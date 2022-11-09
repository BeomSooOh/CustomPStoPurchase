package expend.np.admin.report;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundLoginSessionException;
import common.helper.logger.CommonLogger;
import common.procedure.npG20.BCommonProcService;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExCodeETaxVO;
import common.vo.np.NpErpSendG20VO;
import expend.np.user.budget.BNpUserBudgetService;
import expend.np.user.option.FNpUserOptionServiceIDAO;


@Service ( "FNpAdminReportServiceI" )
public class FNpAdminReportServiceIImpl implements FNpAdminReportService {


	/* 변수정의 */
	/* 변수정의 - DAO */
	@Resource ( name = "FNpAdminReportServiceIDAO" )
	private FNpAdminReportServiceIDAO daoI;
	@Resource ( name = "FNpAdminReportServiceADAO" )
	private FNpAdminReportServiceADAO daoA;
	@Resource ( name = "BCommonProcService" )
	private BCommonProcService procI;
	@Resource ( name = "BNpUserBudgetService" )
	private BNpUserBudgetService serviceBudget; /* Expend Service */
	@Resource ( name = "BCommonProcService" )
	private BCommonProcService serviceCommonProc;
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog;
	@Resource ( name = "FNpUserOptionServiceIDAO" )
	private FNpUserOptionServiceIDAO optDao;

	/* 환원 처리 및 취소 */
	@Override
	public ResultVO updateConfferReturnYN ( Map<String, Object> params ) throws Exception {
		return null;
	}

	/* 품의현황 조회 */
	@Override
	public ResultVO selectConsReport ( Map<String, Object> params ) throws Exception {
		return null;
	}

	@Override
	public ResultVO selectResReport ( Map<String, Object> params ) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO selectSendList ( Map<String, Object> params ) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO insertResSend ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			/*
			 * 문서 데이터 검증 작업 진행
			 * > ResultVO [ resStatus ]
			 */
			ResultVO resStatus = daoA.selectSendInfoDoc( params );
			if ( resStatus.getResultCode( ).equals( commonCode.FAIL ) ) {
				throw new Exception( "결의서 상태 조회에 실패하였습니다." );
			}
			else {
				if ( resStatus.getAaData( ).get( 0 ).get( "erpSendYN" ).equals( "Y" ) ) {
					throw new Exception( "이미 전송된 문서 입니다." );
				}
			}
			/*
			 * ERP 데이터 전송 포멧 준비
			 * > ResultVO [ resDoc, resBudget, resTrade ]
			 */
			ResultVO resDoc = daoA.selectSendInfoDoc( params );
			ResultVO resHead = daoA.selectSendInfoHead( params );
			ResultVO resBudget = daoA.selectSendInfoBudget( params );
			ResultVO resTrade = daoA.selectSendInfoTrade( params );
			ResultVO resItemSpec = daoA.selectSendInfoItemSpec( params );

			/* 회계 기수 마감 여부 확인 */
			if (resHead.getResultCode( ).equals( commonCode.FAIL )){
				return resHead;
			}
			for( int i =0; i < resHead.getAaData( ).size( ) ; i++ ){
				Map<String, Object> item = CommonConvert.CommonSetMapCopy( resHead.getAaData( ).get( i ) );
				item.put( "procType", "gisuCloseCheck" );


				try {
					ResultVO gisuCheckResult = serviceCommonProc.getProcResult( item, conVo );
					if(gisuCheckResult.getResultCode( ).equals( commonCode.FAIL )){
						/* 자동 전송 옵션 사용시 세션 파악 불가능으로 기수 체크 우선 사용 불가능. */
						// return gisuCheckResult;
						continue;
					}else{
						if(gisuCheckResult.getAaData( ).size( ) == 0){
							continue;
						}else if(CommonConvert.NullToString( gisuCheckResult.getAaData( ).get( 0 ).get( "closeYn" ) ).equals( "1" )){
							throw new Exception( "회계 기수가 마감되어 전송할 수 없습니다." );
						}
					}
				}
				catch(Exception e) {
					cmLog.CommonSetInfo("자동 전송 옵션 사용시 세션 파악 불가능으로 기수 체크 우선 사용 불가능.");
					e.printStackTrace();
				}
			}

			/* iCUBE G20 전송 포멧 준비 sendVO */
			NpErpSendG20VO sendVo = new NpErpSendG20VO( resDoc, resHead, resBudget, resTrade, resItemSpec );
			result = daoI.sendABDOCU( sendVo, conVo , params);

			/*
			 * 그룹웨어 결의서 전송 사후 처리 진행
			 */
			/*	[1.] G20 법인카드 승인내역( ACARD_SUNGIN ) 데이터 보정 */
			ResultVO sendCardResult = daoA.selectG20CardSendList(params);
			if(sendCardResult.getResultCode( ).equals( commonCode.SUCCESS )){
				for(Map<String, Object> item : sendCardResult.getAaData( )){
					item.put("erpCompSeq", resStatus.getAaData().get(0).get("erpCompSeq"));
					daoI.updateG20SendCardList( item, conVo );
				}
			}else{
				throw new Exception( "결의서 전송은 성공하였으나, 법인카드 승인내역 상태 연동에 실패하였습니다." );
			}

		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ), ex );
			cmLog.CommonSetInfoToDatabase( "[INFO] #EXNP#  #. ================ SEND FAIL ==================] " + params.toString( ),CommonConvert.NullToString(params.get("groupSeq")), "-", "EXNP" );
		}
		return result;
	}

	@Override
	public ResultVO deleteResSendCancel ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			/*
			 * 문서 데이터 검증 작업 진행
			 * > ResultVO [ resStatus ]
			 */
			ResultVO resStatus = daoA.selectSendInfoDoc( params );
			if ( resStatus.getResultCode( ).equals( commonCode.FAIL ) ) {
				throw new Exception( "결의서 상태 조회에 실패하였습니다." );
			}
			else {
				if ( !resStatus.getAaData( ).get( 0 ).get( "erpSendYN" ).equals( "Y" ) ) {
					result.setFail( "전송되지 않은 결의서 입니다." );
					return result;
				}
			}
			/*
			 * 전송 결의서 G20
			 */
			ResultVO resCancelList = daoA.selectSendCancelInfoRes( params );
			for ( Map<String, Object> item : resCancelList.getAaData( ) ) {
				/*
				 * ERP 전표 발행여부 체크
				 */
				Map<String, Object> checkParam = new HashMap<String, Object>( );
				if( item.get("erpGisuDt")==null && item.get("erpGisuSq")==null ) {
					continue;
				}
				checkParam.put( "erpCompSeq", item.get( "erpCompSeq" ) );
				checkParam.put( "erpGisuDt", item.get( "erpGisuDt" ) );
				checkParam.put( "erpGisuSq", item.get( "erpGisuSq" ) );
				ResultVO isuCheckResult = daoI.selectERPIsuKey( checkParam, conVo );
				if ( CommonConvert.CommonGetStr(isuCheckResult.getResultCode( )).equals( commonCode.FAIL ) ) {
					throw new Exception( "ERP결의서 데이터 조회에 실패하였습니다." );
				}
				for ( Map<String, Object> abdocuB : isuCheckResult.getAaData( ) ) {
					if ( abdocuB.get( "isuDt" ).toString( ).length( ) > 7 ) {
						throw new Exception( "이 결의서는 전표처리가 된 결의서입니다." );
					}
				}
			}
			/*
			 * G20 전표 삭제
			 */
			Map<String, Object> deleteParam = new HashMap<String, Object>( );
			List<String> erpCompSeqs = new ArrayList<>( );
			List<String> erpGisuDts = new ArrayList<>( );
			List<String> erpGisuSqs = new ArrayList<>( );
			ResultVO deleteResult = new ResultVO( );
			for ( Map<String, Object> item : resCancelList.getAaData( ) ) {
				if( item.get("erpGisuDt")==null && item.get("erpGisuSq")==null ) {
					continue;
				}
				erpCompSeqs.add( item.get( "erpCompSeq" ).toString( ) );
				erpGisuDts.add( item.get( "erpGisuDt" ).toString( ) );
				erpGisuSqs.add( item.get( "erpGisuSq" ).toString( ) );
			}
			deleteParam.put( "erpCompSeqs", erpCompSeqs );
			deleteParam.put( "erpGisuDts", erpGisuDts );
			deleteParam.put( "erpGisuSqs", erpGisuSqs );
			if ( (erpCompSeqs.size( ) > 0) && (erpGisuDts.size( ) > 0) && (erpGisuSqs.size( ) > 0) ) {
				deleteResult = daoI.deleteAbdocu( deleteParam, conVo );
			}
			else {
				throw new Exception( "삭제 대상 결의서를 찾을 수 없습니다.." );
			}
			if ( CommonConvert.CommonGetStr(deleteResult.getResultCode( )).equals( commonCode.FAIL ) ) {
				return deleteResult;
			}
			/*
			 * 그룹웨어 결의서 미전송 처리
			 */
			//daoI.sendCancelABDOCU( resStatus.getAaData( ).get( 0 ), conVo );
			daoI.sendCancelABDOCU( resStatus.getAaData( ).get( 0 ) );

			/*
			 * 그룹웨어 결의서 전송 취소 사후 처리 진행
			 */
			/*	[1.] G20 법인카드 승인내역( ACARD_SUNGIN ) 데이터 보정 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO();
			ResultVO sendCardResult = daoA.selectG20CardSendList(params);
			if(sendCardResult.getResultCode( ).equals( commonCode.SUCCESS )){
				for(Map<String, Object> item : sendCardResult.getAaData( )){
					item.put("erpCompSeq", loginVo.getErpCoCd());
					daoI.updateG20DeSendCardList( item, conVo );
				}
			}else{
				throw new Exception( "결의서 전송은 성공하였으나, 법인카드 승인내역 상태 연동에 실패하였습니다." );
			}
		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ), ex );
		}
		return result;
	}

	@Override
	public List<Map<String, Object>> selectCardReport ( Map<String, Object> params ) {
		return null;
	}

	@Override
	public ResultVO updateSendYN ( Map<String, Object> params ) {
		return null;
	}

	/**
	 * 관리자 - 매입전자세금계산서 리스트 조회
	 */
	@Override
	public List<Map<String, Object>> NPAdminEtaxReportList ( ResultVO param, ConnectionVO conVo ) throws Exception {
		/* 매입 전자 세금계산서 조회 */
		ExCodeETaxVO etaxVo = new ExCodeETaxVO( );
		List<Map<String, Object>> etaxListVo = new ArrayList<Map<String, Object>>( );
		return etaxListVo;
	}

	/**
	 * 관리자 - 세금계산서현황 - 세금계산서 사용/미사용처리
	 */
	public ResultVO NPAdminETaxSetUseYN ( ResultVO param ) throws Exception {
		return param;
	}

	@Override
	public ResultVO updateConfferStatus ( Map<String, Object> params ) throws Exception {
		throw new NotFoundLoginSessionException( "BizboxAlpha 전용 로직입니다." );
	}

	@Override
	public ResultVO updateConfferBudgetStatus ( Map<String, Object> params ) throws Exception {
		throw new NotFoundLoginSessionException( "BizboxAlpha 전용 로직입니다." );
	}

	@Override
	public ResultVO selectConsConfferResList ( Map<String, Object> params ) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO selectConsBudgetList ( Map<String, Object> params ) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * 관리자 - 예실대비현황 - 예실대비 현황 리스트 조회
	 * 1. ERP 예실대비 현황 리스트 조회
	 * 2. GW포멧에 맞게 검색된 데이터 포멧 변경
	 * 3. 각 예실대비 현황에 따른 GW통계 데이터 조회
	 * 4. 결과 리턴
	 */
	@Override
	public ResultVO NPAdminYesilList ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			params.put( "gisu", params.get( "erpGisu" ) );

			/* [1] iCUBE G20 예실대비 현황 리스트 조회 */
			result = procI.getProcResult( params );
			ResultVO optResult = new ResultVO( );
			/* G20 환경설정 조회 */
			optResult = optDao.selectERPOption(params, conVo);
			String allocationOpt = optResult.getAaData().get(9).get("USE_YN").toString();
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				throw new Exception( result.getResultName( ) );
			}

			/* [2] 예실대비 현황 조회 결과 컨버트 */
			List<Map<String, Object>> aaData = result.getAaData( );
			List<Map<String, Object>> convertedList = new ArrayList<>( );
			List<Map<String, Object>> resultList = new ArrayList<>( );
			String budgetSeqs = "";

			for ( Map<String, Object> item : aaData ) {
				Map<String, Object> convertedItem = new HashMap<>( );
				convertedItem.put( "erpBudgetSeq", item.get( "BGT_CD" ) ); /* 예산과목 코드 */
				convertedItem.put( "erpBudgetLevelName", item.get( "DIV_FG_NM" ) ); /* 구분(관항목세) */
				convertedItem.put( "erpBudgetLevel", item.get( "DIV_FG" ) ); /* 구분(관항목세) */
				convertedItem.put( "erpBudgetLevelStandard", item.get( "R_DIV_FG" ) ); /* 구분(관항목세) */
				convertedItem.put( "erpBudgetName", item.get( "BGT_NM" ) ); /* 예산과목명 */
				convertedItem.put( "erpCarryAmt", item.get( "CARR_AM" ) ); /* 이월예산 */
				if(allocationOpt.equals("1")) {
					convertedItem.put( "erpAllocationAmt", item.get( "CF_AM2" ) ); /* 기간 배정액*/
				}
				convertedItem.put( "erpOpenAmt", item.get( "CF_AM" ) ); /* 승인예산 */
				convertedItem.put( "erpFutureAmt", item.get( "ADD_AM0" ) ); /* 추경예산 */
				convertedItem.put( "erpExcAmt", item.get( "ADD_AM1" ) ); /* 전용액 */
				convertedItem.put( "erpSumAmt", item.get( "CALC_AM" ) ); /* 예산합계 */
				convertedItem.put( "erpResAmt", item.get( "ACCT_AM" ) ); /* 집행액(결의액) */
				convertedItem.put( "erpResAmt", item.get( "ACCT_AM" ) ); /* 집행액(승인금액) TODO: iCUBE확인 필요. */
				convertedList.add( convertedItem );

				/* 예산조회 예산명 집계 */
				budgetSeqs += ", '" + item.get( "BGT_CD" ) + "'";
			}

			/* [3] GW 예산별 데이터 통계 조회 */
			/*budgetSeqs = budgetSeqs.substring( 1 ).replaceAll( " ", "" );*/
			budgetSeqs = budgetSeqs.substring(1);
			Map<String, Object> budgetInfoParam = params;
			budgetInfoParam.put( "erpBudgetSeq", budgetSeqs );
			budgetInfoParam.put( "erpMgtSeq", params.get( "orgnErpMgtSeq" ) );
			budgetInfoParam.put( "erpBottomSeq", params.get( "orgnErpBottomSeq" ) );
			budgetInfoParam.put( "erpTypeCode", commonCode.ICUBE );
			ResultVO consResult = serviceBudget.selectConsBudgetBalanceForYesil( budgetInfoParam );
			ResultVO resResult = serviceBudget.selectResUseAmtForYesil( budgetInfoParam );

			if(!CommonConvert.CommonGetStr(consResult.getResultCode( )).equals( commonCode.SUCCESS )){
				throw new Exception( "품의서 정보 조회 실패" + consResult.getErrorTrace( ) );
			} else if(!CommonConvert.CommonGetStr(resResult.getResultCode( )).equals( commonCode.SUCCESS )){
				throw new Exception( "결의서 정보 조회 실패" + resResult.getErrorTrace( ));
			}

			/* [4] GW-ERP 데이터 합성 */
			List<Map<String, Object>> consList = consResult.getAaData( );
			List<Map<String, Object>> resList = resResult.getAaData( );
			for ( Map<String, Object> item : convertedList ) {
				for(Map<String, Object> cons : consList){
					if(CommonConvert.CommonGetStr(item.get( "erpBudgetSeq" )).equals( CommonConvert.CommonGetStr(cons.get( "consErpBudgetSeq" )) )){
						item.put( "consBalanceAmt", cons.get( "balanceAmt" ) );
					}
				}
				for(Map<String, Object> res : resList){
					if(CommonConvert.CommonGetStr(item.get( "erpBudgetSeq" )).equals( CommonConvert.CommonGetStr(res.get( "resErpBudgetSeq" )) )){
						item.put( "nonSendResAmt", res.get( "resBudgetAmt" ) );
					}
				}                           
				resultList.add( item );
			}

			/* [5] 결과 검증 이후 데이터 리턴 */
			result.setAaData( resultList );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "예실대비 현황 조회 중 오류가 발생하였습니다.", ex );
		}
		return result;
	}
	
	@Override
	public ResultVO NPAdminMgtList ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		// TODO Auto-generated method stub
		return procI.getProcResult( params );
	}

	@Override
	public ResultVO NPAdminConsAmtList ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO NPAdminResAmtList ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO deleteRes ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO NPAdminERPResAmtList ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO NPAdminERPiUConsAmtList ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO NPAdminERPiUResAmtList ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO deleteConsDoc(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
}

package expend.np.admin.report;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

//import org.apache.solr.common.util.Hash;
import org.springframework.stereotype.Service;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundLoginSessionException;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExCodeETaxVO;
import common.vo.np.NpErpSendiUVO;
import expend.np.user.code.FNpUserCodeServiceUDAO;
import expend.np.user.option.FNpUserOptionServiceUDAO;


@Service ( "FNpAdminReportServiceU" )
public class FNpAdminReportServiceUImpl implements FNpAdminReportService {

	/* 변수정의 */
	/* 변수정의 - DAO */
	@Resource ( name = "FNpAdminReportServiceUDAO" )
	private FNpAdminReportServiceUDAO daoU;
	@Resource ( name = "FNpAdminReportServiceADAO" )
	private FNpAdminReportServiceADAO daoA;
	@Resource ( name = "FNpUserCodeServiceUDAO" )
	private FNpUserCodeServiceUDAO daoUCode;
	@Resource ( name = "FNpUserOptionServiceUDAO" )
	private FNpUserOptionServiceUDAO daoOptionCode;
	/* 환원 처리 및 취소 */
	public ResultVO updateConfferReturnYN ( Map<String, Object> params ) throws Exception {
		@SuppressWarnings("unused")
		Map<String, Object> map = params;
		return null;
	}

	/* 품의현황 조회 */
	public ResultVO selectConsReport ( Map<String, Object> params ) throws Exception {
		@SuppressWarnings("unused")
		Map<String, Object> map = params;
		return null;
	}

	@Override
	public ResultVO selectResReport ( Map<String, Object> params ) throws Exception {
		@SuppressWarnings("unused")
		Map<String, Object> map = params;
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO selectSendList ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			if ( CommonConvert.CommonGetEmpVO( ).getEaType( ).equals( commonCode.EA ) ) {
				result.setAaData( daoA.selectSendEaList( params ) );
			}
			else {
				result.setAaData( daoA.selectSendEapList( params ) );
			}
		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ), ex );
		}
		return result;
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
				if ( CommonConvert.CommonGetStr(resStatus.getAaData( ).get( 0 ).get( "erpSendYN" )).equals( "Y" ) ) {
					throw new Exception( "이미 전송된 문서 입니다." );
				}
			}

			ResultVO resOptionStatus = daoOptionCode.selectERPOption(params, conVo);

			if ( resOptionStatus.getResultCode( ).equals( commonCode.FAIL ) ) {
				throw new Exception( "결의서 옵션 상태 조회에 실패하였습니다." );
			}
			String optTpChincomeRelation = "";
			for(int i=0;i<resOptionStatus.getAaData().size();i++) {
				 if(resOptionStatus.getAaData().get(i).get("TP_ENV").equals("TP_CHINCOME_RELATION")) {
					 optTpChincomeRelation = CommonConvert.NullToString(resOptionStatus.getAaData().get(i).get("CD_ENV"));
				 }
			}

			/*
			 * ERP 데이터 전송 포멧 준비
			 * > ResultVO [ resDoc, resBudget, resTrade ]
			 */
			ResultVO resDoc = daoA.selectSendInfoDoc( params );
			if ( resDoc.getResultCode( ).equals( commonCode.FAIL ) ) {
				throw new Exception( resDoc.getResultName( ) );
			}
			ResultVO resBudget = daoA.selectSendInfoBudget( params );
			if ( resBudget.getResultCode( ).equals( commonCode.FAIL ) ) {
				throw new Exception( resBudget.getResultName( ) );
			}
			ResultVO resTrade = daoA.selectSendInfoTrade( params );
			if ( resTrade.getResultCode( ).equals( commonCode.FAIL ) ) {
				throw new Exception( resTrade.getResultName( ) );
			}
			ResultVO resItemSpec = daoA.selectSendInfoItemSpec( params );
			if ( resItemSpec.getResultCode( ).equals( commonCode.FAIL ) ) {
				throw new Exception( resItemSpec.getResultName( ) );
			}

			/*
			 * ERP 키 정보 조회
			 * > String [ perfectionKey ] 나중에 키를 만들면서 전송을 진행해야 함..... 이거 나중에 싱크 안맞는 오류 생길거같아
			 */
			Calendar cal = Calendar.getInstance( );
			Map<String, Object> keyParam = new HashMap<String, Object>( );
			String resDocSeq = CommonConvert.NullToString( resDoc.getAaData( ).get( 0 ).get( "resDocSeq" ) );
			keyParam.put( "imperfectionKey", "GW" + cal.get( Calendar.YEAR ) + (cal.get( Calendar.MONTH ) + 1) + (cal.get( Calendar.DATE ) < 10 ?  "0" + cal.get( Calendar.DATE ) : cal.get( Calendar.DATE ) ) + resDocSeq ) ;
			keyParam.put( "chincomeKey", "GW" + cal.get( Calendar.YEAR ) + ( cal.get( Calendar.MONTH ) + 1 < 10 ? "0" + (cal.get(Calendar.MONTH) + 1) : cal.get(Calendar.MONTH) + 1 ) + (cal.get( Calendar.DATE ) < 10 ?  "0" + cal.get( Calendar.DATE ) : cal.get( Calendar.DATE ) )  ) ;
			String perfectionKey = daoU.selectERPResKey( keyParam, conVo );

			/* IU 전자결재 키 저장 신규 컬럼 존재 여부 체크 */
			String existErpColumn = daoU.selectERPColumns( params, conVo );


			/*
			 * 전송 VO 생성 및 데이터 전송
			 * > NpErpSendiUVO [ sendVo ]
			 */
			try {
				NpErpSendiUVO sendVo = new NpErpSendiUVO( resDoc, resBudget, resTrade,resItemSpec, perfectionKey , CommonConvert.NullToString(keyParam.get("chincomeKey")));
				List<Map<String, Object>> causeData = sendVo.getSendCauseData( );
				int insertCount = 0;
				for ( int i = 0; i < causeData.size( ); i++ ) {
					Map<String, Object> item = causeData.get( i );
					if(existErpColumn.equals("1")) {
						insertCount = daoU.insertFiDocucause2( item, conVo );
					}
					else {
						insertCount = daoU.insertFiDocucause( item, conVo );
					}
					if(insertCount==0) {
						throw new Exception( "결의서 전송 실패" );
					}
				}
				
				
				List<Map<String, Object>> itemSpecData = sendVo.getSendItemSpecData( );
				for ( int i = 0; i < itemSpecData.size( ); i++ ) {
					Map<String, Object> item = itemSpecData.get( i );
					daoU.insertFiGoodState( item, conVo );
				}
				
				List<Map<String, Object>> payData = sendVo.getSendPayData( );
				for ( int i = 0; i < payData.size( ); i++ ) {
					Map<String, Object> item = payData.get( i );
					insertCount = daoU.insertFidocucausepay( item, conVo );
					
					if(insertCount==0) {
						throw new Exception( "결의서 전송 실패" );
					}
				}
				

				List<Map<String, Object>> etcData = sendVo.getSendPayData( );
				for ( int i = 0; i < etcData.size( ); i++ ) {
					Map<String, Object> item = etcData.get( i );
					if(CommonConvert.NullToString(item.get("CD_MNG")).length()>0) {
						insertCount = daoU.insertFichincome( item, conVo );
						/* 결의서(원인행위) 기타/사업자 등록 옵션 */
						if(optTpChincomeRelation.equals("2")) {
							insertCount = daoU.insertHincome(item,conVo);
						}
					}
					if(insertCount==0) {
						throw new Exception( "결의서 전송 실패" );
					}
				}	
			
							/*
				 * 그룹웨어 결의서 사후 처리 진행
				 * 전송 여부 상태값 변경
				 * > erpSendYN
				 */
				/* ERP 전송 상태 변경 */
				try{
					LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
					params.put( "empName", loginVo.getName( ) );
					params.put( "empSeq", loginVo.getUniqId( ) );
				} catch(Exception ex){
					params.put( "empName", "자동전송" );
					params.put( "empSeq", "SYSTEM");
				}
				params.put( "sendFg", "Y" );
				daoA.updateResSendFg( params );
				result.setSuccess( );
	
				/*
				 * 그룹웨어 결의서 ERP 키 업데이트
				 */
				List<NpErpSendiUVO.KeyContainer> headKeys = sendVo.getBudgetKeyList( );
				for ( NpErpSendiUVO.KeyContainer item : headKeys ) {
					Map<String, Object> m = new HashMap<String, Object>( );
					m.put( "noCDocu", item.noCDocu );
					m.put( "noCDoline", item.noCDoline );
					m.put( "budgetSeq", item.resBudgetSeq );
					daoA.updateResBudgetKey( m );
				}
				List<NpErpSendiUVO.KeyContainer> tradeKeys = sendVo.getTradeKeyList( );
				for ( NpErpSendiUVO.KeyContainer item : tradeKeys ) {
					Map<String, Object> m = new HashMap<String, Object>( );
					m.put( "noCDocu", item.noCDocu );
					m.put( "noCdMng", item.noCdMng );
					m.put( "noCDoline", item.noCDoline );
					m.put( "noPayLine", item.noPayLine );
					m.put( "tradeSeq", item.resTradeSeq );
					daoA.updateResTradeKey( m );
				}
			} catch(Exception ex) {
				deleteResSendCancel(params,conVo);
				result.setFail( "결의서 전송 도중 오류가 발생하였습니다.");
			}
		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ), ex );
			ex.printStackTrace();
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
				if ( !CommonConvert.CommonGetStr(resStatus.getAaData( ).get( 0 ).get( "erpSendYN" )).equals( "Y" ) ) {
					result.setFail( "전송되지 않은 결의서 입니다." );
					return result;
				}
			}
			/*
			 * 전송 결의서 ERPiU 결의서 키 조회
			 */
			ResultVO resCancelList = daoA.selectSendCancelInfoRes( params );
			for ( Map<String, Object> item : resCancelList.getAaData( ) ) {
				/*
				 * ERP 전표 발행여부 체크
				 */
				for ( Map<String, Object> cdocu : daoU.selectFidocucause( item, conVo ) ) {
					if ( cdocu.get( "NO_DOCU" ) != null ) {
						throw new Exception( "이 결의서는 전표처리가 된 결의서입니다." );
					}
				}
			}
			/*
			 * ERP 원인행위 삭제 진행 - 조회된 키사용하여 일괄삭제 진행
			 */
			for ( Map<String, Object> item : resCancelList.getAaData( ) ) {
				daoU.deleteFidocucause( item, conVo );
				item.put( "sendFg", "N" );
				daoA.updateResSendFg( item );
			}
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ), ex );
		}
		return result;
	}

	public List<Map<String, Object>> selectCardReport ( Map<String, Object> params ) {
		@SuppressWarnings("unused")
		Map<String, Object> map = params;
		return null;
	}

	public ResultVO updateSendYN ( Map<String, Object> params ) {
		@SuppressWarnings("unused")
		Map<String, Object> map = params;
		return null;
	}

	/**
	 * 관리자 - 매입전자세금계산서 리스트 조회
	 */
	public List<Map<String, Object>> NPAdminEtaxReportList ( ResultVO param, ConnectionVO conVo ) throws Exception {
		/* 매입 전자 세금계산서 조회 */
		ExCodeETaxVO etaxVo = new ExCodeETaxVO( );
		List<Map<String, Object>> etaxListVo = new ArrayList<Map<String, Object>>( );
		etaxVo.setErpCompSeq( conVo.getErpCompSeq( ) );
		etaxVo.setSearchFromDt( param.getParams( ).get( "searchFromDt" ).toString( ) );
		etaxVo.setSearchToDt( param.getParams( ).get( "searchToDt" ).toString( ) );
		/* 검색조건 */
		etaxVo.setIssNo( param.getParams( ).get( "issNo" ).toString( ) );
		etaxVo.setTrNm( param.getParams( ).get( "partnerName" ).toString( ) );
		etaxVo.setTrregNb( param.getParams( ).get( "partnerNo" ).toString( ) );
		etaxListVo = daoU.NPAdminETaxListInfoSelectMap( etaxVo, conVo );
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
		// TODO Auto-generated method stub
		return null;
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
	 * 	ERPiU 예실대비 현황 리스트 조회
	 */
	@Override
	public ResultVO NPAdminYesilList ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );

		try{
			/* 1. ERP 편성 예산 과목 정보 조회 */
			Map<String, Object> bgListParams = new HashMap<>( );
			bgListParams.put( "erpCompSeq", params.get( "erpCompSeq" ) );
			bgListParams.put( "erpBizplanSeq", params.get( "bpErpBizplanSeq" ) );
			bgListParams.put( "erpBudgetSeq", params.get( "bpErpBudgetSeq" ) );
			bgListParams.put( "writeMonth", params.get( "bpWriteMonth" ) );
			bgListParams.put( "bgtYear", params.get( "bpBgtYear" ) );
			bgListParams.put( "bgacctType", "A" );
			bgListParams.put( "grFg", "1|2" );
			List<Map<String, Object>> bgacctList = daoUCode.selectCommonBgacctCode( bgListParams, conVo );


			/* 2. ERPiU 예실대비 현황 프로시저 호출 금액 정보 */
			ResultVO iUBgacctResult = daoU.NPAdminYesilListSelect( params, conVo );
			if(iUBgacctResult.getResultCode( ).equals( commonCode.FAIL )){
				return iUBgacctResult;
			}
			List<Map<String, Object>> openAmtList = (List<Map<String, Object>>)iUBgacctResult.getaData( ).get( "openAmtList" );
			Map<String, Object> openAmtMap = new HashMap<>( );
			for(Map<String, Object> item : openAmtList){
				String cdBgacct = CommonConvert.NullToString( item.get( "CD_BGACCT" ) );
				String amActsum = CommonConvert.NullToString( item.get( "AM_ACTSUM" ) );

				if( openAmtMap.containsKey( cdBgacct ) ){
					double tOrgAmActsum = CommonConvert.NullToDouble( openAmtMap.get( cdBgacct ) );
					double tAmActsum = CommonConvert.NullToDouble(amActsum);
					tAmActsum = tAmActsum + tOrgAmActsum;
					openAmtMap.put( cdBgacct, String.format("%1$.0f", tAmActsum) );

				}else {
					openAmtMap.put( cdBgacct, amActsum );
				}

			}
			List<Map<String, Object>> erpTotalAmtList = (List<Map<String, Object>>)iUBgacctResult.getaData( ).get( "erpTotalAmt" );
			Map<String, Object> erpTotalAmtMap = new HashMap<>( );
			for(Map<String, Object> item : erpTotalAmtList){
				String cdBgacct = CommonConvert.NullToString( item.get( "CD_BGACCT" ) );
				if(erpTotalAmtMap.containsKey( cdBgacct )){
					long totalAmt = CommonConvert.NullToLong( item.get( "AM_AMTSUM" ) ) + CommonConvert.NullToLong( erpTotalAmtMap.get( cdBgacct ) );
					erpTotalAmtMap.put( cdBgacct, ("" + totalAmt) );
				}else {
					erpTotalAmtMap.put( cdBgacct, CommonConvert.NullToString( item.get( "AM_AMTSUM" ) ) );
				}
			}
			List<Map<String, Object>> erpApplyAmtList = (List<Map<String, Object>>)iUBgacctResult.getaData( ).get( "erpApplyAmt" );
			Map<String, Object> erpApplyAmtMap = new HashMap<>( );
			long erpAmt = 0;
			for(Map<String, Object> item : erpApplyAmtList){

				if(erpApplyAmtMap.containsKey(CommonConvert.NullToString(item.get("CD_BGACCT")))) {
					erpAmt = (long) erpApplyAmtMap.get( CommonConvert.NullToString( item.get( "CD_BGACCT" )) );
					erpAmt += CommonConvert.NullToLong( item.get("AM_DRCR") );
				}
				else {
					erpAmt = CommonConvert.NullToLong( item.get("AM_DRCR") );
				}
				erpApplyAmtMap.put( CommonConvert.NullToString( item.get( "CD_BGACCT" ) ), erpAmt );
			}


			/* 3. 사용자 옵션 조회 불용처리 반영인 경우 */
			if( CommonConvert.NullToString( params.get( "advAmtOption" ) ).equals( "2" ) ){
				List<Map<String, Object>> erpTotalAdvAmtList = (List<Map<String, Object>>)iUBgacctResult.getaData( ).get( "erpTotalAdvAmtList" );
				for(Map<String, Object> item : erpTotalAdvAmtList){
					String cdBgacct = CommonConvert.NullToString( item.get( "CD_BGACCT" ) );
					if(erpTotalAmtMap.containsKey( cdBgacct )){
						long totalAmt = CommonConvert.NullToLong( item.get( "AM_AMTSUM" ) ) + CommonConvert.NullToLong( erpTotalAmtMap.get( cdBgacct ) );
						erpTotalAmtMap.put( cdBgacct, ("" + totalAmt) );
					}else{
						erpTotalAmtMap.put( cdBgacct, CommonConvert.NullToString( item.get( "AM_AMTSUM" ) ) );
					}
				}
				List<Map<String, Object>> erpApplyAdvAmtList = (List<Map<String, Object>>)iUBgacctResult.getaData( ).get( "erpApplyAdvAmtList" );
				for(Map<String, Object> item : erpApplyAdvAmtList){
					String cdBgacct = CommonConvert.NullToString( item.get( "CD_BGACCT" ) );
					if(erpApplyAmtMap.containsKey( cdBgacct )){
						long totalAmt = CommonConvert.NullToLong( item.get( "AM_DRCR" ) ) + CommonConvert.NullToLong( erpApplyAmtMap.get( cdBgacct ) );
						erpApplyAmtMap.put( cdBgacct, ("" + totalAmt) );
					}else{
						erpApplyAmtMap.put( cdBgacct, CommonConvert.NullToString( item.get( "AM_DRCR" ) ) );
					}
				}
			}

			/* 4. GW 예산 계정 별 데이터 조회 */
			Map<String, Object> gwListParams = new HashMap<>( );
			gwListParams.put( "erpCompSeq", params.get( "erpCompSeq" ) );
			gwListParams.put( "erpBizplanSeq", params.get( "bpErpBizplanSeq" ) );
			gwListParams.put( "erpBudgetSeq", params.get( "bpErpBudgetSeq" ) );
			if(params.get( "bpErpBizplanSeq" ) == "***") {
				gwListParams.put( "erpBizplanSeq", "" );
			}
			gwListParams.put( "compSeq", params.get( "compSeq" ));
			gwListParams.put( "gisuFromDate", CommonConvert.NullToString( params.get( "erpGisuFromDate" ) ) + "01" );
			gwListParams.put( "gisuToDate", CommonConvert.NullToString( params.get( "erpGisuToDate" ) ) + "31" );
			ResultVO consBalanceResult = daoA.selectYesilERPiUConsBalanceAmt(gwListParams);
			if(consBalanceResult.getResultCode( ).equals( commonCode.FAIL )){
				return consBalanceResult;
			}
			Map<String, Object> consBalanceMap = consBalanceResult.getaData( );

			ResultVO resResult = daoA.selectYesilERPiUResAmt(gwListParams);
			if(resResult.getResultCode( ).equals( commonCode.FAIL )){
				return resResult;
			}
			Map<String, Object> resMap = resResult.getaData( );

			/* 5. 데이터 반환 준비 */
			List<Map<String, Object>> resultAaData = new ArrayList<>( );
			for(Map<String, Object> item : bgacctList){
				Map<String, Object> resultAData = new HashMap<>( );

				String erpBgacctSeq = CommonConvert.NullToString( item.get( "CD_BGACCT" ) );
				String erpBgacctName = CommonConvert.NullToString( item.get( "NM_BGACCT" ) );
				String openAmt = CommonConvert.NullToString( openAmtMap.get( erpBgacctSeq ) );
				String erpApplyAmt = CommonConvert.NullToString( erpApplyAmtMap.get( erpBgacctSeq ) );
				String erpTotalAmt = CommonConvert.NullToString( erpTotalAmtMap.get( erpBgacctSeq ) ) ;
				String consBalanceAmt = CommonConvert.NullToString( consBalanceMap.get( erpBgacctSeq ) ) ;
				String nonSendResAmt = CommonConvert.NullToString( resMap.get( erpBgacctSeq ) ) ;
				long erpResAmt = CommonConvert.NullToLong( erpTotalAmt );

				resultAData.put( "erpBgacctSeq", erpBgacctSeq );
				resultAData.put( "erpBgacctName", erpBgacctName );
				resultAData.put( "openAmt", openAmt );
				resultAData.put( "erpApplyAmt", erpApplyAmt );
				resultAData.put( "erpTotalAmt", erpTotalAmt );
				resultAData.put( "erpResAmt", erpResAmt );
				resultAData.put( "consAmt", consBalanceAmt );
				resultAData.put( "nonSendResAmt", nonSendResAmt );


				if( CommonConvert.NullToString( params.get( "erpBgacctSeqs" ) ).indexOf( erpBgacctSeq + "|" ) > -1 ){
					resultAaData.add( resultAData );
				}
			}

			result.setAaData( resultAaData );
			result.setSuccess( );
		}catch(Exception ex){
			result.setFail( "예실대비현황 리스트 조회 실패", ex );
		}

		return result;
	}

	@Override
	public ResultVO NPAdminMgtList ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		// TODO Auto-generated method stub
		return null;
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

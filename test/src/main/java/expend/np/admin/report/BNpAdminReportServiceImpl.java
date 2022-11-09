package expend.np.admin.report;

//import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundConnectionException;
import common.helper.exception.NotFoundLoginSessionException;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.procedure.npG20.BCommonProcService;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import expend.np.user.option.BNpUserOptionService;
import expend.trip.admin.report.FTripAdminReportService;


@Service ( "BNpAdminReportService" )
public class BNpAdminReportServiceImpl implements BNpAdminReportService {

	/* 변수정의 */
	/* 변수정의 - Service */
	@Resource ( name = "FNpAdminReportServiceA" )
	private FNpAdminReportService serviceA;
	@Resource ( name = "FNpAdminReportServiceI" )
	private FNpAdminReportService serviceI;
	@Resource ( name = "FNpAdminReportServiceU" )
	private FNpAdminReportService serviceU;
	@Resource ( name = "BNpUserOptionService" )
	private BNpUserOptionService userServiceOption; /* Expend Service */
	@Resource ( name = "BCommonProcService" )
	private BCommonProcService g20ProcService; /* G20 프로시저 연동 */
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo;
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );
	@Resource ( name = "FTripAdminReportServiceA" )
	private FTripAdminReportService tripServiceA;

	/* 환원 처리 및 취소 */
	public ResultVO updateConfferReturnYN ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		/* 필수값 체크 - docSeq */
		if ( params.get( commonCode.DOCSEQ ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			throw new Exception( "parameter not found....." );
		}
		serviceA.updateConfferReturnYN( params );
		return result;
	}

	/* 품의현황 조회 */
	public ResultVO selectConsReport ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			params.put( "empSeq", loginVo.getUniqId( ) );
			params.put( "deptSeq", loginVo.getOrgnztId( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			result = serviceA.selectConsReport( params );
		}
		catch ( Exception e ) {
			result.setFail( "품의현황 조회 도중 오류가 발생하였습니다.", e );
		}
		return result;
	}

	/**
	 * 관리자 - 품의서 현황 - 참조결의서 리스트 조회
	 */
	@Override
	public ResultVO selectConsConfferResList ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			params.put( "empSeq", loginVo.getUniqId( ) );
			params.put( "empName", loginVo.getEmpname( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			result = serviceA.selectConsConfferResList( params );
		}
		catch ( NotFoundLoginSessionException e ) {
			result.setFail( "Biz 에러 발생", e );
		}
		catch ( Exception e ) {
			result.setFail( "품의서 환원/취소 중 에러 발생", e );
		}
		return result;
	}

	/**
	 * 관리자 - 품의서 현황 - 참조결의서 리스트 조회
	 */
	@Override
	public ResultVO selectConsBudgetList ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			params.put( "empSeq", loginVo.getUniqId( ) );
			params.put( "empName", loginVo.getEmpname( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			result = serviceA.selectConsBudgetList( params );
		}
		catch ( NotFoundLoginSessionException e ) {
			result.setFail( "Biz 에러 발생", e );
		}
		catch ( Exception e ) {
			result.setFail( "품의서 환원/취소 중 에러 발생", e );
		}
		return result;
	}

	/**
	 * 관리자 - 품의서 현황 - 품의서 반환/취소
	 */
	@Override
	public ResultVO updateConfferStatus ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			if( CommonConvert.NullToString( params.get( "confferReturn" ) ).equals( "Y" )){
				params.put( "empName", loginVo.getName( ) );
			}else{
				params.put( "empName", "" );
			}
			params.put( "empSeq", loginVo.getUniqId( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			result = serviceA.updateConfferStatus( params );
		}
		catch ( NotFoundLoginSessionException e ) {
			result.setFail( "Biz 에러 발생", e );
		}
		catch ( Exception e ) {
			result.setFail( "품의서 환원/취소 중 에러 발생", e );
		}
		return result;
	}

	/**
	 * 관리자 - 품의서 현황 - 품의예산 반환/취소
	 */
	@Override
	public ResultVO updateConfferBudgetStatus ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			if( CommonConvert.NullToString( params.get( "confferReturn" ) ).equals( "Y" )){
				params.put( "empName", loginVo.getName( ) );
			}else{
				params.put( "empName", "" );
			}
			params.put( "empSeq", loginVo.getUniqId( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			result = serviceA.updateConfferBudgetStatus( params );
		}
		catch ( NotFoundLoginSessionException e ) {
			result.setFail( "Biz 에러 발생", e );
		}
		catch ( Exception e ) {
			result.setFail( "품의서 환원/취소 중 에러 발생", e );
		}
		return result;
	}

	/* 결의현황 조회 */
	@Override
	public ResultVO selectResReport ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			params.put( "empSeq", loginVo.getUniqId( ) );
			params.put( "deptSeq", loginVo.getOrgnztId( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			result = serviceA.selectResReport( params );
		}
		catch ( Exception e ) {
			result.setFail( "결의현황 조회 도중 오류가 발생하였습니다.", e );
		}
		return result;
	}

	/* 결의서 전송 리스트 조회 */
	@Override
	public ResultVO selectSendList ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = serviceA.selectSendList( params );
		}
		catch ( Exception e ) {
			result.setFail( "결의현황 전송리스트 조회 도중 오류가 발생하였습니다.", e );
		}
		return result;
	}

	/* 결의서 삭제 */
	@Override
	public ResultVO NpAdminResDelete ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			params.put( "empSeq", loginVo.getUniqId( ) );
			params.put( "empName", loginVo.getName( ) );
			params.put( "groupSeq", loginVo.getGroupSeq());
			params.put( "eaType", loginVo.getEaType());
			result = serviceA.deleteRes( params, conVo );
			if(params.get("tripResDocSeqs").toString().replaceAll("[^0-9]","").length() > 0 && result.getResultCode().equals(commonCode.SUCCESS) ) {
				result = tripServiceA.deleteTripResDoc(params);
			}

		}
		catch ( Exception e ) {
			result.setFail( "결의서 삭제 중 오류가 발생하였습니다.", e );
		}
		return result;
	}


	/* 결의서 전송 로직 시작 */
	@Override
	public ResultVO insertResSend ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			LoginVO loginVo = null;
			cmLog.CommonSetInfo("insertResSend 진입");
			try{
				loginVo = CommonConvert.CommonGetEmpVO( );
				params.put( "empSeq", loginVo.getUniqId( ) );
				params.put( "empName", loginVo.getName( ) );
			} catch(Exception ex){
				params.put( "empSeq", "SYSTEM" );
				params.put( "empName", "자동전송" );
				cmLog.CommonSetInfo("insertResSend 자동전송 진입");
			}
			cmLog.CommonSetInfo("insertResSend 진입 후");
			FNpAdminReportService service;
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
				/* ERP iU 로직 시작 */
				service = serviceU;
			}
			else if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
				/* iCUBE G20 로직 시작 */
				service = serviceI;
			}
			else {
				throw new Exception( "ERP TYPE CODE를 찾을 수 없습니다." );
			}
			/* 전송 ㄹㅇ 시작 ㄱㄱ */
			result = service.insertResSend( params, conVo );
		}
		catch ( Exception e ) {
			result.setFail( "결의서 전송 도중 오류가 발생하였습니다.", e );
		}
		return result;
	}

	@Override
	public ResultVO deleteResSendCancel ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			FNpAdminReportService service;
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
				/* ERP iU 로직 시작 */
				service = serviceU;
			}
			else if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
				/* iCUBE G20 로직 시작 */
				service = serviceI;
			}
			else {
				throw new Exception( "ERP TYPE CODE를 찾을 수 없습니다." );
			}
			/* 전송 취소 시작 ㄱㄱ */
			result = service.deleteResSendCancel( params, conVo );
		}
		catch ( Exception e ) {
			result.setFail( "결의서 전송 취소 도중 오류가 발생하였습니다.", e );
		}
		return result;
	}

	public List<Map<String, Object>> selectCardReport ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = serviceA.selectCardReport( params );
		return result;
	}

	public ResultVO updateSendYN ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		if ( params.get( "syncId" ) == null || CommonConvert.CommonGetStr(params.get( "syncId" )).equals( "" ) ) {
			throw new Exception( "필수파라미터 누락" );
		}
		result = serviceA.updateSendYN( params );
		return result;
	}

	/**
	 * 관리자 - 매입전자세금계산서 현황
	 */
	public ResultVO NPAdminEtaxReportList ( ResultVO param, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> erpList = new ArrayList<Map<String, Object>>( );
		List<Map<String, Object>> gwList = new ArrayList<Map<String, Object>>( );
		switch ( conVo.getErpTypeCode( ) ) {
			case commonCode.ERPIU:
				erpList = serviceU.NPAdminEtaxReportList( param, conVo );
				break;
			case commonCode.ICUBE:
				//				erpList = reportServiceI.ExAdminEtaxReportList( param, conVo );
				break;
			default:
				throw new NotFoundConnectionException( "사용자 ERP설정 정보를 확인하세요." );
		}
		/* 그룹웨어 데이터 조회 */
		if ( param.getParams( ).get( commonCode.COMPSEQ ) == null || param.getParams( ).get( commonCode.COMPSEQ ).equals( commonCode.COMPSEQ ) ) {
			Map<String, Object> tParam = param.getParams( );
			tParam.put( commonCode.COMPSEQ, CommonConvert.CommonGetEmpVO( ).getCompSeq( ) );
			param.setParams( tParam );
		}
		Map<String, Object> aData = new HashMap<String, Object>( );
		aData.put( "dataLength", erpList.size( ) );
		param.setaData( aData );
		gwList = serviceA.NPAdminEtaxReportList( param, conVo );
		erpList.addAll( gwList );
		param.setAaData( erpList );
		return param;
	}

	/**
	 * 관리자 - 세금계산서현황 - 세금계산서 사용/미사용처리
	 */
	public ResultVO NPAdminETaxSetUseYN ( ResultVO param ) throws Exception {
		param = serviceA.NPAdminETaxSetUseYN( param );
		return param;
	}

	/**
	 * 관리자 - 예실대비현황 - 예실대비 현황 리스트 조회
	 */
	@Override
	public ResultVO NPAdminYesilList ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			switch ( conVo.getErpTypeCode( ) ) {
				case commonCode.ERPIU:
					result = serviceU.NPAdminYesilList( params, conVo );
					break;
				case commonCode.ICUBE:
					result = serviceI.NPAdminYesilList( params, conVo );
					break;
				default:
					throw new NotFoundConnectionException( "사용자 ERP설정 정보를 확인하세요." );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "오류 발생", ex );
		}
		return result;
	}

	/**
	 * 관리자 - 예실대비현황 - 예실대비 현황 리스트 조회
	 */
	@Override
	public ResultVO NPAdminYesilListExcel ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			switch ( conVo.getErpTypeCode( ) ) {
				case commonCode.ERPIU:
					throw new Exception( " ERPiU 예실대비 현황은 준비되지 않았습니다. " );
				case commonCode.ICUBE:
					result = serviceI.NPAdminYesilList( params, conVo );
					List<Map<String, Object>> aaData = result.getAaData( );
					for(Map<String, Object> item : aaData){
						double totalAmt = fnParseInt(item.get("consBalanceAmt")) + fnParseInt(item.get("nonSendResAmt")) + fnParseInt(item.get("erpResAmt")) + fnParseInt(item.get("erpApplyAmt"));
						double resultAmt = fnParseInt(item.get("erpSumAmt")) - fnParseInt(totalAmt);
						double amtRate = 0;
						try{
							if(fnParseInt(item.get("erpSumAmt")) == 0){
								amtRate  = 0;
							}else{
								amtRate = (100 - ( resultAmt / fnParseInt(item.get("erpSumAmt")) * 100 ) ) ;
							}
						}catch(Exception ex){
							amtRate  = 0;
						}
						item.put( "totalAmt", totalAmt ); // 집행합계
						item.put( "resultAmt", resultAmt ); // 집행잔액
						item.put( "amtRate", amtRate ); // 집행률
					}
					break;
				default:
					throw new NotFoundConnectionException( "사용자 ERP설정 정보를 확인하세요." );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "오류 발생", ex );
			return result;
		}
		return result;
	}

	private double fnParseInt(Object o){
		if(o == null) {
			return 0;
		}
		else if (o.toString( ).equals( "" )) {
			return 0;
		}
		return Double.parseDouble( o.toString( ) );
	}

	/**
	 * 관리자 - 예실대비현황 - 관리항목
	 */
	@Override
	public ResultVO NPAdminMgtList ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			switch ( conVo.getErpTypeCode( ) ) {
				case commonCode.ERPIU:
					throw new Exception( " ERPiU 예실대비 현황은 준비되지 않았습니다. " );
				case commonCode.ICUBE:
					result = serviceI.NPAdminMgtList( params, conVo );
					break;
				default:
					throw new NotFoundConnectionException( "사용자 ERP설정 정보를 확인하세요." );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "오류 발생", ex );
		}
		return result;
	}

	/**
	 * 관리자 - 예실대비현황 - 예산별 품의서 리스트 조회
	 */
	@Override
	public ResultVO NPAdminConsAmtList ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			switch ( conVo.getErpTypeCode( ) ) {
				case commonCode.ERPIU:
					result = serviceA.NPAdminERPiUConsAmtList( params, conVo );
					break;
				case commonCode.ICUBE:
					result = serviceA.NPAdminConsAmtList( params, conVo );
					break;
				default:
					throw new NotFoundConnectionException( "사용자 ERP설정 정보를 확인하세요." );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "예산별 결의서 조회도중 오류가 발생하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 관리자 - 예실대비현황 - 예산별 결의서 리스트 조회
	 */
	@Override
	public ResultVO NPAdminResAmtList ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			switch ( conVo.getErpTypeCode( ) ) {
				case commonCode.ERPIU:
					result = serviceA.NPAdminERPiUResAmtList( params, conVo );
					break;
				case commonCode.ICUBE:
					result = serviceA.NPAdminResAmtList( params, conVo );
					break;
				default:
					throw new NotFoundConnectionException( "사용자 ERP설정 정보를 확인하세요." );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "예산별 결의서 조회도중 오류가 발생하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 관리자 - 예실대비현황 - 전송 결의서 리스트 조회
	 */
	@Override
	public ResultVO NPAdminERPResAmtList ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			switch ( conVo.getErpTypeCode( ) ) {
				case commonCode.ERPIU:
					throw new Exception( " ERPiU 예실대비 현황은 준비되지 않았습니다. " );
				case commonCode.ICUBE:
					result = g20ProcService.getERPResListInfoSet( params, conVo );
					break;
				default:
					throw new NotFoundConnectionException( "사용자 ERP설정 정보를 확인하세요." );
			}

			if(result.getResultCode( ).equals( commonCode.SUCCESS )){
				ResultVO gwInfoResult = serviceA.NPAdminERPResAmtList(result.getaData( ), conVo);
				List<Map<String, Object>> gwList = gwInfoResult.getAaData( );
				List<Map<String, Object>> erpList = result.getAaData( );


				for(int i=0; i< erpList.size( ) ; i++){
					Map<String, Object> erpAData = erpList.get( i );

					for(Map<String, Object> gwAData : gwList ){
						if(nullToString( erpAData.get( "erpKey" ) ).equals( nullToString(gwAData.get( "erpKey" ) )) ){
							erpAData.put( "docNo", nullToString(gwAData.get( "docNo" ) ));
							erpAData.put( "docSeq", nullToString(gwAData.get( "docSeq" ) ));
							erpAData.put( "formSeq", nullToString(gwAData.get( "formSeq" ) ));
							erpAData.put( "docTitle", nullToString(gwAData.get( "docTitle" ) ));
							erpAData.put( "resDocSeq", nullToString(gwAData.get( "resDocSeq" ) ));
						}
					}

//					if(!erpAData.get("erpBudgetSeq").equals(params.get("erpBudgetSeq"))) {
//						erpList.remove(i);
//						i--;
//					}
				}
				result.setAaData( erpList );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "예산별 결의서 조회도중 오류가 발생하였습니다.", ex );
		}
		return result;
	}

	private String nullToString(Object o){
		if(o == null){
			return "";
		}else{
			return o.toString( );
		}
	}

	@Override
	public ResultVO deleteConsDoc(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			params.put( "empSeq", loginVo.getUniqId( ) );
			params.put( "empName", loginVo.getName( ) );
			params.put( "groupSeq", loginVo.getGroupSeq());
			params.put( "eaType", loginVo.getEaType());
		
			result = serviceA.deleteConsDoc( params );
			
			if(params.get("tripConsDocSeqs").toString().replaceAll("[^0-9]","").length() > 0 && result.getResultCode().equals(commonCode.SUCCESS) ) {
				result = tripServiceA.deleteTripConsDoc(params);
			}
		}
		catch ( NotFoundLoginSessionException e ) {
			result.setFail( "Biz 에러 발생", e );
		}
		catch ( Exception e ) {
			result.setFail( "품의서 삭제 중 에러 발생", e );
		}
		return result;
	}
}
package expend.np.user.report;

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
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import expend.np.user.option.BNpUserOptionService;


@Service ( "BNpUserReportService" )
public class BNpUserReportServiceImpl implements BNpUserReportService {

	@Resource ( name = "FNpUserReportServiceA" )
	private FNpUserReportService serviceReportA;
	@Resource ( name = "FNpUserReportServiceI" )
	private FNpUserReportService serviceReportI;
	@Resource ( name = "FNpUserReportServiceU" )
	private FNpUserReportService serviceReportU;
	@Resource ( name = "BNpUserOptionService" )
	private BNpUserOptionService userServiceOption; /* Expend Service */
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo;

	/**
	 * 사용자 - 품의서 현황 - 품의서 리스트 조회
	 */
	@Override
	public ResultVO selectUserConsList ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			params.put( "empSeq", CommonConvert.CommonGetEmpVO( ).getUniqId( ) );
			params.put( "compSeq", CommonConvert.CommonGetEmpVO( ).getCompSeq( ) );
			result = serviceReportA.selectUserConsList( params );
		}
		catch ( Exception ex ) {
			result.setFail( "ERP 설정 구분을 확인할 수 없습니다.", ex );
		}
		return result;
	}

	/**
	 * 사용자 - 카드 현황 - 카드 사용내역 조회
	 */
	public List<Map<String, Object>> selectCardReport ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			params.put( "empSeq", loginVo.getUniqId( ) );
			params.put( "deptSeq", loginVo.getOrgnztId( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			result = serviceReportA.selectCardReport( params );
		}
		catch ( NotFoundLoginSessionException e ) {
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 사용자 - 품의서 현황 - 참조결의서 리스트 조회
	 */
	@Override
	public ResultVO selectConsConfferResList ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(CommonConvert.CommonGetEmpVO().getCompSeq()));

			Map<String, Object> optionParam = new HashMap<String, Object>();
			optionParam.put("erpCompSeq", CommonConvert.CommonGetEmpVO().getErpCoCd());
			String vatBudgetOption = userServiceOption.selectERPVatCtrData(optionParam, conVo);
			params.put("vatBudgetOption", vatBudgetOption);
			params.put( "empSeq", loginVo.getUniqId( ) );
			params.put( "empName", loginVo.getEmpname( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			result = serviceReportA.selectConsConfferResList( params );
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
	 * 사용자 - 품의서 현황 - 품의서 조회
	 */
	@Override
	public ResultVO selectConsReport ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			params.put( "empSeq", loginVo.getUniqId( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			result = serviceReportA.selectConsReport( params );
		}
		catch ( NotFoundLoginSessionException e ) {
			result.setFail( "Biz 에러 발생", e );
		}
		catch ( Exception e ) {
			result.setFail( "품의서 조회 중 에러 발생", e );
		}
		return result;
	}

	/**
	 * 사용자 - 품의서 현황 - 참조결의서 리스트 조회
	 */
	@Override
	public ResultVO selectConsBudgetList ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			params.put( "empSeq", loginVo.getUniqId( ) );
			params.put( "empName", loginVo.getEmpname( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			result = serviceReportA.selectConsBudgetList( params );
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
	 * 사용자 - 품의서 현황 - 품의서 반환/취소
	 */
	@Override
	public ResultVO updateConfferStatus ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			params.put( "empSeq", loginVo.getUniqId( ) );
			params.put( "empName", loginVo.getName() );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			result = serviceReportA.updateConfferStatus( params );
		}
		catch ( NotFoundLoginSessionException e ) {
			result.setFail( "Biz 에러 발생", e );
		}
		return result;
	}

	/**
	 * 사용자 - 품의서 현황 - 품의서 반환/취소
	 */
	@Override
	public ResultVO updateConfferBudgetStatus ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			params.put( "empSeq", loginVo.getUniqId( ) );
			params.put( "empName", loginVo.getName( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			result = serviceReportA.updateConfferBudgetStatus( params );
		}
		catch ( NotFoundLoginSessionException e ) {
			result.setFail( "Biz 에러 발생", e );
		}
		return result;
	}

	/**
	 * 사용자 - 결의서 현황 - 결의서 조회
	 */
	@Override
	public ResultVO selectResReport ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			params.put( "empSeq", loginVo.getUniqId( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			result = serviceReportA.selectResReport( params );
		}
		catch ( NotFoundLoginSessionException e ) {
			result.setFail( "Biz 에러 발생", e );
		}
		return result;
	}

	@Override
	public ResultVO ExReportHeaderInterLockInfoSelect ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			params.put( "empSeq", loginVo.getUniqId( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			result = serviceReportA.selectHeadInterlock( params );
		}
		catch ( NotFoundLoginSessionException e ) {
			result.setFail( "Biz 에러 발생", e );
		}
		return result;
	}

	@Override
	public ResultVO ExReportContentsInterLockInfoSelect ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			params.put( "empSeq", loginVo.getUniqId( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			result = serviceReportA.selectContentsInterlock( params );
		}
		catch ( NotFoundLoginSessionException e ) {
			result.setFail( "Biz 에러 발생", e );
		}
		return result;
	}

	@Override
	public ResultVO ExReportDContentsInterLockInfoSelect ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			params.put( "empSeq", loginVo.getUniqId( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			result = serviceReportA.selectDContentsInterlock( params );
		}
		catch ( NotFoundLoginSessionException e ) {
			result.setFail( "Biz 에러 발생", e );
		}
		return result;
	}

	/**
	 * 사용자 - 매입전자세금계산서 현황
	 */
	public ResultVO NPUserETaxReportList ( ResultVO param, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> erpList = new ArrayList<Map<String, Object>>( );
		List<Map<String, Object>> gwList = new ArrayList<Map<String, Object>>( );
		switch ( conVo.getErpTypeCode( ) ) {
			case commonCode.ERPIU:
				// erpList = serviceReportU.NPUserEtaxReportList( param.getParams( ), conVo );
				// break;
			case commonCode.ICUBE:
				//				erpList = serviceI.ExAdminEtaxReportList( param, conVo );
				/* iCUBE 사업장 정보 조회 후 파라미터에 추가 */
				//				Map<String, Object> tParam = new HashMap<String, Object>( );
				//				ResultVO tResult = new ResultVO( );
				//				tParam.put( commonCode.CODETYPE, commonCode.EMP );
				//				tParam.put( "searchStr", CommonConvert.CommonGetEmpVO( ).getErpEmpCd( ) );
				//				tResult = commonCodeA.ExCommonCodeInfoSelect( tParam );
				//				if ( tResult == null || tResult.getAaData( ) == null || tResult.getAaData( ).isEmpty( ) || CommonConvert.CommonGetStr( tResult.getAaData( ).get( 0 ).get( "erpBizSeq" ) ).toString( ).equals( "" ) ) {
				//					param.setFail( "ERP 사번을 확인해주세요" );
				//					return param;
				//				}
				//				Map<String, Object> tEtaxParam = new LinkedHashMap<String, Object>( );
				//				tEtaxParam = CommonConvert.CommonSetMapCopy( param.getParams( ), tEtaxParam );
				//				tEtaxParam.put( "bizplanCode", tResult.getAaData( ).get( 0 ).get( "erpBizSeq" ).toString( ) + "|" );
				//				param.setParams( tEtaxParam );
				//				erpList = codeI.ExUserTtaxReportList( param, conVo );
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
		gwList = serviceReportA.NPUserEtaxReportList( param.getParams( ), conVo );
		erpList.addAll( gwList );
		param.setAaData( erpList );
		return param;
	}

	@Override
	public ResultVO ExReportFooterInterLockInfoSelect ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			params.put( "empSeq", loginVo.getUniqId( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			result = serviceReportA.selectFooterInterlock( params );
		}
		catch ( NotFoundLoginSessionException e ) {
			result.setFail( "Biz 에러 발생", e );
		}
		return result;
	}

	@Override
	public ResultVO NPUserCardTransHistoryList ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			params.put( "empSeq", loginVo.getUniqId( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			result = serviceReportA.selectCardTransHistoryList( params );
		}
		catch ( NotFoundLoginSessionException e ) {
			result.setFail( "Biz 에러 발생", e );
		}
		return result;
	}

	/**
	 * 법인카드 승인내역 상세 팝업 조회
	 */
	@Override
	public ResultVO NPUserCardDetailInfo ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			params.put( "empSeq", loginVo.getUniqId( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			result = serviceReportA.NPUserCardDetailInfo( params );
		}
		catch ( NotFoundLoginSessionException e ) {
			result.setFail( "Biz 에러 발생", e );
		}
		return result;
	}

	/**
	 * 매입전자 세금 계산서 승인내역 상세 팝업 조회
	 */
	@Override
	public ResultVO NPUserETaxDetailInfo ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			params.put( "empSeq", loginVo.getUniqId( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			params.put( "erpCompSeq", conVo.getErpCompSeq( ) );
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
				result = serviceReportU.NPUserETaxDetailInfo( params, conVo );
			}
			else if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
				result = serviceReportI.NPUserETaxDetailInfo( params, conVo );
			}
		}
		catch ( NotFoundLoginSessionException e ) {
			result.setFail( "Biz 에러 발생", e );
		}
		return result;
	}

	/* ## ############################################# ## */
	/* 매입전자세금계산서 현황 및 기능 2차 구현 - 김상겸 */
	/* ## ############################################# ## */
	/**
	 * 매입전자세금계산서 미사용 처리
	 *
	 * @param param
	 *            ( issNo, issDt, trRegNb, ResultVO.groupSeq, ResultVO.compSeq, ResultVO.empSeq )
	 * @return ResultVO.resultCode
	 * @throws Exception
	 */
	public ResultVO SetETaxUseUpdateN ( ResultVO param ) throws Exception {
		try {
			/* VO */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ResultVO temp = new ResultVO( );
			param.setLoginVo( loginVo );
			/* List */
			List<Map<String, Object>> paramList = new ArrayList<Map<String, Object>>( );
			paramList = CommonConvert.CommonGetJSONToListMap( CommonConvert.CommonGetStr( param.getParams( ).get( "eTaxNotUseList" ) ) );
			for ( Map<String, Object> map : paramList ) {
				temp = new ResultVO( );
				temp.setLoginVo( loginVo );
				temp.setParams( map );
				temp = serviceReportA.SetETaxUseN( temp );
				if ( temp.getResultCode( ).equals( commonCode.FAIL ) ) {
					throw new Exception( "미사용 처리중 오류가 발생되었습니다." );
				}
			}
			param.setSuccess( );
		}
		catch ( Exception e ) {
			param.setFail( "매입전자세금계산서 미사용 처리 오류 발생 : " + e.toString( ) );
		}
		return param;
	}

	/**
	 * 매입전자세금계산서 사용 처리
	 *
	 * @param param
	 *            ( issNo, issDt, trRegNb, ResultVO.groupSeq, ResultVO.compSeq, ResultVO.empSeq )
	 * @return ResultVO.resultCode
	 * @throws Exception
	 */
	public ResultVO SetETaxUseUpdateY ( ResultVO param ) throws Exception {
		try {
			/* VO */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ResultVO temp = new ResultVO( );
			param.setLoginVo( loginVo );
			/* List */
			List<Map<String, Object>> paramList = new ArrayList<Map<String, Object>>( );
			paramList = CommonConvert.CommonGetJSONToListMap( CommonConvert.CommonGetStr( param.getParams( ).get( "eTaxUseList" ) ) );
			for ( Map<String, Object> map : paramList ) {
				temp = new ResultVO( );
				temp.setLoginVo( loginVo );
				temp.setParams( map );
				temp = serviceReportA.SetETaxUseY( temp );
				if ( temp.getResultCode( ).equals( commonCode.FAIL ) ) {
					throw new Exception( "미사용 처리중 오류가 발생되었습니다." );
				}
			}
			param.setSuccess( );
		}
		catch ( Exception e ) {
			param.setFail( "매입전자세금계산서 미사용 처리 오류 발생 : " + e.toString( ) );
		}
		return param;
	}

	/**
	 * 매입전자세금계산서 이관 처리
	 *
	 * @param param
	 * @return ( []eTaxTransList, receiveEmpSeq, receiveEmpName, receiveEmpSuperKey )
	 * @throws Exception
	 */
	public ResultVO SetETaxTrans ( ResultVO param ) throws Exception {
		try {
			/* VO */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ResultVO temp = new ResultVO( );
			/* List */
			List<Map<String, Object>> paramList = new ArrayList<Map<String, Object>>( );
			paramList = CommonConvert.CommonGetJSONToListMap( CommonConvert.CommonGetStr( param.getParams( ).get( "eTaxTransList" ) ) );
			for ( Map<String, Object> map : paramList ) {
				temp = new ResultVO( );
				temp.setLoginVo( loginVo );
				map.put( "receiveEmpSeq", CommonConvert.CommonGetStr( param.getParams( ).get( "receiveEmpSeq" ) ) );
				map.put( "receiveEmpName", CommonConvert.CommonGetStr( param.getParams( ).get( "receiveEmpName" ) ) );
				map.put( "receiveEmpSuperKey", CommonConvert.CommonGetStr( param.getParams( ).get( "receiveEmpSuperKey" ) ) );
				temp.setParams( map );
				temp = serviceReportA.SetETaxTrans( temp );
				if ( temp.getResultCode( ).equals( commonCode.FAIL ) ) {
					throw new Exception( "매입전자세금계산서 이관 처리중 오류가 발생되었습니다." );
				}
			}
			param.setSuccess( );
		}
		catch ( Exception e ) {
			param.setFail( "매입전자세금계산서 이관 처리 오류 발생 : " + e.toString( ) );
		}
		return param;
	}

	@Override
	public ResultVO ExReportAdvInterLockInfoSelect(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = serviceReportA.selectDocumentInterfaceInfo(params);
		}
		catch ( Exception e ) {
			result.setFail( "Biz 에러 발생", e );
		}
		return result;
	}
}

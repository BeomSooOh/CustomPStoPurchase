package expend.np.user.budget;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import expend.np.user.option.BNpUserOptionService;


@Repository ( "FNpUserBudgetServiceADAO" )
public class FNpUserBudgetServiceADAO extends EgovComAbstractDAO {

	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog;
	@Resource ( name = "BNpUserOptionService" )
	private BNpUserOptionService serviceOption; /* Expend Service */
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo;

	/**
	 * 예산 잔액정보 조회
	 * P : {
	 * erpGisu
	 * , abgtCd
	 * }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO selectConsBudgetBalance ( Map<String, Object> params ) throws Exception {
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( CommonConvert.CommonGetEmpVO( ).getCompSeq( ) ) );
		return _selectConsBudgetBalance( params, conVo );
	}

	@SuppressWarnings ( "unchecked" )
	public ResultVO selectConsBudgetBalance ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		return _selectConsBudgetBalance( params, conVo );
	}

	/**
	 * 예산 잔액정보 조회
	 * P : {
	 * erpGisu
	 * , abgtCd
	 * }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO _selectConsBudgetBalance ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		String erpType = conVo.getErpTypeCode();
		ResultVO result = new ResultVO( );
		try {
			String erpTypeCode = params.get( "erpTypeCode" ).toString( );
			if ( erpTypeCode.equals( commonCode.ICUBE ) ) {
				Map<String, Object> consBudget = (Map<String, Object>) select( "NpUserBudgetA.selectConsBalanceAmtI", params );
				if ( consBudget == null ) {
					consBudget = new HashMap<String, Object>( );
					consBudget.put( "resErpBudgetSeq", "-1" );
					consBudget.put( "resErpBudgetSeq", "-1" );
					consBudget.put( "consStdAmt", "0" );
					consBudget.put( "consTaxAmt", "0" );
					consBudget.put( "consAmt", "0" );
					consBudget.put( "resStdAmt", "0" );
					consBudget.put( "resTaxAmt", "0" );
					consBudget.put( "resAmt", "0" );
					consBudget.put( "balanceStdAmt", "0" );
					consBudget.put( "balanceTaxAmt", "0" );
					consBudget.put( "balanceAmt", "0" );
				}
				result.setaData( consBudget );
				result.setSuccess( );
			}
			else if ( erpTypeCode.equals( commonCode.ERPIU ) ) {
				Map<String, Object> consBudget = (Map<String, Object>) select( "NpUserBudgetA.selectConsBalanceAmtU", params );
				if ( consBudget == null ) {
					consBudget = new HashMap<String, Object>( );
					consBudget.put( "consErpBgacctSeq", "-1" );
					consBudget.put( "resErpBgacctSeq", "-1" );
					consBudget.put( "consStdAmt", "0" );
					consBudget.put( "consTaxAmt", "0" );
					consBudget.put( "consAmt", "0" );
					consBudget.put( "resStdAmt", "0" );
					consBudget.put( "resTaxAmt", "0" );
					consBudget.put( "resAmt", "0" );
					consBudget.put( "balanceStdAmt", "0" );
					consBudget.put( "balanceTaxAmt", "0" );
					consBudget.put( "balanceAmt", "0" );
				}
				result.setaData( consBudget );
				result.setSuccess( );
			}
			else {
				throw new Exception( " ERP TYPE 확인 불가능/ DATA " );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 예산 잔액정보 조회 [예실대비 현황용]
	 * P : {
	 * erpGisu
	 * , abgtCd
	 * }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO selectConsBudgetBalanceForYesil ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String erpTypeCode = params.get( "erpTypeCode" ).toString( );
			if ( erpTypeCode.equals( commonCode.ICUBE ) ) {
				List<Map<String, Object>> consBudget = (List<Map<String, Object>>) list( "NpUserBudgetA.selectConsBalanceAmtForYesilI", params );
				if ( consBudget == null ) {
					consBudget = new ArrayList<Map<String, Object>>( );
				}
				result.setAaData( consBudget );
				result.setSuccess( );
			}
			else if ( erpTypeCode.equals( commonCode.ERPIU ) ) {
				result.setFail( "ERP iU는 지원하지 않음." );
			}
			else {
				throw new Exception( " ERP TYPE 확인 불가능/ DATA " );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 결의서 집행금 조회
	 * P : {
	 * erpGisu
	 * , abgtCd
	 * }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO selectResUseAmt ( Map<String, Object> params ) throws Exception {
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( CommonConvert.CommonGetEmpVO( ).getCompSeq( ) ) );
		return _selectResUseAmt( params, conVo );
	}

	/**
	 * 결의서 집행금 조회
	 * P : {
	 * erpGisu
	 * , abgtCd
	 * }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO selectResUseAmt ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		return _selectResUseAmt( params, conVo );
	}

	/**
	 * 결의서 집행금 조회
	 * P : {
	 * erpGisu
	 * , abgtCd
	 * }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO _selectResUseAmt ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		String erpType = conVo.getErpTypeCode();
		ResultVO result = new ResultVO( );
		try {
			Map<String, Object> resUse = new HashMap<String, Object>( );
			String erpTypeCode = params.get( "erpTypeCode" ).toString( );
			if ( erpTypeCode.equals( commonCode.ICUBE ) ) {
				resUse = (Map<String, Object>) select( "NpUserBudgetA.selectResUseAmtI", params );
				if ( resUse == null ) {
					resUse = new HashMap<String, Object>( );
					resUse.put( "resErpBudgetSeq", "-1" );
					resUse.put( "resBudgetStdAmt", "0" );
					resUse.put( "resBudgetTaxAmt", "0" );
					resUse.put( "resBudgetAmt", "0" );
				}
			}
			else if ( erpTypeCode.equals( commonCode.ERPIU ) ) {
				resUse = (Map<String, Object>) select( "NpUserBudgetA.selectResUseAmtU", params );
				// TODO: 부가세 옵션 처리 필요 ( ERPiU 옵션 미구현 )
				if ( resUse == null ) {
					resUse = new HashMap<String, Object>( );
					resUse.put( "resErpBgacctSeq", "-1" );
					resUse.put( "resBudgetStdAmt", "0" );
					resUse.put( "resBudgetTaxAmt", "0" );
					resUse.put( "resBudgetAmt", "0" );
				}
			}
			result.setaData( resUse );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 결의서 집행금 조회 [예실대비 현황용]
	 * P : {
	 * erpGisu
	 * , abgtCd
	 * }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO selectResUseAmtForYesil ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String erpTypeCode = params.get( "erpTypeCode" ).toString( );
			if ( erpTypeCode.equals( commonCode.ICUBE ) ) {
				List<Map<String, Object>> resBudget = (List<Map<String, Object>>) list( "NpUserBudgetA.selectResUseAmtForYesilI", params );
				if ( resBudget == null ) {
					resBudget = new ArrayList<Map<String, Object>>( );
				}
				result.setAaData( resBudget );
				result.setSuccess( );
			}
			else if ( erpTypeCode.equals( commonCode.ERPIU ) ) {
				result.setFail( "ERP iU는 지원하지 않음." );
			}
			else {
				throw new Exception( " ERP TYPE 확인 불가능/ DATA " );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 각개 품의 예산 금액 정보 가져오기
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO selectConsAmt ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result.setaData( (Map<String, Object>) select( "NpUserBudgetA.selectConsAmtInfo", params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 각개 결의 예산 금액 정보 가져오기
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO selectResAmt ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			Map<String, Object> tempResult = (Map<String, Object>) select( "NpUserBudgetA.selectResAmtInfo", params );
			result.setaData( tempResult );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * [G20] 품의서 문서내의 예산별 합산금 조회
	 * P : { }
	 * return ResultVO with aData
	 */
	public ResultVO selectConsTryAmt ( Map<String, Object> params ) throws Exception {
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( CommonConvert.CommonGetEmpVO( ).getCompSeq( ) ) );
		return _selectConsTryAmt( params, conVo );
	}
	public ResultVO selectConsTryAmt ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		return _selectConsTryAmt( params, conVo );
	}
	@SuppressWarnings ( "unchecked" )
	public ResultVO _selectConsTryAmt ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
				result.setaData( (Map<String, Object>) select( "NpUserBudgetA.selectConsTryAmtForiU", params ) );
			}
			else {
				result.setaData( (Map<String, Object>) select( "NpUserBudgetA.selectConsTryAmt", params ) );
			}
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 결의서 문서내의 예산별 합산금 조회
	 * P : { }
	 * return ResultVO with aData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO selectResTryAmt ( Map<String, Object> params ) throws Exception {
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( CommonConvert.CommonGetEmpVO( ).getCompSeq( ) ) );
		return _selectResTryAmt( params, conVo );
	}

	/**
	 * 결의서 문서내의 예산별 합산금 조회
	 * P : { }
	 * return ResultVO with aData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO selectResTryAmt ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		return _selectResTryAmt( params, conVo );
	}

	/**
	 * 참조품의시 문서내의 결의서 예산별 금회집행액 조회
	 * P : { }
	 * return ResultVO with aData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO selectConfferTryAmt ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		return _selectConfferTryAmt( params, conVo );
	}

	/**
	 * 참조품의시 문서내의 결의서 예산별 금회집행액 조회
	 * P : { }
	 * return ResultVO with aData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO selectConfferTryAmt ( Map<String, Object> params) throws Exception {
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( CommonConvert.CommonGetEmpVO( ).getCompSeq( ) ) );
		return _selectConfferTryAmt( params, conVo );
	}

	/**
	 * 결의서 문서내의 예산별 합산금 조회
	 * P : { }
	 * return ResultVO with aData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO _selectResTryAmt ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			Map<String, Object> resultTemp = null;
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
				resultTemp = (Map<String, Object>) select( "NpUserBudgetA.selectResTryAmtForiU", params );
			}
			else {
				resultTemp = (Map<String, Object>) select( "NpUserBudgetA.selectResTryAmt", params );
			}
			result.setaData( resultTemp );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 결의서 문서내의 예산별 금회집행액 조회
	 * P : { }
	 * return ResultVO with aData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO _selectConfferTryAmt ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			Map<String, Object> resultTemp = null;
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
				resultTemp = (Map<String, Object>) select( "NpUserBudgetA.selectConfferTryAmtForiU", params );
			}
			else {
				resultTemp = (Map<String, Object>) select( "NpUserBudgetA.selectConfferResTryAmt", params );
			}
			result.setaData( resultTemp );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}



	/**
	 * 결의서 문서내의 예산별 합산금 조회
	 * P : { }
	 * return ResultVO with aData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO selectConfferBudgetBalanceAmt ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			Map<String, Object> tempResult = (Map<String, Object>) select( "NpUserBudgetA.selectConfferBudgetBalance", params );
			result.setaData( tempResult );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	public ResultVO selectConfferBudgetInfo(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData((List<Map<String, Object>>) list( "NpUserBudgetA.selectConfferBudgetInfo", params ));
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	public ResultVO updateConfferBudgetInfo(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			update ( "NpUserBudgetA.updateConfferBudgetInfo", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	public ResultVO selectConsItemAmt(Map<String, Object> params, ConnectionVO conVo) {
		ResultVO result = new ResultVO( );
		try {
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
				result.setaData( (Map<String, Object>) select( "NpUserBudgetA.selectConsItemAmtForiU", params ) );
			}
			else {
				result.setaData( (Map<String, Object>) select( "NpUserBudgetA.selectConsItemAmt", params ) );
			}
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	public ResultVO selectResItemAmt(Map<String, Object> params, ConnectionVO conVo) {
		ResultVO result = new ResultVO( );
		try {
			Map<String, Object> resultTemp = null;
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
				resultTemp = (Map<String, Object>) select( "NpUserBudgetA.selectResItemAmtForiU", params );
			}
			else {
				resultTemp = (Map<String, Object>) select( "NpUserBudgetA.selectResItemAmt", params );
			}
			result.setaData( resultTemp );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}


}
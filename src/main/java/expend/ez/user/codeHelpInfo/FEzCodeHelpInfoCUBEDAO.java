package expend.ez.user.codeHelpInfo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import common.helper.connection.CommonEzConnect;
import common.helper.logger.CommonLogger;
import common.vo.common.ConnectionVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository ( "FEzCodeHelpInfoCUBEDAO" )
public class FEzCodeHelpInfoCUBEDAO extends EgovComAbstractDAO {
	/* 변수정의 - Class */
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );
	/* 변수정의 - class */
	CommonEzConnect connector = new CommonEzConnect( );

	/* 프로젝트코드 가져오기 */
	public List<Map<String, Object>> EzPrjoectCodeInfoSelect( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>( );
		cmLog.CommonSetInfo( "+ [EX] FEzCodeHelpInfoCUBEDAO - EzPrjoectCodeInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> params >" + params.toString( ) );
		try {
			resultList = connector.List( conVo, "EziCUBESQL.USP_ANZR020_PRJNO_SELECT", params );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> resultList >" + resultList);

		return resultList;

	}

	/* 비목코드 가져오기 */
	public List<Map<String, Object>> EzBMCodeInfoSelect( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>( );
		cmLog.CommonSetInfo( "+ [EX] FEzCodeHelpInfoCUBEDAO - EzBMCodeInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> params >" + params.toString( ) );
		try {
			resultList = connector.List( conVo, "EziCUBESQL.USP_ANZR100_BMCODE_SELECT", params );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> resultList >" + resultList);

		return resultList;

	}

	/* 사용용도 코드 가져오기 */
	public List<Map<String, Object>> EzUseCodeInfoSelect( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>( );
		cmLog.CommonSetInfo( "+ [EX] FEzCodeHelpInfoCUBEDAO - EzUseCodeInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> params >" + params.toString( ) );
		try {
			resultList = connector.List( conVo, "EziCUBESQL.USP_ANZR100_NRNDCODE_A01_SELECT", params );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> resultList >" + resultList);

		return resultList;

	}

	/* 집행방법 코드 가져오기 */
	public List<Map<String, Object>> EzExecMtdCodeInfoSelect( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>( );
		cmLog.CommonSetInfo( "+ [EX] FEzCodeHelpInfoCUBEDAO - EzExecMtdCodeInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> params >" + params.toString( ) );
		try {
			resultList = connector.List( conVo, "EziCUBESQL.USP_ANZR020_NRNDCODE_SELECT", params );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> resultList >" + resultList);
		return resultList;
	}


	/* 집행요청구분 코드 가져오기 */
	public List<Map<String, Object>> EzExecReqDivCodeInfoSelect( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>( );
		cmLog.CommonSetInfo( "+ [EX] FEzCodeHelpInfoCUBEDAO - EzExecReqDivCodeInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> params >" + params.toString( ) );
		try {
			resultList = connector.List( conVo, "EziCUBESQL.USP_ANZR020_NRNDCODE_SELECT", params );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> resultList >" + resultList);
		return resultList;
	}

	/* G20입출금계좌 가져오기 */
	public List<Map<String, Object>> EzInOutAccountInfoSelect( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>( );
		cmLog.CommonSetInfo( "+ [EX] FEzCodeHelpInfoCUBEDAO - EzExecReqDivCodeInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> params >" + params.toString( ) );
		try {
			resultList = connector.List( conVo, "EziCUBESQL.USP_GET_HELPCODE", params );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> resultList >" + resultList);
		return resultList;
	}

	/* G20 거래처 정보 가져오기*/
	public List<Map<String, Object>> EzPartnerInfoSelect( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>( );
		cmLog.CommonSetInfo( "+ [EX] FEzCodeHelpInfoCUBEDAO - EzPartnerInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> params >" + params.toString( ) );
		try {
			resultList = connector.List( conVo, "EziCUBESQL.USP_GET_HELPCODE", params );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> resultList >" + resultList);
		return resultList;
	}
	/* G20 연구자 정보 가져오기*/
	public List<Map<String, Object>> EzResearcherInfoSelect( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>( );
		cmLog.CommonSetInfo( "+ [EX] FEzCodeHelpInfoCUBEDAO - EzResearcherInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> params >" + params.toString( ) );
		try {
			resultList = connector.List( conVo, "EziCUBESQL.USP_ANZR020_RESPERSONNO_SELECT", params );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> resultList >" + resultList);
		return resultList;
	}
	/* 은행정보 가져오기*/
	public List<Map<String, Object>> EzBankInfoSelect( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>( );
		cmLog.CommonSetInfo( "+ [EX] FEzCodeHelpInfoCUBEDAO - EzBankInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> params >" + params.toString( ) );
		try {
			resultList = connector.List( conVo, "EziCUBESQL.USP_ANZR020_NRNDCODE_SELECT", params );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> resultList >" + resultList);
		return resultList;
	}
	/* 물품구분 가져오기*/
	public List<Map<String, Object>> EzItemGbnInfoSelect( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>( );
		cmLog.CommonSetInfo( "+ [EX] FEzCodeHelpInfoCUBEDAO - EzItemGbnInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> params >" + params.toString( ) );
		try {
			resultList = connector.List( conVo, "EziCUBESQL.USP_ANZR020_NRNDCODE_SELECT", params );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> resultList >" + resultList);
		return resultList;
	}
	/* 소속구분 가져오기*/
	public List<Map<String, Object>> EzBelongGbnInfoSelect( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>( );
		cmLog.CommonSetInfo( "+ [EX] FEzCodeHelpInfoCUBEDAO - EzBelongGbnInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> params >" + params.toString( ) );
		try {
			resultList = connector.List( conVo, "EziCUBESQL.USP_ANZR020_NRNDCODE_SELECT", params );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> resultList >" + resultList);
		return resultList;
	}

	/* 시내외구분 가져오기*/
	public List<Map<String, Object>> EzInoutGbnInfoSelect( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>( );
		cmLog.CommonSetInfo( "+ [EX] FEzCodeHelpInfoCUBEDAO - EzInoutGbnInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> params >" + params.toString( ) );
		try {
			resultList = connector.List( conVo, "EziCUBESQL.USP_ANZR020_NRNDCODE_SELECT", params );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> resultList >" + resultList);
		return resultList;
	}

	/* 활용방법 가져오기*/
	public List<Map<String, Object>> EzUsemethodInfoSelect( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>( );
		cmLog.CommonSetInfo( "+ [EX] FEzCodeHelpInfoCUBEDAO - EzUsemethodInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> params >" + params.toString( ) );
		try {
			resultList = connector.List( conVo, "EziCUBESQL.USP_ANZR020_NRNDCODE_SELECT", params );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> resultList >" + resultList);
		return resultList;
	}


	/* 카드사용 가져오기*/
	public List<Map<String, Object>> EzCardNumInfoSelect( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>( );
		cmLog.CommonSetInfo( "+ [EX] FEzCodeHelpInfoCUBEDAO - EzCardNumInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> params >" + params.toString( ) );
		try {
			resultList = connector.List( conVo, "EziCUBESQL.USP_ANZR100_CARDNO_SELECT", params );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> resultList >" + resultList);
		return resultList;
	}

	/* 전자 세금계산서 조회 */
	public List<Map<String, Object>> EzTaxApprNoInfoSelect( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>( );
		cmLog.CommonSetInfo( "+ [EX] FEzCodeHelpInfoCUBEDAO - EzTaxApprNoInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> params >" + params.toString( ) );
		try {
			resultList = connector.List( conVo, "EziCUBESQL.USP_ANZR100_ETAX_SELECT_HH", params );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> resultList >" + resultList);
		return resultList;
	}

	/* 세금계산서 선택한 항목 리스트 가져오기*/
	public List<Map<String, Object>> EzETaxListInfo( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>( );
		cmLog.CommonSetInfo( "+ [EX] FEzCodeHelpInfoCUBEDAO - EzETaxListInfo" );
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> params >" + params.toString( ) );
		try {
			resultList = connector.List( conVo, "EziCUBESQL.GetEzBaroDetailETAX", params );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> resultList >" + resultList);
		return resultList;
	}


	/* 세금계산서 선택한 항목 리스트 가져오기*/
	public List<Map<String, Object>> EzCommonCodeInfo( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>( );
		cmLog.CommonSetInfo( "+ [EX] FEzCodeHelpInfoCUBEDAO - EzCommonCodeInfo" );
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> params >" + params.toString( ) );
		try {
			resultList = connector.List( conVo, "EziCUBESQL.USP_ANZR100_NRNDCODE_SELECT", params );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> resultList >" + resultList);
		return resultList;
	}

	/* 이지바로 공통코드 설정하기 */
	public Map<String,Object> EzCommonCodeUpdate(Map<String,Object> params, ConnectionVO conVo ) throws Exception {
		cmLog.CommonSetInfo("+ [EZBARO] FEzSendInfoCubeDAO - EzCommonCodeUpdate");
		cmLog.CommonSetInfo("! [EZBARO] AN_NRNDEXECREQ params >> " + params);
		Map<String,Object> result = new HashMap<String,Object>();
		try {
				connector.Update( conVo, "EziCUBESQL.USP_ANZR100_NRNDCODE_DML", params, "SP" );
				result.put("result", "success");
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}

	/* 기타소득 가져오기*/
	public List<Map<String, Object>> EzETCPartnerInfoSelect( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>( );
		cmLog.CommonSetInfo( "+ [EX] FEzCodeHelpInfoCUBEDAO - EzETCPartnerInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> params >" + params.toString( ) );
		try {
			resultList = connector.List( conVo, "EziCUBESQL.USP_ANA0006_BY_HPMETIC_SELECT", params );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> resultList >" + resultList);
		return resultList;
	}

	/* 지급은행 단일항목 가져오기*/
	public Map<String, Object> EzReqBankInfoSelect( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		Map<String, Object> result = new HashMap<String,Object>();
		cmLog.CommonSetInfo( "+ [EX] FEzCodeHelpInfoCUBEDAO - EzReqBankInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> params >" + params.toString( ) );
		try {
			result = connector.Select( conVo, "EziCUBESQL.USP_ANZR100_BANK_CD_SELECT_HH", params );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> result >" + result);
		return result;
	}

	/* 사용자 지급은행 단일항목 가져오기*/
	public Map<String, Object> EzEmpReqBankInfoSelect( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		Map<String, Object> result = new HashMap<String,Object>();
		cmLog.CommonSetInfo( "+ [EX] FEzCodeHelpInfoCUBEDAO - EzEmpReqBankInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> params >" + params.toString( ) );
		try {
			result = connector.Select( conVo, "EziCUBESQL.USP_ANA0006_BY_SEMP_SELECT", params );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> result >" + result);
		return result;
	}

	/* 사용자 계좌정보 단일항목 가져오기*/
	public Map<String, Object> EzEmpAcctInfoSelect( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		Map<String, Object> result = new HashMap<String,Object>();
		cmLog.CommonSetInfo( "+ [EX] FEzCodeHelpInfoCUBEDAO - EzEmpAcctInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> params >" + params.toString( ) );
		try {
			result = connector.Select( conVo, "EziCUBESQL.USP_ANZR100_ACCBANK_SELECT_HH", params );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> result >" + result);
		return result;
	}

	/* 사용자 참여율 정보 가져오기*/
	public List<Map<String, Object>> EzRateInfoSelect( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>( );
		cmLog.CommonSetInfo( "+ [EX] FEzCodeHelpInfoCUBEDAO - EzRateInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> params >" + params.toString( ) );
		try {
			resultList = connector.List( conVo, "EziCUBESQL.USP_ANZR020_SELECT_D", params );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> result >" + resultList);
		return resultList;
	}

	/* 소득구분 정보 가져오기*/
	public List<Map<String, Object>> EzIncomeGbnSelect( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>( );
		cmLog.CommonSetInfo( "+ [EX] FEzCodeHelpInfoCUBEDAO - EzIncomeGbnSelect" );
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> params >" + params.toString( ) );
		try {
			resultList = connector.List( conVo, "EziCUBESQL.USP_GET_HELPCODE_AMT", params );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> result >" + resultList);
		return resultList;
	}
}

package expend.np.user.option;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


@Service ( "BNpUserOptionService" )
public class BNpUserOptionServiceImpl implements BNpUserOptionService {

	@Resource ( name = "FNpUserOptionServiceI" )
	private FNpUserOptionService serviceOptionI;
	@Resource ( name = "FNpUserOptionServiceU" )
	private FNpUserOptionService serviceOptionU;
	@Resource ( name = "FNpUserOptionServiceA" )
	private FNpUserOptionService serviceOptionA;
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo;

	@Override
	public ResultVO npTest ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		serviceOptionI.npTest( params, conVo );
		return null;
	}

	/**
	 * ERP 옵션 조회
	 */
	@Override
	public ResultVO selectERPOption ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
				result = serviceOptionI.selectERPOption( params, conVo );
			}
			else if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
				result = serviceOptionU.selectERPOption( params, conVo );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "ERP 설정 구분을 확인할 수 없습니다.", ex );
		}
		return result;
	}

	/**
	 * GW 옵션 조회
	 */
	@Override
	public ResultVO selectGWOption ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			params.put( "useSw", conVo.getErpTypeCode( ) );
			params.put( "compSeq", CommonConvert.CommonGetEmpVO( ).getCompSeq( ) );
			result = serviceOptionA.selectGWOption( params, conVo );
		}
		catch ( Exception ex ) {
			result.setFail( "GW 설정을 확인할 수 없습니다.", ex );
		}
		return result;
	}

	/**
	 * ERP 기본 정보 조회
	 */
	@Override
	public ResultVO selectERPBaseData ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			params.put( "useSw", conVo.getErpTypeCode( ) );
			params.put( "compSeq", CommonConvert.CommonGetEmpVO( ).getCompSeq( ) );
			params.put( "erpEmpSeq", CommonConvert.CommonGetEmpVO( ).getErpEmpCd( ) );
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
				result = serviceOptionI.selectBaseData( params, conVo );
			}
			else if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
				result = serviceOptionU.selectBaseData( params, conVo );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "GW 설정을 확인할 수 없습니다.", ex );
		}
		return result;
	}

	/**
	 * 전자결재 기본 정보 조회
	 */
	@Override
	public ResultVO selectEaBaseData ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = serviceOptionA.selectEaFormInfo( params, conVo );
		}
		catch ( Exception ex ) {
			result.setFail( "GW 설정을 확인할 수 없습니다.", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectAbgtinfo ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		if ( conVo == null ) {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
		}
		try {
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
				result = serviceOptionU.selectAbgtInfo( params, conVo );
			}
			else if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
				result = serviceOptionI.selectAbgtInfo( params, conVo );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "GW 설정을 확인할 수 없습니다.", ex );
		}
		return result;
	}

	@Override
	public String selectERPVatCtrData(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		String result = "N";
		if (conVo == null) {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO();
			conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
		}
		try {
			if (conVo.getErpTypeCode().equals(commonCode.ERPIU)) {
				// 원인행위등록시 부가세 예산 포함여부
				ResultVO r = serviceOptionU.selectVatCtrData(params, conVo);
				if (r.getResultCode().equals(commonCode.SUCCESS)) {
					if (CommonConvert.CommonGetStr(r.getaData().get("USE_YN")).equals("Y")) {
						result = "Y";
					}
					else {
						result = "N";
					}
				}
				else {
					result = "N";
				}
			}
			else if (conVo.getErpTypeCode().equals(commonCode.ICUBE)) {
				ResultVO r = serviceOptionI.selectVatCtrData(params, conVo);
				if (r.getResultCode().equals(commonCode.SUCCESS)) {
					if (CommonConvert.CommonGetStr(r.getaData().get("FG_TY")).equals("1")) {
						result = "N";
					}
					else {
						result = "Y";
					}

				}
				else {
					result = "Y";
				}
			}
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
		return result;
	}

	/** 1. 카드번호 표시방식 설정 조회 1 : 가운대 8자리 * 2 : 모두표기*/
	@Override
	public ResultVO selectBasicOptionCardPrint ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		HashMap<String, Object> aData = new HashMap<>( );
		params.put( "optionGbn", "1" );
		params.put( "optionCode", "1" );
		result = serviceOptionA.selectBasicOption( params );
		if(result.getResultCode( ).equals( commonCode.FAIL )){
			return result;
		}

		if(result.getAaData().size( ) == 0){
			aData.put( "value", 0 );
			aData.put( "note",  "가운데 8자리 *표시" );
		}else{
			HashMap<String, Object> item = (HashMap<String, Object>) result.getAaData( ).get( 0 );
			aData.put( "value", item.get( "setValue" ).toString( ) );
			aData.put( "note", item.get( "setName" ).toString( ) );
			result.setaData( aData );
		}
		result.setSuccess( );
		return result;
	}
	/** 2. 주민번호 표시방식 설정 조회 1 : 뒤에서 6자리 * 2 : 모두표기 */
	@Override
	public ResultVO selectBasicOptionJuminPrint ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		HashMap<String, Object> aData = new HashMap<>( );
		params.put( "optionGbn", "1" );
		params.put( "optionCode", "2" );
		result = serviceOptionA.selectBasicOption( params );
		if(result.getResultCode( ).equals( commonCode.FAIL )){
			return result;
		}

		if(result.getAaData().size( ) == 0){
			aData.put( "value", 0 );
			aData.put( "note",  "뒤에서 6자리 *표시" );
		}else{
			HashMap<String, Object> item = (HashMap<String, Object>) result.getAaData( ).get( 0 );
			aData.put( "value", item.get( "setValue" ).toString( ) );
			aData.put( "note", item.get( "setName" ).toString( ) );
			result.setaData( aData );
		}
		result.setSuccess( );
		return result;
	}
	/** 3. 예산체크 로직선택 1: 저장 중 문서 체크 2: 상신 문서 체크 */
	@Override
	public ResultVO selectBasicOptionBudgetCheck ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		HashMap<String, Object> aData = new HashMap<>( );
		params.put( "optionGbn", "1" );
		params.put( "optionCode", "3" );
		result = serviceOptionA.selectBasicOption( params );
		if(result.getResultCode( ).equals( commonCode.FAIL )){
			return result;
		}

		if(result.getAaData().size( ) == 0){
			aData.put( "value", 1 );
			aData.put( "note",  "상신 문서 예산체크" );
		}else{
			HashMap<String, Object> item = (HashMap<String, Object>) result.getAaData( ).get( 0 );
			aData.put( "value", item.get( "setValue" ).toString( ) );
			aData.put( "note", item.get( "setName" ).toString( ) );
			result.setaData( aData );
		}
		result.setSuccess( );
		return result;
	}
	/** 4. 품의서 참조권한 1: 부서 2: 개인 */
	@Override
	public ResultVO selectBasicOptionConsAuth ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		HashMap<String, Object> aData = new HashMap<>( );
		params.put( "optionGbn", "3" );
		params.put( "optionCode", "1" );
		result = serviceOptionA.selectBasicOption( params );
		if(result.getResultCode( ).equals( commonCode.FAIL )){
			return result;
		}

		if(result.getAaData().size( ) == 0){
			aData.put( "value", 0 );
			aData.put( "note",  "부서" );
		}else{
			HashMap<String, Object> item = (HashMap<String, Object>) result.getAaData( ).get( 0 );
			aData.put( "value", item.get( "setValue" ).toString( ) );
			aData.put( "note", item.get( "setName" ).toString( ) );
			result.setaData( aData );
		}
		result.setSuccess( );
		return result;
	}
	/** 5. ERP 전송방식 설정 1: 수동 2: 자동 */
	@Override
	public ResultVO selectBasicOptionSendType ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		HashMap<String, Object> aData = new HashMap<>( );
		params.put( "optionGbn", "3" );
		params.put( "optionCode", "2" );
		result = serviceOptionA.selectBasicOption( params );
		if(result.getResultCode( ).equals( commonCode.FAIL )){
			return result;
		}

		if(result.getAaData().size( ) == 0){
			aData.put( "value", 0 );
			aData.put( "note",  "수동" );
		}else{
			HashMap<String, Object> item = (HashMap<String, Object>) result.getAaData( ).get( 0 );
			aData.put( "value", item.get( "setValue" ).toString( ) );
			aData.put( "note", item.get( "setName" ).toString( ) );
			result.setaData( aData );
		}
		result.setSuccess( );
		return result;
	}

	/** 5. ERP 전송방식 설정 1: 수동 2: 자동 */
	@Override
	public ResultVO selectBasicOptionCreateTr ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		HashMap<String, Object> aData = new HashMap<>( );
		if( CommonConvert.NullToString( params.get( "interfaceType" ) ).equals( "card" ) ){
			params.put( "optionGbn", "3" );
			params.put( "optionCode", "7" );
		}else if( CommonConvert.NullToString( params.get( "interfaceType" ) ).equals( "etax" ) ){
			params.put( "optionGbn", "3" );
			params.put( "optionCode", "8" );
		}

		if(conVo.getErpTypeCode( ).equals( commonCode.ICUBE )){
			result = serviceOptionA.selectBasicOption( params );
			if(result.getResultCode( ).equals( commonCode.FAIL )){
				aData.put( "value", 0 );
				aData.put( "note",  "사용" );
			}
			if(result.getAaData().size( ) == 0){
				aData.put( "value", 0 );
				aData.put( "note",  "사용" );
			}else{
				HashMap<String, Object> item = (HashMap<String, Object>) result.getAaData( ).get( 0 );
				aData.put( "value", item.get( "setValue" ).toString( ) );
				aData.put( "note", item.get( "setName" ).toString( ) );
			}
		}else {
			/* ERPiU의 경우 고정 사용 */
			aData.put( "value", 0 );
			aData.put( "note",  "사용" );
		}

		result.setaData( aData );
		result.setSuccess( );
		return result;
	}
}




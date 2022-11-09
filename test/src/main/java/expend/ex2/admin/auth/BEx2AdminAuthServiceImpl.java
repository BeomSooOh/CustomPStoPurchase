package expend.ex2.admin.auth;

import java.util.ArrayList;
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


@Service ( "BEx2AdminAuthService" )
public class BEx2AdminAuthServiceImpl implements BEx2AdminAuthService {

	@Resource ( name = "FEx2AdminAuthServiceA" )
	private FEx2AdminAuthService authA;
	@Resource ( name = "FEx2AdminAuthServiceI" )
	private FEx2AdminAuthService authI;
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통사용 정보 */

	/* 증빙 유형 생성 */
	public ResultVO setAdminAuthInsert ( ResultVO result ) throws Exception {
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			//conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			result = authA.setAdminAuthInsert( result );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setSuccess( );
			}
			else {
				result.setaData( new HashMap<String, Object>( ) );
				result.setFail( "" );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setaData( new HashMap<String, Object>( ) );
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* 증빙 유형 수정 */
	public ResultVO setAdminAuthUpdate ( ResultVO result ) throws Exception {
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			//conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			result = authA.setAdminAuthUpdate( result );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setSuccess( );
			}
			else {
				result.setaData( new HashMap<String, Object>( ) );
				result.setFail( "" );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setaData( new HashMap<String, Object>( ) );
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* 증빙 유형 삭제 */
	public ResultVO setAdminAuthDelete ( ResultVO result ) throws Exception {
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			//conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			result = authA.setAdminAuthDelete( result );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setSuccess( );
			}
			else {
				result.setaData( new HashMap<String, Object>( ) );
				result.setFail( "" );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setaData( new HashMap<String, Object>( ) );
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* 증빙 유형 조회 */
	public ResultVO setAdminAuthSelect ( ResultVO result ) throws Exception {
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			//conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			result = authA.setAdminAuthSelect( result );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setSuccess( );
			}
			else {
				result.setaData( new HashMap<String, Object>( ) );
				result.setFail( commonCode.EMPTYSTR );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setaData( new HashMap<String, Object>( ) );
			result.setFail( e.toString( ) );
		}
		return result;
	}

	public ResultVO setAdminAuthListSelect ( ResultVO result ) throws Exception {
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			//conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			result = authA.setAdminAuthListSelect( result );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setSuccess( );
			}
			else {
				result.setaData( new HashMap<String, Object>( ) );
				result.setFail( "" );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setAaData( new ArrayList<Map<String, Object>>( ) );
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* 증빙 유형 조회 자동 선택 */
	public ResultVO setAdminAuthAutoCode ( ResultVO result ) throws Exception {
		try {
			/* 변수정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( loginVo.getCompSeq( ) );
			result.setAaData( CommonConvert.CommonGetJSONToListMap( result.getParams( ).get( "filter" ).toString( ) ) );
			result = authI.setAdminAutoSelect( result, conVo );
		}
		catch ( Exception e ) {
			result.setaData( new HashMap<String, Object>( ) );
			result.setFail( e.toString( ) );
		}
		return result;
	}
}

package expend.ex2.admin.summary;

import java.util.HashMap;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


@Service ( "BEx2AdminSummaryService" )
public class BEx2AdminSummaryServiceImpl implements BEx2AdminSummaryService {

	@Resource ( name = "FEx2AdminSummaryServiceA" )
	private FEx2AdminSummaryService summaryA;
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통사용 정보 */

	/* 표준적요 생성 */
	public ResultVO setAdminSummaryInsert ( ResultVO result ) throws Exception {
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			result = summaryA.setAdminSummaryInsert( result );
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

	/* 표준적요 수정 */
	public ResultVO setAdminSummaryUpdate ( ResultVO result ) throws Exception {
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			result = summaryA.setAdminSummaryUpdate( result );
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

	/* 표준적요 삭제 */
	public ResultVO setAdminSummaryDelete ( ResultVO result ) throws Exception {
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			result = summaryA.setAdminSummaryDelete( result );
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

	/* 표준적요 조회 */
	public ResultVO setAdminSummarySelect ( ResultVO result ) throws Exception {
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			result = summaryA.setAdminSummarySelect( result );
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

	public ResultVO setAdminSummaryListSelect ( ResultVO result ) throws Exception {
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			result = summaryA.setAdminSummaryListSelect( result );
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
}

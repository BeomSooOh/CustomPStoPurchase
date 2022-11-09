package expend.ex2.admin.auth;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cmm.util.MapUtil;
import common.helper.convert.CommonConvert;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


@Service ( "FEx2AdminAuthServiceA" )
public class FEx2AdminAuthServiceAImpl implements FEx2AdminAuthService {

	/* 변수정의 - DAO */
	@Resource ( name = "FEx2AdminAuthServiceADAO" )
	private FEx2AdminAuthServiceADAO dao;

	/* 증빙 유형 생성 */
	public ResultVO setAdminAuthInsert ( ResultVO result ) throws Exception {
		try {
			boolean chkParameter = true;
			String[] parametersCheck = { "compSeq", "Y", "authCode", "Y", "authName", "Y", "authRequiredYN", "Y", "partnerRequiredYN", "Y", "projectRequiredYN", "Y", "cardRequiredYN", "Y", "noteRequiredYN", "Y", "empSeq", "Y", "useYN", "Y" };
			if ( !MapUtil.hasParameters( result.getParams( ), parametersCheck ) ) {
				result.setFail( "필수 입력 정보가 누락되었습니다." );
				chkParameter = false;
			}
			if ( chkParameter ) {
				result.setaData( dao.setAdminAuthInsert( result.getParams( ) ) );
				result.setSuccess( );
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
			boolean chkParameter = true;
			String[] parametersCheck = { "authName", "Y", "cashType", "N", "crAcctCode", "N", "crAcctName", "N", "vatAcctCode", "N", "vatAcctName", "N", "vatTypeCode", "N", "vatTypeName", "N", "erpAuthCode", "N", "erpAuthName", "N", "authRequiredYN", "Y", "partnerRequiredYN", "Y", "cardRequiredYN", "Y", "projectRequiredYN", "Y", "noteRequiredYN", "Y", "noTaxCode", "N", "noTaxName", "N", "orderNum", "N", "useYN", "Y", "empSeq", "Y", "vaTypeCode", "N", "vaTypeName", "N", "compSeq", "Y", "authDiv", "Y", "authCode", "Y" };
			if ( !MapUtil.hasParameters( result.getParams( ), parametersCheck ) ) {
				result.setFail( "필수 입력 정보가 누락되었습니다." );
				chkParameter = false;
			}
			if ( chkParameter ) {
				result.setaData( dao.setAdminAuthUpdate( result.getParams( ) ) );
				result.setSuccess( );
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
			boolean chkParameter = true;
			String[] parametersCheck = { "compSeq", "Y", "authDiv", "Y", "authCode", "Y" };
			String[] realAuthCode;
			if ( !MapUtil.hasParameters( result.getParams( ), parametersCheck ) ) {
				result.setFail( "필수 입력 정보가 누락되었습니다." );
				chkParameter = false;
			}
			if ( chkParameter ) {
				String authCodes[] = result.getParams( ).get( "authCode" ).toString( ).split( "," );
				List<Map<String, Object>> authErpSendList = new ArrayList<Map<String, Object>>( );
				/* ERP 전송여부 확인 */
				for ( String authTemp : authCodes ) {
					Map<String, Object> deleteParams = new HashMap<String, Object>( );
					Map<String, Object> realAuthCodeTemp = new HashMap<String, Object>( );
					deleteParams.put( "compSeq", result.getParams( ).get( "compSeq" ) );
					deleteParams.put( "authDiv", result.getParams( ).get( "authDiv" ) );
					deleteParams.put( "authCode", authTemp );
					realAuthCodeTemp = dao.setAdminAuthErpSendYN( deleteParams );
					if ( !CommonConvert.CommonGetStr(realAuthCodeTemp.get( "cnt" )).equals( "0" ) ) {
						authErpSendList.add( realAuthCodeTemp );
					}
					//result.setaData( dao.setAdminAuthDelete( deleteParams ) );
				}
				realAuthCode = new String[authErpSendList.size( )];
				int i = 0;
				/* ERP 전송여부가 N인 코드값 호출 */
				for ( Map<String, Object> temp : authErpSendList ) {
					realAuthCode[i] = temp.get( "authCode" ).toString( );
				}
				/* ERP 전송여부가 Y인 코드값 삭제 */
				int erpSendY = 0;
				int erpSendN = 0;
				for ( String auth : authCodes ) {
					Map<String, Object> deleteParams = new HashMap<String, Object>( );
					Map<String, Object> deleteResult = new HashMap<String, Object>( );
					for ( String temp : realAuthCode ) {
						if ( !temp.equals( auth ) ) {
							erpSendY++;
							deleteParams.put( "compSeq", result.getParams( ).get( "compSeq" ) );
							deleteParams.put( "authDiv", result.getParams( ).get( "authDiv" ) );
							deleteParams.put( "authCode", auth );
							deleteResult.put( "erpSendYCount", erpSendY );
							deleteResult.put( "erpSendNCount", erpSendN );
							result.setaData( dao.setAdminAuthDelete( deleteParams ) );
							result.setaData( deleteResult );
						}
						else {
							erpSendN++;
							deleteResult.put( "erpSendYCount", erpSendY );
							deleteResult.put( "erpSendNCount", erpSendN );
							result.setaData( deleteResult );
						}
					}
				}
				result.setSuccess( );
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
			boolean chkParameter = true;
			String[] parametersCheck = { "searchStr", "N", "useYN", "N" };
			if ( !MapUtil.hasParameters( result.getParams( ), parametersCheck ) ) {
				result.setFail( "필수 입력 정보가 누락되었습니다." );
				chkParameter = false;
			}
			if ( chkParameter ) {
				result.setaData( dao.setAdminAuthSelect( result.getParams( ) ) );
				result.setSuccess( );
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
			boolean chkParameter = true;
			String[] parametersCheck = { "searchStr", "N", "useYN", "N" };
			if ( !MapUtil.hasParameters( result.getParams( ), parametersCheck ) ) {
				result.setFail( "필수 입력 정보가 누락되었습니다." );
				chkParameter = false;
			}
			if ( chkParameter ) {
				result.setAaData( dao.setAdminAuthListSelect( result.getParams( ) ) );
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setAaData( new ArrayList<Map<String, Object>>( ) );
			result.setFail( e.toString( ) );
		}
		return result;
	}

	@Override
	public ResultVO setAdminAutoSelect ( ResultVO result, ConnectionVO conVo ) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
}

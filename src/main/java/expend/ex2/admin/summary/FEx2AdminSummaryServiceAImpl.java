package expend.ex2.admin.summary;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cmm.util.MapUtil;
import common.helper.convert.CommonConvert;
import common.vo.common.ResultVO;


@Service ( "FEx2AdminSummaryServiceA" )
public class FEx2AdminSummaryServiceAImpl implements FEx2AdminSummaryService {

	/* 변수정의 - DAO */
	@Resource ( name = "FEx2AdminSummaryServiceADAO" )
	private FEx2AdminSummaryServiceADAO dao;

	public ResultVO setAdminSummaryInsert ( ResultVO result ) throws Exception {
		try {
			boolean chkParameter = true;
			String[] parametersCheck = { "compSeq", "Y", "summaryCode", "Y", "summaryName", "Y", "drAcctCode", "Y", "drAcctName", "Y", "crAcctCode", "Y", "crAcctName", "Y", "vatAcctCode", "Y", "vatAcctName", "Y", "erpAuthCode", "N", "erpAuthName", "N", "useYN", "Y", "empSeq", "N", "orderNum", "N" };
			if ( !MapUtil.hasParameters( result.getParams( ), parametersCheck ) ) {
				result.setFail( "필수 입력 정보가 누락되었습니다." );
				chkParameter = false;
			}
			if ( chkParameter ) {
				result.setaData( dao.setAdminSummaryInsert( result.getParams( ) ) );
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

	/* 표준적요 수정 */
	public ResultVO setAdminSummaryUpdate ( ResultVO result ) throws Exception {
		try {
			boolean chkParameter = true;
			String[] parametersCheck = { "compSeq", "Y", "summaryCode", "Y", "summaryName", "Y", "drAcctCode", "Y", "drAcctName", "Y", "crAcctCode", "Y", "crAcctName", "Y", "vatAcctCode", "Y", "vatAcctName", "Y", "erpAuthCode", "N", "erpAuthName", "N", "useYN", "Y", "empSeq", "N", "orderNum", "N" };
			if ( !MapUtil.hasParameters( result.getParams( ), parametersCheck ) ) {
				result.setFail( "필수 입력 정보가 누락되었습니다." );
				chkParameter = false;
			}
			if ( chkParameter ) {
				result.setaData( dao.setAdminSummaryUpdate( result.getParams( ) ) );
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

	/* 표준적요 삭제 */
	public ResultVO setAdminSummaryDelete ( ResultVO result ) throws Exception {
		try {
			boolean chkParameter = true;
			String[] parametersCheck = { "compSeq", "Y", "summaryCode", "Y" };
			String[] realSummaryCode;
			if ( !MapUtil.hasParameters( result.getParams( ), parametersCheck ) ) {
				result.setFail( "필수 입력 정보가 누락되었습니다." );
				chkParameter = false;
			}
			if ( chkParameter ) {
				String summaryCodes[] = result.getParams( ).get( "summaryCode" ).toString( ).split( "," );
				List<Map<String, Object>> summaryErpSendList = new ArrayList<Map<String, Object>>( );
				/* ERP 전송여부 확인 */
				for ( String summary : summaryCodes ) {
					Map<String, Object> deleteParams = new HashMap<String, Object>( );
					Map<String, Object> realSummaryCodeTemp = new HashMap<String, Object>( );
					deleteParams.put( "compSeq", result.getParams( ).get( "compSeq" ) );
					deleteParams.put( "summaryDiv", result.getParams( ).get( "summaryDiv" ) );
					deleteParams.put( "summaryCode", summary );
					realSummaryCodeTemp = dao.setAdminSummaryErpSendYN( deleteParams );
					if ( !CommonConvert.CommonGetStr(realSummaryCodeTemp.get( "cnt" )).equals( "0" ) ) {
						summaryErpSendList.add( realSummaryCodeTemp );
					}
					//					result.setaData( dao.setAdminSummaryDelete( deleteParams ) );
				}
				realSummaryCode = new String[summaryErpSendList.size( )];
				int i = 0;
				/* ERP 전송여부가 N인 코드값 호출 */
				for ( Map<String, Object> temp : summaryErpSendList ) {
					realSummaryCode[i] = temp.get( "summaryCode" ).toString( );
				}
				/* ERP 전송여부가 Y인 코드값 삭제 */
				int erpSendY = 0;
				int erpSendN = 0;
				for ( String summary : summaryCodes ) {
					Map<String, Object> deleteParams = new HashMap<String, Object>( );
					Map<String, Object> deleteResult = new HashMap<String, Object>( );
					for ( String temp : realSummaryCode ) {
						if ( !temp.equals( summary ) ) {
							erpSendY++;
							deleteParams.put( "compSeq", result.getParams( ).get( "compSeq" ) );
							deleteParams.put( "summaryDiv", result.getParams( ).get( "summaryDiv" ) );
							deleteParams.put( "summaryCode", summary );
							deleteResult.put( "erpSendYCount", erpSendY );
							deleteResult.put( "erpSendNCount", erpSendN );
							result.setaData( dao.setAdminSummaryDelete( deleteParams ) );
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

	/* 표준적요 조회 */
	public ResultVO setAdminSummarySelect ( ResultVO result ) throws Exception {
		try {
			boolean chkParameter = true;
			String[] parametersCheck = { "searchStr", "N", "useYN", "N" };
			if ( !MapUtil.hasParameters( result.getParams( ), parametersCheck ) ) {
				result.setFail( "필수 입력 정보가 누락되었습니다." );
				chkParameter = false;
			}
			if ( chkParameter ) {
				result.setaData( dao.setAdminSummarySelect( result.getParams( ) ) );
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

	public ResultVO setAdminSummaryListSelect ( ResultVO result ) throws Exception {
		try {
			boolean chkParameter = true;
			String[] parametersCheck = { "searchStr", "N", "useYN", "N" };
			if ( !MapUtil.hasParameters( result.getParams( ), parametersCheck ) ) {
				result.setFail( "필수 입력 정보가 누락되었습니다." );
				chkParameter = false;
			}
			if ( chkParameter ) {
				result.setAaData( dao.setAdminSummaryListSelect( result.getParams( ) ) );
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
}

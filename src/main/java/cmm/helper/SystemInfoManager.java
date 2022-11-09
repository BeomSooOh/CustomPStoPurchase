package cmm.helper;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;

import cmm.vo.ConnectionVO;
import common.vo.common.CommonInterface;
import neos.cmm.util.BizboxAProperties;


public class SystemInfoManager {

	/* 변수정의 */
	//private org.apache.logging.log4j.Logger LOG = LogManager.getLogger( this.getClass( ) );
	private final org.apache.logging.log4j.Logger LOG = LogManager.getLogger( SystemInfoManager.class );

	/* 커넥션 정보 조회 */
	/* 커넥션 정보 조회 - ERP */
	// 참고:https://commons.apache.org/proper/commons-lang/javadocs/api-2.6/org/apache/commons/lang/StringUtils.html#isEmpty(java.lang.String)
	// 참고:https://commons.apache.org/proper/commons-lang/javadocs/api-2.6/src-html/org/apache/commons/lang/StringUtils.html#line.170
	public ConnectionVO getSystemType ( Map<String, Object> param ) throws Exception {
		Map<String, Object> mParam = param;

		ConnectionVO connectionVo = new ConnectionVO( );
		connectionVo.setDatabaseType( BizboxAProperties.getProperty( "BizboxA.DbType" ) );
		connectionVo.setDriver( BizboxAProperties.getProperty( "BizboxA.DriverClassName" ) );
		connectionVo.setUrl( BizboxAProperties.getProperty( "BizboxA.Url" ) );
		connectionVo.setUserId( BizboxAProperties.getProperty( "BizboxA.UserName" ) );
		connectionVo.setPassWord( BizboxAProperties.getProperty( "BizboxA.Password" ) );
		connectionVo.setSystemType( CommonInterface.commonCode.BIZBOXA );
		//		SqlConnectionManager sqlMgr = new SqlConnectionManager(connectionVo, packagePath.commonSystem);
		Map<String, Object> result = new HashMap<String, Object>( );
		// String queryId = "ex.dao.common.system." + connectionVo.getDatabaseType( ) + ".getIfInfo_BizboxA";
		try {
			if ( result == null || result.size( ) < 1 ) {
				// ERP 연동이 없는 경우 데이터가 없을 수 있음.
				result.put( "databaseType", BizboxAProperties.getProperty( "BizboxA.DbType" ) );
				result.put( "driver", BizboxAProperties.getProperty( "BizboxA.DriverClassName" ) );
				result.put( "url", BizboxAProperties.getProperty( "BizboxA.Url" ) );
				result.put( "userId", BizboxAProperties.getProperty( "BizboxA.UserName" ) );
				result.put( "password", BizboxAProperties.getProperty( "BizboxA.Password" ) );
				result.put( "erpTypeCode", CommonInterface.commonCode.BIZBOXA );
			}
			else if ( StringUtils.isEmpty( (String) result.get( "erpTypeCode" ) ) ) {
				// ERP 연동값이 없는 경우
				result.put( "databaseType", BizboxAProperties.getProperty( "BizboxA.DbType" ) );
				result.put( "driver", BizboxAProperties.getProperty( "BizboxA.DriverClassName" ) );
				result.put( "url", BizboxAProperties.getProperty( "BizboxA.Url" ) );
				result.put( "userId", BizboxAProperties.getProperty( "BizboxA.UserName" ) );
				result.put( "password", BizboxAProperties.getProperty( "BizboxA.Password" ) );
				result.put( "erpTypeCode", CommonInterface.commonCode.BIZBOXA );
			}
			connectionVo.setDatabaseType( (String) result.get( "databaseType" ) );
			connectionVo.setDriver( (String) result.get( "driver" ) );
			connectionVo.setUrl( (String) result.get( "url" ) );
			connectionVo.setUserId( (String) result.get( "userId" ) );
			connectionVo.setPassWord( (String) result.get( "password" ) );
			connectionVo.setSystemType( (String) result.get( "erpTypeCode" ) );
		}
		catch ( Exception e ) {
			StringWriter sw = new StringWriter( );
			e.printStackTrace( new PrintWriter( sw ) );
			String exceptionAsStrting = sw.toString( );
			LOG.error( "! [EX] ERROR - " + exceptionAsStrting );
			e.printStackTrace( );
			throw e;
		}
		return connectionVo;
	}

	/* 커넥션 정보 조회 - BizboxA */
	public static ConnectionVO getSystemBizboxAType ( ) throws Exception {
		ConnectionVO connectionVo = new ConnectionVO( );
		try {
			connectionVo.setDatabaseType( BizboxAProperties.getProperty( "BizboxA.DbType" ) );
			connectionVo.setDriver( BizboxAProperties.getProperty( "BizboxA.DriverClassName" ) );
			connectionVo.setUrl( BizboxAProperties.getProperty( "BizboxA.Url" ) );
			connectionVo.setUserId( BizboxAProperties.getProperty( "BizboxA.UserName" ) );
			connectionVo.setPassWord( BizboxAProperties.getProperty( "BizboxA.Password" ) );
			connectionVo.setSystemType( CommonInterface.commonCode.BIZBOXA );
		}
		catch ( Exception e ) {
			StringWriter sw = new StringWriter( );
			e.printStackTrace( new PrintWriter( sw ) );
			String exceptionAsStrting = sw.toString( );
			// LOG.error("! [EX] ERROR - " + exceptionAsStrting);
			//System.out.println( "! [EX] ERROR - " + exceptionAsStrting );
			e.printStackTrace( );
			throw e;
		}
		return connectionVo;
	}

	public Map<String, Object> getSystemType ( String typeGbn, int formId ) {
		Map<String, Object> result = new HashMap<String, Object>( );
		String strTypeGbn = typeGbn;
		int iFormId = formId;

		return result;
	}
}

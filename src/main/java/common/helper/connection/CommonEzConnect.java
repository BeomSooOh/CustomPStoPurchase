package common.helper.connection;

import java.util.List;
import java.util.Map;

import common.helper.logger.CommonLogger;
import common.vo.common.CommonMapInterface.sqlMapPath;
import common.vo.common.ConnectionVO;



public class CommonEzConnect {

	/* 변수정의 */
	/* 변수정의 - Common */
	private final CommonLogger cmLog = new CommonLogger( );
	/* 변수정의 - class */
	private final CommonErpConnect connector = new CommonErpConnect( );

	/* SqlSessionFactory */
	/* SqlSessionFactory - Select */
	public Map<String, Object> Select ( ConnectionVO conVo, String queryId, Map<String, Object> params ) {
		cmLog.CommonSetInfo( "ex execute select >> " + queryId );
		try {
			return connector.Select( conVo, sqlMapPath.EZPATH, queryId, params );
		}
		catch ( Exception e ) {
			// TODO Auto-generated catch block
			e.printStackTrace( );
		}
		return null;
	}

	/* SqlSessionFactory - List */
	public List<Map<String, Object>> List ( ConnectionVO conVo, String queryId, Map<String, Object> params ) {
		cmLog.CommonSetInfo( "ex execute select >> " + queryId );
		try {
			return connector.List( conVo, sqlMapPath.EZPATH, queryId, params );
		}
		catch ( Exception e ) {
			// TODO Auto-generated catch block
			e.printStackTrace( );
		}
		return null;
	}

	/* SqlSessionFactory - Insert */
	public int Insert ( ConnectionVO conVo, String queryId, Map<String, Object> params ) {
		cmLog.CommonSetInfo( "ex execute insert >> " + queryId );
		try {
			return connector.Insert( conVo, sqlMapPath.EZPATH, queryId, params );
		}
		catch ( Exception e ) {
			// TODO Auto-generated catch block
			e.printStackTrace( );
		}
		return 0;
	}



	/* SqlSessionFactory - Update */
	public int Update ( ConnectionVO conVo, String queryId, Map<String, Object> params ) {
		cmLog.CommonSetInfo( "ex execute update >> " + queryId );
		try {
			return connector.Update( conVo, sqlMapPath.EZPATH, queryId, params );
		}
		catch ( Exception e ) {
			// TODO Auto-generated catch block
			e.printStackTrace( );
		}
		return 0;
	}
	/* SqlSessionFactory - Update */
	public int Update ( ConnectionVO conVo, String queryId, Map<String, Object> params, String storedProcedure ) {
		String stp = storedProcedure;
		cmLog.CommonSetInfo( "ex execute update >> " + queryId );
		try {
			return connector.Update( conVo, sqlMapPath.EZPATH, queryId, params, "SP");
		}
		catch ( Exception e ) {
			// TODO Auto-generated catch block
			e.printStackTrace( );
		}
		return 0;
	}



	/* SqlSessionFactory - Delete */
	public int Delete ( ConnectionVO conVo, String queryId, Map<String, Object> params ) {
		cmLog.CommonSetInfo( "ex execute delete >> " + queryId );
		try {
			return connector.Delete( conVo, sqlMapPath.EZPATH, queryId, params );
		}
		catch ( Exception e ) {
			// TODO Auto-generated catch block
			e.printStackTrace( );
		}
		return 0;
	}
}

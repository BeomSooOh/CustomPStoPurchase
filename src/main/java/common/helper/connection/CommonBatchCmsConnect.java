package common.helper.connection;

import java.util.List;
import java.util.Map;

import common.helper.logger.CommonLogger;
import common.vo.common.CommonMapInterface.sqlMapPath;
import common.vo.common.ConnectionVO;


public class CommonBatchCmsConnect {

	/* 변수정의 */
	/* 변수정의 - Common */
	private final CommonLogger cmLog = new CommonLogger( );
	/* 변수정의 - class */
	private final CommonErpConnect connector = new CommonErpConnect( );

	/* SqlSessionFactory */
	/* SqlSessionFactory - Select */
	public Map<String, Object> Select ( ConnectionVO conVo, String queryId, Map<String, Object> params ) throws Exception {
		cmLog.CommonSetInfo( "ex execute select >> " + queryId );
		return connector.Select( conVo, sqlMapPath.CMSPATH, queryId, params );
	}

	/* SqlSessionFactory - List */
	public List<Map<String, Object>> List ( ConnectionVO conVo, String queryId, Map<String, Object> params ) throws Exception {
		cmLog.CommonSetInfo( "ex execute select >> " + queryId );
		return connector.List( conVo, sqlMapPath.CMSPATH, queryId, params );
	}

	/* SqlSessionFactory - Insert */
	public int Insert ( ConnectionVO conVo, String queryId, Map<String, Object> params ) throws Exception {
		cmLog.CommonSetInfo( "ex execute select >> " + queryId );
		return connector.Insert( conVo, sqlMapPath.CMSPATH, queryId, params );
	}

	/* SqlSessionFactory - Update */
	public int Update ( ConnectionVO conVo, String queryId, Map<String, Object> params ) throws Exception {
		cmLog.CommonSetInfo( "ex execute select >> " + queryId );
		return connector.Update( conVo, sqlMapPath.CMSPATH, queryId, params );
	}

	/* SqlSessionFactory - Delete */
	public int Delete ( ConnectionVO conVo, String queryId, Map<String, Object> params ) throws Exception {
		cmLog.CommonSetInfo( "ex execute select >> " + queryId );
		return connector.Delete( conVo, sqlMapPath.CMSPATH, queryId, params );
	}
}

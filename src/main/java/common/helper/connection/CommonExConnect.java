package common.helper.connection;

import java.util.List;
import java.util.Map;

import common.helper.logger.CommonLogger;
import common.vo.common.CommonMapInterface.sqlMapPath;
import common.vo.ex.ExCodeETaxVO;
import common.vo.common.ConnectionVO;


public class CommonExConnect {

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
			return connector.Select( conVo, sqlMapPath.EXPATH, queryId, params );
		}
		catch ( Exception e ) {
			// TODO Auto-generated catch block
			e.printStackTrace( );
		}
		return null;
	}

	/* SqlSessionFactory - OutputSelect */
	public void OutputSelect ( ConnectionVO conVo, String queryId, Map<String, Object> params ) {
		cmLog.CommonSetInfo( "ex execute OutputSelect >> " + queryId );
		try {
			connector.OutputSelect( conVo, sqlMapPath.EXPATH, queryId, params );
		}
		catch ( Exception e ) {
			// TODO Auto-generated catch block
			e.printStackTrace( );
		}
	}

	/* SqlSessionFactory - List */
	public List<Map<String, Object>> List ( ConnectionVO conVo, String queryId, Map<String, Object> params ) {
		cmLog.CommonSetInfo( "ex execute select >> " + queryId );
		try {
			return connector.List( conVo, sqlMapPath.EXPATH, queryId, params );
		}
		catch ( Exception e ) {
			// TODO Auto-generated catch block
			e.printStackTrace( );
		}
		return null;
	}

	public List<ExCodeETaxVO> ETaxList ( ConnectionVO conVo, String queryId, Map<String, Object> params ) {
		cmLog.CommonSetInfo( "ex execute select >> " + queryId );
		try {
			return connector.ETaxList( conVo, sqlMapPath.EXPATH, queryId, params );
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
			return connector.Insert( conVo, sqlMapPath.EXPATH, queryId, params );
		}
		catch ( Exception e ) {
			// TODO Auto-generated catch block
			e.printStackTrace( );
		}
		return 0;
	}

	public int Insert ( ConnectionVO conVo, String queryId, Map<String, Object> params, String type ) {
	     cmLog.CommonSetInfo( "ex execute insert >> " + queryId );
        try {
            return connector.Insert( conVo, sqlMapPath.EXPATH, queryId, params, type );
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
			return connector.Update( conVo, sqlMapPath.EXPATH, queryId, params );
		}
		catch ( Exception e ) {
			// TODO Auto-generated catch block
			e.printStackTrace( );
		}
		return 0;
	}

	/* SqlSessionFactory - Update */
	public int ErpDocUpdate ( ConnectionVO conVo, String queryId, Map<String, Object> params ) {
		cmLog.CommonSetInfo( "ex execute update >> " + queryId );
		try {
			return connector.ErpDocUpdate( conVo, sqlMapPath.EXPATH, queryId, params );
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
			return connector.Delete( conVo, sqlMapPath.EXPATH, queryId, params );
		}
		catch ( Exception e ) {
			// TODO Auto-generated catch block
			e.printStackTrace( );
		}
		return 0;
	}
	/* oracle_yesil connection - list */
	/* [ERPiU - oracle] 예실대비현황 조회시, 필수 프로시저 호출 */
	public List<Map<String, Object>> yesilList_oracle ( ConnectionVO conVo, String queryId, Map<String, Object> params ) {
		cmLog.CommonSetInfo( "ex execute select >> " + queryId );
		try {
			return connector.yesilList_oracle( conVo, sqlMapPath.EXPATH, queryId, params );
		}
		catch ( Exception e ) {
			// TODO Auto-generated catch block
			e.printStackTrace( );
		}
		return null;
	}
}

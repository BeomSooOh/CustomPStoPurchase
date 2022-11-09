package cmm.helper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.logging.log4j.LogManager;

import cmm.vo.ConnectionVO;


public class SqlConnectionManager {

	/* 변수정의 */
	protected SqlSessionFactory sqlSessionFactory = null;
	//private org.apache.logging.log4j.Logger LOG = LogManager.getLogger( this.getClass( ) );
	private final org.apache.logging.log4j.Logger LOG = LogManager.getLogger( SqlConnectionManager.class );

	public SqlConnectionManager ( ConnectionVO conVo, String packagePath ) throws Exception {
		sqlSessionFactory = SqlSessionManager.getSqlSession( conVo, packagePath );
	}

	/* Connection manager - Select one */
	@SuppressWarnings ( "null" )
	public Map<String, Object> mapSelect ( String queryId, Map<String, Object> param ) throws Exception {
		SqlSession session = sqlSessionFactory.openSession( );
		Map<String, Object> result = new HashMap<String, Object>( );
		try {
			// LOG.debug("+ [OPEN] mapSelect queryId : " + queryId);
			if ( param != null && param.size( ) > 0 ) {
				// LOG.debug("mapSelect param : " + param);
				result = session.selectOne( queryId, param );
			}
			else if ( param == null && param.size( ) < 1 ) {
				// LOG.debug("mapSelect param : null");
				result = session.selectOne( queryId );
			}
			else {
				// LOG.debug("mapSelect else...");
				result = null;
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			LOG.error( "SqlConnectionManager Query Error.", e );
		}
		finally {
			session.close( );
			// LOG.debug("- [CLOSE] mapSelect queryId : " + queryId);
		}
		return result;
	}

	/* Connection manager - Select list */
	@SuppressWarnings ( "null" )
	public List<Map<String, Object>> listSelect ( String queryId, Map<String, Object> param ) throws Exception {
		SqlSession session = sqlSessionFactory.openSession( );
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			// LOG.debug("+ [OPEN] listSelect queryId : " + queryId);
			if ( param != null && param.size( ) > 0 ) {
				// LOG.debug("listSelect param : " + param);
				result = session.selectList( queryId, param );
			}
			else if ( param == null && param.size( ) < 1 ) {
				// LOG.debug("listSelect param : null");
				result = session.selectList( queryId );
			}
			else {
				// LOG.debug("listSelect else...");
				result = null;
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			LOG.error( "SqlConnectionManager Query Error.", e );
		}
		finally {
			session.close( );
			// LOG.debug("- [CLOSE] listSelect queryId : " + queryId);
		}
		return result;
	}

	/* Connection manager - Insert */
	public boolean mapInsert ( String queryId, Map<String, Object> param ) throws Exception {
		SqlSession session = sqlSessionFactory.openSession( );
		int result = 0;
		try {
			// LOG.debug("+ [OPEN] listSelect queryId : " + queryId);
			result = session.insert( queryId, param );
			session.commit( );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			LOG.error( "SqlConnectionManager Query Error.", e );
			session.rollback( );
		}
		finally {
			session.close( );
			// LOG.debug("- [CLOSE] listSelect queryId : " + queryId);
		}
		if ( result > 0 ) {
			return true;
		}
		else {
			return false;
		}
	}

	/* Connection manager - Update */
	public boolean mapUpdate ( String queryId, Map<String, Object> param ) throws Exception {
		SqlSession session = sqlSessionFactory.openSession( );
		int result = 0;
		try {
			// LOG.debug("+ [OPEN] listSelect queryId : " + queryId);
			result = session.update( queryId, param );
			session.commit( );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			LOG.error( "SqlConnectionManager Query Error.", e );
			session.rollback( );
		}
		finally {
			session.close( );
			// LOG.debug("- [CLOSE] listSelect queryId : " + queryId);
		}
		if ( result > 0 ) {
			return true;
		}
		else {
			return false;
		}
	}

	/* Connection manager - Delete */
	public boolean mapDelete ( String queryId, Map<String, Object> param ) throws Exception {
		SqlSession session = sqlSessionFactory.openSession( );
		boolean result = false;
		try {
			session.delete( queryId, param );
			session.commit( );
			result = true;
		}
		catch ( Exception e ) {
			// TODO: handle exception
			LOG.error( "SqlConnectionManager Query Error.", e );
			session.rollback( );
			result = false;
		}
		finally {
			session.close( );
			// LOG.debug("- [CLOSE] listSelect queryId : " + queryId);
		}
		return result;
	}
}

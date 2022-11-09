/**
  * @FileName : CommonAcConnect.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package common.helper.connection;

import java.util.List;
import java.util.Map;

import common.vo.common.CommonMapInterface.sqlMapPath;
import common.vo.common.ConnectionVO;


/**
 *   * @FileName : CommonAcConnect.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
public class CommonAcConnect {

	/* ################################################## */
	/* 변수정의 */
	/* ################################################## */
	/* 변수정의 - class */
	private final CommonErpConnect connector = new CommonErpConnect( );

	/* SqlSessionFactory */
	/* SqlSessionFactory - Select */
	public Map<String, Object> Select ( ConnectionVO conVo, String queryId, Map<String, Object> params ) {
		try {
			return connector.Select( conVo, sqlMapPath.ACPATH, queryId, params );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return null;
	}

	/* SqlSessionFactory - List */
	public List<Map<String, Object>> List ( ConnectionVO conVo, String queryId, Map<String, Object> params ) {
		try {
			return connector.List( conVo, sqlMapPath.ACPATH, queryId, params );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return null;
	}

	/* SqlSessionFactory - Insert */
	public int Insert ( ConnectionVO conVo, String queryId, Map<String, Object> params ) {
		try {
			return connector.Insert( conVo, sqlMapPath.ACPATH, queryId, params );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return 0;
	}

	/* SqlSessionFactory - Update */
	public int Update ( ConnectionVO conVo, String queryId, Map<String, Object> params ) {
		try {
			return connector.Update( conVo, sqlMapPath.ACPATH, queryId, params );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return 0;
	}

	/* SqlSessionFactory - Delete */
	public int Delete ( ConnectionVO conVo, String queryId, Map<String, Object> params ) {
		try {
			return connector.Delete( conVo, sqlMapPath.ACPATH, queryId, params );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return 0;
	}
}

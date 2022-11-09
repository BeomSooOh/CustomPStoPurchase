/**
  * @FileName : FAnguUserTblServiceADAO.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.angu.user.tbl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


/**
 *   * @FileName : FAnguUserTblServiceADAO.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Repository ( "FAnguUserTblServiceADAO" )
public class FAnguUserTblServiceADAO extends EgovComAbstractDAO {

	/* t_ex_anbojo >> TExAnbojo */
	/* t_ex_anbojo_abdocu_pay >> TExAnbojoAbdocuPay */
	/* t_ex_anbojo */
	public Map<String, Object> TblAction ( String tbl, String type, Map<String, Object> params ) throws Exception {
		try {
			String queryId = "AnguUserTable." + tbl + "." + type.substring( 0, 1 ).toUpperCase( ) + type.substring( 1 ).toLowerCase( );
			switch ( type.toUpperCase( ) ) {
				case "INSERT":
					params = this.ExecuteQueryInsert( queryId, params );
					break;
				case "UPDATE":
					params = this.ExecuteQueryUpdate( queryId, params );
					break;
				case "DELETE":
					params = this.ExecuteQueryDelete( queryId, params );
					break;
				case "SELECT":
					params = this.ExecuteQuerySelect( queryId, params );
					break;
				case "LIST":
					params = this.ExecuteQueryList( queryId, params );
					break;
				default :
					break;
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			params = null;
		}
		return params;
	}

	private Map<String, Object> ExecuteQueryInsert ( String queryId, Map<String, Object> params ) {
		try {
			this.insert( queryId, params );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			params = null;
		}
		return params;
	}

	private Map<String, Object> ExecuteQueryUpdate ( String queryId, Map<String, Object> params ) {
		try {
			int updateCount = 0;
			updateCount = this.update( queryId, params );
			params.put( "updateCount", updateCount );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			params = null;
		}
		return params;
	}

	private Map<String, Object> ExecuteQueryDelete ( String queryId, Map<String, Object> params ) {
		try {
			int deleteCount = 0;
			deleteCount = this.delete( queryId, params );
			params.put( "deleteCount", deleteCount );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			params = null;
		}
		return params;
	}

	@SuppressWarnings ( "unchecked" )
	private Map<String, Object> ExecuteQuerySelect ( String queryId, Map<String, Object> params ) {
		try {
			params = (Map<String, Object>) this.select( queryId, params );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			params = null;
		}
		return params;
	}

	@SuppressWarnings ( "unchecked" )
	private Map<String, Object> ExecuteQueryList ( String queryId, Map<String, Object> params ) {
		try {
			params.put( "aaData", (List<Map<String, Object>>) this.list( queryId, params ) );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			params = null;
		}
		return params;
	}
}

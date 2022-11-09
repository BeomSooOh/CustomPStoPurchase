package ac.cmm.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


/**
 * @title AcCommonDAO.java
 * @author doban7
 *
 * @date 2016. 9. 1.
 */
@Repository ( "AcCommonDAO" )
public class AcCommonDAO extends EgovComAbstractDAO {

	/**
	 * getExUtilSystemType doban7 2016. 9. 1.
	 * 
	 * @param param
	 * @return
	 */
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> acErpSystemInfo ( Map<String, Object> param ) {
		return (Map<String, Object>) select( "AcCommonDAO.acErpSystemInfo", param );
	}
}

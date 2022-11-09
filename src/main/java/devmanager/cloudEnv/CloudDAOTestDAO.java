package devmanager.cloudEnv;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "CloudDAOTestDAO" )
public class CloudDAOTestDAO extends EgovComAbstractDAO {

	/* ERP 사원정보 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<CloudDAOTestVO> getCloudVOSelect ( ) {
		List<CloudDAOTestVO> result = new ArrayList<CloudDAOTestVO>( );
		// CloudDAOTestVO testParam = new CloudDAOTestVO( );
		HashMap<String, Object> testParam = new HashMap<>( );
		testParam.put( "group_seq", "DEMO" );
		result = (List<CloudDAOTestVO>) list( "getCloudVOSelect", testParam );
		return result;
	}
}

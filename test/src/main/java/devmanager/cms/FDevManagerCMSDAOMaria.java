package devmanager.cms;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FDevManagerCMSDAOMaria" )
public class FDevManagerCMSDAOMaria extends EgovComAbstractDAO {

	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> SelectCMSLogList ( Map<String, Object> param ) throws Exception {
		List<Map<String, Object>> cmsListVo = new ArrayList<Map<String, Object>>( );
		cmsListVo = (List<Map<String, Object>>) this.list( "CMSInfoDAO.SelectCMSLog", param );
		return cmsListVo;
	}
}

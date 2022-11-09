package expend.np.admin.config;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;


@Service ( "FNpAdminConfigServiceA" )
public class FNpAdminConfigServiceAImpl implements FNpAdminConfigService {

	/* 변수정의 */
	/* 변수정의 - DAO */
	@Resource ( name = "FNpAdminConfigServiceADAO" )
	private FNpAdminConfigServiceADAO dao;

	
	public List<Map<String, Object>> NpOptionListSelect ( Map<String, Object> params ){
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = dao.NpOptionListSelect( params );
		return result;
	}
	
	public int NpOptionUpdate ( Map<String, Object> params ){
		return dao.NpOptionUpdate( params );
	}
	
	public List<Map<String, Object>> NpMasterOptionSelect ( Map<String, Object> params ){
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = dao.NpMasterOptionSelect( params );
		return result;
	}
	
	public int NpMasterOptionUpdate ( Map<String, Object> params ){
		return dao.NpMasterOptionUpdate( params );
	}
	
	public int NpMasterOptionCompConsAuthUpdate ( Map<String, Object> params ){
		return dao.NpMasterOptionCompConsAuthUpdate( params );
	}
	
	public int NpMasterOptionCompConsAuthDelete ( Map<String, Object> params ){
		return dao.NpMasterOptionCompConsAuthDelete( params );
	}
	
	public List<Map<String, Object>> NpMasterOptionCompConsAuthSelect ( Map<String, Object> params ){
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = dao.NpMasterOptionCompConsAuthSelect( params );
		return result;
	}
	
	public List<Map<String, Object>> NpFormOptionSelect ( Map<String, Object> params ){
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = dao.NpFormOptionSelect( params );
		return result;
	}
	
	public int NpFormOptionUpdate ( Map<String, Object> params ){
		return dao.NpFormOptionUpdate( params );
	}
}

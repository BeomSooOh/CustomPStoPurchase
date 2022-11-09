package expend.np.admin.config;

import java.util.List;
import java.util.Map;


public interface BNpAdminConfigService {

	List<Map<String, Object>> NpOptionListSelect ( Map<String, Object> params );

	int NpOptionUpdate ( Map<String, Object> params );

	List<Map<String, Object>> NpMasterOptionSelect ( Map<String, Object> params );

	int NpMasterOptionUpdate ( Map<String, Object> params );
	
	int NpMasterOptionCompConsAuthUpdate ( Map<String, Object> params );
	
	List<Map<String, Object>> NpMasterOptionCompConsAuthSelect ( Map<String, Object> params );
	
	List<Map<String, Object>> NpFormOptionSelect ( Map<String, Object> params );
	
	int NpFormOptionUpdate ( Map<String, Object> params );
	
	int NpMasterOptionCompConsAuthDelete ( Map<String, Object> params );
}

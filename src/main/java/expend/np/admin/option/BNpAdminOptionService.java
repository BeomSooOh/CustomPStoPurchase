package expend.np.admin.option;

import java.util.Map;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


public interface BNpAdminOptionService {

	ResultVO selectERPOption ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;

	ResultVO selectGWOption ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;
	
	ResultVO updateGWOption ( Map<String, Object> params, common.vo.common.ConnectionVO conVo ) throws Exception;
}

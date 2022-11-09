package expend.np.admin.option;

import java.util.Map;

import common.vo.common.ResultVO;


public interface FNpAdminOptionService {

	public ResultVO selectERPOption ( Map<String, Object> params, common.vo.common.ConnectionVO conVo ) throws Exception;

	public ResultVO selectGWOption ( Map<String, Object> params, common.vo.common.ConnectionVO conVo ) throws Exception;
	
	public ResultVO updateGWOption ( Map<String, Object> params, common.vo.common.ConnectionVO conVo ) throws Exception;
}

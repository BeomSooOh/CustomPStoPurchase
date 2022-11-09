package expend.np.user.option;

import java.util.Map;

import common.vo.common.ResultVO;


public interface FNpUserOptionService {

	public Map<String, Object> npTest ( Map<String, Object> params, common.vo.common.ConnectionVO conVo ) throws Exception;

	public ResultVO selectERPOption ( Map<String, Object> params, common.vo.common.ConnectionVO conVo ) throws Exception;

	public ResultVO selectGWOption ( Map<String, Object> params, common.vo.common.ConnectionVO conVo ) throws Exception;

	public ResultVO selectBaseData ( Map<String, Object> params, common.vo.common.ConnectionVO conVo ) throws Exception;

	public ResultVO selectVatCtrData ( Map<String, Object> params, common.vo.common.ConnectionVO conVo ) throws Exception;
	
	public ResultVO selectEaFormInfo ( Map<String, Object> params, common.vo.common.ConnectionVO conVo ) throws Exception;

	public ResultVO selectAbgtInfo ( Map<String, Object> params, common.vo.common.ConnectionVO conVo ) throws Exception;
	
	public ResultVO selectBasicOption ( Map<String, Object> params ) throws Exception;
}
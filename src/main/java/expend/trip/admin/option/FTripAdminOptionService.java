package expend.trip.admin.option;

import java.util.Map;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;

public interface FTripAdminOptionService {
	
	public ResultVO selectLocationOption ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;
	
	public ResultVO selectTransPortOption ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;

	public ResultVO insertTransPortOption(Map<String, Object> params, ConnectionVO conVo);

	public ResultVO updateTransPortOption(Map<String, Object> params, ConnectionVO conVo);

	public ResultVO deleteTransPortOption(Map<String, Object> params, ConnectionVO conVo);

	public ResultVO insertLocationOption(Map<String, Object> params, ConnectionVO conVo);

	public ResultVO updateLocationOption(Map<String, Object> params, ConnectionVO conVo);

	public ResultVO deleteLocationOption(Map<String, Object> params, ConnectionVO conVo);

	public ResultVO selectConsReportOption(Map<String, Object> params, ConnectionVO conVo) throws Exception;

	public ResultVO selectAmtOption(Map<String, Object> params, ConnectionVO conVo);

	public ResultVO insertAmtOption(Map<String, Object> params, ConnectionVO conVo);

	public ResultVO updateAmtOption(Map<String, Object> params, ConnectionVO conVo);

	public ResultVO deleteAmtOption(Map<String, Object> params, ConnectionVO conVo);

	public ResultVO selectPositionGroupOption(Map<String, Object> params, ConnectionVO conVo) throws Exception;

	public ResultVO selectPositionGroupItemOption(Map<String, Object> params, ConnectionVO conVo) throws Exception;

	public ResultVO deletePositionGroupOption(Map<String, Object> params, ConnectionVO conVo);

	//public ResultVO insertDutyGroupOption(Map<String, Object> params, ConnectionVO conVo);

	public ResultVO insertPositionGroupOption(Map<String, Object> params, ConnectionVO conVo);

	public ResultVO updatePositionGroupOption ( Map<String, Object> params, ConnectionVO conVo );

}

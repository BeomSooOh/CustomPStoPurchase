package expend.trip.admin.option;

import java.util.Map;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;

public interface BTripAdminOptionService {

	ResultVO selectLocationOption(Map<String, Object> params, ConnectionVO conVo);

//	ResultVO selectPositionGroupOption(Map<String, Object> params, ConnectionVO conVo);

	ResultVO selectTransportOption(Map<String, Object> params, ConnectionVO conVo);

	ResultVO insertTransportOption(Map<String, Object> params, ConnectionVO conVo);

	ResultVO updateTransportOption(Map<String, Object> params, ConnectionVO conVo);

	ResultVO deleteTransportOption(Map<String, Object> params, ConnectionVO conVo);

	ResultVO selectSettingOption(Map<String, Object> params, ConnectionVO conVo);

	ResultVO insertSettingOption(Map<String, Object> params, ConnectionVO conVo);

	ResultVO updateSettingOption(Map<String, Object> params, ConnectionVO conVo);

	ResultVO deleteSettingOption(Map<String, Object> params, ConnectionVO conVo);
	
	ResultVO selectConsReportOption(Map<String, Object> params, ConnectionVO conVo) throws Exception;
}

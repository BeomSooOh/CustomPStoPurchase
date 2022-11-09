package expend.np.user.code;

import java.util.Map;

import common.vo.common.ResultVO;

public interface BNpUserCodeService {
	ResultVO GetCommonCode(Map<String, Object> params);
	
	ResultVO GetTradeAdvInfo(Map<String, Object> params);
	
	ResultVO UpdateInterfaceInfo(Map<String, Object> params);
}
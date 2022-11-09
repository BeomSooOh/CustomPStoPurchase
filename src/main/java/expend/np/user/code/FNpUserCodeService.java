package expend.np.user.code;

import java.util.Map;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


public interface FNpUserCodeService {

	ResultVO GetCommonCode ( Map<String, Object> params, ConnectionVO conVo );
	
	ResultVO UpdateInterfaceInfo(Map<String, Object> params);
}

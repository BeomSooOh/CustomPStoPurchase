package expend.np.user.etax;

import java.util.Map;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;

public interface BNpUserETaxService {
	ResultVO SelectETaxList(ResultVO param, ConnectionVO conVo) throws Exception;

	ResultVO SelectSendETaxList(Map<String, Object> param) throws Exception;

	ResultVO NpUserETaxReflect(Map<String, Object> param) throws Exception;

	ResultVO GetETaxTransHistoryList(ResultVO param) throws Exception;

	/* ## ############################################# ## */
	/* 매입전자세금계산서 현황 및 기능 2차 구현 - 김상겸 */
	/* ## ############################################# ## */
	ResultVO GetETaxList(ResultVO param, ConnectionVO conVo) throws Exception;
}
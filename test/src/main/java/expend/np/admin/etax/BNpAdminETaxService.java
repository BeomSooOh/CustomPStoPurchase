package expend.np.admin.etax;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;

public interface BNpAdminETaxService {
	/**
	 * 매입전자세금계산서 목록 조회
	 * 
	 * @param param
	 * @param conVo
	 * @return
	 * @throws Exception
	 */
	ResultVO GetETaxList(ResultVO param, ConnectionVO conVo) throws Exception;
	
	ResultVO GetETaxTransHistoryList(ResultVO param) throws Exception;
}

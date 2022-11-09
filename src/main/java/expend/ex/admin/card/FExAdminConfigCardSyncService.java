package expend.ex.admin.card;

import java.util.Map;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


public interface FExAdminConfigCardSyncService {

	/* 주석없음 */
	ResultVO ExCodeCardInfoFromErpCopy ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;

	/* 주석없음 */
	ResultVO ExCodeCardListInfoSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;
}
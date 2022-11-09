package expend.trip.user.option;

import java.util.Map;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;

public interface BTripUserOptionService {
	ResultVO selectSettingOption(Map<String, Object> params, ConnectionVO conVo);
	
	/** 출장 옵션 정보 조회 - 출장지 */
	ResultVO selectOptionLocation( Map<String, Object> params );
	
	/** 출장 옵션 정보 조회 - 교통편 */
	ResultVO selectOptionTransport( Map<String, Object> params );
	
	/** 출장 옵션 정보 조회 - 금액 */
	ResultVO selectOptionAmt( Map<String, Object> params );

	ResultVO selectOptionDutyItem(Map<String, Object> params);
}
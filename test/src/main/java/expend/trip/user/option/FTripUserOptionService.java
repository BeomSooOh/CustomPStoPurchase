package expend.trip.user.option;

import java.util.Map;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;

public interface FTripUserOptionService {
	public ResultVO selectLocationOption ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;

	public ResultVO selectTransPortOption ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;


	/** 출장 옵션 정보 조회 - 출장지 */
	public ResultVO selectOptionLocation ( Map<String, Object> params ) throws Exception;

	/** 출장 옵션 정보 조회 - 교통편 */
	public ResultVO selectOptionTransport ( Map<String, Object> params ) throws Exception;

	/** 출장 옵션 정보 조회 - 금액 */
	public ResultVO selectOptionAmt( Map<String, Object> params ) throws Exception;

	public ResultVO selectOptionDutyItem(Map<String, Object> params) throws Exception;

}
package expend.np.user.cust;

import java.util.Map;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;

public interface BNpUserCustService {
	/**	[CUST 001] 
	 * 	ERPiU 회계단위-사업계획 연동 여부 확인
	 * */
	ResultVO CUST001NpUserCheckDivCdInclude ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;
}
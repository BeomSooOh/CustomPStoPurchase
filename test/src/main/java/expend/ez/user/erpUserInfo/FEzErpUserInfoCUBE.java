package expend.ez.user.erpUserInfo;

import java.util.Map;

import common.vo.common.ConnectionVO;

public interface FEzErpUserInfoCUBE {

	/* 이지바로 회계단위 가져오기 */
	public Map<String, Object> EzUnitInfoSelect(Map<String, Object> params, ConnectionVO conVo);
	
	/* 이지바로 사용자/부서 가져오기 */
	public Map<String, Object> EzDeptUserInfoSelect(Map<String, Object> params, ConnectionVO conVo);
	
	/* 이지바로 그룹웨어 상태값 업데이트 */
	public int EzErpGWStateUpdate(Map<String, Object> params, ConnectionVO conVo) throws Exception;
	
}

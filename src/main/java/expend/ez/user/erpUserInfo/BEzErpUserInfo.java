package expend.ez.user.erpUserInfo;

import java.util.Map;

public interface BEzErpUserInfo {

	/* 이지바로 회계단위 가져오기 */
	public Map<String, Object> EzUnitInfoSelect(Map<String, Object> param) throws Exception;
	
	/* 이지바로 사용자/부서 정보 가져오기 */
	public Map<String, Object> EzUserDeptInfoSelect(Map<String, Object> param) throws Exception;
	
	/* 이지바로 폼 정보 가져오기*/
	public Map<String,Object>EzFormInfoSelect(Map<String, Object> param) throws Exception;	
	
	/* 이지바로 그룹웨어 상태값 업데이트 */
	public int EzErpGWStateUpdate(Map<String, Object> param) throws Exception;
}

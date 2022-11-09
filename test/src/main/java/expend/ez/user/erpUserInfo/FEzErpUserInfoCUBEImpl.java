package expend.ez.user.erpUserInfo;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.logger.CommonLogger;
import common.vo.common.ConnectionVO;


@Service ( "FEzErpUserInfoCUBE" )
public class FEzErpUserInfoCUBEImpl implements FEzErpUserInfoCUBE {

	@Resource ( name = "FEzErpUserInfoCubeDAO" )
	private FEzErpUserInfoCubeDAO IUserDAO;
	/* 변수정의 - Class */
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );

	/* 이지바로 회계단위 가져오기 */
	public Map<String, Object> EzUnitInfoSelect(Map<String, Object> params, ConnectionVO conVo) {
		 Map<String, Object> returnMap = new HashMap<String,Object>();
		try {
			returnMap =  IUserDAO.EzUnitInfoSelect(params, conVo);
		} catch (Exception e) {
			cmLog.CommonSetError(e);
			e.printStackTrace();
		}
		return returnMap;
	}

	/* 이지바로 사용자/부서 가져오기 */
	@Override
	public Map<String, Object> EzDeptUserInfoSelect(Map<String, Object> params, ConnectionVO conVo) {
		 Map<String, Object> returnMap = new HashMap<String,Object>();
		try {
			returnMap =  IUserDAO.EzDeptUserInfoSelect(params, conVo);
		} catch (Exception e) {
			cmLog.CommonSetError(e);
			e.printStackTrace();
		}
		return returnMap;
	}

	/* 이지바로 erp 그룹웨어 상태값 업데이트 */
	@Override
	public int EzErpGWStateUpdate(Map<String, Object> params,ConnectionVO conVo) throws Exception {
		int resultValue = 0;
		try {
			resultValue =  IUserDAO.EzErpGWStateUpdate(params, conVo);
		} catch (Exception e) {
			cmLog.CommonSetError(e);
			e.printStackTrace();
		}
		return resultValue;
	}


}

package expend.ez.user.erpUserInfo;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import common.helper.connection.CommonEzConnect;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.ConnectionVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FEzErpUserInfoCubeDAO" )
public class FEzErpUserInfoCubeDAO extends EgovComAbstractDAO {

	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
	/* 변수정의 - Class */
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );
	/* 변수정의 - class */
	CommonEzConnect connector = new CommonEzConnect( );

	/* 회계단위 가져오기 */
	public Map<String, Object> EzUnitInfoSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>( );
		cmLog.CommonSetInfo( "+ [EX] FEzErpUserInfoCubeDAO - EzUnitInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> params >" + params.toString( ) );
		try {
			resultMap = connector.Select( conVo, "EziCUBESQL.GetEzBaroAcUnitInfo", params );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return resultMap;
	}

	/* 사용자/부서 가져오기 */
	public Map<String, Object> EzDeptUserInfoSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>( );
		cmLog.CommonSetInfo( "+ [EX] FEzErpUserInfoCubeDAO - EzDeptUserInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> params >" + params.toString( ) );
		try {
			resultMap = connector.Select( conVo, "EziCUBESQL.GetEzBaroDeptUserInfo", params );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return resultMap;
	}

	/* 전자결재 상태값 공유 - 종결 - iCUBE AN_NRNDEXECREQ GW_STATE UPDATE */
	public int EzErpGWStateUpdate ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] FEzErpUserInfoCubeDAO - EzErpGWStateUpdate" );
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> params >" + params.toString( ) );
		int result = 0;
		try {
			result = (int) connector.Update( conVo, "EziCUBESQL.EzbaroStatusInfoUpdate", params );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}
}

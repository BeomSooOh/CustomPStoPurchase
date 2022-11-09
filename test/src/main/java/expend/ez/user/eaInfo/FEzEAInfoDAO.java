package expend.ez.user.eaInfo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository ( "FEzEAInfoDAO" )
public class FEzEAInfoDAO extends EgovComAbstractDAO {
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */

	/* 변수정의 - Class */
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger();

	/* 이지바로 양식정보 가져오기 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> EzFormInfoSelect ( Map<String, Object> params ) {
		Map<String, Object> returnValue= new HashMap<String, Object>( );
		try {
			returnValue = (Map<String, Object>) select("EzGWSQL.EzFormInfoSelect", params);
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return returnValue;
	}

	/* 이지바로 비영리 양식정보 가져오기 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> EzFormEAInfoSelect ( Map<String, Object> params ) {
		Map<String, Object> returnValue= new HashMap<String, Object>( );
		try {
			returnValue = (Map<String, Object>) select("EzGWSQL.EzFormEAInfoSelect", params);
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return returnValue;
	}


	/* 이지바로 인터락 정보 가져오기 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> EzInterlockResolInfoSelect( Map<String, Object> params ) {
		Map<String, Object> returnValue= new HashMap<String, Object>( );
		try {
			returnValue = (Map<String, Object>) select("EzGWSQL.EzInterlockResolDataSelect", params);
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return returnValue;
	}


	/* 이지바로 품목상세 인터락 정보 가져오기 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> EzInspectInterlockPopDatailList( Map<String, Object> params ) {
		List<Map<String, Object>> returnList= new ArrayList<Map<String, Object>>( );
		try {
			returnList = (List<Map<String, Object>>) list("EzGWSQL.EzInterlockDetailListSelect", params);
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return returnList;
	}

	/* 이지바로 프라이머리 키 정보 가져오기 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> EzErpPrimaryKeyListSelect( Map<String, Object> params ) {
		List<Map<String, Object>> returnList= new ArrayList<Map<String, Object>>( );
		try {
			returnList = (List<Map<String, Object>>) list("EzGWSQL.EzErpPrimaryKeyListSelect", params);
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return returnList;
	}

	/* 이지바로 기존 작성한 마스터 정보 가져오기 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> EzMasterInfoSelect( Map<String, Object> params ) {
		Map<String, Object> resultMap= new HashMap<String, Object>( );
		try {
			resultMap = (Map<String, Object>) select("EzGWSQL.EzMasterInfoSelect", params);
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return resultMap;
	}

	/* 이지바로 기존 작성한 erp 마스터 정보 가져오기 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> EzErpMasterInfoSelect( Map<String, Object> params ) {
		List<Map<String, Object>> returnList= new ArrayList<Map<String, Object>>( );
		try {
			returnList = (List<Map<String, Object>>) list("EzGWSQL.EzErpMasterInfoSelect", params);
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return returnList;
	}

	/* 이지바로 기존 작성한 erp 슬레이브 정보 가져오기 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> EzErpSlaveListInfoSelect( Map<String, Object> params ) {
		List<Map<String, Object>> returnList= new ArrayList<Map<String, Object>>( );
		try {
			returnList = (List<Map<String, Object>>) list("EzGWSQL.EzErpSlaveListInfoSelect", params);
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return returnList;
	}

	/* 이지바로 기존 작성한 gw 마스터 정보 가져오기 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> EzGwMasterInfoSelect( Map<String, Object> params ) {
		List<Map<String, Object>> returnList= new ArrayList<Map<String, Object>>( );
		try {
			returnList = (List<Map<String, Object>>) list("EzGWSQL.EzGwMasterInfoSelect", params);
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return returnList;
	}

	/* 이지바로 기존 작성한 gw 슬레이브 정보 가져오기 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> EzGwSlaveListInfoSelect( Map<String, Object> params ) {
		List<Map<String, Object>> returnList= new ArrayList<Map<String, Object>>( );
		try {
			returnList = (List<Map<String, Object>>) list("EzGWSQL.EzGwSlaveListInfoSelect", params);
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return returnList;
	}

	/* 이지바로 기존 작성한 코드파라메터 정보 가져오기 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> EzCodeParamListInfoSelect( Map<String, Object> params ) {
		List<Map<String, Object>> returnList= new ArrayList<Map<String, Object>>( );
		try {
			returnList = (List<Map<String, Object>>) list("EzGWSQL.EzCodeParamListInfoSelect", params);
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return returnList;
	}


}

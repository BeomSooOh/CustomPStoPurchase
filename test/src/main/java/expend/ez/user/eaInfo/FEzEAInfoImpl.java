package expend.ez.user.eaInfo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.logger.CommonLogger;


@Service ( "FEzEAInfo" )
public class FEzEAInfoImpl implements FEzEAInfo {

	@Resource ( name = "FEzEAInfoDAO" )
	private FEzEAInfoDAO eaDAO;
	/* 변수정의 - Class */
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );

	@Override
	public Map<String, Object> EzFormInfoSelect ( Map<String, Object> param ) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>( );
		try {
			resultMap = eaDAO.EzFormInfoSelect( param );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			e.printStackTrace( );
		}
		return resultMap;
	}

	@Override
	public Map<String, Object> EzInterlockResolInfoSelect ( Map<String, Object> param ) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>( );
		try {
			resultMap = eaDAO.EzInterlockResolInfoSelect( param );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			e.printStackTrace( );
		}
		return resultMap;
	}

	@Override
	public List<Map<String, Object>> EzInspectInterlockPopDatailList ( Map<String, Object> param ) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>( );
		try {
			resultList = eaDAO.EzInspectInterlockPopDatailList( param );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			e.printStackTrace( );
		}
		return resultList;
	}

	@Override
	public List<Map<String, Object>> EzErpPrimaryKeyListSelect ( Map<String, Object> param ) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>( );
		try {
			resultList = eaDAO.EzErpPrimaryKeyListSelect( param );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			e.printStackTrace( );
		}
		return resultList;
	}

	@Override
	public Map<String, Object> EzFormEAInfoSelect ( Map<String, Object> param ) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>( );
		try {
			resultMap = eaDAO.EzFormEAInfoSelect( param );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			e.printStackTrace( );
		}
		return resultMap;
	}

	@Override
	public Map<String, Object> EzMasterInfoSelect ( Map<String, Object> param ) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>( );
		try {
			resultMap = (Map<String, Object>) eaDAO.EzMasterInfoSelect( param );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			e.printStackTrace( );
		}
		return resultMap;
	}

	@Override
	public List<Map<String, Object>> EzErpMasterInfoSelect ( Map<String, Object> param ) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>( );
		try {
			resultList = (List<Map<String, Object>>) eaDAO.EzErpMasterInfoSelect( param );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			e.printStackTrace( );
		}
		return resultList;
	}

	@Override
	public List<Map<String, Object>> EzErpSlaveListInfoSelect ( Map<String, Object> param ) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>( );
		try {
			resultList = eaDAO.EzErpSlaveListInfoSelect( param );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			e.printStackTrace( );
		}
		return resultList;
	}

	@Override
	public List<Map<String, Object>> EzGwMasterInfoSelect ( Map<String, Object> param ) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>( );
		try {
			resultList = (List<Map<String, Object>>) eaDAO.EzGwMasterInfoSelect( param );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			e.printStackTrace( );
		}
		return resultList;
	}

	@Override
	public List<Map<String, Object>> EzGwSlaveListInfoSelect ( Map<String, Object> param ) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>( );
		try {
			resultList = eaDAO.EzGwSlaveListInfoSelect( param );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			e.printStackTrace( );
		}
		return resultList;
	}

	@Override
	public List<Map<String, Object>> EzCodeParamListInfoSelect ( Map<String, Object> param ) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>( );
		try {
			resultList = eaDAO.EzCodeParamListInfoSelect( param );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			e.printStackTrace( );
		}
		return resultList;
	}
}

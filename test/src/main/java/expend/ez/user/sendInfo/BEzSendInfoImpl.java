package expend.ez.user.sendInfo;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import expend.ez.common.EzCommon;


@Service ( "BEzErpSendInfo" )
public class BEzSendInfoImpl implements BEzSendInfo {

	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
	@Resource ( name = "EzCommon" )
	private EzCommon ezCmm; /* 이지바로 ERP 연결 관리 */
	@Resource ( name = "FEzSendInfoCUBE" )
	private FEzSendInfoCUBE ezSendCube; /* 이지바로 큐브 */
	@Resource ( name = "FEzSendInfoGW" )
	private FEzSendInfoGW ezSaveGw; /* 이지바로 GW */

	public Map<String, Object> EzHReqInsert ( Map<String, Object> map ) throws Exception {
		//리턴 변수
		Map<String, Object> result = new HashMap<String, Object>( );
		cmLog.CommonSetInfo( "ENTER -- EZBARO EzHReqInsert " );
		try {
			ConnectionVO conVo = ezCmm.EzCommonGetErpType( );
			switch ( conVo.getErpTypeCode( ) ) {
				case commonCode.ERPIU:
					break;
				case commonCode.ICUBE:
					result = ezSendCube.EzHReqInsert( map, conVo );
					break;
				default:
					cmLog.CommonSetInfo( "이지바로 EzHReqInsert: ERP 연결설정 중 erpCode가 없습니다." );
					break;
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}

	@Override
	public Map<String, Object> EzHReqDetailInsert ( Map<String, Object> map ) throws Exception {
		//리턴 변수
		Map<String, Object> result = new HashMap<String, Object>( );
		cmLog.CommonSetInfo( "ENTER -- EZBARO EzHReqDetailInsert " );
		try {
			ConnectionVO conVo = ezCmm.EzCommonGetErpType( );
			switch ( conVo.getErpTypeCode( ) ) {
				case commonCode.ERPIU:
					break;
				case commonCode.ICUBE:
					result = ezSendCube.EzHReqDetailInsert( map, conVo );
					break;
				default:
					cmLog.CommonSetInfo( "이지바로 EzHReqInsert: ERP 연결설정 중 erpCode가 없습니다." );
					break;
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}

	@Override
	public Map<String, Object> EzMasterInfoInsert ( Map<String, Object> map ) throws Exception {
		//리턴 변수
		Map<String, Object> result = new HashMap<String, Object>( );
		cmLog.CommonSetInfo( "ENTER -- EZBARO EzMasterInfoInsert " );
		try {
			ConnectionVO conVo = ezCmm.EzCommonGetErpType( );
			switch ( conVo.getErpTypeCode( ) ) {
				case commonCode.ERPIU:
				case commonCode.ICUBE:
					result = ezSaveGw.EzMasterInfoInsert( map );
					break;
				default:
					cmLog.CommonSetInfo( "이지바로 EzMasterInfoInsert: ERP 연결설정 중 erpCode가 없습니다." );
					break;
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}

	@Override
	public Map<String, Object> EzErpMasterInsert ( Map<String, Object> map ) throws Exception {
		//리턴 변수
		Map<String, Object> result = new HashMap<String, Object>( );
		cmLog.CommonSetInfo( "ENTER -- EZBARO EzErpMasterInsert " );
		try {
			ConnectionVO conVo = ezCmm.EzCommonGetErpType( );
			switch ( conVo.getErpTypeCode( ) ) {
				case commonCode.ERPIU:
					break;
				case commonCode.ICUBE:
					result = ezSaveGw.EzErpMasterInsert( map );
					break;
				default:
					cmLog.CommonSetInfo( "이지바로 EzErpMasterInsert: ERP 연결설정 중 erpCode가 없습니다." );
					break;
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}

	@Override
	public Map<String, Object> EzErpSlaveInsert ( Map<String, Object> map ) throws Exception {
		//리턴 변수
		Map<String, Object> result = new HashMap<String, Object>( );
		cmLog.CommonSetInfo( "ENTER -- EZBARO EzErpSlaveInsert " );
		try {
			ConnectionVO conVo = ezCmm.EzCommonGetErpType( );
			switch ( conVo.getErpTypeCode( ) ) {
				case commonCode.ERPIU:
					break;
				case commonCode.ICUBE:
					result = ezSaveGw.EzErpSlaveInsert( map );
					break;
				default:
					cmLog.CommonSetInfo( "이지바로 EzErpSlaveInsert: ERP 연결설정 중 erpCode가 없습니다." );
					break;
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}

	@Override
	public Map<String, Object> EzGwParamsInsert ( Map<String, Object> map ) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>( );
		cmLog.CommonSetInfo( "ENTER -- EZBARO EzGwParamsInsert " );
		try {
			ConnectionVO conVo = ezCmm.EzCommonGetErpType( );
			switch ( conVo.getErpTypeCode( ) ) {
				case commonCode.ERPIU:
					break;
				case commonCode.ICUBE:
					result = ezSaveGw.EzGwParamsInsert( map );
					break;
				default:
					cmLog.CommonSetInfo( "이지바로 EzGwParamsInsert: ERP 연결설정 중 erpCode가 없습니다." );
					break;
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}

	@Override
	public Map<String, Object> EzGwMasterInsert ( Map<String, Object> map ) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>( );
		cmLog.CommonSetInfo( "ENTER -- EZBARO EzGwMasterInsert " );
		try {
			ConnectionVO conVo = ezCmm.EzCommonGetErpType( );
			switch ( conVo.getErpTypeCode( ) ) {
				case commonCode.ERPIU:
				case commonCode.ICUBE:
					result = ezSaveGw.EzGwMasterInsert( map );
					break;
				default:
					cmLog.CommonSetInfo( "이지바로 EzGwMasterInsert: ERP 연결설정 중 erpCode가 없습니다." );
					break;
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}

	@Override
	public Map<String, Object> EzGwSlaveInsert ( Map<String, Object> map ) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>( );
		cmLog.CommonSetInfo( "ENTER -- EZBARO EzGwSlaveInsert " );
		try {
			ConnectionVO conVo = ezCmm.EzCommonGetErpType( );
			switch ( conVo.getErpTypeCode( ) ) {
				case commonCode.ERPIU:
				case commonCode.ICUBE:
					result = ezSaveGw.EzGwSlaveInsert( map );
					break;
				default:
					cmLog.CommonSetInfo( "이지바로 EzGwSlaveInsert: ERP 연결설정 중 erpCode가 없습니다." );
					break;
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}
}

package expend.ez.user.erpUserInfo;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import expend.ez.common.EzCommon;


@Service ( "BEzErpUserInfo" )
public class BEzErpUserInfoImpl implements BEzErpUserInfo {

	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
	@Resource ( name = "EzCommon" )
	private EzCommon ezCmm; /* 이지바로 ERP 연결 관리 */
	@Resource ( name = "FEzErpUserInfoCUBE" )
	private FEzErpUserInfoCUBE ezUserCube; /* 이지바로 사용자정보 */

	/* 이지바로 회계단위 정보 가져오기 */
	public Map<String, Object> EzUnitInfoSelect ( Map<String, Object> param ) throws Exception {
		//리턴 변수
		Map<String, Object> resultMap = new HashMap<String, Object>( );
		cmLog.CommonSetInfo( "이지바로 회계단위 정보 가져오기 진입" );
		try {
			ConnectionVO conVo = ezCmm.EzCommonGetErpType( );
			switch ( conVo.getErpTypeCode( ) ) {
				case commonCode.ERPIU:
					break;
				case commonCode.ICUBE:
					param.put( "CO_CD", conVo.getErpCompSeq( ) );
					resultMap = ezUserCube.EzUnitInfoSelect( param, conVo );
					break;
				default:
					cmLog.CommonSetInfo( "이지바로 회계단위 정보 가져오기: ERP 연결설정 중 erpCode가 없습니다." );
					break;
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return resultMap;
	}

	/* 이지바로 사용자/부서 정보 가져오기 */
	@Override
	public Map<String, Object> EzUserDeptInfoSelect ( Map<String, Object> param ) throws Exception {
		//리턴 변수
		Map<String, Object> resultMap = new HashMap<String, Object>( );
		cmLog.CommonSetInfo( "이지바로  사용자/부서 정보 정보 가져오기 진입" );
		try {
			ConnectionVO conVo = ezCmm.EzCommonGetErpType( );
			LoginVO loginVo = ezCmm.EzCommonGetLoginVO( );
			switch ( conVo.getErpTypeCode( ) ) {
				case commonCode.ERPIU:
					break;
				case commonCode.ICUBE:
					param.put( "CO_CD", conVo.getErpCompSeq( ) );
					param.put( "EMP_CD", loginVo.getErpEmpCd( ) );
					resultMap = ezUserCube.EzDeptUserInfoSelect( param, conVo );
					break;
				default:
					cmLog.CommonSetInfo( "이지바로 회계단위 정보 가져오기: ERP 연결설정 중 erpCode가 없습니다." );
					break;
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return resultMap;
	}

	@Override
	public Map<String, Object> EzFormInfoSelect ( Map<String, Object> param ) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int EzErpGWStateUpdate ( Map<String, Object> param ) throws Exception {
		//리턴 변수
		int resultValue = 0;
		ConnectionVO conVo = null;
		cmLog.CommonSetInfo( "이지바로 그룹웨어 업데이트 정보 가져오기 진입" );
		try {
			/* 외부연동시 loignVO 생성이 불가하므로 compSeq를 활용한다. */
			if ( ezCmm.EzCommonGetLoginVO( ) == null ) {
				conVo = ezCmm.EzCommonGetErpType( param );
			}
			else {
				conVo = ezCmm.EzCommonGetErpType( );
			}
			conVo = ezCmm.EzCommonGetErpType( param );
			switch ( conVo.getErpTypeCode( ) ) {
				case commonCode.ERPIU:
					break;
				case commonCode.ICUBE:
					resultValue = ezUserCube.EzErpGWStateUpdate( param, conVo );
					break;
				default:
					cmLog.CommonSetInfo( "이지바로 회계단위 정보 가져오기: ERP 연결설정 중 erpCode가 없습니다." );
					break;
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return resultValue;
	}
}

package expend.bi.admin.car;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cmm.util.MapUtil;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


@Service ( "FBiAdminCarServiceI" )
public class FBiAdminCarServiceIImpl implements FBiAdminCarService {

	@Resource ( name = "FBiAdminCarServiceIDAO" )
	private FBiAdminCarServiceIDAO daoi;

	/**
	 * 함수명 : BiAdminCarInfoListSelect
	 * 함수설명 : ERP - iCUBE 차량 정보 조회
	 * 생성일자 : 2017. 9. 1.
	 *
	 * @param param
	 *            erpCompSeq, carCd(선택/검색)
	 * @return ResultVO
	 */
	public ResultVO BiAdminCarInfoListSelect ( ResultVO param, ConnectionVO conVo ) throws Exception {
		/* 기본 파라미터 수신 확인 필요 */
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			/* searchStr */
			if ( !(MapUtil.hasKey( param.getParams( ), "searchStr" )) ) {
				chkParameter = false;
				param.setResultCode( commonCode.FAIL );
				param.setResultName( "필수 파라미터 searchStr이 수신되지 않았습니다." );
			}
			else if ( !(MapUtil.hasKey( param.getParams( ), commonCode.USEYN )) ) {
				chkParameter = false;
				param.setResultCode( commonCode.FAIL );
				param.setResultName( "필수 파라미터 " + commonCode.USEYN + "이 수신되지 않았습니다." );
			}
			if ( chkParameter ) {
				param.setAaData( daoi.BiAdminCarInfoListSelect( param, conVo ) );
				if ( param.getAaData( ) != null ) {
					param.setSuccess( );
				}
				else {
					param.setFail( "" );
				}
			}
			else {
				param.setAaData( null );
				param.setFail( "" );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			param.setAaData( null );
			param.setFail( "" );
		}
		return param;
	}

	/**
	 * 함수명 : BiAdminCarInfoSync
	 * 함수설명 : iCUBE 차량정보 동기화
	 * 생성일자 : 2017. 9. 1.
	 *
	 * @param param
	 *            erpCompSeq
	 * @return ResultVO
	 */
	@Override
	public ResultVO BiAdminCarInfoSync ( ResultVO param, ConnectionVO conVo ) throws Exception {
		return param;
	}
}
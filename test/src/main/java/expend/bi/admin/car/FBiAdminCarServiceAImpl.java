package expend.bi.admin.car;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


@Service ( "FBiAdminCarServiceA" )
public class FBiAdminCarServiceAImpl implements FBiAdminCarService {

	@Resource ( name = "FBiAdminCarServiceADAO" )
	private FBiAdminCarServiceADAO daoA;
	@Resource ( name = "FBiAdminCarServiceIDAO" )
	private FBiAdminCarServiceIDAO daoI;

	/**
	 * 함수명 : BiAdminCarInfoListSelect
	 * 함수설명 : 차량 정보 조회
	 * 생성일자 : 2017. 9. 1.
	 *
	 * @param param
	 *            compSeq, carCode(선택/검색)
	 * @return ResultVO
	 */
	@Override
	public ResultVO BiAdminCarInfoListSelect ( ResultVO param, ConnectionVO conVo ) throws Exception {
		param.setAaData( daoA.BiAdminCarInfoListSelect( param ) );
		return param;
	}

	/**
	 * 함수명 : BiAdminCarInfoSync
	 * 함수설명 : iCUBE 차량정보 동기화
	 * 생성일자 : 2017. 9. 1.
	 *
	 * @param param
	 *            compSeq, erpCompSeq
	 * @return ResultVO
	 */
	public ResultVO BiAdminCarInfoSync ( ResultVO param, ConnectionVO conVo ) throws Exception {
		/* GW 차량정보 삭제 */
		daoA.BiAdminCarListDelete( param );
		if ( param.getResultCode( ).equals( commonCode.EMPTYYES ) ) {
			/* ERP 차량정보 조회 */
			daoI.BiAdminCarInfoListSelect( param, conVo );
			if ( param.getResultCode( ).equals( commonCode.EMPTYYES ) ) {
				/* GW 차량정보 등록 */
				for ( Map<String, Object> result : param.getAaData( ) ) {
					result.putAll( param.getParams( ) );
					/* 로그인 정보 저장 */
					@SuppressWarnings ( "unused" )
					LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
					ResultVO tResult = new ResultVO( );
					tResult.setParams( result );
					daoA.BiAdminCarListInsert( tResult );
				}
			}
		}
		return param;
	}
}
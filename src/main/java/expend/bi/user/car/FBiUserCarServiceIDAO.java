package expend.bi.user.car;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import common.helper.connection.CommonBiConnect;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FBiUserCarServiceIDAO" )
public class FBiUserCarServiceIDAO extends EgovComAbstractDAO {

	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */
	
	/* 변수정의 - class */
	CommonBiConnect connector = new CommonBiConnect( );

	/* ## iCUBE 코드 조회 ## */
	/* ## iCUBE 코드 조회 ## - 차량 */
	public List<Map<String, Object>> BiUserCarListInfoSelect ( Map<String, Object> param, ConnectionVO conVo ) throws Exception {
		/* iCUBE : exec USP_SYP0020_CAR_HELP_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DIV_CD=N'1000|',@EMP_CD=N'2000' */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			result = connector.List( conVo, "USP_SYP0020_CAR_HELP_SELECT", param );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result = new ArrayList<Map<String, Object>>( );
		}
		return result;
	}
	/* ## iCUBE 코드 조회 ## - 운행내역 */
	/* ## iCUBE 코드 조회 ## - 마지막 주행 거리 */
	/* ## iCUBE 코드 조회 ## - 북마트 정보 */
	/* ## iCUBE 코드 조회 ## - 즐겨찾기 정보 */
	/* ## iCUBE 코드 조회 ## - 휴일 정보 */
	/* ## iCUBE 코드 조회 ## - 거래처 정보 */
	/* ## iCUBE 코드 조회 ## - 거래처 주소 정보 */

	/**
	 * 함수명 : BiUserCarPersonSend
	 * 함수설명 : iCUBE 운행기록현황 데이터 insert 및 키 조회
	 * 생성일자 : 2017. 8. 31.
	 * 
	 * @param param
	 *            CO_CD, DIV_CD, CAR_CD, USE_DT
	 * @return ResultVO
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO BiUserCarPersonSend ( ResultVO param ) throws Exception {
		try {
			param.setaData( (Map<String, Object>) this.select( "BiUserCarPersonSend", param.getParams( ) ) );
		}
		catch ( Exception e ) {
			param.setResultCode( commonCode.EMPTYNO );
			param.setResultName( e.getMessage( ) );
		}
		return param;
	}

	/**
	 * 함수명 : BiUserCarPersonCancel
	 * 함수설명 : iCUBE 운행기록현황 데이터 삭제
	 * 생성일자 : 2017. 8. 31.
	 * 
	 * @param param
	 *            erpCompSeq, erpDivSeq, carCd, useDt, seqNb
	 * @return ResultVO
	 */
	public ResultVO BiUserCarPersonCancel ( ResultVO param ) throws Exception {
		try {
			this.delete( "BiUserCarPersonCancel", param.getParams( ) );
			param.setResultCode( commonCode.EMPTYYES );
		}
		catch ( Exception e ) {
			param.setResultCode( commonCode.EMPTYNO );
			param.setResultName( e.getMessage( ) );
		}
		return param;
	}
}

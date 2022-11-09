package expend.bi.user.code;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import common.helper.connection.CommonBiConnect;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FBiUserCodeServiceIDAO" )
public class FBiUserCodeServiceIDAO extends EgovComAbstractDAO {

	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */
	
	/* 변수정의 - class */
	CommonBiConnect connector = new CommonBiConnect( );

	/**
	 * 함수명 : BiUserCodeDivSelect
	 * 함수설명 : iCUBE 사업장(회계단위) 조회
	 * 생성일자 : 2017. 8. 31.
	 * 
	 * @param param
	 *            erpCompSeq, langCode, codeType, searchDate, searchStr
	 * @return ResultVO
	 */
	ResultVO BiUserCodeDivSelect ( ResultVO param, ConnectionVO conVo ) throws Exception {
		try {
			param.setAaData( connector.List( conVo, "BiUserCodeDivSelect", param.getParams( ) ) );
			param.setResultCode( commonCode.EMPTYYES );
		}
		catch ( Exception e ) {
			param.setResultCode( commonCode.EMPTYNO );
			param.setResultName( e.getMessage( ) );
		}
		return param;
	}

	/**
	 * 함수명 : BiUserCodeDeptSelect
	 * 함수설명 : iCUBE 부서 조회
	 * 생성일자 : 2017. 8. 31.
	 * 
	 * @param param
	 *            erpCompSeq, langCode, codeType, searchDate, searchStr
	 * @return ResultVO
	 */
	ResultVO BiUserCodeDeptSelect ( ResultVO param, ConnectionVO conVo ) throws Exception {
		try {
			param.setAaData( connector.List( conVo, "BiUserCodeDeptSelect", param.getParams( ) ) );
			param.setResultCode( commonCode.EMPTYYES );
		}
		catch ( Exception e ) {
			param.setResultCode( commonCode.EMPTYNO );
			param.setResultName( e.getMessage( ) );
		}
		return param;
	}

	/**
	 * 함수명 : BiUserCodeEmpSelect
	 * 함수설명 : iCUBE 사원 조회
	 * 생성일자 : 2017. 8. 31.
	 * 
	 * @param param
	 *            erpCompSeq, langCode, codeType, searchDate, searchStr
	 * @return ResultVO
	 */
	ResultVO BiUserCodeEmpSelect ( ResultVO param, ConnectionVO conVo ) throws Exception {
		try {
			param.setAaData( connector.List( conVo, "BiUserCodeEmpSelect", param.getParams( ) ) );
			param.setResultCode( commonCode.EMPTYYES );
		}
		catch ( Exception e ) {
			param.setResultCode( commonCode.EMPTYNO );
			param.setResultName( e.getMessage( ) );
		}
		return param;
	}

	/**
	 * 함수명 : BiUserCodeCarSelect
	 * 함수설명 : iCUBE 차량 조회
	 * 생성일자 : 2017. 8. 31.
	 * 
	 * @param param
	 *            langCode, erpCoCd, erpBizCd(뒤에 '|'기호 추가 필요), erpEmpCd, erpDeptCd
	 * @return ResultVO
	 */
	ResultVO BiUserCodeCarSelect ( ResultVO param, ConnectionVO conVo ) throws Exception {
		try {
			param.setAaData( connector.List( conVo, "BiUserCodeCarSelect", param.getParams( ) ) );
			param.setResultCode( commonCode.EMPTYYES );
		}
		catch ( Exception e ) {
			param.setResultCode( commonCode.EMPTYNO );
			param.setResultName( e.getMessage( ) );
		}
		return param;
	}
}

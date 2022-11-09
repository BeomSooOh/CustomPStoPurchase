package expend.bi.user.code;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


public interface BBiUserCodeService {

	/**
	 * 함수명 : BiUserCarCommonCode
	 * 함수설명 : 사용자 - 공통코드 조회
	 * 생성일자 : 2017. 8. 31.
	 * 
	 * @param param
	 *            erpCompSeq, langCode, codeType, searchDate, searchStr
	 * @return ResultVO
	 */
	ResultVO BiUserCarCommonCode ( ResultVO param, ConnectionVO conVo ) throws Exception;
}

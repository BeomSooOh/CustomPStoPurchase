package expend.ex2.admin.auth;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


public interface FEx2AdminAuthService {

	/* 증빙 유형 생성 */
	ResultVO setAdminAuthInsert ( ResultVO result ) throws Exception;

	/* 증빙 유형 수정 */
	ResultVO setAdminAuthUpdate ( ResultVO result ) throws Exception;

	/* 증빙 유형 삭제 */
	ResultVO setAdminAuthDelete ( ResultVO result ) throws Exception;

	/* 증빙 유형 조회 */
	ResultVO setAdminAuthSelect ( ResultVO result ) throws Exception;

	/* 증빙 유형 자동 조회 */
	ResultVO setAdminAutoSelect ( ResultVO result, ConnectionVO conVo ) throws Exception;

	ResultVO setAdminAuthListSelect ( ResultVO result ) throws Exception;
}

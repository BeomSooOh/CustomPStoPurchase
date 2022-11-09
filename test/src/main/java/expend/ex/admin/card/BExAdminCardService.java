package expend.ex.admin.card;

import java.util.List;
import java.util.Map;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


public interface BExAdminCardService {

	/* 카드 등록 */
	ResultVO ExConfigCardInfoSelect ( Map<String, Object> params ) throws Exception;

	/* 카드 등록 */
	ResultVO ExConfigCardInfoInsert ( Map<String, Object> params ) throws Exception;

	/* 카드 수정 */
	ResultVO ExConfigCardInfoUpdate ( Map<String, Object> params ) throws Exception;

	/* 카드 삭제 */
	ResultVO ExConfigCardInfoDelete ( Map<String, Object> params ) throws Exception;

	/* ERP 가져오기 */
	ResultVO ExConfigCardInfoFromErpCopy ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;

	/* 카드 공개범위 등록 */
	ResultVO ExConfigCardPublicListInfoInsert ( List<Map<String, Object>> params ) throws Exception;

	/* 카드 공개범위 삭제 */
	ResultVO ExConfigCardPublicListInfoDelete ( Map<String, Object> params ) throws Exception;

	/* 법인카드 설정영역 페이지 기본 파라미터 조회 */
	public Map<String, Object> ExAdminCardConfigSendParam ( ) throws Exception;
}

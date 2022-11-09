package expend.ex.user.expend;

import java.util.List;
import java.util.Map;

import common.vo.common.ResultVO;
import common.vo.ex.ExCommonResultVO;
import common.vo.ex.ExpendVO;


public interface FExUserService {

	/* Common */
	/* Common - Pop return values */
	Map<String, Object> ExpendPopReturnInfo ( Map<String, Object> params ) throws Exception;

	/* Bizbox Alpha */
	/* Bizbox Alpha - 지출결의 생성 */
	ExpendVO ExUserExpendInfoInsert ( ExpendVO expendVo ) throws Exception;

	/* Bizbox Alpha - 지출결의 삭제 */
	ResultVO ExUserExpendInfoDelete ( ExpendVO expendVo ) throws Exception;

	/* Bizbox Alpha - 지출결의 수정 */
	ResultVO ExUserExpendInfoUpdate ( ExpendVO expendVo ) throws Exception;

	/* Bizbox Alpha - 지출결의 조회 */
	ExpendVO ExUserExpendInfoSelect ( ExpendVO expendVo ) throws Exception;

	/* Bizbox Alpha - 지출결의 오류체크 */
	ResultVO ExUserExpendInfoErrorCheck ( ExpendVO expendVo ) throws Exception;

	/* Bizbox Alpha - 지출결의 회사 정보 가져오기 */
	String ExUserErpCodeInfoSelect ( Map<String, Object> params ) throws Exception;

	/* 본문내역 수정 이력 입력 */
	ResultVO ExAppDocHistoryInsert ( Map<String, Object> params );

	/* 본문내역 수정 이력 컨텐츠 입력 */
	ResultVO ExAppDocContentsHistoryInsert ( Map<String, Object> params );

	/* 지출결의 가져오기 리스트 조회 */
	ResultVO ExExpendHistoryListSelect ( ResultVO param );

	/* 지출결의 수정 내역 이력 추가 */
	ResultVO ExExpendEditHistoryInsert ( ResultVO param );

	/* 지출결의 항목 seq 조회 */
	ResultVO ExExpendListSeqSelect ( ResultVO param );
	/* iCUBE */
	/* ERPiU */
	/* ETC */

	/* 버튼설정 정보 조회 */
	ResultVO ExExpendButtonInfoSelect ( Map<String, Object> param );
	
	/* 지출결의 마감 정보 조회 */
	List<Map<String, Object>> ExExpendCloseDateSelect ( Map<String, Object> param );
	
	/* 지출결의 증빙일자 마감 유효성 체크 */
	List<ExCommonResultVO> ExAuthDateErrorInfoSelect( Map<String, Object> param );
}
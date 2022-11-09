package expend.ex.user.expend;

import java.util.List;
import java.util.Map;

import common.vo.common.ResultVO;
import common.vo.ex.ExCommonResultVO;
import common.vo.ex.ExExpendVO;
import common.vo.ex.ExpendVO;


public interface BExUserService {

	/* Pop */
	/* Pop - ExExpendMasterPop 반환값 처리 */
	Map<String, Object> ExUserMasterPopReturn ( Map<String, Object> params ) throws Exception;
	
	/* 지출결의 작성 초기변수 담기 */
	Map<String, Object> ExUserInitExpendSelect( Map<String, Object> params ) throws Exception;

	/* Biz */
	/* Biz - 지출결의 - 생성 */
	ExpendVO ExUserExpendInfoInsert ( ExpendVO expendVo ) throws Exception;

	/* Biz - 지출결의 - 삭제 */
	ResultVO ExUserExpendInfoDelete ( ExpendVO expendVo ) throws Exception;

	/* Biz - 지출결의 - 수정 */
	ResultVO ExUserExpendInfoUpdate ( ExpendVO expendVo ) throws Exception;

	/* Biz - 지출결의 - 조회 */
	ExpendVO ExUserExpendInfoSelect ( ExpendVO expendVo ) throws Exception;

	/* Biz - 지출결의 - 오류체크 */
	ResultVO ExUserExpendErrorInfoSelect ( ExpendVO expendVo ) throws Exception;
	
	/* Biz - 인터락 - 양식 팝업 코드 파서 */
	ResultVO ExUserExpendInterlockHtmlCode ( Map<String, Object> params ) throws Exception;
	
	List<ExCommonResultVO> ExUserExpendErrorInfoList ( ExExpendVO expendVo , Map<String, Object> param ) throws Exception;
	
	Map<String, Object> ExUserExpendLoadInfo ( ExpendVO expendVo ) throws Exception;
	
	/* 본문내역 수정 이력 입력 */
	ResultVO ExAppDocHistoryInsert ( Map<String, Object> params );
	
	/* 본문내역 수정 이력 컨텐츠 입력 */
	ResultVO ExAppDocContentsHistoryInsert ( Map<String, Object> params );
	
	/* 지출결의 가져오기 리스트 조회 */
	ResultVO ExExpendHistoryListSelect (ResultVO param );
	
	/* 지출결의 수정 내역 이력 추가 */
	ResultVO ExExpendEditHistoryInsert( ResultVO param);
	
	/* 지출결의 버튼설정 정보 조회 */
	ResultVO ExExpendButtonInfoSelect( Map<String, Object> params) throws Exception;
	
	/* 지출결의 마감 정보 조회 */
	List<Map<String, Object>> ExExpendCloseDateSelect ( Map<String, Object> param );
}

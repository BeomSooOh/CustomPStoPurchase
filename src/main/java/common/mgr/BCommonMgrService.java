package common.mgr;

import common.vo.common.ResultVO;

public interface BCommonMgrService {
	/* 회사 목록 조회 */
	ResultVO CommonMgrCompListSelect(ResultVO param) throws Exception;

	/* 표준적요 목록 조회 */
	ResultVO CommonMgrSummaryListSelect(ResultVO param) throws Exception;

	/* 표준적요 목록 삭제 */
	ResultVO CommonMgrSummaryListDelete(ResultVO param) throws Exception;

	/* 표준적요 등록 */
	ResultVO CommonMgrSummaryInsert(ResultVO param) throws Exception;
}

package expend.ex2.admin.summary;

import common.vo.common.ResultVO;


public interface FEx2AdminSummaryService {

	/* 표준적요 생성 */
	ResultVO setAdminSummaryInsert ( ResultVO result ) throws Exception;

	/* 표준적요 수정 */
	ResultVO setAdminSummaryUpdate ( ResultVO result ) throws Exception;

	/* 표준적요 삭제 */
	ResultVO setAdminSummaryDelete ( ResultVO result ) throws Exception;

	/* 표준적요 조회 */
	ResultVO setAdminSummarySelect ( ResultVO result ) throws Exception;

	ResultVO setAdminSummaryListSelect ( ResultVO result ) throws Exception;
}

package expend.np.user.reuse;

import common.vo.common.ResultVO;

public interface BNpUserReUseService {

	/* ## 품의서 ## */
	/* ## ################################################## ## */
	// SELECT
	// 품의서 정보 조회
	ResultVO ConsReUseSelect(ResultVO p) throws Exception;

	// 품의서 기수 정보 조회
	ResultVO ConsReUseGisuSelect(ResultVO p) throws Exception;

	// 재기안 품의서 양식 정보 조회
	ResultVO ConsReUseFormInfoSelect(ResultVO p) throws Exception;

	// SELECT LIST

	// INSERT

	// UPDATE

	// DELETE

	/* ## 결의서 ## */
	/* ## ################################################## ## */
	// SELECT
	// 결의서 정보 조회
	ResultVO ResReUseSelect(ResultVO p) throws Exception;

	// 결의서 기수 정보 조회
	ResultVO ResReUseGisuSelect(ResultVO p) throws Exception;

	// SELECT LIST

	// INSERT

	// UPDATE

	// DELETE
}

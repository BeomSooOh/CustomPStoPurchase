package expend.np.user.reuse;

import common.vo.common.ResultVO;

public interface FNpUserReUseService {

	/* ## 품의서 ## */
	/* ## ################################################## ## */
	// SELECT
	ResultVO ConsDocSelect(ResultVO p) throws Exception;

	ResultVO ConsGisuSelect(ResultVO p) throws Exception;

	ResultVO ConsReUseFormInfoSelect(ResultVO p) throws Exception;

	// SELECT LIST
	ResultVO ConsHeadSelectList(ResultVO p) throws Exception;

	ResultVO ConsBudgetSelectList(ResultVO p) throws Exception;

	ResultVO ConsTradeSelectList(ResultVO p) throws Exception;
	
	ResultVO ConsItemSpecSelectList(ResultVO p) throws Exception;
	// INSERT
	// UPDATE
	// DELETE

	/* ## 결의서 ## */
	/* ## ################################################## ## */
	// SELECT
	ResultVO ResDocSelect(ResultVO p) throws Exception;

	ResultVO ResGisuSelect(ResultVO p) throws Exception;

	// SELECT LIST
	ResultVO ResHeadSelectList(ResultVO p) throws Exception;

	ResultVO ResBudgetSelectList(ResultVO p) throws Exception;

	ResultVO ResTradeSelectList(ResultVO p) throws Exception;
	// INSERT
	// UPDATE
	// DELETE

	/* ## 카드 ## */
	/* ## ################################################## ## */
	// SELECT
	ResultVO CardTmpSelect(ResultVO p) throws Exception;
	// SELECT LIST
	// INSERT
	// UPDATE
	// DELETE

	/* ## 계산서 ## */
	/* ## ################################################## ## */
	// SELECT
	ResultVO ETaxTmpSelect(ResultVO p) throws Exception;
	// SELECT LIST
	// INSERT
	// UPDATE
	// DELETE
}

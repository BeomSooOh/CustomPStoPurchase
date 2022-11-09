package expend.ex.user.list;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExExpendForeignCurrencyVO;
import common.vo.ex.ExExpendListVO;

public interface FExUserListService {

	/**
	 * 항목정보 정렬순서 채번
	 * @param listVo
	 * @return
	 */
	int ExGetOrderSeqFromListInfo(ExExpendListVO listVo) throws Exception;
	
	/* 외화입력 - 외화계정인지 확인 */
	ResultVO CheckForeignCurrencyAcctCode ( ExExpendForeignCurrencyVO foreignCurrencyVO, ConnectionVO conVo ) throws Exception;
}

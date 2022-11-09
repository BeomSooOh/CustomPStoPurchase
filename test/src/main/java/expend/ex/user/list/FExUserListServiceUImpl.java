package expend.ex.user.list;

import javax.annotation.Resource;

import org.apache.commons.lang.NotImplementedException;
import org.springframework.stereotype.Service;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExExpendForeignCurrencyVO;
import common.vo.ex.ExExpendListVO;

@Service("FExUserListServiceU")
public class FExUserListServiceUImpl implements FExUserListService {
	@Resource ( name = "FExUserListServiceUDAO" )
	private FExUserListServiceUDAO userListServiceUDAO;


	@Override
	public int ExGetOrderSeqFromListInfo(ExExpendListVO listVo) throws Exception {
		throw new NotImplementedException( "Bizbox Alpha 전용기능으로 지원하지 않습니다." );
	}

	/* 외화입력 - 외화계정인지 확인 */
	@Override
	public ResultVO CheckForeignCurrencyAcctCode(ExExpendForeignCurrencyVO foreignCurrencyVO, ConnectionVO conVo) throws Exception {
		return userListServiceUDAO.CheckForeignCurrencyAcctCode( foreignCurrencyVO, conVo );
	}

}

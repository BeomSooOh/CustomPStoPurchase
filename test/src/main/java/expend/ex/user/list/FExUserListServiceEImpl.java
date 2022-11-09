package expend.ex.user.list;

import org.apache.commons.lang.NotImplementedException;
import org.springframework.stereotype.Service;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExExpendForeignCurrencyVO;
import common.vo.ex.ExExpendListVO;

@Service("FExUserListServiceE")
public class FExUserListServiceEImpl implements FExUserListService {

	@Override
	public int ExGetOrderSeqFromListInfo(ExExpendListVO listVo) throws Exception {
		throw new NotImplementedException( "Bizbox Alpha 전용기능으로 지원하지 않습니다." );
	}

	@Override
	public ResultVO CheckForeignCurrencyAcctCode(ExExpendForeignCurrencyVO foreignCurrencyVO, ConnectionVO conVo) throws Exception {
		throw new NotImplementedException( "ERP 전용기능으로 지원하지 않습니다." );
	}

}

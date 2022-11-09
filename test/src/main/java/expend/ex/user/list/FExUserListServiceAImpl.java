package expend.ex.user.list;

import org.apache.commons.lang.NotImplementedException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExExpendForeignCurrencyVO;
import common.vo.ex.ExExpendListVO;

@Service("FExUserListServiceA")
public class FExUserListServiceAImpl implements FExUserListService {

	@Autowired
	private FExUserListServiceADAO userListServiceADAO;

	/**
	 * 항목정보 정렬순서 채번
	 * @throws Exception 
	 */
	@Override
	public int ExGetOrderSeqFromListInfo(ExExpendListVO listVo) throws Exception {
		int orderSeq = 0;
		
		//ExExpendListVO에 ListSeq가 없는 경우만 order_seq 채번
		if(listVo.getListSeq().equals("") || listVo.getListSeq().equals("0")) {
			orderSeq = userListServiceADAO.ExExpendListOrderInfoSelect(listVo);
		//ListSeq가 있는 경우 ExExpendListVO에 orderSeq로 대체
		}else {
			orderSeq = listVo.getOrderSeq();
		}
		
		return orderSeq;
	}

	@Override
	public ResultVO CheckForeignCurrencyAcctCode(ExExpendForeignCurrencyVO foreignCurrencyVO, ConnectionVO conVo) throws Exception {
		throw new NotImplementedException( "ERP 전용기능으로 지원하지 않습니다." );
	}
	
}

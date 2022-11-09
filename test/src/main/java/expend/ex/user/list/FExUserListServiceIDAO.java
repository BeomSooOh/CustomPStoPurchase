package expend.ex.user.list;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import common.helper.connection.CommonExConnect;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExExpendForeignCurrencyVO;

@Repository("FExUserListServiceIDAO")
public class FExUserListServiceIDAO {
	private final CommonExConnect exConnect = new CommonExConnect( );

	/* 외화입력 - 외화계정인지 확인 */
	public ResultVO CheckForeignCurrencyAcctCode(ExExpendForeignCurrencyVO foreignCurrencyVO, ConnectionVO conVo) throws Exception {
		ResultVO resultVo = new ResultVO();

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("erpCompSeq", foreignCurrencyVO.getErpCompSeq());
		params.put("drAcctCode", foreignCurrencyVO.getDrAcctCode());
		params.put("crAcctCode", foreignCurrencyVO.getCrAcctCode());

		Map<String, Object> result = exConnect.Select(conVo, "UseriCUBEForeignCurrency.CheckForeignCurrencyAcctCode", params);

        resultVo.setaData(result);
		return resultVo;
	}

	/* 외화입력 - iCUBE 환율, 외화금액 소수점 자릿수 조회(iCUBE 시스템 환경설정) */
	public ResultVO PointLengthInfoSelect(ExExpendForeignCurrencyVO foreignCurrencyVO, ConnectionVO conVo) throws Exception {
		ResultVO resultVo = new ResultVO();

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("erpCompSeq", foreignCurrencyVO.getErpCompSeq());

		Map<String, Object> result = exConnect.Select(conVo, "UseriCUBEForeignCurrency.PointLengthInfoSelect", params);

        resultVo.setaData(result);
		return resultVo;
	}

}

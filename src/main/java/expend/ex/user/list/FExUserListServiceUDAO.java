package expend.ex.user.list;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import common.helper.connection.CommonExConnect;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExExpendForeignCurrencyVO;

@Repository("FExUserListServiceUDAO")
public class FExUserListServiceUDAO {
	private final CommonExConnect exConnect = new CommonExConnect( );

	/* 외화입력 - 환율정보 조회 */
	public ResultVO ExchangeRateInfoSelect(ExExpendForeignCurrencyVO foreignCurrencyVO, ConnectionVO conVo) throws Exception {
		ResultVO resultVo = new ResultVO();

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("erpCompSeq", foreignCurrencyVO.getErpCompSeq());
		params.put("authDate", foreignCurrencyVO.getAuthDate());
		params.put("exchangeUnitCode", foreignCurrencyVO.getExchangeUnitCode());

        exConnect.Select(conVo, "UseriUForeignCurrency.ExchangeRateInfoSelect", params);

        resultVo.setaData(params);
        return resultVo;
    }

	/* 외화입력 - 올림구분 조회 */
	public ResultVO RoundingTypeInfoSelect(ExExpendForeignCurrencyVO foreignCurrencyVO, ConnectionVO conVo) throws Exception {
		ResultVO resultVo = new ResultVO();

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("erpCompSeq", foreignCurrencyVO.getErpCompSeq());

        exConnect.Select(conVo, "UseriUForeignCurrency.RoundingTypeInfoSelect", params);

        resultVo.setaData(params);
        return resultVo;
    }

	/* 외화입력 - 외화계정인지 확인 */
	public ResultVO CheckForeignCurrencyAcctCode(ExExpendForeignCurrencyVO foreignCurrencyVO, ConnectionVO conVo) throws Exception {
		ResultVO resultVo = new ResultVO();

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("erpCompSeq", foreignCurrencyVO.getErpCompSeq());
		params.put("drAcctCode", foreignCurrencyVO.getDrAcctCode());
		params.put("crAcctCode", foreignCurrencyVO.getCrAcctCode());

		Map<String, Object> result = exConnect.Select(conVo, "UseriUForeignCurrency.CheckForeignCurrencyAcctCode", params);

        resultVo.setaData(result);
		return resultVo;
	}
}

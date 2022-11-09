package expend.ex.master.config;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


@Service ( "FExMasterConfigServiceE" )
public class FExMasterConfigServiceEImpl implements FExMasterConfigService {

	/* 공통코드 - ERP 가져오기 */
	/**
	 *   * @Method Name : ExCodeCardInfoFromErpCopy
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : ERP 가져오기
	 *   * @param parms
	 *   * @param conVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@Override
	public ResultVO ExCodeCardInfoFromErpCopy ( Map<String, Object> parms, ConnectionVO conVo ) throws Exception {
		return null;
	}

	/* 주석없응 */
	/**
	 *   * @Method Name : ExCodeVatTypeListInfoSelect
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 주석없음
	 *   * @param vatTypeVo
	 *   * @param conVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@Override
	public List<Map<String, Object>> ExCodeVatTypeListInfoSelect ( Map<String, Object> vatTypeVo, ConnectionVO conVo ) throws Exception {
		return null;
	}
}
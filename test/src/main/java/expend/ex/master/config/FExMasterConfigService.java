package expend.ex.master.config;

import java.util.List;
import java.util.Map;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


public interface FExMasterConfigService {

	/* 공통코드 - ERP 가져오기 */
	ResultVO ExCodeCardInfoFromErpCopy ( Map<String, Object> parms, ConnectionVO conVo ) throws Exception;

	/* 공통코드 - 부가세 구분 가져오기 */
	List<Map<String, Object>> ExCodeVatTypeListInfoSelect ( Map<String, Object> vatTypeVo, ConnectionVO conVo ) throws Exception;
}

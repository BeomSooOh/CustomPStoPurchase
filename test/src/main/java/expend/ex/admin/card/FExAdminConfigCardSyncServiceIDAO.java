package expend.ex.admin.card;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import common.helper.connection.CommonExConnect;
import common.vo.common.ConnectionVO;


@Repository ( "FExAdminConfigCardSyncServiceIDAO" )
public class FExAdminConfigCardSyncServiceIDAO {

	/* 변수정의 - class */
	CommonExConnect connector = new CommonExConnect( );

	/* 주석없음 */
	/**
	 *   * @Method Name : ExCommonCodeCardSelect
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 주석없음
	 *   * @param params
	 *   * @param conVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public List<Map<String, Object>> ExCommonCodeCardSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = connector.List( conVo, "AdminiCUBEConfig.ExCommonCodeCardSelect", params );
		return result;
	}
}

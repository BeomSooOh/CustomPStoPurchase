package expend.ex.master.config;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import common.helper.connection.CommonExConnect;
import common.helper.info.CommonInfo;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FExMasterConfigServiceUDAO" )
public class FExMasterConfigServiceUDAO extends EgovComAbstractDAO {
	/* 변수정의 */

	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
	private final CommonExConnect connect = new CommonExConnect( );

	public List<Map<String, Object>> getMngOptionList ( Map<String, Object> param, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> list = null;
		list = connect.List( conVo, "getMngOptionList", param );
		return list;
	}

	/* 공통코드 - ERP 가져오기 */
	/**
	 *   * @Method Name : ExCodeCardInfoFromErpCopy
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 공통코드 - ERP 가져오기
	 *   * @param parms
	 *   * @param conVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public ResultVO ExCodeCardInfoFromErpCopy ( Map<String, Object> parms, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		connect.List( conVo, "MasterERPiUConfig.ExMasterConfigERPCardSelect", parms );
		return result;
	}

	/* 주석없음 */
	/**
	 *   * @Method Name : ExCodeVatTypeListInfoSelect
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 주석없음
	 *   * @param params
	 *   * @param conVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public List<Map<String, Object>> ExCodeVatTypeListInfoSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> vatTeypListVo = new ArrayList<Map<String, Object>>( );
		try {
			vatTeypListVo = connect.List( conVo, "MasterERPiUConfig.ExCodeVatTypeListInfoSelect", params );
		}
		catch ( Exception e ) {
			throw e;
		}
		return vatTeypListVo;
	}
}
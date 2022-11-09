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


@Repository ( "	" )
public class FExMasterConfigServiceIDAO extends EgovComAbstractDAO {

	/* 변수정의 - Common */
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
	private final CommonExConnect connect = new CommonExConnect( );

	/* 주석없음 */
	/**
	 *   * @Method Name : getCardErpData
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 주석없음
	 *   * @param param
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> getCardErpData ( Map<String, Object> param ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			result = (List<Map<String, Object>>) list( "getCardErpData_iCUBE", param );
		}
		catch ( Exception e ) {
			throw e;
		}
		return result;
	}

	/* 지출결의 관련 설정 */
	/**
	 *   * @Method Name : getMngOptionList
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 지출결의 관련 설정
	 *   * @param param
	 *   * @param conVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public List<Map<String, Object>> getMngOptionList ( Map<String, Object> param, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> list = null;
		connect.List( conVo, "getMngOptionList", param );
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
		connect.List( conVo, "ExCodeCardListInfoSelect", parms );
		return result;
	}

	/* 주석없음 */
	/**
	 *   * @Method Name : ExCodeVatTypeListInfoSelect
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 주석없음
	 *   * @param parms
	 *   * @param conVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public List<Map<String, Object>> ExCodeVatTypeListInfoSelect ( Map<String, Object> parms, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> vatTeypListVo = new ArrayList<Map<String, Object>>( );
		try {
			vatTeypListVo = connect.List( conVo, "ExCodeVatTypeListInfoSelect", parms );
		}
		catch ( Exception e ) {
			throw e;
		}
		return vatTeypListVo;
	}
}
package expend.bi.admin.car;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import common.helper.connection.CommonBiConnect;
import common.helper.logger.CommonLogger;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FBiAdminCarServiceIDAO" )
public class FBiAdminCarServiceIDAO extends EgovComAbstractDAO {

	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */
	
	/* 변수정의 - class */
	CommonBiConnect connector = new CommonBiConnect( );

	/**
	 * 함수명 : BiAdminCarInfoListSelect
	 * 함수설명 : ERP - iCUBE 차량 정보 조회
	 * 생성일자 : 2017. 9. 1.
	 * 
	 * @param param
	 *            erpCompSeq, carCd(선택/검색)
	 * @return ResultVO
	 */
	public List<Map<String, Object>> BiAdminCarInfoListSelect ( ResultVO param, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			result = connector.List( conVo, "BiAdminCarInfoListSelect", param.getParams( ) );
		}
		catch ( Exception ex ) {
			result = new ArrayList<Map<String, Object>>( );
		}
		return result;
	}
}

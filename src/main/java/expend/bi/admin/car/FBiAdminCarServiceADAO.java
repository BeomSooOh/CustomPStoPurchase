package expend.bi.admin.car;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FBiAdminCarServiceADAO" )
public class FBiAdminCarServiceADAO extends EgovComAbstractDAO {

	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */

	/**
	 * 함수명 : BiAdminCarInfoListSelect
	 * 함수설명 : 차량 정보 조회
	 * 생성일자 : 2017. 9. 1.
	 * 
	 * @param param
	 *            compSeq, searchStr(선택/검색)
	 * @return ResultVO
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> BiAdminCarInfoListSelect ( ResultVO param ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			result = this.list( "BiAdminCarListSelect", param.getParams( ) );
		}
		catch ( Exception ex ) {
			result = null;
		}
		return result;
	}

	/**
	 * 함수명 : BiAdminCarListDelete
	 * 함수설명 : GW 차량정보 삭제
	 * 생성일자 : 2017. 9. 1.
	 * 
	 * @param param
	 *            compSeq
	 * @return ResultVO
	 */
	public ResultVO BiAdminCarListDelete ( ResultVO param ) throws Exception {
		try {
			this.delete( "BiAdminCarListDelete", param.getParams( ) );
			param.setResultCode( commonCode.EMPTYYES );
		}
		catch ( Exception ex ) {
			param.setResultCode( commonCode.EMPTYNO );
			param.setResultName( ex.getMessage( ) );
		}
		return param;
	}

	/**
	 * 함수명 : BiAdminCarListInsert
	 * 함수설명 : GW 차량정보 등록
	 * 생성일자 : 2017. 9. 1.
	 * 
	 * @param param
	 *            compSeq
	 * @return ResultVO
	 */
	public ResultVO BiAdminCarListInsert ( ResultVO param ) throws Exception {
		try {
			this.insert( "BiAdminCarListInsert", param.getParams( ) );
			param.setResultCode( commonCode.EMPTYYES );
		}
		catch ( Exception ex ) {
			param.setResultCode( commonCode.EMPTYNO );
			param.setResultName( ex.getMessage( ) );
		}
		return param;
	}
}

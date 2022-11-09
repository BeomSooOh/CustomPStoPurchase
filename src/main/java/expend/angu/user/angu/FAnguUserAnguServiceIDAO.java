/**
  * @FileName : FAnguUserAnguServiceIDAO.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.angu.user.angu;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import common.helper.connection.CommonAnConnect;
import common.vo.common.ConnectionVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


/**
 *   * @FileName : FAnguUserAnguServiceIDAO.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Repository ( "FAnguUserAnguServiceIDAO" )
public class FAnguUserAnguServiceIDAO extends EgovComAbstractDAO {

	/* 변수정의 */
	CommonAnConnect connector = new CommonAnConnect( );

	/* iCUBE 환경설정 정보 조회 - 거래처통장표시내용, 보조금통장표시내용 */
	public Map<String, Object> TermInfoS ( Map<String, Object> params, ConnectionVO conVo ) {
		Map<String, Object> result = new HashMap<String, Object>( );
		result = connector.Select( conVo, "AnguCode.TermInfoS", params );
		return result;
	}

	/* 국고보조 집행등록 사용자 정보 조회 */
	public Map<String, Object> EmpInfoS ( Map<String, Object> params, ConnectionVO conVo ) {
		Map<String, Object> result = new HashMap<String, Object>( );
		result = connector.Select( conVo, "AnguCode.EmpInfoS", params );
		return result;
	}

	/* 결의 + 증빙내역 생성 */
	public Map<String, Object> AbdocuI ( Map<String, Object> params, ConnectionVO conVo ) {
		connector.Insert( conVo, "AnguSync.AbdocuCubeI", params );
		return params;
	}

	/* 비목내역 생성 */
	public Map<String, Object> AbdocuBI ( Map<String, Object> params, ConnectionVO conVo ) {
		connector.Insert( conVo, "AnguSync.AbdocuBCubeI", params );
		return params;
	}

	/* 재원내역 생성 */
	public Map<String, Object> AbdocuTI ( Map<String, Object> params, ConnectionVO conVo ) {
		connector.Insert( conVo, "AnguSync.AbdocuTCubeI", params );
		return params;
	}
	
	/* 인력정보 등록 */
	public Map<String, Object> AbdocuPI ( Map<String, Object> params, ConnectionVO conVo ) {
		connector.Insert( conVo, "AnguSync.AbdocuPCubeI", params );
		return params;
	}
 
	/* iCUBE 상태값 업데이트 */
	public Map<String, Object> AbdocuSyncInfoU ( Map<String, Object> params, ConnectionVO conVo ) {
		connector.Update( conVo, "AnguSync.AbdocuSyncCubeU", params );
		return params;
	}
}

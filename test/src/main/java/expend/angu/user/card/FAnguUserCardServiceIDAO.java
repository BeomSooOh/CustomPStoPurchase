/**
  * @FileName : FAnguUserCardServiceIDAO.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.angu.user.card;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import common.helper.connection.CommonAnConnect;
import common.vo.common.ConnectionVO;


/**
 *   * @FileName : FAnguUserCardServiceIDAO.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Repository ( "FAnguUserCardServiceIDAO" )
public class FAnguUserCardServiceIDAO {

	/* 변수정의 */
	CommonAnConnect connector = new CommonAnConnect( );

	/* 집행등록 - 국고보조사업 귀속 카드 */
	public List<Map<String, Object>> AnguCardInfoS ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCard.AnguCardInfoS", params );
		return result;
	}

	/* 집행등록 - 카드 사용 내역 코드 조회 */
	public List<Map<String, Object>> AnguCardListInfoS ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCard.AnguCardListInfoS", params );
		return result;
	}
}

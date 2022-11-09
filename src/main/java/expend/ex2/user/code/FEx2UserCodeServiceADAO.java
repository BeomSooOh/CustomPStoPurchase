/**
  * @FileName : FEx2UserCodeServiceUDAO.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ex2.user.code;

//import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

//import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.common.CommonInterface.commonCode;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


/**
 *   * @FileName : FEx2UserCodeServiceUDAO.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Repository ( "FEx2UserCodeServiceADAO" )
public class FEx2UserCodeServiceADAO extends EgovComAbstractDAO {
	//public ResultVO insertEntertainmentFee ( ConnectionVO conVo, Map<String, Object> param ) throws Exception {
	public ResultVO insertEntertainmentFee ( Map<String, Object> param ) throws Exception {
		ResultVO result = new ResultVO( );
		try{
			result.setResultCode( insert( "setEntertainmentFeeInsert", param ).toString( ) );
		}catch(Exception ex){
			result.setFail( "DB오류가 발생하였습니다.", ex );
		}
		return result;
	}

	//public ResultVO updateEntertainmentFee ( ConnectionVO conVo, Map<String, Object> param ) throws Exception {
	public ResultVO updateEntertainmentFee ( Map<String, Object> param ) throws Exception {
		ResultVO result = new ResultVO( );
		try{
			update("setEntertainmentFeeUpdate", param);
			result.setResultCode( commonCode.SUCCESS );
		}catch(Exception ex){
			result.setFail( "DB오류가 발생하였습니다.", ex );
		}
		return result;
	}

	//public ResultVO selectEntertainmentFee ( ConnectionVO conVo, Map<String, Object> param ) throws Exception {
	public ResultVO selectEntertainmentFee ( Map<String, Object> param ) throws Exception {
		ResultVO result = new ResultVO( );
		try{
			result.setaData( (Map<String, Object>)select("setEntertainmentFeeSelect", param) );
		}catch(Exception ex){
			result.setFail( "DB오류가 발생하였습니다.", ex );
		}
		return result;
	}
}

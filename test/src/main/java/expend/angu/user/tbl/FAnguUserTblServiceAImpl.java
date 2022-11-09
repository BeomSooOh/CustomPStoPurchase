/**
  * @FileName : FAnguUserTblServiceAImpl.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.angu.user.tbl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ResultVO;
import expend.angu.user.common.BAnUserCommonService;


/**
 *   * @FileName : FAnguUserTblServiceAImpl.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Service ( "FAnguUserTblServiceA" )
public class FAnguUserTblServiceAImpl implements FAnguUserTblService {

	/* 변수정의 */
	@Resource ( name = "BAnUserCommonService" )
	private BAnUserCommonService AnguCommon;
	@Resource ( name = "FAnguUserTblServiceADAO" )
	private FAnguUserTblServiceADAO dao;

	@SuppressWarnings ( "unchecked" )
	public ResultVO TblAction ( ResultVO result ) throws Exception {
		/* result.params.tbl, result.params.type, result.params.... */
		/* 변수정의 */
		Map<String, Object> params = new HashMap<String, Object>( );
		Map<String, Object> resultMap = new HashMap<String, Object>( );
		try {
			/* 기본값 정의 */
			params = (HashMap<String, Object>) result.getParams( );
			/* 필수값 확인 */
			result = AnguCommon.AnCommonCheckParam( result, params, "tbl" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "type" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* 쿼리호출 */
			resultMap = dao.TblAction( CommonConvert.CommonGetStr( params.get( "tbl" ) ), CommonConvert.CommonGetStr( params.get( "type" ) ), params );
			/* 데이터 검증 및 가공 반환 */
			if ( resultMap != null ) {
				if ( resultMap.containsKey( "aaData" ) ) {
					result.setAaData( (List<Map<String, Object>>) resultMap.get( "aaData" ) );
				}
				else if ( resultMap.containsKey( "updateCount" ) ) {
					result.setResultCode( CommonConvert.CommonGetStr( resultMap.get( "updateCount" ) ) );
				}
				else if ( resultMap.containsKey( "deleteCount" ) ) {
					result.setResultCode( CommonConvert.CommonGetStr( resultMap.get( "deleteCount" ) ) );
				}
				else {
					result.setaData( (Map<String, Object>) resultMap );
				}
			}
			else {
				result.setResultCode( commonCode.FAIL );
				result.setResultName( CommonConvert.CommonGetStr( params.get( "tbl" ) ) + " - " + CommonConvert.CommonGetStr( params.get( "type" ) ) );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return result;
	}
}

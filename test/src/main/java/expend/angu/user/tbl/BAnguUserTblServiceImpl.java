/**
  * @FileName : BAnguUserTblServiceImpl.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.angu.user.tbl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ResultVO;


/**
 *   * @FileName : BAnguUserTblServiceImpl.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Service ( "BAnguUserTblService" )
public class BAnguUserTblServiceImpl implements BAnguUserTblService {

	/* 변수정의 */
	
	@Resource ( name = "FAnguUserTblServiceA" )
	private FAnguUserTblService tblA;

	public ResultVO TblAction ( ResultVO result ) throws Exception {
		try {
			/* 기본값 정의 */
			result = (ResultVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetEmpInfo( ), result );
			/* 프로세스 진행 */
			result = tblA.TblAction( result );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}
}

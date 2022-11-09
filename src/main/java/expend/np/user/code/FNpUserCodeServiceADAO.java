package expend.np.user.code;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import common.vo.common.ResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FNpUserCodeServiceADAO" )
public class FNpUserCodeServiceADAO extends EgovComAbstractDAO {

	/* 공통코드 - 카드사용내역 상태값 변경 */
	public ResultVO UpdateInterfaceInfo ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			int resultCnt = (int) update( "NpUserCodeA.UpdateInterfaceInfo", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}
	
	/* 공통코드 - 결의서에서 외부시스템 정보 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String,Object>> SelectInterfaceInfoIntoRes ( Map<String, Object> params ) throws Exception {
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>( );
		try {
			result = (List<Map<String,Object>>) list( "NpUserCodeA.SelectInterfaceInfoIntoRes", params );
		}
		catch ( Exception ex ) {
			ex.printStackTrace( );
		}
		return result;
	}
	
	/* 공통코드 - 카드정보 가져오기 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO NpSelectCardInfoList ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );

		try {
			/* parameter 검증 진행. */
//			if ( params.get( "residence" ) == null ) {
//				params.put( "residence", "" );
//			}
//			paramChecker c = ParameterCheck( params, new String[] { "erpCompSeq", "residence" } );
//			if ( !c.resultCode ) {
//				throw new Exception( c.msg );
//			}
			/* ERP DATA BASE 조회 진행 */
			List<Map<String, Object>> resultList = list( "NpUserCodeA.NpSelectCardInfoList", params );
			result.setAaData( resultList );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "ERP DB연동 처리중 오류가 발생하였습니다.", ex );
		}
		return result;
	}
}
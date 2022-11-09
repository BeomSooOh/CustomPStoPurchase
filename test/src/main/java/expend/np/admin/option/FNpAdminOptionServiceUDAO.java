package expend.np.admin.option;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import common.vo.common.ResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FNpAdminOptionServiceUDAO" )
public class FNpAdminOptionServiceUDAO extends EgovComAbstractDAO {

	/**
	 * 그룹웨어 환경설정 데이터 조회
	 * P : { !formSeq }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO NpGwCommonOptionSelect ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			List<Map<String, Object>> temp = list( "NpAdminOptionA.NpGwCommonOptionSelect", params );
			result.setAaData( temp );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 그룹웨어 환경설정 데이터 복사
	 * P : { !formSeq }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO NpGwCommonOptionInsert ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			insert( "NpUserOptionA.NpGwCommonOptionInsert", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 그룹웨어 환경설정 변경
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO NpGwCommonOptionUpdate ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			List<Map<String, Object>> temp = list( "NpAdminOptionA.NpGwCommonOptionUpdate", params );
			result.setAaData( temp );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}
}

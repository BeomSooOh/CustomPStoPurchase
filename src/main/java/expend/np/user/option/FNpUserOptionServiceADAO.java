package expend.np.user.option;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import common.helper.convert.CommonConvert;
import common.helper.logger.CommonLogger;
import common.vo.common.ResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FNpUserOptionServiceADAO" )
public class FNpUserOptionServiceADAO extends EgovComAbstractDAO {
	@Resource(name = "CommonLogger")
	private CommonLogger cmLog; /* Log 관리 */
	
	/**
	 * 그룹웨어 환경설정 데이터 조회
	 * P : { !formSeq }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO NpGwCommonOptionSelect ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			List<Map<String, Object>> temp = list( "NpUserOptionA.NpGwCommonOptionSelect", params );
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
	 * 그룹웨어 비영리 양식정보 조회
	 * P : { !formSeq }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO NpGwEaFormInfoSelect ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData( (List<Map<String, Object>>) list( "NpUserOptionA.NpGwEaFormInfoSelect", params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 그룹웨어 영리 양식정보 조회
	 * P : { !formSeq }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO NpGwEapFormInfoSelect ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData( (List<Map<String, Object>>) list( "NpUserOptionA.NpGwEapFormInfoSelect", params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}
	
	/**
	 * 품의/결의 기본 설정 조회
	 * P : { !formSeq }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO selectBasicOption ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			if( CommonConvert.NullToString( params.get( "formSeq" ) ).equals( "" ) && ( !CommonConvert.NullToString( params.get( "docSeq" ) ).equals( "" ) )){
				List<Map<String, Object>> daoResult = ((List<Map<String, Object>>) list( "NpAdminConfigA.selectDocFormSeq", params ));
				Map<String, Object> formMap = daoResult.get( 0 );
				String formSeq = CommonConvert.NullToString( formMap.get( "formSeq" ) );
				params.put( "formSeq", formSeq );
			}
			if( CommonConvert.NullToString( params.get( "formSeq" ) ).equals( "" ) && ( !CommonConvert.NullToString( params.get( "resDocSeq" ) ).equals( "" ) )){
				List<Map<String, Object>> daoResult = ((List<Map<String, Object>>) list( "NpAdminConfigA.selectDocFormSeq2", params ));
				Map<String, Object> formMap = daoResult.get( 0 );
				String formSeq = CommonConvert.NullToString( formMap.get( "formSeq" ) );
				params.put( "formSeq", formSeq );
			}
			
			
			result.setAaData( (List<Map<String, Object>>) list( "NpAdminConfigA.selectBasicOption", params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetInfoToDatabase( "[   [ERROR] #EXNP# @DAO selectBasicOption] " + ex.getMessage( ), "-", "EXNP" );
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}
}
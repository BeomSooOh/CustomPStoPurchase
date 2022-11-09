package expend.trip.admin.report;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import common.helper.logger.CommonLogger;
import common.vo.common.ResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FTripAdminReportServiceADAO" )
public class FTripAdminReportServiceADAO extends EgovComAbstractDAO {

	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );

	/* 품의 2.0 프로젝트 정보 조회 */
	//public ResultVO selectConsMgtInfo ( Map<String, Object> params ) {
	public ResultVO selectConsMgtInfo ( ) {
		ResultVO result = new ResultVO( );
		return null;
	}

	/* 품의 2.0 예산 정보 조회 */
	//public ResultVO selectConsBgtInfo ( Map<String, Object> params ) {
	public ResultVO selectConsBgtInfo ( ) {
		ResultVO result = new ResultVO( );
		return null;
	}

	/* 품의 2.0 품의 총 금액 */
	//public ResultVO selectConsAmt ( Map<String, Object> params ) {
	public ResultVO selectConsAmt ( ) {
		ResultVO result = new ResultVO( );
		return null;
	}

	/** 출장 품의 현황 조회 **/
	public ResultVO selectTripConsReport ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			ArrayList<Map<String, Object>> aaData = (ArrayList<Map<String, Object>>) list( "TripAdminReportA.selectTripconsReport", params );
			Map<String, Object> aData = new HashMap( );
			aData.put( "size", aaData.size( ) );
			result.setAaData( aaData );
			result.setaData( aData );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail( "프로젝트 정보 조회 실패", ex );
		}
		return result;
	}

	/** 출장 결의 현황 조회 **/
	public ResultVO selectTripResReport ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			// 기본 리스트 조회
			String queryId = "TripAdminReportA.selectTripResReport";
			// 엑셀저장 시 분기 처리
			if(params.get("tripExcelCode") != null && params.get("tripExcelCode").toString().equals("2")){
				// 예산계정별 리스트 조회
				queryId = "TripAdminReportA.selectTripResReportForBudget";
			}else if(params.get("tripExcelCode") != null && params.get("tripExcelCode").toString().equals("3")){
				// 사용자별 리스트 조회
				queryId = "TripAdminReportA.selectTripResReportForUser";
			}

			//ArrayList<Map<String, Object>> aaData = (ArrayList<Map<String, Object>>) list( "TripAdminReportA.selectTripResReport", params );
			ArrayList<Map<String, Object>> aaData = (ArrayList<Map<String, Object>>) list( queryId, params );
			Map<String, Object> aData = new HashMap( );
			aData.put( "size", aaData.size( ) );
			result.setAaData( aaData );
			result.setaData( aData );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail( "프로젝트 정보 조회 실패", ex );
		}
		return result;
	}

	/** 출장 품의 문서 삭제 **/
	public ResultVO deleteTripConsDoc ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			update("TripAdminReportA.deleteTripConsDoc", params);
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail( "프로젝트 정보 조회 실패", ex );
		}
		return result;
	}


	/** 출장 품의 문서 삭제 **/
	public ResultVO deleteTripResDoc ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			update("TripAdminReportA.deleteTripResDoc", params);
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail( "프로젝트 정보 조회 실패", ex );
		}
		return result;
	}


}

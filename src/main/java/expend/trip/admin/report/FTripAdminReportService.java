package expend.trip.admin.report;

import java.util.Map;

import common.vo.common.ResultVO;


public interface FTripAdminReportService {

	/** 비영리 2.0 품의 문서 정보 조회 **/
	ResultVO selectConsDocInfo ( Map<String, Object> params ) throws Exception;

	/** 비영리 2.0 결의 문서 정보 조회 **/
	ResultVO selectResDocInfo ( Map<String, Object> params ) throws Exception;

	/** 관리자 출장 품의 현황 정보 조회 **/
	ResultVO selectTripConsReport ( Map<String, Object> params ) throws Exception;

	/** 관리자 출장 결의 현황 정보 조회 **/
	ResultVO selectTripResReport ( Map<String, Object> params ) throws Exception;
	
	/** 관리자 품의서 삭제  **/
	ResultVO deleteTripConsDoc ( Map<String, Object> params ) throws Exception;
	
	/** 관리자 결의서 삭제  **/
	ResultVO deleteTripResDoc ( Map<String, Object> params ) throws Exception;
}

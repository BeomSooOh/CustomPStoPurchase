package expend.trip.user.res;

import java.util.Map;

import common.vo.common.ResultVO;


public interface BTripUserResService {

	/** 출장 결의 문서 생성 **/
	ResultVO insertTripResDoc ( Map<String, Object> params ) throws Exception;

	/** 출장 결의 문서 정보 조회 **/
	ResultVO selectTripResDocAllInfo ( Map<String, Object> params ) throws Exception;
	
	/** 비영리 2.0 결의 문서 정보 조회 **/
	ResultVO selectResDocInfo ( Map<String, Object> params ) throws Exception;

	/** 사용자 출장 결의 현황 정보 조회 **/
	ResultVO selectTripResReport ( Map<String, Object> params ) throws Exception;
	
	/** 사용자 참조결의 리스트 조회 **/
	ResultVO selectConfferList ( Map<String, Object> params ) throws Exception;
	
	/** 사용자 참조결의 정보 반영 **/
	ResultVO updateTripConfferCons ( Map<String, Object> params ) throws Exception;
	
	/** 사용자 출장 결의 인사정보, 경비내역 정보 저장 **/
	ResultVO insertTripResAttExInfo(Map<String, Object> params) throws Exception;

	/** 사용자 출장 예산 정보 저장 **/
	ResultVO insertTripResBudgetInfo(Map<String, Object> params) throws Exception;
}

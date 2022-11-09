package expend.trip.user.res;

import java.util.HashMap;
import java.util.Map;

import common.vo.common.ResultVO;


public interface FTripUserResService {
	/** 출장 결의 문서 생성 **/
	ResultVO insertTripResDoc ( Map<String, Object> params ) throws Exception;
	/** 출장 결의 문서 정보 조회 **/
	ResultVO selectTripResDocAllInfo ( Map<String, Object> params ) throws Exception;
	/** 비영리 2.0 결의 문서 정보 조회 **/
	ResultVO selectResDocInfo ( Map<String, Object> params ) throws Exception;
	/** 출장결의 문서 정보 저장 **/
	ResultVO insertTripRes ( Map<String, Object> params ) throws Exception;
	/** 출장 결의 현황 조회 **/
	ResultVO selectTripResReport ( Map<String, Object> params ) throws Exception;
	/** 사용자 참조결의 리스트 조회 **/
	ResultVO selectConfferList ( Map<String, Object> params ) throws Exception;
	/** 사용자 참조결의 정보 반영 **/
	ResultVO updateTripConfferCons ( Map<String, Object> params ) throws Exception;
	/** 출장 결의 문서 근태 정보 저장 **/
	ResultVO insertTripResAttend(Map<String, Object> tripInfo);
	/** 출장 결의 문서 출장자 정보 저장 **/
	ResultVO insertTripResTraveler(HashMap<String, Object> tripParam);
	/** 출장 결의 문서 경비 내역 정보 저장 **/
	ResultVO insertTripResExpense(HashMap<String, Object> hashMap);
	/** 출장 품의 문서 근태 정보 삭제 **/
	ResultVO deleteTripResAttend(Map<String, Object> params);
	/** 출장 품의 문서 경비 내역 정보 삭제 **/
	ResultVO deleteTripResExpense(Map<String, Object> params);
	/** 출장 품의 문서 출장자 정보 삭제 **/
	ResultVO deleteTripResTraveler(Map<String, Object> params);
	/** 출장 품의 문서 예산 정보 저장 **/
	ResultVO insertTripResBudget(Map<String, Object> params);
	/** 출장 품의 문서 예산 과목 정보 조회 **/
	ResultVO selectResBudgetInfo(Map<String, Object> params);
	/** 출장 품의 문서 과목 정보 저장 **/
	ResultVO insertTripResBudgetErp(Map<String, Object> params);
	/** 출장 결의 문서 예산 과목 정보 삭제 **/
	ResultVO deleteTripResBudgetInfo(Map<String, Object> params);
	ResultVO deleteTripResBudgetErpInfo(Map<String, Object> params);
}

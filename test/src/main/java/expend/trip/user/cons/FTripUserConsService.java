package expend.trip.user.cons;

//import java.util.HashMap;
import java.util.Map;

import common.vo.common.ResultVO;


public interface FTripUserConsService {

	/** 비영리 2.0 품의 문서 정보 조회 **/
	ResultVO selectConsDocInfo ( Map<String, Object> params ) throws Exception;
	/** 출장품의 품의 문서 정보 조회 **/
	ResultVO selectTripConsDocAllInfo ( Map<String, Object> params ) throws Exception;
	/** 출장 품의 현황 조회 **/
	ResultVO selectTripConsReport ( Map<String, Object> params ) throws Exception;
	/** 출장 품의 문서 생성 **/
	ResultVO insertTripConsDoc ( Map<String, Object> params ) throws Exception;

	/** 출장 품의 문서 근태 정보 저장 **/
	ResultVO insertTripConsAttend(Map<String, Object> params) throws Exception;
	/** 출장 품의 문서 예산 정보 저장 **/
	ResultVO insertTripConsBudget(Map<String, Object> params) throws Exception;
	/** 출장 품의 문서 과목 정보 저장 **/
	ResultVO insertTripConsBudgetErp(Map<String, Object> params) throws Exception;
	/** 출장 품의 문서 경비 내역 정보 저장 **/
	ResultVO insertTripConsExpense(Map<String, Object> params) throws Exception;
	/** 출장 품의 문서 출장자 정보 저장 **/
	ResultVO insertTripConsTraveler(Map<String, Object> params) throws Exception;

	/** 출장 품의 문서 근태 정보 갱신 **/
	ResultVO updateTripConsAttend(Map<String, Object> params) throws Exception;
	/** 출장 품의 문서 예산 정보 갱신 **/
	ResultVO updateTripConsBudget(Map<String, Object> params) throws Exception;
	/** 출장 품의 문서 과목 정보 갱신 **/
	ResultVO updateTripConsBudgetErp(Map<String, Object> params) throws Exception;
	/** 출장 품의 문서 경비 내역 정보 갱신 **/
	ResultVO updateTripConsExpense(Map<String, Object> params) throws Exception;
	/** 출장 품의 문서 출장자 정보 갱신 **/
	ResultVO updateTripConsTraveler(Map<String, Object> params) throws Exception;

	/** 출장 품의 문서 경비 내역 정보 삭제 **/
	ResultVO deleteTripConsExpense(Map<String, Object> params) throws Exception;
	/** 출장 품의 문서 출장자 정보 삭제 **/
	ResultVO deleteTripConsTraveler(Map<String, Object> params) throws Exception;
	/** 출장 품의 문서 근태 정보 삭제 **/
	ResultVO deleteTripConsAttend(Map<String, Object> params) throws Exception;
	/** 출장 품의 문서 예산 과목 정보 조회 **/
	ResultVO selectConsBudgetInfo (Map<String, Object> params) throws Exception;
	/** 출장 품의 문서 예산 과목 정보 삭제 **/
	ResultVO deleteTripConsBudgetInfo(Map<String, Object> params ) throws Exception;
	ResultVO deleteTripConsBudgetErpInfo(Map<String, Object> params ) throws Exception;

}

package expend.trip.user.cons;

import java.util.Map;

import common.vo.common.ResultVO;


public interface BTripUserConsService {

	
	/** 출장 품의 문서 생성 **/
	ResultVO insertTripConsDoc ( Map<String, Object> params ) throws Exception;

	/** 출장 품의 문서 정보 조회 **/
	ResultVO selectTripConsDocAllInfo ( Map<String, Object> params ) throws Exception;
	
	/** 비영리 2.0 품의 문서 정보 조회 **/
	ResultVO selectConsDocInfo ( Map<String, Object> params ) throws Exception;

	/** 사용자 출장 품의 현황 정보 조회 **/
	ResultVO selectTripConsReport ( Map<String, Object> params ) throws Exception;
	
	/** 사용자 출장 품의 인사정보, 경비내역 정보 저장 **/
	ResultVO insertTripConsAttExInfo(Map<String, Object> params) throws Exception;

	/** 사용자 출장 품의 인사정보, 경비내역 정보 업데이트 **/
	ResultVO updateTripConsAttExInfo(Map<String, Object> params) throws Exception;
	
	ResultVO insertTripConsBudgetInfo(Map<String, Object> params) throws Exception;
}

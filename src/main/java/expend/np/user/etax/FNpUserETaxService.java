package expend.np.user.etax;

import java.util.List;
import java.util.Map;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;

public interface FNpUserETaxService {

	/* 매입전자세금계산서 목록 조회 */
	ResultVO GetETaxApprovalList(ResultVO param, ConnectionVO conVo) throws Exception;

	ResultVO selectETaxList(Map<String, Object> param, ConnectionVO conVo) throws Exception;

	ResultVO selectWritingETaxList(Map<String, Object> param);

	List<Map<String, Object>> selectGWEtaxAuth(Map<String, Object> param);

	List<Map<String, Object>> selectETaxSendList(Map<String, Object> param);

	ResultVO NpUserETaxReflect(Map<String, Object> param) throws Exception;

	/* 매입전자세금계산서 이관 내역 조회 */
	ResultVO GetETaxTransHistoryList(ResultVO param) throws Exception;

	/* 이관받은 내역 조회 */
	List<Map<String, Object>> NpTransferETaxListSelect(Map<String, Object> param);

	/* ## ############################################# ## */
	/* 매입전자세금계산서 현황 및 기능 2차 구현 - 김상겸 */
	/* ## ############################################# ## */
	/**
	 * 매입전자세금계산서 이관 목록 조회
	 * 
	 * @param param
	 *            ( issDateFrom, issDateTo, compSeq, empSeq )
	 * @return ( compSeq, issNo, issDt, partnerNo, partnerName, transferSeq, transferName, receiveSeq, receiveName, supperKey )
	 * @throws Exception
	 */
	ResultVO GetETaxTransList(ResultVO param) throws Exception;


	/* ## ############################################# ## */
	/* 매입전자세금계산서 현황 및 기능 2차 구현 - 최상배 */
	/* ## ############################################# ## */
	/**
	 * 매입전자세금계산서 변경 목록및 옵션 조회
	 * 
	 * @param param
	 *            ( issDateFrom, issDateTo, compSeq, empSeq )
	 * @return 
	 * @throws Exception
	 */
	ResultVO GetETaxHistory(ResultVO param) throws Exception;
	
	/**
	 * 매입전자세금계산서 수신 목록 조회
	 * 
	 * @param param
	 *            ( issDateFrom, issDateTo, compSeq, empSeq )
	 * @return ( compSeq, issNo, issDt, partnerNo, partnerName, transferSeq, transferName, receiveSeq, receiveName, supperKey )
	 * @throws Exception
	 */
	ResultVO GetETaxReceiveList(ResultVO param) throws Exception;

	/**
	 * 매입전자세금계산서 권한 조회
	 * 
	 * @param param
	 *            ( compSeq, deptSeq, empSeq )
	 * @return ResultVO.aaData ( authType, useYN, name, code )
	 * @throws Exception
	 */
	ResultVO GetETaxAuthList(ResultVO param) throws Exception;

	/**
	 * 매입전자세금계산서 상신 목록 조회
	 * 
	 * @param param
	 *            ( issDateFrom, issDateTo, compSeq )
	 * @return ( syncId, issNo, issDt, trRegNb, compSeq, ifMId, ifDId, sendYn, useYn, docSeq, resDocSeq, resSeq, budgetSeq, tradeSeq, createEmpName )
	 * @throws Exception
	 */
	ResultVO GetETaxSendList(ResultVO param) throws Exception;

	/**
	 * 매입전자세금계산서 미사용 목록 조회
	 * 
	 * @param param
	 *            ( issDateFrom, issDateTo, compSeq )
	 * @return ( sync_id, iss_no, iss_dt, comp_seq, send_yn, use_yn )
	 * @throws Exception
	 */
	ResultVO GetETaxNotUseList(ResultVO param) throws Exception;

	ResultVO GetETaxList(ResultVO param, ConnectionVO conVo) throws Exception;
}
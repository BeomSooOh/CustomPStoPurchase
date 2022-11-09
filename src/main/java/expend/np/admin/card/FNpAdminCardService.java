package expend.np.admin.card;

import java.util.Map;

import common.vo.common.ResultVO;

public interface FNpAdminCardService {

	/**
	 * 카드 내역 미사용 처리 목록 조회
	 * 
	 * @param param
	 *            ( groupSeq, compSeq, empSeq )
	 * @return ( syncId )
	 * @throws Exception
	 */
	ResultVO GetNotUseList(ResultVO param) throws Exception;

	/**
	 * 카드 내역 현황 조회 ( 관리자 )
	 * 
	 * @param param
	 *            ( compSeq, cardAuthDateFrom, cardAuthDateTo, searchPartnerName, searchPartnerNo, searchGeoraeStat, searchAuthNum, searchSendYn, searchApprovalEmpName )
	 * @return ResultVO.aaData ( syncId, georaeStatName, georaeStat, authDate, authTime, authNum, partnerName, partnerNo, cardName, cardNum, reqAmt, stdAmt, vatAmt, serAmt, approvalStatName, approvalStat )
	 * @throws Exception
	 */
	ResultVO GetCardList(ResultVO param) throws Exception;

	/**
	 * 카드 내역 현황 조회 ( 관리자 ) 리뉴얼
	 * 
	 * @param param
	 *            ( compSeq, cardAuthDateFrom, cardAuthDateTo, searchPartnerName, searchPartnerNo, searchGeoraeStat, searchAuthNum, searchSendYn, searchApprovalEmpName )
	 * @return ResultVO.aaData ( syncId, georaeStatName, georaeStat, authDate, authTime, authNum, partnerName, partnerNo, cardName, cardNum, reqAmt, stdAmt, vatAmt, serAmt, approvalStatName, approvalStat )
	 * @throws Exception
	 */
	ResultVO GetCardList2(Map<String, Object> params) throws Exception;
	
	/**
	 * 카드 내역 이관
	 * 
	 * @param param
	 *            ( groupSeq, compSeq, syncId, cardNum, authNum, authDate, authTime, partnerNo, partnerName, reqAmt, empSeq, empName, receiveEmpSeq, receiveEmpName, receiveEmpSuperKey )
	 * @return
	 * @throws Exception
	 */
	ResultVO SetTransCardItem(ResultVO param) throws Exception;

	/**
	 * 카드 내역 사용 / 미사용 처리 ( 관리자 )
	 * 
	 * @param param
	 *            ( useYN, cardUseYNList )
	 * @return
	 * @throws Exception
	 */
	ResultVO SetCardUseYN(ResultVO param) throws Exception;

	/**
	 * 카드사용내역 이관 목록 조회
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	ResultVO GetCardTransHistoryList(ResultVO param) throws Exception;

	ResultVO GetCardBatchTime(Map<String, Object> params)throws Exception;
}

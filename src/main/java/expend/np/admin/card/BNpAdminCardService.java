package expend.np.admin.card;

import java.util.Map;

import common.vo.common.ResultVO;

public interface BNpAdminCardService {
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
	 * 카드 내역 현황 조회 리뉴얼 ( 관리자 )
	 * 
	 * @param param
	 *            ( compSeq, cardAuthDateFrom, cardAuthDateTo, searchPartnerName, searchPartnerNo, searchGeoraeStat, searchAuthNum, searchSendYn, searchApprovalEmpName )
	 * @return ResultVO.aaData ( syncId, georaeStatName, georaeStat, authDate, authTime, authNum, partnerName, partnerNo, cardName, cardNum, reqAmt, stdAmt, vatAmt, serAmt, approvalStatName, approvalStat )
	 * @throws Exception
	 */
	ResultVO GetCardList2(Map<String, Object> params) throws Exception;

	/**
	 * 카드 내역 이관 ( 관리자 )
	 * 
	 * @param param
	 *            ( groupSeq, compSeq, syncId, cardNum, authNum, authDate, authTime, partnerNo, partnerName, reqAmt, empSeq, empName, receiveEmpSeq, receiveEmpName, receiveEmpSuperKey )
	 * @return
	 * @throws Exception
	 */
	ResultVO SetCardTrans(ResultVO param) throws Exception;

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
	 * 카드사용내역 이관관리
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	ResultVO GetCardTransHistoryList(ResultVO param) throws Exception;

	ResultVO GetCardBatchTime(Map<String, Object> params) throws Exception;
}
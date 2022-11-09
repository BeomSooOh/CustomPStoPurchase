package expend.np.user.report;

import java.util.List;
import java.util.Map;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;

public interface FNpUserReportService {

	ResultVO selectUserConsList(Map<String, Object> params) throws Exception;

	List<Map<String, Object>> selectCardReport(Map<String, Object> params);

	/**
	 * 사용자 - 품의서 현황 - 품의 현황 조회
	 */
	ResultVO selectConsReport(Map<String, Object> params);

	/**
	 * 사용자 - 품의서 현황 - 반환 / 취소
	 */
	ResultVO updateConfferStatus(Map<String, Object> params);

	/**
	 * 사용자 - 품의서 현황 - 반환 / 취소
	 */
	ResultVO updateConfferBudgetStatus(Map<String, Object> params);

	/**
	 * 사용자 - 결의서 현황 - 품의 현황 조회
	 */
	ResultVO selectResReport(Map<String, Object> params);

	/**
	 * 관리자 - 품의서 현황 - 참조결의 리스트 조회
	 */
	ResultVO selectConsConfferResList(Map<String, Object> params) throws Exception;

	/**
	 * 관리자 - 품의서 현황 - 예산내역 조회
	 */
	ResultVO selectConsBudgetList(Map<String, Object> params) throws Exception;

	/**
	 * 사용자 - 매입전자세금계산서 리스트 조회
	 */
	List<Map<String, Object>> NPUserEtaxReportList(Map<String, Object> param, ConnectionVO conVo) throws Exception;

	/**
	 * 사용자 - 인터락 양식 생성 - 헤더 정보 조회
	 */
	ResultVO selectHeadInterlock(Map<String, Object> params);

	/**
	 * 사용자 - 인터락 양식 생성 - 컨텐츠 정보 조회
	 */
	ResultVO selectContentsInterlock(Map<String, Object> params);

	/**
	 * 사용자 - 인터락 양식 생성 - 컨텐츠 분할양식 정보 조회
	 */
	ResultVO selectDContentsInterlock(Map<String, Object> params);

	/**
	 * 사용자 - 인터락 양식 생성 - 양식 외부 시스템 연동 정보 조회 
	 */
	ResultVO selectDocumentInterfaceInfo(Map<String, Object> params);
	
	/**
	 * 사용자 - 인터락 양식 생성 - 합계 정보 조회
	 */
	ResultVO selectFooterInterlock(Map<String, Object> params);

	/**
	 * 사용자 - 카드내역 이관 내역 조회
	 */
	ResultVO selectCardTransHistoryList(Map<String, Object> params);

	/**
	 * 사용자 - 법인카드 사용내역 상세 정보 조회
	 */
	ResultVO NPUserCardDetailInfo(Map<String, Object> params);

	/**
	 * 사용자 - 매입전자 세금 계산서 사용내역 상세 정보 조회
	 */
	ResultVO NPUserETaxDetailInfo(Map<String, Object> params, ConnectionVO conVo);

	/* ## ############################################# ## */
	/* 매입전자세금계산서 현황 및 기능 2차 구현 - 김상겸 */
	/* ## ############################################# ## */
	/**
	 * 매입전자세금계산서 미사용 처리
	 * 
	 * @param param
	 *            ( issNo, issDt, trRegNb, ResultVO.groupSeq, ResultVO.compSeq, ResultVO.empSeq )
	 * @return ResultVO.resultCode
	 * @throws Exception
	 */
	ResultVO SetETaxUseN(ResultVO param) throws Exception;

	/**
	 * 매입전자세금계산서 사용 처리
	 * 
	 * @param param
	 *            ( issNo, issDt, trRegNb, ResultVO.groupSeq, ResultVO.compSeq, ResultVO.empSeq )
	 * @return ResultVO.resultCode
	 * @throws Exception
	 */
	ResultVO SetETaxUseY(ResultVO param) throws Exception;

	/**
	 * 매입전자세금계산서 이관 처리
	 * 
	 * @param param
	 * @return ( []eTaxTransList, receiveEmpSeq, receiveEmpName, receiveEmpSuperKey )
	 * @throws Exception
	 */

	ResultVO SetETaxTrans(ResultVO param) throws Exception;

	
}
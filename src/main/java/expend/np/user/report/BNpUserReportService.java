package expend.np.user.report;

import java.util.List;
import java.util.Map;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


public interface BNpUserReportService {

	ResultVO selectUserConsList ( Map<String, Object> params ) throws Exception;

	/**
	 * 사용자 - 나의 카드사용현황
	 */
	List<Map<String, Object>> selectCardReport ( Map<String, Object> params );

	/**
	 * 사용자 - 품의서 현황 - 품의서 현황 리스트 조회
	 */
	ResultVO selectConsReport ( Map<String, Object> params );

	/**
	 * 사용자 - 품의서 현황 - 품의서 반환/취소
	 */
	ResultVO updateConfferStatus ( Map<String, Object> params );

	/**
	 * 사용자 - 품의서 현황 - 품의서 예산내역 조회
	 */
	ResultVO selectConsBudgetList ( Map<String, Object> params ) throws Exception;
	
	/**
	 * 사용자 - 품의서 현황 - 참조결의서 리스트 조회
	 */
	ResultVO selectConsConfferResList ( Map<String, Object> params ) throws Exception;

	/**
	 * 사용자 - 품의서 현황 예산별 - 품의서 반환/취소
	 */
	ResultVO updateConfferBudgetStatus ( Map<String, Object> params );
	
	/**
	 * 사용자 - 결의서 현황 - 결의서 현황 리스트 조회
	 */
	ResultVO selectResReport ( Map<String, Object> params );

	/**
	 * [interlock] 사용자 - 2차 외부 시스템연동 인터락 정보 조회
	 */
	ResultVO ExReportAdvInterLockInfoSelect ( Map<String, Object> params ) throws Exception;
	
	/**
	 * [header] 사용자 - 전자결재 interlock 생성
	 */
	ResultVO ExReportHeaderInterLockInfoSelect ( Map<String, Object> params ) throws Exception;

	/**
	 * [contents] 사용자 - 전자결재 interlock 생성
	 */
	ResultVO ExReportContentsInterLockInfoSelect ( Map<String, Object> params ) throws Exception;

	/**
	 * [contents] 사용자 - 전자결재 interlock 생성 / 분할구조 용
	 */
	ResultVO ExReportDContentsInterLockInfoSelect ( Map<String, Object> params ) throws Exception;

	/**
	 * [footer] 사용자 - 전자결재 interlock 생성
	 */
	ResultVO ExReportFooterInterLockInfoSelect ( Map<String, Object> params ) throws Exception;

	/**
	 * 사용자 - 매입전자세금계산서 현황
	 */
	ResultVO NPUserETaxReportList ( ResultVO param, ConnectionVO conVo ) throws Exception;

	/**
	 * 사용자 - 카드내역 이관 히스토리
	 */
	ResultVO NPUserCardTransHistoryList ( Map<String, Object> params ) throws Exception;

	/**
	 * 사용자 - 카드내역 상세 정보 조회
	 */
	ResultVO NPUserCardDetailInfo ( Map<String, Object> params ) throws Exception;
	
	/**
	 * 사용자 - 매입전자 세금계산서 상세 정보 조회
	 */
	ResultVO NPUserETaxDetailInfo ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;	
	
	/* ## ############################################# ## */
	/* 매입전자세금계산서 현황 및 기능 2차 구현 - 김상겸 */
	/* ## ############################################# ## */
	/**
	 * 매입전자세금계산서 미사용 처리
	 * 
	 * @param param
	 *            ( issNo, issDt, trRegNb, ResultVO.groupSeq,
	 *            ResultVO.compSeq, ResultVO.empSeq )
	 * @return ResultVO.resultCode
	 * @throws Exception
	 */
	ResultVO SetETaxUseUpdateN(ResultVO param) throws Exception;

	/**
	 * 매입전자세금계산서 사용 처리
	 * 
	 * @param param
	 *            ( issNo, issDt, trRegNb, ResultVO.groupSeq,
	 *            ResultVO.compSeq, ResultVO.empSeq )
	 * @return ResultVO.resultCode
	 * @throws Exception
	 */
	ResultVO SetETaxUseUpdateY(ResultVO param) throws Exception;
	
	/**
	 * 매입전자세금계산서 이관 처리
	 * @param param
	 * @return ( []eTaxTransList, receiveEmpSeq, receiveEmpName, receiveEmpSuperKey )
	 * @throws Exception
	 */
	ResultVO SetETaxTrans(ResultVO param) throws Exception;
}

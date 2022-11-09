/**
  * @FileName : FApprovalService.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package interlock.exp.approval;

import java.util.Map;

import common.vo.common.ResultVO;
import common.vo.interlock.InterlockExpendVO;
import common.vo.np.NpOutInterfaceVO;

/**
 *   * @FileName : FApprovalService.java   * @Project : BizboxA_exp   * @변경이력 :
 *   * @프로그램 설명 :   
 */
public interface FApprovalService {

	/* 전자결재 연동 */
	/* 전자결재 연동 - 상신준비 */
	String ApprovalContentInfoSelect(String docSeq) throws Exception;

	/* 전자결재 연동 - 본문생성 */
	Map<String, Object> CardAqSendYnUpdate(Map<String, Object> params) throws Exception;

	/* ################################################## */
	/* [회계API] 보관 */
	/* ################################################## */
	public InterlockExpendVO ApprovalProcessSave(Map<String, Object> params) throws Exception;

	/* ################################################## */
	/* [회계API] 상신 */
	/* ################################################## */
	public InterlockExpendVO ApprovalProcessApproval(Map<String, Object> params) throws Exception;

	/* ################################################## */
	/* [회계API] 종결 */
	/* ################################################## */
	public InterlockExpendVO ApprovalProcessEnd(Map<String, Object> params) throws Exception;

	/* ################################################## */
	/* [회계API] 반려 */
	/* ################################################## */
	public InterlockExpendVO ApprovalProcessReturn(Map<String, Object> params) throws Exception;

	/* ################################################## */
	/* [회계API] 삭제 */
	/* ################################################## */
	public InterlockExpendVO ApprovalProcessDelete(Map<String, Object> params) throws Exception;

	/* 전자결재 연동 - 분개 상세 팝업 */
	public ResultVO ApprovalSlipDetailInfoSelect(Map<String, Object> params) throws Exception;

	/* 전자결재 연동 - 관리항목 상세 팝업 */
	public ResultVO ApprovalMngDetailInfoSelect(Map<String, Object> params) throws Exception;

	/* 전자결재 연동 - 첨부파일정보 조회 */
	public ResultVO ApprovalSelectAttachInfo(Map<String, Object> params) throws Exception;

	/* ################################################## */
	/* [회계API] 첨부파일 상세 정보 조회 */
	/* ################################################## */
	public ResultVO SelectApprovalAttachInfo(Map<String, Object> params) throws Exception;

	/* ################################################## */
	/* [회계API] 적요 상세 정보 조회 */
	/* ################################################## */
	public ResultVO SelectApprovalListInfo(Map<String, Object> params) throws Exception;

	/* ################################################## */
	/* [회계API] 분개 상세 정보 조회 */
	/* ################################################## */
	public ResultVO SelectApprovalSlipInfo(Map<String, Object> params) throws Exception;

	/* ################################################## */
	/* [회계API] 국고보조통합시스템 */
	/* ################################################## */
	/* 상신 / 보관 */
	public InterlockExpendVO ApprovalProcessSaveAngu(Map<String, Object> params) throws Exception;

	/* 종결 */
	public InterlockExpendVO ApprovalProcessEndAngu(Map<String, Object> params) throws Exception;

	/* 반려 */
	public InterlockExpendVO ApprovalProcessReturnAngu(Map<String, Object> params) throws Exception;

	/* 품의서 2.0 */
	/* 상신 / 보관 */
	public InterlockExpendVO ApprovalProcessSaveCons(Map<String, Object> params) throws Exception;

	/* 종결 */
	public InterlockExpendVO ApprovalProcessEndCons(Map<String, Object> params) throws Exception;

	/* 반려 */
	public InterlockExpendVO ApprovalProcessReturnCons(Map<String, Object> params) throws Exception;

	/* 삭제 */
	public InterlockExpendVO ApprovalProcessDeleteCons(Map<String, Object> params) throws Exception;

	/* 결의서 2.0 */
	/* 상신 / 보관 */
	public InterlockExpendVO ApprovalProcessSaveRes(Map<String, Object> params) throws Exception;

	/* 종결 */
	public InterlockExpendVO ApprovalProcessEndRes(Map<String, Object> params) throws Exception;

	/* 반려 */
	public InterlockExpendVO ApprovalProcessReturnRes(Map<String, Object> params) throws Exception;

	/* 삭제 */
	public InterlockExpendVO ApprovalProcessDeleteRes(Map<String, Object> params) throws Exception;

	/* 결재문서 정보 조회 */
	public ResultVO ApprovalInfoSelect(Map<String, Object> params) throws Exception;

	/* 품의서 2.0 / 결의서 2.0 외부 연동 */
	/* 품의서 2.0 / 결의서 2.0 외부 연동 - API 호출 */
	void NpOutInterface(Map<String, Object> params) throws Exception;
	
	/* 품의서 2.0 / 결의서 2.0 외부 연동 - 품의서 외부 연동 정보 조회 */
	public NpOutInterfaceVO ConsOutInterfaceSelect(NpOutInterfaceVO params) throws Exception;

	/* 품의서 2.0 / 결의서 2.0 외부 연동 - 결의서 외부 연동 정보 조회 */
	public NpOutInterfaceVO ResOutInterfaceSelect(NpOutInterfaceVO params) throws Exception;

	/* 품의서 2.0 / 결의서 2.0 외부 연동 - 호출 이력 기록 */
	public void OutInterfaceHisInsert(NpOutInterfaceVO params) throws Exception;
	
	/* 전자결재 상태에 따른 추가 외부연동  사용여부 조회 */
	public String SelectAdvInterInfoCount (Map<String, Object> params) throws Exception;
	
	/* 전자결재 상태에 따른 추가 외부연동  연동 로직 조회 */
	public Map<String, Object> SelectAdvInterInfo (Map<String, Object> params) throws Exception;
	
	/********************** 출장복명 2.0 *************************/
	/* 출장 품의서 */
	/* 상신 / 보관 */
	public InterlockExpendVO ApprovalProcessTripCons(Map<String, Object> params) throws Exception;

	/* 출장 결의서 */
	/* 상신 / 보관 */
	public InterlockExpendVO ApprovalProcessTripRes(Map<String, Object> params) throws Exception;

	/********************** iCUBE 법인카드 결재 상태 동기화 *************************/
	
	/* 법인카드 승인내역 정보 조회 */
	public ResultVO SelectICubeCard_EXP ( Map<String, Object> params ) throws Exception ;
	public ResultVO SelectICubeCard_NP ( Map<String, Object> params ) throws Exception ;
	public ResultVO SelectICubeCardKey ( Map<String, Object> params ) throws Exception ;
}

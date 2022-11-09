/**
  * @FileName : BApprovalService.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package interlock.exp.approval;

import java.util.Map;

import common.vo.common.ResultVO;
import common.vo.interlock.InterlockExpendVO;


/**
 *   * @FileName : BApprovalService.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
public interface BApprovalService {

	/* [전자결재 API] 결재 문서 생성 */
	/* params : processId, approKey, interlockUrl, interlockName, form_id, module, [map]header, [list]content, [map]footer */
	/* [form_d_tp] processId || formDTp || form_d_tp : EXPENDA || EXPENDI || EXPENDU */ /* >> 전자결재 따라감 */
	/* approKey : 전자결재 내에서 고유해야하는 값... [ ex) EXP_EXPENDA_{expend_seq} ] */ /* >> 회계에서 정의 */
	/* interlockUrl : 이전단계 url */ /* >> 회계에서 정의 */
	/* interlockName : 이전단계 버튼 명칭 */ /* 회계에서 정의 */
	/* form_id || formSeq || formId : 양식 아이디 */ /* 전자결재 따라감 */
	ResultVO DocMake ( ResultVO params );

	/* [전자결재 API] 결재 문서 본문 수정 */ /* 나중에 구현 */
	Map<String, Object> DocContentEdit ( Map<String, Object> params );

	/* [회계API] 본문조회 */
	String ApprovalProcessContent ( String docSeq, String empSeq );

	/* [회계API] 보관 */
	InterlockExpendVO ApprovalProcessSave ( Map<String, Object> params ) throws Exception;

	/* [회계API] 상신 */
	InterlockExpendVO ApprovalProcessApproval ( Map<String, Object> params ) throws Exception;

	/* [회계API] 종결 */
	InterlockExpendVO ApprovalProcessEnd ( Map<String, Object> params ) throws Exception;

	/* [회계API] 반려 */
	InterlockExpendVO ApprovalProcessReturn ( Map<String, Object> params ) throws Exception;

	/* [회계API] 삭제 */
	InterlockExpendVO ApprovalProcessDelete ( Map<String, Object> params ) throws Exception;

	/* [회계API] 분개 상세 팝업 */
	ResultVO ApprovalSlipDetailInfoSelect ( Map<String, Object> params ) throws Exception;

	/* [회계API] 관리항목 상세 팝업 */
	ResultVO ApprovalMngDetailInfoSelect ( Map<String, Object> params ) throws Exception;

	/* [회계API-팝업] 첨부파일 확인 팝업 내용 조회 */
	ResultVO SelectApprovalAttachInfo ( Map<String, Object> params ) throws Exception;

	/* [회계API-팝업] 적요 상세 내용 조회 */
	ResultVO SelectApprovalListInfo ( Map<String, Object> params ) throws Exception;

	/* [회계API-팝업] 분개 상세 내용 조회 */
	ResultVO SelectApprovalSlipInfo ( Map<String, Object> params ) throws Exception;
	
	/* 결재문서 정보 조회 */
	ResultVO ApprovalInfoSelect ( Map<String, Object> params ) throws Exception;
	
	/* 외부데이터 전자결재 상태에 따른 추가 연동 진행 여부 확인 */
	public String SelectAdvInterInfoCount ( Map<String, Object> params ) throws Exception ;
	
	/* 외부데이터 전자결재 상태에 따른 추가 연동 진행 */
	public ResultVO ExcuteAdvInter ( Map<String, Object> params ) throws Exception ;
	
	/* 외부데이터 전자결재 상태에 따른 추가 연동 진행 */
	public ResultVO ExcuteAdvInterICubeCard ( Map<String, Object> params ) throws Exception ;
	
	ResultVO UpdateInterlockForm ( Map<String, Object> params ) throws Exception;

	ResultVO CopyInterlock(Map<String, Object> params) throws Exception;
	
	
}

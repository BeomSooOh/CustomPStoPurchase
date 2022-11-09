/**
  * @FileName : BAnguUserAnguService.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.angu.user.angu;

import common.vo.common.ResultVO;


/**
 *   * @FileName : BAnguUserAnguService.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
public interface BAnguUserAnguService {

	/* ## [+] 국고보조 v2 ## */
	/* ## [+] 국고보조 v2 ## - 국고보조 집행등록 문서 생성 */
	ResultVO setAnguDocument_Insert ( ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - 국고보조 집행등록 abdocu 생성 */
	ResultVO setAnguDocumentAbdocu_Insert ( ResultVO result, String anbojoSeq ) throws Exception;

	/* ## [+] 국고보조 v2 ## - 국고보조 집행등록 abdocu_b 생성 */
	ResultVO setAnguDocumentAbdocuB_Insert ( ResultVO result, String anbojoSeq, String dSeq ) throws Exception;

	/* ## [+] 국고보조 v2 ## - 국고보조 집행등록 abdocu_t 생성 */
	ResultVO setAnguDocumentAbdocuT_Insert ( ResultVO result, String anbojoSeq, String dSeq, String bSeq ) throws Exception;
	/* ## [-] 국고보조 v2 ## */

	/* 국고보조 결의집행 작성 */
	/* --------------------------------------- */
	/* iCUBE 환경설정 정보 조회 - 거래처통장표시내용, 보조금통장표시내용 */
	public ResultVO TermInfoS ( ResultVO result ) throws Exception;

	/* 국고보조 집행등록 문서 생성 */
	public ResultVO AnguI ( ResultVO result ) throws Exception;

	/* 국고보조 집행등록 인력정보 등록 생성 */
	public ResultVO AnguPayI ( ResultVO result ) throws Exception;

	/* 국고보조 집행등록 문서 갱신 */
	public ResultVO AnguU ( ResultVO result ) throws Exception;

	/* 국고보조 집행등록 기수 정보 조회 */
	public ResultVO GisuInfoS ( ResultVO result ) throws Exception;

	/* 국고보조 집행등록 사용자 정보 조회 */
	public ResultVO EmpInfoS ( ResultVO result ) throws Exception;

	/* 국고보조 집행등록 전자결재 상신 준비 */
	public ResultVO AnguApprovalI ( ResultVO result ) throws Exception;

	/* 국고보조 결의집행 iCUBE 생성 */
	/* --------------------------------------- */
	/* 결의내역 + 증빙내역 생성 */
	public ResultVO AbdocuHDI ( ResultVO result ) throws Exception;

	/* 비목내역 생성 */
	public ResultVO AbdocuBI ( ResultVO result ) throws Exception;

	/* 재원정보 생성 */
	public ResultVO AbdocuTI ( ResultVO result ) throws Exception;

	/* 인력정보 등록 */
	public ResultVO AbdocuPayI ( ResultVO result ) throws Exception;

	/* 국고보조 결의집행 iCUBE, Bizbox Alpha 동기화 */
	/* --------------------------------------- */
	/* iCUBE + Bizbox Alpha 결의내역 동기화 */
	public ResultVO AbdocuSyncU ( ResultVO result ) throws Exception;

	/* 상신전 오류 발생시 삭제 처리 */
	public ResultVO AbdocuApprovalDel ( ResultVO result ) throws Exception;
}

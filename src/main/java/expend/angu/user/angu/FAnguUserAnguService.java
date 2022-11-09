/**
  * @FileName : FAnguUserAnguService.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.angu.user.angu;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


/**
 *   * @FileName : FAnguUserAnguService.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
public interface FAnguUserAnguService {

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

	/* iCUBE 환경설정 정보 조회 - 거래처통장표시내용, 보조금통장표시내용 */
	ResultVO TermInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception;

	/* 국고보조 집행등록 문서 생성 */
	ResultVO AnguI ( ResultVO result, ConnectionVO conVo ) throws Exception;

	/* 국고보조 집행등록 인력정보 등록 생성 */
	ResultVO AnguPayI ( ResultVO result, ConnectionVO conVo ) throws Exception;

	/* 국고보조 집행등록 문서 갱신 */
	ResultVO AnguU ( ResultVO result, ConnectionVO conVo ) throws Exception;

	/* 국고보조 집행등록 기수 정보 조회 */
	ResultVO GisuInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception;

	/* 국고보조 집행등록 사용자 정보 조회 */
	ResultVO EmpInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception;

	/* 국고보조 집행등록 전자결재 상신 준비 */
	ResultVO AnguApprovalI ( ResultVO result, ConnectionVO conVo ) throws Exception;

	/* 상신전 오류 발생시 삭제 처리 */
	ResultVO AbdocuApprovalDel ( ResultVO result ) throws Exception;
}

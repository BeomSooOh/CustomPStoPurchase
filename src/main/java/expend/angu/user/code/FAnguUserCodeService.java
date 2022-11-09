/**
  * @FileName : FAnguUserCodeService.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.angu.user.code;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


/**
 *   * @FileName : FAnguUserCodeService.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
public interface FAnguUserCodeService {

	/* ## [+] 국고보조 v2 ## */
	/* ## [+] 국고보조 v2 ## - ERP 사원정보 및 기수정보 조회 */
	ResultVO getEmpInfoI_Select ( ConnectionVO conVo, ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - ERP 통장표시내용 환경 설정 */
	ResultVO getAnguTermInfoI_Select ( ConnectionVO conVo, ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - ERP 국고보조사업 조회 */
	ResultVO getAnguBusinessInfoI_Select ( ConnectionVO conVo, ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - 이체계좌구분 */
	ResultVO getAnguAccountDivInfoI_Select ( ConnectionVO conVo, ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - 자계좌이체사유코드 */
	ResultVO getAnguAccountReasonDivInfoI_Select ( ConnectionVO conVo, ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - 증빙승인번호 - 전자세금계산서(과세) */
	ResultVO getAnguEtaxTaxInfoI_Select ( ConnectionVO conVo, ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - 증빙승인번호 - 전자세금계산서(면세) */
	ResultVO getAnguEtaxTaxFreeInfoI_Select ( ConnectionVO conVo, ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - 증빙승인번호 - 카드 */
	ResultVO getAnguCardAuthI_Select ( ConnectionVO conVo, ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - 증빙승인번호 - 카드 승인 내역 */
	ResultVO getAnguCardInfoI_Select ( ConnectionVO conVo, ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - 증빙 - 사원 */
	ResultVO getAnguEmpInfoI_Select ( ConnectionVO conVo, ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - 증빙 - 거래처 */
	ResultVO getAnguPartnerInfoI_Select_01 ( ConnectionVO conVo, ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - 증빙 - 거래처 계좌 */
	ResultVO getAnguPartnerInfoI_Select_02 ( ConnectionVO conVo, ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - 증빙 - 금융기관(iCUBE G20) */
	ResultVO getAnguG20BankInfoI_Select_01 ( ConnectionVO conVo, ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - 증빙 - 금융기관(e나라도움) */
	ResultVO getAnguG20BankInfoI_Select_02 ( ConnectionVO conVo, ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - 보조비목세목 */
	ResultVO getAnguBimokInfoI_Select ( ConnectionVO conVo, ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - 재원구분 */
	ResultVO getAnguJaewonInfoI_Select ( ConnectionVO conVo, ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - 국고보조 집행 금액 조회 */
	ResultVO getAnguResultAmtInfoI_Select ( ConnectionVO conVo, ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - 프로젝트 조회 */
	ResultVO getAnguProjectInfoI_Select ( ConnectionVO conVo, ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - 예산과목 조회 */
	ResultVO getAnguBgtInfoI_Select ( ConnectionVO conVo, ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - 금융거래처 조회 */
	ResultVO getAnguBankPartnerInfoI_Select ( ConnectionVO conVo, ResultVO result ) throws Exception;
	/* ## [-] 국고보조 v2 ## */

	/* 코드 - 국고보조사업 */
	ResultVO DdtlbzInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception;

	/* 코드 - 이체계좌구분 */
	ResultVO TransfracnutseInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception;

	/* 코드 - 자계좌이체사유코드 */
	ResultVO SbsacnttrfrsnInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception;

	/* 코드 - 증빙승인번호 - 카드 */
	ResultVO PrufsenoCardS ( ResultVO result, ConnectionVO conVo ) throws Exception;

	/* 코드 - 증빙승인번호 */
	ResultVO PrufsenoInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception;

	/* 코드 - 코드 */
	ResultVO TrInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception;

	/* 코드 - 금융기관 */
	ResultVO BcncbankInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception;

	/* 코드 - 보조비목세목코드 */
	ResultVO AsstntaxitmInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception;

	/* 코드 - 재원구분 */
	ResultVO FnrscseInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception;

	/* 코드 - 프로젝트 */
	ResultVO MgtInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception;

	/* 코드 - 에산과목 레벨 */
	ResultVO AbgtLevelInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception;

	/* 코드 - 예산과목 */
	ResultVO AbgtInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception;

	/* 코드 - 코드 */
	ResultVO BtrInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception;

	/* 코드 - 금액집계 */
	ResultVO AmountInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception;

	/* 인력정보등록 - 코드 */
	ResultVO HpmeticInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception;

	/* 인력정보등록 - 소득구분 */
	ResultVO PayTpInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception;

	/* 카드 */
	ResultVO CardInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception;

	/* 연동 거래처 정보 조회 */
	ResultVO LinkPartnerInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception;

	/* 연동 금융 거래처 정보 조회 */
	ResultVO LinkBankInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception;
}

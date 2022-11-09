/**
  * @FileName : BAnguUserCodeService.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.angu.user.code;

import common.vo.common.ResultVO;


/**
 *   * @FileName : BAnguUserCodeService.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
public interface BAnguUserCodeService {

	/* ## [+] 국고보조 v2 ## */
	/* iCUBE - 사용자 정보 조회 ( 회사, 사업장, 부서 ) */
	ResultVO getEmpInfoI_Select ( ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - ERP 통장표시내용 환경 설정 */
	ResultVO getAnguTermInfoI_Select ( ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - ERP 국고보조사업 조회 */
	ResultVO getAnguBusinessInfoI_Select ( ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - 이체계좌구분 */
	ResultVO getAnguAccountDivInfoI_Select ( ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - 자계좌이체사유코드 */
	ResultVO getAnguAccountReasonDivInfoI_Select ( ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - 증빙승인번호 - 전자세금계산서(과세) */
	ResultVO getAnguEtaxTaxInfoI_Select ( ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - 증빙승인번호 - 전자세금계산서(면세) */
	ResultVO getAnguEtaxTaxFreeInfoI_Select ( ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - 증빙승인번호 - 카드 */
	ResultVO getAnguCardAuthI_Select ( ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - 증빙승인번호 - 카드 승인 내역 */
	ResultVO getAnguCardInfoI_Select ( ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - 증빙 - 사원 */
	ResultVO getAnguEmpInfoI_Select ( ResultVO result ) throws Exception;
	
	/* ## [+] 국고보조 v2 ## - 증빙 - 거래처 */
	ResultVO getAnguPartnerInfoI_Select_01 ( ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - 증빙 - 거래처 계좌 */
	ResultVO getAnguPartnerInfoI_Select_02 ( ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - 증빙 - 금융기관(iCUBE G20) */
	ResultVO getAnguG20BankInfoI_Select_01 ( ResultVO result ) throws Exception;
	
	/* ## [+] 국고보조 v2 ## - 증빙 - 금융기관(e나라도움) */
	ResultVO getAnguG20BankInfoI_Select_02 ( ResultVO result ) throws Exception;
	
	/* ## [+] 국고보조 v2 ## - 보조비목세목 */
	ResultVO getAnguBimokInfoI_Select ( ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - 재원구분 */
	ResultVO getAnguJaewonInfoI_Select ( ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - 국고보조 집행 금액 조회 */
	ResultVO getAnguResultAmtInfoI_Select ( ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - 프로젝트 조회 */
	ResultVO getAnguProjectInfoI_Select ( ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - 예산과목 조회 */
	ResultVO getAnguBgtInfoI_Select ( ResultVO result ) throws Exception;

	/* ## [+] 국고보조 v2 ## - 금융거래처 조회 */
	ResultVO getAnguBankPartnerInfoI_Select ( ResultVO result ) throws Exception;
	/* ## [-] 국고보조 v2 ## */

	/* 코드 - 국고보조사업 */
	public ResultVO DdtlbzInfoS ( ResultVO result ) throws Exception;

	/* 코드 - 이체계좌구분 */
	public ResultVO TransfracnutseInfoS ( ResultVO result ) throws Exception;

	/* 코드 - 자계좌이체사유코드 */
	public ResultVO SbsacnttrfrsnInfoS ( ResultVO result ) throws Exception;

	/* 코드 - 증빙승인번호 - 카드 */
	public ResultVO PrufsenoCardS ( ResultVO result ) throws Exception;

	/* 코드 - 증빙승인번호 */
	public ResultVO PrufsenoInfoS ( ResultVO result ) throws Exception;

	/* 코드 - 코드 */
	public ResultVO TrInfoS ( ResultVO result ) throws Exception;

	/* 코드 - 금융기관 */
	public ResultVO BcncbankInfoS ( ResultVO result ) throws Exception;

	/* 코드 - 보조비목세목코드 */
	public ResultVO AsstntaxitmInfoS ( ResultVO result ) throws Exception;

	/* 코드 - 재원구분 */
	public ResultVO FnrscseInfoS ( ResultVO result ) throws Exception;

	/* 코드 - 프로젝트 */
	public ResultVO MgtInfoS ( ResultVO result ) throws Exception;

	/* 코드 - 에산과목 레벨 */
	public ResultVO AbgtLevelInfoS ( ResultVO result ) throws Exception;

	/* 코드 - 예산과목 */
	public ResultVO AbgtInfoS ( ResultVO result ) throws Exception;

	/* 코드 - 코드 */
	public ResultVO BtrInfoS ( ResultVO result ) throws Exception;

	/* 금액집계 */
	public ResultVO AmountInfoS ( ResultVO result ) throws Exception;

	/* 인력정보등록 - 코드 */
	public ResultVO HpmeticInfoS ( ResultVO result ) throws Exception;

	/* 인력정보등록 - 소득구분 */
	public ResultVO PayTpInfoS ( ResultVO result ) throws Exception;

	/* 카드 */
	public ResultVO CardInfoS ( ResultVO result ) throws Exception;

	/* 연동 거래처 정보 조회 */
	public ResultVO LinkPartnerInfoS ( ResultVO result ) throws Exception;

	/* 연동 금융 거래처 정보 조회 */
	public ResultVO LinkBankInfoS ( ResultVO result ) throws Exception;
}

package expend.ex.user.code;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Repository;
import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExCodeAcctVO;
import common.vo.ex.ExCodeAuthVO;
import common.vo.ex.ExCodeBudgetVO;
import common.vo.ex.ExCodeCardPublicVO;
import common.vo.ex.ExCodeCardVO;
import common.vo.ex.ExCodeOrgVO;
import common.vo.ex.ExCodePartnerVO;
import common.vo.ex.ExCodeProjectVO;
import common.vo.ex.ExCodeSummaryVO;
import common.vo.ex.ExCommonResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import main.web.BizboxAMessage;


@Repository ( "FExUserCodeServiceADAO" )
public class FExUserCodeServiceADAO extends EgovComAbstractDAO {

	/* Common - 사용자 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExUserEmpListInfoSelect ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = list( "FExUserCodeServiceADAO.ExUserEmpListInfoSelect", params );
		return result;
	}

	/* Common - 프로젝트 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExUserProjectListInfoSelect ( Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = list( "FExUserCodeServiceADAO.ExUserProjectListInfoSelect", params );
		return result;
	}

	/* Common - 거래처 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExUserPartnerListInfoSelect ( Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = list( "FExUserCodeServiceADAO.ExUserPartnerListInfoSelect", params );
		return result;
	}

	/* Common - 카드 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExUserCardListInfoSelect ( Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = list( "FExUserCodeServiceADAO.ExUserCardListInfoSelect", params );
		return result;
	}

	/* ---------------------------------- acct ---------------------------------- */
	/* Bizbox Alpha - 표준적요 */
	/* Bizbox Alpha - 표준적요 - 목록 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExUserSummaryListInfoSelect ( Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = list( "FExUserCodeServiceADAO.ExUserSummaryListInfoSelect", params );
		return result;
	}

	/* Bizbox Alpha - 증빙유형 */
	/* Bizbox Alpha - 증빙유형 - 목록 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExUserAuthListInfoSelect ( Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = list( "FExUserCodeServiceADAO.ExUserAuthListInfoSelect", params );
		return result;
	}

	/* 공통코드 */
	/* 공통코드 - 계정과목 생성 */
	public ExCodeAcctVO ExCodeAcctInfoInsert ( ExCodeAcctVO acctVo ) throws Exception {
		/* parameters : comp_seq, acct_code, acct_name, vat_yn, use_yn, create_seq, modify_seq */
		insert( "ExCodeAcctInfoInsert", acctVo );
		return acctVo;
	}

	/* 공통코드 - 계정과목 수정 */
	public ExCommonResultVO ExCodeAcctInfoUpdate ( ExCodeAcctVO acctVo ) throws Exception {
		/* parameters : acct_name, vat_yn, use_yn, modify_seq, comp_seq, acct_code */
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		/* ibatis 에서 update() 실행시 return 값 : 성공시 "1" / 실패시 "0" */
		if ( update( "ExCodeAcctInfoUpdate", acctVo ) > 0 ) {
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( acctVo ) );
		}
		else {
			resultVo.setCode( commonCode.FAIL );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( acctVo ) );
		}
		return resultVo;
	}

	/* 공통코드 - 계정과목 삭제 */
	public ExCommonResultVO ExCodeAcctInfoDelete ( ExCodeAcctVO acctVo ) throws Exception {
		/* parameters : comp_seq, acct_code */
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		/* ibatis 에서 delete() 실행시 return 값 : 삭제한 row 수 */
		if ( delete( "ExCodeAcctInfoDelete", acctVo ) > 0 ) {
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( acctVo ) );
		}
		else {
			resultVo.setCode( commonCode.FAIL );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( acctVo ) );
		}
		return resultVo;
	}

	/* 공통코드 - 계정과목 조회 */
	public ExCodeAcctVO ExCodeAcctInfoSelect ( ExCodeAcctVO acctVo ) throws Exception {
		/* parameters : comp_seq, use_yn, vat_yn, search_str, search_str */
		acctVo = (ExCodeAcctVO) select( "ExCodeAcctInfoSelect", acctVo );
		return acctVo;
	}

	/* 공통코드 - 계정과목 목록 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<ExCodeAcctVO> ExCodeAcctListInfoSelect ( ExCodeAcctVO acctVo ) throws Exception {
		/* parameters : comp_seq, use_yn, vat_yn, search_str, search_str */
		List<ExCodeAcctVO> acctListVo = new ArrayList<ExCodeAcctVO>( );
		acctListVo = list( "ExCodeAcctListInfoSelect", acctVo );
		return acctListVo;
	}

	/* 공통코드 - 대변 계정과목 조회 */
	public ExCodeAcctVO ExCodeAcctCrInfoSelect ( ExCodeAcctVO acctVo ) throws Exception {
		/* parameters : comp_seq, use_yn, search_str, search_str */
		acctVo = (ExCodeAcctVO) select( "ExCodeAcctCrInfoSelect", acctVo );
		return acctVo;
	}

	/* 공통코드 - 대변 계정과목 목록 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<ExCodeAcctVO> ExCodeAcctCrListInfoSelect ( ExCodeAcctVO acctVo ) throws Exception {
		/* parameters : comp_seq, use_yn, search_str, search_str */
		List<ExCodeAcctVO> acctListVo = new ArrayList<ExCodeAcctVO>( );
		acctListVo = list( "ExCodeAcctCrListInfoSelect", acctVo );
		return acctListVo;
	}

	/* 공통코드 - 부가세 계정과목 조회 */
	public ExCodeAcctVO ExCodeAcctVatInfoSelect ( ExCodeAcctVO acctVo ) throws Exception {
		/* parameters : comp_seq, use_yn, search_str, search_str */
		acctVo = (ExCodeAcctVO) select( "ExCodeAcctVatInfoSelect", acctVo );
		return acctVo;
	}

	/* 공통코드 - 부가세 계정과목 목록 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<ExCodeAcctVO> ExCodeAcctVatListInfoSelect ( ExCodeAcctVO acctVo ) throws Exception {
		/* parameters : comp_seq, use_yn, search_str, search_str */
		List<ExCodeAcctVO> acctListVo = new ArrayList<ExCodeAcctVO>( );
		acctListVo = list( "ExCodeAcctVatListInfoSelect", acctVo );
		return acctListVo;
	}

	/* 공통코드 - 차변 계정과목 조회 */
	public ExCodeAcctVO ExCodeAcctDrInfoSelect ( ExCodeAcctVO acctVo ) throws Exception {
		/* parameters : comp_seq, use_yn, search_str, search_str */
		acctVo = (ExCodeAcctVO) select( "ExCodeAcctDrInfoSelect", acctVo );
		return acctVo;
	}

	/* 공통코드 - 차변 계정과목 목록 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<ExCodeAcctVO> ExCodeAcctDrListInfoSelect ( ExCodeAcctVO acctVo ) throws Exception {
		/* parameters : comp_seq, use_yn, search_str, search_str */
		List<ExCodeAcctVO> acctListVo = new ArrayList<ExCodeAcctVO>( );
		acctListVo = list( "ExCodeAcctDrListInfoSelect", acctVo );
		return acctListVo;
	}

	/* ----------------------------------------------------------------------------- */
	/* ---------------------------------- auth ----------------------------------- */
	/* ----------------------------------------------------------------------------- */
	/* 지출결의 - 증빙유형 등록 */
	public ExCodeAuthVO ExExpendAuthInfoInsert ( ExCodeAuthVO authVo ) throws Exception {
		/* parameters : auth_div, auth_code, auth_name, cash_type, cr_acct_code, cr_acct_name , vat_acct_code, vat_acct_name, vat_type_code, vat_type_name, erp_auth_code , erp_auth_name, auth_required_yn, partner_required_yn, card_required_yn , project_required_yn, note_required_yn, no_tax_code, no_tax_name, va_type_code , va_type_name, create_seq, modify_seq, seq */
		authVo.setSeq( (int) insert( "ExExpendAuthInfoInsert", authVo ) );
		return authVo;
	}

	/* 지출결의 - 증빙유형 수정 */
	public ExCommonResultVO ExExpendAuthInfoUpdate ( ExCodeAuthVO authVo ) throws Exception {
		/* parameters : auth_div, auth_code, auth_name, cash_type, cr_acct_code, cr_acct_name , vat_acct_code, vat_acct_name, vat_type_code, vat_type_name, erp_auth_code , erp_auth_name, auth_required_yn, partner_required_yn, card_required_yn , project_required_yn, note_required_yn, no_tax_code, no_tax_name, va_type_code , va_type_name, create_seq, modify_seq, seq */
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		/* ibatis 에서 update() 실행시 return 값 : 성공시 "1" / 실패시 "0" */
		if ( update( "ExExpendAuthInfoUpdate", authVo ) > 0 ) {
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( authVo ) );
		}
		else {
			resultVo.setCode( commonCode.FAIL );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( authVo ) );
		}
		return resultVo;
	}

	/* 지출결의 - 증빙유형 조회 */
	public ExCodeAuthVO ExExpendAuthInfoSelect ( ExCodeAuthVO authVo ) throws Exception {
		/* parameters : seq */
		authVo = (ExCodeAuthVO) select( "ExExpendAuthInfoSelect", authVo );
		return authVo;
	}

	/* 지출결의 - 증빙유형 삭제 */
	public ExCommonResultVO ExExpendAuthInfoDelete ( ExCodeAuthVO authVo ) throws Exception {
		/* parameters : seq */
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		/* ibatis 에서 delete() 실행시 return 값 : 삭제한 row 수 */
		if ( delete( "ExExpendAuthInfoDelete", authVo ) > 0 ) {
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( authVo ) );
		}
		else {
			resultVo.setCode( commonCode.FAIL );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( authVo ) );
		}
		return resultVo;
	}

	/* 공통코드 */
	/* 공통코드 증빙유형 등록 */
	public ExCodeAuthVO ExCodeAuthInfoInsert ( ExCodeAuthVO authVo ) throws Exception {
		/* parameters : comp_seq, auth_div, auth_code, auth_name, cash_type, cr_acct_code, cr_acct_name, vat_acct_code , vat_acct_name, vat_type_code, vat_type_name, erp_auth_code, erp_auth_name, auth_required_yn, partner_required_yn , card_required_yn, project_required_yn, note_required_yn, no_tax_code, no_tax_name, order_num, use_yn, va_type_code , va_type_name, create_seq, modify_seq */
		authVo.setSeq( (int) insert( "ExCodeAuthInfoInsert", authVo ) );
		return authVo;
	}

	/* 공통코드 증빙유형 수정 */
	public ExCommonResultVO ExCodeAuthInfoUpdate ( ExCodeAuthVO authVo ) throws Exception {
		/* parameters : auth_name, cash_type, cr_acct_code, cr_acct_name, vat_acct_code, vat_acct_name, vat_type_code, vat_type_name , erp_auth_code, erp_auth_name, auth_required_yn, partner_required_yn, card_required_yn, project_required_yn , note_required_yn, no_tax_code, no_tax_name, order_num, use_yn, va_type_code, va_type_name, modify_seq , comp_seq, auth_div, auth_code */
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		/* ibatis 에서 update() 실행시 return 값 : 성공시 "1" / 실패시 "0" */
		if ( update( "ExCodeAuthInfoUpdate", authVo ) > 0 ) {
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( authVo ) );
		}
		else {
			resultVo.setCode( commonCode.FAIL );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( authVo ) );
		}
		return resultVo;
	}

	/* 공통코드 증빙유형 조회 */
	public ExCodeAuthVO ExCodeAuthInfoSelect ( ExCodeAuthVO authVo ) throws Exception {
		/* parameters : comp_seq, auth_div, search_str, search_str */
		authVo = (ExCodeAuthVO) select( "ExCodeAuthInfoSelect", authVo );
		return authVo;
	}

	/* 공통코드 증빙유형 목록 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<ExCodeAuthVO> ExCodeAuthListInfoSelect ( ExCodeAuthVO authVo ) throws Exception {
		/* parameters : comp_seq, auth_div, search_str, search_str */
		List<ExCodeAuthVO> authListVo = new ArrayList<ExCodeAuthVO>( );
		authListVo = list( "ExCodeAuthListInfoSelect", authVo );
		return authListVo;
	}

	/* 공통코드 증빙유형 삭제 */
	public ExCommonResultVO ExCodeAuthInfoDelete ( ExCodeAuthVO authVo ) throws Exception {
		/* parameters : comp_seq, auth_div, auth_code */
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		/* ibatis 에서 delete() 실행시 return 값 : 삭제한 row 수 */
		if ( delete( "ExCodeAuthInfoDelete", authVo ) > 0 ) {
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( authVo ) );
		}
		else {
			resultVo.setCode( commonCode.FAIL );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( authVo ) );
		}
		return resultVo;
	}

	/* ----------------------------------------------------------------------------- */
	/* ---------------------------------- budget ----------------------------------- */
	/* ----------------------------------------------------------------------------- */
	public ExCodeBudgetVO ExExpendBudgetInfoInsert ( ExCodeBudgetVO budgetVo ) throws Exception {
        // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
		budgetVo.setSeq( (int) insert( "ExExpendBudgetInfoInsert", budgetVo ) );
		return budgetVo;
	}

	/* 지출결의 - 예산정보 조회 */
	public ExCodeBudgetVO ExExpendBudgetInfoSelect ( ExCodeBudgetVO budgetVo ) throws Exception {
	        // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
		budgetVo = (ExCodeBudgetVO) select( "ExExpendBudgetInfoSelect", budgetVo );
		return budgetVo;
	}

	/* 공통코드 */
	/* 공통코드 - BizboxA - 예산확인 for iCUBE */
	public ExCodeBudgetVO ExCodeiCUBEBudgetAmtInfoSelect ( ExCodeBudgetVO budgetVo ) throws Exception {
		budgetVo = (ExCodeBudgetVO) select( "ExCodeiCUBEBudgetAmtInfoSelect", budgetVo );
		return budgetVo;
	}

	/* ----------------------------------------------------------------------------- */
	/* ---------------------------------- card ----------------------------------- */
	/* ----------------------------------------------------------------------------- */
	/* 지출결의 - 카드 등록 */
	public ExCodeCardVO ExExpendCardInfoInsert ( ExCodeCardVO cardVo ) throws Exception {
		/* parameters : card_code, card_num, card_name, create_seq, modify_seq, seq */
		cardVo.setSeq( (int) insert( "ExExpendCardInfoInsert", cardVo ) );
		return cardVo;
	}

	/* 지출결의 - 카드 수정 */
	public ExCommonResultVO ExExpendCardInfoUpdate ( ExCodeCardVO cardVo ) throws Exception {
		/* parameters : card_code, card_num, card_name, modify_seq, seq */
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		/* ibatis 에서 update() 실행시 return 값 : 성공시 "1" / 실패시 "0" */
		if ( update( "ExExpendCardInfoUpdate", cardVo ) > 0 ) {
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( cardVo ) );
		}
		else {
			resultVo.setCode( commonCode.FAIL );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( cardVo ) );
		}
		return resultVo;
	}

	/* 지출결의 - 카드 조회 */
	public ExCodeCardVO ExExpendCardInfoSelect ( ExCodeCardVO cardVo ) throws Exception {
		/* parameters : seq */
		cardVo = (ExCodeCardVO) select( "ExExpendCardInfoSelect", cardVo );
		return cardVo;
	}

	/* 지출결의 - 카드 삭제 */
	public ExCommonResultVO ExExpendCardInfoDelete ( ExCodeCardVO cardVo ) throws Exception {
		/* parameters : seq */
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		/* ibatis 에서 delete() 실행시 return 값 : 성공시 "delete count" / 실패시 "0" */
		if ( delete( "ExExpendCardInfoDelete", cardVo ) > 0 ) {
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( cardVo ) );
		}
		else {
			resultVo.setCode( commonCode.FAIL );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( cardVo ) );
		}
		return resultVo;
	}

	/* 공통코드 */
	/* 공통코드 - 카드 등록 */
	public ExCodeCardVO ExCodeCardInfoInsert ( ExCodeCardVO cardVo ) throws Exception {
		/* parameters : comp_seq, card_code, card_num, card_name, partner_code, partner_name, use_yn, create_seq, modify_seq ) */
		cardVo.setSeq( (int) insert( "ExCodeCardInfoInsert", cardVo ) );
		return cardVo;
	}

	/* 공통코드 - 카드 수정 */
	public ExCommonResultVO ExCodeCardInfoUpdate ( ExCodeCardVO cardVo ) throws Exception {
		/* parameters : card_name, partner_code, partner_name, modify_seq, comp_seq, card_code */
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		/* ibatis 에서 update() 실행시 return 값 : 성공시 "1" / 실패시 "0" */
		if ( update( "ExCodeCardInfoUpdate", cardVo ) > 0 ) {
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( cardVo ) );
		}
		else {
			resultVo.setCode( commonCode.FAIL );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( cardVo ) );
		}
		return resultVo;
	}

	/* 공통코드 - 카드 조회 */
	public ExCodeCardVO ExCodeCardInfoSelect ( ExCodeCardVO cardVo ) throws Exception {
		/* parameters : comp_seq */
		cardVo = (ExCodeCardVO) select( "ExCodeCardInfoSelect", cardVo );
		return cardVo;
	}

	/* 공통코드 - 카드 목록 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<ExCodeCardVO> ExCodeCardListInfoSelect ( ExCodeCardVO cardVo ) throws Exception {
		/* parameters : comp_seq */
		List<ExCodeCardVO> cardListVo = new ArrayList<ExCodeCardVO>( );
		cardListVo = list( "ExCodeCardListInfoSelect", cardVo );
		return cardListVo;
	}

	/* 공통코드 - 카드 삭제 */
	public ExCommonResultVO ExCodeCardInfoDelete ( ExCodeCardVO cardVo ) throws Exception {
		/* parameters : comp_seq, card_code */
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		/* ibatis 에서 delete() 실행시 return 값 : 삭제한 row 수 */
		if ( delete( "ExCodeCardInfoDelete", cardVo ) > 0 ) {
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( cardVo ) );
		}
		else {
			resultVo.setCode( commonCode.FAIL );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( cardVo ) );
		}
		return resultVo;
	}

	/* 공통코드 - 카드 공개범위 등록 */
	public ExCommonResultVO ExCodeCardPublicListInfoInsert ( ExCodeCardPublicVO publicVo ) throws Exception {
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		try {
			insert( "ExCodeCardPublicListInfoInsert", publicVo );
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( publicVo ) );
		}
		catch ( Exception e ) {
			resultVo.setCode( commonCode.FAIL );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( publicVo ) );
		}
		return resultVo;
	}

	/* 공통코드 - 카드 공개범위 삭제 */
	public ExCommonResultVO ExCodeCardPublicListInfoDelete ( ExCodeCardVO cardVo ) throws Exception {
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		/* ibatis 에서 delete() 실행시 return 값 : 삭제한 row 수 */
		if ( delete( "ExCodeCardPublicListInfoDelete", cardVo ) > 0 ) {
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( cardVo ) );
		}
		else {
			resultVo.setCode( commonCode.FAIL );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( cardVo ) );
		}
		return resultVo;
	}

	/* ----------------------------------------------------------------------------- */
	/* ---------------------------------- common ----------------------------------- */
	/* ----------------------------------------------------------------------------- */
	/* 공통코드 - 회사 목록 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<ExCommonResultVO> ExCodeCommonCompListInfoSelect ( ExCommonResultVO commonParam ) throws Exception {
		/* parameters : lang_code, comp_seq, comp_seq */
		List<ExCommonResultVO> resultVo = new ArrayList<ExCommonResultVO>( );
		resultVo = list( "ExCodeCommonCompListInfoSelect", commonParam );
		return resultVo;
	}

	/* 공통코드 - 양식 목록 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<ExCommonResultVO> ExCodeCommonFormListInfoSelect ( ExCommonResultVO commonParam ) throws Exception {
		/* parameters : comp_seq */
		List<ExCommonResultVO> resultVo = new ArrayList<ExCommonResultVO>( );
		resultVo = list( "ExCodeCommonFormListInfoSelect", commonParam );
		return resultVo;
	}

	/* 공통코드 - 공통코드 목록 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<ExCommonResultVO> ExCodeCommonCodeListInfoSelect ( ExCommonResultVO commonParam ) throws Exception {
		/* parameters : search_type, search_type, search_type, lang_code */
		List<ExCommonResultVO> resultVo = new ArrayList<ExCommonResultVO>( );
		resultVo = list( "ExCodeCommonCodeListInfoSelect", commonParam );
		return resultVo;
	}

	/* 양식상세 조회 */
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> ExCodeCommonFormDetailInfoSelect ( Map<String, Object> param) throws Exception {
		/* parameters : langCode, searchFormSeq, searchFormSeq */
		Map<String, Object> result = new HashMap<String, Object>( );
		try {
			result = (Map<String, Object>) select( "ExCodeCommonFormDetailInfoSelect", param );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			//System.out.println( e.getMessage( ) );
		}
		return result;
	}

	/* 양식목록 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExFormListInfoSelect ( Map<String, Object> param ) throws Exception {
		/* parameters : langCode, deptSeq, empSeq */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			result = list( "ExFormListInfoSelect", param );
		}
		catch ( Exception e ) {
			throw e;
		}
		return result;
	}

	/* ERP 회사코드 조회 - BizboxA only */
	public String getErpCodeCompanyInfoSelect ( Map<String, Object> param ) throws Exception {
		/* parameters : compSeq */
		String result = commonCode.EMPTYSTR;
		try {
			result = (String) select( "getErpCodeCompanyInfoSelect", param );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			//System.out.println( e.getMessage( ) );
		}
		return result;
	}

	/* ERP 사업장코드 조회 - BizboxA only */
	public String getErpCodeBizInfoSelect ( Map<String, Object> param ) throws Exception {
		/* parameters : compSeq, bizSeq */
		String result = commonCode.EMPTYSTR;
		try {
			result = (String) select( "getErpCodeBizInfoSelect", param );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			//System.out.println( e.getMessage( ) );
		}
		return result;
	}

	/* ERP 부서코드 조회 - BizboxA only */
	public String getErpCodeDeptInfoSelect ( Map<String, Object> param ) throws Exception {
		/* parameters : compSeq, bizSeq, deptSeq */
		String result = commonCode.EMPTYSTR;
		try {
			result = (String) select( "getErpCodeDeptInfoSelect", param );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			//System.out.println( e.getMessage( ) );
		}
		return result;
	}

	/* ERP 사원코드 조회 - BizboxA only */
	public String getErpCodeEmpInfoSelect ( Map<String, Object> param ) throws Exception {
		/* parameters : compSeq, bizSeq, deptSeq */
		String result = commonCode.EMPTYSTR;
		try {
			result = (String) select( "getErpCodeEmpInfoSelect", param );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			//System.out.println( e.getMessage( ) );
		}
		return result;
	}

	/* ----------------------------------------------------------------------------- */
	/* ---------------------------------- org ----------------------------------- */
	/* ----------------------------------------------------------------------------- */
	/* 지출결의 - 사용자 등록 */
	public ExCodeOrgVO ExExpendEmpInfoInsert ( ExCodeOrgVO orgVo ) throws Exception {
		orgVo.setSeq( (int) insert( "ExExpendEmpInfoInsert", orgVo ) );
		return orgVo;
	}

	/* 지출결의 - 사용자 수정 */
	public ExCommonResultVO ExExpendEmpInfoUpdate ( ExCodeOrgVO orgVo ) throws Exception {
		/*
		 * parameters : comp_seq, comp_name, erp_comp_seq, erp_comp_name, biz_seq,biz_name,erp_biz_seq , erp_biz_name, dept_seq, dept_name, erp_dept_seq, erp_dept_name, emp_seq, erp_emp_seq, emp_name , erp_emp_name, erp_pc_seq, erp_pc_name, erp_cc_seq, erp_cc_name, modify_seq, ,seq
		 */
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		/* ibatis 에서 update() 실행시 return 값 : 성공시 "1" / 실패시 "0" */
		if ( update( "ExExpendEmpInfoUpdate", orgVo ) > 0 ) {
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( orgVo ) );
		}
		else {
			resultVo.setCode( commonCode.FAIL );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( orgVo ) );
		}
		return resultVo;
	}

	/* 지출결의 - 사용자 조회 */
	public ExCodeOrgVO ExExpendEmpInfoSelect ( ExCodeOrgVO orgVo ) throws Exception {
		/* parameters : seq */
		orgVo = (ExCodeOrgVO) select( "ExExpendEmpInfoSelect", orgVo );
		return orgVo;
	}

	/* 지출결의 - 사용자 삭제 */
	public ExCommonResultVO ExExpendEmpInfoDelete ( ExCodeOrgVO orgVo ) throws Exception {
		/* parameters : seq */
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		/* ibatis 에서 delete() 실행시 return 값 : 성공시 "delete count" / 실패시 "0" */
		if ( delete( "ExExpendEmpInfoDelete", orgVo ) > 0 ) {
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( orgVo ) );
		}
		else {
			resultVo.setCode( commonCode.FAIL );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( orgVo ) );
		}
		return resultVo;
	}

	/* 공통코드 */
	/* 공통코드 - 사용자 조회 */
	public ExCodeOrgVO ExCodeEmpInfoSelect ( ExCodeOrgVO orgVo ) throws Exception {
		/* parameters : lang_code, comp_seq, search_str */
		orgVo = (ExCodeOrgVO) select( "ExCodeEmpInfoSelect", orgVo );
		return orgVo;
	}

	/* 공통코드 - 사용자 목록 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<ExCodeOrgVO> ExCodeEmpListInfoSelect ( ExCodeOrgVO orgVo ) throws Exception {
		/* parameters : comp_seq, lang_code, search_str */
		List<ExCodeOrgVO> orgListVo = new ArrayList<ExCodeOrgVO>( );
		orgListVo = list( "ExCodeEmpListInfoSelect", orgVo );
		return orgListVo;
	}

	/* ----------------------------------------------------------------------------- */
	/* ---------------------------------- partner ----------------------------------- */
	/* ----------------------------------------------------------------------------- */
	/* 지출결의 - 거래처 등록 */
	public ExCodePartnerVO ExExpendPartnerInfoInsert ( ExCodePartnerVO partnerVo ) throws Exception {
		/*
		 * parameters : partner_code, partner_name, partner_no, partner_fg, ceo_name, job_gbn, cls_job_gbn, deposit_no , bank_code, partner_emp_code, partner_hp_emp_no, deposit_name, deposit_convert, create_seq, modify_seq
		 */
		partnerVo.setSeq( (int) insert( "ExExpendPartnerInfoInsert", partnerVo ) );
		return partnerVo;
	}

	/* 지출결의 - 거래처 수정 */
	public ExCommonResultVO ExExpendPartnerInfoUpdate ( ExCodePartnerVO partnerVo ) throws Exception {
		/*
		 * parameters : partner_code, partner_name, partner_no, partner_fg, ceo_name, job_gbn , cls_job_gbn, deposit_no, bank_code, partner_emp_code, partner_hp_emp_no, deposit_name , deposit_convert, modify_seq, seq
		 */
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		/* ibatis 에서 update() 실행시 return 값 : 성공시 "1" / 실패시 "0" */
		if ( update( "ExExpendPartnerInfoUpdate", partnerVo ) > 0 ) {
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( partnerVo ) );
		}
		else {
			resultVo.setCode( commonCode.FAIL );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( partnerVo ) );
		}
		return resultVo;
	}

	/* 지출결의 - 거래처 조회 */
	public ExCodePartnerVO ExExpendPartnerInfoSelect ( ExCodePartnerVO partnerVo ) throws Exception {
		partnerVo = (ExCodePartnerVO) select( "ExExpendPartnerInfoSelect", partnerVo );
		return partnerVo;
	}

	/* 지출결의 - 거래처 삭제 */
	public ExCommonResultVO ExExpendPartnerInfoDelete ( ExCodePartnerVO partnerVo ) throws Exception {
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		/* ibatis 에서 update() 실행시 return 값 : 성공시 "1" / 실패시 "0" */
		if ( delete( "ExExpendPartnerInfoDelete", partnerVo ) > 0 ) {
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( partnerVo ) );
		}
		else {
			resultVo.setCode( commonCode.FAIL );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( partnerVo ) );
		}
		return resultVo;
	}

	/* 공통코드 */
	/* 공통코드 - 거래처 등록 */ /* 다른 모듈의 기능을 사용하므로, 기능 구현 안함 */
	/* 공통코드 - 거래처 수정 */ /* 다른 모듈의 기능을 사용하므로, 기능 구현 안함 */
	/* 공통코드 - 거래처 조회 */
	public ExCodePartnerVO ExCodePartnerInfoSelect ( ExCodePartnerVO partnerVo ) throws Exception {
		partnerVo = (ExCodePartnerVO) select( "ExCodePartnerInfoSelect", partnerVo );
		return partnerVo;
	}

	/* 공통코드 - 거래처 목록 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<ExCodePartnerVO> ExCodePartnerListInfoSelect ( ExCodePartnerVO partnerVo ) throws Exception {
		List<ExCodePartnerVO> partnerListVo = new ArrayList<ExCodePartnerVO>( );
		partnerListVo = (List<ExCodePartnerVO>) select( "ExCodePartnerListInfoSelect", partnerVo );
		return partnerListVo;
	}

	/* ----------------------------------------------------------------------------- */
	/* ---------------------------------- project ----------------------------------- */
	/* ----------------------------------------------------------------------------- */
	/* 지출결의 - 프로젝트 등록 */
	public ExCodeProjectVO ExExpendProjectInfoInsert ( ExCodeProjectVO projectVo ) throws Exception {
		projectVo.setSeq( (int) insert( "ExExpendProjectInfoInsert", projectVo ) );
		return projectVo;
	}

	public ExCodeProjectVO fnExpendProjectInsert_Update ( ExCodeProjectVO projectVo ) throws Exception {

		LoginVO loginVo = new LoginVO();
		loginVo = CommonConvert.CommonGetEmpVO();
		ExCommonResultVO resultVo = new ExCommonResultVO( );

		resultVo.setGroupSeq(loginVo.getGroupSeq());
		resultVo.setExpendSeq(projectVo.getExpendSeq());
		resultVo.setSeq(Integer.toString(projectVo.getSeq()));

		projectVo.setSeq(update( "ExExpendProjectInsert_Update", resultVo ));
		return projectVo;
	}

	public ExCodePartnerVO fnExpendPartnerInsert_Update ( ExCodePartnerVO partnerVO ) throws Exception {

		LoginVO loginVo = new LoginVO();
		loginVo = CommonConvert.CommonGetEmpVO();
		partnerVO.setGroupSeq(loginVo.getGroupSeq());

		partnerVO.setSeq(update( "ExExpendPartnerInsert_Update", partnerVO ));
		return partnerVO;
	}

	public ExCodeCardVO fnExpendCardInsert_Update ( ExCodeCardVO cardVO ) throws Exception {

		LoginVO loginVo = new LoginVO();
		loginVo = CommonConvert.CommonGetEmpVO();
		cardVO.setGroupSeq(loginVo.getGroupSeq());

		cardVO.setSeq(update( "ExExpendCardInsert_Update", cardVO ));
		return cardVO;
	}

	/* 지출결의 - 프로젝트 수정 */
	public ExCommonResultVO ExExpendProjectInfoUpdate ( ExCodeProjectVO projectVo ) throws Exception {
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		/* ibatis 에서 update() 실행시 return 값 : 성공시 "1" / 실패시 "0" */
		if ( update( "ExExpendProjectInfoUpdate", projectVo ) > 0 ) {
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( projectVo ) );
		}
		else {
			resultVo.setCode( commonCode.FAIL );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( projectVo ) );
		}
		return resultVo;
	}

	/* 지출결의 - 프로젝트 조회 */
	public ExCodeProjectVO ExExpendProjectInfoSelect ( ExCodeProjectVO projectVo ) throws Exception {
		projectVo = (ExCodeProjectVO) select( "ExExpendProjectInfoSelect", projectVo );
		return projectVo;
	}

	/* 지출결의 - 프로젝트 삭제 */
	public ExCommonResultVO ExExpendProjectInfoDelete ( ExCodeProjectVO projectVo ) throws Exception {
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		/* ibatis 에서 delete() 실행시 return 값 : 삭제한 row 수 */
		if ( update( "ExExpendProjectInfoUpdate", projectVo ) > 0 ) {
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( projectVo ) );
		}
		else {
			resultVo.setCode( commonCode.FAIL );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( projectVo ) );
		}
		return resultVo;
	}

	/* 공통코드 */
	/* 공통코드 - 프로젝트 등록 */ /* 다른 모듈의 기능을 사용하므로, 기능 구현 안함 */
	/* 공통코드 - 프로젝트 수정 */ /* 다른 모듈의 기능을 사용하므로, 기능 구현 안함 */
	/* 공통코드 - 프로젝트 조회 */
	public ExCodeProjectVO ExCodeProjectInfoSelect ( ExCodeProjectVO projectVo ) throws Exception {
		projectVo = (ExCodeProjectVO) select( "ExCodeProjectInfoSelect", projectVo );
		return projectVo;
	}

	/* 공통코드 - 프로젝트 목록 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<ExCodeProjectVO> ExCodeProjectListInfoSelect ( ExCodeProjectVO projectVo ) throws Exception {
		List<ExCodeProjectVO> projectListVo = new ArrayList<ExCodeProjectVO>( );
		projectListVo = list( "ExCodeProjectListInfoSelect", projectVo );
		return projectListVo;
	}

	/* ----------------------------------------------------------------------------- */
	/* ---------------------------------- summary ----------------------------------- */
	/* ----------------------------------------------------------------------------- */
	/* 지출결의 - 표준적요 등록 */
	public ExCodeSummaryVO ExExpendSummaryInfoInsert ( ExCodeSummaryVO summaryVo ) throws Exception {
		summaryVo.setSeq( (int) insert( "ExExpendSummaryInfoInsert", summaryVo ) );
		return summaryVo;
	}

	/* 지출결의 - 표준적요 수정 */
	public ExCommonResultVO ExExpendSummaryInfoUpdate ( ExCodeSummaryVO summaryVo ) throws Exception {
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		/* ibatis 에서 update() 실행시 return 값 : 성공시 "1" / 실패시 "0" */
		if ( update( "ExExpendSummaryInfoUpdate", summaryVo ) > 0 ) {
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( summaryVo ) );
		}
		else {
			resultVo.setCode( commonCode.FAIL );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( summaryVo ) );
		}
		return resultVo;
	}

	/* 지출결의 - 표준적요 조회 */
	public ExCodeSummaryVO ExExpendSummaryInfoSelect ( ExCodeSummaryVO summaryVo ) throws Exception {
		summaryVo = (ExCodeSummaryVO) select( "ExExpendSummaryInfoSelect", summaryVo );
		return summaryVo;
	}

	/* 지출결의 - 표준적요 삭제 */
	public ExCommonResultVO ExExpendSummaryInfoDelete ( ExCodeSummaryVO summaryVo ) throws Exception {
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		/* ibatis 에서 delete() 실행시 return 값 : 삭제한 row 수 */
		if ( delete( "ExExpendSummaryInfoDelete", summaryVo ) > 0 ) {
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( summaryVo ) );
		}
		else {
			resultVo.setCode( commonCode.FAIL );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( summaryVo ) );
		}
		return resultVo;
	}

	/* 공통코드 */
	/* 공통코드 - 표준적요 생성 */
	public ExCodeSummaryVO ExCodeSummaryInfoInsert ( ExCodeSummaryVO summaryVo ) throws Exception {
		summaryVo.setSeq( (int) insert( "ExCodeSummaryInfoInsert", summaryVo ) );
		return summaryVo;
	}

	/* 공통코드 - 표준적요 수정 */
	public ExCommonResultVO ExCodeSummaryInfoUpdate ( ExCodeSummaryVO summaryVo ) throws Exception {
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		/* ibatis 에서 update() 실행시 return 값 : 성공시 "1" / 실패시 "0" */
		if ( update( "ExCodeSummaryInfoUpdate", summaryVo ) > 0 ) {
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( summaryVo ) );
		}
		else {
			resultVo.setCode( commonCode.FAIL );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( summaryVo ) );
		}
		return resultVo;
	}

	/* 공통코드 - 표준적요 삭제 */
	public ExCommonResultVO ExCodeSummaryInfoDelete ( ExCodeSummaryVO summaryVo ) throws Exception {
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		/* ibatis 에서 delete() 실행시 return 값 : 삭제한 row 수 */
		if ( delete( "ExCodeSummaryInfoDelete", summaryVo ) > 0 ) {
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( summaryVo ) );
		}
		else {
			resultVo.setCode( commonCode.FAIL );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( summaryVo ) );
		}
		return resultVo;
	}

	/* 공통코드 - 표준적요 조회 */
	public ExCodeSummaryVO ExCodeSummaryInfoSelect ( ExCodeSummaryVO summaryVo ) throws Exception {
		summaryVo = (ExCodeSummaryVO) select( "ExCodeSummaryInfoSelect", summaryVo );
		return summaryVo;
	}

	/* 공통코드 - 표준적요 목록 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<ExCodeSummaryVO> ExCodeSummaryListInfoSelect ( ExCodeSummaryVO summaryVo ) throws Exception {
		List<ExCodeSummaryVO> summaryListVo = new ArrayList<ExCodeSummaryVO>( );
		summaryListVo = list( "ExCodeSummaryListInfoSelect", summaryVo );
		return summaryListVo;
	}

	/* ----------------------------------------------------------------------------- */
	/* ---------------------------------- tax ----------------------------------- */
	/* ----------------------------------------------------------------------------- */
	@SuppressWarnings ( "unchecked" )
	//public List<ExCodeAuthVO> getExVaList ( Map<String, Object> param, ConnectionVO conVo ) throws Exception {
	public List<ExCodeAuthVO> getExVaList ( Map<String, Object> param ) throws Exception {
		List<ExCodeAuthVO> list = null;
		try {
			list = list( "getExVaList_BizboxA", param );
		}
		catch ( Exception e ) {
			throw e;
		}
		return list;
	}

	/* ----------------------------------------------------------------------------- */
	/* ---------------------------------- vat ----------------------------------- */
	/* ----------------------------------------------------------------------------- */
	/* 공통코드 - 부가세구분 등록 */
	public ExCodeAuthVO ExCodeVatTypeInfoInsert ( ExCodeAuthVO vatTypeVo ) throws Exception {
		vatTypeVo.setSeq( (int) insert( "ExCodeVatTypeInfoInsert", vatTypeVo ) );
		return vatTypeVo;
	}

	/**
	 * @param vatTypeVo
	 * @return
	 */
	public ExCommonResultVO ExCodeVatTypeInfoUpdate ( ExCodeAuthVO vatTypeVo ) throws Exception {
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		/* ibatis 에서 update() 실행시 return 값 : 성공시 "1" / 실패시 "0" */
		if ( update( "ExCodeVatTypeInfoUpdate", vatTypeVo ) > 0 ) {
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( vatTypeVo ) );
		}
		else {
			resultVo.setCode( commonCode.FAIL );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( vatTypeVo ) );
		}
		return resultVo;
	}

	/**
	 * @param vatTypeVo
	 * @return
	 */
	public ExCommonResultVO ExCodeVatTypeInfoDelete ( ExCodeAuthVO vatTypeVo ) throws Exception {
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		/* ibatis 에서 delete() 실행시 return 값 : 삭제한 row 수 */
		if ( delete( "ExCodeVatTypeInfoDelete", vatTypeVo ) > 0 ) {
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( vatTypeVo ) );
		}
		else {
			resultVo.setCode( commonCode.FAIL );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( vatTypeVo ) );
		}
		return resultVo;
	}

	/**
	 * @param vatTypeVo
	 * @return
	 */
	public ExCodeAuthVO ExCodeVatTypeInfoSelect ( ExCodeAuthVO vatTypeVo ) throws Exception {
		vatTypeVo = (ExCodeAuthVO) select( "ExCodeVatTypeInfoSelect", vatTypeVo );
		return vatTypeVo;
	}

	/**
	 * @param vatTypeVo
	 * @return
	 */
	@SuppressWarnings ( "unchecked" )
	public List<ExCodeAuthVO> ExCodeVatTypeListInfoSelect ( ExCodeAuthVO vatTypeVo ) throws Exception {
		List<ExCodeAuthVO> vatTeypListVo = new ArrayList<ExCodeAuthVO>( );
		vatTeypListVo = list( "ExCodeVatTypeListInfoSelect", vatTypeVo );
		return vatTeypListVo;
	}

	/* ----------------------------------------------------------------------------- */
	/* --------------------------------공통 팝업 조회 영역-------------------------- */
	/* ----------------------------------------------------------------------------- */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExCommonCodeAcctSelect ( Map<String, Object> params ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = this.list( "ExCommonCodeAcctSelect", params );
		return result;
	}

	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExCommonCodeAuthSelect ( Map<String, Object> params ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = this.list( "ExCommonCodeAuthSelect", params );
		return result;
	}

	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExCommonCodeCardSelect ( Map<String, Object> params ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = this.list( "ExCommonCodeCardSelect", params );
		return result;
	}

	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExCommonCodeEmpSelect ( Map<String, Object> params ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = this.list( "ExCommonCodeEmpSelect", params );
		return result;
	}

	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExCommonCodePartnerSelect ( Map<String, Object> params) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = this.list( "ExCommonCodePartnerSelect", params );
		return result;
	}

	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExCommonCodeProjectSelect ( Map<String, Object> params ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = this.list( "ExCommonCodeProjectSelect", params );
		return result;
	}

	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExCommonCodeSummarySelect ( Map<String, Object> params ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = this.list( "ExCommonCodeSummarySelect", params );
		return result;
	}

	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> ExUserCodeExpendSeq ( Map<String, Object> params ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		Map<String, Object> result = (Map<String, Object>) this.select( "ExUserCodeExpendSeq", params );
		if ( result != null ) {
			// do nothing
		}
		return result;
	}

	/* 지출결의 docSts 조회 */
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> ExUserExpendDocStsSelect ( Map<String, Object> params ) throws Exception {
		Map<String, Object> result = (Map<String, Object>) this.select( "ExUserExpendDocStsSelect", params );
		if ( result != null ) {
			// do nothing
		}
		return result;
	}

	/* 전자결재 본문 양식 생성 테스트 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExpendInfoSelect ( Map<String, Object> params ) {
		/* parameters : erp_comp_seq, search_str, search_str */
		//Map<String, Object> expend = new HashMap<String, Object>( );
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>( );
		List<Map<String, Object>> slip = new ArrayList<Map<String, Object>>( );
		List<Map<String, Object>> mng = new ArrayList<Map<String, Object>>( );
		list = list( "ExpendListInfoSelect", params );
		for ( Map<String, Object> temp : list ) {
			slip = new ArrayList<Map<String, Object>>( );
			params.put( "listSeq", temp.get( "listSeq" ).toString( ) );
			slip = list( "ExpendSlipInfoSelect", params );
			for ( Map<String, Object> tempSlip : slip ) {
				mng = new ArrayList<Map<String, Object>>( );
				params.put( "slipSeq", tempSlip.get( "slipSeq" ).toString( ) );
				mng = list( "ExpendMngInfoSelect", params );
				tempSlip.put( "mng", mng );
			}
			temp.put( "slip", slip );
		}
		//expend.put( "list", list );
		return list;
	}

	/**
	 * ERP회사코드, 사업장코드, 문서번호 조회
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO ExCodeERPInfoSelect ( ResultVO param ) {
		param.setaData( (Map<String, Object>) this.select( "ExCodeERPInfoSelect", param.getParams( ) ) );
		return param;
	}

	/**
	 * 해당 지출결의 매입전자 세금계산서 번호 조회
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO ExExpendETaxInfoListSelect ( ResultVO param ) {
		param.setAaData( this.list( "ExExpendETaxInfoListSelect", param.getParams( ) ) );
		return param;
	}
	
	/*
	 * 준성 
	 * 해당 지출결의 카드 조회 
	 * */
	@SuppressWarnings ( "unchecked" )
	public ResultVO ExExpendCardInfoListSelect ( ResultVO param ) {
  	    param.setAaData( this.list( "ExExpendCardInfoListSelect", param.getParams( ) ) );
        return param;
	}
	
	/* row_id, row_no, slipSeq 조회 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO ExExpendSlipBudgetInfoSelect ( ResultVO param ) {
		param.setAaData( this.list( "ExExpendSlipBudgetInfoSelect", param.getParams( ) ) );
		return param;
	}

	/* 전자결재 정보 조회 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO ExExpendDocInfoSelect ( ResultVO param ) {
		param.setaData( (Map<String, Object>) this.select( "ExExpendDocInfoSelect", param.getParams( ) ) );
		return param;
	}

	/* 그룹웨어 사업장 정보 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExCommonCodeBizSelect ( Map<String, Object> params ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = this.list( "ExCommonCodeBizSelect", params );
		return result;
	}

	/* t_ex_group_path 조회 */
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> ExCommonExpGroupPathSelect ( Map<String, Object> param ) {
		Map<String, Object> result = new HashMap<String, Object>( );
		result = (Map<String, Object>) this.select( "ExCommonExpGroupPathSelect", param );
		return result;
	}
}
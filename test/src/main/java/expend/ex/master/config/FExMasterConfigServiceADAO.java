package expend.ex.master.config;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ResultVO;
import common.vo.ex.ExCodeAuthVO;
import common.vo.ex.ExCodeMngVO;
import common.vo.ex.ExCodeSummaryVO;
import common.vo.ex.ExConfigItemVO;
import common.vo.ex.ExConfigOptionVO;
import common.vo.ex.ExOptionVO;
import common.vo.g20.ExCommonResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import main.web.BizboxAMessage;


@Repository ( "FExMasterConfigServiceADAO" )
public class FExMasterConfigServiceADAO extends EgovComAbstractDAO {

	/* 변수정의 - Common */
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */

	/* 주석없음 */
	/**
	 *   * @Method Name : getExERPCompInfo
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 주석없음
	 *   * @param param
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> getExERPCompInfo ( Map<String, Object> param ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			result = (List<Map<String, Object>>) list( "getExERPCompInfo_BizboxA", param );
		}
		catch ( Exception e ) {
			throw e;
		}
		return result;
	}

	/* 주석없음 */
	/**
	 *   * @Method Name : getMngOptionList
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 주석없음
	 *   * @param param
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> getMngOptionList ( Map<String, Object> param ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			result = (List<Map<String, Object>>) list( "getMngOptionList_BizboxA", param );
		}
		catch ( Exception e ) {
			throw e;
		}
		return result;
	}

	/* 주석없음 */
	/**
	 *   * @Method Name : setMngOption
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 주석없음
	 *   * @param param
	 *   * @return
	 *   
	 */
	public boolean setMngOption ( Map<String, Object> param ) {
		Boolean retValue = false;
		try {
			insert( "setMngOption_BizboxA", param );
		}
		catch ( Exception e ) {
			throw e;
		}
		return retValue;
	}

	/* 회사 리스트 조회 */
	/**
	 *   * @Method Name : getCompanyList
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 회사 리스트 조회
	 *   * @param param
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@SuppressWarnings ( "unchecked" )
	public List<ExCommonResultVO> getCompanyList ( ExCommonResultVO param ) throws Exception {
		List<ExCommonResultVO> result = new ArrayList<ExCommonResultVO>( );
		try {
			result = (List<ExCommonResultVO>) list( "ExConfigCompListInfo", param );
		}
		catch ( Exception e ) {
			throw e;
		}
		return result;
	}

	/* form 리스트 조회 */
	/**
	 *   * @Method Name : getFormList
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : form 리스트 조회
	 *   * @param param
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@SuppressWarnings ( "unchecked" )
	public List<ExCommonResultVO> getFormList ( ExCommonResultVO param ) throws Exception {
		List<ExCommonResultVO> result = new ArrayList<ExCommonResultVO>( );
		try {
			result = (List<ExCommonResultVO>) list( "ExConfigFormListInfo", param );
		}
		catch ( Exception e ) {
			throw e;
		}
		return result;
	}

	/* 항목 존재 확인 */
	/**
	 *   * @Method Name : getIsEmptyItemList
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 항목 존재 확인
	 *   * @param param
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public ExConfigItemVO getIsEmptyItemList ( ExConfigItemVO param ) throws Exception {
		ExConfigItemVO result = new ExConfigItemVO( );
		try {
			result = (ExConfigItemVO) select( "ExConfigIsEmptyItemList", param );
			if ( result != null ) {
				// do nothing
			}
		}
		catch ( Exception e ) {
			throw e;
		}
		return result;
	}

	/* 항목설정 최초 조회 */
	/**
	 *   * @Method Name : getFirstItemList
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 항목설정 최초 조회
	 *   * @param param
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@SuppressWarnings ( "unchecked" )
	public List<ExConfigItemVO> getFirstItemList ( ExConfigItemVO param ) throws Exception {
		List<ExConfigItemVO> result = new ArrayList<ExConfigItemVO>( );
		try {
			result = (List<ExConfigItemVO>) list( "ExConfigFirstItemList", param );
		}
		catch ( Exception e ) {
			throw e;
		}
		return result;
	}

	/* 항목설정 조회 */
	/**
	 *   * @Method Name : getItemList
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 항목설정 조회
	 *   * @param param
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@SuppressWarnings ( "unchecked" )
	public List<ExConfigItemVO> getItemList ( ExConfigItemVO param ) throws Exception {
		List<ExConfigItemVO> result = new ArrayList<ExConfigItemVO>( );
		try {
			result = (List<ExConfigItemVO>) list( "ExConfigItemListS", param );
		}
		catch ( Exception e ) {
			throw e;
		}
		return result;
	}

	/* 항목 정보 삭제 */
	/**
	 *   * @Method Name : setItemListD
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 항목 정보 삭제
	 *   * @param param
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public boolean setItemListD ( ExConfigItemVO param ) throws Exception {
		boolean result = true;
		try {
			delete( "ExConfigItemListD", param );
		}
		catch ( Exception e ) {
			result = false;
			throw e;
		}
		return result;
	}

	/* 항목 정보 추가 */
	/**
	 *   * @Method Name : setItemListI
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 항목 정보 추가
	 *   * @param param
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public boolean setItemListI ( ExConfigItemVO param ) throws Exception {
		boolean result = true;
		try {
			insert( "ExConfigItemListI", param );
		}
		catch ( Exception e ) {
			result = false;
			throw e;
		}
		return result;
	}

	/* 지출결의 작성화면 - 테이블 헤더정보 조회 */
	/**
	 *   * @Method Name : getItemListS
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 지출결의 작성화면 - 테이블 헤더정보 조회
	 *   * @param param
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@SuppressWarnings ( "unchecked" )
	public List<ExConfigItemVO> getItemListS ( ExConfigItemVO param ) throws Exception {
		List<ExConfigItemVO> result = new ArrayList<ExConfigItemVO>( );
		try {
			result = (List<ExConfigItemVO>) list( "ExMasterGridItemInfoS", param );
		}
		catch ( Exception e ) {
			throw e;
		}
		return result;
	}

	/* 지출결의 설정 옵션 */
	/**
	 *   * @Method Name : ExConfigOptionListInfoSelect
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 지출결의 설정 옵션
	 *   * @param configVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@SuppressWarnings ( "unchecked" )
	public List<ExConfigOptionVO> ExConfigOptionListInfoSelect ( ExConfigOptionVO configVo ) throws Exception {
		List<ExConfigOptionVO> configListVo = new ArrayList<ExConfigOptionVO>( );
		configListVo = (List<ExConfigOptionVO>) select( "ExConfigOptionListInfoSelect", configVo );
		return configListVo;
	}

	/* 주석없음 */
	/**
	 *   * @Method Name : ExConfigOptionItemsSelect
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 주석없음
	 *   * @param params
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@SuppressWarnings ( "unchecked" )
	public ArrayList<Map<String, Object>> ExConfigOptionItemsSelect ( Map<String, Object> params ) throws Exception {
		ArrayList<Map<String, Object>> returnList = (ArrayList<Map<String, Object>>) this.list( "ExConfigExpendSettingItems", params );
		return returnList;
	}

	/* 주석없음 */
	/**
	 *   * @Method Name : ExConfigOptionItemsUpdate
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 주석없음
	 *   * @param params
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public int ExConfigOptionItemsUpdate ( Map<String, Object> params ) throws Exception {
		this.update( "ExConfigExpendUpdateItems", params );
		return 0;
	}

	/* 주석없음 */
	/**
	 *   * @Method Name : ExConfigOptionCodeListInfoSelect
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 주석없음
	 *   * @param configVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@SuppressWarnings ( "unchecked" )
	public List<ExCommonResultVO> ExConfigOptionCodeListInfoSelect ( ExConfigOptionVO configVo ) throws Exception {
		List<ExCommonResultVO> resultListVo = new ArrayList<ExCommonResultVO>( );
		resultListVo = (List<ExCommonResultVO>) select( "ExConfigOptionCodeListInfoSelect", configVo );
		return resultListVo;
	}

	/* 주석없음 */
	/**
	 *   * @Method Name : ExConfigOptionInfoUpdate
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 주석없음
	 *   * @param configVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public ExCommonResultVO ExConfigOptionInfoUpdate ( ExConfigOptionVO configVo ) throws Exception {
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		/* ibatis 에서 update() 실행시 return 값 : 성공시 "1" / 실패시 "0" */
		if ( update( "ExConfigOptionInfoUpdate", configVo ) > 0 ) {
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( "정상처리되었습니다." );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( configVo ) );
		}
		else {
			resultVo.setCode( commonCode.FAIL );
			resultVo.setMessage( "실패하였습니다." );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( configVo ) );
		}
		return resultVo;
	}

	/* 주석없음 */
	/**
	 *   * @Method Name : ExOptionLoadSetting
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 주석없음
	 *   * @param param
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@SuppressWarnings ( "unchecked" )
	public List<ExOptionVO> ExOptionLoadSetting ( Map<String, Object> param ) throws Exception {
		List<ExOptionVO> resultListVo = new ArrayList<ExOptionVO>( );
		resultListVo = (List<ExOptionVO>) list( "ExConfigOptionSelect", param );
		return resultListVo;
	}

	/* 주석없음 */
	/**
	 *   * @Method Name : ExConfigExpendInsertItems
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 주석없음
	 *   * @param param
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public boolean ExConfigExpendInsertItems ( Map<String, Object> param ) throws Exception {
		boolean result = true;
		try {
			insert( "ExConfigExpendInsertItems", param );
		}
		catch ( Exception e ) {
			result = false;
		}
		return result;
	}

	/* 주석없음 */
	/**
	 *   * @Method Name : ExConfigExpendDeleteItems
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 주석없음
	 *   * @param param
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public boolean ExConfigExpendDeleteItems ( Map<String, Object> param ) throws Exception {
		boolean result = true;
		try {
			delete( "ExConfigExpendDeleteItems", param );
		}
		catch ( Exception e ) {
			result = false;
		}
		return result;
	}

	/* 관리항목 설정 - 관리항목 설정 정보 조회 */
	/**
	 *   * @Method Name : ExConfigMngListInfoSelect
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 관리항목 설정 - 관리항목 설정 정보 조회
	 *   * @param mngVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@SuppressWarnings ( "unchecked" )
	public List<ExCodeMngVO> ExConfigMngListInfoSelect ( ExCodeMngVO mngVo ) throws Exception {
		/* parameter : comp_seq, form_seq, drcr_gbn, search_str */
		List<ExCodeMngVO> mngListVo = new ArrayList<ExCodeMngVO>( );
		/* return : comp_seq, form_seq, mng_code, mng_name, ctd_code, ctd_name, drcr_gbn, use_gbn, use_gbn_name, cust_set, cust_set_target, modify_yn */
		mngListVo = (List<ExCodeMngVO>) list( "ExConfigMngListInfoSelect", mngVo );
		return mngListVo;
	}

	/* 관리항목 설정 - 관리항목 설정 정보 생성 */
	/**
	 *   * @Method Name : ExConfigMngInfoInsert
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 관리항목 설정 - 관리항목 설정 정보 생성
	 *   * @param mngVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public ExCommonResultVO ExConfigMngInfoInsert ( ExCodeMngVO mngVo ) throws Exception {
		/* parameter : comp_seq, form_seq, drcr_gbm, mng_code, mng_name, use_gbn, ctd_code, ctd_name, cust_set, cust_set_target, modify_yn, create_seq, modify_seq */
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		insert( "ExConfigMngInfoInsert", mngVo );
		resultVo.setCode( commonCode.SUCCESS );
		resultVo.setMessage( "정상처리되었습니다." );
		resultVo.setMap( CommonConvert.CommonGetObjectToMap( mngVo ) );
		return resultVo;
	}

	/* 관리항목 설정 - 관리항목 설정 정보 삭제 */
	/**
	 *   * @Method Name : ExConfigMngInfoDelete
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 관리항목 설정 - 관리항목 설정 정보 삭제
	 *   * @param mngVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public ExCommonResultVO ExConfigMngInfoDelete ( ExCodeMngVO mngVo ) throws Exception {
		/* parameter : comp_seq, form_seq, drcr_gbm, mng_code, mng_name, use_gbn, ctd_code, ctd_name, cust_set, cust_set_target, modify_yn, create_seq, modify_seq */
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		delete( "ExConfigMngInfoDelete", mngVo );
		resultVo.setCode( commonCode.SUCCESS );
		resultVo.setMessage( "정상처리되었습니다." );
		resultVo.setMap( CommonConvert.CommonGetObjectToMap( mngVo ) );
		return resultVo;
	}

	/* 공통코드 */
	/* 공통코드 - 계정과목 생성 */
	/**
	 *   * @Method Name : ExCodeAcctInfoInsert
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 공통코드 - 계정과목 생성
	 *   * @param params
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public ResultVO ExCodeAcctInfoInsert ( Map<String, Object> params ) throws Exception {
		/* parameters : comp_seq, acct_code, acct_name, vat_yn, use_yn, create_seq, modify_seq */
		ResultVO resultVo = new ResultVO( );
		try {
			insert( "ExCodeAcctInfoInsert", params );
			resultVo.setResultCode( commonCode.SUCCESS );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
		}
		catch ( Exception e ) {
			resultVo.setResultCode( commonCode.FAIL );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			throw e;
		}
		return resultVo;
	}

	/* 공통코드 - 계정과목 수정 */
	/**
	 *   * @Method Name : ExCodeAcctInfoUpdate
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 공통코드 - 계정과목 수정
	 *   * @param params
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public ResultVO ExCodeAcctInfoUpdate ( Map<String, Object> params ) throws Exception {
		/* parameters : acct_name, vat_yn, use_yn, modify_seq, comp_seq, acct_code */
		ResultVO resultVo = new ResultVO( );
		/* ibatis 에서 update() 실행시 return 값 : 성공시 "1" / 실패시 "0" */
		if ( update( "ExCodeAcctInfoUpdate", params ) > 0 ) {
			resultVo.setResultCode( commonCode.SUCCESS );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
		}
		else {
			resultVo.setResultCode( commonCode.FAIL );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
		}
		return resultVo;
	}

	/* 공통코드 - 계정과목 삭제 */
	/**
	 *   * @Method Name : ExCodeAcctInfoDelete
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 공통코드 - 계정과목 삭제
	 *   * @param params
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public ResultVO ExCodeAcctInfoDelete ( Map<String, Object> params ) throws Exception {
		/* parameters : comp_seq, acct_code */
		ResultVO resultVo = new ResultVO( );
		/* ibatis 에서 delete() 실행시 return 값 : 삭제한 row 수 */
		if ( delete( "ExCodeAcctInfoDelete", params ) > 0 ) {
			resultVo.setResultCode( commonCode.SUCCESS );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
		}
		else {
			resultVo.setResultCode( commonCode.FAIL );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
		}
		return resultVo;
	}

	/* 공통코드 */
	/* 공통코드 증빙유형 등록 */
	/**
	 *   * @Method Name : ExCodeAuthInfoInsert
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 공통코드 증빙유형 등록
	 *   * @param params
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public ResultVO ExCodeAuthInfoInsert ( Map<String, Object> params ) throws Exception {
		/* parameters : comp_seq, auth_div, auth_code, auth_name, cash_type, cr_acct_code, cr_acct_name, vat_acct_code , vat_acct_name, vat_type_code, vat_type_name, erp_auth_code, erp_auth_name, auth_required_yn, partner_required_yn , card_required_yn, project_required_yn, note_required_yn, no_tax_code, no_tax_name, order_num, use_yn, va_type_code , va_type_name, create_seq, modify_seq */
		ResultVO resultVo = new ResultVO( );
		try {
			insert( "ExCodeAuthInfoInsert", params );
			resultVo.setResultCode( commonCode.SUCCESS );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
		}
		catch ( Exception e ) {
			resultVo.setResultCode( commonCode.FAIL );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			throw e;
		}
		return resultVo;
	}

	/* 공통코드 증빙유형 수정 */
	/**
	 *   * @Method Name : ExCodeAuthInfoUpdate
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 공통코드 증빙유형 수정
	 *   * @param params
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public ResultVO ExCodeAuthInfoUpdate ( Map<String, Object> params ) throws Exception {
		/* parameters : auth_name, cash_type, cr_acct_code, cr_acct_name, vat_acct_code, vat_acct_name, vat_type_code, vat_type_name , erp_auth_code, erp_auth_name, auth_required_yn, partner_required_yn, card_required_yn, project_required_yn , note_required_yn, no_tax_code, no_tax_name, order_num, use_yn, va_type_code, va_type_name, modify_seq , comp_seq, auth_div, auth_code */
		ResultVO resultVo = new ResultVO( );
		/* ibatis 에서 update() 실행시 return 값 : 성공시 "1" / 실패시 "0" */
		if ( update( "ExCodeAuthInfoUpdate", params ) > 0 ) {
			resultVo.setResultCode( commonCode.SUCCESS );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
		}
		else {
			resultVo.setResultCode( commonCode.FAIL );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
		}
		return resultVo;
	}

	/* 공통코드 증빙유형 삭제 */
	/**
	 *   * @Method Name : ExCodeAuthInfoDelete
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 공통코드 증빙유형 삭제
	 *   * @param params
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public ResultVO ExCodeAuthInfoDelete ( Map<String, Object> params ) throws Exception {
		/* parameters : comp_seq, auth_div, auth_code */
		ResultVO resultVo = new ResultVO( );
		/* ibatis 에서 delete() 실행시 return 값 : 삭제한 row 수 */
		if ( delete( "ExCodeAuthInfoDelete", params ) > 0 ) {
			resultVo.setResultCode( commonCode.SUCCESS );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
		}
		else {
			resultVo.setResultCode( commonCode.FAIL );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
		}
		return resultVo;
	}

	/* 공통코드 - 표준적요 생성 */
	/**
	 *   * @Method Name : ExCodeSummaryInfoInsert
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 공통코드 - 표준적요 생성
	 *   * @param summaryVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public ExCodeSummaryVO ExCodeSummaryInfoInsert ( ExCodeSummaryVO summaryVo ) throws Exception {
		insert( "ExCodeSummaryInfoInsert", summaryVo );
		return summaryVo;
	}

	/* 공통코드 - 표준적요 수정 */
	/**
	 *   * @Method Name : ExCodeSummaryInfoUpdate
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 공통코드 - 표준적요 수정
	 *   * @param summaryVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
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
	/**
	 *   * @Method Name : ExCodeSummaryInfoDelete
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 공통코드 - 표준적요 삭제
	 *   * @param summaryVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
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

	/* 회사 리스트 조회 */
	/**
	 *   * @Method Name : getCompanyList
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 회사 리스트 조회
	 *   * @param param
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> getCompanyList ( Map<String, Object> param ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			result = list( "ExConfigCompListInfo", param );
		}
		catch ( Exception e ) {
			throw e;
		}
		return result;
	}

	/* form 리스트 조회 */
	/**
	 *   * @Method Name : getFormList
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : form 리스트 조회
	 *   * @param param
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> getFormList ( Map<String, Object> param ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			result = list( "ExConfigFormListInfo", param );
		}
		catch ( Exception e ) {
			throw e;
		}
		return result;
	}

	/* 주석없음 */
	/**
	 *   * @Method Name : ExCodeVatTypeListInfoSelect
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 주석없음
	 *   * @param vatTypeVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExCodeVatTypeListInfoSelect ( Map<String, Object> vatTypeVo ) throws Exception {
		List<Map<String, Object>> vatTeypListVo = new ArrayList<Map<String, Object>>( );
		vatTeypListVo = (List<Map<String, Object>>) list( "ExCodeVatTypeListInfoSelect", vatTypeVo );
		return vatTeypListVo;
	}

	/* 공통코드 - 부가세구분 등록 */
	/**
	 *   * @Method Name : ExCodeVatTypeInfoInsert
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 공통코드 - 부가세구분 등록
	 *   * @param vatTypeVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public ExCodeAuthVO ExCodeVatTypeInfoInsert ( ExCodeAuthVO vatTypeVo ) throws Exception {
		insert( "ExCodeVatTypeInfoInsert", vatTypeVo );
		return vatTypeVo;
	}

	/* 주석없음 */
	/**
	 *   * @Method Name : ExCodeVatTypeInfoUpdate
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 주석없음
	 *   * @param vatTypeVo
	 *   * @return
	 *   * @throws Exception
	 *   
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

	/* 주석없음 */
	/**
	 *   * @Method Name : ExCodeVatTypeInfoDelete
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 주석없음
	 *   * @param vatTypeVo
	 *   * @return
	 *   * @throws Exception
	 *   
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
}
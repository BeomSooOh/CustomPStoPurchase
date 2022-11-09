package expend.ex.admin.config;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import common.vo.common.CommonInterface.commonCode;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FExAdminConfigServiceADAO" )
public class FExAdminConfigServiceADAO extends EgovComAbstractDAO {

	/**
	 *   * @Method Name : ExAdminConfigItemListInfoSelect
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 항목 설정 목록 조회
	 *   * @param params
	 *   * @return
	 *   
	 */
	@SuppressWarnings ( "unchecked" )
	List<Map<String, Object>> ExAdminConfigItemListInfoSelect ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) list( "ExAdminConfig.ExAdminConfigItemListInfoSelect", params );
		return result;
	}

	/* 항목 설정 생성 & 수정 */
	/**
	 *   * @Method Name : ExAdminConfigItemInfoInsert
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 항목 설정 생성 & 수정
	 *   * @param params
	 *   * @return
	 *   
	 */
	public int ExAdminConfigItemInfoInsert ( Map<String, Object> params ) {
		int result = Integer.parseInt( commonCode.EMPTYSEQ );
		try {
			result = (int) update( "ExAdminConfig.ExAdminConfigItemInfoInsert", params );
		}
		catch ( Exception e ) {
			result = Integer.parseInt( commonCode.EMPTYSEQ );
		}
		return result;
	}

	/* 항목 설정 초기화 */
	/**
	 *   * @Method Name : ExAdminConfigItemListInfoDelete
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 항목 설정 초기화
	 *   * @param params
	 *   * @return
	 *   
	 */
	public int ExAdminConfigItemListInfoDelete ( Map<String, Object> params ) {
		int result = Integer.parseInt( commonCode.EMPTYSEQ );
		try {
			result = (int) delete( "ExAdminConfig.ExAdminConfigItemListInfoDelete", params );
		}
		catch ( Exception e ) {
			result = Integer.parseInt( commonCode.EMPTYSEQ );
		}
		return result;
	}

	/**
	 *   * @Method Name : ExAdminConfigOptionSelect
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 :
	 *   * @param param
	 *   * @return
	 *   
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExAdminConfigOptionSelect ( Map<String, Object> param ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) list( "ExAdminConfigOptionSelect", param );
		return result;
	}

	/**
	 *   * @Method Name : ExAdminConfigOptionSelect
	 *   * @변경이력 :
	 *   * @메뉴 : [관리자] 명칭설정 / 기본 리스트 출력
	 *   * @Method 설명 : 명칭정보 전체 조회
	 *   * @param param
	 *   * @return
	 *   
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExAdminLabelInfoListSelect ( Map<String, Object> param ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) list( "ExAdminLabelInfoListSelect", param );
		return result;
	}

	/**
	 *   * @Method Name : ExAdminConfigOptionUpdate
	 *   * @변경이력 :
	 *   * @메뉴 : [관리자] 명칭설정 / 저장 버튼 클릭
	 *   * @Method 설명 : 명칭정보 업데이트
	 *   * @param param
	 *   * @return
	 *   
	 */
	public int ExAdminLabelInfoListUpdate ( Map<String, Object> param ) {
		int result = update( "ExAdminLabelInfoListUpdate", param );
		if ( result == 0 ) {
			insert( "ExAdminLabelInfoListInsert", param );
		}
		return result;
	}

	/**
	 *   * @Method Name : ExAdminConfigOptionUpdate
	 *   * @변경이력 :
	 *   * @메뉴 : [관리자] 명칭설정 / 저장 버튼 클릭
	 *   * @Method 설명 : 툴팁정보 업데이트
	 *   * @param param
	 *   * @return
	 *   
	 */
	public int ExAdminLabelTolltipInfoListUpdate ( Map<String, Object> param ) {
		int result = update( "ExAdminLabelTolltipInfoListUpdate", param );
		if ( result == 0 ) {
			insert( "ExAdminLabelInfoListInsert", param );
		}
		return result;
	}

	/**
	 *   * @Method Name : ExAdminLabelInfoWholeInsert
	 *   * @변경이력 :
	 *   * @메뉴 : [관리자] 명칭설정 / 관리자 최초 조회 이후
	 *   * @Method 설명 : 기본데이터에서 해당 회사로 명칭데이터 전체 복사
	 *   * @param param
	 *   * @return
	 *   
	 */
	public int ExAdminLabelInfoWholeInsert ( Map<String, Object> param ) {
		int result = update( "ExAdminLabelInfoWholeInsert", param );
		return result;
	}

	/**
	 *   * @Method Name : ExAdminLabelInfoWholeInsert
	 *   * @변경이력 :
	 *   * @메뉴 : [관리자] 명칭설정 /명칭 정보 초기화
	 *   * @Method 설명 : 해당 회사에 설정된 명칭 데이터 전체 삭제
	 *   * @param param
	 *   * @return
	 *   
	 */
	public int ExAdminLabelInfoinInitialization ( Map<String, Object> param ) {
		int result = delete( "ExAdminLabelInfoinInitialization", param );
		return result;
	}

	/**
	 *   * @Method Name : ExAdminGetButtonInfoList
	 *   * @변경이력 :
	 *   * @메뉴 : [관리자] 버튼설정 / 버튼 설정정보 조회
	 *   * @Method 설명 : 해당 회사에 설정된 버튼 설정 정보 조회 / 설정된 정보가 없으면 기초 데이터 호출
	 *   * @param param
	 *   * @return
	 *   
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExAdminGetButtonInfoList ( Map<String, Object> param ) {
		List<Map<String, Object>> result = this.list( "ExAdminButtonInfoListSelect", param );
		return result;
	}

	/**
	 *   * @Method Name : ExAdminGetButtonInfoCopy
	 *   * @변경이력 :
	 *   * @메뉴 : [관리자] 버튼설정 / 버튼 설정 기초데이터 복사
	 *   * @Method 설명 : 버튼설정 기초데이터 복사
	 *   * @param param
	 *   * @return
	 *   
	 */
	public void ExAdminGetButtonInfoCopy ( Map<String, Object> param ) {
		this.insert( "ExAdminButtonInfoListCopy", param );
	}

	/**
	 *   * @Method Name : ExAdminSetButtonLocationUpdate
	 *   * @변경이력 :
	 *   * @메뉴 : [관리자] 버튼설정 / 버튼 위치 정보 저장
	 *   * @Method 설명 :
	 *   * @param param
	 *   * @return
	 *   
	 */
	public int ExAdminSetButtonLocationUpdate ( Map<String, Object> param ) {
		return this.update( "ExAdminButtonLocationInfoUpdate", param );
	}

	/**
	 *   * @Method Name : ExAdminSetButtonUpdate
	 *   * @변경이력 :
	 *   * @메뉴 : [관리자] 버튼설정 / 버튼 세부정보 저장
	 *   * @Method 설명 :
	 *   * @param param
	 *   * @return
	 *   
	 */
	public int ExAdminSetButtonUpdate ( Map<String, Object> param ) {
		return this.update( "ExAdminButtonInfoUpdate", param );
	}

	/**
	 *   * @Method Name : ExAdminSetButtonUpdate
	 *   * @변경이력 :
	 *   * @메뉴 : [관리자] 버튼설정 / 개발자 버튼 생성
	 *   * @Method 설명 :
	 *   * @param param
	 *   * @return
	 *   
	 */
	public int ExAdminSetButtonCreate ( Map<String, Object> param ) {
		try {
			this.insert( "ExAdminButtonInfoInsert", param );
		}
		catch ( Exception ex ) {
			return 0;
		}
		return 1;
	}

	/**
	 *   * @Method Name : ExAdminSetButtonUpdate
	 *   * @변경이력 :
	 *   * @메뉴 : [관리자] 버튼설정 / 개발자 버튼 삭제
	 *   * @Method 설명 :
	 *   * @param param
	 *   * @return
	 *   
	 */
	public int ExAdminSetButtonDelete ( Map<String, Object> param ) {
		try {
			this.delete( "ExAdminButtonInfoDelete", param );
		}
		catch ( Exception ex ) {
			return 0;
		}
		return 1;
	}

	/**
	 *   * @Method Name : ExAdminSetButtonUpdate
	 *   * @변경이력 :
	 *   * @메뉴 : [관리자] 버튼설정 / 개발자 라이센스 설정
	 *   * @Method 설명 :
	 *   * @param param
	 *   * @return
	 *   
	 */
	public int ExAdminButtonLicenseInfoUpdate ( Map<String, Object> param ) {
		return this.delete( "ExAdminButtonLicenseInfoUpdate", param );
	}

	/**
	 *   * @Method Name : ExAdminGetFormInfoSelect
	 *   * @변경이력 :
	 *   * @메뉴 : [관리자] 버튼설정 / 문서 옵션 조회
	 *   * @Method 설명 :
	 *   * @param param
	 *   * @return
	 *   
	 */
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> ExAdminGetFormInfoSelect ( Map<String, Object> param ) {
		return (Map<String, Object>) this.select( "ExAdminGetFormInfoSelect", param );
	}

	/* ## 양식별 표준적요 설정 ## */
	/* ## 양식별 표준적요 설정 ## - 표준적요 등록 */
	public int ExAdminSetSummaryAuthCreate ( Map<String, Object> param ) throws Exception {
		return (int) this.update( "ExAdminSetSummaryAuthCreate", param );
	}

	/* ## 양식별 표준적요 설정 ## - 표쥰적요 삭제 */
	public int ExAdminSetSummaryAuthDelete ( Map<String, Object> param ) throws Exception {
		return (int) this.delete( "ExAdminSetSummaryAuthDelete", param );
	}

	/* ## 양식별 증빙유형 설정 ## */
	/* ## 양식별 증빙유형 설정 ## - 증빙유형 등록 */
	public int ExAdminSetAuthTypeAuthCreate ( Map<String, Object> param ) throws Exception {
		return (int) this.update( "ExAdminSetAuthTypeAuthCreate", param );
	}

	/* ## 양식별 증빙유형 설정 ## - 증빙유형 삭제 */
	public int ExAdminSetAuthTypeAuthDelete ( Map<String, Object> param ) throws Exception {
		return (int) this.delete( "ExAdminSetAuthTypeAuthDelete", param );
	}

	/* ## 양식별 증빙유형 설정 ## - 증빙유형 리스트 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExFormLinkAuthListSelect ( Map<String, Object> param ) throws Exception {
		return this.list( "ExFormLinkAuthListSelect", param );
	}

	/* ## 양식별 증빙유형 설정 ## - 표준적요 리스트 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExFormLinkSummaryListSelect ( Map<String, Object> param ) throws Exception {
		return this.list( "ExFormLinkSummaryListSelect", param );
	}

	/* ## 양식별 증빙유형 설정 ## - 증빙유형 링크 리스트 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExFormLinkSettingAuthListSelect ( Map<String, Object> param ) throws Exception {
		return (List<Map<String, Object>>) this.list( "ExFormLinkSettingAuthListSelect", param );
	}

	/* ## 양식별 증빙유형 설정 ## - 표준적요 링크 리스트 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExFormLinkSettingSummaryListSelect ( Map<String, Object> param ) throws Exception {
		return (List<Map<String, Object>>) this.list( "ExFormLinkSettingSummaryListSelect", param );
	}

	/* 지출결의 마감 등록 */
	public int ExAdminExpendCloseInsert ( Map<String, Object> param ) {
		return (int) this.insert( "ExAdminExpendCloseInsert", param );
	}

	/* 지출결의 마감 등록(전체양식) */
	public int ExAdminExpendCloseInsertAllForm ( Map<String, Object> param ) throws Exception {
		int result = 0;
		try {
			this.insert( "ExAdminExpendCloseInsertAllForm", param );
			result = 1;
		}
		catch ( Exception e ) {
			result = 0;
		}
		return result;
	}

	/* 지출결의 마감 수정 */
	public int ExAdminExpendCloseUpdate ( Map<String, Object> param ) {
		return (int) this.update( "ExAdminExpendCloseUpdate", param );
	}

	/* 지출결의 마감 삭제 */
	public int ExAdminExpendCloseDelete ( Map<String, Object> param ) {
		return (int) this.delete( "ExAdminExpendCloseDelete", param );
	}

	/* 지출결의 마감 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExAdminExpendCloseSelect ( Map<String, Object> param ) {
		return this.list( "ExAdminExpendCloseSelect", param );
	}

	/* 지출결의 마감 이력 등록 */
	public int ExAdminExpendCloseHistoryInsert ( Map<String, Object> param ) {
		return (int) this.insert( "ExAdminExpendCloseHistoryInsert", param );
	}

	/* 지출결의 마감 양식 전체 등록 전 날짜 중복 체크 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExAdminExpendCloseFormInsertChkValidate ( Map<String, Object> param ) throws Exception {
		return (List<Map<String, Object>>) this.list( "ExAdminExpendCloseFormInsertChkValidate", param );
	}

	/* 지출결의 마감 등록 전 날짜 중복 체크 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExAdminExpendCloseFormInsertChkValidateOneForm ( Map<String, Object> param ) throws Exception {
		return (List<Map<String, Object>>) this.list( "ExAdminExpendCloseFormInsertChkValidateOneForm", param );
	}
}
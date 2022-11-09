package expend.ex.admin.config;

import java.util.List;
import java.util.Map;

import common.vo.common.ResultVO;


/**
 *   * @FileName : BExAdminConfigService.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 : 지출결의 설정 ( 관리자 ) - Service
 *   
 */
public interface BExAdminConfigService {

	/* 주석없음 */
	ResultVO ExAdminConfigOptionSelect ( Map<String, Object> param );

	/* 명칭설정 명칭정보 조회 */
	ResultVO ExAdminLabelInfoListSelect ( Map<String, Object> param );

	/* 명칭설정 명칭정보 저장 */
	ResultVO ExAdminLabelInfoListUpdate ( List<Map<String, Object>> param );

	/* 명칭설정 명칭정보 전체 초기화 */
	ResultVO ExAdminLabelInfoinInitialization ( Map<String, Object> param );

	/* 양식 옵션조회 */
	ResultVO ExAdminGetFormInfoSelect ( Map<String, Object> param ) throws Exception;

	/* 버튼설정 버튼정보 조회 */
	ResultVO ExAdminGetButtonInfoList ( Map<String, Object> param ) throws Exception;

	/* 버튼설정 버튼정보 갱신 */
	ResultVO ExAdminSetButtonLocationUpdate ( Map<String, Object> param ) throws Exception;

	/* 버튼설정 버튼 세부정보 갱신 */
	ResultVO ExAdminSetButtonUpdate ( Map<String, Object> param ) throws Exception;

	/* 버튼설정 버튼 개발자 신규 */
	ResultVO ExAdminSetButtonCreate ( Map<String, Object> param ) throws Exception;

	/* 버튼설정 버튼 개발자 삭제 */
	ResultVO ExAdminSetButtonDelete ( Map<String, Object> param ) throws Exception;

	/* ## 양식별 표준적요 설정 ## */
	/* ## 양식별 표준적요 설정 ## - 표준적요 등록 */
	ResultVO ExAdminSetSummaryAuthCreate ( Map<String, Object> param ) throws Exception;

	/* ## 양식별 표준적요 설정 ## - 표쥰적요 삭제 */
	ResultVO ExAdminSetSummaryAuthDelete ( Map<String, Object> param ) throws Exception;

	/* ## 양식별 증빙유형 설정 ## */
	/* ## 양식별 증빙유형 설정 ## - 증빙유형 등록 */
	ResultVO ExAdminSetAuthTypeAuthCreate ( Map<String, Object> param ) throws Exception;

	/* ## 양식별 증빙유형 설정 ## - 증빙유형 삭제 */
	ResultVO ExAdminSetAuthTypeAuthDelete ( Map<String, Object> param ) throws Exception;

	/* ## 양식별 증빙유형 설정 ## - 증빙유형 리스트 조회 */
	ResultVO ExFormLinkAuthListSelect ( Map<String, Object> param ) throws Exception;

	/* ## 양식별 증빙유형 설정 ## - 표준적요 리스트 조회 */
	ResultVO ExFormLinkSummaryListSelect ( Map<String, Object> param ) throws Exception;

	/* 양식 별 표준적요 & 증빙유형 설정 -설정된 표준적요 조회 */
	ResultVO ExFormLinkSettingSummaryListSelect ( ResultVO result ) throws Exception;

	/* 양식 별 표준적요 & 증빙유형 설정 -설정된 증빙유형 조회 */
	ResultVO ExFormLinkSettingAuthListSelect ( ResultVO result ) throws Exception;
	
	/* 지출결의 마감일 설정 리스트 조회 */
	ResultVO ExAdminExpendCloseDateSelect ( ResultVO result ) throws Exception;
	
	/* 지출결의 마감일 설정 리스트 등록 */
	ResultVO ExAdminExpendCloseDateInsert ( ResultVO result ) throws Exception;
	
	/* 지출결의 마감일 설정 리스트 등록(전체양식) - 모든양식적용 시 마감기간 중 등록된 내역 있는지 확인 */
	ResultVO ExAdminExpendCloseFormInsertChkValidate ( ResultVO result ) throws Exception;
	
	/* 지출결의 마감일 설정 리스트 등록(전체양식) */
	ResultVO ExAdminExpendCloseInsertAllForm ( ResultVO result ) throws Exception;
	
	/* 지출결의 마감일 설정 리스트 수정 */
	ResultVO ExAdminExpendCloseDateUpdate ( ResultVO result ) throws Exception;
	
	/* 지출결의 마감일 설정 리스트 삭제 */
	ResultVO ExAdminExpendCloseDateDelete ( ResultVO result ) throws Exception;
	
	/* 지출결의 마감일 설정 리스트 선택 삭제 */
	ResultVO ExAdminExpendSelectedCloseDateDelete ( ResultVO result ) throws Exception;
	
	/* 지출결의 마감일 이력 등록 */
	ResultVO ExAdminExpendCloseDateHistoryInsert ( ResultVO result ) throws Exception;
}

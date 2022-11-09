package expend.ex.admin.config;

import java.util.List;
import java.util.Map;

import common.vo.common.ResultVO;


public interface FExAdminConfigService {

	/* [버튼설정] 양식정보 조회 */
	ResultVO ExAdminGetFormInfoSelect ( Map<String, Object> param ) throws Exception;

	/* [버튼설정] 버튼 리스트 가져오기 */
	ResultVO ExAdminGetButtonInfoList ( Map<String, Object> param ) throws Exception;

	/* [버튼설정] 버튼 정보 업데이트 */
	ResultVO ExAdminSetButtonLocationUpdate ( List<Map<String, Object>> params ) throws Exception;

	/* [버튼설정] 버튼 세부 정보 업데이트 */
	ResultVO ExAdminSetButtonUpdate ( Map<String, Object> params ) throws Exception;

	/* [버튼설정] 버튼 개발자 신규 */
	ResultVO ExAdminSetButtonCreate ( Map<String, Object> params ) throws Exception;

	/* [버튼설정] 버튼 개발자 삭제 */
	ResultVO ExAdminSetButtonDelete ( Map<String, Object> params ) throws Exception;

	/* ## 양식별 표준적요 설정 ## */
	/* ## 양식별 표준적요 설정 ## - 표준적요 등록 */
	ResultVO ExAdminSetSummaryAuthCreate ( ResultVO result ) throws Exception;

	/* ## 양식별 표준적요 설정 ## - 표쥰적요 삭제 */
	ResultVO ExAdminSetSummaryAuthDelete ( ResultVO result ) throws Exception;

	/* ## 양식별 증빙유형 설정 ## */
	/* ## 양식별 증빙유형 설정 ## - 증빙유형 등록 */
	ResultVO ExAdminSetAuthTypeAuthCreate ( ResultVO result ) throws Exception;

	/* ## 양식별 증빙유형 설정 ## - 증빙유형 삭제 */
	ResultVO ExAdminSetAuthTypeAuthDelete ( ResultVO result ) throws Exception;

	/* ## 양식별 증빙유형 설정 ## - 증빙유형 리스트 조회 */
	ResultVO ExFormLinkAuthListSelect ( ResultVO result ) throws Exception;

	/* ## 양식별 증빙유형 설정 ## - 표준적요 리스트 조회 */
	ResultVO ExFormLinkSummaryListSelect ( ResultVO result ) throws Exception;

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
	
	/* 지출결의 마감일 이력 등록 */
	ResultVO ExAdminExpendCloseDateHistoryInsert ( ResultVO result ) throws Exception;
}

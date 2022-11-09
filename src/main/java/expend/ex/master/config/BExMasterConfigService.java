package expend.ex.master.config;

import java.util.List;
import java.util.Map;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExCodeAuthVO;
import common.vo.ex.ExCodeMngVO;
import common.vo.ex.ExCodeSummaryVO;
import common.vo.ex.ExConfigItemListVO;
import common.vo.ex.ExConfigItemVO;
import common.vo.ex.ExConfigOptionVO;
import common.vo.ex.ExOptionVO;
import common.vo.g20.ExCommonResultVO;


public interface BExMasterConfigService {
	/* Biz - 환경설정 - 법인카드관리 */

	/* Biz - 환경설정 - 지출결의설정 */
	/* Biz - 지출결의설정 - 옵션목록 조회 */
	List<ExConfigOptionVO> ExConfigOptionListInfoSelect ( ExConfigOptionVO configVo ) throws Exception;

	/* Biz - 지출결의설정 - 옵션 하위코드 조회 */
	List<ExCommonResultVO> ExConfigOptionCodeListInfoSelect ( ExConfigOptionVO configVo ) throws Exception;

	/* Biz - 지출결의설정 - 옵션 수정 */
	ExCommonResultVO ExConfigOptionInfoUpdate ( ExConfigOptionVO configVo ) throws Exception;

	/* Biz - 지출결의설정 - 사용 옵션목록 조회 */
	List<ExOptionVO> ExOptionLoadSetting ( Map<String, Object> param ) throws Exception;

	/* Biz - 환경설정 - 항목설정 */
	/* Biz - 항목설정 - 항목목록 조회 */
	List<Map<String, Object>> ExConfigOptionItemsInfoSelect ( Map<String, Object> param ) throws Exception;

	/* Biz - 항목설정 - 항목정보 수정 */
	int ExConfigOptionItemsInfoUpdate ( Map<String, Object> param ) throws Exception;

	/* Biz - 항목설정 - 항목정보 생성 */
	boolean ExConfigExpendInsertItems ( Map<String, Object> param ) throws Exception;

	/* Biz - 항목설정 - 항목정보 삭제 */
	boolean ExConfigExpendDeleteItems ( Map<String, Object> param ) throws Exception;

	/* Biz - 항목설정 - 항목목록 조회 */
	ExConfigItemListVO GetItemListS ( Map<String, Object> param ) throws Exception;

	/* Biz - 항목설정 - 항목정보 수정 */
	boolean setItemList ( ExConfigItemListVO param ) throws Exception;

	/* Biz - 환경설정 - 관리항목설정 */
	/* Biz - 관리항목설정 - 관리항목 정보 생성 */
	ExCommonResultVO ExConfigMngInfoInsert ( ExCodeMngVO mngVo ) throws Exception;

	/* Biz - 관리항목설정 - 관리항목 정보 삭제 */
	ExCommonResultVO ExConfigMngInfoDelete ( ExCodeMngVO mngVo ) throws Exception;

	/* Biz - 관리항목설정 - 관리항목 설정 정보 삭제 후 생성 */
	ExCommonResultVO ExConfigMngInfoUpdate ( ExCodeMngVO mngVo ) throws Exception;

	/* 주석없음 */
	List<Map<String, Object>> GCompanyListS ( Map<String, Object> params ) throws Exception;

	/* 주석없음 */
	List<Map<String, Object>> GFormListS ( Map<String, Object> params ) throws Exception;

	/* Biz - 공통코드 - 계정과목 */
	/* Biz - 공통코드 - 계정과목 등록 */
	ResultVO ExCodeAcctInfoInsert ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;

	/* Biz - 공통코드 - 계정과목 수정 */
	ResultVO ExCodeAcctInfoUpdate ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;

	/* Biz - 공통코드 - 계정과목 삭제 */
	ResultVO ExCodeAcctInfoDelete ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;

	/* Biz - 공통코드 - 증빙유형 */
	/* Biz - 공통코드 - 증빙유형 등록 */
	ResultVO ExCodeAuthInfoInsert ( Map<String, Object> params ) throws Exception;

	/* Biz - 공통코드 - 증빙유형 수정 */
	ResultVO ExCodeAuthInfoUpdate ( Map<String, Object> params ) throws Exception;

	/* Biz - 공통코드 - 증빙유형 삭제 */
	ResultVO ExCodeAuthInfoDelete ( Map<String, Object> params ) throws Exception;

	/* Biz - 공통코드 - 표준적요 등록 */
	ExCodeSummaryVO ExCodeSummaryInfoInsert ( ExCodeSummaryVO summaryVo ) throws Exception;

	/* Biz - 공통코드 - 표준적요 수정 */
	ExCommonResultVO ExCodeSummaryInfoUpdate ( ExCodeSummaryVO summaryVo ) throws Exception;

	/* Biz - 공통코드 - 표준적요 삭제 */
	ExCommonResultVO ExCodeSummaryInfoDelete ( ExCodeSummaryVO summaryVo ) throws Exception;

	/* Biz - 공통코드 - 부가세 구분 목록 조회 */
	List<Map<String, Object>> ExCodeVatTypeListInfoSelect ( Map<String, Object> vatTypeVo, ConnectionVO conVo ) throws Exception;

	/* Biz - 공통코드 - 부가세 생성 */
	ExCodeAuthVO ExCodeVatTypeInfoInsert ( ExCodeAuthVO vatTypeVo, ConnectionVO conVo ) throws Exception;

	/* Biz - 공통코드 - 부가세 수정 */
	ExCommonResultVO ExCodeVatTypeInfoUpdate ( ExCodeAuthVO vatTypeVo, ConnectionVO conVo ) throws Exception;

	/* Biz - 공통코드 - 부가세 삭제 */
	ExCommonResultVO ExCodeVatTypeInfoDelete ( ExCodeAuthVO vatTypeVo, ConnectionVO conVo ) throws Exception;

	/* 주석없음 */
	List<ExConfigItemVO> getExpendGridHeadInfoS ( ExConfigItemVO param ) throws Exception;
}

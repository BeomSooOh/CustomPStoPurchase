package expend.ex.admin.etax;

import common.vo.common.ResultVO;
import common.vo.ex.ExCodeETaxAuthVO;


/**
 *   * @FileName : BExAdminETaxService.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 : 지출결의 설정 ( 관리자 ) - Service
 *   
 */
public interface BExAdminETaxService {

	/* 세금계산서 권한 설정 페이지 - 회사 귀속 모든 권한 리스트 조회 */
	ResultVO AdminETaxAuthAllListSelect ( ResultVO param ) throws Exception;
	
	/* 세금계산서 권한 설정 페이지 - 권한 리스트 조회 */
	ResultVO ExAdminETaxAuthListSelect ( ResultVO param ) throws Exception;

	/* 세금계산서 권한 설정 페이지 - 권한 추가 */
	ResultVO ExAdminETaxAuthInsert ( ResultVO param ) throws Exception;
	
	/* 세금계산서 권한 설정 페이지 - 권한 삭제 */
	ResultVO ExAdminETaxAuthDelete ( ResultVO param ) throws Exception;
	
	/* 세금계산서 권한 설정 페이지 - 권한 수정 */
	ResultVO ExAdminETaxAuthUpdate ( ResultVO param ) throws Exception;
	
	/* 세금계산서 권한 설정 페이지 - 권한 공개범위 추가 */
	ResultVO ExAdminETaxAuthPublicInsert ( ResultVO param ) throws Exception;
	
	/* 세금계산서 권한 설정 페이지 - 권한 공개범위 조회 */
	ResultVO ExAdminETaxAuthPublicDelete ( ResultVO param ) throws Exception;
	
	/* 세금계산서 권한 설정 페이지 - 사업자등록번호 또는 이메일 중복체크 */
	ResultVO ExETaxAuthCodeDuplicationCheck ( ExCodeETaxAuthVO eTaxAuthVO ) throws Exception;
}

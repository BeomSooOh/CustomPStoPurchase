package expend.ex.admin.etax;

import common.vo.common.ResultVO;


public interface FExAdminETaxService {
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
	
	/* 세금계산서 권한 설정 페이지 - 권한 공개범위 삭제 */
	ResultVO ExAdminETaxAuthPublicDelete ( ResultVO param ) throws Exception;
}

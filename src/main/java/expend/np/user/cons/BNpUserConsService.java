package expend.np.user.cons;

import java.util.Map;

import common.vo.common.ResultVO;


public interface BNpUserConsService {

	/* 품의서 인터락 정보 생성 */
	ResultVO GetExDocMake ( Map<String, Object> params ) throws Exception;

	/* 품의 문서 생성 */
	ResultVO insertConsDoc ( Map<String, Object> params ) throws Exception;

	/* 품의서 생성 */
	ResultVO insertConsHead ( Map<String, Object> params ) throws Exception;

	/* 품의 예산 생성 */
	ResultVO insertConsBudget ( Map<String, Object> params ) throws Exception;

	/* 품의 거래처 생성 */
	ResultVO insertConsTrade ( Map<String, Object> params ) throws Exception;

	/* 품의 문서 변경 */
	ResultVO updateConsDoc ( Map<String, Object> params ) throws Exception;

	/* 품의 문서 전자결재 정보 변경 */
	ResultVO updateConsDocEaInfo ( Map<String, Object> params ) throws Exception;

	/* 품의서 정보 변경 */
	ResultVO updateConsHead ( Map<String, Object> params ) throws Exception;

	/* 품의예산 변경 */
	ResultVO updateConsBudget ( Map<String, Object> params ) throws Exception;

	/* 품의거래처 변경 */
	ResultVO updateConsTrade ( Map<String, Object> params ) throws Exception;

	/* 품의 문서 삭제 */
	ResultVO deleteConsDoc ( Map<String, Object> params ) throws Exception;

	/* 품의서 삭제 */
	ResultVO deleteConsHead ( Map<String, Object> params ) throws Exception;

	/* 품의예산 삭제 */
	ResultVO deleteConsBudget ( Map<String, Object> params ) throws Exception;

	/* 품의 거래처 삭제 */
	ResultVO deleteConsTrade ( Map<String, Object> params ) throws Exception;

	/* 품의 문서 조회 */
	ResultVO selectConsDoc ( Map<String, Object> params ) throws Exception;

	/* 품의서 조회 */
	ResultVO selectConsHead ( Map<String, Object> params ) throws Exception;

	/* 품의 예산 조회 */
	ResultVO selectConsBudget ( Map<String, Object> params ) throws Exception;

	/* 품의 거래처 조회 */
	ResultVO selectConsTrade ( Map<String, Object> params ) throws Exception;

	/* 품의서 예산잔액 조회 */
	ResultVO selectConsBudgetBalance ( Map<String, Object> params ) throws Exception;
	
	/* 권한 품의서 리스트 조회 */
	ResultVO selectRefferConsList ( Map<String, Object> params ) throws Exception;
	
	/* 권한 품의서 상세 정보 조회 */
	ResultVO selectConsDetailBudget ( Map<String, Object> params ) throws Exception;
	
	/* 전자결재 이전단계 품의서 품의정보 조회 */
	ResultVO selectConsApprovalBefore ( Map<String, Object> params ) throws Exception;

	/* 품의서 정보 전체 조회 */
	ResultVO selectConsAllInfo ( Map<String, Object> params ) throws Exception;
	
	/* 참조 품의서 예산 리스트 조회 */
	ResultVO selectConfferConsBudgetInfo ( Map<String, Object> params ) throws Exception;

	ResultVO updateFavoritesStatus(Map<String, Object> params) throws Exception;

	ResultVO selectFavoritesList(Map<String, Object> params)throws Exception;
	
	/* 즐겨찾기 품의서 가져오기 */
	ResultVO updateConsFavoriteInfo(Map<String, Object> params) throws Exception;

	/* 물품명세 품의서 삽입 */
	ResultVO insertConsItemSpec(Map<String, Object> params) throws Exception;

	/* 물품명세 품의서 조회 */
	ResultVO selectConsItemSpec(Map<String, Object> params) throws Exception;

	ResultVO selecTripConsDoc(Map<String, Object> consInfoParam) throws Exception;

	ResultVO selectConsInCustom(Map<String, Object> params) throws Exception; // TODO: 백상휘 수정.
}

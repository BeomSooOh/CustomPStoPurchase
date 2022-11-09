package expend.np.user.cons;

import java.util.Map;

import common.vo.common.ResultVO;


public interface FNpUserConsService {

	ResultVO GetExDocMake ( Map<String, Object> params ) throws Exception;

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
	
	/* 권한 품의서 리스트 조회 */
	ResultVO selectRefferConsList ( Map<String, Object> params ) throws Exception;
	
	/* 권한 품의서 상세 정보 조회 */
	ResultVO selectConsDetailBudget ( Map<String, Object> params ) throws Exception;
	
	/* 참조 품의서 예산 리스트 조회 */
	ResultVO selectConfferConsBudgetInfo ( Map<String, Object> params ) throws Exception;

	/* 품의서 즐겨찾기 추가/삭제 */
	ResultVO updateFavoritesStatus(Map<String, Object> params) throws Exception;

	ResultVO selectFavoritesList(Map<String, Object> params) throws Exception;

	ResultVO updateConsFavoriteInfo(Map<String, Object> params) throws Exception;

	/* 품의서 물품명세 추가 */
	ResultVO insertConsItemSpec(Map<String, Object> params) throws Exception;
	/* 품의서 물품명세 조회 */
	ResultVO selectConsItemSpec(Map<String, Object> params) throws Exception;

	ResultVO selectTripConsDoc(Map<String, Object> params) throws Exception;

	ResultVO selectGroupBudgetInfo(Map<String, Object> params) throws Exception;
	
	ResultVO selectConsInCustom(Map<String, Object> params) throws Exception; // TODO: 백상휘 수정.
}

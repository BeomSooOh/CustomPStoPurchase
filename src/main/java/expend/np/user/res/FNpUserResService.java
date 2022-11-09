package expend.np.user.res;

import java.util.Map;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


public interface FNpUserResService {

	/** 결의 문서 최초 생성 */
	ResultVO insertResDoc ( Map<String, Object> params ) throws Exception;

	/** 결의 문서 참조 결의 반영 */
	ResultVO updateResConfferInfo ( Map<String, Object> params ) throws Exception;

	/** 결의서 생성 */
	ResultVO insertResHead ( Map<String, Object> params ) throws Exception;

	/** 결의 예산 생성 */
	ResultVO insertResBudget ( Map<String, Object> params ) throws Exception;

	/** 결의 거래처 생성 */
	ResultVO insertResTrade ( Map<String, Object> params ) throws Exception;

	/** 결의 문서 변경 */
	ResultVO updateResDoc ( Map<String, Object> params ) throws Exception;

	/** 결의 문서 전자결재 정보 변경 */
	ResultVO updateResDocEaInfo ( Map<String, Object> params ) throws Exception;

	/** 결의서 정보 변경 */
	ResultVO updateResHead ( Map<String, Object> params ) throws Exception;

	/** 결의예산 변경 */
	ResultVO updateResBudget ( Map<String, Object> params ) throws Exception;

	/** 결의거래처 변경 */
	ResultVO updateResTrade ( Map<String, Object> params ) throws Exception;
	
	/** 임시저장 체크 */
	ResultVO CheckDraftInfo ( Map<String, Object> params ) throws Exception;
	
	/** 결의 문서 삭제 */
	ResultVO deleteResDoc ( Map<String, Object> params ) throws Exception;

	/** 결의서 삭제 */
	ResultVO deleteResHead ( Map<String, Object> params ) throws Exception;

	/** 결의예산 삭제 */
	ResultVO deleteResBudget ( Map<String, Object> params ) throws Exception;

	/** 결의 거래처 삭제 */
	ResultVO deleteResTrade ( Map<String, Object> params ) throws Exception;

	/** 결의 문서 조회 */
	ResultVO selectResDoc ( Map<String, Object> params ) throws Exception;

	/** 결의서 조회 */
	ResultVO selectResHead ( Map<String, Object> params ) throws Exception;

	/** 결의 예산 조회 */
	ResultVO selectResBudget ( Map<String, Object> params ) throws Exception;

	/** 결의 거래처 조회 */
	ResultVO selectResTrade ( Map<String, Object> params ) throws Exception;

	/** 카드사용내역 조회 */
	ResultVO selectCardDataList ( Map<String, Object> params ) throws Exception;

	/** 참조품의된 결의서 인지 확인 */
	ResultVO selectConfferBudgetInfo ( Map<String, Object> params ) throws Exception;
	
	/** 참조품의된 결의서 인지 확인 */
	ResultVO selectGroupBudgetInfo ( Map<String, Object> params ) throws Exception;
	
	/** 즐겨찾기 상태 업데이트 */
	ResultVO updateFavoritesStatus ( Map<String, Object> params ) throws Exception;

	/** 즐겨찾기 결의서 불러오기 */
	ResultVO selectFavoritesList ( Map<String, Object> param )throws Exception;

	/** 즐겨찾기 결의서 문서 복사 */
	ResultVO updateResFavoriteInfo(Map<String, Object> params)throws Exception;

	/* 결의서 물품명세 삽입 */
	ResultVO insertResItemSpec(Map<String, Object> params)throws Exception;
	/* 결의서 물품명세 조회 */
	ResultVO selectResItemSpec(Map<String, Object> params)throws Exception;

	ResultVO updateResConfferInfo2(ResultVO result, Map<String, Object> params, ConnectionVO conVo)throws Exception;
}

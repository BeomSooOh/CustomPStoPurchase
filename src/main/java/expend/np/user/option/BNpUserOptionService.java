package expend.np.user.option;

import java.util.Map;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


public interface BNpUserOptionService {

	ResultVO npTest ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;

	ResultVO selectERPOption ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;

	ResultVO selectGWOption ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;

	ResultVO selectERPBaseData ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;
	
	/**
	 * 	ERP 부가세 포함 통제 여부 확인
	 * 	return [ "Y" : 부가세 포함 통제 / "N" : 부가세 미포함 통제 ]
	 */
	String selectERPVatCtrData ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;

	ResultVO selectEaBaseData ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;

	ResultVO selectAbgtinfo ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;
	
	/**
	 *	품의/결의 기본 설정 정보조회
	 * */
	/** 1. 카드번호 표시방식 설정 조회 1 : 가운대 8자리 * 2 : 모두표기*/
	ResultVO selectBasicOptionCardPrint( Map<String, Object> params ) throws Exception;
	/** 2. 주민번호 표시방식 설정 조회 1 : 뒤에서 6자리 * 2 : 모두표기 */
	ResultVO selectBasicOptionJuminPrint( Map<String, Object> params ) throws Exception;
	/** 3. 예산체크 로직선택 1: 저장 중 문서 체크 2: 상신 문서 체크 */
	ResultVO selectBasicOptionBudgetCheck( Map<String, Object> params ) throws Exception;
	/** 4. 품의서 참조권한 1: 부서 2: 개인 */
	ResultVO selectBasicOptionConsAuth( Map<String, Object> params ) throws Exception;
	/** 5. ERP 전송방식 설정 1: 수동 2: 자동 */
	ResultVO selectBasicOptionSendType( Map<String, Object> params ) throws Exception;
	/** 6. ERP 전송방식 설정 0: 사용 1: 미사용 */
	ResultVO selectBasicOptionCreateTr( Map<String, Object> params, ConnectionVO conVo ) throws Exception;
}
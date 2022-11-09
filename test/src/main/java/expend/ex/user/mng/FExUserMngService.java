package expend.ex.user.mng;

import java.util.List;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExExpendMngVO;

public interface FExUserMngService {
	/* 공통코드 */
	/* 공통코드 - 지출결의 항목 분개 관리항목 목록 조회 */
	List<ExExpendMngVO> ExCodeMngListInfoSelect(ExExpendMngVO mngVo, ConnectionVO conVo) throws Exception;

	/* 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 */
	List<ExExpendMngVO> ExCodeMngDListInfoSelect(ExExpendMngVO mngVo, ConnectionVO conVo) throws Exception;
	
	/* 지출결의 - ERP관리항목 필수 입력 리스트 조회 */
	ResultVO ExExpendMngNecessaryOptionInfoSelect(ExExpendMngVO mngVo, ConnectionVO conVo) throws Exception;
	
	/* 공통코드 - iCUBE 사용자 정의 관리항목 연동 항목 조회 */
	List<ExExpendMngVO> ExCutomMngRealInfoSelect(ExExpendMngVO mngVo, ConnectionVO conVo) throws Exception;
}

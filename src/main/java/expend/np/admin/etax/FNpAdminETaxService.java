package expend.np.admin.etax;

//import java.util.Map;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;

public interface FNpAdminETaxService {
	/**
	 * 매입전자세금계산서 목록 조회
	 *
	 * @param param
	 * @param conVo
	 * @return
	 * @throws Exception
	 */
	ResultVO GetETaxList(ResultVO param, ConnectionVO conVo) throws Exception;

	/**
	 * 매입전자세금계산서 목록 조회 2차 구현
	 *
	 * @param param
	 * @param conVo
	 * @return
	 * @throws Exception
	 */
	ResultVO GetETaxList2(ResultVO param, ConnectionVO conVo) throws Exception;

	/**
	 * 매입전자세금계산서 상신 목록 조회
	 *
	 * @param param
	 * @return
	 * @throws Exception
	 */
	ResultVO GetETaxSendList(ResultVO param) throws Exception;

	/**
	 * 매입전자세금계산서 미사용 처리 목록 조회
	 *
	 * @param param
	 * @return
	 * @throws Exception
	 */
	ResultVO GetETaxNotUseList(ResultVO param) throws Exception;

	/**
	 * 매입전자세금계산서 상신 / 미사용 목록 통합 조회
	 *
	 * @param param
	 * @return
	 * @throws Exception
	 */
	ResultVO GetETaxFilterList(ResultVO param) throws Exception;

	/* 매입전자세금계산서 이관 내역 조회 */
	ResultVO GetETaxTransHistoryList(ResultVO param) throws Exception;
}

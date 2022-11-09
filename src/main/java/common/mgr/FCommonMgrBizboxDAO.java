package common.mgr;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import common.vo.common.ResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("FCommonMgrBizboxDAO")
public class FCommonMgrBizboxDAO extends EgovComAbstractDAO {
	/* 회사 목록 조회 */
	//public List<Map<String, Object>> CommonMgrCompListSelect(ResultVO param) throws Exception {
	public List<Map<String, Object>> CommonMgrCompListSelect() throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		result = (List<Map<String, Object>>) list("CommonMgrBizboxDAO.CommonMgrCompList");
		return result;
	}

	/* 표준적요 목록 조회 */
	public List<Map<String, Object>> CommonMgrSummaryListSelect(ResultVO param) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		result = (List<Map<String, Object>>) list("CommonMgrBizboxDAO.CommonMgrSummaryList", param.getParams());
		return result;
	}

	/* 표준적요 목록 삭제 */
	public void CommonMgrSummaryListDelete(ResultVO param) throws Exception {
		/*
		 * DELETE FROM T_EX_SUMMARY WHERE comp_seq = #compSeq#
		 */

		delete("CommonMgrBizboxDAO.CommonMgrSummaryListDelete", param.getParams());

	}

	/* 표준적요 등록 */
	public void CommonMgrSummaryInsert(Map<String, Object> param) throws Exception {
		insert("CommonMgrBizboxDAO.CommonMgrSummaryInsert", param);
	}
}

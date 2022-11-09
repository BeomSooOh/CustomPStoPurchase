package common.mgr;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.vo.common.ResultVO;

@Service("BCommonMgrService")
public class BCommonMgrServiceImpl implements BCommonMgrService {

	@Resource(name = "FCommonMgrBizboxDAO")
	private FCommonMgrBizboxDAO dao;

	/* 회사 목록 조회 */
	public ResultVO CommonMgrCompListSelect(ResultVO param) throws Exception {
		//param.setAaData(dao.CommonMgrCompListSelect(param));
		param.setAaData(dao.CommonMgrCompListSelect());
		return param;
	}

	/* 표준적요 목록 조회 */
	public ResultVO CommonMgrSummaryListSelect(ResultVO param) throws Exception {
		param.setAaData(dao.CommonMgrSummaryListSelect(param));
		return param;
	}

	/* 표준적요 목록 삭제 */
	public ResultVO CommonMgrSummaryListDelete(ResultVO param) throws Exception {
		dao.CommonMgrSummaryListDelete(param);
		return param;
	}

	/* 표준적요 등록 */
	public ResultVO CommonMgrSummaryInsert(ResultVO param) throws Exception {
		List<Map<String, Object>> paramList = new ArrayList<Map<String, Object>>();
		paramList = CommonConvert.CommonGetJSONToListMap(CommonConvert.CommonGetStr(param.getParams().get("list")));

		for (Map<String, Object> map : paramList) {
			dao.CommonMgrSummaryInsert(map);
		}

		return param;
	}

}

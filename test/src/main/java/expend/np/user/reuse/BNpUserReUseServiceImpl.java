package expend.np.user.reuse;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

//import common.helper.convert.CommonConvert;
import common.vo.common.ResultVO;

@Service("BNpUserReUseService")
public class BNpUserReUseServiceImpl implements BNpUserReUseService {

	// Impl
	@Resource(name = "FNpUserReUseServiceA")
	private FNpUserReUseServiceAImpl service;

	/* ## 품의서 ## */
	/* ## ################################################## ## */
	// SELECT
	public ResultVO ConsReUseSelect(ResultVO p) throws Exception {
		// 품의서 정보 조회
		// parameters : consDocSeq
		// Map
		Map<String, Object> aData = new HashMap<String, Object>();
		Map<String, Object> consDoc = new HashMap<String, Object>();
		// List
		List<Map<String, Object>> consHead = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> consBudget = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> consTrade = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> consItem = new ArrayList<Map<String, Object>>();

		try {
			consDoc = service.ConsDocSelect(p).getaData();
			consHead = service.ConsHeadSelectList(p).getAaData();
			consBudget = service.ConsBudgetSelectList(p).getAaData();
			consTrade = service.ConsTradeSelectList(p).getAaData();
			consItem = service.ConsItemSpecSelectList(p).getAaData();

			aData.put("consDoc", consDoc);
			aData.put("consHead", consHead);
			aData.put("consBudget", consBudget);
			aData.put("consTrade", consTrade);
			aData.put("consItem", consItem);
			p.setaData(aData);

			p.setSuccess();
		}
		catch (Exception e) {
			p.setFail(e.toString());
		}

		return p;
	}

	public ResultVO ConsReUseGisuSelect(ResultVO p) throws Exception {
		// 품의서 기수 정보 조회
		// parameters : consDocSeq || resDocSeq
		return service.ConsGisuSelect(p);
	}

	// 재기안 품의서 양식 정보 조회
	public ResultVO ConsReUseFormInfoSelect(ResultVO p) throws Exception{
		// 품의서 양식 정보 조회
		// parameters : oriApproKey, oriDocId, form_gb, copyApprovalLine, copyAttachFile, eaType
		return service.ConsReUseFormInfoSelect(p);
	}

	// SELECT LIST

	// INSERT

	// UPDATE

	// DELETE

	/* ## 결의서 ## */
	/* ## ################################################## ## */
	// SELECT
	public ResultVO ResReUseSelect(ResultVO p) throws Exception {
		// 결의서 정보 조회
		// parameters : resDocSeq
		// Map
		Map<String, Object> aData = new HashMap<String, Object>();
		Map<String, Object> resDoc = new HashMap<String, Object>();
		// List
		List<Map<String, Object>> resHead = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> resBudget = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> resTrade = new ArrayList<Map<String, Object>>();

		try {
			resDoc = service.ResDocSelect(p).getaData();
			resHead = service.ResHeadSelectList(p).getAaData();
			resBudget = service.ResBudgetSelectList(p).getAaData();
			resTrade = service.ResTradeSelectList(p).getAaData();

			aData.put("resDoc", resDoc);
			aData.put("resHead", resHead);
			aData.put("resBudget", resBudget);
			aData.put("resTrade", resTrade);
			p.setaData(aData);

			p.setSuccess();
		}
		catch (Exception e) {
			p.setFail(e.toString());
		}

		return p;
	}

	public ResultVO ResReUseGisuSelect(ResultVO p) throws Exception {
		// 결의서 기수 정보 조회
		// parameters : resDocSeq
		return service.ResGisuSelect(p);
	}

	// SELECT LIST

	// INSERT

	// UPDATE

	// DELETE
}

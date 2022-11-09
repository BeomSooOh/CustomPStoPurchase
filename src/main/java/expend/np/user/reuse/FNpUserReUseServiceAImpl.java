package expend.np.user.reuse;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.vo.common.ResultVO;

@Service("FNpUserReUseServiceA")
public class FNpUserReUseServiceAImpl implements FNpUserReUseService {

	// DAO
	@Resource(name = "FNpUserReUseServiceADAO")
	private FNpUserReUseServiceADAO dao;

	/* ## 품의서 ## */
	/* ## ################################################## ## */

	// SELECT
	@SuppressWarnings("unchecked")
	public ResultVO ConsDocSelect(ResultVO p) throws Exception {
		// 품의서 정보 조회
		// Map
		Map<String, Object> mQueryParam = _ConsParamMake(p);

		// String
		String checkLoginInfo = "";

		// Check
		checkLoginInfo = _CheckLoginInfo(mQueryParam);
		if (!checkLoginInfo.equals("")) {
			p.setFail("not exists " + checkLoginInfo);
			p.setaData(new HashMap<String, Object>());
		}
		else if (_CheckConsDocSeq(mQueryParam)) {
			// ERROR
			p.setFail("not exists consDocSeq");
			p.setaData(new HashMap<String, Object>());
		}
		else {
			// Select
			p.setaData((Map<String, Object>) dao.ConsDocSelect(mQueryParam));
			p.setSuccess();
		}

		// Return
		return p;
	}

	@SuppressWarnings("unchecked")
	public ResultVO ConsGisuSelect(ResultVO p) throws Exception {
		// 품의서 기수 정보 조회
		// Map
		Map<String, Object> mQueryParam = _ConsParamMake(p);

		// String
		String checkLoginInfo = "";

		// Check
		checkLoginInfo = _CheckLoginInfo(mQueryParam);
		if (!checkLoginInfo.equals("")) {
			p.setFail("not exists " + checkLoginInfo);
			p.setaData(new HashMap<String, Object>());
		}
		else if (_CheckConsDocSeq(mQueryParam)) {
			// ERROR
			p.setFail("not exists consDocSeq");
			p.setaData(new HashMap<String, Object>());
		}
		else {
			// Select
			p.setaData((Map<String, Object>) dao.ConsGisuSelect(mQueryParam));
			p.setSuccess();
		}

		// Return
		return p;
	}

	public ResultVO ConsReUseFormInfoSelect(ResultVO p) throws Exception {
		// 재기안 품의서 양식 정보 조회
		// Map
		Map<String, Object> mQueryParam = _ConsParamMake(p);

		// String
		String checkLoginInfo = "";
		checkLoginInfo = _CheckLoginInfo(mQueryParam);
		if (!checkLoginInfo.equals("")) {
			p.setFail("not exists " + checkLoginInfo);
			p.setaData(new HashMap<String, Object>());
		}
		else if (_CheckConsDocSeq(mQueryParam)) {
			// ERROR
			p.setFail("not exists consDocSeq");
			p.setaData(new HashMap<String, Object>());
		}
		else {
			// Select
			p.setaData((Map<String, Object>) dao.ConsReUseFormInfoSelect(mQueryParam));
			p.setSuccess();
		}

		return p;
	}

	// SELECT LIST
	@SuppressWarnings("unchecked")
	public ResultVO ConsHeadSelectList(ResultVO p) throws Exception {
		// 품의서 헤더 정보 조회
		// Map
		Map<String, Object> mQueryParam = _ConsParamMake(p);

		// String
		String checkLoginInfo = "";

		// Check
		checkLoginInfo = _CheckLoginInfo(mQueryParam);
		if (!checkLoginInfo.equals("")) {
			p.setFail("not exists " + checkLoginInfo);
			p.setAaData(new ArrayList<Map<String, Object>>());
		}
		else if (_CheckConsDocSeq(mQueryParam)) {
			// ERROR
			p.setFail("not exists consDocSeq");
			p.setAaData(new ArrayList<Map<String, Object>>());
		}
		else {
			// Select List
			p.setAaData((List<Map<String, Object>>) dao.ConsHeadSelectList(mQueryParam));
			p.setSuccess();
		}

		// Return
		return p;
	}

	@SuppressWarnings("unchecked")
	public ResultVO ConsBudgetSelectList(ResultVO p) throws Exception {
		// 품의서 예산 정보 조회
		// Map
		Map<String, Object> mQueryParam = _ConsParamMake(p);

		// String
		String checkLoginInfo = "";

		// Check
		checkLoginInfo = _CheckLoginInfo(mQueryParam);
		if (!checkLoginInfo.equals("")) {
			p.setFail("not exists " + checkLoginInfo);
			p.setAaData(new ArrayList<Map<String, Object>>());
		}
		else if (_CheckConsDocSeq(mQueryParam)) {
			// ERROR
			p.setFail("not exists consDocSeq");
			p.setAaData(new ArrayList<Map<String, Object>>());
		}
		else {
			// Select List
			p.setAaData((List<Map<String, Object>>) dao.ConsBudgetSelectList(mQueryParam));
			p.setSuccess();
		}

		// Return
		return p;
	}

	@SuppressWarnings("unchecked")
	public ResultVO ConsTradeSelectList(ResultVO p) throws Exception {
		// 품의서 채주 정보 조회
		// Map
		Map<String, Object> mQueryParam = _ConsParamMake(p);

		// String
		String checkLoginInfo = "";

		// Check
		checkLoginInfo = _CheckLoginInfo(mQueryParam);
		if (!checkLoginInfo.equals("")) {
			p.setFail("not exists " + checkLoginInfo);
			p.setAaData(new ArrayList<Map<String, Object>>());
		}
		else if (_CheckConsDocSeq(mQueryParam)) {
			// ERROR
			p.setFail("not exists consDocSeq");
			p.setAaData(new ArrayList<Map<String, Object>>());
		}
		else {
			// Select List
			p.setAaData((List<Map<String, Object>>) dao.ConsTradeSelectList(mQueryParam));
			p.setSuccess();
		}

		// Return
		return p;
	}

	// INSERT

	// UPDATE

	// DELETE

	/* ## 결의서 ## */
	/* ## ################################################## ## */

	// SELECT
	@SuppressWarnings("unchecked")
	public ResultVO ResDocSelect(ResultVO p) throws Exception {
		// 결의서 정보 조회
		// Map
		Map<String, Object> mQueryParam = _ResParamMake(p);

		// String
		String checkLoginInfo = "";

		// Check
		checkLoginInfo = _CheckLoginInfo(mQueryParam);
		if (!checkLoginInfo.equals("")) {
			p.setFail("not exists " + checkLoginInfo);
			p.setaData(new HashMap<String, Object>());
		}
		else if (_CheckResDocSeq(mQueryParam)) {
			// ERROR
			p.setFail("not exists resDocSeq");
			p.setaData(new HashMap<String, Object>());
		}
		else {
			// Select
			p.setaData((Map<String, Object>) dao.ResDocSelect(mQueryParam));
			p.setSuccess();
		}

		// Return
		return p;
	}

	@SuppressWarnings("unchecked")
	public ResultVO ResGisuSelect(ResultVO p) throws Exception {
		// 품의서 기수 정보 조회
		// Map
		Map<String, Object> mQueryParam = _ResParamMake(p);

		// String
		String checkLoginInfo = "";

		// Check
		checkLoginInfo = _CheckLoginInfo(mQueryParam);
		if (!checkLoginInfo.equals("")) {
			p.setFail("not exists " + checkLoginInfo);
			p.setaData(new HashMap<String, Object>());
		}
		else if (_CheckResDocSeq(mQueryParam)) {
			// ERROR
			p.setFail("not exists resDocSeq");
			p.setaData(new HashMap<String, Object>());
		}
		else {
			// Select
			p.setaData((Map<String, Object>) dao.ResGisuSelect(mQueryParam));
			p.setSuccess();
		}

		// Return
		return p;
	}

	// SELECT LIST
	@SuppressWarnings("unchecked")
	public ResultVO ResHeadSelectList(ResultVO p) throws Exception {
		// 결의서 헤더 정보 조회
		// Map
		Map<String, Object> mQueryParam = _ResParamMake(p);

		// String
		String checkLoginInfo = "";

		// Check
		checkLoginInfo = _CheckLoginInfo(mQueryParam);
		if (!checkLoginInfo.equals("")) {
			p.setFail("not exists " + checkLoginInfo);
			p.setAaData(new ArrayList<Map<String, Object>>());
		}
		else if (_CheckResDocSeq(mQueryParam)) {
			// ERROR
			p.setFail("not exists resDocSeq");
			p.setAaData(new ArrayList<Map<String, Object>>());
		}
		else {
			// Select List
			p.setAaData((List<Map<String, Object>>) dao.ResHeadSelectList(mQueryParam));
			p.setSuccess();
		}

		// Return
		return p;
	}

	@SuppressWarnings("unchecked")
	public ResultVO ResBudgetSelectList(ResultVO p) throws Exception {
		// 결의서 예산 정보 조회
		// Map
		Map<String, Object> mQueryParam = _ResParamMake(p);

		// String
		String checkLoginInfo = "";

		// Check
		checkLoginInfo = _CheckLoginInfo(mQueryParam);
		if (!checkLoginInfo.equals("")) {
			p.setFail("not exists " + checkLoginInfo);
			p.setAaData(new ArrayList<Map<String, Object>>());
		}
		else if (_CheckResDocSeq(mQueryParam)) {
			// ERROR
			p.setFail("not exists resDocSeq");
			p.setAaData(new ArrayList<Map<String, Object>>());
		}
		else {
			// Select List
			p.setAaData((List<Map<String, Object>>) dao.ResBudgetSelectList(mQueryParam));
			p.setSuccess();
		}

		// Return
		return p;
	}

	@SuppressWarnings("unchecked")
	public ResultVO ResTradeSelectList(ResultVO p) throws Exception {
		// 결의서 채주 정보 조회
		// Map
		Map<String, Object> mQueryParam = _ResParamMake(p);

		// String
		String checkLoginInfo = "";

		// Check
		checkLoginInfo = _CheckLoginInfo(mQueryParam);
		if (!checkLoginInfo.equals("")) {
			p.setFail("not exists " + checkLoginInfo);
			p.setAaData(new ArrayList<Map<String, Object>>());
		}
		else if (_CheckResDocSeq(mQueryParam)) {
			// ERROR
			p.setFail("not exists resDocSeq");
			p.setAaData(new ArrayList<Map<String, Object>>());
		}
		else {
			// Select List
			p.setAaData((List<Map<String, Object>>) dao.ResTradeSelectList(mQueryParam));
			p.setSuccess();
		}

		// Return
		return p;
	}


	public ResultVO ResItemSpecSelectList(ResultVO p) throws Exception {
		// 결의서 채주 정보 조회
		// Map
		Map<String, Object> mQueryParam = _ResParamMake(p);

		// String
		String checkLoginInfo = "";

		// Check
		checkLoginInfo = _CheckLoginInfo(mQueryParam);
		if (!checkLoginInfo.equals("")) {
			p.setFail("not exists " + checkLoginInfo);
			p.setAaData(new ArrayList<Map<String, Object>>());
		}
		else if (_CheckResDocSeq(mQueryParam)) {
			// ERROR
			p.setFail("not exists resDocSeq");
			p.setAaData(new ArrayList<Map<String, Object>>());
		}
		else {
			// Select List
			p.setAaData((List<Map<String, Object>>) dao.ResItemSpecSelectList(mQueryParam));
			p.setSuccess();
		}

		// Return
		return p;
	}

	// INSERT

	// UPDATE

	// DELETE

	/* ## 카드 ## */
	/* ## ################################################## ## */
	// SELECT
	@SuppressWarnings("unchecked")
	public ResultVO CardTmpSelect(ResultVO p) throws Exception {
		// 카드 상신 여부 판단을 위한 카드 정보 조회
		// Map
		Map<String, Object> mQueryParam = _SyncParamMake(p);

		// String
		String checkLoginInfo = "";

		// Check
		checkLoginInfo = _CheckLoginInfo(mQueryParam);
		if (!checkLoginInfo.equals("")) {
			p.setFail("not exists " + checkLoginInfo);
			p.setaData(new HashMap<String, Object>());
		}
		else if (_CheckSyncId(mQueryParam)) {
			// ERROR
			p.setFail("not exists syncId");
			p.setaData(new HashMap<String, Object>());
		}
		else {
			// Select
			p.setaData((Map<String, Object>) dao.CardTmpSelect(mQueryParam));
			p.setSuccess();
		}

		// Return
		return p;
	}
	// SELECT LIST
	// INSERT
	// UPDATE
	// DELETE

	/* ## 계산서 ## */
	/* ## ################################################## ## */
	// SELECT
	@SuppressWarnings("unchecked")
	public ResultVO ETaxTmpSelect(ResultVO p) throws Exception {
		// 매입전자세금계산서 상신 여부 판단을 위한 계산서 정보 조회
		// Map
		Map<String, Object> mQueryParam = _SyncParamMake(p);

		// String
		String checkLoginInfo = "";

		// Check
		checkLoginInfo = _CheckLoginInfo(mQueryParam);
		if (!checkLoginInfo.equals("")) {
			p.setFail("not exists " + checkLoginInfo);
			p.setaData(new HashMap<String, Object>());
		}
		else if (_CheckSyncId(mQueryParam)) {
			// ERROR
			p.setFail("not exists syncId");
			p.setaData(new HashMap<String, Object>());
		}
		else {
			// Select
			p.setaData((Map<String, Object>) dao.ETaxTmpSelect(mQueryParam));
			p.setSuccess();
		}

		// Return
		return p;
	}
	// SELECT LIST
	// INSERT
	// UPDATE
	// DELETE

	/* ## 공통 ## */
	/* ## ################################################## ## */
	private Map<String, Object> _ConsParamMake(ResultVO p) throws Exception {
		// Map
		Map<String, Object> r = new HashMap<String, Object>();

		// Define
		if (p.getParams() != null) {
			if (p.getParams().keySet().size() > 0) {
				r = CommonConvert.CommonSetMapCopyNotKey(p.getParams());
				r = CommonConvert.CommonSetMapCopy(r, CommonConvert.CommonGetEmpInfo());
			}
		}
		
		if (r.keySet().size() < 1) {
			r = CommonConvert.CommonSetMapCopyNotKey(CommonConvert.CommonGetEmpInfo());
		}
		r.put("consDocSeq", p.getParams().get("consDocSeq"));

		// Return
		return r;
	}

	private Map<String, Object> _ResParamMake(ResultVO p) throws Exception {
		// Map
		Map<String, Object> r = new HashMap<String, Object>();

		// Define
		r = CommonConvert.CommonSetMapCopyNotKey(CommonConvert.CommonGetEmpInfo());
		r.put("resDocSeq", p.getParams().get("resDocSeq"));

		// Return
		return r;
	}

	private Map<String, Object> _SyncParamMake(ResultVO p) throws Exception {
		// Map
		Map<String, Object> r = new HashMap<String, Object>();

		// Define		
		r = CommonConvert.CommonSetMapCopyNotKey(CommonConvert.CommonGetEmpInfo());
		r.put("syncId", p.getParams().get("syncId"));

		// Return
		return r;
	}

	private String _CheckLoginInfo(Map<String, Object> p) {
		// 로그인 사용자 기본정보 점검
		if ((CommonConvert.CommonGetStr(p.get("groupSeq"))).equals("")) {
			// ERROR
			return "groupSeq";
		}
		else if ((CommonConvert.CommonGetStr(p.get("compSeq"))).equals("")) {
			// ERROR
			return "compSeq";
		}
		else if ((CommonConvert.CommonGetStr(p.get("empSeq"))).equals("")) {
			// ERROR
			return "empSeq";
		}
		else if ((CommonConvert.CommonGetStr(p.get("consDocSeq"))).equals("") && (CommonConvert.CommonGetStr(p.get("resDocSeq"))).equals("")) {
			// ERROR
			return "consDocSeq";
		}
		else {
			// SUCCESS
			return "";
		}
	}

	private boolean _CheckSyncId(Map<String, Object> p) {
		// 연동 시퀀스 점검
		if ((CommonConvert.CommonGetStr(p.get("syncId"))).equals("")) {
			return true;
		}
		else {
			return false;
		}
	}

	private boolean _CheckConsDocSeq(Map<String, Object> p) {
		// 품의서 시퀀스 점검
		if (!(CommonConvert.CommonGetStr(p.get("consDocSeq"))).equals("") && !(CommonConvert.CommonGetStr(p.get("resDocSeq"))).equals("")) {
			return true;
		}
		else {
			return false;
		}
	}

	private boolean _CheckResDocSeq(Map<String, Object> p) {
		// 결의서 시퀀스 점검
		if ((CommonConvert.CommonGetStr(p.get("resDocSeq"))).equals("")) {
			return true;
		}
		else {
			return false;
		}
	}

	public ResultVO ConsItemSpecSelectList(ResultVO p) throws Exception {
		// 품의서 헤더 정보 조회
				// Map
				Map<String, Object> mQueryParam = _ConsParamMake(p);

				// String
				String checkLoginInfo = "";

				// Check
				checkLoginInfo = _CheckLoginInfo(mQueryParam);
				if (!checkLoginInfo.equals("")) {
					p.setFail("not exists " + checkLoginInfo);
					p.setAaData(new ArrayList<Map<String, Object>>());
				}
				else if (_CheckConsDocSeq(mQueryParam)) {
					// ERROR
					p.setFail("not exists consDocSeq");
					p.setAaData(new ArrayList<Map<String, Object>>());
				}
				else {
					// Select List
					p.setAaData((List<Map<String, Object>>) dao.ConsItemSpecSelectList(mQueryParam));
					p.setSuccess();
				}
				// Return
				return p;
	}

}

package expend.np.admin.etax;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;

@Service("FNpAdminETaxServiceA")
public class FNpAdminETaxServiceAImpl implements FNpAdminETaxService {

	@Resource(name = "FNpAdminETaxServiceADAO")
	private FNpAdminETaxServiceADAO dao;

	/* 매입전자세금계산서 목록 조회 */
	@Override
	public ResultVO GetETaxList(ResultVO param, ConnectionVO conVo) throws Exception {
		param.setFail("ERP 연동 전용 기능입니다.");
		return param;
	}

	/* 매입전자세금계산서 상신 목록 조회 */
	public ResultVO GetETaxSendList(ResultVO param) throws Exception {
		/* Map */
		Map<String, Object> map = new HashMap<String, Object>();

		map = (param.getParams() == null ? new HashMap<String, Object>() : param.getParams());
		map.put(commonCode.GROUPSEQ, param.getGroupSeq());
		map.put(commonCode.COMPSEQ, param.getCompSeq());
		map.put(commonCode.DEPTSEQ, param.getDeptSeq());
		map.put(commonCode.EMPSEQ, param.getEmpSeq());
		map.put(commonCode.EMPNAME, param.getEmpName());

		try {
			/* 필수 파라미터 점검 ( issDateFrom, issDateTo, compSeq ) */
			if (!map.containsKey("issDateFrom") || CommonConvert.CommonGetStr(map.get("issDateFrom")).equals("")) {
				param.setFail("parameter issDateFrom is not exists..");
				return param;
			}
			else if (!map.containsKey("issDateTo") || CommonConvert.CommonGetStr(map.get("issDateTo")).equals("")) {
				param.setFail("parameter issDateTo is not exists..");
				return param;
			}
			else if (!map.containsKey("compSeq") || CommonConvert.CommonGetStr(map.get("compSeq")).equals("")) {
				param.setFail("parameter compSeq is not exists..");
				return param;
			}
			else {
				param.setAaData(dao.GetETaxSendList(map));
				param.setSuccess();
			}
		}
		catch (Exception e) {
			param.setFail("FNpAdminETaxServiceAImpl.GetETaxSendList >> " + e.toString());
		}

		return param;
	}

	/* 매입전자세금계산서 미사용 처리 목록 조회 */
	public ResultVO GetETaxNotUseList(ResultVO param) throws Exception {
		/* Map */
		Map<String, Object> map = new HashMap<String, Object>();

		map = (param.getParams() == null ? new HashMap<String, Object>() : param.getParams());
		map.put(commonCode.GROUPSEQ, param.getGroupSeq());
		map.put(commonCode.COMPSEQ, param.getCompSeq());
		map.put(commonCode.DEPTSEQ, param.getDeptSeq());
		map.put(commonCode.EMPSEQ, param.getEmpSeq());
		map.put(commonCode.EMPNAME, param.getEmpName());

		try {
			/* 필수 파라미터 점검 ( issDateFrom, issDateTo, compSeq ) */
			if (!map.containsKey("issDateFrom") || CommonConvert.CommonGetStr(map.get("issDateFrom")).equals("")) {
				param.setFail("parameter issDateFrom is not exists..");
				return param;
			}
			else if (!map.containsKey("issDateTo") || CommonConvert.CommonGetStr(map.get("issDateTo")).equals("")) {
				param.setFail("parameter issDateTo is not exists..");
				return param;
			}
			else if (!map.containsKey("compSeq") || CommonConvert.CommonGetStr(map.get("compSeq")).equals("")) {
				param.setFail("parameter compSeq is not exists..");
				return param;
			}
			else {
				param.setAaData(dao.GetETaxNotUseList(map));
				param.setSuccess();
			}
		}
		catch (Exception e) {
			param.setFail("FNpAdminETaxServiceAImpl.GetETaxNotUseList >> " + e.toString());
		}

		return param;
	}

	/* 매입전자세금계산서 미사용 / 상신 목록 조회 */
	@Override
	public ResultVO GetETaxFilterList(ResultVO param) throws Exception {
		ResultVO result = new ResultVO( );
		try{
			Map<String, Object> map = new HashMap<String, Object>();

			map = (param.getParams() == null ? new HashMap<String, Object>() : param.getParams());
			map.put(commonCode.GROUPSEQ, param.getGroupSeq());
			map.put(commonCode.COMPSEQ, param.getCompSeq());
			map.put(commonCode.DEPTSEQ, param.getDeptSeq());
			map.put(commonCode.EMPSEQ, param.getEmpSeq());
			map.put(commonCode.EMPNAME, param.getEmpName());

			result.setAaData( dao.GetETaxFilterList( map ) );
			result.setSuccess( );
		}catch(Exception ex){
			result.setFail( "매입세금계산서 필터 리스트 조회 실패", ex );
		}
		return result;
	}

	@Override
	public ResultVO GetETaxList2 ( ResultVO param, ConnectionVO conVo ) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	/* 매입전자세금계산서 이관 내역 조회 */
	public ResultVO GetETaxTransHistoryList(ResultVO param) throws Exception {
		/* MAP */
		Map<String, Object> map = GetMapBase(param);

		try {
			/* 필수 파라미터 점검 ( groupSeq, compSeq, deptSeq, empSeq ) */
			if (!map.containsKey("groupSeq") || CommonConvert.CommonGetStr(map.get("groupSeq")).equals("")) {
				param.setFail("parameter groupSeq is not exists..");
				return param;
			}
			else if (!map.containsKey("compSeq") || CommonConvert.CommonGetStr(map.get("compSeq")).equals("")) {
				param.setFail("parameter compSeq is not exists..");
				return param;
			}
			else if (!map.containsKey("deptSeq") || CommonConvert.CommonGetStr(map.get("deptSeq")).equals("")) {
				param.setFail("parameter deptSeq is not exists..");
				return param;
			}
			else if (!map.containsKey("empSeq") || CommonConvert.CommonGetStr(map.get("empSeq")).equals("")) {
				param.setFail("parameter empSeq is not exists..");
				return param;
			} else {
				param = dao.GetETaxTransHistoryList(map);
				param.setSuccess();
			}
		}
		catch (Exception e) {
			param.setFail("FNpUserETaxServiceAImpl.GetETaxTransHistoryList >> " + e.toString());
		}

		return param;
	}

	private Map<String, Object> GetMapBase(ResultVO param) {
		Map<String, Object> map = new HashMap<String, Object>();
		map = (param.getParams() == null ? new HashMap<String, Object>() : param.getParams());
		map.put("groupSeq", CommonConvert.CommonGetStr(param.getGroupSeq()));
		map.put("compSeq", CommonConvert.CommonGetStr(param.getCompSeq()));
		map.put("deptSeq", CommonConvert.CommonGetStr(param.getDeptSeq()));
		map.put("empSeq", CommonConvert.CommonGetStr(param.getEmpSeq()));
		map.put("empName", CommonConvert.CommonGetStr(param.getEmpName()));

		return map;
	}
}

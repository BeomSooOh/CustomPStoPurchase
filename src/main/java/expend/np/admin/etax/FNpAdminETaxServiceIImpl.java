package expend.np.admin.etax;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;

@Service("FNpAdminETaxServiceI")
public class FNpAdminETaxServiceIImpl implements FNpAdminETaxService {

	@Resource(name = "FNpAdminETaxServiceIDAO")
	private FNpAdminETaxServiceIDAO dao;


	/* 매입전자 세금 계산서 2차 구현 */
	@Override
	public ResultVO GetETaxList2 ( ResultVO param, ConnectionVO conVo ) throws Exception {
		
		/* 파라미터 검증 진행 */
		Map<String, Object> map = new HashMap<String, Object>();
		map = (param.getParams() == null ? new HashMap<String, Object>() : param.getParams());
		map.put("groupSeq", CommonConvert.CommonGetStr(param.getGroupSeq()));
		map.put("compSeq", CommonConvert.CommonGetStr(param.getCompSeq()));
		map.put("deptSeq", CommonConvert.CommonGetStr(param.getDeptSeq()));
		map.put("empSeq", CommonConvert.CommonGetStr(param.getEmpSeq()));
		map.put("id", CommonConvert.CommonGetStr(param.getId()));
		map.put("erpCompSeq", CommonConvert.CommonGetStr(param.getErpCompSeq()));
		map.put("erpEmpSeq", CommonConvert.CommonGetStr(param.getErpEmpSeq()));
		
		try {
			/* 필수 파라미터 점검 ( {"issDateFrom":"20180508","issDateTo":"20180608","partnerName":"","eTaxStat":"","partnerRegNo":"","eTaxIssNo":"","approvalEmpName":""} ) */
			if (!map.containsKey("issDateFrom") || CommonConvert.CommonGetStr(map.get("issDateFrom")).equals("")) {
				param.setFail("parameter issDateFrom is not exists..");
				return param;
			}
			else if (!map.containsKey("issDateTo") || CommonConvert.CommonGetStr(map.get("issDateTo")).equals("")) {
				param.setFail("parameter issDateTo is not exists..");
				return param;
			}
			else if (!map.containsKey("id") || CommonConvert.CommonGetStr(map.get("id")).equals("")) {
				param.setFail("parameter id is not exists..");
				return param;
			}
			else if (!map.containsKey("partnerName")) {
				param.setFail("parameter partnerName is not exists..");
				return param;
			}
			else if (!map.containsKey("eTaxStat")) {
				param.setFail("parameter eTaxStat is not exists..");
				return param;
			}
			else if (!map.containsKey("partnerRegNo")) {
				param.setFail("parameter partnerRegNo is not exists..");
				return param;
			}
			else if (!map.containsKey("eTaxIssNo")) {
				param.setFail("parameter eTaxIssNo is not exists..");
				return param;
			}
			else if (!map.containsKey("approvalEmpName")) {
				param.setFail("parameter approvalEmpName is not exists..");
				return param;
			}
			else {
				param.setAaData(dao.GetETaxList2(map, conVo));
				param.setSuccess();
			}
		}
		catch (Exception e) {
			param.setFail("FNpAdminETaxServiceIImpl.GetETaxList >> " + e.toString());
		}
		return param;
	}
	
	/* 매입전자세금계산서 목록 조회 */
	public ResultVO GetETaxList(ResultVO param, ConnectionVO conVo) throws Exception {
		/* MAP */
		Map<String, Object> map = new HashMap<String, Object>();

		map = (param.getParams() == null ? new HashMap<String, Object>() : param.getParams());
		map.put("groupSeq", CommonConvert.CommonGetStr(param.getGroupSeq()));
		map.put("compSeq", CommonConvert.CommonGetStr(param.getCompSeq()));
		map.put("deptSeq", CommonConvert.CommonGetStr(param.getDeptSeq()));
		map.put("empSeq", CommonConvert.CommonGetStr(param.getEmpSeq()));
		map.put("id", CommonConvert.CommonGetStr(param.getId()));
		map.put("erpCompSeq", CommonConvert.CommonGetStr(param.getErpCompSeq()));
		map.put("erpEmpSeq", CommonConvert.CommonGetStr(param.getErpEmpSeq()));

		try {
			/* 필수 파라미터 점검 ( {"issDateFrom":"20180508","issDateTo":"20180608","partnerName":"","eTaxStat":"","partnerRegNo":"","eTaxIssNo":"","approvalEmpName":""} ) */
			if (!map.containsKey("issDateFrom") || CommonConvert.CommonGetStr(map.get("issDateFrom")).equals("")) {
				param.setFail("parameter issDateFrom is not exists..");
				return param;
			}
			else if (!map.containsKey("issDateTo") || CommonConvert.CommonGetStr(map.get("issDateTo")).equals("")) {
				param.setFail("parameter issDateTo is not exists..");
				return param;
			}
			else if (!map.containsKey("id") || CommonConvert.CommonGetStr(map.get("id")).equals("")) {
				param.setFail("parameter id is not exists..");
				return param;
			}
			else if (!map.containsKey("partnerName")) {
				param.setFail("parameter partnerName is not exists..");
				return param;
			}
			else if (!map.containsKey("eTaxStat")) {
				param.setFail("parameter eTaxStat is not exists..");
				return param;
			}
			else if (!map.containsKey("partnerRegNo")) {
				param.setFail("parameter partnerRegNo is not exists..");
				return param;
			}
			else if (!map.containsKey("eTaxIssNo")) {
				param.setFail("parameter eTaxIssNo is not exists..");
				return param;
			}
			else if (!map.containsKey("approvalEmpName")) {
				param.setFail("parameter approvalEmpName is not exists..");
				return param;
			}
			else if (!map.containsKey("eTaxSendList")) {
				param.setFail("parameter eTaxSendList is not exists..");
				return param;
			}
			else if (!map.containsKey("eTaxNotUseList")) {
				param.setFail("parameter eTaxNotUseList is not exists..");
				return param;
			}
			else {
				param.setAaData(dao.GetETaxList(map, conVo));
				param.setSuccess();
			}
		}
		catch (Exception e) {
			param.setFail("FNpAdminETaxServiceIImpl.GetETaxList >> " + e.toString());
		}

		return param;
	}

	/* 매입전자세금계산서 상신 목록 조회 */
	public ResultVO GetETaxSendList(ResultVO param) throws Exception {
		param.setFail("BizboxA 전용 기능입니다.");
		return param;
	}

	/* 매입전자세금계산서 미사용 처리 목록 조회 */
	public ResultVO GetETaxNotUseList(ResultVO param) throws Exception {
		param.setFail("BizboxA 전용 기능입니다.");
		return param;
	}

	@Override
	public ResultVO GetETaxFilterList ( ResultVO param ) throws Exception {
		param.setFail("BizboxA 전용 기능입니다.");
		return param;
	}

	@Override
	public ResultVO GetETaxTransHistoryList ( ResultVO param ) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
}

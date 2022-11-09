package expend.np.user.etax;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.helper.logger.CommonLogger;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;

@Service("FNpUserETaxServiceI")
public class FNpUserETaxServiceIImpl implements FNpUserETaxService {

	/* 변수정의 */
	/* 변수정의 - DAO */
	@Resource(name = "FNpUserETaxServiceIDAO")
	private FNpUserETaxServiceIDAO	dao;

	@Resource(name = "CommonLogger")
	private final CommonLogger			cmLog	= new CommonLogger();

	/* 매입전자세금계산서 목록 조회 */
	public ResultVO selectETaxList(Map<String, Object> param, ConnectionVO conVo) throws Exception {
		ResultVO result = new ResultVO();
		try {
			if (param.containsKey("taxTy")) {
				if (CommonConvert.CommonGetStr(param.get("taxTy")).equals("1")) {
					param.put("taxTy", "1");
				}
				else if (CommonConvert.CommonGetStr(param.get("taxTy")).equals("2")) {
					param.put("taxTy", "4");
				}
				else {
					param.put("taxTy", "4");
				}
			}

			result.setAaData(dao.selectETaxList(param, conVo));
		}
		catch (Exception e) {
			// TODO: handle exception
			result.setFail(e.getMessage());
		}

		return result;
	}

	@Override
	public ResultVO selectWritingETaxList(Map<String, Object> param) {
		return null;
	}

	@Override
	public List<Map<String, Object>> selectGWEtaxAuth(Map<String, Object> param) {
		return null;
	}

	@Override
	public List<Map<String, Object>> selectETaxSendList(Map<String, Object> param) {
		return null;
	}

	@Override
	public ResultVO NpUserETaxReflect(Map<String, Object> param) throws Exception {
		return null;
	}

	/* 이관받은 내역 조회 */
	@Override
	public List<Map<String, Object>> NpTransferETaxListSelect(Map<String, Object> param) {
		return null;
	}

	/* 매입전자세금계산서 이관 내역 조회 */
	@Override
	public ResultVO GetETaxTransHistoryList(ResultVO param) throws Exception {
		return null;
	}
	// /* 변수정의 */
	// /* 변수정의 - DAO */
	// @Resource ( name = "FNpUserETaxServiceIDAO" )
	// private FNpUserETaxServiceIDAO dao;
	//
	// /* 세금계산서 데이터 조회 */
	// public ResultVO selectETaxList ( Map<String, Object> param, ConnectionVO
	// conVo ){
	// ResultVO result = new ResultVO( );
	// try{
	// result.setAaData( dao.selectETaxList( param, conVo ) );
	// }catch(Exception e){
	// result.setFail( e.getMessage( ) );
	// }
	// return result;
	// }
	//
	// /* 전송된 세금게산서 및 작성중인 세금계산서 정보 조회 */
	// public ResultVO selectWritingETaxList ( Map<String, Object> param ){
	// return null;
	// }
	//
	// /* 세금계산서 권한 조회 */
	// public List<Map<String, Object>> selectGWEtaxAuth ( Map<String, Object>
	// param ){
	// return null;
	// }
	//
	// /* 반영된 세금게산서 리스트 조회 */
	// public List<Map<String, Object>> selectETaxSendList ( Map<String, Object>
	// param ){
	// return null;
	// }
	//
	// /* 세금계산서 반영 */
	// public ResultVO NpUserETaxReflect ( Map<String, Object> param ) throws
	// Exception{
	// ResultVO result = new ResultVO( );
	// return result;
	// }
	//
	// /* 이관받은 내역 조회 */
	// public List<Map<String, Object>> NpTransferETaxListSelect ( Map<String,
	// Object> param ){
	// List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
	// return result;
	// }

	/* ## ############################################# ## */
	/* 매입전자세금계산서 현황 및 기능 2차 구현 - 김상겸 */
	/* ## ############################################# ## */
	public ResultVO GetETaxList(ResultVO param, ConnectionVO conVo) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map = (param.getParams() == null ? new HashMap<String, Object>() : param.getParams());
		map.put("groupSeq", CommonConvert.CommonGetStr(param.getGroupSeq()));
		map.put("compSeq", CommonConvert.CommonGetStr(param.getCompSeq()));
		map.put("deptSeq", CommonConvert.CommonGetStr(param.getDeptSeq()));
		map.put("empSeq", CommonConvert.CommonGetStr(param.getEmpSeq()));
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
			else if (!map.containsKey("erpCompSeq") || CommonConvert.CommonGetStr(map.get("erpCompSeq")).equals("")) {
				param.setFail("parameter erpCompSeq is not exists..");
				return param;
			}
			else {
				param.setAaData(dao.GetETaxList(map, conVo));
				param.setSuccess();
			}
		}
		catch (Exception e) {
			param.setFail("FNpUserETaxServiceIImpl.GetETaxList >> " + e.toString());
		}

		return param;
	}

	public ResultVO GetETaxApprovalList(ResultVO param, ConnectionVO conVo) throws Exception {

		cmLog.CommonSetInfo("GetETaxApprovalList.param >> " + param.toString());

		Map<String, Object> map = new HashMap<String, Object>();
		map = (param.getParams() == null ? new HashMap<String, Object>() : param.getParams());
		map.put("groupSeq", CommonConvert.CommonGetStr(param.getGroupSeq()));
		map.put("compSeq", CommonConvert.CommonGetStr(param.getCompSeq()));
		map.put("deptSeq", CommonConvert.CommonGetStr(param.getDeptSeq()));
		map.put("empSeq", CommonConvert.CommonGetStr(param.getEmpSeq()));
		map.put("erpCompSeq", CommonConvert.CommonGetStr(param.getErpCompSeq()));
		map.put("erpEmpSeq", CommonConvert.CommonGetStr(param.getErpEmpSeq()));

		try {
			/* 필수 파라미터 점검 */
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
			else if (!map.containsKey("eTaxStat")) {
				param.setFail("parameter eTaxStat is not exists..");
				return param;
			}
			else if (!map.containsKey("searchStr")) {
				param.setFail("parameter searchStr is not exists..");
				return param;
			}
			else if (!map.containsKey("mailAuth")) {
				param.setFail("parameter mailAuth is not exists..");
				return param;
			}
			else if (!map.containsKey("partnerAuth")) {
				param.setFail("parameter partnerAuth is not exists..");
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
			else if (!map.containsKey("eTaxTransList")) {
				param.setFail("parameter eTaxTransList is not exists..");
				return param;
			}
			else if (!map.containsKey("eTaxReceiveList")) {
				param.setFail("parameter eTaxReceiveList is not exists..");
				return param;
			}
			else {
				param.setAaData(dao.GetETaxApprovalList(map, conVo));
				param.setSuccess();
			}
		}
		catch (Exception e) {
			param.setFail("FNpUserETaxServiceIImpl.GetETaxList >> " + e.toString());
		}

		return param;
	}

	public ResultVO GetETaxAuthList(ResultVO param) throws Exception {
		param.setFail("BizboxAlpha 연동 전용기능입니다.");
		return param;
	}

	public ResultVO GetETaxSendList(ResultVO param) throws Exception {
		param.setFail("BizboxAlpha 연동 전용기능입니다.");
		return param;
	}

	public ResultVO GetETaxNotUseList(ResultVO param) throws Exception {
		param.setFail("BizboxAlpha 연동 전용기능입니다.");
		return param;
	}

	/**
	 * 매입전자세금계산서 이관 목록 조회
	 *
	 * @param param
	 *            ( issDateFrom, issDateTo, compSeq, empSeq )
	 * @return ( compSeq, issNo, issDt, partnerNo, partnerName, transferSeq, transferName, receiveSeq, receiveName, supperKey )
	 * @throws Exception
	 */
	public ResultVO GetETaxTransList(ResultVO param) throws Exception {
		param.setFail("Bizbox Alpha 전용 기능입니다.");
		return param;
	}

	/**
	 * 매입전자세금계산서 수신 목록 조회
	 *
	 * @param param
	 *            ( issDateFrom, issDateTo, compSeq, empSeq )
	 * @return ( compSeq, issNo, issDt, partnerNo, partnerName, transferSeq, transferName, receiveSeq, receiveName, supperKey )
	 * @throws Exception
	 */
	public ResultVO GetETaxReceiveList(ResultVO param) throws Exception {
		param.setFail("Bizbox Alpha 전용 기능입니다.");
		return param;
	}

	/**
	 * 매입전자세금계산서 변경 목록및 옵션 조회
	 *
	 * @param param
	 *            ( issDateFrom, issDateTo, compSeq, empSeq )
	 * @return
	 * @throws Exception
	 */
	@Override
	public ResultVO GetETaxHistory ( ResultVO param ) throws Exception {
		param.setFail("Bizbox Alpha 전용 기능입니다.");
		return param;
	}
}
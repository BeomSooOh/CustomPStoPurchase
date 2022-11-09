package expend.np.user.etax;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.helper.logger.CommonLogger;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.common.CommonInterface.commonCode;

@Service("FNpUserETaxServiceA")
public class FNpUserETaxServiceAImpl implements FNpUserETaxService {

	/* 변수정의 */
	/* 변수정의 - DAO */
	@Resource(name = "FNpUserETaxServiceADAO")
	private FNpUserETaxServiceADAO dao;

	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog;

	/* 세금계산서 데이터 조회 */
	@Override
	public ResultVO selectETaxList(Map<String, Object> param, ConnectionVO conVo) {
		cmLog.CommonSetInfo( "! [EX] selectETaxList param >> " + param.toString( ) );
		ResultVO result = new ResultVO();
		try {
			//			result.setAaData( dao.selectETaxList( param, conVo ) );
		}
		catch (Exception e) {
			result.setFail(e.getMessage());
		}
		return result;
	}

	/* 전송된 세금게산서 및 작성중인 세금계산서 정보 조회 */
	public ResultVO selectWritingETaxList(Map<String, Object> param) {
		ResultVO result = new ResultVO();
		try {
			result.setAaData(dao.selectWritingETaxList(param));
		}
		catch (Exception e) {
			result.setFail(e.getMessage());
		}
		return result;
	}

	/* 세금계산서 권한 조회 */
	public List<Map<String, Object>> selectGWEtaxAuth(Map<String, Object> param) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		try {
			result = dao.selectGWEtaxAuth(param);
		}
		catch (Exception e) {
			result = new ArrayList<Map<String, Object>>();
		}
		return result;
	}

	/* 반영된 세금게산서 리스트 조회 */
	public List<Map<String, Object>> selectETaxSendList(Map<String, Object> param) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		try {
			result = dao.selectETaxSendList(param);
		}
		catch (Exception e) {
			result = new ArrayList<Map<String, Object>>();
		}
		return result;
	}

	/* 세금계산서 반영 */
	public ResultVO NpUserETaxReflect(Map<String, Object> param) throws Exception {
		ResultVO result = new ResultVO();
		result = dao.NpUserETaxReflect(param);
		return result;
	}

	/* 이관받은 내역 조회 */
	public List<Map<String, Object>> NpTransferETaxListSelect(Map<String, Object> param) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		try {
			result = dao.NpTransferETaxListSelect(param);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
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

	/* ## ############################################# ## */
	/* 매입전자세금계산서 현황 및 기능 2차 구현 - 김상겸 */
	/* ## ############################################# ## */
	public ResultVO GetETaxList(ResultVO param, ConnectionVO conVo) throws Exception {
		cmLog.CommonSetInfo( "! [EX] ConnectionVO conVo >> " + conVo.toString( ) );
		param.setFail("ERP 연동 전용기능입니다.");
		return param;
	}

	/**
	 * 매입전자세금계산서 권한 목록
	 */
	public ResultVO GetETaxAuthList(ResultVO param) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map = (param.getParams() == null ? new HashMap<String, Object>() : param.getParams());
		map.put("groupSeq", CommonConvert.CommonGetStr(param.getGroupSeq()));
		map.put("compSeq", CommonConvert.CommonGetStr(param.getCompSeq()));
		map.put("deptSeq", CommonConvert.CommonGetStr(param.getDeptSeq()));
		map.put("empSeq", CommonConvert.CommonGetStr(param.getEmpSeq()));

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
			}
			else {
				param.setAaData(dao.GetETaxAuthList(map));
				param.setSuccess();
			}
		}
		catch (Exception e) {
			param.setFail("FNpUserETaxServiceIImpl.GetETaxAuthList >> " + e.toString());
		}

		return param;
	}

	/* 매입전자세금계산서 상신 목록 조회 */
	public ResultVO GetETaxSendList(ResultVO param) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map = (param.getParams() == null ? new HashMap<String, Object>() : param.getParams());
		map.put("groupSeq", CommonConvert.CommonGetStr(param.getGroupSeq()));
		map.put("compSeq", CommonConvert.CommonGetStr(param.getCompSeq()));
		map.put("deptSeq", CommonConvert.CommonGetStr(param.getDeptSeq()));
		map.put("empSeq", CommonConvert.CommonGetStr(param.getEmpSeq()));

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
			param.setFail("FNpUserETaxServiceIImpl.GetETaxSendList >> " + e.toString());
		}

		return param;
	}

	/* 매입전자세금계산서 미사용 목록 조회 */
	public ResultVO GetETaxNotUseList(ResultVO param) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map = (param.getParams() == null ? new HashMap<String, Object>() : param.getParams());
		map.put("groupSeq", CommonConvert.CommonGetStr(param.getGroupSeq()));
		map.put("compSeq", CommonConvert.CommonGetStr(param.getCompSeq()));
		map.put("deptSeq", CommonConvert.CommonGetStr(param.getDeptSeq()));
		map.put("empSeq", CommonConvert.CommonGetStr(param.getEmpSeq()));

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
			param.setFail("FNpUserETaxServiceIImpl.GetETaxSendList >> " + e.toString());
		}

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
		Map<String, Object> mapParam = new HashMap<String, Object>();
		mapParam = param.getParams();
		mapParam.put(commonCode.GROUPSEQ, param.getGroupSeq());
		mapParam.put(commonCode.COMPSEQ, param.getCompSeq());
		mapParam.put(commonCode.EMPSEQ, param.getEmpSeq());
		mapParam.put(commonCode.EMPNAME, param.getEmpName());

		/* 필수 값 점검 ( issDateFrom, issDateTo, compSeq, empSeq ) */
		if (!mapParam.containsKey("issDateFrom") || CommonConvert.CommonGetStr(mapParam.get("issDateFrom")).equals("")) {
			param.setFail("issDateFrom is not exists..");
			return param;
		}
		else if (!mapParam.containsKey("issDateTo") || CommonConvert.CommonGetStr(mapParam.get("issDateTo")).equals("")) {
			param.setFail("issDateTo is not exists..");
			return param;
		}
		else if (!mapParam.containsKey("compSeq") || CommonConvert.CommonGetStr(mapParam.get("compSeq")).equals("")) {
			param.setFail("compSeq is not exists..");
			return param;
		}
		else if (!mapParam.containsKey("empSeq") || CommonConvert.CommonGetStr(mapParam.get("empSeq")).equals("")) {
			param.setFail("empSeq is not exists..");
			return param;
		}
		else {
			param = dao.GetETaxTransList(mapParam);
		}

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
		Map<String, Object> mapParam = new HashMap<String, Object>();
		mapParam = param.getParams();
		mapParam.put(commonCode.GROUPSEQ, param.getGroupSeq());
		mapParam.put(commonCode.COMPSEQ, param.getCompSeq());
		mapParam.put(commonCode.EMPSEQ, param.getEmpSeq());
		mapParam.put(commonCode.EMPNAME, param.getEmpName());

		/* 필수 값 점검 ( issDateFrom, issDateTo, compSeq, empSeq ) */
		if (!mapParam.containsKey("issDateFrom") || CommonConvert.CommonGetStr(mapParam.get("issDateFrom")).equals("")) {
			param.setFail("issDateFrom is not exists..");
			return param;
		}
		else if (!mapParam.containsKey("issDateTo") || CommonConvert.CommonGetStr(mapParam.get("issDateTo")).equals("")) {
			param.setFail("issDateTo is not exists..");
			return param;
		}
		else if (!mapParam.containsKey("compSeq") || CommonConvert.CommonGetStr(mapParam.get("compSeq")).equals("")) {
			param.setFail("compSeq is not exists..");
			return param;
		}
		else if (!mapParam.containsKey("empSeq") || CommonConvert.CommonGetStr(mapParam.get("empSeq")).equals("")) {
			param.setFail("empSeq is not exists..");
			return param;
		}
		else {
			param = dao.GetETaxReceiveList(mapParam);
		}

		return param;
	}

	public ResultVO GetETaxApprovalList(ResultVO param, ConnectionVO conVo) throws Exception{
		cmLog.CommonSetInfo( "! [EX] ConnectionVO conVo >> " + conVo.toString( ) );
		param.setFail("ERP 연동 전용기능입니다.");
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

	@Override
	public ResultVO GetETaxHistory ( ResultVO param ) throws Exception {
		Map<String, Object> mapParam = new HashMap<String, Object>();
		mapParam = param.getParams();
		mapParam.put(commonCode.GROUPSEQ, param.getGroupSeq());
		mapParam.put(commonCode.COMPSEQ, param.getCompSeq());
		mapParam.put(commonCode.EMPSEQ, param.getEmpSeq());
		mapParam.put(commonCode.EMPNAME, param.getEmpName());

		try{
			List<Map<String, Object>> aaData = dao.GetETaxHistory(mapParam);
			if(aaData.size( ) != 7){
				param.setFail("사용자 세금계산서 사용 이력 타입 오류, 7가지의 타입이 조회되지 않았습니다.");
				return param;
			}

			List<Map<String, Object>> aData = dao.GetETaxAuthOption(mapParam);
			if(aData.size( ) != 1){
				param.setFail("사용자 세금계산서 옵션 조회 실패");
				return param;
			}
			param.setaData( aData.get( 0 ) );
			param.setAaData( aaData );
			param.setSuccess( );
		}catch(Exception ex){
			param.setFail( "세금계산서 이력조회 실패", ex );
		}
		return param;
	}
}

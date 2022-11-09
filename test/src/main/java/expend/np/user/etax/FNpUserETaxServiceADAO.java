package expend.np.user.etax;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import common.helper.connection.CommonExConnect;
import common.helper.logger.CommonLogger;
import common.map.np.ETax;
//import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("FNpUserETaxServiceADAO")
public class FNpUserETaxServiceADAO extends EgovComAbstractDAO {

	/* 변수정의 - Common */
	@Resource(name = "CommonLogger")
	private CommonLogger	cmLog;
	/* 변수정의 - class */
	CommonExConnect			connector	= new CommonExConnect();

	/* 테스트 DAO */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> npTest(Map<String, Object> params) throws Exception {
		List<Map<String, Object>> result = new ArrayList<>();
		try {
			this.list("npUserCodeU.TestCode", params);
			result = (List<Map<String, Object>>) params.get("result");
		}
		catch (Exception ex) {
			cmLog.CommonSetError(ex);
			throw ex;
		}
		return result;
	}

	/* 전송된 세금게산서 및 작성중인 세금계산서 정보 조회 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectWritingETaxList(Map<String, Object> params) throws Exception {
		List<Map<String, Object>> result = new ArrayList<>();
		try {
			result = this.list("selectWritingETaxList", params);
		}
		catch (Exception ex) {
			cmLog.CommonSetError(ex);
			throw ex;
		}
		return result;
	}

	/* 세금계산서 권한 조회 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectGWEtaxAuth(Map<String, Object> params) throws Exception {
		List<Map<String, Object>> result = new ArrayList<>();
		try {
			result = this.list("selectGWEtaxAuth", params);
		}
		catch (Exception ex) {
			cmLog.CommonSetError(ex);
			throw ex;
		}
		return result;
	}

	/* 반영된 세금게산서 리스트 조회 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectETaxSendList(Map<String, Object> params) throws Exception {
		List<Map<String, Object>> result = new ArrayList<>();
		try {
			result = this.list("NpUserCodeA.selectETaxSendList", params);
		}
		catch (Exception ex) {
			cmLog.CommonSetError(ex);
			throw ex;
		}
		return result;
	}

	/* 반영된 세금게산서 리스트 조회 */
	@SuppressWarnings("unchecked")
	public ResultVO NpUserETaxReflect(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			Map<String, Object> tResult = new LinkedHashMap<String, Object>();
			tResult = (Map<String, Object>) this.select("NpUserCodeA.NpUserETaxSelect", params);
			/* 세금계산서 내역 미존재 시 insert */
			if (tResult == null || tResult.isEmpty()) {
				tResult = new LinkedHashMap<String, Object>();
				tResult.put("syncId", this.insert("NpUserCodeA.NpUserETaxInsert", params));
			}
			result.setaData(tResult);
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("세금계산서 반영에 실패하였습니다.", ex);
		}
		return result;
	}

	/* 이관받은 내역 조회 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> NpTransferETaxListSelect(Map<String, Object> params) throws Exception {
		List<Map<String, Object>> result = new ArrayList<>();
		try {
			result = this.list("NpUserCodeA.NpTransferETaxListSelect", params);
		}
		catch (Exception ex) {
			cmLog.CommonSetError(ex);
			throw ex;
		}
		return result;
	}

	/* ## ############################################# ## */
	/* 매입전자세금계산서 현황 및 기능 2차 구현 - 김상겸 */
	/* ## ############################################# ## */
	/**
	 * 매입전자세금계산서 권한 목록
	 *
	 * @param p
	 *            ( deptSeq, empSeq, compSeq )
	 * @return ( authType, useYN, name, code )
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> GetETaxAuthList(Map<String, Object> p) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		try {
			result = this.list("NpUserCodeA.GetETaxAuthList", p);
		}
		catch (Exception e) {
			cmLog.CommonSetError(e);
			throw e;
		}
		return result;
	}

	/* ## ############################################# ## */
	/* 매입전자세금계산서 현황 및 기능 2차 구현 - 최상배 */
	/* ## ############################################# ## */
	/**
	 * 매입전자세금계산서 권한 목록
	 *
	 * @param p
	 *            ( deptSeq, empSeq, compSeq )
	 * @return ( authType, useYN, name, code )
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> GetETaxAuthList2(Map<String, Object> p) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		try {
			result = this.list("NpUserCodeA.GetETaxAuthList2", p);
		}
		catch (Exception e) {
			cmLog.CommonSetError(e);
			throw e;
		}
		return result;
	}

	/**
	 * 매입전자세금계산서 권한 구분
	 *
	 * @param p
	 *            ( deptSeq, empSeq, compSeq )
	 * @return ( authType, useYN, name, code )
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> GetETaxAuthOption(Map<String, Object> p) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		try {
			result = this.list("NpUserCodeA.GetETaxAuthOption", p);
		}
		catch (Exception e) {
			cmLog.CommonSetError(e);
			throw e;
		}
		return result;
	}

	/**
	 * 매입전자세금계산서 이력 조회
	 *
	 * @param p
	 *            ( deptSeq, empSeq, compSeq )
	 * @return ( authType, useYN, name, code )
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> GetETaxHistory(Map<String, Object> p) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		try {
			update("NpUserCodeA.GetETaxHistoryGroupConcatSet", p);
			result = this.list("NpUserCodeA.GetETaxHistory", p);
		}
		catch (Exception e) {
			cmLog.CommonSetError(e);
			throw e;
		}
		return result;
	}

	/**
	 * 매입전자세금계산서 상신 목록 조회
	 *
	 * @param p
	 *            ( issDateFrom, issDateTo, compSeq )
	 * @return ( syncId, issNo, issDt, trRegNb, compSeq, ifMId, ifDId, sendYn, useYn, docSeq, resDocSeq, resSeq, budgetSeq, tradeSeq, createEmpName )
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> GetETaxSendList(Map<String, Object> p) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		try {
			result = this.list("NpUserCodeA.GetETaxSendList", p);
		}
		catch (Exception e) {
			cmLog.CommonSetError(e);
			throw e;
		}
		return result;
	}

	/**
	 * 매입전자세금계산서 미사용 목록 조회
	 * @param p ( issDateFrom, issDateTo, compSeq )
	 * @return ( sync_id, iss_no, iss_dt, comp_seq, send_yn, use_yn )
	 * @throws Exception
	 */
	public List<Map<String, Object>> GetETaxNotUseList(Map<String, Object> p) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		try {
			result = this.list("NpUserCodeA.GetETaxNotUseList", p);
		}
		catch (Exception e) {
			cmLog.CommonSetError(e);
			throw e;
		}
		return result;
	}

	/**
	 * 매입전자세금계산서 현황 및 기능 2차 구현 - 매입전자세금계산서 데이터 존재 여부 확인
	 * @param param ( compSeq, empSeq, issDateFrom, issDateTo )
	 * @return ( compSeq, issNo, issDt, partnerNo, partnerName, transferSeq, transferName, receiveSeq, receiveName, supperKey )
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ResultVO GetETaxTransList(Map<String, Object> param) throws Exception {
		ResultVO result = new ResultVO();
		try {
			List<Map<String, Object>> resultMap = new ArrayList<Map<String, Object>>();
			resultMap = (List<Map<String, Object>>) list(ETax.Map.TRANSLIST, param);

			if (resultMap == null) {
				resultMap = new ArrayList<Map<String, Object>>();
			}
			result.setAaData(resultMap);
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setaData(new HashMap<String, Object>());
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}

		return result;
	}

	/**
	 * 매입전자세금계산서 현황 및 기능 2차 구현 - 매입전자세금계산서 데이터 존재 여부 확인
	 * @param param ( compSeq, empSeq, issDateFrom, issDateTo )
	 * @return ( compSeq, issNo, issDt, partnerNo, partnerName, transferSeq, transferName, receiveSeq, receiveName, supperKey )
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ResultVO GetETaxReceiveList(Map<String, Object> param) throws Exception {
		ResultVO result = new ResultVO();
		try {
			List<Map<String, Object>> resultMap = new ArrayList<Map<String, Object>>();
			resultMap = (List<Map<String, Object>>) list(ETax.Map.RECEIVELIST, param);

			if (resultMap == null) {
				resultMap = new ArrayList<Map<String, Object>>();
			}
			result.setAaData(resultMap);
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setaData(new HashMap<String, Object>());
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}

		return result;
	}

	@SuppressWarnings("unchecked")
	public ResultVO GetETaxTransHistoryList(Map<String, Object> p) throws Exception {
		/* VO */
		ResultVO result = new ResultVO();

		try {
			/* LIST */
			result.setAaData((List<Map<String, Object>>) list("NpUserReportA.GetETaxTransHistoryList", p));
			result.setSuccess();
		}
		catch (Exception e) {
			/* EXCEPTION */
			result.setFail("Data 질의 요청중 에러 발생", e);
		}

		/* RETURN */
		return result;
	}
}
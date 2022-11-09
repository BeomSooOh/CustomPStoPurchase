package expend.np.admin.etax;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import common.vo.common.ResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("FNpAdminETaxServiceADAO")
public class FNpAdminETaxServiceADAO extends EgovComAbstractDAO {

	/**
	 * 매입전자세금계산서 상신 목록 조회
	 * 
	 * @param p
	 *            ( issDateFrom, issDateTo, compSeq )
	 * @return ( syncId, issNo, issDt, partnerNo, compSeq, ifMId, ifDId, sendYn, useYn, docSeq, resDocSeq, resSeq, budgetSeq, tradeSeq, createEmpName )
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> GetETaxSendList(Map<String, Object> p) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		try {
			result = this.list("NpAdminETaxA.GetETaxSendList", p);
		}
		catch (Exception e) {
			throw e;
		}
		return result;
	}

	/**
	 * 매입전자세금계산서 미사용 목록 조회
	 * @param p ( issDateFrom, issDateTo, compSeq )
	 * @return ( sync_id, iss_no, iss_dt, partner_no, comp_seq, if_m_id, if_d_id, send_yn, use_yn, notUseEmpName )
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> GetETaxNotUseList(Map<String, Object> p) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		try {
			result = this.list("NpAdminETaxA.GetETaxNotUseList", p);
		}
		catch (Exception e) {
			throw e;
		}
		return result;
	}
	
	/**
	 * 매입전자세금계산서 미사용 / 상신 통합 목록 조회
	 * @param p ( issDateFrom, issDateTo, compSeq )
	 * @return ( sync_id, iss_no, iss_dt, partner_no, comp_seq, if_m_id, if_d_id, send_yn, use_yn, notUseEmpName )
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> GetETaxFilterList(Map<String, Object> p) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		try {
			update("NpAdminETaxA.GetETaxFilterListGroupConcatSet", p);
			result = this.list("NpAdminETaxA.GetETaxFilterList", p);
		}
		catch (Exception e) {
			throw e;
		}
		return result;
	}
	
	
	@SuppressWarnings("unchecked")
	public ResultVO GetETaxTransHistoryList(Map<String, Object> p) throws Exception {
		/* VO */
		ResultVO result = new ResultVO();

		try {
			/* LIST */
			result.setAaData((List<Map<String, Object>>) list("NpUserReportA.GetETaxTransHistoryListAdmin", p));
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

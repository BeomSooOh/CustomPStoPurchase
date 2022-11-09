package expend.np.admin.card;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import common.vo.common.ResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("FNpAdminCardServiceADAO")
public class FNpAdminCardServiceADAO extends EgovComAbstractDAO {

	/* 카드 내역 미사용 처리 목록 조회 */
	@SuppressWarnings("unchecked")
	public ResultVO GetNotUseList(Map<String, Object> p) throws Exception {
		/* VO */
		ResultVO result = new ResultVO();

		try {
			/* LIST */
			result.setAaData((List<Map<String, Object>>) list("NpAdminCard.GetNotUseList", p));
			result.setAaData((result.getAaData() == null ? new ArrayList<Map<String, Object>>() : result.getAaData()));
			result.setSuccess();
		}
		catch (Exception e) {
			/* EXCEPTION */
			result.setFail("Data 질의 요청중 에러 발생", e);
		}

		/* RETURN */
		return result;
	}

	/* 카드 내역 현황 조회 ( 관리자 ) */
	@SuppressWarnings("unchecked")
	public ResultVO GetCardList(Map<String, Object> p) throws Exception {
		/* VO */
		ResultVO result = new ResultVO();

		try {
			/* LIST */
			result.setAaData((List<Map<String, Object>>) list("NpAdminCard.GetCardList", p));
			result.setAaData((result.getAaData() == null ? new ArrayList<Map<String, Object>>() : result.getAaData()));
			result.setSuccess();
		}
		catch (Exception e) {
			/* EXCEPTION */
			result.setFail("Data 질의 요청중 에러 발생", e);
		}

		/* RETURN */
		return result;
	}

	/* 카드 이관 항목 조회 */
	@SuppressWarnings("unchecked")
	public ResultVO GetTransItem(Map<String, Object> p) throws Exception {
		/* VO */
		ResultVO result = new ResultVO();

		try {
			/* MAP */
			result.setaData((Map<String, Object>) select("NpAdminCard.GetTransItem", p));
			result.setaData((result.getaData() == null ? new HashMap<String, Object>() : result.getaData()));
			result.setSuccess();
		}
		catch (Exception e) {
			/* EXCEPTION */
			result.setFail("Data 질의 요청중 에러 발생", e);
		}

		/* RETURN */
		return result;
	}

	/* 카드 이관 항목 생성 */
	public ResultVO SetTransInsertItem(Map<String, Object> p) throws Exception {
		/* VO */
		ResultVO result = new ResultVO();

		try {
			/* MAP */
			insert("NpAdminCard.SetTransInsertItem", p);
			result.setaData(p);
			result.setSuccess();
		}
		catch (Exception e) {
			/* EXCEPTION */
			result.setFail("Data 질의 요청중 에러 발생", e);
		}

		/* RETURN */
		return result;
	}

	/* 카드 이관 항목 수정 */
	public ResultVO SetTransUpdateItem(Map<String, Object> p) throws Exception {
		/* VO */
		ResultVO result = new ResultVO();

		try {
			/* MAP */
			update("NpAdminCard.SetTransUpdateItem", p);
			result.setSuccess();
		}
		catch (Exception e) {
			/* EXCEPTION */
			result.setFail("Data 질의 요청중 에러 발생", e);
		}

		/* RETURN */
		return result;
	}

	public ResultVO SetCardUseYNUpdate(Map<String, Object> p) throws Exception {
		/* VO */
		ResultVO result = new ResultVO();

		try {
			/* MAP */
			update("NpAdminCard.SetUseYNUpdateItem", p);
			result.setSuccess();
		}
		catch (Exception e) {
			/* EXCEPTION */
			result.setFail("Data 질의 요청중 에러 발생", e);
		}

		/* RETURN */
		return result;
	}

	public ResultVO SetCardUseYNInsert(Map<String, Object> p) throws Exception {
		/* VO */
		ResultVO result = new ResultVO();

		try {
			/* MAP */
			insert("NpAdminCard.SetUseYNInsertItem", p);
			result.setaData(p);
			result.setSuccess();
		}
		catch (Exception e) {
			/* EXCEPTION */
			result.setFail("Data 질의 요청중 에러 발생", e);
		}

		/* RETURN */
		return result;
	}

	/**
	 * 	전체 카드 사용내역 정보 조회
	 * 
	 */
	public ResultVO GetCardList2FullList(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			result.setAaData(list("NpAdminCard.GetCardList2FullList", params));
			result.setSuccess();
		}
		catch (Exception e) {
			result.setFail("법인카드 승인내역 전체 조회 중 오류 발생 GetCardList2FullList  ERROR MSG : " + e.getMessage( ) , e);
		}
		return result;
	}
	
	/**
	 * 	전체 카드 사용내역 사용 이력 조회
	 * 
	 */
	public ResultVO GetCardList2History(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			update ("NpAdminCard.GetCardList2HistoryGroupConcatSet", params);
			result.setAaData( list("NpAdminCard.GetCardList2History", params) );
			result.setaData(params);
			result.setSuccess();
		}
		catch (Exception e) {
			result.setFail("Data 질의 요청중 에러 발생", e);
		}
		return result;
	}
	
	
	@SuppressWarnings("unchecked")
	public ResultVO GetCardTransHistoryListSelect(Map<String, Object> p) throws Exception {
		/* VO */
		ResultVO result = new ResultVO();

		try {
			/* LIST */
			result.setAaData((List<Map<String, Object>>) list("NpAdminCard.GetCardTransHistoryListSelect", p));
			result.setSuccess();
		}
		catch (Exception e) {
			/* EXCEPTION */
			result.setFail("Data 질의 요청중 에러 발생", e);
		}

		/* RETURN */
		return result;
	}
	
	@SuppressWarnings("unchecked")
	public ResultVO GetCardCmsBatchTime(Map<String, Object> p) throws Exception {
		/* VO */
		ResultVO result = new ResultVO();

		try {
			/* LIST */
			result.setaData((Map<String, Object>) select("NpAdminCard.GetCardCmsBatchTime", p));
			result.setSuccess();
		}
		catch (Exception e) {
			/* EXCEPTION */
			result.setFail("GetCardCmsBatchTime Data 질의 요청중 에러 발생", e);
		}

		/* RETURN */
		return result;
	}
}

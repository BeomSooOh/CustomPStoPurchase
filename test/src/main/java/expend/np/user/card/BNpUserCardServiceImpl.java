package expend.np.user.card;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.vo.common.ResultVO;
import common.vo.common.CommonInterface.commonCode;

@Service("BNpUserCardService")
public class BNpUserCardServiceImpl implements BNpUserCardService {

	/* SERVICE IMPL */
	@Resource(name = "FNpUserCardService")
	private FNpUserCardService service;

	/* 카드 내역 현황 조회 ( 사용자 ) */
	public ResultVO GetCardList(ResultVO param) throws Exception {

		/* VO */
		//		ResultVO result = new ResultVO();

		/* LIST */
		//		List<Map<String, Object>> notUseList = new ArrayList<Map<String, Object>>();
		//		List<Map<String, Object>> transList = new ArrayList<Map<String, Object>>();
		//		List<Map<String, Object>> receiveList = new ArrayList<Map<String, Object>>();

		/* STRING */
		//		String notUseSyncIds = "", transSyncIds = "", receiveSyncIds = "";

		//		/* 미사용 목록 조회 */
		//		notUseList = service.GetNotUseList(param).getAaData();
		//		for (Map<String, Object> map : notUseList) {
		//			if (map.containsKey("syncId")) {
		//				if (notUseSyncIds.equals("")) {
		//					notUseSyncIds += CommonConvert.CommonGetStr(map.get("syncId"));
		//				}
		//				else {
		//					notUseSyncIds += (", " + CommonConvert.CommonGetStr(map.get("syncId")));
		//				}
		//			}
		//		}
		//		param.getParams().put("notUseSyncIds", notUseSyncIds);
		//
		//		/* 이관 목록 조회 */
		//		transList = service.GetTransLIst(param).getAaData();
		//		for (Map<String, Object> map : transList) {
		//			if (map.containsKey("syncId")) {
		//				if (transSyncIds.equals("")) {
		//					transSyncIds += CommonConvert.CommonGetStr(map.get("syncId"));
		//				}
		//				else {
		//					transSyncIds += (", " + CommonConvert.CommonGetStr(map.get("syncId")));
		//				}
		//
		//			}
		//		}
		//		param.getParams().put("transSyncIds", transSyncIds);
		//
		//		/* 수신 목록 조회 */
		//		receiveList = service.GetReceiveList(param).getAaData();
		//		for (Map<String, Object> map : receiveList) {
		//			if (map.containsKey("syncId")) {
		//				if (receiveSyncIds.equals("")) {
		//					receiveSyncIds += CommonConvert.CommonGetStr(map.get("syncId"));
		//				}
		//				else {
		//					receiveSyncIds += (", " + CommonConvert.CommonGetStr(map.get("syncId")));
		//				}
		//
		//			}
		//		}
		//		param.getParams().put("receiveSyncIds", receiveSyncIds);

		/* 카드 현황 조회 ( 사용자 ) */
		param = service.GetCardList(param);

		return param;
	}

	/* 카드 내역 이관 ( 사용자 ) */
	public ResultVO SetCardTrans(ResultVO param) throws Exception {
		/* VO */
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		ResultVO temp = new ResultVO();

		/* List */
		List<Map<String, Object>> paramList = new ArrayList<Map<String, Object>>();
		paramList = CommonConvert.CommonGetJSONToListMap(CommonConvert.CommonGetStr(param.getParams().get("CardTransList")));

		for (Map<String, Object> map : paramList) {
			temp = new ResultVO();
			temp.setLoginVo(loginVo);

			map.put("receiveEmpSeq", CommonConvert.CommonGetStr(param.getParams().get("receiveEmpSeq")));
			map.put("receiveEmpName", CommonConvert.CommonGetStr(param.getParams().get("receiveEmpName")));
			map.put("receiveEmpSuperKey", CommonConvert.CommonGetStr(param.getParams().get("receiveEmpSuperKey")));
			temp.setParams(map);

			temp = service.SetTransCardItem(temp);

			if (temp.getResultCode().equals(commonCode.FAIL)) { throw new Exception("카드 내역 이관 처리중 오류가 발생되었습니다."); }
		}

		param.setSuccess();
		return param;
	}

	/* 카드 내역 사용 / 미사용 처리 ( 사용자 ) */
	public ResultVO SetCardUseYN(ResultVO param) throws Exception {
		/* VO */
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		ResultVO temp = new ResultVO();

		/* List */
		List<Map<String, Object>> paramList = new ArrayList<Map<String, Object>>();
		paramList = CommonConvert.CommonGetJSONToListMap(CommonConvert.CommonGetStr(param.getParams().get("cardUseYNList")));

		for (Map<String, Object> map : paramList) {
			temp = new ResultVO();
			temp.setLoginVo(loginVo);

			map.put("useYN", CommonConvert.CommonGetStr(param.getParams().get("useYN")));
			temp.setParams(map);

			temp = service.SetCardUseYN(temp);

			if (temp.getResultCode().equals(commonCode.FAIL)) { throw new Exception("카드 내역 이관 처리중 오류가 발생되었습니다."); }
		}

		param.setSuccess();
		return param;
	}

	/* 카드사용내역 이관관리 */
	public ResultVO GetCardTransHistoryList(ResultVO param) throws Exception {
		/* VO */
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		ResultVO temp = new ResultVO();

		/* 카드사용내역 이관 목록 조회 */
		param = service.GetCardTransHistoryList(param);
		return param;
	}

	/**
	 * 	사용자 카드 사용 내역 조회 2차 리뉴얼
	 * 
	 */
	@Override
	public ResultVO GetCardList2 ( Map<String, Object> params ) throws Exception {
		/* VO */
		ResultVO result = new ResultVO();
		
		/* 카드 현황 조회 ( 관리자 ) */
		result = service.GetCardList2(params);
		return result;
	}
}

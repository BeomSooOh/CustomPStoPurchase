package expend.np.user.card;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.vo.common.ResultVO;
import common.vo.common.CommonInterface.commonCode;

@Service("FNpUserCardService")
public class FNpUserCardServiceAImpl implements FNpUserCardService {

	/* DAO */
	@Resource(name = "FNpUserCardServiceADAO")
	private FNpUserCardServiceADAO dao;

	/* 카드 내역 미사용 처리 목록 조회 */
	public ResultVO GetNotUseList(ResultVO param) throws Exception {
		/* MAP */
		Map<String, Object> map = GetMapBase(param);

		try {
			/* 필수 파라미터 점검 ( groupSeq, compSeq, empSeq ) */
			if (!map.containsKey("groupSeq") || CommonConvert.CommonGetStr(map.get("groupSeq")).equals("")) {
				param.setFail("parameter groupSeq is not exists..");
				return param;
			}
			else if (!map.containsKey("compSeq") || CommonConvert.CommonGetStr(map.get("compSeq")).equals("")) {
				param.setFail("parameter compSeq is not exists..");
				return param;
			}
			else if (!map.containsKey("empSeq") || CommonConvert.CommonGetStr(map.get("empSeq")).equals("")) {
				param.setFail("parameter empSeq is not exists..");
				return param;
			}
			else {
				param.setAaData(dao.GetNotUseList(map).getAaData());
				param.setSuccess();
			}
		}
		catch (Exception e) {
			param.setFail("FNpUserCardServiceImpl.GetNotUseList >> " + e.toString());
		}

		return param;
	}

	/* 카드 내역 이관 목록 조회 */
	public ResultVO GetTransLIst(ResultVO param) throws Exception {
		/* MAP */
		Map<String, Object> map = GetMapBase(param);

		try {
			/* 필수 파라미터 점검 ( groupSeq, compSeq, empSeq ) */
			if (!map.containsKey("groupSeq") || CommonConvert.CommonGetStr(map.get("groupSeq")).equals("")) {
				param.setFail("parameter groupSeq is not exists..");
				return param;
			}
			else if (!map.containsKey("compSeq") || CommonConvert.CommonGetStr(map.get("compSeq")).equals("")) {
				param.setFail("parameter compSeq is not exists..");
				return param;
			}
			else if (!map.containsKey("empSeq") || CommonConvert.CommonGetStr(map.get("empSeq")).equals("")) {
				param.setFail("parameter empSeq is not exists..");
				return param;
			}
			else {
				param.setAaData(dao.GetTransLIst(map).getAaData());
				param.setSuccess();
			}
		}
		catch (Exception e) {
			param.setFail("FNpUserCardServiceImpl.GetTransLIst >> " + e.toString());
		}

		return param;
	}

	/* 카드 내역 수신 목록 조회 */
	public ResultVO GetReceiveList(ResultVO param) throws Exception {
		/* MAP */
		Map<String, Object> map = GetMapBase(param);

		try {
			/* 필수 파라미터 점검 ( groupSeq, compSeq, empSeq ) */
			if (!map.containsKey("groupSeq") || CommonConvert.CommonGetStr(map.get("groupSeq")).equals("")) {
				param.setFail("parameter groupSeq is not exists..");
				return param;
			}
			else if (!map.containsKey("compSeq") || CommonConvert.CommonGetStr(map.get("compSeq")).equals("")) {
				param.setFail("parameter compSeq is not exists..");
				return param;
			}
			else if (!map.containsKey("empSeq") || CommonConvert.CommonGetStr(map.get("empSeq")).equals("")) {
				param.setFail("parameter empSeq is not exists..");
				return param;
			}
			else {
				param.setAaData(dao.GetReceiveList(map).getAaData());
				param.setSuccess();
			}
		}
		catch (Exception e) {
			param.setFail("FNpUserCardServiceImpl.GetReceiveList >> " + e.toString());
		}

		return param;
	}

	/* 카드 내역 현황 조회 ( 사용자 ) */
	public ResultVO GetCardList(ResultVO param) throws Exception {
		/* LIST */
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

		/* MAP */
		Map<String, Object> map = GetMapBase(param);

		try {
			/* 필수 파라미터 점검 ( compSeq, cardAuthDateFrom, cardAuthDateTo, searchPartnerName, searchPartnerNo, searchGeoraeStat, searchAuthNum, searchSendYn, searchApprovalEmpName, notUseSyncIds, transSyncIds, receiveSyncIds ) */
			if (!map.containsKey("groupSeq") || CommonConvert.CommonGetStr(map.get("groupSeq")).equals("")) {
				param.setFail("parameter groupSeq is not exists..");
				return param;
			}
			else if (!map.containsKey("compSeq") || CommonConvert.CommonGetStr(map.get("compSeq")).equals("")) {
				param.setFail("parameter compSeq is not exists..");
				return param;
			}
			else if (!map.containsKey("cardAuthDateFrom") || CommonConvert.CommonGetStr(map.get("cardAuthDateFrom")).equals("")) {
				param.setFail("parameter cardAuthDateFrom is not exists..");
				return param;
			}
			else if (!map.containsKey("cardAuthDateTo") || CommonConvert.CommonGetStr(map.get("cardAuthDateTo")).equals("")) {
				param.setFail("parameter cardAuthDateTo is not exists..");
				return param;
			}
			else if (!map.containsKey("searchPartnerName")) {
				param.setFail("parameter searchPartnerName is not exists..");
				return param;
			}
			else if (!map.containsKey("searchPartnerNo")) {
				param.setFail("parameter searchPartnerNo is not exists..");
				return param;
			}
			else if (!map.containsKey("searchGeoraeStat")) {
				param.setFail("parameter searchGeoraeStat is not exists..");
				return param;
			}
			else if (!map.containsKey("searchAuthNum")) {
				param.setFail("parameter searchAuthNum is not exists..");
				return param;
			}
			else if (!map.containsKey("searchSendYn")) {
				param.setFail("parameter searchSendYn is not exists..");
				return param;
			}
			else if (!map.containsKey("searchApprovalEmpName")) {
				param.setFail("parameter searchApprovalEmpName is not exists..");
				return param;
			}
			//			else if (!map.containsKey("notUseSyncIds")) {
			//				param.setFail("parameter notUseSyncIds is not exists..");
			//				return param;
			//			}
			//			else if (!map.containsKey("transSyncIds")) {
			//				param.setFail("parameter transSyncIds is not exists..");
			//				return param;
			//			}
			//			else if (!map.containsKey("receiveSyncIds")) {
			//				param.setFail("parameter receiveSyncIds is not exists..");
			//				return param;
			//			}
			else {
				//				for (Map<String, Object> item : dao.GetCardList(map).getAaData()) {
				//					if (item.containsKey("transYn") && CommonConvert.CommonGetStr(item.get("transYn")).equals("Y")) {
				//						/* 이관 목록 제외 처리 */
				//						continue;
				//					}
				//					else if (item.containsKey("receiveYn") && CommonConvert.CommonGetStr(item.get("receiveYn")).equals("Y")) {
				//						/* 수신 목록 포함 처리 */
				//						list.add(item);
				//					}
				//					else if (item.containsKey("publicYn") && CommonConvert.CommonGetStr(item.get("publicYn")).equals("Y")) {
				//						/* 공개범위 포함 목록 포함 처리 */
				//						list.add(item);
				//					}
				//				}

				param.setAaData(dao.GetCardList(map).getAaData());
				param.setSuccess();
			}
		}
		catch (Exception e) {
			param.setFail("FNpUserCardServiceImpl.GetCardList >> " + e.toString());
		}

		return param;
	}

	/* 카드 내역 이관 */
	public ResultVO SetTransCardItem(ResultVO param) throws Exception {
		/* VO */
		ResultVO result = new ResultVO();
		result = param;

		/* 카드 이관 항목 조회 */
		result = this.GetTransItem(result);
		result = this.SetTransInsertItem(result);
		if (result.getaData().containsKey("syncId") && !CommonConvert.CommonGetStr(result.getaData().get("syncId")).equals("")) {
			/* 카드 이관 항목 수정 */
			// result = this.SetTransUpdateItem(result);
		}
		else {
			/* 카드 이관 항목 생성 */
			// result = this.SetTransInsertItem(result);
		}

		if (CommonConvert.CommonGetStr(result.getResultCode()).equals(commonCode.SUCCESS)) {
			param.setSuccess();
		}
		else {
			param.setFail(result.getResultName());
		}

		return param;
	}

	/* 카드 이관 항목 조회 */
	private ResultVO GetTransItem(ResultVO param) throws Exception {
		/* MAP */
		Map<String, Object> map = GetMapBase(param);

		try {
			/* 필수 파라미터 점검 ( groupSeq, compSeq, syncId ) */
			if (!map.containsKey("groupSeq") || CommonConvert.CommonGetStr(map.get("groupSeq")).equals("")) {
				param.setFail("parameter groupSeq is not exists..");
				return param;
			}
			else if (!map.containsKey("compSeq") || CommonConvert.CommonGetStr(map.get("compSeq")).equals("")) {
				param.setFail("parameter compSeq is not exists..");
				return param;
			}
			else if (!map.containsKey("syncId") || CommonConvert.CommonGetStr(map.get("syncId")).equals("")) {
				param.setFail("parameter syncId is not exists..");
				return param;
			}
			else {
				param.setaData(dao.GetTransItem(map).getaData());
				param.setSuccess();
			}
		}
		catch (Exception e) {
			param.setFail("FNpUserCardServiceImpl.GetTransItem >> " + e.toString());
		}

		return param;
	}

	/* 카드 이관 항목 생성 */
	private ResultVO SetTransInsertItem(ResultVO param) throws Exception {
		/* MAP */
		Map<String, Object> map = GetMapBase(param);

		try {
			/* 필수 파라미터 점검 ( groupSeq, compSeq, syncId, cardNum, authNum, authDate, authTime, partnerNo, partnerName, reqAmt, empSeq, empName, receiveEmpSeq, receiveEmpName, receiveEmpSuperKey ) */
			if (!map.containsKey("groupSeq") || CommonConvert.CommonGetStr(map.get("groupSeq")).equals("")) {
				param.setFail("parameter groupSeq is not exists..");
				return param;
			}
			else if (!map.containsKey("compSeq") || CommonConvert.CommonGetStr(map.get("compSeq")).equals("")) {
				param.setFail("parameter compSeq is not exists..");
				return param;
			}
			else if (!map.containsKey("syncId") || CommonConvert.CommonGetStr(map.get("syncId")).equals("")) {
				param.setFail("parameter syncId is not exists..");
				return param;
			}
			else if (!map.containsKey("cardNum") || CommonConvert.CommonGetStr(map.get("cardNum")).equals("")) {
				param.setFail("parameter cardNum is not exists..");
				return param;
			}
			else if (!map.containsKey("authNum") || CommonConvert.CommonGetStr(map.get("authNum")).equals("")) {
				param.setFail("parameter authNum is not exists..");
				return param;
			}
			else if (!map.containsKey("authDate") || CommonConvert.CommonGetStr(map.get("authDate")).equals("")) {
				param.setFail("parameter authDate is not exists..");
				return param;
			}
			else if (!map.containsKey("authTime")) {
				param.setFail("parameter authTime is not exists..");
				return param;
			}
			else if (!map.containsKey("partnerNo")) {
				param.setFail("parameter partnerNo is not exists..");
				return param;
			}
			else if (!map.containsKey("partnerName")) {
				param.setFail("parameter partnerName is not exists..");
				return param;
			}
			else if (!map.containsKey("reqAmt")) {
				param.setFail("parameter reqAmt is not exists..");
				return param;
			}
			else if (!map.containsKey("empSeq") || CommonConvert.CommonGetStr(map.get("empSeq")).equals("")) {
				param.setFail("parameter empSeq is not exists..");
				return param;
			}
			else if (!map.containsKey("empName") || CommonConvert.CommonGetStr(map.get("empName")).equals("")) {
				param.setFail("parameter empName is not exists..");
				return param;
			}
			else if (!map.containsKey("receiveEmpSeq") || CommonConvert.CommonGetStr(map.get("receiveEmpSeq")).equals("")) {
				param.setFail("parameter receiveEmpSeq is not exists..");
				return param;
			}
			else if (!map.containsKey("receiveEmpName") || CommonConvert.CommonGetStr(map.get("receiveEmpName")).equals("")) {
				param.setFail("parameter receiveEmpName is not exists..");
				return param;
			}
			else if (!map.containsKey("receiveEmpSuperKey") || CommonConvert.CommonGetStr(map.get("receiveEmpSuperKey")).equals("")) {
				param.setFail("parameter receiveEmpSuperKey is not exists..");
				return param;
			}
			else {
				param.setaData(dao.SetTransInsertItem(map).getaData());
				param.setSuccess();
			}
		}
		catch (Exception e) {
			param.setFail("FNpUserCardServiceImpl.SetTransInsertItem >> " + e.toString());
		}

		return param;
	}

	/* 카드 이관 항목 수정 */
	@SuppressWarnings("unused")
	private ResultVO SetTransUpdateItem(ResultVO param) throws Exception {
		/* MAP */
		Map<String, Object> map = GetMapBase(param);

		try {
			/* 필수 파라미터 점검 ( groupSeq, compSeq, syncId, empSeq, empName, receiveEmpSeq, receiveEmpName, receiveEmpSuperKey ) */
			if (!map.containsKey("groupSeq") || CommonConvert.CommonGetStr(map.get("groupSeq")).equals("")) {
				param.setFail("parameter groupSeq is not exists..");
				return param;
			}
			else if (!map.containsKey("compSeq") || CommonConvert.CommonGetStr(map.get("compSeq")).equals("")) {
				param.setFail("parameter compSeq is not exists..");
				return param;
			}
			else if (!map.containsKey("syncId") || CommonConvert.CommonGetStr(map.get("syncId")).equals("")) {
				param.setFail("parameter syncId is not exists..");
				return param;
			}
			else if (!map.containsKey("empSeq") || CommonConvert.CommonGetStr(map.get("empSeq")).equals("")) {
				param.setFail("parameter empSeq is not exists..");
				return param;
			}
			else if (!map.containsKey("empName") || CommonConvert.CommonGetStr(map.get("empName")).equals("")) {
				param.setFail("parameter empName is not exists..");
				return param;
			}
			else if (!map.containsKey("receiveEmpSeq") || CommonConvert.CommonGetStr(map.get("receiveEmpSeq")).equals("")) {
				param.setFail("parameter receiveEmpSeq is not exists..");
				return param;
			}
			else if (!map.containsKey("receiveEmpName") || CommonConvert.CommonGetStr(map.get("receiveEmpName")).equals("")) {
				param.setFail("parameter receiveEmpName is not exists..");
				return param;
			}
			else if (!map.containsKey("receiveEmpSuperKey") || CommonConvert.CommonGetStr(map.get("receiveEmpSuperKey")).equals("")) {
				param.setFail("parameter receiveEmpSuperKey is not exists..");
				return param;
			}
			else {
				param = dao.SetTransUpdateItem(map);
				param.setSuccess();
			}
		}
		catch (Exception e) {
			param.setFail("FNpUserCardServiceImpl.SetTransUpdateItem >> " + e.toString());
		}

		return param;
	}

	/* 카드 내역 사용 / 미사용 처리 ( 사용자 ) */
	public ResultVO SetCardUseYN(ResultVO param) throws Exception {
		/* VO */
		ResultVO result = new ResultVO();
		result = param;

		/* 카드 이관 항목 조회 */
		result = this.GetTransItem(result);
		if (result.getaData().containsKey("syncId") && !CommonConvert.CommonGetStr(result.getaData().get("syncId")).equals("")) {
			/* 카드 이관 항목 수정 */
			result = this.SetCardUseYNUpdate(result);
		}
		else {
			/* 카드 이관 항목 생성 */
			result = this.SetCardUseYNInsert(result);
		}

		return param;
	}

	private ResultVO SetCardUseYNUpdate(ResultVO param) throws Exception {
		/* MAP */
		Map<String, Object> map = GetMapBase(param);

		try {
			/* 필수 파라미터 점검 ( groupSeq, compSeq, syncId, empSeq, empName, receiveEmpSeq, receiveEmpName, receiveEmpSuperKey ) */
			if (!map.containsKey("groupSeq") || CommonConvert.CommonGetStr(map.get("groupSeq")).equals("")) {
				param.setFail("parameter groupSeq is not exists..");
				return param;
			}
			else if (!map.containsKey("compSeq") || CommonConvert.CommonGetStr(map.get("compSeq")).equals("")) {
				param.setFail("parameter compSeq is not exists..");
				return param;
			}
			else if (!map.containsKey("syncId") || CommonConvert.CommonGetStr(map.get("syncId")).equals("")) {
				param.setFail("parameter syncId is not exists..");
				return param;
			}
			else if (!map.containsKey("empSeq") || CommonConvert.CommonGetStr(map.get("empSeq")).equals("")) {
				param.setFail("parameter empSeq is not exists..");
				return param;
			}
			else if (!map.containsKey("useYN") || CommonConvert.CommonGetStr(map.get("useYN")).equals("")) {
				param.setFail("parameter useYN is not exists..");
				return param;
			}
			else {
				param = dao.SetCardUseYNUpdate(map);
				param.setSuccess();
			}
		}
		catch (Exception e) {
			param.setFail("FNpUserCardServiceImpl.SetCardUseYNUpdate >> " + e.toString());
		}

		return param;
	}

	private ResultVO SetCardUseYNInsert(ResultVO param) throws Exception {
		/* MAP */
		Map<String, Object> map = GetMapBase(param);

		try {
			/* 필수 파라미터 점검 ( compSeq, empSeq, syncId, cardNum, authNum, authDate, authTime, partnerNo, partnerName, reqAmt, useYN ) */
			if (!map.containsKey("groupSeq") || CommonConvert.CommonGetStr(map.get("groupSeq")).equals("")) {
				param.setFail("parameter groupSeq is not exists..");
				return param;
			}
			else if (!map.containsKey("compSeq") || CommonConvert.CommonGetStr(map.get("compSeq")).equals("")) {
				param.setFail("parameter compSeq is not exists..");
				return param;
			}
			else if (!map.containsKey("syncId") || CommonConvert.CommonGetStr(map.get("syncId")).equals("")) {
				param.setFail("parameter syncId is not exists..");
				return param;
			}
			else if (!map.containsKey("empSeq") || CommonConvert.CommonGetStr(map.get("empSeq")).equals("")) {
				param.setFail("parameter empSeq is not exists..");
				return param;
			}
			else if (!map.containsKey("useYN") || CommonConvert.CommonGetStr(map.get("useYN")).equals("")) {
				param.setFail("parameter useYN is not exists..");
				return param;
			}
			else if (!map.containsKey("cardNum") || CommonConvert.CommonGetStr(map.get("cardNum")).equals("")) {
				param.setFail("parameter cardNum is not exists..");
				return param;
			}
			else if (!map.containsKey("authNum") || CommonConvert.CommonGetStr(map.get("authNum")).equals("")) {
				param.setFail("parameter authNum is not exists..");
				return param;
			}
			else if (!map.containsKey("reqAmt") || CommonConvert.CommonGetStr(map.get("reqAmt")).equals("")) {
				param.setFail("parameter reqAmt is not exists..");
				return param;
			}
			else if (!map.containsKey("authDate") || CommonConvert.CommonGetStr(map.get("authDate")).equals("")) {
				param.setFail("parameter authDate is not exists..");
				return param;
			}
			else if (!map.containsKey("authTime")) {
				param.setFail("parameter authTime is not exists..");
				return param;
			}
			else if (!map.containsKey("partnerNo")) {
				param.setFail("parameter partnerNo is not exists..");
				return param;
			}
			else if (!map.containsKey("partnerName")) {
				param.setFail("parameter partnerName is not exists..");
				return param;
			}
			else {
				param = dao.SetCardUseYNInsert(map);
				param.setSuccess();
			}
		}
		catch (Exception e) {
			param.setFail("FNpUserCardServiceImpl.SetCardUseYNInsert >> " + e.toString());
		}

		return param;
	}

	/* 카드사용내역 이관 목록 조회 */
	public ResultVO GetCardTransHistoryList(ResultVO param) throws Exception {
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
				param = dao.GetCardTransHistoryListSelect(map);
				param.setSuccess();
			}
		}
		catch (Exception e) {
			param.setFail("FNpUserCardServiceImpl.GetCardTransHistoryList >> " + e.toString());
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

	@Override
	public ResultVO GetCardList2 ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );

		/* 전체 카드 사용내역 조회 */
		ResultVO cardListResult = dao.GetCardList2FullList( params );
		return cardListResult;
//		if(cardListResult.getResultCode( ).equals( commonCode.FAIL )){
//			return cardListResult;
//		}
//		List<Map<String, Object>> cardList = cardListResult.getAaData( );
//
//		/* 카드 사용내역 히스토리 조회 */
//		ResultVO cardHistory = dao.GetCardList2History( params );
//		if(cardHistory.getResultCode( ).equals( commonCode.FAIL )){
//			return cardHistory;
//		}
//		List<Map<String, Object>> cardHistoryList = cardHistory.getAaData( );
//
//		/* 카드 권한 리스트 조회 */
//		ResultVO cardAuthResult = dao.GetCardList2Auth(params);
//		if(cardHistory.getResultCode( ).equals( commonCode.FAIL )){
//			return cardAuthResult;
//		}
//		String cardAuth = CommonConvert.NullToString( cardAuthResult.getaData( ).get( "cardNum" ) );
//
//		/* [p0] 전자결재 결의상신 리스트 */
//		String approList = CommonConvert.NullToString( cardHistoryList.get( 0 ).get( "superKeys" ) );
//		/* [p1] 미사용 처리 리스트 */
//		String notUseList = CommonConvert.NullToString( cardHistoryList.get( 1 ).get( "superKeys" ) );
//		/* [p2] 수신 처리 리스트 */
//		String receiveList = CommonConvert.NullToString( cardHistoryList.get( 2 ).get( "superKeys" ) );
//		/* [p3] 이관 처리 리스트 */
//		String transferList = CommonConvert.NullToString( cardHistoryList.get( 3 ).get( "superKeys" ) );
//		/* [p4] 현재 작성중인 카드사용내역 처리 */
//		String writingList = CommonConvert.NullToString( cardHistoryList.get( 4 ).get( "superKeys" ) );
//
//		/* [3] 카드승인내역 필터링 진행 */
//		List<Map<String, Object>> filterdList = new ArrayList();
//		for( Map<String, Object> item : cardList ){
//			String cardNum = CommonConvert.NullToString( item.get( "cardNum" ) );
//			String syncId =  CommonConvert.NullToString( item.get( "syncId" ) );
//			String regex = "■" + syncId + "Σ" + "[\\S\\s]+" + "Σ" + "[\\S\\s]+"+ "Σ" + "[\\S\\s]+" + "Σ" + "[\\S\\s]+" + "Σ" + "[\\S\\s]+" + "■$";
//
//			Pattern p = Pattern.compile( regex );
//			Matcher m = p.matcher( approList );
//
//			while ( m.find( ) ) {
//				String superKey = m.group( ).split("■")[1];
//				item.put( "approYN", "Y" );
//				item.put( "approYn", "Y" );
//				item.put( "appro_yn", "Y" );
//				item.put( "sendYN", "Y" );
//				item.put( "sendYn", "Y" );
//				item.put( "send_yn", "Y" );
//
//				String docSeq = "";
//				String sendEmpName = "";
//				String docNo = "";
//				String docTitle = "";
//				String docStatus = "";
//
//				try{
//					docSeq = superKey.split( "Σ" )[1].replace( "■", "" );
//					sendEmpName = superKey.split( "Σ" )[2].replace( "■", "" );
//					docNo = superKey.split( "Σ" )[3].replace( "■", "" );
//					docTitle = superKey.split( "Σ" )[4].replace( "■", "" );
//				}catch(Exception ex){
//					System.out.println( superKey );
//					ex.printStackTrace( );
//				}
//
//				item.put("docSeq", docSeq);
//				item.put("sendEmpName", sendEmpName);
//				item.put("docNo", docNo);
//				item.put("docTitle", docTitle);
//
//				try{
//					docStatus = superKey.split( "Σ" )[5].replace( "■", "" );
//				}catch(Exception ex){
//					System.out.println( superKey );
//					ex.printStackTrace( );
//				}
//				switch (docStatus){
//					case "10" :
//					case "001" :
//						item.put("docStatus", "임시보관");
//						break;
//					case "20" :
//					case "002" :
//					case "003" :
//					case "004" :
//						item.put("docStatus", "진행중");
//						break;
//					case "005" :
//						item.put("docStatus", "회수");
//						break;
//					case "100" :
//					case "007" :
//						item.put("docStatus", "반려");
//						break;
//					case "90" :
//					case "008" :
//						item.put("docStatus", "종결");
//						break;
//					case "999" :
//					case "d" :
//						item.put("docStatus", "삭제");
//						break;
//				}
//			}
//
//			regex = syncId + "Σ" + "[\\S\\s]+" + "■$";
//			m = p.matcher( notUseList );
//			while ( m.find( ) ) {
//				String superKey = m.group( ).split("■")[0];
//				item.put("useYn", "N");
//				item.put("useYN", "N");
//				item.put("use_yn", "N");
//				item.put("notUseEmpName", superKey.split( "Σ" )[1].replace( "■", "" ));
//			}
//
//			regex = syncId + "Σ";
//			if(writingList.indexOf( regex ) > -1){
//				item.put("writingYn", "Y");
//			}
//
//			regex = syncId + "Σ" + "[\\S\\s]+" + "■$";
//			m = p.matcher( receiveList );
//			boolean catchem = false;
//			while ( m.find( ) ) {
//				String superKey = m.group( ).split("■")[0];
//				item.put("receiveYn", "Y");
//				item.put("receiveYN", "Y");
//				item.put("receive_yn", "Y");
//				item.put("transferEmpName", superKey.split( "Σ" )[1].replace( "■", "" ));
//				filterdList.add( item );
//				catchem = true;
//			}
//			if(catchem){
//				continue;
//			}
//
//			regex = syncId + "Σ" + "[\\S\\s]+" + "■$";
//			m = p.matcher( transferList );
//			while ( m.find( ) ) {
//				String superKey = m.group( ).split("■")[0];
//				item.put("transferYn", "Y");
//				item.put("transferYN", "Y");
//				item.put("transfer_yn", "Y");
//				item.put("receiveEmpName", superKey.split( "Σ" )[1].replace( "■", "" ));
//			}
//
//			if(cardAuth.indexOf( cardNum ) > -1){
//				filterdList.add( item );
//				continue;
//			}
//		}
//
//		/* [5] 데이터 반환 */
//		result.setAaData( filterdList );
//		result.setSuccess( );
//		return result;
	}
}
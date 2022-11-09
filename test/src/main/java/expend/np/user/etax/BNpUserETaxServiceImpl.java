package expend.np.user.etax;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;

@Service("BNpUserETaxService")
public class BNpUserETaxServiceImpl implements BNpUserETaxService {

	@Resource(name = "CommonInfo")
	private CommonInfo			cmInfo;
	@Resource(name = "CommonLogger")
	private final CommonLogger		cmLog	= new CommonLogger();
	@Resource(name = "FNpUserETaxServiceA")
	private FNpUserETaxService	servicesA;
	@Resource(name = "FNpUserETaxServiceI")
	private FNpUserETaxService	servicesI;
	@Resource(name = "FNpUserETaxServiceU")
	private FNpUserETaxService	servicesU;

	public ResultVO SelectETaxList(ResultVO param, ConnectionVO conVo) throws Exception {
		/* VO */
		ResultVO result = new ResultVO();

		/* IMPL */
		FNpUserETaxService impl = null;

		/* LIST */
		List<Map<String, Object>> eTaxAuthList = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> eTaxSendList = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> eTaxNotUseList = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> eTaxTransList = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> eTaxReceiveList = new ArrayList<Map<String, Object>>();

		/* STRING */
		String mailAuth = "", partnerAuth = "";

		switch (conVo.getErpTypeCode()) {
			case commonCode.ICUBE:
				impl = servicesI;
				break;
			case commonCode.ERPIU:
				impl = servicesU;
				break;
			default:
				throw new Exception("ERP 연결설정 확인 필요");
		}

		/* 사용자 권한 목록 조회 */
		eTaxAuthList = servicesA.GetETaxAuthList(param).getAaData();
		eTaxAuthList = (eTaxAuthList == null ? new ArrayList<Map<String, Object>>() : eTaxAuthList);

		for (Map<String, Object> map : eTaxAuthList) {
			if (map.containsKey("authType")) {
				if (CommonConvert.CommonGetStr(map.get("authType")).equals("P")) {
					partnerAuth += ((partnerAuth.indexOf("|") >= 0) ? (CommonConvert.CommonGetStr(map.get("code")) + "|") : ("|" + CommonConvert.CommonGetStr(map.get("code")) + "|"));
				}
				else if (CommonConvert.CommonGetStr(map.get("authType")).equals("E")) {
					mailAuth += ((mailAuth.indexOf("|") >= 0) ? (CommonConvert.CommonGetStr(map.get("code")) + "|") : ("|" + CommonConvert.CommonGetStr(map.get("code")) + "|"));
				}
			}
		}

		param.getParams().put("mailAuth", mailAuth);
		param.getParams().put("partnerAuth", partnerAuth);
		param.getParams().put("id", param.getId());

		/* 상신 목록 조회 */
		eTaxSendList = servicesA.GetETaxSendList(param).getAaData();
		eTaxSendList = (eTaxSendList == null ? new ArrayList<Map<String, Object>>() : eTaxSendList);
		// param.getParams().put("eTaxSendList", eTaxSendList);

		/* 미사용 목록 조회 */
		eTaxNotUseList = servicesA.GetETaxNotUseList(param).getAaData();
		eTaxNotUseList = (eTaxNotUseList == null ? new ArrayList<Map<String, Object>>() : eTaxNotUseList);
		// param.getParams().put("eTaxNotUseList", eTaxNotUseList);

		/* 이관 목록 조회 */
		eTaxTransList = servicesA.GetETaxTransList(param).getAaData();
		eTaxTransList = (eTaxTransList == null ? new ArrayList<Map<String, Object>>() : eTaxTransList);
		// param.getParams().put("eTaxTransList", eTaxReceiveList);

		/* 수신 목록 조회 */
		eTaxReceiveList = servicesA.GetETaxReceiveList(param).getAaData();
		eTaxReceiveList = (eTaxReceiveList == null ? new ArrayList<Map<String, Object>>() : eTaxReceiveList);
		param.getParams().put("eTaxReceiveList", eTaxReceiveList);


		/* +++++++++로직 변경+++++++++ */
		// 1. 상신 목록
		param.getParams().put("eTaxSendList", new ArrayList<Map<String, Object>>());
		// 2. 미사용 목록
		param.getParams().put("eTaxNotUseList", new ArrayList<Map<String, Object>>());
		// 3. 이관 목록
		param.getParams().put("eTaxTransList", new ArrayList<Map<String, Object>>());
		// 4. 수신 목록
		// param.getParams().put("eTaxReceiveList", new ArrayList<Map<String, Object>>());

		/* 매입전자세금계산서 조회 */
		ResultVO erpEtaxResult = impl.GetETaxApprovalList(param, conVo);

		/* 모든 목록 map객체로 전환 */
		HashMap<String, Object> eTaxSendMap = new HashMap<>();
		for(Map<String, Object> item : eTaxSendList ){
			eTaxSendMap.put( item.get( "issNo" ).toString( ), item );
		}

		HashMap<String, Object> eTaxNotUseMap = new HashMap<>();
		for(Map<String, Object> item : eTaxNotUseList ){
			eTaxSendMap.put( item.get( "iss_no" ).toString( ), item );
		}

		HashMap<String, Object> eTaxTransMap = new HashMap<>();
		for(Map<String, Object> item : eTaxTransList ){
			eTaxSendMap.put( item.get( "issNo" ).toString( ), item );
		}

//		HashMap<String, Object> eTaxSendMap = new HashMap<>();
//		for(Map<String, Object> item : eTaxReceiveList ){
//			eTaxSendMap.put( item.get( "issDt" ).toString( ), item );
//		}

		if(erpEtaxResult.getResultCode( ).equals( commonCode.SUCCESS )){
			List<Map<String, Object>> etaxList = erpEtaxResult.getAaData( );
			List<Map<String, Object>> aaData = new ArrayList<Map<String, Object>>();
			for(Map<String, Object> item : etaxList ){
				if( eTaxSendMap.containsKey( item.get( "issNo" ).toString( ) )){
					continue;
				}
				if( eTaxNotUseMap.containsKey( item.get( "issNo" ).toString( ) )){
					continue;
				}
				if( eTaxTransMap.containsKey( item.get( "issNo" ).toString( ) )){
					continue;
				}
				aaData.add( item );
			}
			param.setAaData( aaData );
		}

		return param;
	}

	/* 반영된 세금계산서 번호 조회 */
	public ResultVO SelectSendETaxList(Map<String, Object> param) throws Exception {
		ResultVO result = new ResultVO();
		param.put(commonCode.EMPSEQ, CommonConvert.CommonGetEmpVO().getUniqId());
		param.put(commonCode.COMPSEQ, CommonConvert.CommonGetEmpVO().getCompSeq());
		result.setAaData(servicesA.selectETaxSendList(param));
		return result;
	}

	/* 세금계산서 반영 */
	public ResultVO NpUserETaxReflect(Map<String, Object> param) throws Exception {
		ResultVO result = new ResultVO();
		result = servicesA.NpUserETaxReflect(param);
		return result;
	}

	public ResultVO GetETaxTransHistoryList(ResultVO param) throws Exception {
		/* VO */
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		ResultVO temp = new ResultVO();

		/* 카드사용내역 이관 목록 조회 */
		param = servicesA.GetETaxTransHistoryList(param);
		return param;
	}

	/* ## ############################################# ## */
	/*	매입전자세금계산서 현황 및 기능 2차 구현 - 최상배 */
	/* ## ############################################# ## */
	public ResultVO GetETaxList(ResultVO param, ConnectionVO conVo) throws Exception {

		/**
		 * 	이 메소드를 수정하기 전 반드시 확인 할 것. *
		 *
		 * 	기본 로직 구성
		 * 		1. ERP 세금계산서 전체 조회
		 * 		2. GW상신 목록 필터링
		 * 		3. GW미사용 처리 목록 필터링
		 * 		4. 품의/결의 기본설정 옵션에 의한 필터링 (세금계산서 조회 권한 구분)
		 * 		5. 사용자 권한별 필터링 (거래처 별, 수신 메일 별)
		 *
		 * 	영향 받는 메뉴
		 * 		1. 사용자 세금계산서 현황 G20
		 * 		2. 사용자 세금계산서 현황 iU
		 * 		3. 관리자 세금계산서 현황 G20
		 * 		4. 관리자 세금계산서 현황 iU
		 * 		5. 사용자 지출결의 작성 -매입전자세금계산서 팝업
		 *
		 * 	메소드 수정시 상기 메뉴 사이드 이펙트 여부를 반드시 확인할 것.
		 * ===============================================================================*/

		/* local variable */
		ResultVO result = new ResultVO();
		FNpUserETaxService impl = null;

		switch (conVo.getErpTypeCode()) {
			case commonCode.BIZBOXA:
				impl = servicesA;
				break;
			case commonCode.ICUBE:
				impl = servicesI;
				break;
			case commonCode.ERPIU:
				impl = servicesU;
				break;
			default:
				throw new Exception("ERP 연결설정 확인 필요");
		}

		/* [1] 세금계산서 전체 데이터 조회
		 * 	ERP의 전체 사용내역에 대해서 조회합니다.
		 * */
		ResultVO etaxResult = impl.GetETaxList(param, conVo);
		if(etaxResult.getResultCode( ).equals( commonCode.FAIL )){
			return etaxResult;
		}
		List<Map<String, Object>> etaxList = etaxResult.getAaData( );

		/* [2] 	세금계산서 사용 이력 정보 전체 조회
		 * 	aData  : 사용자 권한 정보 조회 0 : 권한별 조회 / 1 : 권한무시 전체 조회
		 *  aaData :
		 *  	0 : 매입전자 세금계산서 상신 정보
		 *  	1 : 미사용 지정 정보
		 *  	2 : 사용자 권한 정보 - 수신 메일 별
		 *  	3 : 사용자 권한 정보 - 거래처 정보 별
		 *  	4 : 이관 받은 내역 정보
		 *  	5 : 이관 보낸 내역 정보
		 *  	6 : 현재 결의서에 반영된 내역 정보(결의서 작성시)
		 *  */
		ResultVO historyResult = servicesA.GetETaxHistory(param);
		if(historyResult.getResultCode( ).equals( commonCode.FAIL )){
			return historyResult;
		}


		/* [3-1] 세금계산서 필터링 권한 별 */
		List<Map<String, Object>> eTaxHistoryList = historyResult.getAaData();
		String etaxAuthOptionCode = CommonConvert.NullToString( historyResult.getaData( ).get( "optionValue" ) );
		List<Map<String, Object>> authFilterdList = new ArrayList();

		/* [p0] 전자결재 결의상신 리스트 */
		String approList = CommonConvert.NullToString( eTaxHistoryList.get( 0 ).get( "superKeys" ) );
		/* [p1] 사용자 미사용 지정 리스트 */
		String notUseList = CommonConvert.NullToString( eTaxHistoryList.get( 1 ).get( "superKeys" ) );
		/* [p2] 이메일 조회 권한 */
		String authEmailList = CommonConvert.NullToString( eTaxHistoryList.get( 2 ).get( "superKeys" ) );
		/* [p3] 거래처 조회 권한 */
		String authPartnerList = CommonConvert.NullToString( eTaxHistoryList.get( 3 ).get( "superKeys" ) );
		/* [p4] 수신 세금계산서 리스트 */
		String receiveList = CommonConvert.NullToString( eTaxHistoryList.get( 4 ).get( "superKeys" ) );
		/* [p5] 발신 세금계산서 리스트 */
		String transferList = CommonConvert.NullToString( eTaxHistoryList.get( 5 ).get( "superKeys" ) );
		/* [p6] 현재 작성중인 리스트 */
		String writingList = CommonConvert.NullToString( eTaxHistoryList.get( 6 ).get( "superKeys" ) );

		for(Map<String, Object> item : etaxList){

			/** local variable **/
			String issDt = CommonConvert.NullToString( item.get( "issDt" ) );
			String issNo = CommonConvert.NullToString( item.get( "issNo" ) );
			String issNo2 = CommonConvert.NullToString( item.get( "issNo2" ) );
			String trChargeEMail = CommonConvert.NullToString( item.get( "trChargeEMail" ) );
			String trRegNb = CommonConvert.NullToString( item.get( "trRegNb" ) );
			String regex = "";
			Pattern p = null;
			Matcher m = null;

			/* 결의 상신 내역 처리 */
			regex = issDt + "Σ" + issNo + "Σ" + "[\\S\\s]+" + "■$";
			p = Pattern.compile( regex );
			m = p.matcher( approList );
			boolean catchem2 = false;

			while ( m.find( ) ) {
				String superKey = m.group( ).split("■")[0];
				item.put( "approYN", "Y" );
				item.put( "approYn", "Y" );
				item.put( "appro_yn", "Y" );
				item.put( "sendYN", "Y" );
				item.put( "sendYn", "Y" );
				item.put( "send_yn", "Y" );
				item.put("approEmpName", superKey.split( "Σ" )[2].replace( "■", "" ));
				item.put("createEmpName", superKey.split( "Σ" )[2].replace( "■", "" ));
				catchem2 = true;
			}

			if( !issNo2.equals( "" ) && (!catchem2)){
				// regex 원본
				// regex = issDt + "Σ" + "[\\S\\s]+" + issNo2 + "■$";
				regex = issDt + "Σ" + "[\\S\\s]+" + issNo2 + "■";
				p = Pattern.compile( regex );
				m = p.matcher( approList );
				while ( m.find( ) ) {
					String superKey = m.group( ).split("■")[0];
					item.put( "approYN", "Y" );
					item.put( "approYn", "Y" );
					item.put( "appro_yn", "Y" );
					item.put( "sendYN", "Y" );
					item.put( "sendYn", "Y" );
					item.put( "send_yn", "Y" );
					item.put("approEmpName", superKey.split( "Σ" )[2].replace( "■", "" ));
					item.put("createEmpName", superKey.split( "Σ" )[2].replace( "■", "" ));
				}
			}

			/* 현재 작성중인 결의서 처리 */
			regex = issDt + "Σ" + issNo + "Σ" + issNo2 + "■";
			if( writingList.indexOf( regex ) > -1){
				item.put( "writingYN", "Y" );
				item.put( "writingYn", "Y" );
				item.put( "writing_yn", "Y" );
			}

			/* 미사용 내역 처리 */
			regex = issDt + "Σ" + issNo + "Σ" + "[\\S\\s]+" + "■$";
			p = Pattern.compile( regex );
			m = p.matcher( notUseList );
			while ( m.find( ) ) {
				String superKey = m.group( ).split("■")[0];
				item.put( "useYN", "N" );
				item.put( "use_yn", "N" );
				item.put( "useYn", "N" );
				item.put("notUseEmpName", superKey.split( "Σ" )[2].replace( "■", "" ));
			}

			if( !issNo2.equals( "" )){
				regex = issDt + "Σ" + "[\\S\\s]+" + issNo2 + "■";
				p = Pattern.compile( regex );
				m = p.matcher( notUseList );
				while ( m.find( ) ) {
					String superKey = m.group( ).split("■")[0];
					item.put( "useYN", "N" );
					item.put( "use_yn", "N" );
					item.put( "useYn", "N" );
					item.put("notUseEmpName", superKey.split( "Σ" )[2].replace( "■", "" ));
				}
			}
			/* 발신 내역 처리 */
			regex = issDt + "Σ" + issNo + "Σ" + "[\\S\\s]+" + "■$";
			p = Pattern.compile( regex );
			m = p.matcher( transferList );
			while ( m.find( ) ) {
				String superKey = m.group( ).split("■")[0];
				item.put( "transferYN", "Y" );
				item.put( "transferYn", "Y" );
				item.put( "transfer_yn", "Y" );
				item.put("receiveEmpName", superKey.split( "Σ" )[2].replace( "■", "" ));
			}

			if(!issNo2.equals( "" )){
				regex = issDt + "Σ" + "[\\S\\s]+" + issNo2 + "■";
				p = Pattern.compile( regex );
				m = p.matcher( transferList );
				while ( m.find( ) ) {
					String superKey = m.group( ).split("■")[0];
					item.put( "transferYN", "Y" );
					item.put( "transferYn", "Y" );
					item.put( "transfer_yn", "Y" );
					item.put("receiveEmpName", superKey.split( "Σ" )[2].replace( "■", "" ));
				}
			}


			/* 수신 내역 처리 */
			regex = issDt + "Σ" + issNo + "Σ" + "[\\S\\s]+" + "■$";
			p = Pattern.compile( regex );
			m = p.matcher( receiveList );
			boolean catchem = false;
			while ( m.find( ) ) {
				String superKey = m.group( ).split("■")[0];
				item.put( "receiveYN", "Y" );
				item.put( "receiveYn", "Y" );
				item.put( "receive_yn", "Y" );
				item.put("transferEmpName", superKey.split( "Σ" )[2].replace( "■", "" ));
				authFilterdList.add( item );
				catchem = true;
			}

			if( (!issNo2.equals( "" )) && (!catchem) ){
				regex = issDt + "Σ" + "[\\S\\s]+" + issNo2 + "■";
				p = Pattern.compile( regex );
				m = p.matcher( receiveList );
				while ( m.find( ) ) {
					String superKey = m.group( ).split("■")[0];
					item.put( "receiveYN", "Y" );
					item.put( "receiveYn", "Y" );
					item.put( "receive_yn", "Y" );
					item.put("transferEmpName", superKey.split( "Σ" )[2].replace( "■", "" ));
					authFilterdList.add( item );
					catchem = true;
				}
			}
			if(catchem){
				continue;
			}

			/* 본인계정 권한 확인 */
			String userMail = param.getId( ) + "@";
			if(trChargeEMail.indexOf( userMail ) == 0){
				authFilterdList.add( item );
				continue;
			}

			/* 이메일 조회 권한 확인 */
			regex = "Σ" + trChargeEMail + "■";
			if(authEmailList.indexOf( regex ) > -1){
				authFilterdList.add( item );
				continue;
			}

			/* 거래처 조회 권한 확인*/
			regex = "Σ" + trRegNb + "■";
			if(authPartnerList.indexOf( regex ) > -1){
				authFilterdList.add( item );
				continue;
			}

			if( etaxAuthOptionCode.equals( "1" ) ){
				/* 전체 권한 옵션 사용시 데이터 복사 */
				authFilterdList.add( item );
			}
		}
		param.setAaData( authFilterdList );
		return param;
	}
}
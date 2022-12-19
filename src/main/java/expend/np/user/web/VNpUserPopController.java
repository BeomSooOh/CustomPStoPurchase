package expend.np.user.web;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.exception.CheckDocSettingException;
import common.helper.exception.CheckICUBEG20TypeException;
import common.helper.exception.NotFoundConnectionException;
import common.helper.exception.NotFoundERPEmpCdException;
import common.helper.exception.NotFoundLoginSessionException;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.procedure.npG20.BCommonProcService;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.CommonMapInterface.commonExPath;
import common.vo.common.CommonMapInterface.commonTripPath;
import common.vo.common.ConnectionVO;
import common.vo.common.CustomLabelVO;
import common.vo.common.ResultVO;
import expend.np.user.code.BNpUserCodeService;
import expend.np.user.cons.BNpUserConsService;
import expend.np.user.option.BNpUserOptionService;
import expend.np.user.report.BNpUserReportService;
import expend.np.user.res.BNpUserResService;
import expend.np.user.reuse.BNpUserReUseServiceImpl;
import net.sf.json.JSONArray;
import purchase.service.ContractServiceDAO;


@Controller
public class VNpUserPopController {

	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo;
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );
	@Resource ( name = "BNpUserOptionService" )
	private BNpUserOptionService serviceOption; /* Expend Service */
	@Resource ( name = "BNpUserCodeService" )
	private BNpUserCodeService codeService;
	@Resource ( name = "BCommonProcService" )
	private BCommonProcService procService;
	@Resource ( name = "BNpUserConsService" )
	private BNpUserConsService consService; /* 품의서 정보 관리 */
	@Resource ( name = "BNpUserResService" )
	private BNpUserResService resService; /* 결의서 정보 관리 */
	@Resource ( name = "BNpUserReportService" )
	private BNpUserReportService reportService;
	@Resource ( name = "BNpUserReUseService" )
	private BNpUserReUseServiceImpl reUseService;
    @Resource(name = "ContractServiceDAO")
    private ContractServiceDAO contractServiceDAO;    	 	

	private Map<String, Object> getPublicLoginVo (LoginVO loginVo){
		Map<String, Object> returnObj = new HashMap<>( );
		if(loginVo == null){
			return returnObj;
		}

		returnObj.put( "bizSeq", loginVo.getBizSeq( ) );
		returnObj.put( "classNm", loginVo.getClassNm( ) );
		returnObj.put( "classCode", loginVo.getClassCode( ) );
		returnObj.put( "authorCode", loginVo.getAuthorCode( ) );
		returnObj.put( "compSeq", loginVo.getCompSeq( ) );
		returnObj.put( "deptSeq", loginVo.getOrganId( ) );
		returnObj.put( "eaType", loginVo.getEaType( ) );
		returnObj.put( "erpCoCd", loginVo.getErpCoCd( ) );
		returnObj.put( "erpEmpCd", loginVo.getErpEmpCd( ) );
		returnObj.put( "groupSeq", loginVo.getGroupSeq( ) );
		returnObj.put( "langCode", loginVo.getLangCode( ) );
		returnObj.put( "name", loginVo.getName( ) );
		returnObj.put( "organId", loginVo.getOrganId( ) );
		returnObj.put( "organNm", loginVo.getOrganNm( ) );
		returnObj.put( "orgnztId", loginVo.getOrgnztId( ) );
		returnObj.put( "orgnztNm", loginVo.getOrgnztNm( ) );
		returnObj.put( "positionCode", loginVo.getPositionCode( ) );
		returnObj.put( "positionNm", loginVo.getPositionNm( ) );
		returnObj.put( "empSeq", loginVo.getUniqId( ) );
		returnObj.put( "uniqId", loginVo.getUniqId( ) );

		return returnObj;
	}

	/**
	 * Pop View
	 * 비영리 품의/결의서 테스트 팝업
	 */
	@RequestMapping ( "/expend/np/user/NpUserCRDocPop.do" )
	public ModelAndView NpUserCRDocPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/NpUserCRDocPop.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );

		ResultVO result = null;
		try {
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			/* [예외 검증] ERP 연결정보 조회 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			/* [예외 검증] ERP 연동 확인 */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP 연동 설정을 확인하세요." );
			}
			/* [예외 검증] ERP 타입 확인 / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 설정확인이 필요함." );
			}
			/* [예외 검증] ERP 사번 매핑 확인 */
			if ( loginVo.getErpEmpCd( ) == null || loginVo.getErpEmpCd( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP 사번 매핑이 진행되지 않음." );
			}

			/* interface 연동 파라미터 확인 */
			if (!params.containsKey("outProcessInterfaceId")) { params.put("outProcessInterfaceId", ""); }
			mv.addObject("outProcessInterfaceId", params.get("outProcessInterfaceId"));
			if (!params.containsKey("outProcessInterfaceMId")) { params.put("outProcessInterfaceMId", ""); }
			mv.addObject("outProcessInterfaceMId", params.get("outProcessInterfaceMId"));
			if (!params.containsKey("outProcessInterfaceDId")) { params.put("outProcessInterfaceDId", ""); }
			mv.addObject("outProcessInterfaceDId", params.get("outProcessInterfaceDId"));
			/* 파라미터 재정의 */
			params.put( "compSeq", loginVo.getCompSeq( ) );
			params.put( "erpCompSeq", conVo.getErpCompSeq( ) );

			/* 외부 데이터 연동 코드 확인
			 * 외부(2차) 데이터 연동 팝업인 경우 전자결재 양식 기본 값으로 조회
			 * */
			ArrayList<Map<String, Object>> eaFormInfo = new ArrayList<>( );
			if( CommonConvert.NullToString( params.get( "EXNPInterlockAPI" ) ).equals( "1" ) ){
				String erpGbn = "";
				if(conVo.getErpTypeCode( ).equals( commonCode.ICUBE )){
					erpGbn = "I";
				}else if(conVo.getErpTypeCode( ).equals( commonCode.ERPIU )){
					erpGbn = "U";
				}else{
					erpGbn = "ETC";
				}

				Map<String, Object> item = new HashMap<>( );
				item.put( "formDTp", "EXNP" +  CommonConvert.NullToString( params.get( "EXNPInterlockFormDTP" ) ) + erpGbn );
				item.put( "formDTp2","EXNP" +  CommonConvert.NullToString( params.get( "EXNPInterlockFormDTP2" ) ) + erpGbn );
				eaFormInfo.add( item );
				params.put( "formDTp", CommonConvert.NullToString( params.get( "EXNPInterlockFormDTP" ) ) + erpGbn );
				params.put( "formDTp2", CommonConvert.NullToString( params.get( "EXNPInterlockFormDTP2" ) ) + erpGbn );
				mv.addObject("EXNPInterlockAPI", "TRIP" + CommonConvert.NullToString( params.get( "EXNPInterlockFormDTP" )  ) );
				//mv.addObject( "tripDocSeq", CommonConvert.NullToString( params.get( "tripDocSeq" ) ) );
				mv.addObject( "tripDoBizboxA.CustcSeq", CommonConvert.NullToString( params.get( "tripDocSeq" ) ) );
			}
			else{
				/* 사용자 기본 옵션 조회 - 전자결재 양식 정보 */
				eaFormInfo = (ArrayList<Map<String, Object>>) serviceOption.selectEaBaseData( params, conVo ).getAaData( );
			}
			mv.addObject( "eaBaseInfo", CommonConvert.CommonGetListMapToJson( eaFormInfo ) );
			if ( eaFormInfo.get( 0 ) != null ) {
				if ( eaFormInfo.get( 0 ).get( "formDTp" ).toString( ).indexOf( "EXNPCON" ) > -1 ) {
					params.put( "formDTp", "CON" );
				}
				else if ( eaFormInfo.get( 0 ).get( "formDTp" ).toString( ).indexOf( "EXNPRES" ) > -1 ) {
					params.put( "formDTp", "RES" );
				}
				if ( eaFormInfo.get( 0 ).get( "formDTp" ).toString( ).indexOf( "TRIPCONS" ) > -1 ) {
					params.put( "formDTp", "TRIPCON" );
				}
				else if ( eaFormInfo.get( 0 ).get( "formDTp" ).toString( ).indexOf( "TRIPRES" ) > -1 ) {
					params.put( "formDTp", "TRIPRES" );
				}
			}

			/* 사용자 기본 옵션 조회 - ERP 커넥션 정보 */
			Map<String, Object> conInfoTemp = CommonConvert.CommonGetObjectToMap( conVo );
			Map<String, Object> conInfo = new HashMap<>( );
			conInfo.put( "erpCompName", conInfoTemp.get( "erpCompName" ).toString( ) );
			conInfo.put( "erpCompSeq", conInfoTemp.get( "erpCompSeq" ).toString( ) );
			conInfo.put( "erpTypeCode", conInfoTemp.get( "erpTypeCode" ).toString( ) );
			conInfo.put( "g20YN", conInfoTemp.get( "g20YN" ).toString( ) );
			mv.addObject( "conVo", CommonConvert.CommonGetMapToJSONObj( conInfo ) );
			/* 명칭설정 기능 정의 */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/* 사용자 기본 옵션 조회 - 로그인 정보 조회 */
			mv.addObject( "loginVo", CommonConvert.CommonGetMapToJSONObj( getPublicLoginVo(loginVo) ) );
			/* 사용자 기본 옵션 조회 - ERP 옵션 정보 조회 */
			if(conVo.getErpTypeCode().equals("ERPiU")){
				List<Map<String, Object>> erpOption = new ArrayList<Map<String, Object>>();
				erpOption = serviceOption.selectERPOption( params, conVo ).getAaData( );
				JSONArray jr = new JSONArray();
				for (Map<String, Object> map : erpOption) {
					jr.add(CommonConvert.CommonGetMapToJSONObj(map));
				}
				mv.addObject("erp_optionSet", jr);
			} else {
				mv.addObject( "erp_optionSet", CommonConvert.CommonGetListMapToJson( serviceOption.selectERPOption( params, conVo ).getAaData( ) ) );
			}
			/* 사용자 기본 옵션 조회 - GW 옵션 정보 조회 */
			ResultVO gwOption = serviceOption.selectGWOption( params, conVo );
			if(!gwOption.getResultCode( ).equals( commonCode.SUCCESS )){
				throw new Exception(gwOption.getResultName( ));
			}
			/* 사용자 기본 옵션 조회 - GW 기본설정 정보  */
			mv.addObject( "gw_optionSet", CommonConvert.CommonGetListMapToJson( gwOption.getAaData( ) ) );
			/* 사용자 기본 옵션 조회 - GW 커스터마이징 정보  */
			mv.addObject( "gw_customOptionSet", CommonConvert.CommonGetMapToJSONStr( gwOption.getaData( ) ) );
			/* 사용자 기본 옵션 조회 - GW 커스터마이징 코드 등록 */
			if(!gwOption.getaData( ).isEmpty( )){
				String code = gwOption.getaData( ).get( "commonCode" ).toString( );
				String [] options = code.split( "\\|" );
				for(String option : options){
					if(option.indexOf( "EXNP_CUST_" ) > -1){
						mv.addObject( option, true);
					}
				}
			}

			/* 사용자 기본 옵션 조회 - ERP 기본정보 조회 */
			mv.addObject( "erpBaseInfo", CommonConvert.CommonGetListMapToJson( serviceOption.selectERPBaseData( params, conVo ).getAaData( ) ) );
			/* 결의서 기본 옵션 조회 - ERP 기본정보 조회 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
				HashMap<String, Object> procParams = new HashMap<>( );
				DateFormat dateFormat = new SimpleDateFormat( "yyyyMMdd", Locale.getDefault() );
				Calendar cal = Calendar.getInstance( );
				procParams.put( "procType", "absdocuInfo" );
				procParams.put( "erpCompSeq", loginVo.getErpCoCd( ) );
				mv.addObject( "erpAbsDocu", CommonConvert.CommonGetListMapToJson( procService.getProcResult( procParams ).getAaData( ) ) );
			}
			else {
				mv.addObject( "erpAbsDocu", CommonConvert.CommonGetListMapToJson( new ArrayList( ) ) );
			}
			/* ERP 기수 정보 조회 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
				HashMap<String, Object> procParams = new HashMap<>( );
				DateFormat dateFormat = new SimpleDateFormat( "yyyyMMdd", Locale.getDefault() );
				Calendar cal = Calendar.getInstance( );
				procParams.put( "procType", "commonGisuInfo" );
				procParams.put( "erpCompSeq", loginVo.getErpCoCd( ) );
				procParams.put( "baseDate", dateFormat.format( cal.getTime( ) ) );
				procParams.put( "erpType", CommonConvert.CommonGetStr(conVo.getErpTypeCode( )) );
				mv.addObject( "erpGisu", CommonConvert.CommonGetListMapToJson( procService.getProcResult( procParams ).getAaData( ) ) );
			}
			else {
				HashMap<String, Object> procParams = new HashMap<>( );
				DateFormat dateFormat = new SimpleDateFormat( "yyyyMMdd" );
				Calendar cal = Calendar.getInstance( );
				procParams.put( "procType", "commonGisuInfo" );
				procParams.put( "erpCompSeq", loginVo.getErpCoCd( ) );
				procParams.put( "baseDate", dateFormat.format( cal.getTime( ) ) );
				procParams.put( "erpType", CommonConvert.CommonGetStr(conVo.getErpTypeCode( )) );
				mv.addObject( "erpGisu", CommonConvert.CommonGetListMapToJson( procService.getProcResult( procParams ).getAaData( ) ) );
			}
			/* 이전단계(정보수정) 확인 값 */
			if ( params.get( "approKey" ) != null ) {
				mv.addObject( "approBefore", "Y" );
				String approKey = params.get( "approKey" ).toString( );
				String formType = CommonConvert.CommonGetStr( approKey.split( "_" )[0] );
				String docSeq = CommonConvert.CommonGetStr( approKey.split( "_" )[2] );

				params.put("groupSeq", loginVo.getGroupSeq());
				params.put("resDocSeq", docSeq);
				
				//구매_계약 결의서 작성정보 조회
				Map<String, Object> conclusionPaymentDocInfo = contractServiceDAO.SelectConclusionPaymentDocInfo(params);
				
				if(conclusionPaymentDocInfo == null) {
					//신규 작성할 다음차수 정보 가져오기
					conclusionPaymentDocInfo = contractServiceDAO.SelectConclusionPaymentNextDocInfo(params);
				}
				
				mv.addObject( "conclusionPaymentDocInfo", conclusionPaymentDocInfo);

				if ("paramsOuter".equals(params.get("outProcessInterfaceId"))
						|| ("EXNPRESCONU".equals(formType) || "EXNPRESCUSTOM".equals(formType))) { // TODO : 백상휘 수정.

					mv.addObject("resDocSeq", docSeq);
					mv.addObject("resCustomProcess", true);
					mv.addObject("formType", formType);
					mv.addObject("consDocSeq", docSeq);

					if ("EXNPRESCONU".equals(formType)) { // 품의서 데이터가 있는 경우

						if (docSeq == null || "".equals(docSeq.trim())) {
							throw new Exception("외부 데이터 결의서 셋팅 중 문제가 발생하였습니다.");
						}

						params.put("consDocSeq", docSeq);
						result = consService.selectConsApprovalBefore(params);
						mv.addObject("consDocInfo", CommonConvert.CommonGetListMapToJson((List<Map<String, Object>>) result.getaData().get("consDocInfo")));
						mv.addObject("consHeadInfo", CommonConvert.CommonGetListMapToJson((List<Map<String, Object>>) result.getaData().get("consHeadInfo")));
						mv.addObject("consBudgetInfo", CommonConvert.CommonGetListMapToJson((List<Map<String, Object>>) result.getaData().get("budgetInfo")));
						mv.addObject("consTradeInfo", CommonConvert.CommonGetListMapToJson((List<Map<String, Object>>) result.getaData().get("tradeInfo")));

					} else if ( "EXNPRESCUSTOM".equals(formType)
							&& (params.containsKey("resHeadInfo") && params.containsKey("resBudgetInfo") && params.containsKey("resTradeInfo"))) {
						// 품의서 데이터가 없는 경우. 데이터를 직접 결의서 작성 창으로 보내줌.

						List<Map<String, Object>> consDocInfo = CommonConvert.CommonGetJSONToListMap((String) params.get("resHeadInfo"));

						// 커스텀 소스에서 생성된 결의서 키 셋팅. 참조품의 시 불러온 품의서의 키 역할 할 것임.
						if (params.containsKey("refferKey")) {
							mv.addObject("gntpKey", params.get("refferKey"));
						} else if (consDocInfo.size() > 0 && consDocInfo.get(0).containsKey("resDocSeq")) {
							mv.addObject("gntpKey", consDocInfo.get(0).get("resDocSeq"));
						} else {
							throw new Exception("외부 데이터 결의서 셋팅 중 문제가 발생하였습니다.");
						}

						// 데이터 셋팅.
						mv.addObject("resHeadInfo", params.get("resHeadInfo"));
						mv.addObject("resBudgetInfo", params.get("resBudgetInfo"));
						mv.addObject("resTradeInfo", params.get("resTradeInfo"));
					} else {
						throw new Exception("외부 데이터 결의서 셋팅 중 문제가 발생하였습니다.");
					}
				}
				else {
					if ( formType.equals( "EXNPCONU" ) ) {
						// 품의서 로직 진행 - ERPiU
						params.put( "consDocSeq", docSeq );
						result = consService.selectConsApprovalBefore( params );
						mv.addObject( "consHeadInfo", CommonConvert.CommonGetListMapToJson( (List<Map<String, Object>>) result.getaData( ).get( "consHeadInfo" ) ) );
						mv.addObject( "consBudgetInfo", CommonConvert.CommonGetListMapToJson( (List<Map<String, Object>>) result.getaData( ).get( "budgetInfo" ) ) );
						mv.addObject( "consTradeInfo", CommonConvert.CommonGetListMapToJson( (List<Map<String, Object>>) result.getaData( ).get( "tradeInfo" ) ) );
					}
					else if ( formType.equals( "EXNPRESU" ) ) {
						// 결의서 로직 진행 - ERPiU
						params.put( "resDocSeq", docSeq );
						result = resService.selectResApprovalBefore( params );
						mv.addObject( "resHeadInfo", CommonConvert.CommonGetListMapToJson( (List<Map<String, Object>>) result.getaData( ).get( "resHeadInfo" ) ) );
						mv.addObject( "resBudgetInfo", CommonConvert.CommonGetListMapToJson( (List<Map<String, Object>>) result.getaData( ).get( "budgetInfo" ) ) );
						mv.addObject( "resTradeInfo", CommonConvert.CommonGetListMapToJson( (List<Map<String, Object>>) result.getaData( ).get( "tradeInfo" ) ) );
					}
					else if ( formType.equals( "EXNPCONI" ) ) {
						// 품의서 로직 진행 - iCUBE G20
						try {
							params.put( "consDocSeq", docSeq );
							result = consService.selectConsApprovalBefore( params );
						}
						catch ( Exception ex ) {
							//result =
						}
						mv.addObject( "consDocInfo", CommonConvert.CommonGetListMapToJson( (List<Map<String, Object>>) result.getaData( ).get( "consDocInfo" ) ) );
						mv.addObject( "consHeadInfo", CommonConvert.CommonGetListMapToJson( (List<Map<String, Object>>) result.getaData( ).get( "consHeadInfo" ) ) );
						mv.addObject( "consBudgetInfo", CommonConvert.CommonGetListMapToJson( (List<Map<String, Object>>) result.getaData( ).get( "budgetInfo" ) ) );
						mv.addObject( "consTradeInfo", CommonConvert.CommonGetListMapToJson( (List<Map<String, Object>>) result.getaData( ).get( "tradeInfo" ) ) );
					}
					else if ( formType.equals( "EXNPRESI" ) ) {
						// 결의서 로직 진행 - iCUBE G20
						try {
							params.put( "resDocSeq", docSeq );
							result = resService.selectResApprovalBefore( params );
						}
						catch ( Exception ex ) {
							//result =
						}
						mv.addObject( "resDocInfo", CommonConvert.CommonGetListMapToJson( (List<Map<String, Object>>) result.getaData( ).get( "resDocInfo" ) ) );
						mv.addObject( "resHeadInfo", CommonConvert.CommonGetListMapToJson( (List<Map<String, Object>>) result.getaData( ).get( "resHeadInfo" ) ) );
						mv.addObject( "resBudgetInfo", CommonConvert.CommonGetListMapToJson( (List<Map<String, Object>>) result.getaData( ).get( "budgetInfo" ) ) );
						mv.addObject( "resTradeInfo", CommonConvert.CommonGetListMapToJson( (List<Map<String, Object>>) result.getaData( ).get( "tradeInfo" ) ) );
					}
					else {
						mv.addObject( "consHeadInfo", CommonConvert.CommonGetListMapToJson( new ArrayList( ) ) );
						mv.addObject( "consBudgetInfo", CommonConvert.CommonGetListMapToJson( new ArrayList( ) ) );
						mv.addObject( "consTradeInfo", CommonConvert.CommonGetListMapToJson( new ArrayList( ) ) );
						mv.addObject( "resHeadInfo", CommonConvert.CommonGetListMapToJson( new ArrayList( ) ) );
						mv.addObject( "resBudgetInfo", CommonConvert.CommonGetListMapToJson( new ArrayList( ) ) );
						mv.addObject( "resTradeInfo", CommonConvert.CommonGetListMapToJson( new ArrayList( ) ) );
					}
				}
			}
			else {
				mv.addObject( "approBefore", "N" );
				mv.addObject( "consHeadInfo", CommonConvert.CommonGetListMapToJson( new ArrayList( ) ) );
				mv.addObject( "consBudgetInfo", CommonConvert.CommonGetListMapToJson( new ArrayList( ) ) );
				mv.addObject( "consTradeInfo", CommonConvert.CommonGetListMapToJson( new ArrayList( ) ) );
				mv.addObject( "resHeadInfo", CommonConvert.CommonGetListMapToJson( new ArrayList( ) ) );
				mv.addObject( "resBudgetInfo", CommonConvert.CommonGetListMapToJson( new ArrayList( ) ) );
				mv.addObject( "resTradeInfo", CommonConvert.CommonGetListMapToJson( new ArrayList( ) ) );
			}
			/* 품의/결의 로직 구분 조회 */
			String formDTp = eaFormInfo.get( 0 ).get( "formDTp" ).toString( );

			if ( formDTp.equals( "EXNPCONU" ) ) {
				// 품의서 로직 진행 - ERPiU
				mv.setViewName( commonExPath.NPUSERPOPPATH + commonExPath.NUSERCONSPOP );
			}
			else if ( formDTp.equals( "EXNPRESU" ) ) {
				// 결의서 로직 진행 - ERPiU
				mv.setViewName( commonExPath.NPUSERPOPPATH + commonExPath.NUSERRESPOP );
			}
			else if ( formDTp.equals( "EXNPCONI" ) ) {
				// 품의서 로직 진행 - iCUBE G20
				mv.setViewName( commonExPath.NPUSERPOPPATH + commonExPath.NUSERCONSPOP );
			}
			else if ( formDTp.equals( "EXNPRESI" ) ) {
				// 결의서 로직 진행 - iCUBE G20
				mv.setViewName( commonExPath.NPUSERPOPPATH + commonExPath.NUSERRESPOP );
			}
			else if ( formDTp.equals( "TRIPCONS" ) ) {
				// 출장 품의서 로직 진행
				mv.setViewName( commonTripPath.TRIPUSERPOPPATH + commonTripPath.TRIPUSERCONSPOP );
			}
			else if ( formDTp.equals( "TRIPRES" ) ) {
				// 출장 결의서 로직 진행
				mv.setViewName( commonTripPath.TRIPUSERPOPPATH + commonTripPath.TRIPUSERRESPOP );
			}
			else {
				throw new CheckDocSettingException( "formDTp 값을 찾을 수 없습니다." );
			}

		}
		catch ( CheckDocSettingException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKDOCSETTING );
		}
		catch ( NotFoundLoginSessionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
		}
		catch ( CheckICUBEG20TypeException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKICUBEG20TYPE );
		}
		catch ( NotFoundERPEmpCdException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPEMPCDMAPPING );
		}
		catch ( NotFoundConnectionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPSETTING );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
		}
		return mv;
	}

	/**
	 * Pop View
	 * 비영리 공통 코드 팝업
	 */
	@RequestMapping ( "/expend/np/user/NpCommonCodePop.do" )
	public ModelAndView NpCommonCodePop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/NpCommonCodePop.do] " + "", "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			Map<String, Object> sendParam = new LinkedHashMap<String, Object>( );
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo( );
			Map<String, Object> tempParam = CommonConvert.CommonGetJSONToMap( params.get( "param" ).toString( ) );
			List<Map<String, Object>> commonCodeData = CommonConvert.CommonGetJSONToListMap( params.get( "data" ).toString( ) );
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			/* [예외 검증] ERP 연결정보 조회 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			sendParam.put( "ERPType", conVo.getErpTypeCode( ) );
			/* [예외 검증] ERP 연동 확인 */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP 연동 설정을 확인하세요." );
			}
			/* [예외 검증] ERP 타입 확인 / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 설정확인이 필요함." );
			}
			/* [예외 검증] ERP 사번 매핑 확인 */
			if ( empInfo.get( commonCode.ERPEMPSEQ ) == null || empInfo.get( commonCode.ERPEMPSEQ ).toString( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP 사번 매핑이 진행되지 않음." );
			}
			/* [예외 검증] 코드 타입 파라미터 확인 */
			if ( tempParam.get( "code" ) == null || tempParam.get( "code" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "코드 타입 미지정." );
			}
			else {
				/* 공통코드 타입 정의 */
				sendParam.put( "code", tempParam.get( "code" ).toString( ) );
			}
			/* 옵션에 따라서 팝업창 오픈 또는 바로 검색결과 리턴 */
			sendParam.put( "param", CommonConvert.CommonGetMapToJSONStr( tempParam ) );
			sendParam.put( "data", CommonConvert.CommonGetListMapToJsonArray( commonCodeData ) );
			if ( tempParam.get( "popupType" ) == null || !tempParam.get( "popupType" ).toString( ).equals( "1" ) ) {
				/* 거래처인 경우 거래처 그룹 데이터 전달 */
				if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "ERPiU" ) ) {
					switch ( tempParam.get( "code" ).toString( ) ) {
						case "tr":
							ResultVO group1 = new ResultVO( );
							ResultVO group2 = new ResultVO( );
							Map<String, Object> trParamMap = new HashMap<String, Object>( );
							trParamMap.put( "code", "TrGroup" );
							trParamMap.put( "param", tempParam.get( "param" ) );
							group1 = codeService.GetCommonCode( trParamMap );
							trParamMap.put( "code", "TrGroup2" );
							group2 = codeService.GetCommonCode( trParamMap );
							sendParam.put( "trGroup", CommonConvert.CommonGetListMapToJson( group1.getAaData( ) ) );
							sendParam.put( "trGroup2", CommonConvert.CommonGetListMapToJson( group2.getAaData( ) ) );
							break;
						default:
							break;
					}
				}
				else if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) ) {
					switch ( tempParam.get( "code" ).toString( ) ) {
						case "budgetlist":
							ResultVO budgetName = new ResultVO( );
							Map<String, Object> trParamMap = new HashMap<String, Object>( );
							trParamMap.put( "code", "budgetName" );
							trParamMap.put( "param", tempParam.get( "param" ) );
							budgetName = codeService.GetCommonCode( trParamMap );
							trParamMap.put( "code", "TrGroup2" );
							sendParam.put( "budgetHeaderName", CommonConvert.CommonGetListMapToJsonArray( budgetName.getAaData( ) ) );
							break;
						case "tr":
							sendParam.put( "trOpt", tempParam.get( "param" ) );
							break;
						default:
							break;
					}
				}
				/* 콜백 함수 정의 */
				sendParam.put( "callbackFunction", tempParam.get( "callbackFunction" ).toString( ) );
				mv.addObject( "ViewBag", sendParam );
				/* 명칭설정 기능 정의 */
				LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
				String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
				String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
				String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
				CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
				mv.addObject( "CL", vo.getData( ) );
				/* 공통 코드 팝업 호출 */
				mv.setViewName( commonExPath.NPUSERPOPPATH + commonExPath.USERCOMMONCODEPOP );
			}
			else {
				/* 바로 코드 조회 */
				ResultVO result = null;
				result = codeService.GetCommonCode( tempParam );
				mv.setViewName( "jsonView" );
				mv.addObject( "result", result );
			}
		}
		catch ( NotFoundLoginSessionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
		}
		catch ( CheckICUBEG20TypeException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKICUBEG20TYPE );
		}
		catch ( NotFoundERPEmpCdException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPEMPCDMAPPING );
		}
		catch ( NotFoundConnectionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPSETTING );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
		}
		return mv;
	}

	/**
	 * Pop View
	 * 비영리 물품명세 작성 팝업
	 */
	@RequestMapping ( "/expend/np/user/UserItemSpecPop.do" )
	public ModelAndView UserItemSpecPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/UserItemSpecPop.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo( );
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			/* [예외 검증] ERP 연결정보 조회 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			/* [예외 검증] ERP 연동 확인 */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP 연동 설정을 확인하세요." );
			}
			/* [예외 검증] ERP 타입 확인 / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 설정확인이 필요함." );
			}
			/* [예외 검증] ERP 사번 매핑 확인 */
			if ( empInfo.get( commonCode.ERPEMPSEQ ) == null || empInfo.get( commonCode.ERPEMPSEQ ).toString( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP 사번 매핑이 진행되지 않음." );
			}
			/* 명칭설정 기능 정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );

			mv.addObject("params",params);

			mv.setViewName( commonExPath.NPUSERPOPPATH + commonExPath.USERITEMSPECPOP );
		}
		catch ( NotFoundLoginSessionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
		}
		catch ( CheckICUBEG20TypeException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKICUBEG20TYPE );
		}
		catch ( NotFoundERPEmpCdException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPEMPCDMAPPING );
		}
		catch ( NotFoundConnectionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPSETTING );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
		}
		return mv;
	}

	/**
	 * Pop View
	 * 비영리 결의서 즐겨찾기 가져오기 조회 팝업
	 */
	@RequestMapping ( "/expend/np/user/UserResFavoritesPop.do" )
	public ModelAndView UserResFavoritesResPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/UserResFavoritesPop.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo( );
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			/* [예외 검증] ERP 연결정보 조회 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			/* [예외 검증] ERP 연동 확인 */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP 연동 설정을 확인하세요." );
			}
			/* [예외 검증] ERP 타입 확인 / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 설정확인이 필요함." );
			}
			/* [예외 검증] ERP 사번 매핑 확인 */
			if ( empInfo.get( commonCode.ERPEMPSEQ ) == null || empInfo.get( commonCode.ERPEMPSEQ ).toString( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP 사번 매핑이 진행되지 않음." );
			}
			/* 명칭설정 기능 정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/* 참조품의 가져오기 경로 지정 */
			params.put("empInfo", CommonConvert.CommonGetMapToJSONObj(CommonConvert.CommonGetEmpInfo()));
			mv.addObject("ViewBag", params);
			mv.setViewName( commonExPath.NPUSERPOPPATH + commonExPath.USERBRINGFAVORITESRESPOP );
		}
		catch ( NotFoundLoginSessionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
		}
		catch ( CheckICUBEG20TypeException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKICUBEG20TYPE );
		}
		catch ( NotFoundERPEmpCdException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPEMPCDMAPPING );
		}
		catch ( NotFoundConnectionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPSETTING );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
		}
		return mv;
	}

	/**
	 * Pop View
	 * 비영리 결의서 즐겨찾기 가져오기 조회 팝업
	 */
	@RequestMapping ( "/expend/np/user/UserConsFavoritesPop.do" )
	public ModelAndView UserResFavoritesConsPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/UserResFavoritesPop.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo( );
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			/* [예외 검증] ERP 연결정보 조회 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			/* [예외 검증] ERP 연동 확인 */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP 연동 설정을 확인하세요." );
			}
			/* [예외 검증] ERP 타입 확인 / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 설정확인이 필요함." );
			}
			/* [예외 검증] ERP 사번 매핑 확인 */
			if ( empInfo.get( commonCode.ERPEMPSEQ ) == null || empInfo.get( commonCode.ERPEMPSEQ ).toString( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP 사번 매핑이 진행되지 않음." );
			}
			/* 명칭설정 기능 정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/* 참조품의 가져오기 경로 지정 */
			params.put("empInfo", CommonConvert.CommonGetMapToJSONObj(CommonConvert.CommonGetEmpInfo()));
			mv.addObject("ViewBag", params);
			mv.setViewName( commonExPath.NPUSERPOPPATH + commonExPath.USERBRINGFAVORITESCONSPOP );
		}
		catch ( NotFoundLoginSessionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
		}
		catch ( CheckICUBEG20TypeException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKICUBEG20TYPE );
		}
		catch ( NotFoundERPEmpCdException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPEMPCDMAPPING );
		}
		catch ( NotFoundConnectionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPSETTING );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
		}
		return mv;
	}

	/**
	 * Pop View
	 * 비영리 참조품의 조회 팝업
	 */
	@RequestMapping ( "/expend/np/user/UserConfferPop.do" )
	public ModelAndView UserConfferPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/NpConfferPop.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo( );
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			/* [예외 검증] ERP 연결정보 조회 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			/* [예외 검증] ERP 연동 확인 */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP 연동 설정을 확인하세요." );
			}
			/* [예외 검증] ERP 타입 확인 / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 설정확인이 필요함." );
			}
			/* [예외 검증] ERP 사번 매핑 확인 */
			if ( empInfo.get( commonCode.ERPEMPSEQ ) == null || empInfo.get( commonCode.ERPEMPSEQ ).toString( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP 사번 매핑이 진행되지 않음." );
			}
			/* 명칭설정 기능 정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			mv.addObject( "formSeq", params.get( "formSeq" ) );
			params.put("empInfo", CommonConvert.CommonGetMapToJSONObj(CommonConvert.CommonGetEmpInfo()));
			mv.addObject( "ViewBag", CommonConvert.CommonGetMapToJSONObj( params ) );
			/* 참조품의 가져오기 경로 지정 */
			mv.setViewName( commonExPath.NPUSERPOPPATH + commonExPath.USERCONFFERPOP );
		}
		catch ( NotFoundLoginSessionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
		}
		catch ( CheckICUBEG20TypeException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKICUBEG20TYPE );
		}
		catch ( NotFoundERPEmpCdException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPEMPCDMAPPING );
		}
		catch ( NotFoundConnectionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPSETTING );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
		}
		return mv;
	}

	/**
	 * Pop View
	 * 카드사용내역가져오기 팝업
	 */
	@RequestMapping ( "/expend/np/user/CardUseHistoryPop.do" )
	public ModelAndView UserCardHistoryPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/CardUseHistoryPop.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo( );
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			/* [예외 검증] ERP 연결정보 조회 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			/* [예외 검증] ERP 연동 확인 */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP 연동 설정을 확인하세요." );
			}
			/* [예외 검증] ERP 타입 확인 / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 설정확인이 필요함." );
			}
			/* [예외 검증] ERP 사번 매핑 확인 */
			if ( empInfo.get( commonCode.ERPEMPSEQ ) == null || empInfo.get( commonCode.ERPEMPSEQ ).toString( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP 사번 매핑이 진행되지 않음." );
			}
			/* 명칭설정 기능 정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			mv.addObject( "ViewBag", CommonConvert.CommonGetMapToJSONObj( params ) );

			/* 사용자 기본 옵션 조회 - GW 옵션 정보 조회 */
			ResultVO gwOption = serviceOption.selectGWOption( params, conVo );
			if(!gwOption.getResultCode( ).equals( commonCode.SUCCESS )){
				throw new Exception(gwOption.getResultName( ));
			}
			/* 사용자 기본 옵션 조회 - GW 기본설정 정보  */
			mv.addObject( "gw_optionSet", CommonConvert.CommonGetListMapToJson( gwOption.getAaData( ) ) );

			/* 참조품의 가져오기 경로 지정 */
			mv.setViewName( commonExPath.NPUSERPOPPATH + commonExPath.USERCARDHISTORYPOP );
		}
		catch ( NotFoundLoginSessionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
		}
		catch ( CheckICUBEG20TypeException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKICUBEG20TYPE );
		}
		catch ( NotFoundERPEmpCdException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPEMPCDMAPPING );
		}
		catch ( NotFoundConnectionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPSETTING );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
		}
		return mv;
	}

	/**
	 * Pop View
	 * 세금계산서내역가져오기 팝업
	 */
	@RequestMapping ( "/expend/np/user/ETaxUseHistoryPop.do" )
	public ModelAndView UserETaxHistoryPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/ETaxUseHistoryPop.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo( );
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			/* [예외 검증] ERP 연결정보 조회 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			/* [예외 검증] ERP 연동 확인 */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP 연동 설정을 확인하세요." );
			}
			/* [예외 검증] ERP 타입 확인 / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 설정확인이 필요함." );
			}
			/* [예외 검증] ERP 사번 매핑 확인 */
			if ( empInfo.get( commonCode.ERPEMPSEQ ) == null || empInfo.get( commonCode.ERPEMPSEQ ).toString( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP 사번 매핑이 진행되지 않음." );
			}
			/* 명칭설정 기능 정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			mv.addObject( "ERPType", conVo.getErpTypeCode( ) );
			params.put("empInfo", CommonConvert.CommonGetMapToJSONObj(CommonConvert.CommonGetEmpInfo()));
			mv.addObject( "ViewBag", CommonConvert.CommonGetMapToJSONObj( params ) );
			/* 참조품의 가져오기 경로 지정 */
			mv.setViewName( commonExPath.NPUSERPOPPATH + commonExPath.USERETAXHISTORYPOP );
		}
		catch ( NotFoundLoginSessionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
		}
		catch ( CheckICUBEG20TypeException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKICUBEG20TYPE );
		}
		catch ( NotFoundERPEmpCdException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPEMPCDMAPPING );
		}
		catch ( NotFoundConnectionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPSETTING );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
		}
		return mv;
	}

	/**
	 * Pop View
	 * 카드내역가져오기 팝업
	 */
	@RequestMapping ( "/expend/np/user/UserCardTransHistoryPop.do" )
	public ModelAndView UserCardTransHistoryPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/UserCardTransHistoryPop.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo( );
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			/* [예외 검증] ERP 연결정보 조회 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			/* [예외 검증] ERP 연동 확인 */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP 연동 설정을 확인하세요." );
			}
			/* [예외 검증] ERP 타입 확인 / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 설정확인이 필요함." );
			}
			/* [예외 검증] ERP 사번 매핑 확인 */
			if ( empInfo.get( commonCode.ERPEMPSEQ ) == null || empInfo.get( commonCode.ERPEMPSEQ ).toString( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP 사번 매핑이 진행되지 않음." );
			}
			/* 명칭설정 기능 정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			mv.addObject( "ERPType", conVo.getErpTypeCode( ) );
			mv.addObject( "ViewBag", CommonConvert.CommonGetMapToJSONObj( params ) );
			/* 참조품의 가져오기 경로 지정 */
			mv.setViewName( commonExPath.NPUSERPOPPATH + commonExPath.USERCARDTRANSHISTORYPOP );
		}
		catch ( NotFoundLoginSessionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
		}
		catch ( CheckICUBEG20TypeException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKICUBEG20TYPE );
		}
		catch ( NotFoundERPEmpCdException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPEMPCDMAPPING );
		}
		catch ( NotFoundConnectionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPSETTING );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
		}
		return mv;
	}


	/**
	 * Pop View
	 * 법인카드 사용분 상세내역 팝업
	 */
	@RequestMapping ( "/expend/np/user/UserCardDetailPop.do" )
	public ModelAndView UserCardDetailPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/UserCardDetailPop.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo( );
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			/* [예외 검증] ERP 연결정보 조회 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			/* [예외 검증] ERP 연동 확인 */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP 연동 설정을 확인하세요." );
			}
			/* [예외 검증] ERP 타입 확인 / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 설정확인이 필요함." );
			}
			/* [예외 검증] ERP 사번 매핑 확인 */
			if ( empInfo.get( commonCode.ERPEMPSEQ ) == null || empInfo.get( commonCode.ERPEMPSEQ ).toString( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP 사번 매핑이 진행되지 않음." );
			}
			/* 명칭설정 기능 정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			mv.addObject( "ERPType", conVo.getErpTypeCode( ) );
			mv.addObject( "ViewBag", CommonConvert.CommonGetMapToJSONObj( params ) );

			/* 법인카드 사용내역 상세 데이터 조회 */
			ResultVO cardResult = reportService.NPUserCardDetailInfo( params );
			if(cardResult == null){
				throw new Exception("ERP연결 설정을 확인하여 주세요.");
			}
			if(CommonConvert.CommonGetStr(cardResult.getResultCode( )).equals( commonCode.FAIL )){
				throw new Exception("법인카드 사용정보 조회 실패");
			}
			mv.addObject( "cardInfo", cardResult.getaData( ) );

			/* 법인카드 사용내역 상세 */
			mv.setViewName( commonExPath.NPUSERPOPPATH + commonExPath.USERCARDDETAILPOP );
		}
		catch ( NotFoundLoginSessionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
		}
		catch ( CheckICUBEG20TypeException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKICUBEG20TYPE );
		}
		catch ( NotFoundERPEmpCdException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPEMPCDMAPPING );
		}
		catch ( NotFoundConnectionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPSETTING );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
		}
		return mv;
	}


	/**
	 * Pop View
	 * 전자세금 계산서 사용분 상세내역 팝업
	 */
	@RequestMapping ( "/expend/np/user/UserETaxDetailPop.do" )
	public ModelAndView UserETaxDetailPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/UserETaxDetailPop.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo( );
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			/* [예외 검증] ERP 연결정보 조회 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			/* [예외 검증] ERP 연동 확인 */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP 연동 설정을 확인하세요." );
			}
			/* [예외 검증] ERP 사번 매핑 확인 */
			if ( empInfo.get( commonCode.ERPEMPSEQ ) == null || empInfo.get( commonCode.ERPEMPSEQ ).toString( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP 사번 매핑이 진행되지 않음." );
			}
			/* 명칭설정 기능 정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			mv.addObject( "ERPType", conVo.getErpTypeCode( ) );
			mv.addObject( "ViewBag", CommonConvert.CommonGetMapToJSONObj( params ) );

			/* 매입전자 세금계산서 상세 데이터 조회 */
			ResultVO eTaxResult = reportService.NPUserETaxDetailInfo( params, conVo );
			if(eTaxResult == null){
				throw new Exception("ERP연결 설정을 확인하여 주세요.");
			}
			if(CommonConvert.CommonGetStr(eTaxResult.getResultCode( )).equals( commonCode.FAIL )){
				throw new Exception("전자 세금 계산서 상세 정보 조회 실패");
			}

			//매입전자 세금계산서 상세 데이터 변환 후 담을 list
			List<Map<String, Object>> eTaxResultList = new ArrayList<>();

			for(int i=0; i < eTaxResult.getAaData().size(); i++) {
				Map<String, Object> resultMap = new HashMap<>();
				Map<String, Object> eTaxMap = eTaxResult.getAaData().get(i);

				Set<String> key = eTaxMap.keySet();
				//Map에 데이터를 변환 후 다시 List에 담기(큰따옴표, 작은따옴표 변환)
				for (Iterator<String> iterator = key.iterator(); iterator.hasNext();) {
					String keyName = CommonConvert.CommonGetStr(iterator.next());
					resultMap.put(keyName, CommonConvert.CommonConvertSpecialCharaterForHTML(CommonConvert.CommonGetStr(eTaxMap.get(keyName))));
				}
				eTaxResultList.add(resultMap);
			}

			mv.addObject( "eTaxInfo", eTaxResult.getaData( ) );
			mv.addObject( "eTaxItemInfo", CommonConvert.CommonGetListMapToJson( eTaxResultList ) );

			/* ERP 모듈별 페이지 준비 */
			if(CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU )){
				mv.setViewName( commonExPath.NPUSERPOPPATH + commonExPath.USERETAXDETAILPOPU );
			}else if(CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE )){
				mv.setViewName( commonExPath.NPUSERPOPPATH + commonExPath.USERETAXDETAILPOPI );
			}

		}
		catch ( NotFoundLoginSessionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
		}
		catch ( CheckICUBEG20TypeException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKICUBEG20TYPE );
		}
		catch ( NotFoundERPEmpCdException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPEMPCDMAPPING );
		}
		catch ( NotFoundConnectionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPSETTING );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
		}
		return mv;
	}

	@RequestMapping("/expend/np/user/NpUserReUsePop.do")
	public ModelAndView NpUserReUsePop(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/expend/np/user/NpUserReUsePop.do] " + params.toString(), "-", "EXNP");

		// http://local.duzonnext.com:8080/exp/expend/np/user/NpUserReUsePop.do?oriApproKey=&oriDocId=&form_gb=&formGb=&copyApprovalLine=&copyAttachFile=&formDTp=&consDocSeq=
		// http://local.duzonnext.com:8080/exp/expend/np/user/NpUserReUsePop.do?oriApproKey=&oriDocId=&form_gb=&formGb=&copyApprovalLine=&copyAttachFile=&formDTp=&resDocSeq=
		ModelAndView mv = new ModelAndView();

		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo();
			/* [예외 검증] 로그인 세션 확인 */
			if (CommonConvert.CommonGetEmpInfo() == null) { throw new NotFoundLoginSessionException("로그인 세션 검색 실패"); }
			/* [예외 검증] ERP 연결정보 조회 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(empInfo.get(commonCode.COMPSEQ)));
			/* [예외 검증] ERP 연동 확인 */
			if (conVo.getErpCompSeq() == null || conVo.getErpCompSeq().isEmpty()) { throw new NotFoundConnectionException("ERP 연동 설정을 확인하세요."); }
			/* [예외 검증] ERP 타입 확인 / iCUBE G20 */
			if (conVo.getErpTypeCode().equals("iCUBE") && conVo.getG20YN().equals("N")) { throw new CheckICUBEG20TypeException("iCUBE G20 설정확인이 필요함."); }
			/* [예외 검증] ERP 사번 매핑 확인 */
			if (empInfo.get(commonCode.ERPEMPSEQ) == null || empInfo.get(commonCode.ERPEMPSEQ).toString().isEmpty()) { throw new NotFoundERPEmpCdException("ERP 사번 매핑이 진행되지 않음."); }

			/* 명칭설정 기능 정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO();
			String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
			String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
			String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
			mv.addObject("CL", vo.getData());
			mv.addObject("ERPType", conVo.getErpTypeCode());
			mv.addObject("ViewBag", CommonConvert.CommonGetMapToJSONObj(params));
			mv.addObject("EmpInfo", CommonConvert.CommonGetEmpInfo());

			ResultVO p = new ResultVO();
			params.put("eaType", CommonConvert.CommonGetEmpVO().getEaType());
			p.setParams(params);
			mv.addObject("OriFormInfo", reUseService.ConsReUseFormInfoSelect(p).getaData());

			// View 정의
			ResultVO r = new ResultVO();
			switch (CommonConvert.CommonGetStr(params.get("formDTp"))) {
				case "EXNPCONI":
				case "EXNPCONU":
					mv.setViewName(commonExPath.NPUSERPOPPATH + commonExPath.USERCONSREUSEPOP);

					r = new ResultVO();
					r.setParams(params);
					r = reUseService.ConsReUseGisuSelect(r);
					mv.addObject("ConsGisu", r.getaData());
					break;
				case "EXNPRESI":
				case "EXNPRESU":
					mv.setViewName(commonExPath.NPUSERPOPPATH + commonExPath.USERRESREUSEPOP);

					r = new ResultVO();
					r.setParams(params);
					r = reUseService.ResReUseGisuSelect(r);
					mv.addObject("ResGisu", r.getaData());
					break;
				default:
					mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERROR);
					break;
			}
		}
		catch (NotFoundLoginSessionException ex) {
			mv.addObject("errMsg", ex.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN);
		}
		catch (CheckICUBEG20TypeException ex) {
			mv.addObject("errMsg", ex.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKICUBEG20TYPE);
		}
		catch (NotFoundERPEmpCdException ex) {
			mv.addObject("errMsg", ex.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPEMPCDMAPPING);
		}
		catch (NotFoundConnectionException ex) {
			mv.addObject("errMsg", ex.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPSETTING);
		}
		catch (Exception ex) {
			cmLog.CommonSetError(ex);
			mv.addObject("errMsg", ex.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERROR);
		}

		return mv;
	}

	/**
	 * Pop View 세금계산서 이관내역 팝업
	 */
	@RequestMapping("/expend/np/user/UserETaxTransHistoryPop.do")
	public ModelAndView UserETaxTransHistoryPop(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/expend/np/user/UserETaxTransHistoryPop.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo();
			/* [예외 검증] 로그인 세션 확인 */
			if (CommonConvert.CommonGetEmpInfo() == null) { throw new NotFoundLoginSessionException("로그인 세션 검색 실패"); }
			/* [예외 검증] ERP 연결정보 조회 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(empInfo.get(commonCode.COMPSEQ)));
			/* [예외 검증] ERP 연동 확인 */
			if (conVo.getErpCompSeq() == null || conVo.getErpCompSeq().isEmpty()) { throw new NotFoundConnectionException("ERP 연동 설정을 확인하세요."); }
			/* [예외 검증] ERP 타입 확인 / iCUBE G20 */
			if (conVo.getErpTypeCode().equals("iCUBE") && conVo.getG20YN().equals("N")) { throw new CheckICUBEG20TypeException("iCUBE G20 설정확인이 필요함."); }
			/* [예외 검증] ERP 사번 매핑 확인 */
			if (empInfo.get(commonCode.ERPEMPSEQ) == null || empInfo.get(commonCode.ERPEMPSEQ).toString().isEmpty()) { throw new NotFoundERPEmpCdException("ERP 사번 매핑이 진행되지 않음."); }
			/* 명칭설정 기능 정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO();
			String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
			String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
			String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
			mv.addObject("CL", vo.getData());
			mv.addObject("ERPType", conVo.getErpTypeCode());
			params.put("empInfo", CommonConvert.CommonGetMapToJSONObj(CommonConvert.CommonGetEmpInfo()));
			mv.addObject("ViewBag", CommonConvert.CommonGetMapToJSONObj(params));
			/* 참조품의 가져오기 경로 지정 */
			mv.setViewName(commonExPath.NPUSERPOPPATH + commonExPath.USERETAXTRANSHISTORYPOP);
		}
		catch (NotFoundLoginSessionException ex) {
			mv.addObject("errMsg", ex.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN);
		}
		catch (CheckICUBEG20TypeException ex) {
			mv.addObject("errMsg", ex.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKICUBEG20TYPE);
		}
		catch (NotFoundERPEmpCdException ex) {
			mv.addObject("errMsg", ex.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPEMPCDMAPPING);
		}
		catch (NotFoundConnectionException ex) {
			mv.addObject("errMsg", ex.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPSETTING);
		}
		catch (Exception ex) {
			cmLog.CommonSetError(ex);
			mv.addObject("errMsg", ex.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERROR);
		}
		return mv;
	}

	@RequestMapping("/expend/np/user/getConfferCustomInfo.do")
	public ModelAndView getConfferCustomInfo(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {// TODO : 백상휘 수정.
		ModelAndView mv = new ModelAndView("jsonView");
		ResultVO result;
		mv.addObject( "errMsg", "" );

		if (params.containsKey("consDocSeq") == false) {
			result = new ResultVO();
			result.setFail("파라미터 키 오류가 발생하였습니다.");
			mv.addObject("result", result);
			return mv;
		}

		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			result = consService.selectConsInCustom(params);

			mv.addObject("loginCompInfo", loginVo.getCompSeq() );
			mv.addObject("result", result.getaData());

		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			mv.addObject( "errMsg", ex.getMessage( ) );
		}

		return mv;
	}
}
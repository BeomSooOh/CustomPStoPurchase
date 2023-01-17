package purchase.web;

import java.io.File;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.logging.log4j.LogManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import bizbox.orgchart.service.vo.LoginVO;
import cmm.util.CommonUtil;
import common.helper.convert.CommonConvert;
import common.helper.exception.CheckICUBEG20TypeException;
import common.helper.exception.NotFoundConnectionException;
import common.helper.exception.NotFoundERPEmpCdException;
import common.helper.exception.NotFoundLoginSessionException;
import common.helper.info.CommonInfo;
import common.helper.logger.ExpInfo;
import common.procedure.npG20.BCommonProcService;
import purchase.service.CommonService;
import purchase.service.CommonServiceDAO;
import purchase.service.PurchaseService;
import purchase.service.PurchaseServiceDAO;
import common.vo.common.CommonMapper;
import common.vo.common.ConnectionVO;
import common.vo.common.CustomLabelVO;
import common.vo.common.ResultVO;
import common.vo.common.CommonInterface.commonCode;
import expend.np.user.option.BNpUserOptionService;
import neos.cmm.util.DateUtil;
import net.sf.json.JSONArray;



@Controller
public class PurchasePopController {

    /* ################################################## */
    /* 변수정의 */
    /* ################################################## */
    private final org.apache.logging.log4j.Logger logger = LogManager.getLogger(this.getClass());
    
    /* 변수정의 - Service */
    //@Resource(name = "BExAdminReportService")
    //private BExAdminReportService reportService;
    
    @Resource(name = "CommonInfo")
    private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
    
    @Resource(name = "CommonService")
    private CommonService commonService;    
    
    @Resource(name = "CommonServiceDAO")
    private CommonServiceDAO commonServiceDAO;   
    
    @Resource(name = "PurchaseService")
    private PurchaseService purchaseService;    
    
    @Resource(name = "PurchaseServiceDAO")
    private PurchaseServiceDAO purchaseServiceDAO;    	
    
	@Resource ( name = "BNpUserOptionService" )
	private BNpUserOptionService serviceOption; /* Expend Service */    
    
	@Resource ( name = "BCommonProcService" )
	private BCommonProcService procService;    
    
    @RequestMapping("/purchase/pop/PurchaseCreatePop.do")
    public ModelAndView PurchaseCreatePop(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수 설정 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            
            params.put("groupSeq", loginVo.getGroupSeq());
            params.put("useYn", "Y");
            params.put("group", "resFormSeq");
            params.put("code", "Purchase01");
            List<Map<String, Object>> consFormSeq = commonServiceDAO.SelectPurchaseDetailCodeList(params);
            
            if(consFormSeq.size() > 0) {
            	String formSeq = consFormSeq.get(0).get("LINK").toString();
            	params.put("formSeq", formSeq);
            	mv.addObject("consFormSeq", formSeq);	
            }              
            
			/* [예외 검증] ERP 연결정보 조회 */
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
			ArrayList<Map<String, Object>> eaFormInfo = (ArrayList<Map<String, Object>>) serviceOption.selectEaBaseData( params, conVo ).getAaData( );
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
				procParams.put( "procType", "absdocuInfo" );
				procParams.put( "erpCompSeq", loginVo.getErpCoCd( ) );
				mv.addObject( "erpAbsDocu", CommonConvert.CommonGetListMapToJson( procService.getProcResult( procParams ).getAaData( ) ) );
			}
			else {
				mv.addObject( "erpAbsDocu", CommonConvert.CommonGetListMapToJson( new ArrayList( ) ) );
			}
			/* ERP 기수 정보 조회 */
			HashMap<String, Object> procParams = new HashMap<>( );
			DateFormat dateFormat = new SimpleDateFormat( "yyyyMMdd", Locale.getDefault() );
			Calendar cal = Calendar.getInstance( );
			procParams.put( "procType", "commonGisuInfo" );
			procParams.put( "erpCompSeq", loginVo.getErpCoCd( ) );
			procParams.put( "baseDate", dateFormat.format( cal.getTime( ) ) );
			procParams.put( "erpType", "iCUBE");
			mv.addObject( "erpGisu", CommonConvert.CommonGetListMapToJson( procService.getProcResult( procParams ).getAaData( ) ) );              
            
        	String toDate = DateUtil.getCurrentDate("yyyy-MM-dd");
        	String fromDate = DateUtil.getFormattedDateAdd(toDate, "yyyy-MM-dd", "yyyy-MM-dd", -10, 0, 0);
        	mv.addObject("fromDate", fromDate);
        	mv.addObject("toDate", toDate);                  
            
            mv.addObject("viewType", "I");
            mv.addObject("disabledYn", "N");
            mv.addObject("btnSaveYn", "Y");
            mv.addObject("btnApprYn", "Y");
            
            Map<String, Object> queryParam = new HashMap<String, Object>();
            queryParam.put("groupSeq", loginVo.getGroupSeq());
            
            //구매계약 전용코드 조회 (전체코드 한번에 조회)
            queryParam.put("useYn", "Y");
            List<Map<String, Object>> codeList = commonServiceDAO.SelectPurchaseDetailCodeList(queryParam);
            
            List<Map<String, Object>> notiType = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> budgetType = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> targetType = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> baseLaw = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> payType = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> competeType = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> restrictArea = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> decisionType = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> contractForm1 = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> contractForm2 = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> contractForm3 = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> sectorGroup = new ArrayList<Map<String, Object>>();
            
            List<Map<String, Object>> attachForm_Purchase01 = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> option = new ArrayList<Map<String, Object>>();
            
            List<Map<String, Object>> unit = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> inventory = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> useLocation = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> foreignType = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> country = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> acquisitionReason = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> greenCertType = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> nonGreenReason = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> greenClass = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> purchaseMethod = new ArrayList<Map<String, Object>>();
            
            if(codeList != null && codeList.size() > 0) {
            	
        		for (Map<String, Object> codeinfo : codeList) {
        			
        			if(codeinfo.get("GROUP").equals("notiType")) {
        				notiType.add(codeinfo);
        			}else if(codeinfo.get("GROUP").equals("budgetType")) {
        				budgetType.add(codeinfo);
        			}else if(codeinfo.get("GROUP").equals("targetType")) {
        				targetType.add(codeinfo);
        			}else if(codeinfo.get("GROUP").equals("baseLaw")) {
        				baseLaw.add(codeinfo);
        			}else if(codeinfo.get("GROUP").equals("payType")) {
        				payType.add(codeinfo);
        			}else if(codeinfo.get("GROUP").equals("competeType")) {
        				competeType.add(codeinfo);
        			}else if(codeinfo.get("GROUP").equals("restrictArea")) {
        				restrictArea.add(codeinfo);
        			}else if(codeinfo.get("GROUP").equals("decisionType")) {
        				decisionType.add(codeinfo);
        			}else if(codeinfo.get("GROUP").equals("contractForm1")) {
        				contractForm1.add(codeinfo);
        			}else if(codeinfo.get("GROUP").equals("contractForm2")) {
        				contractForm2.add(codeinfo);
        			}else if(codeinfo.get("GROUP").equals("contractForm3")) {
        				contractForm3.add(codeinfo);
        			}else if(codeinfo.get("GROUP").equals("sectorGroup")) {
        				sectorGroup.add(codeinfo);
        			}else if(codeinfo.get("GROUP").equals("attachForm_Purchase01")) {
        				attachForm_Purchase01.add(codeinfo);
        			}else if(codeinfo.get("GROUP").equals("option")) {
        				option.add(codeinfo);
        			}else if(codeinfo.get("GROUP").equals("unit")) {
        				unit.add(codeinfo);
        			}else if(codeinfo.get("GROUP").equals("inventory")) {
        				inventory.add(codeinfo);
        			}else if(codeinfo.get("GROUP").equals("useLocation")) {
        				useLocation.add(codeinfo);
        			}else if(codeinfo.get("GROUP").equals("foreignType")) {
        				foreignType.add(codeinfo);
        			}else if(codeinfo.get("GROUP").equals("country")) {
        				country.add(codeinfo);
        			}else if(codeinfo.get("GROUP").equals("acquisitionReason")) {
        				acquisitionReason.add(codeinfo);
        			}else if(codeinfo.get("GROUP").equals("greenCertType")) {
        				greenCertType.add(codeinfo);
        			}else if(codeinfo.get("GROUP").equals("nonGreenReason")) {
        				nonGreenReason.add(codeinfo);
        			}else if(codeinfo.get("GROUP").equals("greenClass")) {
        				greenClass.add(codeinfo);
        			}else if(codeinfo.get("GROUP").equals("purchaseMethod")) {
        				purchaseMethod.add(codeinfo);
        			}
        		}            	
            }
            
            //기존 작성정보 조회
            if(params.get("seq") != null && !params.get("seq").equals("")) {
            	Map<String, Object> detailInfo = purchaseServiceDAO.SelectPurchaseDetail(params);
            	
            	if(detailInfo != null) {
            		
            		if(!detailInfo.get("doc_sts").equals("")) {
            			
            			//임시저장 버튼 표시
            			mv.addObject("btnSaveYn", "N");
            			
            			if(!detailInfo.get("approkey_purchase").equals("") || !detailInfo.get("doc_sts").equals("10")) {
            				mv.addObject("btnApprYn", "N");
            				mv.addObject("disabledYn", "Y");
            				mv.addObject("disabled", "disabled");
            			}
            		}
            		
            		mv.addObject("viewType", "U");
            		mv.addObject("seq", params.get("seq"));
            		mv.addObject("purchaseDetailInfo", detailInfo);
            		
                	mv.addObject("createDeptName", detailInfo.get("write_dept_name"));
                	mv.addObject("createEmpName", detailInfo.get("write_emp_name"));
                	mv.addObject("write_comp_seq", detailInfo.get("write_comp_seq"));
                	mv.addObject("write_dept_seq", detailInfo.get("write_dept_seq"));
                	mv.addObject("write_emp_seq", detailInfo.get("write_emp_seq"));
                	mv.addObject("createSuperKey", loginVo.getGroupSeq() + "|" + detailInfo.get("write_comp_seq") + "|" + detailInfo.get("write_dept_seq") + "|" + detailInfo.get("write_emp_seq") + "|u");
                	mv.addObject("write_dt", detailInfo.get("write_dt"));
            		
            		params.put("outProcessCode", "Purchase01");
            		List<Map<String, Object>> formAttachList = commonServiceDAO.SelectFormAttachList(params);
            		mv.addObject("formAttachList", formAttachList);
            		
            		List<Map<String, Object>> budgetList = commonServiceDAO.SelectBudgetList(params);
            		mv.addObject("budgetList", budgetList);
            		
            		List<Map<String, Object>> tradeList = commonServiceDAO.SelectTradeList(params);
            		mv.addObject("tradeList", tradeList);
            		
            		List<Map<String, Object>> itemList = purchaseServiceDAO.SelectItemList(params);
            		mv.addObject("itemList", itemList);            		
            		
            	}else {
            		return mv;
            	}
            }else {
            	mv.addObject("formAttachList", attachForm_Purchase01);
            	
            	mv.addObject("createDeptName", loginVo.getOrgnztNm());
            	mv.addObject("createEmpName", loginVo.getName());
            	mv.addObject("write_comp_seq", loginVo.getOrganId());
            	mv.addObject("write_dept_seq", loginVo.getOrgnztId());
            	mv.addObject("write_emp_seq", loginVo.getUniqId());
            	mv.addObject("createSuperKey", loginVo.getGroupSeq() + "|" + loginVo.getOrganId() + "|" + loginVo.getOrgnztId() + "|" + loginVo.getUniqId() + "|u");
            	mv.addObject("write_dt", CommonUtil.date(new Date(), "yyyy-MM-dd"));
            }
            
            mv.addObject("notiTypeCode", notiType);
            mv.addObject("budgetTypeCode", budgetType);
            mv.addObject("targetTypeCode", targetType);
            mv.addObject("baseLawCode", baseLaw);
            mv.addObject("payTypeCode", payType);
            mv.addObject("competeTypeCode", competeType);
            mv.addObject("restrictAreaCode", restrictArea);
            mv.addObject("decisionTypeCode", decisionType);
            mv.addObject("contractForm1Code", contractForm1);
            mv.addObject("contractForm2Code", contractForm2);
            mv.addObject("contractForm3Code", contractForm3);
            mv.addObject("sectorGroupCode", sectorGroup);
            mv.addObject("option", option);
            
            mv.addObject("unitCode", unit);
            mv.addObject("inventoryCode", inventory);
            mv.addObject("useLocationCode", useLocation);
            mv.addObject("foreignTypeCode", foreignType);
            mv.addObject("countryCode", country);
            mv.addObject("acquisitionReasonCode", acquisitionReason);
            mv.addObject("greenCertTypeCode", greenCertType);
            mv.addObject("nonGreenReasonCode", nonGreenReason);
            mv.addObject("greenClassCode", greenClass);
            mv.addObject("purchaseMethod", purchaseMethod);
            
            mv.addObject("seq", params.get("seq"));
            
            mv.setViewName("/purchase/pop/PurchaseCreatePop");

        } catch (Exception e) {
            e.printStackTrace();
            ExpInfo.ProcessLog(e.getLocalizedMessage());
            mv.addObject("errMsg", e.getMessage());
            mv.setViewName(CommonMapper.GetExError());
            logger.error(e);
        }
        return mv;
    }   
    
    
    
    
    
    @RequestMapping("/purchase/pop/PurchaseCheckPop.do")
    public ModelAndView PurchaseCheckPop(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수 설정 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            
            mv.addObject("viewType", "U");
            mv.addObject("disabledYn", "N");
            mv.addObject("btnSaveYn", "Y");
            mv.addObject("btnApprYn", "Y");
            
            Map<String, Object> queryParam = new HashMap<String, Object>();
            params.put("groupSeq", loginVo.getGroupSeq());
            queryParam.put("groupSeq", loginVo.getGroupSeq());
            
            //기존 작성정보 조회
            Map<String, Object> detailInfo = purchaseServiceDAO.SelectPurchaseDetail(params);
        	
        	if(detailInfo != null) {
        		
        		if(!detailInfo.get("approkey_check").equals("")) {
        			
        			//임시저장 버튼 표시
        			mv.addObject("btnSaveYn", "N");
        			
        			if(!detailInfo.get("doc_sts").equals("10")) {
        				mv.addObject("btnApprYn", "N");
        				mv.addObject("disabledYn", "Y");
        				mv.addObject("disabled", "disabled");
        			}
        		}
        		
        		if(detailInfo.get("c_write_emp_seq") != null && !detailInfo.get("c_write_emp_seq").equals("")) {
                	mv.addObject("c_write_comp_seq", detailInfo.get("c_write_comp_seq"));
                	mv.addObject("c_write_dept_seq", detailInfo.get("c_write_dept_seq"));
                	mv.addObject("c_write_emp_seq", detailInfo.get("c_write_emp_seq"));
                	mv.addObject("c_write_dt", detailInfo.get("c_write_dt"));
                	
        		}else {
                	mv.addObject("c_write_comp_seq", loginVo.getOrganId());
                	mv.addObject("c_write_dept_seq", loginVo.getOrgnztId());
                	mv.addObject("c_write_emp_seq", loginVo.getUniqId());
                	mv.addObject("c_write_dt", CommonUtil.date(new Date(), "yyyy-MM-dd"));        
        		}        		
        		
                //구매계약 전용코드 조회
                queryParam.put("useYn", "Y");
                queryParam.put("group", "useLocation");
                List<Map<String, Object>> useLocation = commonServiceDAO.SelectPurchaseDetailCodeList(queryParam);
                mv.addObject("useLocationCode", useLocation);
                
        		mv.addObject("seq", params.get("seq"));
        		mv.addObject("purchaseDetailInfo", detailInfo);
        		
        		params.put("outProcessCode", "Purchase02");
        		List<Map<String, Object>> formAttachList = commonServiceDAO.SelectFormAttachList(params);
        		
        		mv.addObject("formAttachList", formAttachList);
        		
        		params.put("outProcessCode", "Purchase01");
        		
        		List<Map<String, Object>> tradeList = commonServiceDAO.SelectTradeList(params);
        		mv.addObject("tradeList", tradeList);
        		
        		List<Map<String, Object>> itemList = purchaseServiceDAO.SelectItemList(params);
        		mv.addObject("itemList", itemList);            		
        		
        	}else {
        		return mv;
        	}
            
            mv.addObject("loginVo", loginVo);
            
            mv.setViewName("/purchase/pop/PurchaseCheckPop");

        } catch (Exception e) {
            e.printStackTrace();
            ExpInfo.ProcessLog(e.getLocalizedMessage());
            mv.addObject("errMsg", e.getMessage());
            mv.setViewName(CommonMapper.GetExError());
            logger.error(e);
        }
        return mv;
    }       
    
    
    @RequestMapping("/purchase/pop/PurchasePaymentPop.do")
    public ModelAndView PurchasePaymentPop(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
        ModelAndView mv = new ModelAndView();
        try {
        	
        	String toDate = DateUtil.getCurrentDate("yyyy-MM-dd");
        	String fromDate = DateUtil.getFormattedDateMonthAdd(toDate, "yyyy-MM-dd", "yyyy-MM-dd", -1);
        	mv.addObject("fromDate", fromDate);
        	mv.addObject("toDate", toDate);
        	
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
			ArrayList<Map<String, Object>> eaFormInfo = (ArrayList<Map<String, Object>>) serviceOption.selectEaBaseData( params, conVo ).getAaData( );
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
            
            mv.addObject("seq", params.get("seq"));
            mv.addObject("formSeq", params.get("formSeq"));
            
            Map<String, Object> queryParam = new HashMap<String, Object>();
            queryParam.put("groupSeq", loginVo.getGroupSeq());
            
            //기존 작성정보 조회
            Map<String, Object> detailInfo = purchaseServiceDAO.SelectPurchaseDetail(params);
            
            if(detailInfo != null) {
            	
            	mv.addObject("purchaseDetailInfo", detailInfo);
            	
            }else {
            	return mv;
            }
            
            mv.setViewName("/purchase/pop/PurchasePaymentPop");            
            

        } catch (Exception e) {
            e.printStackTrace();
            ExpInfo.ProcessLog(e.getLocalizedMessage());
            mv.addObject("errMsg", e.getMessage());
            mv.setViewName(CommonMapper.GetExError());
            logger.error(e);
        }
        return mv;
    }     

    
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
}

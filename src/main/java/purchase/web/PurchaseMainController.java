package purchase.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import bizbox.orgchart.service.vo.LoginVO;
import cmm.util.CommonUtil;
import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundLoginSessionException;
import common.helper.info.CommonInfo;
import common.helper.logger.ExpInfo;
import egovframework.com.utl.fcc.service.EgovFileUploadUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import neos.cmm.util.DateUtil;
import neos.cmm.util.HttpJsonUtil;
import net.sf.json.JSONObject;
import purchase.service.CommonServiceDAO;
import purchase.service.PurchaseService;
import purchase.service.PurchaseServiceDAO;
import common.vo.common.CommonMapper;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.CommonMapInterface.commonExPath;
import common.vo.interlock.InterlockExpendVO;

@Controller
public class PurchaseMainController {

    /* ################################################## */
    /* 변수정의 */
    /* ################################################## */
    private final org.apache.logging.log4j.Logger logger = LogManager.getLogger(this.getClass());
    
    /* 변수정의 - Service */
    //@Resource(name = "BExAdminReportService")
    //private BExAdminReportService reportService;
    
    @Resource(name = "CommonInfo")
    private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
    
    @Resource(name = "CommonServiceDAO")
    private CommonServiceDAO commonServiceDAO;    	       
    
    @Resource(name = "PurchaseService")
    private PurchaseService purchaseService;       
    
    @Resource(name = "PurchaseServiceDAO")
    private PurchaseServiceDAO purchaseServiceDAO;    	        
    	
    @RequestMapping("/purchase/{authLevel}/PurchaseList.do")
    public ModelAndView PurchaseList(@PathVariable String authLevel, @RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
        ModelAndView mv = new ModelAndView();
        mv.addObject("authLevel", authLevel);
        
        try {
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();  
            
            //메뉴접근 권한체크
            if(!commonServiceDAO.CheckAuthFromMenuInfo(loginVo, request.getServletPath())) {
            	//권한없음
            	mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKAUTH );
            	return mv;
            }
        	
        	String toDate = DateUtil.getCurrentDate("yyyy-MM-dd");
        	String fromDate = DateUtil.getFormattedDateMonthAdd(toDate, "yyyy-MM-dd", "yyyy-MM-dd", -3);
        	toDate = DateUtil.getFormattedDateMonthAdd(toDate, "yyyy-MM-dd", "yyyy-MM-dd", 12);
        	mv.addObject("fromDate", fromDate);
        	mv.addObject("toDate", toDate);        
            
            params.put("useYn", "Y");
            params.put("group", "resFormSeq");
            params.put("code", "CONCLUSION");
            Map<String, Object> resFormSeq = commonServiceDAO.SelectPurchaseDetailCodeInfo(params);
            
            if(resFormSeq != null) {
            	mv.addObject("resFormSeq", resFormSeq.get("LINK"));	
            }
            
            mv.setViewName("/purchase/content/PurchaseList");

        } catch (Exception e) {
            e.printStackTrace();
            ExpInfo.ProcessLog(e.getLocalizedMessage());
            mv.addObject("errMsg", e.getMessage());
            mv.setViewName(CommonMapper.GetExError());
            logger.error(e);
        }
        return mv;
    }    
    
    @RequestMapping("/purchase/{authLevel}/SelectPurchaseList.do")
    public ModelAndView SelectContractList(@PathVariable String authLevel, @RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
        ModelAndView mv = new ModelAndView();
        
        /* 변수 설정 */
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		params.put("groupSeq", loginVo.getGroupSeq());
		params.put("compSeq", loginVo.getOrganId());
		params.put("deptSeq", loginVo.getOrgnztId());
		params.put("empSeq", loginVo.getUniqId());
		
		params.put("authLevel", authLevel);
        
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo = getPaginationInfo(params);
		
		Map<String,Object> resultMap = purchaseServiceDAO.SelectPurchaseList(params, paginationInfo);        	
		mv.addAllObjects(resultMap);
        
        mv.setViewName("jsonView");

        return mv;
    }
    
	private PaginationInfo getPaginationInfo(Map<String, Object> paramMap) {	
		
		String fromDate= (String)paramMap.get("fromDate") ;
		String toDate= (String)paramMap.get("toDate") ;

		if(EgovStringUtil.isEmpty(toDate)) {
			toDate = DateUtil.getCurrentDate("yyyyMMdd");
			fromDate = DateUtil.getFormattedDateMonthAdd(toDate, "yyyyMMdd", "yyyyMMdd", -1);
			paramMap.put("fromDate", fromDate);
			paramMap.put("toDate", toDate);
		}else {
			if(fromDate.length() == 10 ) {
				fromDate = fromDate.replaceAll("-", "");
				toDate = toDate.replaceAll("-", "");
				paramMap.put("fromDate", fromDate);
				paramMap.put("toDate", toDate);
			}
		}

		PaginationInfo paginationInfo = new PaginationInfo();
		int pageSize =  10;
		int page = 1 ;
		String temp = (String)paramMap.get("pageSize");
		if (!EgovStringUtil.isEmpty(temp )  ) {
			pageSize = Integer.parseInt(temp) ;
		}
		temp = (String)paramMap.get("page") ;
		if (!EgovStringUtil.isEmpty(temp )  ) {
			page = Integer.parseInt(temp) ;
		}
		
		paginationInfo.setPageSize(pageSize);
		paginationInfo.setCurrentPageNo(page);
		return paginationInfo;
	}	    
    
	
	@RequestMapping("/purchase/PurchaseInfo.do")
	public ModelAndView PurchaseInfo(@RequestParam Map<String, Object> params, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		params.put("groupSeq", loginVo.getGroupSeq());
		
		Map<String, Object> resultData = purchaseServiceDAO.SelectPurchaseDetail(params);
		
		mv.addObject("resultData", resultData);
		mv.addObject("resultCode", "success");	
		mv.setViewName("jsonView");
		return mv;
	}	
    
    @SuppressWarnings("unchecked")
	@RequestMapping("/interlock/SelectShoppingList.do")
    public ModelAndView SelectShoppingList(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
        ModelAndView mv = new ModelAndView();
        
        /* 변수 설정 */
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
        
        if(loginVo == null) {
        	return mv;
        }
        
        params.put("groupSeq", loginVo.getGroupSeq());
        params.put("useYn", "Y");
        params.put("group", "option");
        params.put("code", "ServiceKey");
        List<Map<String, Object>> ServiceKey = commonServiceDAO.SelectPurchaseDetailCodeList(params);
        
        String interlockApiUrl = "";
        
        if(ServiceKey.size() > 0) {
        	params.put("ServiceKey", ServiceKey.get(0).get("NOTE"));
        	interlockApiUrl = ServiceKey.get(0).get("LINK").toString();
        }         
		
		params.put("type", "json");
		params.put("numOfRows", params.get("pageSize"));
		params.put("pageNo", params.get("page"));
		
		params.put("inqryBgnDate", params.get("inqryBgnDate").toString().replaceAll("-", ""));
		params.put("inqryEndDate", params.get("inqryEndDate").toString().replaceAll("-", ""));
		
		String queryString = "";
		
		//Query String 생성 
		for (String mapKey : params.keySet()) {
			queryString += (queryString.equals("") ? "?" : "&") + mapKey + "=" + URLEncoder.encode(params.get(mapKey).toString(),"UTF-8");
		}   		
		
        HttpURLConnection connection = (HttpURLConnection) new URL(interlockApiUrl + queryString).openConnection();
        connection.setRequestMethod("GET");
        connection.connect();		
        String result = HttpJsonUtil.readInputStream(connection.getInputStream());
        
        JSONObject interfaceResult = new JSONObject();
        interfaceResult = JSONObject.fromObject(result);
		
		mv.addAllObjects(interfaceResult);

        mv.setViewName("jsonView");

        return mv;
    }        
    
    
    
    @RequestMapping(value="/purchase/PurchaseSaveProc.do", method={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public ModelAndView PurchaseSaveProc(@RequestParam Map<String,Object> params, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();

		params.put("groupSeq", loginVo.getGroupSeq());
		params.put("created_by", loginVo.getUniqId());
		
		purchaseService.InsertPurchase(params);
		
		mv.addObject("resultData", params);
		mv.addObject("resultCode", "success");	
		mv.setViewName("jsonView");
		return mv;
	}
    
    
    @RequestMapping("/purchase/SelectPurchasePaymentList.do")
    @ResponseBody
    public ModelAndView SelectPurchasePaymentList(@RequestParam Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
    	
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo = getPaginationInfo(paramMap);
		
		LoginVO loginVO = CommonConvert.CommonGetEmpVO();
		paramMap.put("loginvo", loginVO);
		
		Map<String,Object> resultMap = null;
		try {
			resultMap = purchaseServiceDAO.SelectPurchasePaymentList(paramMap, paginationInfo);
		} catch (Exception e) {
			resultMap = new HashMap<String,Object>();
			e.printStackTrace();
			logger.error(e);
		}
	 
		ModelAndView mv = new ModelAndView();
		mv.setViewName("jsonView");
		mv.addAllObjects(resultMap);	// data.result
		return mv;    	
    
    } 	    
    
    
	@RequestMapping("/purchase/PurchasePaymentResInfo.do")
	public ModelAndView PurchasePaymentResInfo(@RequestParam Map<String, Object> params, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		params.put("groupSeq", loginVo.getGroupSeq());
		
		Map<String, Object> result = new HashMap<String, Object>( );
		Map<String, Object> contractInfo = purchaseServiceDAO.SelectPurchaseDetail(params);
		
		if(contractInfo != null) {
			
			params.put("outProcessCode", "Purchase01");
			result.put("conclusionBudgetList", commonServiceDAO.SelectBudgetList(params));
			result.put("conclusionTradeList", commonServiceDAO.SelectTradeList(params));
			result.put("conclusionPaymentAmt", purchaseServiceDAO.SelectPurchasePaymentAmt(params));
			result.put("consDocInfo", purchaseServiceDAO.SelectPurchaseConsDocInfo(params));
			
		}
		
		mv.addObject("resultData", result);
		mv.addObject("resultCode", "success");	
		mv.setViewName("jsonView");
		return mv;
	}	
	
	@RequestMapping("/purchase/PurchasePaymentDocInfoCheck.do")
	public ModelAndView PurchasePaymentDocInfoCheck(@RequestParam Map<String, Object> params, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		params.put("groupSeq", loginVo.getGroupSeq());
		
		Map<String, Object> paymentDocInfoCheck = purchaseServiceDAO.SelectPurchasePaymentDocInfoCheck(params);
		
		if(paymentDocInfoCheck.get("FAIL_DUPLICATE").equals("Y")) {
			mv.addObject("resultCode", "FAIL_DUPLICATE");	
		}else if(paymentDocInfoCheck.get("FAIL_RES_AMT_OVER").equals("Y")) {
			mv.addObject("resultCode", "FAIL_RES_AMT_OVER");	
		}else {

			Map<String, Object> resdocInfo = commonServiceDAO.SelectResdocInfo(params);
			
			if(resdocInfo != null) {
				params.put("outProcessCode", resdocInfo.get("out_process_interface_id"));
				params.put("seq", resdocInfo.get("out_process_interface_m_id"));
				commonServiceDAO.DeletePaymentDocInfo(params);
				 
				params.put("resAmt", params.get("tryAmt"));
				params.put("remainAmt", "0");
				params.put("created_by", loginVo.getUniqId());
				commonServiceDAO.InsertPaymentDocInfo(params);
			}
			
			mv.addObject("resultCode", "SUCCESS");	
		}
		
		mv.setViewName("jsonView");
		return mv;
	}    
    
    

}

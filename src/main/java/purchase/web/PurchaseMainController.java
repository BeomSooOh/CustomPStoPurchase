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
            
        	/*
            params.put("useYn", "Y");
            params.put("group", "resFormSeq");
            params.put("code", "CONCLUSION");
            List<Map<String, Object>> resFormSeq = commonServiceDAO.SelectPurchaseDetailCodeList(params);
            
            if(resFormSeq.size() > 0) {
            	mv.addObject("resFormSeq", resFormSeq.get(0).get("LINK"));	
            }
            */
            
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
        mv.addObject("authLevel", authLevel);
        params.put("authLevel", authLevel);
        
        /* 변수 설정 */
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
        params.put("groupSeq", loginVo.getGroupSeq());
        
        List<Map<String, Object>> list = purchaseService.SelectPurchaseList(params);
        mv.addObject("resultList", list);
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
    
    

}

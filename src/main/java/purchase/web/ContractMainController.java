package purchase.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
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
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.fcc.service.EgovFileUploadUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import neos.cmm.util.DateUtil;
import purchase.service.CommonServiceDAO;
import purchase.service.ContractService;
import purchase.service.ContractServiceDAO;
import common.vo.common.CommonMapper;
import common.vo.common.CommonMapInterface.commonExPath;
import common.vo.interlock.InterlockExpendVO;

@Controller
public class ContractMainController {

    /* ################################################## */
    /* 변수정의 */
    /* ################################################## */
    private final org.apache.logging.log4j.Logger logger = LogManager.getLogger(this.getClass());
    
    /* 변수정의 - Service */
    //@Resource(name = "BExAdminReportService")
    //private BExAdminReportService reportService;
    
    @Resource(name = "CommonInfo")
    private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
    
    @Resource(name = "ContractService")
    private ContractService contractService;       
    
    @Resource(name = "ContractServiceDAO")
    private ContractServiceDAO contractServiceDAO;    	   

    @Resource(name = "CommonServiceDAO")
    private CommonServiceDAO commonServiceDAO;    	  
    
    
    @RequestMapping("/purchase/{authLevel}/ContractList.do")
    public ModelAndView ContractList(@PathVariable String authLevel, @RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
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
            List<Map<String, Object>> resFormSeq = commonServiceDAO.SelectPurchaseDetailCodeList(params);
            
            Map<String, Object> queryParam = new HashMap<String, Object>();
            queryParam.put("groupSeq", loginVo.getGroupSeq());
            queryParam.put("useYn", "Y");
            List<Map<String, Object>> codeList = commonServiceDAO.SelectPurchaseDetailCodeList(queryParam);
            
            List<Map<String, Object>> targetType = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> contractType = new ArrayList<Map<String, Object>>();
            
            if(codeList != null && codeList.size() > 0) {
            	
            	for (Map<String, Object> codeinfo : codeList) {
                	if(codeinfo.get("GROUP").equals("targetType")) {
        				targetType.add(codeinfo);
        			}else if(codeinfo.get("GROUP").equals("contractType")) {
        				contractType.add(codeinfo);
        			}            		
            	}
                
            }
            
            
            if(resFormSeq.size() > 0) {
            	mv.addObject("resFormSeq", resFormSeq.get(0).get("LINK"));
            }
            mv.addObject("contractTypeCode", contractType);
            mv.addObject("targetTypeCode", targetType);
            mv.setViewName("/purchase/content/ContractList");

        } catch (Exception e) {
            e.printStackTrace();
            ExpInfo.ProcessLog(e.getLocalizedMessage());
            mv.addObject("errMsg", e.getMessage());
            mv.setViewName(CommonMapper.GetExError());
            logger.error(e);
        }
        return mv;
    }
    
    
    @RequestMapping("/purchase/{authLevel}/SelectContractList.do")
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
		
		Map<String,Object> resultMap = contractServiceDAO.SelectContractList(params, paginationInfo);        	
		mv.addAllObjects(resultMap);
        
        mv.setViewName("jsonView");

        return mv;
    }    
    
    @RequestMapping(value="/purchase/ContractSaveProc.do", method={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public ModelAndView ContractSaveProc(@RequestParam Map<String,Object> params, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();

		params.put("groupSeq", loginVo.getGroupSeq());
		params.put("manage_no", "");
		params.put("contract_no", "");
		params.put("created_by", loginVo.getUniqId());
		
		contractService.InsertContract(params);
		
		mv.addObject("resultData", params);
		mv.addObject("resultCode", "success");	
		mv.setViewName("jsonView");
		return mv;
	}
    
    @RequestMapping(value="/purchase/ConclusionSaveProc.do", method={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public ModelAndView ConclusionSaveProc(@RequestParam Map<String,Object> params, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();

		params.put("groupSeq", loginVo.getGroupSeq());
		params.put("created_by", loginVo.getUniqId());
		
		contractService.InsertConclusion(params);
		
		mv.addObject("resultData", params);
		mv.addObject("resultCode", "success");	
		mv.setViewName("jsonView");
		return mv;
	} 
    
    @RequestMapping(value="/purchase/ConclusionChangeSaveProc.do", method={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public ModelAndView ConclusionChangeSaveProc(@RequestParam Map<String,Object> params, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();

		params.put("groupSeq", loginVo.getGroupSeq());
		params.put("created_by", loginVo.getUniqId());
		
		contractService.InsertConclusionChange(params);
		
		mv.addObject("resultData", params);
		mv.addObject("resultCode", "success");	
		mv.setViewName("jsonView");
		return mv;
	}    
    
    @RequestMapping("/purchase/SelectTradeAmt.do")
    @ResponseBody
    public ModelAndView SelectTradeAmt(@RequestParam Map<String, Object> paramMap, HttpServletRequest request) throws Exception {

		Map<String,Object> resultMap = null;
		resultMap = contractServiceDAO.SelectTradeAmt(paramMap);

	 
		ModelAndView mv = new ModelAndView();
		mv.setViewName("jsonView");
		mv.addAllObjects(resultMap);	// data.result
		return mv;    	
    } 	

    @RequestMapping(value="/purchase/MeetSaveProc.do", method={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public ModelAndView MeetSaveProc(@RequestParam Map<String,Object> params, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();

		params.put("groupSeq", loginVo.getGroupSeq());
		params.put("created_by", loginVo.getUniqId());
		
		contractService.UpdateMeet(params);
		
		mv.addObject("resultData", params);
		mv.addObject("resultCode", "success");	
		mv.setViewName("jsonView");
		return mv;
	}    
    
    @RequestMapping(value="/purchase/ResultSaveProc.do", method={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public ModelAndView ResultSaveProc(@RequestParam Map<String,Object> params, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();

		params.put("groupSeq", loginVo.getGroupSeq());
		params.put("created_by", loginVo.getUniqId());
		
		contractServiceDAO.UpdateResult(params);
		
		mv.addObject("resultData", params);
		mv.addObject("resultCode", "success");	
		mv.setViewName("jsonView");
		return mv;
	}     
    
    
	@RequestMapping("/purchase/ContractInfo.do")
	public ModelAndView ContractInfo(@RequestParam Map<String, Object> params, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		params.put("groupSeq", loginVo.getGroupSeq());
		
		Map<String, Object> resultData = contractServiceDAO.SelectContractDetail(params);
		
		mv.addObject("resultData", resultData);
		mv.addObject("resultCode", "success");	
		mv.setViewName("jsonView");
		return mv;
	}
	
	
    @RequestMapping("/purchase/SelectConclusionPaymentList.do")
    @ResponseBody
    public ModelAndView SelectConclusionPaymentList(@RequestParam Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
    	
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo = getPaginationInfo(paramMap);
		
		LoginVO loginVO = CommonConvert.CommonGetEmpVO();
		paramMap.put("loginvo", loginVO);
		
		Map<String,Object> resultMap = null;
		try {
			resultMap = contractServiceDAO.SelectConclusionPaymentList(paramMap, paginationInfo);
		} catch (Exception e) {
			resultMap = new HashMap<String,Object>();
			e.printStackTrace();
			logger.error(e);
		}
	 
		ModelAndView mv = new ModelAndView();
		mv.setViewName("jsonView");
		mv.addAllObjects(resultMap);	// data.result
		return mv;    	
    	
    	
    	/*
        ModelAndView mv = new ModelAndView();
        
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
        params.put("groupSeq", loginVo.getGroupSeq());
        
        List<Map<String, Object>> list = contractServiceDAO.SelectConclusionPaymentList(params);
        mv.addObject("resultList", list);
        mv.setViewName("jsonView");

        return mv;
        */
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
    

	@RequestMapping("/purchase/ConclutionPaymentResInfo.do")
	public ModelAndView ConclutionPaymentResInfo(@RequestParam Map<String, Object> params, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		params.put("groupSeq", loginVo.getGroupSeq());
		
		Map<String, Object> result = new HashMap<String, Object>( );
		Map<String, Object> contractInfo = contractServiceDAO.SelectContractDetail(params);
		
		if(contractInfo != null) {
			
			result.put("contractInfo", contractInfo);
			params.put("consMode", "Y");
			
			
			if (!contractInfo.get("approkey_change").equals("") && !contractInfo.get("change_result_amt_info_html").equals("")) {
				params.put("outProcessCode", "Conclusion02");
				params.put("consOutProcessCode", "Conclu02");
			}else if(contractInfo.get("contract_type").equals("01")) {
					params.put("outProcessCode", "Conclusion01-1");
					params.put("consOutProcessCode", "Conclu01");
			}else {
				params.put("outProcessCode", "Conclusion01-2");
				params.put("consOutProcessCode", "Conclu01");
			}
			
			result.put("conclusionBudgetList", commonServiceDAO.SelectBudgetList(params));
			
			if(contractInfo.get("contract_type").equals("01")) {
				params.put("outProcessCode", "Conclusion01-1");
			}else {
				params.put("outProcessCode", "Conclusion01-2");
			}
			
			result.put("conclusionTradeList", commonServiceDAO.SelectTradeList(params));
			result.put("conclusionPaymentAmt", contractServiceDAO.SelectConclusionPaymentAmt(params));
			result.put("consDocInfo", contractServiceDAO.SelectConclusionConsDocInfo(params));
			
		}
		
		mv.addObject("resultData", result);
		mv.addObject("resultCode", "success");	
		mv.setViewName("jsonView");
		return mv;
	}	
	
	@RequestMapping("/purchase/ConclutionPaymentDocInfoCheck.do")
	public ModelAndView ConclutionPaymentDocInfoCheck(@RequestParam Map<String, Object> params, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		params.put("groupSeq", loginVo.getGroupSeq());
		
		Map<String, Object> paymentDocInfoCheck = contractServiceDAO.SelectConclutionPaymentDocInfoCheck(params);
		
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
	
	
    @RequestMapping(value="/purchase/ContractAdminChangeProc.do", method={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public ModelAndView ContractAdminChangeProc(@RequestParam Map<String,Object> params, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();

		params.put("groupSeq", loginVo.getGroupSeq());
		params.put("created_by", loginVo.getUniqId());
		params.put("compSeq", loginVo.getOrganId());
		params.put("empSeq", loginVo.getUniqId());
		params.put("deptName", loginVo.getOrgnztNm());
		params.put("positionName", loginVo.getPositionNm());
		params.put("empName", loginVo.getName());
		
		contractService.ContractAdminChangeProc(params);
		
		mv.addObject("resultData", params);
		mv.addObject("resultCode", "success");	
		mv.setViewName("jsonView");
		return mv;
	}	
	
    
    @RequestMapping(value="/purchase/deleteContractList.do", method={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public ModelAndView deleteContractList(@RequestParam Map<String,Object> params, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();

		params.put("groupSeq", loginVo.getGroupSeq());
		params.put("created_by", loginVo.getUniqId());
		
		contractService.deleteContractList(params);
				
		mv.addObject("resultData", params);
		
		if (params.get("resultCode") == "success" ) {
			mv.addObject("resultCode", "success");
		} else {
			mv.addObject("resultCode", "error");
		}
		mv.setViewName("jsonView");
		return mv;
	} 
    
	
    @RequestMapping(value="/purchase/modifyContractList.do", method={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public ModelAndView modifyContractList(@RequestParam Map<String,Object> params, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();

		params.put("groupSeq", loginVo.getGroupSeq());
		params.put("created_by", loginVo.getUniqId());
		

		
		 contractService.modifyContractList(params);
				
		mv.addObject("resultData", params);
		
		if (params.get("resultCode") == "success" ) {
			mv.addObject("resultCode", "success");
		} else {
			mv.addObject("resultCode", "error");
		}
		mv.setViewName("jsonView");
		return mv;
	} 
    
    
    
    @RequestMapping(value="/purchase/modifyApprContractList.do", method={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public ModelAndView modifyApprContractList(@RequestParam Map<String,Object> params, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();

		params.put("groupSeq", loginVo.getGroupSeq());
		params.put("created_by", loginVo.getUniqId());
		
		contractService.modifyApprContractList(params);
				
		mv.addObject("resultData", params);
		
		if (params.get("resultCode") == "success" ) {
			mv.addObject("resultCode", "success");
		} else {
			mv.addObject("resultCode", "error");
		}
		mv.setViewName("jsonView");
		return mv;
	} 
    
	
    
    @RequestMapping(value="/purchase/ReturnCancelContractList.do", method={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public ModelAndView ReturnCancelContractList(@RequestParam Map<String,Object> params, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();

		params.put("groupSeq", loginVo.getGroupSeq());
		params.put("created_by", loginVo.getUniqId());


		params.put("comp_seq", loginVo.getOrganId());
		params.put("conffer_return_emp_seq", loginVo.getUniqId());
		params.put("deptName", loginVo.getOrgnztNm());
		params.put("conffer_return_name", loginVo.getName());
		
		
		
		 contractService.ReturnCancelContractList(params);
				
		mv.addObject("resultData", params);
		
		if (params.get("resultCode") == "success" ) {
			mv.addObject("resultCode", "success");
		} else {
			mv.addObject("resultCode", "error");
		}
		mv.setViewName("jsonView");
		return mv;
	} 
    
}

package purchase.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
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
import purchase.service.ContractService;
import purchase.service.ContractServiceDAO;
import common.vo.common.CommonMapper;
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
    
    @RequestMapping("/purchase/{authLevel}/ContractList.do")
    public ModelAndView ContractList(@PathVariable String authLevel, @RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
        ModelAndView mv = new ModelAndView();
        mv.addObject("authLevel", authLevel);
        
        try {
            /* 변수 설정 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            params.put("groupSeq", loginVo.getGroupSeq());
            
            List<Map<String, Object>> list = contractService.SelectContractList(params);
            mv.addObject("resultList", list);
            
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
        mv.addObject("authLevel", authLevel);
        params.put("authLevel", authLevel);
        
        /* 변수 설정 */
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
        params.put("groupSeq", loginVo.getGroupSeq());
        
        List<Map<String, Object>> list = contractService.SelectContractList(params);
        mv.addObject("resultList", list);
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
    
    @RequestMapping(value="/purchase/MeetSaveProc.do", method={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public ModelAndView MeetSaveProc(@RequestParam Map<String,Object> params, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();

		params.put("groupSeq", loginVo.getGroupSeq());
		params.put("created_by", loginVo.getUniqId());
		
		contractServiceDAO.UpdateMeet(params);
		
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
    public ModelAndView SelectConclusionPaymentList(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
        ModelAndView mv = new ModelAndView();
        
        /* 변수 설정 */
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
        params.put("groupSeq", loginVo.getGroupSeq());
        
        List<Map<String, Object>> list = contractServiceDAO.SelectConclusionPaymentList(params);
        mv.addObject("resultList", list);
        mv.setViewName("jsonView");

        return mv;
    } 	

}

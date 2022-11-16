package purchase.web;

import java.io.File;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
import common.helper.exception.CheckAuthorityException;
import common.helper.exception.NotFoundLoginSessionException;
import common.helper.info.CommonInfo;
import common.helper.logger.ExpInfo;
import common.vo.common.CommonInterface.commonCode;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.fcc.service.EgovFileUploadUtil;
import egovframework.com.utl.sim.service.EgovFileTool;
import purchase.service.PurchaseService;
import purchase.service.PurchaseServiceDAO;
import common.vo.common.CommonMapper;



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
    
    @Resource(name = "PurchaseService")
    private PurchaseService purchaseService;    
    
    @Resource(name = "PurchaseServiceDAO")
    private PurchaseServiceDAO purchaseServiceDAO;    	    
    
    @RequestMapping("/purchase/pop/ContractCreatePop.do")
    public ModelAndView ContractCreatePop(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수 설정 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            
            //mv.addObject("loginVo", loginVo.toString());
            //mv.addObject("authLevel", "");
            
            //구매계약 전용코드 조회
            Map<String, Object> queryParam = new HashMap<String, Object>();
            queryParam.put("groupSeq", loginVo.getGroupSeq());
            queryParam.put("useYn", "Y");
            //전체코드 한번에 조회
            List<Map<String, Object>> codeList = purchaseServiceDAO.SelectPurchaseDetailCodeList(queryParam);
            
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
            
            List<Map<String, Object>> attachForm_Contract01 = new ArrayList<Map<String, Object>>();
            
            
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
        			}else if(codeinfo.get("GROUP").equals("attachForm_Contract_A01")) {
        				attachForm_Contract01.add(codeinfo);
        			}
        			
        		}            	
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
            mv.addObject("attachForm_Contract01", attachForm_Contract01);
            
            mv.addObject("loginVo", loginVo);
            
            mv.setViewName("/purchase/pop/ContractCreatePop");

        } catch (Exception e) {
            e.printStackTrace();
            ExpInfo.ProcessLog(e.getLocalizedMessage());
            mv.addObject("errMsg", e.getMessage());
            mv.setViewName(CommonMapper.GetExError());
            logger.error(e);
        }
        return mv;
    }   
    
    @RequestMapping("/purchase/layer/{layerName}.do")
    public ModelAndView CommonLayerView(@PathVariable String layerName, @RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
        ModelAndView mv = new ModelAndView();
        try {
            
            mv.setViewName("/purchase/layer/" + layerName);

        } catch (Exception e) {
            e.printStackTrace();
            ExpInfo.ProcessLog(e.getLocalizedMessage());
            mv.addObject("errMsg", e.getMessage());
            mv.setViewName(CommonMapper.GetExError());
            logger.error(e);
        }
        return mv;
    }     
    
    
	@RequestMapping("/purchase/ApprCreate.do")
	public ModelAndView ApprCreate(@RequestParam Map<String,Object> params, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {
		
		ModelAndView mv = new ModelAndView();
		
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		
		params.put("groupSeq", loginVo.getGroupSeq());
		params.put("compSeq", loginVo.getOrganId());
		params.put("deptSeq", loginVo.getOrgnztId());
		params.put("empSeq", loginVo.getUniqId());
		
		Map<String, Object> detailInfo = new HashMap<String, Object>();
		
		params.put("mod", "W");
		
		if(params.get("outProcessCode").equals("Contract01")) {
			
			detailInfo = purchaseServiceDAO.SelectContractDetail(params);
			params.put("approKey", "Contract01_" + params.get("seq").toString());
			params.put("detailUrl", request.getContextPath() + "/purchase/pop/ContractCreatePop.do?seq=" + params.get("seq").toString());
			params.put("detailName", "정보수정");
			params.put("subjectStr", detailInfo.get("title"));
			params.put("contentsStr", detailInfo.get("work_info"));
			
			//첨부파일정보 조회
			List<Map<String, Object>> attachList = purchaseServiceDAO.SelectAttachList(params);
			
			if(attachList != null && attachList.size() > 0) {

				//자동첨부 임시폴더로 복사
				String fileKey = "N" + java.util.UUID.randomUUID().toString().replaceAll("-", "");
				
				params.put("osType", CommonUtil.osType());
				params.put("pathSeq", "0");
				Map<String, Object> pathMp = (Map<String, Object>) purchaseServiceDAO.select("PurchaseSQL.getGroupPathInfo", params);
				
				String targetForder = pathMp.get("absol_path").toString() + File.separator + "uploadTemp" + File.separator + fileKey;
				
				for (Map<String, Object> attachinfo : attachList) {
					
					String file_id = attachinfo.get("file_id").toString();
					
					String oriPath = pathMp.get("absol_path").toString() + File.separator + "purchase" + File.separator + file_id.substring(0, 4)+ File.separator + file_id.substring(4, 8) + File.separator + file_id;
					
					File trgDir = new File(oriPath);
					File srcDir = new File(targetForder);

					FileUtils.copyDirectory(srcDir, trgDir);					
					
					/*
					File[] files = new File(oriPath).listFiles();
					
			        for(File file : files) {
			        	file.
			        }					
					
					FileUtils.copyDirectory(null, null)
					oriPath
					
					EgovFileTool.copyFile("",targetForder);
					*/
				}
				
				params.put("fileKey", fileKey);
				
			}
			
			
						
		}
		
		String queryString = "";
		
		if(detailInfo != null) {
			
			//전자결재본문내용 전달
			if(params.get("contentsStr") != null){
				redirectAttributes.addFlashAttribute("contentsStr",params.get("contentsStr"));
				params.remove("contentsStr");
			}else{
				redirectAttributes.addFlashAttribute("contentsStr","");
			}
			
			//전자결재제목 전달
			if(params.get("subjectStr") != null){
				redirectAttributes.addFlashAttribute("subjectStr",params.get("subjectStr"));
				params.remove("subjectStr");
			}else{
				redirectAttributes.addFlashAttribute("subjectStr","");
			}			
			
			//Query String 생성 
			for (String mapKey : params.keySet()) {
				queryString += (queryString.equals("") ? "?" : "&") + mapKey + "=" + URLEncoder.encode(params.get(mapKey).toString(),"UTF-8");
			}			
		}

		String url = request.getScheme() + "://"+request.getServerName()+ ":" +request.getServerPort()+ "/" + loginVo.getEaType() + "/ea/docpop/bizboxOutProcess.do" + queryString;
		mv.setViewName("redirect:"+url);
		
		return mv;
	}    
    

}

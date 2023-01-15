package purchase.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.net.URLEncoder;
import java.util.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

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
import common.helper.info.CommonInfo;
import common.helper.logger.ExpInfo;
import purchase.service.ContractService;
import purchase.service.ContractServiceDAO;
import purchase.service.PurchaseServiceDAO;
import purchase.service.CommonService;
import purchase.service.CommonServiceDAO;
import common.vo.common.CommonMapper;
import neos.cmm.util.DateUtil;



@Controller
public class CommonPopController {

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
    
    @Resource(name = "ContractService")
    private ContractService contractService;    
    
    @Resource(name = "ContractServiceDAO")
    private ContractServiceDAO contractServiceDAO;
    
    @Resource(name = "PurchaseServiceDAO")
    private PurchaseServiceDAO purchaseServiceDAO;    
    
    @RequestMapping("/purchase/layer/{layerName}.do")
    public ModelAndView CommonLayerView(@PathVariable String layerName, @RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
        ModelAndView mv = new ModelAndView();
        try {
        	mv.addObject("params", params);
            mv.setViewName("/purchase/layer/" + layerName);
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            params.put("groupSeq", loginVo.getGroupSeq());
            params.put("useYn", "Y");
            
            if(layerName.equals("NoticePopLayer")) {
            	
            	params.put("group", "contentsForm");
            	params.put("code", params.get("formCode"));
            	
            	Map<String, Object> formInfo = commonServiceDAO.SelectPurchaseDetailCodeInfo(params);
            	
            	if(formInfo != null) {
            		mv.addObject("FORM_HTML", formInfo.get("FORM_HTML"));	
            	}
                
            }else if(layerName.equals("CodeSelectLayer")) {
            	
                //코드도움 데이터 조회
                List<Map<String, Object>> codeList = commonServiceDAO.SelectPurchaseDetailCodeList(params);            	
                mv.addObject("codeList", codeList);
                
            }else if(layerName.equals("greenStateSetLayer")) {
            	
            	params.put("res_doc_seq", params.get("resDocSeq"));
            	Map<String, Object> greenStateSetInfo = commonServiceDAO.SelectPurchaseResGreenInfo(params);
            	mv.addObject("greenStateSetInfo", greenStateSetInfo);
            	
            	params.put("group", "greenCertType");
                List<Map<String, Object>> greenCertTypeCode = commonServiceDAO.SelectPurchaseDetailCodeList(params);
                mv.addObject("greenCertTypeCode", greenCertTypeCode);
                
            	params.put("group", "greenClass");
                List<Map<String, Object>> greenClassCode = commonServiceDAO.SelectPurchaseDetailCodeList(params);
                mv.addObject("greenClassCode", greenClassCode);
                
            }else if(layerName.equals("hopeStateSetLayer")) {
            	
            	params.put("res_doc_seq", params.get("resDocSeq"));
            	List<Map<String, Object>> hopeStateSetInfoList = commonServiceDAO.SelectPurchaseResHopeInfoList(params);
            	mv.addObject("hopeStateSetInfoList", hopeStateSetInfoList);            	
            	
            	params.put("group", "hopeCompany");
                List<Map<String, Object>> hopeCompanyCode = commonServiceDAO.SelectPurchaseDetailCodeList(params);
                mv.addObject("hopeCompanyCode", hopeCompanyCode);            	
            	
            }
            

        } catch (Exception e) {
            e.printStackTrace();
            ExpInfo.ProcessLog(e.getLocalizedMessage());
            mv.addObject("errMsg", e.getMessage());
            mv.setViewName(CommonMapper.GetExError());
            logger.error(e);
        }
        return mv;
    }    
    
    
    @RequestMapping("/purchase/pop/CodeSelectPop.do")
    public ModelAndView CommonPopView(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
        ModelAndView mv = new ModelAndView();
        try {
        	
        	mv.addAllObjects(params);
        	
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
		
		Map<String, Object> apprFormData = new HashMap<String, Object>();
		Map<String, Object> formInfo = new HashMap<String, Object>();
		Map<String, Object> innerParam = new HashMap<String, Object>( );
		innerParam.putAll(params);
		
		params.put("mod", "W");
		
		if(params.get("outProcessCode").equals("Contract01") || 
				params.get("outProcessCode").equals("Contract02")  || 
				params.get("outProcessCode").equals("Contract03") || 
				params.get("outProcessCode").toString().contains("Conclu01") ||
				params.get("outProcessCode").equals("Conclu02") ||
				params.get("outProcessCode").equals("Purchase01") ||
				params.get("outProcessCode").equals("Purchase02")
				) {
			
			String FORM_HTML = "";
			apprFormData = commonServiceDAO.SelectApprFormData(params);
			params.put("group", "contentsForm");
			
			if(params.get("outProcessCode").equals("Conclu02")) {
				params.put("code", params.get("outProcessCode").toString() + "-" + apprFormData.get("contract_type").toString());
			}else {
				params.put("code", params.get("outProcessCode"));	
			}
			
			formInfo = commonServiceDAO.SelectPurchaseDetailCodeInfo(params);
			
			if(formInfo != null) {
				
				FORM_HTML = formInfo.get("FORM_HTML").toString();
				
				for( String strKey : apprFormData.keySet() ){
					String strValue = apprFormData.get(strKey) != null ? apprFormData.get(strKey).toString() : "";
					FORM_HTML = FORM_HTML.replace("$" + strKey + "$", strValue);
				}
				
				//전자결재 연동코드 적용
				innerParam.put("group", "eaFormReplaceCode");
				innerParam.put("useYn", "Y");
				innerParam.remove("code");
	            List<Map<String, Object>> eaFormCodeList = commonServiceDAO.SelectPurchaseDetailCodeList(innerParam);            
				
	    		for (Map<String, Object> eaFormCode : eaFormCodeList) {
	    			FORM_HTML = FORM_HTML.replace(eaFormCode.get("CODE").toString(), eaFormCode.get("NAME").toString());
	    		}	            
				
				params.put("contentsStr", FORM_HTML);
				
			}			
			
			params.put("approKey", params.get("outProcessCode").toString() + "_" + params.get("seq").toString());
			
			if(params.get("outProcessCode").equals("Contract01")) {
				params.put("detailUrl", request.getContextPath() + "/purchase/pop/ContractCreatePop.do?seq=" + params.get("seq").toString());
				params.put("subjectStr", apprFormData.get("title").toString() + " 입찰");
				
			}else if(params.get("outProcessCode").equals("Contract02")) {
				params.put("detailUrl", request.getContextPath() + "/purchase/pop/ContractMeetPop.do?seq=" + params.get("seq").toString());
				params.put("subjectStr", apprFormData.get("title").toString() + " 제안서 평가회의 개최");
				
			}else if(params.get("outProcessCode").equals("Contract03")) {
				params.put("detailUrl", request.getContextPath() + "/purchase/pop/ContractResultPop.do?seq=" + params.get("seq").toString());
				params.put("subjectStr", apprFormData.get("title").toString() + " 우선협상대상자 선정결과 보고");
			}else if(params.get("outProcessCode").toString().contains("Conclu01")) {
				params.put("detailUrl", request.getContextPath() + "/purchase/pop/ConclusionCreatePop.do?seq=" + params.get("seq").toString());
				params.put("subjectStr", apprFormData.get("title").toString() + " 계약체결");
				
            	if(apprFormData.get("contract_type").equals("01")) {
            		innerParam.put("outProcessCode", "Conclusion01-1");	
            	}else {
            		innerParam.put("outProcessCode", "Conclusion01-2");
            	}
            	
			}else if(params.get("outProcessCode").equals("Conclu02")) {
				
				params.put("detailUrl", request.getContextPath() + "/purchase/pop/ConclusionChangePop.do?seq=" + params.get("seq").toString() + "&change_seq=" + params.get("change_seq").toString());
				params.put("subjectStr", apprFormData.get("title").toString() + " 변경계약체결");
				
				innerParam.put("seq", innerParam.get("change_seq"));
				innerParam.put("outProcessCode", "Conclusion02");
				
				params.put("approKey", params.get("outProcessCode").toString() + "_" + params.get("seq").toString() + "_" + params.get("change_seq").toString());
            	
			}else if(params.get("outProcessCode").equals("Purchase01")) {
				params.put("detailUrl", request.getContextPath() + "/purchase/pop/PurchaseCreatePop.do?seq=" + params.get("seq").toString());
				params.put("subjectStr", apprFormData.get("title").toString());
			}else if(params.get("outProcessCode").equals("Purchase02")) {
				params.put("detailUrl", request.getContextPath() + "/purchase/pop/PurchaseCheckPop.do?seq=" + params.get("seq").toString());
				params.put("subjectStr", apprFormData.get("title").toString() + " 물품검사(수) 조서");
			}
			
			params.put("detailName", "정보수정");
			
			//첨부파일정보 조회
			List<Map<String, Object>> attachList = commonServiceDAO.SelectAttachList(innerParam);
			
			if(attachList != null && attachList.size() > 0) {

				//자동첨부 임시폴더로 복사
				String fileKey = "N" + java.util.UUID.randomUUID().toString().replaceAll("-", "");
				
				params.put("osType", CommonUtil.osType());
				params.put("pathSeq", "0");
				Map<String, Object> pathMp = commonServiceDAO.GetGroupPathInfo(params);
				
				String targetForder = pathMp.get("absol_path").toString() + File.separator + "uploadTemp" + File.separator + fileKey;
				
				for (Map<String, Object> attachinfo : attachList) {
					
					String file_id = attachinfo.get("file_id").toString();
					
					String oriPath = pathMp.get("absol_path").toString() + File.separator + "purchase" + File.separator + file_id.substring(0, 4)+ File.separator + file_id.substring(4, 8) + File.separator + file_id;
					
					File srcDir = new File(oriPath);
					
					if(srcDir.exists()) {
						
						File trgDir = new File(targetForder);
						
				    	// 디렉토리 생성
				    	if (! trgDir.getParentFile().exists()) {
				    		trgDir.getParentFile().mkdirs();
				    	}

						FileUtils.copyDirectory(srcDir, trgDir);							
					}
					
				}
				
				params.put("fileKey", fileKey);
				
				//물품구매품의 붙임문서 압축파일 생성
				if(params.get("outProcessCode").equals("Purchase01")) {
					
					String zipFileId = DateUtil.getCurrentDate("yyyyMMdd") + UUID.randomUUID().toString().replace("-", "");
					
					targetForder = pathMp.get("absol_path").toString() + File.separator + "purchase" + File.separator + zipFileId.substring(0, 4)+ File.separator + zipFileId.substring(4, 8) + File.separator + zipFileId;				
					
					String zipFilePath = targetForder + File.separator + params.get("approKey").toString() + ".zip";
					
					File zipFile = new File(zipFilePath);				
					
					// 디렉토리 생성
					if (! zipFile.getParentFile().exists()) {
						zipFile.getParentFile().mkdirs();
					}				
					
					byte[] buf = new byte[4096];
					
				    ZipOutputStream out = new ZipOutputStream(new FileOutputStream(zipFilePath));
				    
				    boolean zipFileCheck = false;
				    
					for (Map<String, Object> attachinfo : attachList) {
						
						String file_id = attachinfo.get("file_id").toString();
						
						String oriPath = pathMp.get("absol_path").toString() + File.separator + "purchase" + File.separator + file_id.substring(0, 4)+ File.separator + file_id.substring(4, 8) + File.separator + file_id;
						
						File srcDir = new File(oriPath);
						
						if(srcDir.exists()) {
							File oriFile = srcDir.listFiles()[0];
							
							FileInputStream in = new FileInputStream(oriFile);
							ZipEntry ze = new ZipEntry(oriFile.getName());
							out.putNextEntry(ze);
					        int len;
					        while ((len = in.read(buf)) > 0) {
					            out.write(buf, 0, len);
					        }
					          
					        out.closeEntry();
					        in.close();
					        
					        zipFileCheck = true;
						}
						
					}				    
					out.close();
					
					params.put("purchase_attach_info", zipFileCheck ? (params.get("approKey").toString() + "▦.zip▦" + zipFileId) : "");
					purchaseServiceDAO.UpdatePurchaseAttachInfo(params);
					
				}
			}
		}
		
		String queryString = "";
		
		if(apprFormData != null) {
			
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

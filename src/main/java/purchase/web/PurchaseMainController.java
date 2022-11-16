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
import purchase.service.PurchaseService;
import purchase.service.PurchaseServiceDAO;
import common.vo.common.CommonMapper;

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
    
    @Resource(name = "PurchaseService")
    private PurchaseService purchaseService;       
    
    @Resource(name = "PurchaseServiceDAO")
    private PurchaseServiceDAO purchaseServiceDAO;    	        
    
	@SuppressWarnings("unchecked")
	@RequestMapping("/ajaxFileUploadProc.do")
	public ModelAndView ajaxFileUploadProc(MultipartHttpServletRequest multiRequest,
			@RequestParam Map<String, Object> paramMap) throws Exception {

		ModelAndView mv = new ModelAndView();

		LoginVO loginVO = CommonConvert.CommonGetEmpVO();

		paramMap.put("groupSeq", loginVO.getGroupSeq());
		
		/** 파일 체크 */
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		if (files.isEmpty()) {
			mv.addObject("result", "Empty");
			mv.setViewName("jsonView");
			return mv;
		}

		// 순번
		MultipartFile file = null;
		String attachFileNm = "";
		
		String targetForder = paramMap.get("fileId").toString();
		
		//보안취약성 관련 수정(서버경로 재검색)
		paramMap.put("osType", CommonUtil.osType());
		paramMap.put("pathSeq", "0");
		Map<String, Object> pathMp = (Map<String, Object>) purchaseServiceDAO.select("PurchaseSQL.getGroupPathInfo", paramMap);
		
		targetForder = pathMp.get("absol_path").toString() + File.separator + "purchase" + File.separator + targetForder.substring(0, 4)+ File.separator + targetForder.substring(4, 8) + File.separator + targetForder;

		String fileName = paramMap.get("nfcFileNames").toString();

		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();

		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();			
			file = entry.getValue();
			
			attachFileNm = new String(org.apache.commons.codec.binary.Base64.decodeBase64(fileName.getBytes("UTF-8")), "UTF-8");

			/* 확장자 */
			int index = attachFileNm.lastIndexOf(".");
			if (index == -1) {
				continue;
			}
			
			String saveFilePath = targetForder + File.separator + attachFileNm;
									
			File saveFile = new File(saveFilePath);

			EgovFileUploadUtil.saveFile(file.getInputStream(), saveFile);

		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("attachFileNm", attachFileNm);

		mv.addAllObjects(resultMap);
		mv.setViewName("jsonView");
		return mv;
	}
	
	@SuppressWarnings({ "unchecked", "unused" })
	@RequestMapping("/fileDownloadProc.do")
    public void fileDownloadProc(HttpServletRequest request, @RequestParam Map<String, Object> paramMap, HttpServletResponse response) throws NotFoundLoginSessionException{

		LoginVO loginVO = CommonConvert.CommonGetEmpVO();

		if (loginVO == null || paramMap.get("fileId") == null || paramMap.get("fileId").equals("")) {
			return;
		}
		
		paramMap.put("groupSeq", loginVO.getGroupSeq());
		
		Map<String, Object> fileMap = new HashMap<String, Object>();
		
		//모듈별 공통 필수 변수
		FileInputStream fis = null;

		String fileId = paramMap.get("fileId").toString();
		
		String fileName = "";
		
		paramMap.put("osType", CommonUtil.osType());
		paramMap.put("pathSeq", "0");
		Map<String, Object> pathMp = (Map<String, Object>) purchaseServiceDAO.select("PurchaseSQL.getGroupPathInfo", paramMap);
		
		File rw = new File(pathMp.get("absol_path").toString() + File.separator + "purchase" + File.separator + fileId.substring(0, 4)+ File.separator + fileId.substring(4, 8) + File.separator + fileId);
		
		File[] fileArray = rw.listFiles();

		File fileInfo = fileArray[0];
		
		fileName = fileInfo.getName();

		try {
			
		    fis = new FileInputStream(fileInfo);

		    String browser = request.getHeader("User-Agent");

		    //파일 인코딩
		    if(browser.contains("MSIE") || browser.contains("Trident") || browser.contains("Edge")){
		    	fileName = URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20"); 
		    } 
		    else {
		    	fileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1"); 
		    }
		    
			response.setContentType(CommonUtil.getContentType(fileInfo).toString());
			response.setHeader("Content-Transfer-Encoding", "binary;");
	    	response.setHeader("Content-Disposition","attachment;filename=\"" + fileName+"\"");	
		    
		    if(Integer.MAX_VALUE >= fileInfo.length()) {
		    	response.setContentLength((int) fileInfo.length());
		    }else {		    	
		    	response.addHeader("Content-Length",Long.toString(fileInfo.length()));
		    }

			byte buffer[] = new byte[4096];
			int bytesRead = 0, byteBuffered = 0;
			
			while((bytesRead = fis.read(buffer)) > -1) {
				
				response.getOutputStream().write(buffer, 0, bytesRead);
				byteBuffered += bytesRead;
				
				//flush after 1MB
				if(byteBuffered > 1024*1024) {
					byteBuffered = 0;
					response.getOutputStream().flush();
				}
			}

			response.getOutputStream().flush();
			response.getOutputStream().close();
			
		} catch (FileNotFoundException e) {
			//System.out.println(e.getMessage());
		} catch (IOException e) {
			//System.out.println(e.getMessage());
		} finally {
			if (fis != null) {
				try {
					fis.close();
				} catch (Exception ignore) {
					//LOGGER.debug("IGNORE: {}", ignore.getMessage());
				}
			}
		}
    }	
    	
    
    @RequestMapping("/purchase/{authLevel}/ContractList.do")
    public ModelAndView ContractList(@PathVariable String authLevel, @RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
        ModelAndView mv = new ModelAndView();
        mv.addObject("authLevel", authLevel);
        
        try {
            /* 변수 설정 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            params.put("groupSeq", loginVo.getGroupSeq());
            
            List<Map<String, Object>> list = purchaseService.SelectContractList(params);
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
        
        List<Map<String, Object>> list = purchaseService.SelectContractList(params);
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

		//Map<String, Object> resultData = new HashMap<String, Object>();
		params.put("manage_no", "");
		params.put("contract_no", "");
		params.put("created_by", loginVo.getUniqId());
		
		purchaseService.InsertContract(params);
		
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
		
		Map<String, Object> resultData = purchaseServiceDAO.SelectContractDetail(params);
		
		mv.addObject("resultData", resultData);
		mv.addObject("resultCode", "success");	
		mv.setViewName("jsonView");
		return mv;
	}	
    
    

}

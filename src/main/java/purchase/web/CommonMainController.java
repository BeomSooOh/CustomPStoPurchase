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

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

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
import purchase.service.CommonService;
import purchase.service.CommonServiceDAO;
import common.vo.common.CommonMapper;
import common.vo.common.CommonMapInterface.commonExPath;
import common.vo.interlock.InterlockExpendVO;

@Controller
public class CommonMainController {

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
    
    @RequestMapping("/purchase/{authLevel}/OverallHopeAmtInfo.do")
    public ModelAndView OverallHopeAmtInfo(@PathVariable String authLevel, @RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
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
        	mv.addObject("deptSeq", loginVo.getOrgnztId());
        	mv.addObject("deptName", loginVo.getOrgnztNm());
        	mv.addObject("fromDate", fromDate);
        	mv.addObject("toDate", toDate);        
            
            mv.setViewName("/purchase/content/OverallHopeAmtInfo");

        } catch (Exception e) {
            e.printStackTrace();
            ExpInfo.ProcessLog(e.getLocalizedMessage());
            mv.addObject("errMsg", e.getMessage());
            mv.setViewName(CommonMapper.GetExError());
            logger.error(e);
        }
        return mv;
    }    
    
    
    @RequestMapping("/purchase/{authLevel}/SelectOverallHopeAmtInfo.do")
    public ModelAndView SelectOverallHopeAmtInfo(@PathVariable String authLevel, @RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
        ModelAndView mv = new ModelAndView();
        
        /* 변수 설정 */
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		params.put("groupSeq", loginVo.getGroupSeq());
		params.put("compSeq", loginVo.getOrganId());
//		params.put("deptSeq", loginVo.getOrgnztId());
		params.put("empSeq", loginVo.getUniqId());
		
		params.put("authLevel", authLevel);
		
		List<Map<String, Object>> resultMap = commonServiceDAO.SelectOverallHopeAmtInfo(params);        	
		mv.addObject("resultData", resultMap);
        
        mv.setViewName("jsonView");

        return mv;
    }     
    
    @RequestMapping("/purchase/{authLevel}/{amtType}/DeptHopeAmtInfo.do")
    public ModelAndView DeptHopeAmtInfo(@PathVariable String authLevel, @PathVariable String amtType, @RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
        ModelAndView mv = new ModelAndView();
        mv.addObject("authLevel", authLevel);
        mv.addObject("amtType", amtType);
        
        try {
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();  
            
            //메뉴접근 권한체크
            if(!commonServiceDAO.CheckAuthFromMenuInfo(loginVo, request.getServletPath())) {
            	//권한없음
            	mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKAUTH );
            	return mv;
            }
        	
        	String toDate = DateUtil.getCurrentDate("yyyy-MM-dd");
        	String fromDate = DateUtil.getCurrentDate("yyyy-01-01");
        	mv.addObject("deptSeq", loginVo.getOrgnztId());
        	mv.addObject("deptName", loginVo.getOrgnztNm());
        	mv.addObject("fromDate", fromDate);
        	mv.addObject("toDate", toDate);        
            
            mv.setViewName("/purchase/content/DeptHopeAmtInfo");

        } catch (Exception e) {
            e.printStackTrace();
            ExpInfo.ProcessLog(e.getLocalizedMessage());
            mv.addObject("errMsg", e.getMessage());
            mv.setViewName(CommonMapper.GetExError());
            logger.error(e);
        }
        return mv;
    } 
    
    
    @RequestMapping("/purchase/{authLevel}/{amtType}/SelectDeptHopeAmtInfo.do")
    public ModelAndView SelectDeptHopeAmtInfo(@PathVariable String authLevel, @PathVariable String amtType, @RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
        ModelAndView mv = new ModelAndView();
        
        /* 변수 설정 */
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		params.put("groupSeq", loginVo.getGroupSeq());
		params.put("compSeq", loginVo.getOrganId());
//		params.put("deptSeq", loginVo.getOrgnztId());
		params.put("empSeq", loginVo.getUniqId());
		params.put("authLevel", authLevel);
		params.put("amtType", amtType);
		
    	params.put("group", "hopeCompany");
        List<Map<String, Object>> hopeCompanyCode = commonServiceDAO.SelectPurchaseDetailCodeList(params);
        mv.addObject("hopeCompanyCode", hopeCompanyCode);       
        params.put("hopeCompanyCode", hopeCompanyCode);
		
		List<Map<String, Object>> resultMap = commonServiceDAO.SelectDeptHopeAmtInfo(params);        	
		mv.addObject("resultData", resultMap);
        
        mv.setViewName("jsonView");

        return mv;
    }      
    
    
    @RequestMapping("/purchase/{authLevel}/GreenAmtInfo.do")
    public ModelAndView GreenAmtInfo(@PathVariable String authLevel, @RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
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
        	String fromDate = DateUtil.getCurrentDate("yyyy-01-01");
        	mv.addObject("deptSeq", loginVo.getOrgnztId());
        	mv.addObject("deptName", loginVo.getOrgnztNm());
        	mv.addObject("fromDate", fromDate);
        	mv.addObject("toDate", toDate);        
            
            params.put("group", "");
            params.put("code", ""); 
            params.put("codeNotEmpty", "Y"); 
            List<Map<String, Object>> codeList = commonServiceDAO.SelectPurchaseDetailCodeList(params);            
            
            List<Map<String, Object>> greenCertType = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> greenClass = new ArrayList<Map<String, Object>>();
            
            if(codeList != null && codeList.size() > 0) {
            	
        		for (Map<String, Object> codeinfo : codeList) {
        			
        			if(codeinfo.get("GROUP").equals("greenCertType")) {
        				greenCertType.add(codeinfo);
        			}else if(codeinfo.get("GROUP").equals("greenClass")) {
        				greenClass.add(codeinfo);
        			}
        		}            	
            }        
            

            mv.addObject("greenCertType", greenCertType);	
            mv.addObject("greenClass", greenClass);	
	
            mv.setViewName("/purchase/content/GreenAmtInfo");

        } catch (Exception e) {
            e.printStackTrace();
            ExpInfo.ProcessLog(e.getLocalizedMessage());
            mv.addObject("errMsg", e.getMessage());
            mv.setViewName(CommonMapper.GetExError());
            logger.error(e);
        }
        return mv;
    }     
    
    
    @RequestMapping("/purchase/{authLevel}/SelectGreenAmtInfo.do")
    public ModelAndView SelectGreenAmtInfo(@PathVariable String authLevel, @RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
        ModelAndView mv = new ModelAndView();
        
        /* 변수 설정 */
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		params.put("groupSeq", loginVo.getGroupSeq());
		params.put("compSeq", loginVo.getOrganId());
//		params.put("deptSeq", loginVo.getOrgnztId());
		params.put("empSeq", loginVo.getUniqId());
		
		params.put("authLevel", authLevel);
		
		List<Map<String, Object>> resultMap = commonServiceDAO.SelectGreenAmtInfo(params);        	
		mv.addObject("resultData", resultMap);
        
        mv.setViewName("jsonView");

        return mv;
    }      
        
    
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
		Map<String, Object> pathMp = commonServiceDAO.GetGroupPathInfo(paramMap);
		
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
		Map<String, Object> pathMp = commonServiceDAO.GetGroupPathInfo(paramMap);
		
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
    	
    @RequestMapping(value="/attachSaveProc.do", method={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public ModelAndView attachSaveProc(@RequestParam Map<String,Object> params, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();

		params.put("created_by", loginVo.getUniqId());
		
		commonService.UpdateAttachInfo(params);
		
		mv.addObject("resultData", params);
		mv.addObject("resultCode", "success");	
		mv.setViewName("jsonView");
		return mv;
	}    
    
	@RequestMapping("/SelectFormInfo.do")
	public ModelAndView SelectFormInfo(@RequestParam Map<String, Object> params, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		params.put("groupSeq", loginVo.getGroupSeq());
		
		Map<String, Object> resultData = commonServiceDAO.SelectPurchaseDetailCodeInfo(params);
		
		mv.addObject("resultData", resultData);
		mv.addObject("resultCode", "success");	
		mv.setViewName("jsonView");
		return mv;
	}	
	
	@RequestMapping("/SaveFormInfo.do")
	public ModelAndView SaveFormInfo(@RequestParam Map<String, Object> params, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		params.put("groupSeq", loginVo.getGroupSeq());
		
		commonServiceDAO.SaveFormInfo(params);
		
		//mv.addObject("resultData", resultData);
		mv.addObject("resultCode", "success");	
		mv.setViewName("jsonView");
		return mv;
	}		
	
	
	
    @RequestMapping(value = "/purchase/ApprovalProcess.do", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public InterlockExpendVO ApprovalProcess(HttpServletRequest servletRequest, @RequestBody Map<String, Object> request, @RequestParam Map<String, Object> params) throws Exception {
    	InterlockExpendVO result = new InterlockExpendVO();
    	
    	try {
    		commonService.UpdateAppr(request);	
    		result.setResultCode("SUCCESS");
    	}catch(Exception ex) {
    		result.setResultCode("FAIL");
    		result.setResultMessage(ex.getMessage());
    	}
    	
    	return result;
    }
    
    
    @RequestMapping("/DelConsTemp.do")
    public ModelAndView DelConsTemp(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
    	ModelAndView mv = new ModelAndView();
    	
		commonService.DelConsTemp(params);	
		
//		params.put("processId", "Conclu02");
//		params.put("approKey", "Conclu02_227_32");
//		params.put("docSts", "90");
//		params.put("seq", params.get("out_process_interface_m_id"));
//		commonService.UpdateAppr(params);
		
		
		mv.addObject("resultCode", "SUCCESS");	
		mv.setViewName("jsonView");    	
    	
		return mv;
    }    

    
    @RequestMapping("confferReturn.do")
    public ModelAndView confferReturn(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
    	ModelAndView mv = new ModelAndView();
    	
		commonService.confferReturn(params);	
		
		mv.addObject("resultCode", "SUCCESS");	
		mv.setViewName("jsonView");    	
    	
		return mv;
    } 
    
    
    @RequestMapping("/updateDeptCons.do")
    public ModelAndView updateDeptCons(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
    	ModelAndView mv = new ModelAndView();
		commonService.updateDeptCons(params);	
		mv.addObject("resultCode", "SUCCESS");	
		mv.setViewName("jsonView");    	
    	
		return mv;
    } 
    
    @RequestMapping("/updateCempName.do")
    public ModelAndView updateCempName(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
    	ModelAndView mv = new ModelAndView();
		commonService.updateCempName(params);	
		mv.addObject("resultCode", "SUCCESS");	
		mv.setViewName("jsonView");    	
    	
		return mv;
    } 
    
    
    @RequestMapping("/SelConsTemp.do")
    public ModelAndView SellConsTemp(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
    	ModelAndView mv = new ModelAndView();
    	
		Map<String, Object> resultData = commonServiceDAO.SelConsTemp(params);
		
		mv.addObject("resultData", resultData);
		mv.addObject("resultCode", "SUCCESS");	
		mv.setViewName("jsonView");    	
    	
		return mv;
    } 
    
    @RequestMapping("/SelResTemp.do")
    public ModelAndView SelResTemp(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
    	ModelAndView mv = new ModelAndView();
		List<Map<String, Object>> resultData = commonServiceDAO.SelResTemp(params);
	
		mv.addObject("resultData", resultData);
		mv.addObject("resultCode", "SUCCESS");	
		mv.setViewName("jsonView");    	
    	
		return mv;
    }  
    
    
    
    @RequestMapping("/SelConsbudget.do")
    public ModelAndView SellConsbudget(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
    	ModelAndView mv = new ModelAndView();
    	
		Map<String, Object> resultData = commonServiceDAO.SelConsbudget(params);
		
		mv.addObject("resultData", resultData);
		mv.setViewName("jsonView");    	
    	
		return mv;
    }  
    
    
    
    @RequestMapping("/purchase/admin/FormEditor.do")
    public ModelAndView FormEditor(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
        ModelAndView mv = new ModelAndView();
        
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
        
        //메뉴접근 권한체크
        if(!commonServiceDAO.CheckAuthFromMenuInfo(loginVo, request.getServletPath())) {
        	//권한없음
        	mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKAUTH );
        	return mv;
        }        
        
        params.put("groupSeq", loginVo.getGroupSeq());
        params.put("group", "contentsForm");
        params.put("useYn", "Y");
        List<Map<String, Object>> formList = commonServiceDAO.SelectPurchaseDetailCodeList(params);            	
        mv.addObject("formList", formList);
        
        mv.setViewName("/purchase/content/FormEditor");

        return mv;
    }    
    
    
    @RequestMapping("/purchase/admin/CommonCodeEditor.do")
    public ModelAndView CommonCodeEditor(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
        ModelAndView mv = new ModelAndView();
        
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
        
        //메뉴접근 권한체크
        if(!commonServiceDAO.CheckAuthFromMenuInfo(loginVo, request.getServletPath())) {
        	//권한없음
        	mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKAUTH );
        	return mv;
        }        
        
        mv.setViewName("/purchase/content/CommonCodeEditor");

        return mv;
    }      
    
    
    @RequestMapping("/purchase/admin/CommonAttachFormEditor.do")
    public ModelAndView CommonAttachFormEditor(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
        ModelAndView mv = new ModelAndView();
        
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
        
        //메뉴접근 권한체크
        if(!commonServiceDAO.CheckAuthFromMenuInfo(loginVo, request.getServletPath())) {
        	//권한없음
        	mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKAUTH );
        	return mv;
        }        
        
        mv.setViewName("/purchase/content/CommonAttachFormEditor");

        return mv;
    }    
    

    @RequestMapping("/purchase/admin/SelectCodeGroupList.do")
    public ModelAndView SelectCodeGroupList(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
        ModelAndView mv = new ModelAndView();
        
        /* 변수 설정 */
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		params.put("groupSeq", loginVo.getGroupSeq());
		params.put("compSeq", loginVo.getOrganId());
		params.put("deptSeq", loginVo.getOrgnztId());
		params.put("empSeq", loginVo.getUniqId());
        
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo = getPaginationInfo(params);
		
		Map<String,Object> resultMap = commonServiceDAO.SelectCodeGroupList(params, paginationInfo);        	
		mv.addAllObjects(resultMap);
        
        mv.setViewName("jsonView");

        return mv;
    }  
    
    @RequestMapping("/purchase/admin/SelectCodeList.do")
    public ModelAndView SelectCodeList(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
        ModelAndView mv = new ModelAndView();
        
        /* 변수 설정 */
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		params.put("groupSeq", loginVo.getGroupSeq());
		params.put("compSeq", loginVo.getOrganId());
		params.put("deptSeq", loginVo.getOrgnztId());
		params.put("empSeq", loginVo.getUniqId());
        
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo = getPaginationInfo(params);
		
		Map<String,Object> resultMap = commonServiceDAO.SelectCodeList(params, paginationInfo);        	
		mv.addAllObjects(resultMap);
        
        mv.setViewName("jsonView");

        return mv;
    } 
    
    
    @RequestMapping(value="/purchase/admin/updateCommonCodeProc.do", method={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public ModelAndView updateCommonCodeProc(@RequestParam Map<String,Object> params, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();

		params.put("groupSeq", loginVo.getGroupSeq());
		params.put("created_by", loginVo.getUniqId());
		
		commonService.updateCommonCodeProc(params);
		
		mv.addObject("resultData", params);
		mv.addObject("resultCode", "success");	
		mv.setViewName("jsonView");
		return mv;
	}    
    
    
    @RequestMapping(value="/purchase/admin/deleteCommonCodeProc.do", method={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public ModelAndView deleteCommonCodeProc(@RequestParam Map<String,Object> params, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();

		params.put("groupSeq", loginVo.getGroupSeq());
		params.put("created_by", loginVo.getUniqId());
		
		commonService.deleteCommonCodeProc(params);
		
		mv.addObject("resultData", params);
		mv.addObject("resultCode", "success");	
		mv.setViewName("jsonView");
		return mv;
	}    
    
    @RequestMapping(value="/purchase/admin/fnCheckCodeValidation.do", method={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public ModelAndView fnCheckCodeValidation(@RequestParam Map<String,Object> params, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();

		params.put("groupSeq", loginVo.getGroupSeq());
		params.put("created_by", loginVo.getUniqId());
		params.put("group", params.get("GROUP"));
		params.put("code", params.get("CODE"));
		
		if(commonServiceDAO.SelectPurchaseDetailCodeInfo(params) == null) {
			mv.addObject("resultCode", "success");	
		}else {
			mv.addObject("resultCode", "duplication");
		}
		
		mv.setViewName("jsonView");
		return mv;
	}    
    
    @RequestMapping(value="/purchase/admin/insertCommonCodeProc.do", method={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public ModelAndView insertCommonCodeProc(@RequestParam Map<String,Object> params, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();

		params.put("groupSeq", loginVo.getGroupSeq());
		params.put("created_by", loginVo.getUniqId());
		params.put("group", params.get("GROUP"));
		params.put("code", params.get("CODE"));
		
		commonServiceDAO.InsertCodeInfo(params);
		
		mv.addObject("resultCode", "success");
		mv.setViewName("jsonView");
		return mv;
	}      
    
	private PaginationInfo getPaginationInfo(Map<String, Object> paramMap) {	
		
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
	

    @RequestMapping("/purchase/greenHopeInfo.do")
    public ModelAndView greenHopeInfo(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
        ModelAndView mv = new ModelAndView();
        
        /* 변수 설정 */
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		params.put("groupSeq", loginVo.getGroupSeq());
		params.put("compSeq", loginVo.getOrganId());
		params.put("deptSeq", loginVo.getOrgnztId());
		params.put("empSeq", loginVo.getUniqId());
        
//		Map<String,Object> resGreenInfo = commonServiceDAO.SelectPurchaseResGreenInfo(params);
		List<Map<String, Object>> resGreenInfo = commonServiceDAO.SelectPurchaseResGreenInfo(params);
		mv.addObject("resGreenInfo", resGreenInfo);
		
		List<Map<String, Object>> resHopeInfoList = commonServiceDAO.SelectPurchaseResHopeInfoList(params);
		mv.addObject("resHopeInfoList", resHopeInfoList);
        
        mv.setViewName("jsonView");

        return mv;
    }
    
    @RequestMapping("/purchase/saveGreenInfo.do")
    public ModelAndView saveGreenInfo(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
        ModelAndView mv = new ModelAndView();
        
        /* 변수 설정 */
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		params.put("groupSeq", loginVo.getGroupSeq());
		params.put("created_by", loginVo.getUniqId());
		
		commonService.saveGreenInfo(params);
        
		mv.addObject("resultCode", "SUCCESS");
        mv.setViewName("jsonView");

        return mv;
    }    
    
    @RequestMapping("/purchase/selectGreenInfo.do")
    public ModelAndView selectGreenInfo(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
        ModelAndView mv = new ModelAndView();
        
        /* 변수 설정 */
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		params.put("groupSeq", loginVo.getGroupSeq());
		
		mv.addObject("resultData", commonServiceDAO.SelectPurchaseResGreenInfo(params));
		mv.addObject("resultCode", "SUCCESS");
        mv.setViewName("jsonView");

        return mv;
    }
    
    @RequestMapping("/purchase/deleteGreenInfo.do")
    public ModelAndView deleteGreenInfo(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
        ModelAndView mv = new ModelAndView();
        
        /* 변수 설정 */
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		params.put("groupSeq", loginVo.getGroupSeq());
		
		commonServiceDAO.DeletePurchaseResGreenInfo(params);
		
		if(params.get("out_process_interface_id").equals("PURCHASE")) {
		
			commonServiceDAO.DeletePurchaseItemGreenInfo(params);
			
		}
		
		mv.addObject("resultCode", "SUCCESS");
        mv.setViewName("jsonView");

        return mv;
    }
    
    
    @RequestMapping("/purchase/saveHopeInfo.do")
    public ModelAndView saveHopeInfo(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
        ModelAndView mv = new ModelAndView();
        
        /* 변수 설정 */
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		params.put("groupSeq", loginVo.getGroupSeq());
		params.put("created_by", loginVo.getUniqId());
		
		commonService.saveHopeInfo(params);
        
		mv.addObject("resultCode", "SUCCESS");
        mv.setViewName("jsonView");

        return mv;
    }    
    
    @RequestMapping("/purchase/selectHopeInfo.do")
    public ModelAndView selectHopeInfo(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
        ModelAndView mv = new ModelAndView();
        
        /* 변수 설정 */
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		params.put("groupSeq", loginVo.getGroupSeq());
		
		mv.addObject("resultData", commonServiceDAO.SelectPurchaseResHopeInfoList(params));
		mv.addObject("resultCode", "SUCCESS");
        mv.setViewName("jsonView");

        return mv;
    }
    
    @RequestMapping("/purchase/deleteHopeInfo.do")
    public ModelAndView deleteHopeInfo(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
        ModelAndView mv = new ModelAndView();
        
        /* 변수 설정 */
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		params.put("groupSeq", loginVo.getGroupSeq());
		
		commonServiceDAO.DeletePurchaseResHopeInfo(params);
		
		
		if(params.get("out_process_interface_id").equals("PURCHASE")) {
			
			commonServiceDAO.DeletePurchaseTradeHopeInfo(params);
			
		}
		
		if(params.get("out_process_interface_id").equals("CONCLUSION")) {
			
			commonServiceDAO.DeletePurchaseContractHopeInfo(params);
			
		}
		
		
		
		mv.addObject("resultCode", "SUCCESS");
        mv.setViewName("jsonView");

        return mv;
    }    
    
}

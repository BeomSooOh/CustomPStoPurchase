package purchase.web;

import java.io.File;
import java.net.URLEncoder;
import java.util.Date;
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
import common.helper.info.CommonInfo;
import common.helper.logger.ExpInfo;
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
            
            mv.addObject("viewType", "I");
            mv.addObject("disabledYn", "N");
            mv.addObject("btnSaveYn", "Y");
            mv.addObject("btnApprYn", "Y");
            
            Map<String, Object> queryParam = new HashMap<String, Object>();
            queryParam.put("groupSeq", loginVo.getGroupSeq());
            
            //구매계약 전용코드 조회 (전체코드 한번에 조회)
            queryParam.put("useYn", "Y");
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
        			}else if(codeinfo.get("GROUP").equals("attachForm_Contract01")) {
        				attachForm_Contract01.add(codeinfo);
        			}
        			
        		}            	
            }
            
            //기존 작성정보 조회
            if(params.get("seq") != null && !params.get("seq").equals("")) {
            	Map<String, Object> detailInfo = purchaseServiceDAO.SelectContractDetail(params);
            	
            	if(detailInfo != null) {
            		
            		if(!detailInfo.get("doc_sts").equals("")) {
            			
            			//임시저장 버튼 표시
            			mv.addObject("btnSaveYn", "N");
            			
            			if(!detailInfo.get("approkey_meet").equals("") || !detailInfo.get("doc_sts").equals("10")) {
            				mv.addObject("btnApprYn", "N");
            				mv.addObject("disabledYn", "Y");
            				mv.addObject("disabled", "disabled");
            			}
            		}
            		
            		mv.addObject("viewType", "U");
            		mv.addObject("seq", params.get("seq"));
            		mv.addObject("contractDetailInfo", detailInfo);
            		
                	mv.addObject("createDeptName", detailInfo.get("write_dept_name"));
                	mv.addObject("createEmpName", detailInfo.get("write_emp_name"));
                	mv.addObject("write_comp_seq", detailInfo.get("write_comp_seq"));
                	mv.addObject("write_dept_seq", detailInfo.get("write_dept_seq"));
                	mv.addObject("write_emp_seq", detailInfo.get("write_emp_seq"));
                	mv.addObject("createSuperKey", loginVo.getGroupSeq() + "|" + detailInfo.get("write_comp_seq") + "|" + detailInfo.get("write_dept_seq") + "|" + detailInfo.get("write_emp_seq") + "|u");
                	mv.addObject("write_dt", detailInfo.get("write_dt"));
            		
            		params.put("outProcessCode", "Contract01");
            		List<Map<String, Object>> formAttachList = purchaseServiceDAO.SelectFormAttachList(params);
            		
            		mv.addObject("formAttachList", formAttachList);
            		
            	}else {
            		return mv;
            	}
            }else {
            	mv.addObject("formAttachList", attachForm_Contract01);
            	
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
    
    
    @RequestMapping("/purchase/pop/ConclusionCreatePop.do")
    public ModelAndView ConclusionCreatePop(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수 설정 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            
            mv.addObject("contractType", "02"); //수의계약 기본
            mv.addObject("viewType", "I");
            mv.addObject("disabledYn", "N");
            mv.addObject("btnSaveYn", "Y");
            mv.addObject("btnApprYn", "Y");
            
            Map<String, Object> queryParam = new HashMap<String, Object>();
            queryParam.put("groupSeq", loginVo.getGroupSeq());
            
            //구매계약 전용코드 조회 (전체코드 한번에 조회)
            queryParam.put("useYn", "Y");
            List<Map<String, Object>> codeList = purchaseServiceDAO.SelectPurchaseDetailCodeList(queryParam);
            
            List<Map<String, Object>> budgetType = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> targetType = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> contractTerm = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> contractYear = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> contractType = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> baseLaw = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> privateReason = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> hopeCompany = new ArrayList<Map<String, Object>>();
            
            List<Map<String, Object>> attachForm_Conclusion01_1 = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> attachForm_Conclusion01_2 = new ArrayList<Map<String, Object>>();
            
            if(codeList != null && codeList.size() > 0) {
            	
        		for (Map<String, Object> codeinfo : codeList) {
        			
        			if(codeinfo.get("GROUP").equals("budgetType")) {
        				budgetType.add(codeinfo);
        			}else if(codeinfo.get("GROUP").equals("targetType")) {
        				targetType.add(codeinfo);
        			}else if(codeinfo.get("GROUP").equals("contractTerm")) {
        				contractTerm.add(codeinfo);
        			}else if(codeinfo.get("GROUP").equals("contractYear")) {
        				contractYear.add(codeinfo);
        			}else if(codeinfo.get("GROUP").equals("contractType")) {
        				contractType.add(codeinfo);
        			}else if(codeinfo.get("GROUP").equals("baseLaw")) {
        				baseLaw.add(codeinfo);
        			}else if(codeinfo.get("GROUP").equals("privateReason")) {
        				privateReason.add(codeinfo);
        			}else if(codeinfo.get("GROUP").equals("hopeCompany")) {
        				hopeCompany.add(codeinfo);
        			}else if(codeinfo.get("GROUP").equals("attachForm_Conclusion01-1")) {
        				attachForm_Conclusion01_1.add(codeinfo);
        			}else if(codeinfo.get("GROUP").equals("attachForm_Conclusion01-2")) {
        				attachForm_Conclusion01_2.add(codeinfo);
        			}
        			
        		}            	
            }
            
            //기존 작성정보 조회
            if(params.get("seq") != null && !params.get("seq").equals("")) {
            	
            	Map<String, Object> detailInfo = purchaseServiceDAO.SelectContractDetail(params);
            	
            	if(detailInfo != null) {
            		
            		if(!detailInfo.get("approkey_conclusion").equals("")) {
            			
            			//임시저장 버튼 표시
            			mv.addObject("btnSaveYn", "N");
            			
            			if(!detailInfo.get("doc_sts").equals("10")) {
            				mv.addObject("btnApprYn", "N");
            				mv.addObject("disabledYn", "Y");
            				mv.addObject("disabled", "disabled");
            			}
            		}            		
            		
            		mv.addObject("viewType", "U");
            		mv.addObject("seq", params.get("seq"));
            		mv.addObject("contractDetailInfo", detailInfo);
            		
                	mv.addObject("createDeptName", detailInfo.get("c_write_dept_name"));
                	mv.addObject("createEmpName", detailInfo.get("c_write_emp_name"));
                	mv.addObject("c_write_comp_seq", detailInfo.get("c_write_comp_seq"));
                	mv.addObject("c_write_dept_seq", detailInfo.get("c_write_dept_seq"));
                	mv.addObject("c_write_emp_seq", detailInfo.get("c_write_emp_seq"));
                	mv.addObject("createSuperKey", loginVo.getGroupSeq() + "|" + detailInfo.get("c_write_comp_seq") + "|" + detailInfo.get("c_write_dept_seq") + "|" + detailInfo.get("c_write_emp_seq") + "|u");
                	mv.addObject("c_write_dt", detailInfo.get("c_write_dt"));
            		
                	if(detailInfo.get("contract_type").equals("01")) {
                		params.put("outProcessCode", "Conclusion01-1");	
                	}else {
                		params.put("outProcessCode", "Conclusion01-2");
                	}
                	
            		params.put("outProcessCode", "Conclusion01");
            		List<Map<String, Object>> formAttachList = purchaseServiceDAO.SelectFormAttachList(params);
            		
            		mv.addObject("formAttachList", formAttachList);
            		
            	}else {
            		return mv;
            	}

            	
            }else {
            	mv.addObject("attachForm_Conclusion01", attachForm_Conclusion01_2);
            	
            	mv.addObject("createDeptName", loginVo.getOrgnztNm());
            	mv.addObject("createEmpName", loginVo.getName());
            	mv.addObject("c_write_comp_seq", loginVo.getOrganId());
            	mv.addObject("c_write_dept_seq", loginVo.getOrgnztId());
            	mv.addObject("c_write_emp_seq", loginVo.getUniqId());
            	mv.addObject("createSuperKey", loginVo.getGroupSeq() + "|" + loginVo.getOrganId() + "|" + loginVo.getOrgnztId() + "|" + loginVo.getUniqId() + "|u");
            	mv.addObject("c_write_dt", CommonUtil.date(new Date(), "yyyy-MM-dd"));
            }
            
            mv.addObject("budgetTypeCode", budgetType);
            mv.addObject("targetTypeCode", targetType);
            mv.addObject("contractTermCode", contractTerm);
            mv.addObject("contractYearCode", contractYear);
            mv.addObject("contractTypeCode", contractType);
            mv.addObject("baseLawCode", baseLaw);
            mv.addObject("privateReasonCode", privateReason);
            mv.addObject("hopeCompanyCode", hopeCompany);
            
            mv.addObject("loginVo", loginVo);
            
            mv.setViewName("/purchase/pop/ConclusionCreatePop");

        } catch (Exception e) {
            e.printStackTrace();
            ExpInfo.ProcessLog(e.getLocalizedMessage());
            mv.addObject("errMsg", e.getMessage());
            mv.setViewName(CommonMapper.GetExError());
            logger.error(e);
        }
        return mv;
    }     
    
    
    @RequestMapping("/purchase/pop/ContractMeetPop.do")
    public ModelAndView ContractMeetPop(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
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
        	Map<String, Object> detailInfo = purchaseServiceDAO.SelectContractDetail(params);
        	
            List<String> timeCodeList = new ArrayList<String>();
            List<String> minCodeList = new ArrayList<String>();
            
			for(int i=0;i<24;i++){
				timeCodeList.add((i < 10 ? "0" : "") + i);
			}            
			mv.addObject("timeCodeList", timeCodeList);
			
			for(int i=0;i<60;i = i+5){
				minCodeList.add((i < 10 ? "0" : "") + i);
			}
			mv.addObject("minCodeList", minCodeList);
        	
        	if(detailInfo != null) {
        		
        		if(!detailInfo.get("approkey_meet").equals("")) {
        			
        			//임시저장 버튼 표시
        			mv.addObject("btnSaveYn", "N");
        			
        			if(!detailInfo.get("doc_sts").equals("10")) {
        				mv.addObject("btnApprYn", "N");
        				mv.addObject("disabledYn", "Y");
        				mv.addObject("disabled", "disabled");
        			}
        		}
        		
        		//경쟁방식 text 조회 
        		if(!detailInfo.get("compete_type").equals("")) {
        			queryParam.put("group", "competeType");
        			queryParam.put("value", detailInfo.get("compete_type"));
        			detailInfo.put("compete_type_text", purchaseServiceDAO.GetCodeText(queryParam));
        		}else {
        			detailInfo.put("compete_type_text", "");
        		}
        		
        		//낙찰자 결정방법 text 조회 
        		if(!detailInfo.get("decision_type_info").equals("")) {
        			queryParam.put("group", "decisionType");
        			queryParam.put("value", detailInfo.get("decision_type_info"));
        			detailInfo.put("decision_type_info_text", purchaseServiceDAO.GetCodeText(queryParam));
        		}else {
        			detailInfo.put("decision_type_info_text", "");
        		}
        		
        		//평가회의 일시정보 설정
        		if(!detailInfo.get("meet_dt").equals("")) {
        			String meet_dt = detailInfo.get("meet_dt").toString();
        			detailInfo.put("meet_dt", meet_dt.substring(0,10));
        			detailInfo.put("meet_start_hh", meet_dt.substring(14,16));
        			detailInfo.put("meet_start_mm", meet_dt.substring(17,19));
        			detailInfo.put("meet_end_hh", meet_dt.substring(20,22));
        			detailInfo.put("meet_end_mm", meet_dt.substring(23,25));     
        		}
        		
        		mv.addObject("viewType", "U");
        		mv.addObject("seq", params.get("seq"));
        		mv.addObject("contractDetailInfo", detailInfo);
        		
        		params.put("outProcessCode", "Contract02");
        		List<Map<String, Object>> formAttachList = purchaseServiceDAO.SelectFormAttachList(params);
        		
        		mv.addObject("formAttachList", formAttachList);
        		
        	}else {
        		return mv;
        	}
            
            mv.addObject("loginVo", loginVo);
            
            mv.setViewName("/purchase/pop/ContractMeetPop");

        } catch (Exception e) {
            e.printStackTrace();
            ExpInfo.ProcessLog(e.getLocalizedMessage());
            mv.addObject("errMsg", e.getMessage());
            mv.setViewName(CommonMapper.GetExError());
            logger.error(e);
        }
        return mv;
    }       
    
    @RequestMapping("/purchase/pop/ContractResultPop.do")
    public ModelAndView ContractResultPop(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
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
        	Map<String, Object> detailInfo = purchaseServiceDAO.SelectContractDetail(params);
        	
        	if(detailInfo != null) {
        		
        		if(!detailInfo.get("approkey_result").equals("")) {
        			
        			//임시저장 버튼 표시
        			mv.addObject("btnSaveYn", "N");
        			
        			if(!detailInfo.get("doc_sts").equals("10")) {
        				mv.addObject("btnApprYn", "N");
        				mv.addObject("disabledYn", "Y");
        				mv.addObject("disabled", "disabled");
        			}
        		}
        		
                //구매계약 전용코드 조회
                queryParam.put("useYn", "Y");
                queryParam.put("group", "scoreType");
                List<Map<String, Object>> scoreTypeCode = purchaseServiceDAO.SelectPurchaseDetailCodeList(queryParam);
                mv.addObject("scoreTypeCode", scoreTypeCode);
        		
        		//경쟁방식 text 조회 
        		if(!detailInfo.get("compete_type").equals("")) {
        			queryParam.put("group", "competeType");
        			queryParam.put("value", detailInfo.get("compete_type"));
        			detailInfo.put("compete_type_text", purchaseServiceDAO.GetCodeText(queryParam));
        		}else {
        			detailInfo.put("compete_type_text", "");
        		}
        		
        		//낙찰자 결정방법 text 조회 
        		if(!detailInfo.get("decision_type_info").equals("")) {
        			queryParam.put("group", "decisionType");
        			queryParam.put("value", detailInfo.get("decision_type_info"));
        			detailInfo.put("decision_type_info_text", purchaseServiceDAO.GetCodeText(queryParam));
        		}else {
        			detailInfo.put("decision_type_info_text", "");
        		}        		
        		
        		mv.addObject("viewType", "U");
        		mv.addObject("seq", params.get("seq"));
        		mv.addObject("contractDetailInfo", detailInfo);
        		
        		params.put("outProcessCode", "Contract03");
        		List<Map<String, Object>> formAttachList = purchaseServiceDAO.SelectFormAttachList(params);
        		
        		mv.addObject("formAttachList", formAttachList);
        		
        	}else {
        		return mv;
        	}
            
            mv.addObject("loginVo", loginVo);
            
            mv.setViewName("/purchase/pop/ContractResultPop");

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
        	mv.addObject("params", params);
            mv.setViewName("/purchase/layer/" + layerName);
            
            //코드도움 데이터 조회
            if(layerName.equals("CodeSelectLayer")) {
                LoginVO loginVo = CommonConvert.CommonGetEmpVO();
                params.put("groupSeq", loginVo.getGroupSeq());
                params.put("useYn", "Y");
                List<Map<String, Object>> codeList = purchaseServiceDAO.SelectPurchaseDetailCodeList(params);            	
                mv.addObject("codeList", codeList);
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
    
    
	@RequestMapping("/purchase/ApprCreate.do")
	public ModelAndView ApprCreate(@RequestParam Map<String,Object> params, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {
		
		ModelAndView mv = new ModelAndView();
		
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		
		params.put("groupSeq", loginVo.getGroupSeq());
		params.put("compSeq", loginVo.getOrganId());
		params.put("deptSeq", loginVo.getOrgnztId());
		params.put("empSeq", loginVo.getUniqId());
		
		Map<String, Object> apprFormData = new HashMap<String, Object>();
		Map<String, Object> formInfo = new HashMap<String, Object>();
		
		params.put("mod", "W");
		
		if(params.get("outProcessCode").equals("Contract01") || params.get("outProcessCode").equals("Contract02")  || params.get("outProcessCode").equals("Contract03")) {
			
			apprFormData = purchaseServiceDAO.SelectApprFormData(params);
			
			params.put("group", "contentsForm");
			params.put("code", params.get("outProcessCode"));
			formInfo = purchaseServiceDAO.SelectPurchaseDetailCodeInfo(params);
			params.put("approKey", params.get("outProcessCode").toString() + "_" + params.get("seq").toString());
			
			if(params.get("outProcessCode").equals("Contract01")) {
				params.put("detailUrl", request.getContextPath() + "/purchase/pop/ContractCreatePop.do?seq=" + params.get("seq").toString());
				params.put("subjectStr", apprFormData.get("title"));
				
			}else if(params.get("outProcessCode").equals("Contract02")) {
				params.put("detailUrl", request.getContextPath() + "/purchase/pop/ContractMeetPop.do?seq=" + params.get("seq").toString());
				params.put("subjectStr", apprFormData.get("title").toString() + " 제안서 평가회의 개최");
				
			}else if(params.get("outProcessCode").equals("Contract03")) {
				params.put("detailUrl", request.getContextPath() + "/purchase/pop/ContractResultPop.do?seq=" + params.get("seq").toString());
				params.put("subjectStr", apprFormData.get("title").toString() + " 우선협상대상자 선정결과 보고");
			}
			
			if(formInfo != null) {
				
				String FORM_HTML = formInfo.get("FORM_HTML").toString();
				
				for( String strKey : apprFormData.keySet() ){
					String strValue = apprFormData.get(strKey) != null ? apprFormData.get(strKey).toString() : "";
					FORM_HTML = FORM_HTML.replace("$" + strKey + "$", strValue);
				}
				
				params.put("contentsStr", FORM_HTML);
				
			}
			
			params.put("detailName", "정보수정");
			
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
					
					File srcDir = new File(oriPath);
					File trgDir = new File(targetForder);
					
			    	// 디렉토리 생성
			    	if (! trgDir.getParentFile().exists()) {
			    		trgDir.getParentFile().mkdirs();
			    	}

					FileUtils.copyDirectory(srcDir, trgDir);					
					
				}
				
				params.put("fileKey", fileKey);
				
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
    
	
    @RequestMapping("/purchase/pop/FormEditor.do")
    public ModelAndView FormEditor(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/purchase/pop/FormEditor");

        return mv;
    }      

}

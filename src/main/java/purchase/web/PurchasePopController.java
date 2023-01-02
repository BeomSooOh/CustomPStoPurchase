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
import purchase.service.CommonService;
import purchase.service.CommonServiceDAO;
import purchase.service.PurchaseService;
import purchase.service.PurchaseServiceDAO;
import common.vo.common.CommonMapper;
import neos.cmm.util.DateUtil;



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
    
    @RequestMapping("/purchase/pop/PurchaseCreatePop.do")
    public ModelAndView PurchaseCreatePop(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
    	
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수 설정 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            
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
            	Map<String, Object> detailInfo = purchaseServiceDAO.SelectPurchaseDetail(params);
            	
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
            		List<Map<String, Object>> formAttachList = commonServiceDAO.SelectFormAttachList(params);
            		
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

}

/**
 *   * @FileName : VCommonPopController.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
package common.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import common.file.download.CommonFileDAO;
import common.helper.convert.CommonConvert;
import common.vo.common.CommonMapInterface.commonPath;
import egovframework.com.cmm.annotation.IncludedInfo;

/**
 *   * @FileName : VCommonPopController.java   * @Project : BizboxA_exp
 *   * @변경이력 :   * @프로그램 설명 :   
 */
@Controller
public class VCommonPopController {

	private static final Logger logger = LoggerFactory.getLogger(VCommonPopController.class);
	@Resource(name = "CommonFileDAO")
	private CommonFileDAO cmmFileDAO;

	/* ################################################## */
	/* 변수정의 */
	/* ################################################## */
	/* 변수정의 - Common */

	/* ################################################## */
	/* 공통 Popup */
	/* ################################################## */

	/* 공통 Popup 첨부파일 다운로드 */
	@RequestMapping("/common/FileDownload.do")
	public ModelAndView FileDownload(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		/* 변수정의 */
		ModelAndView mv = new ModelAndView();
		/* 프로세스 */
		try {
			/* 변수정의 */
			Map<String, Object> empInfo = new HashMap<String, Object>();
			/* 변수값 정의 */
			empInfo = CommonConvert.CommonGetEmpInfo();
			CommonConvert.CommonSetMapCopy(empInfo, params);
			/* 반환정보 가공 */
			mv.addObject("ViewBag", params);
			mv.setViewName(commonPath.POPPATH + commonPath.COMMONFILEDOWNLOAD);
		}
		catch (Exception e) {
			// TODO: handle exception
		}
		/* 반환처리 */
		return mv;
	}

	/* Bizbox Suite 전자결재 마이그레이션 첨부파일 다운로드 */
	@RequestMapping("/common/SuiteMigFileDownload.do")
	public ModelAndView SuiteMigFileDownload(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		// ?expend_seq=726&list_seq=1&slip_seq=0&group_seq=TCFS

		ModelAndView mv = new ModelAndView();

		try {
			Map<String, Object> empInfo = new HashMap<String, Object>();
			empInfo = CommonConvert.CommonGetEmpInfo();
			CommonConvert.CommonSetMapCopy(empInfo, params);
			mv.addObject("ViewBag", params);

			// 첨부파일 정보 조회
			List<Map<String, Object>> fileInfos = new ArrayList<Map<String, Object>>();
			fileInfos = cmmFileDAO.GetCommonSuiteMigFileSelectList(params);
			fileInfos = (fileInfos == null ? new ArrayList<Map<String, Object>>() : fileInfos);

			// [{fileSize=4935037, fileExtSn=, fileExtCn=null, fileSeq=SMIG_21215_1_1, pathSeq=1400, fileSn=1, fileStreCours=/mig/EX21215, orignlFileName=HDC신라용산면세점영수증1.jpg, streFileName=HDC신라용산면세점영수증1.jpg}]
					
			// /common/pop/CommonSuiteMigFileDownload
			mv.addObject("fileInfos", CommonConvert.CommonGetListMapToJson(fileInfos));
			mv.setViewName(commonPath.POPPATH + commonPath.COMMONSUITEMIGFILEDOWNLOAD);
		}
		catch (Exception e) {
			// TODO: handle exception
			logger.error("마이그레이션 첨부파일 View 오류 : " + e.getLocalizedMessage());
		}

		return mv;
	}

	@IncludedInfo(name = "[관리자] 표준적요 업로드", order = 1123, gid = 110)
	@RequestMapping("/common/SummaryExcelUpload.do")
	public ModelAndView SummaryExcelUpload(@RequestParam Map<String, Object> params, HttpServletRequest request) {
		/* 변수정의 */
		ModelAndView mv = new ModelAndView();

		/* 반환정보 가공 */
		mv.setViewName(commonPath.POPPATH + commonPath.SUMMARYEXCELUPLOADPOP);

		/* 반환처리 */
		return mv;
	}
}

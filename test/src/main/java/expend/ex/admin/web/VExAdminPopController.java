package expend.ex.admin.web;

import java.net.URLDecoder;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundLoginSessionException;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.CommonMapInterface.commonExPath;
import common.vo.common.ConnectionVO;
import common.vo.common.CustomLabelVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExCommonResultVO;
import expend.ex.admin.yesil.BExAdminYesilService;
import expend.ex.user.code.BExUserCodeService;


@Controller
public class VExAdminPopController {

	/* 변수정의 */
	/* 변수정의 - Service */
	@Resource ( name = "BExAdminYesilService" ) /* Yesil Service */
	private BExAdminYesilService yesilService;
	@Resource ( name = "BExUserCodeService" )
	private BExUserCodeService codeService;
	/* 변수정의 - Class */
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */

	/* Pop View - 예실대비 현황 - 선택 팝업 */
	@RequestMapping ( "/ex/expend/admin/ExAdminYesilPop.do" )
	public ModelAndView ExAdminYesilPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		/* Bizbox Alpha */
		/* 예실대비현황 > 부서,프로젝트,부문 > 선택 팝업 */
		/* iCUBE */
		ModelAndView mv = new ModelAndView( );
		try {
			/* 반환값 처리 */
			mv.addObject( "budgetFlag", params.get( "budgetFlag" ) );
			mv.addObject( "fromDt", params.get( "fromDt" ) );
			mv.addObject( "toDt", params.get( "toDt" ) );
			mv.addObject( "searchStr", params.get( "searchStr" ) );

			/* 명칭정보 사용 ViewObject */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			/* 반환 처리 */
			mv.addObject( "CL", vo.getData( ) );

			/* View path 정의 */
			mv.setViewName( commonExPath.ADMINPOPPATH + commonExPath.ADMINYESILPOP );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* Pop View - 예실대비 현황 - 지출결의현황 팝업 */
	@RequestMapping ( "/ex/expend/admin/ExAdminYesilDetailPop.do" )
	public ModelAndView ExAdminYesilDetailPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		/* Bizbox Alpha */
		/* 예실대비현황 > 지출결의현황 팝업 */
		/* iCUBE */
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			/* 반환값 처리 */

			mv.addObject( "budgetNm", params.get( "budgetNm" ) == null ? "" : URLDecoder.decode(params.get( "budgetNm" ).toString(), "UTF-8"));
			mv.addObject( "budgetCd", params.get( "budgetCd" ) );
			mv.addObject( "budgetYm", params.get( "budgetYm" ) );
			mv.addObject( "acctNm", params.get( "acctNm" ) == null ? "" : URLDecoder.decode(params.get( "acctNm" ).toString(), "UTF-8"));
			mv.addObject( "acctCd", params.get( "acctCd" ) );
			mv.addObject( "dataFg", params.get( "dataFg" ) );
			mv.addObject( "budYmType", params.get( "budYmType" ) );
			mv.addObject( "erpEmpCd", loginVo.getErpEmpCd( ) );

			/* 명칭정보 사용 ViewObject */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			/* 반환 처리 */
			mv.addObject( "CL", vo.getData( ) );

			/* View path 정의 */
			mv.setViewName( commonExPath.ADMINPOPPATH + commonExPath.ADMINYESILDETAILPOP );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* Pop View - 예실대비 현황2(PIVOT) - 결의부서 선택 팝업 */
	@RequestMapping ( "/ex/expend/admin/ExAdminYesil2DeptPop.do" )
	public ModelAndView ExAdminYesil2DeptPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		/* Bizbox Alpha */
		/* 예실대비현황2(PIVOT) > 결의부서 선택 팝업 */
		/* ERP iU */
		ModelAndView mv = new ModelAndView( );
		try {
			/* 명칭정보 사용 ViewObject */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			/* 반환 처리 */
			mv.addObject( "CL", vo.getData( ) );
			/* View path 정의 */
			mv.setViewName( commonExPath.ADMINPOPPATH + commonExPath.ADMINYESIL2DEPTPOP );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* Pop View - 예실대비 현황2(PIVOT) - 예산단위 그룹 선택 팝업 */
	@RequestMapping ( "/ex/expend/admin/ExAdminYesil2BudgetGrPop.do" )
	public ModelAndView ExAdminYesil2BudgetGrPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		/* Bizbox Alpha */
		/* 예실대비현황2(PIVOT) > 예산단위 선택 팝업 */
		/* ERP iU */
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ResultVO result = new ResultVO( );
			/* ERP 연결정보 조회 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			/* ERP 회사 코드 확인 */
			params.put( "erpCompSeq", codeService.getErpCompSeq( loginVo, conVo.getErpTypeCode( ), loginVo.getCompSeq( ) ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			result = yesilService.ExAdminYesil2SendParam( params );

			/* 명칭정보 사용 ViewObject */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			/* 반환 처리 */
			mv.addObject( "CL", vo.getData( ) );

			/* 반환처리 */
			mv.addObject( "ViewBag", result );
			/* View path 정의 */
			mv.setViewName( commonExPath.ADMINPOPPATH + commonExPath.ADMINYESIL2BUDGETGRPOP );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* Pop View - 예실대비 현황2(PIVOT) - 예산단위 선택 팝업 */
	@RequestMapping ( "/ex/expend/admin/ExAdminYesil2BudgetDeptPop.do" )
	public ModelAndView ExAdminYesil2BudgetDeptPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		/* Bizbox Alpha */
		/* 예실대비현황2(PIVOT) > 예산단위 선택 팝업 */
		/* ERP iU */
		ModelAndView mv = new ModelAndView( );
		try {
			mv.addObject( "authDept", params.get( "authDept" ) );

			/* 명칭정보 사용 ViewObject */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			/* 반환 처리 */
			mv.addObject( "CL", vo.getData( ) );

			/* View path 정의 */
			mv.setViewName( commonExPath.ADMINPOPPATH + commonExPath.ADMINYESIL2BUDGETDEPTPOP );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* Pop View - 예실대비 현황2(PIVOT) - 사업계획 선택 팝업 */
	@RequestMapping ( "/ex/expend/admin/ExAdminYesil2BizPlanPop.do" )
	public ModelAndView ExAdminYesil2BizPlanPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		/* Bizbox Alpha */
		/* 예실대비현황2(PIVOT) > 사업계획 선택 팝업 */
		/* ERP iU */
		ModelAndView mv = new ModelAndView( );
		try {
			/* 명칭정보 사용 ViewObject */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			/* 반환 처리 */
			mv.addObject( "CL", vo.getData( ) );

			/* View path 정의 */
			mv.setViewName( commonExPath.ADMINPOPPATH + commonExPath.ADMINYESIL2BIZPLANPOP );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* Pop View - 예실대비 현황2(PIVOT) - 예산계정 선택 팝업 */
	@RequestMapping ( "/ex/expend/admin/ExAdminYesil2BudgetAcctPop.do" )
	public ModelAndView ExAdminYesil2BudgetAcctPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		/* Bizbox Alpha */
		/* 예실대비현황2(PIVOT) > 예산계정 선택 팝업 */
		/* ERP iU */
		ModelAndView mv = new ModelAndView( );
		try {
			/* 명칭정보 사용 ViewObject */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			/* 반환 처리 */
			mv.addObject( "CL", vo.getData( ) );

			mv.addObject( "cdDeptPipe", params.get( "cdDeptPipe" ) );
			mv.addObject( "cdBudgetPipe", params.get( "cdBudgetPipe" ) );
			mv.addObject( "cdBizplanPipe", params.get( "cdBizplanPipe" ) );
			mv.addObject( "tpAclevel", params.get( "tpAclevel" ) );
			/* View path 정의 */
			mv.setViewName( commonExPath.ADMINPOPPATH + commonExPath.ADMINYESIL2BUDGETACCTPOP );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* Pop View - 예실대비 현황2(PIVOT) - 지출결의현황 팝업 */
	@RequestMapping ( "/ex/expend/admin/ExAdminYesil2DetailPop.do" )
	public ModelAndView ExAdminYesil2DetailPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		/* Bizbox Alpha */
		/* 예실대비현황2(PIVOT) > 지출결의현황 팝업 */
		/* ERP iU */
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			/* 반환값 처리 */
			mv.addObject( "deptCd", params.get( "deptCd" ));
			mv.addObject( "budgetNm", params.get( "budgetNm" ) == null ? "" : URLDecoder.decode(params.get( "budgetNm" ).toString(), "UTF-8"));
			mv.addObject( "budgetCd", params.get( "budgetCd" ));
			mv.addObject( "budgetYm", params.get( "budgetYm" ));
			mv.addObject( "acctNm", params.get( "acctNm" ) == null ? "" : URLDecoder.decode(params.get( "acctNm" ).toString(), "UTF-8"));
			mv.addObject( "acctCd", params.get( "acctCd" ));
			mv.addObject( "bizplanNm", params.get( "bizplanNm" ) == null ? "" : URLDecoder.decode(params.get( "bizplanNm" ).toString(), "UTF-8"));
			mv.addObject( "bizplanCd", params.get( "bizplanCd" ));
			mv.addObject( "dataFg", params.get( "dataFg" ));
			mv.addObject( "budYmType", params.get( "budYmType" ) == null ? "" : URLDecoder.decode(params.get( "budYmType" ).toString(), "UTF-8"));
			mv.addObject( "erpEmpCd", loginVo.getErpEmpCd( ) );

			/* 명칭정보 사용 ViewObject */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			/* 반환 처리 */
			mv.addObject( "CL", vo.getData( ) );

			/* View path 정의 */
			mv.setViewName( commonExPath.ADMINPOPPATH + commonExPath.ADMINYESIL2DETAILPOP );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* 양식 별 표준적요 & 증빙유형 설정 - 표준적요 선택 팝업 */
	@RequestMapping ( "/ex/expend/admin/ExFormLinkSummaryPop.do" )
	public ModelAndView ExFormLinSummaryPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		/* Bizbox Alpha */
		ModelAndView mv = new ModelAndView( );
		try {
			/* compSeq 정의 */
			params.put( commonCode.COMPSEQ, CommonConvert.CommonGetEmpInfo().get( commonCode.COMPSEQ ).toString( ) );
			mv.addObject( commonCode.FORMSEQ, params.get( commonCode.FORMSEQ ).toString( ) );

			/* 명칭정보 사용 ViewObject */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			/* 반환 처리 */
			mv.addObject( "CL", vo.getData( ) );

			/* View path 정의 */
			mv.setViewName( commonExPath.ADMINPOPPATH + commonExPath.ADMINFORMLINKSUMMARYPOP );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* 양식 별 표준적요 & 증빙유형 설정 - 증빙유형 선택 팝업 */
	@RequestMapping ( "/ex/expend/admin/ExFormLinkAuthPop.do" )
	public ModelAndView ExFormLinkAuthPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		/* Bizbox Alpha */
		ModelAndView mv = new ModelAndView( );
		try {
			/* compSeq 정의 */
			params.put( commonCode.COMPSEQ, CommonConvert.CommonGetEmpInfo().get( commonCode.COMPSEQ ).toString( ) );
			mv.addObject( commonCode.FORMSEQ, params.get( commonCode.FORMSEQ ).toString( ) );

			/* 명칭정보 사용 ViewObject */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			/* 반환 처리 */
			mv.addObject( "CL", vo.getData( ) );

			/* View path 정의 */
			mv.setViewName( commonExPath.ADMINPOPPATH + commonExPath.ADMINFORMLINKAUTHPOP );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* 지출결의 확인 마감 설정 팝업 */
	@RequestMapping ( "/ex/expend/admin/AdminCloseDatePop.do" )
	public ModelAndView AdminCloseDatePop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		/* Bizbox Alpha */
		ModelAndView mv = new ModelAndView( );
		try {
			/* compSeq 정의 */
			params.put( commonCode.COMPSEQ, CommonConvert.CommonGetEmpInfo().get( commonCode.COMPSEQ ).toString( ) );

			/* 명칭정보 사용 ViewObject */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			/* 반환 처리 */
			mv.addObject( "CL", vo.getData( ) );

			/* View path 정의 */
			mv.setViewName( commonExPath.ADMINPOPPATH + commonExPath.ADMINCLOSEDATEPOP );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* 회계 (사용자) - 지출결의 관리 - 나의 세금계산서 현황(ERPiU) - 계산서 이관 내역 팝업 */
	@RequestMapping ( "/ex/admin/report/ExAdminETaxTransferHistoryPop.do" )
	public ModelAndView ExAdminETaxTransferHistoryPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		/* Bizbox Alpha */
		ModelAndView mv = new ModelAndView( );
		try {
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			/* 변수정의 */
			@SuppressWarnings ( "unused" )
			ExCommonResultVO commonParam = new ExCommonResultVO( );
			params.put( "empInfo", CommonConvert.CommonGetMapToJSONObj( CommonConvert.CommonGetEmpInfo( ) ) );

			/* 명칭정보 사용 ViewObject */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			/* 반환 처리 */
			mv.addObject( "CL", vo.getData( ) );

			/* View path 정의 [UserCardReport.jsp] */
			mv.setViewName( commonExPath.USERPOPPATH + commonExPath.EXETAXTRANSFERHISTORYPOP );
		}
		catch ( NotFoundLoginSessionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
		}
		catch ( Exception ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
		}
		return mv;
	}
}

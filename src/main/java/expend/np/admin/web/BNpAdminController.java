package expend.np.admin.web;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.HashMap;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import bizbox.orgchart.service.vo.LoginVO;
import bizbox.orgchart.util.JedisClient;
import cloud.CloudConnetInfo;
import cmm.util.CommonUtil;
import common.helper.convert.CommonConvert;
import common.helper.convert.CommonException;
import common.helper.excel.CommonExcel;
import common.helper.exception.CheckAuthorityException;
import common.helper.exception.CheckErpTypeException;
import common.helper.exception.NotFoundLoginSessionException;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.procedure.npG20.BCommonProcService;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.CommonMapInterface.commonExPath;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import expend.ex.user.code.BExUserCodeService;
import expend.np.admin.card.BNpAdminCardService;
import expend.np.admin.config.BNpAdminConfigService;
import expend.np.admin.etax.BNpAdminETaxService;
import expend.np.admin.option.BNpAdminOptionService;
import expend.np.admin.report.BNpAdminReportService;
import expend.ex.cmm.BExCommonService;
//import expend.np.user.etax.BNpUserETaxService;


@Controller
public class BNpAdminController {

	/* 변수정의 */
	/* 변수정의 - Service */
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );
	@Resource ( name = "BNpAdminOptionService" )
	private BNpAdminOptionService optionService;
	@Resource ( name = "BNpAdminReportService" )
	private BNpAdminReportService reportService;
	@Resource ( name = "BNpAdminConfigService" )
	private BNpAdminConfigService configService;
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
	@Resource ( name = "BCommonProcService" )
	private BCommonProcService g20ProcService; /* G20 프로시저 연동 */
	@Resource ( name = "BNpAdminETaxService" )
	private BNpAdminETaxService eTaxService;
	@Resource ( name = "BExUserCodeService" )
	private BExUserCodeService exCodeService;
	@Resource(name = "BNpAdminETaxService")
	private BNpAdminETaxService	etaxService;					/* 세금계산서 정보 관리 */
	@Resource ( name = "BNpAdminCardService" )
	private BNpAdminCardService npCardService;
	@Resource ( name = "BCommonProcService" )
	private BCommonProcService procService;
	@Resource(name = "BExCommonService")
	private BExCommonService exCommonService;

	/* ------------------------- 프로시저 사용 데이터 조회 테스트 ------------------------- */
	@RequestMapping ( "/expend/np/admin/code/ExProcDataSelect.do" )
	public ModelAndView ExProcDataSelect ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/code/ExCodeInfoSelect.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		try {
			result = g20ProcService.getProcResult( params );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "공통 코드 조회 실패", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 공통 옵션 데이터 조회 */
	@RequestMapping ( "/expend/np/admin/option/NpAdminOptionSelect.do" )
	public ModelAndView NpAdminOptionSelect ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/option/NpAdminOptionSelect.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		try {
			/* 변수정의 */
			/* 세션 정보 조회 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			/* ERP 연결정보 조회 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			result = optionService.selectGWOption( params, conVo );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "공통 코드 조회 실패", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 공통 옵션 데이터 수정 */
	@RequestMapping ( "/expend/np/admin/option/NpAdminOptionUpdate.do" )
	public ModelAndView NpAdminOptionUpdate ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/option/NpAdminOptionUpdate.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		try {
			/* 변수정의 */
			/* 세션 정보 조회 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			/* ERP 연결정보 조회 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			result = optionService.updateGWOption( params, conVo );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "공통 코드 조회 실패", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 품의서 환원 여부 수정 */
	@RequestMapping ( "/expend/np/admin/report/NpAdminReportConfferReturnUpdate.do" )
	public ModelAndView NpAdminReportConfferReturnUpdate ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/report/NpAdminReportConfferReturnUpdate.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		try {
			/* 변수정의 */
			/* 세션 정보 조회 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			result = reportService.updateConfferReturnYN( params );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "공통 코드 조회 실패", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 지출결의 전송 리스트 조회 */
	@RequestMapping ( "/expend/np/admin/report/NpAdminSendListSelect.do" )
	public ModelAndView NpAdminSendListSelect ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/report/NpAdminSendListSelect.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		try {
			/* 변수정의 */
			/* 세션 정보 조회 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			params.put("compSeq", loginVo.getCompSeq());
			result = reportService.selectSendList( params );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "공통 코드 조회 실패", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 지출결의 전송 - 지출결의 삭제 */
	@RequestMapping ( "/expend/np/admin/report/NpAdminResDelete.do" )
	public ModelAndView NpAdminResDelete ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/report/NpAdminResDelete.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		try {
			/* 변수정의 */
			/* 세션 정보 조회 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			String requestDomain = request.getScheme() + "://" + ( request.getServerName() + ":" + request.getServerPort() );
            params.put( "requestDomain", requestDomain );
			result = reportService.NpAdminResDelete( params, conVo );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "공통 코드 조회 실패", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 지출결의 전송 */
	@RequestMapping ( "/expend/np/admin/report/NpAdminSendRes.do" )
	public ModelAndView NpAdminSendRes ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/report/NpAdminSendRes.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		try {
			/* 변수정의 */
			/* 세션 정보 조회 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			params.put("compSeq", CommonConvert.NullToString(loginVo.getCompSeq()));
			result = reportService.insertResSend( params, conVo );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "공통 코드 조회 실패", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 지출결의 전송 취소 */
	@RequestMapping ( "/expend/np/admin/report/NpAdminSendCancelRes.do" )
	public ModelAndView NpAdminSendCancelRes ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/report/NpAdminSendCancelRes.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		try {
			/* 변수정의 */
			/* 세션 정보 조회 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			result = reportService.deleteResSendCancel( params, conVo );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "공통 코드 조회 실패", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}
	//	/* 카드사용현황 */
	//	@RequestMapping ( "/expend/np/admin/report/NpAdminCardReportSelect.do" )
	//	public ModelAndView NpAdminCardReport ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
	//		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/report/NpAdminCardReportSelect.do] " + params.toString( ), "-", "EXNP" );
	//		ModelAndView mv = new ModelAndView( );
	//		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
	//		try {
	//			/* 변수정의 */
	//			result = reportService.selectCardReport( params );
	//		}
	//		catch ( Exception ex ) {
	//			ex.printStackTrace( );
	//		}
	//		finally {
	//			mv.setViewName( "jsonView" );
	//			mv.addObject( "result", result );
	//		}
	//		return mv;
	//	}

	/* 카드사용현황 */
	@RequestMapping ( "/expend/np/admin/report/NpAdminCardSetUseYN.do" )
	public ModelAndView NpAdminCardSetUseYN ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/report/NpAdminCardSetUseYN.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			/* 변수정의 */
			result = reportService.updateSendYN( params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "사용처리실패", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 품의결의 환경설정 - 옵션 조회 */
	@RequestMapping ( "/expend/np/admin/config/NpAdminConfigOptionSelect.do" )
	public ModelAndView NpAdminConfigOptionSelect ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/config/NpAdminConfigOptionSelect.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			/* 파라미터 정의 */
			if ( params.get( commonCode.COMPSEQ ) == null || CommonConvert.CommonGetStr(params.get( commonCode.COMPSEQ )).equals( "" ) ) {
				params.put( commonCode.COMPSEQ, CommonConvert.CommonGetEmpVO( ).getCompSeq( ) );
			}
			result.setAaData( configService.NpOptionListSelect( params ) );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "사용처리실패", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 품의결의 환경설정 - 옵션 변경 */
	@RequestMapping ( "/expend/np/admin/config/NpAdminConfigOptionUpdate.do" )
	public ModelAndView NpAdminConfigOptionUpdate ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/config/NpAdminConfigOptionUpdate.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			/* 파라미터 정의 */
			if ( params.get( commonCode.COMPSEQ ) == null || CommonConvert.CommonGetStr(params.get( commonCode.COMPSEQ )).equals( "" ) ) {
				params.put( commonCode.COMPSEQ, CommonConvert.CommonGetEmpVO( ).getCompSeq( ) );
			}
			if ( configService.NpOptionUpdate( params ) > 0 ) {
				result.setSuccess( );
			}
			else {
				result.setFail( "옵션 변경 실패" );
			}
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "사용처리실패", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 관리자 - 품의서 현황 - 품의현황 리스트 조회 */
	@RequestMapping ( "/expend/np/admin/NpAdminConsReportSelect.do" )
	public ModelAndView NpAdminConsReportSelect ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/report/NpAdminConsReportSelect.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			result = CommonConvert.setNpResultFormat( reportService.selectConsReport( params ) );
		}
		catch ( Exception ex ) {
			ex.printStackTrace( );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 관리자 - 품의서 반환 - 품의서 삭제 */
	@RequestMapping ( "/expend/np/admin/NpAdminConsReportDelete.do" )
	public ModelAndView NpAdminConsReportDelete ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/NpAdminConsReportDelete.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			String requestDomain = request.getScheme() + "://" + ( request.getServerName() + ":" + request.getServerPort() );
	        params.put( "requestDomain", requestDomain );
	        
			result = reportService.deleteConsDoc( params );
		}
		catch ( Exception ex ) {
			ex.printStackTrace( );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}
	
	/* 관리자 - 품의서 현황 - 반환/반환취소 */
	@RequestMapping ( "/expend/np/admin/NpAdminConsConfferStatusUpdate.do" )
	public ModelAndView NpUserConsConfferStatusUpdate ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/NpAdminConsConfferStatusUpdate.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			result = reportService.updateConfferStatus( params );
		}
		catch ( Exception ex ) {
			ex.printStackTrace( );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 관리자 - 품의서 현황 - 예산별 반환/반환취소 */
	@RequestMapping ( "/expend/np/admin/NpAdminConsConfferBudgetStatusUpdate.do" )
	public ModelAndView NpUserConsConfferBudgetStatusUpdate ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/NpUserConsConfferBudgetStatusUpdate.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			result = reportService.updateConfferBudgetStatus( params );
		}
		catch ( Exception ex ) {
			ex.printStackTrace( );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 관리자 - 품의서 현황 - 참조 결의 리스트 조회 */
	@RequestMapping ( "/expend/np/admin/NpAdminConsConfferResList.do" )
	public ModelAndView NpAdminConsConfferResList ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/NpAdminConsConfferResList.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			result = reportService.selectConsConfferResList( params );
		}
		catch ( Exception ex ) {
			ex.printStackTrace( );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 관리자 - 품의서 반환 - 품의서 예산목록 조회 */
	@RequestMapping ( "/expend/np/admin/NpAdminConsBudgetList.do" )
	public ModelAndView NpAdminConsBudgetList ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/NpAdminConsBudgetList.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			result = reportService.selectConsBudgetList( params );
		}
		catch ( Exception ex ) {
			ex.printStackTrace( );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 관리자 - 결의서 현황 - 결의현황 리스트 조회 */
	@RequestMapping ( "/expend/np/admin/NpAdminResReportSelect.do" )
	public ModelAndView NpAdminResReportSelect ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/report/NpAdminResReportSelect.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			result = reportService.selectResReport( params );
		}
		catch ( Exception ex ) {
			ex.printStackTrace( );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 관리자 - 기본설정 - 기본설정 옵션 조회 */
	@RequestMapping ( "/expend/np/admin/NpMasterOptionSelect.do" )
	public ModelAndView NpMasterOptionSelect ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/report/NpMasterOptionSelect.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			params.put( "compSeq", CommonConvert.CommonGetEmpVO( ).getCompSeq( ) );
			result.setAaData( configService.NpMasterOptionSelect( params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "기본설정 옵션 조회에 실패하였습니다.", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 관리자 - 기본설정 - 기본설정 옵션 변경 */
	@RequestMapping ( "/expend/np/admin/NpMasterOptionUpdate.do" )
	public ModelAndView NpMasterOptionUpdate ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/NpMasterOptionUpdate.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			params.put( "compSeq", CommonConvert.CommonGetEmpVO( ).getCompSeq( ) );
			params.put( "empSeq", CommonConvert.CommonGetEmpVO( ).getUniqId( ) );
			if ( configService.NpMasterOptionUpdate( params ) > 0 ) {
				result.setSuccess( );
			}
			else {
				result.setFail( "기본설정 옵션 저장에 실패하였습니다." );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "기본설정 옵션 저장에 실패하였습니다.", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 관리자 - 기본설정 - 참조품의 회사 조회 권한 부여 */
	@RequestMapping ( "/expend/np/admin/NpMasterOptionCompConsAuthUpdate.do" )
	public ModelAndView NpMasterOptionCompConsAuthUpdate ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/report/NpMasterOptionUpdate.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			params.put( "compSeq", CommonConvert.CommonGetEmpVO( ).getCompSeq( ) );
			params.put( "empSeq", CommonConvert.CommonGetEmpVO( ).getUniqId( ) );
			if ( configService.NpMasterOptionCompConsAuthUpdate( params ) > 0 ) {
				result.setSuccess( );
			}
			else {
				result.setFail( "기본설정 옵션 저장에 실패하였습니다." );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "기본설정 옵션 저장에 실패하였습니다.", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 관리자 - 기본설정 - 참조품의 회사 조회 권한 조회 */
	@RequestMapping ( "/expend/np/admin/NpMasterOptionCompConsAuthSelect.do" )
	public ModelAndView NpMasterOptionCompConsAuthSelect ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/report/NpMasterOptionUpdate.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			params.put( "compSeq", CommonConvert.CommonGetEmpVO( ).getCompSeq( ) );
			params.put( "empSeq", CommonConvert.CommonGetEmpVO( ).getUniqId( ) );
			result.setAaData( configService.NpMasterOptionCompConsAuthSelect( params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "기본설정 옵션 저장에 실패하였습니다.", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 관리자 - 기본설정 - 참조품의 회사 조회 권한 삭제 */
	@RequestMapping ( "/expend/np/admin/NpMasterOptionCompConsAuthDelete.do" )
	public ModelAndView NpMasterOptionCompConsAuthDelete ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/report/NpMasterOptionUpdate.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			params.put( "compSeq", CommonConvert.CommonGetEmpVO( ).getCompSeq( ) );
			params.put( "empSeq", CommonConvert.CommonGetEmpVO( ).getUniqId( ) );
			configService.NpMasterOptionCompConsAuthDelete( params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "기본설정 옵션 저장에 실패하였습니다.", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 매입전자세금계산서 현황 조회 */
	@RequestMapping ( "/expend/np/admin/NPETaxReportList.do" )
	public ModelAndView ExAdminiCUBEDocListReport ( @RequestParam Map<String, Object> param, HttpServletRequest request ) throws Exception {
		/* 로그인정보 */
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		/* ERP 연결정보 조회 */
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		result.setParams( param );
		try {
			result = reportService.NPAdminEtaxReportList( result, conVo );
			result.setResultCode( commonCode.SUCCESS );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 세금계산서현황 사용/미사용 처리 */
	@RequestMapping ( "/expend/np/admin/NPAdminETaxSetUseYN.do" )
	public ModelAndView ExAdminETaxSetUseYN ( @RequestParam Map<String, Object> param, HttpServletRequest request ) throws Exception {
		/* 변수 정의 */
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 정의 */
			param = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), param );
			param.put( "modifySeq", param.get( commonCode.EMPSEQ ).toString( ) );
			param.put( "createSeq", param.get( commonCode.EMPSEQ ).toString( ) );
			param.put( "modifyName", param.get( commonCode.EMPNAME ).toString( ) );
			result.setParams( param );
			reportService.NPAdminETaxSetUseYN( result );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( "" );
		}
		mv.setViewName( "jsonView" );
		mv.addObject( "result", result );
		return mv;
	}

	/* 관리자 - 항목설정 - 항목설정 옵션 변경 */
	@RequestMapping ( "/expend/np/admin/NpFormOptionSelect.do" )
	public ModelAndView NpFormOptionSelect ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/report/NpFormOptionSelect.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
		try {
			params.put( "erpType", conVo.getErpTypeCode( ) );
			params.put( "compSeq", CommonConvert.CommonGetEmpVO( ).getCompSeq( ) );
			params.put( "empSeq", CommonConvert.CommonGetEmpVO( ).getUniqId( ) );
			result.setAaData( configService.NpFormOptionSelect( params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "항목설정 옵션 조회에 실패하였습니다.", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 관리자 - 항목설정 - 항목설정 옵션 변경 */
	@RequestMapping ( "/expend/np/admin/NpFormOptionUpdate.do" )
	public ModelAndView NpFormOptionUpdate ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/report/NpFormOptionUpdate.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			params.put( "compSeq", CommonConvert.CommonGetEmpVO( ).getCompSeq( ) );
			params.put( "empSeq", CommonConvert.CommonGetEmpVO( ).getUniqId( ) );
			configService.NpFormOptionUpdate( params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "항목설정 옵션 조회에 실패하였습니다.", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* ## ############################################# ## */
	/* 매입전자세금계산서 현황 및 기능 2차 구현 - 김상겸 */
	/* ## ############################################# ## */
	/* 매입전자세금계산서 현황 조회 */
	@RequestMapping ( "/expend/np/admin/NpGetETaxList.do" )
	public ModelAndView NpGetETaxList ( @RequestParam Map<String, Object> param, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/NpGetETaxList.do] " + param.toString( ), "-", "EXNP" );
		/* ModelAndView */
		ModelAndView mv = new ModelAndView( );
		/* VO */
		LoginVO loginVo = new LoginVO( );
		ConnectionVO conVo = new ConnectionVO( );
		ResultVO result = new ResultVO( );
		try {
			/* [예외 검증] 로그인 세션 확인 */
			CommonException.Login( );
			loginVo = CommonConvert.CommonGetEmpVO( );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			result.setLoginVo( loginVo );
			/* [예외 검증] 권한 확인 */
			CommonException.AdminAuth( );
			/* [예외 검증] ERP 연동 확인 */
			CommonException.ERP( conVo );
			result.setParams( param );
			/* 세금계산서 목록 조회 */
			result = eTaxService.GetETaxList( result, conVo );
			result.setSuccess( );
			mv.setViewName( "jsonView" );


		}
		catch ( NotFoundLoginSessionException e ) {
			mv.addObject( "errMsg", e.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
		}
		catch ( CheckErpTypeException e ) {
			mv.addObject( "errMsg", e.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERP );
		}
		catch ( CheckAuthorityException e ) {
			mv.addObject( "errMsg", e.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKAUTH );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			mv.addObject( "errMsg", e.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
		}
		mv.addObject( "result", result );
		return mv;
	}

	/* 매입전자세금계산서 현황 엑셀 다운로드 */
	@RequestMapping ( "/expend/np/admin/NpGetETaxListExcel.do" )
	public void NpGetETaxListExcel ( @RequestParam Map<String, Object> param, HttpServletRequest request, HttpServletResponse response ) throws Exception {
		/* VO */
		LoginVO loginVo = new LoginVO();
		ConnectionVO conVo = new ConnectionVO();
		ResultVO result = new ResultVO();

		/* Map */
		Map<String, Object> map = new HashMap<String, Object>( );

		/* File */
		FileInputStream fileStream = null;
		BufferedInputStream bufferStream = null;
		ByteArrayOutputStream outStream = null;

		/* String */
		String fileName = "", filePath = "";

		try {
			/* [예외 검증] 로그인 세션 확인 */
			CommonException.Login( );
			loginVo = CommonConvert.CommonGetEmpVO( );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			result.setLoginVo( loginVo );

			/* [예외 검증] 권한 확인 */
			CommonException.AdminAuth( );

			/* [예외 검증] ERP 연동 확인 */
			CommonException.ERP( conVo );
			result.setParams( param );

			/* 세금계산서 목록 조회 */
			result = eTaxService.GetETaxList( result, conVo );

			for(Map<String, Object> item : result.getAaData( )){
				/* 사용 / 미사용 텍스트 보정 */
				String useYn = CommonConvert.NullToString( item.get( "useYn" ) );
				if( useYn.equals( "N" ) ){
					item.put( "useYn", "미사용" );
				}else {
					item.put( "useYn", "사용" );
				}

				/* 결의 / 미결의 텍스트 보정 */
				String sendYn = CommonConvert.NullToString( item.get( "sendYn" ) );
				if( sendYn.equals( "Y" ) ){
					item.put( "sendYn", "결의" );
				}else {
					item.put( "sendYn", "미결의" );
				}
			}

			/* 파일 명칭 정의 ( 매입전자세금계산서현황_20180101_사용자이름.xlsx ) */
			fileName = "매입전자세금계산서현황(관리자)_" + CommonConvert.CommonGetStr( param.get( "issDateFrom" ) ) + "_" + CommonConvert.CommonGetStr( param.get( "issDateTo" ) ) + "_" + loginVo.getName( ) + ".xlsx";

			/* 파일 경로 */
            map.put("osType", CommonUtil.osType());
			map.put( "pathSeq", commonCode.EXPPATHSEQ );
			map.put( commonCode.GROUPSEQ, loginVo.getGroupSeq( ) );
			map = exCodeService.ExCommonExpGroupPathSelect( map );

			if ( map == null || map.get( "absolPath" ) == null || map.get( "absolPath" ).toString( ).equals( "" ) ) {
				throw new Exception( "Group path not exists.." );
			}

			filePath = map.get( "absolPath" ).toString( ) + File.separator + commonCode.EXCELPATH + File.separator;

			/* 엑셀 생성 */
			if ( CommonExcel.CreateExcelFile( result.getAaData( ), param, filePath, fileName ) ) {
				/* 파일 반환 */
				CommonExcel.ExcelDownload( fileStream, bufferStream, outStream, (filePath + fileName), fileName, request, response );
			}

			result.setSuccess( );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
	}

	/* ## ############################################# ## */
	/* 카드 사용 현황 및 기능 */
	/* ## ############################################# ## */
	/* 카드사용현황 */
	@RequestMapping ( "/expend/np/admin/NpAdminCardReportSelect.do" )
	public ModelAndView NpAdminCardReport ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/NpAdminCardReportSelect.do] " + params.toString( ), "-", "EXNP" );
		/* MODELANDVIEW */
		ModelAndView mv = new ModelAndView( );
		/* VO */
		LoginVO loginVo = new LoginVO( );
		ConnectionVO conVo = new ConnectionVO( );
		ResultVO result = new ResultVO( );
		try {
			/* [예외 검증] 로그인 세션 확인 */
			CommonException.Login( );
			loginVo = CommonConvert.CommonGetEmpVO( );
			result.setLoginVo( loginVo );
			result.setParams( params );
			/* [예외 검증] 권한 확인 */
			CommonException.AdminAuth( );
			/* 카드 내역 조회 */
			result = npCardService.GetCardList( result );
			result.setSuccess( );
			mv.setViewName( "jsonView" );
		}
		catch ( NotFoundLoginSessionException e ) {
			mv.addObject( "errMsg", e.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			mv.addObject( "errMsg", e.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
		}
		mv.addObject( "result", result );
		return mv;
	}


	@RequestMapping ( "/expend/np/admin/NpAdminCardCmsBatchTime.do" )
	public ModelAndView NpAdminCardCmsBatchTime ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/NpAdminCardCmsBatchTime.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		LoginVO loginVo = new LoginVO( );
		ConnectionVO conVo = new ConnectionVO( );
		ResultVO result = new ResultVO();

		try {
			/* [예외 검증] 로그인 세션 확인 */
			CommonException.Login( );
			loginVo = CommonConvert.CommonGetEmpVO( );
			/* [예외 검증] 권한 확인 */
			CommonException.AdminAuth( );
			params.put( "empSeq", loginVo.getUniqId( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );

            JedisClient jedisClient = CloudConnetInfo.getJedisClient();

            String buildType = jedisClient.getBuildType();



           	/* 카드 내역 조회 */

            /*성일 수정 
             *2021-08-23
             *AdminCardReport.jsp 의 클라우드 경우 시간만 표시되게 수정위해 BUILD타입, 클라우드타입 구분 삭제 */
   			result = npCardService.GetCardBatchTime( params );
   			result.setSuccess( );


        	if(result.getaData()==null) {
        		result.setFail("CMS 미설치");
        	}

			mv.setViewName( "jsonView" );
		}
		catch ( NotFoundLoginSessionException e ) {
			mv.addObject( "errMsg", e.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			mv.addObject( "errMsg", e.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
		}
		mv.addObject( "result", result );
		return mv;
	}

	/* ## ############################################# ## */
	/* 카드 사용 현황 및 기능 리뉴얼 */
	/* ## ############################################# ## */
	/* 카드사용현황 */
	@RequestMapping ( "/expend/np/admin/NpAdminCardReportSelect2.do" )
	public ModelAndView NpAdminCardReport2 ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/NpAdminCardReportSelect2.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		LoginVO loginVo = new LoginVO( );
		ConnectionVO conVo = new ConnectionVO( );
		ResultVO result = new ResultVO();

		try {
			/* [예외 검증] 로그인 세션 확인 */
			CommonException.Login( );
			loginVo = CommonConvert.CommonGetEmpVO( );
			/* [예외 검증] 권한 확인 */
			CommonException.AdminAuth( );
			params.put( "empSeq", loginVo.getUniqId( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );

			/* 카드 내역 조회 */
			result = npCardService.GetCardList2( params );
			result.setSuccess( );
			mv.setViewName( "jsonView" );
		}
		catch ( NotFoundLoginSessionException e ) {
			mv.addObject( "errMsg", e.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			mv.addObject( "errMsg", e.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
		}
		mv.addObject( "result", result );
		return mv;
	}

	/* 카드 내역 이관 */
	@RequestMapping ( "/expend/np/admin/NPAdminCardTrans.do" )
	public ModelAndView NPAdminCardTrans ( @RequestParam Map<String, Object> param, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/NPAdminCardTrans.do] " + param.toString( ), "-", "EXNP" );
		/* ModelAndView */
		ModelAndView mv = new ModelAndView( );
		/* VO */
		LoginVO loginVo = new LoginVO( );
		ConnectionVO conVo = new ConnectionVO( );
		ResultVO result = new ResultVO( );
		try {
			/* [예외 검증] 로그인 세션 확인 */
			CommonException.Login( );
			loginVo = CommonConvert.CommonGetEmpVO( );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			result.setLoginVo( loginVo );
			result.setParams( param );
			/* [예외 검증] 권한 확인 */
			CommonException.AdminAuth( );
			/* 카드 내역 이관 */
			result = npCardService.SetCardTrans( result );
			result.setSuccess( );
			mv.setViewName( "jsonView" );
		}
		catch ( NotFoundLoginSessionException e ) {
			mv.addObject( "errMsg", e.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			mv.addObject( "errMsg", e.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
		}
		mv.addObject( "result", result );
		return mv;
	}

	/* 카드 내역 사용 / 미사용 처리 */
	@RequestMapping ( "/expend/np/admin/NPAdminCardUseYN.do" )
	public ModelAndView NPAdminCardUseYN ( @RequestParam Map<String, Object> param, HttpServletRequest request ) throws Exception {
		// cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/NPAdminCardUseYN.do] " + param.toString( ), "-", "EXNP" );
		/* ModelAndView */
		ModelAndView mv = new ModelAndView( );
		/* VO */
		LoginVO loginVo = new LoginVO( );
		ConnectionVO conVo = new ConnectionVO( );
		ResultVO result = new ResultVO( );
		try {
			/* [예외 검증] 로그인 세션 확인 */
			CommonException.Login( );
			loginVo = CommonConvert.CommonGetEmpVO( );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			result.setLoginVo( loginVo );
			result.setParams( param );
			/* [예외 검증] 권한 확인 */
			CommonException.AdminAuth( );
			/* 카드 내역 사용 / 미사용 처리 */
			result = npCardService.SetCardUseYN( result );
			result.setSuccess( );
			mv.setViewName( "jsonView" );
		}
		catch ( NotFoundLoginSessionException e ) {
			mv.addObject( "errMsg", e.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			mv.addObject( "errMsg", e.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
		}
		mv.addObject( "result", result );
		return mv;
	}

	/* 카드 내역 엑셀 다운로드 */
	@RequestMapping ( "/expend/np/admin/NpAdminCardReportExcel.do" )
	public void ExAdminCardReportListExcelDown ( @RequestParam Map<String, Object> param, HttpServletRequest request, HttpServletResponse response ) throws Exception {
		/* VO */
		LoginVO loginVo = new LoginVO( );
		ConnectionVO conVo = new ConnectionVO( );
		ResultVO result = new ResultVO( );
		/* Map */
		Map<String, Object> map = new HashMap<String, Object>( );
		/* File */
		FileInputStream fileStream = null;
		BufferedInputStream bufferStream = null;
		ByteArrayOutputStream outStream = null;
		/* String */
		String fileName = "", filePath = "";
		try {
			/* [예외 검증] 로그인 세션 확인 */
			CommonException.Login( );
			loginVo = CommonConvert.CommonGetEmpVO( );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			result.setLoginVo( loginVo );
			/* [예외 검증] 권한 확인 */
			CommonException.AdminAuth( );
			/* 카드 내역 목록 조회 */
			result.setAaData( CommonConvert.CommonGetJSONToListMap( CommonConvert.NullToString(param.get( "tableData" ) )) );
			/* 파일 명칭 정의 ( 나의카드사용내역현황_20180101_사용자이름.xlsx ) */
			fileName = "카드사용내역현황_" + CommonConvert.GetToday( ) + "_" + loginVo.getName( ) + ".xlsx";
			/* 파일 경로 */
            map.put("osType", CommonUtil.osType());
			map.put( "pathSeq", commonCode.EXPPATHSEQ );
			map.put( commonCode.GROUPSEQ, loginVo.getGroupSeq( ) );
			map = exCodeService.ExCommonExpGroupPathSelect( map );
			if ( map == null || map.get( "absolPath" ) == null || map.get( "absolPath" ).toString( ).equals( "" ) ) {
				throw new Exception( "Group path not exists.." );
			}
			filePath = map.get( "absolPath" ).toString( ) + File.separator + commonCode.EXCELPATH + File.separator;
			/* 엑셀 생성 */
			if ( CommonExcel.CreateExcelFile( result.getAaData( ), param, filePath, fileName ) ) {
				/* 파일 반환 */
				CommonExcel.ExcelDownload( fileStream, bufferStream, outStream, (filePath + fileName), fileName, request, response );
			}
			result.setSuccess( );
		}
		catch ( Exception e ) {
			e.printStackTrace();
		}
	}

	/**
	 * [G20 / ERPiU] 예실대비 현황
	 **/
	/* 예실대비 현황 리스트 조회 */
	@RequestMapping ( "/expend/np/admin/report/NpAdminYesilReport.do" )
	public ModelAndView NpAdminYesilReport ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/report/NpAdminYesilReport.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
		try {
			/* 로직파라미터 */
			params.put( "erpType", conVo.getErpTypeCode( ) );
			params.put( "compSeq", CommonConvert.CommonGetEmpVO( ).getCompSeq( ) );
			params.put( "empSeq", CommonConvert.CommonGetEmpVO( ).getUniqId( ) );
			params.put( "procType", "yesil" );

			ResultVO yesilResult = reportService.NPAdminYesilList( params, conVo );
			if ( CommonConvert.CommonGetStr(yesilResult.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setAaData( yesilResult.getAaData( ) );
				result.setSuccess( );
			}
			else {
				result = yesilResult;
			}
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "항목설정 옵션 조회에 실패하였습니다.", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/**
	 * [G20] 프로젝트 리스트 조회
	 **/
	/* 프로젝트 리스트 조회 */
	@RequestMapping ( "/expend/np/admin/report/NpAdminYesilMgtList.do" )
	public ModelAndView NpAdminYesilMgtList ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/report/NpAdminYesilMgtList.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
		try {
			/* 로직파라미터 */
			params.put( "erpType", conVo.getErpTypeCode( ) );
			params.put( "compSeq", CommonConvert.CommonGetEmpVO( ).getCompSeq( ) );
			params.put( "empSeq", CommonConvert.CommonGetEmpVO( ).getUniqId( ) );
			params.put( "procType", "yesil" );
			ResultVO yesilResult = reportService.NPAdminMgtList( params, conVo );
			if ( CommonConvert.CommonGetStr(yesilResult.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setAaData( yesilResult.getAaData( ) );
				result.setSuccess( );
			}
			else {
				result = yesilResult;
			}
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "항목설정 옵션 조회에 실패하였습니다.", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/**
	 * [G20] 예산별 ERP 전표/결의서 조회 / 통계정보 조회
	 **/
	@RequestMapping ( "/expend/np/admin/report/NpAdminYesilERPResInfoSet.do" )
	public ModelAndView NpAdminYesilERPResInfoSet ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/report/NpAdminYesilERPResInfoSet.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
		try {
			/* 로직파라미터 */
			params.put( "erpType", conVo.getErpTypeCode( ) );
			params.put( "compSeq", CommonConvert.CommonGetEmpVO( ).getCompSeq( ) );
			params.put( "empSeq", CommonConvert.CommonGetEmpVO( ).getUniqId( ) );

			/* ERP 전표/ 결의서 정보 조회 */
			result = reportService.NPAdminERPResAmtList( params, conVo );
		}
		catch ( Exception ex ) {
			result.setFail( "품의정보 조회에 실패하였습니다.", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/**
	 * [G20] 예산별 품의서 정보 리스트 / 통계정보 조회
	 **/
	@RequestMapping ( "/expend/np/admin/report/NpAdminYesilConsInfoSet.do" )
	public ModelAndView NpAdminYesilConsInfoSet ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/report/NpAdminYesilConsInfoSet.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
		String flag = commonCode.EMPTYSTR;
		try {
			Map<String, Object> codeParams = new HashMap<String, Object>();
			codeParams.put("groupSeq", loginVo.getGroupSeq());
			codeParams.put("code", "ex00038");
			codeParams.put("detailCode", "0000");
			Map<String, Object> codeResult = exCommonService.CommonCodeSelect(codeParams);
			flag = codeResult.get("FLAG_1").toString();
			/* 로직파라미터 */
			params.put( "flag", flag);
			params.put( "erpType", conVo.getErpTypeCode( ) );
			params.put( "compSeq", CommonConvert.CommonGetEmpVO( ).getCompSeq( ) );
			params.put( "empSeq", CommonConvert.CommonGetEmpVO( ).getUniqId( ) );
			params.put( "erpCompSeq", conVo.getErpCompSeq());
			/* iCUBE - G20 품의 데이터 조회  */
			result = reportService.NPAdminConsAmtList( params, conVo );
		}
		catch ( Exception ex ) {
			result.setFail( "품의정보 조회에 실패하였습니다.", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/**
	 * [G20] 예산별 결의서 정보 리스트 / 통계정보 조회
	 **/
	@RequestMapping ( "/expend/np/admin/report/NpAdminYesilResInfoSet.do" )
	public ModelAndView NpAdminYesilResInfoSet ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/report/NpAdminYesilResInfoSet.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
		String flag = commonCode.EMPTYSTR;
		try {
			Map<String, Object> codeParams = new HashMap<String, Object>();
			codeParams.put("groupSeq", loginVo.getGroupSeq());
			codeParams.put("code", "ex00038");
			codeParams.put("detailCode", "0000");
			Map<String, Object> codeResult = exCommonService.CommonCodeSelect(codeParams);
			flag = codeResult.get("FLAG_1").toString();
			/* 로직파라미터 */
			params.put("flag",flag);
			params.put("erpType", conVo.getErpTypeCode( ));
			params.put("compSeq", CommonConvert.CommonGetEmpVO( ).getCompSeq());
			params.put("empSeq", CommonConvert.CommonGetEmpVO( ).getUniqId());
			params.put("erpCompSeq", conVo.getErpCompSeq());
			/* iCUBE - G20 결의 데이터 조회  */
			result = reportService.NPAdminResAmtList( params, conVo );
		}
		catch ( Exception ex ) {
			result.setFail( "품의정보 조회에 실패하였습니다.", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 매입전자세금계산서 이관관리 조회 */
	@RequestMapping("/expend/np/admin/NPAdminETaxTransHistoryList.do")
	public ModelAndView NPAdminETaxTransHistoryList(@RequestParam Map<String, Object> param, HttpServletRequest request, HttpServletResponse response) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/expend/np/admin/NPAdminETaxTransHistoryList.do] " + param.toString(), "-", "EXNP");

		/* ModelAndView */
		ModelAndView mv = new ModelAndView();

		/* VO */
		LoginVO loginVo = new LoginVO();
		ConnectionVO conVo = new ConnectionVO();
		ResultVO result = new ResultVO();

		try {
			/* [예외 검증] 로그인 세션 확인 */
			CommonException.Login();
			loginVo = CommonConvert.CommonGetEmpVO();
			conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
			result.setLoginVo(loginVo);
			result.setParams(param);

			/* 매입전자세금계산서 이관 내역 조회 */
			result = etaxService.GetETaxTransHistoryList(result);
			result.setSuccess();
			mv.setViewName("jsonView");
		}
		catch (NotFoundLoginSessionException e) {
			mv.addObject("errMsg", e.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN);
		}
		catch (Exception e) {
			cmLog.CommonSetError(e);
			mv.addObject("errMsg", e.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERROR);
		}

		mv.addObject("result", result);
		return mv;
	}


	/* 카드사용내역 이관관리 조회 */
	@RequestMapping("/expend/np/admin/NPAdminCardTransHistoryList.do")
	public ModelAndView NPAdminCardTransHistoryList(@RequestParam Map<String, Object> param, HttpServletRequest request, HttpServletResponse response) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/expend/np/admin/NPAdminCardTransHistoryList.do] " + param.toString(), "-", "EXNP");

		/* ModelAndView */
		ModelAndView mv = new ModelAndView();

		/* VO */
		LoginVO loginVo = new LoginVO();
		ConnectionVO conVo = new ConnectionVO();
		ResultVO result = new ResultVO();

		try {
			/* [예외 검증] 로그인 세션 확인 */
			CommonException.Login();
			loginVo = CommonConvert.CommonGetEmpVO();
			conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
			result.setLoginVo(loginVo);
			result.setParams(param);

			/* 카드 내역 사용 / 미사용 처리 */
			result = npCardService.GetCardTransHistoryList(result);
			result.setSuccess();
			mv.setViewName("jsonView");
		}
		catch (NotFoundLoginSessionException e) {
			mv.addObject("errMsg", e.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN);
		}
		catch (Exception e) {
			cmLog.CommonSetError(e);
			mv.addObject("errMsg", e.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERROR);
		}

		mv.addObject("result", result);
		return mv;
	}

	/* 카드사용내역 이관관리 조회 */
	@RequestMapping("/expend/np/admin/NpAdminOptionSelect.do")
	public ModelAndView NpAdminOptionSelect(@RequestParam Map<String, Object> param, HttpServletRequest request, HttpServletResponse response) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/expend/np/admin/NpAdminOptionSelect.do] " + param.toString(), "-", "EXNP");

		/* ModelAndView */
		ModelAndView mv = new ModelAndView();

		/* VO */
		LoginVO loginVo = new LoginVO();
		ConnectionVO conVo = new ConnectionVO();
		ResultVO result = new ResultVO();

		try {
			/* [예외 검증] 로그인 세션 확인 */
			CommonException.Login();
			loginVo = CommonConvert.CommonGetEmpVO();
			conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
			result.setLoginVo(loginVo);
			result.setParams(param);

			param.put( "compSeq", loginVo.getCompSeq( ) );
			param.put( "erpType", conVo.getErpTypeCode( ) );
			param.put( "useSw", conVo.getErpTypeCode( ) );

			/* 양식별 옵션 설정 정보 조회 */
			result.setAaData(  configService.NpMasterOptionSelect(param) );
			result.setSuccess();
			mv.setViewName("jsonView");
		}
		catch (NotFoundLoginSessionException e) {
			mv.addObject("errMsg", e.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN);
		}
		catch (Exception e) {
			cmLog.CommonSetError(e);
			mv.addObject("errMsg", e.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERROR);
		}

		mv.addObject("result", result);
		return mv;
	}



}

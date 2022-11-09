package expend.np.admin.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.exception.CheckICUBEG20TypeException;
import common.helper.exception.NotFoundConnectionException;
import common.helper.exception.NotFoundERPEmpCdException;
import common.helper.exception.NotFoundLoginSessionException;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.CommonMapInterface.commonExPath;
import common.vo.common.ConnectionVO;
import common.vo.common.CustomLabelVO;
//import common.vo.common.ResultVO;
import expend.np.admin.report.BNpAdminReportService;


@Controller
public class VNpAdminPopController {

	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo;
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );
	@Resource ( name = "BNpAdminReportService" )
	private BNpAdminReportService reportService;

	/**
	 * Pop View
	 * [비영리/관리자] 예실대비 현황
	 * 예산별 상세 팝업 - 품의 잔액 리스트 조회
	 */
	@RequestMapping ( "/expend/np/admin/AdminYesilConsAmtDetailInfo.do" )
	public ModelAndView AdminYesilConsAmtDetailInfo ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/AdminYesilConsAmtDetailInfo.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo( );
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			/* [예외 검증] ERP 연결정보 조회 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			/* [예외 검증] ERP 연동 확인 */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP 연동 설정을 확인하세요." );
			}
			/* [예외 검증] ERP 사번 매핑 확인 */
			if ( empInfo.get( commonCode.ERPEMPSEQ ) == null || empInfo.get( commonCode.ERPEMPSEQ ).toString( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP 사번 매핑이 진행되지 않음." );
			}
			/* 명칭설정 기능 정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );

			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			mv.addObject("eaType", loginVo.getEaType());
			mv.addObject( "ERPType", conVo.getErpTypeCode( ) );
			mv.addObject( "ViewBag", CommonConvert.CommonGetMapToJSONObj( params ) );
			mv.addObject( "fromDate", params.get( "fromDate" ) );
			mv.addObject( "toDate", params.get( "toDate" ) );

			/* ERP 모듈별 페이지 준비 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
				mv.setViewName( commonExPath.NPADMINPOPPATH + commonExPath.ADMINERPIUYESILCONSAMTDETAILINFO );
			}
			else if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
				mv.setViewName( commonExPath.NPADMINPOPPATH + commonExPath.ADMINYESILCONSAMTDETAILINFO );
			}
		}
		catch ( NotFoundLoginSessionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
		}
		catch ( CheckICUBEG20TypeException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKICUBEG20TYPE );
		}
		catch ( NotFoundERPEmpCdException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPEMPCDMAPPING );
		}
		catch ( NotFoundConnectionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPSETTING );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
		}
		return mv;
	}

	/**
	 * Pop View
	 * [비영리/관리자] 예실대비 현황
	 * 예산별 상세 팝업 - 미전송 결의 잔액 리스트 조회
	 */
	@RequestMapping ( "/expend/np/admin/AdminYesilResAmtDetailInfo.do" )
	public ModelAndView AdminYesilResAmtDetailInfo ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/AdminYesilResAmtDetailInfo.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo( );
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			/* [예외 검증] ERP 연결정보 조회 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			/* [예외 검증] ERP 연동 확인 */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP 연동 설정을 확인하세요." );
			}
			/* [예외 검증] ERP 사번 매핑 확인 */
			if ( empInfo.get( commonCode.ERPEMPSEQ ) == null || empInfo.get( commonCode.ERPEMPSEQ ).toString( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP 사번 매핑이 진행되지 않음." );
			}
			/* 명칭설정 기능 정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			mv.addObject( "eaType", loginVo.getEaType() );
			mv.addObject( "ERPType", conVo.getErpTypeCode( ) );
			mv.addObject( "ViewBag", CommonConvert.CommonGetMapToJSONObj( params ) );
			mv.addObject( "fromDate", params.get( "fromDate" ) );
			mv.addObject( "toDate", params.get( "toDate" ) );
			/* ERP 모듈별 페이지 준비 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
				mv.setViewName( commonExPath.NPADMINPOPPATH + commonExPath.ADMINERPIUYESILRESAMTDETAILINFO );
			}
			else if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
				mv.setViewName( commonExPath.NPADMINPOPPATH + commonExPath.ADMINYESILRESAMTDETAILINFO );
			}
		}
		catch ( NotFoundLoginSessionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
		}
		catch ( CheckICUBEG20TypeException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKICUBEG20TYPE );
		}
		catch ( NotFoundERPEmpCdException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPEMPCDMAPPING );
		}
		catch ( NotFoundConnectionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPSETTING );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
		}
		return mv;
	}

	/**
	 * Pop View
	 * [비영리/관리자] 예실대비 현황
	 * 예산별 상세 팝업 - 미전송 결의 잔액 리스트 조회
	 */
	@RequestMapping ( "/expend/np/admin/AdminYesilERPResAmtDetailInfo.do" )
	public ModelAndView AdminYesilERPResAmtDetailInfo ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/AdminYesilERPResAmtDetailInfo.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo( );
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			/* [예외 검증] ERP 연결정보 조회 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			/* [예외 검증] ERP 연동 확인 */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP 연동 설정을 확인하세요." );
			}
			/* [예외 검증] ERP 타입 확인 / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 설정확인이 필요함." );
			}
			/* [예외 검증] ERP 사번 매핑 확인 */
			if ( empInfo.get( commonCode.ERPEMPSEQ ) == null || empInfo.get( commonCode.ERPEMPSEQ ).toString( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP 사번 매핑이 진행되지 않음." );
			}
			/* 명칭설정 기능 정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			mv.addObject( "eaType", loginVo.getEaType() );
			mv.addObject( "ERPType", conVo.getErpTypeCode( ) );
			mv.addObject( "ViewBag", CommonConvert.CommonGetMapToJSONObj( params ) );
			mv.addObject( "fromDate", params.get( "fromDate" ) );
			mv.addObject( "toDate", params.get( "toDate" ) );
			/* ERP 모듈별 페이지 준비 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
				throw new Exception( "ERPiU연동은 지원하지 않는 기능입니다." );
			}
			else if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
				mv.setViewName( commonExPath.NPADMINPOPPATH + commonExPath.ADMINYESILERPRESAMTDETAILINFO );
			}
		}
		catch ( NotFoundLoginSessionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
		}
		catch ( CheckICUBEG20TypeException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKICUBEG20TYPE );
		}
		catch ( NotFoundERPEmpCdException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPEMPCDMAPPING );
		}
		catch ( NotFoundConnectionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPSETTING );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
		}
		return mv;
	}


	/**
	 * Pop View 세금계산서 이관내역 팝업
	 */
	@RequestMapping("/expend/np/admin/AdminETaxTransHistoryPop.do")
	public ModelAndView UserETaxTransHistoryPop(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/expend/np/admin/AdminETaxTransHistoryPop.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo();
			/* [예외 검증] 로그인 세션 확인 */
			if (CommonConvert.CommonGetEmpInfo() == null) { throw new NotFoundLoginSessionException("로그인 세션 검색 실패"); }
			/* [예외 검증] ERP 연결정보 조회 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(empInfo.get(commonCode.COMPSEQ)));
			/* [예외 검증] ERP 연동 확인 */
			if (conVo.getErpCompSeq() == null || conVo.getErpCompSeq().isEmpty()) { throw new NotFoundConnectionException("ERP 연동 설정을 확인하세요."); }
			/* [예외 검증] ERP 타입 확인 / iCUBE G20 */
			if (conVo.getErpTypeCode().equals("iCUBE") && conVo.getG20YN().equals("N")) { throw new CheckICUBEG20TypeException("iCUBE G20 설정확인이 필요함."); }
			/* [예외 검증] ERP 사번 매핑 확인 */
			if (empInfo.get(commonCode.ERPEMPSEQ) == null || empInfo.get(commonCode.ERPEMPSEQ).toString().isEmpty()) { throw new NotFoundERPEmpCdException("ERP 사번 매핑이 진행되지 않음."); }
			/* 명칭설정 기능 정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO();
			String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
			String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
			String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
			mv.addObject("CL", vo.getData());
			mv.addObject("ERPType", conVo.getErpTypeCode());
			params.put("empInfo", CommonConvert.CommonGetMapToJSONObj(CommonConvert.CommonGetEmpInfo()));
			mv.addObject("ViewBag", CommonConvert.CommonGetMapToJSONObj(params));
			/* 참조품의 가져오기 경로 지정 */
			mv.setViewName(commonExPath.NPADMINPOPPATH + commonExPath.ADMINETAXTRANSHISTORYPOP);
		}
		catch (NotFoundLoginSessionException ex) {
			mv.addObject("errMsg", ex.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN);
		}
		catch (CheckICUBEG20TypeException ex) {
			mv.addObject("errMsg", ex.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKICUBEG20TYPE);
		}
		catch (NotFoundERPEmpCdException ex) {
			mv.addObject("errMsg", ex.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPEMPCDMAPPING);
		}
		catch (NotFoundConnectionException ex) {
			mv.addObject("errMsg", ex.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPSETTING);
		}
		catch (Exception ex) {
			cmLog.CommonSetError(ex);
			mv.addObject("errMsg", ex.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERROR);
		}
		return mv;
	}

	/**
	 * Pop View
	 * 카드내역가져오기 팝업
	 */
	@RequestMapping ( "/expend/np/admin/AdminCardTransHistoryPop.do" )
	public ModelAndView AdminCardTransHistoryPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/AdminCardTransHistoryPop.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo( );
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			/* [예외 검증] ERP 연결정보 조회 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			/* [예외 검증] ERP 연동 확인 */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP 연동 설정을 확인하세요." );
			}
			/* [예외 검증] ERP 타입 확인 / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 설정확인이 필요함." );
			}
			/* [예외 검증] ERP 사번 매핑 확인 */
			if ( empInfo.get( commonCode.ERPEMPSEQ ) == null || empInfo.get( commonCode.ERPEMPSEQ ).toString( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP 사번 매핑이 진행되지 않음." );
			}
			/* 명칭설정 기능 정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			mv.addObject( "ERPType", conVo.getErpTypeCode( ) );
			mv.addObject( "ViewBag", CommonConvert.CommonGetMapToJSONObj( params ) );
			/* 참조품의 가져오기 경로 지정 */
			mv.setViewName( commonExPath.NPADMINPOPPATH + commonExPath.ADMINCARDTRANSHISTORYPOP );
		}
		catch ( NotFoundLoginSessionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
		}
		catch ( CheckICUBEG20TypeException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKICUBEG20TYPE );
		}
		catch ( NotFoundERPEmpCdException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPEMPCDMAPPING );
		}
		catch ( NotFoundConnectionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPSETTING );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
		}
		return mv;
	}
}

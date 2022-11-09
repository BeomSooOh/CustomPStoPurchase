package expend.ez.user.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import bizbox.orgchart.service.vo.LoginVO;
import cmm.helper.ConvertManager;
import common.helper.convert.CommonConvert;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ResultVO;
import expend.ez.user.codeHelpInfo.BEzCodeHelpInfo;
import expend.ez.user.eaInfo.FEzEAInfo;
import expend.ez.user.erpUserInfo.BEzErpUserInfo;
import expend.ez.user.sendInfo.BEzSendInfo;
import interlock.exp.approval.BApprovalService;


@Controller
public class BEzMasterController {

	@Resource ( name = "BEzErpUserInfo" )
	BEzErpUserInfo erpUserInfo;
	@Resource ( name = "BEzCodeHelpInfo" )
	BEzCodeHelpInfo erpCodeInfo;
	@Resource ( name = "BEzErpSendInfo" )
	BEzSendInfo erpSendInfo;
	@Resource ( name = "BApprovalService" )
	private BApprovalService approvalService;
	@Resource ( name = "FEzEAInfo" )
	private FEzEAInfo eaInfo;
	@Resource ( name = "CommonConvert" )
	private CommonConvert commonConvert;
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */

	/* 이지바로 기본정보 불러오기(작성자 회계단위) */
	@RequestMapping ( "/expend/ez/user/EzUnitInfo.do" )
	public ModelAndView EzUnitInfo ( @RequestParam Map<String, Object> paramMap, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		Map<String, Object> serviceParam = new HashMap<String, Object>( );
		Map<String, Object> retValue = new HashMap<String, Object>( );
		try {
			cmLog.CommonSetInfo( "Controller  :  EzUnitInfo 진입" );
			retValue = erpUserInfo.EzUnitInfoSelect( serviceParam );
			mv.addObject( "CO_CD", retValue.get( "CO_CD" ) );
			mv.addObject( "DIV_CD", retValue.get( "DIV_CD" ) );
			mv.addObject( "DIV_NM", retValue.get( "DIV_NM" ) );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return mv;
	}

	/* 이지바로 기본정보 불러오기(작성자 결의부서/작성자) */
	@RequestMapping ( "/expend/ez/user/EzDeptUserInfo.do" )
	public ModelAndView EzDeptUserInfo ( @RequestParam Map<String, Object> paramMap, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		Map<String, Object> serviceParam = new HashMap<String, Object>( );
		Map<String, Object> retValue = new HashMap<String, Object>( );
		try {
			cmLog.CommonSetInfo( "Controller  :  EzDeptUserInfo 진입" );
			retValue = erpUserInfo.EzUserDeptInfoSelect( serviceParam );
			mv.addObject( "DEPT_CD", retValue.get( "DEPT_CD" ) );
			mv.addObject( "DEPT_NM", retValue.get( "DEPT_NM" ) );
			mv.addObject( "EMP_CD", retValue.get( "EMP_CD" ) );
			mv.addObject( "EMP_NM", retValue.get( "EMP_NM" ) );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return mv;
	}

	/* 이지바로 코드도움 실행 */
	@RequestMapping ( "/expend/ez/user/code/EzCodeHelpInfo.do" )
	public ModelAndView EzCodeHelpInfo ( @RequestParam Map<String, Object> paramMap, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>( );
		try {
			resultList = erpCodeInfo.EzDistinguishCodeSelect( paramMap );
			mv.addObject( "aaData", resultList );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return mv;
	}

	/* 이지바로 결의내역 최초삽입 실행 */
	@RequestMapping ( "/expend/ez/user/EzbaroHReqInsert.do" )
	public ModelAndView EzbaroHReqInsert ( @RequestParam Map<String, Object> paramMap, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		Map<String, Object> result = new HashMap<String, Object>( );
		try {
			result = erpSendInfo.EzHReqInsert( paramMap );
			mv.addObject( "task_sq", result.get( "TASK_SQ" ) );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return mv;
	}

	/* 이지바로 품의상세 삽입 실행 */
	@RequestMapping ( "/expend/ez/user/EzbaroHReqDetailInsert.do" )
	public ModelAndView EzbaroHReqDetailInsert ( @RequestParam Map<String, Object> paramMap, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		Map<String, Object> result = new HashMap<String, Object>( );
		try {
			result = erpSendInfo.EzHReqDetailInsert( paramMap );
			mv.addObject( "regseq", result.get( "REGSEQ" ) );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return mv;
	}

	/* 이지바로 마스터 정보 생성 */
	@RequestMapping ( "/expend/ez/user/EzbaroMasterInfoInsert.do" )
	public ModelAndView EzbaroMasterInfoInsert ( @RequestParam Map<String, Object> paramMap, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		Map<String, Object> result = new HashMap<String, Object>( );
		try {
			result = erpSendInfo.EzMasterInfoInsert( paramMap );
			mv.addObject( "master_seq", result.get( "master_seq" ) );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return mv;
	}

	/* 이지바로 ERP 마스터 정보 생성 */
	@RequestMapping ( "/expend/ez/user/EzbaroErpMasterInsert.do" )
	public ModelAndView EzbaroErpMasterInsert ( @RequestParam Map<String, Object> paramMap, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		Map<String, Object> result = new HashMap<String, Object>( );
		try {
			result = erpSendInfo.EzErpMasterInsert( paramMap );
			mv.addObject( "erp_master_seq", result.get( "erp_master_seq" ) );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return mv;
	}

	/* 이지바로 ERP 슬레이브 정보 생성 */
	@RequestMapping ( "/expend/ez/user/EzbaroErpSlaveInsert.do" )
	public ModelAndView EzbaroErpSlaveInsert ( @RequestParam Map<String, Object> paramMap, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		Map<String, Object> result = new HashMap<String, Object>( );
		try {
			result = erpSendInfo.EzErpSlaveInsert( paramMap );
			mv.addObject( "erp_slave_seq", result.get( "erp_slave_seq" ) );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return mv;
	}

	/* 이지바로 파라메터 정보 생성 */
	@RequestMapping ( "/expend/ez/user/EzbaroGwParamsInsert.do" )
	public ModelAndView EzbaroGwParamsInsert ( @RequestParam Map<String, Object> paramMap, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		Map<String, Object> result = new HashMap<String, Object>( );
		try {
			result = erpSendInfo.EzGwParamsInsert( paramMap );
			mv.addObject( "param_seq", result.get( "param_seq" ) );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return mv;
	}

	/* 이지바로 GW 마스터 정보 생성 */
	@RequestMapping ( "/expend/ez/user/EzbaroGwMasterInsert.do" )
	public ModelAndView EzbaroGwMasterInsert ( @RequestParam Map<String, Object> paramMap, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		Map<String, Object> result = new HashMap<String, Object>( );
		try {
			result = erpSendInfo.EzGwMasterInsert( paramMap );
			mv.addObject( "gw_master_seq", result.get( "gw_master_seq" ) );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return mv;
	}

	/* 이지바로 GW 슬레이브 정보 생성 */
	@RequestMapping ( "/expend/ez/user/EzbaroGwSlaveInsert.do" )
	public ModelAndView EzbaroGwSlaveInsert ( @RequestParam Map<String, Object> paramMap, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		Map<String, Object> result = new HashMap<String, Object>( );
		try {
			result = erpSendInfo.EzGwSlaveInsert( paramMap );
			mv.addObject( "gw_slave_seq", result.get( "gw_slave_seq" ) );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return mv;
	}

	/* 이지바로 전자결재 호출 */
	@RequestMapping ( "/expend/ez/user/EzbaroCallAppdoc.do" )
	public ModelAndView EzbaroCallAppdoc ( @RequestParam Map<String, Object> paramMap, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			LoginVO loginVO = CommonConvert.CommonGetEmpVO( );
			ResultVO resultVo = new ResultVO( );
			
			/* servlet request property 확인용 로그  */
		    /* cmLog.CommonSetInfo("[[ request ContextPath ]] :: " + request.getContextPath());
		      cmLog.CommonSetInfo("[[ request PathInfo ]] :: " + request.getPathInfo());
		      cmLog.CommonSetInfo("[[ request RequestURL ]] :: " + request.getRequestURL().toString());
		      cmLog.CommonSetInfo("[[ request serverName ]] :: " + request.getServerName());
		      cmLog.CommonSetInfo("[[ request portName ]] :: " + request.getServerPort());
		      cmLog.CommonSetInfo("[[ request protocol ]] :: " + request.getProtocol());
		      cmLog.CommonSetInfo("[[ request servletPath ]] :: " + request.getServletPath());      
		      cmLog.CommonSetInfo("[[ request isSecure ]] :: " + request.isSecure());
		      cmLog.CommonSetInfo("[[ request getScheme ]] :: " + request.getScheme());
		    */
		      
	        String wegUrl = CommonConvert.CommonGetStr(paramMap.get("eapCallDomain"));
	        if("".equals(wegUrl)) {
	          throw new Exception("eapCallDomain is Empty");
	        }
	        cmLog.CommonSetInfo("[[ CALL wegUrl ]] :: " + wegUrl);
		
			//이전단계 url
			String interlockUrl = wegUrl + "/exp/expend/ez/user/EzMasterPop.do?form_id=" + paramMap.get( commonCode.FORMSEQ ) + "&masterSeq=" + paramMap.get( "masterSeq" );
			@SuppressWarnings ( "unused" )
			Map<String, Object> interlock = new HashMap<String, Object>( );
			Map<String, Object> head = CommonConvert.CommonGetJSONToMap( paramMap.get( "head" ).toString( ) );
			List<Map<String, Object>> content = CommonConvert.CommonGetJSONToListMap( paramMap.get( "content" ).toString( ) );
			resultVo.setProcessId( CommonConvert.CommonGetStr( paramMap.get( commonCode.PROCESSID ) ) );
			resultVo.setApproKey( CommonConvert.CommonGetStr( paramMap.get( commonCode.APPROKEY ) ) );
			resultVo.setInterlockUrl( interlockUrl );
			resultVo.setInterlockName( "결의내역 수정" );
			// 20180910 soyoung, interlockName 결의내역수정 영문/일문/중문 다국어추가 필요
			resultVo.setInterlockNameEn("결의내역 수정" );
			resultVo.setInterlockNameJp("결의내역 수정" );
			resultVo.setInterlockNameCn("결의내역 수정" );
			resultVo.setPreUrl( CommonConvert.CommonGetStr( wegUrl ) );
			resultVo.setDocSeq( commonCode.EMPTYSEQ );
			resultVo.setFormSeq( CommonConvert.CommonGetSeq( paramMap.get( commonCode.FORMSEQ ) ) );
			resultVo.setHeader( head );
			resultVo.setContent( content );
			resultVo = approvalService.DocMake( resultVo );
			resultVo.setEaType( loginVO.getEaType( ) );
			mv.setViewName( "jsonView" );
			mv.addObject( "result", resultVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return mv;
	}

	/* 이지바로 전자세금계산서 입력테이블에 추가할 항목 리스트 호출 */
	@RequestMapping ( "/expend/ez/user/EzbaroGetETaxListInfo.do" )
	public ModelAndView EzbaroGetETaxListInfo ( @RequestParam Map<String, Object> paramMap, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			result = erpCodeInfo.EzETaxListInfo( paramMap );
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return mv;
	}

	/* 이지바로 기존 작성한 데이터 호출하기 */
	@RequestMapping ( "/expend/ez/user/EzbaroLoadPreData.do" )
	public ModelAndView EzbaroLoadPreData ( @RequestParam Map<String, Object> paramMap, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			@SuppressWarnings ( "unused" )
			LoginVO loginVO = CommonConvert.CommonGetEmpVO( );
			@SuppressWarnings ( "unused" )
			ResultVO resultVo = new ResultVO( );
			/* 이지바로 마스터 테이블정보 가져오기 */
			Map<String, Object> masterMap = eaInfo.EzMasterInfoSelect( paramMap );
			/* 수정가능 결의서라면 데이터를 불러온다. */
			if ( masterMap.size( ) > 0 ) {
				mv.addObject( "masterInfo", eaInfo.EzMasterInfoSelect( paramMap ) );
				/* 이지바로 마스터 erp 테이블정보 가져오기 */
				mv.addObject( "erpMaster", eaInfo.EzErpMasterInfoSelect( paramMap ) );
				/* 이지바로 슬레이브 erp 테이블정보 가져오기 */
				mv.addObject( "erpSlave", eaInfo.EzErpSlaveListInfoSelect( paramMap ) );
				/* 이지바로 마스터 gw 테이블정보 가져오기 */
				mv.addObject( "gwMaster", eaInfo.EzGwMasterInfoSelect( paramMap ) );
				/* 이지바로 슬레이브 gw 테이블정보 가져오기 */
				mv.addObject( "gwSlave", eaInfo.EzGwSlaveListInfoSelect( paramMap ) );
				/* 이지바로 코드파라메터 테이블정보 가져오기 */
				mv.addObject( "codeParam", eaInfo.EzCodeParamListInfoSelect( paramMap ) );
			}
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return mv;
	}

	/* 이지바로 공콩코드 설정 호출 */
	@RequestMapping ( "/expend/ez/user/EzbaroGetCommonCodeSelect.do" )
	public ModelAndView EzbaroGetCommonCodeSelect ( @RequestParam Map<String, Object> paramMap, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			result = erpCodeInfo.EzCommonCodeInfo( paramMap );
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return mv;
	}

	/* 이지바로 공콩코드 설정 호출 */
	@RequestMapping ( "/expend/ez/user/EzbaroGetCommonCodeUpdate.do" )
	public ModelAndView EzbaroCommonCodeUpdate ( @RequestParam Map<String, Object> paramMap, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		List<Map<String, Object>> listUpdateData = new ArrayList<Map<String, Object>>( );
		Map<String, Object> result = new HashMap<String, Object>( );
		try {
			listUpdateData = ConvertManager.ConvertJsonToListMap( (String) paramMap.get( "updateList" ) );
			result = erpCodeInfo.EzCommonCodeUpdate( listUpdateData );
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return mv;
	}

	/* 이지바로 지급은행 단일정보 호출 */
	@RequestMapping ( "/expend/ez/user/EzbaroBankInfo.do" )
	public ModelAndView EzbaroBankInfoSelect ( @RequestParam Map<String, Object> paramMap, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		Map<String, Object> result = new HashMap<String, Object>( );
		try {
			result = erpCodeInfo.EzBankInfoSelect( paramMap );
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return mv;
	}

	/* 이지바로 사용자 지급은행 단일정보 호출 */
	@RequestMapping ( "/expend/ez/user/EzbaroEmpBankInfo.do" )
	public ModelAndView EzbaroEmpBankInfoSelect ( @RequestParam Map<String, Object> paramMap, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		Map<String, Object> result = new HashMap<String, Object>( );
		try {
			result = erpCodeInfo.EzEmpBankInfoSelect( paramMap );
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return mv;
	}

	/* 이지바로 사용자 계정정보 단일정보 호출 */
	@RequestMapping ( "/expend/ez/user/EzbaroEmpAcctInfoSelect.do" )
	public ModelAndView EzbaroEmpAcctInfoSelect ( @RequestParam Map<String, Object> paramMap, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		Map<String, Object> result = new HashMap<String, Object>( );
		try {
			result = erpCodeInfo.EzEmpAcctInfoSelect( paramMap );
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return mv;
	}

	/* 이지바로 원천징수액 소득구분 호출 */
	@RequestMapping ( "/expend/ez/user/EzbaroIncomeGbnSelect.do" )
	public ModelAndView EzbaroIncomeGbnSelect ( @RequestParam Map<String, Object> paramMap, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>( );
		try {
			resultList = erpCodeInfo.EzIncomeGbnSelect( paramMap );
			mv.addObject( "result", resultList );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return mv;
	}
}

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
import common.helper.convert.CommonConvert;
import common.helper.logger.CommonLogger;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import expend.ez.user.eaInfo.FEzEAInfo;


@Controller
public class VEzMasterController {

	@Resource ( name = "FEzEAInfo" )
	FEzEAInfo eaInfo;
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */
	@Resource ( name = "CommonConvert" )
	private CommonConvert commonConvert;

	/* 이지바로 작성팝업 페이지 */
	@RequestMapping ( "/expend/ez/user/EzMasterPop.do" )
	public ModelAndView EzbaroDocPop ( @RequestParam Map<String, Object> paramMap, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		Map<String, Object> resultFormInfo = new HashMap<String, Object>( );
		try {
			/* 폼 아이디 저장 */
			mv.addObject( "form_seq", EgovStringUtil.isNullToString( paramMap.get( "form_id" ) ) );
			/* 문서아이디 확인 */
			mv.addObject( "doc_seq", EgovStringUtil.isNullToString( paramMap.get( "docId" ) ) );
			/* 이지바로 마스터 아이디 확인 */
			mv.addObject( "master_seq", EgovStringUtil.isNullToString( paramMap.get( "masterSeq" ) ) );
			/* 문서 외부연동 키값 확인 */
			mv.addObject( "approKey", EgovStringUtil.isNullToString( paramMap.get( "approKey" ) ) );
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			/* 전자결재 타입 저장 */
			mv.addObject( "ea_type", loginVo.getEaType( ) );
			/* 영리 */
			if ( loginVo.getEaType( ).equals( "eap" ) ) {
				/* 폼 정보 넣기 */
				paramMap.put( "form_id", paramMap.get( "form_id" ) );
				/* 양식 정보 확인 */
				resultFormInfo = eaInfo.EzFormInfoSelect( paramMap );
				/* 프로세스 아이디 넣기 */
				mv.addObject( "process_id", resultFormInfo.get( "form_d_tp" ) );
				mv.addObject( "interlock_url", resultFormInfo.get( "interlock_url" ) );
			}
			/* 비영리 */
			else if ( loginVo.getEaType( ).equals( "ea" ) ) {
				/* 폼 정보 넣기 */
				/* 폼 아이디 저장 */
				paramMap.put( "form_id", paramMap.get( "form_id" ) );
				/* 양식 정보 확인 */
				resultFormInfo = eaInfo.EzFormEAInfoSelect( paramMap );
				/* 프로세스 아이디 넣기 */
				mv.addObject( "process_id", resultFormInfo.get( "form_d_tp" ) );
				mv.addObject( "interlock_url", resultFormInfo.get( "interlock_url" ) );
			}
			mv.setViewName( "/expend/ez/user/pop/EzMasterPop" );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return mv;
	}

	/* 이지바로 인터락 상세보기 팝업 페이지 */
	@SuppressWarnings ( "static-access" )
	@RequestMapping ( "/expend/ez/user/EzInspectInterlockPop.do" )
	public ModelAndView EzInspectInterlockPop ( @RequestParam Map<String, Object> paramMap, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		Map<String, Object> resultResolInfo = new HashMap<String, Object>( );
		try {
			mv.addObject( "MASTER_SEQ", EgovStringUtil.isNullToString( paramMap.get( "MASTER_SEQ" ) ) );
			mv.addObject( "TASK_DT", EgovStringUtil.isNullToString( paramMap.get( "TASK_DT" ) ) );
			mv.addObject( "TASK_SQ", EgovStringUtil.isNullToString( paramMap.get( "TASK_SQ" ) ) );
			mv.addObject( "CO_CD", EgovStringUtil.isNullToString( paramMap.get( "CO_CD" ) ) );
			resultResolInfo = eaInfo.EzInterlockResolInfoSelect( paramMap );
			//EgovStringUtil.isNullToString(resultResolInfo);
			mv.addObject( "resolData", EgovStringUtil.isNullToString( commonConvert.CommonGetMapToJSONStr( resultResolInfo ) ) );
			mv.setViewName( "/expend/ez/user/pop/EzInterLock" );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return mv;
	}

	/* 이지바로 인터락 품목셍세 팝업 페이지 */
	@SuppressWarnings ( "static-access" )
	@RequestMapping ( "/expend/ez/user/EzInspectInterlockPopDatailList.do" )
	public ModelAndView EzInspectInterlockPopDatailList ( @RequestParam Map<String, Object> paramMap, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>( );
		try {
			mv.addObject( "TASK_DT", EgovStringUtil.isNullToString( paramMap.get( "TASK_DT" ) ) );
			mv.addObject( "TASK_SQ", EgovStringUtil.isNullToString( paramMap.get( "TASK_SQ" ) ) );
			mv.addObject( "CO_CD", EgovStringUtil.isNullToString( paramMap.get( "CO_CD" ) ) );
			resultList = eaInfo.EzInspectInterlockPopDatailList( paramMap );
			mv.addObject( "resultList", EgovStringUtil.isNullToString( commonConvert.CommonGetListMapToJson( (resultList) ) ) );
			mv.setViewName( "/expend/ez/user/pop/EzInterLockDetailList" );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return mv;
	}

	/* 이지바로 공통코드 설정 페이지 */
	@RequestMapping ( "/expend/ez/user/EzCommonCodePop.do" )
	public ModelAndView EzbaroCommonCodePop ( @RequestParam Map<String, Object> paramMap, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			mv.addObject( "CO_CD", EgovStringUtil.isNullToString( paramMap.get( "CO_CD" ) ) );
			mv.addObject( "LANGKIND", EgovStringUtil.isNullToString( paramMap.get( "LANGKIND" ) ) );
			mv.addObject( "EMP_SEQ", EgovStringUtil.isNullToString( paramMap.get( "EMP_SEQ" ) ) );
			mv.setViewName( "/expend/ez/user/pop/EzCommonCodePop" );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return mv;
	}

	@RequestMapping ( "/testExcel.xls" )
	public ModelAndView testExcel ( HttpServletRequest request ) {
		ModelAndView mav = new ModelAndView( );
		mav.setViewName( "TestExcelView" );
		return mav;
	}
}

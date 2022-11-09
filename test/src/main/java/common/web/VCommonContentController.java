/**
  * @FileName : VCommonContentController.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package common.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import cmm.helper.ConvertManager;
import common.form.BCommonFormService;
import common.helper.convert.CommonConvert;
import common.helper.exception.CheckAuthorityException;
import common.helper.exception.NotFoundLogicException;
import common.helper.exception.NotFoundLoginSessionException;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.CommonMapInterface.commonExPath;
import common.vo.common.ResultVO;
import egovframework.com.cmm.annotation.IncludedInfo;


/**
 *   * @FileName : VCommonContentController.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 : 공통사용 Content Controller
 *   
 */
@Controller
public class VCommonContentController {

	/* ################################################## */
	/* 변수정의 */
	/* ################################################## */
	/* 변수정의 - Service */
	@Resource ( name = "BCommonFormService" )
	private BCommonFormService formService;
	/* 변수정의 - Class */
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
	/* ################################################## */
	/* 공통 Content */
	/* ################################################## */
	/* 공통 Content - 관리자 권한이 없습니다. */
	/* 공통 Content - 마스터 권한이 없습니다. */
	/* 공통 Content - Bizbox Alpha 전용 기능입니다. */
	/* 공통 Content - iCUBE 전용 기능입니다. */
	/* 공통 Content - iU 전용 기능입니다. */

	@IncludedInfo ( name = "[관리자] 양식설정", order = 1111, gid = 110 )
	@RequestMapping ( "/common/form/FormSettingTestPage.do" )
	public ModelAndView FromSettingTestPage ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		/* 변수정의 */
		ModelAndView mv = new ModelAndView( );
		try {
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			else if ( !CommonConvert.CommonGetEmpInfo( ).get( "userSe" ).equals( commonCode.ADMIN ) ) {
				throw new CheckAuthorityException( commonCode.ADMIN );
			}
			else if ( CommonConvert.CommonGetEmpInfo( ).get( commonCode.COMPSEQ ).equals( commonCode.EMPTYSEQ ) ) {
				throw new NotFoundLoginSessionException( "사용자 소속 회사 조회 실패" );
			}
			ResultVO result = new ResultVO( );
			/* 양식 정보 조회 */
			result = formService.CommonFormSendParam( params );
			mv.addObject( "aaData", ConvertManager.ConvertListMapToJson( result.getAaData( ) ) );
			mv.addObject( "groupSeq", CommonConvert.CommonGetEmpInfo( ).get( "groupSeq" ) );
			mv.setViewName( "/common/content/formSettingTestPage" );
		}
		catch ( NotFoundLogicException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERP );
		}
		catch ( CheckAuthorityException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKAUTH );
		}
		catch ( NotFoundLoginSessionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
		}
		return mv;
	}

	@RequestMapping ( "/common/form/FormTestPop.do" )
	public ModelAndView FormTestPop ( @RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		mv.setViewName( "/common/content/FormTestPop" );
		return mv;
	}

	@IncludedInfo ( name = "모듈 옵션 설정 페이지", order = 9105, gid = 910 )
	@RequestMapping ( "/common/form/ModuleOptionSettingPage.do" )
	public ModelAndView ModuleSettingPage ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		mv.setViewName( "/common/content/ModuleOptionSettingPage" );
		return mv;
	}
}

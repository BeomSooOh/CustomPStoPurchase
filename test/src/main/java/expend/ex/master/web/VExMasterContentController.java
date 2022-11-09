package expend.ex.master.web;

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
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface;
import common.vo.common.ConnectionVO;
import common.vo.ex.ExCommonResultVO;
import egovframework.com.cmm.annotation.IncludedInfo;
import expend.ex.master.config.BExMasterConfigService;
import expend.ex.user.code.BExUserCodeService;
import net.sf.json.JSONArray;


@Controller
public class VExMasterContentController {

	/* 변수정의 */
	/* 변수정의 - Service */
	@Resource ( name = "BExMasterConfigService" )
	private BExMasterConfigService exMasterConfigService;
	@Resource ( name = "BExUserCodeService" )
	private BExUserCodeService exUserCodeService;
	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */

	/* View - 공통코드 조회 */
	private void setCommonParams ( Map<String, Object> sendParam ) throws Exception {
		LoginVO loginVo = new LoginVO( );
		ExCommonResultVO commonParam = new ExCommonResultVO( );
		List<ExCommonResultVO> commonCode = new ArrayList<ExCommonResultVO>( );
		/* 초기값 정의 */
		loginVo = CommonConvert.CommonGetEmpVO( );
		//		sendParam = cmConvert.CommonSetMapCopy( sendParam );
		if ( commonParam.getGroupSeq( ) == null || CommonConvert.CommonGetStr(commonParam.getGroupSeq( )).equals( "" ) ) {
			commonParam.setGroupSeq( loginVo.getGroupSeq( ) );
		}
		if ( sendParam.get( "comp_seq" ) == null || CommonConvert.CommonGetStr(sendParam.get( "comp_seq" )).equals( CommonInterface.commonCode.EMPTYSTR ) ) {
			commonParam.setCompSeq( loginVo.getCompSeq( ) );
		}
		commonParam.setLangCode( loginVo.getLangCode( ) );
		// VO -> Map
		sendParam.put( "empInfo", CommonConvert.CommonGetObjectToMap( loginVo ) );
		/* ERP 연결정보 조회 */
		/* 기본값 지정 - 연동 시스템 정보 처리 */
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
		sendParam.put( CommonInterface.commonCode.IFSYSTEM, conVo.getErpTypeCode( ) );
		/* 공통코드 */
		/* 공통코드 - 회사목록 */
		//		sendParam.put("compListInfo", JSONArray.fromObject(exMasterConfigService.GCompanyListS(sendParam)));
		commonCode = exUserCodeService.ExCodeCommonCompListInfoSelect( commonParam );
		sendParam.put( "compListInfo", JSONArray.fromObject( commonCode ) );
		/* 공통코드 - 사용여부 */
		commonParam.setSearchType( CommonInterface.commonCodeKey.USEYN );
		commonCode = exUserCodeService.ExCodeCommonCodeListInfoSelect( commonParam );
		sendParam.put( "commonCodeListUseYN", JSONArray.fromObject( commonCode ) );
		/* 공통코드 - 예 / 아니오 */
		commonParam.setSearchType( CommonInterface.commonCodeKey.YESORNO );
		commonCode = exUserCodeService.ExCodeCommonCodeListInfoSelect( commonParam );
		sendParam.put( "commonCodeListYesOrNo", JSONArray.fromObject( commonCode ) );
		/* 전자결재 - 양식목록 */
		commonCode = exUserCodeService.ExCodeCommonFormListInfoSelect( commonParam );
		sendParam.put( "formListInfo", JSONArray.fromObject( commonCode ) );
		/* 공통코드 - 차대구분 */
		commonParam.setSearchType( CommonInterface.commonCode.DRCRTYPE );
		commonCode = exUserCodeService.ExCodeCommonCodeListInfoSelect( commonParam );
		sendParam.put( "commonCodeListDrcrGbn", JSONArray.fromObject( commonCode ) );
		/* 공통코드 - 관리항목 설정 항목 */
		commonParam.setSearchType( CommonInterface.commonCode.MNGMAPTYPE );
		commonCode = exUserCodeService.ExCodeCommonCodeListInfoSelect( commonParam );
		sendParam.put( "commonCodeListMngMapType", JSONArray.fromObject( commonCode ) );
		/* 공통코드 - 표준적요 구분 / 적요구분 */
		commonParam.setSearchType( CommonInterface.commonCode.SUMMARYTYPE );
		commonCode = exUserCodeService.ExCodeCommonCodeListInfoSelect( commonParam );
		sendParam.put( "commonCodeListSummaryType", JSONArray.fromObject( commonCode ) );
		/* 공통코드 - 검색어 구분 */
		commonParam.setSearchType( CommonInterface.commonCode.SUMMARYSEARCHTYPE );
		commonCode = exUserCodeService.ExCodeCommonCodeListInfoSelect( commonParam );
		sendParam.put( "commonCodeListSummarySearchType", JSONArray.fromObject( commonCode ) );
	}

	/* View - 계정과목관리 */
	@IncludedInfo ( name = "계정과목 관리", order = 1201, gid = 120 )
	@RequestMapping ( "/ex/master/config/ExConfigAcctSetting.do" )
	public ModelAndView ExConfigAcctSetting ( @RequestParam Map<String, Object> param, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			Map<String, Object> sendParam = new HashMap<String, Object>( );
			setCommonParams( sendParam );
			/* 반환처리 */
			mv.addObject( "ViewBag", sendParam );
			mv.setViewName( "/expend/ex/master/content/MasterAcctSetting" );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* View - 증빙관리 */
	@IncludedInfo ( name = "증빙 관리", order = 1202, gid = 120 )
	@RequestMapping ( "/ex/master/config/ExConfigAuthSetting.do" )
	public ModelAndView ExConfigAuthSetting ( @RequestParam Map<String, Object> param, HttpServletRequest request ) throws Exception {
		// 파라미터
		// 반환 :
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			Map<String, Object> sendParam = new HashMap<String, Object>( );
			setCommonParams( sendParam );
			// 반환값 처리
			mv.addObject( "ViewBag", sendParam );
			mv.setViewName( "/expend/ex/master/content/MasterAuthSetting" );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* View - 법인카드관리 */
	@IncludedInfo ( name = "법인카드 관리", order = 1203, gid = 120 )
	@RequestMapping ( "/ex/master/config/ExConfigCardSetting.do" )
	public ModelAndView ExConfigCardSetting ( @RequestParam Map<String, Object> param, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			Map<String, Object> sendParam = new HashMap<String, Object>( );
			setCommonParams( sendParam );
			/* 반환처리 */
			mv.addObject( "ViewBag", sendParam );
			mv.setViewName( "/expend/ex/admin/content/AdminCardSetting" );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	@IncludedInfo ( name = "지출결의 관리", order = 1204, gid = 120 )
	@RequestMapping ( "/ex/master/config/ExConfigExpendSetting.do" )
	public ModelAndView ExConfigExpendSetting ( @RequestParam Map<String, Object> param, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			Map<String, Object> sendParam = new HashMap<String, Object>( );
			setCommonParams( sendParam );
			/* 반환처리 */
			mv.addObject( "ViewBag", sendParam );
			mv.setViewName( "/expend/ex/master/content/MasterExpendSetting" );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	@IncludedInfo ( name = "관리항목 관리", order = 1205, gid = 120 )
	@RequestMapping ( "/ex/master/config/ExConfigSettingMng.do" )
	public ModelAndView ExConfigSettingMng ( @RequestParam Map<String, Object> param, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			Map<String, Object> sendParam = new HashMap<String, Object>( );
			setCommonParams( sendParam );
			/* 반환처리 */
			mv.addObject( "ViewBag", sendParam );
			mv.setViewName( "/expend/ex/master/content/MasterSettingMng" );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	@IncludedInfo ( name = "항목 관리", order = 1206, gid = 120 )
	@RequestMapping ( "/ex/master/config/ExSettingItems.do" )
	public ModelAndView ExSettingItems ( @RequestParam Map<String, Object> param ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			Map<String, Object> sendParam = new HashMap<String, Object>( );
			setCommonParams( sendParam );
			/* 반환처리 */
			mv.addObject( "ViewBag", sendParam );
			mv.setViewName( "/expend/ex/master/content/MasterSettingItems" );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	@IncludedInfo ( name = "표준적요 관리", order = 1207, gid = 120 )
	@RequestMapping ( "/ex/master/config/ExConfigSummarySetting.do" )
	public ModelAndView ExConfigSummarySetting ( @RequestParam Map<String, Object> param, HttpServletRequest request ) throws Exception {
		// 파라미터
		// 반환 :
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			Map<String, Object> sendParam = new HashMap<String, Object>( );
			setCommonParams( sendParam );
			// 반환값 처리
			mv.addObject( "ViewBag", sendParam );
			mv.setViewName( "/expend/ex/master/content/MasterSummarySetting" );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	@IncludedInfo ( name = "부가세 관리", order = 1208, gid = 120 )
	@RequestMapping ( "/ex/master/config/ExConfigVatTypeSetting.do" )
	public ModelAndView ExConfigVatSetting ( @RequestParam Map<String, Object> param, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			Map<String, Object> sendParam = new HashMap<String, Object>( );
			setCommonParams( sendParam );
			/* 반환처리 */
			mv.addObject( "ViewBag", sendParam );
			mv.setViewName( "/expend/ex/master/content/MasterVatTypeSetting" );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}
}

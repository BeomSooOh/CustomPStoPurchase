package expend.ex.master.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import bizbox.orgchart.service.vo.LoginVO;
import cmm.helper.ConvertManager;
import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExCodeAuthVO;
import common.vo.ex.ExCodeMngVO;
import common.vo.ex.ExCodeSummaryVO;
import common.vo.ex.ExConfigItemListVO;
import common.vo.ex.ExConfigItemVO;
import common.vo.g20.ExCommonResultVO;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import expend.ex.master.config.BExMasterConfigService;
import expend.ex.user.code.BExUserCodeService;


@Controller
public class BExMasterController {

	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
	private ConnectionVO conVo = new ConnectionVO( );
	/* 변수정의 - Service */
	@Resource ( name = "BExMasterConfigService" )
	private BExMasterConfigService exMasterConfigService;
	@Resource ( name = "BExUserCodeService" )
	private BExUserCodeService exUserCodeService;

	/* View - 공통코드 조회 */
	private void setCommonParams ( Map<String, Object> sendParam ) throws Exception {
		LoginVO loginVo = new LoginVO( );
		ExCommonResultVO commonParam = new ExCommonResultVO( );
		/* 초기값 정의 */
		loginVo = CommonConvert.CommonGetEmpVO( );
		commonParam.setComp_seq( loginVo.getCompSeq( ) );
		commonParam.setLang_code( loginVo.getLangCode( ) );
		// VO -> Map
		sendParam.put( "empInfo", CommonConvert.CommonGetObjectToMap( loginVo ) );
		/* ERP 연결정보 조회 */
		/* 기본값 지정 - 연동 시스템 정보 처리 */
		ConnectionVO conVo = null;
		if ( sendParam.get( "comp_seq" ) == null || CommonConvert.CommonGetStr(sendParam.get( "comp_seq" )).equals( commonCode.EMPTYSTR ) || sendParam.get( commonCode.COMPSEQ ) == null || sendParam.get( commonCode.COMPSEQ ).equals( commonCode.EMPTYSTR ) ) {
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
		}
		else if ( sendParam.get( "comp_seq" ) != null && CommonConvert.CommonGetStr(sendParam.get( "comp_seq" )).equals( commonCode.EMPTYSTR ) ) {
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( sendParam.get( "comp_seq" ) ) );
		}
		else {
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( sendParam.get( commonCode.COMPSEQ ) ) );
		}
		sendParam.put( commonCode.IFSYSTEM, conVo.getErpTypeCode( ) );
	}

	/* 공통코드 - 계정과목 생성 */
	@RequestMapping ( "/ex/master/config/AcctInfoInsert.do" )
	public ModelAndView ExCodeAcctInfoInsert ( @RequestParam Map<String, Object> param, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ResultVO result = new ResultVO( );
			/* 초기값 지정 */
			param.put( "createSeq", loginVo.getUniqId( ) );
			param.put( "modifySeq", loginVo.getUniqId( ) );
			setCommonParams( param );
			/* 생성 */
			result = exMasterConfigService.ExCodeAcctInfoInsert( param, conVo );
			/* 반환처리 */
			mv.setViewName( "jsonView" );
			mv.addObject( "aaData", result );
			mv.addObject( commonCode.IFSYSTEM, param.get( commonCode.IFSYSTEM ) );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* 공통코드 - 계정과목 수정 */
	@RequestMapping ( "/ex/master/config/AcctInfoUpdate.do" )
	public ModelAndView ExCodeAcctInfoUpdate ( @RequestParam Map<String, Object> param, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ResultVO result = new ResultVO( );
			/* 초기값 지정 */
			param.put( "createSeq", loginVo.getUniqId( ) );
			param.put( "modifySeq", loginVo.getUniqId( ) );
			setCommonParams( param );
			/* 생성 */
			result = exMasterConfigService.ExCodeAcctInfoUpdate( param, conVo );
			/* 반환처리 */
			mv.setViewName( "jsonView" );
			mv.addObject( "aaData", result );
			mv.addObject( commonCode.IFSYSTEM, param.get( commonCode.IFSYSTEM ) );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* 공통코드 - 계정과목 삭제 */
	@RequestMapping ( "/ex/master/config/AcctInfoDelete.do" )
	public ModelAndView ExCodeAcctInfoDelete ( @RequestParam Map<String, Object> param, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ResultVO result = new ResultVO( );
			/* 초기값 지정 */
			param.put( "createSeq", loginVo.getUniqId( ) );
			param.put( "modifySeq", loginVo.getUniqId( ) );
			setCommonParams( param );
			/* 생성 */
			result = exMasterConfigService.ExCodeAcctInfoDelete( param, conVo );
			/* 반환처리 */
			mv.setViewName( "jsonView" );
			mv.addObject( "aaData", result );
			mv.addObject( commonCode.IFSYSTEM, param.get( commonCode.IFSYSTEM ) );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* 공통코드 - 증빙유형 등록 */
	@RequestMapping ( "/ex/master/config/AuthInfoInsert.do" )
	public ModelAndView AuthInfoInsert ( @RequestParam Map<String, Object> param, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ResultVO result = new ResultVO( );
			/* 초기값 지정 */
			param.put( "createSeq", loginVo.getUniqId( ) );
			param.put( "modifySeq", loginVo.getUniqId( ) );
			setCommonParams( param );
			/* 등록 */
			result = exMasterConfigService.ExCodeAuthInfoInsert( param );
			/* 반환처리 */
			mv.setViewName( "jsonView" );
			mv.addObject( "aaData", result );
			mv.addObject( commonCode.IFSYSTEM, param.get( commonCode.IFSYSTEM ) );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* 공통코드 - 증빙유형 수정 */
	@RequestMapping ( "/ex/master/config/AuthInfoUpdate.do" )
	public ModelAndView AuthInfoUpdate ( @RequestParam Map<String, Object> param, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ResultVO result = new ResultVO( );
			/* 초기값 지정 */
			param.put( "createSeq", loginVo.getUniqId( ) );
			param.put( "modifySeq", loginVo.getUniqId( ) );
			setCommonParams( param );
			/* 등록 */
			result = exMasterConfigService.ExCodeAuthInfoUpdate( param );
			/* 반환처리 */
			mv.setViewName( "jsonView" );
			mv.addObject( "aaData", result );
			mv.addObject( commonCode.IFSYSTEM, param.get( commonCode.IFSYSTEM ) );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* 공통코드 - 증빙유형 삭제 */
	@RequestMapping ( "/ex/master/config/AuthInfoDelete.do" )
	public ModelAndView AuthInfoDelete ( @RequestParam Map<String, Object> param, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ResultVO result = new ResultVO( );
			/* 초기값 지정 */
			param.put( "createSeq", loginVo.getUniqId( ) );
			param.put( "modifySeq", loginVo.getUniqId( ) );
			setCommonParams( param );
			/* 등록 */
			result = exMasterConfigService.ExCodeAuthInfoDelete( param );
			/* 반환처리 */
			mv.setViewName( "jsonView" );
			mv.addObject( "aaData", result );
			mv.addObject( commonCode.IFSYSTEM, param.get( commonCode.IFSYSTEM ) );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* 지출결의 환경설정 - 옵션목록 조회 */
	@RequestMapping ( "/ex/master/config/ExpendOptionListSelect.do" )
	public ModelAndView ExConfigOptionItemsSelect ( @RequestParam Map<String, Object> param, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			/* 초기값 지정 */
			param.put( "create_seq", loginVo.getUniqId( ) );
			param.put( "modify_seq", loginVo.getUniqId( ) );
			setCommonParams( param );
			/* ERP 연결정보 조회 */
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( param.get( "sCompSeq" ) ) );
			param.put( commonCode.IFSYSTEM, conVo.getErpTypeCode( ) );
			/* ERP 회사 코드 확인 */
			param.put( commonCode.ERPCOMPSEQ, exUserCodeService.getErpCompSeq( loginVo, conVo.getErpTypeCode( ), (String) param.get( "sCompSeq" ) ) );
			/* 반환처리 */
			mv.setViewName( "jsonView" );
			param.put( "useSw", conVo.getErpTypeCode( ) );
			param.put( commonCode.LANGCODE, loginVo.getLangCode( ) );
			mv.addObject( "optionItemsSet", exMasterConfigService.ExConfigOptionItemsInfoSelect( param ) );
			mv.addObject( commonCode.IFSYSTEM, conVo.getErpTypeCode( ) );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* 지출결의 환경설정 - 옵션 수정 */
	@RequestMapping ( "/ex/master/config/ExpendOptionUpdate.do" )
	public ModelAndView ExConfigOptionItemUpdate ( @RequestParam Map<String, Object> param, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			/* ServletContext sc = request.getSession().getServletContext(); */
			/* ApplicationContext act = WebApplicationContextUtils.getRequiredWebApplicationContext(sc); */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ExCommonResultVO resultVo = new ExCommonResultVO( );
			/* 초기값 지정 */
			param.put( commonCode.EMPSEQ, loginVo.getUniqId( ) );
			param.put( commonCode.LANGCODE, loginVo.getLangCode( ) );
			List<Map<String, Object>> displayOption = CommonConvert.CommonGetJSONToListMap( param.get( "disOpt" ).toString( ) );
			List<Map<String, Object>> dateOption = CommonConvert.CommonGetJSONToListMap( param.get( "dateOpt" ).toString( ) );
			List<Map<String, Object>> functionOption = CommonConvert.CommonGetJSONToListMap( param.get( "funOpt" ).toString( ) );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( param.get( commonCode.COMPSEQ ) ) );
			param.put( "useSw", conVo.getErpTypeCode( ) );
			boolean result = true;
			// 기존 지출결의 옵션 삭제
			exMasterConfigService.ExConfigExpendDeleteItems( param );
			// 화면 옵션 저장
			for ( int i = 0; i < displayOption.size( ); i++ ) {
				Map<String, Object> sendParam = displayOption.get( i );
				sendParam.put( commonCode.COMPSEQ, param.get( commonCode.COMPSEQ ) );
				sendParam.put( commonCode.FORMSEQ, param.get( commonCode.FORMSEQ ) );
				sendParam.put( "createSeq", loginVo.getCompSeq( ) );
				sendParam.put( "modifySeq", loginVo.getCompSeq( ) );
				// 해당 회사, 양식의 옵션 저장
				result = exMasterConfigService.ExConfigExpendInsertItems( sendParam );
				if ( !result ) {
					mv.addObject( "return", result );
					break;
				}
			}
			// 날짜 옵션 저장
			if ( result ) {
				for ( int i = 0; i < dateOption.size( ); i++ ) {
					Map<String, Object> sendParam = dateOption.get( i );
					sendParam.put( commonCode.COMPSEQ, param.get( commonCode.COMPSEQ ) );
					sendParam.put( commonCode.FORMSEQ, param.get( commonCode.FORMSEQ ) );
					sendParam.put( "createSeq", loginVo.getUniqId( ) );
					sendParam.put( "modifySeq", loginVo.getUniqId( ) );
					// 해당 회사, 양식의 옵션 저장
					result = exMasterConfigService.ExConfigExpendInsertItems( sendParam );
					if ( !result ) {
						mv.addObject( "return", result );
						break;
					}
				}
			}
			// 기능 옵션 저장
			if ( result ) {
				for ( int i = 0; i < functionOption.size( ); i++ ) {
					Map<String, Object> sendParam = functionOption.get( i );
					sendParam.put( commonCode.COMPSEQ, param.get( commonCode.COMPSEQ ) );
					sendParam.put( commonCode.FORMSEQ, param.get( commonCode.FORMSEQ ) );
					sendParam.put( "createSeq", loginVo.getUniqId( ) );
					sendParam.put( "modifySeq", loginVo.getUniqId( ) );
					// 해당 회사, 양식의 옵션 저장
					result = exMasterConfigService.ExConfigExpendInsertItems( sendParam );
					if ( !result ) {
						mv.addObject( "return", result );
						break;
					}
				}
			}
			/* ERP 연결정보 조회 */
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			/* 반환처리 */
			mv.setViewName( "jsonView" );
			mv.addObject( "aaData", resultVo );
			mv.addObject( commonCode.IFSYSTEM, conVo.getErpTypeCode( ) );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	@RequestMapping ( "/ex/master/config/ExpendItemListSelect.do" )
	public ModelAndView GetItemList ( @RequestParam Map<String, Object> param ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		ExConfigItemListVO lVex2ExpendItemListVO = new ExConfigItemListVO( );
		String compSeq = EgovStringUtil.isNullToString( (String) param.get( "comp_seq" ) );
		String formSeq = EgovStringUtil.isNullToString( (String) param.get( "form_seq" ) );
		String itemGbn = EgovStringUtil.isNullToString( (String) param.get( "item_gbn" ) );
		try {
			Map<String, Object> params = new HashMap<String, Object>( );
			params.put( commonCode.GROUPSEQ, CommonConvert.CommonGetEmpVO( ).getGroupSeq( ) );
			params.put( "comp_seq", compSeq );
			params.put( "form_seq", formSeq );
			params.put( "item_gbn", itemGbn );
			lVex2ExpendItemListVO = exMasterConfigService.GetItemListS( params );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		mv.addObject( "aaData", lVex2ExpendItemListVO );
		mv.setViewName( "jsonView" );
		return mv;
	}

	@RequestMapping ( "/ex/master/config/ExpendItemListUpdate.do" )
	public ModelAndView SetItemList ( @RequestParam Map<String, Object> param ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		//return 값
		boolean result = false;
		// JSON -> MAP -> VO 변경 작업 진행
		List<Map<String, Object>> tSelectedList = new ArrayList<Map<String, Object>>( );
		List<Map<String, Object>> tBasicList = new ArrayList<Map<String, Object>>( );
		tSelectedList = ConvertManager.ConvertJsonToListMap( (String) param.get( "selectedList" ) );
		tBasicList = ConvertManager.ConvertJsonToListMap( (String) param.get( "basicList" ) );
		// 선택한 항목 변경 완료
		List<ExConfigItemVO> selectedList = new ArrayList<ExConfigItemVO>( );
		// 기본 항목 변경 완료
		List<ExConfigItemVO> basicList = new ArrayList<ExConfigItemVO>( );
		for ( int i = 0; i < tSelectedList.size( ); i++ ) {
			selectedList.add( (ExConfigItemVO) ConvertManager.ConvertMapToObject( tSelectedList.get( i ), new ExConfigItemVO( ) ) );
			selectedList.get( selectedList.size( ) - 1 ).setOrder_num( tSelectedList.get( i ).get( "order_num" ).toString( ) );
		}
		for ( int j = 0; j < tBasicList.size( ); j++ ) {
			basicList.add( (ExConfigItemVO) ConvertManager.ConvertMapToObject( tBasicList.get( j ), new ExConfigItemVO( ) ) );
			basicList.get( basicList.size( ) - 1 ).setOrder_num( tBasicList.get( j ).get( "order_num" ).toString( ) );
		}
		ExConfigItemListVO itemListVO = new ExConfigItemListVO( );
		itemListVO.setConfigBasicItem( basicList );
		itemListVO.setConfigSelectItem( selectedList );
		try {
			result = exMasterConfigService.setItemList( itemListVO );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		mv.addObject( "aaData", result );
		mv.setViewName( "jsonView" );
		return mv;
	}

	/* 공통코드 - 관리항목 전체 목록 조회 */
	@RequestMapping ( "/ex/master/config/MngListInfoSelect.do" )
	public ModelAndView ExExpendMngListInfoSelect ( @ModelAttribute ExCodeMngVO mngVo, HttpServletRequest request ) throws Exception {
		/* parameter : comp_seq, form_seq, drcr_gbn, erp_comp_seq, search_str */
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			List<ExCodeMngVO> mngListVo = new ArrayList<ExCodeMngVO>( );
			/* ERP 연결정보 조회 */
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( mngVo.getCompSeq( ) ) );
			/* ERP 회사 코드 확인 */
			mngVo.setErpCompSeq( exUserCodeService.getErpCompSeq( loginVo, conVo.getErpTypeCode( ), mngVo.getCompSeq( ) ) );
			/* 조회 */
			/* parameter : comp_seq, form_seq, drcr_gbn, erp_comp_seq, search_str */
			mngListVo = exUserCodeService.ExExpendMngListInfoSelect( mngVo, conVo );
			/* 반환처리 */
			mv.setViewName( "jsonView" );
			mv.addObject( "aaData", mngListVo );
			mv.addObject( commonCode.IFSYSTEM, conVo.getErpTypeCode( ) );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* 관리항목 설정 - 관리항목 설정 정보 삭제 후 생성 */
	@RequestMapping ( "/ex/master/config/MngInfoUpdate.do" )
	public ModelAndView ExConfigMngInfoUpdate ( @ModelAttribute ExCodeMngVO mngVo, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ExCommonResultVO resultVo = new ExCommonResultVO( );
			/* 초기값 지정 */
			mngVo.setCreateSeq( loginVo.getUniqId( ) );
			mngVo.setModifySeq( loginVo.getUniqId( ) );
			/* ERP 연결정보 조회 */
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( mngVo.getCompSeq( ) ) );
			/* 삭제후 생성 */
			resultVo = exMasterConfigService.ExConfigMngInfoUpdate( mngVo );
			/* 반환처리 */
			mv.setViewName( "jsonView" );
			mv.addObject( "aaData", resultVo );
			mv.addObject( commonCode.IFSYSTEM, conVo.getErpTypeCode( ) );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* 관리항목 설정 - 관리항목 설정 정보 삭제 */
	@RequestMapping ( "/ex/config/ExConfigMngInfoDelete.do" )
	public ModelAndView ExConfigMngInfoDelete ( @ModelAttribute ExCodeMngVO mngVo, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ExCommonResultVO resultVo = new ExCommonResultVO( );
			/* 초기값 지정 */
			mngVo.setCreateSeq( loginVo.getUniqId( ) );
			mngVo.setModifySeq( loginVo.getUniqId( ) );
			/* ERP 연결정보 조회 */
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( mngVo.getCompSeq( ) ) );
			/* 삭제 */
			resultVo = exMasterConfigService.ExConfigMngInfoDelete( mngVo );
			/* 반환처리 */
			mv.setViewName( "jsonView" );
			mv.addObject( "aaData", resultVo );
			mv.addObject( commonCode.IFSYSTEM, conVo.getErpTypeCode( ) );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* 환경설정 - 표준적요 등록 */
	@RequestMapping ( "/ex/master/config/SummaryInfoInsert.do" )
	public ModelAndView ExCodeSummaryInfoInsert ( @RequestParam Map<String, Object> param, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ExCodeSummaryVO summaryVo = new ExCodeSummaryVO( );
			Map<String, Object> sendParam = new HashMap<String, Object>( );
			/* 초기값 지정 */
			summaryVo = (ExCodeSummaryVO) ConvertManager.ConvertMapToObject( param, summaryVo );
			summaryVo.setCreateSeq( loginVo.getUniqId( ) );
			summaryVo.setModifySeq( loginVo.getUniqId( ) );
			sendParam.put( commonCode.COMPSEQ, summaryVo.getCompSeq( ) );
			/* ERP 연결정보 조회 */
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( summaryVo.getCompSeq( ) ) );
			/* 수정 */
			summaryVo = exMasterConfigService.ExCodeSummaryInfoInsert( summaryVo );
			/* 반환처리 */
			mv.setViewName( "jsonView" );
			mv.addObject( "aaData", summaryVo );
			mv.addObject( commonCode.IFSYSTEM, conVo.getErpTypeCode( ) );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* 공통코드 - 표준적요 수정 */
	@RequestMapping ( "/ex/master/config/SummaryInfoUpdate.do" )
	public ModelAndView ExCodeSummaryInfoUpdate ( @RequestParam Map<String, Object> param, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ExCodeSummaryVO summaryVo = new ExCodeSummaryVO( );
			ExCommonResultVO resultVo = new ExCommonResultVO( );
			Map<String, Object> sendParam = new HashMap<String, Object>( );
			/* 초기값 지정 */
			summaryVo = (ExCodeSummaryVO) ConvertManager.ConvertMapToObject( param, summaryVo );
			summaryVo.setCreateSeq( loginVo.getUniqId( ) );
			summaryVo.setModifySeq( loginVo.getUniqId( ) );
			sendParam.put( commonCode.COMPSEQ, summaryVo.getCompSeq( ) );
			/* ERP 연결정보 조회 */
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( summaryVo.getCompSeq( ) ) );
			/* 수정 */
			resultVo = exMasterConfigService.ExCodeSummaryInfoUpdate( summaryVo );
			/* 반환처리 */
			mv.setViewName( "jsonView" );
			mv.addObject( "aaData", resultVo );
			mv.addObject( commonCode.IFSYSTEM, conVo.getErpTypeCode( ) );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* 공통코드 - 표준적요 삭제 */
	@RequestMapping ( "/ex/master/config/SummaryInfoDelete.do" )
	public ModelAndView ExCodeSummaryInfoDelete ( @ModelAttribute ExCodeSummaryVO summaryVo, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ExCommonResultVO resultVo = new ExCommonResultVO( );
			Map<String, Object> sendParam = new HashMap<String, Object>( );
			/* 초기값 지정 */
			summaryVo.setCreateSeq( loginVo.getUniqId( ) );
			summaryVo.setModifySeq( loginVo.getUniqId( ) );
			sendParam.put( commonCode.COMPSEQ, summaryVo.getCompSeq( ) );
			/* ERP 연결정보 조회 */
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( summaryVo.getCompSeq( ) ) );
			/* 삭제 */
			resultVo = exMasterConfigService.ExCodeSummaryInfoDelete( summaryVo );
			/* 반환처리 */
			mv.setViewName( "jsonView" );
			mv.addObject( "aaData", resultVo );
			mv.addObject( commonCode.IFSYSTEM, conVo.getErpTypeCode( ) );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* 공통코드 - 환경설정 회사 정보 조회 */
	@RequestMapping ( "/ex/master/config/GetCompanyList.do" )
	public ModelAndView CommonConfigCompanyList ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			params.put( "lang_code", loginVo.getLangCode( ) );
			/* 반환처리 */
			mv.setViewName( "jsonView" );
			mv.addObject( "aaData", exMasterConfigService.GCompanyListS( params ) );
			mv.addObject( commonCode.IFSYSTEM, conVo.getErpTypeCode( ) );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* 공통코드 - 환경설정 양식 목록 조회 */
	@RequestMapping ( "/ex/master/config/GetFormList.do" )
	public ModelAndView CommonConfigFormList ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			params.put( "lang_code", loginVo.getLangCode( ) );
			if ( params.get( "comp_seq" ) == null || CommonConvert.CommonGetStr(params.get( "comp_seq" )).equals( commonCode.EMPTYSTR ) ) {
				params.put( "comp_seq", loginVo.getCompSeq( ) );
			}
			/* 반환처리 */
			mv.setViewName( "jsonView" );
			mv.addObject( "aaData", exMasterConfigService.GFormListS( params ) );
			mv.addObject( commonCode.IFSYSTEM, conVo.getErpTypeCode( ) );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* 공통코드 - 부가세 구분 목록 조회 */
	@RequestMapping ( "/ex/master/config/VatTypeListInfoSelect.do" )
	public ModelAndView ExCodeVatTypeListInfoSelect ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			List<Map<String, Object>> vatTypeListVo = new ArrayList<Map<String, Object>>( );
			Map<String, Object> sendParam = new HashMap<String, Object>( );
			/* 초기값 지정 */
			params.put( "create_seq", loginVo.getUniqId( ) );
			params.put( "modify_seq", loginVo.getUniqId( ) );
			sendParam.put( commonCode.COMPSEQ, params.get( "comp_seq" ) );
			/* ERP 연결정보 확인 */
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( "comp_seq" ) ) );
			/* ERP 회사 코드 확인 */
			params.put( "erp_comp_seq", exUserCodeService.getErpCompSeq( loginVo, conVo.getErpTypeCode( ), params.get( "comp_seq" ).toString( ) ) );
			/* 조회 */
			vatTypeListVo = exMasterConfigService.ExCodeVatTypeListInfoSelect( params, conVo );
			/* 반환처리 */
			mv.setViewName( "jsonView" );
			mv.addObject( "aaData", vatTypeListVo );
			mv.addObject( commonCode.IFSYSTEM, conVo.getErpTypeCode( ) );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* 공통코드 - 부가세 구분 등록 */
	@RequestMapping ( "/ex/code/vat/ExCodeVatTypeInfoInsert.do" )
	public ModelAndView ExCodeVatTypeInfoInsert ( @ModelAttribute ExCodeAuthVO vatTypeVo, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ExCodeAuthVO resultVo = new ExCodeAuthVO( );
			/* 초기값 지정 */
			vatTypeVo.setCreateSeq( loginVo.getUniqId( ) );
			vatTypeVo.setModifySeq( loginVo.getUniqId( ) );
			/* ERP 연결정보 확인 */
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( vatTypeVo.getCompSeq( ) ) );
			/* 수정 */
			resultVo = exMasterConfigService.ExCodeVatTypeInfoInsert( vatTypeVo, conVo );
			/* 반환처리 */
			mv.setViewName( "jsonView" );
			mv.addObject( "aaData", resultVo );
			mv.addObject( commonCode.IFSYSTEM, conVo.getErpTypeCode( ) );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* 공통코드 - 부가세 구분 수정 */
	@RequestMapping ( "/ex/code/vat/ExCodeVatTypeInfoUpdate.do" )
	public ModelAndView ExCodeVatTypeInfoUpdate ( @ModelAttribute ExCodeAuthVO vatTypeVo, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ExCommonResultVO resultVo = new ExCommonResultVO( );
			/* 초기값 지정 */
			vatTypeVo.setCreateSeq( loginVo.getUniqId( ) );
			vatTypeVo.setModifySeq( loginVo.getUniqId( ) );
			/* ERP 연결정보 확인 */
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( vatTypeVo.getCompSeq( ) ) );
			/* 수정 */
			resultVo = exMasterConfigService.ExCodeVatTypeInfoUpdate( vatTypeVo, conVo );
			/* 반환처리 */
			mv.setViewName( "jsonView" );
			mv.addObject( "aaData", resultVo );
			mv.addObject( commonCode.IFSYSTEM, conVo.getErpTypeCode( ) );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* 공통코드 - 부가세 구분 삭제 */
	@RequestMapping ( "/ex/code/vat/ExCodeVatTypeInfoDelete" )
	public ModelAndView ExCodeVatTypeInfoDelete ( @ModelAttribute ExCodeAuthVO vatTypeVo, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ExCommonResultVO resultVo = new ExCommonResultVO( );
			Map<String, Object> sendParam = new HashMap<String, Object>( );
			/* 초기값 지정 */
			vatTypeVo.setCreateSeq( loginVo.getUniqId( ) );
			vatTypeVo.setModifySeq( loginVo.getUniqId( ) );
			sendParam.put( commonCode.COMPSEQ, vatTypeVo.getCompSeq( ) );
			/* ERP 연결정보 확인 */
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( vatTypeVo.getCompSeq( ) ) );
			/* 삭제 */
			resultVo = exMasterConfigService.ExCodeVatTypeInfoDelete( vatTypeVo, conVo );
			/* 반환처리 */
			mv.setViewName( "jsonView" );
			mv.addObject( "aaData", resultVo );
			mv.addObject( commonCode.IFSYSTEM, conVo.getErpTypeCode( ) );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* 지출결의 - 지출결의 항목 및 분개 그리드 헤더 조회 */
	@RequestMapping ( "/ex/master/config/ExpendGridHeadInfoS.do" )
	public ModelAndView GetExpendGridHeadInfoS ( @RequestParam Map<String, Object> param ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();

		List<ExConfigItemVO> lVex2ExpendItemListVO = new ArrayList<ExConfigItemVO>( );
		String compSeq = EgovStringUtil.isNullToString( (String) param.get( "compSeq" ) );
		String formSeq = EgovStringUtil.isNullToString( (String) param.get( "formSeq" ) );
		String itemGbn = EgovStringUtil.isNullToString( (String) param.get( "itemGbn" ) );
		String langType = loginVo.getLangCode();
		try {
			Map<String, Object> params = new HashMap<String, Object>( );
			params.put( "comp_seq", compSeq );
			params.put( "form_seq", formSeq );
			params.put( "item_gbn", itemGbn );
			params.put( "lang_type", langType);
			ExConfigItemVO tParam = new ExConfigItemVO( );
			tParam = (ExConfigItemVO) ConvertManager.ConvertMapToObject( params, tParam );
			lVex2ExpendItemListVO = exMasterConfigService.getExpendGridHeadInfoS( tParam );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			// exUtilCommonService.getErrorMessage(e.getMessage(), "GetItemList", param.toString(), loginVo.getUniqId());
		}
		mv.addObject( "aaData", lVex2ExpendItemListVO );
		mv.setViewName( "jsonView" );
		return mv;
	}
}

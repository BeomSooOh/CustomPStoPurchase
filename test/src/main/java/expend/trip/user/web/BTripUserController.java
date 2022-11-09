package expend.trip.user.web;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import bizbox.orgchart.service.vo.LoginVO;
import cmm.util.CommonUtil;
import common.helper.convert.CommonConvert;
import common.helper.excel.CommonExcel;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import expend.ex.user.code.BExUserCodeService;
import expend.trip.admin.report.BTripAdminReportServiceImpl;
import expend.trip.user.cons.BTripUserConsService;
import expend.trip.user.option.BTripUserOptionService;
import expend.trip.user.res.BTripUserResService;


@Controller
public class BTripUserController {

	/* 변수정의 */
	/* 변수정의 - Service */
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
	@Resource ( name = "BTripUserConsService" )
	private BTripUserConsService consService;
	@Resource ( name = "BTripUserResService" )
	private BTripUserResService resService;
	@Resource ( name = "BTripUserOptionService" )
	private BTripUserOptionService optionService;
	@Resource(name = "BExUserCodeService")
	private BExUserCodeService codeService;
	@Resource ( name = "BTripAdminConsService" )
	private BTripAdminReportServiceImpl reportService;

	/* 출장 결의 문서 정보 생성 */
	@RequestMapping ( "/trip/user/res/insertTripResDoc.do" )
	public ModelAndView insertTripResDoc ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/trip/user/res/insertTripResDoc.do] " + params.toString( ), "-", "TRIP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		try {
			result = resService.insertTripResDoc( params );
			mv.addObject( "result", result );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "품의 문서 정보 생성 실패", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 출장 결의 문서 정보 조회 */
	@RequestMapping ( "/trip/user/res/selectTripResDocAllInfo.do" )
	public ModelAndView selectTripResDocAllInfo ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/trip/user/cons/selectTripConsDocAllInfo.do] " + params.toString( ), "-", "TRIP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		try {
			result = resService.selectTripResDocAllInfo( params );
			mv.addObject( "result", result );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "품의 문서 정보 생성 실패", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 출장 품의 문서 정보 생성 */
	@RequestMapping ( "/trip/user/cons/insertTripConsDoc.do" )
	public ModelAndView insertTripConsDoc ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/trip/user/cons/insertTripConsDoc.do] " + params.toString( ), "-", "TRIP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		try {
			result = consService.insertTripConsDoc( params );
			mv.addObject( "result", result );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "품의 문서 정보 생성 실패", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 출장 품의 문서 정보 조회 */
	@RequestMapping ( "/trip/user/cons/selectTripConsDocAllInfo.do" )
	public ModelAndView selectTripConsDocAllInfo ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/trip/user/cons/selectTripConsDocAllInfo.do] " + params.toString( ), "-", "TRIP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		try {
			result = consService.selectTripConsDocAllInfo( params );
			mv.addObject( "result", result );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "품의 문서 정보 생성 실패", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 출장 품의/결의 옵션 정보 조회 - 장소 설정 */
	@RequestMapping ( "/trip/user/cons/selectOptionLocation.do" )
	public ModelAndView selectOptionLocation ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/trip/user/cons/selectOptionLocation.do] " + params.toString( ), "-", "TRIP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		try {
			result = optionService.selectOptionLocation( params );
			mv.addObject( "result", result );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "품의 문서 정보 생성 실패", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 출장 품의/결의 옵션 정보 조회 - 교통 설정 */
	@RequestMapping ( "/trip/user/cons/selectOptionTransport.do" )
	public ModelAndView selectOptionTransport ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/trip/user/cons/selectOptionTransport.do] " + params.toString( ), "-", "TRIP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		try {
			result = optionService.selectOptionTransport( params );
			mv.addObject( "result", result );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "품의 문서 정보 생성 실패", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 출장 품의/결의 옵션 정보 조회 - 교통 설정 */
	@RequestMapping ( "/trip/user/cons/selectOptionAmt.do" )
	public ModelAndView selectOptionAmt ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/trip/user/cons/selectOptionAmt.do] " + params.toString( ), "-", "TRIP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		try {
			result = optionService.selectOptionAmt( params );
			mv.addObject( "result", result );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "품의 문서 정보 생성 실패", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 품의 정보 조회 */
	@RequestMapping ( "/trip/user/cons/selectConsDocInfo.do" )
	public ModelAndView selectConsDocInfo ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/trip/user/cons/selectConsDocInfo.do] " + params.toString( ), "-", "TRIP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		try {
			result = consService.selectConsDocInfo( params );
			mv.addObject( "result", result );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "품의 문서 정보 생성 실패", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 결의 정보 조회 */
	@RequestMapping ( "/trip/user/res/selectResDocInfo.do" )
	public ModelAndView selectResDocInfo ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/trip/user/res/selectResDocInfo.do] " + params.toString( ), "-", "TRIP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		try {
			result = resService.selectResDocInfo( params );
			mv.addObject( "result", result );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "품의 문서 정보 생성 실패", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 품의 정보 저장 */
	@RequestMapping ( "/trip/user/cons/insertTripCons.do" )
	public ModelAndView insertTripCons ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/trip/user/res/insertTripCons.do] " + params.toString( ), "-", "TRIP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		try {
			result = consService.insertTripConsAttExInfo( params );
			mv.addObject( "result", result );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "품의 문서 정보 생성 실패", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 품의 정보 갱신 */
	@RequestMapping ( "/trip/user/cons/updateTripCons.do" )
	public ModelAndView updateTripCons ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/trip/user/cons/updateTripCons.do] " + params.toString( ), "-", "TRIP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		try {
			result = consService.updateTripConsAttExInfo( params );
			mv.addObject( "result", result );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "품의 문서 정보 생성 실패", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 품의 예산 정보 저장 */
	@RequestMapping ( "/trip/user/cons/insertTripConsBudget.do" )
	public ModelAndView insertTripConsBudget ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/trip/user/res/insertTripConsBudget.do] " + params.toString( ), "-", "TRIP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;

		try {
			result = consService.insertTripConsBudgetInfo(params);
			mv.addObject( "result", result );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "품의 문서 정보 생성 실패", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 결의 예산 정보 저장 */
	@RequestMapping ( "/trip/user/res/insertTripResBudget.do" )
	public ModelAndView insertTripResBudget ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/trip/user/res/insertTripResBudget.do] " + params.toString( ), "-", "TRIP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;

		try {
			result = resService.insertTripResBudgetInfo(params);
			mv.addObject( "result", result );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "품의 문서 정보 생성 실패", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 결의 정보 저장 */
	@RequestMapping ( "/trip/user/res/insertTripRes.do" )
	public ModelAndView insertTripRes ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/trip/user/res/insertTripRes.do] " + params.toString( ), "-", "TRIP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		try {
			result = resService.insertTripResAttExInfo( params );
			mv.addObject( "result", result );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "품의 문서 정보 생성 실패", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 사용자 품의 현황 정보 조회 */
	@RequestMapping ( "/trip/user/cons/selectTripConsReport.do" )
	public ModelAndView selectTripConsReport ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/trip/user/cons/selectTripConsReport.do] " + params.toString( ), "-", "TRIP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		try {
			result = consService.selectTripConsReport( params );
			mv.addObject( "result", result );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "품의 현황 정보 조회 실패", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 사용자 결의 현활 정보 조회 */
	@RequestMapping ( "/trip/user/res/selectTripResReport.do" )
	public ModelAndView selectTripResReport ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/trip/user/res/selectTripResReport.do] " + params.toString( ), "-", "TRIP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		try {
			result = resService.selectTripResReport( params );
			mv.addObject( "result", result );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "품의 현황 정보 조회 실패", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 사용자 참조 품의 가져오기 목록 조회 */
	@RequestMapping ( "/trip/user/res/selectConfferList.do" )
	public ModelAndView selectConfferList ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/trip/user/res/selectConfferList.do] " + params.toString( ), "-", "TRIP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		try {
			result = resService.selectConfferList( params );
			mv.addObject( "result", result );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "품의 현황 정보 조회 실패", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}


	/* 사용자 참조 품의 반영 */
	@RequestMapping ( "/trip/user/res/updateTripConfferCons.do" )
	public ModelAndView updateTripConfferCons ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/trip/user/res/updateTripConfferCons] " + params.toString( ), "-", "TRIP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		try {
			result = resService.updateTripConfferCons ( params );
			mv.addObject( "result", result );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "품의 현황 정보 조회 실패", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 사용자 품의/결의 현황 엑셀 다운로드 기능 지원 */
	@RequestMapping("/trip/user/comm/commonExcel.do")
	public void ExAdminCardReportListExcelDown(@RequestParam Map<String, Object> params, HttpServletRequest request,HttpServletResponse response) throws Exception {
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );

		/* parameter : fromDate, toDate, reqDate, docNo, docTitle */
		FileInputStream fis = null;
		BufferedInputStream in = null;
		ByteArrayOutputStream bStream = null;
		params.put("langCode", CommonConvert.CommonGetEmpInfo().get(commonCode.LANGCODE));
		try {
			/* 데이터 조회 */
			ResultVO result = new ResultVO();
			params.put(commonCode.ERPCOMPSEQ, CommonConvert.CommonGetEmpInfo().get(commonCode.ERPCOMPSEQ));
			params.put(commonCode.COMPSEQ, CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ));
			params.put(commonCode.DEPTSEQ, CommonConvert.CommonGetEmpInfo().get(commonCode.LANGCODE));
			switch (params.get("fileName").toString()) {
			case "나의출장품의현황":
				result = consService.selectTripConsReport( params );
				break;
			case "나의출장결의현황":
				result = resService.selectTripResReport( params );
				break;
			case "출장품의현황":
				result = reportService.selectTripConsReport( params );
				break;
			case "출장결의현황":
				result = reportService.selectTripResReport(params);
				break;
			default:
				break;
			}
			if (result == null) {
				result = new ResultVO();
			}
			/* 파일 명칭(카드사용현황20170925_사용지시퀀스.xlsx) */
			String fileName = commonCode.EMPTYSTR;
			fileName = params.get("fileName").toString();
			Calendar day = Calendar.getInstance();
			SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());
			fileName = fileName + df.format(day.getTime()) + "_"
					+ CommonConvert.CommonGetEmpInfo().get(commonCode.EMPSEQ).toString() + ".xlsx";
			/* 파일 경로(d:/upload/expend/temp/excel/ */
			String filePath = commonCode.EMPTYSTR;

			/* 회계모듈 기본 경로 확인 */
			Map<String, Object> tData = new HashMap<String, Object>();
            tData.put("osType", CommonUtil.osType());
			tData.put("pathSeq", commonCode.EXPPATHSEQ);
			tData.put(commonCode.GROUPSEQ, CommonConvert.CommonGetEmpInfo().get(commonCode.GROUPSEQ).toString());

			// 기본 경로 조회
			tData = codeService.ExCommonExpGroupPathSelect(tData);
			if (tData == null || tData.get("absolPath") == null
					|| CommonConvert.CommonGetStr(tData.get("absolPath")).equals(commonCode.EMPTYSTR)) {
				throw new Exception("그룹 패스를 확인하여 주시길 바랍니다.");
			}
			filePath = tData.get("absolPath").toString() + File.separator + commonCode.EXCELPATH + File.separator;
			/* 파일 구분자 변경 */
			// fileName = fileName.replaceAll( "/", File.separator );
			// filePath = filePath.replaceAll( "/", File.separator ) +
			// File.separator;

			List<Map<String, Object>> aaData = result.getAaData();

			/* 엑셀 데이터 라벨 보정 */
			for(int i = 0;i < aaData.size( ); i++){
				Map<String, Object> item = aaData.get( i );
				item.put( "docStatus", getDocStatusText( item.get( "docStatus" ) ) );
			}

			if (CommonExcel.CreateExcelFile(result.getAaData(), params, filePath, fileName)) {
				/* 파일 리턴 */
				CommonExcel.ExcelDownload(fis, in, bStream, (filePath + fileName), fileName, request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (bStream != null) {
				try {
					bStream.close();
				} catch (Exception ignore) {
					// LOGGER.debug("IGNORE: {}", ignore.getMessage());
				}
			}
			if (in != null) {
				try {
					in.close();
				} catch (Exception ignore) {
					// LOGGER.debug("IGNORE: {}", ignore.getMessage());
				}
			}
			if (fis != null) {
				try {
					fis.close();
				} catch (Exception ignore) {
					// LOGGER.debug("IGNORE: {}", ignore.getMessage());
				}
			}
		}
	}

	private String getDocStatusText(Object item){
		String value = "";
		value = CommonConvert.NullToString( item );
	    if(value.equals( "000")){
	    	return "기안대기";
	    }else if(value.equals( "001")){
	    	return "임시보관";
	    }else if(value.equals( "002")){
	    	return "결재중";
	    }else if(value.equals( "003")){
	    	return "협조중";
	    }else if(value.equals( "004")){
	    	return "결재보류";
	    }else if(value.equals( "005")){
	    	return "문서회수";
	    }else if(value.equals( "006")){
	    	return "다중부서접수중";
	    }else if(value.equals( "007")){
	    	return "기안반려";
	    }else if(value.equals( "008")){
	    	return "결재완료";
	    }else if(value.equals( "009")){
	    	return "발송요구";
	    }else if(value.equals( "101")){
	    	return "감사중";
	    }else if(value.equals( "102")){
	    	return "감사대기";
	    }else if(value.equals( "108")){
	    	return "감사완료";
	    }else if(value.equals( "998")){
	    	return "심사취소";
	    }else if(value.equals( "999")){
	    	return "결재중";
	    }else if(value.equals( "d")){
	    	return "삭제";
	    }
	    /** 영리 전자결재 상태 코드 **/
	    else if(value.equals( "10")){
	    	return "저장";
	    } else if(value.equals( "100")){
	    	return "반려";
	    } else if(value.equals( "110")){
	    	return "보류";
	    } else if(value.equals( "20")){
	    	return "상신";
	    } else if(value.equals( "30")){
	    	return "진행";
	    } else if(value.equals( "40")){
	    	return "발신종결";
	    } else if(value.equals( "50")){
	    	return "수신상신";
	    } else if(value.equals( "60")){
	    	return "수신진행";
	    } else if(value.equals( "70")){
	    	return "수신반려";
	    } else if(value.equals( "80")){
	    	return "수신확인";
	    } else if(value.equals( "90")){
	    	return "종결";
	    }
		return "";
	}
}

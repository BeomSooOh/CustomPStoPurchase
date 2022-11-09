package expend.bi.user.web;

import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundLoginSessionException;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import expend.bi.admin.car.BBiAdminCarService;
import expend.bi.user.car.BBiUserCarService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;


@Controller
public class BBiUserController {

	/* 변수정의 */
	/* 변수정의 - Service */
	@Resource ( name = "BBiUserCarService" )
	private BBiUserCarService carService;
	@Resource ( name = "BBiAdminCarService" )
	private BBiAdminCarService adminCarService;

	/* 변수정의 - Class */
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */


	/* ## 코드 조회 ## */
	/* ## 코드 조회 ## - 차량 */
	//public ModelAndView BiUserCarListInfoSelect ( @RequestParam Map<String, Object> param, HttpServletRequest request ) throws Exception {
	public ModelAndView BiUserCarListInfoSelect ( @RequestParam Map<String, Object> param ) throws Exception {
		/* iCUBE : exec USP_SYP0020_CAR_HELP_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DIV_CD=N'1000|',@EMP_CD=N'2000' */
		/* 변수정의 */
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 정의 */
			param = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), param );
			/* 정보 조회 */
			result = carService.BiUserCarListInfoSelect( result );
			result.setSuccess( );
			/* 반환 처리 */
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return mv;
	}

	/* ## 코드 조회 ## - 운행내역 */
	//public ModelAndView BiUserCarHisListInfoSelect ( @RequestParam Map<String, Object> param, HttpServletRequest request ) throws Exception {
	public ModelAndView BiUserCarHisListInfoSelect ( @RequestParam Map<String, Object> param ) throws Exception {
		/* iCUBE : exec USP_SYP0020_BY_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DIV_CD=N'',@EMP_CD=N'2000',@CAR_CD=N' 1111',@YEAR=N'2017',@MONTH=N'09',@DAY=N'13',@SEND_YN=N'0',@SEQ_NB=0,@START_TIME=N'',@END_TIME=N'',@USE_FG=N'',@START_FG=N'',@START_ADDR=N'',@START_ADDR1=N'',@START_NAVER_VALUE=N'',@END_FG=N'',@END_ADDR=N'',@END_ADDR1=N'',@END_NAVER_VALUE=N'',@MILEAGE_KM=0,@BEFORE_KM=0,@AFTER_KM=0,@RMK_NB=0,@RMK_DC=N'',@A1=N'',@A2=0.0000,@B1=N'',@B2=0.0000,@C1=N'',@C2=0.0000,@D1=N'',@D2=0.0000,@E1=N'',@E2=0.0000,@ETC_RMK=N'',@INSERT_ID=N'2000',@INSERT_IP=N'10.102.40.32',@DML_FG=N'S' */
		/* 변수정의 */
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 정의 */
			param = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), param );
			/* 정보 조회 */
			result = carService.BiUserCarHisListInfoSelect( result );
			result.setSuccess( );
			/* 반환 처리 */
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return mv;
	}

	/* ## 코드 조회 ## - 마지막 주행 거리 */
	/* ## 코드 조회 ## - 북마트 정보 */
	/* ## 코드 조회 ## - 즐겨찾기 정보 */
	/* ## 코드 조회 ## - 휴일 정보 */
	/* ## 코드 조회 ## - 거래처 정보 */
	/* ## 코드 조회 ## - 거래처 주소 정보 */
	/**
	 * 함수명 : BiUserCarPersonListSelect
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 조회
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            compSeq, useDateFrom, useDateTo, carCode(예 : 111','333','222 이런식으로), closeYN(미마감:0, 마감:1)
	 * @return ResultVO
	 */
	@RequestMapping ( "/bi/user/car/BiUserCarPersonListSelect.do" )
	public ModelAndView ExUserInitExpendSelect ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		result.setParams( params );
		carService.BiUserCarPersonListSelect( result );
		mv.setViewName( "jsonView" );
		mv.addObject( "result", result );
		return mv;
	}

	/**
	 * 함수명 : BiUserCarPersonInsert
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 등록
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 * @return ResultVO
	 */
	@RequestMapping ( "/bi/user/car/BiUserCarPersonInsert.do" )
	public ModelAndView BiUserCarPersonInsert ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		result.setParams( params );
		carService.BiUserCarPersonInsert( result );
		mv.setViewName( "jsonView" );
		mv.addObject( "result", result );
		return mv;
	}

	/**
	 * 함수명 : BiUserCarPersonUpdate
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 수정
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            compSeq, carCode, useDate, seqNumber
	 * @return ResultVO
	 */
	@RequestMapping ( "/bi/user/car/BiUserCarPersonUpdate.do" )
	public ModelAndView BiUserCarPersonUpdate ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		result.setParams( params );
		carService.BiUserCarPersonUpdate( result );
		mv.setViewName( "jsonView" );
		mv.addObject( "result", result );
		return mv;
	}

	/**
	 * 함수명 : BiUserCarPersonDelete
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 삭제
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            compSeq, carCode, useDate, seqNumber
	 * @return ResultVO
	 */
	@RequestMapping ( "/bi/user/car/BiUserCarPersonDelete.do" )
	public ModelAndView BiUserCarPersonDelete ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		result.setParams( params );
		carService.BiUserCarPersonDelete( result );
		mv.setViewName( "jsonView" );
		mv.addObject( "result", result );
		return mv;
	}

	/**
	 * 함수명 : BiUserCarPersonClose
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 마감/취소
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            closeYN(0:미마감, 1:마감), modifySeq, ip, compSeq, carCode, useDate, seqNumber
	 * @return ResultVO
	 */
	@RequestMapping ( "/bi/user/car/BiUserCarPersonClose.do" )
	public ModelAndView BiUserCarPersonClose ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		result.setParams( params );
		carService.BiUserCarPersonClose( result );
		mv.setViewName( "jsonView" );
		mv.addObject( "result", result );
		return mv;
	}

	/**
	 * 함수명 : BiUserCarPersonSend
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 전송/취소
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            erpSendYN(0:미전송, 1:전송), erpSendSeq, modifySeq, ip, compSeq, carCode, useDate, seqNumber
	 * @return ResultVO
	 */
	@RequestMapping ( "/bi/user/car/BiUserCarPersonSend.do" )
	public ModelAndView BiUserCarPersonSend ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		result.setParams( params );
		carService.BiUserCarPersonSend( result );
		mv.setViewName( "jsonView" );
		mv.addObject( "result", result );
		return mv;
	}

	/**
	 * 함수명 : BiUserCarBookmarkSelect
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 즐겨찾기 조회
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            empSeq, compSeq
	 * @return ResultVO
	 */
	@RequestMapping ( "/bi/user/car/BiUserCarBookmarkSelect.do" )
	public ModelAndView BiUserCarBookmarkSelect ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		result.setParams( params );
		carService.BiUserCarBookmarkSelect( result );
		mv.setViewName( "jsonView" );
		mv.addObject( "result", result );
		return mv;
	}

	/**
	 * 함수명 : BiUserCarBookmarkInsert
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 즐겨찾기 등록
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 * @return ResultVO
	 */
	@RequestMapping ( "/bi/user/car/BiUserCarBookmarkInsert.do" )
	public ModelAndView BiUserCarBookmarkInsert ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		result.setParams( params );
		carService.BiUserCarBookmarkInsert( result );
		mv.setViewName( "jsonView" );
		mv.addObject( "result", result );
		return mv;
	}

	/**
	 * 함수명 : BiUserCarBookmarkUpdate
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 즐겨찾기 수정
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            bookmarkCode, empSeq, compSeq
	 * @return ResultVO
	 */
	@RequestMapping ( "/bi/user/car/BiUserCarBookmarkUpdate.do" )
	public ModelAndView BiUserCarBookmarkUpdate ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		result.setParams( params );
		carService.BiUserCarBookmarkUpdate( result );
		mv.setViewName( "jsonView" );
		mv.addObject( "result", result );
		return mv;
	}

	/**
	 * 함수명 : BiUserCarBookmarkDelete
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 즐겨찾기 삭제
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            bookmarkCode, empSeq, compSeq
	 * @return ResultVO
	 */
	@RequestMapping ( "/bi/user/car/BiUserCarBookmarkDelete.do" )
	public ModelAndView BiUserCarBookmarkDelete ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		result.setParams( params );
		carService.BiUserCarBookmarkDelete( result );
		mv.setViewName( "jsonView" );
		mv.addObject( "result", result );
		return mv;
	}

	/**
	 * 함수명 : BiUserCarRmkSelect
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 비고 조회
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            erpCompSeq, erpEmpSeq
	 * @return ResultVO
	 */
	@RequestMapping ( "/bi/user/car/BiUserCarRmkSelect.do" )
	public ModelAndView BiUserCarRmkSelect ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		result.setParams( params );
		carService.BiUserCarRmkSelect( result );
		mv.setViewName( "jsonView" );
		mv.addObject( "result", result );
		return mv;
	}

	/**
	 * 함수명 : BiUserCarRmkUpdate
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 비고 수정
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            erpCompSeq, erpEmpSeq, rmkNb, useFg
	 * @return ResultVO
	 */
	@RequestMapping ( "/bi/user/car/BiUserCarRmkUpdate.do" )
	public ModelAndView BiUserCarRmkUpdate ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		result.setParams( params );
		carService.BiUserCarRmkUpdate( result );
		mv.setViewName( "jsonView" );
		mv.addObject( "result", result );
		return mv;
	}

	/**
	 * 함수명 : BiUserCarRmkInsert
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 비고 등록
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 * @return ResultVO
	 */
	@RequestMapping ( "/bi/user/car/BiUserCarRmkInsert.do" )
	public ModelAndView BiUserCarRmkInsert ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		result.setParams( params );
		carService.BiUserCarRmkInsert( result );
		mv.setViewName( "jsonView" );
		mv.addObject( "result", result );
		return mv;
	}

	/**
	 * 함수명 : BiUserCarRmkDelete
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 비고 삭제
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            erpCompSeq, erpEmpSeq, rmkNb, useFg
	 * @return ResultVO
	 */
	@RequestMapping ( "/bi/user/car/BiUserCarRmkDelete.do" )
	public ModelAndView BiUserCarRmkDelete ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		result.setParams( params );
		carService.BiUserCarRmkDelete( result );
		mv.setViewName( "jsonView" );
		mv.addObject( "result", result );
		return mv;
	}

	/**
	 * 함수명 : BiUserCarListSelect
	 * 함수설명 : 사용자 - 업무용승용차관리 운행기록부 - 차량선택팝업
	 * 생성일자 : 2017. 10. 17.
	 *
	 * @param searchKeyword 검색어
	 * @return ResultVO
	 */
	@RequestMapping ( "/bi/user/car/BiUserCarListSelect.do" )
	public ModelAndView BiUserCarListSelect ( @RequestParam(defaultValue = "") String searchKeyword, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView();
		ResultVO result = new ResultVO();
		Map<String, Object> params = new HashMap();

		if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
			throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
		}

		params = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), params );
		/* ERP 연결정보 조회 */
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( CommonInterface.commonCode.COMPSEQ ) ) );

		/* 검색 조건 */
		params.put("searchStr", searchKeyword);
		params.put("useYN", "1");
		result.setParams( params );
		adminCarService.BiAdminCarInfoListSelect( result, conVo );
		mv.setViewName( "jsonView" );
		mv.addObject( "result", result );
		return mv;
	}
}
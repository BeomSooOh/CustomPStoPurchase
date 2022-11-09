package expend.bi.admin.web;

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
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import expend.bi.admin.car.BBiAdminCarService;


@Controller
public class BBiAdminController {

	/* 변수정의 */
	/* 변수정의 - Service */
	@Resource ( name = "BBiAdminCarService" )
	private BBiAdminCarService carService;
	/* 변수정의 - Class */
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */


	/**
	 * 함수명 : BiAdminCarInfoListSelect
	 * 함수설명 : 차량 정보 조회
	 * 생성일자 : 2017. 9. 1.
	 *
	 * @param param
	 *            compSeq, searchStr(선택/검색)
	 * @return ResultVO
	 */
	@RequestMapping ( "/bi/admin/car/CarInfoListSelect.do" )
	public ModelAndView BiUserInitExpendSelect ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		/* parameter : searchStr */
		/* 변수정의 */
		ModelAndView mv = new ModelAndView( );
		params = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), params );
		ResultVO result = new ResultVO( );
		try {
			/* ERP 연결정보 조회 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ) );
			/* 필요 파라미터 정의 */
			result.setParams( params );
			/* 데이터 조회 */
			result = carService.BiAdminCarInfoListSelect( result, conVo );
			/* 반환처리 */
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		catch ( Exception e ) {
			// TODO: log..
			mv.addObject( "result", "" );
		}
		return mv;
	}

	/**
	 * 함수명 : BiAdminCarInfoSync
	 * 함수설명 : iCUBE 차량정보 동기화
	 * 생성일자 : 2017. 9. 1.
	 *
	 * @param param
	 *            erpCompSeq, compSeq
	 * @return ResultVO
	 */
	@RequestMapping ( "/bi/admin/car/BiAdminCarInfoSync.do" )
	public ModelAndView BiAdminCarInfoSync ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		/* ERP 연결정보 조회 */
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
		ResultVO result = new ResultVO( );
		params.put( "erpCompSeq", loginVo.getErpCoCd( ) );
		params.put( "compSeq", loginVo.getCompSeq( ) );
		result.setParams( params );
		result = carService.BiAdminCarInfoSync( result, conVo );
		mv.setViewName( "jsonView" );
		mv.addObject( "result", result );
		return mv;
	}
}
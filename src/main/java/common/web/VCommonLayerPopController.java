/**
  * @FileName : VCommonLayerPopController.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package common.web;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.CommonMapInterface.commonPath;


/**
 *   * @FileName : VCommonLayerPopController.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
public class VCommonLayerPopController {

	/* ################################################## */
	/* 변수정의 */
	/* ################################################## */
	/* ################################################## */
	/* 공통 Layer Popup */
	/* ################################################## */
	/* 공통 Layer Popup - 알림 - 확인 */
	@RequestMapping ( "/common/AlertLayerPop.do" )
	public ModelAndView AlertLayerPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		/* parameters : alertMessage */
		/* 변수정의 */
		ModelAndView mv = new ModelAndView( );
		/* 프로세스 */
		try {
			/* 필수 파라미터 점검 */
			if ( CommonConvert.CommonGetStr( params.get( commonCode.ALERTMESSAGE ) ).equals( commonCode.EMPTYSTR ) ) {
				params.put( commonCode.ALERTMESSAGE, commonCode.EMPTYSTR );
			}
			/* 반환정보 가공 */
			mv.addObject( "ViewBag", params ); /* { ViewBag: { alertMessage: "" } } */
			mv.setViewName( commonPath.LAYERPATH + commonPath.COMMONALERT ); /* /expend/common/layer/AlertLayerPop */
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		/* 반환처리 */
		return mv;
	}
}

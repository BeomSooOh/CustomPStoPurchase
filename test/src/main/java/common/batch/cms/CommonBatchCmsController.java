package common.batch.cms;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ResultVO;


@Controller
public class CommonBatchCmsController {

	/* 변수정의 */
	/* 변수정의 - Service */
	@Resource ( name = "CommonBatchCmsService" )
	CommonBatchCmsService cmsService;
	
	@Resource ( name = "CommonBatchCmsServiceTest" )
	CommonBatchCmsServiceTest cmsServiceTest;

	/* CMS 동기화 실행 바로실행 */
	/* CMS 동기화 실행 바로실행 - ERPiU */
	/* CMS 동기화 실행 바로실행 - ERPiU - 미구현 */
	/* CMS 동기화 실행 바로실행 - iCUBE */
	/* CMS 동기화 실행 바로실행 - iCUBE - 스마트 자금관리 미구현 */
	/* CMS 동기화 실행 바로실행 - iCUBE - 하나은행 구현 완료 */
	@RequestMapping ( "/common/batch/cms/CommonSetCmsSyncNow.do" )
	public ModelAndView CommonSetCmsSyncNow ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		ResultVO resultVo = new ResultVO( );
		try {
			params.put("cmsPeriodSync", "");
			cmsService.CommonSetCmsSync(params);
			resultVo.setResultCode( commonCode.SUCCESS );
			resultVo.setResultName( commonCode.SUCCESS );
		}
		catch ( Exception e ) {
			resultVo.setResultCode( commonCode.FAIL );
			resultVo.setResultName( commonCode.FAIL );
		}
		mv.setViewName( "jsonView" );
		mv.addObject( "result", resultVo );
		return mv;
	}
	
	@RequestMapping ( "/common/batch/cms/CommonSetCmsSyncPeriod.do" )
	public ModelAndView CommonSetCmsSyncPeriod ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		ResultVO resultVo = new ResultVO( );
		int isSuccess = 1;
		try {
  		    params.put("cmsPeriodSync", "");
            cmsService.CommonSetCmsSync(params);
			isSuccess = cmsServiceTest.CommonSetCmsSynctest(params);
			if(isSuccess == 0 || isSuccess == 3) {
				throw new Exception();
			}
			
			resultVo.setResultCode( commonCode.SUCCESS );
			resultVo.setResultName( commonCode.SUCCESS );
		}
		catch ( Exception e ) {
			resultVo.setResultCode( commonCode.FAIL );
			resultVo.setResultName( commonCode.FAIL );
			Map<String, Object> isSucessAdata = new HashMap<String, Object>();
			isSucessAdata.put("isSuccess", isSuccess);
			resultVo.setaData(isSucessAdata);
		}
		mv.setViewName( "jsonView" );
		mv.addObject( "result", resultVo );
		return mv;
	}
}
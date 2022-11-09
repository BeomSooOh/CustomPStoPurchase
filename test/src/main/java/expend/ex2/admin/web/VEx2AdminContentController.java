/**
  * @FileName : VEx2AdminContentController.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ex2.admin.web;

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
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.CommonMapInterface.Ex2Path;
import common.vo.common.ConnectionVO;
import common.vo.common.CustomLabelVO;
import egovframework.com.cmm.annotation.IncludedInfo;


/**
 *   * @FileName : VEx2AdminContentController.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Controller
public class VEx2AdminContentController {

	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */

	/* 표준적요 설정 - Ex2ConfigSummary */
	@IncludedInfo ( name = "[관리자] 표준적요 관리(설정) v2.0", order = 1120, gid = 110 )
	@RequestMapping ( "/ex/admin/config/Ex2ConfigSummary.do" )
	public ModelAndView Ex2ConfigSummary ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			/* 로그인 여부 & 관리자 권한 확인 */
			mv.setViewName( CommonConvert.CommonLoginAuthChk( Ex2Path.ADMINCONTENT + Ex2Path.CONFIGSUMMARY, commonCode.ADMIN ) );
			/* 사용여부 - 테스트용 */
			List<Map<String, Object>> useYN = new ArrayList<Map<String, Object>>( );
			String[] code = { "", "Y", "N" };
			String[] name = { "전체선택", "사용", "미사용" };
			for ( int i = 0; i < 3; i++ ) {
				Map<String, Object> item = new HashMap<String, Object>( );
				item.put( "code", code[i] );
				item.put( "name", name[i] );
				useYN.add( item );
			}
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			/* 필요 반환 값 정의 */
			mv.addObject( "useYN", CommonConvert.CommonGetListMapToJson( useYN ) );
			mv.addObject( "empInfo", CommonConvert.CommonGetEmpInfo( ) );
			mv.addObject( "CL", vo.getData( ) );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		/* 사용여부 공통코드 : JSON.parse( '${useYN}' || [] ) */
		/* 회사시퀀스 : '${empInfo.compSeq}' / 사원시퀀스 : '${empInfo.empSeq}' */
		return mv;
	}

	/* 증빙유형 설정 - Ex2ConfigAuth */
	@IncludedInfo ( name = "[관리자] 증빙유형 관리(설정) v2.0", order = 1121, gid = 110 )
	@RequestMapping ( "/ex2/admin/config/Ex2ConfigAuth.do" )
	public ModelAndView Ex2ConfigAuth ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			/* 로그인 여부 & 관리자 권한 확인 */
			mv.setViewName( CommonConvert.CommonLoginAuthChk( Ex2Path.ADMINCONTENT + Ex2Path.CONFIGAUTH, commonCode.ADMIN ) );
			/* 사용여부 - 테스트용 */
			List<Map<String, Object>> useYN = new ArrayList<Map<String, Object>>( );
			String[] code = { "", "Y", "N" };
			String[] name = { "전체선택", "사용", "미사용" };
			for ( int i = 0; i < 3; i++ ) {
				Map<String, Object> item = new HashMap<String, Object>( );
				item.put( "code", code[i] );
				item.put( "name", name[i] );
				useYN.add( item );
			}
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( pCompSeq ) );
			/* 필요 반환 값 정의 */
			mv.addObject( "useYN", CommonConvert.CommonGetListMapToJson( useYN ) );
			mv.addObject( "empInfo", CommonConvert.CommonGetEmpInfo( ) );
			mv.addObject( "ifSystem", conVo.getErpTypeCode( ) );
			mv.addObject( "CL", vo.getData( ) );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		/* 사용여부 공통코드 : JSON.parse( '${useYN}' || [] ) */
		/* 회사시퀀스 : '${empInfo.compSeq}' / 사원시퀀스 : '${empInfo.empSeq}' */
		return mv;
	}
}

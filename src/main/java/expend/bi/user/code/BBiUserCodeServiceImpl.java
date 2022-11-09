package expend.bi.user.code;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


@Service ( "BBiUserCodeService" )
public class BBiUserCodeServiceImpl implements BBiUserCodeService {

	/* ################################################## */
	/* 변수정의 */
	/* ################################################## */
	/* 변수정의 */
	/* 변수정의 - Service */
	@Resource ( name = "FBiUserCodeServiceI" )
	private FBiUserCodeService codeServiceI;
	@Resource ( name = "FBiUserCodeServiceA" )
	private FBiUserCodeService codeServiceA;
	/* 변수정의 - Class */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */

	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */

	/**
	 * 함수명 : BiUserCarCommonCode
	 * 함수설명 : 사용자 - 공통코드 조회
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            erpCompSeq, langCode, codeType, searchDate, searchStr, erpEmpCd, erpDeptCd
	 * @return ResultVO
	 */
	public ResultVO BiUserCarCommonCode ( ResultVO param,ConnectionVO conVo ) throws Exception{
		/* 로그인 정보 저장 */
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		/* 전달 파라미터 저장 */
		Map<String, Object> tParam = param.getParams( );
		/* 서비스 정의 */
		FBiUserCodeService tService;

		/* 필수 파라미터 존재 여부 체크 */
		if(param.getParams( ).get( "erpCoCd" ) == null || param.getParams( ).get( "erpCoCd" ).toString( ).equals( commonCode.EMPTYSTR )){
			tParam.put( "erpCoCd", loginVo.getErpCoCd( ) );
			param.setParams( tParam );
		}
		if(param.getParams( ).get( "langCode" ) == null || param.getParams( ).get( "langCode" ).toString( ).equals( commonCode.EMPTYSTR )){
			tParam.put( "langCode", loginVo.getLangCode( ) );
			param.setParams( tParam );
		}
		if(param.getParams( ).get( "codeType" ) == null || param.getParams( ).get( "codeType" ).toString( ).equals( commonCode.EMPTYSTR )){
			throw new Exception( "codeType 파라미터가 미존재합니다." );
		}
		if(param.getParams( ).get( "searchDate" ) == null || param.getParams( ).get( "searchDate" ).toString( ).equals( commonCode.EMPTYSTR )){
			SimpleDateFormat tDate = new SimpleDateFormat( "yyyyMMdd", Locale.getDefault() );
			tParam.put( "searchDate", tDate.format( new Date( ) ) );
			param.setParams( tParam );
		}
		if(param.getParams( ).get( "erpEmpCd" ) == null || param.getParams( ).get( "erpEmpCd" ).toString( ).equals( commonCode.EMPTYSTR )){
			tParam.put( "erpEmpCd", loginVo.getErpEmpCd( ) );
			param.setParams( tParam );
		}
		if(param.getParams( ).get( "erpDeptCd" ) == null || param.getParams( ).get( "erpDeptCd" ).toString( ).equals( commonCode.EMPTYSTR )){
			tParam.put( "erpDeptCd", loginVo.getErpDeptCd( ) );
			param.setParams( tParam );
		}

		switch ( param.getParams( ).get( "codeType" ).toString( ).toLowerCase( ) ) {
			case "emp":
			case "dept":
			case "car":
			case "biz":
				tService = codeServiceI;
				break;
			default:
				tService = codeServiceA;
				break;
		}

		tService.BiUserCarCommonCode( param, conVo );
		return param;
	}
}
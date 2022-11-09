package expend.np.admin.option;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


@Service ( "BNpAdminOptionService" )
public class BNpAdminOptionServiceImpl implements BNpAdminOptionService {

	@Resource ( name = "FNpAdminOptionServiceI" )
	private FNpAdminOptionService serviceOptionI;
	@Resource ( name = "FNpAdminOptionServiceU" )
	private FNpAdminOptionService serviceOptionU;
	@Resource ( name = "FNpAdminOptionServiceA" )
	private FNpAdminOptionService serviceOptionA;

	/**
	 * ERP 옵션 조회
	 */
	@Override
	public ResultVO selectERPOption ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
				result = serviceOptionI.selectERPOption( params, conVo );
			}
			else if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
				result = serviceOptionU.selectERPOption( params, conVo );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "ERP 설정 구분을 확인할 수 없습니다.", ex );
		}
		return result;
	}

	/**
	 * GW 옵션 조회
	 * 
	 */
	@Override
	public ResultVO selectGWOption ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			params.put( "useSw", conVo.getErpTypeCode( ) );
			params.put( "compSeq", CommonConvert.CommonGetEmpVO( ).getCompSeq( ) );
			result = serviceOptionA.selectGWOption( params, conVo );
		}
		catch ( Exception ex ) {
			result.setFail( "GW 설정을 확인할 수 없습니다.", ex );
		}
		return result;
	}


	/**
	 * 	공통옵션	[공통옵션 저장]
	 * 	params : { 
	 * 		"formSeq" ["0"] - 문서번호
	 * 		, "optionGbn" ["common":공통, "cons":품의서, "res":결의서] - 옵션구분
	 * 		, "optionCode" ["001001"] - 옵션코드
	 * 		, "setValue" ["Y"] - 옵션 값
	 * 		, "setName" ["사용"] - 옵션 이름
	 * 	}
	 */
	public ResultVO updateGWOption ( Map<String, Object> params, common.vo.common.ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			params.put( "useSw", conVo.getErpTypeCode( ) );
			params.put( "compSeq", CommonConvert.CommonGetEmpVO( ).getCompSeq( ) );
			result = serviceOptionA.updateGWOption( params, conVo );
		}
		catch ( Exception ex ) {
			result.setFail( "GW 설정 변경에 오류가 발생했습니다.", ex );
		}
		return result;
	}
}

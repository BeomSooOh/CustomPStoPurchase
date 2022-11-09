package expend.np.user.code;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundLoginSessionException;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import expend.np.user.cons.BNpUserConsService;


@Service ( "BNpUserCodeService" )
public class BNpUserCodeServiceImpl implements BNpUserCodeService {

	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo;
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );
	@Resource ( name = "BNpUserConsService" )
	private BNpUserConsService consA; /* Bizbox Alpha */
	@Resource ( name = "FNpUserCodeServiceA" )
	private FNpUserCodeService codeA; /* Bizbox Alpha */
	@Resource ( name = "FNpUserCodeServiceI" )
	private FNpUserCodeService codeI; /* ERP iCUBE */
	@Resource ( name = "FNpUserCodeServiceU" )
	private FNpUserCodeService codeU; /* ERP iU */


	@SuppressWarnings ( "unchecked" )
	@Override
	public ResultVO GetCommonCode ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		/* [예외 검증] ERP 연결정보 조회 */
		LoginVO loginVo = new LoginVO( );
		try {
			loginVo = CommonConvert.CommonGetEmpVO( );
		}
		catch ( NotFoundLoginSessionException e ) {
			result.setFail( "로그인 세션 검색 실패" );
			return result;
		}
		ConnectionVO conVo = new ConnectionVO( );
		try {
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			params.put( "erpCompSeq", loginVo.getErpCoCd( ) );

			/** ERP 코드 정보조회 추가 파라미터 보정 영역 **/
			/* 1. [품의참조 결의서] 결의서 예산 리스트 조회의 경우 */
			Map<String, Object> innerParam = CommonConvert.CommonGetJSONToMap( params.get( "param" ).toString( ) ) ;
			String code = params.get( "code" ).toString( );
			if( ( code.equals( "budgetlist" ) || code.equals( "budget" ) || code.equals( "bizplan" ) || code.equals( "bgacct" ))
					&& ( innerParam.get( "resSeq" ) != null )){
				ResultVO consBudgetInfo = consA.selectConfferConsBudgetInfo( innerParam );
				if(consBudgetInfo.getResultCode( ).equals( commonCode.SUCCESS )){
					if(CommonConvert.CommonGetStr(consBudgetInfo.getaData( ).get( "isConffer" )).equals( "Y" )){
						String erpBudgetSeqs = "";
						for(String item : ((List<String>) consBudgetInfo.getaData( ).get("erpBudgetSeq")) ){
							erpBudgetSeqs += "|" + item + "|";
						}
						String erpBizplanSeqs = "";
						for(String item : ((List<String>) consBudgetInfo.getaData( ).get("erpBizplanSeq")) ){
							erpBizplanSeqs += "|" + item + "|";
						}
						String erpFiacctSeqs = "";
						for(String item : ((List<String>) consBudgetInfo.getaData( ).get("erpFiacctSeq")) ){
							erpFiacctSeqs += "|" + item + "|";
						}
						String erpBgacctSeqs = "";
						for(String item : ((List<String>) consBudgetInfo.getaData( ).get("erpBgacctSeq")) ){
							erpBgacctSeqs += "|" + item + "|";
						}
						innerParam.put( "advParam_erpBudgetSeqs",  erpBudgetSeqs);
						innerParam.put( "advParam_erpBizplanSeqs",  erpBizplanSeqs);
						innerParam.put( "advParam_erpFiacctSeqs",  erpFiacctSeqs);
						innerParam.put( "advParam_erpBgacctSeqs",  erpBgacctSeqs);
						innerParam.remove( "dummy" );
						params.put( "param", CommonConvert.CommonGetMapToJSONStr( innerParam ));
					}
				}
			}

			/* 2. 추가 파라미터가 필요한 경우 아래에 추가하세요. */
		}
		catch ( NotFoundLoginSessionException e ) {
			e.printStackTrace( );
		}
		catch ( Exception e ) {
			e.printStackTrace();
		}
		FNpUserCodeService codeS = null;
		if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
			codeS = codeI;
		}
		else if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
			codeS = codeU;
		}
		else {
			codeS = codeA;
		}
		result = codeS.GetCommonCode( params, conVo );
		return result;
	}

	public ResultVO GetTradeAdvInfo(Map<String, Object> params){
		ResultVO result = new ResultVO();

		params.put( "param", CommonConvert.CommonGetMapToJSONObj( params ) );
		params.put( "code", "trAdv" );

		LoginVO loginVo = new LoginVO( );
		ConnectionVO conVo = new ConnectionVO( );

		try {
			loginVo = CommonConvert.CommonGetEmpVO( );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			result = codeU.GetCommonCode( params, conVo );

		}
		catch ( Exception e ) {
			e.printStackTrace();
			result.setFail( e.getLocalizedMessage( ) );
		}
		return result;
	}

	public ResultVO UpdateInterfaceInfo ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		result = codeA.UpdateInterfaceInfo( params );
		return result;
	}
}
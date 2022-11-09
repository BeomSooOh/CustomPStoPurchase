package expend.np.user.option;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundLogicException;
import common.helper.logger.CommonLogger;
import common.procedure.npG20.BCommonProcService;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


@Service ( "FNpUserOptionServiceI" )
public class FNpUserOptionServiceIImpl implements FNpUserOptionService {

	/* 변수정의 */
	/* 변수정의 - DAO */
	@Resource ( name = "FNpUserOptionServiceIDAO" )
	private FNpUserOptionServiceIDAO dao;
	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog;
	@Resource ( name = "BCommonProcService" )
	private BCommonProcService procService;

	public Map<String, Object> npTest ( Map<String, Object> params, common.vo.common.ConnectionVO conVo ) throws Exception {
		cmLog.CommonSetInfo( "Call ExUserEmpListInfoSelect(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		Map<String, Object> result = new HashMap<String, Object>( );
		try {
			result = dao.npTest( params, conVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}

	/**
	 * iCUBE-G20 ERP 환경 설정 조회
	 */
	@Override
	public ResultVO selectERPOption ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			params.put( "erpCompSeq", conVo.getErpCompSeq( ) );
			result = dao.selectERPOption( params, conVo );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail( "AP 서버 데이터 가공 실패", ex );
		}
		return result;
	}

	/**
	 * GW 환경설정 조회 - GW전용 메서드.
	 */
	@Override
	public ResultVO selectGWOption ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		result.setFail( "GW 전용 메소드 입니다." );
		return result;
	}

	/**
	 * ERP 기본 데이터 조회 - GW전용 메서드.
	 */
	@Override
	public ResultVO selectBaseData ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			/* 사용자 기본 정보 조회 */
			result.addAaData( dao.selectBaseData( params, conVo ).get( 0 ) );
			/* 추가... */
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail( "iCUBE G20 기본 데이터 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * ERP 부가세 예산통제 사용여부
	 */
	@Override
	public ResultVO selectVatCtrData ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			params.put( "moduleCode", "4" );
			params.put( "ctrCode", "03" );
			/* 예산통제 부가세 부가세 포함여부 조회 */
			result.setaData( dao.selectERPCertainOption( params, conVo ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail( "iCUBE G20 기본 데이터 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectEaFormInfo ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		throw new NotFoundLogicException( "전자결재 정보 조회 기능으로 BizboxA전용 로직입니다.", commonCode.ERPIU );
	}

	@Override
	public ResultVO selectAbgtInfo ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		HashMap<String, Object> rMap = new HashMap<>( );

		/* 예산별 상세 정보 조회 */
		HashMap<String, Object> procParams = new HashMap<>( );
		procParams.put( "procType", "budget" );

		procParams.put( "erpCompSeq", params.get("erpCompSeq") );
		procParams.put( "erpDivSeq", params.get("erpBudgetDivSeq") );
		procParams.put( "erpMgtSeq", params.get("erpMgtSeq") );
		procParams.put( "erpBudgetSeq", params.get("erpBudgetSeq") );
		procParams.put( "erpGisuDate", params.get("expendDate") );
		procParams.put( "sumAm", params.get("budgetAmt") );
		procParams.put( "erpBottomSeq", params.get("bottomSeq") );
		procParams.put( "gisu", params.get("gisu") );

		result = procService.getProcResult( procParams );
		if(CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS )){
			Map<String, Object> t = result.getAaData( ).get( 0 );
			if(t.get( "ctlFg" ) != null && Integer.parseInt( t.get( "ctlFg" ).toString( ) ) < 5){
				rMap.put("ctlBudget", commonCode.CANBGT );
			}else{
				rMap.put("ctlBudget", "N" );
			}
		}
		result.setaData( rMap );
		return result;
	}

	@Override
	public ResultVO selectBasicOption ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		result.setFail( "GW 전용 기능입니다." );
		return result;
	}
}










package expend.np.user.budget;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.procedure.npG20.BCommonProcService;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


@Service ( "FNpUserBudgetServiceI" )
public class FNpUserBudgetServiceIImpl implements FNpUserBudgetService {

	/* 변수정의 */
	/* 변수정의 - DAO */
	@Resource ( name = "FNpUserBudgetServiceIDAO" )
	private FNpUserBudgetServiceIDAO dao;
	@Resource ( name = "BCommonProcService" )
	private BCommonProcService procService;

	@Override
	public ResultVO selectERPBudgetBalance ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		/* 예산별 상세 정보 조회 */
		HashMap<String, Object> procParams = new HashMap<>( );
		procParams.put( "procType", "budget" );
		procParams.put( "erpCompSeq", params.get( "erpCompSeq" ) );
		procParams.put( "erpDivSeq", params.get( "erpBudgetDivSeq" ) );
		procParams.put( "erpMgtSeq", params.get( "erpMgtSeq" ) );
		procParams.put( "erpBudgetSeq", params.get( "erpBudgetSeq" ) );
		procParams.put( "erpGisuDate", params.get( "erpGisuDate" ) );
		procParams.put( "sumAm", params.get( "sumAm" ) );
		procParams.put( "erpBottomSeq", params.get( "bottomSeq" ) );
		procParams.put( "gisu", params.get( "gisu" ) );
		
		if(conVo == null){
			result = procService.getProcResult( procParams );	
		}else {
			result = procService.getProcResult( procParams, conVo );
		}
		
		return result;
	}

	@Override
	public ResultVO selectConsBudgetBalance ( Map<String, Object> params ) throws Exception {
		throw new Exception( "품의서 잔액 조회 기능으로 GW전용 기능입니다." );
	}

	@Override
	public ResultVO selectResUseAmt ( Map<String, Object> params ) throws Exception {
		throw new Exception( "결의액 조회 기능으로 GW전용 기능입니다." );
	}

	@Override
	public ResultVO selectConsAmt ( Map<String, Object> params ) throws Exception {
		throw new Exception( "품의서별 합계 금 조회 기능으로 GW전용 기능입니다." );
	}

	@Override
	public ResultVO selectResAmt ( Map<String, Object> params ) throws Exception {
		throw new Exception( "결의서별 합계 금 조회 기능으로 GW전용 기능입니다." );
	}

	@Override
	public ResultVO selectTryAmt ( Map<String, Object> params ) throws Exception {
		throw new Exception( "문서 예산별 조회 금 조회 기능으로 GW전용 기능입니다." );
	}

	@Override
	public ResultVO selectConfferBudgetBalanceAmt ( Map<String, Object> params ) throws Exception {
		throw new Exception( "참조품의서 잔액 조회기능으로 GW전용 기능입니다." );
	}

	@Override
	public ResultVO selectConsBudgetBalanceForYesil ( Map<String, Object> params ) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO selectResUseAmtForYesil ( Map<String, Object> params ) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO selectConsBudgetBalance ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		throw new Exception( "품의서 잔액 조회 기능으로 GW전용 기능입니다." );
	}

	@Override
	public ResultVO selectResUseAmt ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		throw new Exception( "결의서 잔액 조회 기능으로 GW전용 기능입니다." );
	}

	@Override
	public ResultVO selectTryAmt ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		throw new Exception( "문서 예산별 조회 금 조회 기능으로 GW전용 기능입니다." );
	}

	@Override
	public ResultVO selectConfferBudgetInfo(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO updateConfferBudgetInfo(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO selectItemAmt(Map<String, Object> params, ConnectionVO conVo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO selectConfferTryAmt(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO selectConfferTryAmt(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
}

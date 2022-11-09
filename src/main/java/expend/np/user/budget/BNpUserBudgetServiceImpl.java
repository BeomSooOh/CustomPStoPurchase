package expend.np.user.budget;

import java.util.HashMap;
//import java.util.Iterator;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

//import cmm.util.MapUtil;
import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
//import expend.np.user.option.BNpUserOptionService;
import expend.np.user.res.BNpUserResService;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


@Service ( "BNpUserBudgetService" )
public class BNpUserBudgetServiceImpl implements BNpUserBudgetService {

	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo;
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );
	@Resource ( name = "FNpUserBudgetServiceU" )
	private FNpUserBudgetService budgetU;
	@Resource ( name = "FNpUserBudgetServiceI" )
	private FNpUserBudgetService budgetI;
	@Resource ( name = "FNpUserBudgetServiceA" )
	private FNpUserBudgetService budgetA;
	@Resource ( name = "BNpUserBudgetService" )
	private BNpUserBudgetService serviceBudget; /* Expend Service */
	@Resource ( name = "BNpUserResService" )
	private BNpUserResService serviceRes; /* 결의서 정보 관리 */

	public String nullToString ( Object o ) {
		String returnStr = "";
		if ( o == null ) {
			return returnStr;
		}
		else {
			return o.toString( );
		}
	}

	/*
	 * [G20]
	 * ERP 예산 잔액 조회 - G20
	 */
	@Override
	public ResultVO selectG20BudgetInfo ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			params.put( "erpTypeCode", conVo.getErpTypeCode( ) );
			/* [Call DB] 참조된 품의서 정보 구해야함 */
			ResultVO budgetInfo = serviceRes.selectConfferBudgetInfo( params );
			Map<String, Object> budgetInfoMap = budgetInfo.getaData( );
			boolean confferRes = false;
			if ( (params.get( "consSeq" ) == null) && ((!nullToString( params.get( "confferDocSeq" ) ).equals( "" )) || budgetInfoMap != null) ) {
				confferRes = true;
				/* 품의서 확인 이후 파라미터 보정작업 진행 */
				if ( params.get( "confferSeq" ) == null && !CommonConvert.CommonGetStr( budgetInfoMap.get( "confferDocSeq" ) ).equals( "" ) ) {
					params.put( "confferDocSeq", budgetInfoMap.get( "confferDocSeq" ) );
					params.put( "confferSeq", budgetInfoMap.get( "confferSeq" ) );
					params.put( "confferBudgetSeq", budgetInfoMap.get( "confferBudgetSeq" ) );
				}
			}
			double openAmt = 0;
			double erpApplyAmt = 0;
			double consAmt = 0;
			double resAmt = 0;
			double tryAmt = 0;
			double itemAmt = 0;
			double resTryAmt = 0;
			/* [Call DB] ERP 예산 편성액 조회 */
			ResultVO budgetResult = budgetI.selectERPBudgetBalance( params, conVo );
			if ( CommonConvert.CommonGetStr(budgetResult.getResultCode( )).equals( commonCode.FAIL ) ) {
				return budgetResult;
			}
			openAmt = Double.parseDouble( budgetResult.getAaData( ).get( 0 ).get( "openAmt" ).toString( ) );
			erpApplyAmt = Double.parseDouble( budgetResult.getAaData( ).get( 0 ).get( "applyAmt" ).toString( ) );
			/* [Call DB] applyAmt 구해야 함 */
			ResultVO consResult = serviceBudget.selectConsBudgetBalance( params, conVo );
			ResultVO resResult = serviceBudget.selectResUseAmt( params, conVo );
			consAmt = Double.parseDouble( consResult.getaData( ).get( "balanceAmt" ).toString( ) );
			resAmt = Double.parseDouble( resResult.getaData( ).get( "resBudgetAmt" ).toString( ) );
			/* [Call DB] tryAmt 구해야함 */
			ResultVO tryResult = budgetA.selectTryAmt( params, conVo );
			tryAmt = Double.parseDouble( tryResult.getaData( ).get( "tryAmt" ).toString( ) );
			ResultVO itemAmtResult = budgetA.selectItemAmt( params, conVo );
			ResultVO resTryResult = budgetA.selectConfferTryAmt(params, conVo);
			resTryAmt = Double.parseDouble( resTryResult.getaData( ).get( "tryAmt" ).toString( ) );
			itemAmt = Double.parseDouble( itemAmtResult.getaData( ).get( "itemAmt" ).toString( ) );
			Map<String, Object> resultMap = new HashMap<>( );

			/* 공통 사용 */
			resultMap.put( "itemAmt", itemAmt );
			resultMap.put( "openAmt", openAmt ); // 예산 편성금
			resultMap.put( "applyAmt", consAmt + resAmt + erpApplyAmt ); // 집행액 (품의서, ERP 결의서, 미전송 결의서)
			resultMap.put( "consBalanceAmt", consAmt ); // 품의서 잡고있는 돈
			resultMap.put( "resApplyAmt", resAmt + erpApplyAmt ); // 결의서 잡고있는 돈
			resultMap.put( "tryAmt", tryAmt ); // 현재 결의서 결의액
			resultMap.put( "erpLeftAmt", openAmt - erpApplyAmt ); // ERP 잔액
			resultMap.put( "balanceAmt", openAmt - (consAmt + resAmt + erpApplyAmt) - tryAmt ); // 예산 총잔액
			resultMap.put( "budgetTableConsAmt", consAmt );
			resultMap.put( "budgetTableResAmt", resAmt );
			resultMap.put( "erpApplyAmt", erpApplyAmt );

			if ( confferRes ) {
				/* [로직] 품의참조 결의서 */
				/* [Call DB] 참조 품의서 품의잔액 조회 */
				Map<String, Object> confferMap = budgetA.selectConfferBudgetBalanceAmt( params ).getaData( );
				if ( confferMap.get( "consAmt" ) == null ) {
					return result.setFail( "품의 참조 결의서이지만 품의정보 누락" );
				}
				double confferConsAmt = Double.parseDouble( confferMap.get( "consAmt" ).toString( ) );
				double confferResAmt = Double.parseDouble( confferMap.get( "resAmt" ).toString( ) );
				double confferBalanceAmt = Double.parseDouble( confferMap.get( "balanceAmt" ).toString( ) );
				/* 참조품의 결의서 추가 예산 */
				resultMap.put( "confferConsAmt", confferConsAmt ); // 참조 품의서 품의액
				resultMap.put( "confferResAmt", confferResAmt ); // 참조 품의서 사용하는 결의서 결의액 (현재 예산과목 제외)
				resultMap.put( "confferBalanceAmt", confferBalanceAmt ); // 품의서 잔액 (현재 예산과목 제외)
				resultMap.put( "confferResultBalanceAmt", confferBalanceAmt - resTryAmt ); // 품의서 잔액 (현재 예산과목 포함 (tryAmt 임시 제거))
				resultMap.put( "tryAmt", resTryAmt );
			}

			result.setaData( resultMap );
			result.setSuccess( );


		}
		catch ( Exception ex ) {
			result.setFail( "ERP 구분을 확인할 수 없습니다.", ex );
		}
		return result;
	}

	/*
	 * [ERP iU]
	 * ERP 예산 잔액 조회 - ERPiU
	 */
	@Override
	public ResultVO selectiUBudgetInfo ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			params.put( "erpTypeCode", conVo.getErpTypeCode( ) );
			/* 참조된 품의서 정보 구해야함 */
			ResultVO budgetInfo = serviceRes.selectConfferBudgetInfo( params );
			Map<String, Object> budgetInfoMap = budgetInfo.getaData( );
			if(budgetInfoMap == null){
				budgetInfoMap = new HashMap<String, Object>();
			}
			boolean confferRes = false;
			if ( (params.get( "consSeq" ) == null) && ((!nullToString( params.get( "confferDocSeq" ) ).equals( "" )) || !budgetInfoMap.isEmpty()) ) {
				confferRes = true;
				/* 품의서 확인 이후 파라미터 보정작업 진행 */
				if ( params.get( "confferSeq" ) == null && !CommonConvert.CommonGetStr( budgetInfoMap.get( "confferDocSeq" ) ).equals( "" ) ) {
					params.put( "confferDocSeq", budgetInfoMap.get( "confferDocSeq" ) );
					params.put( "confferSeq", budgetInfoMap.get( "confferSeq" ) );
					params.put( "confferBudgetSeq", budgetInfoMap.get( "confferBudgetSeq" ) );
				}
			}
			double openAmt = 0;
			/* ERP 사용금액(전표 포함) */
			double erpApplyAmt = 0;
			/* ERP 원인행위 금액 */
			double erpResAmt = 0;
			double consAmt = 0;
			double resAmt = 0;
			double tryAmt = 0;
			double itemAmt = 0;
			double resTryAmt = 0;
			/* ERP 예산 편성액 조회 */
			ResultVO budgetResult = budgetU.selectERPBudgetBalance( params, conVo );
			if ( CommonConvert.CommonGetStr(budgetResult.getResultCode( )).equals( commonCode.FAIL ) ) {
				return budgetResult;
			}
			openAmt = Double.parseDouble( budgetResult.getaData( ).get( "openAmt" ).toString( ) );
			erpApplyAmt = Double.parseDouble( budgetResult.getaData( ).get( "applyAmt" ).toString( ) );
			erpResAmt = Double.parseDouble( budgetResult.getaData( ).get( "resAmt" ).toString( ) );
			/* applyAmt 구해야 함 */
			ResultVO consResult = serviceBudget.selectConsBudgetBalance( params, conVo );
			ResultVO resResult = serviceBudget.selectResUseAmt( params, conVo );
			consAmt = Double.parseDouble( consResult.getaData( ).get( "balanceAmt" ).toString( ) );
			resAmt = Double.parseDouble( resResult.getaData( ).get( "resBudgetAmt" ).toString( ) );
			/* tryAmt 구해야함 */
			ResultVO tryResult = budgetA.selectTryAmt( params, conVo );
			tryAmt = Double.parseDouble( tryResult.getaData( ).get( "tryAmt" ).toString( ) );
			/* 참조품의시 결의서별 예산 금회집행액 */
			ResultVO resTryResult = budgetA.selectConfferTryAmt(params, conVo);
			resTryAmt = Double.parseDouble( resTryResult.getaData( ).get( "tryAmt" ).toString( ) );
			ResultVO itemAmtResult = budgetA.selectItemAmt( params, conVo );
			itemAmt = Double.parseDouble( itemAmtResult.getaData( ).get( "itemAmt" ).toString( ) );
			Map<String, Object> resultMap = new HashMap<>( );

			/* 공통 사용 */
			resultMap.put( "openAmt", openAmt ); // 예산 편성금
			resultMap.put( "applyAmt", consAmt + resAmt + erpApplyAmt + erpResAmt ); // 집행액 (품의서, ERP 결의서, 미전송 결의서, 원인행위 금액)
			resultMap.put( "consBalanceAmt", consAmt ); // 품의서 잡고있는 돈
			resultMap.put( "resApplyAmt", resAmt + erpApplyAmt + erpResAmt ); // 결의서 잡고있는 돈
			resultMap.put( "tryAmt", tryAmt ); // 현재 결의서 결의액
			resultMap.put( "erpLeftAmt", openAmt - erpApplyAmt + erpResAmt ); // ERP 잔액
			resultMap.put( "balanceAmt", openAmt - (consAmt + resAmt + erpApplyAmt + erpResAmt) - tryAmt ); // 예산 총잔액
			resultMap.put( "budgetTableConsAmt", consAmt );
			resultMap.put( "budgetTableResAmt", resAmt );
			resultMap.put( "erpApplyAmt", erpApplyAmt + erpResAmt ); // iU 전표 금액
			resultMap.put( "erpResAmt", erpResAmt ); // 원인행위 금액
			resultMap.put( "itemAmt", itemAmt );

			if ( confferRes ) {
				/* [로직] 품의참조 결의서 */
				/* 참조 품의서 품의잔액 조회 */
				Map<String, Object> confferMap = budgetA.selectConfferBudgetBalanceAmt( params ).getaData( );
				if ( confferMap.get( "consAmt" ) == null ) {
					return result.setFail( "품의 참조 결의서이지만 품의정보 누락" );
				}
				double confferConsAmt = Double.parseDouble( confferMap.get( "consAmt" ).toString( ) );
				double confferResAmt = Double.parseDouble( confferMap.get( "resAmt" ).toString( ) );
				double confferBalanceAmt = Double.parseDouble( confferMap.get( "balanceAmt" ).toString( ) );
				/* 참조품의 결의서 추가 예산 */
				resultMap.put( "confferConsAmt", confferConsAmt ); // 참조 품의서 품의액
				resultMap.put( "confferResAmt", confferResAmt ); // 참조 품의서 사용하는 결의서 결의액 (현재 예산과목 제외)
				resultMap.put( "confferBalanceAmt", confferBalanceAmt ); // 품의서 잔액
				resultMap.put( "confferResultBalanceAmt", confferBalanceAmt - resTryAmt); // 품의서 잔액
				resultMap.put( "tryAmt", resTryAmt );
			}

			result.setaData( resultMap );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "ERP 구분을 확인할 수 없습니다.", ex );
		}
		return result;
	}

	/* ERP 예산 잔액 조회 */
	@Override
	public ResultVO selectERPBudgetBalance ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
				result = budgetI.selectERPBudgetBalance( params, conVo );
				if ( result.getAaData( ).size( ) == 1 ) {
					Map<String, Object> temp = new HashMap<>( );
					temp = result.getAaData( ).get( 0 );
					temp.put( "balanceAmt", temp.get( "leftAmt" ) );
					result.setaData( temp );
				}
			}
			else if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
				result = budgetU.selectERPBudgetBalance( params, conVo );
			}
			/* 공통 예산 코드 처리 필요 */
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				Map<String, Object> temp = result.getaData( );
				/* 예산 잔액 널처리 */
				if ( temp.get( "balanceAmt" ) == null ) {
					temp.put( "balanceAmt", "0" );
				}
				/* 예산 잔액 숫자 제외 모든 문자 제거 */
				temp.put( "balanceAmt", temp.get( "balanceAmt" ).toString( ) );
				/* 예산 잔액 공백일경우 0 처리 */
				if ( temp.get( "balanceAmt" ).toString( ).length( ) == 0 ) {
					temp.put( "balanceAmt", "0" );
				}
			}
		}
		catch ( Exception ex ) {
			result.setFail( "ERP 구분을 확인할 수 없습니다.", ex );
		}
		return result;
	}

	/* GW 품의서 잔액 조회 */
	@Override
	public ResultVO selectConsBudgetBalance ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = budgetA.selectConsBudgetBalance( params );
		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ), ex );
		}
		return result;
	}

	/* GW 품의서 잔액 조회 */
	@Override
	public ResultVO selectConsBudgetBalance ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = budgetA.selectConsBudgetBalance( params, conVo );
		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ), ex );
		}
		return result;
	}

	/* GW 미전송 결의액 조회 */
	@Override
	public ResultVO selectResUseAmt ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			return budgetA.selectResUseAmt( params );
		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ), ex );
		}
		return result;
	}

	/* GW 미전송 결의액 조회 */
	@Override
	public ResultVO selectResUseAmt ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			return budgetA.selectResUseAmt( params, conVo );
		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ), ex );
		}
		return result;
	}

	/* GW 품의서 잔액 조회 [예실대비현황] */
	@Override
	public ResultVO selectConsBudgetBalanceForYesil ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = budgetA.selectConsBudgetBalanceForYesil( params );
		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ), ex );
		}
		return result;
	}

	/* GW 미전송 결의액 조회 [예실대비현황] */
	@Override
	public ResultVO selectResUseAmtForYesil ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			return budgetA.selectResUseAmtForYesil( params );
		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ), ex );
		}
		return result;
	}

	@Override
	public ResultVO selectConsAmt ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			return budgetA.selectConsAmt( params );
		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ), ex );
		}
		return result;
	}

	@Override
	public ResultVO selectResAmt ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			return budgetA.selectResAmt( params );
		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ), ex );
		}
		return result;
	}

	@Override
	public ResultVO selectTryAmt ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			return budgetA.selectTryAmt( params );
		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ), ex );
		}
		return result;
	}

	@Override
	public ResultVO selectConfferTryAmt ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			return budgetA.selectConfferTryAmt(params);
		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ), ex );
		}
		return result;
	}

	/* 참조 품의서 예산정보 조회 */
	@Override
	public ResultVO selectConfferBudgetInfo ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = budgetA.selectConfferBudgetInfo( params );
		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ), ex );
		}
		return result;
	}

	/* 참조 품의서 예산정보 업데이 */
	@Override
	public ResultVO updateConfferBudgetInfo ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = budgetA.updateConfferBudgetInfo( params );
		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ), ex );
		}
		return result;
	}

	@Override
	public ResultVO selectConfferBudgetBalanceAmt ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = budgetA.selectConfferBudgetBalanceAmt( params );
		}
		catch ( Exception ex ) {
			result.setFail( "품의 거래처 조회에 실패하였습니다.", ex );
		}
		return result;
	}

}

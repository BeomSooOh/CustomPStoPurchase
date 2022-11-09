package expend.np.user.res;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import bizbox.orgchart.service.vo.LoginVO;
import cmm.util.MapUtil;
import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.procedure.npG20.BCommonProcService;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import expend.np.user.budget.BNpUserBudgetService;
import expend.np.user.budget.FNpUserBudgetService;
import expend.np.user.cons.FNpUserConsServiceADAO;


@Service ( "FNpUserResServiceA" )
public class FNpUserResServiceAImpl implements FNpUserResService {

	/* 변수정의 */
	/* 변수정의 - DAO */
	@Resource ( name = "FNpUserResServiceADAO" )
	private FNpUserResServiceADAO dao;
	@Resource ( name = "FNpUserConsServiceADAO" )
	private FNpUserConsServiceADAO consDao;
	@Resource ( name = "FNpUserResServiceA" )
	private FNpUserResService ResA;
	@Resource ( name = "BNpUserBudgetService" )
	private BNpUserBudgetService serviceBudget;
	@Resource ( name = "FNpUserBudgetServiceI" )
	private FNpUserBudgetService budgetI;
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo;
	@Resource ( name = "BCommonProcService" )
	private BCommonProcService serviceCommonProc;
	/* 결의 문서 최초 생성 */
	@Override
	public ResultVO insertResDoc ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = dao.insertResDoc( params );
		}
		catch ( Exception ex ) {
			result.setFail( "결의문서 생성에 실패하였습니다.", ex );
		}
		return result;
	}

	/* 결의문서 참조품의 정보 반영 */
	@Override
	public ResultVO updateResConfferInfo ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "resDocSeq", "Y", "consDocSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			result = dao.selectResDoc( params );
			String docSeq = CommonConvert.NullToString( result.getAaData( ).get( 0 ).get( "docSeq" ), commonCode.EMPTYSTR );
			if ( !docSeq.equals( "" ) ) {
				result.setFail( "상신 된 문서는 변경할 수 없습니다." );
				return result;
			}
			
			LoginVO loginVo = CommonConvert.CommonGetEmpVO();
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
			
			if(conVo.getErpTypeCode( ).equals( commonCode.ICUBE )){
				/* 품의서 회계 기수 마감 조회 */
				ResultVO consHeadResult = consDao.selectConsHead( params );
				if(consHeadResult.getResultCode( ).equals( commonCode.FAIL )){
					return consHeadResult; 
				}else {
					for(Map<String, Object> item : consHeadResult.getAaData( )){
						item.put( "procType", "gisuCloseCheck" );
						result = serviceCommonProc.getProcResult( item, conVo );
						if(result.getResultCode( ).equals( commonCode.FAIL )){
							return result;
						}else{
							if(result.getAaData( ).size( ) == 0){
								continue;
							}else if(CommonConvert.NullToString( result.getAaData( ).get( 0 ).get( "closeYn" ) ).equals( "1" )){
								result.setResultName( "기수가 마감되어 품의서를 작성할 수 없습니다." );
								result.setResultCode( "GISU_CLOSE" );
								return result;
							}
						}
					}
				}
			}
			/* 현재 결의서 데이터 초기화 */
			dao.deleteResHeadForDoc( params );
			dao.deleteResBudgetForDoc( params );
			dao.deleteResTradeForDoc( params );
			dao.deleteResAllItemSpec( params );
			
			/* 품의서 데이터 이관 - DOC */
			result = dao.updateDocConfferInfo( params );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				throw new Exception( " 품의 문서 반영 도중 오류가 발생하였습니다. " );
			}
			/* 품의서 데이터 이관 - HEAD */
			result = dao.updateHeadConfferInfo( params );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				throw new Exception( " 품의서 반영 도중 오류가 발생하였습니다. " );
			}
			
			/* 품의서 예산 조회 및 조회결과 업데이트(마이그레이션시 품의서 데이터 bgtSeq누락현상 으로 인해 조회 결과 업데이트)*/
			ResultVO budgetInfo = new ResultVO();
			
			result =  serviceBudget.selectConfferBudgetInfo(params);
			if(!conVo.getErpTypeCode( ).equals( commonCode.ERPIU )){
				for(int i=0;i<result.getAaData().size();i++){
					budgetInfo = budgetI.selectERPBudgetBalance(result.getAaData().get(i), conVo);
					budgetInfo.getAaData().get(0).put("consBudgetSeq", result.getAaData().get(i).get("budgetSeq"));
					serviceBudget.updateConfferBudgetInfo(budgetInfo.getAaData().get(0));
				}
				if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
					throw new Exception( " 품의 예산 조회 도중 오류가 발생하였습니다. " );
				}
			}
			/* 품의서 데이터 이관 - BUDGET */
			result = dao.updateBudgetConfferInfo( params );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				throw new Exception( " 품의 예산 반영 도중 오류가 발생하였습니다. " );
			}

			/* 품의서 데이터 이관 - TRADE */
			result = dao.updateTradeConfferInfo( params );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				throw new Exception( " 품의 거래처 반영 도중 오류가 발생하였습니다. " );
			}
			
			/* 품의서 데이터 이관 - ITEMSPEC */
			result = dao.updateItemSpecConfferInfo( params );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				throw new Exception( " 품의 물품명세 반영 도중 오류가 발생하였습니다. " );
			}
		}
		catch ( Exception ex ) {
			/* 예산을 잡고 있지 않도록 롤백. */
			dao.rollbackDocConfferInfo( params );
			dao.rollbackHeadConfferInfo( params );
			dao.rollbackBudgetConfferInfo( params );
			dao.rollbackTradeConfferInfo( params );
			dao.deleteResAllItemSpec( params );
			result.setFail( "참조품의 반영중 에러가 발생하였습니다." + ex.getMessage( ), ex );
		}
		return result;
	}

	/**
	 * 각개 결의서 생성
	 */
	@Override
	public ResultVO insertResHead ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "resDocSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				result = dao.insertResHead( params );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "각개 결의 생성에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 결의 예산 생성
	 */
	@Override
	public ResultVO insertResBudget ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "resDocSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				/* 결의 예산 생성 */
				result = dao.insertResBudget( params );
				Map<String, Object> orgnAData = result.getaData( );
				Map<String, Object> budgetAmtTemp = serviceBudget.selectResAmt( params ).getaData( );
				orgnAData.put( "amt", budgetAmtTemp.get( "resAmt" ) );
				orgnAData.put( "stdAmt", budgetAmtTemp.get( "resBudgetStdAmt" ) );
				orgnAData.put( "taxAmt", budgetAmtTemp.get( "resBudgetTaxAmt" ) );
				orgnAData.put( "budgetAmt", budgetAmtTemp.get( "resBudgetAmt" ) );
				orgnAData.put( "consBalance", budgetAmtTemp.get( "consBalance" ) );
				orgnAData.put( "confferDocSeq", budgetAmtTemp.get( "confferDocSeq" ) );
				
				/* 예산별 금회 결의액 생성 */
				if(!CommonConvert.NullToString(params.get("confferDocSeq")).equals("")) {
					ResultVO tryResult = serviceBudget.selectConfferTryAmt( params );
					orgnAData.put( "tryAmt", tryResult.getaData( ).get( "tryAmt" ) );
				}
				else {
					ResultVO tryResult = serviceBudget.selectTryAmt( params );
					orgnAData.put( "tryAmt", tryResult.getaData( ).get( "tryAmt" ) );	
				}
				
				/* 결의서 금액 조회 */
				result.setaData( orgnAData );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "결의 예산 생성에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 결의 거래처 생성
	 */
	@Override
	public ResultVO insertResTrade ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "resDocSeq", "Y", "resSeq", "Y", "budgetSeq", "N", "erpBudgetSeq", "N" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				/* 결의 거래처 생성 */
				result = dao.insertResTrade( params );
				/* 결의 예산 정보 갱신 */
				dao.updateResAmt( params );
				/* 결의서 예산 조회 */
				Map<String, Object> orgnAData = result.getaData( );
				Map<String, Object> budgetAmtTemp = serviceBudget.selectResAmt( params ).getaData( );
				orgnAData.put( "amt", budgetAmtTemp.get( "resAmt" ) );
				orgnAData.put( "stdAmt", budgetAmtTemp.get( "resBudgetStdAmt" ) );
				orgnAData.put( "taxAmt", budgetAmtTemp.get( "resBudgetTaxAmt" ) );
				orgnAData.put( "budgetAmt", budgetAmtTemp.get( "resBudgetAmt" ) );
				orgnAData.put( "consBalance", budgetAmtTemp.get( "consBalance" ) );

				
				/* 예산별 금회 결의액 생성 */
				if(!CommonConvert.NullToString(params.get("confferDocSeq")).equals("")) {
					ResultVO tryResult = serviceBudget.selectConfferTryAmt( params );
					orgnAData.put( "tryAmt", tryResult.getaData( ).get( "tryAmt" ) );
				}
				else {
					ResultVO tryResult = serviceBudget.selectTryAmt( params );
					orgnAData.put( "tryAmt", tryResult.getaData( ).get( "tryAmt" ) );	
				}
				result.setaData( orgnAData );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "결의 거래처 생성에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 결의 문서 갱신
	 */
	@Override
	public ResultVO updateResDoc ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "resDocSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				result = dao.updateResDoc( params );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "결의문서 갱신에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 결의 문서 전자결재 정보 갱신
	 */
	@Override
	public ResultVO updateResDocEaInfo ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "resDocSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				result = dao.updateResDocEaInfo( params );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "결의 문서 전자결재 정보 갱신에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 각개 결의서 갱신
	 */
	@Override
	public ResultVO updateResHead ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "resDocSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				result = dao.updateResHead( params );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "각개 결의서 갱신에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 결의 예산 갱신
	 */
	@Override
	public ResultVO updateResBudget ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "resDocSeq", "Y", "resSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				/* 결의 예산 갱신 */
				result = dao.updateResBudget( params );
				/* 결의서 예산 조회 */
				Map<String, Object> orgnAData = result.getaData( );
				Map<String, Object> budgetAmtTemp = serviceBudget.selectResAmt( params ).getaData( );
				orgnAData.put( "amt", budgetAmtTemp.get( "resAmt" ) );
				orgnAData.put( "stdAmt", budgetAmtTemp.get( "resBudgetStdAmt" ) );
				orgnAData.put( "taxAmt", budgetAmtTemp.get( "resBudgetTaxAmt" ) );
				orgnAData.put( "budgetAmt", budgetAmtTemp.get( "resBudgetAmt" ) );
				orgnAData.put( "consBalance", budgetAmtTemp.get( "consBalance" ) );
				
				
				/* 예산별 금회 결의액 생성 */
				if(!CommonConvert.NullToString(params.get("confferDocSeq")).equals("")) {
					ResultVO tryResult = serviceBudget.selectConfferTryAmt( params );
					orgnAData.put( "tryAmt", tryResult.getaData( ).get( "tryAmt" ) );
				}
				else {
					ResultVO tryResult = serviceBudget.selectTryAmt( params );
					orgnAData.put( "tryAmt", tryResult.getaData( ).get( "tryAmt" ) );	
				}
				
				result.setaData( orgnAData );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "결의 예산 갱신에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 결의 거래처 갱신
	 */
	@Override
	public ResultVO updateResTrade ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "resDocSeq", "Y", "resSeq", "Y", "tradeSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				result = dao.updateResTrade( params );
				/* 결의 예산 정보 갱신 */
				dao.updateResAmt( params );
				/* 결의 예산금액 조회 */
				Map<String, Object> orgnAData = result.getaData( );
				Map<String, Object> budgetAmtTemp = serviceBudget.selectResAmt( params ).getaData( );
				orgnAData.put( "amt", budgetAmtTemp.get( "resAmt" ) );
				orgnAData.put( "stdAmt", budgetAmtTemp.get( "resBudgetStdAmt" ) );
				orgnAData.put( "taxAmt", budgetAmtTemp.get( "resBudgetTaxAmt" ) );
				orgnAData.put( "budgetAmt", budgetAmtTemp.get( "resBudgetAmt" ) );
				orgnAData.put( "consBalance", budgetAmtTemp.get( "consBalance" ) );
				orgnAData.put( "tradeSeq", params.get( "tradeSeq" ) );

				/* 예산별 금회 결의액 생성 */
				if(!CommonConvert.NullToString(params.get("confferDocSeq")).equals("")) {
					ResultVO tryResult = serviceBudget.selectConfferTryAmt( params );
					orgnAData.put( "tryAmt", tryResult.getaData( ).get( "tryAmt" ) );
				}
				else {
					ResultVO tryResult = serviceBudget.selectTryAmt( params );
					orgnAData.put( "tryAmt", tryResult.getaData( ).get( "tryAmt" ) );	
				}
				
				result.setaData( orgnAData );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "결의 거래처 갱신에 실패하였습니다.", ex );
		}
		return result;
	}
	
	/**
	 * 임시저장 체크
	 */
	@Override
	public ResultVO CheckDraftInfo ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			/* 임시저장 체크 */
			result = dao.CheckDraftInfo( params );
		}
		catch ( Exception ex ) {
			result.setFail( "임시저장 체크 실패.", ex );
		}
		return result;
	}
	
	/**
	 * 결의 문서 삭제
	 */
	@Override
	public ResultVO deleteResDoc ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "resDocSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				/* 결의 단계 삭제 */
				dao.deleteResHeadForDoc( params );
				/* 예산 단계 삭제 */
				dao.deleteResBudgetForDoc( params );
				/* 채주 단계 삭제 */
				dao.deleteResTradeForDoc( params );
				/* 문서 단계 삭제 */
				result = dao.deleteResDoc( params );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "결의 문서 삭제에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 각개 결의 삭제
	 */
	@Override
	public ResultVO deleteResHead ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "resDocSeq", "Y", "resSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				/* 예산 단계 삭제 */
				dao.deleteResBudgetForRes( params );
				/* 채주 단계 삭제 */
				dao.deleteResTradeForRes( params );
				/* 결의 단계 삭제 */
				result = dao.deleteResHead( params );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "각개 결의 삭제에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 결의 예산 삭제
	 */
	@Override
	public ResultVO deleteResBudget ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "resDocSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				/* 채주 단계 삭제 */
				dao.deleteResTradeForBudget( params );
				/* 예산 단계 삭제 */
				result = dao.deleteResBudget( params );
				/* 결의서 예산 조회 */
				Map<String, Object> orgnAData = result.getaData( );
				Map<String, Object> budgetAmtTemp = serviceBudget.selectResAmt( params ).getaData( );
				orgnAData.put( "amt", budgetAmtTemp.get( "resAmt" ) );
				orgnAData.put( "stdAmt", budgetAmtTemp.get( "resBudgetStdAmt" ) );
				orgnAData.put( "taxAmt", budgetAmtTemp.get( "resBudgetTaxAmt" ) );
				orgnAData.put( "budgetAmt", budgetAmtTemp.get( "resBudgetAmt" ) );
				orgnAData.put( "consBalance", budgetAmtTemp.get( "consBalance" ) );

				/* 예산별 금회 결의액 생성 */
				if(!CommonConvert.NullToString(params.get("confferDocSeq")).equals("")) {
					ResultVO tryResult = serviceBudget.selectConfferTryAmt( params );
					orgnAData.put( "tryAmt", tryResult.getaData( ).get( "tryAmt" ) );
				}
				else {
					ResultVO tryResult = serviceBudget.selectTryAmt( params );
					orgnAData.put( "tryAmt", tryResult.getaData( ).get( "tryAmt" ) );	
				}
				
				result.setaData( orgnAData );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "결의 예산 삭제에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 결의 거래처 삭제
	 */
	@Override
	public ResultVO deleteResTrade ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "resDocSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				/* 카드 연동 여부 확인 */
				List<Map<String, Object>> cardList = new ArrayList<Map<String, Object>>();
				params.put("sendYN", "Y");
				cardList = dao.CardLinkSelect(params);
				
				/* 세금계산서 연동 여부 확인 */
				List<Map<String, Object>> eTaxList = new ArrayList<Map<String, Object>>();
				params.put("sendYN", "Y");
				eTaxList = dao.ETaxLinkSelect(params);
				
				/* 결의서 거래처 정보 삭제 */
				result = dao.deleteResTrade( params );
				
				/* 세금계산서 연동 정보 복구 */
				for (Map<String, Object> map : eTaxList) {
					map.put("sendYN", "N");
					map.put("ifMId", "0");
					map.put("ifDId", "0");
					
					dao.ETaxStatInfoUpdate(map);
				}
				
				/* 카드 연동 정보 복구 */
				for (Map<String, Object> map : cardList) {
					map.put("sendYN", "N");
					map.put("ifMId", "0");
					map.put("ifDId", "0");
					
					dao.CardStatInfoUpdate(map);
				}
				
				/* 결의 예산 정보 갱신 */
				dao.updateResAmt( params );
				/* 결의 예산금액 조회 */
				Map<String, Object> orgnAData = result.getaData( );
				Map<String, Object> budgetAmtTemp = serviceBudget.selectResAmt( params ).getaData( );
				orgnAData.put( "amt", budgetAmtTemp.get( "resAmt" ) );
				orgnAData.put( "stdAmt", budgetAmtTemp.get( "resBudgetStdAmt" ) );
				orgnAData.put( "taxAmt", budgetAmtTemp.get( "resBudgetTaxAmt" ) );
				orgnAData.put( "budgetAmt", budgetAmtTemp.get( "resBudgetAmt" ) );
				orgnAData.put( "consBalance", budgetAmtTemp.get( "consBalance" ) );

				/* 예산별 금회 결의액 생성 */
				if(!CommonConvert.NullToString(params.get("confferDocSeq")).equals("")) {
					ResultVO tryResult = serviceBudget.selectConfferTryAmt( params );
					orgnAData.put( "tryAmt", tryResult.getaData( ).get( "tryAmt" ) );
				}
				else {
					ResultVO tryResult = serviceBudget.selectTryAmt( params );
					orgnAData.put( "tryAmt", tryResult.getaData( ).get( "tryAmt" ) );	
				}
				
				result.setaData( orgnAData );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "결의 거래처 삭제에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 결의 문서 조회
	 */
	@Override
	public ResultVO selectResDoc ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = dao.selectResDoc( params );
		}
		catch ( Exception ex ) {
			result.setFail( "결의 문서 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 각개 결의 조회
	 */
	@Override
	public ResultVO selectResHead ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "resDocSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				result = dao.selectResHead( params );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "각개 결의 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 결의 예산 조회
	 */
	@Override
	public ResultVO selectResBudget ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "resDocSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				result = dao.selectResBudget( params );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "결의 예산 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 결의 거래처 조회
	 */
	@Override
	public ResultVO selectResTrade ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "resDocSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				result = dao.selectResTrade( params );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "결의 거래처 조회에 실패하였습니다.", ex );
		}
		return result;
	}
	
	/**
	 * 카드사용내역 조회
	 */
	@Override
	public ResultVO selectCardDataList ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			/* 현재 작성중인 결의서에서 사용중인 카드내역은 제외한다. */
			String notSyncId = "";
			for(Map<String, Object> tMap : dao.selectCardInfoIntoRes( params ).getAaData( ) ){
				notSyncId += tMap.get("syncId").toString( ) + "','";
			}
			if( notSyncId.length( ) > 1){
				notSyncId = notSyncId.substring( 0, notSyncId.length( ) - 3 );
			}
			params.put( "notInSyncId", notSyncId );
			/* 카드내역 조회 */
			result = dao.selectCardDataList( params );
		}
		catch ( Exception ex ) {
			result.setFail( "카드사용내역 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectConfferBudgetInfo ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "resDocSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				result = dao.selectConfferBudgetInfo( params );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "결의 거래처 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectGroupBudgetInfo ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "resSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				result = dao.selectGroupBudgetInfo( params );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "결의 거래처 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	@Override
	public ResultVO updateFavoritesStatus ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "resDocSeq", "Y", "favoritesStatus", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				result = dao.updateFavoritesStatus( params );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "즐겨찾기 저장/취소에 실패하였습니다.", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectFavoritesList ( Map<String, Object> param ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
				result = dao.selectFavoritesList( param );
		}
		catch ( Exception ex ) {
			result.setFail( "결의서 즐겨찾기 불러오기에 실패하였습니다.", ex );
		}
		return result;	
	}

	@Override
	public ResultVO updateResFavoriteInfo(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "resDocSeq", "Y"};
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			
			result = dao.selectResDoc( params );
			
			String docSeq = CommonConvert.NullToString( result.getAaData( ).get( 0 ).get( "docSeq" ), commonCode.EMPTYSTR );
			if ( !docSeq.equals( "" ) ) {
				result.setFail( "상신 된 문서는 변경할 수 없습니다." );
				return result;
			}
			/* 현재 결의서 데이터 초기화 */
			dao.deleteResHeadForDoc( params );
			dao.deleteResBudgetForDoc( params );
			dao.deleteResTradeForDoc( params );
			
			/* 복사할 결의서 정보 조회 */
			HashMap<String, Object> param = new HashMap<>();
			param.put("resDocSeq", params.get("favoriteResDocSeq"));
			ResultVO headInfo = dao.selectResHead(param);
			ResultVO budgetInfo = dao.selectResBudget(param);
			ResultVO tradeInfo = dao.selectResTrade(param);
			
			/* 즐겨찾기 데이터 이관 - DOC */
			result = dao.updateDocFavoriteInfo( params );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				throw new Exception( " 품의 문서 반영 도중 오류가 발생하였습니다. " );
			}
			
			if(headInfo.getResultCode().equals(commonCode.FAIL)) {
				return headInfo;
			} else if(budgetInfo.getResultCode().equals(commonCode.FAIL)) {
				return budgetInfo;
			} else if(tradeInfo.getResultCode().equals(commonCode.FAIL)) {
				return tradeInfo;
			}
			
			List<Map<String, Object>> headList = headInfo.getAaData();
			List<Map<String, Object>> budgetList = budgetInfo.getAaData();
			List<Map<String, Object>> tradeList = tradeInfo.getAaData();
			
			
			int budgetIndex = 0;
			int tradeIndex = 0;
			for(int hIndex=0;hIndex<headList.size();hIndex++) {
				
				Map<String, Object> targetHead = headList.get(hIndex);
				targetHead.put("resDocSeq", params.get("resDocSeq"));
				ResultVO headInsertResult = dao.updateHeadFavoriteInfo(targetHead);
				if(headInsertResult.getResultCode().equals(commonCode.FAIL) ) {
					throw new Exception( " 품의 문서 반영 도중 오류가 발생하였습니다. " );
				}
				String resSeq = CommonConvert.NullToString( headInsertResult.getaData().get("resSeq") ) ;
				
				do{
					if( budgetList.size() < (budgetIndex +1) ) {
						break;
					}else if( !headList.get(hIndex).get("resSeq").equals( budgetList.get(budgetIndex).get("resSeq") ) )  {
						break;
					}else {
						Map<String, Object> targetBudget = budgetList.get(budgetIndex);
						targetBudget.put("resSeq", resSeq);
						targetBudget.put("resDocSeq", params.get("resDocSeq"));
						ResultVO budgetInsertResult = dao.updateBudgetFavoriteInfo(targetBudget);
						if(budgetInsertResult.getResultCode().equals(commonCode.FAIL) ) {
							throw new Exception( " 품의 문서 반영 도중 오류가 발생하였습니다. " );
						}
						String budgetSeq = CommonConvert.NullToString( budgetInsertResult.getaData().get("budgetSeq") ) ;
						do {
							if( tradeList.size() < (tradeIndex +1) ) {
								break;
							}else if( !budgetList.get(budgetIndex).get("budgetSeq").equals( tradeList.get(tradeIndex).get("budgetSeq") ) )  {
								break;
							}else {
								Map<String, Object> targetTrade = tradeList.get(tradeIndex);
								targetTrade.put("resSeq", resSeq);
								targetTrade.put("budgetSeq", budgetSeq);
								targetTrade.put("resDocSeq", params.get("resDocSeq"));
								ResultVO tradeInsertResult = dao.updateTradeFavoriteInfo(targetTrade);
								if(tradeInsertResult.getResultCode().equals(commonCode.FAIL) ) {
									throw new Exception( " 품의 문서 반영 도중 오류가 발생하였습니다. " );
								}
								tradeIndex++;
							}
						}while(true);
						budgetIndex ++;
					}
				}while (true);
			}
			
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				throw new Exception( " 품의 문서 반영 도중 오류가 발생하였습니다. " );
			}
		}
		catch ( Exception ex ) {
			/* 예산을 잡고 있지 않도록 롤백. */
			dao.rollbackDocConfferInfo( params );
			dao.rollbackHeadConfferInfo( params );
			dao.rollbackBudgetConfferInfo( params );
			dao.rollbackTradeConfferInfo( params );
			result.setFail( "참조품의 반영중 에러가 발생하였습니다." + ex.getMessage( ), ex );
		}
		return result;
	}

	@Override
	public ResultVO insertResItemSpec(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO( );
		
		try {
			String[] key = { "resDocSeq", "Y", "resSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				dao.deleteResItemSpec(params);
				result.setAaData(CommonConvert.CommonGetJSONToListMap((String)params.get("innerData")));
				List<Map<String,Object>> itemList = result.getAaData();
				for(int i=0;i<itemList.size();i++ ) {
					Map<String,Object> param = itemList.get(i);
					param.put("resDocSeq", params.get("resDocSeq"));
					param.put("resSeq", params.get("resSeq"));
					param.put("budgetSeq", params.get("budgetSeq"));
					result = dao.insertResItemSpec(param);
					if(result.getResultCode().equals("Fail")) {
						dao.deleteResItemSpec(params);
					}
				}
			}
			result = dao.selectResItemSpec(params);
		}
		catch ( Exception ex ) {
			result.setFail( "즐겨찾기 저장/취소에 실패하였습니다.", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectResItemSpec(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "resDocSeq", "Y", "resSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				result = dao.selectResItemSpec( params );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "물품명세 조회에 실패하였습니다.", ex );
		}
		return result;
	}
}

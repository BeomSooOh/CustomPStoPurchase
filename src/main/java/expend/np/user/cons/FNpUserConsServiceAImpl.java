package expend.np.user.cons;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cmm.util.MapUtil;
import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ResultVO;
import expend.np.user.budget.BNpUserBudgetService;
import expend.np.user.option.BNpUserOptionService;


@Service ( "FNpUserConsServiceA" )
public class FNpUserConsServiceAImpl implements FNpUserConsService {

	/* 변수정의 */
	/* 변수정의 - DAO */
	@Resource(name = "FNpUserConsServiceADAO")
	private FNpUserConsServiceADAO	dao;

	@Resource(name = "BNpUserBudgetService")
	private BNpUserBudgetService	serviceBudget;

	@Resource(name = "BNpUserOptionService")
	private BNpUserOptionService	userServiceOption;	/* Expend Service */

	@Resource(name = "CommonInfo")
	private CommonInfo				cmInfo;

	public ResultVO GetExDocMake ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = dao.GetExDocMake( params );
		}
		catch ( Exception ex ) {
			result.setFail( "전자결재 인터락 조회 오류가 발생했습니다." );
		}
		return result;
	}

	/**
	 * 품의문서 생성
	 */
	@Override
	public ResultVO insertConsDoc ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = dao.insertConsDoc( params );
		}
		catch ( Exception ex ) {
			result.setFail( "품의문서 생성에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 각개 품의서 생성
	 */
	@Override
	public ResultVO insertConsHead ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "consDocSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				result = dao.insertConsHead( params );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "각개 품의 생성에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 품의 예산 생성
	 */
	@Override
	public ResultVO insertConsBudget ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "consDocSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				/* 품의 예산 생성 */
				result = dao.insertConsBudget( params );
				Map<String, Object> orgnAData = result.getaData( );
				Map<String, Object> amtTemp = serviceBudget.selectConsAmt( params ).getaData( );
				orgnAData.put( "amt", amtTemp.get( "consBudgetAmt" ) );
				orgnAData.put( "stdAmt", amtTemp.get( "consBudgetStdAmt" ) );
				orgnAData.put( "taxAmt", amtTemp.get( "consBudgetTaxAmt" ) );

				/* 예산별 금회 품의액 생성 */
				ResultVO tryResult = serviceBudget.selectTryAmt( params );
				orgnAData.put( "tryAmt", tryResult.getaData( ).get( "tryAmt" ) );

				/* 품의서 금액 조회 */
				result.setaData( orgnAData );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "품의 예산 생성에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 품의 거래처 생성
	 */
	@Override
	public ResultVO insertConsTrade ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "consDocSeq", "Y", "consSeq", "Y", "budgetSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				/* 품의 거래처 생성 */
				result = dao.insertConsTrade( params );
				/* 품의 예산 정보 갱신 */
				dao.updateConsAmt( params );
				/* 품의서 예산 조회 */
				Map<String, Object> orgnAData = result.getaData( );
				Map<String, Object> amtTemp = serviceBudget.selectConsAmt( params ).getaData( );
				orgnAData.put( "amt", amtTemp.get( "consBudgetAmt" ) );
				orgnAData.put( "stdAmt", amtTemp.get( "consBudgetStdAmt" ) );
				orgnAData.put( "taxAmt", amtTemp.get( "consBudgetTaxAmt" ) );

				/* 예산별 금회 품의액 생성 */
				ResultVO tryResult = serviceBudget.selectTryAmt( params );
				orgnAData.put( "tryAmt", tryResult.getaData( ).get( "tryAmt" ) );

				result.setaData( orgnAData );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "품의 거래처 생성에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 품의 문서 갱신
	 */
	@Override
	public ResultVO updateConsDoc ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "consDocSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				result = dao.updateConsDoc( params );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "품의문서 갱신에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 품의 문서 전자결재 정보 갱신
	 */
	@Override
	public ResultVO updateConsDocEaInfo ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "consDocSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				result = dao.updateConsDocEaInfo( params );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "품의 문서 전자결재 정보 갱신에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 각개 품의서 갱신
	 */
	@Override
	public ResultVO updateConsHead ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "consDocSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				result = dao.updateConsHead( params );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "각개 품의서 갱신에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 품의 예산 갱신
	 */
	@Override
	public ResultVO updateConsBudget ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "consDocSeq", "Y", "consSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				/* 품의 예산 갱신 */
				result = dao.updateConsBudget( params );

				/* 품의서 예산 조회 */
				Map<String, Object> orgnAData = result.getaData( );
				Map<String, Object> amtTemp = serviceBudget.selectConsAmt( params ).getaData( );
				orgnAData.put( "budgetSeq", params.get( "budgetSeq" ) );
				orgnAData.put( "amt", amtTemp.get( "consBudgetAmt" ) );
				orgnAData.put( "stdAmt", amtTemp.get( "consBudgetStdAmt" ) );
				orgnAData.put( "taxAmt", amtTemp.get( "consBudgetTaxAmt" ) );

				/* 예산별 금회 품의액 생성 */
				ResultVO tryResult = serviceBudget.selectTryAmt( params );
				orgnAData.put( "tryAmt", tryResult.getaData( ).get( "tryAmt" ) );

				result.setaData( orgnAData );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "품의 예산 갱신에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 품의 거래처 갱신
	 */
	@Override
	public ResultVO updateConsTrade ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "consDocSeq", "Y", "consSeq", "Y", "tradeSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				result = dao.updateConsTrade( params );
				/* 품의 예산 정보 갱신 */
				dao.updateConsAmt( params );
				/* 품의 예산금액 조회 */
				Map<String, Object> orgnAData = result.getaData( );
				Map<String, Object> amtTemp = serviceBudget.selectConsAmt( params ).getaData( );
				orgnAData.put( "amt", amtTemp.get( "consBudgetAmt" ) );
				orgnAData.put( "stdAmt", amtTemp.get( "consBudgetStdAmt" ) );
				orgnAData.put( "taxAmt", amtTemp.get( "consBudgetTaxAmt" ) );

				/* 예산별 금회 품의액 생성 */
				ResultVO tryResult = serviceBudget.selectTryAmt( params );
				orgnAData.put( "tryAmt", tryResult.getaData( ).get( "tryAmt" ) );

				result.setaData( orgnAData );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "품의 거래처 갱신에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 품의 문서 삭제
	 */
	@Override
	public ResultVO deleteConsDoc ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "consDocSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				/* 품의 단계 삭제 */
				dao.deleteConsHeadForDoc( params );
				/* 예산 단계 삭제 */
				dao.deleteConsBudgetForDoc( params );
				/* 채주 단계 삭제 */
				dao.deleteConsTradeForDoc( params );
				/* 문서 단계 삭제 */
				result = dao.deleteConsDoc( params );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "품의 문서 삭제에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 각개 품의 삭제
	 */
	@Override
	public ResultVO deleteConsHead ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "consDocSeq", "Y", "consSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				/* 예산 단계 삭제 */
				dao.deleteConsBudgetForCons( params );
				/* 채주 단계 삭제 */
				dao.deleteConsTradeForCons( params );
				/* 품의 단계 삭제 */
				result = dao.deleteConsHead( params );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "각개 품의 삭제에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 품의 예산 삭제
	 */
	@Override
	public ResultVO deleteConsBudget ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "consDocSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				/* 채주 단계 삭제 */
				dao.deleteConsTradeForBudget( params );
				/* 예산 단계 삭제 */
				result = dao.deleteConsBudget( params );
				/* 품의서 예산 조회 */
				Map<String, Object> orgnAData = result.getaData( );
				Map<String, Object> amtTemp = serviceBudget.selectConsAmt( params ).getaData( );
				orgnAData.put( "amt", amtTemp.get( "consBudgetAmt" ) );
				orgnAData.put( "stdAmt", amtTemp.get( "consBudgetStdAmt" ) );
				orgnAData.put( "taxAmt", amtTemp.get( "consBudgetTaxAmt" ) );

				/* 예산별 금회 품의액 생성 */
				ResultVO tryResult = serviceBudget.selectTryAmt( params );
				orgnAData.put( "tryAmt", tryResult.getaData( ).get( "tryAmt" ) );

				result.setaData( orgnAData );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "품의 예산 삭제에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 품의 거래처 삭제
	 */
	@Override
	public ResultVO deleteConsTrade ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "consDocSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				/* 품의서 거래처 정보 삭제 */
				result = dao.deleteConsTrade( params );
				/* 품의 예산 정보 갱신 */
				dao.updateConsAmt( params );
				/* 품의 예산금액 조회 */
				Map<String, Object> orgnAData = result.getaData( );
				Map<String, Object> amtTemp = serviceBudget.selectConsAmt( params ).getaData( );
				orgnAData.put( "amt", amtTemp.get( "consBudgetAmt" ) );
				orgnAData.put( "stdAmt", amtTemp.get( "consBudgetStdAmt" ) );
				orgnAData.put( "taxAmt", amtTemp.get( "consBudgetTaxAmt" ) );

				/* 예산별 금회 품의액 생성 */
				ResultVO tryResult = serviceBudget.selectTryAmt( params );
				orgnAData.put( "tryAmt", tryResult.getaData( ).get( "tryAmt" ) );

				result.setaData( orgnAData );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "품의 거래처 삭제에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 품의 문서 조회
	 */
	@Override
	public ResultVO selectConsDoc ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = dao.selectConsDoc( params );
		}
		catch ( Exception ex ) {
			result.setFail( "품의 문서 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 각개 품의 조회
	 */
	@Override
	public ResultVO selectConsHead ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "consDocSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				result = dao.selectConsHead( params );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "각개 품의 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 품의 예산 조회
	 */
	@Override
	public ResultVO selectConsBudget ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "consDocSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				result = dao.selectConsBudget( params );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "품의 예산 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 품의 거래처 조회
	 */
	@Override
	public ResultVO selectConsTrade ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "consDocSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				result = dao.selectConsTrade( params );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "품의 거래처 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 *	참조 품의 리스트 조회
	 * 	param : {
	 * 		! frDt    [yyyyMMdd]
	 * 		, ! toDt  [yyyyMMdd]
	 * }
	 */
	@Override
	public ResultVO selectRefferConsList ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		ResultVO existTableFlag = new ResultVO(); /* 0 : 없음 1: 있음 */

		try {
			String[] key = { "frDt", "Y", "toDt", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				result.setSuccess( );
				/* 장애인개발원 임시 처리 */
				if(CommonConvert.NullToString(params.get("groupSeq")).equals("koddi")) {
					result = dao.selectRefferConsListNotTable( params );	
				}
				else {
					result = dao.selectRefferConsList( params );
				}
				
			}
		}
		catch ( Exception ex ) {
			result.setFail( "참조품의 내역 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 	품의서 상세정보 조회
	 * 	param : {
	 * 		! consDocSeq
	 * }
	 */
	@Override
	public ResultVO selectConsDetailBudget ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "consDocSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				result = dao.selectConsDetailBudget( params );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "품의서 상세정보 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectConfferConsBudgetInfo ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "resSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				result = dao.selectConfferConsBudgetInfo( params );
				Map<String, Object> aData = new HashMap<String, Object>();
				if(CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS )){
					List<Map<String, Object>> budgetInfo = result.getAaData( );
					if(budgetInfo.size( ) == 0){
						/* 일반 결의서의 경우 */
						aData.put( "isConffer", "N" );
						aData.put( "erpBudgetSeq", new ArrayList<String>() );
						aData.put( "erpBizplanSeq", new ArrayList<String>() );
						aData.put( "erpFiacctSeq", new ArrayList<String>() );
						aData.put( "erpBgacctSeq", new ArrayList<String>() );

						result.setaData( aData );
						result.setSuccess( "일반 결의서" );
					}else{
						ArrayList<String> erpBudgetSeq = new ArrayList<>( );
						ArrayList<String> erpBizplanSeq = new ArrayList<>( );
						ArrayList<String> erpFiacctSeq = new ArrayList<>( );
						ArrayList<String> erpBgacctSeq = new ArrayList<>( );
						for( Map<String, Object> item : budgetInfo ){
							erpBudgetSeq.add( item.get( "erpBudgetSeq" ).toString( ) );
							erpBizplanSeq.add( item.get( "erpBizplanSeq" ).toString( ) );
							erpFiacctSeq.add( item.get( "erpFiacctSeq" ).toString( ) );
							erpBgacctSeq.add( item.get( "erpBgacctSeq" ).toString( ) );
						}
						aData.put( "isConffer", "Y" );
						aData.put( "erpBudgetSeq", erpBudgetSeq );
						aData.put( "erpBizplanSeq", erpBizplanSeq );
						aData.put( "erpFiacctSeq", erpFiacctSeq );
						aData.put( "erpBgacctSeq", erpBgacctSeq );
						result.setaData( aData );
						result.setSuccess( "참조 결의서" );
					}
				}
			}
		}
		catch ( Exception ex ) {
			result.setFail( "품의서 상세정보 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	@Override
	public ResultVO updateFavoritesStatus(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "consDocSeq", "Y", "favoritesStatus", "Y" };
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
	public ResultVO selectFavoritesList(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO( );
		try {
				result = dao.selectFavoritesList( params );
		}
		catch ( Exception ex ) {
			result.setFail( "결의서 즐겨찾기 불러오기에 실패하였습니다.", ex );
		}
		return result;
	}

	@Override
	public ResultVO updateConsFavoriteInfo(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "consDocSeq", "Y"};
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}

			result = dao.selectConsDoc( params );

			String docSeq = CommonConvert.NullToString( result.getAaData( ).get( 0 ).get( "docSeq" ), commonCode.EMPTYSTR );
			if ( !docSeq.equals( "" ) ) {
				result.setFail( "상신 된 문서는 변경할 수 없습니다." );
				return result;
			}
			/* 현재 품의서 데이터 초기화 */
			dao.deleteConsHeadForDoc( params );
			dao.deleteConsBudgetForDoc( params );

			/* 복사할 품의서 정보 조회 */
			HashMap<String, Object> param = new HashMap<>();
			param.put("consDocSeq", params.get("favoriteConsDocSeq"));
			ResultVO headInfo = dao.selectConsHead(param);
			ResultVO budgetInfo = dao.selectConsBudget(param);

			/* 즐겨찾기 데이터 이관 - DOC */
			result = dao.updateDocFavoriteInfo( params );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				throw new Exception( " 즐겨찾기문서 복사 반영 도중 오류가 발생하였습니다. " );
			}

			if(headInfo.getResultCode().equals(commonCode.FAIL)) {
				return headInfo;
			} else if(budgetInfo.getResultCode().equals(commonCode.FAIL)) {
				return budgetInfo;
			}

			List<Map<String, Object>> headList = headInfo.getAaData();
			List<Map<String, Object>> budgetList = budgetInfo.getAaData();

			int budgetIndex = 0;
			for(int hIndex=0;hIndex<headList.size();hIndex++) {

				Map<String, Object> targetHead = headList.get(hIndex);
				targetHead.put("consDocSeq", params.get("consDocSeq"));
				ResultVO headInsertResult = dao.updateHeadFavoriteInfo(targetHead);
				if(headInsertResult.getResultCode().equals(commonCode.FAIL) ) {
					throw new Exception( " 즐겨찾기문서 복사 반영 도중 오류가 발생하였습니다. " );
				}
				String consSeq = CommonConvert.NullToString( headInsertResult.getaData().get("consSeq") ) ;

				do{
					if( budgetList.size() < (budgetIndex +1) ) {
						break;
					}else if( !headList.get(hIndex).get("consSeq").equals( budgetList.get(budgetIndex).get("consSeq") ) )  {
						break;
					}else {
						Map<String, Object> targetBudget = budgetList.get(budgetIndex);
						targetBudget.put("consSeq", consSeq);
						targetBudget.put("consDocSeq", params.get("consDocSeq"));
						ResultVO budgetInsertResult = dao.updateBudgetFavoriteInfo(targetBudget);
						if(budgetInsertResult.getResultCode().equals(commonCode.FAIL) ) {
							throw new Exception( "즐겨찾기문서 복사 반영 도중 오류가 발생하였습니다. " );
						}
						String budgetSeq = CommonConvert.NullToString( budgetInsertResult.getaData().get("budgetSeq") ) ;
						budgetIndex ++;
					}
				}while (true);
			}

			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				throw new Exception( "즐겨찾기문서 복사 반영 도중 오류가 발생하였습니다. " );
			}
		}
		catch ( Exception ex ) {
			/* 예산을 잡고 있지 않도록 롤백. */
			dao.deleteConsDoc( params );
			dao.deleteConsHeadForDoc( params );
			dao.deleteConsBudgetForDoc( params );
			result.setFail( "즐겨찾기 반영중 에러가 발생하였습니다." + ex.getMessage( ), ex );
		}
		return result;
	}

	@Override
	public ResultVO insertConsItemSpec(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO( );

		try {
			String[] key = { "consDocSeq", "Y", "consSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				dao.deleteConsItemSpec(params);
				result.setAaData(CommonConvert.CommonGetJSONToListMap((String)params.get("innerData")));
				List<Map<String,Object>> itemList = result.getAaData();
				for(int i=0;i<itemList.size();i++ ) {
					Map<String,Object> param = itemList.get(i);
					param.put("consDocSeq", params.get("consDocSeq"));
					param.put("consSeq", params.get("consSeq"));
					param.put("budgetSeq", params.get("budgetSeq"));
					result = dao.insertConsItemSpec(param);
					if(result.getResultCode().equals("Fail")) {
						dao.deleteConsItemSpec(params);
					}
				}
			}
			result = dao.selectConsItemSpec(params);
		}
		catch ( Exception ex ) {
			result.setFail( "즐겨찾기 저장/취소에 실패하였습니다.", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectConsItemSpec(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "consDocSeq", "Y", "consSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				result = dao.selectConsItemSpec( params );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "물품명세 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectTripConsDoc(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = dao.selectTripConsDoc( params );
		}
		catch ( Exception ex ) {
			result.setFail( "참조품의 문서 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectGroupBudgetInfo ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "consDocSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				result = dao.selectGroupBudgetInfo( params );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "품의서내 예산 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectConsInCustom(Map<String, Object> params) throws Exception { // TODO: 백상휘 수정.
		return dao.selectConsInCustom(params);
	}
}

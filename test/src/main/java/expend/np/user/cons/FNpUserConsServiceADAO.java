package expend.np.user.cons;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import common.helper.convert.CommonConvert;
import common.vo.common.ResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FNpUserConsServiceADAO" )
public class FNpUserConsServiceADAO extends EgovComAbstractDAO {

	/**
	 * 품의서 인터락 정보 생성
	 * P : { !formSeq }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO GetExDocMake ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			List<Map<String, Object>> temp = list( "", params );
			result.setAaData( temp );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}
	
	
	/**
	 * 품의문서 생성
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO insertConsDoc ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			int consDocSeq = (int) insert( "NpUserConsA.insertConsDoc", params );
			if ( consDocSeq > 0 ) {
				Map<String, Object> temp = new HashMap<String, Object>( );
				temp.put( "consDocSeq", consDocSeq );
				result.setaData( temp );
				result.setSuccess( );
			}
			else {
				result.setFail( "품의 문서가 저장되지 않았습니다." );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 품의문서 삭제
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO deleteConsDoc ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			int resultCnt = (int) delete( "NpUserConsA.deleteConsDoc", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 품의문서 갱신
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO updateConsDoc ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			int resultCnt = (int) update( "NpUserConsA.updateConsDoc", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 품의문서 전자결재 정보갱신
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO updateConsDocEaInfo ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			int resultCnt = (int) update( "NpUserConsA.updateConsDocEaInfo", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 품의문서 정보 조회
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO selectConsDoc ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData( (List<Map<String, Object>>) list( "NpUserConsA.selectConsDoc", params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 각개 품의 정보 생성
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO insertConsHead ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			int consSeq = (int) insert( "NpUserConsA.insertConsHead", params );
			if ( consSeq > 0 ) {
				Map<String, Object> temp = new HashMap<String, Object>( );
				temp.put( "consSeq", consSeq );
				result.setaData( temp );
				result.setSuccess( );
			}
			else {
				result.setFail( "품의 문서가 저장되지 않았습니다." );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 각개 품의 정보 갱신
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO updateConsHead ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			int resultCnt = (int) update( "NpUserConsA.updateConsHead", params );
			update("NpUserConsA.updateConsDoc", params);
			
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}

	/**
	 * 각개 품의 정보 조회
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO selectConsHead ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData( (List<Map<String, Object>>) list( "NpUserConsA.selectConsHead", params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 각개 품의 정보 삭제 - 단일 품의서
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO deleteConsHead ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			int resultCnt = (int) delete( "NpUserConsA.deleteConsHead", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 각개 품의 정보 삭제 - 문서 단위
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO deleteConsHeadForDoc ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			int resultCnt = (int) delete( "NpUserConsA.deleteConsHeadForDoc", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 각개 품의 예산 정보 생성
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO insertConsBudget ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			int budgetSeq = (int) insert( "NpUserConsA.insertConsBudget", params );
			if ( budgetSeq > 0 ) {
				Map<String, Object> temp = new HashMap<String, Object>( );
				temp.put( "budgetSeq", budgetSeq );
				result.setaData( temp );
				result.setSuccess( );
			}
			else {
				result.setFail( "품의 문서가 저장되지 않았습니다." );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 각개 품의 예산 정보 갱신
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO updateConsBudget ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			int resultCnt = (int) update( "NpUserConsA.updateConsBudget", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 각개 품의 예산 정보 조회
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO selectConsBudget ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData( (List<Map<String, Object>>) list( "NpUserConsA.selectConsBudget", params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 각개 품의 예산 정보 삭제
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO deleteConsBudget ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			int resultCnt = (int) delete( "NpUserConsA.deleteConsBudget", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 각개 품의 예산 정보 삭제 - 문서 단위
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO deleteConsBudgetForDoc ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			int resultCnt = (int) delete( "NpUserConsA.deleteConsBudgetForDoc", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 각개 품의 예산 정보 삭제 - 품의서 단위
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO deleteConsBudgetForCons ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			int resultCnt = (int) delete( "NpUserConsA.deleteConsBudgetForCons", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 각개 품의 거래처 정보 생성
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO insertConsTrade ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			int tradeSeq = (int) insert( "NpUserConsA.insertConsTrade", params );
			if ( tradeSeq > 0 ) {
				Map<String, Object> temp = new HashMap<String, Object>( );
				temp.put( "tradeSeq", tradeSeq );
				result.setaData( temp );
				result.setSuccess( );
			}
			else {
				result.setFail( "품의 문서가 저장되지 않았습니다." );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 각개 품의 거래처 정보 갱신
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO updateConsTrade ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			int resultCnt = (int) update( "NpUserConsA.updateConsTrade", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 각개 품의 거래처 정보 조회
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO selectConsTrade ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData( (List<Map<String, Object>>) list( "NpUserConsA.selectConsTrade", params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 각개 품의 거래처 정보 삭제
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO deleteConsTrade ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			int resultCnt = (int) delete( "NpUserConsA.deleteConsTrade", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 각개 품의 거래처 정보 삭제 - 예산 종속
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO deleteConsTradeForBudget ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			int resultCnt = (int) delete( "NpUserConsA.deleteConsTradeForBudget", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 각개 품의 거래처 정보 삭제 - 품의서 종속
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO deleteConsTradeForCons ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			int resultCnt = (int) delete( "NpUserConsA.deleteConsTradeForCons", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 각개 품의 거래처 정보 삭제 - 품의서 문서 종속
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO deleteConsTradeForDoc ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			int resultCnt = (int) delete( "NpUserConsA.deleteConsTradeForDoc", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 각개 품의 예산정보 최신화
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO updateConsAmt ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			update( "NpUserConsA.updateConsBudgetAmt", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}
	
	/**
	 * 참조 품의 품의서 리스트 조회
	 * P : { 
	 * 	! frDt   [yyyyMMdd]
	 * 	, ! toDt [yyyyMMdd]
	 * }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO selectRefferConsList ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData( (List<Map<String, Object>>) list( "NpUserConsA.selectRefferConsList", params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}
	
	/**
	 * 참조 품의 품의서 리스트 조회 (t_exnp_cons_auth X)
	 * P : { 
	 * 	! frDt   [yyyyMMdd]
	 * 	, ! toDt [yyyyMMdd]
	 * }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO selectRefferConsListNotTable ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData( (List<Map<String, Object>>) list( "NpUserConsA.selectRefferConsListNotTable", params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}
	
	
	/**
	 * 품의서 상세 정보 조회 
	 * P : { 
	 * 	! consDocSeq
	 * }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO selectConsDetailBudget ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData( (List<Map<String, Object>>) list( "NpUserConsA.selectConsDetailBudget", params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}
	
	/**
	 * 결의서 키를 이용한 품의서 예산 정보조회 
	 * P : { 
	 * 	! consDocSeq
	 * }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO selectConfferConsBudgetInfo ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData( (List<Map<String, Object>>) list( "NpUserConsA.selectConfferConsBudgetInfo", params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}


	public ResultVO updateFavoritesStatus(Map<String, Object> param) {
		ResultVO result =  new ResultVO( );
		try {
			update("NpUserCard.updateFavoritesConsStatus", param);
			result.setSuccess( );
		}
		catch ( Exception e ) {
			result.setFail( e.toString( ), e );
		}
		return result;
	}


	public ResultVO selectFavoritesList(Map<String, Object> params) {
		ResultVO result = new ResultVO();
		try {
			result.setAaData((List<Map<String, Object>>) list("NpUserConsA.selectFavoritesList", params));
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;	
	}


	public ResultVO updateDocFavoriteInfo(Map<String, Object> params) {
		ResultVO result = new ResultVO();
		try {
			update("NpUserConsA.updateDocFavoriteInfo", params);
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}


	public ResultVO updateHeadFavoriteInfo(Map<String, Object> params) {
		ResultVO result = new ResultVO();
		try {
			int consSeq = (int) insert("NpUserConsA.updateHeadFavoriteInfo", params);
			Map param = new HashMap<>();
			param.put("consSeq", Integer.toString(consSeq));
			result.setaData(param);
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}


	public ResultVO updateBudgetFavoriteInfo(Map<String, Object> params) {
		ResultVO result = new ResultVO();
		try {
			int budgetSeq = (int) insert("NpUserConsA.updateBudgetFavoriteInfo", params);
			Map param = new HashMap<>();
			param.put("budgetSeq", Integer.toString(budgetSeq));
			result.setaData(param);
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}


	public ResultVO insertConsItemSpec(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			int consItemSeq = (int) insert( "NpUserConsA.insertConsItemSpec", params );
			if ( consItemSeq > 0 ) {
				result.setSuccess( );
			}
			else {
				result.setFail( "물품명세 정보가 저장되지 않았습니다." );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}


	public ResultVO selectConsItemSpec(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData( (List<Map<String, Object>>) list( "NpUserConsA.selectConsItemSpec", params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "물품명세 정보가 조회되지 않았습니다.", ex );
		}
		return result;
	}


	public ResultVO deleteConsItemSpec(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			int resultCnt = (int) delete( "NpUserConsA.deleteConsItemSpec", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "물품명세 정보가 삭제되지 않았습니다.", ex );
		}
		return result;	
	}


	public ResultVO selectTripConsDoc(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData( (List<Map<String, Object>>) list( "NpUserConsA.selectTripConsDoc", params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "출장 참조품의 정보가 조회되지 않았습니다.", ex );
		}
		return result;	
	}
	
	/**
	 * 품의서내 중복 예산코드 금액 정보조회
	 */
	@SuppressWarnings("unchecked")
	public ResultVO selectGroupBudgetInfo(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			if( CommonConvert.NullToString(  params.get( "erpBudgetSeq" ) ).equals( "" )){
				params.put( "erpBudgetSeq", "-1" );
			}
			if( CommonConvert.NullToString(  params.get( "erpBgacctSeq" ) ).equals( "" )){
				params.put( "erpBgacctSeq", "-1" );
			}
			if( CommonConvert.NullToString(  params.get( "erpBizplanSeq" ) ).equals( "" )){
				params.put( "erpBizplanSeq", "-1" );
			}
			
			List<Map<String, Object>> aaData = (List<Map<String, Object>> )list("NpUserConsA.selectGroupBudgetInfo", params);
			if(aaData.size( ) == 0){
				Map<String, Object> aData = new HashMap<>( );
				aData.put( "consDocSeq", "" );
				aData.put( "consSeq", "" );
				aData.put( "budgetAmt", "0" );
				aData.put( "budgetStdAmt", "0" );
				aData.put( "budgetTaxAmt", "0" );
				aaData.add( aData );
			}
			result.setAaData( aaData );
			
			if( CommonConvert.NullToString(  params.get( "erpBizplanSeq" ) ).equals( "-1" )){
				params.put( "erpBizplanSeq", "" );
			}
			
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}
}

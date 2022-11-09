package expend.trip.user.res;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import common.helper.logger.CommonLogger;
import common.vo.common.ResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FTripUserResServiceADAO" )
public class FTripUserResServiceADAO extends EgovComAbstractDAO {

	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );

	public ResultVO insertTripResDoc ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			int consDocSeq = (int) insert( "TripUserResA.insertTripResDoc", params );
			if ( consDocSeq > 0 ) {
				Map<String, Object> temp = new HashMap<String, Object>( );
				temp.put( "tripResDocSeq", consDocSeq );
				result.setaData( temp );
				result.setSuccess( );
			}
			else {
				result.setFail( "결의 문서가 저장되지 않았습니다." );
			}
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail( "출장 결의 문서 생성 실패", ex );
		}
		return result;
	}

	/* 결의 2.0 프로젝트 정보 조회 */
	public ResultVO selectResMgtInfo ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData( list( "TripUserResA.selectResMgtInfo", params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail( "프로젝트 정보 조회 실패", ex );
		}
		return result;
	}

	/* 결의 2.0 예산 정보 조회 */
	public ResultVO selectResBgtInfo ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData( list( "TripUserResA.selectResBgtInfo", params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail( "프로젝트 정보 조회 실패", ex );
		}
		return result;
	}

	/* 결의 2.0 결의 총 금액 */
	public ResultVO selectResAmt ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			result.setaData( (Map<String, Object>) (list( "TripUserResA.selectResAmt", params ).get( 0 )) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail( "프로젝트 정보 조회 실패", ex );
		}
		return result;
	}

	/** 출장 결의 현황 조회 **/
	public ResultVO selectTripResReport ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			// 기본 리스트 조회
			String queryId = "TripUserResA.selectTripResReport";
			// 엑셀저장 시 분기 처리
			if(params.get("tripExcelCode") != null && params.get("tripExcelCode").toString().equals("2")){
				// 예산계정별 리스트 조회
				queryId = "TripUserResA.selectTripResReportForBudget";
			}else if(params.get("tripExcelCode") != null && params.get("tripExcelCode").toString().equals("3")){
				// 사용자별 리스트 조회
				queryId = "TripUserResA.selectTripResReportForUser";
			}

			//ArrayList<Map<String, Object>> aaData = (ArrayList<Map<String, Object>>) list( "TripUserResA.selectTripResReport", params );
			ArrayList<Map<String, Object>> aaData = (ArrayList<Map<String, Object>>) list( queryId, params );
			Map<String, Object> aData = new HashMap( );
			aData.put( "size", aaData.size( ) );
			result.setAaData( aaData );
			result.setaData( aData );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail( "프로젝트 정보 조회 실패", ex );
		}
		return result;
	}

	/** 출장 결의 현황 조회 **/
	public ResultVO selectConfferList ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			ArrayList<Map<String, Object>> aaData = (ArrayList<Map<String, Object>>) list( "TripUserResA.selectConfferList", params );
			Map<String, Object> aData = new HashMap( );
			aData.put( "size", aaData.size( ) );
			result.setAaData( aaData );
			result.setaData( aData );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail( "프로젝트 정보 조회 실패", ex );
		}
		return result;
	}

	/** t_exnp_trip_res_doc 참조결의 정보 업데이트 **/
	public ResultVO updateConfferInfoDoc ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try{
			update( "TripUserResA.updateConfferInfoDoc", params );
			result.setSuccess( );
		}catch(Exception ex){
			cmLog.CommonSetError( ex );
			result.setFail( "출장 품의서 정보 조회 실패", ex );
		}
		return result;
	}

	/** t_exnp_trip_res_attend 참조결의 정보 생성 - 출장 정보 **/
	public ResultVO insertConfferInfoAttend ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try{
			int attendSeq = (int) insert( "TripUserResA.insertConfferInfoAttend", params );
			Map<String, Object> aData = new HashMap<String, Object>();
			aData.put( "attendSeq", attendSeq );
			result.setaData( aData );
			result.setSuccess( );
		}catch(Exception ex){
			cmLog.CommonSetError( ex );
			result.setFail( "출장정보 정보 조회 실패", ex );
		}
		return result;
	}


	/** t_exnp_trip_res_expense 참조결의 정보 생성 - 금액 정보 **/
	public ResultVO insertConfferInfoExpense ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try{
			insert( "TripUserResA.insertConfferInfoExpense", params );
			result.setSuccess( );
		}catch(Exception ex){
			cmLog.CommonSetError( ex );
			result.setFail( "출장여비 정보 조회 실패", ex );
		}
		return result;
	}


	/** t_exnp_trip_res_traveler 참조결의 정보 생성 - 출장자 정보 **/
	public ResultVO insertConfferInfoTraveler ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try{
			insert( "TripUserResA.insertConfferInfoTraveler", params );
			result.setSuccess( );
		}catch(Exception ex){
			cmLog.CommonSetError( ex );
			result.setFail( "출장자 정보 조회 실패", ex );
		}
		return result;
	}

	/** 결의서 출장 정보 조회 **/
	public ResultVO selectTripAttendInfo ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try{
			List<Map<String, Object>> aaData = list("TripUserResA.selectTripAttendInfo", params);
			result.setAaData( aaData );
			result.setSuccess( );
		}catch(Exception ex){
			cmLog.CommonSetError( ex );
			result.setFail( "프로젝트 정보 조회 실패", ex );
		}
		return result;
	}

	/** 결의서 출장자 정보 조회 **/
	public ResultVO selectTripTravelerInfo ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try{
			List<Map<String, Object>> aaData = list("TripUserResA.selectTripTravelerInfo", params);
			result.setAaData( aaData );
			result.setSuccess( );
		}catch(Exception ex){
			cmLog.CommonSetError( ex );
			result.setFail( "프로젝트 정보 조회 실패", ex );
		}
		return result;
	}

	/** 출장 결의서 예산 정보 임시 조회 **/
	public ResultVO selectTripBudgetInfo ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try{
			List<Map<String, Object>> aaData = list("TripUserResA.selectTripBudgetInfo", params);
			result.setAaData( aaData );
			result.setSuccess( );
		}catch(Exception ex){
			cmLog.CommonSetError( ex );
			result.setFail( "프로젝트 정보 조회 실패", ex );
		}
		return result;
	}

	/** 출장 결의서 프로젝트 정보 임시 조회 **/
	public ResultVO selectTripMgtInfo ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try{
			List<Map<String, Object>> aaData = list("TripUserResA.selectTripMgtInfo", params);
			result.setAaData( aaData );
			result.setSuccess( );
		}catch(Exception ex){
			cmLog.CommonSetError( ex );
			result.setFail( "프로젝트 정보 조회 실패", ex );
		}
		return result;
	}

	/** 결의서 출장여비 정보 조회 **/
	public ResultVO selectTripExpenseInfo ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try{
			List<Map<String, Object>> aaData = list("TripUserResA.selectTripExpenseInfo", params);
			result.setAaData( aaData );
			result.setSuccess( );
		}catch(Exception ex){
			cmLog.CommonSetError( ex );
			result.setFail( "프로젝트 정보 조회 실패", ex );
		}
		return result;
	}
	/* 출장 품의 근태 정보 입력 */
	public ResultVO insertTripResAttend(Map<String, Object> params) {
	    ResultVO result = new ResultVO( );
	    try {
	        int attendSeq = (int) insert( "TripUserResA.insertTripResAttend", params );
	        result.setSuccess( );
	        HashMap hashMap = new HashMap<String,Object>();
	        hashMap.put("attendSeq", attendSeq);
	        result.setaData(hashMap);
	    }
	    catch ( Exception ex ) {
	        cmLog.CommonSetError( ex );
	        result.setFail("근태 정보 저장 실패",ex);
	    }
	    return result;
	}
	/* 출장 품의 출장자 정보 입력 */
	public ResultVO insertTripResTraveler(HashMap<String, Object> params) {
	    ResultVO result = new ResultVO( );
	    try {
	        insert( "TripUserResA.insertTripResTraveler", params );
	        result.setSuccess( );
	    }
	    catch ( Exception ex ) {
	        cmLog.CommonSetError( ex );
	        result.setFail("출장자 정보 저장 실패",ex);
	    }
	    return result;
	}
	/* 출장 품의 경비 내역 정보 입력 */
	public ResultVO insertTripResExpense(HashMap<String, Object> params) {
	    ResultVO result = new ResultVO( );
	    try {
	        insert( "TripUserResA.insertTripResExpense", params );
	        result.setSuccess( );
	    }
	    catch ( Exception ex ) {
	        cmLog.CommonSetError( ex );
	        result.setFail("경비 내역 정보 저장 실패",ex);
	    }
	    return result;

	}
	/* 출장 품의 인사 정보 삭제 */
	public ResultVO deleteTripResAttend(Map<String, Object> params) {
	    ResultVO result = new ResultVO( );
	    try {
	        delete( "TripUserResA.deleteTripResAttend", params );
	        result.setSuccess( );
	    }
	    catch ( Exception ex ) {
	        cmLog.CommonSetError( ex );
	        result.setFail("출장 품의 인사 정보 삭제 실패",ex);
	    }
	    return result;
	}
	/* 출장 품의 경비 내역 정보 삭제 */
	public ResultVO deleteTripResExpense(Map<String, Object> params) {
	    ResultVO result = new ResultVO( );
	    try {
	        delete( "TripUserResA.deleteTripResExpense", params );
	        result.setSuccess( );
	    }
	    catch ( Exception ex ) {
	        cmLog.CommonSetError( ex );
	        result.setFail("출장 품의 경비 내역 삭제 실패",ex);
	    }
	    return result;

	}
	/* 출장 품의 출장자 정보 삭제 */
	public ResultVO deleteTripResTraveler(Map<String, Object> params) {
	    ResultVO result = new ResultVO( );
	    try {
	        delete( "TripUserResA.deleteTripResTraveler", params );
	        result.setSuccess( );
	    }
	    catch ( Exception ex ) {
	        cmLog.CommonSetError( ex );
	        result.setFail("출장 품의 출장자 정보 삭제 실패",ex);
	    }
	    return result;

	}

	public ResultVO deleteTripResBudgetInfo(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			delete( "TripUserResA.deleteTripResBudgetInfo", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail("출장 결의 예산 과목 정보 삭제 실패",ex);
		}
		return result;
	}

	public ResultVO insertTripResBudgetErp(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			insert( "TripUserResA.insertTripResBudgetErp", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail("예산 과목 정보 저장 실패",ex);
		}
		return result;
	}

	public ResultVO selectTripResBudgetInfo(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData( list( "TripUserResA.selectTripResBudgetInfo", params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail( "프로젝트 정보 조회 실패", ex );
		}
		return result;
	}

	public ResultVO insertTripResBudget(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			int tripBudetSeq= (int) insert( "TripUserResA.insertTripResBudget", params );
			HashMap<String, Object> budgetSeqInfo = new HashMap<>();
			budgetSeqInfo.put("tripBudgetSeq", tripBudetSeq);
			result.setaData(budgetSeqInfo);
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail("예산 금액 정보 저장 실패",ex);
		}
		return result;
	}

	public ResultVO deleteTripResBudgetErpInfo(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			delete( "TripUserResA.deleteTripResBudgetErpInfo", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail("출장 결의 예산 과목 정보 삭제 실패",ex);
		}
		return result;
	}

	/* 출장 결의 문서 정보 조회 - 출장 결의 문서 정보 */
	public ResultVO selectTripResDocInfoResDoc(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData( list( "TripUserResA.selectTripResDocInfoResDoc", params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail("출장정보 조회 실패",ex);
		}
		return result;
	}

	/* 출장 결의 문서 정보 조회 - 출장 정보 */
	public ResultVO selectTripResDocInfoAttend(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData( list( "TripUserResA.selectTripResDocInfoAttend", params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail("출장정보 조회 실패",ex);
		}
		return result;
	}
	/* 출장 결의 문서 정보 조회 - 출장자 */
	public ResultVO selectTripResDocInfoTripper(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData( list( "TripUserResA.selectTripResDocInfoTripper", params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail("출장자 정보 조회 실패",ex);
		}
		return result;
	}
	/* 출장 결의 문서 정보 조회 - 출장경비내역 */
	public ResultVO selectTripResDocInfoAmt(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData( list( "TripUserResA.selectTripResDocInfoAmt", params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail("출장 경비내역 조회 실패",ex);
		}
		return result;
	}

	/**
	 * 사용자 - 인터락 양식 생성 - 컨텐츠 정보 조회 - 프로젝트 (출장복명 2.0)
	 */
	@SuppressWarnings("unchecked")
	public ResultVO selectTripProjectInterlock(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			if (params.get("processId") == null) {
				throw new Exception("프로세스 아이디를 확인할 수 없습니다.");
			}
			if (params.get("processId").toString().indexOf("TRIPRES") > -1) {
				result.setAaData(list("TripUserReportA.selectResHeadInfo", params));
			} else {
				throw new Exception("알 수 없는 프로세스 아이디입니다.");
			}
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 사용자 - 인터락 양식 생성 - 컨텐츠 정보 조회 - 예산정보 (출장복명 2.0)
	 */
	@SuppressWarnings("unchecked")
	public ResultVO selectTripBudgetInterlock(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			if (params.get("processId") == null) {
				throw new Exception("프로세스 아이디를 확인할 수 없습니다.");
			}
			if (params.get("processId").toString().indexOf("TRIPRES") > -1) {
				result.setAaData(list("TripUserReportA.selectResBudgetInfo", params));
			} else {
				throw new Exception("알 수 없는 프로세스 아이디입니다.");
			}
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 사용자 - 인터락 양식 생성 - 컨텐츠 정보 조회 - 채주정 (출장복명 2.0)
	 */
	@SuppressWarnings("unchecked")
	public ResultVO selectTripTradeInterlock(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			if (params.get("processId") == null) {
				throw new Exception("프로세스 아이디를 확인할 수 없습니다.");
			}
			if (params.get("processId").toString().indexOf("TRIPRES") > -1) {
				result.setAaData(list("TripUserReportA.selectResTradeInfo", params));
			} else {
				throw new Exception("알 수 없는 프로세스 아이디입니다.");
			}
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}
}

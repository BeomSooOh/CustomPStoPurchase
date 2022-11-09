package expend.trip.user.cons;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import common.helper.logger.CommonLogger;
import common.vo.common.ResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FTripUserConsServiceADAO" )
public class FTripUserConsServiceADAO extends EgovComAbstractDAO {

	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );

	/* 출장 품의 문서 신규 생성 */
	public ResultVO insertTripConsDoc ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			int consDocSeq = (int) insert( "TripUserConsA.insertTripConsDoc", params );
			if ( consDocSeq > 0 ) {
				Map<String, Object> temp = new HashMap<String, Object>( );
				temp.put( "tripConsDocSeq", consDocSeq );
				result.setaData( temp );
				result.setSuccess( );
			}
			else {
				result.setFail( "품의 문서가 저장되지 않았습니다." );
			}
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail( "출장 품의 문서 생성 실패", ex );
		}
		return result;
	}
	/* 출장 품의 출장자 정보 입력 */
	public ResultVO insertTripConsTraveler(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			insert( "TripUserConsA.insertTripConsTraveler", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail("출장자 정보 저장 실패",ex);
		}
		return result;
	}
	/* 출장 품의 경비 내역 정보 입력 */
	public ResultVO insertTripConsExpense(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			insert( "TripUserConsA.insertTripConsExpense", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail("경비 내역 정보 저장 실패",ex);
		}
		return result;
	}
	/* 출장 품의 예산 과목 정보 입력 */
	public ResultVO insertTripConsBudgetErp(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			insert( "TripUserConsA.insertTripConsBudgetErp", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail("예산 과목 정보 저장 실패",ex);
		}
		return result;
	}
	/* 출장 품의 예산 금액 정보 입력 */
	public ResultVO insertTripConsBudget(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			int tripBudetSeq= (int) insert( "TripUserConsA.insertTripConsBudget", params );
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
	/* 출장 품의 근태 정보 입력 */
	public ResultVO insertTripConsAttend(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			int attendSeq = (int) insert( "TripUserConsA.insertTripConsAttend", params );
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

	/* 출장 품의 문서 신규 갱신 */
	public ResultVO updateTripConsDoc ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			update( "TripUserConsA.updateTripConsDoc", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail( "출장 품의 문서 생성 실패", ex );
		}
		return result;
	}
	/* 출장 품의 출장자 정보 갱신 */
	public ResultVO updateTripConsTraveler(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			update( "TripUserConsA.updateTripConsTraveler", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail("출장자 정보 저장 실패",ex);
		}
		return result;
	}
	/* 출장 품의 경비 내역 정보 갱신 */
	public ResultVO updateTripConsExpense(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			update( "TripUserConsA.updateTripConsExpense", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail("경비 내역 정보 저장 실패",ex);
		}
		return result;
	}
	/* 출장 품의 예산 과목 정보 갱신 */
	public ResultVO updateTripConsBudgetErp(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			update( "TripUserConsA.updateTripConsBudgetErp", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail("예산 과목 정보 저장 실패",ex);
		}
		return result;
	}
	/* 출장 품의 예산 금액 정보 갱신 */
	public ResultVO updateTripConsBudget(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			update("TripUserConsA.updateTripConsBudget", params);
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail("예산 금액 정보 저장 실패",ex);
		}
		return result;
	}
	/* 출장 품의 근태 정보 갱신 */
	public ResultVO updateTripConsAttend(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			update("TripUserConsA.updateTripConsAttend", params);
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail("근태 정보 저장 실패",ex);
		}
		return result;
	}

	/* 품의 2.0 프로젝트 정보 조회 */
	public ResultVO selectConsMgtInfo ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData( list( "TripUserConsA.selectConsMgtInfo", params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail( "프로젝트 정보 조회 실패", ex );
		}
		return result;
	}

	/* 품의 2.0 예산 정보 조회 */
	public ResultVO selectConsBgtInfo ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData( list( "TripUserConsA.selectConsBgtInfo", params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail( "프로젝트 정보 조회 실패", ex );
		}
		return result;
	}

	/* 품의 2.0 품의 총 금액 */
	public ResultVO selectConsAmt ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			result.setaData( (Map<String, Object>) (list( "TripUserConsA.selectConsAmt", params ).get( 0 )) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail( "프로젝트 정보 조회 실패", ex );
		}
		return result;
	}

	/** 출장 품의 현황 조회 **/
	public ResultVO selectTripConsReport ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			ArrayList<Map<String, Object>> aaData = (ArrayList<Map<String, Object>>) list( "TripUserConsA.selectTripConsReport", params );
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

	/* 출장 품의 인사 정보 삭제 */
	public ResultVO deleteTripConsAttend(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			delete( "TripUserConsA.deleteTripConsAttend", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail("출장 품의 인사 정보 삭제 실패",ex);
		}
		return result;
	}
	/* 출장 품의 출장자 정보 삭제 */
	public ResultVO deleteTripConsTraveler(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			delete( "TripUserConsA.deleteTripConsTraveler", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail("출장 품의 출장자 정보 삭제 실패",ex);
		}
		return result;
	}
	/* 출장 품의 경비 내역 정보 삭제 */
	public ResultVO deleteTripConsExpense(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			delete( "TripUserConsA.deleteTripConsExpense", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail("출장 품의 경비 내역 삭제 실패",ex);
		}
		return result;
	}
	/* 출장 품의 예산 과목 정보 조회 */
	public ResultVO selectTripConsBudgetInfo(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData( list( "TripUserConsA.selectTripConsBudgetInfo", params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail( "프로젝트 정보 조회 실패", ex );
		}
		return result;
	}

	/* 출장 품의 예산 과목 정보 삭제 */
	public ResultVO deleteTripConsBudgetErpInfo(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			delete( "TripUserConsA.deleteTripConsBudgetInfo", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail("출장 품의 예산 과목 정보 삭제 실패",ex);
		}
		return result;
	}

	/* 출장 품의 예산 과목 정보 삭제 */
	public ResultVO deleteTripConsBudgetInfo(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			delete( "TripUserConsA.deleteTripConsBudgetErpInfo", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail("출장 품의 예산 과목 정보 삭제 실패",ex);
		}
		return result;
	}

	/* 출장 품의 문서 정보 조회 - 출장 정보 */
	public ResultVO selectTripConsDocInfoAttend(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData( list( "TripUserConsA.selectTripConsDocInfoAttend", params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail("출장정보 조회 실패",ex);
		}
		return result;
	}
	/* 출장 품의 문서 정보 조회 - 출장자 */
	public ResultVO selectTripConsDocInfoTripper(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData( list( "TripUserConsA.selectTripConsDocInfoTripper", params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail("출장자 정보 조회 실패",ex);
		}
		return result;
	}
	/* 출장 품의 문서 정보 조회 - 출장경비내역 */
	public ResultVO selectTripConsDocInfoAmt(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData( list( "TripUserConsA.selectTripConsDocInfoAmt", params ) );
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
			if (params.get("processId").toString().indexOf("TRIPCONS") > -1) {
				result.setAaData(list("TripUserReportA.selectConsHeadInfo", params));
			}
			else {
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
			if (params.get("processId").toString().indexOf("TRIPCONS") > -1) {
				result.setAaData(list("TripUserReportA.selectConsBudgetInfo", params));
			}
			else {
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
			if (params.get("processId").toString().indexOf("TRIPCONS") > -1) {
				result.setAaData(list("TripUserReportA.selectConsTradeInfo", params));
			}
			else {
				throw new Exception("알 수 없는 프로세스 아이디입니다.");
			}
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}
}

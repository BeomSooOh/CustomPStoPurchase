package expend.trip.user.option;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import common.vo.common.ResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository ( "FTripUserOptionServiceADAO" )
public class FTripUserOptionServiceADAO extends EgovComAbstractDAO {
	
	/**
	 * 출장복명 출장지 조회
	 * P : { compSeq, langCode  }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO TripLocationOptionSelect ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			
			List<Map<String, Object>> temp = list ( "TripUserOptionA.TripLocationOptionSelect", params );
			result.setAaData( temp );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}
	
	/**
	 * 출장복명 교통수단 조회
	 * P : { compSeq, langCode  }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO TripTransPortOptionSelect ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			List<Map<String, Object>> temp = list ( "TripUserOptionA.TripTransPortOptionSelect", params );
			result.setAaData( temp );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}
	
	
	/**
	 * 출장복명 출장지 조회
	 * P : { compSeq, langCode  }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO selectOptionLocation ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			List<Map<String, Object>> temp = list ( "TripUserOptionA.TripLocationOptionSelect", params );
			result.setAaData( temp );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}
	
	/**
	 * 출장복명 교통수단 조회
	 * P : { compSeq, langCode  }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO selectOptionTransport ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			List<Map<String, Object>> temp = list ( "TripUserOptionA.TripTransPortOptionSelect", params );
			result.setAaData( temp );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 출장복명 사용자 경비내역 조회
	 * P : { compSeq, transportSeq, locationSeq, empSeq  }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO selectOptionAmt ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			List<Map<String, Object>> temp = list ( "TripUserOptionA.TripAmtOptionSelect", params );
			result.setAaData( temp );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}

	public ResultVO selectOptionDutyItem(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			List<Map<String, Object>> temp = list ( "TripUserOptionA.TripDutyItemOptionSelect", params );
			result.setAaData( temp );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}
}
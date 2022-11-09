package expend.trip.user.option;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


@Service ( "FTripUserOptionServiceA" )
public class FTripUserOptionServiceAImpl implements FTripUserOptionService {

	/* 변수정의 */
	/* 변수정의 - DAO */
	@Resource ( name = "FTripUserOptionServiceADAO" )
	private FTripUserOptionServiceADAO dao;

	@Override
	public ResultVO selectLocationOption ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = dao.TripLocationOptionSelect( params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "DAO 호출 오류 발생", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectTransPortOption ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = dao.TripTransPortOptionSelect( params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "DAO 호출 오류 발생", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectOptionLocation ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = dao.selectOptionLocation( params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "DAO 호출 오류 발생", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectOptionTransport ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = dao.selectOptionTransport( params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "DAO 호출 오류 발생", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectOptionAmt ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = dao.selectOptionAmt( params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "DAO 호출 오류 발생", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectOptionDutyItem(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = dao.selectOptionDutyItem( params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "DAO 호출 오류 발생", ex );
		}
		return result;
	}
}

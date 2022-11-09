package expend.trip.user.cons;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

//import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ResultVO;


@Service ( "FTripUserConsServiceA" )
public class FTripUserConsServiceAImpl implements FTripUserConsService {

	@Resource ( name = "FTripUserConsServiceADAO" )
	private FTripUserConsServiceADAO dao;


	/** 출장 품의 문서 생성 **/
	@Override
	public ResultVO insertTripConsDoc ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = dao.insertTripConsDoc( params );
			result.setSuccess();
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}

	/** 출장 품의 문서 근태 정보 저장 **/
	@Override
	public ResultVO insertTripConsAttend ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = dao.insertTripConsAttend(params);
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}

	/** 출장 품의 문서 예산 정보 저장 **/
	@Override
	public ResultVO insertTripConsBudget ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = dao.insertTripConsBudget(params);
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}
	/** 출장 품의 문서 과목 정보 저장 **/
	@Override
	public ResultVO insertTripConsBudgetErp ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			dao.insertTripConsBudgetErp(params);
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}
	/** 출장 품의 문서 경비 내역 정보 저장 **/
	@Override
	public ResultVO insertTripConsExpense ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			dao.insertTripConsExpense(params);
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}
	/** 출장 품의 문서 출장자 정보 저장 **/
	@Override
	public ResultVO insertTripConsTraveler ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			dao.insertTripConsTraveler(params);
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}


	/** 출장 품의 문서 근태 정보 갱신 **/
	@Override
	public ResultVO updateTripConsAttend ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = dao.updateTripConsAttend(params);
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}

	/** 출장 품의 문서 예산 정보 갱신 **/
	@Override
	public ResultVO updateTripConsBudget ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = dao.updateTripConsBudget(params);
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}
	/** 출장 품의 문서 과목 정보 갱신 **/
	@Override
	public ResultVO updateTripConsBudgetErp ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			dao.updateTripConsBudgetErp(params);
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}
	/** 출장 품의 문서 경비 내역 정보 갱신 **/
	@Override
	public ResultVO updateTripConsExpense ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			dao.updateTripConsExpense(params);
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}
	/** 출장 품의 문서 출장자 정보 갱신 **/
	@Override
	public ResultVO updateTripConsTraveler ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			dao.updateTripConsTraveler(params);
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}

	/** 출장 품의 문서 경비 내역 정보 삭제 **/
	@Override
	public ResultVO deleteTripConsExpense(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			dao.deleteTripConsExpense(params);
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}
	/** 출장 품의 문서 출장자 정보 삭제 **/
	@Override
	public ResultVO deleteTripConsTraveler(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			dao.deleteTripConsTraveler(params);
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}
	/** 출장 품의 문서 인사 정보 삭제 **/
	@Override
	public ResultVO deleteTripConsAttend(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			dao.deleteTripConsAttend(params);
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}

	/** 비영리 2.0 품의문서 정보 조회 **/
	@Override
	public ResultVO selectConsDocInfo ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			HashMap<String, Object> aData = new HashMap<>( );
			/* 품의 프로젝트 정보 조회 */
			ResultVO mgtDataVO = dao.selectConsMgtInfo( params );
			if ( mgtDataVO.getResultCode( ).equals( commonCode.FAIL ) ) {
				return mgtDataVO;
			}
			else {
				aData.put( "mgtData", mgtDataVO.getAaData( ) );
			}
			/* 품의 예산 정보 조회 */
			ResultVO bgtDataVO = dao.selectConsBgtInfo( params );
			if ( bgtDataVO.getResultCode( ).equals( commonCode.FAIL ) ) {
				return bgtDataVO;
			}
			else {
				aData.put( "bgtData", bgtDataVO.getAaData( ) );
			}
			/* 품의 금액 조회 */
			ResultVO consAmtVO = dao.selectConsAmt( params );
			if ( consAmtVO.getResultCode( ).equals( commonCode.FAIL ) ) {
				return consAmtVO;
			}
			else {
				aData.put( "consAmt", consAmtVO.getaData( ).get( "consAmt" ) );
			}
			result.setaData( aData );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "품의 문서 정보조회 실패", ex );
			ex.printStackTrace();
		}
		return result;
	}

	/** 출장 품의 내용 전체 조회 **/
	@Override
	public ResultVO selectTripConsDocAllInfo ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			Map<String, Object> resultAData = new HashMap<>( );

			ResultVO attendResult = dao.selectTripConsDocInfoAttend( params );
			if(attendResult.getResultCode( ).equals( commonCode.SUCCESS )){
				resultAData.put( "attendResult", attendResult.getAaData( ) );
			}else{
				throw new Exception(" 출장품의 출장정보 조회 실패 ");
			}

			ResultVO travelerResult = dao.selectTripConsDocInfoTripper( params );
			if(travelerResult.getResultCode( ).equals( commonCode.SUCCESS )){
				resultAData.put( "travelerResult", travelerResult.getAaData( ) );
			}else{
				throw new Exception(" 출장품의 출장자 조회 실패 ");
			}

			ResultVO amtResult = dao.selectTripConsDocInfoAmt( params );
			if(amtResult.getResultCode( ).equals( commonCode.SUCCESS )){
				resultAData.put( "amtResult", amtResult.getAaData( ) );
			}else{
				throw new Exception(" 출장품의 경비내역 조회 실패 ");
			}

			ResultVO consResult = this.selectConsDocInfo( params );
			if(consResult.getResultCode( ).equals( commonCode.SUCCESS )){
				resultAData.put( "consResult", consResult.getaData() ) ;
			}else{
				throw new Exception(" 품의 정보 조회 실패 ");
			}
			result.setaData( resultAData );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}

	/** 출장 품의 현황 조회 **/
	@Override
	public ResultVO selectTripConsReport ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = dao.selectTripConsReport( params );
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}
	/** 출장 품의 예산 정보 조회 **/
	@Override
	public ResultVO selectConsBudgetInfo(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = dao.selectTripConsBudgetInfo( params );
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 조회 중 오류 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}
	/** 출장 품의 예산 정보 삭제 **/
	@Override
	public ResultVO deleteTripConsBudgetInfo(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			dao.deleteTripConsBudgetInfo(params);
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}
	/** 출장 품의 예산 정보 삭제 **/
	@Override
	public ResultVO deleteTripConsBudgetErpInfo(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			dao.deleteTripConsBudgetErpInfo(params);
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}




}

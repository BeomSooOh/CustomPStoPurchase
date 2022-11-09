package expend.trip.user.res;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ResultVO;


@Service ( "FTripUserResServiceA" )
public class FTripUserResServiceAImpl implements FTripUserResService {

	@Resource ( name = "FTripUserResServiceADAO" )
	private FTripUserResServiceADAO dao;

	/** 출장 품의 문서 생성 **/
	@Override
	public ResultVO insertTripResDoc ( Map<String, Object> params ) throws Exception {
		return dao.insertTripResDoc( params );
	}

	/** 비영리 2.0 결의문서 정보 조회 **/
	@Override
	public ResultVO selectResDocInfo ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			HashMap<String, Object> aData = new HashMap<>( );
			/* 품의 프로젝트 정보 조회 */
			ResultVO mgtDataVO = dao.selectResMgtInfo( params );
			if ( mgtDataVO.getResultCode( ).equals( commonCode.FAIL ) ) {
				return mgtDataVO;
			}
			else {
				aData.put( "mgtData", mgtDataVO.getAaData( ) );
			}
			/* 품의 예산 정보 조회 */
			ResultVO bgtDataVO = dao.selectResBgtInfo( params );
			if ( bgtDataVO.getResultCode( ).equals( commonCode.FAIL ) ) {
				return bgtDataVO;
			}
			else {
				aData.put( "bgtData", bgtDataVO.getAaData( ) );
			}
			/* 품의 금액 조회 */
			ResultVO resAmtVO = dao.selectResAmt( params );
			if ( resAmtVO.getResultCode( ).equals( commonCode.FAIL ) ) {
				return resAmtVO;
			}
			else {
				aData.put( "resAmt", resAmtVO.getaData( ).get( "resAmt" ) );
			}
			result.setaData( aData );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "품의 문서 정보조회 실패", ex );
		}
		return result;
	}

	/** 출장 결의 내용 전체 조회 **/
	@Override
	public ResultVO selectTripResDocAllInfo ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			Map<String, Object> resultAData = new HashMap<>( );

			ResultVO resDocResult = dao.selectTripResDocInfoResDoc(params);
			if(resDocResult.getResultCode( ).equals( commonCode.SUCCESS )){
				resultAData.put( "resDocResult", resDocResult.getAaData( ) );
			}else{
				throw new Exception(" 출장결의 출장 결의서 정보 조회 실패 ");
			}
			
			ResultVO attendResult = dao.selectTripResDocInfoAttend( params );
			if(attendResult.getResultCode( ).equals( commonCode.SUCCESS )){
				resultAData.put( "attendResult", attendResult.getAaData( ) );
			}else{
				throw new Exception(" 출장결의 출장정보 조회 실패 ");
			}
			
			ResultVO travelerResult = dao.selectTripResDocInfoTripper( params );
			if(travelerResult.getResultCode( ).equals( commonCode.SUCCESS )){
				resultAData.put( "travelerResult", travelerResult.getAaData( ) );
			}else{
				throw new Exception(" 출장결의 출장자 조회 실패 ");
			}
			
			ResultVO amtResult = dao.selectTripResDocInfoAmt( params );
			if(amtResult.getResultCode( ).equals( commonCode.SUCCESS )){
				resultAData.put( "amtResult", amtResult.getAaData( ) );
			}else{
				throw new Exception(" 출장결의 경비내역 조회 실패 ");
			}
			
			ResultVO resResult = this.selectResDocInfo( params );
			if(resResult.getResultCode( ).equals( commonCode.SUCCESS )){
				resultAData.put( "resResult", resResult.getaData() ) ;
				Map<String, Object> budgetResult = (Map<String, Object>)resResult.getaData( ); 
				resultAData.put( "budgetResult", budgetResult.get( "bgtData" ) );
				resultAData.put( "resAmt", CommonConvert.NullToString(  budgetResult.get( "resAmt" ) ) );
				resultAData.put( "mgtResult", budgetResult.get( "mgtData" ) );
			}else{
				throw new Exception(" 결의 정보 조회 실패 ");
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
	
	@Override
	public ResultVO insertTripRes ( Map<String, Object> params ) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	/** 출장 결의 현황 조회 **/
	@Override
	public ResultVO selectTripResReport ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = dao.selectTripResReport( params );
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
		}
		return result;
	}
	
	/** 사용자 참조품의 리스트 조회 **/
	@Override
	public ResultVO selectConfferList ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = dao.selectConfferList( params );
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
		}
		return result;
	}
	

	/** 사용자 참조품의 정보 반영 **/
	@Override
	public ResultVO updateTripConfferCons ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			/* 1. 출장결의서 참조품의 정보 반영 */
			ResultVO docResult = dao.updateConfferInfoDoc( params );
			if(!docResult.getResultCode( ).equals( commonCode.SUCCESS )){
				return docResult; 
			}
			
			/* 2. 출장결의서 참조품의 출장 정보 */
			ResultVO attendResult = dao.insertConfferInfoAttend( params );
			if(!attendResult.getResultCode( ).equals( commonCode.SUCCESS )){
				return attendResult;
			}
			String attendSeq = CommonConvert.NullToString( attendResult.getaData( ).get( "attendSeq" ) );
			params.put( "attendSeq", attendSeq );
			
			/* 3. 출장결의서 참조품의 금액 정보 */
			ResultVO expenseResult = dao.insertConfferInfoExpense( params );
			if(!expenseResult.getResultCode( ).equals( commonCode.SUCCESS )){
				return expenseResult;
			}
			
			/* 4. 출장결의서 참조품의 출장자 정보 */
			ResultVO travelerResult = dao.insertConfferInfoTraveler( params );
			if(!travelerResult.getResultCode( ).equals( commonCode.SUCCESS )){
				return travelerResult;
			}
			
			
			ResultVO resAttendList = dao.selectTripAttendInfo( params );
			if(!resAttendList.getResultCode( ).equals( commonCode.SUCCESS )){
				return resAttendList;
			}
			ResultVO resExpenseList = dao.selectTripExpenseInfo( params );
			if(!resExpenseList.getResultCode( ).equals( commonCode.SUCCESS )){
				return resExpenseList;
			}
			ResultVO restravelerList = dao.selectTripTravelerInfo( params );
			if(!restravelerList.getResultCode( ).equals( commonCode.SUCCESS )){
				return restravelerList;
			}
			ResultVO budgetList = dao.selectTripBudgetInfo( params );
			if(!budgetList.getResultCode( ).equals( commonCode.SUCCESS )){
				return budgetList;
			}
			ResultVO mgtList = dao.selectTripMgtInfo( params );
			if(!mgtList.getResultCode( ).equals( commonCode.SUCCESS )){
				return mgtList;
			}
			
			Map<String, Object> resDocAllInfo = new HashMap<>( );
			resDocAllInfo.put( "attendResult", resAttendList.getAaData( ) );
			resDocAllInfo.put( "amtResult", resExpenseList.getAaData( ) );
			resDocAllInfo.put( "travelerResult", restravelerList.getAaData( ) );
			resDocAllInfo.put( "budgetResult", budgetList.getAaData( ) );
			resDocAllInfo.put( "mgtResult", mgtList.getAaData( ) );
			
			ResultVO consResult = this.selectResDocInfo( params );
			if(consResult.getResultCode( ).equals( commonCode.SUCCESS )){
				resDocAllInfo.put( "consResult", consResult.getaData() ) ;
			}else{
				throw new Exception(" 결의 정보 조회 실패 ");
			}
			
			result.setaData( resDocAllInfo );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
		}
		return result;
	}

	@Override
	public ResultVO insertTripResAttend(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			result = dao.insertTripResAttend(params);
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}

	@Override
	public ResultVO insertTripResTraveler(HashMap<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			dao.insertTripResTraveler(params);
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}

	@Override
	public ResultVO insertTripResExpense(HashMap<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			dao.insertTripResExpense(params);
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}

	@Override
	public ResultVO deleteTripResAttend(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			dao.deleteTripResAttend(params);
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}

	@Override
	public ResultVO deleteTripResExpense(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			dao.deleteTripResExpense(params);
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}

	@Override
	public ResultVO deleteTripResTraveler(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			dao.deleteTripResTraveler(params);
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}

	@Override
	public ResultVO insertTripResBudget(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			result = dao.insertTripResBudget(params);
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}

	@Override
	public ResultVO selectResBudgetInfo(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			result = dao.selectTripResBudgetInfo( params );
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 조회 중 오류 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}

	@Override
	public ResultVO insertTripResBudgetErp(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			dao.insertTripResBudgetErp(params);
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}

	@Override
	public ResultVO deleteTripResBudgetInfo(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			dao.deleteTripResBudgetInfo(params);
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}

	@Override
	public ResultVO deleteTripResBudgetErpInfo(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			dao.deleteTripResBudgetErpInfo(params);
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
			ex.printStackTrace();
		}
		return result;
	}
}

package expend.trip.admin.report;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.vo.common.ResultVO;


@Service ( "BTripAdminConsService" )
public class BTripAdminReportServiceImpl implements BTripAdminReportService {

	@Resource ( name = "FTripAdminReportServiceA" )
	private FTripAdminReportService reportA; /* Bizbox Alpha */

	/** 비영리 2.0 품의 문서 정보 조회 */
	@Override
	public ResultVO selectReportDocInfo ( Map<String, Object> params ) throws Exception {
		String isCons = params.get( "isCons" ).toString( );
		if ( isCons.equals( "cons" ) ) {
			return reportA.selectConsDocInfo( params );
		}
		else {
			return reportA.selectResDocInfo( params );
		}
	}

	/** 관리자 출장 품의 현황 정보 조회 **/
	@Override
	public ResultVO selectTripConsReport ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try{
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			params.put( "empSeq", loginVo.getUniqId( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			result = reportA.selectTripConsReport( params );
		}catch(Exception ex){
			result.setFail( "사용자 로그인 세션 확인 실패",  ex );
		}
		return result;
	}

	/** 관리자 출장 결의 현황 정보 조회 **/
	@Override
	public ResultVO selectTripResReport ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try{
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			params.put( "empSeq", loginVo.getUniqId( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			result = reportA.selectTripResReport( params );
		}catch(Exception ex){
			result.setFail( "사용자 로그인 세션 확인 실패",  ex );
		}
		return result;		
	}

	/** 관리자 출장 품의 문서 삭제 **/
	@Override
	public ResultVO deleteTripConsDoc ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try{
			result = reportA.deleteTripConsDoc( params );
		}catch(Exception ex){
			result.setFail( "사용자 로그인 세션 확인 실패",  ex );
		}
		return result;	
	}

	/** 관리자 출장 결의 문서 삭제 **/
	@Override
	public ResultVO deleteTripResDoc ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try{
			result = reportA.deleteTripResDoc( params );
		}catch(Exception ex){
			result.setFail( "사용자 로그인 세션 확인 실패",  ex );
		}
		return result;	
	}
}

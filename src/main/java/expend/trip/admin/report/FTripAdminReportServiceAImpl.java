package expend.trip.admin.report;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.vo.common.ResultVO;
import interlock.exp.approval.FApprovalServiceADAO;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


@Service ( "FTripAdminReportServiceA" )
public class FTripAdminReportServiceAImpl implements FTripAdminReportService {

	@Resource ( name = "FTripAdminReportServiceADAO" )
	private FTripAdminReportServiceADAO dao;
	@Resource(name = "FApprovalServiceADAO")
	private FApprovalServiceADAO daoApproval;

	/** 비영리 2.0 품의문서 정보 조회 **/
	@Override
	public ResultVO selectConsDocInfo ( Map<String, Object> params ) throws Exception {
		return null;
	}

	@Override
	public ResultVO selectResDocInfo ( Map<String, Object> params ) throws Exception {
		// TODO Auto-generated method stub
		return null;
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
		}
		return result;
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

	/** 관리자 출장 품의 문서 삭제 **/
	@Override
	public ResultVO deleteTripConsDoc ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try{
			String requestDomain = CommonConvert.NullToString( params.get( "requestDomain" ) );
			String tripConsDocSeqs = CommonConvert.NullToString( params.get( "tripConsDocSeqs" ) );
			String tripConsDocSeq[] = tripConsDocSeqs.replace( "(", "").replace( ")", "" ).split( "," );

			for(int i=0; i < tripConsDocSeq.length; i++){
				params.put( "tripConsDocSeq", tripConsDocSeq[i] );
				ResultVO apiInfo = daoApproval.ConsDocAPIInfoSelect( params );
				apiInfo.getAaData( ).get( 0 ).put( "requestDomain", requestDomain );
				callAttendAPI( apiInfo );
				callCalendarDeleteAPI(apiInfo);
			}

			result = dao.deleteTripConsDoc( params );
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
			String requestDomain = CommonConvert.NullToString( params.get( "requestDomain" ) );
			String tripResDocSeqs = CommonConvert.NullToString( params.get( "tripResDocSeqs" ) );
			String tripResDocSeq[] = tripResDocSeqs.replaceAll("[^0-9^,]","").split(",");

			for(int i=0; i < tripResDocSeq.length; i++){
				params.put( "tripResDocSeq", tripResDocSeq[i] );
				ResultVO apiInfo = daoApproval.ResDocAPIInfoSelect( params );
				apiInfo.getAaData( ).get( 0 ).put( "requestDomain", requestDomain );
				callAttendAPI( apiInfo );
				callCalendarDeleteAPI(apiInfo);
			}

			result = dao.deleteTripResDoc( params );
		}catch(Exception ex){
			result.setFail( "사용자 로그인 세션 확인 실패",  ex );
		}
		return result;
	}

	/** 일정 연동 API호출 */
	private ResultVO callCalendarDeleteAPI(ResultVO param){
		/* 기본 조회 데이터 확인 */
		List<Map<String, Object>> aaData = param.getAaData( );
		Map<String, Object> item = aaData.get( 0 );
		JSONObject apiParam = new JSONObject();

		/*--------------  headerParam  --------------*/
		JSONObject headerParam = new JSONObject();
		headerParam.put("pId", "");
		headerParam.put("groupSeq", CommonConvert.NullToString(item.get( "groupSeq" )) );
		headerParam.put("tId", "");
		headerParam.put("empSeq", CommonConvert.NullToString(item.get( "reqEmpSeq" )));


		/*--------------  bodyParam - companyInfo --------------*/
		JSONObject companyParam = new JSONObject();
		companyParam.put("compSeq", CommonConvert.NullToString(item.get( "compSeq" )) );
		companyParam.put("bizSeq", "");
		companyParam.put("deptSeq", CommonConvert.NullToString(item.get( "deptSeq" )) );
		companyParam.put("emailAddr", "");
		companyParam.put("emailDomain", "");


		/*--------------  bodyParam - schUserList --------------*/
		JSONArray schUserList = new JSONArray( );
		for( Map<String, Object> scu : aaData ){
			JSONObject schUserItem = new JSONObject();
			schUserItem.put( "userType", "10");
			schUserItem.put( "orgType", "E");
			schUserItem.put( "compSeq", CommonConvert.NullToString( scu.get( "B_compSeq" ) ) );
			schUserItem.put( "orgSeq", CommonConvert.NullToString(scu.get( "B_empSeq" ) ) );
			schUserItem.put( "deptSeq", CommonConvert.NullToString(scu.get( "B_deptSeq" ) ) );
			schUserList.add( schUserItem );
		}

		/*--------------  bodyParam --------------*/
		JSONObject bodyParam = new JSONObject();
		bodyParam.put("empSeq", CommonConvert.NullToString(item.get("reqEmpSeq")) );
		bodyParam.put("schmSeq", CommonConvert.NullToString(item.get("C_schmSeq")) );
		bodyParam.put("schSeq", CommonConvert.NullToString(item.get("C_schSeq")) );
		bodyParam.put("useYn", "N");
		bodyParam.put("companyInfo", companyParam);

		/*--------------  set API param --------------*/
		apiParam.put("header", headerParam);
		apiParam.put("body", bodyParam);

		String scheduleUrl = item.get("requestDomain").toString( ) + "/schedule/MobileSchedule/UpdateAttendScheduleYn";
		JSONObject jsonResult = getPostJSON(scheduleUrl, apiParam.toString());
		return null;
	}

	/** 인사/근태 연동 API호출 */
	private ResultVO callAttendAPI(ResultVO param){
		List<Map<String, Object>> aaData = param.getAaData( );
		JSONArray eaAttReqList = new JSONArray( );
		JSONObject parameter = new JSONObject();
		for( Map<String, Object> item : aaData ){
			JSONObject eaAttReqItem = new JSONObject();
			eaAttReqItem.put( "deptSeq", CommonConvert.NullToString( item.get( "B_deptSeq" ) ) );
			eaAttReqItem.put( "empSeq", CommonConvert.NullToString( item.get( "B_empSeq" ) ) );
			eaAttReqItem.put( "attDivCode", CommonConvert.NullToString( item.get( "B_attDivCode" ) ) );
			eaAttReqItem.put( "attDate", CommonConvert.NullToString( item.get( "B_attDate" ) ) );
			eaAttReqItem.put( "reqStartDt", CommonConvert.NullToString( item.get( "B_reqStartDt" ) ) );
			eaAttReqItem.put( "reqEndDt", CommonConvert.NullToString( item.get( "B_reqEndDt" ) ) );
			eaAttReqItem.put( "dayCnt", CommonConvert.NullToString( item.get( "B_dayCnt" ) ) );
			eaAttReqItem.put( "reqRemark", CommonConvert.NullToString( item.get( "reqTitle" ) ) );
			eaAttReqItem.put( "fieldOffice", CommonConvert.NullToString( item.get( "B_fieldOffice" ) ) );
			eaAttReqItem.put( "attTime", CommonConvert.NullToString( item.get( "B_attTime" ) ) );
			eaAttReqItem.put( "transport", CommonConvert.NullToString( item.get( "B_transport" ) ) );
			eaAttReqItem.put( "officialTripPurpose", CommonConvert.NullToString( item.get( "B_officialTripPurpose" ) ) );
			eaAttReqList.add( eaAttReqItem );
		}
		Map<String, Object> item = aaData.get( 0 );
		parameter.put( "compSeq",  CommonConvert.NullToString(item.get( "compSeq" )) );
		parameter.put( "groupSeq", CommonConvert.NullToString(item.get( "groupSeq" )) );
		parameter.put( "reqDate", CommonConvert.NullToString(item.get( "reqDate" )) );
		parameter.put( "reqEmpSeq", CommonConvert.NullToString(item.get( "reqEmpSeq" )) );
		parameter.put( "approKey", CommonConvert.NullToString(item.get( "approKey" )) );
		parameter.put( "docSts", "d" );
		parameter.put( "reqEmpDeptSeq", CommonConvert.NullToString(item.get( "deptSeq" )) );
		parameter.put( "docId", CommonConvert.NullToString(item.get( "docSeq" )) );
		parameter.put( "reqTitle", CommonConvert.NullToString(item.get( "reqTitle" )) );
		parameter.put( "eaAttReqList", eaAttReqList );

		String scheduleUrl = item.get("requestDomain").toString( ) + "/attend/custom/api/attend/businessTripUpdateAtt";
		JSONObject indiData = getPostJSON(scheduleUrl, parameter.toString());

		return null;
	}

	public static JSONObject getPostJSON(String url, String data) {
		StringBuilder sbBuf = new StringBuilder();
		HttpURLConnection con = null;
		BufferedReader brIn = null;
		OutputStreamWriter wr = null;
		String line = null;
		try {
			con = (HttpURLConnection) new URL(url).openConnection();
			con.setRequestMethod("POST");
			con.setConnectTimeout(5000);
			con.setRequestProperty("Content-Type", "application/json;charset=UTF-8");
			con.setDoOutput(true);
			con.setDoInput(true);

			wr = new OutputStreamWriter(con.getOutputStream());
			wr.write(data);
			wr.flush();
			brIn = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
			while ((line = brIn.readLine()) != null) {
				sbBuf.append(line);
			}
			// System.out.println(sbBuf);

			JSONObject rtn = JSONObject.fromObject(sbBuf.toString());

			sbBuf = null;

			return rtn;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				wr.close();
			} catch (Exception e) {
				// do nothing
			}
			try {
				brIn.close();
			} catch (Exception e) {
				// do nothing
			}
			try {
				con.disconnect();
			} catch (Exception e) {
				// do nothing
			}
		}
	}
}

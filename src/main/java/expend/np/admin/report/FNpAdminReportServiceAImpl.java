package expend.np.admin.report;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.vo.common.CommonInterface.commonCode;
import expend.np.user.option.BNpUserOptionService;
//import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


@Service ( "FNpAdminReportServiceA" )
public class FNpAdminReportServiceAImpl implements FNpAdminReportService {

	/* 변수정의 */
	/* 변수정의 - DAO */
	@Resource ( name = "FNpAdminReportServiceADAO" )
	private FNpAdminReportServiceADAO dao;
	@Resource ( name = "BNpUserOptionService" )
	private BNpUserOptionService serviceOption; /* Expend Service */
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo;
	@Resource ( name = "FNpAdminReportServiceIDAO" )
	private FNpAdminReportServiceIDAO daoI;
	
	/* 환원 처리 및 취소 */
	public ResultVO updateConfferReturnYN ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		dao.updateConfferReturnYN( params );
		return result;
	}

	/* 품의현황 조회 */
	public ResultVO selectConsReport ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData( dao.selectConsReport( params ) );
			result.setSuccess( );
		}
		catch ( Exception e ) {
			result.setFail( "품의 현황 조회에 실패하였습니다", e );
		}
		return result;
	}

	/* 결의현황 조회 */
	@Override
	public ResultVO selectResReport ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData( dao.selectResReport( params ) );
			result.setSuccess( );
		}
		catch ( Exception e ) {
			result.setFail( "결의 현황 조회에 실패하였습니다.", e );
		}
		return result;
	}

	/**
	 * 참조결의서 리스트 조회
	 */
	@Override
	public ResultVO selectConsConfferResList ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = dao.selectConsConfferResList( params );
		}
		catch ( Exception ex ) {
			result.setFail( "품의서 반환/취소 실패", ex );
		}
		return result;
	}

	/**
	 * 품의서 예산내역 조회
	 */
	@Override
	public ResultVO selectConsBudgetList ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			ResultVO headResult = dao.selectConsBudgetListHead( params );
			ResultVO listResult = dao.selectConsBudgetList( params );
			if ( CommonConvert.CommonGetStr(headResult.getResultCode( )).equals( commonCode.FAIL ) ) {
				return headResult;
			}
			else if ( CommonConvert.CommonGetStr(listResult.getResultCode( )).equals( commonCode.FAIL ) ) {
				return listResult;
			}
			result.setaData( headResult.getaData( ) );
			result.setAaData( listResult.getAaData( ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "품의 예산내역 조회 실패", ex );
		}
		return result;
	}

	@Override
	public ResultVO updateConfferStatus ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = dao.NpUserConsConfferStatusUpdate( params );
		}
		catch ( Exception ex ) {
			result.setFail( "품의서 반환/취소 실패", ex );
		}
		return result;
	}

	@Override
	public ResultVO updateConfferBudgetStatus ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = dao.NpUserConsConfferBudgetStatusUpdate( params );
		}
		catch ( Exception ex ) {
			result.setFail( "품의서 반환/취소 실패", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectSendList ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			/* 파라미터 널처리 진행 */
			/* TODO:상배 */
			if ( CommonConvert.CommonGetEmpVO( ).getEaType( ).equals( commonCode.EA ) ) {
				result.setAaData( dao.selectSendEaList( params ) );
			}
			else {
				result.setAaData( dao.selectSendEapList( params ) );
			}
			result.setSuccess( );
		}
		catch ( Exception e ) {
			result.setFail( "결의 전송리스트 조회에 실패하였습니다.", e );
		}
		return result;
	}

	@Override
	public ResultVO deleteRes ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		
		result = dao.deleteRes( params );
		if(params.get("eaType").equals("ea")) {
			eaDocDeleteCountAPI(params);	
		}
		
		if(result.getResultCode( ).equals( commonCode.FAIL )){
			return result;
		}else{
			if(conVo.getErpTypeCode( ).equals( commonCode.ICUBE )){
				/*	[1.] G20 법인카드 승인내역( ACARD_SUNGIN ) 데이터 보정 / 결의서 삭제 */
				ResultVO sendCardResult = dao.selectG20CardSendList(params);
				LoginVO loginVo = CommonConvert.CommonGetEmpVO();
				if(sendCardResult.getResultCode( ).equals( commonCode.SUCCESS )){
					for(Map<String, Object> item : sendCardResult.getAaData( )){
						item.put("erpCompSeq", loginVo.getErpCoCd());
						daoI.updateG20DeleteCardList( item, conVo );
					}
				}else{
					throw new Exception( "결의서 전송은 성공하였으나, 법인카드 승인내역 상태 연동에 실패하였습니다." );
				}	
			}
		}
		return result;
	}
	
	@Override
	public ResultVO insertResSend ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		result.setFail( "ERP 연동 로직으로 GW 사용불가능." );
		return result;
	}

	@Override
	public ResultVO deleteResSendCancel ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		result.setFail( "ERP 연동 로직으로 GW 사용불가능." );
		return result;
	}

	public List<Map<String, Object>> selectCardReport ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = dao.selectCardReport( params );
		return result;
	}

	public ResultVO updateSendYN ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		result = dao.updateSendYN( params );
		return result;
	}

	/**
	 * 관리자 - 매입전자세금계산서 리스트 조회
	 */
	public List<Map<String, Object>> NPAdminEtaxReportList ( ResultVO param, ConnectionVO conVo ) throws Exception {
		/* 매입 전자 세금계산서 조회 */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = dao.NPAdminGWEtaxInfoSelect( param );
		return result;
	}

	/**
	 * 관리자 - 세금계산서현황 - 세금계산서 사용/미사용처리
	 */
	public ResultVO NPAdminETaxSetUseYN ( ResultVO param ) throws Exception {
		dao.NPAminETaxSetUseYN( param );
		return param;
	}

	@Override
	public ResultVO NPAdminYesilList ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO NPAdminMgtList ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO NPAdminERPiUConsAmtList ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			/* 1. 품의서 리스트 조회 aaData */
			ResultVO listResult = dao.selectERPiUYesilConsAmtList( params );
			if ( CommonConvert.CommonGetStr(listResult.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setAaData( listResult.getAaData( ) );
			}
			else {
				throw new Exception( "품의서 리스트 조회 중 오류 발생." );
			}
			/* 2. 품의서 예산 통계 조회 aData */
			ResultVO budgetResult = dao.selectERPiUYesilConsBudgetInfo( params );
			if ( CommonConvert.CommonGetStr(budgetResult.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setaData( budgetResult.getaData( ) );
			}
			else {
				throw new Exception( result.getResultName( ) );
			}
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "예실대비 현황 조회 중 오류가 발생하였습니다.", ex );
		}
		return result;
	}
	
	@Override
	public ResultVO NPAdminConsAmtList ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			/* 1. 품의서 리스트 조회 aaData */
			ResultVO listResult = dao.selectYesilConsAmtList( params );
			if ( CommonConvert.CommonGetStr(listResult.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setAaData( listResult.getAaData( ) );
			}
			else {
				throw new Exception( "품의서 리스트 조회 중 오류 발생." );
			}
			/* 2. 품의서 예산 통계 조회 aData */
			ResultVO budgetResult = dao.selectYesilConsBudgetInfo( params );
			if ( CommonConvert.CommonGetStr(budgetResult.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setaData( budgetResult.getaData( ) );
			}
			else {
				throw new Exception( result.getResultName( ) );
			}
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "예실대비 현황 조회 중 오류가 발생하였습니다.", ex );
		}
		return result;
	}

	@Override
	public ResultVO NPAdminERPiUResAmtList ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			/* 1. 결의서 리스트 조회 aaData */
			ResultVO listResult = dao.selectERPiUYesilResAmtList( params );
			if ( CommonConvert.CommonGetStr(listResult.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setAaData( listResult.getAaData( ) );
			}
			else {
				throw new Exception( "결의서 리스트 조회 중 오류 발생." );
			}
			/* 2. 결의서 예산 통계 조회 aData */
			ResultVO budgetResult = dao.selectERPiUYesilResBudgetInfo( params );
			if ( CommonConvert.CommonGetStr(budgetResult.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setaData( budgetResult.getaData( ) );
			}
			else {
				throw new Exception( result.getResultName( ) );
			}
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "예실대비 현황 조회 중 오류가 발생하였습니다.", ex );
		}
		return result;
	}
	
	@Override
	public ResultVO NPAdminResAmtList ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			/* 1. 결의서 리스트 조회 aaData */
			ResultVO listResult = dao.selectYesilResAmtList( params );
			if ( CommonConvert.CommonGetStr(listResult.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setAaData( listResult.getAaData( ) );
			}
			else {
				throw new Exception( "결의서 리스트 조회 중 오류 발생." );
			}
			/* 2. 결의서 예산 통계 조회 aData */
			ResultVO budgetResult = dao.selectYesilResBudgetInfo( params );
			if ( CommonConvert.CommonGetStr(budgetResult.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setaData( budgetResult.getaData( ) );
			}
			else {
				throw new Exception( result.getResultName( ) );
			}
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "예실대비 현황 조회 중 오류가 발생하였습니다.", ex );
		}
		return result;
	}
	

	@Override
	public ResultVO NPAdminERPResAmtList ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			/* 1. 결의서 리스트 조회 aaData */
			result = dao.selectYesilERPResAmtList( params );
		}
		catch ( Exception ex ) {
			result.setFail( "예실대비 현황 조회 중 오류가 발생하였습니다.", ex );
		}
		return result;
	}
	
	/** 전자결재 비영리 테이블 카운트갱신 API호출 */
	private ResultVO eaDocDeleteCountAPI(Map<String, Object> params){
		/* 기본 조회 데이터 확인 */
		JSONObject apiParam = new JSONObject();
		
		/*--------------  headerParam  --------------*/
		JSONObject headerParam = new JSONObject();
		headerParam.put("groupSeq", CommonConvert.NullToString(params.get( "groupSeq" )) );
		
		String docSeqs = params.get("docSeqs").toString();
		docSeqs = docSeqs.replace("(", "");
		docSeqs = docSeqs.replace(")", "");
		docSeqs = docSeqs.replaceAll("'", "");
		String[] docSeqList = docSeqs.split(",");
		
		for(int i=0; i<docSeqList.length ; i++) {
			/*--------------  set API param --------------*/
			headerParam.put("diKeyCode", CommonConvert.NullToString(docSeqList[i]) );
			apiParam.put("header", headerParam);
			
			String scheduleUrl = params.get("requestDomain").toString( ) + "/ea/box/setBoxDocInit.do";
			JSONObject jsonResult = getPostJSON(scheduleUrl, apiParam.toString());	
		}
		
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
			con.setRequestMethod("GET");
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
				e.printStackTrace();
			}
			try {
				brIn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				con.disconnect();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	@Override
	public ResultVO deleteConsDoc(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO( );
		
		try {
			result = dao.deleteCons( params );
			if(params.get("eaType").equals("ea")) {
				eaDocDeleteCountAPI(params);	
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
}
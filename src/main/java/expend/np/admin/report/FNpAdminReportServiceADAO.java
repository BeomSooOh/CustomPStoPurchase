package expend.np.admin.report;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FNpAdminReportServiceADAO" )
public class FNpAdminReportServiceADAO extends EgovComAbstractDAO {

	/**
	 * test
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO test ( Map<String, Object> params ) throws Exception {
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
	 * 참조결의서 리스트 조회
	 * updateConfferReturnYN
	 * P : { selectConsReport }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO selectConsConfferResList ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		
		
		try {
			if (loginVo.getEaType().equals("ea")) {
				result.setAaData( (List<Map<String, Object>>) list( "NpAdminReportA.selectConsConfferResListEA", params ) );
			} else if (loginVo.getEaType().equals("eap")) {
				result.setAaData( (List<Map<String, Object>>) list( "NpAdminReportA.selectConsConfferResListEAP", params ) );
			} else {
				throw new Exception("전자결재 구분을 확인할 수 없습니다.");
			}
			
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 품의서 예산내역 헤더 정보 조회
	 * updateConfferReturnYN
	 * P : { selectConsReport }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO selectConsBudgetListHead ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			List<Map<String, Object>> dbResult = (List<Map<String, Object>>) list( "NpAdminReportA.consBudgetListHead", params );
			if ( dbResult.size( ) != 1 ) {
				throw new Exception( "헤더 조회 실패 / DB 조회 예측 오차" );
			}
			result.setaData( dbResult.get( 0 ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 품의서 예산내역 리스트 조회
	 * updateConfferReturnYN
	 * P : { selectConsReport }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO selectConsBudgetList ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData( (List<Map<String, Object>>) list( "NpAdminReportA.consBudgetList", params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 품의서 환원 처리
	 * updateConfferReturnYN
	 * P : { selectConsReport }
	 * return ResultVO with aaData
	 */
	public ResultVO updateConfferReturnYN ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			update( "NpAdminReportA.updateConfferReturnYN", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 품의 현황 조회
	 * selectConsReport
	 * P : { }
	 * return ResultVO with aaData
	 * @throws Exception 
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> selectConsReport ( Map<String, Object> params ) throws Exception {
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		List<Map<String, Object>> temp = new ArrayList<Map<String, Object>>( );
		if (loginVo.getEaType().equals("ea")) {
			temp = list( "NpAdminReportA.selectConsReportEA", params );
		} else if (loginVo.getEaType().equals("eap")) {
			temp = list( "NpAdminReportA.selectConsReportEAP", params );
		} else {
			throw new Exception("전자결재 구분을 확인할 수 없습니다.");
		}
		return temp;
	}

	/**
	 * 관리자 - 품의서 현황 - 품의서 반환 / 취소
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO NpUserConsConfferStatusUpdate ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			update( "NpAdminReportA.updateConsConfferStatus", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 관리자 - 품의서 현황 - 품의서 반환 / 취소
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO NpUserConsConfferBudgetStatusUpdate ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			update( "NpAdminReportA.updateConsConfferBudgetStatus", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 결의 현황 조회
	 * selectResReport
	 * P : { }
	 * return ResultVO with aaData
	 * @throws Exception 
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> selectResReport ( Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> temp = new ArrayList<Map<String, Object>>( );
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		if (loginVo.getEaType().equals("ea")) {
			temp = list( "NpAdminReportA.selectResReportEA", params );
		} else if (loginVo.getEaType().equals("eap")) {
			temp = list( "NpAdminReportA.selectResReportEAP", params );
		} else {
			throw new Exception("전자결재 구분을 확인할 수 없습니다.");
		}
		return temp;
	}

	/**
	 * 결의서 비영리 전송 / 결의서 삭제
	 * selectSendList
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO deleteRes ( Map<String, Object> params ) {
		int temp = 0;
		ResultVO result = new ResultVO( ); 
		temp = update( "NpAdminReportA.deleteResCardAqTmp", params );
		temp = update( "NpAdminReportA.deleteResEtaxAqTmp", params );
		temp = update( "NpAdminReportA.deleteRes", params );
		temp = update( "NpAdminReportA.deleteResDoc", params );
		temp = update( "NpAdminReportA.deleteRecordInfo", params );
		temp = update( "NpAdminReportA.deleteResDocEap", params );
		delete( "NpAdminReportA.deleteResDocEapBox", params );
		result.setSuccess( );		
		return result;
	}
	
	/**
	 * 품의서 비영리 삭제
	 * 
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO deleteCons ( Map<String, Object> params ) {
		int temp = 0;
		ResultVO result = new ResultVO( ); 
		temp = update( "NpAdminReportA.deleteCons", params );
		temp = update( "NpAdminReportA.deleteResDoc", params );
		temp = update( "NpAdminReportA.deleteRecordInfo", params );
		temp = update( "NpAdminReportA.deleteResDocEap", params );
		delete( "NpAdminReportA.deleteResDocEapBox", params );
		result.setSuccess( );		
		return result;
	}

	
	/**
	 * 결의서 비영리 전송 리스트 조회
	 * selectSendList
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> selectSendEaList ( Map<String, Object> params ) {
		List<Map<String, Object>> temp = new ArrayList<Map<String, Object>>( );
		temp = list( "NpAdminReportA.selectSendEaList", params );
		return temp;
	}

	/**
	 * 결의서 영리 전송 리스트 조회
	 * selectSendList
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> selectSendEapList ( Map<String, Object> params ) {
		List<Map<String, Object>> temp = new ArrayList<Map<String, Object>>( );
		temp = list( "NpAdminReportA.selectSendEapList", params );
		return temp;
	}

	/**
	 * 전송 결의서 항목 조회 - 문서
	 * selectSendInfoHead
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO selectSendInfoDoc ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			List<Map<String, Object>> resultList = list( "NpAdminReportA.selectSendInfoDoc", params );
			if ( resultList.size( ) != 1 ) {
				result.setFail( "데이터 조회 실패 - 문서 정보 조회는 단일 건이 조회 되어야 함." );
			}
			else {
				result.setAaData( resultList );
				result.setSuccess( );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 전송 결의서, 결의서 리스트 조회 - 결의서
	 * selectSendInfoHead
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO selectSendCancelInfoRes ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			List<Map<String, Object>> resultList = list( "NpAdminReportA.selectSendCancelInfoRes", params );
			if ( resultList.size( ) == 0 ) {
				result.setFail( "데이터 조회 실패" );
			}
			else {
				result.setAaData( resultList );
				result.setSuccess( );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 전송 결의서 전송 상태 변경
	 * selectSendInfoHead
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO updateResSendFg ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			update( "NpAdminReportA.updateResSendStatus", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 전송 결의서 ERP연동 코드 변경 - budget
	 * selectSendInfoHead
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO updateResBudgetKey ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			update( "NpAdminReportA.updateResBudgetKey", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 전송 결의서 ERP연동 코드 변경 - trade
	 * selectSendInfoHead
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO updateResTradeKey ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			update( "NpAdminReportA.updateResTradeKey", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	/**
	 * 전송 결의서 항목 조회 - 헤더 / 헤더
	 * selectSendInfoHead
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO selectSendInfoHead ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			List<Map<String, Object>> resultList = list( "NpAdminReportA.selectSendInfoHead", params );
			if ( resultList.size( ) == 0 ) {
				result.setFail( "헤더정보 데이터 조회에 실패하였습니다." );
			}
			else {
				result.setAaData( resultList );
				result.setSuccess( );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "GW 결의정보 데이터 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 전송 결의서 항목 조회 - 헤더 / 예산
	 * selectSendInfoHead
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO selectSendInfoBudget ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			List<Map<String, Object>> resultList = list( "NpAdminReportA.selectSendInfoBudget", params );
			if ( resultList.size( ) == 0 ) {
				result.setFail( "예산정보 데이터 조회에 실패하였습니다." );
			}
			else {
				result.setAaData( resultList );
				result.setSuccess( );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "GW 결의 예산 정보 데이터 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 전송 결의서 항목 조회 - 거래처
	 * selectSendInfoHead
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO selectSendInfoTrade ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			List<Map<String, Object>> resultList = list( "NpAdminReportA.selectSendInfoTrade", params );
			if ( resultList.size( ) == 0 ) {
				result.setFail( "거래처정보 데이터 조회에 실패하였습니다." );
			}
			else {
				result.setAaData( resultList );
				result.setSuccess( );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "GW 결의 채주정보 데이터 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 관리자 - 카드사용 현황 조회
	 * selectCardReport
	 * P : { }
	 * return List<Map<String, Object>>
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> selectCardReport ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			params.put( commonCode.COMPSEQ, loginVo.getCompSeq( ) );
			if ( loginVo.getEaType( ).equals( "ea" ) ) {
				if ( params.get( "searchCardInfo" ).toString( ).indexOf( "," ) > 0 ) {
					params.put( "cardInfo", params.get( "searchCardInfo" ).toString( ).split( "," ) );
				}
				result = list( "NpAdminReportA.selectEACardReport", params );
			}
			else {
				result = list( "NpAdminReportA.selectEAPCardReport", params );
			}
		}
		catch ( Exception ex ) {
			result = new ArrayList<Map<String, Object>>( );
		}
		return result;
	}

	/**
	 * 관리자 - 카드사용 내역 미사용/사용처리
	 * updateSendYN
	 * P : { }
	 * return List<Map<String, Object>>
	 */
	public ResultVO updateSendYN ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			update( "NpAdminReportA.updateSendYN", params );
		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ) );
		}
		return result;
	}

	/**
	 * 관리자 - GW 세금계산서 정보 조회
	 * NPAdminGWEtaxInfoSelect
	 * P : { }
	 * return List<Map<String, Object>>
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> NPAdminGWEtaxInfoSelect ( ResultVO param ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		if ( CommonConvert.CommonGetEmpVO( ).getEaType( ).equals( "ea" ) ) {
			result = this.list( "NpAdminReportA.NPAdminGWEtaxInfoSelectEA", param.getParams( ) );
		}
		else {
			result = this.list( "NpAdminReportA.NPAdminGWEtaxInfoSelectEAP", param.getParams( ) );
		}
		return result;
	}

	/**
	 * 관리자 - 세금계산서현황 - 세금계산서 사용/미사용처리
	 * NPAminETaxSetUseYN
	 * P : { }
	 * return List<Map<String, Object>>
	 */
	@SuppressWarnings ( "unchecked" )
	public boolean NPAminETaxSetUseYN ( ResultVO param ) throws Exception {
		boolean result = true;
		try {
			List<Map<String, Object>> temp = this.list( "NPAdminSpecificETaxSelect", param.getParams( ) );
			if ( temp != null && temp.size( ) > 0 ) {
				Map<String, Object> mp = new LinkedHashMap<String, Object>( );
				mp = param.getParams( );
				mp.put( "syncId", temp.get( 0 ).get( "syncId" ).toString( ) );
				this.update( "NPAdminETaxSetUseYNUpdate", mp );
			}
			else {
				this.insert( "NPAdminETaxSetUseYNInsert", param.getParams( ) );
			}
		}
		catch ( Exception e ) {
			e.printStackTrace( );
		}
		return result;
	}

	/**
	 * 관리자 - 예실대비현황 G20- 품의 내역 팝업 - 예산별 품의서 리스트 조회 [G20 / 예실대비]
	 */
	public ResultVO selectYesilConsAmtList ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData( ( List<Map<String, Object>> ) this.list( "NpUserReportA.selectYesilConsAmtList", params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ) );
		}
		return result;
	}

	/**
	 * 관리자 - 예실대비현황 G20 - 품의 내역 팝업 - 예산별 품의정보 총계 [G20 / 예실대비]
	 */
	public ResultVO selectYesilConsBudgetInfo ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			List<Map<String, Object>> budgetInfo = ( List<Map<String, Object>> ) this.list( "NpUserReportA.selectYesilConsBudgetInfo", params );
			if( (budgetInfo == null)){
				result.setaData( new  HashMap<String, Object>());	
			}else if(budgetInfo.size( ) == 1){
				result.setaData( budgetInfo.get( 0 ) );	
			}
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ) );
		}
		return result;
	}
	
	/**
	 * 관리자 - 예실대비현황 G20 - 결의 내역 팝업 - 예산별 결의서 리스트 조회
	 */
	public ResultVO selectYesilResAmtList ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData( ( List<Map<String, Object>> ) this.list( "NpUserReportA.selectYesilResAmtList", params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ) );
		}
		return result;
	}
	
	/**
	 * 관리자 - 예실대비현황 G20 - 결의 내역 팝업 - 예산별 결의정보 총계
	 */
	public ResultVO selectYesilResBudgetInfo ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			List<Map<String, Object>> budgetInfo = ( List<Map<String, Object>> ) this.list( "NpUserReportA.selectYesilResBudgetInfo", params );
			if(budgetInfo.size( ) == 0){
				result.setaData( new  HashMap<String, Object>());	
			}else if(budgetInfo.size( ) == 1){
				result.setaData( budgetInfo.get( 0 ) );	
			}
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ) );
		}
		return result;
	}
	
	/**
	 * 관리자 - 예실대비현황 G20 - 결의 내역 팝업 - 예산별 결의정보 총계
	 */
	public ResultVO selectYesilERPResAmtList ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			List<Map<String, Object>> budgetInfo = ( List<Map<String, Object>> ) this.list( "NpUserReportA.selectYesilERPResAmtList", params );
			result.setAaData( budgetInfo );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ) );
		}
		return result;
	}
	
	
	/**
	 * 관리자 - 예실대비현황 ERPiU- 품의 내역 팝업 - 예산별 품의서 리스트 조회  [ERPiU / 예실대비]
	 */
	public ResultVO selectERPiUYesilConsAmtList ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData( ( List<Map<String, Object>> ) this.list( "NpUserReportA.selectERPiUYesilConsAmtList", params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ) );
		}
		return result;
	}


	/**
	 * 관리자 - 예실대비현황 ERPiU - 품의 내역 팝업 - 예산별 품의정보 총계  [ERPiU / 예실대비]
	 */
	public ResultVO selectERPiUYesilConsBudgetInfo ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			List<Map<String, Object>> budgetInfo = ( List<Map<String, Object>> ) this.list( "NpUserReportA.selectERPiUYesilConsBudgetInfo", params );
			if( (budgetInfo == null)){
				result.setaData( new  HashMap<String, Object>());	
			}else if(budgetInfo.size( ) == 1){
				result.setaData( budgetInfo.get( 0 ) );	
			}
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ) );
		}
		return result;
	}


	/**
	 * 관리자 - 예실대비현황 ERPiU - 결의 내역 팝업 - 예산별 결의서 리스트 조회 [ERPiU / 예실대비]
	 */
	public ResultVO selectERPiUYesilResAmtList ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData( ( List<Map<String, Object>> ) this.list( "NpUserReportA.selectERPiUYesilResAmtList", params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ) );
		}
		return result;
	}

	
	/**
	 * 관리자 - 예실대비현황 ERPiU - 결의 내역 팝업 - 예산별 결의정보 총계 [ERPiU / 예실대비]
	 */
	public ResultVO selectERPiUYesilResBudgetInfo ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			List<Map<String, Object>> budgetInfo = ( List<Map<String, Object>> ) this.list( "NpUserReportA.selectERPiUYesilResBudgetInfo", params );
			if(budgetInfo.size( ) == 0){
				result.setaData( new  HashMap<String, Object>());	
			}else if(budgetInfo.size( ) == 1){
				result.setaData( budgetInfo.get( 0 ) );	
			}
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ) );
		}
		return result;
	}

	/**
	 * 관리자 - 예실대비현황 ERPiU - 결의 내역 팝업 - 예산별 결의정보 총계
	 */
	public ResultVO selectERPiUYesilERPResAmtList ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			List<Map<String, Object>> budgetInfo = ( List<Map<String, Object>> ) this.list( "NpUserReportA.selectYesilERPResAmtList", params );
			result.setAaData( budgetInfo );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ) );
		}
		return result;
	}
	
	/**
	 * 전송 결의서 항목 조회 - 법인카드 승인내역
	 * selectSendInfoHead
	 * P : { }
	 * return ResultVO with aaData
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO selectG20CardSendList ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			List<Map<String, Object>> resultList = list( "NpAdminReportA.selectG20CardSendList", params );
			result.setAaData( resultList );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "GW 결의 채주정보 데이터 조회에 실패하였습니다.", ex );
		}
		return result;
	}
	
	/**
	 * 관리자 - ERPiU 예실대비현황 예산계정별 품의 잔액 조회
	 */
	public ResultVO selectYesilERPiUConsBalanceAmt ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			List<Map<String, Object>> budgetInfo = ( List<Map<String, Object>> ) this.list( "NpUserReportA.selectYesilERPiUConsBalanceAmt", params );
			Map<String, Object> aData = new HashMap<>();
			for( Map<String, Object> item : budgetInfo ){
				aData.put( CommonConvert.NullToString( item.get( "erpBgacctSeq" ) ) , item.get( "confferBalanceAmt" ));
			}
			result.setaData( aData );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ) );
		}
		return result;
	}
	
	
	/**
	 * 관리자 - ERPiU 예실대비현황 미전송 결의 금액 조회
	 */
	public ResultVO selectYesilERPiUResAmt ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			List<Map<String, Object>> budgetInfo = ( List<Map<String, Object>> ) this.list( "NpUserReportA.selectYesilERPiUResAmt", params );
			Map<String, Object> aData = new HashMap<>();
			for( Map<String, Object> item : budgetInfo ){
				aData.put( CommonConvert.NullToString( item.get( "erpBgacctSeq" ) ) , item.get( "resAmt" ));
			}
			result.setaData( aData );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ) );
		}
		return result;
	}

	public ResultVO selectSendInfoItemSpec(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			List<Map<String, Object>> resultList = list( "NpAdminReportA.selectSendInfoItemSpec", params );
			result.setAaData( resultList );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "GW 물품명세 정보 데이터 조회에 실패하였습니다.", ex );
		}
		return result;
	}
}

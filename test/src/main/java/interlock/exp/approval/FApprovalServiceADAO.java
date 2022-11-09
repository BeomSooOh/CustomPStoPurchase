/**
  * @FileName : FApprovalServiceADAO.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package interlock.exp.approval;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import common.vo.common.CommonInterface.commonCode;
import common.helper.convert.CommonConvert;
import common.helper.logger.CommonLogger;
import common.vo.common.ResultVO;
import common.vo.interlock.InterlockExpendVO;
import common.vo.np.NpOutInterfaceVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


/**
 *   * @FileName : FApprovalServiceADAO.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Repository ( "FApprovalServiceADAO" )
public class FApprovalServiceADAO extends EgovComAbstractDAO {
	/* 변수정의 */
	/* 공통 */
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );

	/* 전자결재 본문 조회 */
	public String ApprovalContentInfoSelect ( Map<String, Object> params ) {
		String result = commonCode.EMPTYSTR;
		result = (String) select( "InterlockEA.ApprovalContentInfoSelect", params );
		return result;
	}

	/* 전자결재 분개 상세 조회 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO ApprovalSlipDetailInfoSelect ( Map<String, Object> params ) {
		ResultVO result = new ResultVO();
		result.setAaData( (List<Map<String, Object>>) list( "InterlockEAP.ExDocSlipDetailPop", params ) );
		return result;
	}

	/* 전자결재 관리항목 상세 조회 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO ApprovalMngDetailInfoSelect ( Map<String, Object> params ) {
		ResultVO result = new ResultVO();
		result.setAaData( (List<Map<String, Object>>) list( "InterlockEAP.ExDocMngDetailPop", params ) );
		return result;
	}

	/* 이지바로 연계 - 진행 상태값 업데이트 */
	public InterlockExpendVO ApprovalProcessEzbaroStatusInfoUpdate ( Map<String, Object> params ) {
		InterlockExpendVO result = new InterlockExpendVO( );
		try {
			int updateCount = (int) update( "EzGWSQL.EzMasterProcessUpdate", params );
			if ( updateCount > 0 ) {
				result.setResultCode( commonCode.SUCCESS );
				result.setResultMessage( "정상 처리되었습니다." );
			}
			else {
				result.setResultCode( commonCode.FAIL );
				result.setResultMessage( "전자결재 상태 값 동기화 진행 중 오류가 발생되었습니다." );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			//System.out.println( e.getMessage( ) );
		}
		return result;
	}

	/* 이지바로 연계 - 종결 상태값 업데이트 */
	public InterlockExpendVO ApprovalEndProcessEzbaroStatusInfoUpdate ( Map<String, Object> params ) {
		InterlockExpendVO result = new InterlockExpendVO( );
		try {
			int updateCount = (int) update( "EzGWSQL.EzMasterEndProcessUpdate", params );
			if ( updateCount > 0 ) {
				result.setResultCode( commonCode.SUCCESS );
				result.setResultMessage( "정상 처리되었습니다." );
			}
			else {
				result.setResultCode( commonCode.FAIL );
				result.setResultMessage( "전자결재 상태 값 동기화 진행 중 오류가 발생되었습니다." );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			//System.out.println( e.getMessage( ) );
		}
		return result;
	}

	/* 결재문서 정보 조회 */
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> ApprovalInfoSelect ( Map<String, Object> params ) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>( );
		result = (Map<String, Object>) select( "InterlockEA.ApprovalInfoSelect", params );
		return result;
	}

	/* 품의서 2.0 / 결의서 2.0 외부 연동 */
	/* 품의서 2.0 / 결의서 2.0 외부 연동 - 품의서 외부 연동 정보 조회 */
	public NpOutInterfaceVO ConsOutInterfaceSelect(NpOutInterfaceVO params) throws Exception {
		NpOutInterfaceVO result = new NpOutInterfaceVO();
		Map<String, Object> tmp = new HashMap<String, Object>();

		tmp = (Map<String, Object>) select("NpUserOutInterfaceA.ConsOutInterfaceSelect", CommonConvert.CommonGetObjectToMap( params ));

		if(tmp != null) {
			result = (NpOutInterfaceVO)CommonConvert.CommonGetMapToObject(tmp, result);
		} else {
			result = new NpOutInterfaceVO( );
		}

		return result;
	}

	/* 품의서 2.0 / 결의서 2.0 외부 연동 - 결의서 외부 연동 정보 조회 */
	public NpOutInterfaceVO ResOutInterfaceSelect(NpOutInterfaceVO params) throws Exception {
		NpOutInterfaceVO result = new NpOutInterfaceVO();
		Map<String, Object> tmp = new HashMap<String, Object>();

		tmp = (Map<String, Object>) select("NpUserOutInterfaceA.ResOutInterfaceSelect", CommonConvert.CommonGetObjectToMap( params ));

		if(tmp != null) {
			result = (NpOutInterfaceVO)CommonConvert.CommonGetMapToObject(tmp, result);
		} else {
			result = new NpOutInterfaceVO( );
		}

		return result;
	}

	/** 품의서 2.0 / 결의서 2.0 외부 연동 - 호출 이력 기록 **/
	public void OutInterfaceHisInsert(NpOutInterfaceVO params) throws Exception {
		insert("NpUserOutInterfaceA.OutInterfaceHisInsert", params);
	}

	/** 외부 데이터 추가 연동 로직 사용여부 조회 **/
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> SelectAdvInterInfoCount ( Map<String, Object> params ) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>( );
		result = (Map<String, Object>) select( "NpUserOutInterfaceA.SelectAdvInterInfoCount", params );
		return result;
	}

	/** 외부 데이터 추가 연동 로직 조회 **/
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> SelectAdvInterInfo ( Map<String, Object> params ) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>( );
		result = (Map<String, Object>) select( "NpUserOutInterfaceA.SelectAdvInterInfo", params );
		return result;
	}

	/** 출장복명 2.0 결재 상태 값 업데이트 (t_exnp_trip_cons_doc) **/
	public InterlockExpendVO TripConsDocInfoUpdate ( Map<String, Object> params ) {
		InterlockExpendVO result = new InterlockExpendVO();
		try{
			update( "TripUserConsA.TripConsDocInfoUpdate", params );
			result.setResultCode(commonCode.SUCCESS);
		} catch(Exception e){
			e.printStackTrace( );
			result.setResultCode(commonCode.FAIL);
		}
		return result;
	}

	/** 출장복명 2.0 결재 상태 값 업데이트 (t_exnp_consdoc) **/
	public InterlockExpendVO ConsDocInfoUpdate ( Map<String, Object> params ) {
		InterlockExpendVO result = new InterlockExpendVO();
		try{
			update( "TripUserConsA.ConsDocInfoUpdate", params );
			result.setResultCode(commonCode.SUCCESS);
		} catch(Exception e){
			e.printStackTrace( );
			result.setResultCode(commonCode.FAIL);
		}
		return result;
	}

	/** 출장 품의서 등록된 일정 정보 업데이트 **/
	public ResultVO updateConsSchInfo(Map<String, Object> params){
		ResultVO result = new ResultVO();
		try{
			cmLog.CommonSetInfoToDatabase( "               [EXNP-TRIP] CALL TripUserConsA.updateConsSchInfo , params : " + params.toString( ), "-", "EXNP" );
			int resultCnt = update("TripUserConsA.updateConsSchInfo", params);
			result.setSuccess( );
		} catch(Exception e){
			result.setFail( "데이터 조회 실패", e );
		}
		return result;
	}

	/** 출장 결의서 등록된 일정 정보 업데이트 **/
	public ResultVO updateResSchInfo(Map<String, Object> params){
		ResultVO result = new ResultVO();
		try{
			cmLog.CommonSetInfoToDatabase( "               [EXNP-TRIP] CALL TripUserResA.updateResSchInfo , params : " + params.toString( ), "-", "EXNP" );
			int resultCnt = update("TripUserResA.updateResSchInfo", params);
			result.setSuccess( );
		} catch(Exception e){
			result.setFail( "데이터 조회 실패", e );
		}
		return result;
	}

	/** 인사근태/일정 등 API 연동 정보 조회 (t_exnp_consdoc) **/
	public ResultVO ConsDocAPIInfoSelect ( Map<String, Object> params ) {
		ResultVO result = new ResultVO();
		try{
			result.setAaData( list( "TripUserConsA.selectTripConsDocAPIInfo", params ));
			result.setSuccess( );
		} catch(Exception e){
			result.setFail( "데이터 조회 실패", e );
		}
		return result;
	}

	/** 출장복명 2.0 결재 상태 값 업데이트 (t_exnp_trip_res_doc) **/
	public InterlockExpendVO TripResDocInfoUpdate ( Map<String, Object> params ) {
		InterlockExpendVO result = new InterlockExpendVO();
		try{
			update( "TripUserResA.TripResDocInfoUpdate", params );
			result.setResultCode(commonCode.SUCCESS);
		} catch(Exception e){
			e.printStackTrace( );
			result.setResultCode(commonCode.FAIL);
		}
		return result;
	}

	/** 출장복명 2.0 결재 상태 값 업데이트 (t_exnp_resdoc) **/
	public InterlockExpendVO ResDocInfoUpdate ( Map<String, Object> params ) {
		InterlockExpendVO result = new InterlockExpendVO();
		try{
			update( "TripUserResA.ResDocInfoUpdate", params );
			result.setResultCode(commonCode.SUCCESS);
		} catch(Exception e){
			e.printStackTrace( );
			result.setResultCode(commonCode.FAIL);
		}
		return result;
	}


	/** 인사근태/일정 등 API 연동 정보 조회 (t_exnp_resdoc) **/
	public ResultVO ResDocAPIInfoSelect ( Map<String, Object> params ) {
		ResultVO result = new ResultVO();
		try{
			result.setAaData( list( "TripUserResA.selectTripResDocAPIInfo", params ));
			result.setSuccess( );
		} catch(Exception e){
			result.setFail( "데이터 조회 실패", e );
		}
		return result;
	}


	/** 영리 회계 법인카드 승인내역 키 조회 **/
	public ResultVO SelectICubeCard_EXP ( Map<String, Object> params ) {
		ResultVO result = new ResultVO();
		try{
			result.setAaData( list( "InterlockEA.SelectICubeCard_EXP", params ));
			result.setSuccess( );
		} catch(Exception e){
			result.setFail( "데이터 조회 실패", e );
		}
		return result;
	}

	/** 비영리 회계 법인카드 승인내역 키 조회 **/
	public ResultVO SelectICubeCard_NP ( Map<String, Object> params ) {
		ResultVO result = new ResultVO();
		try{
			result.setAaData( list( "InterlockEA.SelectICubeCard_NP", params ));
			result.setSuccess( );
		} catch(Exception e){
			result.setFail( "데이터 조회 실패", e );
		}
		return result;
	}

	/** [영리/비영리] 회계 법인카드 승인내역 ERP확정 키 조회 **/
	public ResultVO SelectICubeCardKey ( Map<String, Object> params ) {
		ResultVO result = new ResultVO();
		try{
			List<Map<String, Object>> queryResult = list( "InterlockEA.SelectICubeCardKey", params );
			if(queryResult.size( ) != 1){
				throw new Exception(" SelectICubeCardKey] 법인카드 승인내역 조회 실패 param : " + params.toString( ) );
			}
			result.setaData( queryResult.get( 0 ) );
			result.setSuccess( );
		} catch(Exception e){
			result.setFail( e.getMessage( ), e );
			cmLog.CommonSetError( e );
		}
		return result;
	}
}

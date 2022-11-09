/**
  * @FileName : FApprovalServicePDAO.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package interlock.exp.approval;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ResultVO;
import common.vo.interlock.InterlockExpendVO;
import common.vo.np.NpOutInterfaceVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


/**
 *   * @FileName : FApprovalServicePDAO.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Repository ( "FApprovalServicePDAO" )
public class FApprovalServicePDAO extends EgovComAbstractDAO {

	/* 전자결재 본문 조회 */
	public String ApprovalContentInfoSelect ( Map<String, Object> params ) {
		String result = commonCode.EMPTYSTR;
		result = (String) select( "InterlockEAP.ApprovalContentInfoSelect", params );
		return result;
	}

	/* ################################################## */
	/* 지출결의 연계 */
	/* ################################################## */
	/* 지출결의 연계 - 이전 상태값 조회 */
	public String ApprovalProcessExStatusInfoSelect ( Map<String, Object> params ) {
		String result = commonCode.EMPTYSTR;
		result = (String) select( "InterlockEAP.ApprovalProcessExStatusInfoSelect", params );
		return result;
	}

	/* 지출결의 연계 - 상태값 업데이트 */
	public InterlockExpendVO ApprovalProcessExStatusInfoUpdate ( Map<String, Object> params ) {
		InterlockExpendVO result = new InterlockExpendVO( );
		try {
			int updateCount = (int) update( "InterlockEAP.ApprovalProcessExStatusInfoUpdate", params );
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

	/* 지출결의 인터락 첨부파일 정보 조회 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO ApprovalSelectAttachInfo(Map<String, Object> params){
		ResultVO result = new ResultVO();
		try {
			result.setResultCode( commonCode.SUCCESS );
			result.setAaData( (ArrayList<Map<String,Object>>) list("InterlockEAP.ApprovalSelectAttachInfo", params) );
		}catch(Exception ex){
			result.setResultCode( commonCode.FAIL );
			result.setResultName( "첨부파일 정보 조회에 실패하였습니다." );
		}

		return result;
	}

	/* 지출결의 인터락 첨부파일 상세 정보 조회 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO SelectApprovalAttachInfo(Map<String, Object> params){
		ResultVO result = new ResultVO();
		try {
			result.setResultCode( commonCode.SUCCESS );
			result.setAaData( (ArrayList<Map<String,Object>>) list("InterlockEAP.ApprovalSelectAttachInfoDetail", params) );
		}catch(Exception ex){
			result.setResultCode( commonCode.FAIL );
			result.setResultName( "첨부파일 정보 조회에 실패하였습니다." );
		}

		return result;
	}
	/* 지출결의 인터락 적요 상세 정보 조회 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO SelectApprovalListInfo(Map<String, Object> params){
		ResultVO result = new ResultVO();
		try {
			result.setResultCode( commonCode.SUCCESS );
			result.setAaData( (ArrayList<Map<String,Object>>) list("InterlockEAP.ExDocSlipDetailPop", params) );
		}catch(Exception ex){
			result.setResultCode( commonCode.FAIL );
			result.setResultName( "첨부파일 정보 조회에 실패하였습니다." );
		}

		return result;
	}
	/* 지출결의 인터락 분개 상세 정보 조회 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO SelectApprovalSlipInfo(Map<String, Object> params){
		ResultVO result = new ResultVO();
		try {
			result.setResultCode( commonCode.SUCCESS );
			result.setAaData( (ArrayList<Map<String,Object>>) list("InterlockEAP.ExDocMngDetailPop", params) );
		}catch(Exception ex){
			result.setResultCode( commonCode.FAIL );
			result.setResultName( "첨부파일 정보 조회에 실패하였습니다." );
		}

		return result;
	}

	/* 결재문서 정보 조회 */
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> ApprovalInfoSelect ( Map<String, Object> params ) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>( );
		result = (Map<String, Object>) select( "InterlockEAP.ApprovalInfoSelect", params );
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

	/* 품의서 2.0 / 결의서 2.0 외부 연동 - 호출 이력 기록 */
	public void OutInterfaceHisInsert(NpOutInterfaceVO params) throws Exception {
		insert("NpUserOutInterfaceA.OutInterfaceHisInsert", params);
	}


	/* 외부 데이터 추가 연동 로직 사용여부 조회 */
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> SelectAdvInterInfoCount ( Map<String, Object> params ) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>( );
		result = (Map<String, Object>) select( "NpUserOutInterfaceA.SelectAdvInterInfoCount", params );
		return result;
	}

	/* 외부 데이터 추가 연동 로직 조회 */
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> SelectAdvInterInfo ( Map<String, Object> params ) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>( );
		result = (Map<String, Object>) select( "NpUserOutInterfaceA.SelectAdvInterInfo", params );
		return result;
	}
}

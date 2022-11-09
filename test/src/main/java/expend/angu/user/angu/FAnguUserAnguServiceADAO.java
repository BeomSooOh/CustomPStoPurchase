/**
  * @FileName : FAnguUserAnguServiceADAO.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.angu.user.angu;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import common.helper.connection.CommonAnConnect;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


/**
 *   * @FileName : FAnguUserAnguServiceADAO.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Repository ( "FAnguUserAnguServiceADAO" )
public class FAnguUserAnguServiceADAO extends EgovComAbstractDAO {

	/* 변수정의 */
	CommonAnConnect connector = new CommonAnConnect( );

	/* ## [+] 국고보조 v2 ## */
	/* ## [+] 국고보조 v2 ## - 국고보조 집행등록 문서 생성 */
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> setAnguDocument_Insert ( Map<String, Object> param ) {
		Map<String, Object> result = new HashMap<String, Object>( );
		this.insert( "AnguUser.setAnguDocument_Insert_01", param );
		result = (Map<String, Object>) this.select( "AnguUser.setAnguDocument_Insert_02", param );
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 국고보조 집행등록 abdocu 삭제 */
	public void setAnguDocumentAbdocu_Delete ( Map<String, Object> param ) {
		setAnguDocumentAbdocuB_Delete( param );
		this.delete( "AnguUser.setAnguDocumentAbdocu_Delete", param );
	}

	/* ## [+] 국고보조 v2 ## - 국고보조 집행등록 abdocu B 삭제 */
	public void setAnguDocumentAbdocuB_Delete ( Map<String, Object> param ) {
		setAnguDocumentAbdocuT_Delete( param );
		this.delete( "AnguUser.setAnguDocumentAbdocuB_Delete", param );
	}

	/* ## [+] 국고보조 v2 ## - 국고보조 집행등록 abdocu T 삭제 */
	public void setAnguDocumentAbdocuT_Delete ( Map<String, Object> param ) {
		setAnguDocumentAbdocuPay_Delete( param );
		this.delete( "AnguUser.setAnguDocumentAbdocuT_Delete", param );
	}

	/* ## [+] 국고보조 v2 ## - 국고보조 집행등록 abdocu Pay 삭제 */
	public void setAnguDocumentAbdocuPay_Delete ( Map<String, Object> param ) {
		this.delete( "AnguUser.setAnguDocumentAbdocuPay_Delete", param );
	}

	/* ## [+] 국고보조 v2 ## - 국고보조 집행등록 abdocu 생성 */
	public Map<String, Object> setAnguDocumentAbdocu_Insert ( Map<String, Object> param ) {
		// this.insert( "AnguUser.setAnguDocumentAbdocu_Insert", param );
		//System.out.println( "AnguUser.setAnguDocumentAbdocu_Insert" + param.toString( ) );
		this.insert( "AnguUser.setAnguDocumentAbdocu_Insert", param );
		return param;
	}

	/* ## [+] 국고보조 v2 ## - 국고보조 집행등록 abdocu_b 생성 */
	public Map<String, Object> setAnguDocumentAbdocuB_Insert ( Map<String, Object> param ) {
		// this.insert( "AnguUser.setAnguDocumentAbdocuB_Insert", param );
		//System.out.println( "AnguUser.setAnguDocumentAbdocuB_Insert" + param.toString( ) );
		this.insert( "AnguUser.setAnguDocumentAbdocuB_Insert", param );
		return param;
	}

	/* ## [+] 국고보조 v2 ## - 국고보조 집행등록 abdocu_t 생성 */
	public Map<String, Object> setAnguDocumentAbdocuT_Insert ( Map<String, Object> param ) {
		// this.insert( "AnguUser.setAnguDocumentAbdocuT_Insert", param );
		//System.out.println( "AnguUser.setAnguDocumentAbdocuT_Insert" + param.toString( ) );
		this.insert( "AnguUser.setAnguDocumentAbdocuT_Insert", param );
		return param;
	}
	/* ## [-] 국고보조 v2 ## */

	/* 국고보조 집행등록 문서 생성 */
	public Map<String, Object> AnguI ( Map<String, Object> params ) {
		/* parameter : compSeq, docSeq, formSeq, anbojoStatCode, gisuDate, writeSeq, jsonStr, empSeq */
		this.insert( "AnguUser.AnguI", params );
		return params;
	}

	/* 결의내역 등록 */
	public Map<String, Object> AbdocuI ( Map<String, Object> params ) {
		this.insert( "AnguUser.AbdocuI", params );
		return params;
	}

	/* 증빙내역 등록 */
	public Map<String, Object> AbdocuSubI ( Map<String, Object> params ) {
		this.update( "AnguUser.AbdocuSubI", params );
		return params;
	}

	/* 비목내역 등록 */
	public Map<String, Object> AbdocuBI ( Map<String, Object> params ) {
		this.update( "AnguUser.AbdocuBI", params );
		return params;
	}

	/* 재원내역 등록 */
	public Map<String, Object> AbdocuTI ( Map<String, Object> params ) {
		this.update( "AnguUser.AbdocuTI", params );
		return params;
	}

	/* 인력정보 삭제 */
	public void AbdocuPD ( Map<String, Object> params ) {
		this.delete( "AnguUser.AbdocuPD", params );
	}

	/* 인력정보 등록 */
	public Map<String, Object> AbdocuPI ( Map<String, Object> params ) {
		this.insert( "AnguUser.AbdocuPI", params );
		return params;
	}

	/* 국고보조 집행등록 상신 준비 오류 시 */
	public Map<String, Object> AbdocuException ( Map<String, Object> params ) {
		this.delete( "AnguUser.AbdocuException", params );
		this.delete( "AnguUser.AbdocuBException", params );
		this.delete( "AnguUser.AbdocuTException", params );
		return params;
	}

	/* 결의 + 증빙내역 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> AbdocuS ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) this.list( "AnguUser.AbdocuS", params );
		return result;
	}

	/* 비목내역 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> AbdocuBS ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) this.list( "AnguUser.AbdocuBS", params );
		return result;
	}

	/* 재원내역 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> AbdocuTS ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) this.list( "AnguUser.AbdocuTS", params );
		return result;
	}

	/* 인력정보 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> AbdocuPS ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) this.list( "AnguUser.AbdocuPS", params );
		return result;
	}

	/* GISU_SQ 업데이트 */
	public void AbdocuGisuSqU ( Map<String, Object> params ) {
		this.update( "AnguUser.AbdocuGisuSqU", params );
		this.update( "AnguUser.AbdocuTGisuSqU", params );
		this.update( "AnguUser.AbdocuBGisuSqU", params );
		this.update( "AnguUser.AbdocuPGisuSqU", params );
	}

	/* BG_SQ 업데이트 */
	public void AbdocuBgSqU ( Map<String, Object> params ) {
		this.update( "AnguUser.AbdocuTBgSqU", params );
		this.update( "AnguUser.AbdocuBBgSqU", params );
		this.update( "AnguUser.AbdocuPBgSqU", params );
	}

	/* IN_SQ 업데이트 */
	public void AbdocuInSqU ( Map<String, Object> params ) {
		this.update( "AnguUser.AbdocuBInSqU", params );
		this.update( "AnguUser.AbdocuPInSqU", params );
	}

	/* HNF_REGIST_SN 업데이트 */
	public void AbdocuRegistSnU ( Map<String, Object> params ) {
		this.update( "AnguUser.AbdocuPRegistSnU", params );
	}

	/* iCUBE 업데이트 정보 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> AbdocuSyncInfoS ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = this.list( "AnguUser.AbdocuSyncInfoS", params );
		return result;
	}

	/* 상신전 오류 발생시 삭제 처리 */
	public int AbdocuApprovalDel ( Map<String, Object> params ) {
		int result = 0;
		result = this.delete( "AnguUser.AbdocuApprovalDel", params );
		return result;
	}
}

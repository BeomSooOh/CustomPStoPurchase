package expend.ex2.admin.summary;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FEx2AdminSummaryServiceADAO" )
public class FEx2AdminSummaryServiceADAO extends EgovComAbstractDAO {

	/* 증빙 유형 생성 */
	public Map<String, Object> setAdminSummaryInsert ( Map<String, Object> param ) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>( );
		result.put( "insertCount", this.insert( "setAdminSummaryInsert", param ) );
		param.put( "langCode", "kr" );
		param.put( "summaryName", param.get( "summaryName" ) );
		result.put( "insertCount", this.insert( "setAdminSummaryMultiInsert", param ) );
		param.put( "langCode", "en" );
		param.put( "summaryName", param.get( "summaryNameEn" ) );
		result.put( "insertCount", this.insert( "setAdminSummaryMultiInsert", param ) );
		param.put( "langCode", "cn" );
		param.put( "summaryName", param.get( "summaryNameCn" ) );
		result.put( "insertCount", this.insert( "setAdminSummaryMultiInsert", param ) );
		param.put( "langCode", "jp" );
		param.put( "summaryName", param.get( "summaryNameJp" ) );
		result.put( "insertCount", this.insert( "setAdminSummaryMultiInsert", param ) );
		return result;
	}

	/* 증빙 유형 수정 */
	public Map<String, Object> setAdminSummaryUpdate ( Map<String, Object> param ) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>( );
		result.put( "updateCount", this.update( "setAdminSummaryUpdate", param ) );
		param.put( "langCode", "kr" );
		param.put( "summaryName", param.get( "summaryName" ) );
		result.put( "updateCount", this.update( "setAdminSummaryMultiUpdate", param ) );
		param.put( "langCode", "jp" );
		param.put( "summaryName", param.get( "summaryNameJp" ) );
		result.put( "updateCount", this.update( "setAdminSummaryMultiUpdate", param ) );
		param.put( "langCode", "cn" );
		param.put( "summaryName", param.get( "summaryNameCn" ) );
		result.put( "updateCount", this.update( "setAdminSummaryMultiUpdate", param ) );
		param.put( "langCode", "en" );
		param.put( "summaryName", param.get( "summaryNameEn" ) );
		result.put( "updateCount", this.update( "setAdminSummaryMultiUpdate", param ) );
		return result;
	}

	/* 증빙 유형 삭제 */
	public Map<String, Object> setAdminSummaryDelete ( Map<String, Object> param ) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>( );
		result.put( "deleteCount", this.delete( "setAdminSummaryDelete", param ) );
		result.put( "deleteCount", this.delete( "setAdminSummaryMultiDelete", param ) );
		return result;
	}

	/* 증빙 유형 조회 */
	public Map<String, Object> setAdminSummarySelect ( Map<String, Object> param ) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>( );
		result = (Map<String, Object>) this.select( "setAdminSummarySelect", param );
		return result;
	}

	public List<Map<String, Object>> setAdminSummaryListSelect ( Map<String, Object> param ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) this.list( "setAdminSummaryListSelect", param );
		return result;
	}

	/* ERP 전송유무 확인 */
	public Map<String, Object> setAdminSummaryErpSendYN ( Map<String, Object> param ) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>( );
		result = (Map<String, Object>) this.select( "setAdminSummaryErpSendYN", param );
		return result;
	}
}

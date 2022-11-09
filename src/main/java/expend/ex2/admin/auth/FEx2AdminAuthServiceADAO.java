package expend.ex2.admin.auth;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FEx2AdminAuthServiceADAO" )
public class FEx2AdminAuthServiceADAO extends EgovComAbstractDAO {

	/* 증빙 유형 생성 */
	public Map<String, Object> setAdminAuthInsert ( Map<String, Object> param ) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>( );
		result.put( "insertCount", this.insert( "setAdminAuthInsert", param ) );
		param.put( "langCode", "kr" );
		param.put( "authName", param.get( "authName" ) );
		result.put( "insertCount", this.insert( "setAdminAuthMultiInsert", param ) );
		param.put( "langCode", "en" );
		param.put( "authName", param.get( "authNameEn" ) );
		result.put( "insertCount", this.insert( "setAdminAuthMultiInsert", param ) );
		param.put( "langCode", "cn" );
		param.put( "authName", param.get( "authNameCn" ) );
		result.put( "insertCount", this.insert( "setAdminAuthMultiInsert", param ) );
		param.put( "langCode", "jp" );
		param.put( "authName", param.get( "authNameJp" ) );
		result.put( "insertCount", this.insert( "setAdminAuthMultiInsert", param ) );
		return result;
	}

	/* 증빙 유형 수정 */
	public Map<String, Object> setAdminAuthUpdate ( Map<String, Object> param ) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>( );
		result.put( "updateCount", this.update( "setAdminAuthUpdate", param ) );
		param.put( "langCode", "kr" );
		param.put( "authName", param.get( "authName" ) );
		result.put( "insertCount", this.insert( "setAdminAuthMultiUpdate", param ) );
		param.put( "langCode", "en" );
		param.put( "authName", param.get( "authNameEn" ) );
		result.put( "insertCount", this.insert( "setAdminAuthMultiUpdate", param ) );
		param.put( "langCode", "cn" );
		param.put( "authName", param.get( "authNameCn" ) );
		result.put( "insertCount", this.insert( "setAdminAuthMultiUpdate", param ) );
		param.put( "langCode", "jp" );
		param.put( "authName", param.get( "authNameJp" ) );
		result.put( "insertCount", this.insert( "setAdminAuthMultiUpdate", param ) );
		return result;
	}

	/* 증빙 유형 삭제 */
	public Map<String, Object> setAdminAuthDelete ( Map<String, Object> param ) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>( );
		result.put( "deleteCount", this.delete( "setAdminAuthDelete", param ) );
		result.put( "deleteCount", this.delete( "setAdminAuthMultiDelete", param ) );
		return result;
	}

	/* 증빙 유형 조회 */
	public Map<String, Object> setAdminAuthSelect ( Map<String, Object> param ) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>( );
		result = (Map<String, Object>) this.select( "setAdminAuthSelect", param );
		return result;
	}

	public List<Map<String, Object>> setAdminAuthListSelect ( Map<String, Object> param ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) this.list( "setAdminAuthListSelect", param );
		return result;
	}

	/* ERP 전송 여부 확인 */
	public Map<String, Object> setAdminAuthErpSendYN ( Map<String, Object> param ) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>( );
		result = (Map<String, Object>) this.select( "setAdminAuthErpSendYN", param );
		return result;
	}
}

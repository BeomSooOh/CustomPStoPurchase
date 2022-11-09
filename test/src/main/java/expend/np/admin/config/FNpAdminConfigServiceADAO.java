package expend.np.admin.config;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

//import common.helper.convert.CommonConvert;
//import common.vo.common.ResultVO;
//import common.vo.common.CommonInterface.commonCode;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FNpAdminConfigServiceADAO" )
public class FNpAdminConfigServiceADAO extends EgovComAbstractDAO {

	/*
	 * 관리자 - 품의결의설정 페이지 옵션 조회
	 * */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> NpOptionListSelect ( Map<String, Object> params ){
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = list( "NpAdminConfigA.NpOptionListSelect", params );
		return result;
	}

	/*
	 * 관리자 - 품의결의설정 페이지 옵션 변경
	 * */
	public int NpOptionUpdate ( Map<String, Object> params ){
		int result = 0;
		result = update( "NpAdminConfigA.NpOptionUpdate", params );
		return result;
	}

	/*
	 * 관리자 - 기본설정 페이지 옵션 조회
	 * */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> NpMasterOptionSelect ( Map<String, Object> params ){
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = list( "NpAdminConfigA.NpMasterOptionSelect", params );
		if( result.size( ) == 0 ){
			insert( "NpAdminConfigA.NpMasterOptionInsert", params );
			result = list( "NpAdminConfigA.NpMasterOptionSelect", params );
		}else if(result.get( 0 ).get( "optionMatch" ).toString( ).equals( "0" )){
			insert( "NpUserOptionA.NpGwCommonOptionInsert", params );
			result = list( "NpAdminConfigA.NpMasterOptionSelect", params );
		}
		return result;
	}

	/*
	 * 관리자 - 기본설정 페이지 옵션 변경
	 * */
	public int NpMasterOptionUpdate ( Map<String, Object> params ){
		int result = 0;
		result = update( "NpAdminConfigA.NpMasterOptionUpdate", params );
		return result;
	}

	/*
	 * 관리자 - 회사 참조품의 조회 권한 설정
	 * */
	public int NpMasterOptionCompConsAuthUpdate ( Map<String, Object> params ){
		int result = 0;
		result = delete ( "NpAdminConfigA.NpMasterConsAuthTruncate", params );
		insert ( "NpAdminConfigA.NpMasterConsAuthInsert",params);
		return result;
	}

	/*
	 * 관리자 - 회사 참조품의 조회 권한 삭제
	 * */
	public int NpMasterOptionCompConsAuthDelete ( Map<String, Object> params ){
		int result = 0;
		delete ( "NpAdminConfigA.NpMasterConsAuthDelete",params);
		return result;
	}

	/*
	 * 관리자 - 회사 참조품의 조회 권한 조회
	 * */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> NpMasterOptionCompConsAuthSelect ( Map<String, Object> params ){
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = list( "NpAdminConfigA.NpMasterConsAuthSelect", params );

		return result;
	}

	/*
	 * 관리자 - 항목설정 페이지 옵션 조회
	 * */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> NpFormOptionSelect ( Map<String, Object> params ){
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = list( "NpAdminConfigA.NpFormOptionSelect", params );
		if( result.size( ) == 0 ){
			if(params.get("formDTp").toString( ).indexOf( "CON" ) > -1){
				params.put("formDTp", "CON" );
			}else if(params.get("formDTp").toString( ).indexOf( "RES" ) > -1){
				params.put("formDTp", "RES" );
			}
			insert( "NpAdminConfigA.NpFormOptionInsert", params );
			result = list( "NpAdminConfigA.NpFormOptionSelect", params );
		}
		return result;
	}

	/*
	 * 관리자 - 항목설정 페이지 옵션  변경
	 * */
	public int NpFormOptionUpdate ( Map<String, Object> params ){
		int result = 0;
		result = update( "NpAdminConfigA.NpFormOptionUpdate", params );
		return result;
	}
}

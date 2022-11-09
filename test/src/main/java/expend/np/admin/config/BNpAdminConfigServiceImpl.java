package expend.np.admin.config;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

//import common.helper.convert.CommonConvert;
//import common.vo.common.ConnectionVO;


@Service ( "BNpAdminConfigService" )
public class BNpAdminConfigServiceImpl implements BNpAdminConfigService {

	@Resource ( name = "FNpAdminConfigServiceA" )
	private FNpAdminConfigService serviceConfigA;

	/*
	 * 관리자 - 품의결의설정 페이지 옵션 조회
	 * */
	public List<Map<String, Object>> NpOptionListSelect ( Map<String, Object> params ){
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = serviceConfigA.NpOptionListSelect( params );
		return result;
	}

	/*
	 * 관리자 - 품의결의설정 페이지 옵션 변경
	 * */
	public int NpOptionUpdate ( Map<String, Object> params ){
		return serviceConfigA.NpOptionUpdate( params );
	}

	/*
	 * 관리자 - 기본설정 페이지 옵션 조회
	 * */
	public List<Map<String, Object>> NpMasterOptionSelect ( Map<String, Object> params ){
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = serviceConfigA.NpMasterOptionSelect( params );
		return result;
	}

	/*
	 * 관리자 - 기본설정 페이지 옵션 변경
	 * */
	public int NpMasterOptionUpdate ( Map<String, Object> params ){
		return serviceConfigA.NpMasterOptionUpdate( params );
	}

	/*
	 * 관리자 - 기본설정 회사 품의서 조회 권한 부여
	 * */
	public int NpMasterOptionCompConsAuthUpdate ( Map<String, Object> params ){
		return serviceConfigA.NpMasterOptionCompConsAuthUpdate( params );
	}


	/*
	 * 관리자 - 기본설정 회사 품의서 조회 권한 부여
	 * */
	public List<Map<String, Object>> NpMasterOptionCompConsAuthSelect ( Map<String, Object> params ){
		return serviceConfigA.NpMasterOptionCompConsAuthSelect( params );
	}

	/*
	 * 관리자 - 기본설정 회사 품의서 조회 권한 삭제
	 * */
	public int NpMasterOptionCompConsAuthDelete ( Map<String, Object> params ){
		return serviceConfigA.NpMasterOptionCompConsAuthDelete( params );
	}

	/*
	 * 관리자 - 항목설정 페이지 옵션 조회
	 * */
	public List<Map<String, Object>> NpFormOptionSelect ( Map<String, Object> params ){
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );

		result = serviceConfigA.NpFormOptionSelect( params );
		return result;
	}

	/*
	 * 관리자 - 항목설정 페이지 옵션  변경
	 * */
	public int NpFormOptionUpdate ( Map<String, Object> params ){
		return serviceConfigA.NpFormOptionUpdate( params );
	}
}

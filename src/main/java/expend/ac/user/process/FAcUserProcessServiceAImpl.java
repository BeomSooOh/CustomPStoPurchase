/**
  * @FileName : FAcUserProcessServiceAImpl.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ac.user.process;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;


/**
 *   * @FileName : FAcUserProcessServiceAImpl.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Service ( "FAcUserProcessServiceA" )
public class FAcUserProcessServiceAImpl implements FAcUserProcessService {

	/* 변수정의 */
	/* 변수정의 - DAO */
	@Resource ( name = "FAcUserProcessServiceADAO" )
	private FAcUserProcessServiceADAO dao;

	/* G20 품의 / 결의서 */
	/* G20 품의 / 결의서 - 회계기수목록정보 조회 */
	@Override
	public List<Map<String, Object>> AcExErpGisuListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		return result;
	}

	/* G20 품의 / 결의서 - 사용자정보 조회 */
	@Override
	public Map<String, Object> AcExErpEmpInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>( );
		return result;
	}

	/* G20 품의 / 결의서 - 사용자목록정보 조회 */
	@Override
	public List<Map<String, Object>> AcExErpEmpListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		return result;
	}

	/* G20 품의 / 결의서 - 양식정보 조회 */
	@Override
	public Map<String, Object> AcExFormInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>( );
		try {
			/* 변수정의 */
			/* parameters : compSeq, empSeq, formSeq, langCode */
			@SuppressWarnings ( "unused" )
			String[] parameters = { commonCode.COMPSEQ, commonCode.EMPSEQ, commonCode.FORMSEQ, commonCode.LANGCODE };
			boolean chkParameters = true;
			/* 필수값 확인 */
			/* 필수값 확인 - compSeq */
			if ( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				chkParameters = false;
				throw new Exception( "parameter 누락 : " + commonCode.COMPSEQ );
			}
			/* 필수값 확인 - empSeq */
			if ( CommonConvert.CommonGetStr( params.get( commonCode.EMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				chkParameters = false;
				throw new Exception( "parameter 누락 : " + commonCode.EMPSEQ );
			}
			/* 필수값 확인 - formSeq */
			if ( CommonConvert.CommonGetStr( params.get( commonCode.FORMSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				chkParameters = false;
				throw new Exception( "parameter 누락 : " + commonCode.FORMSEQ );
			}
			/* 필수값 확인 - langCode */
			if ( CommonConvert.CommonGetStr( params.get( commonCode.LANGCODE ) ).equals( commonCode.EMPTYSTR ) ) {
				chkParameters = false;
				throw new Exception( "parameter 누락 : " + commonCode.LANGCODE );
			}
			/* 양식정보 조회 */
			if ( chkParameters ) {
				//result = dao.AcExFormInfoSelect( conVo, params );
				result = dao.AcExFormInfoSelect( params );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return result;
	}

	/* G20 공통코드 조회 */
	/* G20 공통코드 조회 - 프로젝트 */
	@Override
	public List<Map<String, Object>> AcExErpProjectListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		return result;
	}

	/* G20 공통코드 조회 - 부서 */
	@Override
	public List<Map<String, Object>> AcExErpDeptListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		return result;
	}

	/* G20 공통코드 조회 - 입출금계좌 */
	@Override
	public List<Map<String, Object>> AcExErpBankTradeListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		return result;
	}
}

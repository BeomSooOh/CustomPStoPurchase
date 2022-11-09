package common.helper.info;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Repository;

//import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundLoginSessionException;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.EaFormVO;
import common.vo.ex.ExOptionVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "CommonInfoDAO" )
public class CommonInfoDAO extends EgovComAbstractDAO {

	/* 전자결재 버전 정조 조회 - comp_seq 버전 - DAO */
	public String SelectCommonCompEaTypeInfo ( String compSeq ) throws NotFoundLoginSessionException {
		return SelectCommonCompEaTypeInfo( CommonConvert.CommonGetEmpVO( ).getGroupSeq( ), compSeq );
	}

	public String SelectCommonCompEaTypeInfo ( String groupSeq, String compSeq ) {
		String result = commonCode.EMPTYSTR;
		compSeq = CommonConvert.CommonGetStr( compSeq );
		Map<String, Object> params = new HashMap<String, Object>( );
		params.put( commonCode.GROUPSEQ, groupSeq );
		params.put( commonCode.COMPSEQ, compSeq );
		result = (String) select( "CommonDAO.SelectCommonCompEaTypeInfo", params );
		return result;
		/* SELECT IFNULL(ea_type, '') AS ea_type FROM t_co_comp WHERE comp_seq = '${compSeq}' LIMIT 1 */
	}

	/* 전자결재 버전 정조 조회 - emp_seq 버전 - DAO */
	public String SelectCommonEmpEaTypeInfo ( String empSeq ) {
		String result = commonCode.EMPTYSTR;
		empSeq = CommonConvert.CommonGetStr( empSeq );
		Map<String, Object> params = new HashMap<String, Object>( );
		params.put( "empSeq", empSeq );
		result = (String) select( "CommonDAO.SelectCommonEmpEaTypeInfo", params );
		return result;
		/* SELECT IFNULL(ea_type, '') AS ea_type FROM t_co_comp WHERE comp_seq = '${compSeq}' LIMIT 1 */
	}

	/* 연동시스템 정보 조회 - DAO */
	public ConnectionVO SelectCommonConnectionInfo ( String compSeq ) throws NotFoundLoginSessionException {
		/*
		 * Cloud 버전 사용을 위하여, groupSeq 전송 형태로 변경
		 * - 2018-02-13
		 * - 김상겸
		 */
		return SelectCommonConnectionInfo( CommonConvert.CommonGetStr( CommonConvert.CommonGetEmpVO( ).getGroupSeq( ) ), compSeq );
		/* SELECT `database_type`, `driver`, `url`, `userid`, `password`, `erp_type_code`, `erp_comp_seq`, `erp_comp_name` FROM t_co_erp WHERE comp_seq = '${compSeq}' AND achr_gbn = 'ac' LIMIT 1 */
	}

	/* 연동시스템 정보 조회 - DAO ( Cloud ) */
	public ConnectionVO SelectCommonConnectionInfo ( String groupSeq, String compSeq ) {
		Map<String, Object> parmas = new HashMap<String, Object>( );
		parmas.put( commonCode.GROUPSEQ, groupSeq );
		parmas.put( commonCode.COMPSEQ, compSeq );
		return SelectCommonConnectionInfo( parmas );
		/* SELECT `database_type`, `driver`, `url`, `userid`, `password`, `erp_type_code`, `erp_comp_seq`, `erp_comp_name` FROM t_co_erp WHERE comp_seq = '${compSeq}' AND achr_gbn = 'ac' LIMIT 1 */
	}

	public ConnectionVO SelectCommonConnectionInfo ( Map<String, Object> param ) {
		ConnectionVO conVo = new ConnectionVO( );
		conVo = (ConnectionVO) select( "CommonDAO.SelectCommonConnectionInfo", param );
		return conVo;
	}

	/* 영리 전자결재 - 지출결의 양식정보 조회 - DAO */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> CommonGetExFormListInfo (Map<String, Object> empInfo ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) list( "CommonDAO.CommonGetExFormListInfo", empInfo);
		return result;
	}

	/* 영리 전자결재 - 양식정보 조회 - DAO */
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> SelectCommonEapFormInfo ( Map<String, Object> param ) {
		Map<String, Object> result = new HashMap<String, Object>( );
		result = (Map<String, Object>) select( "CommonDAO.SelectCommonEapFormInfo", param );
		return result;
		/* SELECT `form_id`, `form_nm`, IFNULL(`form_nm_en`, `form_nm`) AS `form_nm_en`, IFNULL(`form_nm_jp`, `form_nm`) AS `form_nm_jp`, IFNULL(`form_nm_cn`, `form_nm`) AS `form_nm_cn`, IFNULL(`form_short_nm`, `form_nm`) AS `form_short_nm`, `form_tp`, `form_d_tp`, IFNULL(`form_size`, '900') AS form_size, `form_mode`, IFNULL(`form_alert`, '') AS form_alert, IFNULL(`interlock_url`, '') AS interlock_url, IFNULL(`interlock_width`, '') AS interlock_width, IFNULL(`interlock_height`, '') AS interlock_height, IFNULL(`interlock_yn`, 'N') AS interlock_yn FROM teag_form WHERE form_id = '${form_seq}' */
	}

	/* 영리 전자결재 - 양식정보 상세조회 - DAO */
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> SelectCommonEapFormDetailInfo ( Map<String, Object> params ) {
		Map<String, Object> result = new HashMap<String, Object>( );
		result = (Map<String, Object>) select( "CommonDAO.SelectCommonEapFormDetailInfo", params );
		return result;
	}

	/* 비영리 전자결재 - 양식정보 조회 - DAO */
	public EaFormVO SelectCommonEaFormInfo ( String formSeq ) {
		EaFormVO formVo = new EaFormVO( );
		formSeq = (StringUtils.isEmpty( formSeq ) ? commonCode.EMPTYSEQ : formSeq);
		formVo = (EaFormVO) select( "CommonDAO.SelectCommonEaFormInfo", formSeq );
		return formVo;
	}

	/* 전자결재 양식정보 상세 조회 (비영리) */
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> CommonEaFormInfoSelect ( Map<String, Object> params ) {
		Map<String, Object> result = new HashMap<String, Object>( );
		result = (Map<String, Object>) select( "CommonDAO.CommonEaFormInfoSelect", params );
		return result;
	}

	/* 전자결재 양식정보 상세 조회 (영리) */
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> CommonEapFormInfoSelect ( Map<String, Object> params ) {
		Map<String, Object> result = new HashMap<String, Object>( );
		result = (Map<String, Object>) select( "CommonDAO.CommonEapFormInfoSelect", params );
		return result;
	}

	/* 지출결의 옵션 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<ExOptionVO> SelectCommonExOptionInfo ( Map<String, Object> params ) {
		List<ExOptionVO> resultListVo = new ArrayList<ExOptionVO>( );
		resultListVo = (List<ExOptionVO>) list( "CommonDAO.SelectCommonExOptionInfo", params );
		return resultListVo;
	}

	/* 공통코드 - Bizbox Alpha */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> SelectCommonCodeListInfo ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) list( "CommonDAO.SelectCommonCodeListInfo", params );
		return result;
	}

	/* 사용자 지정 명칭 정보 조회 - DAO */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> SelectCommonCustomLabelInfo ( String compSeq, String langCode, String groupSeq ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		compSeq = CommonConvert.CommonGetStr( compSeq );
		Map<String, Object> params = new HashMap<String, Object>( );
		params.put( commonCode.GROUPSEQ, groupSeq );
		params.put( commonCode.COMPSEQ, compSeq );
		params.put( commonCode.LANGCODE, langCode );
		//result = (List<Map<String, Object>>) list( "CommonDAO.SelectCustomLabelListInfo", params );
		result = list( "CommonDAO.SelectCustomLabelListInfo", params );
		return result;
	}

	/* 비영리 품의결의 결재 양식 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> SelectCommonNpFormListInfo ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			if ( CommonConvert.CommonGetStr(CommonConvert.CommonGetEmpVO( ).getEaType( )).equals( "ea" ) ) {
				result = (List<Map<String, Object>>) list( "CommonDAO.SelectCommonNpEAFormListInfo", params );
			}
			else {
				result = (List<Map<String, Object>>) list( "CommonDAO.SelectCommonNpEAPFormListInfo", params );
			}
		}
		catch ( Exception e ) {
			e.printStackTrace();
		}
		return result;
	}
}
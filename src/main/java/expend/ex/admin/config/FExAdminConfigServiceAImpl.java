package expend.ex.admin.config;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sun.star.uno.Exception;

import cmm.util.MapUtil;
import common.vo.common.CommonInterface.commonCode;
import common.helper.convert.CommonConvert;
import common.vo.common.ResultVO;


/**
 *   * @FileName : FExAdminConfigServiceAImpl.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Service ( "FExAdminConfigServiceA" )
public class FExAdminConfigServiceAImpl implements FExAdminConfigService {

	/* ################################################## */
	/* 변수정의 */
	/* ################################################## */
	/* 변수정의 - DAO */
	@Resource ( name = "FExAdminConfigServiceADAO" )
	private FExAdminConfigServiceADAO dao;

	@Override
	public ResultVO ExAdminGetButtonInfoList ( Map<String, Object> param ) throws Exception {
		/* 버튼 설정내용 조회 */
		ResultVO result = new ResultVO( );
		/* 1. 해당 회사에 대하여 기초데이터 복사 */
		dao.ExAdminGetButtonInfoCopy( param );
		/* 2. 일반 데이터 조회 */
		List<Map<String, Object>> tryData = dao.ExAdminGetButtonInfoList( param );
		if ( tryData.size( ) > 0 ) {
			result.setResultCode( commonCode.SUCCESS );
			result.setAaData( tryData );
			return result;
		}
		else {
			throw new Exception( "기초데이터를 확인할 수 없습니다." );
		}
	}

	@Override
	public ResultVO ExAdminSetButtonLocationUpdate ( List<Map<String, Object>> params ) throws Exception {
		ResultVO result = new ResultVO( );
		for ( Map<String, Object> param : params ) {
			if ( dao.ExAdminSetButtonLocationUpdate( param ) == 0 ) {
				throw new Exception( "버튼 정보를 찾을 수 없습니다. 페이지를 새로고침 하세요." );
			}
		}
		result.setResultCode( commonCode.SUCCESS );
		return result;
	}

	@Override
	public ResultVO ExAdminSetButtonUpdate ( Map<String, Object> param ) throws Exception {
		ResultVO result = new ResultVO( );
		if ( dao.ExAdminSetButtonUpdate( param ) == 0 ) {
			throw new Exception( "버튼 정보를 찾을 수 없습니다. 페이지를 새로고침 하세요." );
		}
		dao.ExAdminButtonLicenseInfoUpdate( param );
		result.setResultCode( commonCode.SUCCESS );
		return result;
	}

	@Override
	public ResultVO ExAdminSetButtonCreate ( Map<String, Object> param ) throws java.lang.Exception {
		ResultVO result = new ResultVO( );
		if ( dao.ExAdminSetButtonCreate( param ) == 0 ) {
			throw new Exception( "버튼정보 생성 실패" );
		}
		result.setResultCode( commonCode.SUCCESS );
		return result;
	}

	@Override
	public ResultVO ExAdminSetButtonDelete ( Map<String, Object> param ) throws java.lang.Exception {
		ResultVO result = new ResultVO( );
		if ( dao.ExAdminSetButtonDelete( param ) == 0 ) {
			throw new Exception( "버튼정보 삭제 실패" );
		}
		result.setResultCode( commonCode.SUCCESS );
		return result;
	}

	@Override
	public ResultVO ExAdminGetFormInfoSelect ( Map<String, Object> param ) throws java.lang.Exception {
		/* 버튼 설정내용 조회 */
		ResultVO result = new ResultVO( );
		result.setaData( dao.ExAdminGetFormInfoSelect( param ) );
		return result;
	}

	/* ## 양식별 표준적요 설정 ## */
	/* ## 양식별 표준적요 설정 ## - 표준적요 등록 */
	public ResultVO ExAdminSetSummaryAuthCreate ( ResultVO result ) throws Exception {
		/* compSeq, formSeq, summaryCode */
		/* 변수정의 */
		Map<String, Object> param = new HashMap<String, Object>( );
		boolean chkParameter = true;
		/* 기본값 정의 */
		param = result.getParams( );
		/* 필수 파라미터 점검 */
		String[] parametersCheck = { commonCode.COMPSEQ, commonCode.EMPTYYES, commonCode.FORMSEQ, commonCode.EMPTYYES, "summaryCode", commonCode.EMPTYYES };
		if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
			result.setFail( "필수 입력 정보가 누락되었습니다." );
			chkParameter = false;
		}
		if ( chkParameter ) {
			/* 양식 귀속 표준적요 생성 */
			try {
				int resultCount = dao.ExAdminSetSummaryAuthCreate( param );
				/* 처리 상태값 */
				result = (resultCount > 0 ? result.setSuccess( ) : result.setFail( "" ));
			}
			catch ( java.lang.Exception e ) {
				// TODO Auto-generated catch block
				e.printStackTrace( );
				result.setFail( e.toString( ) );
			}
		}
		/* 반환 */
		return result;
	}

	/* ## 양식별 표준적요 설정 ## - 표쥰적요 삭제 */
	public ResultVO ExAdminSetSummaryAuthDelete ( ResultVO result ) throws Exception {
		/* compSeq, formSeq, summaryCode */
		/* 변수정의 */
		Map<String, Object> param = new HashMap<String, Object>( );
		boolean chkParameter = true;
		/* 기본값 정의 */
		param = result.getParams( );
		/* 필수 파라미터 점검 */
		String[] parametersCheck = { commonCode.COMPSEQ, commonCode.EMPTYYES, commonCode.FORMSEQ, commonCode.EMPTYYES, "summaryCode", commonCode.EMPTYYES };
		
		// 등록 전 삭제일 경우 파라미터에 summaryCode가 없기 때문에 필수값 체크에서 제외시킨다.
		if("Y".equals(param.get("isInsert"))) {
			List<String> list = new ArrayList<>(Arrays.asList(parametersCheck));
			list.remove(5);
			list.remove(4);
			
			parametersCheck = list.toArray(new String[list.size()]);
		}
		
		if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
			result.setFail( "필수 입력 정보가 누락되었습니다." );
			chkParameter = false;
		}
		if ( chkParameter ) {
			/* 양식 귀속 표준적요 삭제 */
			try {
				dao.ExAdminSetSummaryAuthDelete( param );
			}
			catch ( java.lang.Exception e ) {
				// TODO Auto-generated catch block
				e.printStackTrace( );
				result.setFail( e.toString( ) );
			}
		}
		/* 반환 */
		return result;
	}

	/* ## 양식별 증빙유형 설정 ## */
	/* ## 양식별 증빙유형 설정 ## - 증빙유형 등록 */
	public ResultVO ExAdminSetAuthTypeAuthCreate ( ResultVO result ) throws Exception {
		/* compSeq, formSeq, authTypeCode */
		/* 변수정의 */
		Map<String, Object> param = new HashMap<String, Object>( );
		boolean chkParameter = true;
		/* 기본값 정의 */
		param = result.getParams( );
		/* 필수 파라미터 점검 */
		String[] parametersCheck = { commonCode.COMPSEQ, commonCode.EMPTYYES, commonCode.FORMSEQ, commonCode.EMPTYYES, "authTypeCode", commonCode.EMPTYYES };
		if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
			result.setFail( "필수 입력 정보가 누락되었습니다." );
			chkParameter = false;
		}
		if ( chkParameter ) {
			try {
				/* 양식 귀속 증빙유형 생성 */
				int resultCount = dao.ExAdminSetAuthTypeAuthCreate( param );
				/* 처리 상태값 */
				result = (resultCount > 0 ? result.setSuccess( ) : result.setFail( "" ));
			}
			catch ( java.lang.Exception e ) {
				// TODO Auto-generated catch block
				e.printStackTrace( );
				result.setFail( e.toString( ) );
			}
		}
		/* 반환 */
		return result;
	}

	/* ## 양식별 증빙유형 설정 ## - 증빙유형 삭제 */
	public ResultVO ExAdminSetAuthTypeAuthDelete ( ResultVO result ) throws Exception {
		/* compSeq, formSeq, authTypeCode */
		/* 변수정의 */
		Map<String, Object> param = new HashMap<String, Object>( );
		boolean chkParameter = true;
		/* 기본값 정의 */
		param = result.getParams( );
		/* 필수 파라미터 점검 */
		String[] parametersCheck = { commonCode.COMPSEQ, commonCode.EMPTYYES, commonCode.FORMSEQ, commonCode.EMPTYYES, "authTypeCode", commonCode.EMPTYYES };
		
		// 등록 전 삭제일 경우 파라미터에 summaryCode가 없기 때문에 필수값 체크에서 제외시킨다.
		if("Y".equals(param.get("isInsert"))) {
			List<String> list = new ArrayList<>(Arrays.asList(parametersCheck));
			list.remove(5);
			list.remove(4);
			
			parametersCheck = list.toArray(new String[list.size()]);
		}
		
		if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
			result.setFail( "필수 입력 정보가 누락되었습니다." );
			chkParameter = false;
		}
		if ( chkParameter ) {
			/* 양식 귀속 증빙유형 삭제 */
			try {
				dao.ExAdminSetAuthTypeAuthDelete( param );
			}
			catch ( java.lang.Exception e ) {
				// TODO Auto-generated catch block
				e.printStackTrace( );
				result.setFail( e.toString( ) );
			}
		}
		/* 반환 */
		return result;
	}

	/* ## 양식별 증빙유형 설정 ## - 증빙유형 리스트 조회 */
	public ResultVO ExFormLinkAuthListSelect ( ResultVO result ) throws Exception {
		/* compSeq, formSeq */
		/* 변수정의 */
		Map<String, Object> param = new HashMap<String, Object>( );
		boolean chkParameter = true;
		/* 기본값 정의 */
		param = result.getParams( );
		/* 필수 파라미터 점검 */
		String[] parametersCheck = { commonCode.COMPSEQ, commonCode.EMPTYYES, commonCode.FORMSEQ, commonCode.EMPTYYES };
		if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
			result.setFail( "필수 입력 정보가 누락되었습니다." );
			chkParameter = false;
		}
		if ( chkParameter ) {
			/* 양식 별 증빙유형 리스트 조회 */
			try {
				result.setAaData( dao.ExFormLinkAuthListSelect( param ) );
				/* 처리 상태값 */
				result.setSuccess( );
			}
			catch ( java.lang.Exception e ) {
				// TODO Auto-generated catch block
				e.printStackTrace( );
				result.setAaData( new ArrayList<Map<String, Object>>( ) );
				result.setFail( e.toString( ) );
			}
		}
		/* 반환 */
		return result;
	}

	/* ## 양식별 증빙유형 설정 ## - 표준적요 리스트 조회 */
	public ResultVO ExFormLinkSummaryListSelect ( ResultVO result ) throws Exception {
		/* compSeq, formSeq */
		/* 변수정의 */
		Map<String, Object> param = new HashMap<String, Object>( );
		boolean chkParameter = true;
		/* 기본값 정의 */
		param = result.getParams( );
		/* 필수 파라미터 점검 */
		String[] parametersCheck = { commonCode.COMPSEQ, commonCode.EMPTYYES, commonCode.FORMSEQ, commonCode.EMPTYYES };
		if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
			result.setFail( "필수 입력 정보가 누락되었습니다." );
			chkParameter = false;
		}
		if ( chkParameter ) {
			/* 양식 별 표준적요 리스트 조회 */
			try {
				result.setAaData( dao.ExFormLinkSummaryListSelect( param ) );
				/* 처리 상태값 */
				result.setSuccess( );
			}
			catch ( java.lang.Exception e ) {
				// TODO Auto-generated catch block
				e.printStackTrace( );
				result.setAaData( new ArrayList<Map<String, Object>>( ) );
				result.setFail( e.toString( ) );
			}
		}
		/* 반환 */
		return result;
	}

	/* 양식 별 표준적요 & 증빙유형 설정 -설정된 표준적요 조회 */
	public ResultVO ExFormLinkSettingSummaryListSelect ( ResultVO result ) throws Exception {
		/* compSeq, formSeq */
		/* 변수정의 */
		Map<String, Object> param = new HashMap<String, Object>( );
		boolean chkParameter = true;
		/* 기본값 정의 */
		param = result.getParams( );
		/* 필수 파라미터 점검 */
		String[] parametersCheck = { "compSeq", "Y", "formSeq", "Y" };
		if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
			result.setFail( "필수 입력 정보가 누락되었습니다." );
			chkParameter = false;
		}
		if ( chkParameter ) {
			/* 정보 조회 */
			try {
				result.setAaData( (List<Map<String, Object>>) dao.ExFormLinkSettingSummaryListSelect( param ) );
			}
			catch ( java.lang.Exception e ) {
				// TODO Auto-generated catch block
				e.printStackTrace( );
			}
			/* 처리 상태값 */
			result.setSuccess( );
		}
		else {
			result.setFail( "" );
		}
		return result;
	}

	/* 양식 별 표준적요 & 증빙유형 설정 -설정된 증빙유형 조회 */
	public ResultVO ExFormLinkSettingAuthListSelect ( ResultVO result ) throws Exception {
		/* compSeq, formSeq */
		/* 변수정의 */
		Map<String, Object> param = new HashMap<String, Object>( );
		boolean chkParameter = true;
		/* 기본값 정의 */
		param = result.getParams( );
		/* 필수 파라미터 점검 */
		String[] parametersCheck = { "compSeq", "Y", "formSeq", "Y" };
		if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
			result.setFail( "필수 입력 정보가 누락되었습니다." );
			chkParameter = false;
		}
		if ( chkParameter ) {
			/* 정보 조회 */
			try {
				result.setAaData( (List<Map<String, Object>>) dao.ExFormLinkSettingAuthListSelect( param ) );
			}
			catch ( java.lang.Exception e ) {
				// TODO Auto-generated catch block
				e.printStackTrace( );
			}
			/* 처리 상태값 */
			result.setSuccess( );
		}
		else {
			result.setFail( "" );
		}
		return result;
	}

	/* 지출결의 마감일 설정 리스트 조회 */
	public ResultVO ExAdminExpendCloseDateSelect ( ResultVO result ) throws Exception {
		/* compSeq, formSeq */
		/* 변수정의 */
		Map<String, Object> param = new HashMap<String, Object>( );
		boolean chkParameter = true;
		/* 기본값 정의 */
		param = result.getParams( );
		/* 필수 파라미터 점검 */
		String[] parametersCheck = { "compSeq", "Y", "formSeq", "Y" };
		if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
			result.setFail( "필수 입력 정보가 누락되었습니다." );
			chkParameter = false;
		}
		if ( chkParameter ) {
			/* 정보 조회 */
			try {
				result.setAaData( dao.ExAdminExpendCloseSelect( param ) );
			}
			catch ( java.lang.Exception e ) {
				// TODO Auto-generated catch block
				e.printStackTrace( );
			}
			/* 처리 상태값 */
			result.setSuccess( );
		}
		else {
			result.setFail( "" );
		}
		return result;
	}

	/* 지출결의 마감일 설정 리스트 등록 */
	public ResultVO ExAdminExpendCloseDateInsert ( ResultVO result ) throws Exception {
		/* compSeq, formSeq */
		/* 변수정의 */
		Map<String, Object> param = new HashMap<String, Object>( );
		boolean chkParameter = true;
		/* 기본값 정의 */
		param = result.getParams( );
		/* 필수 파라미터 점검 */
		String[] parametersCheck = { "compSeq", "Y", "formSeq", "Y" };
		if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
			result.setFail( "필수 입력 정보가 누락되었습니다." );
			chkParameter = false;
		}
		if ( chkParameter ) {
			try {
				/* 지출결의 마감일 중복 확인 */
				List<Map<String, Object>> valChk = new ArrayList<Map<String, Object>>( );
				valChk = dao.ExAdminExpendCloseFormInsertChkValidateOneForm( param );
				if(valChk == null || valChk.size( ) == 0 ){
					/* 지출결의 마감일 설정 리스트 등록 */
					int closeSeq = dao.ExAdminExpendCloseInsert( param );
					Map<String, Object> tParam = new HashMap<String, Object>( );
					tParam = result.getParams( );
					tParam.put( "closeSeq", closeSeq );
					result.setParams( tParam );
					/* 처리 상태값 */
					result = (closeSeq > 0 ? result.setSuccess( ) : result.setFail( "" ));
				}else{
					result.setResultCode( commonCode.FAIL );
					result.setResultName( "기간 중복" );
				}
			}
			catch ( java.lang.Exception e ) {
				// TODO Auto-generated catch block
				e.printStackTrace( );
			}
		}
		else {
			result.setFail( "" );
		}
		return result;
	}
	
	/* 지출결의 마감일 설정 리스트 등록(전체양식) - 모든양식적용 시 마감기간 중 등록된 내역 있는지 확인 */
	public ResultVO ExAdminExpendCloseFormInsertChkValidate ( ResultVO result ) throws Exception {
		/* compSeq, formSeq */
		/* 변수정의 */
		Map<String, Object> param = new HashMap<String, Object>( );
		boolean chkParameter = true;
		/* 기본값 정의 */
		param = result.getParams( );
		/* 필수 파라미터 점검 */
		String[] parametersCheck = { "compSeq", "Y", "closeType", "Y", "closeFromDate", "Y", "closeToDate", "Y" };
		if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
			result.setFail( "필수 입력 정보가 누락되었습니다." );
			chkParameter = false;
		}
		if ( chkParameter ) {
			/* 정보 조회 */
			try {
				result.setAaData( dao.ExAdminExpendCloseFormInsertChkValidate( param ) );
			}
			catch ( java.lang.Exception e ) {
				// TODO Auto-generated catch block
				e.printStackTrace( );
			}
			/* 처리 상태값 */
			result.setSuccess( );
		}
		else {
			result.setFail( "" );
		}
		return result;
	}

	/* 지출결의 마감일 설정 리스트 등록(전체양식) */
	public ResultVO ExAdminExpendCloseInsertAllForm ( ResultVO result ) throws Exception {
		/* compSeq, formSeq */
		/* 변수정의 */
		Map<String, Object> param = new HashMap<String, Object>( );
		boolean chkParameter = true;
		/* 기본값 정의 */
		param = result.getParams( );
		/* 필수 파라미터 점검 */
		String[] parametersCheck = { "compSeq", "Y" };
		if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
			result.setFail( "필수 입력 정보가 누락되었습니다." );
			chkParameter = false;
		}
		if ( chkParameter ) {
			try {
				/* 마감일 겹치는 양식은 제외 */
				param.put( "exceptFormList", CommonConvert.ConvertJsonToListMap(CommonConvert.CommonGetStr(param.get("exceptFormList"))) );
				/* 지출결의 마감일 설정 리스트 등록 */
				int closeSeq = dao.ExAdminExpendCloseInsertAllForm( param );
				/* 처리 상태값 */
				result = (closeSeq == 1 ? result.setSuccess( ) : result.setFail( "" ));
			}
			catch ( java.lang.Exception e ) {
				// TODO Auto-generated catch block
				e.printStackTrace( );
				result.setFail( "" );
			}
		}
		else {
			result.setFail( "" );
		}
		return result;
	}

	/* 지출결의 마감일 설정 리스트 수정 */
	public ResultVO ExAdminExpendCloseDateUpdate ( ResultVO result ) throws Exception {
		/* compSeq, formSeq */
		/* 변수정의 */
		Map<String, Object> param = new HashMap<String, Object>( );
		boolean chkParameter = true;
		/* 기본값 정의 */
		param = result.getParams( );
		/* 필수 파라미터 점검 */
		String[] parametersCheck = { "compSeq", "Y", "formSeq", "Y" };
		if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
			result.setFail( "필수 입력 정보가 누락되었습니다." );
			chkParameter = false;
		}
		if ( chkParameter ) {
			try {
				/* 지출결의 마감일 설정 리스트 수정 */
				int resultCount = dao.ExAdminExpendCloseUpdate( param );
				/* 처리 상태값 */
				result = (resultCount > 0 ? result.setSuccess( ) : result.setFail( "" ));
			}
			catch ( java.lang.Exception e ) {
				// TODO Auto-generated catch block
				e.printStackTrace( );
			}
			/* 처리 상태값 */
			result.setSuccess( );
		}
		else {
			result.setFail( "" );
		}
		return result;
	}

	/* 지출결의 마감일 설정 리스트 삭제 */
	public ResultVO ExAdminExpendCloseDateDelete ( ResultVO result ) throws Exception {
		/* compSeq, formSeq */
		/* 변수정의 */
		Map<String, Object> param = new HashMap<String, Object>( );
		boolean chkParameter = true;
		/* 기본값 정의 */
		param = result.getParams( );
		/* 필수 파라미터 점검 */
		String[] parametersCheck = { "compSeq", "Y", "formSeq", "Y" };
		if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
			result.setFail( "필수 입력 정보가 누락되었습니다." );
			chkParameter = false;
		}
		if ( chkParameter ) {
			try {
				/* 지출결의 마감일 설정 삭제 */
				int resultCount = dao.ExAdminExpendCloseDelete( param );
				/* 처리 상태값 */
				result = (resultCount > 0 ? result.setSuccess( ) : result.setFail( "" ));
			}
			catch ( java.lang.Exception e ) {
				// TODO Auto-generated catch block
				/* 처리 상태값 */
				result.setFail( "" );
			}
			
		}
		else {
			result.setFail( "" );
		}
		return result;
	}

	/* 지출결의 마감일 이력 등록 */
	@SuppressWarnings ( "unused" )
	public ResultVO ExAdminExpendCloseDateHistoryInsert ( ResultVO result ) throws Exception {
		/* compSeq, formSeq */
		/* 변수정의 */
		Map<String, Object> param = new HashMap<String, Object>( );
		boolean chkParameter = true;
		/* 기본값 정의 */
		param = result.getParams( );
		/* 필수 파라미터 점검 */
		String[] parametersCheck = { "compSeq", "Y", "formSeq", "Y" };
		if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
			chkParameter = false;
		}
		if ( chkParameter ) {
			try {
				/* 지출결의 마감일 이력 등록 */
				int resultCount = dao.ExAdminExpendCloseHistoryInsert( param );
			}
			catch ( java.lang.Exception e ) {
				// TODO Auto-generated catch block
				e.printStackTrace( );
			}
		}
		return result;
	}
}

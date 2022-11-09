/**
  * @FileName : BAnguUserAnguServiceImpl.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.angu.user.angu;

import java.util.HashMap;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cmm.util.ErpUtil;
import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import expend.angu.user.common.BAnUserCommonService;


/**
 *   * @FileName : BAnguUserAnguServiceImpl.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Service ( "BAnguUserAnguService" )
public class BAnguUserAnguServiceImpl implements BAnguUserAnguService {

	/* 변수정의 */
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통사용 정보 */
	@Resource ( name = "BAnUserCommonService" )
	private BAnUserCommonService AnguCommon; /* 국고보조 전용 공통 */
	@Resource ( name = "FAnguUserAnguServiceI" )
	private FAnguUserAnguService AnguI;
	@Resource ( name = "FAnguUserAnguServiceA" )
	private FAnguUserAnguService AnguA;

	/* ## [+] 국고보조 v2 ## */
	/* ## [+] 국고보조 v2 ## - 국고보조 집행등록 문서 생성 */
	public ResultVO setAnguDocument_Insert ( ResultVO result ) throws Exception {
		/* return : compSeq, anbojoSeq, docSeq, anbojoStatCode, gisuDate, writeSeqe, jsonStr, erpSendYN, erpSendSeq */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr( ( ErpUtil.Chk_G20( conVo, result )).getResultCode( ) ).equals( commonCode.SUCCESS ) ) {
				/* 문서 생성 */
				result = AnguA.setAnguDocument_Insert( result );
				if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
					result.setSuccess( );
				}
				else {
					result.setaData( new HashMap<String, Object>( ) );
					result.setFail( "" );
				}
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setaData( new HashMap<String, Object>( ) );
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 국고보조 집행등록 abdocu 생성 */
	public ResultVO setAnguDocumentAbdocu_Insert ( ResultVO result, String anbojoSeq ) throws Exception {
		/* if ( MapUtil.hasKey( param, "resolve" ) ) { anguInfo.put( "resolve", CommonConvert.CommonGetJSONToListMap( CommonConvert.CommonGetStr( param.get( "resolve" ) ) ) ); } */
		/* if ( MapUtil.hasKey( param, "auth" ) ) { anguInfo.put( "auth", CommonConvert.CommonGetJSONToListMap( CommonConvert.CommonGetStr( param.get( "auth" ) ) ) ); } */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr( (ErpUtil.Chk_G20( conVo, result )).getResultCode( ) ).equals( commonCode.SUCCESS ) ) {
				/* 문서 생성 */
				result = AnguA.setAnguDocumentAbdocu_Insert( result, anbojoSeq );
				if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
					result.setSuccess( );
				}
				else {
					result.setaData( new HashMap<String, Object>( ) );
					result.setFail( "" );
				}
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			/* Abdocu T 삭제 */
			/* Abdocu B 삭제 */
			/* Abdocu 삭제 */
			result.setaData( new HashMap<String, Object>( ) );
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 국고보조 집행등록 abdocu_b 생성 */
	public ResultVO setAnguDocumentAbdocuB_Insert ( ResultVO result, String anbojoSeq, String dSeq ) throws Exception {
		/* if ( MapUtil.hasKey( param, "bimok" ) ) { anguInfo.put( "bimok", CommonConvert.CommonGetJSONToListMap( CommonConvert.CommonGetStr( param.get( "bimok" ) ) ) ); } */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr( (ErpUtil.Chk_G20( conVo, result )).getResultCode( ) ).equals( commonCode.SUCCESS ) ) {
				/* 문서 생성 */
				result = AnguA.setAnguDocumentAbdocuB_Insert( result, anbojoSeq, dSeq );
				if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
					result.setSuccess( );
				}
				else {
					result.setaData( new HashMap<String, Object>( ) );
					result.setFail( "" );
				}
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			/* Abdocu T 삭제 */
			/* Abdocu B 삭제 */
			/* Abdocu 삭제 */
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 국고보조 집행등록 abdocu_t 생성 */
	public ResultVO setAnguDocumentAbdocuT_Insert ( ResultVO result, String anbojoSeq, String dSeq, String bSeq ) throws Exception {
		/* if ( MapUtil.hasKey( param, "jaewon" ) ) { anguInfo.put( "jaewon", CommonConvert.CommonGetJSONToListMap( CommonConvert.CommonGetStr( param.get( "jaewon" ) ) ) ); } */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr( (ErpUtil.Chk_G20( conVo, result )).getResultCode( ) ).equals( commonCode.SUCCESS ) ) {
				/* 문서 생성 */
				result = AnguA.setAnguDocumentAbdocuT_Insert( result, anbojoSeq, dSeq, bSeq );
				if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
					result.setSuccess( );
				}
				else {
					result.setaData( new HashMap<String, Object>( ) );
					result.setFail( "" );
				}
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			/* Abdocu T 삭제 */
			/* Abdocu B 삭제 */
			/* Abdocu 삭제 */
		}
		return result;
	}
	/* ## [-] 국고보조 v2 ## */

	/* 국고보조 결의집행 작성 */
	/* --------------------------------------- */
	/* iCUBE 환경설정 정보 조회 - 거래처통장표시내용, 보조금통장표시내용 */
	public ResultVO TermInfoS ( ResultVO result ) throws Exception {
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result = (ResultVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetEmpInfo( ), result );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getCompSeq( ) ) );
			/* 프로세스 진행 */
			if ( CommonConvert.CommonGetStr(AnguCommon.AnCommonCheck( conVo, result ).getResultCode( )).equals( commonCode.SUCCESS ) ) {
				/* 프로세스 진행 */
				result = AnguI.TermInfoS( result, conVo );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 국고보조 집행등록 문서 생성 */
	public ResultVO AnguI ( ResultVO result ) throws Exception {
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result = (ResultVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetEmpInfo( ), result );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getCompSeq( ) ) );
			/* 프로세스 진행 */
			if ( CommonConvert.CommonGetStr(AnguCommon.AnCommonCheck( conVo, result ).getResultCode( )).equals( commonCode.SUCCESS ) ) {
				/* 프로세스 진행 */
				result = AnguA.AnguI( result, conVo );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 국고보조 집행등록 인력정보 등록 생성 */
	public ResultVO AnguPayI ( ResultVO result ) throws Exception {
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result = (ResultVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetEmpInfo( ), result );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getCompSeq( ) ) );
			/* 프로세스 진행 */
			if ( CommonConvert.CommonGetStr(AnguCommon.AnCommonCheck( conVo, result ).getResultCode( )).equals( commonCode.SUCCESS ) ) {
				/* 프로세스 진행 */
				result = AnguA.AnguPayI( result, conVo );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 국고보조 집행등록 문서 갱신 */
	public ResultVO AnguU ( ResultVO result ) throws Exception {
		try {
			/* 변수정의 */
			@SuppressWarnings ( "unused" )
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result = (ResultVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetEmpInfo( ), result );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getCompSeq( ) ) );
			/* 프로세스 진행 */
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 국고보조 집행등록 기수 정보 조회 */
	public ResultVO GisuInfoS ( ResultVO result ) throws Exception {
		try {
			/* 변수정의 */
			@SuppressWarnings ( "unused" )
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result = (ResultVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetEmpInfo( ), result );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getCompSeq( ) ) );
			/* 프로세스 진행 */
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 국고보조 집행등록 사용자 정보 조회 */
	public ResultVO EmpInfoS ( ResultVO result ) throws Exception {
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result = (ResultVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetEmpInfo( ), result );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getCompSeq( ) ) );
			/* 프로세스 진행 */
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr(AnguCommon.AnCommonCheck( conVo, result ).getResultCode( )).equals( commonCode.SUCCESS ) ) {
				/* 프로세스 진행 */
				AnguI.EmpInfoS( result, conVo );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 국고보조 집행등록 전자결재 상신 준비 */
	public ResultVO AnguApprovalI ( ResultVO result ) throws Exception {
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result = (ResultVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetEmpInfo( ), result );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getCompSeq( ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr(AnguCommon.AnCommonCheck( conVo, result ).getResultCode( )).equals( commonCode.SUCCESS ) ) {
				/* 프로세스 진행 */
				result = AnguA.AnguApprovalI( result, conVo );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 국고보조 결의집행 iCUBE 생성 */
	/* --------------------------------------- */
	/* 결의내역 + 증빙내역 생성 */
	public ResultVO AbdocuHDI ( ResultVO result ) throws Exception {
		return result;
	}

	/* 비목내역 생성 */
	public ResultVO AbdocuBI ( ResultVO result ) throws Exception {
		return result;
	}

	/* 재원정보 생성 */
	public ResultVO AbdocuTI ( ResultVO result ) throws Exception {
		return result;
	}

	/* 인력정보 등록 */
	public ResultVO AbdocuPayI ( ResultVO result ) throws Exception {
		return result;
	}

	/* 국고보조 결의집행 iCUBE, Bizbox Alpha 동기화 */
	/* --------------------------------------- */
	/* iCUBE + Bizbox Alpha 결의내역 동기화 */
	public ResultVO AbdocuSyncU ( ResultVO result ) throws Exception {
		return result;
	}

	/* 상신전 오류 발생시 삭제 처리 */
	public ResultVO AbdocuApprovalDel ( ResultVO result ) throws Exception {
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result = (ResultVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetEmpInfo( ), result );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getCompSeq( ) ) );
			/* ERP 연동 확인 */
			if (CommonConvert.CommonGetStr( AnguCommon.AnCommonCheck( conVo, result ).getResultCode( )).equals( commonCode.SUCCESS ) ) {
				/* 프로세스 진행 */
				result = AnguA.AbdocuApprovalDel( result );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}
}

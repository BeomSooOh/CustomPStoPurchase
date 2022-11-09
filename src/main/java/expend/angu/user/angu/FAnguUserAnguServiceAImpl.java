/**
  * @FileName : FAnguUserAnguServiceAImpl.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.angu.user.angu;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cmm.util.MapUtil;
import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import expend.angu.user.common.BAnUserCommonService;


/**
 *   * @FileName : FAnguUserAnguServiceAImpl.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Service ( "FAnguUserAnguServiceA" )
public class FAnguUserAnguServiceAImpl implements FAnguUserAnguService {

	/* 변수정의 */
	@Resource ( name = "BAnUserCommonService" )
	private BAnUserCommonService AnguCommon; /* 국고보조 전용 공통 */
	@Resource ( name = "FAnguUserAnguServiceADAO" )
	private FAnguUserAnguServiceADAO dao; /* 국고보조 집행등록 */


	/* ## [+] 국고보조 v2 ## */
	/* ## [+] 국고보조 v2 ## - 국고보조 집행등록 문서 생성 */
	public ResultVO setAnguDocument_Insert ( ResultVO result ) throws Exception {
		/* return : compSeq, anbojoSeq, docSeq, anbojoStatCode, gisuDate, writeSeqe, jsonStr, erpSendYN, erpSendSeq */
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			Map<String, Object> param = new HashMap<String, Object>( );
			/* 기본값 정의 */
			param = result.getParams( );
			/* 필수 파라미터 검증 */
			String[] parametersCheck = { "compSeq", "Y", "formSeq", "Y", "empSeq", "Y" };
			if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
				result.setFail( "필수 입력 정보가 누락되었습니다." );
				chkParameter = false;
			}
			/* 문서 생성 */
			if ( chkParameter ) {
				result.setaData( dao.setAnguDocument_Insert( param ) );
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 국고보조 집행등록 abdocu 생성 */
	@SuppressWarnings ( "unused" )
	public ResultVO setAnguDocumentAbdocu_Insert ( ResultVO result, String anbojoSeq ) throws Exception {
		/* if ( MapUtil.hasKey( param, "resolve" ) ) { anguInfo.put( "resolve", CommonConvert.CommonGetJSONToListMap( CommonConvert.CommonGetStr( param.get( "resolve" ) ) ) ); } */
		/* if ( MapUtil.hasKey( param, "auth" ) ) { anguInfo.put( "auth", CommonConvert.CommonGetJSONToListMap( CommonConvert.CommonGetStr( param.get( "auth" ) ) ) ); } */
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			Map<String, Object> empInfo = new HashMap<String, Object>( );
			List<Map<String, Object>> resolveList = new ArrayList<Map<String, Object>>( );
			List<Map<String, Object>> authList = new ArrayList<Map<String, Object>>( );
			/* 기본값 정의 */
			result.setSuccess( );
			resolveList = CommonConvert.CommonGetJSONToListMap( CommonConvert.CommonGetStr( result.getParams( ).get( "resolve" ) ) );
			authList = CommonConvert.CommonGetJSONToListMap( CommonConvert.CommonGetStr( result.getParams( ).get( "auth" ) ) );
			empInfo = CommonConvert.CommonGetJSONToMap( CommonConvert.CommonGetStr( result.getParams( ).get( "empInfo" ) ) );
			/* 기존 등록 내역 삭제 */
			dao.setAnguDocumentAbdocu_Delete( result.getParams( ) );
			/* 국고보조 집행등록 문서 생성 */
			for ( Map<String, Object> resolveMap : resolveList ) {
				if ( CommonConvert.CommonGetSeq( resolveMap.get( "anbojoSeq" ) ).equals( anbojoSeq ) ) {
					for ( Map<String, Object> authMap : authList ) {
						if ( CommonConvert.CommonGetSeq( resolveMap.get( "dSeq" ) ).equals( CommonConvert.CommonGetSeq( authMap.get( "dSeq" ) ) ) ) {
							/* Abdocu Insert */
							Map<String, Object> param = new HashMap<String, Object>( );
							param = CommonConvert.CommonSetMapCopy( resolveMap, param );
							param = CommonConvert.CommonSetMapCopy( authMap, param );
							param = CommonConvert.CommonSetMapCopy( empInfo, param );
							dao.setAnguDocumentAbdocu_Insert( param );
							/* Abdocu B Insert */
							result = setAnguDocumentAbdocuB_Insert( result, anbojoSeq, CommonConvert.CommonGetSeq( param.get( "dSeq" ) ) );
							if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
								throw new Exception( );
							}
						}
					}
				}
			}
			result.setSuccess( );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			/* 등록내역 삭제 */
			dao.setAnguDocumentAbdocu_Delete( result.getParams( ) );
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 국고보조 집행등록 abdocu_b 생성 */
	@SuppressWarnings ( "unused" )
	public ResultVO setAnguDocumentAbdocuB_Insert ( ResultVO result, String anbojoSeq, String dSeq ) throws Exception {
		/* if ( MapUtil.hasKey( param, "bimok" ) ) { anguInfo.put( "bimok", CommonConvert.CommonGetJSONToListMap( CommonConvert.CommonGetStr( param.get( "bimok" ) ) ) ); } */
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			Map<String, Object> empInfo = new HashMap<String, Object>( );
			List<Map<String, Object>> bimokList = new ArrayList<Map<String, Object>>( );
			/* 기본값 정의 */
			result.setSuccess( );
			bimokList = CommonConvert.CommonGetJSONToListMap( CommonConvert.CommonGetStr( result.getParams( ).get( "bimok" ) ) );
			empInfo = CommonConvert.CommonGetJSONToMap( CommonConvert.CommonGetStr( result.getParams( ).get( "empInfo" ) ) );
			for ( Map<String, Object> bimokMap : bimokList ) {
				if ( CommonConvert.CommonGetSeq( bimokMap.get( "anbojoSeq" ) ).equals( anbojoSeq ) ) {
					if ( CommonConvert.CommonGetSeq( bimokMap.get( "dSeq" ) ).equals( dSeq ) ) {
						/* Abdocu B Insert */
						bimokMap = CommonConvert.CommonSetMapCopy( empInfo, bimokMap );
						dao.setAnguDocumentAbdocuB_Insert( bimokMap );
						/* Abdocu T Insert */
						result = setAnguDocumentAbdocuT_Insert( result, anbojoSeq, dSeq, CommonConvert.CommonGetSeq( bimokMap.get( "bSeq" ) ) );
						if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
							throw new Exception( );
						}
					}
				}
			}
			result.setSuccess( );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			/* 등록내역 삭제 */
			dao.setAnguDocumentAbdocu_Delete( result.getParams( ) );
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 국고보조 집행등록 abdocu_t 생성 */
	@SuppressWarnings ( "unused" )
	public ResultVO setAnguDocumentAbdocuT_Insert ( ResultVO result, String anbojoSeq, String dSeq, String bSeq ) throws Exception {
		/* if ( MapUtil.hasKey( param, "jaewon" ) ) { anguInfo.put( "jaewon", CommonConvert.CommonGetJSONToListMap( CommonConvert.CommonGetStr( param.get( "jaewon" ) ) ) ); } */
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			Map<String, Object> empInfo = new HashMap<String, Object>( );
			List<Map<String, Object>> jaewonList = new ArrayList<Map<String, Object>>( );
			/* 기본값 정의 */
			result.setSuccess( );
			jaewonList = CommonConvert.CommonGetJSONToListMap( CommonConvert.CommonGetStr( result.getParams( ).get( "jaewon" ) ) );
			empInfo = CommonConvert.CommonGetJSONToMap( CommonConvert.CommonGetStr( result.getParams( ).get( "empInfo" ) ) );
			for ( Map<String, Object> jaewonMap : jaewonList ) {
				if ( CommonConvert.CommonGetSeq( jaewonMap.get( "anbojoSeq" ) ).equals( anbojoSeq ) ) {
					if ( CommonConvert.CommonGetSeq( jaewonMap.get( "dSeq" ) ).equals( dSeq ) ) {
						if ( CommonConvert.CommonGetSeq( jaewonMap.get( "bSeq" ) ).equals( bSeq ) ) {
							/* Abdocu T Insert */
							jaewonMap = CommonConvert.CommonSetMapCopy( empInfo, jaewonMap );
							dao.setAnguDocumentAbdocuT_Insert( jaewonMap );
						}
					}
				}
			}
			result.setSuccess( );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			/* 등록내역 삭제 */
			dao.setAnguDocumentAbdocu_Delete( result.getParams( ) );
			result.setFail( e.toString( ) );
		}
		return result;
	}
	/* ## [-] 국고보조 v2 ## */

	/* iCUBE 환경설정 정보 조회 - 거래처통장표시내용, 보조금통장표시내용 */
	@Override
	public ResultVO TermInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception {
		result.setResultCode( commonCode.FAIL );
		result.setResultName( "iCUBE G20 전용 기능입니다." );
		return result;
	}

	/* 국고보조 집행등록 문서 생성 */
	@Override
	public ResultVO AnguI ( ResultVO result, ConnectionVO conVo ) throws Exception {
		try {
			/* 변수정의 */
			Map<String, Object> params = new HashMap<String, Object>( );
			params = (Map<String, Object>) result.getParams( );
			/* 기본값 정의 */
			/* 파라미터 검증 */
			/* Bizbox Alpha 회사 시퀀스 */
			result = AnguCommon.AnCommonCheckParam( result, params, commonCode.COMPSEQ );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* Bizbox Alpha 부서 시퀀스 */
			result = AnguCommon.AnCommonCheckParam( result, params, commonCode.DEPTSEQ );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* Bizbox Alpha 사용자 시퀀스 */
			result = AnguCommon.AnCommonCheckParam( result, params, commonCode.EMPSEQ );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* ERP 회사 코드 */
			result = AnguCommon.AnCommonCheckParam( result, params, commonCode.ERPCOMPSEQ );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* ERP 회사 명칭 */
			result = AnguCommon.AnCommonCheckParam( result, params, commonCode.ERPCOMPNAME );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* ERP 사업장 코드 */
			result = AnguCommon.AnCommonCheckParam( result, params, commonCode.ERPBIZSEQ );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* ERP 사업장 명칭 */
			result = AnguCommon.AnCommonCheckParam( result, params, commonCode.ERPBIZNAME );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* ERP 부서 코드 */
			result = AnguCommon.AnCommonCheckParam( result, params, commonCode.ERPDEPTSEQ );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* ERP 부서 명칭 */
			result = AnguCommon.AnCommonCheckParam( result, params, commonCode.ERPDEPTNAME );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* ERP 사원 번호 */
			result = AnguCommon.AnCommonCheckParam( result, params, commonCode.ERPEMPSEQ );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* ERP 사원 명 */
			result = AnguCommon.AnCommonCheckParam( result, params, commonCode.ERPEMPNAME );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* 데이터 생성 */
			result.setaData( dao.AnguI( params ) );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 국고보조 집행등록 인력정보 등록 생성 */
	@Override
	public ResultVO AnguPayI ( ResultVO result, ConnectionVO conVo ) throws Exception {
		try {
			/* 변수정의 */
			Map<String, Object> params = new HashMap<String, Object>( );
			List<Map<String, Object>> listParams = new ArrayList<Map<String, Object>>( );
			params = (Map<String, Object>) result.getParams( );
			boolean inputFirst = true;
			/* 기본값 정의 */
			listParams = CommonConvert.CommonGetJSONToListMap( CommonConvert.CommonGetStr( params.get( "parameters" ) ) );
			for ( Map<String, Object> map : listParams ) {
				if ( inputFirst ) {
					dao.AbdocuPD( map );
					inputFirst = !inputFirst;
				}
				map.put( "erpCompSeq", result.getErpCompSeq( ) );
				map.put( "intrfcId", "IF-EXE-EFR-0221" );
				/* map.put( "etcdivCd", result.getErpBizSeq( ) ); */
				/* 데이터 생성 */
				dao.AbdocuPI( map );
			}
			result.setResultCode( commonCode.SUCCESS );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 국고보조 집행등록 문서 갱신 */
	@Override
	public ResultVO AnguU ( ResultVO result, ConnectionVO conVo ) throws Exception {
		try {
			// do nothing
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 국고보조 집행등록 기수 정보 조회 */
	@Override
	public ResultVO GisuInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception {
		try {
			// do nothing
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 국고보조 집행등록 사용자 정보 조회 */
	@Override
	public ResultVO EmpInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception {
		try {
			// do nothing
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 국고보조 집행등록 전자결재 상신 준비 */
	@Override
	public ResultVO AnguApprovalI ( ResultVO result, ConnectionVO conVo ) throws Exception {
		Map<String, Object> anbojo = new HashMap<String, Object>( ); /* 국고보조 마스터 */
		try {
			/* 변수정의 */
			Map<String, Object> resultParams = new HashMap<String, Object>( );
			Map<String, Object> params = new HashMap<String, Object>( );
			List<Map<String, Object>> abdocu = new ArrayList<Map<String, Object>>( ); /* 국고보조 집행등록 */
			List<Map<String, Object>> abdocuSub = new ArrayList<Map<String, Object>>( ); /* 국고보조 집행등록 */
			List<Map<String, Object>> abdocuB = new ArrayList<Map<String, Object>>( );
			List<Map<String, Object>> abdocuT = new ArrayList<Map<String, Object>>( );
			@SuppressWarnings ( "unused" )
			List<Map<String, Object>> abdocuP = new ArrayList<Map<String, Object>>( ); /* 인력정보 */
			/* 기본값 정의 */
			resultParams = result.getParams( );
			String keyAttribute = commonCode.EMPTYSTR;
			Iterator<String> itr = resultParams.keySet( ).iterator( );
			while ( itr.hasNext( ) ) {
				keyAttribute = (String) itr.next( );
				if ( keyAttribute.contains( "jaewon" ) ) {
					/* 재원내역 */
					abdocuT.add( CommonConvert.CommonGetJSONToMap( CommonConvert.CommonGetStr( resultParams.get( keyAttribute ) ) ) );
				}
				else if ( keyAttribute.contains( "bimok" ) ) {
					/* 비목내역 */
					abdocuB.add( CommonConvert.CommonGetJSONToMap( CommonConvert.CommonGetStr( resultParams.get( keyAttribute ) ) ) );
				}
				else if ( keyAttribute.contains( "auth" ) ) {
					/* 증빙내역 */
					abdocuSub.add( CommonConvert.CommonGetJSONToMap( CommonConvert.CommonGetStr( resultParams.get( keyAttribute ) ) ) );
				}
				else if ( keyAttribute.contains( "resolve" ) ) {
					/* 결의내역 */
					abdocu.add( CommonConvert.CommonGetJSONToMap( CommonConvert.CommonGetStr( resultParams.get( keyAttribute ) ) ) );
				}
				else if ( keyAttribute.contains( "anbojo" ) ) {
					/* 국고보조 집행등록 */
					anbojo = CommonConvert.CommonGetJSONToMap( CommonConvert.CommonGetStr( resultParams.get( keyAttribute ) ) );
				}
			}
			/* 결의내역 등록 >> t_ex_anbojo_abdocu */
			for ( Map<String, Object> map : abdocu ) {
				// AbdocuI
				params = map;
				CommonConvert.CommonSetMapCopy( anbojo, params );
				String mSeq = CommonConvert.CommonGetStr( params.get( "mSeq" ) );
				params.put( "dSeq", mSeq );
				params.put( "ipAddress", result.getIpAddress( ) );
				params.put( "prufSeNo", CommonConvert.CommonGetStr( params.get( "prufSeNo" ) ) );
				params.put( "cardNo", CommonConvert.CommonGetStr( params.get( "cardNo" ) ) );
				params.put( "ctrCd", CommonConvert.CommonGetStr( params.get( "ctrCd" ) ) );
				dao.AbdocuI( params );
			}
			/* 증빙내역 등록 >> t_ex_anbojo_abdocu */
			for ( Map<String, Object> map : abdocuSub ) {
				// AbdocuSubI
				params = map;
				CommonConvert.CommonSetMapCopy( anbojo, params );
				String mSeq = CommonConvert.CommonGetStr( params.get( "mSeq" ) );
				params.put( "dSeq", mSeq );
				params.put( "ipAddress", result.getIpAddress( ) );
				dao.AbdocuSubI( params );
			}
			/* 비목내역 등록 >> t_ex_anbojo_abdocu_b */
			for ( Map<String, Object> map : abdocuB ) {
				// AbdocuBI
				params = map;
				CommonConvert.CommonSetMapCopy( anbojo, params );
				String mSeq = CommonConvert.CommonGetStr( params.get( "mSeq" ) );
				params.put( "dSeq", mSeq );
				String bSeq = CommonConvert.CommonGetStr( params.get( "sSeq" ) );
				params.put( "bSeq", bSeq );
				params.put( "ipAddress", result.getIpAddress( ) );
				dao.AbdocuBI( params );
			}
			/* 재원내역 등록 >> t_ex_anbojo_abdocu_t */
			for ( Map<String, Object> map : abdocuT ) {
				if ( !(CommonConvert.CommonGetStr( map.get( "fnrscseDCode" ) ).equals( "" )) ) {
					// AbdocuTI
					params = map;
					CommonConvert.CommonSetMapCopy( anbojo, params );
					String tSeq = CommonConvert.CommonGetStr( params.get( "dSeq" ) );
					params.put( "tSeq", tSeq );
					String bSeq = CommonConvert.CommonGetStr( params.get( "sSeq" ) );
					params.put( "bSeq", bSeq );
					String mSeq = CommonConvert.CommonGetStr( params.get( "mSeq" ) );
					params.put( "dSeq", mSeq );
					params.put( "ipAddress", result.getIpAddress( ) );
					/* convert double */
					params.put( "splpc", CommonConvert.CommonGetDouble( params.get( "splpc" ) ) );
					params.put( "vat", CommonConvert.CommonGetDouble( params.get( "vat" ) ) );
					params.put( "amount", CommonConvert.CommonGetDouble( params.get( "amount" ) ) );
					dao.AbdocuTI( params );
				}
			}
			result.setResultCode( commonCode.SUCCESS );
			result.setResultName( "처리되었습니다." );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			dao.AbdocuException( anbojo );
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 상신전 오류 발생시 삭제 처리 */
	public ResultVO AbdocuApprovalDel ( ResultVO result ) throws Exception {
		try {
			/* 변수정의 */
			Map<String, Object> params = new HashMap<String, Object>( );
			params = (Map<String, Object>) result.getParams( );
			/* 파라미터 검증 */
			result = AnguCommon.AnCommonCheckParam( result, params, "anbojoSeq" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* 데이터 삭제 */
			result.getaData( ).put( "deleteCount", dao.AbdocuApprovalDel( params ) );
			result.setResultCode( commonCode.SUCCESS );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}
}
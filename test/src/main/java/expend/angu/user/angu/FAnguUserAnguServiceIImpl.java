/**
  * @FileName : FAnguUserAnguServiceIImpl.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.angu.user.angu;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import expend.angu.user.common.BAnUserCommonService;


/**
 *   * @FileName : FAnguUserAnguServiceIImpl.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Service ( "FAnguUserAnguServiceI" )
public class FAnguUserAnguServiceIImpl implements FAnguUserAnguService {

	/* 변수정의 */
	@Resource ( name = "BAnUserCommonService" )
	private BAnUserCommonService AnguCommon; /* 국고보조 전용 공통 */
	@Resource ( name = "FAnguUserAnguServiceIDAO" )
	private FAnguUserAnguServiceIDAO dao; /* 국고보조 집행등록 */


	/* ## [+] 국고보조 v2 ## */
	/* ## [+] 국고보조 v2 ## - 국고보조 집행등록 문서 생성 */
	public ResultVO setAnguDocument_Insert ( ResultVO result ) throws Exception {
		/* return : compSeq, anbojoSeq, docSeq, anbojoStatCode, gisuDate, writeSeqe, jsonStr, erpSendYN, erpSendSeq */
		result.setFail( "해당 기능은 Bizbox Alpha 전용 기능입니다. iCUBE G20은 지원하지 않습니다." );
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 국고보조 집행등록 abdocu 생성 */
	@Override
	public ResultVO setAnguDocumentAbdocu_Insert ( ResultVO result, String anbojoSeq ) throws Exception {
		result.setFail( "해당 기능은 Bizbox Alpha 전용 기능입니다. iCUBE G20은 지원하지 않습니다." );
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 국고보조 집행등록 abdocu_b 생성 */
	@Override
	public ResultVO setAnguDocumentAbdocuB_Insert ( ResultVO result, String anbojoSeq, String dSeq ) throws Exception {
		result.setFail( "해당 기능은 Bizbox Alpha 전용 기능입니다. iCUBE G20은 지원하지 않습니다." );
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 국고보조 집행등록 abdocu_t 생성 */
	@Override
	public ResultVO setAnguDocumentAbdocuT_Insert ( ResultVO result, String anbojoSeq, String dSeq, String bSeq ) throws Exception {
		result.setFail( "해당 기능은 Bizbox Alpha 전용 기능입니다. iCUBE G20은 지원하지 않습니다." );
		return result;
	}
	/* ## [-] 국고보조 v2 ## */

	/* iCUBE 환경설정 정보 조회 - 거래처통장표시내용, 보조금통장표시내용 */
	public ResultVO TermInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception {
		try {
			/* 변수정의 */
			Map<String, Object> params = new HashMap<String, Object>( );
			params = (Map<String, Object>) result.getParams( );
			/* 기본값 정의 */
			params.put( "LANGKIND", "KOR" );
			params.put( "CO_CD", result.getErpCompSeq( ) );
			result.setParams( params );
			/* 파라미터 검증 */
			result = AnguCommon.AnCommonCheckParam( result, params, commonCode.ERPCOMPSEQ );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "LANGKIND" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* 데이터 조회 */
			result.setaData( dao.TermInfoS( params, conVo ) );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 국고보조 집행등록 문서 생성 */
	@Override
	public ResultVO AnguI ( ResultVO result, ConnectionVO conVo ) throws Exception {
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

	/* 국고보조 집행등록 인력정보 등록 생성 */
	@Override
	public ResultVO AnguPayI ( ResultVO result, ConnectionVO conVo ) throws Exception {
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
	public ResultVO EmpInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception {
		try {
			/* 변수정의 */
			Map<String, Object> params = new HashMap<String, Object>( );
			params = (Map<String, Object>) result.getParams( );
			result.setParams( params );
			/* 파라미터 검증 */
			if ( CommonConvert.CommonGetStr( result.getErpEmpSeq( ) ).equals( "" ) ) {
				result.setResultCode( commonCode.FAIL );
				result.setResultName( "사용자의  ERP 사원정보가 없습니다." );
				return result;
			}
			else {
				params.put( "erpEmpSeq", CommonConvert.CommonGetStr( result.getErpEmpSeq( ) ) );
			}
			if ( CommonConvert.CommonGetStr( result.getErpCompSeq( ) ).equals( "" ) ) {
				result.setResultCode( commonCode.FAIL );
				result.setResultName( "사용자의  ERP 회사정보가 없습니다." );
				return result;
			}
			else {
				params.put( "erpCompSeq", CommonConvert.CommonGetStr( result.getErpCompSeq( ) ) );
			}
			/* 데이터 조회 */
			result.setaData( dao.EmpInfoS( params, conVo ) );
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
		return result;
	}

	/* 상신전 오류 발생시 삭제 처리 */
	public ResultVO AbdocuApprovalDel ( ResultVO result ) throws Exception {
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
}
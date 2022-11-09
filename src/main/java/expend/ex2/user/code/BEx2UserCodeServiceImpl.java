/**
  * @FileName : BEx2UserCodeServiceImpl.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ex2.user.code;

import java.util.ArrayList;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


/**
 *   * @FileName : BEx2UserCodeServiceImpl.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Service ( "BEx2UserCodeServiceImpl" )
public class BEx2UserCodeServiceImpl implements BEx2UserCodeService {

	@Resource ( name = "FEx2UserCodeServiceU" )
	private FEx2UserCodeService codeU;
	@Resource ( name = "FEx2UserCodeServiceA" )
	private FEx2UserCodeService codeA;
	@Resource ( name = "CommonInfo" )
	CommonInfo cmInfo;

	/* 공통코드 조회 */
	public ResultVO getCommonCodeListSelect ( ResultVO result ) throws Exception {
		/* parameters : sourceType, codeType */
		/* return : masterCode, masterCodeName, detailCode, detailCodeName */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			/* 조회 대상 분기 */
			switch ( CommonConvert.CommonGetStr( result.getParams( ).get( "sourceType" ) ) ) {
				case commonCode.BIZBOXA:
					/* Bizbox Alpha 공통코드 조회 */
					result.setAaData( new ArrayList<Map<String, Object>>( ) );
					result.setFail( "Bizbox Alpha 는 지원되지 않는 기능입니다." );
					break;
				case commonCode.ICUBE:
					/* iCUBE 공통코드 조회 */
					result.setAaData( new ArrayList<Map<String, Object>>( ) );
					result.setFail( "iCUBE 는 지원되지 않는 기능입니다." );
					break;
				case commonCode.ERPIU:
					/* ERPiU 공통코드 조회 */
					result = codeU.getCommonCodeListSelect( conVo, result );
					break;
				case commonCode.ETC:
					/* 기타 ERP 공통코드 조회 */
					result.setAaData( new ArrayList<Map<String, Object>>( ) );
					result.setFail( "기타 ERP 는 지원되지 않는 기능입니다." );
					break;
				default:
					result.setAaData( new ArrayList<Map<String, Object>>( ) );
					result.setFail( "codeType 이 정의되지 않았습니다." );
					break;
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setAaData( new ArrayList<Map<String, Object>>( ) );
			result.setFail( e.toString( ) );
		}
		return result;
	}

	@Override
	public ResultVO insertEntertainmentFee ( ResultVO result ) throws Exception {
		/* 변수정의 */
		ConnectionVO conVo = new ConnectionVO( );
		try {
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			result = codeA.insertEntertainmentFee( conVo, result );
		}
		catch ( Exception ex ) {
			result.setFail( "접대비 부표 저장 실패", ex );
		}
		return result;
	}

	@Override
	public ResultVO updateEntertainmentFee ( ResultVO result ) throws Exception {
		/* 변수정의 */
		ConnectionVO conVo = new ConnectionVO( );
		try {
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			result = codeA.updateEntertainmentFee( conVo, result );
		}
		catch ( Exception ex ) {
			result.setFail( "접대비 부표 저장 실패", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectEntertainmentFee ( ResultVO result ) throws Exception {
		/* 변수정의 */
		ConnectionVO conVo = new ConnectionVO( );
		try {
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			result = codeA.selectEntertainmentFee( conVo, result );
		}
		catch ( Exception ex ) {
			result.setFail( "접대비 부표 저장 실패", ex );
		}
		return result;
	}
}

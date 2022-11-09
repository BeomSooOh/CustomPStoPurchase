/**
  * @FileName : BEx2UserExpendServiceImpl.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ex2.user.expend;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


/**
 *   * @FileName : BEx2UserExpendServiceImpl.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Service ( "BEx2UserExpendServiceImpl" )
public class BEx2UserExpendServiceImpl implements BEx2UserExpendService {

	@Resource ( name = "FEx2UserExpendServiceA" )
	private FEx2UserExpendService expendA;

	/* 접대비등록 생성 / 수정 / 삭제 / 조회 */
	public ResultVO setEntertainmentFee ( ResultVO result ) throws Exception {
		/* parameters : (생성,수정,삭제,조회) 여부, 발생일자, 사용구분코드, 사용구분명칭, 증빙구분코드, 증빙구분명칭, 신용카드번호, 신용카드명칭, 접대상태코드, 접대상대명칭, 사업자번호, 대표자, 주민번호, 사용금액, 금액초과, 물품대, 봉사료, 접대내역, 비고 */
		/* return : */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			/* 프로세스 처리 분기 */
			switch ( CommonConvert.CommonGetStr( result.getParams( ).get( "(등록,수정,삭제) 여부" ) ) ) {
				case "생성":
					result = expendA.setEntertainmentFeeInsert( );
					break;
				case "수정":
					result = expendA.setEntertainmentFeeUpdate( );
					break;
				case "삭제":
					result = expendA.setEntertainmentFeeDelete( );
					break;
				case "조회":
					result = expendA.setEntertainmentFeeSelect( );
					break;
				default:
					result.setFail( "처리 프로세스가 정의되지 않았습니다." );
					break;
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}
}

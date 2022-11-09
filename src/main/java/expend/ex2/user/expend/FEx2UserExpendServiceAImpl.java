/**
  * @FileName : FEx2UserExpendServiceAImpl.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ex2.user.expend;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.vo.common.ResultVO;


/**
 *   * @FileName : FEx2UserExpendServiceAImpl.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Service ( "FEx2UserExpendServiceA" )
public class FEx2UserExpendServiceAImpl implements FEx2UserExpendService {

	@Resource ( name = "FEx2UserExpendServiceADAO" )
	private FEx2UserExpendServiceADAO dao;

	/* 접대비등록 생성 */
	public ResultVO setEntertainmentFeeInsert ( ) throws Exception {
		return null;
	}

	/* 접대비등록 수정 */
	public ResultVO setEntertainmentFeeUpdate ( ) throws Exception {
		return null;
	}

	/* 접대비등록 삭제 */
	public ResultVO setEntertainmentFeeDelete ( ) throws Exception {
		return null;
	}

	/* 접대비등록 조회 */
	public ResultVO setEntertainmentFeeSelect ( ) throws Exception {
		return null;
	}
}

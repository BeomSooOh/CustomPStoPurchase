/**
  * @FileName : BEx2AdminConfigService.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ex2.admin.config;

import common.vo.common.ResultVO;


/**
 *   * @FileName : BEx2AdminConfigService.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
public interface BEx2AdminConfigService {

	/* 관리자 - 표준적요 설정 - 조회 ( list ) */
	ResultVO getConfigSummaryListSelect ( ResultVO result ) throws Exception;

	/* 관리자 - 표준적요 설정 - 조회 ( map ) */
	ResultVO getConfigSummarySelect ( ResultVO result ) throws Exception;

	/* 관리자 - 표준적요 설정 - 삭제 ( list ) */
	ResultVO setConfigSummaryListDelete ( ResultVO result ) throws Exception;

	/* 관리자 - 표준적요 설정 - 삭제 ( map ) */
	ResultVO setConfigSummaryDelete ( ResultVO result ) throws Exception;

	/* 관리자 - 표준적요 설정 - 수정 ( map ) */
	ResultVO setConfigSummaryUpdate ( ResultVO result ) throws Exception;
}

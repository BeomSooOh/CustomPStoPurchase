package expend.ex.user.expend;

import static org.junit.Assert.assertTrue;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import common.vo.ex.ExCommonResultVO;
import common.vo.ex.ExExpendVO;
import expend.TestCase;
import expend.ex.user.mng.BExUserMngService;

/**
 * BExUserServiceImplTest JUnit테스트
 * Created by Kwon Oh Gwang on 2020-03-03.
 */
public class BExUserServiceImplTest extends TestCase {
	private static final Logger logger = LoggerFactory.getLogger(BExUserServiceImplTest.class);

	@Resource ( name = "BExUserMngService" ) /* 관리항목 서비스 */
	private BExUserMngService mngService;
	
	/**
	 * 지출결의서 오류체크
	 * @throws Exception 
	 */
	@Test
	public void testExUserExpendErrorInfoList() throws Exception {
		ExExpendVO expendVo = new ExExpendVO();
		expendVo.setExpendSeq("6677");
		
		List<ExCommonResultVO> resultVO = new ArrayList<ExCommonResultVO>( );
		
		// 관리항목 누락 여부 체크
		List<ExCommonResultVO> result = ExMngErrorInfoCheck(expendVo);
		
		resultVO.addAll(result);
		logger.info("### resultVO = {}", resultVO);
		logger.info("### size = {}", resultVO.size());
	}
	
	/**
	 * 관리항목 누락 여부 체크
	 * @param expendVo
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings("unused")
	private List<ExCommonResultVO> ExMngErrorInfoCheck(ExExpendVO expendVo) throws Exception {
		List<ExCommonResultVO> result = new ArrayList<ExCommonResultVO>( );
		
		List<ExCommonResultVO> resultMng = mngService.ExMngErrorInfoSelect( expendVo );
		
		for ( ExCommonResultVO mngError : resultMng ) {
			if ( mngError.getValidateStat( ).equals( "false" ) ) { 
				if(mngError.getMngCode().equals("C15")) { // 관리항목 C15(거래계좌번호) 예외처리(거래처계좌번호는 코드값이 없기 때문에 명만 체크한다)
					if(mngError.getCtdName().replace("/", "").trim().equals("")) {
						mngError.setError( "관리항목이 누락되었습니다." );
						result.add( mngError );
					}
				}else {
					mngError.setError( "관리항목이 누락되었습니다." );
					result.add( mngError );
				}
			}
		}
		
		return result;
	}

}

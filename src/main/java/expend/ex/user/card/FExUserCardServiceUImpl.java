package expend.ex.user.card;

import java.util.Map;

import common.vo.common.CommonInterface.commonCode;
import common.vo.interlock.InterlockExpendVO;


public class FExUserCardServiceUImpl implements FExUserCardService {

	/* ################################################## */
	/* 변수정의 */
	/* ################################################## */
	/* ################################################## */
	/* 전자결재 연동 - 법인카드 상신 상태값 동기화 */
	/* 주의사항 : LoginVO 사용 불가 */
	/* ################################################## */
	@Override
	public InterlockExpendVO ExUserCardStateListInfoUpdate ( Map<String, Object> params ) throws Exception {
		/* parameters : expendSeq, sendYN */
		InterlockExpendVO result = new InterlockExpendVO( );
		result.setResultCode( commonCode.FAIL );
		result.setResultMessage( "Bizbox Alpha 만 지원하는 기능입니다." );
		return result;
	}
}

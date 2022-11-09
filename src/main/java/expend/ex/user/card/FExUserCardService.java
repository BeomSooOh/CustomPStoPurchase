package expend.ex.user.card;

import java.util.Map;

import common.vo.interlock.InterlockExpendVO;


public interface FExUserCardService {

	/* ################################################## */
	/* 전자결재 연동 - 법인카드 상신 상태값 동기화 */
	/* 주의사항 : LoginVO 사용 불가 */
	/* ################################################## */
	InterlockExpendVO ExUserCardStateListInfoUpdate ( Map<String, Object> params ) throws Exception;
}
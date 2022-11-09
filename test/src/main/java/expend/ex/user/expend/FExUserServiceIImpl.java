package expend.ex.user.expend;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.NotImplementedException;
import org.springframework.stereotype.Service;

import common.vo.common.ResultVO;
import common.vo.ex.ExCommonResultVO;
import common.vo.ex.ExpendVO;


@Service ( "FExUserServiceI" )
public class FExUserServiceIImpl implements FExUserService {
	/* 변수정의 */
	/* 변수정의 - DAO */

	/* Common */
	/* Common - Pop return values */
	public Map<String, Object> ExpendPopReturnInfo ( Map<String, Object> params ) throws Exception {
		throw new NotImplementedException( "Bizbox Alpha 전용기능으로 지원하지 않습니다." );
	}

	/* Bizbox Alpha */
	/* Bizbox Alpha - 지출결의 생성 */
	@Override
	public ExpendVO ExUserExpendInfoInsert ( ExpendVO expendVo ) throws Exception {
		throw new NotImplementedException( "Bizbox Alpha 전용기능으로 지원하지 않습니다." );
	}

	/* Bizbox Alpha - 지출결의 삭제 */
	@Override
	public ResultVO ExUserExpendInfoDelete ( ExpendVO expendVo ) throws Exception {
		throw new NotImplementedException( "Bizbox Alpha 전용기능으로 지원하지 않습니다." );
	}

	/* Bizbox Alpha - 지출결의 수정 */
	@Override
	public ResultVO ExUserExpendInfoUpdate ( ExpendVO expendVo ) throws Exception {
		throw new NotImplementedException( "Bizbox Alpha 전용기능으로 지원하지 않습니다." );
	}

	/* Bizbox Alpha - 지출결의 조회 */
	@Override
	public ExpendVO ExUserExpendInfoSelect ( ExpendVO expendVo ) throws Exception {
		throw new NotImplementedException( "Bizbox Alpha 전용기능으로 지원하지 않습니다." );
	}

	/* Bizbox Alpha - 지출결의 오류체크 */
	@Override
	public ResultVO ExUserExpendInfoErrorCheck ( ExpendVO expendVo ) throws Exception {
		throw new NotImplementedException( "Bizbox Alpha 전용기능으로 지원하지 않습니다." );
	}

	@Override
	public String ExUserErpCodeInfoSelect ( Map<String, Object> params ) throws Exception {
		// TODO Auto-generated method stub
		throw new NotImplementedException( "Bizbox Alpha 전용기능으로 지원하지 않습니다." );
	}

	/* 본문내역 수정 이력 입력 */
	@Override
	public ResultVO ExAppDocHistoryInsert ( Map<String, Object> params ) {
		return null;
	}

	/* 본문내역 수정 이력 컨텐츠 입력 */
	@Override
	public ResultVO ExAppDocContentsHistoryInsert ( Map<String, Object> params ) {
		return null;
	}

	/* 지출결의 가져오기 리스트 조회 */
	public ResultVO ExExpendHistoryListSelect ( ResultVO param ) {
		return param;
	}

	/* 지출결의 수정 내역 이력 추가 */
	public ResultVO ExExpendEditHistoryInsert ( ResultVO param ) {
		return param;
	}

	/* 지출결의 항목 seq 조회 */
	public ResultVO ExExpendListSeqSelect ( ResultVO param ) {
		return param;
	}
	/* iCUBE */
	/* ERPiU */
	/* ETC */

	/* 버튼설정정보 조회 */
	@Override
	public ResultVO ExExpendButtonInfoSelect ( Map<String, Object> param ) {
		/* iCUBE지원하지 않음. */
		return null;
	}

	/* 지출결의 마감 정보 조회 */
	@Override
	public List<Map<String, Object>> ExExpendCloseDateSelect ( Map<String, Object> param ){
		return null;
	}

	/* 지출결의 증빙일자 마감 유효성 체크 */
	@Override
	public List<ExCommonResultVO> ExAuthDateErrorInfoSelect( Map<String, Object> param ){
		return null;
	}
}

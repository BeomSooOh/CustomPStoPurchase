package expend.ex.user.card;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;
import common.vo.interlock.InterlockExpendVO;


@Service ( "FExUserCardServiceA" )
public class FExUserCardServiceAImpl implements FExUserCardService {

	/* ################################################## */
	/* 변수정의 */
	/* ################################################## */
	/* 변수정의 - DAO */
	@Resource ( name = "FExUserCardServiceADAO" )
	private FExUserCardServiceADAO dao;

	/* ################################################## */
	/* 전자결재 연동 - 법인카드 상신 상태값 동기화 */
	/* 주의사항 : LoginVO 사용 불가 */
	/* ################################################## */
	public InterlockExpendVO ExUserCardStateListInfoUpdate ( Map<String, Object> params ) throws Exception {
		/* parameters : expendSeq, sendYN */
		InterlockExpendVO result = new InterlockExpendVO( );
		try {
			/* 상태값 동기화 대상 조회 */
			List<Map<String, Object>> cardList = new ArrayList<Map<String, Object>>( );
			cardList = dao.ExUserCardStateSyncListInfoSelect( params );
			for ( Map<String, Object> map : cardList ) {
				map.put( "groupSeq", CommonConvert.CommonGetStr( params.get( "groupSeq" ) ) );
				map.put( "sendYN", CommonConvert.CommonGetStr( params.get( "sendYN" ) ) );
				if ( CommonConvert.CommonGetStr( params.get( "sendYN" ) ).equals( commonCode.EMPTYNO ) ) {
					/* 반려 / 삭제 */
					map.put( commonCode.EXPENDSEQ, commonCode.EMPTYSEQ );
					map.put( commonCode.LISTSEQ, commonCode.EMPTYSEQ );
					if ( (dao.ExUserCardStateInfoUpdate( map )) == 0 ) {
						result.setResultCode( commonCode.FAIL );
						result.setResultMessage( "카드 사용내역 상태 값 동기화[" + CommonConvert.CommonGetStr( params.get( "sendYN" ) ) + "] 진행 중 동기화 누락 건이 발생되었습니다." );
						throw new Exception( commonCode.EMPTYSTR );
					}
				}
				else if ( CommonConvert.CommonGetStr( params.get( "sendYN" ) ).equals( commonCode.EMPTYYES ) ) {
					/* 보관 / 상신 */
					if ( (dao.ExUserCardStateInfoUpdate( map )) == 0 ) {
						result.setResultCode( commonCode.FAIL );
						result.setResultMessage( "카드 사용내역 상태 값 동기화[" + CommonConvert.CommonGetStr( params.get( "sendYN" ) ) + "] 진행 중 동기화 누락 건이 발생되었습니다." );
						throw new Exception( commonCode.EMPTYSTR );
					}
				}
			}
			result.setResultCode( commonCode.SUCCESS );
			result.setResultMessage( "정상 처리되었습니다." );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return result;
	}
}

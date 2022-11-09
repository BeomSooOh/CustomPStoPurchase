package expend.ex.user.card;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Repository;
import cmm.helper.ConvertManager;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ResultVO;
import common.vo.ex.ExCodeCardVO;
import common.vo.ex.ExCommonResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import main.web.BizboxAMessage;


@Repository ( "FExUserCardServiceADAO" )
public class FExUserCardServiceADAO extends EgovComAbstractDAO {

	/* 지출결의 */
	/* 지출결의 - 카드 사용내역 상태값 수정 */
	public ExCommonResultVO ExExpendCardSubInfoUpdate ( ExCodeCardVO cardVo ) throws Exception {
		/* parameter : send_yn, user_send_yn, if_m_id, if_d_id, emp_seq, summary_eq, note, auth_seq, project_seq, budget_seq, sync_id */
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		/* ibatis 에서 update() 실행시 return 값 : 성공시 "1" / 실패시 "0" */
		if ( update( "ExExpendCardSubInfoUpdate", cardVo ) > 0 ) {
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			resultVo.setMap( ConvertManager.ConverObjectToMap( cardVo ) );
		}
		else {
			resultVo.setCode( commonCode.FAIL );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			resultVo.setMap( ConvertManager.ConverObjectToMap( cardVo ) );
		}
		return resultVo;
	}

	/* 지출결의 - 카드 상신 목록 조회 ( 사용자 ) */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExExpendEmpCardListInfoSelect ( Map<String, Object> params ) throws Exception {
		/* parameter : search_from_date, search_to_date, search_card_num, comp_seq, dept_seq, emp_seq */
		List<Map<String, Object>> returnMap = new ArrayList<Map<String, Object>>( );
        // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
		returnMap = list( "ExExpendEmpCardListInfoSelect", params );
		if ( returnMap != null ) {
			// do nothing
		}
		return returnMap;
	}

	/* 지출결의 - 카드 상신 목록 조회 ( 사용자 )_카드취소분 포함 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExExpendEmpCardListInfoWithCancelInfoSelect ( Map<String, Object> params ) throws Exception {
		/* parameter : searchFromDate, searchToDate, notInSyncId, deptSeq, empSeq, compSeq, searchStr */
        // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
		return list( "ExExpendEmpCardListInfoWithCancelInfoSelect", params );
	}

	/* 지출결의 - 카드 상신 목록 조회 ( 관리자 ) */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExExpendAdminCardListInfoSelect ( Map<String, Object> params ) throws Exception {
		/* parameter : search_from_date, search_to_date, search_card_num, comp_seq */
		List<Map<String, Object>> returnMap = new ArrayList<Map<String, Object>>( );
		returnMap = list( "ExExpendAdminCardListInfoSelect", params );
		return returnMap;
	}

	/* 지출결의 - 카드 사용내역 상세 */
	public ExCodeCardVO ExReportCardDetailInfoSelect ( ExCodeCardVO cardVo ) throws Exception {
		/* parameter : sync_id */
		cardVo = (ExCodeCardVO) select( "ExReportCardDetailInfoSelect", cardVo );
		return cardVo;
	}

	/* 지출결의 - 카드 사용내역 상세_취소분 포함 */
	public ExCodeCardVO ExReportCardDetailInfoWithCancelInfoSelect ( ExCodeCardVO cardVo ) throws Exception {
		/* parameter : sync_id */
		cardVo = (ExCodeCardVO) select( "ExReportCardDetailInfoWithCancelInfoSelect", cardVo );
		return cardVo;
	}

	/* 지출결의 - 카드 사용내역 상세 */
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> ExExpendCardDetailInfoSelect ( ResultVO params ) throws Exception {
		/* parameter : sync_id */
		Map<String, Object> result = (Map<String, Object>) select( "ExExpendCardDetailInfoSelect", params.getParams( ) );
		return result;
	}

	/* ################################################## */
	/* 전자결재 연동 - 법인카드 상신 상태값 동기화 */
	/* 주의사항 : LoginVO 사용 불가 */
	/* ################################################## */
	/* 상태값 동기화 대상 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExUserCardStateSyncListInfoSelect ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = list( "ExUserCardA.ExUserCardStateSyncListInfoSelect", params );
		return result;
	}

	public int ExUserCardStateInfoUpdate ( Map<String, Object> params ) {
		int result = 0;
		result = update( "ExUserCardA.ExUserCardStateInfoUpdate", params );
		return result;
	}

	/* 지출결의 - 작성중인 지출결의 문서에서 카드정보 조회 ( 사용자 ) */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExExpendUseCardInfoSelect ( Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> returnMap = new ArrayList<Map<String, Object>>( );
		returnMap = list( "ExExpendUseCardInfoSelect", params );
		return returnMap;
	}

	/* 지출결의 - 카드 사용내역 지출결의 정보 초기화 */
	public int ExExpendCardInfoMapReset ( Map<String, Object> param ) throws Exception {
		int result = 0;
		param.put( "historyInfo", "카드내역 초기화 syncId : " + param.get( "syncId" ).toString( ) );
		insert( "ExUserCardA.ExUserCardStateInfoResetLogInsert", param );
		result = update( "ExUserCardA.ExUserCardStateInfoReset", param );
		return result;
	}

	/* 지출결의 - 카드정보 도움창 - 카드정보 조회 */
	/* param - compSeq, deptSeq, empSeq, searchType, searchStr, notUseCardYN */
	public Map<String, Object> ExExpendUserCardInfoSelect(Map<String, Object> param, PaginationInfo paginationInfo){
		return listOfPaging2( param, paginationInfo, "ExUserCardA.ExExpendUserCardInfoSelect" );
	}
}


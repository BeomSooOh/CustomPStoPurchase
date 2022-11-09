package expend.ex.user.expend;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Repository;
import common.helper.info.CommonInfo;
import common.vo.common.CommonInterface;
import common.vo.common.ResultVO;
import common.vo.ex.ExCommonResultVO;
import common.vo.ex.ExExpendListVO;
import common.vo.ex.ExpendVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import main.web.BizboxAMessage;


@Repository ( "FExUserServiceADAO" )
public class FExUserServiceADAO extends EgovComAbstractDAO {

	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */

	/* 지출결의 - 지출결의 생성 */
	public ExpendVO ExUserExpendInfoInsert ( ExpendVO expendVo ) {
        // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
		expendVo.setExpendSeq( (String) insert( "ExExpendInfoInsert", expendVo ) );
		return expendVo;
	}

	/* 지출결의 - 지출결의 수정 */
	public ResultVO ExUserExpendInfoUpdate ( ExpendVO expendVo ) throws Exception {
		ResultVO resultVo = new ResultVO( );
		/* ibatis 에서 update() 실행시 return 값 : 성공시 "1" / 실패시 "0" */
		if ( update( "ExExpendInfoUpdate", expendVo ) > 0 ) {
			resultVo.setResultCode( CommonInterface.commonCode.SUCCESS );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
		}
		else {
			resultVo.setResultCode( CommonInterface.commonCode.FAIL );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
		}
		return resultVo;
	}

	/* 지출결의 - 지출결의 삭제 */
	public ResultVO ExUserExpendInfoDelete ( ExpendVO expendVo ) throws Exception {
		/* !!중요..지출결의 정보는 삭제하지 않으며, 지출결의 상태값을 전자결재 삭제와 같은 999 상태로 만들어 준다. */
		/* 업데이트로 대응이 가능하나, 개발상 개발자의 편의성과 이해도를 높이기 위하여 메서드를 분리한다. */
		ResultVO resultVo = new ResultVO( );
		/* ibatis 에서 update() 실행시 return 값 : 성공시 "1" / 실패시 "0" */
		if ( update( "ExExpendInfoDelete", expendVo ) > 0 ) {
			resultVo.setResultCode( CommonInterface.commonCode.SUCCESS );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
		}
		else {
			resultVo.setResultCode( CommonInterface.commonCode.FAIL );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
		}
		return resultVo;
	}

	/* 지출결의 - 지출결의 조회 */
	public ExpendVO ExUserExpendInfoSelect ( ExpendVO expendVo ) throws Exception {
	        // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
		expendVo = (ExpendVO) select( "ExExpendInfoSelect", expendVo );
		return expendVo;
	}

	/* 지출결의 항목 조회 */
	public ExExpendListVO ExUserListInfoSelect ( ExExpendListVO listVo ) throws Exception {
		listVo = (ExExpendListVO) select( "ExListInfoSelect", listVo );
		return listVo;
	}

	/* 지출결의 양식 경로 조회 */
	//public ResultVO ExExpendUploadPathSelect ( Map<String, Object> params ) throws Exception {
	public ResultVO ExExpendUploadPathSelect ( ) throws Exception {
		return null;
	}

	/* 지출결의 양식 유닛 조회 */
	//public ResultVO ExExpendUnitSelect ( Map<String, Object> params ) throws Exception {
	public ResultVO ExExpendUnitSelect ( ) throws Exception {
		return null;
	}

	/* 본문내역 수정 이력 입력 */
	public ResultVO ExAppDocHistoryInsert ( Map<String, Object> params ) {
		@SuppressWarnings ( "unused" )
		ResultVO result = new ResultVO( );
		insert( "ExAppDocHistoryInsert", params );
		return null;
	}

	/* 본문내역 수정 이력 컨텐츠 입력 */
	public ResultVO ExAppDocContentsHistoryInsert ( Map<String, Object> params ) {
		@SuppressWarnings ( "unused" )
		ResultVO result = new ResultVO( );
		insert( "ExAppDocContentsHistoryInsert", params );
		return null;
	}

	/* 지출결의 가져오기 리스트 조회 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO ExExpendHistoryListSelect ( ResultVO param ) {
		param.setAaData( list( "ExExpendHistoryListSelect", param.getParams( ) ) );
		return param;
	}

	/* 지출결의 수정 내역 이력 추가 */
	public ResultVO ExExpendEditHistoryInsert ( ResultVO param ) {
		try {
		        /* 2019-09-19 / 김상겸 : 와탭확인 결과 싱글쿼텐션 문제 발생 확인으로, 파라미터 문자열 변경 기능 추가 */
		        param.getParams( ).put("modifyReason", param.getParams( ).get("modifyReason").toString().replaceAll("'", "''"));
			insert( "ExExpendEditHistoryInsert", param.getParams( ) );
		}
		catch ( Exception e ) {
			e.printStackTrace();
		}
		return param;
	}

	/* 지출결의 항목 seq 조회 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO ExExpendListSeqSelect ( ResultVO param ) {
		param.setAaData( list( "ExExpendListSeqSelect", param.getParams( ) ) );
		if ( param.getAaData( ) == null ) {
			param.setAaData( new ArrayList<Map<String, Object>>( ) );
		}
		return param;
	}

	/* 버튼정보 리스트 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExExpendButtonInfoSelect ( Map<String, Object> param ) {
		return this.list( "ExExpendButtonInfoSelect", param );
	}

	/* 항목 복사 시 해당 항목의 하위 예산정보 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExExpendListBudgetInfoSelect ( Map<String, Object> param ) {
		return this.list( "ExExpendListCopyBudgetInfoSelect", param );
	}

	/* 분개 복사 시 해당 항목의 동일 예산정보 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExExpendSlipBudgetInfoSelect ( Map<String, Object> param ) {
		return this.list( "ExExpendSlipCopyBudgetInfoSelect", param );
	}

	/* 지출결의 마감 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExExpendCloseDateSelect ( Map<String, Object> param ){
		return this.list( "ExExpendCloseDateSelect", param );
	}

	/* 지출결의 증빙일자 마감 유효성 체크 */
	@SuppressWarnings ( "unchecked" )
	public List<ExCommonResultVO> ExAuthDateErrorInfoSelect ( Map<String, Object> param ){
		return this.list( "ExAuthDateErrorInfoSelect", param );
	}
}

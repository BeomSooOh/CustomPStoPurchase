package expend.ex.user.etax;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import cmm.helper.ConvertManager;
import common.helper.info.CommonInfo;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ResultVO;
import common.vo.ex.ExCodeETaxVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import main.web.BizboxAMessage;


@Repository ( "FExUserEtaxServiceADAO" )
public class FExUserEtaxServiceADAO extends EgovComAbstractDAO {

	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */

	/* 매입전자세금계산서 - 목록 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<ExCodeETaxVO> ExExpendETaxSubListInfoSelect ( ExCodeETaxVO etaxVo ) throws Exception {
		List<ExCodeETaxVO> etaxListVo = new ArrayList<ExCodeETaxVO>( );
		
		// 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
		etaxListVo = (List<ExCodeETaxVO>) list( "ExUserETaxSubListInfoSelect", etaxVo );
		return etaxListVo;
	}

	/* 매입전자세금계산서 - 작성중인 목록 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<ExCodeETaxVO> ExExpendETaxSubAppListInfoSelect ( ExCodeETaxVO etaxVo ) throws Exception {
		List<ExCodeETaxVO> etaxListVo = new ArrayList<ExCodeETaxVO>( );
		etaxListVo = (List<ExCodeETaxVO>) list( "ExUserETaxSubAppListInfoSelect", etaxVo );
		return etaxListVo;
	}

	/* 매입전자세금계산서 - 연동 코드 조회 */
	public ExCodeETaxVO ExExpendETaxSubInfoSelect ( ExCodeETaxVO etaxVo ) throws Exception {
		etaxVo = (ExCodeETaxVO) select( "ExUserETaxSubInfoSelect", etaxVo );
		if ( etaxVo == null ) {
			etaxVo = new ExCodeETaxVO( );
		}
		return etaxVo;
	}

	/* 매입전자세금계산서 - 연동 코드 생성 */
	public ResultVO ExExpendETaxSubInfoInsert ( ExCodeETaxVO etaxVo ) throws Exception {
		ResultVO resultVo = new ResultVO( );
		try {
			insert( "ExUserETaxSubInfoInsert", etaxVo );
			resultVo.setResultCode( commonCode.SUCCESS );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			List<Map<String, Object>> tempList = new ArrayList<Map<String, Object>>( );
			tempList.add( ConvertManager.ConverObjectToMap( etaxVo ) );
			resultVo.setAaData( tempList );
		}
		catch ( Exception e ) {
			resultVo.setResultCode( commonCode.FAIL );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			List<Map<String, Object>> tempList = new ArrayList<Map<String, Object>>( );
			tempList.add( ConvertManager.ConverObjectToMap( etaxVo ) );
			resultVo.setAaData( tempList );
		}
		return resultVo;
	}

	/* 매입전자세금계산서 - 연동 코드 수정 */
	public ResultVO ExExpendETaxSubInfoUpdate ( ExCodeETaxVO etaxVo ) throws Exception {
		ResultVO resultVo = new ResultVO( );
		/* ibatis 에서 update() 실행시 return 값 : 성공시 "1" / 실패시 "0" */
		if ( update( "ExUserETaxSubInfoUpdate", etaxVo ) > 0 ) {
			resultVo.setResultCode( commonCode.SUCCESS );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			List<Map<String, Object>> tempList = new ArrayList<Map<String, Object>>( );
			tempList.add( ConvertManager.ConverObjectToMap( etaxVo ) );
			resultVo.setAaData( tempList );
		}
		else {
			resultVo.setResultCode( commonCode.FAIL );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			List<Map<String, Object>> tempList = new ArrayList<Map<String, Object>>( );
			tempList.add( ConvertManager.ConverObjectToMap( etaxVo ) );
			resultVo.setAaData( tempList );
		}
		return resultVo;
	}

	/* 매입전자세금계산서 - 매입전자세금계산서 사용내역 상태값 수정 */
	public ResultVO ExExpendETaxInfoUpdate ( ExCodeETaxVO etaxVo ) throws Exception {
		ResultVO resultVo = new ResultVO( );
		/* ibatis 에서 update() 실행시 return 값 : 성공시 "1" / 실패시 "0" */
		if ( update( "ExUserETaxInfoUpdate", etaxVo ) > 0 ) {
			resultVo.setResultCode( commonCode.SUCCESS );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			List<Map<String, Object>> tempList = new ArrayList<Map<String, Object>>( );
			tempList.add( ConvertManager.ConverObjectToMap( etaxVo ) );
			resultVo.setAaData( tempList );
		}
		else {
			resultVo.setResultCode( commonCode.FAIL );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			List<Map<String, Object>> tempList = new ArrayList<Map<String, Object>>( );
			tempList.add( ConvertManager.ConverObjectToMap( etaxVo ) );
			resultVo.setAaData( tempList );
		}
		return resultVo;
	}

	/* ################################################## */
	/* 전자결재 연동 - 매입전자세금계산서 상신 상태값 동기화 */
	/* 주의사항 : LoginVO 사용 불가 */
	/* ################################################## */
	/* 상태값 동기화 대상 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExUserETaxStateSyncListInfoSelect ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) list( "ExUserEtaxA.ExUserETaxStateSyncListInfoSelect", params );
		return result;
	}

	/* 상태값 업데이트 */
	public int ExUserETaxStateInfoUpdate ( Map<String, Object> params ) {
		int result = 0;
		result = (int) update( "ExUserEtaxA.ExUserETaxStateInfoUpdate", params );
		return result;
	}

	/**/
	@SuppressWarnings ( "unchecked" )
	public ResultVO ExuserETaxISSNoInfoSelect ( ResultVO params ) {
		params.setAaData( list( "ExuserEtaxA.ExuserETaxISSNoInfoSelect", params.getParams( ) ) );
		if ( params.getAaData( ) == null ) {
			params.setAaData( new ArrayList<Map<String, Object>>( ) );
		}
		return params;
	}

	public String ExExpendCompSeqSelect ( Map<String, Object> param ) {
		String result = commonCode.EMPTYSTR;
		result = select( "ExExpendCompSeqSelect", param ).toString( );
		return result;
	}

	/* 세금계산서 권한 정보 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExExpendETaxAuthSelect ( Map<String, Object> param ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = list( "ExExpendETaxAuthSelect", param );
		return result;
	}

	/* 그룹웨어 세금계산서 정보 조회 */
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> ExExpendEtaxGWInfoSelect ( Map<String, Object> param ) {
		Map<String, Object> result = new HashMap<String, Object>( );
		result = (Map<String, Object>) select( "ExExpendEtaxGWInfoSelect", param );
		return result;
	}
	
	/* 이관받은 세금계산서 정보 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExExpendTransferETaxListSelect ( Map<String, Object> param ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = list( "ExExpendTransferETaxListSelect", param );
		return result;
	}
	
	/* 매입전자세금계산서 - 지출결의 정보 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExUserETaxExpendInfoSelect ( Map<String, Object> param ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = list( "ExUserETaxExpendInfoSelect", param );
		return result;
	}
	
	/* 매입전자세금계산서 - 매입전자세금계산서 사용내역 지출결의 정보 초기화 */
	public int ExExpendETaxInfoMapReset(Map<String, Object> param) throws Exception {
		int result = 0;
		param.put( "historyInfo", "매입전자세금계산서 초기화 syncId : " + param.get( "syncId" ).toString( ) );
		insert( "ExUserETax.ExUserETaxStateInfoResetLogInsert", param );
		result = (int) delete( "ExUserETax.ExUserETaxStateInfoReset", param );
		return result;
	}
}

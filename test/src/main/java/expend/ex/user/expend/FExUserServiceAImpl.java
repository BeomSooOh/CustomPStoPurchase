package expend.ex.user.expend;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ResultVO;
import common.vo.ex.ExCommonResultVO;
import common.vo.ex.ExpendVO;


@Service ( "FExUserServiceA" )
public class FExUserServiceAImpl implements FExUserService {

	/* 변수정의 */
	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
	/* 변수정의 - DAO */
	@Resource ( name = "FExUserServiceADAO" )
	FExUserServiceADAO daoA;

	/* Common */
	/* Common - Pop return values */
	@Override
    public Map<String, Object> ExpendPopReturnInfo ( Map<String, Object> params ) throws Exception {
		return null;
	}

	/* Bizbox Alpha */
	/* Bizbox Alpha - 지출결의 생성 */
	@Override
	public ExpendVO ExUserExpendInfoInsert ( ExpendVO expendVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] FExUserServiceAImpl - ExUserExpendInfoInsert" );
		cmLog.CommonSetInfo( "! [EX] ExExpendVO expendVo >> " + expendVo.toString( ) );
		try {
            // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
			expendVo = daoA.ExUserExpendInfoInsert( expendVo );
		}
		catch ( Exception e ) {
			StringWriter sw = new StringWriter( );
			e.printStackTrace( new PrintWriter( sw ) );
			String exceptionAsStrting = sw.toString( );
			cmLog.CommonSetInfo( "! [EX] ERROR - " + exceptionAsStrting );
			e.printStackTrace( );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExExpendVO expendVo >> " + expendVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] FExUserServiceAImpl - ExUserExpendInfoInsert" );
		return expendVo;
	}

	/* Bizbox Alpha - 지출결의 삭제 */
	@Override
	public ResultVO ExUserExpendInfoDelete ( ExpendVO expendVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendMasterService - ExExpendInfoDelete" );
		cmLog.CommonSetInfo( "! [EX] ExExpendVO acctVo >> " + expendVo.toString( ) );
		ResultVO resultVo = new ResultVO( );
		try {
			resultVo = daoA.ExUserExpendInfoDelete( expendVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendMasterService - ExExpendInfoDelete" );
		return resultVo;
	}

	/* Bizbox Alpha - 지출결의 수정 */
	@Override
	public ResultVO ExUserExpendInfoUpdate ( ExpendVO expendVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendMasterService - ExExpendInfoUpdate" );
		cmLog.CommonSetInfo( "! [EX] ExExpendVO acctVo >> " + expendVo.toString( ) );
		ResultVO resultVo = new ResultVO( );
		try {
			resultVo = daoA.ExUserExpendInfoUpdate( expendVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendMasterService - ExExpendInfoUpdate" );
		return resultVo;
	}

	/* Bizbox Alpha - 지출결의 조회 */
	@Override
	public ExpendVO ExUserExpendInfoSelect ( ExpendVO expendVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendMasterService - ExExpendInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] ExExpendVO expendVo >> " + expendVo.toString( ) );
		try {
		        // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
			expendVo = daoA.ExUserExpendInfoSelect( expendVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExExpendVO expendVo >> " + expendVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendMasterService - ExExpendInfoSelect" );
		return expendVo;
	}

	/* Bizbox Alpha - 지출결의 양식 경로 조회 */
	public ResultVO ExUserExpendUploadPathSelect ( Map<String, Object> params ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendMasterService - ExExpendInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] ExExpendVO expendVo >> " + params.toString( ) );
		ResultVO result = new ResultVO( );
		try {
			// expendVo = daoA.ExUserExpendInfoSelect(expendVo);
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExExpendVO expendVo >> " + result.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendMasterService - ExExpendInfoSelect" );
		return result;
	}

	/* Bizbox Alpha - 지출결의 양식 아이템 유닛 조회 */
	public ResultVO ExUserExpendUnitSelect ( Map<String, Object> params ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendMasterService - ExExpendInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] ExExpendVO expendVo >> " + params.toString( ) );
		ResultVO result = new ResultVO( );
		try {
			// expendVo = daoA.ExUserExpendInfoSelect(expendVo);
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExExpendVO expendVo >> " + result.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendMasterService - ExExpendInfoSelect" );
		return result;
	}

	/* Bizbox Alpha - 지출결의 오류체크 */
	@Override
	public ResultVO ExUserExpendInfoErrorCheck ( ExpendVO expendVo ) throws Exception {
		return null;
	}

	@Override
	public String ExUserErpCodeInfoSelect ( Map<String, Object> params ) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	/* 본문내역 수정 이력 입력 */
	@Override
    public ResultVO ExAppDocHistoryInsert ( Map<String, Object> params ) {
		return daoA.ExAppDocHistoryInsert( params );
	}

	/* 본문내역 수정 이력 컨텐츠 입력 */
	@Override
    public ResultVO ExAppDocContentsHistoryInsert ( Map<String, Object> params ) {
		return daoA.ExAppDocContentsHistoryInsert( params );
	}

	/* 지출결의 가져오기 리스트 조회 */
	@Override
    public ResultVO ExExpendHistoryListSelect ( ResultVO param ) {
		return daoA.ExExpendHistoryListSelect( param );
	}

	/* 지출결의 수정 내역 이력 추가 */
	@Override
    public ResultVO ExExpendEditHistoryInsert ( ResultVO param ) {
		return daoA.ExExpendEditHistoryInsert( param );
	}

	/* 지출결의 항목 seq 조회 */
	@Override
    public ResultVO ExExpendListSeqSelect ( ResultVO param ) {
		param = daoA.ExExpendListSeqSelect( param );
		return param;
	}
	/* iCUBE */
	/* ERPiU */
	/* ETC */

	/* 버튼설정 정보 조회 */
	@Override
    public ResultVO ExExpendButtonInfoSelect ( Map<String, Object> param ) {
		ResultVO result = new ResultVO( );
		List<Map<String, Object>> temp = daoA.ExExpendButtonInfoSelect( param );
		if ( temp.size( ) == 0 ) {
			result.setResultCode( commonCode.FAIL );
			result.setResultName( "버튼설정 기초 코드 누락." );
		}
		else {
			result.setResultCode( commonCode.SUCCESS );
			result.setAaData( temp );
		}
		return result;
	}
	
	/* 지출결의 마감 정보 조회 */
	@Override
    public List<Map<String, Object>> ExExpendCloseDateSelect ( Map<String, Object> param ){
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = daoA.ExExpendCloseDateSelect( param );
		return result;
	}
	
	/* 지출결의 증빙일자 마감 유효성 체크 */
	@Override
    public List<ExCommonResultVO> ExAuthDateErrorInfoSelect( Map<String, Object> param ){
		List<ExCommonResultVO> result = new ArrayList<ExCommonResultVO>( );
		result = daoA.ExAuthDateErrorInfoSelect( param );
		return result;
	}
}

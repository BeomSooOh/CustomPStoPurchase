package expend.ex.user.mng;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.springframework.stereotype.Service;

import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExExpendMngVO;


@Service ( "FExUserMngServiceI" )
public class FExUserMngServiceIImpl implements FExUserMngService {

	/* 변수정의 */
	@Resource ( name = "FExUserMngServiceIDAO" )
	private FExUserMngServiceIDAO exUserMngServiceIDAO;
	private final org.apache.logging.log4j.Logger LOG = LogManager.getLogger( this.getClass( ) );

	/* 공통코드 */
	/* 공통코드 - 지출결의 항목 분개 관리항목 목록 조회 */
	@Override
	public List<ExExpendMngVO> ExCodeMngListInfoSelect ( ExExpendMngVO mngVo, ConnectionVO conVo ) throws Exception {
		LOG.debug( "+ [EX] FExUserMngServiceI - ExCodeMngListInfoSelect" );
		LOG.debug( "! [EX] ExExpendMngVO mngVo >> " + mngVo.toString( ) );
		List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>( );
		try {
			mngListVo = exUserMngServiceIDAO.ExCodeMngListInfoSelect( mngVo, conVo );
		}
		catch ( Exception e ) {
			StringWriter sw = new StringWriter( );
			e.printStackTrace( new PrintWriter( sw ) );
			String exceptionAsStrting = sw.toString( );
			LOG.error( "! [EX] ERROR - " + exceptionAsStrting );
			e.printStackTrace( );
			throw e;
		}
		LOG.debug( "! [EX] List<ExExpendMngVO> mngListVo >> " + mngListVo.toString( ) );
		LOG.debug( "- [EX] FExUserMngServiceI - ExCodeMngListInfoSelect" );
		return mngListVo;
	}

	/* 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 */
	@Override
	public List<ExExpendMngVO> ExCodeMngDListInfoSelect ( ExExpendMngVO mngVo, ConnectionVO conVo ) throws Exception {
		LOG.debug( "+ [EX] FExUserMngServiceI - ExCodeMngDListInfoSelect" );
		LOG.debug( "! [EX] ExExpendMngVO mngVo >> " + mngVo.toString( ) );
		List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>( );
		try {
			if ( mngVo.getMngCode( ).indexOf( "L" ) == 0 || mngVo.getMngCode( ).indexOf( "M" ) == 0 ) {
				String tMngCode = mngVo.getMngCode( );
				/* L 또는 M 으로 시작하는 관리항목은 사용자 정의 관리항목으로 iCUBE 로 부터 제공받은 프로시저를 통하여 하위코드를 조회한다. */
				if ( !mngVo.getRealMngCode( ).equals( commonCode.EMPTYSEQ ) && !mngVo.getRealMngCode( ).equals( commonCode.EMPTYSTR ) ) {
					mngVo.setMngCode( mngVo.getRealMngCode( ) );
				}
				mngListVo = exUserMngServiceIDAO.ExCodeMngDLMListInfoSelect( mngVo, conVo );
				mngVo.setMngCode( tMngCode );
				/* 사용자 정의 관리항목이 아닌 연동 관리항목인 경우 연동된 정보의 관리항목 조회 */
				if ( mngListVo != null && mngListVo.size( ) == 0 ) {
					String mngCode = mngVo.getMngCode( );
					mngVo.setMngCode( mngVo.getRealMngCode( ) );
					/* 업무승용차관리항목인 경우 별도의 쿼리로 진행 */
					if ( mngVo.getRealMngCode( ).equals( "Y1" ) ) {
						mngListVo = exUserMngServiceIDAO.ExCodeLinkMngCarListInfoSelect( mngVo, conVo );
					}
					else {
						mngListVo = exUserMngServiceIDAO.ExCodeLinkMngListInfoSelect( mngVo, conVo );
						if(mngListVo != null && mngListVo.size( ) == 0){
							mngVo.setMngCode( mngCode );
							mngListVo = exUserMngServiceIDAO.ExCodeLinkMngListInfoSelect( mngVo, conVo );
						}
					}
					mngVo.setMngCode( mngCode );
				}
			}
			else {
				/* 사용자 정의 관리항목이 아닌경우 iCUBE 로 부터 제공받은 View 를 통하여 하위코드를 조회한다. */
				mngListVo = exUserMngServiceIDAO.ExCodeMngDListInfoSelect( mngVo, conVo );
			}
		}
		catch ( Exception e ) {
			StringWriter sw = new StringWriter( );
			e.printStackTrace( new PrintWriter( sw ) );
			String exceptionAsStrting = sw.toString( );
			LOG.error( "! [EX] ERROR - " + exceptionAsStrting );
			e.printStackTrace( );
			throw e;
		}
		LOG.debug( "! [EX] List<ExExpendMngVO> mngListVo >> " + mngListVo.toString( ) );
		LOG.debug( "- [EX] FExUserMngServiceI - ExCodeMngDListInfoSelect" );
		return mngListVo;
	}

	@Override
	public ResultVO ExExpendMngNecessaryOptionInfoSelect ( ExExpendMngVO mngVo, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		ArrayList<Map<String, Object>> aaData = new ArrayList<>( );
		for ( ExExpendMngVO item : exUserMngServiceIDAO.ExCodeMngListInfoSelect( mngVo, conVo ) ) {
			Map<String, Object> temp = new HashMap<String, Object>( );
			temp.put( "mngCode", item.getMngCode( ) );
			temp.put( "mngName", item.getMngName( ) );
			temp.put( "mngStat", item.getMngStat( ) );
			temp.put( "realMngCode", item.getRealMngCode( ) );
			aaData.add( temp );
		}
		result.setAaData( aaData );
		result.setResultCode( commonCode.SUCCESS );
		return result;
	}

	/* 공통코드 - iCUBE 사용자 정의 관리항목 연동 항목 조회 */
	@Override
	public List<ExExpendMngVO> ExCutomMngRealInfoSelect ( ExExpendMngVO mngVo, ConnectionVO conVo ) throws Exception {
		LOG.debug( "+ [EX] FExUserMngServiceI - ExCodeMngListInfoSelect" );
		LOG.debug( "! [EX] ExExpendMngVO mngVo >> " + mngVo.toString( ) );
		List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>( );
		try {
			mngListVo = exUserMngServiceIDAO.ExCutomMngRealInfoSelect( mngVo, conVo );
		}
		catch ( Exception e ) {
			StringWriter sw = new StringWriter( );
			e.printStackTrace( new PrintWriter( sw ) );
			String exceptionAsStrting = sw.toString( );
			LOG.error( "! [EX] ERROR - " + exceptionAsStrting );
			e.printStackTrace( );
			throw e;
		}
		LOG.debug( "! [EX] List<ExExpendMngVO> mngListVo >> " + mngListVo.toString( ) );
		LOG.debug( "- [EX] FExUserMngServiceI - ExCodeMngListInfoSelect" );
		return mngListVo;
	}
}

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


@Service ( "FExUserMngServiceU" )
public class FExUserMngServiceUImpl implements FExUserMngService {

	/* 변수정의 */
	@Resource ( name = "FExUserMngServiceUDAO" )
	private FExUserMngServiceUDAO exUserMngServiceUDAO;
	private final org.apache.logging.log4j.Logger LOG = LogManager.getLogger( this.getClass( ) );

	/* 공통코드 */
	/* 공통코드 - 지출결의 항목 분개 관리항목 목록 조회 */
	@Override
	public List<ExExpendMngVO> ExCodeMngListInfoSelect ( ExExpendMngVO mngVo, ConnectionVO conVo ) throws Exception {
		LOG.debug( "+ [EX] FExUserMngServiceU - ExCodeMngListInfoSelect" );
		LOG.debug( "! [EX] ExExpendMngVO mngVo >> " + mngVo.toString( ) );
		List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>( );
		try {
			mngListVo = exUserMngServiceUDAO.ExCodeMngListInfoSelect( mngVo, conVo );
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
		LOG.debug( "- [EX] FExUserMngServiceU - ExCodeMngListInfoSelect" );
		return mngListVo;
	}

	/* 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 */
	@Override
	public List<ExExpendMngVO> ExCodeMngDListInfoSelect ( ExExpendMngVO mngVo, ConnectionVO conVo ) throws Exception {
		LOG.debug( "+ [EX] FExUserMngServiceU - ExCodeMngDListInfoSelect" );
		LOG.debug( "! [EX] ExExpendMngVO mngVo >> " + mngVo.toString( ) );
		List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>( );
		try {
			/* 관리항목에 따른 목록 조회 변경 */
			switch ( mngVo.getMngCode( ) ) {
				case "A01": /* 사업장 */
					mngListVo = exUserMngServiceUDAO.ExCodeMngDA01ListInfoSelect( mngVo, conVo );
					break;
				case "A02": /* 코스트센터 */
					mngListVo = exUserMngServiceUDAO.ExCodeMngDA02ListInfoSelect( mngVo, conVo );
					break;
				case "A03": /* 부서 */
					mngListVo = exUserMngServiceUDAO.ExCodeMngDA03ListInfoSelect( mngVo, conVo );
					break;
				case "A04": /* 사원 */
					mngListVo = exUserMngServiceUDAO.ExCodeMngDA04ListInfoSelect( mngVo, conVo );
					break;
				case "A05": /* 프로젝트 */
					mngListVo = exUserMngServiceUDAO.ExCodeMngDA05ListInfoSelect( mngVo, conVo );
					break;
				case "A06": /* 거래처 */
				case "C45": /* 접대상대 */
					mngListVo = exUserMngServiceUDAO.ExCodeMngDA06ListInfoSelect( mngVo, conVo );
					break;
				case "A07": /* 예적금계좌 */
					mngListVo = exUserMngServiceUDAO.ExCodeMngDA07ListInfoSelect( mngVo, conVo );
					break;
				case "A08": /* 신용카드 */
					mngListVo = exUserMngServiceUDAO.ExCodeMngDA08ListInfoSelect( mngVo, conVo );
					break;
				case "A09": /* 금융기관 */
					mngListVo = exUserMngServiceUDAO.ExCodeMngDA09ListInfoSelect( mngVo, conVo );
					break;
				case "A10": /* 품목 */
					mngListVo = exUserMngServiceUDAO.ExCodeMngDA10ListInfoSelect( mngVo, conVo );
					break;
				case "B01": /* 자산관리번호 */
					mngListVo = exUserMngServiceUDAO.ExCodeMngDB01ListInfoSelect( mngVo, conVo );
					break;
				case "B11": /* 자산처리구분 */
					mngListVo = exUserMngServiceUDAO.ExCodeMngDB11ListInfoSelect( mngVo, conVo );
					break;
				case "B12": /* 받을어음정리구분 */
					mngListVo = exUserMngServiceUDAO.ExCodeMngDB12ListInfoSelect( mngVo, conVo );
					break;
				case "B24": /* 환종 */
					mngListVo = exUserMngServiceUDAO.ExCodeMngDB24ListInfoSelect( mngVo, conVo );
					break;
				case "C01": /* 사업자번호 */
					mngListVo = exUserMngServiceUDAO.ExCodeMngDC01ListInfoSelect( mngVo, conVo );
					break;
				case "C03": /* 관련계정 */
					mngListVo = exUserMngServiceUDAO.ExCodeMngDC03ListInfoSelect( mngVo, conVo );
					break;
				case "C14": /* 세무구분 */
					mngListVo = exUserMngServiceUDAO.ExCodeMngDC14ListInfoSelect( mngVo, conVo );
					break;
				case "C15": /* 거래처계좌번호 */
					mngListVo = exUserMngServiceUDAO.ExCodeMngDC15ListInfoSelect( mngVo, conVo );
					break;
				case "C18": /* 불공제구분 */
					mngListVo = exUserMngServiceUDAO.ExCodeMngDC18ListInfoSelect( mngVo, conVo );
					break;
				case "C20": /* 증빙구분 */
					mngListVo = exUserMngServiceUDAO.ExCodeMngDC20ListInfoSelect( mngVo, conVo );
					break;
				case "C28": /* 지급조건 */
					mngListVo = exUserMngServiceUDAO.ExCodeMngDC28ListInfoSelect( mngVo, conVo );
					break;
				case "B54": /* 업무용차량 */
					mngListVo = exUserMngServiceUDAO.ExCodeMngDB54ListInfoSelect( mngVo, conVo );
					break;
				default: /* 관리내역 */
					mngListVo = exUserMngServiceUDAO.ExCodeMngDListInfoSelect( mngVo, conVo );
					break;
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
		LOG.debug( "- [EX] FExUserMngServiceU - ExCodeMngDListInfoSelect" );
		return mngListVo;
	}

	@Override
	public ResultVO ExExpendMngNecessaryOptionInfoSelect ( ExExpendMngVO mngVo, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		ArrayList<Map<String, Object>> aaData = new ArrayList<>( );
		for ( ExExpendMngVO item : exUserMngServiceUDAO.ExCodeMngListInfoSelect( mngVo, conVo ) ) {
			Map<String, Object> temp = new HashMap<String, Object>( );
			temp.put( "mngCode", item.getMngCode( ) );
			temp.put( "mngName", item.getMngName( ) );
			temp.put( "mngStat", item.getMngStat( ) );
			aaData.add( temp );
		}
		result.setAaData( aaData );
		result.setResultCode( commonCode.SUCCESS );
		return result;
	}

	/* 공통코드 - iCUBE 사용자 정의 관리항목 연동 항목 조회 */
	@Override
	public List<ExExpendMngVO> ExCutomMngRealInfoSelect ( ExExpendMngVO mngVo, ConnectionVO conVo ) throws Exception {
		return null;
	}
}
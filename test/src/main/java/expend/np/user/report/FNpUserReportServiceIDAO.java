package expend.np.user.report;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.stereotype.Repository;

import cmm.util.MapUtil;
import common.helper.connection.CommonErpConnect;
import common.helper.connection.CommonExConnect;
import common.helper.convert.CommonConvert;
import common.helper.logger.CommonLogger;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.common.SqlSessionVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FNpUserReportServiceIDAO" )
public class FNpUserReportServiceIDAO extends EgovComAbstractDAO {
	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog;
	/* 변수정의 - class */
	CommonExConnect connector = new CommonExConnect( );
	/* 변수정의 */
	//private SqlSessionFactory sqlSessionFactory;

	/* 공통사용 */
	/* 공통사용 - 커넥션 */
	private SqlSessionVO connect(ConnectionVO conVo) throws Exception {
		String mapPath = "np";
		if (!MapUtil.hasKey(CommonErpConnect.connections, CommonConvert.CommonGetStr(conVo.getUrl()))) {
			SqlSessionVO sqlSessionVo = new SqlSessionVO(conVo, mapPath);
			CommonErpConnect.connections.put(CommonConvert.CommonGetStr(conVo.getUrl()), sqlSessionVo);
		}
		return (SqlSessionVO) CommonErpConnect.connections.get(CommonConvert.CommonGetStr(conVo.getUrl()));
	}

	/**
	 * 	[매입전자 세금계산서] 건별 상세 데이터 조회
	 * */
	public ResultVO selectETaxDetailInfo ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		ResultVO result = new ResultVO( );
		cmLog.CommonSetInfo( "+ [EX] FNpUserReportServiceIDAO - selectETaxDetailInfo" );
		cmLog.CommonSetInfo( "! [EX] Map<String, Object> params >> " + params );
		connect( conVo );
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			List<Map<String, Object>> aaData = session.selectList( "npUserETaxI.selectETaxDetailInfo", params );


			if(aaData.size( ) == 0){
				result.setFail("매입전자 세금 계산서 정보를 찾을 수 없습니다.");
			}else{
				/* 전자 세금 계산서 헤드 데이터 탐색 */
				result.setaData( aaData.get( 0 ) );

				/* 전자 세금 계산서 품목 데이터 탐색 */
				result.setAaData( aaData );

				result.setSuccess( );
			}
		}
		catch ( Exception ex ) {
			StringWriter sw = new StringWriter();
			ex.printStackTrace(new PrintWriter(sw));
			ex.printStackTrace();
			session.rollback();
			session.close();
			params = null;
			throw ex;
		}
		finally {
			session.close( );
		}
		cmLog.CommonSetInfo( "! [EX] return params >> " + params.toString( ) );
		cmLog.CommonSetInfo( "- [EX] FNpUserReportServiceIDAO - selectETaxDetailInfo" );
		return result;
	}

}

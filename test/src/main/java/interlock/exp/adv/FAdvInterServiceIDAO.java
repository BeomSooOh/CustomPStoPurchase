/**
  * @FileName : FApprovalServiceADAO.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package interlock.exp.adv;

//import java.io.Reader;
import java.util.List;
import java.util.Map;
//import java.util.Properties;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
//import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Repository;

//import com.ibatis.common.resources.Resources;

import cmm.util.MapUtil;
import common.helper.connection.CommonErpConnect;
import common.helper.connection.CommonExConnect;
import common.helper.convert.CommonConvert;
import common.helper.logger.CommonLogger;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.common.SqlSessionVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


/**
 *   * @FileName : FApprovalServiceADAO.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Repository ( "FAdvInterServiceIDAO" )
public class FAdvInterServiceIDAO extends EgovComAbstractDAO {

	/* 변수정의 - class */
	CommonExConnect connector = new CommonExConnect( );
	/* 변수정의 */
	@SuppressWarnings("unused")
	private SqlSessionFactory sqlSessionFactory;
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog;
	/* 공통사용 */
	/* 공통사용 - 커넥션 */
	private SqlSessionVO connect(ConnectionVO conVo) throws Exception {
		String mapPath = "ex";
		if (!MapUtil.hasKey(CommonErpConnect.connections, CommonConvert.CommonGetStr(conVo.getUrl()))) {
			SqlSessionVO sqlSessionVo = new SqlSessionVO(conVo, mapPath);
			CommonErpConnect.connections.put(CommonConvert.CommonGetStr(conVo.getUrl()), sqlSessionVo);
		}
		return (SqlSessionVO) CommonErpConnect.connections.get(CommonConvert.CommonGetStr(conVo.getUrl()));
	}
	/**
	 * 	양식 코드 DAO 테스트 쿼리
	 * 	params : {  }
	 */
	public List<Map<String, Object>> npTest ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = null;
		connect( conVo );
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			result = session.selectList( "npUserCodeI.TestCode", params );
		}
		catch ( Exception ex ) {
			throw ex;
		}
		finally {
			session.close( );
		}
		return result;
	}

	public String set_WCMS_ERP_VCRD03 ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		String result = "N";
		connect( conVo );
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		String sConVo = new ObjectMapper().writeValueAsString( conVo );
		try {
			cmLog.CommonSetInfo( "               [EXNP-ADV] session.update( advInteriCUBE.set_WCMS_ERP_VCRD03, params )");
			cmLog.CommonSetInfo( "               [EXNP-ADV] conVo : " + sConVo);
			session.update( "advInteriCUBE.set_WCMS_ERP_VCRD03", params );
			session.commit( );
		}
		catch ( Exception ex ) {
			session.rollback( );
			throw ex;
		}
		finally {
			result = "Y";
			session.close( );
		}
		return result;
	}

	public String rollback_WCMS_ERP_VCRD03 ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		String result = "N";
		connect( conVo );
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			cmLog.CommonSetInfo( "               [EXNP-ADV] session.update( advInteriCUBE.set_WCMS_ERP_VCRD03, params )");
			session.update( "advInteriCUBE.rollback_WCMS_ERP_VCRD03", params );
			session.commit( );
		}
		catch ( Exception ex ) {
			session.rollback( );
			throw ex;
		}
		finally {
			result = "Y";
			session.close( );
		}
		return result;
	}

	/**
	 *	iCUBE 법인카드 승인내역 전자결재 상태값 연동
	 */
	public ResultVO UpdateICubeCardGwState ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		connect( conVo );
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			session.update( "advInteriCUBE.updateAcardSunginGWState", params );
			session.commit( );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ), ex);
		}
		finally {
			session.close( );
		}
		return result;
	}

}
package expend.np.user.code;

import java.io.Reader;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Repository;

import com.ibatis.common.resources.Resources;

import cmm.util.MapUtil;
import common.helper.connection.CommonExConnect;
import common.helper.exception.CheckErpVersionException;
import common.helper.exception.NotFoundDataException;
import common.helper.logger.CommonLogger;
import common.vo.common.ConnectionVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import expend.np.user.option.FNpUserOptionServiceIDAO;


@Repository ( "FNpUserCodeServiceIDAO" )
public class FNpUserCodeServiceIDAO extends EgovComAbstractDAO {
	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog;
	@Resource ( name = "FNpUserOptionServiceIDAO" )
	private FNpUserOptionServiceIDAO dao;
	/* 변수정의 - class */
	CommonExConnect connector = new CommonExConnect( );
	/* 변수정의 */
	private SqlSessionFactory sqlSessionFactory;

	/* 공통사용 */
	/* 공통사용 - 커넥션 */
	private boolean connect ( ConnectionVO conVo ) throws Exception {
		boolean result = false;
		try {
			// 환경 설정 파일의 경로를 문자열로 저장 / String resource = "sample/mybatis/sql/mybatis-config.xml";
			String resource = "egovframework/sqlmap/config/" + conVo.getDatabaseType( ) + "/iCUBE/np/sql-map-mybatis-iCUBE-config.xml";
			Properties props = new Properties( );
			props.put( "databaseType", conVo.getDatabaseType( ) );
			props.put( "driver", conVo.getDriver( ) );
			props.put( "url", conVo.getUrl( ) );
			props.put( "username", conVo.getUserId( ) );
			props.put( "password", conVo.getPassword( ) );
			props.put( "erpTypeCode", conVo.getErpTypeCode( ) );
			// 문자열로 된 경로의파일 내용을 읽을 수 있는 Reader 객체 생성
			Reader reader = Resources.getResourceAsReader( resource );
			// reader 객체의 내용을 가지고 SqlSessionFactory 객체 생성 / sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader, props);
			if ( sqlSessionFactory == null ) {
				sqlSessionFactory = new SqlSessionFactoryBuilder( ).build( reader, props );
			}
			else {
				sqlSessionFactory = null;
				sqlSessionFactory = new SqlSessionFactoryBuilder( ).build( reader, props );
			}
			result = true;
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}

	/**
	 * 	양식 코드 DAO 테스트 쿼리
	 * 	params : {  }
	 */
	public List<Map<String, Object>> npTest ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = null;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			result = session.selectList( "npUserCodeI.TestCode", params );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			throw ex;
		}
		finally {
			session.close( );
		}
		return result;
	}
	
	/**
	 * 	공통 양식 코드 조회	[사원 정보]
	 * 	params : { 
	 * 		stdDate[기준일:yyyyMMdd, 전체:null  
	 * 	}
	 */
	public List<Map<String, Object>> selectCommonEmpCode ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = null;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			result = session.selectList( "npUserCodeI.selectCommonEmpCode", params );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			throw new CheckErpVersionException( ex.getMessage( ));
		}
		finally {
			session.close( );
		}
		return result;
	}
	
	/**
	 * 	공통 양식 코드 조회	[프로젝트 정보]
	 * 	params : { 
	 * 		"useYn"['':전체, '1':사용, '2':완료, '3':진행]  
	 * 	}
	 */
	public List<Map<String, Object>> selectCommonProjectCode ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
	
		List<Map<String, Object>> result = null;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			result = session.selectList( "npUserCodeI.selectCommonProjectCode", params );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			throw new CheckErpVersionException( ex.getMessage( ));
		}
		finally {
			session.close( );
		}
		return result;
	}
	
	/**
	 * 	공통 양식 코드 조회	[입출금 계좌 정보]
	 * 	params : { 
	 * 		"useYn"['':전체, '1':사용]
	 * 		, "trFg" ['' 확인 필요]
	 * 	}
	 */
	public List<Map<String, Object>> selectCommonBtrCode ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = null;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			result = session.selectList( "npUserCodeI.selectCommonBtrCode", params );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			throw new CheckErpVersionException( ex.getMessage( ));
		}
		finally {
			session.close( );
		}
		return result;
	}
	
	/**
	 * 	공통 양식 코드 조회	[거래처 코드 정보]
	 * 	params : { 
	 * 		"trName"[거래처 명 필터 텍스트]
	 * 		, "useYn"['':전체 거래처, '1':사용 거래처]
	 * 	}
	 */
	public List<Map<String, Object>> selectCommonTrCode ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = null;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			result = session.selectList( "npUserCodeI.selectCommonTrCode", params );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			throw new CheckErpVersionException( ex.getMessage( ));
		}
		finally {
			session.close( );
		}
		return result;
	}
	
	/**
	 * 	공통 양식 코드 조회	[금융기관 코드 정보]
	 * 	params : { 
	 * 	}
	 */
	public List<Map<String, Object>> selectCommonBankCode ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = null;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			result = session.selectList( "npUserCodeI.selectCommonBankCode", params );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			throw new CheckErpVersionException( ex.getMessage( ));
		}
		finally {
			session.close( );
		}
		return result;
	}
	
	/**
	 * 	공통 양식 코드 조회	[사원등록 거래처 코드 정보]
	 * 	params : { 
	 * 		stdDate[기준일:yyyyMMdd, 전체:null]
	 * 	}
	 */
	public List<Map<String, Object>> selectCommonTrEmpCode ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = null;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			result = session.selectList( "npUserCodeI.selectCommonTrEmpCode", params );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			throw new CheckErpVersionException( ex.getMessage( ));
		}
		finally {
			session.close( );
		}
		return result;
	}
	
	/**
	 * 	공통 양식 코드 조회	[원인행위자 코드 정보]
	 * 	params : { 
	 * 		stdDate[기준일:yyyyMMdd, 전체:null]
	 * 	}
	 */
	public List<Map<String, Object>> selectCommonCauseCode ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = null;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			result = session.selectList( "npUserCodeI.selectCommonCauseCode", params );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			throw new CheckErpVersionException( ex.getMessage( ));
		}
		finally {
			session.close( );
		}
		return result;
	}
	
	/**
	 * 	공통 양식 코드 조회	[부서 코드 정보]
	 * 	params : { 
	 * 		stdDate[기준일:yyyyMMdd, 전체:null]  
	 * 	}
	 */
	public List<Map<String, Object>> selectCommonDeptCode ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = null;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			result = session.selectList( "npUserCodeI.selectCommonDeptCode", params );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			throw new CheckErpVersionException( ex.getMessage( ));
		}
		finally {
			session.close( );
		}
		return result;
	}
	
	/**
	 * 	공통 양식 코드 조회	[사업장, 회계단위 코드 정보]
	 * 	params : { 
	 * 		stdDate[기준일:yyyyMMdd, 전체:null
	 * 	}
	 */
	public List<Map<String, Object>> selectCommonBizCode ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = null;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			result = session.selectList( "npUserCodeI.selectCommonBizCode", params );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			throw new CheckErpVersionException( ex.getMessage( ));
		}
		finally {
			session.close( );
		}
		return result;
	}
	
	/**
	 *	공통 양식 코드 조회 [기타소득자 정보]
	 *	params : { 
	 *		stdDate[기준일:yyyyMMdd, 전체:null
	 *	}
	 */
	public List<Map<String, Object>> selectCommonTrEtcCode ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		//		String[] parametersCheck = {};
		//		if ( !MapUtil.hasParameters( params, parametersCheck ) ) {
		//			throw new Exception("파라미터 확인이 필요합니다.");
		//		}
		List<Map<String, Object>> result = null;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			result = session.selectList( "npUserCodeI.selectCommonTrEtcCode", params );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			throw new CheckErpVersionException( ex.getMessage( ));
		}
		finally {
			session.close( );
		}
		return result;
	}

	/**
	 * 공통 양식 코드 조회 [예산과목 레벨 사용자 명칭 정보]
	 * params : { }
	 */
	public List<Map<String, Object>> selectCommonBgtLabelCode ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		//		String[] parametersCheck = {};
		//		if ( !MapUtil.hasParameters( params, parametersCheck ) ) {
		//			throw new Exception("파라미터 확인이 필요합니다.");
		//		}
		List<Map<String, Object>> result = null;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			result = session.selectList( "npUserCodeI.selectCommonBgtLabelCode", params );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			throw new CheckErpVersionException( ex.getMessage( ));
		}
		finally {
			session.close( );
		}
		return result;
	}

	/**
	 * 공통 양식 코드 조회 [예산과목 코드 정보]
	 * params : { 
	 * 		필수 
	 * 		gisu			ERP 기수 정보 [ n ]
	 * 		, frDate		ERP 기수 시작일 [ yyyyMMdd ]
	 * 		, toDate		ERP 기수 종료일 [ yyyyMMdd ]
	 * 		, grFg			지출 수입 예산여부 ["1":수입, "2":지출] 
	 * 		, erpDivCode	회계단위 [ CODE1 + "|" ]
	 * 		, mgtCode		프로젝트 코드 [ CODE1 + "|" ]
	 * 		, opt01			예산과목 옵션 [ "1":전체, "2":당기 편성, "3":프로젝트기간 편성]
	 * 		, opt02			사용기한 옵션 [ "1":전체, "2": 사용기한 경과분 숨김 ]
	 * 		, opt03			상위과목표시 옵션 [ "1":모두 표시, "2":최하위 표시 ]
	 * 		, bgtFrDate 	품의/결의 일  [yyyyMMdd]
	 * 	
	 * 		선택적 필수 
	 * 		bottomCode		하위사업코드 [ CODE1 + "|" ] - 하위사업 옵션 사용의 경우 필수 값.
	 * 		
	 * 		선택
	 * 		, bgtCode		검색어 [ 예산 계정 코드 ]
	 * 		, bgtName		검색어 [ 예산 계정 명 ]
	 * 	}
	 */
	public List<Map<String, Object>> selectCommonBgtCode ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		String[] parametersCheck = { "gisu", "Y", "frDate", "Y", "toDate", "Y", "grFg", "Y", "erpDivCode", "Y", "mgtCode", "Y", "bottomCode", "N", "bgtCode", "N", "bgtName", "N", "opt01", "Y", "opt02", "Y", "opt03", "Y", "bgtFrDate", "Y", "groupCode", "N" };
		if ( !MapUtil.hasParameters( params, parametersCheck ) ) {
			throw new NotFoundDataException( "파라미터 확인이 필요합니다." );
		}
		/* 회계단위 및 프로젝트 코드에 | 기호 입력 안되어있으면 입력 */
		if( params.get("erpDivCode").toString( ).indexOf( "" ) == -1){
			params.put("erpDivCode", (params.get("erpDivCode").toString( ) + "|"));
		}
		if( params.get("mgtCode").toString( ).indexOf( "" ) == -1){
			params.put("mgtCode", (params.get("mgtCode").toString( ) + "|"));
		}
		List<Map<String, Object>> result = null;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			result = session.selectList( "npUserCodeI.npUserCodeI.selectCommonBgtCode", params );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			throw new CheckErpVersionException( ex.getMessage( ));
		}
		finally {
			session.close( );
		}
		return result;
	}
	
	/**
	 * 	공통 양식 코드 조회	[사업소득자 코드 정보]
	 * 	params : { 
	 * 	}
	 */
	public List<Map<String, Object>> selectCommonTrBusCode ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = null;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			result = session.selectList( "npUserCodeI.selectCommonTrBusCode", params );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			throw new CheckErpVersionException( ex.getMessage( ));
		}
		finally {
			session.close( );
		}
		return result;
	}
}









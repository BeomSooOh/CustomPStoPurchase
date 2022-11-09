/**
  * @FileName : SqlSessionVO.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package common.vo.common;

import java.io.IOException;
import java.io.Reader;
import java.util.Properties;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import common.helper.convert.CommonConvert;


/**
 *   * @FileName : SqlSessionVO.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
public class SqlSessionVO {

	public SqlSessionFactory sqlSessionFactory = null;

	public SqlSessionVO ( ConnectionVO conVo, String mapPath ) throws IOException {
		String strMapPath = mapPath;
		String resource = "egovframework/sqlmap/config/" + CommonConvert.CommonGetStr( conVo.getDatabaseType( ) ) + "/" + CommonConvert.CommonGetStr( conVo.getErpTypeCode( ) ) + "/sql-map-mybatis-" + CommonConvert.CommonGetStr( conVo.getErpTypeCode( ) ) + "-config.xml";
		Properties props = new Properties( );
		props.put( "databaseType", CommonConvert.CommonGetStr( conVo.getDatabaseType( ) ) );
		props.put( "driver", CommonConvert.CommonGetStr( conVo.getDriver( ) ) );
		props.put( "url", CommonConvert.CommonGetStr( conVo.getUrl( ) ) );
		props.put( "username", CommonConvert.CommonGetStr( conVo.getUserId( ) ) );
		props.put( "password", CommonConvert.CommonGetStr( conVo.getPassword( ) ) );
		props.put( "erpTypeCode", CommonConvert.CommonGetStr( conVo.getErpTypeCode( ) ) );
		Reader reader = Resources.getResourceAsReader( resource );
		sqlSessionFactory = new SqlSessionFactoryBuilder( ).build( reader, props );
	}

	public SqlSessionFactory getSqlSessionFactory ( ) {
		return sqlSessionFactory;
	}
}

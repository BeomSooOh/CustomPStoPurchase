package cmm.helper;

import javax.sql.DataSource;

import org.apache.ibatis.datasource.pooled.PooledDataSource;
import org.apache.ibatis.mapping.Environment;
import org.apache.ibatis.session.Configuration;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.ibatis.transaction.TransactionFactory;
import org.apache.ibatis.transaction.jdbc.JdbcTransactionFactory;

import cmm.vo.ConnectionVO;

public class SqlSessionManager {

	/* 변수정의 */
	public static SqlSessionFactory sqlSession;

	/* 커넥션 생성 */
	public static SqlSessionFactory getSqlSession(ConnectionVO conVo, String packagePath) throws Exception {
		String driver = conVo.getDriver();
		String username = conVo.getUserId();
		String password = conVo.getPassWord();
		String url = conVo.getUrl();

		String strPackagePath = packagePath;

		DataSource dataSource = new PooledDataSource(driver, url, username, password);
		TransactionFactory transactionFactory = new JdbcTransactionFactory();
		Environment environment = new Environment("development", transactionFactory, dataSource);
		Configuration configuration = new Configuration(environment);

		// 나중에, package 하위 클래스를 찾아서 자동으로 mapper 하는 기능 구현
		/*
		 * switch (packagePath) { case SystemCommonInterface.packagePath.codeAcct: configuration.addMapper(ex.dao.code.acct.mariadb.class); configuration.addMapper(ex.dao.code.acct.oracle.class); configuration.addMapper(ex.dao.code.acct.mssql.class); break; case SystemCommonInterface.packagePath.codeAuth: configuration.addMapper(ex.dao.code.auth.mariadb.class); configuration.addMapper(ex.dao.code.auth.oracle.class); configuration.addMapper(ex.dao.code.auth.mssql.class); break; case SystemCommonInterface.packagePath.codeTax: configuration.addMapper(ex.dao.code.tax.mariadb.class); configuration.addMapper(ex.dao.code.tax.oracle.class); configuration.addMapper(ex.dao.code.tax.mssql.class); break; case SystemCommonInterface.packagePath.codeCommon: configuration.addMapper(ex.dao.code.common.mariadb.class); configuration.addMapper(ex.dao.code.common.oracle.class); configuration.addMapper(ex.dao.code.common.mssql.class); break; case SystemCommonInterface.packagePath.commonSystem:
		 * configuration.addMapper(ex.dao.common.system.mariadb.class); configuration.addMapper(ex.dao.common.system.oracle.class); configuration.addMapper(ex.dao.common.system.mssql.class); break; case SystemCommonInterface.packagePath.config: configuration.addMapper(ex.dao.config.mariadb.class); configuration.addMapper(ex.dao.config.oracle.class); configuration.addMapper(ex.dao.config.mssql.class); break; case SystemCommonInterface.packagePath.codeProject: configuration.addMapper(ex.dao.code.project.mariadb.class); configuration.addMapper(ex.dao.code.project.oracle.class); configuration.addMapper(ex.dao.code.project.mssql.class); break; case SystemCommonInterface.packagePath.expendMaster: configuration.addMapper(ex.dao.expend.master.mariadb.class); configuration.addMapper(ex.dao.expend.master.mssql.class); configuration.addMapper(ex.dao.expend.master.oracle.class); break; case SystemCommonInterface.packagePath.codeVat: configuration.addMapper(ex.dao.code.vat.mariadb.class);
		 * configuration.addMapper(ex.dao.code.vat.oracle.class); configuration.addMapper(ex.dao.code.vat.mssql.class); break; default: break; }
		 */

		sqlSession = new SqlSessionFactoryBuilder().build(configuration);

		return sqlSession;
	}
}

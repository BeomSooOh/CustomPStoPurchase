package expend.ex.admin.yesil;

import java.io.Reader;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import javax.annotation.Resource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Repository;
import com.ibatis.common.resources.Resources;
import common.helper.connection.CommonExConnect;
import common.helper.convert.CommonConvert;
import common.helper.logger.CommonLogger;
import common.helper.logger.ExpInfo;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository("FExAdminYesilServiceUDAO")
public class FExAdminYesilServiceUDAO extends EgovComAbstractDAO {

    /* 변수정의 - Common */
    /* 변수정의 - class */
    CommonExConnect connector = new CommonExConnect();
    @Resource(name = "CommonLogger")
    private CommonLogger cmLog;
    /* 변수정의 */
    private SqlSessionFactory sqlSessionFactory;

    /* 공통사용 */
    /* 공통사용 - 커넥션 */
    @SuppressWarnings("unused")
    private boolean connect(ConnectionVO conVo) throws Exception {
        boolean result = false;
        try {
            // 환경 설정 파일의 경로를 문자열로 저장 / String resource = "sample/mybatis/sql/mybatis-config.xml";
            String resource = "egovframework/sqlmap/config/" + CommonConvert.CommonGetStr(conVo.getDatabaseType()) + "/ERPiU/sql-map-mybatis-ERPiU-config.xml";
            Properties props = new Properties();
            props.put("databaseType", CommonConvert.CommonGetStr(conVo.getDatabaseType()));
            props.put("driver", conVo.getDriver());
            props.put("url", conVo.getUrl());
            props.put("username", conVo.getUserId());
            props.put("password", conVo.getPassword());
            props.put("erpTypeCode", conVo.getErpTypeCode());
            // 문자열로 된 경로의파일 내용을 읽을 수 있는 Reader 객체 생성
            Reader reader = Resources.getResourceAsReader(resource);
            // reader 객체의 내용을 가지고 SqlSessionFactory 객체 생성 / sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader, props);
            if (sqlSessionFactory == null) {
                sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader, props);
            } else {
                sqlSessionFactory = null;
                sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader, props);
            }
            result = true;
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            throw e;
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> ExAdminYesil2CommonCode(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        if (params.get("erpCompSeq") == null || params.get("erpCompSeq").toString().equals("")) {
            ExpInfo.CoreLogNotLoop("ERP 회사코드를 확인할 수 없습니다. [" + Thread.currentThread().getStackTrace()[1].getClassName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName() + "]", null);
        }

        List<Map<String, Object>> result = new ArrayList<>();
        if (CommonConvert.CommonGetStr(conVo.getDatabaseType()).equals(commonCode.ORACLE)) {
            params.put("RC1", null);
            params.put("RC2", null);
            connector.List(conVo, "AdminiUYesil2.ExAdminYesil2CommonCode", params);
            result = (List<Map<String, Object>>) params.get("RC1");
        } else if (CommonConvert.CommonGetStr(conVo.getDatabaseType()).equals(commonCode.MSSQL)) {
            result = connector.List(conVo, "AdminiUYesil2.ExAdminYesil2CommonCode", params);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> ExAdminYesil2DetailAuth(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        if (params.get("erpCompSeq") == null || params.get("erpCompSeq").toString().equals("")) {
            ExpInfo.CoreLogNotLoop("ERP 회사코드를 확인할 수 없습니다. [" + Thread.currentThread().getStackTrace()[1].getClassName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName() + "]", null);
        }

        List<Map<String, Object>> result = new ArrayList<>();
        if (CommonConvert.CommonGetStr(conVo.getDatabaseType()).equals(commonCode.ORACLE)) {
            params.put("RC1", null);
            connector.List(conVo, "AdminiUYesil2.ExAdminYesil2DetailAuth", params);
            result = (List<Map<String, Object>>) params.get("RC1");
        } else if (CommonConvert.CommonGetStr(conVo.getDatabaseType()).equals(commonCode.MSSQL)) {
            result = connector.List(conVo, "AdminiUYesil2.ExAdminYesil2DetailAuth", params);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> ExAdminYesil2BudgetGr(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        if (params.get("erpCompSeq") == null || params.get("erpCompSeq").toString().equals("")) {
            ExpInfo.CoreLogNotLoop("ERP 회사코드를 확인할 수 없습니다. [" + Thread.currentThread().getStackTrace()[1].getClassName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName() + "]", null);
        }

        List<Map<String, Object>> result = new ArrayList<>();
        if (CommonConvert.CommonGetStr(conVo.getDatabaseType()).equals(commonCode.ORACLE)) {
            params.put("RC1", null);
            connector.List(conVo, "AdminiUYesil2.ExAdminYesil2BudgetGr", params);
            result = (List<Map<String, Object>>) params.get("RC1");
        } else if (CommonConvert.CommonGetStr(conVo.getDatabaseType()).equals(commonCode.MSSQL)) {
            result = connector.List(conVo, "AdminiUYesil2.ExAdminYesil2BudgetGr", params);
        }
        return result;
    }

    public List<Map<String, Object>> ExAdminYesil2BudgetCodeSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        if (params.get("erpCompSeq") == null || params.get("erpCompSeq").toString().equals("")) {
            ExpInfo.CoreLogNotLoop("ERP 회사코드를 확인할 수 없습니다. [" + Thread.currentThread().getStackTrace()[1].getClassName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName() + "]", null);
        }

        List<Map<String, Object>> result = connector.List(conVo, "AdminiUYesil2.ExAdminYesil2BudgetCodeSelect", params);
        return result;
    }

    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> ExAdminYesil2BizPlan(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        if (params.get("erpCompSeq") == null || params.get("erpCompSeq").toString().equals("")) {
            ExpInfo.CoreLogNotLoop("ERP 회사코드를 확인할 수 없습니다. [" + Thread.currentThread().getStackTrace()[1].getClassName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName() + "]", null);
        }

        List<Map<String, Object>> result = new ArrayList<>();
        if (CommonConvert.CommonGetStr(conVo.getDatabaseType()).equals(commonCode.ORACLE)) {
            params.put("RC1", null);
            connector.List(conVo, "AdminiUYesil2.ExAdminYesil2BizPlan", params);
            result = (List<Map<String, Object>>) params.get("RC1");
        } else if (CommonConvert.CommonGetStr(conVo.getDatabaseType()).equals(commonCode.MSSQL)) {
            result = connector.List(conVo, "AdminiUYesil2.ExAdminYesil2BizPlan", params);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> ExAdminYesil2BudgetAcctInfo(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        if (params.get("erpCompSeq") == null || params.get("erpCompSeq").toString().equals("")) {
            ExpInfo.CoreLogNotLoop("ERP 회사코드를 확인할 수 없습니다. [" + Thread.currentThread().getStackTrace()[1].getClassName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName() + "]", null);
        }

        List<Map<String, Object>> result = new ArrayList<>();
        if (CommonConvert.CommonGetStr(conVo.getDatabaseType()).equals(commonCode.ORACLE)) {
            params.put("RC1", null);
            connector.List(conVo, "AdminiUYesil2.ExAdminYesil2BudgetAcctInfo", params);
            result = (List<Map<String, Object>>) params.get("RC1");
        } else if (CommonConvert.CommonGetStr(conVo.getDatabaseType()).equals(commonCode.MSSQL)) {
            result = connector.List(conVo, "AdminiUYesil2.ExAdminYesil2BudgetAcctInfo", params);
        }
        return result;
    }

    public List<Map<String, Object>> ExAdminYesil2InfoSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        if (params.get("erpCompSeq") == null || params.get("erpCompSeq").toString().equals("")) {
            ExpInfo.CoreLogNotLoop("ERP 회사코드를 확인할 수 없습니다. [" + Thread.currentThread().getStackTrace()[1].getClassName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName() + "]", null);
        }
        List<Map<String, Object>> result = new ArrayList<>();
        if (CommonConvert.CommonGetStr(conVo.getDatabaseType()).equals(commonCode.ORACLE)) {
        	if(params.get("erpCompSeq").equals("kef")) {
        		result = connector.yesilList_oracle(conVo, "AdminiUYesil2.ExAdminYesil2InfoSelectKef", params);
        	}
        	else {
        		result = connector.yesilList_oracle(conVo, "AdminiUYesil2.ExAdminYesil2InfoSelect", params);
        	}
        }else if (CommonConvert.CommonGetStr(conVo.getDatabaseType()).equals(commonCode.MSSQL)) {
        	result = connector.List(conVo, "AdminiUYesil2.ExAdminYesil2InfoSelect", params);
        }
        return result;
    }

    public List<Map<String, Object>> ExAdminYesil2DeptInfo(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        if (params.get("erpCompSeq") == null || params.get("erpCompSeq").toString().equals("")) {
            ExpInfo.CoreLogNotLoop("ERP 회사코드를 확인할 수 없습니다. [" + Thread.currentThread().getStackTrace()[1].getClassName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName() + "]", null);
        }

        List<Map<String, Object>> result = connector.List(conVo, "AdminiUYesil2.ExAdminYesil2DeptInfo", params);
        return result;
    }

    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> ExAdminYesil2DetailPopInfo(Map<String, Object> params) {
        if (params.get("erpCompSeq") == null || params.get("erpCompSeq").toString().equals("")) {
            ExpInfo.CoreLogNotLoop("ERP 회사코드를 확인할 수 없습니다. [" + Thread.currentThread().getStackTrace()[1].getClassName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName() + "]", null);
        }

        List<Map<String, Object>> result = list("ExAdminYesilA.ExAdminYesil2DetailPopInfo", params);
        return result;
    }
    
    @SuppressWarnings("unchecked")
    public List<Map<String,Object>> ExAdminIuYesilExpendDetailPop(Map<String,Object> params){
      if (params.get("erpCompSeq") == null || params.get("erpCompSeq").toString().equals("")) {
        ExpInfo.CoreLogNotLoop("ERP 회사코드를 확인할 수 없습니다. [" + Thread.currentThread().getStackTrace()[1].getClassName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName() + "]", null);
      }
      params.put("fromDt", params.get("fromDt").toString().replace("-", ""));
      params.put("toDt", params.get("toDt").toString().replace("-", ""));
      List<Map<String, Object>> result = list("ExAdminYesilA.ExAdminIuYesilExpendDetailPop",params);
      
      return result;
    }
    
    @SuppressWarnings("unchecked")
    public List<Map<String,Object>> ExAdminIuYesilExpendTop(Map<String, Object> params){
      if (params.get("erpCompSeq") == null || params.get("erpCompSeq").toString().equals("")) {
        ExpInfo.CoreLogNotLoop("ERP 회사코드를 확인할 수 없습니다. [" + Thread.currentThread().getStackTrace()[1].getClassName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName() + "]", null);
      }
      List<Map<String, Object>> result = list("ExAdminYesilA.ExAdminIuYesilExpendTopp",params);
      
      return result;
    }
    
    
    
    
}

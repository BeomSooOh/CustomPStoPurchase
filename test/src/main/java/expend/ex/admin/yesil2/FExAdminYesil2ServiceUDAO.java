package expend.ex.admin.yesil2;

import java.io.Reader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
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

@Repository("FExAdminYesil2ServiceUDAO")
public class FExAdminYesil2ServiceUDAO extends EgovComAbstractDAO {

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
    public List<Map<String, Object>> ExAdminIuYesilCommonCode(Map<String, Object> params, ConnectionVO conVo) throws Exception {

        if (params.get("erpCompSeq") == null || params.get("erpCompSeq").toString().equals("")) {
            ExpInfo.CoreLogNotLoop("ERP 회사코드를 확인할 수 없습니다. [" + Thread.currentThread().getStackTrace()[1].getClassName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName() + "]", null);
        }
        List<Map<String, Object>> result = new ArrayList<>();

        if (CommonConvert.CommonGetStr(conVo.getDatabaseType()).equals(commonCode.ORACLE)) {
            params.put("RC1", null);
            params.put("RC2", null);
            connector.List(conVo, "AdminIuYesil.ExAdminIuYesilCommonCode", params);
            result = (List<Map<String, Object>>) params.get("RC1");
        } else if (CommonConvert.CommonGetStr(conVo.getDatabaseType()).equals(commonCode.MSSQL)) {
            result = connector.List(conVo, "AdminIuYesil.ExAdminIuYesilCommonCode", params);
        }
        return result;
    }

    public Map<String, Object> ExAdminIuYesilDeptInfo(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        if (params.get("erpCompSeq") == null || params.get("erpCompSeq").toString().equals("")) {
            ExpInfo.CoreLogNotLoop("ERP 회사코드를 확인할 수 없습니다. [" + Thread.currentThread().getStackTrace()[1].getClassName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName() + "]", null);
        }
        Map<String, Object> result = connector.Select(conVo, "AdminIuYesil.ExAdminIuYesilDeptInfo", params);
        return result;
    }


    public List<Map<String, Object>> ExAdminIuYesilInfoSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        if (params.get("erpCompSeq") == null || params.get("erpCompSeq").toString().equals("")) {
            ExpInfo.CoreLogNotLoop("ERP 회사코드를 확인할 수 없습니다. [" + Thread.currentThread().getStackTrace()[1].getClassName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName() + "]", null);
        }
        List<Map<String, Object>> result = new ArrayList<>();
        if (CommonConvert.CommonGetStr(conVo.getDatabaseType()).equals(commonCode.ORACLE)) {
            result = connector.yesilList_oracle(conVo, "AdminIuYesil.ExAdminIuYesilInfoSelect", params);
        } else if (CommonConvert.CommonGetStr(conVo.getDatabaseType()).equals(commonCode.MSSQL)) {
            result = connector.List(conVo, "AdminIuYesil.ExAdminIuYesilInfoSelect", params);
        }
        return result;
    }

    public Map<String,Object> ExAdminYesilBizPlanCheck(Map<String,Object> params,ConnectionVO conVo) throws Exception{
      if (params.get("erpCompSeq") == null || params.get("erpCompSeq").toString().equals("")) {
        ExpInfo.CoreLogNotLoop("ERP 회사코드를 확인할 수 없습니다. [" + Thread.currentThread().getStackTrace()[1].getClassName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName() + "]", null);
      }
      Map<String, Object> result = (Map<String, Object>) connector.Select(conVo, "AdminIuYesil.ExAdminIuYesilBizPlanCheck", params);

      return result;
    }


    public List<Map<String, Object>> selectCommonBgacctCode(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();

        try {
            // 검색조건 파라미터가 없는 경우 기본값으로 지정
            Date nowDate = new Date();

            if (params.get("fromDt") == null) {
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy", Locale.getDefault());
                params.put("fromDt", dateFormat.format(nowDate));
            }

            if (params.get("toDt") == null) {
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMM", Locale.getDefault());
                params.put("toDt", dateFormat.format(nowDate));
            }

            if (params.get("bgacctType") == null) {
                params.put("bgacctType", commonCode.EMPTYSTR);
            }

            if (params.get("isConnectedBizplan") == null) {
                params.put("isConnectedBizplan", commonCode.EMPTYYES);
            }

            if (params.get(commonCode.SEARCHSTR) == null) {
                params.put(commonCode.SEARCHSTR, commonCode.EMPTYSTR);

            }

            List<Map<String, Object>> erpBudgetResult = new ArrayList<Map<String, Object>>();

            params.put("fromDtConvert", params.get("fromDt").toString().substring(0,6));
            params.put("toDtConvert", params.get("toDt").toString().substring(0,6));


            erpBudgetResult = connector.List(conVo, "AdminIuYesil.selectCommonBgacctCode", params);
            //System.out.println(erpBudgetResult.size());

            List<Map<String, Object>> gwBudgetResult = new ArrayList<Map<String, Object>>();

            params.put("cdBizplanPipe", (params.get("cdBizplanPipe").toString().equals("") ? "***" : params.get("cdBizplanPipe")));
            gwBudgetResult = this.list("ExAdminExpendSend.selectYesilBagcctCode", params);

            for (int i = (erpBudgetResult.size() - 1); i >= 0; i--) {
                Map<String, Object> t = new HashMap<String, Object>();
                t = erpBudgetResult.get(i);

                // CD_BUDGET / NM_BUDGET / CD_BIZPLAN / NM_BIZPLAN / CD_BGACCT / NM_BGACCT / YY_BUDGET / AM_ACTSUM / AM_EXP / AM_DRCR / AM_LEAVE / AM_PER
                double amActsum = 0;
                double amExp = 0;
                double amDrcr = 0;
                double amLeave = 0;
                double amPer = 0;

                if(gwBudgetResult.size() > 0) {
                  for (Map<String, Object> tBudget : gwBudgetResult) {

                      if (t.get("CD_BUDGET").toString().equals(tBudget.get("CD_BUDGET").toString())
                          && t.get("CD_BIZPLAN").toString().equals(tBudget.get("CD_BIZPLAN").toString())
                          && t.get("CD_BGACCT").toString().equals(tBudget.get("CD_BGACCT").toString())) {

                    	  amActsum = Double.parseDouble(t.get("AM_ACTSUM").toString());
                    	  amExp = Double.parseDouble(tBudget.get("AM_EXP").toString());
                    	  amDrcr = Double.parseDouble(t.get("AM_DRCR").toString());
                    	  amLeave = Double.parseDouble(t.get("AM_LEAVE").toString());
                        gwBudgetResult.remove(gwBudgetResult.indexOf(tBudget));
                        break;
                      } else {
                    	  amActsum = Double.parseDouble(t.get("AM_ACTSUM").toString());
                    	  amExp = 0;
                    	  amDrcr = Double.parseDouble(t.get("AM_DRCR").toString());
                    	  amLeave = Double.parseDouble(t.get("AM_LEAVE").toString());
                      }
                  }
                } else {
                	amActsum = Double.parseDouble(t.get("AM_ACTSUM").toString());
                	amExp = 0;
                	amDrcr = Double.parseDouble(t.get("AM_DRCR").toString());
                	amLeave = Double.parseDouble(t.get("AM_LEAVE").toString());
                }

                t.put("AM_ACTSUM", amActsum);
                t.put("AM_EXP", amExp);
                t.put("AM_DRCR", ( amDrcr - amExp ));
                /* 집행잔액 => 실행예산 - ( 미전송결의 + 집행실적 ) */
                t.put("AM_LEAVE", (amActsum - ( amExp + (amDrcr-amExp)) ));
                /* 집행율 => (미전송결의 + 집행실적) / 실행예산 * 100  */
                // isNaN 처리 하는 곳
                amPer = ((amExp + (amDrcr - amExp)) / amActsum) * 100;
                t.put("AM_PER", ( Double.isNaN(amPer) ? 0.0 : amPer ));

                result.add(t);
                erpBudgetResult.remove(i);
            }

        } catch (Exception e) {
            e.printStackTrace();
            cmLog.CommonSetError(e);
            throw e;
        }

        return result;
    }


}

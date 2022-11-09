package expend.ex.user.etax;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Repository;
import common.helper.connection.CommonExConnect;
import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.helper.logger.ExpInfo;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExCodeETaxVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository("FExUserEtaxServiceIDAO")
public class FExUserEtaxServiceIDAO extends EgovComAbstractDAO {

  @Resource(name = "CommonInfo")
  private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
  private final CommonExConnect exConnect = new CommonExConnect();

  /* 매입전자세금계산서 - 매입전자세금계산서 목록 조회 */
  public List<ExCodeETaxVO> ExETaxListInfoSelect(ExCodeETaxVO etaxVo, ConnectionVO conVo)
      throws Exception {

    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + etaxVo.toString(), etaxVo);
    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + conVo.toString(), conVo);
    List<ExCodeETaxVO> etaxListVo = new ArrayList<ExCodeETaxVO>();
    try {
      Map<String, Object> param = CommonConvert.CommonGetObjectToMap(etaxVo);
      etaxListVo = exConnect.ETaxList(conVo, "ExETaxListInfoSelect", param);
    } catch (Exception e) {
      throw e;
    }
    return etaxListVo;
  }

  /* 매입전자세금계산서 - 매입전자세금계산서 조회 */
  public ExCodeETaxVO ExETaxDetailInfoSelect(ExCodeETaxVO etaxVo, ConnectionVO conVo)
      throws Exception {
    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + etaxVo.toString(), etaxVo);
    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + conVo.toString(), conVo);
    try {
      Map<String, Object> param = CommonConvert.CommonGetObjectToMap(etaxVo);
      param = exConnect.Select(conVo, "ExETaxDetailInfoSelect", param);
      CommonConvert.CommonGetMapToObject(param, etaxVo);
    } catch (Exception e) {
      throw e;
    }
    return etaxVo;
  }

  /* iCUBE 매입전자세금계산서 정보 업데이트 진행 */
  public ResultVO ExETaxInfoUpdate(ResultVO param, ConnectionVO conVo) {
    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + param.toString(), param);
    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + conVo.toString(), conVo);
    /* 변수정의 */
    try {
      exConnect.Update(conVo, "ExETaxInfoUpdate", param.getParams());
      param.setResultCode(commonCode.SUCCESS);
    } catch (Exception e) {
      param.setResultCode(commonCode.FAIL);
      throw e;
    }
    return param;
  }

  /* 매입전자세금계산서 - 매입전자세금계산서 목록 조회 */
  public List<Map<String, Object>> ExETaxListInfoSelectMap(ExCodeETaxVO etaxVo, ConnectionVO conVo)
      throws Exception {
    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + etaxVo.toString(), etaxVo);
    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + conVo.toString(), conVo);
    List<Map<String, Object>> etaxListVo = new ArrayList<Map<String, Object>>();
    try {
      Map<String, Object> param = CommonConvert.CommonGetObjectToMap(etaxVo);
      etaxListVo = exConnect.List(conVo, "ExETaxListInfoSelectMap", param);
    } catch (Exception e) {
      throw e;
    }
    return etaxListVo;
  }
  
  /*
   * 매입세금계산서 - 사업장 조회 
   * */
  public Map<String, Object> ExEtaxDivInfoSelect(Map<String, Object> param, ConnectionVO conVo){
      
      Map<String, Object> etaxDiv = exConnect.Select(conVo, "ExEtaxDivInfoSelect", param);
      
      return etaxDiv;
  }
  
  
}

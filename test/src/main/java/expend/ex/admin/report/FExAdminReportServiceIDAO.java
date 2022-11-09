package expend.ex.admin.report;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import common.helper.connection.CommonExConnect;
import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundDataException;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExCodeETaxVO;

/* 최상배 배포금지 */
@Repository("FExAdminReportServiceIDAO")
public class FExAdminReportServiceIDAO {

	/* 변수정의 - class */
	CommonExConnect connector = new CommonExConnect();

	/* ERP iCUBE IN_SQ정보 조회 */
	public String ExInSqSelect(ConnectionVO conVo, String expendDate) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("IN_DT", expendDate);
		return connector.Select(conVo, "ExInSqSelect", params).get("IN_SQ").toString();
	}

	/* ERP iCUBE 커스텀 컬럼 확인 */
	public int ExReportExpendErpCheckColumn(ConnectionVO conVo) throws Exception {
		int result = 0;
		result = Integer.parseInt(
				connector.Select(conVo, "ExSAUTODOCUDColumnSelect", null).get("exists_doc_info_columns").toString());
		return result;
	}

    /* ERP iCUBE 전표 정보 전송 */
    public int ExReportExpendErpSendWithDocInfo(ConnectionVO conVo, Map<String, Object> param, String inDt,
            String inSq, int lnSq, String docId, String docNo) throws Exception {
        param.put("IN_DT", inDt);
        param.put("IN_SQ", (commonCode.EMPTYSTR + inSq));
        param.put("LN_SQ", (commonCode.EMPTYSTR + lnSq));
        param.put("DOC_ID", (commonCode.EMPTYSTR + docId));
        param.put("DOC_NO", (commonCode.EMPTYSTR + docNo));

        return connector.Insert(conVo, "ExSAUTODOCUDInsertWithDocInfo", param, "send");
    }

	/* ERP iCUBE 전표 정보 전송 / 문서 정보 없는 구 버전 */
	public int ExReportExpendErpSend(ConnectionVO conVo, Map<String, Object> param, String inDt, String inSq,
			int lnSq) throws Exception {
		param.put("IN_DT", inDt);
		param.put("IN_SQ", (commonCode.EMPTYSTR + inSq));
		param.put("LN_SQ", (commonCode.EMPTYSTR + lnSq));
		return connector.Insert(conVo, "ExSAUTODOCUDInsert", param);
	}

	/* 지출결의 - 자동전표 삭제 가능여부 확인 */
	public int ExReportExpendReturnCountInfoSelect(Map<String, Object> param, ConnectionVO conVo) throws Exception {
		int resultVal = 0;
		try {
			resultVal = Integer.parseInt(connector.Select(conVo, "ExCheckCanDelete", param).get("COUNT").toString());
		} catch (Exception e) {
			return 0;
		}
		return resultVal;
	}

	/* 지출결의 - 자동전표 삭제 */
	public int ExReportExpendSendInfoDelete(Map<String, Object> param, ConnectionVO conVo) throws Exception {
		int result = 0;
		result = Integer.parseInt(connector.Select(conVo, "ExSAUTODOCUDDelete", param).get("returnValue").toString());
		if (result == 0) {
			throw new NotFoundDataException(param.toString());
		}
		return result;
	}

	/* ERP 전송한 전표 삭제 */
	public ResultVO ExAdminExpendSendERPDataDelete(ResultVO param, ConnectionVO conVo) throws Exception {
		try {
			param.setAaData(connector.List(conVo, "ExAdminExpendSendERPDataDelete", param.getParams()));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return param;
	}
	
	/*
	 * 준성 
	 * ERP iCUBE
	 * ACARD_SUNGIN UPDATE
	 * */
	public int ExAdminExpendERPAcardSunginGwState(ResultVO param, ConnectionVO conVo) {
	  int result = 0;

      result = connector.Update(conVo, "ExAdminAcardInfoUpdate", param.getParams());
	  
	  return result;
	}

	/* 매입전자세금계산서 ERP 연동 정보 초기화(iCUBE) */
	/* iCUBE 매입전자세금계산서 정보 업데이트 진행 */
	public int ExAdminExpendOtherSystemERPInfoReollback(ResultVO param, ConnectionVO conVo) {
		/* 변수정의 */
		int result = 0;
		result = connector.Update(conVo, "ExAdminETaxInfoUpdate", param.getParams());
		return result;
	}

	/* 매입전자세금계산서 - 매입전자세금계산서 목록 조회 */
	public List<Map<String, Object>> ExAdminETaxListInfoSelectMap(ExCodeETaxVO etaxVo, ConnectionVO conVo)
			throws Exception {
		List<Map<String, Object>> etaxListVo = new ArrayList<Map<String, Object>>();
		try {
			Map<String, Object> param = CommonConvert.CommonGetObjectToMap(etaxVo);
			etaxListVo = connector.List(conVo, "ExAdminETaxListInfoSelectMap", param);
		} catch (Exception e) {
			throw e;
		}
		return etaxListVo;
	}

	/* 지출결의 - iCUBE 연동문서 현황 문서 삭제 */
	public ResultVO ExAdminiCUBEDocListDelete(ResultVO param, ConnectionVO conVo) throws Exception {
		/* 변수정의 */
	        if(param.getParams().get("approKey") == null || param.getParams().get("approKey").toString().equals("")) {
	            throw new Exception("approKey 값이 수신되지 않았습니다.");
	        }

		int result = 0;
		result = connector.ErpDocUpdate(conVo, "ExAdminiCUBEDocListDelete", param.getParams());
		if (result > 0) {
			param.setResultCode(commonCode.SUCCESS);
		} else {
			param.setResultCode(commonCode.FAIL);
		}
		return param;
	}
}

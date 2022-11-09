package common.batch.cms;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Repository;
import org.springframework.util.StopWatch;
import bizbox.orgchart.constant.CloudConstants;
import common.helper.logger.CommonLogger;
import common.vo.batch.CommonBatchCmsConfigVO;
import common.vo.batch.CommonBatchCmsDataVO;
import common.vo.common.CommonInterface.commonCode;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository("CommonBatchCmsBizboxDAO")
public class CommonBatchCmsBizboxDAO extends EgovComAbstractDAO {

    /* 변수정의 - Common */
    @Resource(name = "CommonLogger")
    CommonLogger cmLog;
    /* sql-map-config-mariadb-common.xml */
    /* sql-map-config-mariadb-common.xml - CommonBatchCms_SQL.xml */

    /* Batch - CMS */
    /* Batch - CMS - Config */
    /* Batch - CMS - Config - Insert */
    public int CommonCmsConfigInfoInsert(CommonBatchCmsConfigVO params) throws Exception {
        int result = Integer.parseInt(commonCode.EMPTYSEQ);
        /* insert return : 입력 시 selectKey 를 사용하여 key 를 딴 경우 해당 key */
        result = (int) insert("CommonBatchCmsBizboxDAO.CommonCmsConfigInfoInsert", params);
        return result;
    }

    /* Batch - CMS - Config - Delete */
    public int CommonCmsConfigInfoDelete(CommonBatchCmsConfigVO params) throws Exception {
        int result = Integer.parseInt(commonCode.EMPTYSEQ);
        /* DBMS가 지원하는 경우 delete 적용 결과 count */
        result = delete("CommonBatchCmsBizboxDAO.CommonCmsConfigInfoDelete", params);
        return result;
    }

    /* Batch - CMS - Config - List */
    @SuppressWarnings("unchecked")
    public List<CommonBatchCmsConfigVO> CommonCmsConfigInfoListSelect(Map<String, String> custInfo) throws Exception {
        List<CommonBatchCmsConfigVO> result = new ArrayList<CommonBatchCmsConfigVO>();
        /*
         * 결과 List 객체 - SQL mapping 파일에서 지정한 resultClass/resultMap 에 의한 결과 객체(보통 VO 또는 Map)의 List
         */
        /*
         * 검색조건은 무조건 !! cms_sync_yn = 'Y' AND cms_batch_yn = 'Y' AND cms_process_yn = 'N'
         */
        result = list("CommonBatchCmsBizboxDAO.CommonCmsConfigInfoListSelect", custInfo);
        return result;
    }
    
    /* Batch - CMS 카드 연동 중 상태 값 업데이트 */
    public int CommonCmsRunYnUpdate(Map<String, Object> mapCmsSyncParams) throws Exception {
        int result = Integer.parseInt(commonCode.EMPTYSEQ);
        /* DBMS가 지원하는 경우 update 적용 결과 count */
        result = update("CommonBatchCmsBizboxDAO.CommonCmsRunYnUpdate", mapCmsSyncParams);
        return result;
    }

    /* Batch - CMS - Config - Update */
    /* Batch - CMS - Config - Update - Setting */
    public int CommonCmsConfigInfoUpdate(CommonBatchCmsConfigVO params) throws Exception {
        int result = Integer.parseInt(commonCode.EMPTYSEQ);
        /* DBMS가 지원하는 경우 update 적용 결과 count */
        result = update("CommonBatchCmsBizboxDAO.CommonCmsConfigInfoUpdate", params);
        return result;
    }

    /* Batch - CMS - Config - Update - Process Y */
    public int CommonCmsConfigInfoProcessUpdate_Y() throws Exception {
        int result = Integer.parseInt(commonCode.EMPTYSEQ);
        /* DBMS가 지원하는 경우 update 적용 결과 count */
        result = update("CommonBatchCmsBizboxDAO.CommonCmsConfigInfoProcessUpdate_Y");
        return result;
    }

    /* Batch - CMS - Config - Update - Process N */
    public int CommonCmsConfigInfoProcessUpdate_N(Map<String, String> param) throws Exception {
        int result = Integer.parseInt(commonCode.EMPTYSEQ);
        /* DBMS가 지원하는 경우 update 적용 결과 count */
        result = update("CommonBatchCmsBizboxDAO.CommonCmsConfigInfoProcessUpdate_N", param);
        return result;
    }

    public int CommonCmsiCUBEInfoListUpdate(List<Map<String, Object>> params) throws Exception {
        /* key : ACCT_NO, BANK_CODE, TRADE_DATE, TRADE_TIME, SEQ */
        int result = Integer.parseInt(commonCode.EMPTYSEQ);
        /* >> List 전달로 변경 개발 필요 */
        for (Map<String, Object> map : params) {
            result += update("CommonBatchCmsBizboxDAO.CommonCmsiCUBEInfoListUpdate", map);
        }
        if (result != params.size()) {
            result = 0;
        }
        return result;
    }

    /* Batch - CMS - CARDAQTMP */
    /* Batch - CMS - CARDAQTMP - Insert */
    public int CommonCmsCardTempInfoInsert(CommonBatchCmsDataVO params) {
        int result = Integer.parseInt(commonCode.EMPTYSEQ);
        result = (int) select("CommonBatchCmsBizboxDAO.CommonCmsCardTempInfoSelect", params);
        if (result < 1) {
        	params.setMercAddr( params.getMercAddr( ).replace( "'", "''" ) );
            result = Integer.parseInt((String) insert("CommonBatchCmsBizboxDAO.CommonCmsCardTempInfoInsert", params));
        } else {
            result = 0;
        }
        return result;
    }

    // CommonCmsConfigInfoModifyDate
    /* Batch - CMS - Config - Update - modifydate N */
    public void CommonCmsConfigInfoModifyDate(Map<String, String> param) throws Exception {
        update("CommonBatchCmsBizboxDAO.CommonCmsConfigInfoModifyDate", param);
    }

    public int CommonCmsCardTempInfoInsertAll(CommonBatchCmsDataVO params) throws Exception {
      
      StopWatch beforeInsert  = new StopWatch();

      beforeInsert.start();
      logger.error("[RunTest] beforeInsert 시작");
      
        if (params.getPK1() == null || params.getPK1().equals("")) {
            /* 키값이 존재하지 않는 경우 생성안함. */
            return 0;
        }

        // 반환값 정의
        int result = Integer.parseInt(commonCode.EMPTYSEQ);

        // t_ex_card_aq_tmp_sub 생성
        if (params.getCO_CD() != null && !params.getCO_CD().equals("")) {
            insert("CommonBatchCmsBizboxDAO.CommonCmsCardTempInfoAllSubInsert", params);
        }

        // 중복확인 ( EBANK_KEY )
        result = (int) select("CommonBatchCmsBizboxDAO.CommonCmsCardTempInfoAllEBANK_KEYSelect", params);
        if (result < 1) {
            // 중복확인 ( PK1 ~ PK7 )
            result = (int) select("CommonBatchCmsBizboxDAO.CommonCmsCardTempInfoAllPKSelect", params);
            if (result < 1) {
                result = Integer.parseInt((String) insert("CommonBatchCmsBizboxDAO.CommonCmsCardTempInfoAllInsert", params));

                // t_ex_card_aq_tmp_sub : sync_id 업데이트
                params.setSYNC_ID(((Map<String, Object>) select("CommonBatchCmsBizboxDAO.CommonCmsCardTempInfoAllSyncId", params)).get("SYNC_ID").toString());
                update("CommonBatchCmsBizboxDAO.CommonCmsCardTempInfoAllSubUpdate", params);
            } else {
                update("CommonBatchCmsBizboxDAO.CommonCmsCardTempInfoAllUpdate", params);

                // t_ex_card_aq_tmp_sub : sync_id 업데이트
                params.setSYNC_ID(((Map<String, Object>) select("CommonBatchCmsBizboxDAO.CommonCmsCardTempInfoAllSyncId", params)).get("SYNC_ID").toString());
                update("CommonBatchCmsBizboxDAO.CommonCmsCardTempInfoAllSubUpdate", params);

                result = 0;
            }
        } else {
            update("CommonBatchCmsBizboxDAO.CommonCmsCardTempInfoAllUpdate", params);

            // t_ex_card_aq_tmp_sub : sync_id 업데이트
            params.setSYNC_ID(((Map<String, Object>) select("CommonBatchCmsBizboxDAO.CommonCmsCardTempInfoAllSyncId", params)).get("SYNC_ID").toString());
            update("CommonBatchCmsBizboxDAO.CommonCmsCardTempInfoAllSubUpdate", params);

            result = 0;
        }
        
        beforeInsert.stop();
        logger.error("[RunTest] beforeInsert 종료");
        logger.error("[RunTest] beforeInsert 시간차이(m) :" + beforeInsert.getTotalTimeSeconds());


        return result;
    }
    
    /* Batch - CMS - Config - DiffrentGeoraeCall */
    @SuppressWarnings("unchecked")
    public int CommonCmsConfigDiffrentGeoraeCall(Map<String, Object> dateInfo) throws Exception {
        /* CMS 동기화시 과거 커스텀프로시저 사용으로 인한 중복 유입을 방지 */
    	int result = Integer.parseInt(commonCode.EMPTYSEQ);
        result = (int) select("CommonBatchCmsBizboxDAO.CommonCmsConfigDiffrentGeoraeCall", dateInfo);
        return result;
    }

	public void CommonCmsACardTempInfoInsert(StringBuffer sb, Map<String, Object> params) throws Exception{
  	    StopWatch insertTime = new StopWatch();
        logger.error("[CloudCmsRun] CommonCmsACardTempInfoInsert 조회 시작");
        insertTime.start();
  	  
		String cardData = sb.substring(1);
		params.put("cardData", cardData);
        insert("CommonBatchCmsBizboxDAO.CommonCmsACardTempInfoInsert", params);
        
        logger.error("[CloudCmsRun] CommonCmsACardTempInfoInsert 조회 끝");
        insertTime.stop();
        logger.error("[CloudCmsRun " + params.get("groupSeq") + "] CommonCmsACardTempInfoInsert 걸린 시간 : " + insertTime.getTotalTimeSeconds()  );
        
	}

	public void CommonCmsACardTempTrunate( Map<String, Object> param) {
         delete ("CommonBatchCmsBizboxDAO.CommonCmsACardTempTruncate",param);
	}

	public void CommonCmsCardTempUpdate( Map<String, Object> param) {
	  StopWatch CommonCmsCardTempUpdate = new StopWatch();
	  CommonCmsCardTempUpdate.start();
	  logger.error("[CloudCmsRun] CommonCmsCardTempUpdate시작");
	  
	  update("CommonBatchCmsBizboxDAO.CommonCmsCardTempUpdate",param);
	  logger.error("[CloudCmsRun] CommonCmsCardTempUpdate끝");
	  CommonCmsCardTempUpdate.stop();
	  logger.error("[CloudCmsRun " + param.get("groupSeq") + "] CommonCmsCardTempUpdate 걸린 시간 : " + CommonCmsCardTempUpdate.getTotalTimeSeconds()  );
	}
	
	public void CommonCmsCardTempInsert( Map<String, Object> param) {
	  StopWatch CommonCmsCardTempInsert = new StopWatch();
	  CommonCmsCardTempInsert.start();
	  logger.error("[CloudCmsRun] CommonCmsCardTempInsert시작");
	  
      insert("CommonBatchCmsBizboxDAO.CommonCmsCardTempInsert",param);
      
      logger.error("[CloudCmsRun] CommonCmsCardTempInser끝");
      CommonCmsCardTempInsert.stop();
      
      logger.error("[CloudCmsRun " + param.get("groupSeq") + "] CommonCmsCardTempInsert 걸린 시간 : " + CommonCmsCardTempInsert.getTotalTimeSeconds()  );
  }

}

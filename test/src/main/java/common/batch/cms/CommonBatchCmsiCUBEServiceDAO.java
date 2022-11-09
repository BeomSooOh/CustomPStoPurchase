package common.batch.cms;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.apache.logging.log4j.LogManager;
import org.springframework.stereotype.Repository;
import org.springframework.util.StopWatch;
import common.helper.connection.CommonBatchCmsConnect;
import common.helper.convert.CommonConvert;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCms;
import common.vo.common.ConnectionVO;


@Repository ( "CommonBatchCmsiCUBEServiceDAO" )
public class CommonBatchCmsiCUBEServiceDAO {
 
    private static org.apache.logging.log4j.Logger logger = LogManager.getLogger(CommonBatchCmsServiceImpl.class);


	/* 변수정의 */
	/* 변수정의 - Class */
	CommonBatchCmsConnect connector = new CommonBatchCmsConnect( );
	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	CommonLogger cmLog;

	/* Batch - CMS - iCUBE */
	/* Batch - CMS - iCUBE - Select */
	/* Batch - CMS - iCUBE - Select - ALL */
	public List<Map<String, Object>> CommonCmsiCUBEInfoListSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result.addAll( this.CommonCmsiCUBEInfoListSelect_HANA( conVo, params ) ); /* 하나은행 */
		result.addAll( this.CommonCmsiCUBEInfoListSelect_IBK( conVo, params ) ); /* 기업은행 */
		result.addAll( this.CommonCmsiCUBEInfoListSelect_SHINHAN( conVo, params ) ); /* 신한은행 */
		result.addAll( this.CommonCmsiCUBEInfoListSelect_SHINHANInsideBank( conVo, params ) ); /* 신한은행 InsideBank */
		// 미개발 상태
		// result.addAll( this.CommonCmsiCUBEInfoListSelect_KB( conVo, params ) ); /* 국민은행 */
		result.addAll( this.CommonCmsiCUBEInfoListSelect_NH( conVo, params ) ); /* 농협 */
		result.addAll( this.CommonCmsiCUBEInfoListSelect_WOORI( conVo, params ) ); /* 우리은행 */
		return result;
	}

	/* Batch - CMS - iCUBE - Select - 하나은행 */ /* VA_ZA_HANACMSCARDAPPR */
	private List<Map<String, Object>> CommonCmsiCUBEInfoListSelect_HANA ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		/* CO_CD, REG_NB, CARD_NO, APPR_DATE, APPR_NO, APPR_SEQ */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "CommonBatchCmsiCUBEServiceDAO.CommonCmsiCUBEInfoListSelect_HANA", params );
		for ( Map<String, Object> map : result ) {
			map.put( CommonConvert.CommonGetStr( commonCms.CMSTYPE ), CommonConvert.CommonGetStr( commonCms.CMSHAHA ) );
		}
		return result;
	}

	/* Batch - CMS - iCUBE - Select - 기업은행 */ /* VA_ZA_IBKCMSCARDAPPR */
	private List<Map<String, Object>> CommonCmsiCUBEInfoListSelect_IBK ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		/* CO_CD, REG_NB, BANK_CODE, CARD_NO, APPR_DATE, APPR_SEQ */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "CommonBatchCmsiCUBEServiceDAO.CommonCmsiCUBEInfoListSelect_IBK", params );
		for ( Map<String, Object> map : result ) {
			map.put( CommonConvert.CommonGetStr( commonCms.CMSTYPE ), CommonConvert.CommonGetStr( commonCms.CMSIBK ) );
		}
		return result;
	}

	/* Batch - CMS - iCUBE - Select - 국민은행 */ /* VA_ZA_KBCMSCARDAPPR */
	@SuppressWarnings ( "unused" )
	private List<Map<String, Object>> CommonCmsiCUBEInfoListSelect_KB ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		/* REG_NB, BANK_CODE, CARD_NO, APPR_DATE, APPR_SEQ */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "CommonBatchCmsiCUBEServiceDAO.CommonCmsiCUBEInfoListSelect_KB", params );
		for ( Map<String, Object> map : result ) {
			map.put( CommonConvert.CommonGetStr( commonCms.CMSTYPE ), CommonConvert.CommonGetStr( commonCms.CMSKB ) );
		}
		return result;
	}

	/* Batch - CMS - iCUBE - Select - 농협은행 */ /* VA_ZA_NHCMSCARDAPPR */
	@SuppressWarnings ( "unused" )
	private List<Map<String, Object>> CommonCmsiCUBEInfoListSelect_NH ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		/* CO_CD, REG_NB, BANK_CODE, CARD_NO, APPR_DATE, APPR_SEQ */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "CommonBatchCmsiCUBEServiceDAO.CommonCmsiCUBEInfoListSelect_NH", params );
		for ( Map<String, Object> map : result ) {
			map.put( CommonConvert.CommonGetStr( commonCms.CMSTYPE ), CommonConvert.CommonGetStr( commonCms.CMSNH ) );
		}
		return result;
	}

	/* Batch - CMS - iCUBE - Select - 신한은행 */ /* VA_ZA_SHINHANCMSCARDBUY */
	private List<Map<String, Object>> CommonCmsiCUBEInfoListSelect_SHINHAN ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		/* CARD_SEQ, APPR_BUY_DATE, APPR_BUY_NB_SEQ, APPR_DATE */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "CommonBatchCmsiCUBEServiceDAO.CommonCmsiCUBEInfoListSelect_SHINHAN", params );
		for ( Map<String, Object> map : result ) {
			map.put( CommonConvert.CommonGetStr( commonCms.CMSTYPE ), CommonConvert.CommonGetStr( commonCms.CMSSHINHAN ) );
		}
		return result;
	}
	
	/* Batch - CMS - iCUBE - Select - 신한은행 */ /* VA_ZA_SHINHANCMSCARDAPPR */
	private List<Map<String, Object>> CommonCmsiCUBEInfoListSelect_SHINHANInsideBank ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		/* CARD_SEQ, APPR_BUY_DATE, APPR_BUY_NB_SEQ, APPR_DATE */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "CommonBatchCmsiCUBEServiceDAO.CommonCmsiCUBEInfoListSelect_SHINHANInsideBank", params );
		for ( Map<String, Object> map : result ) {
			map.put( CommonConvert.CommonGetStr( commonCms.CMSTYPE ), CommonConvert.CommonGetStr( commonCms.CMSSHINHAN ) );
		}
		return result;
	}

	/* Batch - CMS - iCUBE - Select - 우리은행 */ /* VA_ZA_WOORICMSCARDAPPR */
	@SuppressWarnings ( "unused" )
	private List<Map<String, Object>> CommonCmsiCUBEInfoListSelect_WOORI ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		/* CO_CD, REG_NB, TRNX_ID, IF_KEY, APPR_CLASS, CARD_NO, APPR_NO, TRANS_DATE */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "CommonBatchCmsiCUBEServiceDAO.CommonCmsiCUBEInfoListSelect_WOORI", params );
		for ( Map<String, Object> map : result ) {
			map.put( CommonConvert.CommonGetStr( commonCms.CMSTYPE ), CommonConvert.CommonGetStr( commonCms.CMSWOORI ) );
		}
		return result;
	}

	/* Batch - CMS - iCUBE - Select - 스마트증빙 */ /* VA_ZA_SMARTCMSCARDAPPR */
	public List<Map<String, Object>> CommonCmsiCUBEInfoListSelect_SMART ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		/* CO_CD, ISS_DT, ISS_SQ */
		/* sample */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "CommonBatchCmsiCUBEServiceDAO.CommonCmsiCUBEInfoListSelect_SMART", params );
		for ( Map<String, Object> map : result ) {
			map.put( CommonConvert.CommonGetStr( commonCms.CMSTYPE ), CommonConvert.CommonGetStr( commonCms.CMSSMART ) );
		}
		return result;
	}

	/* Batch - CMS - iCUBE - Update - 스마트증빙 */ /* USP_ACY0050_BY_GWA_UPDATE */
	public Map<String, Object> CommonCmsiCUBEInfoUpdate_SMART ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		/* CO_CD, DTSQ_KEY, GET_FG, APPRO_STATE, DOCU_IDZ, DOCU_NO, IN_DT, IN_SQ, MODIFY_DT, MODIFY_IP */
		Map<String, Object> result = new HashMap<String, Object>( );
		result = connector.Select( conVo, "CommonBatchCmsiCUBEServiceDAO.CommonCmsiCUBEInfoUpdate_SMART", params );
		return result;
	}

	/* Batch - CMS - iCUBE - Select - 프로시저 */ /* 0 */
	public List<Map<String, Object>> CommonCmsiCUBEInfoListSelect_Procedure ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "CommonBatchCmsiCUBEServiceDAO.CommonCmsiCUBEInfoListSelect_Procedure", params );
		return result;
	}

    /* Batch - CMS - iCUBE - Select - 통합(2019. 11. 27) */
    public List<Map<String, Object>> CommonCmsiCUBEInfoListSelect_All(ConnectionVO conVo, Map<String, Object> params) throws Exception {
    	try {
    		
    	} catch(Exception ex) {
    		 ex.printStackTrace();
    		 logger.error("CommonCmsiCUBEInfoListSelect_All ERROR : " + ex.toString());
    	}
        StopWatch icubeProcedureSelect  = new StopWatch();
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        
        logger.error("[CloudCmsRun] ERP iCUBE 조회 시작");
        icubeProcedureSelect.start();
        
        result = connector.List(conVo, "CommonBatchCmsiCUBEServiceDAO.CommonCmsiCUBEInfoListSelect_All", params);
        logger.error("[CloudCmsRun] ERP iCUBE 조회 종료");
        icubeProcedureSelect.stop();
        
        logger.error("[CloudCmsRun " + params.get("groupSeq") + "] icubeProcedure 조회 걸린 시간 : " + icubeProcedureSelect.getTotalTimeSeconds()  );
        
        return result;
    }
}

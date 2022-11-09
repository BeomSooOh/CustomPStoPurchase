package common.helper.logger;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.Map;
import javax.annotation.Resource;
import org.apache.logging.log4j.LogManager;
import org.springframework.stereotype.Service;
import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;


@Service("CommonLogger")
public class CommonLogger {

    /* 변수정의 */
    /* 변수정의 - DAO */
    @Resource(name = "CommonLoggerDAO")
    CommonLoggerDAO dao;
    /* 변수정의 - Log */
    private final org.apache.logging.log4j.Logger LOG = LogManager.getLogger(CommonLogger.class);

    /* 로그 기록 */
    /* 로그 기록 - file */
    /* 로그 기록 - file - ERROR */
    public void CommonSetError(Exception e) {
        StringWriter sw = new StringWriter();
        e.printStackTrace(new PrintWriter(sw));
        String exceptionAsStrting = sw.toString();
        LOG.error("! [EXP] ERROR - " + exceptionAsStrting);
        e.printStackTrace();
    }

    /* 로그 기록 - file - INFO */
    public void CommonSetInfo(String message) {
        // LOG.info( "! [EXP] INFO - " + message );
    }

    /* 로그 기록 - database */
    /* 로그 기록 - database - ERROR */
    public void CommonSetErrorToDatabase(Exception e, String groupSeq, String compSeq, String moduleType) {
        /* file ERROR 기록 */
        StringWriter sw = new StringWriter();
        e.printStackTrace(new PrintWriter(sw));
        String exceptionAsStrting = sw.toString();
        // LOG.error( "! [EXP] ERROR - " + exceptionAsStrting );
        e.printStackTrace();
        /* database ERROR 기록 */
        StringBuffer exceptionAsStrtingBuffer = new StringBuffer();
        exceptionAsStrtingBuffer.append("! [EXP] ERROR - [" + moduleType + "] " + e.getMessage());
        Map<String, Object> params = new HashMap<String, Object>();
        params.put(commonCode.GROUPSEQ, CommonConvert.CommonGetStr(groupSeq));
        params.put(commonCode.COMPSEQ, CommonConvert.CommonGetStr(compSeq));
        params.put(commonCode.MODULE, CommonConvert.CommonGetStr(moduleType));
        params.put(commonCode.TYPE, CommonConvert.CommonGetStr(commonCode.ERROR));
        params.put(commonCode.MESSAGE, CommonConvert.CommonGetStr(exceptionAsStrtingBuffer.toString()));
        dao.CommonSetLogToDatabaseInsert(params);
    }

    /* 로그 기록 - database - INFO */
    public void CommonSetInfoToDatabase(String message, String compSeq, String moduleType) {
        this.CommonSetInfoToDatabase(message, "", compSeq, moduleType);
    }

    public void CommonSetInfoToDatabase(String message, String groupSeq, String compSeq, String moduleType) {
        /* file INFO 기록 */
        // LOG.info( "! [EXP] INFO - " + message );
        /* database INFO 기록 */
        StringBuffer exceptionAsStrtingBuffer = new StringBuffer();
        exceptionAsStrtingBuffer.append("! [EXP] INFO - [" + moduleType + "] " + message);
        Map<String, Object> params = new HashMap<String, Object>();
        params.put(commonCode.GROUPSEQ, CommonConvert.CommonGetStr(groupSeq));
        params.put(commonCode.COMPSEQ, CommonConvert.CommonGetStr(compSeq));
        params.put(commonCode.MODULE, CommonConvert.CommonGetStr(moduleType));
        params.put(commonCode.TYPE, CommonConvert.CommonGetStr(commonCode.INFO));
        params.put(commonCode.MESSAGE, CommonConvert.CommonGetStr(exceptionAsStrtingBuffer.toString().replace("'", "")));
        dao.CommonSetLogToDatabaseInsert(params);
    }
}

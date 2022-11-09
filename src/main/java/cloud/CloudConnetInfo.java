package cloud;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.logging.log4j.LogManager;
import bizbox.orgchart.util.JedisClient;
import cmm.util.DecryptUtil;
import common.helper.convert.CommonConvert;
import neos.cmm.util.BizboxAProperties;


public class CloudConnetInfo {

    /* 변수 선언 */
    private static JedisClient jedisClient = null;
    
    private static org.apache.logging.log4j.Logger logger = LogManager.getLogger(CloudConnetInfo.class);

	private final static String IPADDRESS = "BizboxA.redis.ip";
	private final static String PORT = "BizboxA.redis.port";
	private final static String PASSWORD = "BizboxA.redis.password";
	private static final String PROPERTIES_REDIS_SENTINEL_CLIENT_HOSTS = "BizboxA.redis.sentinel.client.hosts";
	private static final String PROPERTIES_REDIS_MASTER_NAME = "BizboxA.redis.master.name";
	
	private final static String HOST = "127.0.0.1";
	private final static int DB_PORT = 6380;
	private final static String DB_PASSWORD = "ejwhs@1234";

	/*
    private interface properitesName {

        String ipAddress = "BizboxA.redis.ip";
        String port = "BizboxA.redis.port";
        String password = "BizboxA.redis.password";
    }

    private interface basicDatabaseName {

        String host = "127.0.0.1";
        int port = 6380;
        String password = "ejwhs@1234";
    }
	*/

    /* 클라우드 정보 가져오는 객체 생성 */
    public static void getCloudInstanse() {
        if (jedisClient == null) {
            String host = "";
            int port = 6379;
            String password = "";
            if (CommonConvert.CommonGetStr(BizboxAProperties.getProperty(IPADDRESS)).equals("99")) {
                host = HOST;
            } else {
                host = BizboxAProperties.getProperty(IPADDRESS);
            }
            if (CommonConvert.CommonGetStr(BizboxAProperties.getProperty(PORT)).equals("99")) {
                port = DB_PORT;
            } else {
                port = Integer.parseInt(BizboxAProperties.getProperty(PORT));
            }
            if (CommonConvert.CommonGetStr(BizboxAProperties.getProperty(PASSWORD)).equals("99")) {
                password = DB_PASSWORD;
            } else {
                password = DecryptUtil.decrypt(BizboxAProperties.getProperty(PASSWORD));
            }
            
            String redisSentinelClientHosts = BizboxAProperties.getPropertyValueByKey(PROPERTIES_REDIS_SENTINEL_CLIENT_HOSTS);
    		String redisMasterName = BizboxAProperties.getPropertyValueByKey(PROPERTIES_REDIS_MASTER_NAME);
    		
    		jedisClient = jedisClient.getInstance(host, port, password, redisSentinelClientHosts, redisMasterName);
        }
    }

    /* 클라우드 정보 가져오는 객체 반환 */
    public static JedisClient getJedisClient() {
        if (jedisClient == null) {
            String host = "";
            int port = 6379;
            String password = "";
            if (CommonConvert.CommonGetStr(BizboxAProperties.getProperty(IPADDRESS)).equals("99")) {
                host = HOST;
            } else {
                host = BizboxAProperties.getProperty(IPADDRESS);
            }
            if (CommonConvert.CommonGetStr(BizboxAProperties.getProperty(PORT)).equals("99")) {
                port = DB_PORT;
            } else {
                port = Integer.parseInt(BizboxAProperties.getProperty(PORT));
            }
            if (CommonConvert.CommonGetStr(BizboxAProperties.getProperty(PASSWORD)).equals("99")) {
                password = DB_PASSWORD;
            } else {
                password = DecryptUtil.decrypt(BizboxAProperties.getProperty(PASSWORD));
            }
            jedisClient = JedisClient.getInstance(host, port, password);
        }
        return jedisClient;
    }

    /* 클라우드 형 DB 정보 가져오기 */
    public static Map<String, Object> getParamMap(String groupSeq) {
        try {
            if (groupSeq == null || groupSeq.equals("")) {
                throw new Exception("Not exist groupSeq");
            }
        } catch (Exception e) {
            logger.error("getparamMap - not exists groupSeq");
            return null;
        }

        Map<String, Object> databaseName = new HashMap<String, Object>();
        if (jedisClient == null) {
            try {
                CloudConnetInfo.getCloudInstanse();
            } catch (Exception e) {
                logger.debug("BizboxACloudInstanseError : " + e.getMessage());
            }
        }

        try {
            /* 클라우드 형 DB 정보 가져오기 */
            databaseName = jedisClient.getParamMap(groupSeq);

            if ((databaseName.get("DB_NEOS") == null ? "" : databaseName.get("DB_NEOS")).equals("")) {
                throw new Exception("Not exist DB_NEOS");
            } else if ((databaseName.get("DB_MOBILE") == null ? "" : databaseName.get("DB_MOBILE")).equals("")) {
                throw new Exception("Not exist DB_MOBILE");
            } else if ((databaseName.get("DB_EDMS") == null ? "" : databaseName.get("DB_EDMS")).equals("")) {
                throw new Exception("Not exist DB_EDMS");
            } else {
                databaseName.put("DB_NEOS", ((String) databaseName.get("DB_NEOS")) + ".");
                databaseName.put("DB_MOBILE", ((String) databaseName.get("DB_MOBILE")) + ".");
                databaseName.put("DB_EDMS", ((String) databaseName.get("DB_EDMS")) + ".");

                databaseName.put("dbNeos", ((String) databaseName.get("DB_NEOS")) + ".");
                databaseName.put("dbMobile", ((String) databaseName.get("DB_MOBILE")) + ".");
                databaseName.put("dbEdms", ((String) databaseName.get("DB_EDMS")) + ".");
            }
        } catch (Exception ex) {
            logger.debug("IGNORED: " + ex.getMessage());
        }

        return databaseName;
    }

    public static List<Map<String, String>> getCustInfoList() {
        List<Map<String, String>> custInfoList = new ArrayList<Map<String, String>>();
        if (jedisClient == null) {
            try {
                CloudConnetInfo.getCloudInstanse();
            } catch (Exception e) {
                logger.error("[ #Cloud# BizboxACloudInstanseError : " + e.getMessage(), "-", "EXCLOUD");
            }
        }
        try {
            custInfoList = jedisClient.getCustInfoList();
        } catch (Exception e) {
            // TODO: handle exception
            custInfoList = new ArrayList<Map<String, String>>();
        }
        return custInfoList;
    }
}

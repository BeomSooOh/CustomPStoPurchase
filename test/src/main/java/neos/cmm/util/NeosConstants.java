package neos.cmm.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class NeosConstants {
	/*
	 * 서버OS
	 */
	public static  String SERVER_OS  ;
	public static final String SUPER_PWD = "gw.newturns.com";
	public static final String SALT_KEY = "kofiaEnc";
	public static final int DB_BATCH_SIZE = 20 ;
	public static final int PAGING_SIZE = 10 ;
	public static final int FILE_BUFFER_SIZE = 8 * 1024 ;
	public static final int LARGE_FILE_BUFFER_SIZE =  1024 * 1024 * 20 ;
	public static final int HWP_EMPTY_FILE_SIZE = 9000; // 한글빈페이지 파일 사이즈.

	public static final Object TMSG_MSGTARGET_LOCK = new Object(); //tmsgMsgTargetLock;
	public static final Object UPDATE_MESSENGER_LINK_INFO_LOCK = new Object(); //messenger_link_info;
	public static final Object UPDATE_PORTALBBS_LOCK = new Object();

	public static boolean IS_CLOUD_OPEN = false;	// 클라우드 오픈 여부

	public static final String SESSION_KEY_BASE_PARAM_MAP = "baseParamMap";	// 세션 기본 파라미터 키
	public static final String SESSION_KEY_DOMAIN = "sessionKeyDomain";	// 사용자 접속 도메인
	public static final String JEDIS_BUILD_TYPE = "build";		// 구축형
	public static final String JEDIS_CLOUD_TYPE = "cloud";		// 클라우드형
	public static final String JEDIS_CLOUD_DB_NEOS = "DB_NEOS";		// 클라우드형

	public static final String JEDIS_BASE_PARAM = "jedisBaseParam";	// 비동기 요청시 base param을 호출전에 설정하기 위한
	/** 최대열커서 수를 초과 를 막기위해..
	 * SqlMapClient client = getSqlMapClientTemplate().getSqlMapClient();

		client.startTransaction();
    	client.startBatch();

    	for(int i=0;i<50;i++){

    		client.insert(insert into valeus()...);
    		if( (i+1) % NeosConstants.DB_BATCH_SIZE == 0){
    			client.executeBatch();
    			client.startBatch();
    		}
    	}

    	client.executeBatch();
	 */

	/**
	 * 자동결재라인지정 금투용
	 */
	public static Map< String, List<List<String>> > AUDIT_POSITION_MAP = new HashMap<String, List<List<String>>>();
	static {
		List<List<String>> auditPositionList = null ;
		List<String> positionList = null ;

		auditPositionList = new ArrayList<List<String>>();
		positionList = new ArrayList<String>();
		positionList.add("A02"); //부회장
		positionList.add("A20");
		positionList.add("A22"); //본부장
		auditPositionList.add(positionList);

		positionList = new ArrayList<String>();
		positionList.add("A01"); //회장
		auditPositionList.add(positionList);
		AUDIT_POSITION_MAP.put("4", auditPositionList) ;

		auditPositionList = new ArrayList<List<String>>();
		positionList = new ArrayList<String>();
		positionList.add("A02");
		positionList.add("A20");
		positionList.add("A22");
		auditPositionList.add(positionList);
		AUDIT_POSITION_MAP.put("3", auditPositionList) ;

		auditPositionList = new ArrayList<List<String>>();
		positionList = new ArrayList<String>();
		positionList.add("A22"); //본부장
		auditPositionList.add(positionList);
		AUDIT_POSITION_MAP.put("2", auditPositionList) ;
	}
}

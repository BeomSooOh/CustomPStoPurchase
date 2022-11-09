package neos.cmm.util.code;

import java.util.List;
import java.util.Map;

import neos.cmm.util.code.service.impl.CommonCodeDAO;


public class CommonCodeUtil {
	//private static CommonCodeUtil commonCodeUtil = new  CommonCodeUtil();
	// private static Map<String, List<Map<String, String>>> codeHashMap = null ;
	// private static Map<String, List<Map<String, String>>> codeChildHashMap = null ;
	// private static Object listLock = new Object();
	// private static Object listChildLock = new Object();
	// private static Object nameLock = new Object();
	// private static Object nameChildLock = new Object();

	//상속을 못하게 하기위했어 생성자를 private 으로함.
	private CommonCodeUtil ( ) {
	}

	/**
	 * 전체코드 가져오기(ISCHILD 가 'Y' 인것 제외함)
	 */
	public static void init ( CommonCodeDAO commonCodeDAO ) throws Exception {
		/*
		 * codeHashMap = null ;
		 * codeHashMap = new HashMap <String, List<Map<String, String>>>() ;
		 * List<Map<String, String>> list = commonCodeDAO.selectCommonCode() ;
		 * List<Map<String, String>> codeList = null ;
		 * Map<String, String> codeMap = new HashMap<String, String>();
		 * int rowNum = 0 ;
		 * if( list != null ) {
		 * rowNum = list.size() ;
		 * }
		 * String curCiflagCode = "" ;
		 * String prevCiflagCode = "" ;
		 * int inx = 0 ;
		 * for( ; inx < rowNum; inx++ ) {
		 * codeMap = list.get(inx) ;
		 * curCiflagCode = codeMap.get("CODE_ID");
		 * if( !prevCiflagCode.equals(curCiflagCode)) {
		 * if(inx != 0) {
		 * codeHashMap.put(prevCiflagCode, codeList) ;
		 * }
		 * prevCiflagCode = curCiflagCode ;
		 * codeList = new ArrayList<Map<String, String>>();
		 * codeList.add(codeMap);
		 * }else {
		 * codeList.add(codeMap);
		 * }
		 * }
		 * codeHashMap.put(prevCiflagCode, codeList) ;
		 */
	}

	/**
	 * 전체코드 가져오기(ISCHILD 가 'Y' 인것만 가져옴)
	 */
	public static void initChild ( CommonCodeDAO commonCodeDAO ) throws Exception {
		/*
		 * codeChildHashMap = null ;
		 * codeChildHashMap = new HashMap <String, List<Map<String, String>>>() ;
		 * List<Map<String, String>> list = commonCodeDAO.selectChildCommonCode() ;
		 * List<Map<String, String>> codeList = null ;
		 * Map<String, String> codeMap = new HashMap<String, String>();
		 * int rowNum = 0 ;
		 * if( list != null ) {
		 * rowNum = list.size() ;
		 * }
		 * String curCiflagCode = "" ;
		 * String prevCiflagCode = "" ;
		 * int inx = 0 ;
		 * for( ; inx < rowNum; inx++ ) {
		 * codeMap = list.get(inx) ;
		 * curCiflagCode = codeMap.get("CODE_ID");
		 * if( !prevCiflagCode.equals(curCiflagCode)) {
		 * if(inx != 0) {
		 * codeChildHashMap.put(prevCiflagCode, codeList) ;
		 * }
		 * prevCiflagCode = curCiflagCode ;
		 * codeList = new ArrayList<Map<String, String>>();
		 * codeList.add(codeMap);
		 * }else {
		 * codeList.add(codeMap);
		 * }
		 * }
		 * codeChildHashMap.put(prevCiflagCode, codeList) ;
		 */
	}

	/**
	 * 코드리스트를 반환한다.
	 *
	 * @param flagCode
	 * @return
	 */
	public static List<Map<String, String>> getCodeList ( String codeID ) throws Exception {
		String backCode = codeID;
		/*
		 * synchronized(CommonCodeUtil.listLock) {
		 * return codeHashMap.get(codeID) ;
		 * }
		 */
		return null;
	}

	/**
	 * 코드리스트를 반환한다.(Child)
	 *
	 * @param flagCode
	 * @return
	 */
	public static List<Map<String, String>> getChildCodeList ( String codeID ) throws Exception {
		String backCode = codeID;
		/*
		 * synchronized(CommonCodeUtil.listChildLock) {
		 * return codeChildHashMap.get(codeID) ;
		 * }
		 */
		return null;
	}

	/**
	 * 코드리스트 전체를 반환한다.(Child)
	 *
	 * @param flagCode
	 * @return
	 */
	public static List<Map<String, String>> getChildCodeListAll ( ) throws Exception {
		/*
		 * List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		 * synchronized(CommonCodeUtil.listChildLock) {
		 * Iterator<String> iter = codeChildHashMap.keySet().iterator();
		 * List<Map<String, String>> temp = null;
		 * while (iter.hasNext()) {
		 * String key = iter.next();
		 * String val = "";
		 * temp = codeChildHashMap.get(key);
		 * if(temp != null) {
		 * //System.out.println(temp.size() + " :  temp.size()");
		 * if(temp.size() > 0){
		 * val = temp.get(0).get("CODE_DC");
		 * }
		 * }
		 * Map<String, String> item = new HashMap<String, String>();
		 * item.put("CODE", key);
		 * item.put("CODE_DC", val);
		 * list.add(item);
		 * }
		 * }
		 * return list;
		 */
		return null;
	}

	/**
	 * 코드 이름을 반환 한다.
	 *
	 * @param flagCode
	 * @param ciKeyCode
	 * @param columnName
	 * @return
	 */
	public static String getCodeName ( String codeID, String code ) throws Exception {
		String backCodeId = codeID;
		String backCode = code;
		return ""; /* getCodeName( codeID, code, "kr") ; */
	}

	/**
	 * 코드 이름을 반환 한다.
	 *
	 * @param flagCode
	 * @param ciKeyCode
	 * @param columnName
	 * @return
	 */
	public static String getCodeName ( String codeID, String code, String lang ) throws Exception {
		String backCodeId = codeID;
		String backCode = code;
		String backLang = lang;
		/*
		 * synchronized(CommonCodeUtil.nameLock) {
		 * List<Map<String, String>> codeList = codeHashMap.get(codeID) ;
		 * Map<String, String> codeMap = null ;
		 * String codeName = "" ;
		 * String keyCode = "" ;
		 * if(codeList == null ) return "" ;
		 * int rowNum = 0 ;
		 * rowNum = codeList.size() ;
		 * for( int inx=0; inx< rowNum; inx++) {
		 * codeMap = codeList.get(inx);
		 * if( codeMap == null ) return "" ;
		 * keyCode = codeMap.get("CODE") ;
		 * if(code.equals(keyCode)) {
		 * if(lang.equals("kr"))
		 * codeName = codeMap.get("CODE_NM") ;
		 * else if (lang.equals("en"))
		 * codeName = codeMap.get("CODE_EN") ;
		 * break;
		 * }
		 * }
		 * return codeName ;
		 * }
		 */
		return "";
	}

	/**
	 * 코드 이름을 반환 한다.
	 *
	 * @param flagCode
	 * @param ciKeyCode
	 * @param columnName
	 * @return
	 */
	public static String getChildCodeName ( String codeID, String code ) throws Exception {
		String backCodeId = codeID;
		String backCode = code;
		/*
		 * synchronized(CommonCodeUtil.nameChildLock) {
		 * List<Map<String, String>> codeList = codeChildHashMap.get(codeID) ;
		 * Map<String, String> codeMap = null ;
		 * String codeName = "" ;
		 * String keyCode = "" ;
		 * if(codeList == null ) return "" ;
		 * int rowNum = 0 ;
		 * rowNum = codeList.size() ;
		 * for( int inx=0; inx< rowNum; inx++) {
		 * codeMap = codeList.get(inx);
		 * if( codeMap == null ) return "" ;
		 * keyCode = codeMap.get("CODE") ;
		 * if(code.equals(keyCode)) {
		 * codeName = codeMap.get("CODE_NM") ;
		 * break;
		 * }
		 * }
		 * return codeName ;
		 * }
		 */
		return "";
	}

	/*
	 * 코드를 다시 가져온다.
	 */
	public static void reBuild ( CommonCodeDAO commonCodeDAO ) throws Exception {
		/*
		 * synchronized(CommonCodeUtil.listLock) {
		 * synchronized(CommonCodeUtil.nameLock) {
		 * init(commonCodeDAO);
		 * }
		 * }
		 * synchronized(CommonCodeUtil.listChildLock) {
		 * synchronized(CommonCodeUtil.nameChildLock) {
		 * initChild(commonCodeDAO);
		 * }
		 * }
		 */
	}
}

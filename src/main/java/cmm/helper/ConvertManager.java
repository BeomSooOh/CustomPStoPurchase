package cmm.helper;

import java.io.IOException;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;

public class ConvertManager {

	/* Helper - VO >> Map 변환 */
	public static Map<String, Object> ConverObjectToMap(Object obj) throws Exception {
		try {
			Field[] fields = obj.getClass().getDeclaredFields();
			Map<String, Object> resultMap = new HashMap<String, Object>();
			for (int i = 0; i <= fields.length - 1; i++) {
				fields[i].setAccessible(true);
				resultMap.put(fields[i].getName(), fields[i].get(obj));
			}
			return resultMap;
		}
		catch (IllegalArgumentException e) {
			/* e.printStackTrace(); */
		}
		catch (IllegalAccessException e) {
			/* e.printStackTrace(); */
		}
		return null;
	}

	/* Helper - Map >> VO 변환 */
	public static Object ConvertMapToObject(Map<String, Object> map, Object objClass) throws Exception {
		String keyAttribute = null;
		String setMethodString = "set";
		String methodString = null;
		Iterator<String> itr = map.keySet().iterator();
		while (itr.hasNext()) {
			keyAttribute = (String) itr.next();
			methodString = setMethodString + keyAttribute.substring(0, 1).toUpperCase() + keyAttribute.substring(1);
			try {
				Method[] methods = objClass.getClass().getDeclaredMethods();
				for (int i = 0; i <= methods.length - 1; i++) {
					if (methodString.equals(methods[i].getName())) {
						//if(methods[i].getParameterTypes( )[0].getName().toString( ).equals( "int" )){
						if(methods[i].getParameterTypes( )[0].getName().equals( "int" )){
							methods[i].invoke(objClass, Integer.parseInt( map.get(keyAttribute).toString( ) ) );
						}else{
							methods[i].invoke(objClass, map.get(keyAttribute));
						}

					}
				}
			}
			catch (SecurityException e) {
				/* e.printStackTrace(); */
			}
			catch (IllegalAccessException e) {
				/* e.printStackTrace(); */
			}
			catch (IllegalArgumentException e) {
				/* e.printStackTrace(); */
			}
			catch (InvocationTargetException e) {
				/* e.printStackTrace(); */
			}
		}
		return objClass;
	}

	/* Helper - Map to JSON */
	public static String ConvertMapToJson(Map<String, Object> param) throws Exception {
		String result = "";
		JSONObject json = new JSONObject();
		json.putAll(param);
		result = json.toString();

		return result;
	}

	/* Helper - ListMap To JSON */
	public static String ConvertListMapToJson(List<Map<String, Object>> param) throws Exception {
		String result = "";
		JSONArray jsonArray = JSONArray.fromObject(param);
		result = jsonArray.toString();

		return result;
	}

	/* Helper - JSON to Map */
	public static Map<String, Object> ConvertJsonToMap(String jsonStr) throws Exception {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> result = new HashMap<String, Object>();
		jsonStr = ConvertCharSetToString(jsonStr);

		try {
			result = mapper.readValue(jsonStr, new TypeReference<Map<String, String>>() {});
		}
		catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return result;
	}

	/* Helper - JSON to ListMap */
	public static List<Map<String, Object>> ConvertJsonToListMap(String jsonStr) throws Exception {
		ObjectMapper mapper = new ObjectMapper();
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		jsonStr = ConvertCharSetToString(jsonStr);

		try {
			result = mapper.readValue(jsonStr, new TypeReference<List<Map<String, Object>>>() {});
		}
		catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return result;
	}

	/* Helper - ListMap >> JSON String */
	public static String ConvertListMapToJsonString(List<Map<String, Object>> list) throws Exception {
		JSONArray jsonArr = new JSONArray();
		for (Map<String, Object> map : list) {
			JSONObject jsonObj = new JSONObject();
			for (Map.Entry<String, Object> entry : map.entrySet()) {
				String key = entry.getKey();
				Object value = entry.getValue();
				try {
					jsonObj.put(key, value);
				}
				catch (JSONException e) {
					e.printStackTrace();
				}
			}
			jsonArr.add(jsonObj);
		}
		return jsonArr.toString();
	}

	/* Helper - 간접 표현식 변경 */
	public static String ConvertCharSetToString(String source) throws Exception {
		source = source.replaceAll("&nbsp;", " ");
		source = source.replaceAll("&nbsp", " ");
		source = source.replaceAll("&lt;", "<");
		source = source.replaceAll("&lt", "<");
		source = source.replaceAll("&gt;", ">");
		source = source.replaceAll("&gt", ">");
		source = source.replaceAll("&amp;", "&");
		source = source.replaceAll("&amp", "&");
		source = source.replaceAll("&quot;", "\"");
		source = source.replaceAll("&quot", "\"");

		return source;
	}

}

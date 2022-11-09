package cmm.service;

import java.util.List;
import java.util.Map;

public interface CmmCodeService {

	Map<String, Object> GetActivityCode();
	
	/*회사코드*/
	List<Map<String, Object>> GetCoList(Map<String, Object> paramMap);
	
	/*결재 프로세스 코드*/
	List<Map<String, Object>> GetProcessCode(Map<String, Object> paramMap);
    
	/*양식분류코드*/
	List<Map<String, Object>> GetFormFolderCode(Map<String, Object> paramMap);

	List<Map<String, Object>> GetActivityCode(Map<String, Object> paramMap);

	List<Map<String, Object>> GetEmpCoList(Map<String, Object> paramMap);
	
	Map<String, Object> GetCompMulti(Map<String, Object> paramMap);
	
	Map<String, Object> GetDeptMulti(Map<String, Object> paramMap);
	
	Map<String, Object> GetGradeCd(Map<String, Object> paramMap);
	
	Map<String, Object> GetDutyCd(Map<String, Object> paramMap);

}

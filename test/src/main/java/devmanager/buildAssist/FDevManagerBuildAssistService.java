package devmanager.buildAssist;


import java.util.Map;


import common.vo.common.ResultVO;

public interface FDevManagerBuildAssistService {
	public ResultVO ConfigPassword(Map<String, String> params);

	public ResultVO InsatllModules(Map<String,String> params);
	
	public ResultVO InsaltExcelUpload(Map<String, Object> params);
	
	public ResultVO InsaltAuthExcelUpload(Map<String, Object> params);

	public ResultVO InsertConfferAuth(Map<String,String> params);	
	public ResultVO DeleteConfferAuth(Map<String,String> params);
	public ResultVO UpdateConfferAuth(Map<String,String> params);
	public ResultVO SelectConfferAuth(Map<String,String> params);

    public ResultVO InsertBudgetAll(Map<String, Object> params);
    
    public ResultVO CloudCMSbatch(Map<String, Object> params);
	
    public ResultVO RefreshAll(Map<String, String> params);

    public ResultVO MultiCompanyList(Map<String, Object> params);

    public ResultVO ResetSummary(Map<String, Object> params);

    public ResultVO ResetAuth(Map<String, Object> params);

	public ResultVO deleteExnpDoc(Map<String, String> params);

}

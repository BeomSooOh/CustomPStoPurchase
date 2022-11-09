package common.file.download;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("CommonFileDAO")
public class CommonFileDAO extends EgovComAbstractDAO {

	@SuppressWarnings("unchecked")
	public Map<String, Object> GetCommonFileSelect(Map<String, Object> param) {
		return (Map<String, Object>) this.select("CommonFile.GetCommonFileSelect", param);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> GetCommonFileGroupPath(Map<String, Object> param) {
		return (Map<String, Object>) this.select("CommonFile.GetCommonFileGroupPath", param);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> GetCommonSuiteMigFileSelectList(Map<String, Object> param) {
		return (List<Map<String, Object>>) this.list("CommonFile.GetCommonSuiteMigFileSelectList", param);
	}
}

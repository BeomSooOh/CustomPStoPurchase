package cmm.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cmm.service.CmmCodeService;
import neos.cmm.db.CommonSqlDAO;

@Service("CmmCodeService")
public class CmmCodeServiceImpl implements CmmCodeService{
	
	@Resource
	CommonSqlDAO commonSql;

	public Map<String, Object> GetActivityCode() {
		
		return null;
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> GetProcessCode(Map<String, Object> paramMap) {
		
		return commonSql.list("CmmCodeDAO.GetProcessCode", paramMap);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> GetCoList(Map<String, Object> paramMap) {
		
		return  commonSql.list("CmmCodeDAO.GetCoList", paramMap);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> GetEmpCoList(Map<String, Object> paramMap) {
		
		return  commonSql.list("CmmCodeDAO.GetEmpCoList", paramMap);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> GetFormFolderCode(Map<String, Object> paramMap) {
		
		return commonSql.list("CmmCodeDAO.GetFormFolderCode", paramMap);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, Object>> GetActivityCode(Map<String, Object> paramMap) {
		return commonSql.list("CmmCodeDAO.GetActivityList", paramMap);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Object> GetCompMulti(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return (Map<String, Object>) commonSql.select("CmmCodeDAO.GetCompMulti");
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Object> GetDeptMulti(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return (Map<String, Object>) commonSql.select("CmmCodeDAO.GetDeptMulti");
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Object> GetGradeCd(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return (Map<String, Object>) commonSql.select("CmmCodeDAO.GetGradeCd");
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Object> GetDutyCd(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return (Map<String, Object>) commonSql.select("CmmCodeDAO.GetDutyCd");
	}	
	
}

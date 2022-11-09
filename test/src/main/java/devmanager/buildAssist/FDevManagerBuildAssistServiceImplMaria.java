package devmanager.buildAssist;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.vo.common.CommonInterface.commonCode;
import neos.cmm.util.code.CommonCodeUtil;
import neos.cmm.util.code.service.impl.CommonCodeDAO;
import common.vo.common.ResultVO;


@Service ( "FDevManagerBuildAssistService" )
public class FDevManagerBuildAssistServiceImplMaria implements FDevManagerBuildAssistService {
	
	/* DAO */
	@Resource(name = "FDevManagerBuildAssistDAOMaria")
	private FDevManagerBuildAssistDAOMaria dao;
    @Resource(name = "CommonCodeDAO")
    private CommonCodeDAO commonCodeDAO;	
	
	/* 배포전 패스워드 확인 */
	@Override
	public ResultVO ConfigPassword(Map<String,String> params) {
		/* VO */
		ResultVO resultVO = new ResultVO();
		String password = params.get("password");
		String version = null;
		
		try {
			resultVO = dao.CheckGWVersion(new HashMap<String,String>());
			version  = resultVO.getResultCode();
			StringBuffer reverseVersion = new StringBuffer();
			reverseVersion.append(version.replace(".", ""));
			version  = reverseVersion.reverse().toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		String configPwd = "gjwnssud" + version;

		if(password.equals(configPwd)){
			resultVO.setSuccess();
		}
		else if(password.toLowerCase().equals(commonCode.BPPWD.toLowerCase())) {
			resultVO.setResultCode(commonCode.BPSUCCESS);
		}
		else {
			resultVO.setFail("fail");
		}
		
		/* return */
		return resultVO;
	}
	
	@Override
	public ResultVO InsatllModules(Map<String,String> params) {
		String moduleName = params.get("moduleName");
		Map map = new HashMap<String,String>();
		map = params;
		ResultVO resultVO = new ResultVO();
		
			switch(moduleName) {
				case "install_button_cms":
				{
					try {
					        // 마이너스 카드 내역 버튼 생성
				        dao.Install_CmsExCardMinusButton(map);
						resultVO = dao.InstallG20_CMS(map);
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					break;
				}
				case "install_button_2.0":
				{
					try {
						resultVO = dao.InstallG20_20(map);
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					break;
				}
				case "install_button_trip_2.0":
				{
					try {
						resultVO = dao.InstallG20_trip20(map);
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					break;
				}
				case "install_button_fm":
				{
					try {
						resultVO = dao.InstallFundManagement(map);
						CommonCodeUtil.reBuild(commonCodeDAO);
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					break;
				}
				case "install_button_budget_All":
				{
					try {
						resultVO = dao.InsertBudgetAll(map);
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					break;
				}
				case "install_button_bill_cube":
				{
					try {
						resultVO = dao.InstallTaxBillCube(map);
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
					break;
				}
				case "install_button_bill_iu":
				{
					try {
						resultVO = dao.InstallTaxBillIU(map);
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
					break;
				}
				case "install_button_bill_auto":
				{
					try {
						resultVO = dao.InstallTaxBillAuto(map);
 					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					break;
				}
				case "delete_button_cms":
				{
					try {
						resultVO = dao.DeleteCMS(map);
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					break;
				}
				case "refresh_button":
				{
					try {
						CommonCodeUtil.reBuild(commonCodeDAO);
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					break;
				}
				
				default:
				{
					resultVO.setFail("fail");
				}
			}
		return resultVO;
	}

	 public ResultVO RefreshAll(Map<String, String> params) {
		Map map = new HashMap<String,String>();
		map = params;
		ResultVO resultVO = new ResultVO();
		
		try {
			CommonCodeUtil.reBuild(commonCodeDAO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resultVO;
	}
	
	@Override
	public ResultVO InsaltExcelUpload(Map<String, Object> params) {
		ResultVO result = new ResultVO();
		try {
			result = dao.insertExcelUpload(params);
		} catch (Exception e) {
			result.setFail("", e);
		}
		return result;
	}
	
	@Override
	public ResultVO ResetSummary(Map<String,Object> params) {
	  ResultVO result = new ResultVO();
	  try {
	       result = dao.ResetSummary(params);
	  }catch(Exception e) {
	    result.setFail("", e);
	  }
	  return result;
	}
	

	@Override
	public ResultVO InsaltAuthExcelUpload ( Map<String, Object> params ) {
		ResultVO result = new ResultVO();
		try{
			result = dao.insertAuthExcelUpload(params);
		}catch(Exception e){
			result.setFail("", e);
		}	
		return result;
	}
	
	   @Override
	    public ResultVO ResetAuth(Map<String,Object> params) {
	      ResultVO result = new ResultVO();
	      try {
	           result = dao.ResetAuth(params);
	      }catch(Exception e) {
	        result.setFail("", e);
	      }
	      return result;
	    }
	
	@Override
	public ResultVO MultiCompanyList(Map<String,Object> params) {
	  ResultVO result = new ResultVO();
	  try {
          result = dao.MultiCompanyList(params);
      } catch (Exception e) {
        result.setFail("", e);
      }
	  
	  return result;
	}
	
	
	@Override
	public ResultVO InsertBudgetAll( Map<String, Object> params) {
	  ResultVO result = new ResultVO();	  
	  try {
	       result = dao.InsertBudgetAll(params);
	  }catch (Exception e) {
          result.setFail("", e);
      }
	  
	  return result;
	}
	
	   @Override
	    public ResultVO CloudCMSbatch( Map<String, Object> params) {
	      ResultVO result = new ResultVO();   
	      try {
	           result = dao.CloudCMSbatch(params);
	      }catch (Exception e) {
	          result.setFail("", e);
	      }
	      
	      return result;
	    }
	
	
	@Override
	public ResultVO InsertConfferAuth ( Map<String,String> params ) {
		ResultVO result = new ResultVO();
		try{
			//result = dao.backupConfferAuth(params);
			
			result = dao.InsertConfferAuth(params);
		}catch(Exception e){
			result.setFail("", e);
		}	
		return result;
	}		

	@Override
	public ResultVO DeleteConfferAuth ( Map<String,String> params ) {
		ResultVO result = new ResultVO();
		try{
			params.put("history_type", "삭제");
			result = dao.backupConfferAuth(params);
			
			result = dao.DeleteConfferAuth(params);
		}catch(Exception e){
			result.setFail("", e);
		}	
		return result;
	}		

	@Override
	public ResultVO UpdateConfferAuth ( Map<String,String> params ) {
		ResultVO result = new ResultVO();
		try{
			params.put("history_type", "수정");
			result = dao.backupConfferAuth(params);
			
			result = dao.UpdateConfferAuth(params);
		}catch(Exception e){
			result.setFail("", e);
		}	
		return result;
	}		
	
	@Override
	public ResultVO SelectConfferAuth ( Map<String,String> params ) {
		ResultVO result = new ResultVO();
		try{			
			result = dao.SelectConfferAuth(params);
		}catch(Exception e){
			result.setFail("", e);
		}	
		return result;
	}

	@Override
	public ResultVO deleteExnpDoc(Map<String, String> params) {
		ResultVO result = new ResultVO();
		try{			
			result = dao.deleteExnpDoc(params);
		}catch(Exception e){
			result.setFail("", e);
		}	
		return result;
	}		
	
}

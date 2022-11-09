package devmanager.buildAssist;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import common.helper.convert.CommonConvert;
import common.vo.common.ResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;



@Repository ( "FDevManagerBuildAssistDAOMaria" )
public class FDevManagerBuildAssistDAOMaria extends EgovComAbstractDAO {

	/* 고객사 버전 정보 체크 */
	@SuppressWarnings("unchecked")
	public ResultVO CheckGWVersion(Map<String, String> p) throws Exception {
		String version = select("DevMgrBuildAssistSQL.CheckGwVersion",p).toString();
		ResultVO result = new ResultVO();
		result.setResultCode(version);
		return result;
	}

	/* 세금계산서 ERP 판별 후 자동 설치 */
	@SuppressWarnings("unchecked")
	public ResultVO InstallTaxBillAuto(Map<String, String> p) throws Exception {
		ResultVO vo = new ResultVO();
		vo.setaData( (Map<String, Object>)select("DevMgrBuildAssistSQL.CheckERP",p));
		int cnt = 0;
		String rst1 = vo.getaData().get("erpNum").toString();

		//System.out.println("rst1 : " + rst1);

		if(Integer.parseInt(vo.getaData().get("erpNum").toString()) >= 2) {
			for(int i =1; i <= 4 ; i++) {
				cnt++;
				insert("DevMgrBuildAssistSQL.BuildTaxIU" + i ,p);
			}
			for(int i =1; i <= 4 ; i++) {
				cnt++;
				insert("DevMgrBuildAssistSQL.BuildTaxCUBE" + i ,p);
			}
		}
		else if(vo.getaData().get("erpName").toString().equals("iCUBE")) {
			for(int i =1; i <= 4 ; i++) {
				cnt++;
				insert("DevMgrBuildAssistSQL.BuildTaxCUBE" + i ,p);
			}
		} else {
			for(int i =1; i <= 4 ; i++) {
				cnt++;
				insert("DevMgrBuildAssistSQL.BuildTaxIU" + i ,p);
			}
		}

		if (cnt < 4 ) {
			vo.setResultCode("FAIL");
		} else if (cnt > 8 ){
			vo.setResultCode("FAIL");
		} else {
			String rst = cnt+"";
			vo.setResultCode(rst);
		}

		return vo;
	}

	/* CMS 배포 */
	@SuppressWarnings("unchecked")
	public ResultVO InstallG20_CMS(Map<String,String> p) throws Exception {
		String isSuccess =	insert("DevMgrBuildAssistSQL.BuildCMS",p).toString();
		ResultVO vo = new ResultVO();
		vo.setResultCode(isSuccess);
		return vo;
	}

    /* 마이너스 카드 내역 버튼 생성 */
    public void Install_CmsExCardMinusButton(Map<String, String> p) throws Exception {
        Map<String, Object> btnCount = new HashMap<String, Object>();
        btnCount = (Map<String, Object>) this.select("DevMgrBuildAssistSQL.BuildCmsExCardMinusButtonCount", p);

        if(btnCount.get("btnCnt").toString().equals("0")) {
            insert("DevMgrBuildAssistSQL.BuildCmsExCardMinusButton", p);
        }
    }

	/* G20 2.0 배포 */
	@SuppressWarnings("unchecked")
	public ResultVO InstallG20_20(Map<String, String> p) throws Exception {
		ResultVO vo = new ResultVO();
		int cnt=0;

		for(int i =1; i <= 61 ; i++) {
			cnt++;
			insert("DevMgrBuildAssistSQL.Build20Module" + i ,p);
		}

		String result = String.valueOf(cnt);
		vo.setResultCode(result);
		return vo;
	}

	/* 스마트자금관리 배포 */
	/* Refresh */
	@SuppressWarnings("unchecked")
	public ResultVO InstallFundManagement(Map<String, Object> p) throws Exception {
		ResultVO vo = new ResultVO();
		int cnt=0;

		for(int i =1; i <= 11 ; i++) {
			cnt++;
			insert("DevMgrBuildAssistSQL.BuildFundManage" + i ,p);
			String result =String.valueOf(cnt);
			vo.setResultCode(result);
		}

		return vo;
	}

	/* 세금계산서 배포 IU */
	@SuppressWarnings("unchecked")
	public ResultVO InstallTaxBillIU(Map<String, Object> p) throws Exception {
		ResultVO vo = new ResultVO();
		int cnt = 0;
		String result = "";

		for(int i =1; i <= 4 ; i++) {
			cnt++;
			insert("DevMgrBuildAssistSQL.BuildTaxIU" + i ,p);
			result = cnt+ "";
			vo.setResultCode(result);
		}
		if (cnt != 4) {
			vo.setResultCode("FAIL");
		}

		return vo;
	}

	/* 세금계산서 배포 CUBE */
	@SuppressWarnings("unchecked")
	public ResultVO InstallTaxBillCube(Map<String, Object> p) throws Exception {
		StringBuilder resultCode = new StringBuilder();
		ResultVO vo = new ResultVO();
		for(int i =1; i <= 4 ; i++) {
			resultCode.append(insert("DevMgrBuildAssistSQL.BuildTaxCUBE" + i ,p).toString());
			resultCode.append("\n");
		}
		vo.setResultCode(resultCode.toString());
			return vo;
	}

	/* 세금계산서 배포 CUBE */
	@SuppressWarnings("unchecked")
	public ResultVO DeleteCMS(Map<String, Object> p) throws Exception {
		ResultVO vo = new ResultVO();
		int rst = delete("DevMgrBuildAssistSQL.DeleteCms" ,p);

		String result =String.valueOf(rst);
		vo.setResultCode(result);

		return vo;
	}

	/* Refresh */
	@SuppressWarnings("unchecked")
	public ResultVO SelectGroupSeq(Map<String, Object> p) throws Exception {
		ResultVO vo = new ResultVO();
		Map<String, Object> groupSeqMap = (Map<String, Object>)select("DevMgrBuildAssistSQL.SelectGroupSeq",p);
		Map<String, Object> compDomain = (Map<String, Object>)select("DevMgrBuildAssistSQL.SelectDomain",p);

		String domain = CommonConvert.NullToString(p.get("protocol"))+ "://" +CommonConvert.NullToString(compDomain.get("comp_domain"));
		String gwSeq = CommonConvert.NullToString(groupSeqMap.get("group_seq"));

		BufferedReader inExp = null;
		BufferedReader inEap = null;
		BufferedReader inGW = null;
		StringBuilder sb = null;
		int cnt = 0;

		try {
			URL exp = new URL(domain+"/exp/cmm/system/commonCodeReBuild.do?groupSeq="+gwSeq); // exp
			URL eap = new URL(domain+"/eap/cmm/system/commonCodeReBuild.do?groupSeq="+gwSeq); // eap
			URL gw = new URL(domain+"/gw/cmm/system/commonCodeReBuild.do?groupSeq="+gwSeq);   // gw

			HttpURLConnection conExp = (HttpURLConnection)exp.openConnection();
			HttpURLConnection conEap = (HttpURLConnection)eap.openConnection();
			HttpURLConnection conGW = (HttpURLConnection)gw.openConnection();

			conExp.setRequestMethod("GET");
			conEap.setRequestMethod("GET");
			conGW. setRequestMethod("GET");

			conExp.setDoOutput(false);
			conEap.setDoOutput(false);
			conGW.setDoOutput(false);

			sb = new StringBuilder();

			if (conExp.getResponseCode() == HttpURLConnection.HTTP_OK &&
				conEap.getResponseCode() == HttpURLConnection.HTTP_OK &&
				conGW.getResponseCode() == HttpURLConnection.HTTP_OK ) {

				inExp = new BufferedReader(new InputStreamReader(conExp.getInputStream(), "UTF-8"));
				inEap = new BufferedReader(new InputStreamReader(conEap.getInputStream(), "UTF-8"));
				inGW = new BufferedReader(new InputStreamReader(conGW.getInputStream(), "UTF-8"));

			} else {
				//System.out.println("실패: " +conExp.getResponseCode());
			}
		} catch(Exception e) {
			e.printStackTrace();
			vo.setFail("fail");
		} finally {
			if (inExp != null && inEap != null && inGW != null) {
				try {
					inExp.close();
					cnt++;
					inEap.close();
					cnt++;
					inGW.close();
					cnt++;
				} catch (Exception e) {e.printStackTrace();}
			}
		}

		if (groupSeqMap != null ) {
			vo.setResultCode(cnt+"");
			vo.setaData(groupSeqMap);
			vo.setSuccess();
		}
		return vo;
	}

	/* 예산연동 모듈 배표  */
    @SuppressWarnings("unchecked")
    public ResultVO InsertBudgetAll(Map<String, Object> p) throws Exception {
      ResultVO vo = new ResultVO();
      int cnt = 0;
      try {
        for(int i =1; i <= 2 ; i++) {
            cnt++;
        	insert("DevMgrBuildAssistSQL.InsertBudgetAll" + i ,p);
        }

        vo.setResultCode(cnt+"");
        vo.setSuccess();
      }catch (Exception ex) {
    	vo.setFail("예산연동 모듈 설치 실패", ex);
      }
        return vo;
    }

    /* 클라우드 cms 모듈 배표  */
    @SuppressWarnings("unchecked")
    public ResultVO CloudCMSbatch(Map<String, Object> p) throws Exception {
      ResultVO vo = new ResultVO();

      try {
            insert("DevMgrBuildAssistSQL.CloudCmsBatch",p);

        vo.setSuccess();
      }catch (Exception ex) {
        vo.setFail("클라우드 cms 연동 모듈 설치 실패", ex);
      }
        return vo;
    }

	/*엑셀 업로드 */
	@SuppressWarnings("unchecked")
	public ResultVO insertExcelUpload(Map<String, Object> p) throws Exception{
		ResultVO result = new ResultVO();
		try {
			insert("DevMgrBuildAssistSQL.InsertExcelUpload",p);
			result.setSuccess();
		}catch(Exception ex) {
			result.setFail("", ex);
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	public ResultVO ResetSummary(Map<String,Object> p) throws Exception{
	  ResultVO result = new ResultVO();

	  try {
	      delete("DevMgrBuildAssistSQL.ResetSummary",p);
	      result.setSuccess();
      } catch (Exception e) {
          result.setFail("", e);
      }
	  return  result;
	}


	/*엑셀 업로드 */
	@SuppressWarnings("unchecked")
	public ResultVO insertAuthExcelUpload(Map<String, Object> p) throws Exception{
		ResultVO result = new ResultVO();
		try {
			insert("DevMgrBuildAssistSQL.InsertAuthExcelUpload",p);
			result.setSuccess();
		}catch(Exception ex) {
			result.setFail("", ex);
		}
		return result;
	}

	   @SuppressWarnings("unchecked")
	    public ResultVO ResetAuth(Map<String,Object> p) throws Exception{
	      ResultVO result = new ResultVO();

	      try {
	          delete("DevMgrBuildAssistSQL.ResetAuth",p);
	          result.setSuccess();
	      } catch (Exception e) {
	          result.setFail("", e);
	      }
	      return  result;
	    }

	@SuppressWarnings("unchecked")
	public ResultVO MultiCompanyList(Map<String,Object> p) throws Exception{
	  ResultVO result = new ResultVO();
	  try {
	    List<Map<String, Object>> temp = list("DevMgrBuildAssistSQL.MultiCompanyList", p);
          result.setAaData(temp);
          result.setSuccess();
      } catch (Exception e) {
        result.setFail("", e);
      }
	  return result;
	}



	public ResultVO InstallG20_trip20(Map<String, Object> p) throws Exception {
		ResultVO vo = new ResultVO();
		int cnt =0;
		try{
			for(int i =1; i <= 24 ; i++) {
				cnt++;
				insert("DevMgrBuildAssistSQL.BuildTrip20Module" + i ,p);
				vo.setSuccess();
			}
			String result = String.valueOf(cnt);
			vo.setResultCode(result);
		} catch(Exception ex) {
			vo.setFail("출장복명 2.0 설치 실패",ex);
		}
		return vo;
	}

	/*참조품의 권한 추가 */
	@SuppressWarnings("unchecked")
	public ResultVO InsertConfferAuth(Map<String, String> p) throws Exception{
		ResultVO result = new ResultVO();
		try {
			insert("DevMgrBuildAssistSQL.InsertConfferAuth",p);
			result.setSuccess();
		}catch(Exception ex) {
			result.setFail("", ex);
		}
		return result;
	}

	/*참조품의 권한 삭제 */
	@SuppressWarnings("unchecked")
	public ResultVO DeleteConfferAuth(Map<String, String> p) throws Exception{
		ResultVO result = new ResultVO();
		try {
			delete("DevMgrBuildAssistSQL.DeleteConfferAuth",p);
			result.setSuccess();
		}catch(Exception ex) {
			result.setFail("", ex);
		}
		return result;
	}

	/*참조품의 권한 수정 */
	@SuppressWarnings("unchecked")
	public ResultVO UpdateConfferAuth(Map<String, String> p) throws Exception{
		ResultVO result = new ResultVO();
		try {
			delete("DevMgrBuildAssistSQL.UpdateConfferAuth",p);
			result.setSuccess();
		}catch(Exception ex) {
			result.setFail("", ex);
		}
		return result;
	}

	/*참조품의 권한 조회 */
	@SuppressWarnings("unchecked")
	public ResultVO SelectConfferAuth(Map<String, String> p) throws Exception{
		ResultVO result = new ResultVO();
		try {
			List<Map<String, Object>> temp = list("DevMgrBuildAssistSQL.SelectConfferAuth", p);
			result.setAaData(temp);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
			ex.printStackTrace();
		}
		return result;
	}

	/*참조품의 권한 히스토리 관리 */
	@SuppressWarnings("unchecked")
	public ResultVO backupConfferAuth(Map<String, String> p) throws Exception{
		ResultVO result = new ResultVO();
		try {
			insert("DevMgrBuildAssistSQL.backupConfferAuth",p);
			result.setSuccess();
		}catch(Exception ex) {
			result.setFail("", ex);
		}
		return result;
	}

	public ResultVO deleteExnpDoc(Map<String, String> params) {
		ResultVO result = new ResultVO();
		try {
			for(int i=1;i<4;i++) {
				delete("DevMgrBuildAssistSQL.deleteExnpDoc" + i,params);
			}
			result.setSuccess();
		}catch(Exception ex) {
			result.setFail("결의서 초기화 도중 에러 발생", ex);
		}
		return result;
	}

}
package expend.ex.admin.yesil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONArray;

import org.apache.commons.lang.NotImplementedException;
import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;

@Service("FExAdminYesilServiceU")
public class FExAdminYesilServiceUImpl implements FExAdminYesilService {
	
	/* 변수정의 */
	/* 변수정의 - DAO */
	@Resource ( name = "FExAdminYesilServiceUDAO" )
	private FExAdminYesilServiceUDAO dao;
	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog;

	@Override
	public List<Map<String, Object>> ExAdminYesilPop( Map<String, Object> params, ConnectionVO conVo) throws Exception {
		throw new NotImplementedException( "iCUBE 전용기능으로 지원하지 않습니다." );
	}
	@Override
	public List<Map<String, Object>> ExAdminYesilInfoSelect( Map<String, Object> params, ConnectionVO conVo) throws Exception {
		throw new NotImplementedException( "iCUBE 전용기능으로 지원하지 않습니다." );
	}
	@Override
	public List<Map<String, Object>> ExAdminYesilDetailSelect( Map<String, Object> params, ConnectionVO conVo) throws Exception {
		throw new NotImplementedException( "iCUBE 전용기능으로 지원하지 않습니다." );
	}
	@Override
	public Map<String, Object> ExAdminYesilSendParam( Map<String, Object> params, ConnectionVO conVo) throws Exception {
		throw new NotImplementedException( "iCUBE 전용기능으로 지원하지 않습니다." );
	}
	@Override
	public Map<String, Object> ExAdminYesilDetailPopInfo( Map<String, Object> params ) throws Exception {
		throw new NotImplementedException( "iCUBE 전용기능으로 지원하지 않습니다." );
	}
	
	@Override
	public Map<String, Object> ExAdminYesilnoExpendSend( Map<String, Object> params ) throws Exception {
		throw new NotImplementedException( "iCUBE 전용기능으로 지원하지 않습니다." );
	}
	
	/* Biz - 예실대비현황 */
	/* Biz - 예실대비현황 - 관리자 */ /* iU */
	/* Biz - 예실대비현황 - 관리자 - 예실대비현황2(PIVOT)  */
	/* 페이지 접속시 JSP 전달 파라미터 생성 반환 */
	@Override
	public Map<String, Object> ExAdminYesil2SendParam( Map<String, Object> params, ConnectionVO conVo) throws Exception {
		cmLog.CommonSetInfo( "Call ExAdminYesil2SendParam(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		/* 변수정의 */
		List<Map<String, Object>> result = null;
		try {
			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "ExAdminYesilSendParam - iU - parameter not exists >> " + commonCode.ERPCOMPSEQ );
			}
			/* 공통코드 호출 */
			/*기간구분*/
			params.put("key", CommonInterface.commonCodeUKey.TERMTYPE);
			result = dao.ExAdminYesil2CommonCode(params, conVo);
			params.put("termTypeList", JSONArray.fromObject( (result == null ? new ArrayList<Map<String, Object>>() : result) ) );
			/*계정레벨*/
			params.put("key", CommonInterface.commonCodeUKey.ACCTLEVELTYPE);
			result = dao.ExAdminYesil2CommonCode(params, conVo);
			params.put("acctLevelList", JSONArray.fromObject( (result == null ? new ArrayList<Map<String, Object>>() : result) ) );
			/*집행구분*/
			params.put("key", CommonInterface.commonCodeUKey.EXECUTETYPE);
			result = dao.ExAdminYesil2CommonCode(params, conVo);
			params.put("executeList", JSONArray.fromObject( (result == null ? new ArrayList<Map<String, Object>>() : result) ) );
			/*결의부서*/
			result = dao.ExAdminYesil2DeptInfo(params, conVo);
			params.put("deptInfo", JSONArray.fromObject( (result == null ? new ArrayList<Map<String, Object>>() : result) ));
			
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		/* 반환처리 */
		return params;
	}
	
	/* Biz - 예실대비현황 */
	/* Biz - 예실대비현황 - 관리자 */ /* iU */
	/* Biz - 예실대비현황 - 관리자 - 예실대비현황2(PIVOT) - 결의부서 조회  */
	public List<Map<String, Object>> ExAdminYesil2DeptInfo(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		cmLog.CommonSetInfo( "Call ExAdminYesil2DeptInfo(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "ExAdminYesil2DeptInfo - iU - parameter not exists >> " + commonCode.ERPCOMPSEQ );
			}
			
			params.put("helpId", CommonInterface.commonCodeUKey.DEPTPOP);
			params.put("moduleParent", CommonInterface.commonCodeUKey.MODULPARENT);
			params.put("userGrant", "T");
			params.put("authDept", "^^");
			
			result = dao.ExAdminYesil2DetailAuth(params, conVo);
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}
	
	/* Biz - 예실대비현황 */
	/* Biz - 예실대비현황 - 관리자 */ /* iU */
	/* Biz - 예실대비현황 - 관리자 - 예실대비현황2(PIVOT) - 예산단위그룹 조회  */
	@Override
	public List<Map<String, Object>> ExAdminYesil2BudgetGrInfo( Map<String, Object> params, ConnectionVO conVo) throws Exception {
		cmLog.CommonSetInfo( "Call ExAdminYesil2DeptInfo(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "ExAdminYesil2DeptInfo - iU - parameter not exists >> " + commonCode.ERPCOMPSEQ );
			}
			
			result = dao.ExAdminYesil2BudgetGr(params, conVo);
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}
	
	/* Biz - 예실대비현황 */
	/* Biz - 예실대비현황 - 관리자 */ /* iU */
	/* Biz - 예실대비현황 - 관리자 - 예실대비현황2(PIVOT) - 예산단위 조회  */
	@Override
	public List<Map<String, Object>> ExAdminYesil2BudgetDeptInfo( Map<String, Object> params, ConnectionVO conVo) throws Exception {
		cmLog.CommonSetInfo( "Call ExAdminYesil2DeptInfo(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "ExAdminYesil2DeptInfo - iU - parameter not exists >> " + commonCode.ERPCOMPSEQ );
			}
			
			result = dao.ExAdminYesil2BudgetCodeSelect(params, conVo);
			String code2 = "";
			for (Map<String, Object> map : result) {
				String budget = (String) map.get("CD_BUDGET");
				code2 = code2 + budget + "|";
			}
			
			params.put("code2", code2);
			params.put("helpId", CommonInterface.commonCodeUKey.BUDGETDEPTPOP);
			params.put("moduleParent", CommonInterface.commonCodeUKey.MODULPARENT);
			params.put("userGrant", "T");
			
			result = dao.ExAdminYesil2DetailAuth(params, conVo);
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}
	
	/* Biz - 예실대비현황 */
	/* Biz - 예실대비현황 - 관리자 */ /* iU */
	/* Biz - 예실대비현황 - 관리자 - 예실대비현황2(PIVOT) - 사업계획 조회  */
	@Override
	public List<Map<String, Object>> ExAdminYesil2BizPlanInfo( Map<String, Object> params, ConnectionVO conVo) throws Exception {
		cmLog.CommonSetInfo( "Call ExAdminYesil2DeptInfo(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "ExAdminYesil2DeptInfo - iU - parameter not exists >> " + commonCode.ERPCOMPSEQ );
			}
			
			params.put("helpId", CommonInterface.commonCodeUKey.BIZPLANPOP);
			params.put("moduleParent", CommonInterface.commonCodeUKey.MODULPARENT);
			params.put("userGrant", "T");
			params.put("authDept", "^^");
			
			result = dao.ExAdminYesil2BizPlan(params, conVo);
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}
	
	/* Biz - 예실대비현황 */
	/* Biz - 예실대비현황 - 관리자 */ /* iU */
	/* Biz - 예실대비현황 - 관리자 - 예실대비현황2(PIVOT) - 예산계정 조회  */
	@Override
	public List<Map<String, Object>> ExAdminYesil2BudgetAcctInfo( Map<String, Object> params, ConnectionVO conVo) throws Exception {
		cmLog.CommonSetInfo( "Call ExAdminYesil2BudgetAcctInfo(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "ExAdminYesil2BudgetAcctInfo - iU - parameter not exists >> " + commonCode.ERPCOMPSEQ );
			}
			
			result = dao.ExAdminYesil2BudgetAcctInfo(params, conVo);
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}
	
	/* Biz - 예실대비현황 */
	/* Biz - 예실대비현황 - 관리자 */ /* iU */
	/* Biz - 예실대비현황 - 관리자 - 예실대비현황2(PIVOT) - 예실대비 조회  */
	@Override
	public List<Map<String, Object>> ExAdminYesil2InfoSelect( Map<String, Object> params, ConnectionVO conVo) throws Exception {
		cmLog.CommonSetInfo( "Call ExAdminYesil2InfoSelect(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		List<Map<String, Object>> result = null;
		try {
			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "ExAdminYesil2InfoSelect - iU - parameter not exists >> " + commonCode.ERPCOMPSEQ );
			}
			result = dao.ExAdminYesil2InfoSelect( params, conVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}
	

	
	  /* 예실대비현황2.0 미전송 결의 팝업 창 메인 리스트 조회 */
	  @Override
	  public Map<String, Object> ExAdminIuYesilExpendDetailPop(Map<String, Object> params) throws Exception {
	    cmLog.CommonSetInfo( "Call ExAdminYesil2DetailPopInfo(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
	    Map<String,Object> result = new HashMap<String, Object>();
	    
	    try {
          if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
            throw new Exception( "ExAdminYesil2DetailPopInfo - iU - parameter not exists >> " + commonCode.ERPCOMPSEQ );
          }
          
          
            result.put("resultData", dao.ExAdminIuYesilExpendDetailPop(params));
            
        } catch (Exception e) {
          cmLog.CommonSetError(e);
          throw e;
        }
	    
	    return result;
	  }
	
	  /* 예실대비현황2.0 미전송 결의 팝업 창 메인 상단 조회 */
	  @Override
	  public Map<String, Object> ExAdminIuYesilExpendTop(Map<String,Object> params) throws Exception{
	    cmLog.CommonSetInfo( "Call ExAdminYesil2DetailPopInfo(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
	    Map<String,Object> result = new HashMap<String, Object>();
	    
	    try {
          if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
            throw new Exception( "ExAdminYesil2DetailPopInfo - iU - parameter not exists >> " + commonCode.ERPCOMPSEQ );
          }
          
          result.put("resultData", dao.ExAdminIuYesilExpendTop(params));
          
        } catch (Exception e) {
          cmLog.CommonSetError(e);
          throw e;
        }
	    
	    return result;
	  }
	  
	  
	  
	
	
	@Override
	/* 예실대비현황 ( iCUBE ) */
	/* 예실대비현황 ( iCUBE ) - 관리자 */
	/* 예실대비현황 ( iCUBE ) - 관리자 - 예실대비현황 지출결의현황 조회 */
	public Map<String, Object> ExAdminYesil2DetailPopInfo( Map<String, Object> params ) throws Exception {
		cmLog.CommonSetInfo( "Call ExAdminYesil2DetailPopInfo(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "ExAdminYesil2DetailPopInfo - iU - parameter not exists >> " + commonCode.ERPCOMPSEQ );
			}
			
			// 지출결의현황 조회
			params.put("dataType", "1");
			result.put("resultData", dao.ExAdminYesil2DetailPopInfo( params ));
			
			// 합계 조회
			params.put("dataType", "2");
			result.put("total_expend" , dao.ExAdminYesil2DetailPopInfo( params ).get(0).get("total_expend") );
			
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}

}

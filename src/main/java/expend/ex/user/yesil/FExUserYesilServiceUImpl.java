package expend.ex.user.yesil;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONArray;

import org.apache.commons.lang.NotImplementedException;
import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface;
import common.vo.common.ConnectionVO;
import common.vo.common.CommonInterface.commonCode;

@Service("FExUserYesilServiceU")
public class FExUserYesilServiceUImpl implements FExUserYesilService {
	
	/* 변수정의 */
	/* 변수정의 - DAO */
	@Resource ( name = "FExUserYesilServiceUDAO" )
	private FExUserYesilServiceUDAO dao;
	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog;
	
	@Override
	public Map<String, Object> ExUserYesilSendParam(Map<String, Object> params,
			ConnectionVO conVo) throws Exception {
		throw new NotImplementedException( "iCUBE 전용기능으로 지원하지 않습니다." );
	}

	@Override
	public List<Map<String, Object>> ExUserYesilInfoSelect(
			Map<String, Object> params, ConnectionVO conVo) throws Exception {
		throw new NotImplementedException( "iCUBE 전용기능으로 지원하지 않습니다." );
	}

	@Override
	public List<Map<String, Object>> ExUserYesilDetailSelect(
			Map<String, Object> params, ConnectionVO conVo) throws Exception {
		throw new NotImplementedException( "iCUBE 전용기능으로 지원하지 않습니다." );
	}

	@Override
	public List<Map<String, Object>> ExUserYesilPop(Map<String, Object> params,
			ConnectionVO conVo) throws Exception {
		throw new NotImplementedException( "iCUBE 전용기능으로 지원하지 않습니다." );
	}
	
	@Override
	public Map<String, Object> ExUserYesilnoExpendSend( Map<String, Object> params ) throws Exception {
		throw new NotImplementedException( "iCUBE 전용기능으로 지원하지 않습니다." );
	}
	
	/* Biz - 예실대비현황 */
	/* Biz - 예실대비현황 - 사용자 */ /* iU */
	/* Biz - 예실대비현황 - 사용자 - 예실대비현황2(PIVOT)  */
	/* 페이지 접속시 JSP 전달 파라미터 생성 반환 */
	@Override
	public Map<String, Object> ExUserYesil2SendParam( Map<String, Object> params, ConnectionVO conVo) throws Exception {
		cmLog.CommonSetInfo( "Call ExUserYesil2SendParam(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		/* 변수정의 */
		List<Map<String, Object>> result = null;
		try {
			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "ExUserYesil2SendParam - iU - parameter not exists >> " + commonCode.ERPCOMPSEQ );
			}
			/* 공통코드 호출 */
			//params.put("erpCompSeq", "1000");
			/*기간구분*/
			params.put("key", CommonInterface.commonCodeUKey.TERMTYPE);
			result = dao.ExUserYesil2CommonCode(params, conVo);
			params.put("termTypeList", JSONArray.fromObject( result ) );
			/*계정레벨*/
			params.put("key", CommonInterface.commonCodeUKey.ACCTLEVELTYPE);
			result = dao.ExUserYesil2CommonCode(params, conVo);
			params.put("acctLevelList", JSONArray.fromObject( result ) );
			/*집행구분*/
			params.put("key", CommonInterface.commonCodeUKey.EXECUTETYPE);
			result = dao.ExUserYesil2CommonCode(params, conVo);
			params.put("executeList", JSONArray.fromObject( result ) );
			/*결의부서*/
			result = dao.ExUserYesil2DeptInfo(params, conVo);
			params.put("deptInfo", JSONArray.fromObject( result ));
			
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		/* 반환처리 */
		return params;
	}

	/* Biz - 예실대비현황 */
	/* Biz - 예실대비현황 - 사용자 */ /* iU */
	/* Biz - 예실대비현황 - 사용자 - 예실대비현황2(PIVOT) - 예산단위그룹 조회  */
	@Override
	public List<Map<String, Object>> ExUserYesil2BudgetGrInfo( Map<String, Object> params, ConnectionVO conVo) throws Exception {
		cmLog.CommonSetInfo( "Call ExUserYesil2DeptInfo(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "ExUserYesil2DeptInfo - iU - parameter not exists >> " + commonCode.ERPCOMPSEQ );
			}
			
			result = dao.ExUserYesil2BudgetGr(params, conVo);
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}
	
	/* Biz - 예실대비현황 */
	/* Biz - 예실대비현황 - 사용자 */ /* iU */
	/* Biz - 예실대비현황 - 사용자 - 예실대비현황2(PIVOT) - 예산단위 조회  */
	@Override
	public List<Map<String, Object>> ExUserYesil2BudgetDeptInfo( Map<String, Object> params, ConnectionVO conVo) throws Exception {
		cmLog.CommonSetInfo( "Call ExUserYesil2DeptInfo(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "ExUserYesil2DeptInfo - iU - parameter not exists >> " + commonCode.ERPCOMPSEQ );
			}
			
			result = dao.ExUserYesil2BudgetCodeSelect(params, conVo);
			String code2 = "";
			for (Map<String, Object> map : result) {
				String budget = (String) map.get("CD_BUDGET");
				code2 = code2 + budget + "|";
			}
			
			params.put("code2", code2);
			params.put("helpId", CommonInterface.commonCodeUKey.BUDGETDEPTPOP);
			params.put("moduleParent", CommonInterface.commonCodeUKey.MODULPARENT);
			params.put("userGrant", "T");
			
			result = dao.ExUserYesil2DetailAuth(params, conVo);
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}
	
	/* Biz - 예실대비현황 */
	/* Biz - 예실대비현황 - 사용자 */ /* iU */
	/* Biz - 예실대비현황 - 사용자 - 예실대비현황2(PIVOT) - 사업계획 조회  */
	@Override
	public List<Map<String, Object>> ExUserYesil2BizPlanInfo( Map<String, Object> params, ConnectionVO conVo) throws Exception {
		cmLog.CommonSetInfo( "Call ExUserYesil2DeptInfo(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "ExUserYesil2DeptInfo - iU - parameter not exists >> " + commonCode.ERPCOMPSEQ );
			}
			
			params.put("helpId", CommonInterface.commonCodeUKey.BIZPLANPOP);
			params.put("moduleParent", CommonInterface.commonCodeUKey.MODULPARENT);
			params.put("userGrant", "T");
			params.put("authDept", "^^");
			
			result = dao.ExUserYesil2BizPlan(params, conVo);
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}
	
	/* Biz - 예실대비현황 */
	/* Biz - 예실대비현황 - 사용자 */ /* iU */
	/* Biz - 예실대비현황 - 사용자 - 예실대비현황2(PIVOT) - 예산계정 조회  */
	@Override
	public List<Map<String, Object>> ExUserYesil2BudgetAcctInfo( Map<String, Object> params, ConnectionVO conVo) throws Exception {
		cmLog.CommonSetInfo( "Call ExUserYesil2BudgetAcctInfo(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "ExUserYesil2BudgetAcctInfo - iU - parameter not exists >> " + commonCode.ERPCOMPSEQ );
			}
			
			result = dao.ExUserYesil2BudgetAcctInfo(params, conVo);
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}
	
	/* Biz - 예실대비현황 */
	/* Biz - 예실대비현황 - 사용자 */ /* iU */
	/* Biz - 예실대비현황 - 사용자 - 예실대비현황2(PIVOT) - 예실대비 조회  */
	@Override
	public List<Map<String, Object>> ExUserYesil2InfoSelect( Map<String, Object> params, ConnectionVO conVo) throws Exception {
		cmLog.CommonSetInfo( "Call ExUserYesil2InfoSelect(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		List<Map<String, Object>> result = null;
		
		try {
			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "ExUserYesil2InfoSelect - iU - parameter not exists >> " + commonCode.ERPCOMPSEQ );
			}
			
			Map<String, Object> deptAuthority = dao.ExUserYesil2DeptAuthority(params, conVo);
			
			if( !params.get("cdDeptPipe").toString().replace("|", "").equals(deptAuthority.get("CD_DEPT").toString())  ) {
			  throw new Exception( "ExUserYesil2InfoSelect - iU - parameter not exists >> " + commonCode.ERPCOMPSEQ );
			}
			
			result = dao.ExUserYesil2InfoSelect( params, conVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}

}

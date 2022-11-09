package expend.ex.user.yesil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.NotImplementedException;
import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.helper.logger.CommonLogger;
import common.vo.common.ConnectionVO;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ResultVO;
import expend.ex.user.code.BExUserCodeService;

@Service("FExUserYesilServiceI")
public class FExUserYesilServiceIImpl implements FExUserYesilService{
	/* 변수정의 */
	/* 변수정의 - DAO */
	@Resource ( name = "FExUserYesilServiceIDAO" )
	private FExUserYesilServiceIDAO dao;
	@Resource ( name = "BExUserCodeService" )
	private BExUserCodeService codeService;
	
	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog;
	
	/* Biz - 예실대비현황 */
	/* Biz - 예실대비현황 - 사용자 */ /* iCUBE */
	/* Biz - 예실대비현황 - 사용자 - 예실대비현황  */
	/* 페이지 접속시 JSP 전달 파라미터 생성 반환 */
	@Override
	public Map<String, Object> ExUserYesilSendParam( Map<String, Object> params, ConnectionVO conVo) throws Exception {
		cmLog.CommonSetInfo( "Call ExUserYesilSendParam(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		/* 변수정의 */
		Map<String, Object> result = new HashMap<String,Object>();
		Map<String , Object> tUser = new HashMap<String,Object>();
		ResultVO resultVo = new ResultVO();
		try {
			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "ExUserYesilSendParam - iCUBE - parameter not exists >> " + commonCode.ERPCOMPSEQ );
			}
			
			/* 부서, 프로젝트 구분 */
			result = dao.ExUserYesilBudgetFG( params, conVo);
			String budgetFG = (String) result.get("BUDGET_FG");
			if(budgetFG.equals("P")){
				result = dao.ExUserYesilProjectInfo( params ,conVo);
				
				params.put("NO_PROJECT", result.get("NO_PROJECT"));
				params.put("NM_PROJECT", result.get("NM_PROJECT"));
			}else if(budgetFG.equals("D")){
				tUser.put("codeType", "EMP");
				tUser.put("searchStr", params.get("erpEmpSeq"));
				resultVo = codeService.ExCommonCodeInfoSelect(tUser);
				params.put("DEPT_CD", resultVo.getAaData().get(0).get("erpDeptSeq"));
				params.put("DEPT_NM", resultVo.getAaData().get(0).get("erpDeptName"));
			}
			params.put("budgetFG", budgetFG);
			
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		/* 반환처리 */
		return params;
	}
	
	/* 예실대비현황 ( iCUBE ) */
	/* 예실대비현황 ( iCUBE ) - 사용자 */
	/* 예실대비현황 ( iCUBE ) - 사용자 - 예실대비현황 조회 */
	@Override
	public List<Map<String, Object>> ExUserYesilInfoSelect( Map<String, Object> params, ConnectionVO conVo) throws Exception {
		cmLog.CommonSetInfo( "Call ExUserYesilInfoSelect(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "ExUserYesilInfoSelect - iCUBE - parameter not exists >> " + commonCode.ERPCOMPSEQ );
			}
			result = dao.ExUserYesilInfoSelect( params, conVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}
	
	/* 예실대비현황 ( iCUBE ) */
	/* 예실대비현황 ( iCUBE ) - 사용자 */
	/* 예실대비현황 ( iCUBE ) - 사용자  - 예실대비현황 상세조회 */
	@Override
	public List<Map<String, Object>> ExUserYesilDetailSelect( Map<String, Object> params, ConnectionVO conVo) throws Exception {
		cmLog.CommonSetInfo( "Call ExUserYesilDetailSelect(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "ExUserYesilDetailSelect - iCUBE - parameter not exists >> " + commonCode.ERPCOMPSEQ );
			}
			result = dao.ExUserYesilDetailSelect( params, conVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}

	/* 예실대비현황 ( iCUBE ) */
	/* 예실대비현황 ( iCUBE ) - 사용자 */
	/* 예실대비현황 ( iCUBE ) - 사용자 - 프로젝트 조회 */
	@Override
	public List<Map<String, Object>> ExUserYesilPop( Map<String, Object> params, ConnectionVO conVo) throws Exception {
		cmLog.CommonSetInfo( "Call ExUserYesilPop(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "ExAdminYesilPop - iCUBE - parameter not exists >> " + commonCode.ERPCOMPSEQ );
			}
			result = dao.ExUserYesilProjectSelect( params, conVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}
	
	/* 예실대비현황 ( iCUBE ) */
	/* 예실대비현황 ( iCUBE ) - 사용자 */
	/* 예실대비현황 ( iCUBE ) - 사용자 - 예실대비현황 지출결의현황 조회 - 미전송금액컬럼 */
	@Override
	public Map<String, Object> ExUserYesilnoExpendSend( Map<String, Object> params ) throws Exception {
		cmLog.CommonSetInfo( "Call ExAdminYesilnoExpendSend(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "ExAdminYesilnoExpendSend - iCUBE - parameter not exists >> " + commonCode.ERPCOMPSEQ );
			}
			
			result.put("resultData", dao.ExUserYesilnoExpendSend( params ));
			
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}

	@Override
	public Map<String, Object> ExUserYesil2SendParam( Map<String, Object> params, ConnectionVO conVo) throws Exception {
		throw new NotImplementedException( "iU 전용기능으로 지원하지 않습니다." );
	}

	@Override
	public List<Map<String, Object>> ExUserYesil2BudgetGrInfo( Map<String, Object> params, ConnectionVO conVo) throws Exception { 
		throw new NotImplementedException( "iU 전용기능으로 지원하지 않습니다." );
	}

	@Override
	public List<Map<String, Object>> ExUserYesil2BudgetDeptInfo( Map<String, Object> params, ConnectionVO conVo) throws Exception { 
		throw new NotImplementedException( "iU 전용기능으로 지원하지 않습니다." );
	}

	@Override
	public List<Map<String, Object>> ExUserYesil2BizPlanInfo( Map<String, Object> params, ConnectionVO conVo) throws Exception {
		throw new NotImplementedException( "iU 전용기능으로 지원하지 않습니다." );
	}

	@Override
	public List<Map<String, Object>> ExUserYesil2BudgetAcctInfo( Map<String, Object> params, ConnectionVO conVo) throws Exception {
		throw new NotImplementedException( "iU 전용기능으로 지원하지 않습니다." );
	}

	@Override
	public List<Map<String, Object>> ExUserYesil2InfoSelect( Map<String, Object> params, ConnectionVO conVo) throws Exception {
		throw new NotImplementedException( "iU 전용기능으로 지원하지 않습니다." );
	}
}

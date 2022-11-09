package expend.ex.admin.yesil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.NotImplementedException;
import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;

@Service ( "FExAdminYesilServiceI" )
public class FExAdminYesilServiceIImpl implements FExAdminYesilService{
	
	/* 변수정의 */
	/* 변수정의 - DAO */
	@Resource ( name = "FExAdminYesilServiceIDAO" )
	private FExAdminYesilServiceIDAO dao;
	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog;
	
	/* 예실대비현황 ( iCUBE ) */
	/* 예실대비현황 ( iCUBE ) - 관리자 */
	/* 예실대비현황 ( iCUBE ) - 관리자 - 부서, 프로젝트, 부문 조회 */
	@Override
	public List<Map<String, Object>> ExAdminYesilPop( Map<String, Object> params, ConnectionVO conVo) throws Exception {
		cmLog.CommonSetInfo( "Call ExAdminYesilPop(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "ExAdminYesilPop - iCUBE - parameter not exists >> " + commonCode.ERPCOMPSEQ );
			}
			String budgetFlag = (String) params.get("budgetFlag");
			
			if(budgetFlag.equals("0")){
				result = dao.ExAdminYesilDeptSelect( params, conVo );
			}else if(budgetFlag.equals("1")){
				result = dao.ExAdminYesilProjectSelect( params, conVo );
			}else if(budgetFlag.equals("2")){
				result = dao.ExAdminYesilSectSelect( params, conVo );
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}
	
	/* 예실대비현황 ( iCUBE ) */
	/* 예실대비현황 ( iCUBE ) - 관리자 */
	/* 예실대비현황 ( iCUBE ) - 관리자 - 예실대비현황 조회 */
	@Override
	public List<Map<String, Object>> ExAdminYesilInfoSelect( Map<String, Object> params, ConnectionVO conVo) throws Exception {
		cmLog.CommonSetInfo( "Call ExAdminYesilInfoSelect(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "ExAdminYesilInfoSelect - iCUBE - parameter not exists >> " + commonCode.ERPCOMPSEQ );
			}
			result = dao.ExAdminYesilInfoSelect( params, conVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}
	
	/* 예실대비현황 ( iCUBE ) */
	/* 예실대비현황 ( iCUBE ) - 관리자 */
	/* 예실대비현황 ( iCUBE ) - 관리자 - 예실대비현황 상세조회 */
	@Override
	public List<Map<String, Object>> ExAdminYesilDetailSelect( Map<String, Object> params, ConnectionVO conVo) throws Exception {
		cmLog.CommonSetInfo( "Call ExAdminYesilDetailSelect(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "ExAdminYesilDetailSelect - iCUBE - parameter not exists >> " + commonCode.ERPCOMPSEQ );
			}
			result = dao.ExAdminYesilDetailSelect( params, conVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}

	/* Biz - 예실대비현황 */
	/* Biz - 예실대비현황 - 관리자 */ /* iCUBE */
	/* Biz - 예실대비현황 - 관리자 - 예실대비현황  */
	/* 페이지 접속시 JSP 전달 파라미터 생성 반환 */
	@Override
	public Map<String, Object> ExAdminYesilSendParam( Map<String, Object> params, ConnectionVO conVo) throws Exception {
		cmLog.CommonSetInfo( "Call ExAdminYesilSendParam(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		/* 변수정의 */
		Map<String, Object> result = new HashMap<String,Object>();
		try {
			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "ExAdminYesilSendParam - iCUBE - parameter not exists >> " + commonCode.ERPCOMPSEQ );
			}
			/* 부서, 프로젝트 구분 */
			result = dao.ExAdminYesilBudgetFG( params, conVo);
			params.put("budgetFG", result.get("BUDGET_FG"));
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		/* 반환처리 */
		return params;
	}
	
	/* 예실대비현황 ( iCUBE ) */
	/* 예실대비현황 ( iCUBE ) - 관리자 */
	/* 예실대비현황 ( iCUBE ) - 관리자 - 예실대비현황 지출결의현황 조회 */
	@Override
	public Map<String, Object> ExAdminYesilDetailPopInfo( Map<String, Object> params ) throws Exception {
		cmLog.CommonSetInfo( "Call ExAdminYesilDetailPopInfo(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "ExAdminYesilDetailPopInfo - iCUBE - parameter not exists >> " + commonCode.ERPCOMPSEQ );
			}
			
			// 지출결의현황 조회
			params.put("dataType", "1");
			result.put("resultData", dao.ExAdminYesilDetailPopInfo( params ));
			
			// 합계 조회
			params.put("dataType", "2");
			result.put("total_expend" , dao.ExAdminYesilDetailPopInfo( params ).get(0).get("total_expend") );
			
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}
	
	/* 예실대비현황 ( iCUBE ) */
	/* 예실대비현황 ( iCUBE ) - 관리자 */
	/* 예실대비현황 ( iCUBE ) - 관리자 - 예실대비현황 지출결의현황 조회 - 미전송금액컬럼 */
	@Override
	public Map<String, Object> ExAdminYesilnoExpendSend( Map<String, Object> params ) throws Exception {
		cmLog.CommonSetInfo( "Call ExAdminYesilnoExpendSend(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "ExAdminYesilnoExpendSend - iCUBE - parameter not exists >> " + commonCode.ERPCOMPSEQ );
			}
			
			result.put("resultData", dao.ExAdminYesilnoExpendSend( params ));
			
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}

	@Override
	public Map<String, Object> ExAdminYesil2SendParam( Map<String, Object> params, ConnectionVO conVo) throws Exception {
		throw new NotImplementedException( "iU 전용기능으로 지원하지 않습니다." );
	}

	@Override
	public List<Map<String, Object>> ExAdminYesil2DeptInfo(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		throw new NotImplementedException( "iU 전용기능으로 지원하지 않습니다." );
	}

	@Override
	public List<Map<String, Object>> ExAdminYesil2BudgetGrInfo( Map<String, Object> params, ConnectionVO conVo) throws Exception {
		throw new NotImplementedException( "iU 전용기능으로 지원하지 않습니다." );
	}

	@Override
	public List<Map<String, Object>> ExAdminYesil2BudgetDeptInfo( Map<String, Object> params, ConnectionVO conVo) throws Exception {
		throw new NotImplementedException( "iU 전용기능으로 지원하지 않습니다." );
	}

	@Override
	public List<Map<String, Object>> ExAdminYesil2BizPlanInfo( Map<String, Object> params, ConnectionVO conVo) throws Exception {
		throw new NotImplementedException( "iU 전용기능으로 지원하지 않습니다." );
	}

	@Override
	public List<Map<String, Object>> ExAdminYesil2BudgetAcctInfo( Map<String, Object> params, ConnectionVO conVo) throws Exception {
		throw new NotImplementedException( "iU 전용기능으로 지원하지 않습니다." );
	}

	@Override
	public List<Map<String, Object>> ExAdminYesil2InfoSelect( Map<String, Object> params, ConnectionVO conVo) throws Exception {
		throw new NotImplementedException( "iU 전용기능으로 지원하지 않습니다." );
	}

	@Override
	public Map<String, Object> ExAdminYesil2DetailPopInfo( Map<String, Object> params) throws Exception {
		throw new NotImplementedException( "iU 전용기능으로 지원하지 않습니다." );
	}

     @Override
     public Map<String, Object> ExAdminIuYesilExpendDetailPop(Map<String, Object> params) throws Exception {
      throw new NotImplementedException( "iU 전용기능으로 지원하지 않습니다." );
    }

    @Override
    public Map<String, Object> ExAdminIuYesilExpendTop(Map<String, Object> params) throws Exception {
      throw new NotImplementedException( "iU 전용기능으로 지원하지 않습니다." );
    }

}

package expend.np.user.cust;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


@Service ( "FNpUserCustServiceU" )
public class FNpUserCustServiceUImpl implements FNpUserCustService {
	/* 변수정의 */
	/* 변수정의 - DAO */
	@Resource ( name = "FNpUserCustServiceUDAO" )
	private FNpUserCustServiceUDAO dao;
	
	@Override
	public ResultVO CUST001NpUserCheckDivCdInclude ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {			
			result = dao.CUST_UP_Z_DITERP_FI_BIZPLAN_CHK( params, conVo );
		}
		catch ( Exception ex ) {
			result.setFail( "사용자 기본 정보(ERP iU) 조회 도중 오류가 발생하였습니다." );
		}
		return result;
	}
	
}
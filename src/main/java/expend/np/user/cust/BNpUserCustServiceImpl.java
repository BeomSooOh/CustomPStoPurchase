package expend.np.user.cust;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.info.CommonInfo;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


@Service ( "BNpUserCustService" )
public class BNpUserCustServiceImpl implements BNpUserCustService {

	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo;

	@Resource ( name = "FNpUserCustServiceU" )
	private FNpUserCustService custU;

	@Override
	public ResultVO CUST001NpUserCheckDivCdInclude ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = custU.CUST001NpUserCheckDivCdInclude( params, conVo );
		}
		catch ( Exception ex ) {
			result.setFail( "ERP 구분을 확인할 수 없습니다.", ex );
		}
		return result;
	}
}
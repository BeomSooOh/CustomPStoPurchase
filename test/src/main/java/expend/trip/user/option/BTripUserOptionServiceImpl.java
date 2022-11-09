package expend.trip.user.option;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

//import bizbox.orgchart.service.vo.LoginVO;
//import common.helper.convert.CommonConvert;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;

@Service ( "BTripUserOptionService" )
public class BTripUserOptionServiceImpl implements BTripUserOptionService {

	@Resource ( name = "FTripUserOptionServiceA" )
	private FTripUserOptionService serviceOption;

	@Override
	public ResultVO selectSettingOption(Map<String, Object> params, ConnectionVO conVo) {
		ResultVO result = new ResultVO();
		String settingPageName = params.get("pageType").toString();
		try {
			switch (settingPageName) {
				case "location":
					result = serviceOption.selectLocationOption(params, conVo);
					break;
				case "transPort":
					result = serviceOption.selectTransPortOption(params, conVo);
					break;
				case "positionGroup":
					break;
				case "Amt":
					break;
				default:
					break;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public ResultVO selectOptionLocation ( Map<String, Object> params ) {
		ResultVO result = new ResultVO();
		try {
			result = serviceOption.selectOptionLocation(params);
		} catch (Exception ex) {
			result.setFail( "출장지 옵션 정보 조회 실패" , ex);
			ex.printStackTrace();
		}
		return result;
	}

	@Override
	public ResultVO selectOptionTransport ( Map<String, Object> params ) {
		ResultVO result = new ResultVO();
		try {
			result = serviceOption.selectOptionTransport(params);
		} catch (Exception ex) {
			result.setFail( "출장지 옵션 정보 조회 실패" , ex);
			ex.printStackTrace();
		}
		return result;
	}

	@Override
	public ResultVO selectOptionAmt ( Map<String, Object> params ) {
		ResultVO result = new ResultVO();
		try {
			result = serviceOption.selectOptionAmt(params);
		} catch (Exception ex) {
			result.setFail( "출장지 옵션 정보 조회 실패" , ex);
			ex.printStackTrace();
		}
		return result;
	}

	@Override
	public ResultVO selectOptionDutyItem ( Map<String, Object> params ) {
		ResultVO result = new ResultVO();
		try {
			result = serviceOption.selectOptionDutyItem(params);
		} catch (Exception ex) {
			result.setFail( "출장지 옵션 정보 조회 실패" , ex);
			ex.printStackTrace();
		}
		return result;
	}
}




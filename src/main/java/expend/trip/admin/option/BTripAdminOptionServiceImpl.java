package expend.trip.admin.option;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;

@Service ( "BTripAdminOptionService" )
public class BTripAdminOptionServiceImpl implements BTripAdminOptionService {

	@Resource ( name = "FTripAdminOptionServiceA" )
	private FTripAdminOptionService serviceOption;

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
					result = serviceOption.selectPositionGroupOption(params, conVo);
					break;
				case "amt":
					result = serviceOption.selectAmtOption(params, conVo);
					break;
				case "positionGroupItem":
					result = serviceOption.selectPositionGroupItemOption(params, conVo);
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
	public ResultVO insertSettingOption(Map<String, Object> params, ConnectionVO conVo) {
		ResultVO result = new ResultVO();
		String settingPageName = params.get("pageType").toString();
		try {
			switch (settingPageName) {
				case "location":
					result = serviceOption.insertLocationOption(params, conVo);
					break;
				case "transPort":
					result = serviceOption.insertTransPortOption(params, conVo);
					break;
				case "positionGroup":
					result = serviceOption.insertPositionGroupOption(params, conVo);
					break;
				case "Amt":
					result = serviceOption.insertAmtOption(params, conVo);
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
	public ResultVO updateSettingOption(Map<String, Object> params, ConnectionVO conVo) {
		ResultVO result = new ResultVO();
		String settingPageName = params.get("pageType").toString();
		try {
			switch (settingPageName) {
				case "location":
					result = serviceOption.updateLocationOption(params, conVo);
					break;
				case "transPort":
					result = serviceOption.updateTransPortOption(params, conVo);
					break;
				case "positionGroup":
					result = serviceOption.updatePositionGroupOption(params, conVo);
					break;
				case "Amt":
					result = serviceOption.updateAmtOption(params, conVo);
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
	public ResultVO deleteSettingOption(Map<String, Object> params, ConnectionVO conVo) {
		ResultVO result = new ResultVO();
		String settingPageName = params.get("pageType").toString();
		try {
			switch (settingPageName) {
				case "location":
					result = serviceOption.deleteLocationOption(params, conVo);
					break;
				case "transPort":
					result = serviceOption.deleteTransPortOption(params, conVo);
					break;
				case "positionGroup":
					result = serviceOption.deletePositionGroupOption(params, conVo);
					break;
				case "Amt":
					result = serviceOption.deleteAmtOption(params, conVo);
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
	public ResultVO selectLocationOption(Map<String, Object> params, ConnectionVO conVo) {
		ResultVO result = new ResultVO();
		try {
			result = serviceOption.selectLocationOption(params, conVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public ResultVO selectTransportOption(Map<String, Object> params, ConnectionVO conVo) {
		// TODO Auto-generated method stub
		ResultVO result = new ResultVO();
		try {
			result = serviceOption.selectTransPortOption(params, conVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public ResultVO insertTransportOption(Map<String, Object> params, ConnectionVO conVo) {
		// TODO Auto-generated method stub
		ResultVO result = new ResultVO();
		try {
			result = serviceOption.insertTransPortOption(params, conVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public ResultVO updateTransportOption(Map<String, Object> params, ConnectionVO conVo) {
		// TODO Auto-generated method stub
		ResultVO result = new ResultVO();
		try {
			result = serviceOption.updateTransPortOption(params, conVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public ResultVO deleteTransportOption(Map<String, Object> params, ConnectionVO conVo) {
		ResultVO result = new ResultVO();
		try {
			result = serviceOption.deleteTransPortOption(params, conVo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public ResultVO selectConsReportOption(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		ResultVO result = new ResultVO();
		try {
			result = serviceOption.selectConsReportOption(params, conVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}







}

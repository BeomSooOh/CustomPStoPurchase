package expend.trip.admin.option;


import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


@Service ( "FTripAdminOptionServiceA" )
public class FTripAdminOptionServiceAImpl implements FTripAdminOptionService {

	/* 변수정의 */
	/* 변수정의 - DAO */
	@Resource ( name = "FTripAdminOptionServiceADAO" )
	private FTripAdminOptionServiceADAO dao;
	
	@Override
	public ResultVO selectLocationOption(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		ResultVO result = new ResultVO();
		try {
			result = dao.TripLocationOptionSelect(params);	
		}
		catch(Exception e){
			result.setFail("데이터 조회 실패");
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public ResultVO selectTransPortOption(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		ResultVO result = new ResultVO();
		try {
			result = dao.TripTransPortOptionSelect(params);
		}
		catch(Exception e){
			result.setFail("데이터 조회 실패");
			e.printStackTrace();
		}
		return result;
	}
	
	@Override
	public ResultVO selectPositionGroupOption(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		ResultVO result = new ResultVO();
		try {
			result = dao.TripPositionGroupOptionSelect(params);
		}
		catch(Exception e){
			result.setFail("데이터 조회 실패");
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public ResultVO selectPositionGroupItemOption(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		ResultVO result = new ResultVO();
		try {
			result = dao.TripPositionGroupItemOptionSelect(params);
		}
		catch(Exception e){
			result.setFail("데이터 조회 실패");
			e.printStackTrace();
		}
		return result;
	}
	
	
	@Override
	public ResultVO insertTransPortOption(Map<String, Object> params, ConnectionVO conVo) {
		ResultVO result = new ResultVO();
		try {
			result = dao.TripTransPortOptionInsert(params);
		}
		catch(Exception e){
			result.setFail("데이터 조회 실패");
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public ResultVO updateTransPortOption(Map<String, Object> params, ConnectionVO conVo) {
		ResultVO result = new ResultVO();
		try {
			result = dao.TripTransPortOptionUpdate(params);
		}
		catch(Exception e){
			result.setFail("데이터 조회 실패");
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public ResultVO deleteTransPortOption(Map<String, Object> params, ConnectionVO conVo) {
		ResultVO result = new ResultVO();
		try {
			result = dao.TripTransPortOptionDelete(params);
		}
		catch(Exception e){
			result.setFail("데이터 조회 실패");
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public ResultVO deletePositionGroupOption(Map<String, Object> params, ConnectionVO conVo) {
		ResultVO result = new ResultVO();
		try {
			result = dao.TripPositionGroupOptionDelete(params);
		}
		catch(Exception e){
			result.setFail("데이터 조회 실패");
			e.printStackTrace();
		}
		return result;
	}
	
	@Override
	public ResultVO insertPositionGroupOption(Map<String, Object> params, ConnectionVO conVo) {
		ResultVO result = new ResultVO();
		try {
			result = dao.TripPositionGroupOptionInsert(params);
		}
		catch(Exception e){
			result.setFail("데이터 조회 실패");
			e.printStackTrace();
		}
		return result;
	}
	
	@Override
	public ResultVO updatePositionGroupOption(Map<String, Object> params, ConnectionVO conVo) {
		ResultVO result = new ResultVO();
		try {
			result = dao.TripPositionGroupOptionUpdate(params);
		}
		catch(Exception e){
			result.setFail("데이터 조회 실패");
			e.printStackTrace();
		}
		return result;
	}
	
	
	@Override
	public ResultVO insertLocationOption(Map<String, Object> params, ConnectionVO conVo) {
		ResultVO result = new ResultVO();
		try {
			result = dao.TripLocationOptionInsert(params);
		}
		catch(Exception e){
			result.setFail("데이터 조회 실패");
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public ResultVO updateLocationOption(Map<String, Object> params, ConnectionVO conVo) {
		ResultVO result = new ResultVO();
		try {
			result = dao.TripLocationOptionUpdate(params);
		}
		catch(Exception e){
			result.setFail("데이터 조회 실패");
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public ResultVO deleteLocationOption(Map<String, Object> params, ConnectionVO conVo) {
		ResultVO result = new ResultVO();
		try {
			result = dao.TripLocationOptionDelete(params);
		}
		catch(Exception e){
			result.setFail("데이터 조회 실패");
			e.printStackTrace();
		}
		return result;
	}
	
	
	
	/* 출장품의현황 조회*/
	@Override
	public ResultVO selectConsReportOption(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		ResultVO result = new ResultVO();
		try {
			result = dao.TripConsReportSelect(params);	
		}
		catch(Exception e){
			result.setFail("데이터 조회 실패");
			e.printStackTrace();
		}
		
		return result;
	}
	
	/* 출장단가 페이지 조회*/
	@Override
	public ResultVO selectAmtOption(Map<String, Object> params, ConnectionVO conVo) {
		ResultVO result = new ResultVO();
		try {
			result = dao.TripAmtOptionSelect(params);
		} catch(Exception e){
			result.setFail("데이터 조회 실패");
			e.printStackTrace();
		}
		return result;
	}
	/* 출장단가 페이지 단가 추가*/
	@Override
	public ResultVO insertAmtOption(Map<String, Object> params, ConnectionVO conVo) {
		ResultVO result = new ResultVO();
		try {
			result = dao.TripAmtOptionInsert(params);
		} catch(Exception e){
			result.setFail("데이터 조회 실패");
			e.printStackTrace();
		}
		return result;
	}
	/* 출장단가 페이지 단가 업데이트*/
	@Override
	public ResultVO updateAmtOption(Map<String, Object> params, ConnectionVO conVo) {
		ResultVO result = new ResultVO();
		try {
			result = dao.TripAmtOptionUpdate(params);
		} catch(Exception e){
			result.setFail("데이터 조회 실패");
			e.printStackTrace();
		}
		return result;
	}
	/* 출장단가 페이지 단가 삭제*/
	@Override
	public ResultVO deleteAmtOption(Map<String, Object> params, ConnectionVO conVo) {
		ResultVO result = new ResultVO();
		try {
			result = dao.TripAmtOptionDelete(params);
		} catch(Exception e){
			result.setFail("데이터 조회 실패");
			e.printStackTrace();
		}

		return result;
	}


	
	






//	@Override
//	public ResultVO selectPositionGroupOption(Map<String, Object> params, ConnectionVO conVo) throws Exception {
//		// TODO Auto-generated method stub
//		ResultVO result = new ResultVO();
//		result = dao.TripPositionGroupOptionSelect(params);
//		return result;
//	}



}

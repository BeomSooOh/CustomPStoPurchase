package expend.bi.admin.car;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;

public interface FBiAdminCarService {
	/**
	 * 함수명 : BiAdminCarInfoListSelect
	 * 함수설명 : 차량 정보 조회
	 * 생성일자 : 2017. 9. 1.
	 * 
	 * @param param
	 *            compSeq, searchStr(선택/검색), erpCoCd, carCd(선택/검색)
	 * @return ResultVO
	 */
	ResultVO BiAdminCarInfoListSelect ( ResultVO param, ConnectionVO conVo ) throws Exception;
	
	/**
	 * 함수명 : BiAdminCarInfoSync
	 * 함수설명 : iCUBE 차량정보 동기화
	 * 생성일자 : 2017. 9. 1.
	
	 * @param param erpCompSeq, compSeq
	 * @return ResultVO
	 */
	ResultVO BiAdminCarInfoSync ( ResultVO param, ConnectionVO conVo ) throws Exception;
}
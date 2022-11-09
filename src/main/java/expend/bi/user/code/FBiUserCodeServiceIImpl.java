package expend.bi.user.code;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


@Service ( "FBiUserCodeServiceI" )
public class FBiUserCodeServiceIImpl implements FBiUserCodeService {

	@Resource ( name = "FBiUserCodeServiceIDAO" )
	private FBiUserCodeServiceIDAO daoI;
	
	/**
	 * 함수명 : BiUserCarCommonCode
	 * 함수설명 : 사용자 - 공통코드 조회
	 * 생성일자 : 2017. 8. 31.
	 * 
	 * @param param
	 *            erpCompSeq, langCode, codeType, searchDate, searchStr, erpEmpCd, erpDeptCd
	 * @return ResultVO
	 */
	public ResultVO BiUserCarCommonCode ( ResultVO param,ConnectionVO conVo ) throws Exception{
		switch ( param.getParams( ).get( "codeType" ).toString( ).toLowerCase( ) ) {
			case "biz":
				/* ERP 사업장 정보 조회 */
				daoI.BiUserCodeDivSelect( param, conVo );
				break;
			case "dept":
				/* ERP 부서 정보 조회 */
				daoI.BiUserCodeDeptSelect( param, conVo );
				break;
			case "emp":
				/* ERP 사원 정보 조회 */
				daoI.BiUserCodeEmpSelect( param, conVo );
				break;
			case "car":
				/* ERP 차량 정보 조회 */
				daoI.BiUserCodeCarSelect( param, conVo );
				break;
			default:
				break;
		}
		return param;
	}
	
}
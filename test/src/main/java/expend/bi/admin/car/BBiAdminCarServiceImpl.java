package expend.bi.admin.car;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


@Service ( "BBiAdminCarService" )
public class BBiAdminCarServiceImpl implements BBiAdminCarService {

	/* ################################################## */
	/* 변수정의 */
	/* ################################################## */
	/* 변수정의 */
	/* 변수정의 - Service */
	@Resource ( name = "FBiAdminCarServiceI" )
	private FBiAdminCarService carServiceI;
	@Resource ( name = "FBiAdminCarServiceA" )
	private FBiAdminCarService carServiceA;
	/* 변수정의 - Class */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */
	
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */

	/**
	 * 함수명 : BiAdminCarInfoListSelect
	 * 함수설명 : 차량 정보 조회
	 * 생성일자 : 2017. 9. 1.
	 * 
	 * @param param
	 *            compSeq, searchStr(선택/검색)
	 * @return ResultVO
	 */
	public ResultVO BiAdminCarInfoListSelect ( ResultVO param, ConnectionVO conVo ) throws Exception {
		try {
			param = carServiceI.BiAdminCarInfoListSelect( param, conVo );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			param = new ResultVO( );
		}
		return param;
	}

	/**
	 * 함수명 : BiAdminCarInfoSync
	 * 함수설명 : iCUBE 차량정보 동기화
	 * 생성일자 : 2017. 9. 1.
	 * 
	 * @param param
	 *            erpCompSeq, compSeq
	 * @return ResultVO
	 */
	public ResultVO BiAdminCarInfoSync ( ResultVO param, ConnectionVO conVo ) throws Exception {
		/* 전달 파라미터 */
		Map<String, Object> tParam = param.getParams( );
		/* 로그인 정보 저장 */
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		/* 필수 파라미터 존재 여부 체크 */
		if ( param.getParams( ).get( "erpCompSeq" ) == null || param.getParams( ).get( "erpCompSeq" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			tParam.put( "erpCompSeq", loginVo.getErpCoCd( ) );
			param.setParams( tParam );
		}
		if ( param.getParams( ).get( "compSeq" ) == null || param.getParams( ).get( "compSeq" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			tParam.put( "compSeq", loginVo.getCompSeq( ) );
			param.setParams( tParam );
		}
		if ( param.getParams( ).get( "empSeq" ) == null || param.getParams( ).get( "empSeq" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			tParam.put( "empSeq", loginVo.getUniqId( ) );
			param.setParams( tParam );
		}
		if ( param.getParams( ).get( "deptSeq" ) == null || param.getParams( ).get( "deptSeq" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			tParam.put( "deptSeq", loginVo.getDept_seq( ) );
			param.setParams( tParam );
		}
		if ( param.getParams( ).get( "bizSeq" ) == null || param.getParams( ).get( "bizSeq" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			tParam.put( "bizSeq", loginVo.getBizSeq( ) );
			param.setParams( tParam );
		}
		carServiceA.BiAdminCarInfoSync( param, conVo );
		return param;
	}
}

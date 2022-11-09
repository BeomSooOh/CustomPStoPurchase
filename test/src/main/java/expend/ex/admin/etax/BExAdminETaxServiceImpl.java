package expend.ex.admin.etax;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.helper.exception.CheckExistsException;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ResultVO;
import common.vo.ex.ExCodeETaxAuthVO;


/**
 *   * @FileName : BExAdminConfigServiceImpl.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 : 지출결의 설정 ( 관리자 )
 *   
 */
@Service ( "BExAdminETaxService" )
public class BExAdminETaxServiceImpl implements BExAdminETaxService {

	/* 변수정의 - Service */
	@Resource ( name = "FExAdminETaxServiceA" )
	private FExAdminETaxService adminETaxA;
	/* 변수정의 - DAO */
	@Resource ( name = "FExAdminETaxServiceADAO" )
	private FExAdminETaxServiceADAO etaxADAO;
	/* 변수정의 - Class */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */



	/* 세금계산서 권한 설정 페이지 - 회사 귀속 모든 권한 리스트 조회 */
	public ResultVO AdminETaxAuthAllListSelect ( ResultVO param ) throws Exception {
		/* 필수값 체크 - 회사 시퀀스 */
	    if(CommonConvert.NullToString(param.getParams( ).get( "compSeq" )).equals(commonCode.EMPTYSTR)) {

			throw new Exception( "회사 seq가 누락되었습니다. " );
		}
		param = adminETaxA.AdminETaxAuthAllListSelect( param );
		return param;
	}


	/* 세금계산서 권한 설정 페이지 - 권한 리스트 조회 */
	@Override
	public ResultVO ExAdminETaxAuthListSelect ( ResultVO param ) throws Exception {
		/* 필수값 체크 - 회사 시퀀스 */
	    if(CommonConvert.NullToString(param.getParams( ).get( "compSeq" )).equals(commonCode.EMPTYSTR)) {
			throw new Exception( "회사 seq가 누락되었습니다. " );
		}
		param = adminETaxA.ExAdminETaxAuthListSelect( param );
		return param;
	}

	/* 세금계산서 권한 설정 페이지 - 권한 추가 */
	@Override
	public ResultVO ExAdminETaxAuthInsert ( ResultVO param ) throws Exception {
		/* 필수값 체크 - 회사 시퀀스 */
	    if(CommonConvert.NullToString(param.getParams( ).get( "compSeq" )).equals(commonCode.EMPTYSTR)) {
			throw new Exception( "회사 seq가 누락되었습니다. " );
		}

		ExCodeETaxAuthVO eTaxAuthVO = new ExCodeETaxAuthVO();
		eTaxAuthVO.setCompSeq(CommonConvert.CommonGetStr(param.getParams().get("compSeq")));
		eTaxAuthVO.setAuthType(CommonConvert.CommonGetStr(param.getParams().get("authType")));
		eTaxAuthVO.setCode(CommonConvert.CommonGetStr(param.getParams().get("code")));

		//중복된 값이 있는지 확인
		ResultVO checkResult = ExETaxAuthCodeDuplicationCheck(eTaxAuthVO);

		if(Integer.parseInt(CommonConvert.CommonGetSeq(checkResult.getaData().get("duplicationCount"))) > 0) {
			throw new CheckExistsException( "이미 등록된 정보가 있습니다." );
		}

		param = adminETaxA.ExAdminETaxAuthInsert( param );
		// publicInfo
		if ( param.getParams( ).get( "publicJson" ) != null && !String.valueOf(param.getParams( ).get( "publicJson" )).equals("") ) {
			List<Map<String, Object>> publicInfo = new ArrayList<Map<String, Object>>( );
			publicInfo = CommonConvert.CommonGetJSONToListMap( param.getParams( ).get( "publicJson" ).toString( ) );
			for ( Map<String, Object> tData : publicInfo ) {
				tData.put( "etaxSeq", param.getaData( ).get( "etaxSeq" ).toString( ) );

				String empDetpFlag = CommonConvert.CommonGetStr(tData.get("empDeptFlag"));
				tData.put("type", empDetpFlag);
				switch (empDetpFlag) {
				case "c":
					tData.put("code", CommonConvert.CommonGetStr(tData.get("compSeq")));
					break;
				case "d":
					tData.put("code", CommonConvert.CommonGetStr(tData.get("deptSeq")));
					break;
				case "u":
					tData.put("code", CommonConvert.CommonGetStr(tData.get("empSeq")));
					break;
				default :
					break;
				}

				param.setParams( tData );
				param = adminETaxA.ExAdminETaxAuthPublicInsert( param );
			}
		}
		return param;
	}

	/* 세금계산서 권한 설정 페이지 - 권한 삭제 */
	@Override
	public ResultVO ExAdminETaxAuthDelete(ResultVO param) throws Exception {
		/* 필수값 체크 - 회사 시퀀스 */
	    if(CommonConvert.NullToString(param.getParams( ).get( "compSeq" )).equals(commonCode.EMPTYSTR)) {
		    throw new Exception("회사 seq가 누락되었습니다. ");
		}

		if (CommonConvert.NullToString(param.getParams( ).get( "deleteEtaxSeq" )).equals(commonCode.EMPTYSTR)){
			param = adminETaxA.ExAdminETaxAuthPublicDelete(param);
			param = adminETaxA.ExAdminETaxAuthDelete(param);
		}
		else if (!CommonConvert.NullToString(param.getParams( ).get( "deleteEtaxSeq" )).equals(commonCode.EMPTYSTR)) {
			List<Map<String, Object>> deleteEtaxSeq = new ArrayList<Map<String, Object>>();
			deleteEtaxSeq = CommonConvert.CommonGetJSONToListMap(param.getParams().get("deleteEtaxSeq").toString());
			for (Map<String, Object> etaxSeq : deleteEtaxSeq) {
				Map<String, Object> tParam = param.getParams();
				tParam.put("etaxSeq", etaxSeq.get("etaxSeq").toString());
				param.setParams(tParam);
				param = adminETaxA.ExAdminETaxAuthPublicDelete(param);
				param = adminETaxA.ExAdminETaxAuthDelete(param);
			}
		}
		return param;
	}

	/* 세금계산서 권한 설정 페이지 - 권한 수정 */
	@Override
	public ResultVO ExAdminETaxAuthUpdate ( ResultVO param ) throws Exception {
		/* 필수값 체크 - 회사 시퀀스 */
	    if(CommonConvert.NullToString(param.getParams( ).get( "compSeq" )).equals(commonCode.EMPTYSTR)) {
			throw new Exception( "회사 seq가 누락되었습니다. " );
		}
		else if(CommonConvert.NullToString(param.getParams( ).get( "etaxSeq" )).equals(commonCode.EMPTYSTR)) {
			throw new Exception( "권한 시퀀스가 누락되었습니다. " );
		}

		param = adminETaxA.ExAdminETaxAuthUpdate( param );
		// publicInfo
		param = adminETaxA.ExAdminETaxAuthPublicDelete( param );
		if ( param.getParams( ).get( "publicJson" ) != null ) {
			List<Map<String, Object>> publicInfo = new ArrayList<Map<String, Object>>( );
			publicInfo = CommonConvert.CommonGetJSONToListMap( param.getParams( ).get( "publicJson" ).toString( ) );
			for ( Map<String, Object> tData : publicInfo ) {
				tData.put( "etaxSeq", param.getParams( ).get( "etaxSeq" ).toString( ) );

				String empDetpFlag = CommonConvert.CommonGetStr(tData.get("empDeptFlag"));
				tData.put("type", empDetpFlag);
				switch (empDetpFlag) {
				case "c":
					tData.put("code", CommonConvert.CommonGetStr(tData.get("compSeq")));
					tData.put("name", CommonConvert.CommonGetStr(tData.get("compName")));
					break;
				case "d":
					tData.put("code", CommonConvert.CommonGetStr(tData.get("deptSeq")));
					tData.put("name", CommonConvert.CommonGetStr(tData.get("deptName")));
					break;
				case "u":
					tData.put("code", CommonConvert.CommonGetStr(tData.get("empSeq")));
					tData.put("name", CommonConvert.CommonGetStr(tData.get("empName")));
					break;
				default :
					break;
				}

				param.setParams( tData );
				param = adminETaxA.ExAdminETaxAuthPublicInsert( param );
			}
		}
		return param;
	}

	/* 세금계산서 권한 설정 페이지 - 권한 공개범위 추가 */
	@Override
	public ResultVO ExAdminETaxAuthPublicInsert ( ResultVO param ) throws Exception {
  	    /* 필수값 체크 - 회사 시퀀스 */
        if(CommonConvert.NullToString(param.getParams( ).get( "compSeq" )).equals(commonCode.EMPTYSTR)) {
            throw new Exception( "회사 seq가 누락되었습니다. " );
        }
        else if(CommonConvert.NullToString(param.getParams( ).get( "etaxSeq" )).equals(commonCode.EMPTYSTR)) {
            throw new Exception( "권한 시퀀스가 누락되었습니다. " );
        }
		param = adminETaxA.ExAdminETaxAuthPublicInsert( param );
		return param;
	}

	/* 세금계산서 권한 설정 페이지 - 권한 공개범위 삭제 */
	@Override
	public ResultVO ExAdminETaxAuthPublicDelete ( ResultVO param ) throws Exception {
		/* 필수값 체크 - 회사 시퀀스 */
		if ( CommonConvert.CommonGetStr(param.getParams( ).get( "compSeq")).equals( commonCode.EMPTYSTR ) ) {
			throw new Exception( "회사 seq가 누락되었습니다. " );
		}
		else if ( CommonConvert.CommonGetStr(param.getParams( ).get( "etaxSeq")).equals( commonCode.EMPTYSTR ) ) {
			throw new Exception( "권한 시퀀스가 누락되었습니다. " );
		}
		param = adminETaxA.ExAdminETaxAuthPublicDelete( param );
		return param;
	}

	/* 세금계산서 권한 설정 페이지 - 사업자등록번호 또는 이메일 중복체크 */
	@Override
	public ResultVO ExETaxAuthCodeDuplicationCheck(ExCodeETaxAuthVO eTaxAuthVO) throws Exception {
		ResultVO result = new ResultVO();

		/* 필수값 체크 */
		if ( eTaxAuthVO.getCompSeq().equals( commonCode.EMPTYSTR ) ) {
			throw new Exception( "회사시퀀스가 누락되었습니다. " );
		}
		else if ( eTaxAuthVO.getAuthType().equals( commonCode.EMPTYSTR ) ) {
			throw new Exception( "권한구분이 누락되었습니다. " );
		}

		result = etaxADAO.ExETaxAuthCodeDuplicationCheckSelect(eTaxAuthVO);
		return result;
	}
}

package expend.bi.user.car;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
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


@Service ( "BBiUserCarService" )
public class BBiUserCarServiceImpl implements BBiUserCarService {

	/* 변수정의 */
	/* 변수정의 - Service */
	@Resource ( name = "FBiUserCarServiceI" )
	private FBiUserCarService carServiceI;
	@Resource ( name = "FBiUserCarServiceA" )
	private FBiUserCarService carServiceA;
	/* 변수정의 - Class */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */

	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */

	/* ## iCUBE 코드 조회 ## */
	/* ## iCUBE 코드 조회 ## - 차량 */
	public ResultVO BiUserCarListInfoSelect ( ResultVO result ) throws Exception {
		try {
			Map<String, Object> param = result.getParams( );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( param.get( commonCode.COMPSEQ ) ) );
			switch ( (String) conVo.getErpTypeCode( ) ) {
				case commonCode.ICUBE:
					/* iCUBE : exec USP_SYP0020_CAR_HELP_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DIV_CD=N'1000|',@EMP_CD=N'2000' */
					result = carServiceI.BiUserCarListInfoSelect( result, conVo );
					break;
				case commonCode.ERPIU:
					result.setFail( "구현되지 않은 기능입니다. ERPiU 연동은 지원되지 않습니다." );
					break;
				case commonCode.ETC:
					result.setFail( "구현되지 않은 기능입니다. 기타 ERP 연동은 지원되지 않습니다." );
					break;
				case commonCode.BIZBOXA:
					result.setFail( "구현되지 않은 기능입니다. ERP 연동은 필수입니다." );
					break;
				default:
					result.setFail( "구현되지 않은 기능입니다. ERP 연동정보가 확인되지 않습니다." );
					break;
			}
			result.setSuccess( );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( "" );
		}
		return result;
	}

	/* ## iCUBE 코드 조회 ## - 운행내역 */
	public ResultVO BiUserCarHisListInfoSelect ( ResultVO result ) throws Exception {
		try {
			Map<String, Object> param = result.getParams( );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( param.get( commonCode.COMPSEQ ) ) );
			switch ( (String) conVo.getErpTypeCode( ) ) {
				case commonCode.ICUBE:
					/* iCUBE : exec USP_SYP0020_BY_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DIV_CD=N'',@EMP_CD=N'2000',@CAR_CD=N' 1111',@YEAR=N'2017',@MONTH=N'09',@DAY=N'13',@SEND_YN=N'0',@SEQ_NB=0,@START_TIME=N'',@END_TIME=N'',@USE_FG=N'',@START_FG=N'',@START_ADDR=N'',@START_ADDR1=N'',@START_NAVER_VALUE=N'',@END_FG=N'',@END_ADDR=N'',@END_ADDR1=N'',@END_NAVER_VALUE=N'',@MILEAGE_KM=0,@BEFORE_KM=0,@AFTER_KM=0,@RMK_NB=0,@RMK_DC=N'',@A1=N'',@A2=0.0000,@B1=N'',@B2=0.0000,@C1=N'',@C2=0.0000,@D1=N'',@D2=0.0000,@E1=N'',@E2=0.0000,@ETC_RMK=N'',@INSERT_ID=N'2000',@INSERT_IP=N'10.102.40.32',@DML_FG=N'S' */
					result = carServiceI.BiUserCarHisListInfoSelect( result, conVo );
					break;
				case commonCode.ERPIU:
					result.setFail( "구현되지 않은 기능입니다. ERPiU 연동은 지원되지 않습니다." );
					break;
				case commonCode.ETC:
					result.setFail( "구현되지 않은 기능입니다. 기타 ERP 연동은 지원되지 않습니다." );
					break;
				case commonCode.BIZBOXA:
					result.setFail( "구현되지 않은 기능입니다. ERP 연동은 필수입니다." );
					break;
				default:
					result.setFail( "구현되지 않은 기능입니다. ERP 연동정보가 확인되지 않습니다." );
					break;
			}
			result.setSuccess( );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( "" );
		}
		return result;
	}
	/* ## iCUBE 코드 조회 ## - 마지막 주행 거리 */
	/* ## iCUBE 코드 조회 ## - 북마트 정보 */
	/* ## iCUBE 코드 조회 ## - 즐겨찾기 정보 */
	/* ## iCUBE 코드 조회 ## - 휴일 정보 */
	/* ## iCUBE 코드 조회 ## - 거래처 정보 */
	/* ## iCUBE 코드 조회 ## - 거래처 주소 정보 */

	/**
	 * 함수명 : BiUserCarPersonListSelect
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 조회
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            compSeq, useDateFrom, useDateTo, carCode(예 : 111','333','222 이런식으로)
	 * @return ResultVO
	 */
	public ResultVO BiUserCarPersonListSelect ( ResultVO param ) throws Exception {
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		/* 전달 파라미터 저장 */
		Map<String, Object> tParam = param.getParams( );
		if ( param.getParams( ).get( "compSeq" ) == null || param.getParams( ).get( "compSeq" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			tParam.put( "compSeq", loginVo.getCompSeq( ) );
			param.setParams( tParam );
		}
		if ( param.getParams( ).get( "useDate" ) == null || param.getParams( ).get( "useDate" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			SimpleDateFormat tDate = new SimpleDateFormat( "yyyyMMdd", Locale.getDefault() );
			tParam.put( "useDate", tDate.format( new Date( ) ) );
			param.setParams( tParam );
		}
		if ( param.getParams( ).get( "carCode" ) == null || param.getParams( ).get( "carCode" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			throw new Exception( "carCode가 존재하지 않습니다." );
		}
		carServiceA.BiUserCarPersonListSelect( param );
		return param;
	}

	/**
	 * 함수명 : BiUserCarPersonInsert
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 등록
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 * @return ResultVO
	 */
	public ResultVO BiUserCarPersonInsert ( ResultVO param ) throws Exception {
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		/* 전달 파라미터 저장 */
		Map<String, Object> tParam = param.getParams( );
		if ( param.getParams( ).get( "compSeq" ) == null || param.getParams( ).get( "compSeq" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			tParam.put( "compSeq", loginVo.getCompSeq( ) );
			param.setParams( tParam );
		}
		if ( param.getParams( ).get( "useDate" ) == null || param.getParams( ).get( "useDate" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			SimpleDateFormat tDate = new SimpleDateFormat( "yyyyMMdd", Locale.getDefault() );
			tParam.put( "useDate", tDate.format( new Date( ) ) );
			param.setParams( tParam );
		}
		carServiceA.BiUserCarPersonInsert( param );
		return param;
	}

	/**
	 * 함수명 : BiUserCarPersonUpdate
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 수정
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            compSeq, carCode, useDate, seqNumber
	 * @return ResultVO
	 */
	public ResultVO BiUserCarPersonUpdate ( ResultVO param ) throws Exception {
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		/* 전달 파라미터 저장 */
		Map<String, Object> tParam = param.getParams( );
		if ( param.getParams( ).get( "compSeq" ) == null || param.getParams( ).get( "compSeq" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			tParam.put( "compSeq", loginVo.getCompSeq( ) );
			param.setParams( tParam );
		}
		if ( param.getParams( ).get( "carCode" ) == null || param.getParams( ).get( "carCode" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			throw new Exception( "carCode 파라미터가 존재하지 않습니다." );
		}
		if ( param.getParams( ).get( "useDate" ) == null || param.getParams( ).get( "useDate" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			throw new Exception( "useDate 파라미터가 존재하지 않습니다." );
		}
		if ( param.getParams( ).get( "seqNumber" ) == null || param.getParams( ).get( "seqNumber" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			throw new Exception( "seqNumber 파라미터가 존재하지 않습니다." );
		}
		carServiceA.BiUserCarPersonUpdate( param );
		return param;
	}

	/**
	 * 함수명 : BiUserCarPersonDelete
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 삭제
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            compSeq, carCode, useDate, seqNumber
	 * @return ResultVO
	 */
	public ResultVO BiUserCarPersonDelete ( ResultVO param ) throws Exception {
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		/* 전달 파라미터 저장 */
		Map<String, Object> tParam = param.getParams( );
		if ( param.getParams( ).get( "compSeq" ) == null || param.getParams( ).get( "compSeq" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			tParam.put( "compSeq", loginVo.getCompSeq( ) );
			param.setParams( tParam );
		}
		if ( param.getParams( ).get( "carCode" ) == null || param.getParams( ).get( "carCode" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			throw new Exception( "carCode 파라미터가 존재하지 않습니다." );
		}
		if ( param.getParams( ).get( "useDate" ) == null || param.getParams( ).get( "useDate" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			throw new Exception( "useDate 파라미터가 존재하지 않습니다." );
		}
		if ( param.getParams( ).get( "seqNumber" ) == null || param.getParams( ).get( "seqNumber" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			throw new Exception( "seqNumber 파라미터가 존재하지 않습니다." );
		}
		carServiceA.BiUserCarPersonDelete( param );
		return param;
	}

	/**
	 * 함수명 : BiUserCarPersonClose
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 마감/취소
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            closeYN(0:미마감, 1:마감), modifySeq, ip, compSeq, carCode, useDate, seqNumber
	 * @return ResultVO
	 */
	public ResultVO BiUserCarPersonClose ( ResultVO param ) throws Exception {
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		/* 전달 파라미터 저장 */
		Map<String, Object> tParam = param.getParams( );
		if ( param.getParams( ).get( "modifySeq" ) == null || param.getParams( ).get( "modifySeq" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			tParam.put( "modifySeq", loginVo.getUniqId( ) );
			param.setParams( tParam );
		}
		if ( param.getParams( ).get( "ip" ) == null || param.getParams( ).get( "ip" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			tParam.put( "ip", loginVo.getIp( ) );
			param.setParams( tParam );
		}
		if ( param.getParams( ).get( "compSeq" ) == null || param.getParams( ).get( "compSeq" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			tParam.put( "compSeq", loginVo.getCompSeq( ) );
			param.setParams( tParam );
		}
		if ( param.getParams( ).get( "carCode" ) == null || param.getParams( ).get( "carCode" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			throw new Exception( "carCode 파라미터가 존재하지 않습니다." );
		}
		if ( param.getParams( ).get( "useDate" ) == null || param.getParams( ).get( "useDate" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			throw new Exception( "useDate 파라미터가 존재하지 않습니다." );
		}
		if ( param.getParams( ).get( "seqNumber" ) == null || param.getParams( ).get( "seqNumber" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			throw new Exception( "seqNumber 파라미터가 존재하지 않습니다." );
		}
		carServiceA.BiUserCarPersonClose( param );
		return param;
	}

	/**
	 * 함수명 : BiUserCarPersonSend
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 전송/취소
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            erpSendYN(0:미전송, 1:전송), erpSendSeq, modifySeq, ip, compSeq, carCode, useDate, seqNumber
	 * @return ResultVO
	 */
	public ResultVO BiUserCarPersonSend ( ResultVO param ) throws Exception {
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		/* 전달 파라미터 저장 */
		Map<String, Object> tParam = param.getParams( );
		if ( param.getParams( ).get( "modifySeq" ) == null || param.getParams( ).get( "modifySeq" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			tParam.put( "modifySeq", loginVo.getUniqId( ) );
			param.setParams( tParam );
		}
		if ( param.getParams( ).get( "ip" ) == null || param.getParams( ).get( "ip" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			tParam.put( "ip", loginVo.getIp( ) );
			param.setParams( tParam );
		}
		if ( param.getParams( ).get( "compSeq" ) == null || param.getParams( ).get( "compSeq" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			tParam.put( "compSeq", loginVo.getCompSeq( ) );
			param.setParams( tParam );
		}
		if ( param.getParams( ).get( "carCode" ) == null || param.getParams( ).get( "carCode" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			throw new Exception( "carCode 파라미터가 존재하지 않습니다." );
		}
		if ( param.getParams( ).get( "useDate" ) == null || param.getParams( ).get( "useDate" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			throw new Exception( "useDate 파라미터가 존재하지 않습니다." );
		}
		if ( param.getParams( ).get( "seqNumber" ) == null || param.getParams( ).get( "seqNumber" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			throw new Exception( "seqNumber 파라미터가 존재하지 않습니다." );
		}
		/* 전송 */
		if ( param.getParams( ).get( "erpSendYN" ).toString( ).equals( "1" ) ) {
			/* 전송 할 항목 정보 조회 */
			carServiceA.BiUserCarPersonSendListSelect( param );
			if ( param.getResultCode( ).equals( commonCode.EMPTYYES ) ) {
				/* iCUBE 전송 */
				tParam = param.getParams( );
				tParam.put( "seqNb", param.getaData( ) );
				param.setParams( tParam );
				carServiceI.BiUserCarPersonSend( param );
			}
			if ( param.getResultCode( ).equals( commonCode.EMPTYYES ) ) {
				/* 그룹웨어 전송값 저장 */
				tParam = param.getParams( );
				tParam.put( "seqNb", param.getaData( ) );
				param.setParams( tParam );
				carServiceA.BiUserCarPersonSend( param );
			}
		}
		else { /* 취소 */
			/* iCUBE 데이터 삭제 */
			carServiceI.BiUserCarPersonSendCancel( param );
			if ( param.getResultCode( ).equals( commonCode.EMPTYYES ) ) {
				carServiceA.BiUserCarPersonSendCancel( param );
			}
		}
		return param;
	}

	/**
	 * 함수명 : BiUserCarBookmarkSelect
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 즐겨찾기 조회
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            empSeq, compSeq
	 * @return ResultVO
	 */
	public ResultVO BiUserCarBookmarkSelect ( ResultVO param ) throws Exception {
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		/* 전달 파라미터 저장 */
		Map<String, Object> tParam = param.getParams( );
		if ( param.getParams( ).get( "empSeq" ) == null || param.getParams( ).get( "empSeq" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			tParam.put( "empSeq", loginVo.getUniqId( ) );
			param.setParams( tParam );
		}
		if ( param.getParams( ).get( "compSeq" ) == null || param.getParams( ).get( "compSeq" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			tParam.put( "compSeq", loginVo.getCompSeq( ) );
			param.setParams( tParam );
		}
		carServiceA.BiUserCarBookmarkSelect( param );
		return param;
	}

	/**
	 * 함수명 : BiUserCarBookmarkInsert
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 즐겨찾기 등록
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 * @return ResultVO
	 */
	public ResultVO BiUserCarBookmarkInsert ( ResultVO param ) throws Exception {
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		/* 전달 파라미터 저장 */
		Map<String, Object> tParam = param.getParams( );
		if ( param.getParams( ).get( "empSeq" ) == null || param.getParams( ).get( "empSeq" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			tParam.put( "empSeq", loginVo.getUniqId( ) );
			param.setParams( tParam );
		}
		if ( param.getParams( ).get( "compSeq" ) == null || param.getParams( ).get( "compSeq" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			tParam.put( "compSeq", loginVo.getCompSeq( ) );
			param.setParams( tParam );
		}
		carServiceA.BiUserCarBookmarkInsert( param );
		return param;
	}

	/**
	 * 함수명 : BiUserCarBookmarkUpdate
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 즐겨찾기 수정
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            bookmarkCode, empSeq, compSeq
	 * @return ResultVO
	 */
	public ResultVO BiUserCarBookmarkUpdate ( ResultVO param ) throws Exception {
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		/* 전달 파라미터 저장 */
		Map<String, Object> tParam = param.getParams( );
		if ( param.getParams( ).get( "empSeq" ) == null || param.getParams( ).get( "empSeq" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			tParam.put( "empSeq", loginVo.getUniqId( ) );
			param.setParams( tParam );
		}
		if ( param.getParams( ).get( "compSeq" ) == null || param.getParams( ).get( "compSeq" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			tParam.put( "compSeq", loginVo.getCompSeq( ) );
			param.setParams( tParam );
		}
		if ( param.getParams( ).get( "bookmarkCode" ) == null || param.getParams( ).get( "bookmarkCode" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			throw new Exception( "bookmarkCode가 존재하지 않습니다." );
		}
		carServiceA.BiUserCarBookmarkUpdate( param );
		return param;
	}

	/**
	 * 함수명 : BiUserCarBookmarkDelete
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 즐겨찾기 삭제
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            bookmarkCode, empSeq, compSeq
	 * @return ResultVO
	 */
	public ResultVO BiUserCarBookmarkDelete ( ResultVO param ) throws Exception {
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		/* 전달 파라미터 저장 */
		Map<String, Object> tParam = param.getParams( );
		if ( param.getParams( ).get( "empSeq" ) == null || param.getParams( ).get( "empSeq" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			tParam.put( "empSeq", loginVo.getUniqId( ) );
			param.setParams( tParam );
		}
		if ( param.getParams( ).get( "compSeq" ) == null || param.getParams( ).get( "compSeq" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			tParam.put( "compSeq", loginVo.getCompSeq( ) );
			param.setParams( tParam );
		}
		if ( param.getParams( ).get( "bookmarkCode" ) == null || param.getParams( ).get( "bookmarkCode" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			throw new Exception( "bookmarkCode가 존재하지 않습니다." );
		}
		carServiceA.BiUserCarBookmarkDelete( param );
		return param;
	}

	/**
	 * 함수명 : BiUserCarRmkSelect
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 비고 조회
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            erpCompSeq, erpEmpSeq
	 * @return ResultVO
	 */
	public ResultVO BiUserCarRmkSelect ( ResultVO param ) throws Exception {
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		/* 전달 파라미터 저장 */
		Map<String, Object> tParam = param.getParams( );
		if ( param.getParams( ).get( "erpCompSeq" ) == null || param.getParams( ).get( "erpCompSeq" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			tParam.put( "erpCompSeq", loginVo.getErpCoCd( ) );
			param.setParams( tParam );
		}
		if ( param.getParams( ).get( "erpEmpSeq" ) == null || param.getParams( ).get( "erpEmpSeq" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			tParam.put( "erpEmpSeq", loginVo.getErpEmpCd( ) );
			param.setParams( tParam );
		}
		carServiceA.BiUserCarRmkSelect( param );
		return param;
	}

	/**
	 * 함수명 : BiUserCarRmkUpdate
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 비고 수정
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            erpCompSeq, erpEmpSeq, rmkNb, useFg
	 * @return ResultVO
	 */
	public ResultVO BiUserCarRmkUpdate ( ResultVO param ) throws Exception {
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		/* 전달 파라미터 저장 */
		Map<String, Object> tParam = param.getParams( );
		if ( param.getParams( ).get( "erpCompSeq" ) == null || param.getParams( ).get( "erpCompSeq" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			tParam.put( "erpCompSeq", loginVo.getErpCoCd( ) );
			param.setParams( tParam );
		}
		if ( param.getParams( ).get( "erpEmpSeq" ) == null || param.getParams( ).get( "erpEmpSeq" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			tParam.put( "erpEmpSeq", loginVo.getErpEmpCd( ) );
			param.setParams( tParam );
		}
		if ( param.getParams( ).get( "rmkNb" ) == null || param.getParams( ).get( "rmkNb" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			throw new Exception( "rmkNb 가 존재하지 않습니다." );
		}
		if ( param.getParams( ).get( "useFg" ) == null || param.getParams( ).get( "useFg" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			throw new Exception( "useFg 가 존재하지 않습니다." );
		}
		carServiceA.BiUserCarRmkUpdate( param );
		return param;
	}

	/**
	 * 함수명 : BiUserCarRmkInsert
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 비고 등록
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 * @return ResultVO
	 */
	public ResultVO BiUserCarRmkInsert ( ResultVO param ) throws Exception {
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		/* 전달 파라미터 저장 */
		Map<String, Object> tParam = param.getParams( );
		if ( param.getParams( ).get( "erpCompSeq" ) == null || param.getParams( ).get( "erpCompSeq" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			tParam.put( "erpCompSeq", loginVo.getErpCoCd( ) );
			param.setParams( tParam );
		}
		if ( param.getParams( ).get( "erpEmpSeq" ) == null || param.getParams( ).get( "erpEmpSeq" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			tParam.put( "erpEmpSeq", loginVo.getErpEmpCd( ) );
			param.setParams( tParam );
		}
		if ( param.getParams( ).get( "useFg" ) == null || param.getParams( ).get( "useFg" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			throw new Exception( "useFg 가 존재하지 않습니다." );
		}
		carServiceA.BiUserCarRmkInsert( param );
		return param;
	}

	/**
	 * 함수명 : BiUserCarRmkDelete
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 비고 삭제
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            erpCompSeq, erpEmpSeq, rmkNb, useFg
	 * @return ResultVO
	 */
	public ResultVO BiUserCarRmkDelete ( ResultVO param ) throws Exception {
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		/* 전달 파라미터 저장 */
		Map<String, Object> tParam = param.getParams( );
		if ( param.getParams( ).get( "erpCompSeq" ) == null || param.getParams( ).get( "erpCompSeq" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			tParam.put( "erpCompSeq", loginVo.getErpCoCd( ) );
			param.setParams( tParam );
		}
		if ( param.getParams( ).get( "erpEmpSeq" ) == null || param.getParams( ).get( "erpEmpSeq" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			tParam.put( "erpEmpSeq", loginVo.getErpEmpCd( ) );
			param.setParams( tParam );
		}
		if ( param.getParams( ).get( "rmkNb" ) == null || param.getParams( ).get( "rmkNb" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			throw new Exception( "rmkNb 가 존재하지 않습니다." );
		}
		if ( param.getParams( ).get( "useFg" ) == null || param.getParams( ).get( "useFg" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			throw new Exception( "useFg 가 존재하지 않습니다." );
		}
		carServiceA.BiUserCarRmkDelete( param );
		return param;
	}
}
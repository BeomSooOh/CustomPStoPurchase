package expend.bi.user.car;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cmm.util.MapUtil;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


@Service ( "FBiUserCarServiceI" )
public class FBiUserCarServiceIImpl implements FBiUserCarService {

	@Resource ( name = "FBiUserCarServiceIDAO" )
	private FBiUserCarServiceIDAO daoI;

	/* ## iCUBE 코드 조회 ## */
	/* ## iCUBE 코드 조회 ## - 차량 */
	@Override
	public ResultVO BiUserCarListInfoSelect ( ResultVO result, ConnectionVO conVo ) throws Exception {
		/* iCUBE : exec USP_SYP0020_CAR_HELP_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DIV_CD=N'1000|',@EMP_CD=N'2000' */
		Map<String, Object> param = new HashMap<String, Object>( );
		boolean chkParameter = true;
		try {
			/* 기본값 정의 */
			param = result.getParams( );
			/* 필수 파라미터 검증 - LANGKIND */
			String[] parametersCheck = { "LANGKIND", "N", "CO_CD", "Y", "DIV_CD", "Y", "EMP_CD", "Y" };
			if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
				result.setFail( "필수 입력 정보가 누락되었습니다." );
				chkParameter = false;
			}
			if ( chkParameter ) {
				/* 정보 조회 */
				/* 처리 상태값 */
				result.setSuccess( );
			}
			else {
				result.setFail( "" );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( "" );
		}
		return result;
	}

	/* ## iCUBE 코드 조회 ## - 운행내역 */
	@Override
	public ResultVO BiUserCarHisListInfoSelect ( ResultVO result, ConnectionVO conVo ) throws Exception {
		/* iCUBE : exec USP_SYP0020_BY_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DIV_CD=N'',@EMP_CD=N'2000',@CAR_CD=N' 1111',@YEAR=N'2017',@MONTH=N'09',@DAY=N'13',@SEND_YN=N'0',@SEQ_NB=0,@START_TIME=N'',@END_TIME=N'',@USE_FG=N'',@START_FG=N'',@START_ADDR=N'',@START_ADDR1=N'',@START_NAVER_VALUE=N'',@END_FG=N'',@END_ADDR=N'',@END_ADDR1=N'',@END_NAVER_VALUE=N'',@MILEAGE_KM=0,@BEFORE_KM=0,@AFTER_KM=0,@RMK_NB=0,@RMK_DC=N'',@A1=N'',@A2=0.0000,@B1=N'',@B2=0.0000,@C1=N'',@C2=0.0000,@D1=N'',@D2=0.0000,@E1=N'',@E2=0.0000,@ETC_RMK=N'',@INSERT_ID=N'2000',@INSERT_IP=N'10.102.40.32',@DML_FG=N'S' */
		Map<String, Object> param = new HashMap<String, Object>( );
		boolean chkParameter = true;
		try {
			/* 기본값 정의 */
			param = result.getParams( );
			/* 필수 파라미터 검증 - LANGKIND */
			String[] parametersCheck = { "LANGKIND", "N", "CO_CD", "Y", "DIV_CD", "Y", "EMP_CD", "Y" };
			if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
				result.setFail( "필수 입력 정보가 누락되었습니다." );
				chkParameter = false;
			}
			if ( chkParameter ) {
				/* 정보 조회 */
				/* 처리 상태값 */
				result.setSuccess( );
			}
			else {
				result.setFail( "" );
			}
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
	 *            compSeq, useDate, carCode(예 : 111','333','222 이런식으로)
	 * @return ResultVO
	 */
	public ResultVO BiUserCarPersonListSelect ( ResultVO param ) throws Exception {
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
		return param;
	}

	/**
	 * 함수명 : BiUserCarPersonSend
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 전송
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            erpSendYN(0:미전송, 1:전송), erpSendSeq, modifySeq, ip, compSeq, carCode, useDate, seqNumber
	 * @return ResultVO
	 */
	public ResultVO BiUserCarPersonSend ( ResultVO param ) throws Exception {
		/* 전송 */
		if ( param.getParams( ).get( "erpSendYN" ).toString( ).equals( "1" ) ) {
			daoI.BiUserCarPersonSend( param );
		}
		else { /* 취소 */
			daoI.BiUserCarPersonCancel( param );
		}
		return param;
	}

	/**
	 * 함수명 : BiUserCarPersonSendCancel
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 취소
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            erpSendYN(0:미전송, 1:전송), erpSendSeq, modifySeq, ip, compSeq, carCode, useDate, seqNumber
	 * @return ResultVO
	 */
	public ResultVO BiUserCarPersonSendCancel ( ResultVO param ) throws Exception {
		daoI.BiUserCarPersonCancel( param );
		return param;
	}

	/**
	 * 함수명 : BiUserCarPersonSendListSelect
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 전송 데이터 조회
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            empSeq, ip, compSeq, carCode, useDate, seqNumber
	 * @return ResultVO
	 */
	public ResultVO BiUserCarPersonSendListSelect ( ResultVO param ) throws Exception {
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
		return param;
	}
}
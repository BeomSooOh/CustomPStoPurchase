package expend.bi.user.car;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


public interface FBiUserCarService {

	/* ## iCUBE 코드 조회 ## */
	/* ## iCUBE 코드 조회 ## - 차량 */
	ResultVO BiUserCarListInfoSelect ( ResultVO result, ConnectionVO conVo ) throws Exception;

	/* ## iCUBE 코드 조회 ## - 운행내역 */
	ResultVO BiUserCarHisListInfoSelect ( ResultVO result, ConnectionVO conVo ) throws Exception;
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
	ResultVO BiUserCarPersonListSelect ( ResultVO param ) throws Exception;

	/**
	 * 함수명 : BiUserCarPersonInsert
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 등록
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 * @return ResultVO
	 */
	ResultVO BiUserCarPersonInsert ( ResultVO param ) throws Exception;

	/**
	 * 함수명 : BiUserCarPersonUpdate
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 수정
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            compSeq, carCode, useDate, seqNumber
	 * @return ResultVO
	 */
	ResultVO BiUserCarPersonUpdate ( ResultVO param ) throws Exception;

	/**
	 * 함수명 : BiUserCarPersonDelete
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 삭제
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            compSeq, carCode, useDate, seqNumber
	 * @return ResultVO
	 */
	ResultVO BiUserCarPersonDelete ( ResultVO param ) throws Exception;

	/**
	 * 함수명 : BiUserCarPersonClose
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 마감/취소
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            closeYN(0:미마감, 1:마감), modifySeq, ip, compSeq, carCode, useDate, seqNumber
	 * @return ResultVO
	 */
	ResultVO BiUserCarPersonClose ( ResultVO param ) throws Exception;

	/**
	 * 함수명 : BiUserCarPersonSend
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 전송
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            erpSendYN(0:미전송, 1:전송), erpSendSeq, modifySeq, ip, compSeq, carCode, useDate, seqNumber
	 * @return ResultVO
	 */
	ResultVO BiUserCarPersonSend ( ResultVO param ) throws Exception;

	/**
	 * 함수명 : BiUserCarPersonSendCancel
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 취소
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            erpSendYN(0:미전송, 1:전송), erpSendSeq, modifySeq, ip, compSeq, carCode, useDate, seqNumber
	 * @return ResultVO
	 */
	ResultVO BiUserCarPersonSendCancel ( ResultVO param ) throws Exception;

	/**
	 * 함수명 : BiUserCarPersonSendListSelect
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 전송 데이터 조회
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            empSeq, ip, compSeq, carCode, useDate, seqNumber
	 * @return ResultVO
	 */
	ResultVO BiUserCarPersonSendListSelect ( ResultVO param ) throws Exception;

	/**
	 * 함수명 : BiUserCarBookmarkSelect
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 즐겨찾기 조회
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            empSeq, compSeq
	 * @return ResultVO
	 */
	ResultVO BiUserCarBookmarkSelect ( ResultVO param ) throws Exception;

	/**
	 * 함수명 : BiUserCarBookmarkInsert
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 즐겨찾기 등록
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 * @return ResultVO
	 */
	ResultVO BiUserCarBookmarkInsert ( ResultVO param ) throws Exception;

	/**
	 * 함수명 : BiUserCarBookmarkUpdate
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 즐겨찾기 수정
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            bookmarkCode, empSeq, compSeq
	 * @return ResultVO
	 */
	ResultVO BiUserCarBookmarkUpdate ( ResultVO param ) throws Exception;

	/**
	 * 함수명 : BiUserCarBookmarkDelete
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 즐겨찾기 삭제
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            bookmarkCode, empSeq, compSeq
	 * @return ResultVO
	 */
	ResultVO BiUserCarBookmarkDelete ( ResultVO param ) throws Exception;

	/**
	 * 함수명 : BiUserCarRmkSelect
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 비고 조회
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            erpCompSeq, erpEmpSeq
	 * @return ResultVO
	 */
	ResultVO BiUserCarRmkSelect ( ResultVO param ) throws Exception;

	/**
	 * 함수명 : BiUserCarRmkUpdate
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 비고 수정
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            erpCompSeq, erpEmpSeq, rmkNb, useFg
	 * @return ResultVO
	 */
	ResultVO BiUserCarRmkUpdate ( ResultVO param ) throws Exception;

	/**
	 * 함수명 : BiUserCarRmkInsert
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 비고 등록
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 * @return ResultVO
	 */
	ResultVO BiUserCarRmkInsert ( ResultVO param ) throws Exception;

	/**
	 * 함수명 : BiUserCarRmkDelete
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 비고 삭제
	 * 생성일자 : 2017. 8. 31.
	 *
	 * @param param
	 *            erpCompSeq, erpEmpSeq, rmkNb, useFg
	 * @return ResultVO
	 */
	ResultVO BiUserCarRmkDelete ( ResultVO param ) throws Exception;
}
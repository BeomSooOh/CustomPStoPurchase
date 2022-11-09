package expend.bi.user.car;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


@Service ( "FBiUserCarServiceA" )
public class FBiUserCarServiceAImpl implements FBiUserCarService {

	@Resource ( name = "FBiUserCarServiceADAO" )
	private FBiUserCarServiceADAO daoA;

	/* ## Bizbox Alpha 코드 조회 ## */
	/* ## Bizbox Alpha 코드 조회 ## - 차량 */
	@Override
	public ResultVO BiUserCarListInfoSelect ( ResultVO result, ConnectionVO conVo ) throws Exception {
		return null;
	}

	/* ## Bizbox Alpha 코드 조회 ## - 운행내역 */
	@Override
	public ResultVO BiUserCarHisListInfoSelect ( ResultVO result, ConnectionVO conVo ) throws Exception {
		return null;
	}
	/* ## Bizbox Alpha 코드 조회 ## - 마지막 주행 거리 */
	/* ## Bizbox Alpha 코드 조회 ## - 북마트 정보 */
	/* ## Bizbox Alpha 코드 조회 ## - 즐겨찾기 정보 */
	/* ## Bizbox Alpha 코드 조회 ## - 휴일 정보 */
	/* ## Bizbox Alpha 코드 조회 ## - 거래처 정보 */
	/* ## Bizbox Alpha 코드 조회 ## - 거래처 주소 정보 */

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
		daoA.BiUserCarPersonListSelect( param );
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
		daoA.BiUserCarPersonInsert( param );
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
		daoA.BiUserCarPersonUpdate( param );
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
		daoA.BiUserCarPersonDelete( param );
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
		daoA.BiUserCarPersonClose( param );
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
		daoA.BiUserCarPersonSend( param );
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
		daoA.BiUserCarPersonSendCancel( param );
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
		return daoA.BiUserCarPersonSendListSelect( param );
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
		daoA.BiUserCarBookmarkSelect( param );
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
		daoA.BiUserCarBookmarkInsert( param );
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
		daoA.BiUserCarBookmarkUpdate( param );
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
		daoA.BiUserCarBookmarkDelete( param );
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
		daoA.BiUserCarRmkSelect( param );
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
		daoA.BiUserCarRmkUpdate( param );
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
		daoA.BiUserCarRmkInsert( param );
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
		daoA.BiUserCarRmkDelete( param );
		return param;
	}
}
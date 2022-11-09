package expend.bi.user.car;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FBiUserCarServiceADAO" )
public class FBiUserCarServiceADAO extends EgovComAbstractDAO {

	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */

	/**
	 * 함수명 : BiUserCarPersonListSelect
	 * 함수설명 : 사용자 - 업무용승용차 차량운행기록부 조회
	 * 생성일자 : 2017. 8. 31.
	 * 
	 * @param param
	 *            compSeq, useDateFrom, useDateTo, carCode(예 : 111','333','222 이런식으로)
	 * @return ResultVO
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO BiUserCarPersonListSelect ( ResultVO param ) throws Exception {
		try {
			param.setAaData( this.list( "BiUserCarPersonListSelect", param.getParams( ) ) );
		}
		catch ( Exception e ) {
			param.setResultName( e.getMessage( ) );
			param.setResultCode( commonCode.EMPTYNO );
		}
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
		try {
			this.insert( "BiUserCarPersonInsert", param.getParams( ) );
			param.setResultCode( commonCode.EMPTYYES );
		}
		catch ( Exception e ) {
			param.setResultName( e.getMessage( ) );
			param.setResultCode( commonCode.EMPTYNO );
		}
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
		try {
			this.update( "BiUserCarPersonUpdate", param.getParams( ) );
			param.setResultCode( commonCode.EMPTYYES );
		}
		catch ( Exception e ) {
			param.setResultName( e.getMessage( ) );
			param.setResultCode( commonCode.EMPTYNO );
		}
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
		try {
			this.update( "BiUserCarPersonDelete", param.getParams( ) );
			param.setResultCode( commonCode.EMPTYYES );
		}
		catch ( Exception e ) {
			param.setResultName( e.getMessage( ) );
			param.setResultCode( commonCode.EMPTYNO );
		}
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
		try {
			this.update( "BiUserCarPersonClose", param.getParams( ) );
			param.setResultCode( commonCode.EMPTYYES );
		}
		catch ( Exception e ) {
			param.setResultName( e.getMessage( ) );
			param.setResultCode( commonCode.EMPTYNO );
		}
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
		try {
			this.update( "BiUserCarPersonSend", param.getParams( ) );
			param.setResultCode( commonCode.EMPTYYES );
		}
		catch ( Exception e ) {
			param.setResultName( e.getMessage( ) );
			param.setResultCode( commonCode.EMPTYNO );
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
		try {
			this.update( "BiUserCarPersonSendCancel", param.getParams( ) );
			param.setResultCode( commonCode.EMPTYYES );
		}
		catch ( Exception e ) {
			param.setResultName( e.getMessage( ) );
			param.setResultCode( commonCode.EMPTYNO );
		}
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
		try {
			this.update( "BiUserCarPersonSendListSelect", param.getParams( ) );
			param.setResultCode( commonCode.EMPTYYES );
		}
		catch ( Exception e ) {
			param.setResultName( e.getMessage( ) );
			param.setResultCode( commonCode.EMPTYNO );
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
	@SuppressWarnings ( "unchecked" )
	public ResultVO BiUserCarBookmarkSelect ( ResultVO param ) throws Exception {
		try {
			param.setAaData( this.list( "BiUserCarBookmarkSelect", param.getParams( ) ) );
			param.setResultCode( commonCode.EMPTYYES );
		}
		catch ( Exception e ) {
			param.setResultName( e.getMessage( ) );
			param.setResultCode( commonCode.EMPTYNO );
		}
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
		try {
			this.insert( "BiUserCarBookmarkInsert", param.getParams( ) );
			param.setResultCode( commonCode.EMPTYYES );
		}
		catch ( Exception e ) {
			param.setResultName( e.getMessage( ) );
			param.setResultCode( commonCode.EMPTYNO );
		}
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
		try {
			this.update( "BiUserCarBookmarkUpdate", param.getParams( ) );
			param.setResultCode( commonCode.EMPTYYES );
		}
		catch ( Exception e ) {
			param.setResultName( e.getMessage( ) );
			param.setResultCode( commonCode.EMPTYNO );
		}
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
		try {
			this.update( "BiUserCarBookmarkDelete", param.getParams( ) );
			param.setResultCode( commonCode.EMPTYYES );
		}
		catch ( Exception e ) {
			param.setResultName( e.getMessage( ) );
			param.setResultCode( commonCode.EMPTYNO );
		}
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
	@SuppressWarnings ( "unchecked" )
	public ResultVO BiUserCarRmkSelect ( ResultVO param ) throws Exception {
		try {
			param.setAaData( this.list( "BiUserCarRmkSelect", param.getParams( ) ) );
			param.setResultCode( commonCode.EMPTYYES );
		}
		catch ( Exception e ) {
			param.setResultName( e.getMessage( ) );
			param.setResultCode( commonCode.EMPTYNO );
		}
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
		try {
			this.update( "BiUserCarRmkUpdate", param.getParams( ) );
			param.setResultCode( commonCode.EMPTYYES );
		}
		catch ( Exception e ) {
			param.setResultName( e.getMessage( ) );
			param.setResultCode( commonCode.EMPTYNO );
		}
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
		try {
			this.insert( "BiUserCarRmkInsert", param );
			param.setResultCode( commonCode.EMPTYYES );
		}
		catch ( Exception e ) {
			param.setResultName( e.getMessage( ) );
			param.setResultCode( commonCode.EMPTYNO );
		}
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
		try {
			this.delete( "BiUserCarRmkDelete", param.getParams( ) );
			param.setResultCode( commonCode.EMPTYYES );
		}
		catch ( Exception e ) {
			param.setResultName( e.getMessage( ) );
			param.setResultCode( commonCode.EMPTYNO );
		}
		return param;
	}
}

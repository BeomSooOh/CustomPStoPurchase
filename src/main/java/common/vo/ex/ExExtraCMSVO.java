package common.vo.ex;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;


/**
 * CMS 연동 데이터 조회와 컨트롤 VO입니다.
 * 해당의 클래스로부터, 연동에 관련된 로그 조회가 가능합니다.
 *
 * @author asdlkjsb (최상배)
 */
public class ExExtraCMSVO {

	/* Constructor Area */
	public ExExtraCMSVO ( ) {
		batchSeq = "";
		compSeq = "";
		moduleType = "";
		logType = "";
		message = "";
		createDate = "";
		bizError = false;
		bizErrorMsg = "-";
	}

	String batchSeq;
	String compSeq;
	String moduleType;
	String logType;
	String message;
	String createDate;
	String compName;
	boolean isError;
	public boolean bizError;
	public String bizErrorMsg;

	/* Setter Area */
	public void SetBatchSeq ( String batchSeq ) {
		this.batchSeq = batchSeq;
	}

	public void SetCompSeq ( String compSeq ) {
		this.compSeq = compSeq;
	}

	public void SetModuleType ( String moduleType ) {
		this.moduleType = moduleType;
	}

	public void SetLogType ( String logType ) {
		//this.isError = (logType.equals( commonCode.ERROR ) ? true : false);
		if( logType.equals( commonCode.ERROR ) ){
			this.isError = true;
		}else {
			this.isError = false;
		}
		this.logType = logType;
	}

	public void SetMessage ( String message ) {
		this.message = message;
	}

	public void SetCreateDate ( String createDate ) {
		this.createDate = createDate;
	}

	public void SetCompName ( String compName ) {
		this.compName = compName;
	}

	/* Geter Area */
	public String getBatchSeq ( ) {
		return CommonConvert.CommonGetStr(this.batchSeq);
	}

	public String getCompSeq ( ) {
		return CommonConvert.CommonGetStr(this.compSeq);
	}

	public String getModuleType ( ) {
		return CommonConvert.CommonGetStr(this.moduleType);
	}

	public String getLogType ( ) {
		return CommonConvert.CommonGetStr(this.logType);
	}

	public String getMessage ( ) {
		return CommonConvert.CommonGetStr(this.message);
	}

	public String getCreateDate ( ) {
		return CommonConvert.CommonGetStr(this.createDate);
	}

	public boolean getIsError ( ) {
		return this.isError;
	}

	public String getCompName ( ) {
		return CommonConvert.CommonGetStr(this.compName);
	}
	/* Method Area */
}

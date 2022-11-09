package common.vo.interlock;

import javax.xml.bind.annotation.XmlRootElement;

import common.vo.common.CommonInterface.commonCode;

@XmlRootElement(name = "content")
public class InterlockNpInterfaceFormVO {
	private String resultCode = commonCode.EMPTYSTR;
	private String resultMessage = commonCode.EMPTYSTR;
	private String resultContent = commonCode.EMPTYSTR;

	public String getResultCode() {
		return resultCode;
	}

	public void setResultCode(String resultCode) {
		this.resultCode = resultCode;
	}

	public String getResultMessage() {
		return resultMessage;
	}

	public void setResultMessage(String resultMessage) {
		this.resultMessage = resultMessage;
	}

	public String getResultContent() {
		return resultContent;
	}

	public void setResultContent(String resultContent) {
		this.resultContent = resultContent;
	}
}

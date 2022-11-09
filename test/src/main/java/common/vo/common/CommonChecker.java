package common.vo.common;

public class CommonChecker {
    private String callUrl = ""; /* 호출 URL */
    private String resultCode = ""; /* 반환 코드 */
    private String resultMessage = ""; /* 반환 메시지 */

    public String getCallUrl() {
        return callUrl;
    }

    public void setCallUrl(String callUrl) {
        this.callUrl = callUrl;
    }

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

    @Override
    public String toString() {
        return "CommonChecker [callUrl=" + callUrl + ", resultCode=" + resultCode + ", resultMessage=" + resultMessage + "]";
    }

}

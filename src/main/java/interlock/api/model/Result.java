package interlock.api.model;

import java.util.HashMap;
import java.util.Map;

public class Result {

    /**
     * 반환 코드
     */
    private String resultCode = "";

    /**
     * 반환 메시지
     */
    private String resultMessage = "";

    /**
     * 에러내용
     */
    private String Exception = "";

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

    public String getException() {
        return Exception;
    }

    public void setException(String exception) {
        Exception = exception;
    }

    public Map<String, Object> getMap() {
        Map<String, Object> res = new HashMap<String, Object>();
        res.put("resultCode", this.getResultCode());
        res.put("resultMessage", this.getResultMessage());
        res.put("exception", this.getException());

        return res;
    }

    @Override
    public String toString() {
        return "Result [resultCode=" + resultCode + ", resultMessage=" + resultMessage + ", Exception=" + Exception + "]";
    }
}

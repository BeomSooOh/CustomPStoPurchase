package exception;

@SuppressWarnings("serial")
public class ExceptionNotConnectERP extends Exception {

    /**
     * ERP 연동 미설정 오류 정의
     */
    public ExceptionNotConnectERP() {
        super("ERP 연동설정이 진행되지 않았습니다.");
    }

    /**
     * ERP 연동 미설정 오류 정의
     *
     * @param Message : 에러 메시
     */
    public ExceptionNotConnectERP(String message) {
        super(message);
    }
}

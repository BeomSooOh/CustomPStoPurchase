package exception;

@SuppressWarnings("serial")
public class ExceptionNotFoundLoginSession extends Exception {
    /**
     * Login session 확인 불가 오류
     */
    public ExceptionNotFoundLoginSession() {
        super("Login session 정보를 확인할 수 없습니다.");
    }

    /**
     * Login session 확인 불가 오류
     *
     * @param Message : 에러 메시
     */
    public ExceptionNotFoundLoginSession(String message) {
        super(message);
    }
}

package exception;

@SuppressWarnings("serial")
public class ExceptionCheckAuthorityAdmin extends Exception {
    /**
     * 사용자 권한 오류 정의
     */
    public ExceptionCheckAuthorityAdmin() {
        super("현재 권한이 일치하지 않습니다. 해당 기능은 관리자 권한 기능입니다.");
    }

    /**
     * ERP 연동 미설정 오류 정의
     *
     * @param Message : 에러 메시
     */
    public ExceptionCheckAuthorityAdmin(String message) {
        super(message);
    }
}

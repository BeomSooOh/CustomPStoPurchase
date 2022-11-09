package exception;

public enum ExceptionType {
    
    /**
     * 정의되지 않은 오류
     */
    EXCEPTION("Exception")
    /**
     * ERP 연결정보 확인 불가 오류
     */
    , NOT_CONNECT_ERP("ExceptionNotConnectERP")
    /**
     * 로그인 정보 확인 불가 오류
     */
    , NOT_FOUND_LOGIN_SESSION("ExceptionNotFoundLoginSession");

    private String exceptionType;

    ExceptionType(String exceptionType) {
        this.exceptionType = exceptionType;
    }

    @Override
    public String toString() {
        return exceptionType;
    }
}

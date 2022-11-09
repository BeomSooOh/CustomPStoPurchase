package common.vo.ex;

/**
 * 매입세금계산서 권환 VO 
 * Created by Kwon Oh Gwang on 2019-08-05.
 */
public class ExCodeETaxAuthVO {
	private String compSeq; //회사시퀀
	private String authType; //권한타입(P:거래처, E:이메일)
	private String code; //대상코드(사업자등록번호 또는 이메일주소)
	
	public String getCompSeq() {
		return compSeq;
	}
	public void setCompSeq(String compSeq) {
		this.compSeq = compSeq;
	}
	public String getAuthType() {
		return authType;
	}
	public void setAuthType(String authType) {
		this.authType = authType;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	
	@Override
	public String toString() {
		return "ExCodeETaxAuthVO [compSeq=" + compSeq + 
				               ", authType=" + authType + 
				               ", code=" + code + "]";
	}
}

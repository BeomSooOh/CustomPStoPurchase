package common.vo.ex;
import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;

public class ExAttachVO {
	// CommonEX >> var ExCodeAcct 동일
	private String type = commonCode.EMPTYSTR; /*  첨부파일을 업로드한 모듈  */
	private String expend_seq = commonCode.EMPTYSEQ; /* 지출결의 시퀀스 */
	private String list_seq = commonCode.EMPTYSEQ; /* 지출결의 항목 시퀀스 */
	private String slip_seq = commonCode.EMPTYSEQ; /* 지출결의 항목 시퀀스 */
	private String file_seq = commonCode.EMPTYSEQ; /* 지출결의 파일 시퀀스 */
	private String create_seq = commonCode.EMPTYSEQ;/* 지출결의 파일 생성자 */
	private String create_date =  commonCode.EMPTYSTR;/* 지출결의 생성일자 */
	private String modify_seq = commonCode.EMPTYSEQ;/* 지출결의 파일 수정자 */
	private String modify_date =  commonCode.EMPTYSTR;/* 지출결의 파일 수정일자 */
	private String file_sn =  commonCode.EMPTYSEQ;/* 지출결의 파일 순번 */
	private String file_absol_path =  commonCode.EMPTYSTR;/* 지출결의 서버 내 파일절대경로 */
	private String file_size =  commonCode.EMPTYSTR;/* 지출결의 파일 크기 */
	private String file_name = commonCode.EMPTYSTR; /* 지출결의 파일 이름*/
	private String file_thum = commonCode.EMPTYSTR; /* 지출결의 파일 썸네일*/

	public String getType() {
		return CommonConvert.CommonGetStr(type);
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getExpend_seq() {
		return CommonConvert.CommonGetStr(expend_seq);
	}
	public void setExpend_seq(String expendSeq) {
		this.expend_seq = expendSeq;
	}
	public String getList_seq() {
		return CommonConvert.CommonGetStr(list_seq);
	}
	public void setList_seq(String listSeq) {
		this.list_seq = listSeq;
	}
	public String getSlip_seq() {
		return CommonConvert.CommonGetStr(slip_seq);
	}
	public void setSlip_seq(String slipSeq) {
		this.slip_seq = slipSeq;
	}
	public String getFile_seq() {
		return CommonConvert.CommonGetStr(file_seq);
	}
	public void setFile_seq(String fileSeq) {
		this.file_seq = fileSeq;
	}

	public String getCreate_seq() {
		return CommonConvert.CommonGetStr(create_seq);
	}
	public void setCreate_seq(String createSeq) {
		this.create_seq = createSeq;
	}
	public String getCreate_date() {
		return CommonConvert.CommonGetStr(create_date);
	}
	public void setCreate_date(String createDate) {
		this.create_date = createDate;
	}
	public String getModify_seq() {
		return CommonConvert.CommonGetStr(modify_seq);
	}
	public void setModify_seq(String modifySeq) {
		this.modify_seq = modifySeq;
	}
	public String getModify_date() {
		return CommonConvert.CommonGetStr(modify_date);
	}
	public void setModify_date(String modifyDate) {
		this.modify_date = modifyDate;
	}
	public String getFile_sn() {
		return CommonConvert.CommonGetStr(file_sn);
	}
	public void setFile_sn(String fileSn) {
		this.file_sn = fileSn;
	}
	public String getFile_absol_path() {
		return CommonConvert.CommonGetStr(file_absol_path);
	}
	public void setFile_absol_path(String fileAbsolPath) {
		this.file_absol_path = fileAbsolPath;
	}
	public String getFile_size() {
		return CommonConvert.CommonGetStr(file_size);
	}
	public void setFile_size(String fileSize) {
		this.file_size = fileSize;
	}
	public String getFile_name() {
		return CommonConvert.CommonGetStr(file_name);
	}
	public void setFile_name(String fileName) {
		this.file_name = fileName;
	}
	public String getFile_thum() {
		return CommonConvert.CommonGetStr(file_thum);
	}
	public void setFile_thum(String fileThum) {
		this.file_thum = fileThum;
	}
	@Override
	public String toString ( ) {
		return "ExAttachVO [type=" + type + ", expend_seq=" + expend_seq + ", list_seq=" + list_seq + ", slip_seq=" + slip_seq + ", file_seq=" + file_seq +", create_seq=" +create_seq+", create_date=" +create_date+	", modify_seq=" +modify_seq+ ", modify_date=" +modify_date+", file_sn=" +file_sn+", file_absol_path=" +file_absol_path+", file_size=" +file_size+", file_name="+file_name+", file_thum="+file_thum+"]";
	}

	/* 멤버 변수 초기화 */
	public void InitValue(){
		 type = commonCode.EMPTYSTR; /*  첨부파일을 업로드한 모듈  */
		 expend_seq = commonCode.EMPTYSEQ; /* 지출결의 시퀀스 */
		 list_seq = commonCode.EMPTYSEQ; /* 지출결의 항목 시퀀스 */
		 slip_seq = commonCode.EMPTYSEQ; /* 지출결의 항목 시퀀스 */
		 file_seq = commonCode.EMPTYSEQ; /* 지출결의 파일 시퀀스 */
		 create_seq = commonCode.EMPTYSEQ;/* 지출결의 파일 생성자 */
		 create_date =  commonCode.EMPTYSTR;/* 지출결의 생성일자 */
		 modify_seq = commonCode.EMPTYSEQ;/* 지출결의 파일 수정자 */
		 modify_date =  commonCode.EMPTYSTR;/* 지출결의 파일 수정일자 */
		 file_sn =  commonCode.EMPTYSEQ;/* 지출결의 파일 순번 */
		 file_absol_path =  commonCode.EMPTYSTR;/* 지출결의 서버 내 파일절대경로 */
		 file_size =  commonCode.EMPTYSTR;/* 지출결의 파일 크기 */
	}
}

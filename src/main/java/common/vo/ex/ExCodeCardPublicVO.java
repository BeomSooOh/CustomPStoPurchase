package common.vo.ex;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;

public class ExCodeCardPublicVO {

	private String comp_seq = commonCode.EMPTYSTR; /* 회사 시퀀스 */
	private String card_num = commonCode.EMPTYSTR; /* 카드번호 */
	private String org_div = commonCode.EMPTYSTR; /* 조직도 구분 */
	private String org_id = commonCode.EMPTYSTR; /* 조직도 시퀀스 */
	private String create_seq = commonCode.EMPTYSTR; /* 최초 생성자 */
	private String modify_seq = commonCode.EMPTYSTR; /* 최종 수정자 */

	public String getComp_seq ( ) {
		return CommonConvert.CommonGetStr(comp_seq);
	}

	public void setComp_seq ( String compSeq ) {
		this.comp_seq = compSeq;
	}

	public String getCard_num ( ) {
		return CommonConvert.CommonGetStr(card_num);
	}

	public void setCard_num ( String cardNum ) {
		this.card_num = cardNum;
	}

	public String getOrg_div ( ) {
		return CommonConvert.CommonGetStr(org_div);
	}

	public void setOrg_div ( String orgDiv ) {
		this.org_div = orgDiv;
	}

	public String getOrg_id ( ) {
		return CommonConvert.CommonGetStr(org_id);
	}

	public void setOrg_id ( String orgId ) {
		this.org_id = orgId;
	}

	public String getCreate_seq ( ) {
		return CommonConvert.CommonGetStr(create_seq);
	}

	public void setCreate_seq ( String createSeq ) {
		this.create_seq = createSeq;
	}

	public String getModify_seq ( ) {
		return CommonConvert.CommonGetStr(modify_seq);
	}

	public void setModify_seq ( String modifySeq ) {
		this.modify_seq = modifySeq;
	}

	@Override
	public String toString ( ) {
		return "ExCodeCardPublicVO [comp_seq=" + comp_seq + ", card_num=" + card_num + ", org_div=" + org_div + ", org_id=" + org_id + ", create_seq=" + create_seq + ", modify_seq=" + modify_seq + "]";
	}
}

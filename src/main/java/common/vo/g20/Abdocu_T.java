package common.vo.g20;

import common.vo.common.CommonInterface.commonCode;

/**
 *
 * @title Abdocu_T.java
 * @author doban7
 *
 * @date 2016. 9. 7.
 */
public class Abdocu_T {

	private String wd_am = commonCode.EMPTYSTR;
	private String vat_am = commonCode.EMPTYSTR;
	private String unit_am = commonCode.EMPTYSTR;
	private String tran_cd = commonCode.EMPTYSTR;
	private String tr_nm = commonCode.EMPTYSTR;
	private String tr_cd = commonCode.EMPTYSTR;
	private String tel = commonCode.EMPTYSTR;
	private String tax_dt = commonCode.EMPTYSTR;
	private String sup_am = commonCode.EMPTYSTR;
	private String sessionid = commonCode.EMPTYSTR;
	private String rstx_am = commonCode.EMPTYSTR;
	private String rmk_dc = commonCode.EMPTYSTR;
	private String reg_nb = commonCode.EMPTYSTR;
	private String ref_abin_ln_no = commonCode.EMPTYSTR;
	private String ndep_am = commonCode.EMPTYSTR;
	private String modify_id = commonCode.EMPTYSTR;
	private String modify_dt = commonCode.EMPTYSTR;
	private String link_type = commonCode.EMPTYSTR;
	private String jiro_nm = commonCode.EMPTYSTR;
	private String jiro_cd = commonCode.EMPTYSTR;
	private String it_use_no = commonCode.EMPTYSTR;
	private String it_use_dt = commonCode.EMPTYSTR;
	private String it_card_no = commonCode.EMPTYSTR;
	private String iss_sq = commonCode.EMPTYSTR;
	private String iss_dt = commonCode.EMPTYSTR;
	private String intx_am = commonCode.EMPTYSTR;
	private String insert_id = commonCode.EMPTYSTR;
	private String insert_dt = commonCode.EMPTYSTR;
	private String inad_am = commonCode.EMPTYSTR;
	private String etcrvrs_ym = commonCode.EMPTYSTR;
	private String etcdummy1 = commonCode.EMPTYSTR;
	private String etcdummy1_nm = commonCode.EMPTYSTR;
	private String etcdata_cd = commonCode.EMPTYSTR;
	private String etcdiv_cd = commonCode.EMPTYSTR;
	private String et_yn = commonCode.EMPTYSTR;
	private String erp_ln_sq = commonCode.EMPTYSTR;
	private String erp_isu_sq = commonCode.EMPTYSTR;
	private String erp_isu_dt = commonCode.EMPTYSTR;
	private String erp_co_cd = commonCode.EMPTYSTR;
	private String erp_bq_sq = commonCode.EMPTYSTR;
	private String edit_proc = commonCode.EMPTYSTR;
	private String docu_mode = commonCode.EMPTYSTR;
	private String depositor = commonCode.EMPTYSTR;
	private String ctr_nm = commonCode.EMPTYSTR;
	private String ctr_cd = commonCode.EMPTYSTR;
	private String ctr_appdt = commonCode.EMPTYSTR;
	private String cms_name = commonCode.EMPTYSTR;
	private String chain_name = commonCode.EMPTYSTR;
	private String ceo_nm = commonCode.EMPTYSTR;
	private String btr_nm = commonCode.EMPTYSTR;
	private String btr_cd = commonCode.EMPTYSTR;
	private String bk_sq2 = commonCode.EMPTYSTR;
	private String bk_sq = commonCode.EMPTYSTR;
	private String bank_sq = commonCode.EMPTYSTR;
	private String bank_dt = commonCode.EMPTYSTR;
	private String ba_nb = commonCode.EMPTYSTR;
	private String abdocu_no_reffer = commonCode.EMPTYSTR;
	private String abdocu_t_no = commonCode.EMPTYSTR;
	private String abdocu_no = commonCode.EMPTYSTR;
	private String abdocu_b_no = commonCode.EMPTYSTR;
	private String erp_emp_cd = commonCode.EMPTYSTR;
	private String item_nm = commonCode.EMPTYSTR;
	private String item_cnt = commonCode.EMPTYSTR;
	private String item_am = commonCode.EMPTYSTR;
	private String emp_nm = commonCode.EMPTYSTR;
	private String tr_fg = commonCode.EMPTYSTR;
	private String tr_fg_nm = commonCode.EMPTYSTR;
	private String attr_nm = commonCode.EMPTYSTR;
	private String ppl_nb = commonCode.EMPTYSTR;
	private String addr = commonCode.EMPTYSTR;
	private String trcharge_emp = commonCode.EMPTYSTR;
	// 필요경비율
	private String etcrate = commonCode.EMPTYSTR;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	private String ctr_card_num = commonCode.EMPTYSTR;
	private String ctr_card_k_nm = commonCode.EMPTYSTR;

	public String getErp_emp_cd ( ) {
		return erp_emp_cd;
	}

	public String getTr_fg ( ) {
		return tr_fg;
	}

	public void setTr_fg ( String trFg ) {
		this.tr_fg = trFg;
	}

	public String getTr_fg_nm ( ) {
		return tr_fg_nm;
	}

	public void setTr_fg_nm ( String trFgNm ) {
		this.tr_fg_nm = trFgNm;
	}

	public String getAttr_nm ( ) {
		return attr_nm;
	}

	public void setAttr_nm ( String attrNm ) {
		this.attr_nm = attrNm;
	}

	public String getPpl_nb ( ) {
		return ppl_nb;
	}

	public void setPpl_nb ( String pplNb ) {
		this.ppl_nb = pplNb;
	}

	public String getAddr ( ) {
		return addr;
	}

	public void setAddr ( String addr ) {
		this.addr = addr;
	}

	public String getTrcharge_emp ( ) {
		return trcharge_emp;
	}

	public void setTrcharge_emp ( String trchargeEmp ) {
		this.trcharge_emp = trchargeEmp;
	}

	public String getAbdocu_no_reffer ( ) {
		return abdocu_no_reffer;
	}

	public void setAbdocu_no_reffer ( String abdocuNoReffer ) {
		this.abdocu_no_reffer = abdocuNoReffer;
	}

	public String getItem_cnt ( ) {
		return item_cnt;
	}

	public void setItem_cnt ( String itemCnt ) {
		this.item_cnt = itemCnt;
	}

	public String getItem_am ( ) {
		return item_am;
	}

	public void setItem_am ( String itemAm ) {
		this.item_am = itemAm;
	}

	public String getEmp_nm ( ) {
		return emp_nm;
	}

	public void setEmp_nm ( String empNm ) {
		this.emp_nm = empNm;
	}

	public String getItem_nm ( ) {
		return item_nm;
	}

	public void setItem_nm ( String itemNm ) {
		this.item_nm = itemNm;
	}

	public void setErp_emp_cd ( String erpEmpCd ) {
		this.erp_emp_cd = erpEmpCd;
	}

	public String getWd_am ( ) {
		return wd_am;
	}

	public void setWd_am ( String wdAm ) {
		this.wd_am = wdAm;
	}

	public String getVat_am ( ) {
		return vat_am;
	}

	public void setVat_am ( String vatAm ) {
		this.vat_am = vatAm;
	}

	public String getUnit_am ( ) {
		return unit_am;
	}

	public void setUnit_am ( String unitAm ) {
		this.unit_am = unitAm;
	}

	public String getTran_cd ( ) {
		return tran_cd;
	}

	public void setTran_cd ( String tranCd ) {
		this.tran_cd = tranCd;
	}

	public String getTr_nm ( ) {
		return tr_nm;
	}

	public void setTr_nm ( String trNm ) {
		this.tr_nm = trNm;
	}

	public String getTr_cd ( ) {
		return tr_cd;
	}

	public void setTr_cd ( String trCd ) {
		this.tr_cd = trCd;
	}

	public String getTel ( ) {
		return tel;
	}

	public void setTel ( String tel ) {
		this.tel = tel;
	}

	public String getTax_dt ( ) {
		return tax_dt;
	}

	public void setTax_dt ( String taxDt ) {
		this.tax_dt = taxDt;
	}

	public String getSup_am ( ) {
		return sup_am;
	}

	public void setSup_am ( String supAm ) {
		this.sup_am = supAm;
	}

	public String getSessionid ( ) {
		return sessionid;
	}

	public void setSessionid ( String sessionid ) {
		this.sessionid = sessionid;
	}

	public String getRstx_am ( ) {
		return rstx_am;
	}

	public void setRstx_am ( String rstxAm ) {
		this.rstx_am = rstxAm;
	}

	public String getRmk_dc ( ) {
		return rmk_dc;
	}

	public void setRmk_dc ( String rmkDc ) {
		this.rmk_dc = rmkDc;
	}

	public String getReg_nb ( ) {
		return reg_nb;
	}

	public void setReg_nb ( String regNb ) {
		this.reg_nb = regNb;
	}

	public String getRef_abin_ln_no ( ) {
		return ref_abin_ln_no;
	}

	public void setRef_abin_ln_no ( String refAbinLnNo ) {
		this.ref_abin_ln_no = refAbinLnNo;
	}

	public String getNdep_am ( ) {
		return ndep_am;
	}

	public void setNdep_am ( String ndepAm ) {
		this.ndep_am = ndepAm;
	}

	public String getModify_id ( ) {
		return modify_id;
	}

	public void setModify_id ( String modifyId ) {
		this.modify_id = modifyId;
	}

	public String getModify_dt ( ) {
		return modify_dt;
	}

	public void setModify_dt ( String modifyDt ) {
		this.modify_dt = modifyDt;
	}

	public String getLink_type ( ) {
		return link_type;
	}

	public void setLink_type ( String linkType ) {
		this.link_type = linkType;
	}

	public String getJiro_nm ( ) {
		return jiro_nm;
	}

	public void setJiro_nm ( String jiroNm ) {
		this.jiro_nm = jiroNm;
	}

	public String getJiro_cd ( ) {
		return jiro_cd;
	}

	public void setJiro_cd ( String jiroCd ) {
		this.jiro_cd = jiroCd;
	}

	public String getIt_use_no ( ) {
		return it_use_no;
	}

	public void setIt_use_no ( String itUseNo ) {
		this.it_use_no = itUseNo;
	}

	public String getIt_use_dt ( ) {
		return it_use_dt;
	}

	public void setIt_use_dt ( String itUseDt ) {
		this.it_use_dt = itUseDt;
	}

	public String getIt_card_no ( ) {
		return it_card_no;
	}

	public void setIt_card_no ( String itCardNo ) {
		this.it_card_no = itCardNo;
	}

	public String getIss_sq ( ) {
		return iss_sq;
	}

	public void setIss_sq ( String issSq ) {
		this.iss_sq = issSq;
	}

	public String getIss_dt ( ) {
		return iss_dt;
	}

	public void setIss_dt ( String issDt ) {
		this.iss_dt = issDt;
	}

	public String getIntx_am ( ) {
		return intx_am;
	}

	public void setIntx_am ( String intxAm ) {
		this.intx_am = intxAm;
	}

	public String getInsert_id ( ) {
		return insert_id;
	}

	public void setInsert_id ( String insertId ) {
		this.insert_id = insertId;
	}

	public String getInsert_dt ( ) {
		return insert_dt;
	}

	public void setInsert_dt ( String insertDt ) {
		this.insert_dt = insertDt;
	}

	public String getInad_am ( ) {
		return inad_am;
	}

	public void setInad_am ( String inadAm ) {
		this.inad_am = inadAm;
	}

	public String getEtcrvrs_ym ( ) {
		return etcrvrs_ym;
	}

	public void setEtcrvrs_ym ( String etcrvrsYm ) {
		this.etcrvrs_ym = etcrvrsYm;
	}

	public String getEtcdummy1 ( ) {
		return etcdummy1;
	}

	public void setEtcdummy1 ( String etcdummy1 ) {
		this.etcdummy1 = etcdummy1;
	}

	public String getEtcdata_cd ( ) {
		return etcdata_cd;
	}

	public void setEtcdata_cd ( String etcdataCd ) {
		this.etcdata_cd = etcdataCd;
	}

	public String getEtcdiv_cd ( ) {
		return etcdiv_cd;
	}

	public void setEtcdiv_cd ( String etcdivCd ) {
		this.etcdiv_cd = etcdivCd;
	}

	public String getEt_yn ( ) {
		return et_yn;
	}

	public void setEt_yn ( String etYn ) {
		this.et_yn = etYn;
	}

	public String getErp_ln_sq ( ) {
		return erp_ln_sq;
	}

	public void setErp_ln_sq ( String erpLnSq ) {
		this.erp_ln_sq = erpLnSq;
	}

	public String getErp_isu_sq ( ) {
		return erp_isu_sq;
	}

	public void setErp_isu_sq ( String erpIsuSq ) {
		this.erp_isu_sq = erpIsuSq;
	}

	public String getErp_isu_dt ( ) {
		return erp_isu_dt;
	}

	public void setErp_isu_dt ( String erpIsuDt ) {
		this.erp_isu_dt = erpIsuDt;
	}

	public String getErp_co_cd ( ) {
		return erp_co_cd;
	}

	public void setErp_co_cd ( String erpCoCd ) {
		this.erp_co_cd = erpCoCd;
	}

	public String getErp_bq_sq ( ) {
		return erp_bq_sq;
	}

	public void setErp_bq_sq ( String erpBqSq ) {
		this.erp_bq_sq = erpBqSq;
	}

	public String getEdit_proc ( ) {
		return edit_proc;
	}

	public void setEdit_proc ( String editProc ) {
		this.edit_proc = editProc;
	}

	public String getDocu_mode ( ) {
		return docu_mode;
	}

	public void setDocu_mode ( String docuMode ) {
		this.docu_mode = docuMode;
	}

	public String getDepositor ( ) {
		return depositor;
	}

	public void setDepositor ( String depositor ) {
		this.depositor = depositor;
	}

	public String getCtr_nm ( ) {
		return ctr_nm;
	}

	public void setCtr_nm ( String ctrNm ) {
		this.ctr_nm = ctrNm;
	}

	public String getCtr_cd ( ) {
		return ctr_cd;
	}

	public void setCtr_cd ( String ctrCd ) {
		this.ctr_cd = ctrCd;
	}

	public String getCtr_appdt ( ) {
		return ctr_appdt;
	}

	public void setCtr_appdt ( String ctrAppdt ) {
		this.ctr_appdt = ctrAppdt;
	}

	public String getCms_name ( ) {
		return cms_name;
	}

	public void setCms_name ( String cmsName ) {
		this.cms_name = cmsName;
	}

	public String getChain_name ( ) {
		return chain_name;
	}

	public void setChain_name ( String chainName ) {
		this.chain_name = chainName;
	}

	public String getCeo_nm ( ) {
		return ceo_nm;
	}

	public void setCeo_nm ( String ceoNm ) {
		this.ceo_nm = ceoNm;
	}

	public String getBtr_nm ( ) {
		return btr_nm;
	}

	public void setBtr_nm ( String btrNm ) {
		this.btr_nm = btrNm;
	}

	public String getBtr_cd ( ) {
		return btr_cd;
	}

	public void setBtr_cd ( String btrCd ) {
		this.btr_cd = btrCd;
	}

	public String getBk_sq2 ( ) {
		return bk_sq2;
	}

	public void setBk_sq2 ( String bkSq2 ) {
		this.bk_sq2 = bkSq2;
	}

	public String getBk_sq ( ) {
		return bk_sq;
	}

	public void setBk_sq ( String bkSq ) {
		this.bk_sq = bkSq;
	}

	public String getBank_sq ( ) {
		return bank_sq;
	}

	public void setBank_sq ( String bankSq ) {
		this.bank_sq = bankSq;
	}

	public String getBank_dt ( ) {
		return bank_dt;
	}

	public void setBank_dt ( String bankDt ) {
		this.bank_dt = bankDt;
	}

	public String getBa_nb ( ) {
		return ba_nb;
	}

	public void setBa_nb ( String baNb ) {
		this.ba_nb = baNb;
	}

	public String getAbdocu_t_no ( ) {
		return abdocu_t_no;
	}

	public void setAbdocu_t_no ( String abdocuTNo ) {
		this.abdocu_t_no = abdocuTNo;
	}

	public String getAbdocu_no ( ) {
		return abdocu_no;
	}

	public void setAbdocu_no ( String abdocuNo ) {
		this.abdocu_no = abdocuNo;
	}

	public String getAbdocu_b_no ( ) {
		return abdocu_b_no;
	}

	public void setAbdocu_b_no ( String abdocuBNo ) {
		this.abdocu_b_no = abdocuBNo;
	}

	public String getEtcrate ( ) {
		return etcrate;
	}

	public void setEtcrate ( String etcrate ) {
		this.etcrate = etcrate;
	}

	public String getCtr_card_num ( ) {
		return ctr_card_num;
	}

	public void setCtr_card_num ( String ctrCardNum ) {
		this.ctr_card_num = ctrCardNum;
	}

	public String getEtcdummy1_nm ( ) {
		return etcdummy1_nm;
	}

	public void setEtcdummy1_nm ( String etcdummy1Nm ) {
		this.etcdummy1_nm = etcdummy1Nm;
	}

	public String getCtr_card_k_nm ( ) {
		return ctr_card_k_nm;
	}

	public void setCtr_card_k_nm ( String ctrCardKNm ) {
		this.ctr_card_k_nm = ctrCardKNm;
	}
}

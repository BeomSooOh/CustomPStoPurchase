package common.vo.batch;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;


public class CommonBatchCmsConfigVO {

	public String compSeq = commonCode.EMPTYSEQ;
	public String cmsSyncYN = commonCode.EMPTYNO;
	public String cmsBatchYN = commonCode.EMPTYNO;
	public String cmsProcessYN = commonCode.EMPTYNO;
	public String customYN = commonCode.EMPTYNO;
	public String cmsBaseDate = commonCode.EMPTYSTR;
	public String cmsBaseDay = commonCode.EMPTYSEQ;
	public String runYN = commonCode.EMPTYNO;
	public String serverIp = commonCode.EMPTYSTR;
	public String allCompSyncYN = commonCode.EMPTYYES;
	public String customNewTypeYN = commonCode.EMPTYNO;
	public String modifyDate = commonCode.EMPTYSTR;
	
	public String getCompSeq ( ) {
		return CommonConvert.CommonGetStr(compSeq);
	}

	public void setCompSeq ( String compSeq ) {
		this.compSeq = compSeq;
	}

	public String getCmsSyncYN ( ) {
		return CommonConvert.CommonGetStr(cmsSyncYN);
	}

	public void setCmsSyncYN ( String cmsSyncYN ) {
		this.cmsSyncYN = cmsSyncYN;
	}

	public String getCmsBatchYN ( ) {
		return CommonConvert.CommonGetStr(cmsBatchYN);
	}

	public void setCmsBatchYN ( String cmsBatchYN ) {
		this.cmsBatchYN = cmsBatchYN;
	}

	public String getCmsProcessYN ( ) {
		return CommonConvert.CommonGetStr(cmsProcessYN);
	}

	public void setCmsProcessYN ( String cmsProcessYN ) {
		this.cmsProcessYN = cmsProcessYN;
	}

	public String getCustomYN ( ) {
		return CommonConvert.CommonGetStr(customYN);
	}

	public void setCustomYN ( String customYN ) {
		this.customYN = customYN;
	}
	
	public String getRunYN ( ) {
		return CommonConvert.CommonGetStr(runYN);
	}
	
	public void setRunYN ( String runYN ) {
		this.runYN = runYN;
	}

	public String getCmsBaseDate ( ) {
		return CommonConvert.CommonGetStr(cmsBaseDate);
	}

	public void setCmsBaseDate ( String cmsBaseDate ) {
		this.cmsBaseDate = cmsBaseDate;
	}

	public String getCmsBaseDay ( ) {
		return CommonConvert.CommonGetStr(cmsBaseDay);
	}

	public void setCmsBaseDay ( String cmsBaseDay ) {
		this.cmsBaseDay = cmsBaseDay;
	}

	public String getServerIp() {
		return CommonConvert.CommonGetStr(serverIp);
	}

	public void setServerIp( String serverIp) {
		this.serverIp = serverIp;
	}

	public String getAllCompSyncYN() { return CommonConvert.CommonGetStr(this.allCompSyncYN); }

	public void setAllCompSyncYN ( String allCompSyncYN ) { this.allCompSyncYN = allCompSyncYN; }

	public String getCustomNewTypeYN() { return CommonConvert.CommonGetStr(this.customNewTypeYN); }

	public void setCustomNewTypeYN ( String customNewTypeYN ) { this.customNewTypeYN = customNewTypeYN; }
	
	public String getModifyDate ( ) {
		return CommonConvert.CommonGetStr(modifyDate);
	}

	public void setModifyDate ( String modifyDate ) {
		this.modifyDate = modifyDate;
	}	

	@Override
	public String toString ( ) {
		return "CommonBatchCmsConfigVO [compSeq=" + compSeq + ", cmsSyncYN=" + cmsSyncYN + ", cmsBatchYN=" + cmsBatchYN + ", cmsProcessYN=" + cmsProcessYN + ", customYN=" + customYN + ", cmsBaseDate=" + cmsBaseDate + ", cmsBaseDay=" + cmsBaseDay + ", modifyDate=" + modifyDate + ", serverIp=" + serverIp + ", allCompSyncYN=" + allCompSyncYN + ", customNewTypeYN=" + customNewTypeYN + "]";
	}
}

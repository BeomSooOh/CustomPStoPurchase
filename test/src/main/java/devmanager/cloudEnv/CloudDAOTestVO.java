package devmanager.cloudEnv;

public class CloudDAOTestVO {
	private String groupSeq;
	private String compSeq;
	private String empSeq;
	
	CloudDAOTestVO(){
		groupSeq = "DEMO";
		compSeq = "CSB";
		empSeq = "JSD";
	}
	
	public String getGroupSeq ( ) {
		return groupSeq;
	}
	
	public void setGroupSeq ( String groupSeq ) {
		this.groupSeq = groupSeq;
	}
	
	public String getCompSeq ( ) {
		return compSeq;
	}
	
	public void setCompSeq ( String compSeq ) {
		this.compSeq = compSeq;
	}
	
	public String getEmpSeq ( ) {
		return empSeq;
	}
	
	public void setEmpSeq ( String empSeq ) {
		this.empSeq = empSeq;
	}
	
	
}
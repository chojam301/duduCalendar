package dudu.service;

public class ApprovalVO {
	public int appauto;
	public String appno;
	public String useremail;
	public String appfirst;
	public String appmiddle;
	public String appfinal;
	public String appdate;
	public String appenddate;
	public String appfilename;
	public String findfirst;
	public String findmiddle;
	public String findfinal;
	
	
	@Override
	public String toString() {
		return "ApprovalVO [appauto=" + appauto + ", appno=" + appno + ", useremail=" + useremail + ", appfirst="
				+ appfirst + ", appmiddle=" + appmiddle + ", appfinal=" + appfinal + ", appdate=" + appdate
				+ ", appenddate=" + appenddate + ", appfilename=" + appfilename + ", findfirst=" + findfirst
				+ ", findmiddle=" + findmiddle + ", findfinal=" + findfinal + ", apptitle=" + apptitle + ", appcnt="
				+ appcnt + ", appstatus=" + appstatus + ", appreason=" + appreason + ", appfile=" + appfile
				+ ", appref=" + appref + "]";
	}
	public String getFindfirst() {
		return findfirst;
	}
	public void setFindfirst(String findfirst) {
		this.findfirst = findfirst;
	}
	public String getFindmiddle() {
		return findmiddle;
	}
	public void setFindmiddle(String findmiddle) {
		this.findmiddle = findmiddle;
	}
	public String getFindfinal() {
		return findfinal;
	}
	public void setFindfinal(String findfinal) {
		this.findfinal = findfinal;
	}
	public String getAppfilename() {
		return appfilename;
	}
	public void setAppfilename(String approval_filename) {
		this.appfilename = approval_filename;
	}
	public String getAppenddate() {
		return appenddate;
	}
	public void setAppenddate(String appenddate) {
		this.appenddate = appenddate;
	}
	public String apptitle;
	public String appcnt;
	public String appstatus;
	public String appreason;
	public String appfile;
	public String appref;
	

	public int getAppauto() {
		return appauto;
	}
	public void setAppauto(int appauto) {
		this.appauto = appauto;
	}
	public String getAppno() {
		return appno;
	}
	public void setAppno(String appno) {
		this.appno = appno;
	}
	public String getUseremail() {
		return useremail;
	}
	public void setUseremail(String useremail) {
		this.useremail = useremail;
	}
	public String getAppfirst() {
		return appfirst;
	}
	public void setAppfirst(String appfirst) {
		this.appfirst = appfirst;
	}
	public String getAppmiddle() {
		return appmiddle;
	}
	public void setAppmiddle(String appmiddle) {
		this.appmiddle = appmiddle;
	}
	public String getAppfinal() {
		return appfinal;
	}
	public void setAppfinal(String appfinal) {
		this.appfinal = appfinal;
	}
	public String getAppdate() {
		return appdate;
	}
	public void setAppdate(String appdate) {
		this.appdate = appdate;
	}
	public String getApptitle() {
		return apptitle;
	}
	public void setApptitle(String apptitle) {
		this.apptitle = apptitle;
	}
	public String getAppcnt() {
		return appcnt;
	}
	public void setAppcnt(String appcnt) {
		this.appcnt = appcnt;
	}
	public String getAppstatus() {
		return appstatus;
	}
	public void setAppstatus(String appstatus) {
		this.appstatus = appstatus;
	}
	public String getAppreason() {
		return appreason;
	}
	public void setAppreason(String appreason) {
		this.appreason = appreason;
	}
	public String getAppfile() {
		return appfile;
	}
	public void setAppfile(String appfile) {
		this.appfile = appfile;
	}
	public String getAppref() {
		return appref;
	}
	public void setAppref(String appref) {
		this.appref = appref;
	}
	
	
}

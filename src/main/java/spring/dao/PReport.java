package spring.dao;

import java.time.LocalDateTime;

public class PReport {

	/*
	 * Bean for contains preport data
	 */
	
	//basic method
	private String resID;
	private String planID;
	private LocalDateTime startdate;
	private LocalDateTime enddate;
	private int passedQty;
	private int failedQty;
	private String empNo;
	
	public PReport(String resID, String planID, LocalDateTime startdate, LocalDateTime enddate, int passedQty,
			int failedQty, String empNo) {
		super();
		this.resID = resID;
		this.planID = planID;
		this.startdate = startdate;
		this.enddate = enddate;
		this.passedQty = passedQty;
		this.failedQty = failedQty;
		this.empNo = empNo;
	}

	public String getResID() {
		return resID;
	}

	public void setResID(String resID) {
		this.resID = resID;
	}

	public String getPlanID() {
		return planID;
	}

	public void setPlanID(String planID) {
		this.planID = planID;
	}

	public LocalDateTime getStartdate() {
		return startdate;
	}

	public void setStartdate(LocalDateTime startdate) {
		this.startdate = startdate;
	}

	public LocalDateTime getEnddate() {
		return enddate;
	}

	public void setEnddate(LocalDateTime enddate) {
		this.enddate = enddate;
	}

	public int getPassedQty() {
		return passedQty;
	}

	public void setPassedQty(int passedQty) {
		this.passedQty = passedQty;
	}

	public int getFailedQty() {
		return failedQty;
	}

	public void setFailedQty(int failedQty) {
		this.failedQty = failedQty;
	}

	public String getEmpNo() {
		return empNo;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	
}

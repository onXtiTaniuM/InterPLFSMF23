package spring.dao;

public class LOTprod {
	/*
	 * Bean for contains inventory(LOT) res product data
	 */
	
	//basic method
	private String lotNo;
	private String prodNo;
	private String serialNo;
	private String processid;
	private int cycleTime;
	private int status;
	
	public LOTprod(String lotno, String prodno, String serialno, String processid, int cycletime, int status) {
		this.lotNo = lotno;
		this.prodNo = prodno;
		this.serialNo = serialno;
		this.processid = processid;
		this.cycleTime = cycletime;
		this.status = status;
	}

	public String getLotNo() {
		return lotNo;
	}

	public void setLotNo(String lotNo) {
		this.lotNo = lotNo;
	}

	public String getProdNo() {
		return prodNo;
	}

	public void setProdNo(String prodNo) {
		this.prodNo = prodNo;
	}

	public String getSerialNo() {
		return serialNo;
	}

	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}

	public int getCycleTime() {
		return cycleTime;
	}

	public void setCycleTime(int cycleTime) {
		this.cycleTime = cycleTime;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getProcessid() {
		return processid;
	}

	public void setProcessid(String processid) {
		this.processid = processid;
	}
	
}

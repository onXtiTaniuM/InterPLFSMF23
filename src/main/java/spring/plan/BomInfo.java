package spring.plan;

public class BomInfo {
	
	//BOM
	private String prodNo;
	private String materNo;
	private String materPrNo;
	private int materQty;
	//material
	private String materName;
	private int materPrice;
	private String unit;
	//product	
	private String prodName;
	private String prodPrice;
	
	public String getProdNo() {
		return prodNo;
	}
	public void setProdNo(String prodNo) {
		this.prodNo = prodNo;
	}
	public String getMaterNo() {
		return materNo;
	}
	public void setMaterNo(String materNo) {
		this.materNo = materNo;
	}
	public String getMaterPrNo() {
		return materPrNo;
	}
	public void setMaterPrNo(String materPrNo) {
		this.materPrNo = materPrNo;
	}
	public int getMaterQty() {
		return materQty;
	}
	public void setMaterQty(int materQty) {
		this.materQty = materQty;
	}
	public String getMaterName() {
		return materName;
	}
	public void setMaterName(String materName) {
		this.materName = materName;
	}
	public int getMaterPrice() {
		return materPrice;
	}
	public void setMaterPrice(int materPrice) {
		this.materPrice = materPrice;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public String getProdName() {
		return prodName;
	}
	public void setProdName(String prodName) {
		this.prodName = prodName;
	}
	public String getProdPrice() {
		return prodPrice;
	}
	public void setProdPrice(String prodPrice) {
		this.prodPrice = prodPrice;
	}
}

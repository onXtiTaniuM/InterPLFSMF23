package spring.dao;

import java.time.LocalDateTime;

public class User {

	/*
	 * Bean for contains user data
	 */
	
	//basic method
	private Long userNo;
	private Long empNo;
	private String id;
	private String password;
	private String name;
	private String rank;
	private boolean admin;
	private LocalDateTime regiDate;
	
	public User(Long empno, 
			String id, 
			String password, 
			String name, 
			String rank, 
			boolean admin, 
			LocalDateTime regidate) {
		this.empNo = empno;
		this.id = id;
		this.password = password;
		this.name = name;
		this.rank = rank;
		this.admin = admin;
		this.regiDate = regidate;
	}
	
	public boolean matchPassword(String password) {
		// TODO Auto-generated method stub
		return false;
	}

	public Long getEmpNo() {
		return empNo;
	}

	public String getId() {
		return id;
	}

	public String getPassword() {
		return password;
	}

	public String getName() {
		return name;
	}

	public String getRank() {
		return rank;
	}

	public boolean isAdmin() {
		return admin;
	}

	public LocalDateTime getRegiDate() {
		return regiDate;
	}

	
	public void setUserNo(Long userNo) {
		this.userNo = userNo;
	}

	public Long getUserNo() {
		return userNo;
	}
	
}

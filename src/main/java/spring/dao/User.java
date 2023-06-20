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
	
	
	
	public boolean matchPassword(String password) {
		// TODO Auto-generated method stub
		return false;
	}

	public String getId() {
		// TODO Auto-generated method stub
		return null;
	}

	public String getEmail() {
		// TODO Auto-generated method stub
		return null;
	}

	public String getName() {
		// TODO Auto-generated method stub
		return null;
	}

	public boolean getAdmin() {
		// TODO Auto-generated method stub
		return false;
	}

}

package spring.manage;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import controller.manage.ManageUserCommand;
import spring.dao.PlanDao;
import spring.dao.User;
import spring.dao.UserDao;

public class ManageService {
	private UserDao userDao;
	private PlanDao planDao;
	
	public void setuserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	public void setplanDao(PlanDao planDao) {
		this.planDao = planDao;
	}

	public List<User> allUserList(){
		List<User> userlist = userDao.selectAll();
		return userlist;
	}
	
	public void insertUser(ManageUserCommand newUser) {
		userDao.insertUser(newUser);
	}
	
	public String userAdminString(User user) {
		if(user.isAdmin()) {
			return "true";
		}else {
			return "false";
		}
	}
	
	public String userRegiDate(User user) {
		String regidate;
		LocalDateTime userDate = user.getRegiDate();
		
		regidate = userDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
		
		return regidate;
	}
	
	public boolean planNotification() {
		return planDao.planNotification();
	}
	
	public boolean idDuplicate(String id) {
		return (userDao.selectById(id) != null) ? true:false ;
	}
}

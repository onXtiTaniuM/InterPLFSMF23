package spring.manage;

import java.util.List;

import controller.manage.ManageUserCommand;
import spring.dao.User;
import spring.dao.UserDao;

public class ManageService {
	private UserDao userDao;
	
	public void setuserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	
	public List<User> allUserList(){
		List<User> userlist = userDao.selectAll();
		return userlist;
	}
	
	public void insertUser(ManageUserCommand newUser) {
		userDao.insertUser(newUser);
	}
	
}

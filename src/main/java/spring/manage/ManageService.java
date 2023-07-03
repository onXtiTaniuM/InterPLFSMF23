package spring.manage;

import java.util.List;

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
	
	
}

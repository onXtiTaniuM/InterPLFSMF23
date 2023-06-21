package spring.auth;

import exeptions.WrongIdPasswordException;
import spring.dao.User;
import spring.dao.UserDao;

public class AuthService {

	private UserDao userDao;

	public void setuserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	public AuthInfo authenticate(String id, String password) {
		User user = userDao.selectById(id);
		if (user == null) {
			throw new WrongIdPasswordException();
		}
		if (!user.matchPassword(password)) {
			throw new WrongIdPasswordException();
		}
		return new AuthInfo(user.getId(),
				user.getName(),
				user.isAdmin());
	}

}

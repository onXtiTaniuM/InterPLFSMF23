package spring.auth;

import exeptions.WrongIdPasswordException;
import spring.dao.User;
import spring.dao.UserDao;

public class AuthService {

	private UserDao userDao;

	public void setuserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	public AuthInfo authenticate(String email, String password) {
		User user = userDao.selectByEmail(email);
		if (user == null) {
			throw new WrongIdPasswordException();
		}
		if (!user.matchPassword(password)) {
			throw new WrongIdPasswordException();
		}
		return new AuthInfo(user.getId(),
				user.getEmail(),
				user.getName());
	}

}

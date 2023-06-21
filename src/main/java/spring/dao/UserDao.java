package spring.dao;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;

public class UserDao {

	/*
	 * Dao for user data
	 */
	
	private JdbcTemplate jdbcTemplate;

	public UserDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	public User selectByEmail(String email) {
		// TODO Auto-generated method stub
		return null;
	}

	public User selectById(String id) {
		// TODO Auto-generated method stub
		return null;
	}

}

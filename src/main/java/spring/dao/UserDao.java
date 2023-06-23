package spring.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;


public class UserDao {

	/*
	 * Dao for user data
	 */
	
	private JdbcTemplate jdbcTemplate;

	public UserDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	public User selectById(String id) {
		Object[] where = new Object[] {id};
		List<User> results = jdbcTemplate.query(
				"select * from e_user where id = ?", where,
				new RowMapper<User>() {
					@Override
					public User mapRow(ResultSet rs, int rowNum) throws SQLException {
						User user = new User(
								rs.getLong("empno"),
								rs.getString("id"),
								rs.getString("pw"),
								rs.getString("name"),
								rs.getString("rank"),
								(1 == rs.getLong("admin")),
								rs.getTimestamp("regidate").toLocalDateTime());
						user.setuserNo(rs.getLong("userNo"));
						return user;
					}
				});
		return results.isEmpty() ? null : results.get(0);
	}

}

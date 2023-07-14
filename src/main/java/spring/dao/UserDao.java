package spring.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;

import controller.manage.ManageUserCommand;


public class UserDao {

	/*
	 * Dao for user data
	 */
	
	private JdbcTemplate jdbcTemplate;

	public UserDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	public User selectById(String id) { //ID로 User 조회
		Object[] where = new Object[] {id};
		List<User> results = jdbcTemplate.query(
				"select * from e_user where id = ?", where,
				new RowMapper<User>() {
					@Override
					public User mapRow(ResultSet rs, int rowNum) throws SQLException {
						User user = new User(
								rs.getString("empno"),
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
	
	public List<User> selectAll() { //User 전체 조회
		List<User> results = jdbcTemplate.query(
				"select * from e_user", 
				new RowMapper<User>() {
					@Override
					public User mapRow(ResultSet rs, int rowNum) throws SQLException {
						User user = new User(
								rs.getString("empno"),
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
		
		return results;
	}
	
	public void insertUser(ManageUserCommand user) { //신규 User 입력
		jdbcTemplate.update(new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement pstmt = con.prepareStatement(
						"insert into e_user (userno, empno, name, id, pw, rank) " +
						"values (user_seq.NEXTVAL, ?, ?, ?, ?, ?)");
				pstmt.setString(1, user.getEmpNo());
				pstmt.setString(2, user.getName());
				pstmt.setString(3, user.getId());
				pstmt.setString(4, user.getPassword());
				pstmt.setString(5, user.getRank());
				return pstmt;
			}
		});
	}
	
	public User selectIdPwMatch(String id, String pw) { //ID, PW 공통 조회
		Object[] where = new Object[] {id, pw};
		List<User> results = jdbcTemplate.query(
				"select * from e_user where id = ? and pw = ?", where,
				new RowMapper<User>() {
					@Override
					public User mapRow(ResultSet rs, int rowNum) throws SQLException {
						User user = new User(
								rs.getString("empno"),
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
	
	public void updatePassword(String id, String pw) { //PW 변경
		jdbcTemplate.update(
				"update e_user set pw = ? where id = ?", pw, id);
	}
	
	public void updateUser(String id) { //정보 변경
		jdbcTemplate.update(
				"update e_user set empno = ?, pw = ?, rank = ?, admin = ? where id = ?", id);
	}
	
	public List<String> rankList() { //등록된 Rank 전체 조회
		List<String> results = jdbcTemplate.query(
				"select distinct rank from e_user", 
				new RowMapper<String>() {
					@Override
					public String mapRow(ResultSet rs, int rowNum) throws SQLException {
						return rs.getString("rank");
					}
				});
		return results;
	}
	
	public void deleteUser(String id) { //사용자 삭제
		jdbcTemplate.update(
				"delete from e_user where id = ?", id);
	}

}

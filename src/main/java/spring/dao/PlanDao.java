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

public class PlanDao {

	private JdbcTemplate jdbcTemplate;

	public PlanDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	public boolean planNotification() { //계획 결제 확인
		int needCheckP = jdbcTemplate.queryForObject(
				"SELECT count(*) FROM PROCESS_PLAN WHERE CHECK_YN = 'N'",
					Integer.class);
		return needCheckP != 0 ? true : false;
	}
}

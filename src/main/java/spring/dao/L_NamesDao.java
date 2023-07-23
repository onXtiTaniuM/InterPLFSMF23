package spring.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;


public class L_NamesDao {
	
	private static JdbcTemplate jdbcTemplate;

	public L_NamesDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	public static List<L_Names> select(String lineID, String planID) { //l_names 뷰 전체 조회 후 한 건만 뽑아서 사용
		List<L_Names> results = jdbcTemplate.query(
				"select * from l_names where lineID = ? and planID = ?", 
				new RowMapper<L_Names>() {
					@Override
					public L_Names mapRow(ResultSet rs, int rowNum) throws SQLException {
						L_Names l_names = new L_Names(
								rs.getString("PlanID"),
								rs.getString("ProdNo"),
								rs.getString("ProdName"),
								rs.getString("LineID"),
								rs.getString("Status"),
								rs.getString("empNo"),
								rs.getString("Name"));
						return l_names;
					}
				}, lineID, planID);
		return results;
	}

}

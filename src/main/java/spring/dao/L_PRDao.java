package spring.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;


public class L_PRDao {
	
	private static JdbcTemplate jdbcTemplate;

	public L_PRDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	static public List<L_PR> select(String lineID, String planID) { //p_pr 뷰 전체 조회 후 한건만 뽑아서 사용
		List<L_PR> results = jdbcTemplate.query(
				"select * from l_pr where lineID = ? and planID = ?", 
				new RowMapper<L_PR>() {
					@Override
					public L_PR mapRow(ResultSet rs, int rowNum) throws SQLException {
						L_PR l_pr = new L_PR(
								rs.getString("PlanID"),
								rs.getString("LineID"),
								rs.getString("ProdNo"),
								rs.getDate("startdate"),
								rs.getDate("enddate"),
								rs.getInt("passedQty"),
								rs.getInt("failedQty"));
						return l_pr;
					}
				}, lineID, planID);
		return results;
	}
}

package spring.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;


public class L_InvenDao {
	
	private static JdbcTemplate jdbcTemplate;

	public L_InvenDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	/*
	static public List<P_Inven> selectAll() { //process_res 전체 조회
		List<P_Inven> results = jdbcTemplate.query(
				"select * from KBD001_Inven", 
				new RowMapper<P_Inven>() {
					@Override
					public P_Inven mapRow(ResultSet rs, int rowNum) throws SQLException {
						P_Inven kbd001_inven = new P_Inven(
								rs.getString("PlanID"),
								rs.getString("ProdNo"),
								rs.getString("materNo"),
								rs.getString("materName"),
								rs.getInt("materPrice"),
								rs.getInt("materQty"));
						return kbd001_inven;
					}
				});
		return results;
	}
	*/
	
	public static List<L_Inven> select(String lineID, String planID) { //p_inven 뷰에서 전체 조회 후 한 건만 뽑아서 조회
		List<L_Inven> results = jdbcTemplate.query(
				"select * from l_inven where lineID = ? and planID = ?", 
				new RowMapper<L_Inven>() {
					@Override
					public L_Inven mapRow(ResultSet rs, int rowNum) throws SQLException {
						L_Inven l_inven = new L_Inven(
								rs.getString("PlanID"),
								rs.getString("LineID"),
								rs.getString("ProdNo"),
								rs.getString("materNo"),
								rs.getString("materName"),
								rs.getInt("materPrice"),
								rs.getInt("materQty"));
						return l_inven;
					}
				}, lineID, planID);
		//return results.isEmpty() ? null : results.get(0);
		return results;
	}
}

package spring.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;


public class PReportDao {

	/*
	 * Dao for preport data
	 */
	
	private JdbcTemplate jdbcTemplate;

	public PReportDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	public List<PReport> selectAll() { //process_res 전체 조회
		List<PReport> results = jdbcTemplate.query(
				"select * from process_res", 
				new RowMapper<PReport>() {
					@Override
					public PReport mapRow(ResultSet rs, int rowNum) throws SQLException {
						PReport preport = new PReport(
								rs.getString("ResID"),
								rs.getString("PlanID"),
								rs.getTimestamp("startdate").toLocalDateTime(),
								rs.getTimestamp("enddate").toLocalDateTime(),
								rs.getInt("PassedQty"),
								rs.getInt("FailedQty"),
								rs.getString("empNo"));
						return preport;
					}
				});
		return results;
	}
	
	public PReport select(String planID) { //process_res 전체 조회 후 한건만 뽑아서 사용
		List<PReport> results = jdbcTemplate.query(
				"select * from process_res where planID = ?", 
				new RowMapper<PReport>() {
					@Override
					public PReport mapRow(ResultSet rs, int rowNum) throws SQLException {
						PReport preport = new PReport(
								rs.getString("ResID"),
								rs.getString("PlanID"),
								rs.getTimestamp("startdate").toLocalDateTime(),
								rs.getTimestamp("enddate").toLocalDateTime(),
								rs.getInt("PassedQty"),
								rs.getInt("FailedQty"),
								rs.getString("empNo"));
						return preport;
					}
				}, planID );
		
		return results.isEmpty() ? null : results.get(0);
	}

}

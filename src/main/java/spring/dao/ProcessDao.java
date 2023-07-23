package spring.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.apache.tomcat.jdbc.pool.DataSource;

public class ProcessDao {
	
	private JdbcTemplate jdbcTemplate;
	
	public ProcessDao() {
		System.out.println("[ProcessDao 실행]");
	}
	
	// DB 연동
	public ProcessDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		System.out.println("[ProcessDao 실행]");
	}
	
	// 제품명
	public String selectProdName(String id) {
		String prodName = jdbcTemplate.queryForObject(
				"SELECT p.prodName\r\n"
				+ "    FROM product p \r\n"
				+ "    JOIN process_plan pp ON p.prodNo = pp.prodNo\r\n"
				+ "    WHERE p.prodNO = ?", String.class, id);
		return prodName;
	}

	// 양품생산수량
	public String selectGood_prod(String id) {
		if(id.equals("KBD001")) { // 매개변수와 비교시에는 .equals() 사용
			id = "PKB01";
		}
		else if (id.equals("KBD003")) {
			id = "PKB02";
		}
		else if (id.equals("KC002")) {
			id = "PKC01";
		}
		String goodProd = jdbcTemplate.queryForObject(
				"SELECT COUNT(*) AS good_count\r\n"
				+ "    FROM result_prod\r\n"
				+ "    WHERE status = 0 \r\n"
				+ "    AND processID = ?", String.class, id);
		return goodProd;
	}
	// 불량생산수량
	public String selectBad_prod(String id) {
		if(id.equals("KBD001")) {
			id = "PKB01";
		}
		else if(id.equals("KBD003")){
			id = "PKB02";
		}
		else if(id.equals("KC002")) {
			id = "PKC01";
		}
		String badProd = jdbcTemplate.queryForObject(
				"SELECT COUNT(*) AS good_count\r\n"
				+ "    FROM result_prod\r\n"
				+ "    WHERE status = 1 \r\n"
				+ "    AND processID = ?", String.class, id);
		return badProd;
	}
	
	// 이슈발생횟수
	public String selectIssue_count(String id) {
		if(id.equals("KBD001")) {
			id = "KBPL01";
		}
		else if(id.equals("KBD003")) {
			id = "KBPL02";
		}
		else if(id.equals("KC002")) {
			id = "KCPL01";
		}
		String issueCount = jdbcTemplate.queryForObject(
				"SELECT COUNT(*) AS issue_count\r\n"
				+ "        FROM process_issue\r\n"
				+ "        WHERE planID = ?", String.class, id);
		return issueCount;
	}
	

	

	/*
	public List<ProcessBean> selectById(String id) {
		List<ProcessBean> results = jdbcTemplate.query("select * from single_value where prod = ?", 
				new RowMapper<ProcessBean>() {
					@Override
					public ProcessBean mapRow(ResultSet rs, int rowNum) throws SQLException {
						ProcessBean process = new ProcessBean(
								rs.getString("prodName"),
								rs.getString("good_count"),
								rs.getString("bad_count"),
								rs.getString("issue_count"));
						return process;				
					}
			}, id);
	return results;
	}
	
	public List<ProcessBean> selectByIds(String id1, String id2) {
		List<ProcessBean> results = jdbcTemplate.query("select * from single_value where prod = ? and abc=?", 
				new RowMapper<ProcessBean>() {
					@Override
					public ProcessBean mapRow(ResultSet rs, int rowNum) throws SQLException {
						ProcessBean process = new ProcessBean(
								rs.getString("prodName"),
								rs.getString("good_count"),
								rs.getString("bad_count"),
								rs.getString("issue_count"));
						return process;				
					}
			}, id1, id2);
	return results;
	}*/
	
	// List<> 쿼리를 통한 데이터 가져오기(싱글벨류)
	
	public List<ProcessBean> selectAll() {
		List<ProcessBean> results = jdbcTemplate.query("select * from single_value",
				new RowMapper<ProcessBean>() {
					@Override
					public ProcessBean mapRow(ResultSet rs, int rowNum) throws SQLException {
						ProcessBean process = new ProcessBean();
								process.setProdName(rs.getString("prodName"));
								process.setGood_count(rs.getString("good_count"));
								process.setBad_count(rs.getString("bad_count"));
								process.setIssue_count(rs.getString("issue_count"));
								return process;
					}
			});
	return results;
	}
	
	// 이슈 내용 
	public List<ProcessBean> selectIssueAll(String id) {
		if("KBD001".equals(id)) {
			id = "KBPL01";
		}
		else if("KBD003".equals(id)) {
			id = "KBPL02";
		}
		else if("KC002".equals(id)) {
			id = "KCPL01";
		}
		List<ProcessBean> results = jdbcTemplate.query("SELECT issueNo, issueInfo, timestamp\r\n"
				+ "    FROM process_issue\r\n"
				+ "    WHERE planID = ?",
				new RowMapper<ProcessBean>() {
					@Override
					public ProcessBean mapRow(ResultSet rs, int rowNum) throws SQLException {
						ProcessBean process = new ProcessBean();
								process.setIssueNo(rs.getString("issueNo"));
								process.setIssueInfo(rs.getString("issueInfo"));
								process.setTimeStamp(rs.getString("timestamp"));
						return process;				
					}
			}, id);
	return results;
	}
	/*
	// 공정 진행률(게이지 차트) 1건
	public String selectGauge() {
		String process_gauge = jdbcTemplate.queryForObject(
				"SELECT percent FROM process_percent", String.class);
		return process_gauge;
	}*/
	
	// 공정 진행률(게이지 차트) 1건
	/*
	public String selectGauge(String id) {
		if("KBD001".equals(id)) {
			id = "KBPL01";
			System.out.println("SelectGauge : " + id);
		}
		String process_gauge = jdbcTemplate.queryForObject(
				"SELECT TRUNC(A.Qty/B.prodQty * 100,2) AS 공정진행률\r\n"
				+ "    FROM (SELECT COUNT(*) AS Qty\r\n"
				+ "        FROM result_prod R, process P, process_plan PP \r\n"
				+ "        WHERE R.processID = P.processID \r\n"
				+ "        AND P.planID = PP.planID\r\n"
				+ "        AND R.status = 0\r\n"
				+ "        AND PP.planID = ?) A,\r\n"
				+ "        (SELECT prodQty \r\n"
				+ "        FROM process_plan\r\n"
				+ "        WHERE planID = ?)B", String.class, id,id);
		return process_gauge;
	}*/
	
	// 공정률
	public List<ProcessBean> selectGauge(String id) {
		if("KBD001".equals(id)) {
			id = "KBPL01";
		}
		else if ("KBD003".equals(id)) {
			id = "KBPL02";
		}
		else if ("KC002".equals(id)) {
			id = "KCPL01";
		}
		List<ProcessBean> process_gauge = jdbcTemplate.query(
				"SELECT TRUNC(A.Qty/B.prodQty * 100,2) AS process\r\n"
				+ "    FROM (SELECT COUNT(*) AS Qty\r\n"
				+ "        FROM result_prod R, process P, process_plan PP \r\n"
				+ "        WHERE R.processID = P.processID \r\n"
				+ "        AND P.planID = PP.planID\r\n"
				+ "        AND R.status = 0\r\n"
				+ "        AND PP.planID = ?) A,\r\n"
				+ "        (SELECT prodQty \r\n"
				+ "        FROM process_plan\r\n"
				+ "        WHERE planID = ?)B", 
				new RowMapper<ProcessBean>() {
					@Override
					public ProcessBean mapRow(ResultSet rs, int rowNum) throws SQLException {
						ProcessBean process = new ProcessBean();
								process.setProcess_gauge(rs.getString("process"));
						return process;				
					}
			},id,id);
	return process_gauge;
	}
	
	// 수율
	public List<ProcessBean> select_rate(String id) {
		if("KBD001".equals(id)) {
			id = "PKB01";
		}
		else if ("KBD003".equals(id)) {
			id = "PKB02";
		}
		else if ("KC002".equals(id)) {
			id = "PKC01";
		}
		List<ProcessBean> process_gauge = jdbcTemplate.query(
				"SELECT TRUNC(A.Qty / C.t_Qty * 100) AS goodprod_rate,\r\n"
				+ "    TRUNC(B.Qty / C.t_Qty * 100) AS badprod_rate \r\n"
				+ "    FROM (SELECT COUNT(*) AS Qty\r\n"
				+ "        FROM result_prod\r\n"
				+ "        WHERE status = 0 \r\n"
				+ "        AND processID = ?) A,\r\n"
				+ "        (SELECT COUNT(*) AS Qty\r\n"
				+ "        FROM result_prod\r\n"
				+ "        WHERE status = 1 \r\n"
				+ "        AND processID = ?) B,\r\n"
				+ "        (SELECT COUNT(*) AS t_Qty\r\n"
				+ "        FROM result_prod\r\n"
				+ "        WHERE processID =?)C", 
				new RowMapper<ProcessBean>() {
					@Override
					public ProcessBean mapRow(ResultSet rs, int rowNum) throws SQLException {
						ProcessBean process = new ProcessBean();
								process.setGoodprod_rate(rs.getString("goodprod_rate"));
								process.setBadprod_rate(rs.getString("badprod_rate"));
						return process;				
					}
			},id,id,id);
	return process_gauge;
	}
	/*
	//양품률/불량률
	public List<ProcessBean> select_rate() {
		List<ProcessBean> results = jdbcTemplate.query("SELECT * FROM prod_rate",
				new RowMapper<ProcessBean>() {
			@Override
			public ProcessBean mapRow(ResultSet rs, int rowNum) throws SQLException {
				ProcessBean process = new ProcessBean(
						rs.getString("goodprod_rate"),
						rs.getString("badprod_rate"));
				return process;				
			}
	});
return results;
}
	/*
	// 양품률/불량률
	public List<ProcessBean> select_rate(String id) {
		if(id =="KBD001") {
			id = "PKB01";
		}
		List<ProcessBean> results = jdbcTemplate.query("SELECT TRUNC(A.Qty / C.t_Qty * 100) AS goodprod_rate,\r\n"
				+ "    TRUNC(B.Qty / C.t_Qty * 100) AS badprod_rate \r\n"
				+ "    FROM (SELECT COUNT(*) AS Qty\r\n"
				+ "        FROM result_prod\r\n"
				+ "        WHERE status = 0 \r\n"
				+ "        AND processID = ?) A,\r\n"
				+ "        (SELECT COUNT(*) AS Qty\r\n"
				+ "        FROM result_prod\r\n"
				+ "        WHERE status = 1 \r\n"
				+ "        AND processID = ?) B,\r\n"
				+ "        (SELECT COUNT(*) AS t_Qty\r\n"
				+ "        FROM result_prod\r\n"
				+ "        WHERE processID = ?)C",
				new RowMapper<ProcessBean>() {
					@Override
					public ProcessBean mapRow(ResultSet rs, int rowNum) throws SQLException {
						ProcessBean process = new ProcessBean(
								rs.getString("goodprod_rate"),
								rs.getString("badprod_rate"));
						return process;				
					}
			},id,id,id);
	return results;
	}*/
	
	// 리드타임
	public String selectleadtime(String id) {
		if("KBD001".equals(id)) {
			id = "PKB01";
		}
		else if("KBD003".equals(id)) {
			id = "PKB02";
		}
		else if("KC002".equals(id)) {
			id = "PKC01";
		}
		String process_leadtime = jdbcTemplate.queryForObject(
				"SELECT leadtime\r\n"
				+ "    FROM process\r\n"
				+ "    WHERE processID = ?", String.class,id);
		return process_leadtime;
	}
	/*
	public String selectcycletime() {
		String process_cycletime = jdbcTemplate.queryForObject(
				"select * from cycletime", String.class);
		return process_cycletime;
	}
	*/
	// 싸이클타임(가변)
	public List<ProcessBean> select_cycletime(String id) {
		if("KBD001".equals(id)) {
			id = "PKB01";
		}
		else if("KBD003".equals(id)) {
			id = "PKB02";
		}
		else if("KC002".equals(id)) {
			id = "PKC01";
		}
		List<ProcessBean> results = jdbcTemplate.query("SELECT cycletime \r\n"
				+ "    FROM result_prod\r\n"
				+ "    WHERE processID = ?",
				new RowMapper<ProcessBean>() {
					@Override
					public ProcessBean mapRow(ResultSet rs, int rowNum) throws SQLException {
						ProcessBean process = new ProcessBean();
						process.setCycletime(rs.getString("cycletime"));
						return process;				
					}
			},id);
	return results;
	}
	
	// 소요 재료
	public List<ProcessBean> select_material(String id) {
		List<ProcessBean> results = jdbcTemplate.query("SELECT C.MATERNAME, (A.MATERQTY*B.PRODQTY) QTY, C.UNIT \r\n"
				+ "        FROM bom A, process_plan B, material C \r\n"
				+ "        WHERE A.MATERNO = C.MATERNO \r\n"
				+ "        AND A.PRODNO = B.PRODNO \r\n"
				+ "        AND A.PRODNO = ?"
				+ "		   ORDER BY QTY",
				new RowMapper<ProcessBean>() {
					@Override
					public ProcessBean mapRow(ResultSet rs, int rowNum) throws SQLException {
						// DEFAULT 생성자 이용
						ProcessBean process = new ProcessBean(); 
						process.setMaterialname(rs.getString("matername"));
						process.setMaterialqty(rs.getString("QTY"));
						return process;				
					}
			},id);
	return results;
	}
	
	// 공정 명령
	// DB 데이터 호출
	public List<ProcessBean> select_plan() {
		System.out.println("select_plan 실행");
		List<ProcessBean> results = jdbcTemplate.query("SELECT B.num,A.prodNO, A.startdate, A.enddate, B.name\r\n"
				+ "    FROM process_plan A, process_order B\r\n"
				+ "    WHERE A.planID = B.planID",
				new RowMapper<ProcessBean>() {
					@Override
					public ProcessBean mapRow(ResultSet rs, int rowNum) throws SQLException {
						ProcessBean process = new ProcessBean();
								process.setNum(rs.getInt("num"));
								process.setProdNo(rs.getString("prodNo"));
								process.setStartDate(rs.getDate("startdate"));
								process.setEndDate(rs.getDate("enddate"));
								process.setName(rs.getString("name"));
								return process;
					}
			});
	return results;
	}
	
	/* 
	 * 파라미터 num에 해당하는 공정 데이터 삭제 
	 */
	
	public int deleteProcess(Integer num) {
		System.out.println("deleteProcess 실행");
		int deleteprocess = jdbcTemplate.update("DELETE FROM process_order WHERE num = ?", num);
		return deleteprocess;
	}
	
	// lineid 값이 null이 아닐경우에만 실행
	public void insertLineid(String value, String prodNo) {
		if(value != null) {
			System.out.println("insertLineid 실행");
			jdbcTemplate.update("UPDATE PROCESS_ORDER SET LINEID = ?, PROCHECK = 'Y' WHERE PRODNO = ?", value,prodNo);
		}
		else {
			System.out.println("value 값이 올바르지 않습니다"); 
		}
		
	}
	
	
	public int count() {
		Integer count = jdbcTemplate.queryForObject(
				"select count(*) from cycletime_1", Integer.class);
		return count;
	}

}

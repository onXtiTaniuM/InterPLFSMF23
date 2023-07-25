package controller.statistics;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import spring.dao.ApprovalPlan;
import spring.dao.Issue;
import spring.dao.LOT;
import spring.dao.MainDao;
import spring.dao.User;

public class StatisticsService {
	private MainDao mainDao;
	
	public void setmainDao(MainDao mainDao) {
		this.mainDao = mainDao;
	}
	
	public String getIssueDate(Issue is) {
		String date;
		LocalDateTime timestamp = is.getTime();
		
		date = timestamp.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
		
		return date;
	}
	
	public String planPeriodDate(ApprovalPlan plan) {
		String date;
		LocalDateTime stdate = plan.getStartdate();
		LocalDateTime eddate = plan.getEnddate();
		
		date = stdate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) + " ~ " + 
				eddate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		
		return date;
	}
	
	public List<Issue> getIssueList(){
		return mainDao.selectAllIssue();
	}
	
	public List<ApprovalPlan> getPlanList() {
		return mainDao.selectPlanWithName();
	}
	
	public List<LOT> getInvenMaterQtyList(){
		return mainDao.selectEAMaterialQty();
	}
}

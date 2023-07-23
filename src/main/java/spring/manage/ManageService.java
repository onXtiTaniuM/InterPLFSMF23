package spring.manage;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import controller.manage.ManageUserCommand;
import spring.dao.ApprovalPlan;
import spring.dao.PlanDao;
import spring.dao.User;
import spring.dao.MainDao;

public class ManageService {
	private MainDao userDao;
	
	public void setuserDao(MainDao userDao) {
		this.userDao = userDao;
	}

	public List<User> allUserList(){
		List<User> userlist = userDao.selectAll();
		return userlist;
	}
	
	public void insertUser(ManageUserCommand newUser) {
		userDao.insertUser(newUser);
	}
	
	public String userAdminString(User user) {
		if(user.isAdmin()) {
			return "true";
		}else {
			return "false";
		}
	}
	
	public String userRegiDate(User user) {
		String regidate;
		LocalDateTime userDate = user.getRegiDate();
		
		regidate = userDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
		
		return regidate;
	}
	
	public boolean planNotification() {
		return userDao.planNotification();
	}
	
	public boolean idDuplicate(String id) {
		return (userDao.selectById(id) != null) ? true:false ;
	}
	
	public void changePassword(String id, String pw) {
		userDao.updatePassword(id, pw);
	}
	
	public boolean passwordCheck(String id, String pw) {
		if(userDao.selectIdPwMatch(id, pw) != null) {
			return true;
		}
		return false;
	}
	
	public User getUserById(String id) {
		User user = userDao.selectById(id);
		return user;
	}
	
	public List<String> rankList(){
		return userDao.rankList();
	}
	
	public void deleteUser(String id) {
		userDao.deleteUser(id);
	}

	public void updateUser(User user) {
		userDao.updateUser(user);
	}
	
	public List<ApprovalPlan> getApprovalPlanList() {
		return userDao.selectApprovalPlan("N");
		
	}
	
	public String planPeriodDate(ApprovalPlan plan) {
		String date;
		LocalDateTime stdate = plan.getStartdate();
		LocalDateTime eddate = plan.getEnddate();
		
		date = stdate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) + " ~ " + 
				eddate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		
		return date;
	}

	public void planChecked(String planid) {
		userDao.planChecked(planid);	
	}
}

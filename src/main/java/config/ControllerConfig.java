package config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import controller.login.LogoutController;
import controller.manage.ManageController;
import controller.plan.PReportController;
import controller.plan.PlanController;
import controller.process.ProcessController;
import controller.TestController;
import controller.inventory.InvenController;
import controller.login.LoginController;
import spring.auth.AuthService;

@Configuration
public class ControllerConfig {

	@Autowired
	private AuthService authService;
	
	@Bean
	public LoginController loginController() {
		LoginController controller = new LoginController();
		controller.setAuthService(authService);
		return controller;
	}
	
	@Bean
	public LogoutController logoutController() {
		return new LogoutController();
	}
	
	@Bean
	public ManageController manageController() {
		return new ManageController();
	}
	
	@Bean
	public PlanController planController() {
		return new PlanController();
	}
	
	@Bean
	public InvenController invenController() {
		return new InvenController();
	}
	
	@Bean
	public ProcessController processController() {
		return new ProcessController();
	}
	
	@Bean
	public PReportController processreportController() {
		return new PReportController();
	}
	
	//Bean For Test Page. Will Not Use.
	@Bean
	public TestController testController() {
		return new TestController();
	}
	
	
	
}

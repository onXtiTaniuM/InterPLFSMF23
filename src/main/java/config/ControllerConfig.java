package config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import controller.login.LogoutController;
import controller.manage.ManageController;
import controller.plan.BomController;
import controller.plan.PlanController;
import controller.preport.Pr_ProductController;
import controller.process.ProcessController;
import controller.process.ProcessOrController;
import controller.setting.SettingController;
import controller.TestController;
import controller.inventory.InvenController;
import controller.login.LoginController;
import spring.auth.AuthService;
import spring.dao.ProcessDao;
import spring.inventory.InventoryService;
import spring.manage.ManageService;

@Configuration
public class ControllerConfig {
	
	@Autowired
	private ProcessDao processDao;

	@Autowired
	private AuthService authService;
	
	@Autowired
	private ManageService manageService;
	
	@Autowired
	private InventoryService inventoryService;
	
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
		ManageController controller = new ManageController();
		controller.setManageS(manageService);
		return controller;
	}
	
	@Bean
	public PlanController planController() {
		return new PlanController();
	}
	
	@Bean
	public BomController bomController() {
		return new BomController();
	}
	
	@Bean
	public InvenController invenController() {
		InvenController controller = new InvenController();
		controller.setInvenService(inventoryService);
		return controller;
	}
	
	@Bean
	public ProcessController processController() {
		return new ProcessController(processDao);
	}
	
	@Bean
	public ProcessOrController processOrController() {
		return new ProcessOrController(processDao);
	}
	
	@Bean
	public SettingController settingsController() {
		SettingController controller = new SettingController();
		controller.setManageService(manageService);
		return controller;
	}
	
	@Bean
	public Pr_ProductController pr_productController() {
		return new Pr_ProductController();
	}
	
	//Bean For Test Page. Will Not Use.
	@Bean
	public TestController testController() {
		return new TestController();
	}
	
	
	
}

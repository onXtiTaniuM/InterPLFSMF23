package controller.setting;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import spring.manage.ManageService;

@Controller
@RequestMapping("/settings")
public class SettingController {
	private ManageService manageService;
	
	@RequestMapping
	public String setting() {
		return "settings/settings";
	}
	
	@RequestMapping("/changepassword")
	public String changePassword() {
		return "settings/changePassword";
	}

	public void setManageService(ManageService manageService) {
		this.manageService = manageService;	
	}
	
}

package controller.manage;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import spring.dao.User;
import spring.manage.ManageService;

@Controller
@RequestMapping("/manage")
public class ManageController {
	private ManageService manageS;
	
	public void setManageS(ManageService manageS) {
		this.manageS = manageS;
	}

	@RequestMapping("")
    public String manage() {
    	return "manage/manage";
    }
	
	@RequestMapping("/usermanagement")
    public String manageUser(Model model, ManageUserCommand manageUserCommand) {
		System.out.println("[REQUEST] /usermanagement");
		List<User> list = manageS.allUserList();
		model.addAttribute("userlist",list);
    	return "manage/manageUser";
    }
	
	@PostMapping("/usermanagement/register.do")
	public String newUser(ManageUserCommand manageUserCommand) {
		System.out.println("[POST] /register.do");
		manageS.insertUser(manageUserCommand);
		return "manage/manageUser";
	}
}

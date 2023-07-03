package controller.manage;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
    public String manageUser(Model model) {
		List<User> list = manageS.allUserList();
		for(User user : list) {
			System.out.println(user);
		}
		model.addAttribute("userlist",list);
    	return "manage/manageUser";
    }
 
}

package controller.manage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/manage")
public class ManageController {
	
	@RequestMapping("")
    public String manage() {
    	return "manage/manage";
    }
	
	@RequestMapping("/usermanagement")
    public String manageUser() {
    	return "manage/manageUser";
    }
 
}

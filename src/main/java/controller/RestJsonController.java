package controller;

import java.util.List;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import spring.dao.User;
import spring.manage.ManageService;

@RestController
@RequestMapping("/api")
public class RestJsonController {
	private ManageService manageSvc;
	
	public void setManageS(ManageService manageS) {
		this.manageSvc = manageS;
	}
	
	@RequestMapping("/userList")
    public List<User> members() {
        return manageSvc.allUserList();
    }
}

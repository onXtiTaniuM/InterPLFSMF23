package controller.manage;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import controller.login.LoginCommandValidator;
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
	public void newUser(HttpServletRequest httpServletRequest, HttpServletResponse response, ManageUserCommand manageUserCommand, Errors errors, Model model) throws ServletException, IOException{
		System.out.println("[POST] /register.do");
		httpServletRequest.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		
		System.out.println("[register User req]" + httpServletRequest.getParameter("empNo")
		+ httpServletRequest.getParameter("name")
		+ httpServletRequest.getParameter("id")
		+ httpServletRequest.getParameter("password"));
		
		manageUserCommand.setEmpNo(httpServletRequest.getParameter("empNo"));
		manageUserCommand.setName(httpServletRequest.getParameter("name"));
		manageUserCommand.setId(httpServletRequest.getParameter("id"));
		manageUserCommand.setPassword(httpServletRequest.getParameter("password"));
		manageUserCommand.setPasswordCheck(httpServletRequest.getParameter("passwordCheck"));
		manageUserCommand.setRank(httpServletRequest.getParameter("rank"));
		
		System.out.println("[register User]" + manageUserCommand.getEmpNo()
		+ manageUserCommand.getName()
		+ manageUserCommand.getPassword()
		+ manageUserCommand.getRank());
		
		new LoginCommandValidator().validate(manageUserCommand, errors);
		if (errors.hasErrors()) {
			System.out.println("[Validator] has error");
			writer.print("fail");
			return;
        }
		
		manageS.insertUser(manageUserCommand);
		List<User> list = manageS.allUserList();
		model.addAttribute("userlist",list);
		writer.print("success");
	}
}

package controller.login;

import javax.servlet.http.Cookie;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import controller.login.LoginCommand;


@Controller
@RequestMapping("/login")
public class LoginController {
    
    @GetMapping
    public String form(LoginCommand loginCommand,	//쿠키 획득
    		@CookieValue(value = "REMEMBER", required = false) Cookie rCookie) {
		if (rCookie != null) {
			loginCommand.setEmail(rCookie.getValue());
			loginCommand.setRememberEmail(true);
		}
    	return "login/loginPage";
    }
}

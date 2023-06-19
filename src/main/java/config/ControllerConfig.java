package config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import controller.login.LoginController;

@Configuration
public class ControllerConfig {

	@Bean
	public LoginController loginController() {
		LoginController controller = new LoginController();
		return controller;
	}
	
}

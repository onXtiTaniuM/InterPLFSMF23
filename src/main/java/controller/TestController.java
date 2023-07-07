package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TestController {
	
	@RequestMapping("/testx")	//preport controller로 연결해주기 위해 뒤에 x를 붙임
    public String test() {
    	return "test/test";
    }
 
}

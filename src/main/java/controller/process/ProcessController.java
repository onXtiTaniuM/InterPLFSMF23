package controller.process;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/process")
public class ProcessController {
	
	@RequestMapping("")
    public String manage() {
    	return "process/process";
    }
 
}

package controller.process;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/process")
public class ProcessController {
	
	@RequestMapping("")
    public String process() {
    	return "process/process";
    }
 
	@RequestMapping("/issueList.json")
	public void issueListJson() {
		
	}
}

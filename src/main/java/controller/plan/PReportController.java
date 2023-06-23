package controller.plan;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PReportController {
	
	@RequestMapping("/report")
    public String manage() {
    	return "report/report";
    }
 
}

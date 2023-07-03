package controller.plan;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/report")
public class PReportController {
	
	@RequestMapping("")
    public String manage() {
    	return "report/report";
    }
 
}

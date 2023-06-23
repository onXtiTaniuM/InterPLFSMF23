package controller.plan;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PlanController {
	
	@RequestMapping("/plan")
    public String manage() {
    	return "plan/plan";
    }
 
}

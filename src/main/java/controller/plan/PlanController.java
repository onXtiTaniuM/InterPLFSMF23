package controller.plan;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/plan")
public class PlanController {
	
	@RequestMapping("")
    public String manage() {
    	return "plan/plan";
    }
 
}

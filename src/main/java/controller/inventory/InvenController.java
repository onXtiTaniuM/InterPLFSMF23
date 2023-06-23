package controller.inventory;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class InvenController {
	
	@RequestMapping("/inventory")
    public String manage() {
    	return "inventory/inven";
    }
 
}

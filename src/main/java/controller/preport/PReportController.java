package controller.preport;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import spring.dao.PReport;
import spring.dao.PReportDao;

@Controller
@RequestMapping("/test")	//testpage만 열려있기 때문에 test로 해둠
public class PReportController {
	
	@Autowired
	PReportDao preportDao;
	
	@RequestMapping("")
    public String manage(Model model) {
		
		List<PReport> preport = preportDao.selectAll();
		model.addAttribute("preport", preport);
		return "test/test";
    	//return "preport/preport";
    }
}

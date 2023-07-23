package controller.process;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ch.qos.logback.core.recovery.ResilientSyslogOutputStream;
import spring.dao.ProcessBean;
import spring.dao.ProcessDao;

@Controller
public class ProcessOrController {
private ProcessDao processDao;
	
	public ProcessOrController(ProcessDao processDao) {
		this.processDao = processDao;
	}
	
	@GetMapping("/testOR") // 주소창에 /process 입력시 실행
    public String single_value(Model model) {
		List<ProcessBean>orderlist = processDao.select_plan();
		model.addAttribute("orderlist", orderlist);
		System.out.println("orderlist 실행");
		return "test/testOR";
	}
	
	@GetMapping("/testORDelete")
	public String deleteProcess(Model model, @RequestParam("num") Integer num) {
		System.out.println("[ProcessOrController] deleteProcess: prodNo=" + num);
		processDao.deleteProcess(num);
		System.out.println("deleprocess 완료 2");
		
		List<ProcessBean>orderlist = processDao.select_plan();
		model.addAttribute("orderlist", orderlist);
		return "test/testOR";
	}
	
	@GetMapping("/testORstart")
	public String insertLine(Model model, @RequestParam("prodNo") String prodNo,@RequestParam("value") String value) {
		System.out.println("[ProcessOrController] insertLine : prodNo=" + prodNo);
		System.out.println("[ProcessOrController] insertLine : value=" + value);
		
		
		String insertProdNo = prodNo;
		processDao.insertLineid(value, prodNo);
		model.addAttribute("insertProdNo", insertProdNo);
		return "test/test";	
	}
	
		
}

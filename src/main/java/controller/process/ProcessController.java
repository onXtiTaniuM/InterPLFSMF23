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

import spring.dao.ProcessBean;
import spring.dao.ProcessDao;

@Controller
public class ProcessController {
private ProcessDao processDao;
	
	public ProcessController(ProcessDao processDao) {
		this.processDao = processDao;
	}
	
	/*
	@GetMapping("/process") // 주소창에 /process 입력시 실행
    public String single_value(Model model) {
		List<ProcessBean> single = processDao.selectAll();
		for(ProcessBean p : single) {
			
		model.addAttribute("single", single);
		}
		List<ProcessBean> issueList = processDao.selectIssueAll();
		System.out.println("issueList" + issueList);
		model.addAttribute("issueList", issueList);
		return "test3.jsp";
	}*/
	
	@GetMapping("/process") // 주소창에 /process 입력시 실행
    public String single_value(Model model,@RequestParam("procid") String procid) {
		System.out.println("[ProcessController] /process : procid=" + procid);
		
		// 뷰파일에 procid를 저장하기 위해 재전송
		model.addAttribute("procid", procid);
		
		String prodName = processDao.selectProdName(procid);
		model.addAttribute("prodName", prodName);
		System.out.println("[ProcessController] /process : prodName=" + prodName);
		
		System.out.println("procid : " + procid);
		String goodProd = processDao.selectGood_prod(procid);
		model.addAttribute("goodProd", goodProd);
		
		String badProd = processDao.selectBad_prod(procid);
		model.addAttribute("badProd", badProd);
		
		String issueCount = processDao.selectIssue_count(procid);
		model.addAttribute("issueCount", issueCount);
		
		List<ProcessBean> issueList = processDao.selectIssueAll(procid);
		if(issueList != null) {
			model.addAttribute("issueList", issueList);
			System.out.println("issueList" + issueList);
		}
		
		List<ProcessBean> process_gauge = processDao.selectGauge(procid);
		if(process_gauge != null) {
			model.addAttribute("process_gauge", process_gauge.get(0));
			System.out.println("ProcessController.single_value(): /process : process_gauge=" + process_gauge.get(0).getProcess_gauge());
		}
		List<ProcessBean> process_rate = processDao.select_rate(procid);
		if(process_rate != null) {
			model.addAttribute("process_rate", process_rate);
			System.out.println("process_rate" + process_rate);
		}
	
		return "test/test";
	}
	
/*
		@GetMapping("/process1") // 주소창에 /process 입력시 실행
	    public String single_value1(Model model, @RequestParam("procid") String procid) {
			System.out.println("[ProcessController] /process1 : procid=" + procid);
			
			List<ProcessBean> processList = processDao.selectById(procid);
			System.out.println("processList" + processList);
			model.addAttribute("processList", processList);
			
			List<ProcessBean> issueList = processDao.selectIssueAll();
			System.out.println("issueList" + issueList);
			model.addAttribute("issueList", issueList);
			return "test3.jsp";
		}

		*/
	//---------------------------------------------------------------------------------
	/*
	@PostMapping("/process") 
	public void doChart_gauge(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value="procid", required=false ) String procid) throws ServletException, IOException{
		System.out.println("[GaugeChart]");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		
		// DB에 저장된 값을 process_gauge 변수에 저장
		List<ProcessBean> process_gauge = processDao.selectGauge(procid);
		System.out.println("Gauge Chart : " + process_gauge);
		// JSON 배열 선언
		JSONArray chart = new JSONArray();
		// xvals에 DB에서 받아온 변수값 저장
		for(ProcessBean p : process_gauge) {
			chart.add(p.getProcess_gauge());
		}
		/*
		String xvals = process_gauge;
		chart.add(xvals);
		*/
		//String jsonInfo = chart.toJSONString();
		//System.out.println(jsonInfo);
		//writer.print(jsonInfo);
	//}
	
	/*
	@PostMapping("/process") 
	public void doChart_gauge(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		System.out.println("[GaugeChart]");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		
		// DB에 저장된 값을 process_gauge 변수에 저장
		String process_gauge = processDao.selectGauge();
		System.out.println("Gauge Chart : " + process_gauge);
		// JSON 배열 선언
		JSONArray chart = new JSONArray();
		// xvals에 DB에서 받아온 변수값 저장
		String xvals = process_gauge;
		chart.add(xvals);
		
		String jsonInfo = chart.toJSONString();
		System.out.println(jsonInfo);
		writer.print(jsonInfo);
	}*/
	//---------------------------------------------------------------------------------
	/*
	@PostMapping("/process1") // 주소창에 /process 입력시 실행
	public void doChart_rate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		System.out.println("[PieChart]");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		
		// DB에 저장된 값을 process_gauge 변수에 저장
		// List<ProcessBean>process = processDao.select_rate();
		List<ProcessBean> process = processDao.select_rate(id);
		System.out.println("Pie Chart : " + process);
		// JSON 배열 선언
		JSONArray chart = new JSONArray();
		// xvals에 DB에서 받아온 변수값 저장
		// for(ProcessBean k : process) {
		for(ProcessBean p : process) {
			chart.add(p.getGoodprod_rate());
			chart.add(p.getBadprod_rate());
		}
		// }
		String jsonInfo = chart.toJSONString();
		System.out.println(jsonInfo);
		writer.print(jsonInfo);
	}*/
	//---------------------------------------------------------------------------------
	
	@PostMapping("/process2")
	public void doChart_time(HttpServletRequest request, HttpServletResponse response, @RequestParam("procid") String procid) throws ServletException, IOException{
		System.out.println("[timechart/procid] : " + procid);
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		
		String process_leadtime = processDao.selectleadtime(procid);
		System.out.println("Leadtime : " + process_leadtime);
		
		List<ProcessBean>process_cycletime = processDao.select_cycletime(procid);
		int count = processDao.count(); 
		System.out.println("Cycletime : " + count);
		
		JSONArray chart = new JSONArray();
		chart.add(process_leadtime);
		
		for(ProcessBean p : process_cycletime) {
			chart.add(p.getCycletime());
		}
		
		String jsonInfo = chart.toJSONString();
		System.out.println(jsonInfo);
		writer.print(jsonInfo);
		
		/*
		JSONArray chart = new JSONArray();
		chart.add(process_leadtime);
		chart.add(process_cycletime);
		*/
	}
	//---------------------------------------------------------------------------------
	@PostMapping("/process3")
	public void doChart_material(HttpServletRequest request, HttpServletResponse response,@RequestParam("procid")String procid) throws ServletException, IOException{
		System.out.println("[timechart]");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		
		List<ProcessBean>process_material = processDao.select_material(procid);
		System.out.println("Material : " + process_material);
		JSONArray chart = new JSONArray();
		for(ProcessBean p : process_material) {
			chart.add(p.getMaterialname());
		}
		for(ProcessBean p : process_material) {
			chart.add(p.getMaterialqty());
		}
		String jsonInfo = chart.toJSONString();
		System.out.println(jsonInfo);
		writer.print(jsonInfo);
	}
	//---------------------------------------------------------------------------------
	@PostMapping("/process4")
	public void doChart_material2(HttpServletRequest request, HttpServletResponse response,@RequestParam("procid")String procid) throws ServletException, IOException{
		System.out.println("[timechart]");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		
		List<ProcessBean>process_material = processDao.select_material(procid);
		System.out.println("Material : " + process_material);
		JSONArray chart = new JSONArray();
		for(ProcessBean p : process_material) {
			chart.add(p.getMaterialname());
		}
		for(ProcessBean p : process_material) {
			chart.add(p.getMaterialqty());
		}
		String jsonInfo = chart.toJSONString();
		System.out.println(jsonInfo);
		writer.print(jsonInfo);
	}
	//---------------------------------------------------------------------------------
	
	@PostMapping("/process5")
	public void doChart_material3(HttpServletRequest request, HttpServletResponse response,@RequestParam("procid")String procid) throws ServletException, IOException{
		System.out.println("[timechart]");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		
		List<ProcessBean>process_material = processDao.select_material(procid);
		System.out.println("Material : " + process_material);
		JSONArray chart = new JSONArray();
		for(ProcessBean p : process_material) {
			chart.add(p.getMaterialname());
		}
		for(ProcessBean p : process_material) {
			chart.add(p.getMaterialqty());
		}
		String jsonInfo = chart.toJSONString();
		System.out.println(jsonInfo);
		writer.print(jsonInfo);
	}
	/*
	@GetMapping("/test3")
	public String one(Model model) {
		return test3
	} 
	*/

	/*
	@RequestMapping("/process")
    public String manage() {
    	return "process/process";
    }
	*/
}

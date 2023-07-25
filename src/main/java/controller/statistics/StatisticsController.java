package controller.statistics;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import spring.dao.ApprovalPlan;
import spring.dao.Issue;
import spring.dao.LOT;

@Controller
@RequestMapping("/statistics")
public class StatisticsController {
	private StatisticsService statisticsService;

	public void setStatisticsService(StatisticsService statisticsService) {
		this.statisticsService = statisticsService;
	}
	
	@RequestMapping("/issuelist.json")
	public void issueListJson(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		
		JSONArray issueArray = new JSONArray();
		JSONObject jsonInfo = new JSONObject();
		
		List<Issue> list = statisticsService.getIssueList();
		for(Issue is : list) {
			JSONArray issueInfo = new JSONArray();
			issueInfo.add(is.getLineID());
			issueInfo.add(is.getIssueName());
			issueInfo.add(is.getIssueInfo());
			issueInfo.add(statisticsService.getIssueDate(is));
			issueArray.add(issueInfo);
		}
			jsonInfo.put("data", issueArray);
			String data = jsonInfo.toJSONString();
			System.out.print(data);
			writer.print(data);
	}
	
	@RequestMapping("/planlist.json")
	public void planListJson(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		
		JSONArray plansArray = new JSONArray();
		JSONObject jsonInfo = new JSONObject();
		
		List<ApprovalPlan> list = statisticsService.getPlanList();
		for(ApprovalPlan plan : list) {
			JSONArray planInfo = new JSONArray();
			planInfo.add(plan.getPlanid());
			planInfo.add(plan.getLineid());
			planInfo.add(plan.getProdname());
			planInfo.add(plan.getQty());
			planInfo.add(statisticsService.planPeriodDate(plan));
			planInfo.add(plan.getRank());
			planInfo.add(plan.getName());
			plansArray.add(planInfo);
		}
		
		jsonInfo.put("data", plansArray);
		String data = jsonInfo.toJSONString();
		//System.out.print(data);
		writer.print(data);
	}
}

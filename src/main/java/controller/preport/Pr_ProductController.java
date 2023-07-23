package controller.preport;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import spring.dao.P_Names;
import spring.dao.P_NamesDao;
import spring.dao.P_Issue;
import spring.dao.P_IssueDao;
import spring.dao.L_Inven;
import spring.dao.L_InvenDao;
import spring.dao.L_Issue;
import spring.dao.L_IssueDao;
import spring.dao.L_Names;
import spring.dao.L_NamesDao;
import spring.dao.L_PR;
import spring.dao.L_PRDao;
import spring.dao.P_Inven;
import spring.dao.P_InvenDao;
import spring.dao.P_PR;
import spring.dao.P_PRDao;

@Controller
@RequestMapping("/preport")	//폴더명이 preport
public class Pr_ProductController {	
	
	@Autowired
	P_NamesDao p_nameDao;
	
	@RequestMapping("/pr_product")
	public String manage3() {
		return "preport/pr_product";
	}
	
	@RequestMapping("/pr_line")
	public String manage4() {
		return "preport/pr_line";
	}

	@RequestMapping("/product")
    public String manage(@RequestParam("prodNo") String prodNo, 
    		@RequestParam("planID") String planID,
    		Model model) {
		System.out.println("/preport : prodNo=" + prodNo); // 결과 값 잘 받아오는지 확인
	
		List<P_Names> p_names = P_NamesDao.select(prodNo, planID);
		List<P_PR> p_pr = P_PRDao.select(prodNo, planID);
		List<P_Issue> p_issue = P_IssueDao.select(prodNo, planID);
		List<P_Inven> p_inven = P_InvenDao.select(prodNo, planID);
		
		model.addAttribute("p_names", p_names);
		model.addAttribute("p_pr", p_pr);
		model.addAttribute("p_issue", p_issue);
		model.addAttribute("p_inven", p_inven);
		
		return "preport/product";
	}
	
	@RequestMapping("/line")
    public String manage2(@RequestParam("lineID") String prodNo,
    		@RequestParam("planID") String planID,
    		Model model) {
		System.out.println("/test : lineID=" + prodNo); // 결과 값 잘 받아오는지 확인
	
		List<L_Names> l_names = L_NamesDao.select(prodNo, planID);
		List<L_PR> l_pr = L_PRDao.select(prodNo, planID);
		List<L_Issue> l_issue = L_IssueDao.select(prodNo, planID);
		List<L_Inven> l_inven = L_InvenDao.select(prodNo, planID);
		
		model.addAttribute("l_names", l_names);
		model.addAttribute("l_pr", l_pr);
		model.addAttribute("l_issue", l_issue);
		model.addAttribute("l_inven", l_inven);
		
		return "preport/line";
	}
}

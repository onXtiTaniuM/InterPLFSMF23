package controller.plan;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import spring.plan.BomInfo;

@Controller
@RequestMapping("/ajax")
public class BomController {
	
	@GetMapping("/prodVal.do")
	public void prodValSubmit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    request.setCharacterEncoding("utf-8");
	    response.setContentType("text/html;charset=utf-8");

	    String[] prodValArray = request.getParameterValues("prodVal");
	    System.out.println("[prodVal]: " + Arrays.toString(prodValArray));

	    PrintWriter writer = response.getWriter();
	    writer.print(Arrays.toString(prodValArray));
	}

	
	@GetMapping("/submit")
	public String prodInfoSubmit(Model model){
		
		
		
		return null;
	}
	
	
}

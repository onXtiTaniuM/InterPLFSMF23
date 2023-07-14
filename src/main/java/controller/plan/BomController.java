package controller.plan;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import spring.plan.BomInfo;

@Controller
@RequestMapping("/ajax")
public class BomController {
	

	@GetMapping("/prodVal.do")
	public void prodValSubmit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.print("success");
	    request.setCharacterEncoding("utf-8");
	    response.setContentType("text/html;charset=utf-8");
	    
	    String[] prodValArray = (String[])request.getParameterValues("prodVal");
	    System.out.println("[prodVal]: " + Arrays.toString(prodValArray));
	    
  
		JSONArray json = new JSONArray();
		
		for(String str : prodValArray) {
			json.add(str);
		}
		
		String jsonStr = json.toJSONString();
		System.out.println(jsonStr);

		PrintWriter writer = response.getWriter();
		writer.print(jsonStr);
	}

}

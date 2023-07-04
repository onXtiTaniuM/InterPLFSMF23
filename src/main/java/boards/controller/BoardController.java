package boards.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import boards.dao.BoardBean;
import boards.dao.BoardDAO;

@Controller
@RequestMapping("/boards")
public class BoardController {

	@GetMapping(value={ "/", "/list.do" } )
	public String boards(Model model) {
		System.out.println("[BoardController] : GET:/boards/list.do");
		return "boards/list";
	}

	@PostMapping("/list.do")
	public String listPost(Model model) {
		System.out.println("[BoardController] : POST:/list.do");
		return "boards/list";
	}

	@GetMapping("/read.do")
	public String read(Model model) {
		System.out.println("[BoardController] : GET:/boards/read.do");
		return "boards/read";
	}
	
	@GetMapping("/update.do")
	public String update(Model model) {
		System.out.println("[BoardController] : GET:/boards/update.do");
		return "boards/update";
	}

	@GetMapping("/reply.do")
	public String reply(Model model) {
		System.out.println("[BoardController] : GET:/boards/reply.do");
		return "boards/reply";
	}

	@RequestMapping("/delete.do")
	public String delete(Model model) {
		System.out.println("[BoardController] : /boards/delete.do");
		return "boards/delete";
	}
	
	@PostMapping("/download.do")
	public String download(Model model) {
		System.out.println("[BoardController] : POST:/boards/download.do");
		return "boards/download";
	}

	
	@GetMapping("/writePost.do")
	public String writePost(Model model) {
		System.out.println("[BoardController] : /writePost.do");
		return "boards/writePost";
	}

	@PostMapping("/boardPost.do")	// @GetMapping("/writePost.do")에서 요청
	public String boardPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		System.out.println("[BoardController] : POST:/boards/boardPost.do");
		request.setCharacterEncoding("UTF-8");
		BoardDAO bMgr = new BoardDAO();
		bMgr.insertBoard(request);
		return "redirect:/boards/list.do";
	}
	
	@PostMapping("/boardReply.do")	// @GetMapping("/writePost.do")에서 요청
	public String boardReply(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		System.out.println("[BoardController] : POST:/boards/boardReply.do");
		request.setCharacterEncoding("UTF-8");
		BoardDAO bMgr = new BoardDAO();
		BoardBean reBean = new BoardBean();
		reBean.setEmpName(request.getParameter("empname"));
		reBean.setProdName(request.getParameter("prodName"));
		reBean.setContent(request.getParameter("content"));
		reBean.setRef(Integer.parseInt(request.getParameter("ref"))); 
		reBean.setPos(Integer.parseInt(request.getParameter("pos"))); 
		reBean.setDepth(Integer.parseInt(request.getParameter("depth"))); 
		reBean.setPass(request.getParameter("pass"));
		reBean.setIp(request.getParameter("ip"));

		bMgr.replyUpBoard(reBean.getRef(), reBean.getPos());
		bMgr.replyBoard(reBean);
		
		String nowPage = request.getParameter("nowPage");
		// response.sendRedirect("list.jsp?nowPage="+nowPage);
		return "redirect:/boards/list.do?nowPage="+nowPage;
	}	
	
	@PostMapping("/boardUpdate.do")
	protected String boardUpdate(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("[BoardController] : POST:/boards/boardUpdate.do");
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter(); 

		BoardDAO bMgr = new BoardDAO();
		BoardBean bean = (BoardBean) session.getAttribute("bean");
		String nowPage = request.getParameter("nowPage");
		
		BoardBean upBean = new BoardBean();
		upBean.setNum(Integer.parseInt(request.getParameter("num")));
		upBean.setEmpName(request.getParameter("empname"));
		upBean.setProdName(request.getParameter("prodName"));
		upBean.setContent(request.getParameter("content"));
		upBean.setPass(request.getParameter("pass"));
		upBean.setIp(request.getParameter("ip"));

		String upPass = upBean.getPass();
		String inPass = bean.getPass();

		if (upPass.equals(inPass)) {
			bMgr.updateBoard(upBean);
			String url = "redirect:/boards/read.do?nowPage=" + nowPage + "&num=" + upBean.getNum();
			// response.sendRedirect(url);
			return url;
		} 
		else {
			out.println("<script>");
			out.println("alert('입력하신 비밀번호가 아닙니다.');");
			out.println("history.back();");
			out.println("</script>");
		}
		
		return null;
	}	
} 

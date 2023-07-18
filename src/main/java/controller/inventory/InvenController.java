package controller.inventory;

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

import spring.dao.LOT;
import spring.dao.LOTprod;
import spring.dao.User;
import spring.inventory.InventoryService;

@Controller
@RequestMapping("/inventory")
public class InvenController {
	private InventoryService invenService;
	
	public void setInvenService(InventoryService invenService) {
		this.invenService = invenService;
	}

	@RequestMapping("")
    public String manage() {
    	return "inventory/inven";
    }
 
	@RequestMapping("/lotlist.json")
	public void lotListJson(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		
		JSONArray lotArray = new JSONArray();
		JSONObject jsonInfo = new JSONObject();
		
		List<LOT> list = invenService.allInvenList();
		for(LOT lot : list) {
			JSONArray lotInfo = new JSONArray();
			lotInfo.add(lot.getLotNo());
			lotInfo.add(lot.getProdName());
			lotInfo.add(lot.getMaterialName());
			lotInfo.add(lot.getStringQty());
			lotInfo.add(lot.getWarehouseName());
			lotArray.add(lotInfo);
		}
			jsonInfo.put("data", lotArray);
			String data = jsonInfo.toJSONString();
			System.out.print(data);
			writer.print(data);
	}
	
	@RequestMapping("/prodlotlist.json")
	public void prodlotListJson(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		
		JSONArray lotArray = new JSONArray();
		JSONObject jsonInfo = new JSONObject();
		
		String lot = request.getParameter("lot");
		List<LOTprod> list = invenService.lotSelectProductList(lot);
		for(LOTprod prod : list) {
			JSONArray prodInfo = new JSONArray();
			prodInfo.add(prod.getLotNo());
			prodInfo.add(prod.getProdName());
			prodInfo.add(prod.getSerialNo());
			prodInfo.add(prod.getProcessid());
			prodInfo.add(prod.getStatusPF());
			lotArray.add(prodInfo);
		}
			jsonInfo.put("data", lotArray);
			String data = jsonInfo.toJSONString();
			System.out.print(data);
			writer.print(data);
	}
	
	@RequestMapping("/warehouselist.json")
	public void warehsListJson(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		
		
	}
}

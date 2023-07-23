package spring.inventory;

import java.util.List;

import spring.dao.LOT;
import spring.dao.LOTprod;
import spring.dao.MainDao;
import spring.dao.Warehouse;

public class InventoryService {
	private MainDao userDao;
	
	public void setuserDao(MainDao userDao) {
		this.userDao = userDao;
	}
	
	public List<LOT> allInvenList(){
		return userDao.selectAllLOT();
	}
	
	public List<LOTprod> lotSelectProductList(String lot){
		return userDao.selectRProdByLOT(lot);
	}
	
	public List<Warehouse> allWarehouseList(){
		return userDao.selectAllWareHs();
	}
}

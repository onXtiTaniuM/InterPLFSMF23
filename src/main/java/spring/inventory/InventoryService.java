package spring.inventory;

import java.util.List;

import spring.dao.LOT;
import spring.dao.LOTprod;
import spring.dao.UserDao;
import spring.dao.Warehouse;

public class InventoryService {
	private UserDao userDao;
	
	public void setuserDao(UserDao userDao) {
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

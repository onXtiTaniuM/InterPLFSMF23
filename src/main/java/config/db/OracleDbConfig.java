package config.db;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import config.db.OracleInfo;
import spring.auth.AuthService;
import spring.dao.UserDao;
import spring.dao.PlanDao;
import spring.dao.UserRegisterService;
import spring.inventory.InventoryService;
import spring.manage.ManageService;

@Configuration
@EnableTransactionManagement
public class OracleDbConfig{

	@Bean(destroyMethod = "close")
	public DataSource dataSource() {
		DataSource ds = new DataSource();
		ds.setDriverClassName(OracleInfo._driver);
		ds.setUrl(OracleInfo._url);
		ds.setUsername(OracleInfo._user);
		ds.setPassword(OracleInfo._password);
		ds.setInitialSize(2);
		ds.setMaxActive(10);
		ds.setMaxIdle(10);
		ds.setTestWhileIdle(true);
		ds.setMinEvictableIdleTimeMillis(60000 * 3);
		ds.setTimeBetweenEvictionRunsMillis(10 * 1000);
		return ds;
	}

	@Bean
	public PlatformTransactionManager transactionManager() {
		DataSourceTransactionManager tm = new DataSourceTransactionManager();
		tm.setDataSource(dataSource());
		return tm;
	}

	@Bean
	public UserDao userDao() {
		return new UserDao(dataSource());
	}
	
	@Bean
	public PlanDao planDao() {
		return new PlanDao(dataSource());
	}

	@Bean
	public UserRegisterService memberRegSvc() {
		return new UserRegisterService(userDao());
	}
	
	@Bean
	public AuthService authService() {
		AuthService authService = new AuthService();
		authService.setuserDao(userDao());
		return authService;
	}
	
	@Bean
	public ManageService manageService() {
		ManageService manageService = new ManageService();
		manageService.setuserDao(userDao());
		return manageService;
	}
	
	@Bean
	public InventoryService inventoryService() {
		InventoryService invenService = new InventoryService();
		invenService.setuserDao(userDao());
		return invenService;
	}
}

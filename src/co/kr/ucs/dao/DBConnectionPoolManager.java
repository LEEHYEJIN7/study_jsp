package co.kr.ucs.dao;

import java.util.HashMap;
import java.util.Map;

public class DBConnectionPoolManager {
	private static String DEFAULT_POOLNAME="DEFAULT";
	private static Map<String, DBConnectionPool> dbPool=new HashMap<>();
	private static DBConnectionPoolManager instance=new DBConnectionPoolManager();
	
	// DBConnectionPoolManager 객체 반환
	public static DBConnectionPoolManager getInstance() {
		return instance;
	}
	
	public void setDBPool(String url, String id, String pw) {
		setDBPool(DEFAULT_POOLNAME, url, id, pw, 1, 10);
	}

	public void setDBPool(String poolName, String url, String id, String pw) {
		setDBPool(poolName, url, id, pw, 1, 10);
	}
	
	public void DBPool(String poolName, String url, String id, String pw, int initConns) {
		setDBPool(poolName, url, id, pw, initConns, 10);
	}
	
	public void setDBPool(String poolName, String url, String id, String pw, int initConns, int maxConns) {
		if(!dbPool.containsKey(poolName)) {
			DBConnectionPool connPool=new DBConnectionPool(url, id, pw, initConns, maxConns);
			dbPool.put(poolName, connPool);
		}
	}
	
	public DBConnectionPool getDBPool() {
		return getDBPool(DEFAULT_POOLNAME);
	}
	
	public DBConnectionPool getDBPool(String poolName) {
		return dbPool.get(poolName);
	}
}

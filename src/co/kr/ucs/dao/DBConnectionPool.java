package co.kr.ucs.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.SQLTimeoutException;

public class DBConnectionPool {
	private int initConns;	// 초기에 Pool에 생성할 Connection 개수
	private int maxConns;	// Pool에 생성할 최대 Connection 개수
	
	private long timeOut=1000*30; // Connection을 얻을 때 대기 시간
	
	private String url;
	private String id;
	private String pw;
	
	private int[] connStatus;	// Connection Pool의 상태
	private Connection[] connPool; //Connection Pool
	
	
	//ConnectionPool 정보 인자를 갖는 생성자
	public DBConnectionPool(String url, String id, String pw, int initConns, int maxConns) {
		this.url=url;
		this.id=id;
		this.pw=pw;
		
		this.initConns=initConns;
		this.maxConns=maxConns;
		
		this.connStatus=new int[maxConns];
		this.connPool=new Connection[maxConns];
		
		for(int i=0; i<this.initConns; i++) {
			try {
				this.createConnection(i);
			}catch(Exception e) {
				e.printStackTrace();
				return;
			}
		}
	}

	// 커넥션을 생성하여 connPool에 추가
	private Connection createConnection(int pos) throws ClassNotFoundException, SQLException {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection conn=DriverManager.getConnection(url, id, pw);
		
		this.connPool[pos]=conn;
		this.connStatus[pos]=1;
		
		return this.connPool[pos];
	}
	
	//사용하지 않는 커넥션을 반환
	public synchronized Connection getConnection() throws SQLTimeoutException{
		long currTime=System.currentTimeMillis();
		while((System.currentTimeMillis()-currTime)<=this.timeOut) {
			for(int i=0; i<this.maxConns; i++) {
				if(this.connStatus[i] == 1) {
					this.connStatus[i]=2;
					return this.connPool[i];
				}else if(this.connStatus[i]==0) {
					try {
						this.connStatus[i]=2;
						return createConnection(i);
					}catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
			
			try {
				Thread.sleep(100);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		throw new SQLTimeoutException("모든 Connection이 사용중입니다.");

	}
	
	//커넥션을 반환
	public void freeConnection(Connection conn) {
		if(conn!=null) {
			for(int i=0; i<this.maxConns; i++) {
				if(this.connPool[i]==conn) {
					this.connStatus[i]=1;
					break;
				}
			}
		}
	}
	
	//getConnection시 대기 시간 반환
	public long getTimeOut() {
		return timeOut;
	}
	
	//getConnection시 대기 시간 설정
	public void setTimeOut(long timeOut) {
		this.timeOut=timeOut;
	}
}

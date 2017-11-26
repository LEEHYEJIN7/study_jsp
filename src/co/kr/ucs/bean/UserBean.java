package co.kr.ucs.bean;

public class UserBean {
	private String userId;
	private String userNm;
	private String userPw;
	private String email;
	
	
	public UserBean() {
		super();
	}

	public UserBean(String userId, String userNm, String userPw, String email) {
		super();
		this.userId = userId;
		this.userNm = userNm;
		this.userPw = userPw;
		this.email = email;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserNm() {
		return userNm;
	}

	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}

	public String getUserPw() {
		return userPw;
	}

	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public String toString() {
		return "UserBean [userId=" + userId + ", userNm=" + userNm + ", userPw=" + userPw + ", email=" + email + "]";
	}	
	
}

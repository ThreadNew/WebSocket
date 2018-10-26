package com.chatsocket.bean;

/**
   * @类 名： User
   * @功能描述： TODO 用户信息实体类
   * @作者信息： 陈强
   * @创建时间： 2018年10月26日上午11:37:49
   * @修改备注：
   */
public class User {
	private String username;//用户名
	private String password;//密码

	@Override
	public String toString() {
		return "User [username=" + username + ", password=" + password + "]";
	}

	public User(String username, String password) {
		super();
		this.username = username;
		this.password = password;
	}

	public User() {
		super();
		// TODO Auto-generated constructor stub
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

}

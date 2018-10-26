package com.chatsocket.bean;

/**
   * @类 名： Message
   * @功能描述： TODO 消息实体类
   * @作者信息： 陈强
   * @创建时间： 2018年10月26日上午11:41:55
   * @修改备注：
   */
public class Message {
	private String from;
	private String content;
	private String date;
	public Message() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Message(String from, String content, String date) {
		super();
		this.from = from;
		this.content = content;
		this.date = date;
	}
	public String getFrom() {
		return from;
	}
	public void setFrom(String from) {
		this.from = from;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	@Override
	public String toString() {
		return "Message [from=" + from + ", content=" + content + ", date=" + date + "]";
	}
	

}

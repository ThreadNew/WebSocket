package com.chatsocket.data;

/**
   * @类 名： UInfoSingleton
   * @功能描述： TODO 设计模式 采用懒汉模式
   * @作者信息： 陈强
   * @创建时间： 2018年10月26日上午11:35:59
   * @修改备注：
   */
public class UInfoSingleton {
	private static UserInfo instance;

	public synchronized static UserInfo getInstance(){
		if(instance==null){
			return new UserInfo();
		}else{
			return instance;
		}
	}

}

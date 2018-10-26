package com.chatsocket.data;

import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

/**
   * @类 名： UserInfo
   * @功能描述： TODO 模拟数据库
   * @作者信息： 陈强
   * @创建时间： 2018年10月26日上午11:32:26
   * @修改备注：
   */
public class UserInfo {
	private final Map<String, String> info = new ConcurrentHashMap<>();// 多线程操作
	// 代码块

	{
		info.put("admin", "admin");
		info.put("tom", "tom");
		info.put("guest", "guest");
	}

	// 判断用户名是否存在
	public Boolean checkUserName(String userName, String pws) {
		Set<String> uname = info.keySet();
		if (uname.contains(userName)) {
			String tPws = info.get(userName);
			if (tPws.equals(pws)) {
				return true;
			}
		}
		return false;
	}

}

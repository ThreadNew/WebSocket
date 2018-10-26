package com.chatsocket.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chatsocket.bean.User;
import com.chatsocket.data.UInfoSingleton;

@Controller
@RequestMapping("/LoginController")
public class LoginController {
	/*
	 * 进入主界面
	 */
	@GetMapping("/into")
	public String into() {
		return "frame";
	}

	/*
	 * 身份验证
	 */
	@PostMapping("/login")
	@ResponseBody
	public String Login(User user, HttpServletRequest request) {
		if (!UInfoSingleton.getInstance().checkUserName(user.getUsername(), user.getPassword()))
			return "error";
		request.getSession().setAttribute("user", user);
		return "ok";
	}

	/*
	 * 进入单聊界面
	 */
	@GetMapping("/alone")
	public String alone() {
		return "alone";

	}
	/*
	 * 进入群聊界面
	 */
	@GetMapping("/together")
	public String together() {
		return "together";

	}
}

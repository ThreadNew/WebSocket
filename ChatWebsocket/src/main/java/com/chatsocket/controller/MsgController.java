package com.chatsocket.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import com.chatsocket.bean.Message;

@Controller
public class MsgController {
	private final SimpMessagingTemplate messageTemplate;
	@Autowired
	public MsgController(SimpMessagingTemplate messageTemplate) {
		super();
		this.messageTemplate = messageTemplate;
	}
	/*
	 * 一对一聊天
	 */
	@MessageMapping("/alone/{userid}")
	public void aloneChat(Principal principal,@DestinationVariable String userid,Message message){
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		message.setDate(sdf.format(new Date()));
		System.out.println(message);
		messageTemplate.convertAndSendToUser(userid, "/alone/chat", message);
	}
	/*
	 * 一对多
	 */
	@MessageMapping("/chat")
	public void togeChat(Message message){
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		message.setDate(sdf.format(new Date()));
		messageTemplate.convertAndSend("/topic/toge/chat", message);
	}
	

}

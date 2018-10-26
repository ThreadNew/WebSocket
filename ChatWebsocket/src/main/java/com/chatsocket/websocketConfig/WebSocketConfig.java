package com.chatsocket.websocketConfig;

import java.security.Principal;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.Message;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.simp.config.ChannelRegistration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.messaging.simp.stomp.StompCommand;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.messaging.support.ChannelInterceptor;
import org.springframework.messaging.support.MessageHeaderAccessor;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;
@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer{

	@Override
	public void configureClientInboundChannel(ChannelRegistration registration) {
		// TODO Auto-generated method stub
		registration.interceptors(new ChannelInterceptor() {

			@Override
			public Message<?> preSend(Message<?> message, MessageChannel channel) {
				StompHeaderAccessor accessor = MessageHeaderAccessor.getAccessor(message, StompHeaderAccessor.class);
				// 1、判断是否首次连接
				if (StompCommand.CONNECT.equals(accessor.getCommand())) {
					// 2、判断用户名和密码
					String username = accessor.getNativeHeader("username").get(0);
					String password = accessor.getNativeHeader("password").get(0);

					if (true) {
						Principal principal = new Principal() {
							@Override
							public String getName() {
								return username;
							}
						};
						accessor.setUser(principal);
						return message;
					} else {
						return null;
					}
				}
				// 不是首次连接，已经登陆成功
				return message;
			}
			
			
		});
	}

	@Override
	public void configureMessageBroker(MessageBrokerRegistry registry) {
		// TODO Auto-generated method stub
		registry.setApplicationDestinationPrefixes("/app");
		registry.enableSimpleBroker("/topic","/user");
	}

	@Override
	public void registerStompEndpoints(StompEndpointRegistry registry) {
		// TODO Auto-generated method stub
		registry.addEndpoint("/webSocket").withSockJS();
	}
	

}

<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'frame.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" href="<%=basePath%>/layui/css/layui.css"
	media="all">
<script src="<%=basePath%>/layui/layui.js"></script>
<script src="<%=basePath%>/layui/jquery-3.3.1.min.js"></script>
<script src="/webjars/sockjs-client/sockjs.min.js"></script>
<script src="/webjars/stomp-websocket/stomp.min.js"></script>
</head>
<body>
	<div class="layui-container">
		<div class="layui-row">&nbsp;</div>
		<div class="layui-row">
			<hr class="layui-bg-green">
		</div>
		<div class="layui-row">&nbsp;</div>
		<div class="layui-row">
			<div class="layui-col-md2">&nbsp;</div>
			<!-- <div class="layui-col-md4">
				<input id="oName" type="text" name="username" required
					lay-verify="required" placeholder="请输入对方用户名" autocomplete="off"
					class="layui-input">
			</div> -->
			<div class="layui-col-md1 layui-col-md-offset1">
				<button id="connect" class="layui-btn layui-btn-radius"
					onclick="connect('${user.username}','${user.password}');">connected</button>
			</div>
			<div class="layui-col-md1 layui-col-md-offset1">
				<button id="disconnect" class="layui-btn layui-btn-radius"
					onclick="disconnect();">disconnect</button>
			</div>
			<div class="layui-col-md2">&nbsp;</div>
		</div>
		<div class="layui-row">&nbsp;</div>
		<div class="layui-row">
			<hr class="layui-bg-green">
		</div>
		<div class="layui-row">&nbsp;</div>
		<div class="layui-row">
			<div class="layui-col-md2">&nbsp;</div>
			<div class="layui-col-md4">
				<input id="content" type="text" name="title" required
					lay-verify="required" placeholder="请输入消息" autocomplete="off"
					class="layui-input">
			</div>
			<div class="layui-col-md1 layui-col-md-offset1">
				<button id="send" class="layui-btn " onclick="send();">send</button>
			</div>
		</div>
		<div class="layui-row">&nbsp;</div>
		<div class="layui-row">
			<hr class="layui-bg-green">
		</div>
		<div class="layui-row">&nbsp;</div>
		<div class="layui-row">
			<table id="recode" class="layui-table" lay-skin="line">
				<thead>
					<th>聊天记录</th>
				</thead>
			</table>
		</div>
	</div>
	</div>
</body>
<script type="text/javascript">
	var stompClient = null;
	//连接时按钮的显示问题
	function setConnected(connected) {
		$("#connect").prop("disabled", connected);
		$("#disconnect").prop("disabled", !connected);
		$("#send").prop("disabled", !connected);
		if (connected) {
			$('#connect').addClass("layui-btn-disabled");
			$('#disconnect').removeClass("layui-btn-disabled");
			$('#send').removeClass("layui-btn-disabled");
		} else {
			$('#connect').removeClass("layui-btn-disabled");
			$('#disconnect').addClass("layui-btn-disabled");
			$('#send').addClass("layui-btn-disabled");
		}
	}
	function connect(u, p) {
		var headers = {
			username : u,
			password : p
		};
		var socket = new SockJS('/webSocket');
		stompClient = Stomp.over(socket);
		stompClient.connect(headers, function(frame) {
			setConnected(true);
			console.log('Connected: ' + frame);
			stompClient.subscribe('/topic/toge/chat', function(greeting) {
				showGreeting(greeting.body);
			});
		});
	}
	//展示
	function showGreeting(message) {
		var elt=eval("("+message+")");
		$("#recode").append("<tr><td>" + elt.from + ":" + elt.content + "_" + elt.date);
	}
	//发送
	function send() {
		stompClient.send("/app/chat", {}, JSON.stringify({
			'from' : '${user.username}',
			'content' : $("#content").val()
		}));
		/* $("#recode").append("<tr><td>" + '${user.username}' + ":" + $("#content").val() + "_" +formatDate(new Date()) ); */
	}
var formatDate = function (date) {  
    var y = date.getFullYear();  
    var m = date.getMonth() + 1;  
    m = m < 10 ? ('0' + m) : m;  
    var d = date.getDate();  
    d = d < 10 ? ('0' + d) : d;  
    var h = date.getHours();  
    var minute = date.getMinutes();  
    minute = minute < 10 ? ('0' + minute) : minute; 
    var second= date.getSeconds();  
    second = minute < 10 ? ('0' + second) : second;  
    return y + '-' + m + '-' + d+' '+h+':'+minute+':'+ second;  
};  
	//断开连接
	function disconnect() {
		if (stompClient !== null) {
			stompClient.disconnect();
		}
		setConnected(false);
		console.log("Disconnected");
	}
</script>

</html>
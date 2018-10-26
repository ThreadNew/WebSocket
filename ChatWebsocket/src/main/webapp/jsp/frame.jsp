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
		<div class="layui-row">
			<div class="layui-col-md-12"
				style="background-color: #6db33f;   width:100%px;
        height:200px;">
				<h1
					style="color: #EEEEEE; font-size: 50px;padding-left: 28%;padding-top: 4%;">SpringBoot&nbsp;&nbsp;&nbsp;WebSocket</h1>
			</div>
		</div>
		<!--左右分工登陆框-->
		<div class="layui-row">
			<div class="layui-col-md6">
				<fieldset class="layui-elem-field">
					<legend>用户登陆窗口</legend>
					<div class="layui-field-box">
						<form id="userLogForm" class="layui-form" action="">
							<div class="layui-form-item">
								<label class="layui-form-label">用户名:</label>
								<div class="layui-input-block">
									<input type="text" name="username" required
										lay-verify="required" placeholder="请输入用户名" autocomplete="off"
										class="layui-input">
								</div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">密码:</label>
								<div class="layui-input-block">
									<input type="text" name="password" required
										lay-verify="required" placeholder="请输入密码" autocomplete="off"
										class="layui-input">
								</div>
							</div>
							<div class="layui-form-item">
								<div class="layui-input-block">
									<button id="btt" class="layui-btn" lay-submit
										lay-filter="formDemo">登陆</button>
									<button type="button" class="layui-btn layui-btn-primary"
										onclick="Register()">注册</button>
								</div>
							</div>
						</form>
					</div>
				</fieldset>
			</div>
			<div class="layui-col-md6">
				<fieldset class="layui-elem-field">
					<legend>聊天方式：</legend>
					<div class="layui-field-box">
						<center>
							<div style="margin-top: 30px;">
								<button id="btn1"
									class="layui-btn layui-btn-radius layui-btn-normal"
									onclick="alone()">单聊</button>
							</div>
							<div style="margin-top: 54px;">
								<button id="btn2"
									class="layui-btn layui-btn-radius layui-btn-normal" onclick="together();">群聊</button>
							</div>
						</center>
					</div>
				</fieldset>
			</div>
		</div>
	</div>
</body>
<script>
	$(function() {
		$('#btn1').attr('disabled', "true"); //添加disabled属性 
		$('#btn1').addClass("layui-btn-disabled");
		$('#btn2').attr('disabled', "true"); //添加disabled属性 
		$('#btn2').addClass("layui-btn-disabled");
	})
	layui.use([ 'form', 'layer' ], function() {
		var form = layui.form;
		var layer = layui.layer;
		//监听提交
		form.on('submit(formDemo)', function(data) {
			$('#btt').attr('disabled', "true"); //添加disabled属性 
			$('#btt').addClass("layui-btn-disabled");
			$.ajax({
				type : "POST",
				url : "LoginController/login",
				data : $('#userLogForm').serialize(),
				async : false,
				error : function(request) {
					layer.msg("Connection error");
				},
				success : function(data) {
					//接收后台返回的结果  
					if (data == 'ok') {
						$('#btn1').removeAttr('disabled'); //添加disabled属性 
						$('#btn1').removeClass("layui-btn-disabled");
						$('#btn2').removeAttr('disabled'); //添加disabled属性 
						$('#btn2').removeClass("layui-btn-disabled");
						layer.msg("登陆成功")
					} else {
						layer.msg("登陆失败")
						$('#btt').removeAttr('disabled'); //添加disabled属性 
					$('#btt').removeClass("layui-btn-disabled");
					}

				},
				error : function() {
					layer.msg("登陆失败失败");
					$('#btt').removeAttr('disabled'); //添加disabled属性 
					$('#btt').removeClass("layui-btn-disabled");
				}
			});

			return false;
		});
	});

	function Register() {
		layer.msg("注册");

	}
	//alone chat
	function alone() {
		layer.open({
			type:2,
			title : '单聊页面',
			shadeClose : true,
			shade : 0.8,
			area : [ '80%', '90%' ],
			content : 'LoginController/alone' //iframe的url
		});

	}
	//together chat
	function together() {
		layer.open({
			type:2,
			title : '单聊页面',
			shadeClose : true,
			shade : 0.8,
			area : [ '80%', '90%' ],
			content : 'LoginController/together' //iframe的url
		});

	}
</script>

</html>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>管理员后台登录</title>
		<link rel="stylesheet" href="css/bootstrap.css" />
		<link rel="stylesheet" href="css/back.css" />
		<script src="js/jquery-2.0.3.min.js"></script>
		<script src="js/bootstrap.js"></script>
	</head>
	
	<body style="background:#9FB6CD">
		<div class="container">
			<div class="row content">
				<div class="loginbox">
				<p class="text-center"><b>管理员后台登录</b></p>
				<form action="adminLogin" method="post" class="form">
					<div class="form-group has-feedback">
						<span class="glyphicon glyphicon-user form-control-feedback"></span>
						<input type="text" class="form-control" name="userName" placeholder="用户名" />
					</div>
					<div class="form-group has-feedback">
						<span class="glyphicon glyphicon-lock form-control-feedback"></span>
						<input type="password" class="form-control" name="pwd" placeholder="密码" />
					</div>
					<div class="form-group login">
						<input type="submit" value="登录" class="btn btn-primary btn-block" />
					</div>
				</form>
				</div>
			</div>
		</div>
		<script>
			$(function(){
				$(".btn").click(function(){
					var username = $("input[name=username]").val();
					var password = $("input[name=password]").val();
					if(username.length==0){
						alert("请输入账号");
						return false;
					}else if(password.length==0){
						alert("请输入密码");
						return false;
					}else{
						return true;
					}
				})
				//如果登录不成功，则返回登录页面
				var msg = "${msg}";
				if(msg=="0"){
					alert("用户名或密码不存在,请重新登录");
					window.location.href="admin";
				}
				
				
			})
		</script>
	</body>

</html>
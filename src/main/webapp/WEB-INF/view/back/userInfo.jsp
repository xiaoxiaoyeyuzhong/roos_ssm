<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>管理中心</title>
		<link rel="stylesheet" href="css/bootstrap.css"/>
		<link rel="stylesheet" href="css/back.css"/>
		<script src="js/jquery-2.0.3.min.js"></script>
		<script src="js/bootstrap.js"></script>
		<style type="text/css">
			.detail{
				height:150px;
				display:;
			}
			
		</style>	
	</head>
	<body>
		<nav class="navbar navbar-inverse">
		    <div class="container-fluid">
			    <div class="navbar-header">
			      <a class="navbar-brand" href="#"><b>管理员中心</b></a>
			    </div>
			   <ul class="nav navbar-nav navbar-right">
		          <li><a href="exit"><b>退出</b></a></li>
		      </ul>
	      </div>
		</nav>
		<div class="container-fluid">
			<div class="row">
				<%@ include file="menu.jsp" %>
				<div class="col-sm-10">
					<p class="text-center title">VIP客户信 息</p>
					<p class="text-right title"style="padding-right:50px;"><a href="javascript:history.go(-1);">返回上一页</a></p>
					
					<div class="row orderConten">
					<!--<div class="col-md-2  text-center">用户编号
							<p class="text-center bb">${user.openid}</p>
						</div> -->	
						<div class="col-md-1 text-center">用户名
							<p class="text-center bb">${user.userName}</p>
						</div>
						<div class="col-md-1 text-center">昵称
							<p class="text-center bb">${user.nike}</p>
						</div>
						<div class="col-md-2 text-center">手机号码
							<p class="text-center bb">${user.phone}</p>
						</div>
						
						<div class="col-md-2 text-center">会员类型
							<p class="text-center bb">${user.member}</p>
						</div>
						<div class="col-md-2 text-center">会员卡号
							<p class="text-center bb">${user.id}</p>
						</div>
						<div class="col-md-2 text-center">积分
							<p class="text-center bb">${user.integral}</p>
						</div>
						<div class="col-md-2 text-center">注册时间
							<p class="text-center bb">${user.createTime}</p>
						</div>
					</div>
					<div id="msg" style="text-align:center;"></div>
				</div>
				
			</div>
<!-- 			<div class="text-center" style="font-weight:bolder;color:red;font-size:39px;">合计:￥.00</div> -->
<!-- 			<p class="text-center"><a href="">打印订单</a></p> -->
		</div>
		<script>
			var msg = "${msg}";
			if(msg=="0"){
				$("#msg").html("<font style='color:red;font-size:25px;'>此客户还不是会员，暂时没有任何信息</font>");
			}
		</script>
	</body>
</html>

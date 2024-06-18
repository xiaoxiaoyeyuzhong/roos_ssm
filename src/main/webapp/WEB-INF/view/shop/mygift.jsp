<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8"/>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1, user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<link rel="stylesheet" type="text/css" href="css/mui.css"/>
		<link rel="stylesheet" type="text/css" href="css/font-awesome.css">
		<link rel="stylesheet" type="text/css" href="css/style.css"/>
		<script src="js/jquery-2.0.3.min.js"></script>
		<title>我的礼品</title>
		<script type="text/javascript">
		   var _global = {};
			   _global.spm = {};
			   
			document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {WeixinJSBridge.call('hideToolbar');});
		</script>
		<style type="text/css">
			.mui-table-view .mui-media-object{
				line-height: 80px;
				max-width:120px;
				height: 80px;
			}
			.mui-table-view .mui-table-view-cell{
				border:#ccc solid 1px;
				box-shadow: 0 0 5px #e1e1e1;
				border-radius: 5px;
			}
		</style>
	</head>
	<body>
		<header class="mui-bar mui-bar-nav">
		   
		    <h1 class="mui-title">我的礼品</h1>
		</header>
		<div class="mui-content">
		    <ul class="mui-table-view" id="myorder">
		    <c:forEach items="${giftorder}" var="go" begin="0" end="4">
				<li class="mui-table-view-cell mui-media">
					<a href="javascript:;">
						<img class="mui-media-object mui-pull-left" src="${go.gift.imgurl}">
						<div class="mui-media-body">
							<p class='mui-ellipsis'>${go.gift.pname}</p>
							<p class='mui-show_price'>
								<span class="mui-pull-left">${go.gift.integral}积分</span>
								<span class="mui-pull-right">x${go.gift.number}</span>
							</p>
						</div>
					</a>
					<button class="mui-pull-right">${go.state}</button>
				</li>
			</c:forEach>
			</ul>
			<div style="margin-bottom:50px;"></div>
		</div>
		<!-- 引入底部菜单 -->
		<%@ include file="../front/footer.jsp" %>
		<!-- 引入底部菜单 -->
		<script>
			var msg = "${msg}"
			if(msg=="null"){
				$(".mui-content").append("<div style='height:260px;margin:100px;text-align:center;color:red;'>目前没有礼品</div>")
			}
		</script>
	</body>
</html>

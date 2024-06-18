<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
		<title>菜品列表</title>
		<link rel="stylesheet" type="text/css" href="css/font-awesome.css"/>
		<link rel="stylesheet" type="text/css" href="css/style.css"/>
		<script src="js/jquery-2.0.3.min.js" type="text/javascript"></script>
		<script type="text/javascript">
		   var _global = {};
			   _global.spm = {};
			   
			document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {WeixinJSBridge.call('hideToolbar');});
		</script>
	</head>
	<body>
		<div class="type_header">
			<p><img src="images/banner.jpg" width="100%" height="130px"/></p>
		</div>
		<div class="type_body"style="margin-bottom:50px;">
			<p class="type_logo"><img src="images/logo.png"/></p>
			<ul>
			<c:forEach items="${ftlist}" var="ft">
				<li>
					<a href="openfoodlistById?openid=${openid}&&typeid=${ft.typeid}">
						<p>	
							<img src="${ft.picurl}"/>
							<span class="type_title">${ft.typeName}</span>
							<i class="icon-chevron-right"></i>
						</p>
					</a>
				</li>
			</c:forEach>	
			</ul>
		</div>
		<!--下导航-->
		<%@include file  = "footer.jsp" %>
	  <!--nav-on-bottom下导航结束-->  
  	
	</body>
</html>

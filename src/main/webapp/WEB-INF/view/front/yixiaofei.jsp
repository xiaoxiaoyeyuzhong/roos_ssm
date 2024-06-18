<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>未成交列表</title>
		<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
		<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
		<link rel="stylesheet" type="text/css" href="css/font-awesome.css">
		<link rel="stylesheet" type="text/css" href="css/style.css" />
		<script type="text/javascript">
		   var _global = {};
			   _global.spm = {};
			   
		document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {WeixinJSBridge.call('hideToolbar');});
		</script>
		<script type="text/javascript" src="js/jquery-2.0.3.min.js"></script>
	</head>

<body>
	<div class="body">
		<h3 class="fn-tit"><a href="javascript:history.go(-1);" class="nback">返回</a><b class="tit">已消费订单明细</b></h3>
		<div id="msg"></div>
		<c:forEach items="${orders}" var="o" begin="0" end="4">
		  <div class="jf-body">
		  	<table width="100%" border="0">
				  <tr>
				  	<th scope="col" align="center" width="15%">图片</th>
				    <th scope="col" align="left" width="25%">菜品名</th>
				    <th scope="col" align="center" width="30%">用餐时间</th>
				    <th scope="col" align="center" width="15%">状态</th>
				  </tr>
				  <c:forEach items="${o.odf}" var="d">
				  <tr>
				 	<td align="left"><img src="${d.food.picurl}" width="50px" height="50px" /></td>
				    <td align="left">${d.food.foodName}</td>
				    <td align="center">${o.eatdate}</td>
				    <td align="center"><a href="javascript:void(0);">${o.xiaofei}</a></td>
				  </tr>
				 </c:forEach>
			</table>
	  	</div>
	  	</c:forEach>
	  <!--下导航-->
	  <%@include file="footer.jsp" %>
	  <!--nav-on-bottom下导航结束--> 
	</div>
	<!--body--> 
	<script>
		var msg = "${msg}";
		if(msg=="0"){
			$("#msg").css("height","250");
			$("#msg").html("<p style='color:red;text-align:center;font-size:20px;margin-top:100px;'>你当前没有已消费 的订单...</p>");
		}
	</script>
</body>
</html>
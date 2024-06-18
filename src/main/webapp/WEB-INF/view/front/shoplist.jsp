<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<title>店面展示</title>
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
		<script type="text/javascript">
		$(document).ready(function(){	
		$(".dci").click( function () { 
		$(this).toggleClass("selected");
		 }); 
		});
		</script>
	</head>

<body>
	<div class="body">
	  <div class="topsearch">
	    <form class="clearfix">
	      <input type="button" class="sbtn icon-search">
	      <input type="text" name="keys" id="keys" class="stxt" value="寻找店面" >
	      <a href="queryAllCard?openid=${openid}" title="我的订单" class="floatr"></a>
	    </form>
	  </div>
	  <!--topsearch-->
	  <div class="container">
	    <ul class="assort clearfix">
	      <li class="ast1 floatl ast-cur"><a href="#">全部分店<i class="icon-caret-down"></i></a></li>
	    </ul>
	    <!--assort-->
	    <ul class="shoplist">
		    <c:forEach items="${shops}" var="s">
		      <li>
		        <div class="shopintro clearfix"> <a href="tel:0769-82129805" class="shopimg floatl"><img src="${s.imgurl}" alt="门店照片"></a>
		          <div class="shopcon floatl">
		            <h3 class="tit">${s.shopName}</h3>
		            <p>电话：<b>${s.telphone}</b></p>
		            <p class="btn fts clearfix"><a href="tel:${s.telphone}" class="floatl orange-btn">一键订座位</a></p>
		          </div>
		          <!--foodcon--> 
		        </div>
		        <!--foodintro-->
		        <p class="shopaddr">${s.address}</p>
		      </li>
		     </c:forEach> 
	    </ul>
	  </div>
	  <!--container--> 
	  <!--下导航-->
	  <%@include file = "footer.jsp" %>
	  <!--nav-on-bottom下导航结束--> 
	</div>
	<!--body--> 

</body>
</html>
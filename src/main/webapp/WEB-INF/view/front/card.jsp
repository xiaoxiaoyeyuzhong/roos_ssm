<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>会员卡</title>
		<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
		<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
		<link rel="stylesheet" type="text/css" href="css/font-awesome.css">
		<link rel="stylesheet" type="text/css" href="css/style.css" />
		<link rel="stylesheet" type="text/css" href="css/card.css" />
		<script type="text/javascript" src="js/jquery-2.0.3.min.js"></script>
		<script type="text/javascript">
		   var _global = {};
			   _global.spm = {};
			document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {WeixinJSBridge.call('hideToolbar');});
		</script>
		
	</head>

<body style="background:#f0f0f0;">
	<div class="content">
		<div id="member">
			<div class="card-bg">
			    <div class="card"> 
			    	<img src="images/card-bg.png" alt="会员卡背景"> 
			    </div>
		    </div>
		    <div class="yue">
	            <div class="yue_1 card_no_box">会员卡号：<span class="card_no">XZG-${user.id}</span></div>
	        </div>
		    <div class="chushi">使用时向服务员出示此卡</div>
		    
		    
		    <div class="kuang">
		    	<div class="yue">
		        	<div class="tubiao"><img src="images/b2.png" width="30" height="31"/></div>
		            <div class="yueyue">余额：<span>${user.amount}元</span></div>
		            <a href="toRecharge?openid=${openid}" class="jiantou"><span class="chongzi bg">充 值</span></a>
		        </div>
		        <div style="width:100%; height:1px; background:#c2c2c2;"></div>
		        <div class="jifen">
			        <div class="yue">
			        	<div class="tubiao"><img src="images/b1.png" width="30" height="31"/></div>
			            <div class="yueyue">积分：<span class="jfnum">${user.integral}分</span></div>
			            <a href="goToIntegralShop?openid=${openid}" class="jiantou"><span class="chongzi">兑 换</span></a>
			        </div>
		        </div>
		    </div>
		    
		    <div class="kuang_2">
		    	<div class="yue">
		    		<button id="xiaofei">会员余额结账</button>
		        </div>
		        <div style="width:100%; height:10px; background:#f0f0f0;"></div>
		        <div class="jifen">
			        <div class="yue">
			        	<button id="findMyNote">查看账单</button>
			        </div>
		        </div>
		        
		    </div>
	    </div>
	    <div style="clear:both;margin-bottom:50px;"></div>
	   </div> 
	  <!--下导航-->
	  <%@include file="footer.jsp" %>
	  <!--nav-on-bottom下导航结束-->
	  <script>
	  	$("#xiaofei").click(function(){
	  		window.location.href="openconsume?openid=${openid}";
	  	});
	  	$("#findMyNote").click(function(){
	  		window.location.href="findMyNote?openid=${openid}";
	  	})
	  </script>
</body>
</html>

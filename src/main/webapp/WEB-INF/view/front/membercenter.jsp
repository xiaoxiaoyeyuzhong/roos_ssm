<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<title>会员中心</title>
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
	  <div class="mem-top clearfix">
	  	<em class="floatl mem-img"><img src="images/logo.png" width="100%" alt="头像"></em>
	    <div class="mem-intro floatr">
	    	<p><b>${user.userName}</b></p>
	        <p>账户余额：<strong style="color:#FF4040;">${user.amount}元</strong></p>
	        <!--<p><a href="openmember?openid=${openid}">我的VIP会员卡</a>，我还不是VIP，<br /><a href="openRegUser?openid=${openid}">申请成为VIP</a></p>-->
	    </div><!--mem-intro-->    
	  </div><!--mem-top-->
	  <dl class="mem-orderlist mem">
	  	<dt>订单</dt>
	    <dd>
	    	<p><a href="queryudingOrderDetail?openid=${openid}" class="clearfix"><span class="floatl"><i class="icon-pencil"></i>预定中</span><em class="floatr">查看<i class="icon-chevron-right"></i></em></a></p>
	        <p><a href="queryPaidOrderDetail?openid=${openid}" class="clearfix"><span class="floatl"><i class="icon-check"></i>已支付</span><em class="floatr">查看<i class="icon-chevron-right"></i></em></a></p>
	        <p><a href="queryYixiaofeiDetail?openid=${openid}" class="clearfix"><span class="floatl"><i class="icon-check-empty"></i>已消费</span><em class="floatr">查看<i class="icon-chevron-right"></i></em></a></p>
	        <p><a href="queryDweiDetail?openid=${openid}" class="clearfix"><span class="floatl"><i class="icon-check-empty"></i>已定桌位</span><em class="floatr">查看<i class="icon-chevron-right"></i></em></a></p>
	        <p><a href="queryMyGift?openid=${openid}" class="clearfix"><span class="floatl"><i class="icon-gift"></i>我的礼品</span><em class="floatr">查看<i class="icon-chevron-right"></i></em></a></p>
	    </dd>
	  </dl>
	 <!--<dl class="mem-score mem">
	  	<dt>我的积分</dt>
	    <dd>
	    	<p><a href="jifenlieb.html" class="clearfix"><span class="floatl"><i class="icon-money"></i>现有积分：<b class="orange">912</b></span><em class="floatr">积分记录<i class="icon-chevron-right"></i></em></a></p>
	        <p><a href="jifenhuodong.html" class="clearfix"><span class="floatl"><i class="icon-gift"></i>积分活动</span><em class="floatr"><i class="icon-chevron-right"></i></em></a></p>
	        <p><a href="jifenguize.html" class="clearfix"><span class="floatl"><i class="icon-book"></i>积分规则</span><em class="floatr"><i class="icon-chevron-right"></i></em></a></p>
	    </dd>
	  </dl>  --> 
	  <dl class="mem-set mem">
	  	<dt>账户设置</dt>
	    <dd>
	    	<p><a href="openUpdateUserName?openid=${openid}" class="clearfix"><span class="floatl"><i class="icon-user"></i>${user.userName}</span><em class="floatr">修改<i class="icon-chevron-right"></i></em></a></p>
	        <p><a href="openUpdatePwd?openid=${openid}" class="clearfix"><span class="floatl"><i class="icon-edit"></i>修改支付密码</span><em class="floatr">修改<i class="icon-chevron-right"></i></em></a></p>        
	    </dd>
	  </dl>
	  <!--下导航-->
	  <%@include file="footer.jsp" %>
	  <!--nav-on-bottom下导航结束--> 
	</div>
	<!--body--> 

</body>
</html>

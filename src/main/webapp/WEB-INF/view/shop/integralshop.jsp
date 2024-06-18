<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>积分商城</title>
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
	  <h2 class="score-top">积分礼品商城</h2>
	  <ul class="score-list clearfix">
	  	<c:forEach items="${gifts}" var="g">
	    <li class="floatl"><a href="exchange?openid=${openid}&pid=${g.pid}" class="score-img"><img src="${g.imgurl}" class="border-gray" alt="${g.pname}"></a>
	      <h3>${g.pname}</h3>
	      <p class="score-con">需要积分${g.integral}分</p>
	      <p><a href="exchange?openid=${openid}&pid=${g.pid}" class="orange-btn">兑换</a></p>
	    </li>
	    </c:forEach>
	  </ul>
	  
	  <!--下导航-->
	 <%@include file="../front/footer.jsp" %>
	  <!--nav-on-bottom下导航结束--> 
	</div>
	<!--body--> 
	<script type="text/javascript">
		var msg = "${msg}";
		if(msg=="0"){
			$("h2").after("<p style='margin-top:120px; text-align:center;font-size:25px;'><i class='icon-gift'></i><br/><span style='position:relative;'>暂无礼品</span></p>")
		}
	</script>
</body>
</html>
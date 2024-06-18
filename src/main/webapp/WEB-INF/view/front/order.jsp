<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>您好！欢迎订桌</title>
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
		<script type="text/javascript" src="js/WdatePicker.js"></script>
	</head>

<body>
	
	<div class="body tablebg">
		<div class="clockbody"> 
		  	<a href="javascript:history.go(-1);" class="nback">返回</a>
		    <div class="clock"> <img src="images/clock.png" alt="钟"> </div>
		    <h3><img src="images/ninhao.png" alt="您好！欢迎订桌"></h3>
		    <p class="tnum">现在还空闲<b>10</b>张桌</p>
		    <form class="orderform" action="saveDweiInfo?openid=${openid}" method="post">
		      <p class="ydtxt clearfix"><span class="floatl">预订时间：</span>
		        <input id="d12" type="date" class="floatl" name="activetime"  onClick="WdatePicker()"/>
		       </p>
		      <p class="ydtxt clearfix"><span class="floatl">预订人数：</span>
		        <input type="text" class="floatl" name="personNum" placeholder="预定人数">
		      </p>
		      <p class="ydtxt clearfix"><span class="floatl">预订桌数：</span>
		        <input type="text" class="floatl" name="diskNum" placeholder="预定桌数">
		      </p>
		      <p class="ydtxt clearfix"><span class="floatl">手机号：</span>
		        <input type="text" class="floatl" name="mobile" placeholder="请输入手机号码">
		      </p>
		      <p class="ydtxt clearfix"><span class="floatl">姓名：</span>
		        <input type="text" class="floatl" name="name" placeholder="请输入姓名">
		      </p>
		      <p class="ydtxt clearfix"><span class="floatl">备注：</span>
		        <textarea type="text" class="floatl" rows="4" name="remark" placeholder="备注"></textarea>
		      </p>
		      <p class="ydbtn"><a href="javascript:$('#shade').toggleClass('on');" class="orange-btn">马上预订</a></p>
		      
		      <article id="shade" class="shade" onclick="$('#shade').toggleClass('on')">
		        <ul class="yd-detail">
			        <li>预订时间：<b id="time">0:00</b></li>
			        <li>预订人数：<b id="num">0人</b></li>
		        </ul>
		        <p class="detail-btn"><a class="fh">我反悔了</a>
		          <button type="submit" class="qd orange-btn">我确定了</button>
		        </p>
		      </article>
		    </form>
		    
		</div>
	  <!--clockbody--> 
	  <!--下导航-->
	  <%@include file="footer.jsp" %>
	  <!--nav-on-bottom下导航结束--> 
	</div>
	<!--body--> 
	<script>
		//非空检测
		$(".ydbtn").click(function(){
			var date = $("[name='activetime']").val();
			var pnum = $("[name='personNum']").val();
			$("#time").text(date);
			$("#num").text(pnum+"人");
			var diskNum = $("[name='diskNum']").val();
			var mobile = $("[name='mobile']").val();
			var name = $("[name='name']").val();
			
			if(date.length==0){
				alert("请选择预餐时间");
				return false;
			}else if(pnum.length==0){
				alert("请输入人数");
				return false;
			}else if(diskNum.length==0){
				alert("请输入桌数");
				return false;
			}else if(mobile.length==0){
				alert("请输入手机号码");
				return false;
			}else if(name.length==0){
				alert("请输入姓名");
				return false;
			}else {
				return true;
			}
		})
		
		//提示
		var msg = "${msg}";
		if(msg=="1"){
			alert("预定成功!");
		}
		if(msg=="0"){
			alert("预定失败!");
		}
	</script>
</body>
</html>
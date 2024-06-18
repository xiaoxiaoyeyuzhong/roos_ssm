<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<title>申请成为VIP</title>
		<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
		<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
		<link rel="stylesheet" type="text/css" href="css/mui.css">
		<link rel="stylesheet" type="text/css" href="css/font-awesome.css">
		<link rel="stylesheet" type="text/css" href="css/style.css" />
		<script type="text/javascript">
		   var _global = {};
			   _global.spm = {};
			   
		document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {WeixinJSBridge.call('hideToolbar');});
		</script>
		<script type="text/javascript" src="js/mui.js"></script> 
		<script type="text/javascript" src="js/jquery-2.0.3.min.js"></script>
	</head>

<body>
	<div class="body login-bg">
	    <p class="login-logo"><img src="images/logo.png" alt="logo"></p>
	    <div id="msg"></div>
	    <h2 class="login-tit">VIP注册</h2>
	    <div class="login-div">
	      <form action="regMember" method="post">
	        <p class="clearfix">
	        	<span class="floatl">用户名：</span>
	        	<em class="floatr">
		          	<input type="text" class="ltxt floatl" name="userName" placeholder="请输入用户名" />
		          	<input type="hidden" name="openid" value="${openid}" />
	          	</em>
	          	<span style="position:absolute;right:60px;color:red;" id="show_uname"></span>
	        </p>
	        <p class="clearfix">
		        <span class="floatl">昵 称：</span>
		        <em class="floatr">
		          	<input type="text" class="ltxt floatl" name="nike" placeholder="请输入昵称" />
		        </em>
		        <span style="position:absolute;right:60px;color:red;" id="show_nike"></span>
	        </p> 
	        <p class="clearfix">
		        <span class="floatl">手 机：</span>
		        <em class="floatr">
		          	<input type="text" class="ltxt floatl" name="phone" placeholder="请输入你的手机号" />
		        </em>
		        <span style="position:absolute;right:60px;color:red;" id="show_phone"></span>
	         </p>
	        <p class="clearfix">
		        <span class="floatl">密 码：</span>
		        <em class="floatr">
		          	<input type="password" class="ltxt floatl" name="pwd" placeholder="请输入6位支付密码" />
		        </em>
	        </p>
	        <p class="lbtn" style=" text-align:center;">
	          <input type="submit" class="orange-btn lbtn-dl" value="注 册">
	          </p>
	      </form>
	    </div>
	 
	  <!--下导航-->
	  <%@include file="footer.jsp" %>
	  <!--nav-on-bottom下导航结束-->  
	</div>
	<!--body-->
	
	<script>
		
		var msg = "${msg}";
		if(msg=="1"){
			mui.alert("注册成功","恭喜你!",function(){
				//链接到我的会员
				window.location.href="openmember?openid=${openid}";
				return;
			});
		}
		if(msg=="2"){
			mui.alert("亲，您已经是我们的会员","温馨提示",function(){
				//链接到我的会员
				window.location.href="myVipMember?openid=${openid}";
				return;
			})
		}
		
		var msg = "${msg}";
		if(msg=="0"){
			$("#msg").html("<p style='text-align:center;color:red;font-size:20px;width:100%;'>你还不是VIP会员，请注册成为VIP会员</p>")
		}
		if(msg=="1"){
			mui.alert("亲，你已经是VIP会员了，查看我的VIP会员中心","",function(){
				window.location.href="openmember?openid=${openid}";
			})
		}
		
		//非空检测
		$(".lbtn-dl").click(function(){
			var userName = $("[name='userName']").val();
			var nike = $("[name='nike']").val();
			var phone = $("[name='phone']").val();
			var pwd = $("[name='pwd']").val();
			//正则表达式验证
			var reg = /^[0-9]\d{5}$/;
			var tel = /^1[345789]\d{9}$/;
			
			if(userName.length==0){
				mui.toast("请输入用户名");
				$("[name='userName']").focus();
				return false;
			}else if(nike.length==0){
				mui.toast("请输入昵称");
				$("[name='nike']").focus();
				return false;
			}else if(!tel.test(phone)){
				mui.toast("请输入正确格式的手机号码");
				$("[name='phone']").focus();
				return false;
			}else if(!reg.test(pwd)){
				mui.toast("请输入6位支付密码");
				return false;
			}else{
				return true;
			}
		});
		//验证重复数据
		//用户名
		$("[name='userName']").change(function(){
			var username = $(this).val();
			$.post("checkuser",function(data){
				for (var i= 0; i < data.length; i++) {
					if(data[i].userName==username){
						$("#show_uname").text("已被注册");
						$("[name='userName']").val("").focus();
						break;
					}else{
						$("#show_uname").html("<font style='color:green;font-weight:bolder;'>通过</font>");
					}
				}
			});
		});
		//昵称
		$("[name='nike']").change(function(){
			var nike = $(this).val();
			$.post("checkuser",function(data){
				for (var i= 0; i < data.length; i++) {
					if(data[i].nike==nike){
						$("#show_nike").text("已被注册");
						$("[name='nike']").val("").focus();
						break;
					}else{
						$("#show_nike").html("<font style='color:green;font-weight:bolder;'>通过</font>");
					}
				}
			});
		});
		//手机号码
		$("[name='phone']").change(function(){
			var phone = $(this).val();
			$.post("checkuser",function(data){
				for (var i= 0; i < data.length; i++) {
					if(data[i].phone==phone){
						$("#show_phone").text("已被注册");
						$("[name='phone']").val("").focus();
						break;
					}else{
						$("#show_phone").html("<font style='color:green;font-weight:bolder;'>通过</font>");
					}
				}
			});
		});
	</script>
</body>
</html>

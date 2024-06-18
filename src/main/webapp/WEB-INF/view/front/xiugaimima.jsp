<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>修改支付密码</title>
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
	<div class="body">
	<h3 class="fn-tit"><a href="javascript:history.go(-1);" class="nback">返回</a><b class="tit">修改密码</b></h3>
	  <div class="jf-body">
	  	<div class="edit">
	    	<p>手机号：</p>
	        <p><input type="text" class="etxt" name="phone" placeholder="请输入你的手机号" /></p>
	        <p>新密码：</p>
	        <p><input type="password" class="etxt" name="newPwd1" placeholder="请输入新密码"/></p>
	        <p>确认新密码：</p>
	        <p><input type="password" class="etxt" name="newPwd2" placeholder="请再次输入新密码" /></p>
	        <p class="tips">密码长度为6个数字，请妥善保管</p>
	        <p><input type="submit" class="ebtn orange-btn" value="确 定"></p>
	    </div>
	  </div>
	  <!--下导航-->
	 <%@include file="footer.jsp" %>
	  <!--nav-on-bottom下导航结束-->
	</div>
	<!--body--> 
	<script>
		//如果当前用户不是会员
		var msg = "${msg}";
		if(msg=="0"){
			mui.alert("你还不是会员,没有权限进行操作",function(){
				window.location.href="queryMyOrder?openid=${openid}";
			})
		}
		
		//异步提交
		$(".ebtn").click(function(){
			
			var phone = $("[name='phone']").val();
			var newPwd1 = $("[name='newPwd1']").val();
			var newPwd2 = $("[name='newPwd2']").val();
			//正则表达式验证
			var tel = /^1[345789]\d{9}$/;
			var pwd = /^[0-9]\d{5}$/;
			
			if(!tel.test(phone)){
				mui.toast("请输入注册的手机号码");
				$("[name='phone']").focus();
			}else if(!pwd.test(newPwd1)){
				mui.toast("请输入6位新密码");
				$("[name='newPwd1']").focus();
			}else if(!pwd.test(newPwd2)){
				mui.toast("请再次输入6位新密码");
				$("[name='newPwd2']").focus();
			}else if(newPwd1!=newPwd2){
				mui.toast("两次输入密码不一致");
				$("[name='newPwd2']").focus();
			}else{
				$.post("updatePwd",{phone:phone,newPwd:newPwd2,openid:"${openid}"},function(data){
					if(data=="1"){
						mui.alert("修改成功!",function(){
							window.location.href="queryMyOrder?openid=${openid}";
						})
					}
					if(data=="-1"){
						mui.alert("你输入的手机号码不匹配","修改失败!",function(){
							window.location.href="openUpdatePwd?openid=${openid}";
						})
					}
				})
			}
		})
	</script>
</body>
</html>
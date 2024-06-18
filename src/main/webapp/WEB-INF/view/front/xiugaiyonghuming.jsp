<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>修改用户名</title>
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
	<h3 class="fn-tit"><a href="javascript:history.go(-1);" class="nback">返回</a><b class="tit">修改用户名</b></h3>
	  <div class="jf-body">
	  	<div class="edit">
	    	<p>用户名：</p>
	        <p><input type="text" class="etxt" name="yhm" value="${user.userName}" /></p>
	        <p class="tips">以中文或英文字母开头，限4-16个字符，一个汉字为两个字符</p>
	        <p><input type="submit" class="ebtn orange-btn" value="确 定"></p>
	    </div>
	  </div>
  	<!--下导航-->
  	<%@include file="footer.jsp"%>
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
		
	
		$(".ebtn").click(function(){
			var userName = $("[name='yhm']").val();
			if(userName.length==0){
				mui.alert("请输入要修改的用户名");
				$("[name='yhm']").focus();
			}else{
				$.post("updateUserName",{openid:"${openid}",userName:userName},function(data){
					if(data=="1"){
						mui.alert("修改成功!",function(){
							window.location.href="queryMyOrder?openid=${openid}";
						})
					}
					if(data=="-1"){
						mui.alert("修改失败!",function(){
							window.location.href="openUpdateUserName?openid=${openid}";
						})
					}
				})
			}
		})
	</script>
</body>
</html>
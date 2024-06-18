<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0"/>
		<link type="text/css" href="css/style.css" rel="stylesheet"/>
		<link type="text/css" href="css/card.css" rel="stylesheet"/>
		<script type="text/javascript" src="js/jquery-2.0.3.min.js"></script>
		<title>会员余额消费</title>
	</head>
<body>
	<div class="mui-content">
	    <div class="model-input">
	    	<form action="gopasswordbox" method="post">
			<div class="model-body">
				<div class="model-body-tile"><p>你当前账户余额：${amount}元</p></div>
				<div class="model-body-content">消费金额<br/><br/>
					<p><span>&yen;</span><input type="text" name="amount" placeholder="输入金额" /></p>
					<p><input type="hidden" name="openid" value="${openid}" /></p>
					<p id="msg"></p>
				</div>
			</div>
			<div class="model-footer">
				<button type="submit" id="tj">确 定</button>
			</div>
			</form>
		</div>
	</div>
	
	<script type="text/javascript">
		$("#tj").click(function(){
			var amount = $("[name='amount']").val();
			var reg = /^[1-9][0-9]*$/;
			if(amount.length==0){
				$("[name='amount']").focus();
				return false;
			}else if(!reg.test(amount)){
				$("[name='amount']").val("");
				$("[name='amount']").attr("placeholder","非法数据");
				return false;
			}else{
				return true;
			}
		});
		//判断余额是否充足
		$("[name='amount']").blur(function(){
			var money =parseInt("${amount}");
			var amount = $("[name='amount']").val();
			var reg = /^[1-9][0-9]*$/;
			if(amount.length==0){
				$("[name='amount']").focus();
			}else if(!reg.test(amount)){
				$("[name='amount']").val("");
				$("[name='amount']").attr("placeholder","非法数据");
				$("[name='amount']").focus();
			}else if(amount>money){
				$("#tj").attr("disabled","true").css({"background":"#ccc","color":"#F5FFFA"});
				$("#msg").html("<font style='color:red;'>你当前余额不足</font>");
			}
		});
	</script>
</body>
</html>
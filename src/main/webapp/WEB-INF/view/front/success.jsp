<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
		<title>交易详情</title>
		<link rel="stylesheet" type="text/css" href="css/mui.css" />
		<style type="text/css">
			.mui-title {
				text-align: left;
			}
			.tik{
				color:green;
				font-weight: bolder;
			}
			.mui-radio input[type='radio']:checked:before, .mui-checkbox input[type='checkbox']:checked:before{
				color: green;
			}
			.ccc{
				font-weight: bolder;color:black;
			}
			.ddd{
				margin-top: 30px;
			}
			.mui-bar{
				height:60px;padding-top:10px;
			}
		</style>
	</head>

	<body>
		<header class="mui-bar mui-bar-nav">
			<div class="mui-input-row mui-checkbox mui-left">
				<label class="tik">支付成功</label>
				<input  type="checkbox" checked="checked" >
			</div>
			
		</header>
		<div class="mui-content">
			<div style="margin:50px auto;padding-bottom:30px;border-bottom: 1px solid #ccc;">
				<p class="ccc mui-text-center">微信支付</p>
				<p class="ccc mui-text-center" style="font-size: 25px;">￥${count}</p>
				<p class="mui-text-center ddd" style="font-size: 25px;">
					<a href="queryMyOrder?openid=${openid}">点击查看订单</a></p>
			</div>
			<div class="mui-text-center">东莞市湘中阁餐饮有限公司</div>
			<div class="mui-text-center"style="margin-top:20px;">
				<img src="images/weixin.png"width="40%"/>
			</div>
		</div>
	</body>
</html>
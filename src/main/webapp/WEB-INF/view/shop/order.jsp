<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1, user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<link rel="stylesheet" type="text/css" href="css/mui.css" />
		<title>礼品订单</title>
		<style type="text/css">
			.userInfo {
				margin:10px;
				padding:5px;
				background: #F4F4F4;
				border: #ccc dashed 1px;
				border-radius: 5px;
				font-size:12px;
			}
			.userInfo .mui-address {
				margin-top: 10px;
			}
			.mui-table-view .mui-media-object{
				max-width:102px;
				line-height:102px;
				height:102px;
			}
			#myorder{
				margin:20px 10px;
			}
			.mui-media-body p{
				line-height: 45px;
				color:#575757;
			}
			.mui-content-padd{
				position:fixed;bottom:53px;
				height:40px;width:100%;
				background:#F4F4F4;
				padding:10px 20px;
				font-size:16px;color:#8B7B8B;
			}
			.mui-content-padd span{color:red;}
		</style>
	</head>

	<body>
		<div class="mui-content">
			<div class="userInfo">收货信息
				<div class="mui-row mui-address">
					<div class="mui-col-xs-6">姓名：${address.userName}</div>
					<div class="mui-col-xs-6">手机：${address.mobile}</div>
				</div>
				<div class="mui-row mui-address">收货地址：${address.address}</div>
			</div>
			<ul class="mui-table-view" id="myorder">
				<li class="mui-table-view-cell mui-media">
					<a href="javascript:;">
						<img class="mui-media-object mui-pull-left" src="${gift.imgurl}">
						<div class="mui-media-body">
							<p class='mui-ellipsis'>${gift.pname}</p>
							<p class='mui-show_price'>
								<span class="mui-pull-left">${gift.integral}积分</span>
								<span class="mui-pull-right">x${gift.number}</span>
							</p>
						</div>
					</a>
				</li>
			</ul>
		</div>
		<div class="mui-content-padd">需抵扣你 <span> ${gift.integral} </span> 积分</div>
		<nav class="mui-bar mui-bar-tab">
			<a class="mui-tab-item" style="color:#8B7B8B">应付运费：
		        <span class="mui-tab-label" style="color:red;">${gift.postage}元</span>
		    </a>
		    <a href="payPostage?openid=${openid}&pid=${gift.pid}" class="mui-tab-item" style="background:#F4A460">
		        <span class="mui-tab-label" style="color:white;">确定支付</span>
		    </a>
		</nav>
		
		<script>
			mui("body").on('tap','a',function(){document.location.href=this.href;})
		</script>
	</body>

</html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8"/>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1, user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		
    	<link href="css/mui.css" rel="stylesheet"/> 
    	<script src="js/jquery-2.0.3.min.js"></script>
		<title>我的账单记录</title>
		<style type="text/css">
			.mui-media-body{
				width:30%;
				margin-left:20%;
			}
			.mui-media-right{
				float:right;
				width:160px;
				margin-top:-35px;
				margin-right: px;
			}
			.mui-media-object{
				border-radius: 50px;
			}
			.mui-ellipsis{
				font-size:12px;
				font-weight: bolder;
				color:black;
			}
			.mui-ellipsis span{
				font-size: 12px;
				color: red;
			}
			.mui-row li{
				list-style: none;
			}
			.tile{
				padding-top:10px;
				padding-left:10px;
			}
			.mui-btn{
				height: 40px;
				padding-top:6px;
				margin-top:8px;
				opacity: 0.6;
				width:90%;
				margin-left:5%;
			}
		</style>
	</head>
	<body>
		<header class="mui-bar mui-bar-nav">
		    <h1 class="mui-title"><b>钱来钱往</b></h1>
		</header>
		<div class="mui-content">
			<p class="tile">最新<span id="zs">10</span>条记录</p>
			<ul class="mui-table-view">
				<c:forEach items="${notes}" var="n">
			    <li class="mui-table-view-cell mui-media">
			        <a href="javascript:;">
			            <img class="mui-media-object mui-pull-left" src="images/c_icon.png">
			            <div class="mui-media-body">
			                <p class="mui-ellipsis"><font class="change">充值：</font><span class="blank">${n.recordBill}</span></p>
			            </div>
			            <div class="mui-media-body">
			                <p class="mui-ellipsis">余额：<span>${n.money}元</span></p>
			            </div>
			            <div class="mui-media-body mui-media-right">
			                <p class="mui-ellipsis">日期：${n.createTime}</p>
			            </div>
			        </a>
			    </li>
			  </c:forEach>
			</ul>
			<a href="findAllNote?openid=${openid}" class="mui-btn mui-btn-primary mui-btn-block">查看全部</a>
		</div>
		<script>
			$(function(){
				$("li").each(function(i){
					var money = $(this).find(".blank").text();
					if(money[0]=="-"){
						$(this).find(".change").text("消费：");
						$(this).find(".mui-media-object").attr("src","images/rmb_icon.png")
					}
				})
				
				//获取显示总记录数
				var len = $("li").length;
				$("#zs").text(len);
				
				var msg = "${msg}";
				if(msg=="ok"){
					$(".tile").text("全部账单信息  共"+len+"条记录");
					$(".mui-btn").hide();
				}
				var len = "${len}";
				if(len=="0"){
					$(".mui-content").hide();
					$("header").after(
						"<div class='mui-content'style='padding:30%;'>"
						+"<span style='font-size:140px;opacity: 0.4;' class='mui-icon mui-icon-chatboxes'></span>"
						+"<br><span style='margin-left:30px;'>没有记录</span></div>"
					)
				}
			});
		</script>
	</body>
</html>

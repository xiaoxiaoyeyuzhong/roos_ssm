<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
		<title>订单中心</title>
		<link rel="stylesheet" type="text/css" href="css/mui.css"/>
		<link rel="stylesheet" type="text/css" href="css/font-awesome.css">
		<link rel="stylesheet" type="text/css" href="css/style.css" />
		<script type="text/javascript" src="js/mui.js"></script>
		<script type="text/javascript" src="js/jquery-2.0.3.min.js"></script>
		<!--jquery开始--->
		<script type="text/javascript">
			var _global = {};
			_global.spm = {};

			document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
				WeixinJSBridge.call('hideToolbar');
			});
		</script>
		<!--jquery结束--->
	</head>
	<body>
		<header class="mui-bar mui-bar-nav">
		    <a class="mui-btn  mui-btn-link mui-pull-left" style="color:red;">湘中阁餐饮连锁</a>
		    <a class="mui-btn  mui-btn-link mui-pull-right" onclick="toggle()" id="banji"style="color:red;">编辑</a>
		</header>
		<div class="mui-content">
			<div id="msg" style="width:200px; height:500px;margin:30px auto;display:none;">
				<img src="images/cart.png" height="200"/>
				<p style="text-align:center;margin-top:30px;">购物车里没有商品，<a href="opentypeList?openid=${openid}">去逛逛吧!</a></p>
			</div>
			<ul id="OA_task_1" class="mui-table-view">
				<c:forEach items="${carts}" var="cart">
				<li class="mui-table-view-cell">
					<div class="mui-slider-right mui-disabled">
						<a class="mui-btn mui-btn-red delete">删除</a>
						<input type="hidden"  value="${cart.fid}" />
					</div>
				
					<div class="mui-slider-handle">
						<div style="width:15%;float: left;">
							<img src="${cart.food.picurl}" />
						</div>
						
						<div class="aa">
							${cart.food.foodName}
							<span class="price">${cart.food.foodPrice}元</span>
							<div class="mui-numbox mui-pull-right" data-numbox-min='1' data-numbox-max='9'>
								<button class="mui-btn mui-btn-numbox-minus" type="button">-</button>
								<input  class="mui-input-numbox" type="number" value="1" />
								<button class="mui-btn mui-btn-numbox-plus" type="button">+</button>
							</div>
						</div>
					</div>
				</li>
				</c:forEach>
			</ul>
			<div class="mui-content-padded">
			    <ul>
			    	<li class="li_left">总金额：<span id="count">0.00元</span></li>
			    	<li class="li_right"><input type="button" onclick="submit();" value="去结算" /></li>
			    </ul>
			</div>
			<div class="mui-content-padded" style="display:none;">
			    <ul>
			    	<li class="li_left">删除全部<span id="count"></span></li>
			    	<li class="li_right"><input type="button" onclick="delAll();" value="确定" /></li>
			    </ul>
			</div>
		</div>
		<div style="margin-bottom:90px;"></div>
		<!--下导航-->
		<%@include file = "footer.jsp" %>
		<!--nav-on-bottom下导航结束-->
		
		<script>
		(function($) {
			$('#OA_task_1').on('tap', '.delete', function(event) {
					var elem = this;
					var li = elem.parentNode.parentNode;
					var fid =elem.nextElementSibling.value
					
					mui.confirm('确认删除该条记录？', '湘中阁', btnArray, function(e) {
						if (e.index == 0) {
							$.post("deletecart",{openid:"${openid}",fid:fid},function(data){
								if(data=="ok"){
									li.parentNode.removeChild(li);
									count(); //调用计算总金额方法
									var len = li.length
									
									if(len==0){
										msg.style.display="block";
										//$("").css("display","block");
									}
								}
							})
						} else {
							setTimeout(function() {
								$.swipeoutClose(li);
							}, 0);
						}
					});
				});
			})(mui);
			var btnArray = ['确认', '取消'];
			
			
			
			//求当前订单的总金额“count”
			count();
			function count() {
				var count=0;
				$("#OA_task_1").children("li").each(function(){
					count += parseInt($(this).find(".price").text())*parseInt($(this).find(".mui-input-numbox").val());
				});
				$("#count").text(count+".00元");
			}
			//点击加号计算总金额
			$(".mui-btn-numbox-plus").click(function(){
				var numbox =$(this).parent().find(".mui-input-numbox");
					numbox.val(parseInt(numbox.val())+1);
				count();
			})
			//点击减号计算总金额
			$(".mui-btn-numbox-minus").click(function(){
				var numbox =$(this).parent().find(".mui-input-numbox");
				if(parseInt(numbox.val())==1){
					return;
				}else{
					numbox.val(parseInt(numbox.val())-1);
					count();
				}
			})
			
			
			//删除购物车所有信息
			function toggle(){
				$(".mui-content-padded").toggle();
				if(banji.innerHTML=="编辑"){
					banji.innerHTML="完成";
				}else{
					banji.innerHTML="编辑";
				}
			}
			
			function delAll(){
				var len = $("#OA_task_1").children("li").length;
				$("#OA_task_1").children("li").each(function(i){
					var fid = $("[type='hidden']").eq(i).val();
					
					$.post("deletecart",{openid:"${openid}",fid:fid},function(data){
						if(data=="ok"){
							if(len-1==i){
								window.location.href="queryAllCart?openid=${openid}";
							}
						}
						
					})
				})
			}
			
			
			
			
			//提交订单
			function submit(){
				var len = $("#OA_task_1").children("li").length;
				if(len=="0"){
					mui.toast("你还没有任何菜品，去逛逛吧!");
				}else{
					mui.toast("提交中...");

					var orderfos = [];
					$("#OA_task_1").children("li").each(function(i){
						var fid = $("[type='hidden']").eq(i).val();
						var num = $("[type='number']").eq(i).val();
						var orderfo =  {openid:"${openid}",fid:fid,number:num};
						orderfos.push(orderfo)
					})
					//生成订单获orderid
					$.ajax({
						url: "newOrder",
						type: "POST",
						contentType: "application/json",
						data: JSON.stringify({openid:"${openid}",odf:orderfos}),// 转换为JSON
						dataType: "json",
						success:function(data){
							console.log("data.msg",data)
							if(data.msg=="ok"){
									window.location.href="toPayPage?openid=${openid}&orderid="+data.orderid;
							}
						}
					})
				}
			}
			
			
			//当购物车没有商品
			var nocart ="${nocart}";
			if(nocart=="0"){
				$("#msg").css("display","block");
			}
		</script>
	</body>
</html>

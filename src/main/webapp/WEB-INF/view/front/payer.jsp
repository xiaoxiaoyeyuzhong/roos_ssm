<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
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
		<div class="mui-content">
			<div class="mui-card" style="margin-bottom:25px;">
				<ul class="mui-table-view">
					<c:forEach items="${orderFos}" var="o">
					<li class="mui-table-view-cell mui-media">
						<a href="javascript:;">
							<img class="mui-media-object mui-pull-left" src="${o.food.picurl}">
							<div class="mui-media-body">
								${o.food.foodPrice}元
								<p class='mui-ellipsis'>${o.food.foodName}
									<span style="margin-left:20%;">${o.number}份</span>
								</p>
							</div>
						</a>
					</li>
					</c:forEach>
				</ul>
			</div>
			<div class="mui-input-row" >
				<label class="mui-navigate-right" href="javascript:;">选择店面：</label>
				<select name="select" id="shop">
					<option value="-1" selected="true">--未选择店面--</option>
					<c:forEach items="${shop}" var="s">
					<option value="${s.id}">${s.shopName }</option>
					</c:forEach>
				</select>
			</div>
			<div class="mui-input-row">
			    <label>到店日期：</label>
			    <input type="date"  id="mydate">
			</div>
			<div class="mui-input-row">
			    <label>到店时间：</label>
			    <input type="time" id="mytime">
			</div>	
			<div class="mui-input-row" >
				<label class="mui-navigate-right" href="javascript:;">支付方式：</label>
				<select name="select" id="select_k1">
					<option value="1">到店支付</option>
					<option value="2" selected="true">支付宝支付</option>
				</select>
			</div>
			<div class="mui-content-padded">
			    <ul>
			    	<li class="li_left">总金额：<span id="count">${amount}元</span></li>
			    	<li class="li_right"><input type="button" onclick="submit();" id="pay" value="确定提交" /></li>
			    </ul>
			</div>
		</div>
		<div style="margin-bottom:90px;"></div>
		<!--下导航-->
		<%@include file="footer.jsp" %>
		<!--nav-on-bottom下导航结束-->
		<script>
//		(function($) {
// 			$('#OA_task_1').on('tap', '.delete', function(event) {
// 					var elem = this;
// 					var li = elem.parentNode.parentNode;
// 					mui.confirm('确认删除该条记录？', '湘中阁', btnArray, function(e) {
// 						if (e.index == 0) {
// 							li.parentNode.removeChild(li);
// 							count(); //调用计算总金额方法
// 						} else {
// 							setTimeout(function() {
// 								$.swipeoutClose(li);
// 							}, 0);
// 						}
// 					});
// 				});
// 			})(mui);
// 			var btnArray = ['确认', '取消'];
			
			//提交订单
			function submit(){
				//首先判断客户所选的付款方式
				var payment = $("#select_k1").val();
				if(payment==1){
					//到店付
					var date = $("#mydate").val();
					var time = $("#mytime").val();
					var shopid = $("#shop").val();
					if(date.length==0){
						mui.toast("请选择就餐日期");
					}else if(time.length==0){
						mui.toast("请选择就餐时间");
					}else if(shopid=="-1"){
						mui.toast("请选择用餐店面");
					}
					else{
						var eatdate =date+" "+time; 
						$.post("changePaymentState",{shopid:shopid,eatdate:eatdate,openid:"${openid}",orderid:"${orderid}"},function(data){
							if(data=="ok"){
								mui.alert("提交成功!","湘中阁",function(){
									window.location.href="queryMyOrder?openid=${openid}";
								});
							}
						})
					}	
					
				}else if(payment==2){
					//支付宝支付
					var date = $("#mydate").val();
					var time = $("#mytime").val();
					var shopid = $("#shop").val();
					if(date.length==0){
						mui.toast("请选择就餐日期");
					}else if(time.length==0){
						mui.toast("请选择就餐时间");
					}else if(shopid=="-1"){
						mui.toast("请选择用餐店面");
					}else{
						var eatdate = date+" "+time;
						window.location.href="payOrder?openid=${openid}&orderid=${orderid}&eatdate="+eatdate+"&shopid="+shopid;
					}
				}
			}
			//选择支付方式
			select_k1.onchange=function() {
				var payer = select_k1.value;
				if(payer=="2"){
					pay.value="去支付";
				}
			}
		</script>
	</body>
</html>

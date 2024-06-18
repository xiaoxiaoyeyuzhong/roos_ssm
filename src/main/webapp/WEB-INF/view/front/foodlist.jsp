<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

	<head>
		<title>菜品列表</title>
		<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
		<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
		<link rel="stylesheet" type="text/css" href="css/font-awesome.css">
		<link rel="stylesheet" type="text/css" href="css/style.css" />
		<script type="text/javascript">
			var _global = {};
			_global.spm = {};

			document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
				WeixinJSBridge.call('hideToolbar');
			});
		</script>
		<script type="text/javascript" src="js/jquery-2.0.3.min.js"></script>
		<script type="text/javascript">
			$(document).ready(function() {
				$(".dci").click(function() {
					$(this).toggleClass("selected");
				});
			});
			
		</script>
	</head>

	<body>

		<div class="body">
			<div class="topsearch">
				<form class="clearfix">
					<input type="button" class="sbtn icon-search">
					<input type="text" name="keys" id="keys" class="stxt"  value="寻找菜品、店面">
					<a href="queryAllCard?openid=${openid}" title="我的订单" class="floatr"></a>
				</form>
			</div>
			<!--topsearch-->
			<div class="container">
				<ul class="assort clearfix">
					<li class="ast1 floatl ast-cur">
						<a href="#" id="msg">${ftype.typeName}<i class="icon-caret-down"></i></a>
					</li>
					<!--<li class="ast2 floatl"><a href="#">特色菜<i class="icon-caret-down"></i></a></li>
					     <li class="ast3 floatl"><a href="#">店长推荐<i class="icon-caret-down"></i></a></li>
					     <li class="ast4 floatl"><a href="#">精品上市<i class="icon-caret-down"></i></a></li>
					 -->
				</ul>
				<!--assort-->
				<ul class="foodlist">
				<c:forEach items="${ftype.foods}" var="f">
					<li>
						<h3 class="tit"><a href="javascript:void(0);">${f.foodName}</a></h3>
						<div class="foodintro clearfix">
							<a href="javascript:void(0);" class="foodimg floatl"><img src="${f.picurl}" height="150px" alt="菜品图片"></a>
							<div class="foodcon floatl">
								<p>单价：<b style="color:red;">￥${f.foodPrice}</b></p>
								<p class="fts orange">VIP：￥${f.foodVIP}</p>
							<!--<p>制作时间：<b>10分钟</b></p> -->
								<p>可获积分：<b>${f.integral}分</b></p>
								<p>特点：<b>${f.feature}</b></p>
								<p><b></b></p>
								<p class="btn fts clearfix">
									<a href="javascript:addcart('${f.fid}');" class="floatl orange-btn">点菜</a>
									<i class="icon-ok floatl dci"></i>
									<input type="hidden" value="${f.fid}" />
								</p>
							</div>
							<!--foodcon-->
						</div>
						<!--foodintro
						<p class="fcomment clearfix"> <span class="floatl"><a href="#"><i class="icon-thumbs-up"></i>赞<em>215</em></a></span> <span class="floatl"><a href="#"><i class="icon-comment"></i>评论<em>15</em></a></span> <span class="floatl" style="border-right:0; border-right:none;"><a href="#"><i class="icon-share-alt"></i>转发</a></span> </p>
						<em class="lt ltred">特色<br>推荐</em>-->
					</li>
				</c:forEach>
				</ul>
				<!--<p class="fenye clearfix">
					<a href="#" class="floatl clearfix"><i class="icon-caret-left floatl"></i><span class="floatl">上一页</span></a>
					<a href="#" class="floatr clearfix"><i class="icon-caret-right floatr"></i><span class="floatr">下一页</span></a>
				</p> -->
			</div>
			<!--container-->
			<!--下导航-->
			<%@include file="footer.jsp" %>
			<!--nav-on-bottom下导航结束-->
		</div>
		<!--body-->
		<script>

 			$(".orange-btn").click(function(){
				var fid = $(this).parent().find("[type='hidden']").val();
				var btn = $(this);
				//异步提交
				$.post("addcart",{openid:"${openid}",fid:fid},function(data){
					if(data=="ok"){
						//获取前当对象自身的宽高
						var width = btn.width();
						var height = btn.height();
						//获取前当对象的在浏览器中的坐标
						var left = btn.offset().left;
						var top = btn.offset().top;
						//alert(left+"\t"+top);
						//复制前当对象
						var clone_obj = btn.clone();
					
						//获取底部菜单中“订单”这个按钮的坐标
						var order_left = $("#orderid").offset().left;
						var order_top = $("#orderid").offset().top;
						
						//给当前对象的复制品添加样式，然后appendto到body,最后自定义动画animate让它飞
						clone_obj.css({
							'width':width,
							'height':height,
							'position':'absolute',
							'left':left,
							'top':top,
							'z-index':'1000'
						}).appendTo("body").animate({
							'left':order_left,
							'top':order_top,
							'width':'48',
							'height':'20',
							'z-index':'1000',
							'opcity':'0.5'
						},500,function() {
							clone_obj.fadeOut(500);
						})
					}
				})				
			})
			var ft = "${ft}";
			if(ft=="[]"){
				alert("1");
				$("#msg").text("暂无商品");
			}
		</script>
		
	</body>

</html>
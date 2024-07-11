<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>管理中心</title>
		<link rel="stylesheet" href="css/bootstrap.css"/>
		<link rel="stylesheet" href="css/back.css"/>
		<script src="js/jquery-2.0.3.min.js"></script>
		<script src="js/bootstrap.js"></script>
	</head>
	<body>
		<nav class="navbar navbar-inverse">
		    <div class="container-fluid">
			    <div class="navbar-header">
			      <a class="navbar-brand" href="#"><b>管理员中心</b></a>
			    </div>
			   <ul class="nav navbar-nav navbar-right">
		          <li><a href="#"><b>退出</b></a></li>
		      </ul>
	      </div>
		</nav>
		<div class="container-fluid">
			<div class="row">
				<%@ include file="menu.jsp" %>
				<div class="col-sm-10">
					<p class="text-center title">礼 品 信 息</p>
					<ul class="nav nav-tabs" role="tablist">
						 <li role="presentation"><a href="queryUndeliveredGifts?page=1">未处理订单</a></li>
						 <li role="presentation" class="active"><a href="queryDeliveredGifts?page=1">已处理订单</a></li>
					</ul>
					<table class="table">
						<tr>
							<td>序号</td>
							<td>下单日期</td>
							<td>礼品图标</td>
							<td>礼品名称</td>
							<td>礼品积分</td>
							<td>礼品数量</td>
							<td>运费</td>
							<td>订单状态</td>
							<td>操作</td>
						</tr>
						<%int i=0; %>
						<c:forEach items="${giftorder}" var="go">
						<%i++; %>
						<tr class="infos">
							<td class="aa"><%=i %></td>
							<td class="aa">${go.createTime}</td>
							<td><img src="${go.gift.imgurl}" width="64"/></td>
							<td class="aa">${go.gift.pname}</td>
							<td class="aa">${go.gift.integral}分</td>
							<td class="aa">${go.gift.number}</td>
							<td class="aa">${go.gift.postage}元</td>
							<td class="aa">${go.state}</td>
							<td class="aa">
								<a href="javascript:showAddress('${go.openid}');">收货信息</a>\&nbsp;&nbsp;
							</td>
						</tr>
						</c:forEach>
					</table>
					<!-- 收货地址显示区 开始-->
					<div class="row show_my_address">
						<div class="show_address_content">
							<div class="text-center row-title">客户收货信息
								<button class="pull-right"><span class="close">&times;</span></button>
							</div>
							<div class="row-body">
								<p>收货人：<span id="username"></span></p>
								<p>手机号：<span id="mobile"></span></p>
								<div class="pull-left">收货地址：</div>
								<div class="pull-right" id="address"></div>
							</div>
						</div>
						
					</div>
					<!-- 收货地址显示区 结束-->
				</div>
				<!-- 分页 -->
				<div class="row text-center">
					<nav>
						 <ul class="pagination">
						    <li><a href="javascript:void(0);" onclick="pre();">&laquo;上一页</a></li>
						    <li><a href="javascript:void(0);">当前第<span id="num">1</span>页</a></li>
						    <li><a href="javascript:void(0);" onclick="next();">下一页&raquo;</a></li>
						    <li><a href="javascript:void(0);">总页数</a></li>
						     <li><a href="javascript:void(0);">${countPage}页</a></li>
						 </ul>
					</nav>
				</div>
			</div>
		</div>
		<script>
			var msg = "${msg}";
			if(msg=="1"){
				alert("删除成功!");
				window.location.href="queryAllgift";
			}
			if(msg=="0"){
				alert("删除失败！");
			}
			
			var size = "${size}";
			if(size=="0"){
				$(".table tr").hide();
				$(".table").html("<p class='text-center'style='color:red;font-size:22px;margin-top:150px;'>目前没有订单</p>");
			}
			
			
			
			//查看收货信息
			function showAddress(openid){
				$.post("getUserAddress",{openid:openid},function(data){
					$("#username").text(data.userName);
					$("#mobile").text(data.mobile);
					$("#address").text(data.address);
					$(".show_my_address").fadeIn();
				});
			}
			
			//关闭收货信息窗口
			$(".pull-right").click(function(){
				$(".show_my_address").fadeOut();
			})
			
			//分页
			//上一页
			function pre(){
				var page = $("#num").text();
				if(page==1){
					return;
				}else{
					$("#num").text(page-1);
					page = $("#num").text();
					$.post("querylipinyichuliOrderPage",{page:page},function(data){
						var str;
						$(".infos").remove();
						var j = (page-1)*8;
						for(var i=0;i<data.length;i++){
							var str =str+"<tr class='infos'>"
											+"<td class='aa'>"+(j+i+1)+"</td>"
											+"<td class='aa'>"+data[i].createTime+"</td>"
											+"<td><img src='"+data[i].gift.imgurl+"' width='64'/></td>"
											+"<td class='aa'>"+data[i].gift.pname+"</td>"
											+"<td class='aa'>"+data[i].gift.integral+"分</td>"
											+"<td class='aa'>"+data[i].gift.number+"</td>"
											+"<td class='aa'>"+data[i].gift.postage+"元</td>"
											+"<td class='aa'>"+data[i].state+"</td>"
											+"<td class='aa'>"
												+"<a href='javascript:showAddress("+data[i].openid+");'>收货信息</a>&nbsp;"
											+"</td>"
										+"</tr>"
						}
						$(".table tr:eq(0)").after(str);
					})
				}
			}
			//下一页
			function next(){
				var page =parseInt($("#num").text());
				if(page=="${countPage}"){
					return;
				}else{
					$("#num").text(page+1);
					page = $("#num").text();
					$.post("querylipinyichuliOrderPage",{page:page},function(data){
						var str;
						$(".infos").remove();
						var j = (page-1)*8;
						for(var i=0;i<data.length;i++){
							var str =str+"<tr class='infos'>"
											+"<td class='aa'>"+(j+i+1)+"</td>"
											+"<td class='aa'>"+data[i].createTime+"</td>"
											+"<td><img src='"+data[i].gift.imgurl+"' width='64'/></td>"
											+"<td class='aa'>"+data[i].gift.pname+"</td>"
											+"<td class='aa'>"+data[i].gift.integral+"分</td>"
											+"<td class='aa'>"+data[i].gift.number+"</td>"
											+"<td class='aa'>"+data[i].gift.postage+"元</td>"
											+"<td class='aa'>"+data[i].state+"</td>"
											+"<td class='aa'>"
												+"<a href='javascript:showAddress("+data[i].openid+");'>收货信息</a>&nbsp;"
											+"</td>"
										+"</tr>"
						}
						$(".table tr:eq(0)").after(str);
					})
				}
			}
		</script>
	</body>
</html>

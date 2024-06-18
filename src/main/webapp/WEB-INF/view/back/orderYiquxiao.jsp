<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
		<style type="text/css">
			.detail{
				height:150px;
				display:;
			}
			
		</style>	
	</head>
	<body>
		<nav class="navbar navbar-inverse">
		    <div class="container-fluid">
			    <div class="navbar-header">
			      <a class="navbar-brand" href="#"><b>管理员中心</b></a>
			    </div>
			   <ul class="nav navbar-nav navbar-right">
		          <li><a href="exit"><b>退出</b></a></li>
		      </ul>
	      </div>
		</nav>
		<div class="container-fluid">
			<div class="row">
				<%@ include file="menu.jsp" %>
				<div class="col-sm-10">
					<p class="text-center title">购买清单信 息</p>
					<ul class="nav nav-tabs" role="tablist">
						<li role="presentation" class="active"><a href="openOrderManager?page=1&isexpend=未消费">未处理订单</a></li>
						<li role="presentation"><a href="openOrderManager?page=1&isexpend=已消费">已处理订单</a></li>
						<li role="presentation"><a href="openOrderManager?page=1&isexpend=已取消">已取消订单</a></li>
					</ul>
					<div style="margin-bottom:50px;"></div>
					<table class="table">
						<tr>
							<td>序号</td>
							<td>订单编号</td>
							<td>支付状态</td>
							<td>支付方式</td>
							<td>到店时间</td> 
							<td>用餐地点</td>
							<td style="color:red;">订单状态</td>
							<td>操作</td>
							
						</tr>
						<%int i=0; %>
						<c:forEach items="${orders}" var="o">
						<%i++; %>
						<tr class="infos">
							<td><%=i %></td>
							<td>${o.orderid}</td>
							<td>${o.state}</td>
							<td>${o.payment}</td>
							<td>${o.eatdate}</td>
							<td>${o.shop.shopName}</td>
							<td style="color:red;font-weight:bolder;" class="state">${o.isexpend}</td>
							<td>
								<a href="openOrderContent?page=1&orderid=${o.orderid}">订单详情</a> \ 
								<a href="queryUserInfo?openid=${o.openid}" style="color:black;">客户信息</a>
							</td>
						</tr>
						
						</c:forEach>
					</table>
					<div id="msg" style="text-align: center;margin-top:150px;"></div>
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
			if(msg=="0"){
				$("#msg").html("<b style='color:red;font-size:34px;'>目前还没有订单</b>")
			}
			
			//分页
			//上一页
			function pre(){
				var page = $("#num").text();
				if(page==1){
					return;
				}else{
					$("#num").text(page-1);
					page = $("#num").text();
					$.post("queryOrdersTurnPagesByIsexpend",{page:page,isexpend:"已取消"},function(data){
						var str;
						$(".infos").remove();
						var j = (page-1)*10;
						for(var i=0;i<data.length;i++){
							var str =str+"<tr class='infos'>"
											+"<td>"+(j+i+1)+"</td>"
											+"<td>"+data[i].orderid+"</td>"
											+"<td>"+data[i].state+"</td>"
											+"<td>"+data[i].payment+"</td>"
											+"<td>"+data[i].eatdate+"</td>"
											+"<td>"+data[i].shop.shopName+"</td>"
											+"<td style='color:red;font-weight:bolder;' class='state'>"+data[i].isexpend+"</td>"
											+"<td>"
												+"<a href='openOrderContent?page=1&orderid="+data[i].orderid+"'>订单详情</a> \ "
												+"<a href='queryUserInfo?openid="+data[i].openid+"' style='color:black;'>客户信息</a>"
											+"</td>"
										+"</tr>;"
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
					$.post("queryOrdersTurnPagesByIsexpend",{page:page,isexpend:"已取消"},function(data){
						var str;
						$(".infos").remove();
						var j = (page-1)*10;
						for(var i=0;i<data.length;i++){
							var str =str+"<tr class='infos'>"
											+"<td>"+(j+i+1)+"</td>"
											+"<td>"+data[i].orderid+"</td>"
											+"<td>"+data[i].state+"</td>"
											+"<td>"+data[i].payment+"</td>"
											+"<td>"+data[i].eatdate+"</td>"
											+"<td>"+data[i].shop.shopName+"</td>"
											+"<td style='color:red;font-weight:bolder;' class='state'>"+data[i].isexpend+"</td>"
											+"<td>"
												+"<a href='openOrderContent?page=1&orderid="+data[i].orderid+"'>订单详情</a> \ "
												+"<a href='queryUserInfo?openid="+data[i].openid+"' style='color:black;'>客户信息</a>"
											+"</td>"
										+"</tr>;"
						}
						$(".table tr:eq(0)").after(str);
					})
				}
			}
		</script>
	</body>
</html>

<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
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
					<p class="text-center title">湘中阁分店信息</p>
					<table class="table">
						<tr>
							<td>分店图</td>
							<td>分店名</td>
							<td>分店电话</td>
							<td>分店地址</td>
							<td>操作</td>
						</tr>
						<c:forEach items="${shops}" var="s">
						<tr>
							<td><img src="${s.imgurl}" width="100"></td>
							<td>${s.shopName}</td>
							<td>${s.telphone}</td>
							<td>${s.address}</td>
							<td><a href="openUpdateShop?id=${s.id}">修改</a>\<a href="javascript:deleteShop('${s.id}')">删除</a></td>
						</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
		<script>
			function deleteShop(id){
				if(confirm("确定要删除吗?")){
					$.post("deleteShopInfo",{id:id},function(data){
						if(data=="1"){
							alert("删除成功");
							window.location.href="queryShopInfo";
						}
					})
				}
			}
		</script>
	</body>
</html>

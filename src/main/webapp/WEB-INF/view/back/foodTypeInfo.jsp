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
					<p class="text-center title">菜 品 分类信 息</p>
					<table class="table">
						<tr>
							<td>菜品编号</td>
							<td>分类名称</td>
							<td>操作</td>
						</tr>
						<c:forEach items="${ftlist}" var="ft">
						<tr>
							<td>${ft.typeid}</td>
							<td>${ft.typeName}</td>
							<td><a href="openupdatefoodType?typeid=${ft.typeid}">修改</a>\<a href="javascript:if(confirm('确定要删除吗?')) window.location.href='deletefoodTypeInfo?typeid=${ft.typeid}'">删除</a></td>
						</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			var msg = "${msg}";
			if(msg=="1"){
				alert("删除成功！");
				//返回到所有菜品分类信息列表
				window.location.href="queryAllfoodType";
			}
			if(msg=="0"){
				alert("删除失败!");
			}
		</script>
	</body>
</html>

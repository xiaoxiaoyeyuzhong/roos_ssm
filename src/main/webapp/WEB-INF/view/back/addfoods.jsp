<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>添加菜品信息</title>
		<link rel="stylesheet" href="css/bootstrap.css"/>
		<link rel="stylesheet" href="css/back.css"/>
		<script src="js/jquery-2.0.3.min.js"></script>
		<script src="js/bootstrap.js"></script>
		<script>
			var msg = "${msg}";
			if(msg=="1"){
				alert("添加成功");
				//返回到商品分类列表
				window.location.href="queryAllfood?typeid=0";
			}
			if(msg=="0"){
				alert("添加失败！");
			}
		</script>
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
					<div class="addbox">
						<p><b>添加菜品信息</b></p>
						<form action="addfood" method="post" enctype="multipart/form-data">
						<div class="form-group form-inline">
							<div class="input-group">
								<label class="control-label input-group-addon">商品名称：</label>
								<input type="text" class="form-control" name="foodName" />
							</div>
						</div>
						<div class="form-group form-inline">
							<div class="input-group">
								<label class="control-label input-group-addon">商品描述：</label>
								<input type="text" class="form-control" name="feature" />
							</div>
						</div>
						<div class="form-group form-inline">
							<div class="input-group">
								<label class="control-label input-group-addon">商品积分：</label>
								<input type="text" class="form-control" name="integral" />
							</div>
						</div>
						<div class="form-group form-inline">
							<div class="input-group">
								<label class="control-label input-group-addon">商品价格：</label>
								<input type="text" class="form-control" name="foodPrice" />
								<span class="input-group-addon">￥</span>
							</div>
						</div>
						<div class="form-group form-inline">
							<div class="input-group">
								<label class="control-label input-group-addon">V I P价格：</label>
								<input type="text" class="form-control" name="foodVIP" />
								<span class="input-group-addon">￥</span>
							</div>
						</div>
						<div class="form-group form-inline">
							<div class="pic"><img src="" width="100%"/></div>
							<input type="file" name="file" />
						</div>
						<div class="form-group form-inline">
							<select id="type" name="typeid" class="form-control">
								<option value="-1">未选择菜品类型</option>
							<c:forEach items="${ftlist}" var="ft">
								<option value="${ft.typeid}">${ft.typeName}</option>
							</c:forEach>
							</select>
						</div>
						
						<div class="form-group save">
							<input type="submit" class="btn btn-success" value="保存" />
							<input type="reset" class="btn btn-default quxiao" value="取消" />
						</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<script>
		
			//非空检测
			$(".btn-success").click(function(){
				var fname = $("[name='foodName']").val();
				var feature = $("[name='feature']").val();
				var integral = $("[name='integral']").val();
				var price = $("[name='foodPrice']").val();
				var vip = $("[name='foodVIP']").val();
				var file = $(":file").val();
				var type = $("#type").val();
				if(fname.length==0){
					alert("请输入菜品名称");
					$("[name='foodName']").focus();
					return false;
				}else if(feature.length==0){
					alert("请输入菜品描述");
					$("[name='feature']").focus();
					return false;
				}else if(integral.length==0){
					alert("请输入积分");
					$("[name='integral']").focus();
					return false;
				}else if(price.length==0){
					alert("请输入菜吕价格");
					$("[name='foodPrice']").focus();
					return false;
				}else if(vip.length==0){
					alert("请输入菜品VIP价格");
					$("name='foodVIP'").focus();
					return false;
				}else if(file.length==0){
					alert("请选择一张菜品图片");
					return false;
				}else if(type==-1){
					alert("请选择菜品分类");
					return false;
				}else{
					return true;
				}
				
			})
		</script>
	</body>
</html>

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>修改商品信息</title>
		<link rel="stylesheet" href="css/bootstrap.css"/>
		<link rel="stylesheet" href="css/back.css"/>
		<script src="js/jquery-2.0.3.min.js"></script>
		<script src="js/bootstrap.js"></script>
		<script>
			var msg = "${msg}";
			if(msg=="1"){
				alert("修改成功");
				//返回到商品分类列表
				window.location.href="queryAllfood?typeid=0";
			}
			if(msg=="0"){
				alert("修改失败！");
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
		          <li><a href="#"><b>退出</b></a></li>
		      </ul>
	      </div>
		</nav>
		<div class="container-fluid">
			<div class="row">
				<%@ include file="menu.jsp" %>
				<div class="col-sm-4">
					<div class="addbox">
						<p><b>修改商品信息</b></p>
						<form action="updatefood" method="post" enctype="multipart/form-data">
						
						<div class="form-group form-inline">
							<div class="input-group">
								<label class="control-label input-group-addon">商品名称：</label>
								<input type="text" class="form-control" name="foodName" value="${food.foodName}" />
							</div>
						</div>
						<div class="form-group form-inline">
							<div class="input-group">
								<label class="control-label input-group-addon">商品描述：</label>
								<input type="text" class="form-control" name="feature" value="${food.feature}" />
							</div>
						</div>
					
						<div class="form-group form-inline">
							<div class="input-group">
								<label class="control-label input-group-addon">商品价格：</label>
								<input type="text" class="form-control" name="foodPrice" value="${food.foodPrice}" />
								<span class="input-group-addon">￥</span>
							</div>
						</div>
						<div class="form-group form-inline">
							<div class="input-group">
								<label class="control-label input-group-addon">VIP价格：</label>
								<input type="text" class="form-control"  name="foodVIP" value="${food.foodVIP }" />
								<span class="input-group-addon">￥</span>
							</div>
						</div>
						<div class="form-group form-inline">
							<div class="input-group">
								<label class="control-label input-group-addon">商品积分：</label>
								<input type="text" class="form-control" name="integral" value="${food.integral }" />
								<span class="input-group-addon">分</span>
							</div>
						</div>
						<div class="form-group form-inline">
							<div style="display:none;">
								<input type="hidden" name="fid" value="${food.fid}" />
								<input type="hidden" name="picurl" value="${food.picurl}" />
							</div>
							<div class="pic"><img src="${food.picurl}" width="100%" height="150px" /></div>
							<input type="file" name="file" />
						</div>
						<div class="form-group form-inline">
							<select name="typeid" id="type" class="form-control">
								<option value="-1">未选择任何分类</option>
							<c:forEach items="${ftlist}" var="ft">
								<option value="${ft.typeid}">${ft.typeName}</option>
							</c:forEach>
							</select>
						</div>
						<div class="form-group save">
							<input type="submit" class="btn btn-success" value="保存" />
							<a href="javascript:history.go(-1);" class="btn btn-default quxiao" >取消</a>
						</div>
						</form>
					</div>
				</div>
					
			</div>
		</div>
		<script type="text/javascript">
			
			
			//改变下拉框的默认值
			var typeid = ${typeid};
			$("#type option[value='"+typeid+"']").attr("selected",true);
			
			//非空检测
			$(".btn-success").click(function(){
				var fname = $("[name='foodName']").val();
				var feature = $("[name='feature']").val();
				var integral = $("[name='integral']").val();
				var price = $("[name='foodPrice']").val();
				var vip = $("[name='foodVIP']").val();
				var typeid = $("#type").val();
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
				
				}else if(typeid==-1){
					alert("请选择菜品分类");
					return false;
				}else{
					return true;
				}
				
			})
		</script>
	</body>
</html>

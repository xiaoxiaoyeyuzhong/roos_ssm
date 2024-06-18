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
						<p><b>修改分店信息</b></p>
						<form action="updateShopInfo" method="post" enctype="multipart/form-data">
						
						<div class="form-group form-inline">
							<div class="input-group">
								<label class="control-label input-group-addon">分店名：</label>
								<input type="text" class="form-control" name="shopName" value="${shop.shopName}" />
								<input type="hidden" name="id" value="${shop.id }" />
							</div>
						</div>
						<div class="form-group form-inline">
							<div class="input-group">
								<label class="control-label input-group-addon">分店电话：</label>
								<input type="text" class="form-control" name="telphone" value="${shop.telphone}" />
							</div>
						</div>
					
						<div class="form-group form-inline">
							<div class="pic"><img src="${shop.imgurl}" width="100%" height="150px" /></div>
							<input type="file" name="file" />
							<input type="hidden" name="imgurl" value="${shop.imgurl}" />
						</div>
						<div class="form-group form-inline">
							<div class="input-group">
								<textarea rows="5" cols="40" name="address" placeholder="请输入分店地址">${shop.address}</textarea>
							</div>
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
			var msg = "${msg}";
			if(msg=="1"){
				alert("修改成功!");
				window.location.href="queryShopInfo";
			}
			if(msg=="0"){
				alert("修改失败");
			}
			//非空检测
			$(".btn-success").click(function(){
				var name = $("[name='shopName']").val();
				var tel = $("[name='telphone']").val();
				var address = $("[name='address']").val();
				if(name.length==0){
					alert("店名不能为空");
					$("[name='shopName']").focus();
					return false;
				}else if(tel.length==0){
					alert("分店电话不能为空");
					$("[name='telphone']").focus();
					return false;
				}else if(address.length==0){
					alert("分店地址不能为空");
					$("[name='address']").focus();
					return false;
				}else{
					return true;
				}
			})
		</script>
	</body>
</html>

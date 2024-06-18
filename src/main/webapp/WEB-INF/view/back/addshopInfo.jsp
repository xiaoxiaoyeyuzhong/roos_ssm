<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>添加分店信息</title>
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
		          <li><a href="exit"><b>退出</b></a></li>
		      </ul>
	      </div>
		</nav>
		<div class="container-fluid">
			<div class="row">
			<%@ include file="menu.jsp" %>
				<div class="col-sm-10">
					<div class="addbox">
						<p><b>添加分店信息</b></p>
						<form action="addShopInfo" method="post" enctype="multipart/form-data">
						<div class="form-group form-inline">
							<div class="input-group">
								<label class="control-label input-group-addon">分店名：</label>
								<input type="text" class="form-control" name="shopName" />
							</div>
						</div>
						<div class="form-group form-inline">
							<div class="input-group">
								<label class="control-label input-group-addon">分店电话：</label>
								<input type="text" class="form-control" name="telphone" />
							</div>
						</div>
						<div class="form-group form-inline">
							<div class="pic"><img src="" width="100%"/></div>
							<input type="file" name="file" />
							<span>图片规格：440px*188px</span>
						</div>
						<div class="form-group form-inline">
							<div class="input-group">
								<textarea rows="5" cols="40" name="address" placeholder="请输入分店地址"></textarea>
							</div>
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
			var msg = "${msg}";
			if(msg=="1"){
				alert("添加成功!");
				window.location.href="queryShopInfo";
			}
			if(msg=="0"){
				alert("添加失败");
			}
			
		</script>
	</body>
</html>

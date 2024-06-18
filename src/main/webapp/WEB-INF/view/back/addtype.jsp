<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>添加商品分类</title>
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
						<p><b>添加商品分类</b></p>
						<form action="addfoodType" method="post" enctype="multipart/form-data">
						<div class="form-group form-inline">
							<div class="input-group">
								<label class="control-label input-group-addon">分类名称：</label>
								<input type="text" class="form-control" name="typeName" />
							</div>
						</div>
						
						<div class="form-group form-inline">
							<lable>添加缩略图</lable>
							<div class="pic"><img src="" width="100%"/></div>
							<input type="file" name="file" />
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
				var typeName = $("[name='typeName']").val();
				var fileName = $(":file").val();
				if(typeName.length==0){
					alert("请输入商品分类名称");
					$("[name='typeName']").focus();
					return false;
				}else if(fileName.length==0){
					alert("请选择一张缩略图");
					return false;
				}else{
					return true;
				}
			})
			var msg = "${msg}";
			if(msg=="1"){
				alert("添加成功!");
				if(confirm("继续添加吗?")){
					window.location.href="openType";
				}else{
					window.location.href="queryAllfoodType";
				}
			}
		</script>
	</body>
</html>

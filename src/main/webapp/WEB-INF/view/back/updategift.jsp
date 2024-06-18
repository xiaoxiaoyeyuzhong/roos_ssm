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
						<p><b>修改礼品信息</b></p>
						<form action="updateGiftInfo" method="post" enctype="multipart/form-data">
						
						<div class="form-group form-inline">
							<div class="input-group">
								<label class="control-label input-group-addon">礼品名称：</label>
								<input type="text" class="form-control" name="pname" value="${gift.pname}" />
							</div>
						</div>
						<div class="form-group form-inline">
							<div class="input-group">
								<label class="control-label input-group-addon">礼品积分：</label>
								<input type="text" class="form-control" name="integral" value="${gift.integral}" />
								<span class="input-group-addon">(纯数字)</span>
							</div>
						</div>
					
						<div class="form-group form-inline">
							<div class="input-group">
								<label class="control-label input-group-addon">礼品数量：</label>
								<input type="text" class="form-control" name="number" value="${gift.number}" />
								<span class="input-group-addon">(可带单位)</span>
							</div>
						</div>
						
						<div class="form-group form-inline">
							<div style="display:none;">
								<input type="hidden" name="pid" value="${gift.pid}" />
								<input type="hidden" name="imgurl" value="${gift.imgurl}" />
							</div>
							<div class="pic"><img src="${gift.imgurl}" width="100%" height="150px" /></div>
							<span>图片规格：220px * 220px</span>
							<input type="file" name="file" />
						</div>
						<div class="form-group form-inline">
							<div class="input-group">
								<div>快递费</div>
								<textarea rows="3" cols="40" name="postage" placeholder="请输入邮费">${gift.postage}</textarea>
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
				window.location.href="queryAllgift";
			}
			if(msg=="0"){
				alert("修改失败");
			}
			
			//非空检测
			$(".btn-success").click(function(){
				var pname = $("[name='pname']").val();
				var integral = $("[name='integral']").val();
				var number = $("[name='number']").val();
				var postage = $("[name='postage']").val();
				
				var reg = /^[1-9][0-9]*$/;
				
				if(pname.length==0){
					alert("请输入礼品名称");
					return false;
				}else if(!reg.test(integral)){
					alert("请输入礼品积分");
					return false;
				}else if(number.length==0){
					alert("请输入礼品数量 ");
					return false;
				}else if(!reg.test(postage)){
					alert("请输入邮费");
					return false;
				}else{
					return true;
				}
				
			})
		</script>
	</body>
</html>

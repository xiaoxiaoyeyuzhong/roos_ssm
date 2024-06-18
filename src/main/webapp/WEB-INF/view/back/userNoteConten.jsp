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
		          <li><a href="exit"><b>退出</b></a></li>
		      </ul>
	      </div>
		</nav>
		<div class="container-fluid">
			<div class="row">
				<%@ include file="menu.jsp" %>
				<div class="col-sm-10">
					<p class="text-center title">商 品 信 息</p>
					<div class="form-group form-inline">
						<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon">第</span>
								<input type="text" id="page" class="form-control" placeholder="输入出页数" style="width:100px;"/>
								<span class="input-group-addon">页</span>
							</div>
							<button class="btn" onclick="submit()">查找 </button>
							
						</div>
						<a href="javascript:history.go(-1);" class="btn push-right" style="position:relative;left:70%;font-size:25px;color:#FF7F50">返回上一页</a>
					</div>
					
					<div style="padding-left:40px;">
						<ul class="nav nav-pills" role="tablist">
							<li role="presentation" class="active1"><a href="#">用户名：${user.userName}</a></li>
							<li role="presentation"><a href="#">手机：${user.phone}</a></li>
							<li role="presentation"><a href="#">会员号：XZG-${user.id}</a></li>
						</ul>
					</div>
					
					<table class="table">
						<tr>
							<td>编号</td>
							<td>账户进/出</td>
							<td>日期/时间</td>
							<td>余额</td>
							<td>操作</td>
						</tr>
							<%int i=0; %>
						<c:forEach items="${notes}" var="n">
								<%i++; %>
						<tr class="sa">
							<td><%=i %></td>
							<td style="color:red;"><span class="record">${n.recordBill}</span>元</td>
							<td>${n.createTime}</td>
							<td style="color:red;">${n.money}元</td>
							<td>
								<a href="javascript:;?openid=${n.openid}">暂无操作</a>
							</td>
						</tr>
						</c:forEach>
					</table>
				</div>
				<div class="row" style="text-align:center;font-size:20px;color:red;"><b>当前余额：${user.amount }元</b></div>
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
			
			//选择日期查询
			function submit(){
				var page = $("#page").val();
				if(page.length==0){
					alert("请输入页码数");
					$("#page").focus();
				}else if(page==0){
					alert("输入的页码数不能为零");
					$("#page").focus();
				}else{
					$.post("pagequeryNote",{page:page,openid:"${user.openid}"},function(data){
						var str;
						$(".sa").remove();
						var j = (page-1)*13;
						for(var i=0;i<data.length;i++){
							var str =str+"<tr class='sa'>"
										+"<td>"+(j+i+1)+"</td>"
										+"<td style='color:red;'>"+data[i].recordBill+"</td>"
										+"<td>"+data[i].createTime+"</td>"
										+"<td style='color:red;'>"+data[i].money+"</td>"
										+"<td>暂无操作</td>"
										+"</tr>";
						}
						$(".table tr:eq(0)").after(str);
					})
				}
			}
			
			
			//异步分页
			//上一页
			function pre(){
				var page = $("#num").text();
				if(page==1){
					return;
				}else{
					$("#num").text(page-1);
					page = $("#num").text();
					$.post("pagequeryNote",{page:page,openid:"${user.openid}"},function(data){
						var str;
						$(".sa").remove();
						var j = (page-1)*13;
						for(var i=0;i<data.length;i++){
							var str =str+"<tr class='sa'>"
										+"<td>"+(j+i+1)+"</td>"
										+"<td style='color:red;'>"+data[i].recordBill+"</td>"
										+"<td>"+data[i].createTime+"</td>"
										+"<td style='color:red;'>"+data[i].money+"</td>"
										+"<td>暂无操作</td>"
										+"</tr>";
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
					$.post("pagequeryNote",{page:page,openid:"${user.openid}"},function(data){
						var str;
						$(".sa").remove();
						var j = (page-1)*13;
						for(var i=0;i<data.length;i++){
							var str =str+"<tr class='sa'>"
										+"<td>"+(j+i+1)+"</td>"
										+"<td style='color:red;'>"+data[i].recordBill+"</td>"
										+"<td>"+data[i].createTime+"</td>"
										+"<td style='color:red;'>"+data[i].money+"</td>"
										+"<td>暂无操作</td>"
										+"</tr>";
						}
						$(".table tr:eq(0)").after(str);
					})
					//window.location.href="pagequery?page="+page;
				}
			}
		</script>
	</body>
</html>

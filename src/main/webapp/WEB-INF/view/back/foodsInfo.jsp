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
					<p class="text-center title">菜 品 信 息</p>
					<div class="form-group form-inline">
						<select id="type" name="typeid" class="form-control">
							<option value="-1">请选择菜品类型</option>
							<option value="0" selected=selected >所有菜品</option>
						<c:forEach items="${ftlist}" var="ft">
							<option value="${ft.typeid}">${ft.typeName}</option>
						</c:forEach>
						</select>
						<button class="btn" onclick="submit()">查找 </button>
					</div>
					<table class="table">
						<tr>
							<td>菜品编号</td>
							<td>菜品名称</td>
							<td>菜品分类</td>
							<td>菜品价格</td>
							<td>菜品积分</td>
							<td>菜品描述</td>
							<td>VIP价格</td>
							<td>操作</td>
						</tr>
						<c:forEach items="${foods}" var="f">
						<tr class="sa">
							<td>${f.fid}</td>
							<td>${f.foodName}</td>
							<td>${f.ft.typeName}</td>
							<td>${f.foodPrice}</td>
							<td>${f.integral}</td>
							<td>${f.feature}</td>
							<td>${f.foodVIP }</td>
							<td>
								<a href="queryfoodById?fid=${f.fid}&&typeid=${f.ft.typeid}">修改</a>
								<a href="javascript:if(confirm('确定要删除吗?')) window.location.href='deletefoodInfo?fid=${f.fid}'">删除</a>
							</td>
						</tr>
						</c:forEach>
					</table>
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
			if(msg=="1"){
				alert("删除成功!");
				//返回到菜品信息列表
				window.location.href="queryAllfood?typeid=0";
			}
			if(msg=="0"){
				alert("删除失败!");
			}
			
			
			
			//分类查询
			function submit(){
				var typeid = $("#type").val();
				if(typeid==-1){
					alert("请选择具体分类");
					return;
				}else if(typeid==0){
					window.location.href="queryAllfood?typeid="+typeid;
				}else{
					window.location.href="queryfoodByTypeid?typeid="+typeid;
				}
			}
			//改变下拉框的默认值
 			var typeid = "${typeid}";
			$("#type option[value='"+typeid+"']").attr("selected",true);
			
			//异步分页
			//上一页
			function pre(){
				var page = $("#num").text();
				if(page==1){
					return;
				}else{
					$("#num").text(page-1);
					page = $("#num").text();
					$.post("pagequery",{page:page,typeid:"${typeid}"},function(data){
						var str;
						$(".sa").remove();
						for(var i=0;i<data.length;i++){
							var str =str+"<tr class='sa'>"
										+"<td>"+data[i].fid+"</td>"
										+"<td>"+data[i].foodName+"</td>"
										+"<td>"+data[i].ft.typeName+"</td>"
										+"<td>"+data[i].foodPrice+"</td>"
										+"<td>"+data[i].integral+"</td>"
										+"<td>"+data[i].feature+"</td>"
										+"<td>"+data[i].foodVIP+"</td>"
										+"<td>"
											+"<a href='queryfoodById?fid="+data[i].fid+"&&typeid="+data[i].ft.typeid+"'>修改</a> "
											+" <a href='javascript:if(confirm(\"确定要删除吗?\")) window.location.href=\"deletefoodInfo?fid="+data[i].fid+"\"'> 删除</a></td>"
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
					$.post("pagequery",{page:page,typeid:"${typeid}"},function(data){
						var str;
						$(".sa").remove();
						for(var i=0;i<data.length;i++){
							var str =str+"<tr class='sa'>"
										+"<td>"+data[i].fid+"</td>"
										+"<td>"+data[i].foodName+"</td>"
										+"<td>"+data[i].ft.typeName+"</td>"
										+"<td>"+data[i].foodPrice+"</td>"
										+"<td>"+data[i].integral+"</td>"
										+"<td>"+data[i].feature+"</td>"
										+"<td>"+data[i].foodVIP+"</td>"
										+"<td>"
											+"<a href='queryfoodById?fid="+data[i].fid+"&&typeid="+data[i].ft.typeid+"'>修改</a>"
											+" <a href='javascript:if(confirm(\"确定要删除吗?\")) window.location.href=\"deletefoodInfo?fid="+data[i].fid+"\"'> 删除</a></td>"
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

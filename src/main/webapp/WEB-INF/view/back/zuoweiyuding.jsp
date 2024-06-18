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
		<style type="text/css">
			.detail{
				height:150px;
				display:;
			}
			
		</style>	
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
					<p class="text-center title">客户桌位预定信息</p>
					<table class="table">
						<tr>
							<td>编号</td>
							<td>到店时间</td>
							<td>预定人数</td>
							<td>预定桌数</td>
							<td>客户姓名</td> 	
							<td>客户电话</td>
							<td>备注</td> 
							<td style="color:red;">订单状态</td> 
							<td>确定订单</td>
							<td>操作</td>
						</tr>
						<%int i=0; %>
						<c:forEach items="${dweis}" var="dw">
						<%i++; %>
						<tr class="infos">
							<td><%=i %></td>
							<td>${dw.activetime}</td>
							<td>${dw.personNum}</td>
							<td>${dw.diskNum}</td>
							<td>${dw.name}</td>
							<td>${dw.mobile}</td>
							<td>${dw.remark}</td>
							<td style="color:red;font-weight:bolder;" class="state">${dw.state}</td>
							<td><button class="btn btn-danger" onclick="changeState('${dw.id}')">确定消费</button></td>
							<td><a href="queryUserInfo?openid=${dw.openid}" style="font-size:10px;">查看客户信息</a></td>
						</tr>
						
						</c:forEach>
					</table>
					<div id="msg" style="text-align: center;margin-top:150px;"></div>
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
			var x = "${x}";
			if(x=="0"){
				$("#msg").html("<b style='color:red;font-size:34px;'>目前还没有订单</b>")
			}
			
			//异步更改订单状态
			function changeState(id,openid){
				if(confirm("要确定消费吗")){
					$.post("OKyuding",{id:id,openid:openid},function(data){
						if(data=="1"){
							alert("已成功确定消费!");
							window.location.href="queryAllDweiInfo?page=1";
						}
						if(data=="0"){
							alert("确定不成功请重新确定!");
						}
					})
				}
			}
			
			$(".infos").each(function(i){
				var state = $(".state").eq(i).text();
				if(state=="已消费"||state=="已取消"){
					$(".btn-danger").eq(i).attr("disabled",true);
				}
			});
			
			//分页
			//上一页
			function pre(){
				var page = $("#num").text();
				if(page==1){
					return;
				}else{
					$("#num").text(page-1);
					page = $("#num").text();
					$.post("findyuyuezwByPage",{page:page},function(data){
						var str;
						$(".infos").remove();
						var j = (page-1)*10;
						for(var i=0;i<data.length;i++){
							var str =str+"<tr class='infos'>"
											+"<td>"+(j+i+1)+"</td>"
											+"<td>"+data[i].activetime+"</td>"
											+"<td>"+data[i].personNum+"</td>"
											+"<td>"+data[i].diskNum+"</td>"
											+"<td>"+data[i].name+"</td>"
											+"<td>"+data[i].mobile+"</td>"
											+"<td>"+data[i].remark+"</td>"
											+"<td style='color:red;font-weight:bolder;' class='state'>"+data[i].state+"</td>"
											+"<td>"
												+"<button class='btn btn-danger' onclick='changeState('"+data[i].id+"'>确定消费</button>"
											+"</td>"
											+"<td>"
												+"<a href='queryUserInfo?openid="+data[i].openid+"' style='color:black;'>客户信息</a>"
											+"</td>"
										+"</tr>;"
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
					$.post("findyuyuezwByPage",{page:page},function(data){
						var str;
						$(".infos").remove();
						var j = (page-1)*10;
						for(var i=0;i<data.length;i++){
							var str =str+"<tr class='infos'>"
											+"<td>"+(j+i+1)+"</td>"
											+"<td>"+data[i].activetime+"</td>"
											+"<td>"+data[i].personNum+"</td>"
											+"<td>"+data[i].diskNum+"</td>"
											+"<td>"+data[i].name+"</td>"
											+"<td>"+data[i].mobile+"</td>"
											+"<td>"+data[i].remark+"</td>"
											+"<td style='color:red;font-weight:bolder;' class='state'>"+data[i].state+"</td>"
											+"<td>"
												+"<button class='btn btn-danger' onclick='changeState('"+data[i].id+"')'>确定消费</button>"
											+"</td>"
											+"<td>"
												+"<a href='queryUserInfo?openid="+data[i].openid+"' style='color:black;'>客户信息</a>"
											+"</td>"
										+"</tr>;"
						}
						$(".table tr:eq(0)").after(str);
					})
				}
			}
		</script>
	</body>
</html>

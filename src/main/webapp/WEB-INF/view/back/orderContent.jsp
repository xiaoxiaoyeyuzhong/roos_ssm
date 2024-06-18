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
		          <li><a href="admin"><b>退出</b></a></li>
		      </ul>
	      </div>
		</nav>
		<div class="container-fluid">
			<div class="row">
				<%@ include file="menu.jsp" %>
				<div class="col-sm-10">
					<p class="text-center title">购买清单信 息</p>
					<div class="row" style="border-bottom:2px solid black;">
						<div class="col-md-5 title">合计金额：<span style="color:red;">${totalAmount}元</span></div>
						<div class="col-md-7 text-right title"><a href="javascript:history.go(-1);">返回上一页</a></div>
					</div>
					<c:forEach items="${orderFos}" var="o">
					<div class="row orderConten">
						<div class="col-md-1  text-center">订单编号
							<p class="text-center bb">${o.orderid}</p>
						</div>
						<div class="col-md-2 text-center">菜品图片
							<p class="text-center pictrue">
								<img src="${o.food.picurl}"width="70" height="70"/>
							</p>
						</div>
						<div class="col-md-3 text-center">菜品名称
							<p class="text-center bb">${o.food.foodName}</p>
						</div>
						<div class="col-md-2 text-center">菜品数量
							<p class="text-center bb">${o.number}份</p>
						</div>
						
						<div class="col-md-2 text-center">菜品价格
							<p class="text-center bb">&yen;${o.food.foodPrice}元</p>
						</div>
						<div class="col-md-2 text-center">总金额
							
							<p class="text-center bb">&yen;${o.sum_money}元</p>
						</div>
					</div>
					</c:forEach>
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
	</body>
	<script>
		//分页
		//上一页
		function pre(){
			var page = $("#num").text();
			if(page==1){
				return;
			}else{
				$("#num").text(page-1);
				page = $("#num").text();
				$.post("querydingdandetail",{orderid:"${orderid}",page:page},function(data){
					var str="";
					$(".orderConten").remove();
						for(var i=0;i<data.length;i++){
							str	+="<div class='row orderConten'>"
									+"<div class='col-md-1  text-center'>订单编号"
									+"<p class='text-center bb'>"+data[i].orderid+"</p>"
								+"</div>"
								+"<div class='col-md-2 text-center'>菜品图片"
									+"<p class='text-center pictrue'>"
										+"<img src='"+data[i].food.picurl+"' width='70' height='70'/>"
									+"</p>"
								+"</div>"
								+"<div class='col-md-3 text-center'>菜品名称"
									+"<p class='text-center bb'>"+data[i].food.foodName+"</p>"
								+"</div>"
								+"<div class='col-md-2 text-center'>菜品数量"
									+"<p class='text-center bb'>"+data[i].number+"份</p>"
								+"</div>"
								
								+"<div class='col-md-2 text-center'>菜品价格"
									+"<p class='text-center bb'>&yen;"+data[i].food.foodPrice+"元</p>"
								+"</div>"
								+"<div class='col-md-2 text-center'>总金额"
									+"<p class='text-center bb'>&yen;"+data[i].sum_money+"元</p>"
								+"</div>"
							+"</div>"
						}
					$(".col-sm-10 .row").after(str);
					
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
				$.post("querydingdandetail",{orderid:"${orderid}",page:page},function(data){
					var str="";
					$(".orderConten").remove();
					for(var i=0;i<data.length;i++){
						
						str	+="<div class='row orderConten'>"
								+"<div class='col-md-1  text-center'>订单编号"
								+"<p class='text-center bb'>"+data[i].orderid+"</p>"
							+"</div>"
							+"<div class='col-md-2 text-center'>菜品图片"
								+"<p class='text-center pictrue'>"
									+"<img src='"+data[i].food.picurl+"' width='70' height='70'/>"
								+"</p>"
							+"</div>"
							+"<div class='col-md-3 text-center'>菜品名称"
								+"<p class='text-center bb'>"+data[i].food.foodName+"</p>"
							+"</div>"
							+"<div class='col-md-2 text-center'>菜品数量"
								+"<p class='text-center bb'>"+data[i].number+"份</p>"
							+"</div>"
							
							+"<div class='col-md-2 text-center'>菜品价格"
								+"<p class='text-center bb'>&yen;"+data[i].food.foodPrice+"元</p>"
							+"</div>"
							+"<div class='col-md-2 text-center'>总金额"
								+"<p class='text-center bb'>&yen;"+data[i].sum_money+"元</p>"
							+"</div>"
						+"</div>"
					}
					$(".col-sm-10 .row").after(str);
					
				})
			}
		}
	</script>
</html>

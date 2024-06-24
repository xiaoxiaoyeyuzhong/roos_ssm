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
					<p class="text-center title">VIP会员信 息</p>
					<div class="row">
						<div class="col-md-3 title">当前会员总数：<span style="color:red;">${count}个</span></div>
						<div class="col-md-3">
							<div class="input-group">
								<span class="input-group-addon">手机号</span>
								<input type="text" name="phone" class="form-control" />
								<a href ="javascript:findUser();" class="btn input-group-addon">查找</a>
							</div>
						</div>	
						<div class="col-md-3"></div>
						<div class="col-md-3 text-center title"><a href="javascript:history.go(-1);">返回上一页</a></div>
					</div>
					<div style="height:40px;border-bottom:#ccc solid 1px;" id="show"></div>
					<% int i=0;%>
					<c:forEach items="${users}" var="u">
					<%i++; %>
					<div class="row orderConten">
						<div class="col-md-1 text-center">编号
							<p class="text-center bb"><%=i%></p>
						</div>
						<div class="col-md-1 text-center">用户名
							<p class="text-center bb">${u.userName}</p>
						</div>
						<div class="col-md-1 text-center">昵称
							<p class="text-center bb">${u.nike}</p>
						</div>
						<div class="col-md-1 text-center">手机号码
							<p class="text-center bb">${u.phone}</p>
						</div>
						
						<div class="col-md-1 text-center">会员类型
							<p class="text-center bb">${u.member}</p>
						</div>
						<div class="col-md-1 text-center">会员卡号
							<p class="text-center bb">${u.id}</p>
						</div>
						<div class="col-md-1 text-center">积分
							<p class="text-center bb">${u.integral}分</p>
						</div>
						<div class="col-md-1 text-center">会员余额
							<p class="text-center bb">${u.amount}元</p>
						</div>
						<div class="col-md-2 text-center">注册时间
							<p class="text-center bb">${u.createTime}</p>
						</div>
						<div class="col-md-1 text-center">操作
							<button class="btn" data-toggle="modal" data-target="#myModal" onclick="duihuan('${u.openid}')" style="margin-top:20px;">线下兑换</button>
						</div>
						<!--  
						<div class="col-md-1 text-center">操作
							<button class="btn" data-toggle="modal" data-target="#czModal" onclick="duihuan('${u.openid}')" style="margin-top:20px;">现金充值</button>
						</div>
						-->
					</div>
					</c:forEach>
					<!-- 线下兑换Small modal-start -->
					<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					  <div class="modal-dialog modal-sm">
					    <div class="modal-content">
							<div class="modal-header">
						        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
						        <h4 class="modal-title" id="myModalLabel">线下兑换礼品</h4>
						    </div>
						    <div class="modal-body">
						        <div class="input-group">
						        	<input type="text" class="form-control" name="integral" placeholder="请输入积分" />
						        	<span class="input-group-addon">分</span>
						        </div>
						    </div>
						    <div class="modal-footer">
						        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
						        <button class="btn btn-primary" onclick="isOK();">确定</button>
						    </div>
					    </div>
					  </div>
					</div>
					<!-- Small modal-end -->
					
					<!-- 线下充值Small modal-start -->
					<div class="modal fade" id="czModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					  <div class="modal-dialog modal-sm">
					    <div class="modal-content">
							<div class="modal-header">
						        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
						        <h4 class="modal-title" id="myModalLabel">线下现金充值</h4>
						    </div>
						    <div class="modal-body">
						    	<div class="btn-group">
								     <button type="button" class="btn btn-default">请选择分店名称</button>
								     <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
									     <span class="caret"></span>
									  </button>
									  <ul class="dropdown-menu" role="menu">
									      <li><a href="#">花园店</a></li>
									      <li><a href="#">京州店</a></li>
									      <li><a href="#">凤岗店</a></li>
									      <li><a href="#">长沙店</a></li>
									      <li><a href="#">清溪店</a></li>
									  </ul>
								</div>
						        <div class="input-group">
						        	<input type="text" class="form-control" name="money" placeholder="请输入充值金额" />
						        	<span class="input-group-addon">元</span>
						        </div>
						    </div>
						    <div class="modal-footer">
						        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
						        <button class="btn btn-primary" onclick="isOK();">确定</button>
						    </div>
					    </div>
					  </div>
					</div>
					<!-- Small modal-end -->
					
					<div id="msg" style="text-align:center;"></div>
				</div>	
				<!-- 分页 -->
				<div class="row text-center">
					<nav>
						 <ul class="pagination">
						     <li><a href="javascript:void(0);" onclick="pre();">&laquo;上一页</a></li>
						     <li><a href="javascript:void(0);">当前第<span id="num">1</span>页</a></li>
						     <li><a href="javascript:void(0);" onclick="next();">下一页&raquo;</a></li>
						     <li><a href="javascript:void(0);">总页数</a></li>
						     <li><a href="javascript:void(0);" id="dd">${countPage}页</a></li>
						 </ul>
					</nav>
				</div>
			</div>
		</div>
		<script>
			$(function(){
				var d = "${da}";
				if(d=="da"){
					$("#msg").html("<font style='color:red;font-size:25px;'>暂时没有任何员会信息</font>");
				}
			
			
				var msg = "${msg}";
				if(msg=="0"){
					$("#msg").html("<font style='color:red;font-size:25px;'>暂时没有任何员会信息</font>");
				}
			
				//隔行变色
				$(".orderConten:even").css("background","#FFFAFA");
				$(".orderConten:old").css("background","#F0FFF0");
				
				$('#myModal').modal(options)
			})
			//根据手机号码查询会员信息
			function findUser(){
				var phone = $("input[name='phone']").val();
				if(phone.length==0){
					alert("请输入手机号码");
				}else{
						window.location.href="queryMemberByPageAndPhone?page=1&phone="+phone;
				}
			}
			
			//线下兑换
			function duihuan(openid){
				console.log("duihuan function called with openid:", openid);

				// 清空旧的 sessionStorage.openid 值
				sessionStorage.removeItem('openid');

				// 设置新的 sessionStorage.openid 值
				sessionStorage.openid = openid;

				// 弹出提示，显示当前存储的 openid
				alert("Stored openid in sessionStorage: " + sessionStorage.openid);
			}
			
			//确定兑换
			function isOK(){
				var integral = $("input[name='integral']").val();
				var openid = sessionStorage.openid;
				var reg = /^[1-9][0-9]*$/;
				if(!reg.test(integral)){
					alert("请输入积分数");
				}else{
					$.post("userUpdateIntegral",{integral:integral,openid:openid},function(data){
						if(data=="ok"){alert("兑换成功!");window.location.href="queryMemberByPageAndPhone?page=1"}
						if(data=="no"){alert("兑换失败");}
						if(data=="0"){alert("你当前的积分不足，不能兑换");}
					});
				}
			}
			
			
			//分页
			//上一页
			function pre(){
				var page = $("#num").text();
				if(page==1){
					return;
				}else{
					$("#num").text(page-1);
					page = $("#num").text();
					$.post("queryMemberByPage",{page:page},function(data){
						var str ="";
						$(".orderConten").remove();
						var j = (page-1)*5;
						for(var i=0;i<data.length;i++){
							str	+="<div class='row orderConten'>"
								+"<div class='col-md-1 text-center'>编号"
									+"<p class='text-center bb'>"+(j+i+1)+"</p>"	
								+"</div>"
								+"<div class='col-md-1 text-center'>用户名"
									+"<p class='text-center bb'>"+data[i].userName+"</p>"	
								+"</div>"
								+"<div class='col-md-1 text-center'>昵称"	
									+"<p class='text-center bb'>"+data[i].nike+"</p>"	
								+"</div>"
								+"<div class='col-md-1 text-center'>手机号码"	
									+"<p class='text-center bb'>"+data[i].phone+"</p>"	
								+"</div>"	
								
								+"<div class='col-md-1 text-center'>会员类型"	
									+"<p class='text-center bb'>"+data[i].member+"</p>"	
								+"</div>"	
								+"<div class='col-md-1 text-center'>会员卡号"	
									+"<p class='text-center bb'>"+data[i].id+"</p>"	
								+"</div>"	
								+"<div class='col-md-1 text-center'>积分"	
									+"<p class='text-center bb'>"+data[i].integral+"分</p>"	
									+"</div>"
									+"<div class='col-md-1 text-center'>会员余额"	
									+"<p class='text-center bb'>"+data[i].amount+"元</p>"	
								+"</div>"
								+"<div class='col-md-2 text-center'>注册时间"	
									+"<p class='text-center bb'>"+data[i].createTime+"</p>"
								+"</div>"
								+"<div class='col-md-1 text-center'>操作"	
									+"<button class='btn' data-toggle='modal' data-target='#myModal' onclick='duihuan(\"" + data[i].openid + "\")' style='margin-top:20px;'>线下兑换</button>"
								+"</div>"
							+"</div>";
						}
						$(".col-sm-10 #show").after(str);
						$(".orderConten:even").css("background","#FFFAFA");
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
					$.post("queryMemberByPage",{page:page},function(data){
						var str="";
						$(".orderConten").remove();
						var j = (page-1)*5;
						for(var i=0;i<data.length;i++){
							str	+="<div class='row orderConten'>"
								+"<div class='col-md-1 text-center'>编号"
									+"<p class='text-center bb'>"+(j+i+1)+"</p>"	
								+"</div>"
								+"<div class='col-md-1 text-center'>用户名"
									+"<p class='text-center bb'>"+data[i].userName+"</p>"	
								+"</div>"
								+"<div class='col-md-1 text-center'>昵称"	
									+"<p class='text-center bb'>"+data[i].nike+"</p>"	
								+"</div>"
								+"<div class='col-md-1 text-center'>手机号码"	
									+"<p class='text-center bb'>"+data[i].phone+"</p>"	
								+"</div>"	
								
								+"<div class='col-md-1 text-center'>会员类型"	
									+"<p class='text-center bb'>"+data[i].member+"</p>"	
								+"</div>"	
								+"<div class='col-md-1 text-center'>会员卡号"	
									+"<p class='text-center bb'>"+data[i].id+"</p>"	
								+"</div>"	
								+"<div class='col-md-1 text-center'>积分"	
									+"<p class='text-center bb'>"+data[i].integral+"分</p>"	
								+"</div>"
									+"<div class='col-md-1 text-center'>会员余额"	
									+"<p class='text-center bb'>"+data[i].amount+"元</p>"	
								+"</div>"
								+"<div class='col-md-2 text-center'>注册时间"	
									+"<p class='text-center bb'>"+data[i].createTime+"</p>"
								+"</div>"
								+"<div class='col-md-1 text-center'>操作"	
										+"<button class='btn' data-toggle='modal' data-target='#myModal' onclick='duihuan(\"" + data[i].openid + "\")' style='margin-top:20px;'>线下兑换</button>"
								+"</div>"
							+"</div>";
						}
						$(".col-sm-10 #show").after(str);
						$(".orderConten:even").css("background","#FFFAFA");
					})
				}
			}
		</script>
	</body>
</html>

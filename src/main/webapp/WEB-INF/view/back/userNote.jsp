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
								<span class="input-group-addon">查询日期：</span>
								<input type="date" id="startDate" class="form-control"/>
							</div>
							<!--<div class="input-group">
								<span class="input-group-addon">结束日期：</span>
								<input type="date" id="endDate" class="form-control"/>
							</div>-->
						</div>
						
						<button class="btn" onclick="submit()">查找 </button>
						<a class="btn btn-primary" href="queryRechargeByPageAndtime?page=1"style="margin-left:40px;color:white;">查找所有 </a>
					</div>
					<table class="table">
						<tr>
							<td>编号</td>
							<td>用户名</td>
							<td>会员卡号</td>
							<td>手机</td>
							<td>充值金额</td>
							<td>充值时间</td>
							<td>余额</td>
							<td>操作</td>
						</tr>
						<%int i=0; %>
						<c:forEach items="${notes}" var="n">
						<%i++; %>
						<tr class="sa">
							<td><%=i %></td>
							<td>${n.user.userName}</td>
							<td>${n.user.id}</td>
							<td>${n.user.phone}</td>
							<td style="color:red;"><span class="record">${n.recordBill}</span>元</td>
							<td>${n.createTime}</td>
							<td style="color:red;">${n.user.amount}元</td>
							<td>
								<a href="queryUserNoteByPage?openid=${n.openid}&page=1">账单详情</a>
							</td>
						</tr>
						</c:forEach>
					</table>
				</div>
				<div class="row" style="text-align:center;font-size:20px;color:red;"><b>合计充值金额：<span id="sum_record">${sum}</span>元</b></div>
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
			if(msg=="0"){
				$(".table tr").hide();
				$(".table").html("<p style='color:red;margin-top:150px;text-align:center;font-size:30px;'>当前没有记录</p>")
			}
			
			var str = "${date}";
			if(str=="1"){
				$("#startDate").val(sessionStorage.startDate);
			}else{
				sessionStorage.clear();
			}
			
			//选择日期查询
			function submit(){
				var startDate = $("#startDate").val();
				//var endDate = $("#endDate").val();
				//h5sessionStorage存储
				sessionStorage.startDate =startDate;
				//sessionStorage.endDate =endDate;
				
				if(startDate.length==0){
					alert("请选择开始日期");
				}else{
					window.location.href="queryRechargeByPageAndtime?page=1&startDate="+startDate
				}
			}
			var startDate = "${startDate}";
			//异步分页
			//上一页
			function pre() {
				var page = parseInt($("#num").text());
				if (msg == "0" || page == 1) {
					return;
				} else {
					$("#num").text(page - 1);
					page = $("#num").text();
					$.post("queryRechargeByPage", { page: page, startDate: startDate }, function (data) {
						var str = ""; // 将str的定义移到循环外
						var j = (page - 1) * 5; // 每次显示5条
						for (var i = 0; i < data.length; i++) {
							str += "<tr class='sa'>" + // 使用+=进行字符串拼接
									"<td>" + (j + i + 1) + "</td>" +
									"<td>" + data[i].user.userName + "</td>" +
									"<td>" + data[i].user.id + "</td>" +
									"<td>" + data[i].user.phone + "</td>" +
									"<td style='color:red;'>" + data[i].recordBill + "元</td>" +
									"<td>" + data[i].createTime + "</td>" +
									"<td style='color:red;'>" + data[i].user.amount + "元</td>" +
									"<td><a href='queryUserNoteByPage?openid=" + data[i].openid + "&page=1'>账单详情</a></td>" +
									"</tr>";
						}
						$(".sa").remove(); // 移除旧的数据行
						$(".table tr:eq(0)").after(str); // 插入新的数据行
					});
				}
			}
			//下一页
			function next() {
				var page = parseInt($("#num").text());
				if (msg == "0" || page == "${countPage}") {
					return;
				} else {
					$("#num").text(page + 1);
					page = $("#num").text();
					$.post("queryRechargeByPage", { page: page, startDate: startDate }, function (data) {
						var str = ""; // 将str的定义移到循环外
						var j = (page - 1) * 5; // 每次显示5条
						for (var i = 0; i < data.length; i++) {
							str += "<tr class='sa'>" + // 使用+=进行字符串拼接
									"<td>" + (j + i + 1) + "</td>" +
									"<td>" + data[i].user.userName + "</td>" +
									"<td>" + data[i].user.id + "</td>" +
									"<td>" + data[i].user.phone + "</td>" +
									"<td style='color:red;'>" + data[i].recordBill + "元</td>" +
									"<td>" + data[i].createTime + "</td>" +
									"<td style='color:red;'>" + data[i].user.amount + "元</td>" +
									"<td><a href='queryUserNoteByPage?openid=" + data[i].openid + "&page=1'>账单详情</a></td>" +
									"</tr>";
						}
						$(".sa").remove(); // 移除旧的数据行
						$(".table tr:eq(0)").after(str); // 插入新的数据行
					});
				}
			}
		</script>
	</body>
</html>

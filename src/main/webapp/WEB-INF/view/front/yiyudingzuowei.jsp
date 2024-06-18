<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<title>已成交列表</title>
	<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
	<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
	<link rel="stylesheet" type="text/css" href="css/mui.css" />
	<link rel="stylesheet" type="text/css" href="css/font-awesome.css">
	<link rel="stylesheet" type="text/css" href="css/style.css" />
	<script type="text/javascript">
		var _global = {};
		_global.spm = {};

		document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {WeixinJSBridge.call('hideToolbar');});
	</script>
	<script type="text/javascript" src="js/mui.js"></script>
	<script type="text/javascript" src="js/jquery-2.0.3.min.js"></script>
</head>

<body>
<div class="body">
	<h3 class="fn-tit"><a href="javascript:history.go(-1);" class="nback">返回</a><b class="tit">已预定桌位明细</b></h3>
	<div id="msg"></div>
	<c:forEach items="${dweis}" var="dw">
		<div class="jf-body">
			<table width="100%" border="0">
				<tr>
					<th scope="col" align="center" width="15%">桌数</th>
					<th scope="col" align="left" width="25%">人数</th>
					<th scope="col" align="center" width="30%">到店时间</th>
					<th scope="col" align="center" width="15%">状态</th>
				</tr>

				<tr>
					<td align="center">${dw.diskNum}</td>
					<td align="left">${dw.personNum}</td>
					<td align="center">${dw.activetime}</td>
					<td align="center"><a href="javascript:void(0);" class="state">${dw.state}</a></td>
				</tr>
			</table>
			<div style="text-align:right;"><button onclick="changeState('${dw.id}','${dw.state}')">取消订单</button></div>
		</div>
	</c:forEach>
	<!--下导航-->
	<%@include file="footer.jsp" %>
	<!--nav-on-bottom下导航结束-->
</div>
<!--body-->
<script>
	var msg = "${msg}";
	if(msg=="0"){
		$("#msg").css("height","250");
		$("#msg").html("<p style='color:red;text-align:center;font-size:20px;margin-top:100px;'>你当前没有预定的桌位信息...</p>");
	}

	var state = $(".state").text();
	if(state=="已取消"){
		$("button").hide();
	}
	//用户取消未支付订单
	function changeState(id,state){
		if(state=="已消费"){
			alert("已消费订单不能取消!")
			return
		}
		var btnArray = ['否', '是'];
		mui.confirm("确定要取消订单吗?","温馨提示",btnArray,function(e){
			if(e.index==1){
				$.post("changeYudingState",{id:id},function(data){
					if(data=="1"){
						mui.alert("已取消",function(){
							window.location.href="queryDweiDetail?openid=${openid}";
						});
					}
				})
			}
		})
	}
</script>
</body>
</html>
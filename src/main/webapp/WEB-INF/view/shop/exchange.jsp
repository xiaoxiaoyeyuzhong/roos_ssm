<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
		<title>兑换中心</title>
		<link rel="stylesheet" type="text/css" href="css/mui.css"/>
		<link rel="stylesheet" type="text/css" href="css/font-awesome.css">
		<link rel="stylesheet" type="text/css" href="css/style.css" />
		<script type="text/javascript" src="js/mui.js"></script>
		<script type="text/javascript" src="js/jquery-2.0.3.min.js"></script>
		<!--jquery开始--->
		<script type="text/javascript">
			var _global = {};
			_global.spm = {};

			document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
				WeixinJSBridge.call('hideToolbar');
			});
		</script>
		<!--jquery结束--->
	</head>
	<body>
		<!-- 模态框-->
		<div id="model"></div>
		<!-- 模态框-->
		
		
		<div class="mui-content" style="height:650px;">
		    <p style="margin-top:18px;">
				<img src="${gift.imgurl}" height="200px" />
			</p>
			<p>
				礼品名称：${gift.pname}
			</p>
			<p>
				礼品数量：${gift.number}
			</p>
			<p>
				礼品积分：${gift.integral}分
			</p>
			<p>
				当前可用积分：<span>${user.integral}分</span>
				<span class="msg" style="display:none;">你的积分不足....</span>
			</p>
			<div class="mui-content-padded">
			    <ul>
			    	<li class="li_left">合计积分：<span>${gift.integral}分</span></li>
			    	<li class="li_right"><input type="button"  id="pay" value="确定兑换" /></li>
			    </ul>
			</div>
			
			<!--收货信息-->
			<div class="mui-content-aaa">
				<div class="mui-row">收货信息</div>
			    <div class="mui-row">
			    	<ul >
			    		<li class="mui-col-xs-5 mui-pull-left">姓名：${address.userName}</li>
			    		<li class="mui-col-xs-7 mui-pull-right">手机：${address.mobile}</li>
			    	</ul>
			    </div>
			    <div class="mui-row addr_content">地址：${address.address}</div>
			    <div class="mui-row mui-text-right">
			    	<a href="javascript:updateAddress()"><span class="mui-icon mui-icon-compose"></span>编辑</a>
			    	<a href="javascript:delAddress()"><span class="mui-icon mui-icon-trash"></span>删除</a>
			    </div>
			</div>
		</div>
		
		<!---填写收货信息开始--->
		<div class="mui-content-padd" style="display: none;">
			<div class="address_title">收件人信息
				<span class="mui-icon mui-icon-close mui-pull-right"></span>
			</div>
		    <div class="mui-input-row">
		        <label>收件人：</label>
		        <input type="text" name = "userName" class="mui-input-clear" placeholder="请输入姓名">
		    </div>
		    <div class="mui-input-row">
		        <label>手机号：</label>
		        <input type="text" name = "mobile" class="mui-input-clear" placeholder="请输入手机">
		    </div>
		    
			<textarea id="textarea" rows="5"  placeholder="请输入收件地址"></textarea>
			<button type="button" class="mui-btn mui-btn-red mui-btn-block">保存</button>
		</div>
		<!---填写收货信息结束--->
		<!--下导航-->
		 <%@include file="../front/footer.jsp" %>
		<!--nav-on-bottom下导航结束-->
		<script>
			/* 没有默认地址 隐藏地址框*/
			var haveAdd = "${haveAdd}";
			if(haveAdd=="no"){
				$(".mui-content-aaa").hide();
				$(".mui-content").css("height","550px");
			}

			var msg = "${msg}";
			if(msg=="不足"){
				$(".msg").show(); //显示你的积分不足
				$("#pay").attr("disabled",true).css("background","#ccc");//兑换按钮为不可用
			}
			
			
			
			//关闭模态框
			function closemodel(){
				$("#model").removeClass("model");
				$(".mui-content-padd").hide().removeClass("addcss");
				$(".mui-content").show();
			}
			//打开模态框
			function openmodel(){
				$(".mui-content").hide();
				$("#model").addClass("model");
				$(".mui-content-padd").show().addClass("addcss");
			}
			
			$(".mui-icon-close").click(function(){
				closemodel();//关闭模态框
			})
			
			//确认兑换，如果用户收货信息为空，则进入添加收货信息页
			$("#pay").click(function(){
				var openid= "${openid}";
				$.post("queryAddress",{openid:openid},function(data){
					//添加收货信息
					if(data=="no"){
						openmodel();//启动模态框
					}
					
					//支付运费
					if(data=="ok"){
						window.location.href="openorder?openid=${openid}&pid=${gift.pid}";
					}
				})
			})
			
			//添加收货信息
			$(".mui-btn").click(function(){
				var userName = $("[name='userName']").val();
				var mobile = $("[name='mobile']").val();
				var address = $("#textarea").val();
				if(userName.length==0){
					mui.toast("请输入姓名");
					$("[name='userName']").focus();
				}else if(mobile.length==0||mobile.length!=11){
					mui.toast("请输入手机号");
					$("[name='mobile']").focus();
				}else if(address.length==0){
					mui.toast("请输入收货地址");
					$("#textarea").focus();
				}else{
					$.post("addAddressInfo",{openid:"${openid}",userName:userName,mobile:mobile,address:address},function(data){
						if(data=="null"){
							mui.toast("请重新输入");
						}else if(data=="1"){
							closemodel();
							window.location.href="exchange?openid=${openid}&pid=${gift.pid}";
							mui.toast("添加成功!");
							
						}else if(data="0"){
							mui.toast("添加失败，请重新输入");
							$("[name='userName']").val("");
							$("[name='mobile']").val("");
							$("#textarea").val("");
						}
					})
				}
			});
			
			//编辑收货地址
			function updateAddress(){
				$.post("getUserAddress",{openid:"${openid}"},function(data){
					$("[name='userName']").val(data.userName);
					$("[name='mobile']").val(data.mobile);
					$("#textarea").val(data.address);
					openmodel();
				});
			}
			
			//删除收货地址
			function delAddress(){
				$.post("delAddressInfo",{openid:"${openid}"},function(data){
					if(data=="1"){
						window.location.href="exchange?openid=${openid}&pid=${gift.pid}";
						mui.toast("删除成功");
					}else if(data=="0"){
						mui.toast("删除失败");
					}
				});
			}
		</script>
	</body>
</html>

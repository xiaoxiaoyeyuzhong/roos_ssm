<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<div class="js-navmenu nav-on-bottom style-2">
	<div class="nav-menu has-menu-3">
		<a href="index.html?code=${openid}" class="icon-home"></a>
		<div class="divide">&nbsp;</div>
		
		<div class="one">
			<a class="mainmenu js-mainmenu" href="javascript:void(0);"> <i
				class="arrow-weixin"></i> 菜品
			</a>
			<div class="submenu js-submenu">
				<span class="arrow before-arrow"></span> <span
					class="arrow after-arrow"></span>
				<ul>
				<c:forEach items="${ftlist}" var="ft">
					<li><a href="openfoodlistById?openid=${openid}&&typeid=${ft.typeid}">${ft.typeName}</a></li>
				</c:forEach>	
				</ul>
			</div>
		</div>
		<div class="divide">&nbsp;</div>
		<div class="one">
			<a class="mainmenu js-mainmenu" href="javascript:void(0);"> <i
				class="arrow-weixin"></i> 订位
			</a>
			<div class="submenu js-submenu">
				<span class="arrow before-arrow"></span> <span
					class="arrow after-arrow"></span>
				<ul>
					<li><a href="opendingcan?openid=${openid}"> 我要订位 </a></li>
				</ul>
			</div>
		</div>
		<div class="divide">&nbsp;</div>
		<div class="one">
			<a class="mainmenu js-mainmenu" href="javascript:void(0);"> <i
				class="arrow-weixin"></i> 我的
			</a>
			<div class="submenu js-submenu">
				<span class="arrow before-arrow"></span> <span
					class="arrow after-arrow"></span>
				<ul>
<!-- 				<li><a href="openRegUser?openid=${openid}"> 注册成为VIP </a></li> -->
					<li><a href="openmember?openid=${openid}"> 我的会员卡 </a></li>
					<li><a href="queryMyOrder?openid=${openid}">个人中心 </a></li>
<!-- 					<li><a href="score.html"> 积分兑换 </a></li> -->
				</ul>
			</div>
		</div>
		<div class="divide">&nbsp;</div>
		<div class="one" id="orderid">
			<a class="mainmenu js-mainmenu" href="javascript:void(0);"> <i
				class="arrow-weixin"></i> 订单
			</a>
			<div class="submenu js-submenu">
				<span class="arrow before-arrow"></span> <span
					class="arrow after-arrow"></span>
				<ul>
					<li><a href="queryAllCart?openid=${openid}"> 我点的菜 </a></li>
				</ul>
			</div>
			<!--submenu js-submenu-->
		</div>
		<!--one-->
	</div>
</div>

<script type="text/javascript" src="js/wap.min.js"></script>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<div class="col-sm-2">
	
	<div class="panel-group" id="myAccordion">
		<div class="panel panel-accordion panel-default">
			<div class="panel-heading text-center">
				<a href="#panel1" data-toggle ="collapse" data-target="#panel1">菜品管理</a>
			</div>
			<div class="panel-collapse collapse" id="panel1">
				<div class="panel-body text-center">
					<span class="glyphicon glyphicon-search"></span><a href="queryAllfood?typeid=0">查看菜品信息</a></div>
				<div class="panel-body text-center">
					<span class="glyphicon glyphicon-plus"></span><a href="openAddfood">添加菜品信息</a></div>
				<div class="panel-body text-center">
					<span class="glyphicon glyphicon-search"></span><a href="queryAllfoodType">查看菜品分类</a></div>
				<div class="panel-body text-center">
					<span class="glyphicon glyphicon-plus"></span><a href="openType">添加菜品分类</a></div>
			</div>
		</div>
		
		<div class="panel panel-accordion panel-default">
			<div class="panel-heading text-center">
				<a href="#panel2" data-toggle="collapse" data-target = "#panel2">分店管理</a>
			</div>
			<div class="panel-collapse collapse" id="panel2">
				<div class="panel-body text-center">
					<span class="glyphicon glyphicon-search"></span><a href="queryShopInfo">查看分店信息</a></div>
				<div class="panel-body text-center">
					<span class="glyphicon glyphicon-plus"></span><a href="openAddShop">添加分店信息</a></div>
			</div>
		</div>
		
		<div class="panel panel-accordion panel-default">
			<div class="panel-heading text-center">
				<a href="#panel3" data-toggle="collapse" data-target="#panel3">礼品管理</a>
			</div>
			<div class="panel-collapse collapse" id="panel3">
				<div class="panel-body text-center">
					<span class="glyphicon glyphicon-search"></span><a href="queryAllgift">查看礼品信息</a></div>
				<div class="panel-body text-center">
					<span class="glyphicon glyphicon-plus"></span><a href="opengift">添加礼品信息</a></div>
			</div>
		</div>
		
		<div class="panel panel-accordion panel-default">
			<div class="panel-heading text-center">
				<a href="#panel4" data-toggle="collapse" data-target="#panel4">订单管理</a>
			</div>
			<div class="panel-collapse collapse" id="panel4">
				<div class="panel-body text-center"><a href="openOrderManager?page=1&isexpend=未消费">在线点餐订单</a></div>
				<div class="panel-body text-center"><a href="queryAllDweiInfo?page=1">在线桌位预定</a></div>
				<div class="panel-body text-center"><a href="queryUndeliveredGifts?page=1">礼品订单信息</a></div>
			</div>
		</div>
		
		<div class="panel panel-accordion panel-default">
			<div class="panel-heading text-center">
				<a href="#panel5" data-toggle="collapse" data-target="#panel5">会员管理</a>
			</div>
			<div class="panel-collapse collapse" id="panel5">
				<div class="panel-body text-center"><a href="queryMemberByPageAndPhone?page=1">查看会员信息</a></div>
				<div class="panel-body text-center"><a href="queryRechargeByPageAndtime?page=1">查看充值记录</a></div>
				<div class="panel-body text-center"><a href="queryConsumeByPageAndtime?page=1">查看消费记录</a></div>
			</div>
		</div>
		
	</div>
</div>
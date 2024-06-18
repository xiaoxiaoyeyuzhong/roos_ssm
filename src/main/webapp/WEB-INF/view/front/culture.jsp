<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
	<head>
		<title>企业文化</title>
		<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
		<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
		<link rel="stylesheet" type="text/css" href="css/font-awesome.css">
		<link rel="stylesheet" type="text/css" href="css/style.css" />
		<script type="text/javascript" src="js/jquery-2.0.3.min.js"></script>
		<script type="text/javascript">
		   var _global = {};
			   _global.spm = {};
			   
		document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {WeixinJSBridge.call('hideToolbar');});
		</script>
		<script type="text/javascript" src="js/swipe.js"></script>
		<script type="text/javascript">
				$(function(){
					new Swipe(document.getElementById('banner_box'), {
						speed:500,
						auto:3000,
						callback: function(){
							var lis = $(this.element).next("ol").children();
							lis.removeClass("on").eq(this.index).addClass("on");
						}
					});
				});
		</script>
	</head>

<body>
	<div class="body">
	  <p class="logo clearfix"><span class="floatl"><img src="images/logo.png" alt="logo"></span><em class="floatl"><img src="images/sybar.png" alt=""></em></p>
	  <div class="banner clearfix">
	    <div style="-webkit-transform:translate3d(0,0,0);">
	      <div id="banner_box" class="box_swipe">
	        <ul>
	          <li> <a onclick="return false;"> <img src="images/culimg1.jpg" alt="企业文化广告图" style="width:100%;" /> </a> </li>
	          <li> <a onclick="return false;"> <img src="images/banner.jpg" alt="企业文化广告图" style="width:100%;" /> </a> </li>
	        </ul>
	        <ol>
	          <li class="on"></li>
	          <li ></li>
	        </ol>
	      </div>
	    </div>
	  </div>
	  <div class="culture">
	    <h3 class="tit">企业文化</h3>
	    <div class="cul-intro">
	      <p>小坛子商务信息咨询有限公司成立于沈阳，是东北地区唯一一家对企业进行网络营销实战培训的机构，致力于企业网络领域中成功管理方法的研究，探寻成功网商成长中的实战方法，为成长中企业的不断创新提供专业、贴身的网络咨询服务。</p>
	    </div>
	    <h3 class="tit">团队展示</h3>
	    <div class="cul-intro">
	      <p><img src="images/team.jpg" alt="团队展示"></p>
	    </div>
	    <h3 class="tit">经营理念</h3>
	    <div class="cul-intro">
	      <p>小坛子商务信息咨询有限公司成立于沈阳，是东北地区唯一一家对企业进行网络营销实战培训的机构，致力于企业网络领域中成功管理方法的研究，探寻成功网商成长中的实战方法，为成长中企业的不断创新提供专业、贴身的网络咨询服务。</p>
	    </div>
	  </div>
	  <!--culture--> 
	  
	  <!--下导航-->
	 <%@include file ="footer.jsp" %>
	  <!--nav-on-bottom下导航结束--> 
	</div>
	<!--body-->
</body>
</html>


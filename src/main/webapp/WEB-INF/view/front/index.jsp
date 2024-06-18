<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>首页</title>
		<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
		<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
		<link rel="stylesheet" type="text/css" href="css/font-awesome.css">
		<link rel="stylesheet" type="text/css" href="css/style.css" />
		<script type="text/javascript" src="js/jquery-2.0.3.min.js"></script>
		<script type="text/javascript" src="js/swipe.js"></script>
		<script type="text/javascript">
			document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {WeixinJSBridge.call('hideToolbar');});
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
				        <li> <a onClick="return false;"> <img src="images/banner.jpg" alt="爱上吃鱼的感觉" style="width:100%;" /> </a> </li>
				        <li> <a onClick="return false;"> <img src="images/banner.jpg" alt="爱上吃鱼的感觉" style="width:100%;" /> </a> </li>
			        </ul>
			        <ol>
			            <li class="on"></li>
			            <li ></li>
			        </ol>
			    </div><!--#banner_box-->
		    </div>
		</div><!--banner-->
	    <ul class="clearfix synav">
		    <li class="syn1 floatl"><a href="opentypeList?openid=${openid}"><b>菜品</b><em>在线点餐</em></a></li>
		    <li class="syn2 floatl"><a href="opendingcan?openid=${openid}"><b>餐位</b><em>在线预定</em></a></li>
		    <li class="syn3 floatl"><a href="openmember?openid=${openid}"><b>会员</b><em>成为VIP</em></a></li>
		    <li class="syn4 floatl"><a href="goToIntegralShop?openid=${openid}"><b>礼品</b><em>积分商城</em></a></li>
		    <li class="syn5 floatl"><a href="openShopList?openid=${openid}"><b>店面</b><em>店面展示</em></a></li>
		    <li class="syn6 floatl"><a href="openCulture?openid=${openid}"><b>团队</b><em>团队展示</em></a></li>
	    </ul>
	  	<div class="syad clearfix">
	  		<em class="floatl tgimg"><img src="images/tgimgs.jpg" alt="广告图"></em>
	  		<em class="floatr tgtxt"><span><img src="images/tgtxt.jpg" alt="6菜一汤 团购特价仅58元"></span>
	  		<a href="openfoodlistById?openid=${openid}&typeid=1">立即查看</a></em>
	  	</div>
		<footer class="syfooter">
		    <ul class="clearfix">
			    <li class="ft1 floatl"><a href="index.html?openid=${openid}" class="icon-home"></a></li>
			    <li class="ft2 floatl"><a href="tel:0769-82129805">电话</a></li>
			    <li class="ft3 floatl"><a href="http://xzg.vzzj.cn/sm/html/map.html">导航</a></li>
			    <li class="ft4 floatl"><a href="javascript:$('#shareCover').toggleClass('on');">分享</a></li>
		    </ul>
		</footer>
		<article id="shareCover" class="share" onclick="$('#shareCover').toggleClass('on')">
		    <table>
			    <tr>
			        <td colspan="2" style="text-align:right;"><img src="images/share_1.png" style="width:120px!important;" /> <img src="images/share_2.png" style="width:30px!important;" /></td>
			    </tr>
			    <tr>
			        <td style="width:50%;"><img src="images/share_4.png" />
			            <div>发送给朋友</div></td>
			        <td><img src="images/share_3.png" />
			        	<div>分享到朋友圈</div></td>
			    </tr>
		    </table>
		</article>
	</div>
	<!--body-->
</body>
</html>


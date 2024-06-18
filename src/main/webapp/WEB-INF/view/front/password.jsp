<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="utf-8" />
		<meta name="viewport"content="width=device-width,initial-scale=1, user-scalable=no">
		<link href="css/password.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="js/jquery-2.0.3.min.js"></script>
		<script type="text/javascript" src="js/fastclick.js"></script>
		<title>确认金额</title>
	</head>
	<script>
	    function init(){
	        var width=$(window).width();
	        var height=$(window).height();
	        $("body").css("height",height);
	        $("body").css("width",width);
	    }
	    window.addEventListener('load', function() {
	    	  FastClick.attach(document.body);
	    	}, false);
	</script>
<body onload="init(),reset()">
	<!-- 蒙罩 -->
	<div id="mask"></div>
	<div>
	    <div style="text-align: center;padding-top:70px;p"><span id="set_text" style="font-size: large;"></span></div>
	    <div style="padding-top:10px;text-align: center;">
	        <form id="password" >
	            <input readonly class="pass" type="password"maxlength="1"value="">
	            <input readonly class="pass" type="password"maxlength="1"value="">
	            <input readonly class="pass" type="password"maxlength="1"value="">
	            <input readonly class="pass" type="password"maxlength="1"value="">
	            <input readonly class="pass" type="password"maxlength="1"value="">
	            <input readonly class="pass" type="password"maxlength="1"value="">
	        </form>
	    </div>
	</div>
	<!-- 提示模态框 -->
	<div id="model">
		<div class="model-title">温馨提示</div>
		<div class="model-body">消费成功!</div>
	</div>
	
	<!-- 键盘box -->
	<div id="keyboardDIV"></div>
	<script>
		var check_pass_word='';var passwords = $('#password').get(0); //把form转成jquery对象
		$(function(){
			//初始化
			reset();
		});
		
		function reset(){
			var div = '\
				<div id="key" style="position:absolute;background-color:#A8A8A8;width:99.5%;bottom:0px;">\
					<ul id="keyboard" style="font-size:20px;margin:2px -2px 1px 2px">\
						<li class="symbol"><span class="off">1</span></li>\
						<li class="symbol"><span class="off">2</span></li>\
						<li class="symbol btn_number_"><span class="off">3</span></li>\
						<li class="tab"><span class="off">4</span></li>\
						<li class="symbol"><span class="off">5</span></li>\
						<li class="symbol btn_number_"><span class="off">6</span></li>\
						<li class="tab"><span class="off">7</span></li>\
						<li class="symbol"><span class="off">8</span></li>\
						<li class="symbol btn_number_"><span class="off">9</span></li>\
						<li class="delete lastitem">删除</li>\
						<li class="symbol"><span class="off">0</span></li>\
						<li class="cancle btn_number_">取消</li>\
					</ul>\
				</div>\
				';
			    var character,index=0;	$("input.pass").attr("disabled",true);	$("#password").attr("disabled",true);$("#keyboardDIV").html(div);
			    $('#keyboard li').click(function(){
			        if ($(this).hasClass('delete')) {
			        	$(passwords.elements[--index%6]).val('');
			        	if($(passwords.elements[0]).val()==''){
			        		index = 0;
			        	}
			           
			            return false;
			        }
			        if ($(this).hasClass('cancle')) {
			        	$("#password input").each(function(){
			        		$("#password input").val('');
			        		index = 0;
			        	});
			            parentDialog.close();
			            return false;
			        }
			        if ($(this).hasClass('symbol') || $(this).hasClass('tab')){
			            character = $(this).text();
						$(passwords.elements[index++%6]).val(character);
						if($(passwords.elements[5]).val()!=''){
			        		index = 0;
			        	}
			        
				        if($(passwords.elements[5]).val()!='') {
				            var temp_rePass_word = '';
				            for (var i = 0; i < passwords.elements.length; i++) {
				                temp_rePass_word += $(passwords.elements[i]).val();
				            }
				            check_pass_word = temp_rePass_word;
				            //alert(check_pass_word);
				            $("#key").hide();
				           	var action = 'modify';
			                $.post('submitPwd',{openid:'${openid}',amount:'${amount}',pwd:check_pass_word},function(data){
			                	if(data=="ok"){
			                		$("#mask").addClass("mask");
			                		$("#model").show();
			                		msgbox();
			                	}else{
			                		//清空密码框
			                        $("#password input").each(function(){
			    		        		$("#password input").val('');
			    		        		index = 0;
			    		        	});
			                		//调用初始化
			                      	 reset();
			                		//更改提示信息
		                      	    var result_text='<span>提示：</span><span style="color: red;">密码不正确,请重新输入</span>';
			                        $("#set_text").html(result_text);
			                	}
			                });
				        }
			        }
			        return false;
			    });
			    
			(function () {
			    function tabForward(e) {
			        e = e || window.event;
			        var target = e.target || e.srcElement;
			        if (target.value.length === target.maxLength) {
			            var form = target.form;
			            for (var i = 0, len = form.elements.length-1; i < len; i++) {
			                if (form.elements[i] === target) {
			                    if (form.elements[i++]) {
			                        form.elements[i++].focus();
			                    }
			                    break;
			                }
			            }
			        }
			    }
			   
			    var form = document.getElementById("password");
			    form.addEventListener("keyup", tabForward, false);
			    var set_text='<span>金额：</span><span style="color: red;">${amount}元</span><br/><span>请输入支付密码</span>';
			    $("#set_text").html(set_text);
			})(); 
		}
		
		//提示信息框
		function msgbox(){
			setTimeout(removeStyle,1500);
			function removeStyle(){
				$("#mask").removeClass("mask");
				$("#model").hide();
				window.location.href="openmember?openid=${openid}";
				
			}
		}
		
	</script>
</body>
</html>
<%@ page language="java" contentType="text/html;charset=GB2312"%>
<%@ page autoFlush="true"%>
<%@ page import="com.care.app.LoginUser"%>
<%@ page import="com.care.common.config.Config"%>
<%@ taglib uri="/WEB-INF/struts-bean" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic" prefix="logic"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="<%=request.getContextPath()%>/css/tbls.css" rel="stylesheet"
	type="text/css">
<script type="text/javascript"
	src="<%=request.getContextPath()%>/public/public.js"></script>
	<scripttype="text/javascript"src="http://code.jquery.com/jquery-1.4.1.min.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery-1.8.2.js"
	type="text/javascript"></script>
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/public/My97DatePicker/WdatePicker.js"></script>
<title>无标题文档</title>
</head>
<!-- <style>
select
{outline: none;border: none;
appearance: none;
-moz-appearance: none;
-webkit-appearance: none;
}
</style> -->

<script type="text/javascript">

$(document).ready(function(){
	 $("#orderNumber").blur(function(){
		 var userCodeValue = $("#orderNumber").val().trim();
		 $.ajax({
			 type:"post",
			 url:"doProjectInfo.do?method=verfyDingDan",
		 	 data:"userCode="+userCodeValue,
		 	 success:function(msg){
		 		 if(msg=="fail"){
		 			alert("订单号重复！！！");
		 			 $("#orderNumber").focus();
		 			 return false;
		 		 }
		 	 }
		 });
	 });
});

	 
function setSecond(obj){
	  var val = obj.value;
	  if(val == "双排二扣一" || val == "双排四扣二" ||  val == "双排六扣二"){
	    var sec = document.getElementById("xiabai");
	    sec.innerHTML = "<option>直角下摆</option><option>圆角下摆</option><option>大圆角下摆</option><option>燕尾下摆</option><option>其他</option>";
	    
/* 		<option value="圆角下摆">圆角下摆</option>
		<option value="直角下摆（双排扣默认）">直角下摆（双排扣默认）</option>
		<option value="大圆角下摆">大圆角下摆</option>
		<option value="燕尾下摆">燕尾下摆</option>
		<option value="其他">其他</option> */
		
	  }else{
	    var sec = document.getElementById("xiabai");
	    sec.innerHTML = "<option>无</option><option>直角下摆</option><option>圆角下摆</option><option>大圆角下摆</option><option>燕尾下摆</option><option>其他</option>";
	  }
	}
	
	
	function onAdd(wechat) {
		   document.getElementById("anniu").setAttribute("value", wechat);
		   
		if(frmGo.orderNumber.value.trim() == ""){
			alert("订单号不能为空！");
			frmGo.orderNumber.focus();
			return false;
		} 
		frmGo.submit();
	}
	function onAddd(wechat) {
		   document.getElementById("anniu").setAttribute("value", wechat);
		   
		if(frmGo.orderNumber.value.trim() == ""){
			alert("订单号不能为空！");
			frmGo.orderNumber.focus();
			return false;
		}
		if(frmGo.kehuPhone.value.trim() == ""){
			alert("客户电话为空！");
			frmGo.kehuPhone.focus();
			return false;
		}
		frmGo.submit();
	}

	function preViews() {
		document.getElementById('preView').style.display = "none"
		document.getElementById('rePicture').style.display = "none"
		document.getElementById('pictureView').style.display = "block"
	}
	
    function InserTab() {
        var trLen = $("#tab1 tr").length;
        var rowT = "<tr><td><input type=text style='width:90px;' value='' id='d" + trLen + "'></td>" +
            "<td><input type=text style='width:90px;' value='' id='d1" + trLen + "'></td>" +
            "<td><input type=text style='width:90px;' value='' id='d2" + trLen + "'></td>" +
            "<td><input type=text style='width:90px;' value='' id='d3" + trLen + "'></td></tr>";
        var trPre = $("#tab1 tr:eq(" + (trLen - 1) + ")");
        $(rowT).insertAfter($(trPre));
    }
    
    function setwechat(wechat) {
        document.getElementById("xiongweiB").setAttribute("value", wechat);
        document.getElementById("xiongweiD").setAttribute("value", wechat);
    }

    function setzhongyao(wechat) {
        document.getElementById("zhongyaoB").setAttribute("value", wechat);
        document.getElementById("zhongyaoD").setAttribute("value", wechat);
    }
    
    
    function setfuwei(wechat) {
        document.getElementById("fuweiB").setAttribute("value", wechat);
    }
    
    function setanniu(wechat) {
        document.getElementById("anniu").setAttribute("value", wechat);
    }
    
</script>
<body>
	<span class="title_1"></span>
	<form name="frmGo" method="post"
		action="doProjectInfo.do?method=insertUserDangAn"
		encType="multipart/form-data" onsubmit="return onAdd()">
		<%
			LoginUser loginUser = (LoginUser) request.getSession()
					.getAttribute(Config.SystemConfig.LOGINUSER);
			String loginUserCode = loginUser.getUserCode();
		%>
		<!-- <input type="hidden" name="addUser" value="<%=loginUserCode%>"> -->
		<!-- <table width="100%" border="0"cellpadding="0" cellspacing="0"  class="tbl_11" > -->
		
		
    
	<table width="100%"  id="tb1"  class="tbl_11" border="1" bordercolorlight=#000000  bordercolordark=#000000  bordercolor=#000000 cellspacing="0"  cellpadding="2"> 
	
	
    		  
		

			<tr>
				<th colspan="8" nowrap="nowrap" align="left">添加订单信息(客户档案) </th>
			</tr>

			<tr class="tr_11">
				<td colspan="8" nowrap="nowrap" align="center" width="7%">不一定制和周卢江   客户信息档案表</td>
			</tr>
			
			<tr>
				<td colspan="4" nowrap="nowrap" align="center" width="7%">订单信息</td>
				<td colspan="4" nowrap="nowrap" align="center" width="7%">订单信息</td>
			</tr>
			
			<tr>
				<td nowrap="nowrap" align="center" width="7%">订单编号</td>
				<td nowrap="nowrap" align="center" width="7%"><%=request.getAttribute("dingdan")%></td>
				<td nowrap="nowrap" align="center" width="7%">渠道</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="qudao" value="qudao">
						<option value="淘宝">淘宝</option>
						<option value="工单">工单</option>
						<option value="分销">分销</option>
						<option value="线下">线下</option>
						<option value="打样">打样</option>
						<option value="重做">重做</option>
						<option value="其他">其他</option>
				</select> <font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%">年龄</td>
				<td  nowrap="nowrap" align="center" width="7%">
				<input name="age" size="50" id="age" type="number" 
					class="txt_1" maxlength="100" /><font color="red"></font>
					</td>
				<td nowrap="nowrap" align="center" width="7%">客户电话</td>	
				<td  nowrap="nowrap" align="center" width="7%">
				<input name="kehuPhone" size="38"  
					id="kehuPhone" type="text" class="txt_1" maxlength="30" /><font
					color="red"></font>
					</td>
			</tr>
			
				<tr>
				<td nowrap="nowrap" align="center" width="7%">微信号</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="wechat" size="38" id="wechat"
					type="text" class="txt_1" maxlength="30" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%">下单客服</td>
				<td nowrap="nowrap" align="center" width="7%"><%=request.getAttribute("userName")%></td>
				<td nowrap="nowrap" align="center" width="7%">性别</td>
				<td  nowrap="nowrap" align="center" width="7%">
				<select name="sex" value="sex">
						<option value="男">男</option>
						<option value="女">女</option>
				</select> <font color="red"></font>
					</td>
				<td nowrap="nowrap" align="center" width="7%">客户姓名</td>	
				<td  nowrap="nowrap" align="center" width="7%">
			<input name="kehuName" size="38" id="kehuName" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font>
					</td>
			</tr>
			
			<tr>
				<td nowrap="nowrap" align="center" width="7%">订单号</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="orderNumber" size="38"
					id="orderNumber" type="text" class="txt_1" maxlength="30" /><font
					color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%">销售价格</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="salePrice" size="38"
					id="salePrice" type="text" class="txt_1" maxlength="30" /><font
					color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%">身高</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="height" size="38" id="height" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%">体重</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="weight" size="38" id="weight" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">旺旺名</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="projectNo" size="38"
					id="projectNo" type="text" class="txt_1" maxlength="30" /><font
					color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%">下单时间</td>
				<td nowrap="nowrap" align="left" width="7%"><%=request.getAttribute("shijian")%>  </td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="2">客户地址</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="3" rowspan="2"><input name="address" size="90" id="address"
					type="text" class="txt_1" /><font color="red"></font></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">订单类型</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="orderType" value="orderType">
						<option value="新单">新单</option>
						<option value="打样">打样</option>
						<option value="重做">重做</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">交付时间</td>
				<td nowrap="nowrap" align="left" width="7%">
				
			<!-- 	<input name="startTime1" type="text" class="txt_1"  id="startTime1" style="cursor:text"
								 onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
								size="20" readonly> -->
					
				<select name="jiaofu_time"  id="jiaofu_time" >
						<option value="10">+10天  加急</option>
						<option value="5">+5天  特别加急</option>
						<option value="3">+3天   非常紧急</option>
				</select> <font color="red"><span id="uNameSpan"></span></font>
				</td>
			
				
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">西装数量</td>
				<td nowrap="nowrap" align="left" width="7%">
				<input name="xizhuang_number" size="38" id="xizhuang_number" type="number"
					class="txt_1" maxlength="100" /><font color="red"></font>
			</td>
				<td nowrap="nowrap" align="center" width="7%">衣码</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" width="7%">衬衫数量</td>
				<td nowrap="nowrap" align="left" width="7%">
				<input name="chenshan_number" size="38" id="chenshan_number" type="number"
					class="txt_1" maxlength="100" /><font color="red"></font>
				</td>
				<td nowrap="nowrap" align="center" width="7%">衬衫码</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">肩宽</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="jiankuanA" size="38" id="jiankuanA"
					type="text" class="txt_1" maxlength="100" /></td>
				<td nowrap="nowrap" align="center" width="7%">
					<input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  />
				</td>
				<td nowrap="nowrap" align="center" width="7%"  rowspan="4">
					<img src="http://47.111.148.8/watch/upload/test.png" width="100" height="100" />
					</td>
				<td nowrap="nowrap" align="center" width="7%">领围</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="lingweiB" size="38" id="lingweiB" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"> <input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="4">
					<img src="http://47.111.148.8/watch/upload/test.png" width="100" height="100" />
					</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">胸围</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="xiongweiA" size="38" id="xiongweiA"
					type="text" class="txt_1" maxlength="100" onchange="setwechat(this.value)" /><font color="red"></font></td>
				
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" width="7%">胸围</td>
				<td nowrap="nowrap" align="center" width="7%">
			<input name="xiongweiB" size="38" id="xiongweiB"
					type="text" class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">中腰</td>
				<td nowrap="nowrap" align="center" width="7%">
			<input name="zhongyaoA" size="38" id="zhongyaoA"
					type="text" class="txt_1" maxlength="100"  onchange="setzhongyao(this.value)" /><font color="red"></font></td>
				
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" width="7%">中腰</td>
				<td nowrap="nowrap" align="center" width="7%">
		<input name="zhongyaoB" size="38" id="zhongyaoB"
					type="text" class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">腹围</td>
				<td nowrap="nowrap" align="center" width="7%">
		<input name="fuweiA" size="38" id="fuweiA" type="text"
					class="txt_1" maxlength="100" onchange="setfuwei(this.value)" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				
				<td nowrap="nowrap" align="center" width="7%">腹围</td>
				<td nowrap="nowrap" align="center" width="7%">
	<input name="fuweiB" size="38" id="fuweiB" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">后中衣长</td>
				<td nowrap="nowrap" align="center" width="7%">
	<input name="houzhongyichangA" size="38" id="houzhongyichangA" type="text" class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="5"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" width="7%">衣长</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input  name="yichangB2" size="38" type="text" class="txt_1"maxlength="50" >
				</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="5"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
			</tr>
				<tr>
				<td nowrap="nowrap" align="center" width="7%">前衣长</td>
				<td nowrap="nowrap" align="center" width="7%">
	<input name="qianyichangA" size="38" id="qianyichangA"
					type="text" class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
			
				<td nowrap="nowrap" align="center" width="7%">腹围</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input style="border:none;" name="fuwei_quea" size="38" type="text" class="txt_1"maxlength="50" >
				</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">袖长</td>
				<td nowrap="nowrap" align="center" width="7%">
	<input name="xiuchangB" size="38" id="xiuchangB"
					type="text" class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
			
				<td nowrap="nowrap" align="center" width="7%">袖长</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="xiuchangA" size="38" id="xiuchangA"
					type="text" class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
			
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">袖肥</td>
				<td nowrap="nowrap" align="center" width="7%">
	<input name="xiufeiB" size="38" id="xiufeiB" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				
				<td nowrap="nowrap" align="center" width="7%">袖肥</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="xiufeiA" size="38" id="xiufeiA" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
			
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">袖口</td>
				<td nowrap="nowrap" align="center" width="7%">
<input name="xiukouB" size="38" id="xiukouB" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
			
				<td nowrap="nowrap" align="center" width="7%">袖口</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="xiukouA" size="38" id="xiukouA" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
			
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">西裤数量</td>
				<td nowrap="nowrap" align="left" width="7%"><input name="xiku_number" size="38" id="xiku_number" type="number"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%">裤码</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" width="7%">马甲数量</td>
				<td nowrap="nowrap" align="left" width="7%"><input name="majia_number" size="38" id="majia_number" type="number"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%">马甲码</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">腰围</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="yaoweiC" size="38" id="yaoweiC" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="4">
					<img src="http://47.111.148.8/watch/upload/test.png" width="100" height="100" />
				</td>
				<td nowrap="nowrap" align="center" width="7%">肩宽</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input  name="jiankuannew" size="38" type="text" class="txt_1"maxlength="50" >
				</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="4">
					<img src="http://47.111.148.8/watch/upload/test.png" width="100" height="100" />
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">臀围</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="tuiweiC" size="38" id="tuiweiC" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" width="7%">胸围</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="xiongweiD" size="38" id="xiongweiD"
					type="text" class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">档围</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="dangweiC" size="38" id="dangweiC" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" width="7%">中腰</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="zhongyaoD" size="38" id="zhongyaoD"
					type="text" class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">大腿</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="datuiC" size="38" id="datuiC" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" width="7%">衣长</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="yichangD" size="38" id="yichangD" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">中腿</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="zhongtuiC" size="38" id="zhongtuiC"
					type="text" class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="4"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="4">款型</td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="4" colspan="2"><select name="kuanxingD" value="kuanxingD">
						<option value="修身">修身</option>
						<option value="修身+">修身+</option>
						<option value="合身">合身</option>
						<option value="合身+">合身+</option>
						<option value="宽松">宽松</option>
						<option value="宽松+">宽松+</option>
				</select> <font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="4"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">小腿</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="xiaotuiC" size="38" id="xiaotuiC" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				
			
				
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">裤长</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="kuchangC" size="38" id="kuchangC" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				
			
				
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">脚口</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="tuikouC" size="38" id="tuikouC" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				
			
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">扣型</td>
				<td nowrap="nowrap" align="center" width="7%">
					<select name="kouxingC" value="kouxingC" onchange="setSecond(this)">
						<option value=""></option>
						<option value="一粒扣">一粒扣</option>
						<option value="二粒扣">二粒扣</option>
						<option value="三粒扣">三粒扣</option>
						<option value="双排二扣一">双排二扣一</option>
						<option value="双排四扣二">双排四扣二</option>
						<option value="双排六扣二">双排六扣二</option>
				</select> <font color="red"></font>
					</td>
				<td nowrap="nowrap" align="center" width="7%">口袋</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="koudaiC" value="koudaiC">
				         <option value=""></option>
						<option value="1平袋盖、4斜袋盖">1平袋盖、4斜袋盖</option>
						<option value="2平单线、5斜单线">2平单线、5斜单线</option>
						<option value="3平双线、6斜双线">3平双线、6斜双线</option>
						<option value="7外贴袋">7外贴袋</option>
				</select> <font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%">开叉</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="kaicha" value="kaicha">
				        <option value=""></option>
						<option value="单叉">单叉</option>
						<option value="双叉">双叉</option>
						<option value="不开叉">不开叉</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">领型</td>
				<td nowrap="nowrap" align="center" width="7%">
				<!-- <input name="lingkoukuaishiB" size="38"
					id="lingkoukuaishiB" type="text" class="txt_1" maxlength="100" /><font
					color="red"></font> -->
					<select name="lingkoukuaishiB" value="lingkoukuaishiB">
					    <option value=""></option>
						<option value="平驳领">平驳领</option>
						<option value="戗驳领">戗驳领</option>
						<option value="青果领">青果领</option>
						<option value="假青果">假青果</option>
						<option value="假平驳">假平驳</option>
						<option value="宽平驳">宽平驳</option>
						<option value="宽戗驳">宽戗驳</option>
						<option value="其他">其他</option>
				</select> 
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">下摆</td>
				<td nowrap="nowrap" align="center" width="7%">
					<select id="xiabai" name="xiabai" >
					
					 <option value=""></option>
						<option value="圆角下摆">圆角下摆</option>
						<option value="直角下摆（双排扣默认）">直角下摆（双排扣默认）</option>
						<option value="大圆角下摆">大圆角下摆</option>
						<option value="燕尾下摆">燕尾下摆</option>
						<option value="其他">其他</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">撞色</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="zhuangse" value="zhuangse">
				<option value=""></option>
						<option value="袋条用色丁">袋条用色丁</option>
						<option value="领边有色丁">领边有色丁</option>
						<option value="驳头用色丁">驳头用色丁</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">外珠边</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="waizhubian" value="waizhubian">
				<option value=""></option>
						<option value="有">有</option>
						<option value="无">无</option>
				</select>
				
			<!-- 	<input name="waizhubian" size="38"
					id="waizhubian" type="text" class="txt_1" maxlength="100" /><font
					color="red"></font> -->
				</td>
				<td nowrap="nowrap" align="center" width="7%">袖叉</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="xiucha" value="xiucha">
				<option value=""></option>
						<option value="真袖叉">真袖叉</option>
						<option value="假袖叉">假袖叉</option>
						<option value="翻袖">翻袖</option>
						<option value="其它">其它</option>
				</select>
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">裤腰</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="kuyao" value="kuyao">
				<option value=""></option>
						<option value="伸出订扣">伸出订扣</option>
						<option value="伸出订钩">伸出订钩</option>
						<option value="不伸头">不伸头</option>
						<option value="松紧">松紧</option>
						<option value="调节扣">调节扣</option>
						<option value="那不勒斯">那不勒斯</option>
						<option value="其它">其它</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">裤型</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="kuxing" value="kuxing">
				<option value=""></option>
						<option value="修身裤">修身裤</option>
						<option value="翻边">翻边</option>
						<option value="单褶">单褶</option>
						<option value="双褶">双褶</option>
						<option value="萝卜裤">萝卜裤</option>
						<option value="直筒裤">直筒裤</option>
						<option value="其它">其它</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">衬衫领</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="chenshanling" value="chenshanling">
				<option value=""></option>
						<option value="小方领">小方领</option>
						<option value="小尖领">小尖领</option>
						<option value="v尖领">v尖领</option>
						<option value="正方领">正方领</option>
						<option value="大领">大领</option>
						<option value="其它">其它</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">衬衫袖</td>
				<td nowrap="nowrap" align="center" width="7%">
					<select name="chenshanxiu" value="chenshanxiu">
					<option value=""></option>
						<option value="法式门襟＋袖">法式门襟＋袖</option>
						<option value="直角二扣">直角二扣</option>
						<option value="直角一扣">直角一扣</option>
						<option value="圆角二扣">圆角二扣</option>
						<option value="圆角一扣">圆角一扣</option>
						<option value="翻袖">翻袖</option>
						<option value="其它">其它</option>
				</select>
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">面料</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="miaoliao1" size="38" id="miaoliao1"
					type="text" class="txt_1" maxlength="100" /><font color="red"></font>
				</td>
				<td nowrap="nowrap" align="center" width="7%">用途</td>
				<td nowrap="nowrap" align="center" width="7%">
					<select name="yongtu1" value="yongtu1">
					<option value=""></option>
						<option value="上衣">上衣</option>
						<option value="裤子">裤子</option>
						<option value="马甲">马甲</option>
						<option value="衬衫">衬衫</option>
						<option value="西装套装">西装套装</option>
						<option value="换片">换片</option>
						<option value="其他">其他</option>
				</select> <font color="red"></font>
				</td>
				<td nowrap="nowrap" align="center" width="7%">米数</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" width="7%">供应商</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">面料</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="miaoliao2" size="38" id="miaoliao2"
					type="text" class="txt_1" maxlength="100" /><font color="red"></font>
				</td>
				<td nowrap="nowrap" align="center" width="7%">用途</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="yongtu2" value="yongtu2">
				<option value=""></option>
						<option value="上衣">上衣</option>
						<option value="裤子">裤子</option>
						<option value="马甲">马甲</option>
						<option value="衬衫">衬衫</option>
						<option value="西装套装">西装套装</option>
						<option value="换片">换片</option>
						<option value="其他">其他</option>
				</select> <font color="red"></font>
				</td>
				<td nowrap="nowrap" align="center" width="7%">米数</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" width="7%">供应商</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">附件</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input type="file" name="channelId"
					id="channelId" multiple="multiple"  /><!--  <img alt=""
					src="" id="image1" class="showImage"> -->
					
					
					</td>
			</tr>
			
			<tr>
				<td nowrap="nowrap" align="center" width="7%">客服备注</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="7">
			<input name="remark" size="200" id="remark"
					type="text" class="txt_1" maxlength="1000" /><font color="red"></font></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">批单备注</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="7">
					
			<input name="" size="200" id=""
					type="text" class="txt_1" maxlength="1000"  readonly="true"/>
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">跟单备注</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="7">
				<input name="" size="200" id=""
					type="text" class="txt_1" maxlength="1000"  readonly="true"/>
				</td>
			</tr>
			<!-- 	<tr>
				<td nowrap="nowrap" align="center" width="7%">提交类型</td>
				<td nowrap="nowrap" align="center" width="7%" colspan="7">
					保存 <input name="tag" type="radio" class="radio_1" value="1" checked="checked" >
	    保存并提交<input type="radio" name="tag" class="radio_1" value="2" >
				</td>
			</tr> -->
			
			
			
			
				
		
			<tr>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="right" width="7%">
				<input name="anniu" size="200" id="anniu"
					 type="hidden" class="txt_1"  />
					
				<input id="ok"   title="1"
					type="button" name="ok" accesskey="y" tabindex="y" value="保存"
					class="but_1" onclick="onAdd(this.title)"
					style="font-size:12;width:40px;height:21px;">
					</td>
				<td nowrap="nowrap" align="left" width="7%">	
					<input id="ok"   title="2"
					type="button" name="ok" accesskey="y" tabindex="y" value="保存并提交" 
					class="but_1" onclick="onAdd(this.title)"
					style="font-size:12;width:80px;height:21px;">
					
					 <input
					type="button" name="back" accesskey="b" tabindex="b" value="返回"
					class="but_1"
					onclick="location='doProjectInfo.do?method=queryProjectInfoXml'"
					style="font-size:12;width:40px;height:21px;">
					</td>
			
			</tr>
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			

	<!-- 		<tr>
				<td align="left">订单编号</td>
				<td colspan="2" align="left">自动生成</td>
				<td align="left">旺旺名</td>
				<td colspan="2" align="left"></td>
				<td align="left">销售价格</td>
				<td align="left"></td>
			</tr>

			<tr>
				<td>微信名</td>
				<td colspan="2"></td>
				<td>订单号</td>
				<td colspan="2"></td>
				<td>下单时间</td>
				<td></td>
			</tr>


			<tr>
				<td>客户电话</td>
				
				<td>订单类型</td>
				<td colspan="2"></td>
				<td>交付时间</td>
				<td>
				</td>
			</tr>


			<tr>
				<td>客户姓名</td>
				<td></td>
				<td>渠道</td>
				
				<td>下单客服</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>客户地址</td>
				<td colspan="7">
				</td>
			</tr>

			<tr>
				<td>身高</td>
				<td></td>
				<td>体重</td>
				<td></td>
				<td>年龄</td>
				
				<td>性别</td>
				<td></td>
			</tr>

			<tr>
				<td >西装数量</td>
						<td></td>
				<td>衣码</td>
				<td >衬衫数量</td>
				<td></td>
				<td>衬衫码</td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>肩宽</td>
				<td>
				</td>
				<td></td>
				<td>领围</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>胸围</td>
				<td>
				</td>
				<td></td>
				<td>胸围</td>
				<td>
				</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>中腰</td>
				<td>
				</td>
				<td></td>
				<td>中腰</td>
				<td>
				</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>腹围</td>
				<td></td>
				<td></td>
				<td>腹围</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>后中衣长</td>
				<td></td>
				<td></td>
				<td>袖长</td>
				<td>
				</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>前衣长</td>
				<td>
				</td>
				<td></td>
				<td>袖肥</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>袖长</td>
				<td>
				</td>
				<td></td>
				<td>袖口</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>袖肥</td>
				<td></td>
				<td></td>
				<td>领口款式</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>


			<tr>
				<td>袖口</td>
				<td></td>
				<td></td>
				<td>衣长</td>
				<td><input name="yichangB" size="38" id="yichangB" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>西裤数量</td>
				<td></td>
				<td>裤码</td>
				<td >马甲数量</td>
					<td></td>
				<td>马甲码</td>
				<td></td>
				<td></td>
			</tr>


			<tr>
				<td>裤长</td>
				<td></td>
				<td></td>
				<td>胸围</td>
				<td>
				</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>


			<tr>
				<td>腰围</td>
				<td></td>
				<td></td>
				<td>中腰</td>
				<td>
				</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>臀围</td>
				<td></td>
				<td></td>
				<td>衣长</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>


			<tr>
				<td>档围</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>大腿</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>


			<tr>
				<td>中腿</td>
				<td>
				</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>


			<tr>
				<td>小腿</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>脚口</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>扣型</td>
				<td></td>
				<td>扣色</td>
				<td><input name="kouseC" size="38" id="kouseC" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td>款型</td>
				<td></td>
				<td>驳头</td>
				<td><select name="botouD" value="botouD">
						<option value="西装领">西装领</option>
						<option value="平驳领">平驳领</option>
						<option value="戗驳领">戗驳领</option>
						<option value="青果领">青果领</option>
						<option value="立领">立领</option>
						<option value="中华立领">中华立领</option>
						<option value="其它">其它</option>
				</select> <font color="red"></font></td>
			</tr>

			<tr>
				<td>口袋</td>
				<td></td>
				<td>袋盖</td>
				<td><select name="daigai" value="daigai">
						<option value="有">有</option>
						<option value="无">无</option>
						<option value="其它">其它</option>
				</select> <font color="red"></font></td>
				<td>平斜袋</td>
				<td><select name="pingxiedai" value="pingxiedai">
						<option value="平袋">平袋</option>
						<option value="斜袋">斜袋</option>
						<option value="其它">其它</option>
				</select> <font color="red"></font></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>面料1</td>
				<td>
				</td>
				<td>米数</td>
				<td></td>
				<td>用途</td>
				<td>
			</td>
				
				<input name="yongtu1" size="38" id="yongtu1" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font>
					
					</td>
				<td>供应商</td>
				<td></td>
			</tr>
 
			<tr>
				<td>面料2</td>
				<td>
				</td>
				<td>米数</td>
				<td></td>
				<td>用途</td>
				<td>
				
				</td>
				<input name="yongtu2" size="38" id="yongtu2" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td>供应商</td>
				<td></td>
			</tr>

			<tr>
				<td>体型备注</td>
				<td colspan="3"><input name="tixingremark" size=60"
					id="tixingremark" type="text" class="txt_1" maxlength="1000" /><font
					color="red"></font></td>
				<td>备注</td>
				<td colspan="3">
				</td>
			</tr>

			<tr>
				<td align="left">附件(ZIP)</td>
				<td colspan="2">请压缩后再添加--
				</td>
					
						<td align="left" colspan="2">&
				</td>
			</tr>
			
				<tr>
				<td>提交类型</td>
				<td colspan="7">
						
					</td>
				
			</tr>
			
			<tr>
					<td></td>
				<td colspan="7">
					
					</td>
				
			</tr> -->

		</table>

	</form>
</body>
</html>
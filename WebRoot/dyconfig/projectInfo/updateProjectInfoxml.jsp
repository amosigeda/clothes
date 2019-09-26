<%@ page language="java" contentType="text/html;charset=gb2312"%>
<%@ page import = "com.godoing.rose.http.common.*" %>
<%@ page import = "com.godoing.rose.lang.*" %>
<%@ page import="com.care.common.lang.*"%>
<%@ page import="com.care.common.config.Config"%>
<%@ page import="com.care.app.LoginUser"%>
<%@ taglib uri="/WEB-INF/struts-bean" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic" prefix="logic"%>

<jsp:useBean id = "projectInfo" scope = "request" class = "com.godoing.rose.lang.DataMap"/>
<%@ page autoFlush="true" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="<%=request.getContextPath()%>/css/tbls.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="<%=request.getContextPath()%>/public/public.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/jquery-1.8.2.js"></script>
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

<script language="javascript">
function selectProject(obj){
    var a=frmGo.projectName1.value;
    var b=frmGo.projectName.value;
	$.ajax({
		type:"get",
		url:"doProjectInfo.do?method=queryProjectName",
		data:"projectName="+obj,
		success:function(msg){
			 if(msg.trim() != ""&&b!=a){	
				alert("项目名已经存在,请重新输入！");
				 document.all.projectName.value=""; 
			} 
			}
	});

}
function onUpdate(wechat){
	   document.getElementById("anniu").setAttribute("value", wechat);
	   
	   if(wechat == "3"){
		   if(frmGo.role.value=="批单"){
			   if(frmGo.pidanremark.value.trim() == ''){
					alert("批单备注不能为空");
					frmGo.ProjectName.focus();
					return false;
				}
		   }else if(frmGo.role.value=="跟单"){
			   if(frmGo.gdremark.value.trim() == ''){
					alert("跟单备注不能为空");
					frmGo.ProjectName.focus();
					return false;
				}
		   }
	   }
	   
	/* if(frmGo.projectName.value.trim() == ''){
		alert("项目名称不能为空");
		frmGo.ProjectName.focus();
		return false;
	} */
	/* if(frmGo.remark.value.trim().length > 30){
		alert("字数不能超过30字");
		frmGo.remark.focus();
		return false;
	} */
	frmGo.submit();
}

</script>

<body>
<span class="title_1"></span>
<form name="frmGo" method="post" action="doProjectInfo.do?method=updateProjectInfodangan" encType="multipart/form-data" onsubmit="return onUpdate()">
<input style="border:none;" name="id" type="hidden" value="<%=projectInfo.getAt("id")%>" >
<input style="border:none;" name="role" id ="role" type="hidden" value="<%=request.getAttribute("role")%>" >
<%-- <input style="border:none;" name="role" type="hidden" value="<%=projectInfo.getAt("role")%>" > --%>
<!-- <table width="100%" border="0"cellpadding="0" cellspacing="1"  class="tbl_11"> -->
<table width="100%" class="tbl_11" border="1" bordercolorlight=#000000
			bordercolordark=#000000 bordercolor=#000000 cellspacing="0"
			cellpadding="2">
			
			  <%--  <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role"))){ %>
			    <%} %>	 --%>
			   
			   <tr>
				<th colspan="8" nowrap="nowrap" align="left"><%=request.getAttribute("role")%>修改订单信息</th>
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
				<td nowrap="nowrap" align="center" width="7%">
	<input style="border:none;" type="text"   readOnly="true"  size="38"  name="project_no1" id="project_no1" value=<%=projectInfo.getAt("order_id")%>>
</td>
				<td nowrap="nowrap" align="center" width="7%">渠道</td>
				<td nowrap="nowrap" align="center" width="7%">
				
				<select name="qudao" value="qudao">
					<option value="" <%=projectInfo.getAt("qudao").equals("")? "selected":"" %>></option>
						<option value="淘宝" <%=projectInfo.getAt("qudao").equals("淘宝")? "selected":"" %>>淘宝</option>
						<option value="工单" <%=projectInfo.getAt("qudao").equals("工单")? "selected":"" %>>工单</option>
						<option value="分销" <%=projectInfo.getAt("qudao").equals("分销")? "selected":"" %>>分销</option>
						<option value="线下" <%=projectInfo.getAt("qudao").equals("线下")? "selected":"" %>>线下</option>
						<option value="打样" <%=projectInfo.getAt("qudao").equals("打样")? "selected":"" %>>打样</option>
						<option value="重做" <%=projectInfo.getAt("qudao").equals("重做")? "selected":"" %>>重做</option>
						<option value="其他" <%=projectInfo.getAt("qudao").equals("其他")? "selected":"" %>>其他</option>
				</select> 
				
				<%-- 	<input style="border:none;" name="qudao" type="radio" class="radio_1" value="淘宝" <%if("淘宝".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>淘宝
						<input style="border:none;" name="qudao" type="radio" class="radio_1" value="工单" <%if("工单".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>工单
						<input style="border:none;" name="qudao" type="radio" class="radio_1" value="分销" <%if("分销".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>分销
						<input style="border:none;" name="qudao" type="radio" class="radio_1" value="线下" <%if("线下".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>线下
						<input style="border:none;" name="qudao" type="radio" class="radio_1" value="打样" <%if("打样".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>打样
						<input style="border:none;" name="qudao" type="radio" class="radio_1" value="重做" <%if("重做".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>重做
						<input style="border:none;" name="qudao" type="radio" class="radio_1" value="其他" <%if("其他".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>其他 --%>
						</td>
				<td nowrap="nowrap" align="center" width="7%">年龄</td>
				<td  nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" type="text"      size="38"  name="age" id="age"   value="<%=projectInfo.getAt("age")%>"  >
					</td>
				<td nowrap="nowrap" align="center" width="7%">客户电话</td>	
				<td  nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" type="text"    size="38"  name="kehuPhone" id="kehuPhone"   value="<%=projectInfo.getAt("kehu_phone")%>"  >
					</td>
			</tr>
			
				<tr>
				<td nowrap="nowrap" align="center" width="7%">微信号</td>
				<td nowrap="nowrap" align="center" width="7%"><input style="border:none;" type="text"   size="38"  name="wechat" id="wechat"  value=<%=projectInfo.getAt("wechat")%>></td>
				<td nowrap="nowrap" align="center" width="7%">下单客服</td>
				<td><input style="border:none;" type="text"    size="38"  name="project_no" id="project_no"   value="<%=projectInfo.getAt("xiadan_kefu")%>"  ></td>
				<td nowrap="nowrap" align="center" width="7%">性别</td>
				<td  nowrap="nowrap" align="center" width="7%">
				
				<select name="sex" value="sex">
					<option value="" <%=projectInfo.getAt("sex").equals("")? "selected":"" %>></option>
						<option value="男" <%=projectInfo.getAt("sex").equals("男")? "selected":"" %>>男</option>
						<option value="女" <%=projectInfo.getAt("sex").equals("女")? "selected":"" %>>女</option>
				</select> 
				
				<%-- 	<input style="border:none;" name="sex" type="radio" class="radio_1" value="男" <%if("男".equals("" + projectInfo.getAt("sex"))){%>checked<%}%>>男
	    <input style="border:none;" name="sex" type="radio" class="radio_1" value="女" <%if("女".equals("" + projectInfo.getAt("sex"))){%>checked<%}%>>女 --%>
					</td>
				<td nowrap="nowrap" align="center" width="7%">客户姓名</td>	
				<td  nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" type="text"    size="38"  name="kehuName" id="kehuName"   value="<%=projectInfo.getAt("kehu_name")%>"  >
					</td>
			</tr>
			
			<tr>
				<td nowrap="nowrap" align="center" width="7%">订单号</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" type="text"   size="38"  name="orderNumber" id="orderNumber"  value=<%=projectInfo.getAt("order_number")%>>
				</td>
				<td nowrap="nowrap" align="center" width="7%">销售价格</td>
				<td nowrap="nowrap" align="center" width="7%">
	<input style="border:none;" type="text"   size="38"  name="salePrice" id="salePrice"  value=<%=projectInfo.getAt("sale_price")%>>
</td>
				<td nowrap="nowrap" align="center" width="7%">身高</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" type="text"      size="38"  name="height" id="height"   value="<%=projectInfo.getAt("height")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">体重</td>
				<td nowrap="nowrap" align="center" width="7%">
<input style="border:none;" type="text"      size="38"  name="weight" id="weight"   value="<%=projectInfo.getAt("weight")%>"  >
</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">旺旺名</td>
				<td nowrap="nowrap" align="center" width="7%">
<input style="border:none;" type="text"   size="38"  name="projectNo" id="projectNo"  value=<%=projectInfo.getAt("ww_name")%>>
</td>
				<td nowrap="nowrap" align="center" width="7%">下单时间</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" type="text"    readOnly="true" size="38"  name="project_no" id="project_no"   value="<%=projectInfo.getAt("add_time")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="2">客户地址</td>
				<td nowrap="nowrap" align="center" width="7%" colspan="3" rowspan="2">
				<input style="border:none;" type="text"      size="50"  name="address" id="address"   value="<%=projectInfo.getAt("address")%>"  >
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">订单类型</td>
				<td nowrap="nowrap" align="center" width="7%">
			<%-- 		<input style="border:none;" name="orderType" type="radio" class="radio_1" value="新单" <%if("新单".equals("" + projectInfo.getAt("order_type"))){%>checked<%}%>>新单
	    <input style="border:none;" name="orderType" type="radio" class="radio_1" value="打样" <%if("打样".equals("" + projectInfo.getAt("order_type"))){%>checked<%}%>>打样
	    <input style="border:none;" name="orderType" type="radio" class="radio_1" value="重做" <%if("重做".equals("" + projectInfo.getAt("order_type"))){%>checked<%}%>>重做 --%>
	    
	    	<select name="orderType" value="orderType">
	    		<option value="" <%=projectInfo.getAt("order_type").equals("")? "selected":"" %>></option>
						<option value="新单" <%=projectInfo.getAt("order_type").equals("新单")? "selected":"" %>>新单</option>
						<option value="打样" <%=projectInfo.getAt("order_type").equals("打样")? "selected":"" %>>打样</option>
						<option value="重做" <%=projectInfo.getAt("order_type").equals("重做")? "selected":"" %>>重做</option>
						<option value="其他" <%=projectInfo.getAt("order_type").equals("其他")? "selected":"" %>>其他</option>
				</select> 
				
				</td>
				<td nowrap="nowrap" align="center" width="7%">交付时间</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" type="text"      size="38"  name="jiankuanAa" id="jiankuanAa"   value="<%=projectInfo.getAt("jiaofu_time")%>"  >
				<!-- <select name="jiaofu_time" value="jiaofu_time">
						<option value="10">+10天  加急</option>
						<option value="5">+5天  特别加急</option>
						<option value="3">+3天   非常紧急</option>
				</select> <font color="red"></font> -->
				</td>
				
			
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">西装数量</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="xizhuang_number" size="38" id="xizhuang_number" type="number"
					class="txt_1" maxlength="100"   value="<%=projectInfo.getAt("xizhuang_number")%>" />
			</td>
				<td nowrap="nowrap" align="center" width="7%">衣码</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="yi_ma" size="38" type="text" class="txt_1"  maxlength="50"  value="<%=projectInfo.getAt("yi_ma")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%">衬衫数量</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="chenshan_number" size="38" id="chenshan_number" type="number"
					class="txt_1" maxlength="100"  value="<%=projectInfo.getAt("chenshan_number")%>" />
				</td>
				<td nowrap="nowrap" align="center" width="7%">衬衫码</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="chenshan_ma" size="38" type="text" class="txt_1"  maxlength="50"  value="<%=projectInfo.getAt("chenshan_ma")%>">
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">肩宽</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input style="border:none;" type="text"      size="38"  name="jiankuanA" id="jiankuanA"   value="<%=projectInfo.getAt("jiankuan_a")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input style="border:none;" name="jiankuanA2" size="38" type="text" class="txt_1"  maxlength="50"  value="<%=projectInfo.getAt("jiankuan_a2")%>" >
				</td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="4">
					<img src="http://47.111.148.8/watch/upload/test.png" width="100" height="100" />
				</td>
				<td nowrap="nowrap" align="center" width="7%">领围</td>
				<td nowrap="nowrap" align="center" width="7%">
			<input style="border:none;" type="text"      size="38"  name="lingweiB" id="lingweiB"   value="<%=projectInfo.getAt("lingwei_b")%>"  >
		</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input style="border:none;" name="lingweiB2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("lingwei_b2")%>" >
				</td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="4">
					<img src="http://47.111.148.8/watch/upload/test.png" width="100" height="100" />
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">胸围</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input style="border:none;" type="text"      size="38"  name="xiongweiA" id="xiongweiA"   value="<%=projectInfo.getAt("xiongwei_a")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">
				
				<input style="border:none;" name="xiongweiA2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("xiongwei_a2")%>">
				</td>
				
				<td nowrap="nowrap" align="center" width="7%">胸围</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input style="border:none;" type="text"      size="38"  name="xiongweiB" id="xiongweiB"   value="<%=projectInfo.getAt("xiongwei_b")%>"  >
			</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input style="border:none;" name="xiongweiB22" size="38" type="text" class="txt_1"maxlength="50"  value="<%=projectInfo.getAt("xiongwei_2")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">中腰</td>
				<td nowrap="nowrap" align="center" width="7%">
			<input style="border:none;" type="text"      size="38"  name="zhongyaoA" id="zhongyaoA"   value="<%=projectInfo.getAt("zhongyao_a")%>"  >
		</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input style="border:none;" name="zhongyaoA2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("zhongyao_a2")%>">
				</td>
			
				<td nowrap="nowrap" align="center" width="7%">中腰</td>
				<td nowrap="nowrap" align="center" width="7%">
		<input style="border:none;" type="text"      size="38"  name="zhongyaoA" id="zhongyaoA"   value="<%=projectInfo.getAt("zhongyao_b")%>"  >
	</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="zhongyaoB2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("zhongyao_b2")%>" ><font color="red"></font>
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">腹围</td>
				<td nowrap="nowrap" align="center" width="7%">
			<input style="border:none;" type="text"      size="38"  name="fuweiA" id="fuweiA"   value="<%=projectInfo.getAt("fuwei_a")%>"  >
		</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input style="border:none;" name="fuweiA2" id="fuweiA2"  size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("fuwei_a2")%>">
				</td>
				
				<td nowrap="nowrap" align="center" width="7%">腹围</td>
				<td nowrap="nowrap" align="center" width="7%">
<input style="border:none;" type="text"      size="38"  name="fuweiB" id="fuweiB"   value="<%=projectInfo.getAt("fuwei_b")%>"  >
</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input style="border:none;" name="fuweiB2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("fuwei_b2")%>"><font color="red"></font>
				
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">后中衣长</td>
				<td nowrap="nowrap" align="center" width="7%">
<input style="border:none;" type="text"      size="38"  name="houzhongyichangA" id="houzhongyichangA"   value="<%=projectInfo.getAt("houzhongyichang_a")%>"  >
</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input style="border:none;" name="houzhongyichangA2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("houzhongyichang_a2")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="5">
				 <input style="border:none;" name="dakuang1" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("dakuang1")%>">
<%-- 				 <textarea name="dakuang1" id="dakuang1" rows="8" cols="8" class="txt_1"  value="<%=projectInfo.getAt("dakuang1")%>"></textarea>
 --%>				</td>
				<td nowrap="nowrap" align="center" width="7%">衣长</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="yichangB2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("yichang_b2")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="yichang_q" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("yichang_q")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%"rowspan="5">
				 <input style="border:none;" name="dakuang2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("dakuang2")%>">
				 </td>
			</tr>
				<tr>
				<td nowrap="nowrap" align="center" width="7%">前衣长</td>
				<td nowrap="nowrap" align="center" width="7%">
		<input style="border:none;" type="text"      size="38"  name="qianyichangA" id="qianyichangA"   value="<%=projectInfo.getAt("qianyichang_a")%>"  >
	</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input style="border:none;" name="qianyichangA2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("qianyichang_a2")%>">
				</td>
			<!-- 	<td nowrap="nowrap" align="center" width="7%"></td> -->
				<td nowrap="nowrap" align="center" width="7%">腹围</td>
				<td nowrap="nowrap" align="center" width="7%"> 
				 <input style="border:none;" name="fuwei_quea" size="38" type="text" class="txt_1"maxlength="50" value="<%=request.getAttribute("fuwei_quea")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input style="border:none;" name="fuwei_queb" size="38" type="text" class="txt_1"maxlength="50" value="<%=request.getAttribute("fuwei_queb")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">袖长</td>
				<td nowrap="nowrap" align="center" width="7%">
	<input style="border:none;" type="text"      size="38"  name="xiuchangB" id="xiuchangB"   value="<%=projectInfo.getAt("xiuchang_b")%>"  >
</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input style="border:none;" type="text"      size="38"  name="xc_que" id="xc_que"   value="<%=projectInfo.getAt("xc_que")%>"  >
				</td>
				<!-- <td nowrap="nowrap" align="center" width="7%"></td> -->
				<td nowrap="nowrap" align="center" width="7%">袖长</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" type="text"      size="38"  name="xiuchangA" id="xiuchangA"   value="<%=projectInfo.getAt("xiuchang_a")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input style="border:none;" name="xiuchangA2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("xiuchang_a2")%>" >
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">袖肥</td>
				<td nowrap="nowrap" align="center" width="7%">
	<input style="border:none;" type="text"      size="38"  name="xiufeiB" id="xiufeiB"   value="<%=projectInfo.getAt("xiufei_b")%>"  >
</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input style="border:none;" name="xiufeiB2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("xiufei_b2")%>">
				</td>
				<!-- <td nowrap="nowrap" align="center" width="7%"></td> -->
				<td nowrap="nowrap" align="center" width="7%">袖肥</td>
				<td nowrap="nowrap" align="center" width="7%">
	<input style="border:none;" type="text"      size="38"  name="xiufeiA" id="xiufeiA"   value="<%=projectInfo.getAt("xiufei_a")%>"  >
</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="xiukouA2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("xiukou_a2")%>">
				
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">袖口</td>
				<td nowrap="nowrap" align="center" width="7%">
<input style="border:none;" type="text"      size="38"  name="xiukouB" id="xiukouB"   value="<%=projectInfo.getAt("xiukou_b")%>"  >
</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input style="border:none;" name="xiukouB2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("xiukou_b2")%>">
				</td>
				<!-- <td nowrap="nowrap" align="center" width="7%"></td> -->
				<td nowrap="nowrap" align="center" width="7%">袖口</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input style="border:none;" type="text"      size="38"  name="xiukouA" id="xiukouA"   value="<%=projectInfo.getAt("xiukou_a")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" type="text"      size="38"  name="xiukou_que" id="xiukou_que"   value="<%=projectInfo.getAt("xiukou_que")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">西裤数量</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="xiku_number" size="38" id="xiku_number" type="number"
					class="txt_1"  value="<%=projectInfo.getAt("xiku_number")%>" />
				</td>
				<td nowrap="nowrap" align="center" width="7%">裤码</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="ku_ma" size="38" type="text" class="txt_1"  maxlength="50"   value="<%=projectInfo.getAt("ku_ma")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%">马甲数量</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input style="border:none;" name="majia_number" size="38" id="majia_number" type="number"
					class="txt_1" maxlength="100"  value="<%=projectInfo.getAt("majia_number")%>" />
				</td>
				<td nowrap="nowrap" align="center" width="7%">马甲码</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="majia_ma" size="38" type="text" class="txt_1"  maxlength="50"  value="<%=projectInfo.getAt("majia_ma")%>">
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">腰围</td>
				<td nowrap="nowrap" align="center" width="7%">	<input style="border:none;" type="text"      size="38"  name="yaoweiC" id="yaoweiC"   value="<%=projectInfo.getAt("yaowei_c")%>"  ></td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="yaoweiC22" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("yaowei_c22")%>">
			
				</td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="4">
					<img src="http://47.111.148.8/watch/upload/test.png" width="100" height="100" />
				</td>
				<td nowrap="nowrap" align="center" width="7%">肩宽</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input style="border:none;" name="jiankuannew" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("jiankuannew")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input style="border:none;" name="jiankuanque" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("jiankuanque")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="4">
					<img src="http://47.111.148.8/watch/upload/test.png" width="100" height="100" />
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">臀围</td>
				<td nowrap="nowrap" align="center" width="7%">	<input style="border:none;" type="text"      size="38"  name="tuiweiC" id="tuiweiC"   value="<%=projectInfo.getAt("tuiwei_c")%>"  ></td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="tuiweiC2" size="38" type="text" class="txt_1"maxlength="50"  value="<%=projectInfo.getAt("tuiwei_c2")%>">
				
				</td>
				
				<td nowrap="nowrap" align="center" width="7%">胸围</td>
				<td nowrap="nowrap" align="center" width="7%">
<input style="border:none;" type="text"      size="38"  name="xiongweiD" id="xiongweiD"   value="<%=projectInfo.getAt("xiongwei_d")%>"  >
</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="xiongweiD2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("xiongwei_d2")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">档围</td>
				<td nowrap="nowrap" align="center" width="7%">
	<input style="border:none;" type="text"      size="38"  name="dangweiC" id="dangweiC"   value="<%=projectInfo.getAt("dangwei_c")%>"  >
</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="dangweiC2" size="38" type="text" class="txt_1"maxlength="50"  value="<%=projectInfo.getAt("dangwei_c2")%>">
				</td>
				
				<td nowrap="nowrap" align="center" width="7%">中腰</td>
				<td nowrap="nowrap" align="center" width="7%">	<input style="border:none;" type="text"      size="38"  name="zhongyaoD" id="zhongyaoD"   value="<%=projectInfo.getAt("zhongyao_d")%>"  ></td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="zhongyaoD2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("yaowei_c2")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">大腿</td>
				<td nowrap="nowrap" align="center" width="7%">	<input style="border:none;" type="text"      size="38"  name="datuiC" id="datuiC"   value="<%=projectInfo.getAt("datui_c")%>"  ></td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="datuiC2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("datui_c2")%>">
				</td>
				
				<td nowrap="nowrap" align="center" width="7%">衣长</td>
				<td nowrap="nowrap" align="center" width="7%">	<input style="border:none;" type="text"      size="38"  name="yichangD" id="yichangD"   value="<%=projectInfo.getAt("yichang_d")%>"  ></td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="yichangD2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("yichang_d2")%>">
				
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			
			<tr>
				<td nowrap="nowrap" align="center" width="7%">中腿</td>
				<td nowrap="nowrap" align="center" width="7%">	<input style="border:none;" type="text"      size="38"  name="zhongtuiC" id="zhongtuiC"   value="<%=projectInfo.getAt("zhongtui_c")%>"  ></td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="zhongtuiC2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("zhongtui_c2")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="4">
						<input style="border:none;" name="dakuang3" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("dakuang3")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="4">款型</td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="4" colspan="2">
				
				<select name="kuanxingD" value="kuanxingD" >
					<option value="" <%=projectInfo.getAt("kuanxing_d").equals("")? "selected":"" %>></option>
						<option value="修身" <%=projectInfo.getAt("kuanxing_d").equals("修身")? "selected":"" %>>修身</option>
						<option value="修身+" <%=projectInfo.getAt("kuanxing_d").equals("修身+")? "selected":"" %>>修身+</option>
						<option value="合身" <%=projectInfo.getAt("kuanxing_d").equals("合身")? "selected":"" %>>合身</option>
						<option value="合身+"  <%=projectInfo.getAt("kuanxing_d").equals("合身+")? "selected":"" %> >合身+</option>
						<option value="宽松" <%=projectInfo.getAt("kuanxing_d").equals("宽松")? "selected":"" %> >宽松</option>
						<option value="宽松+" <%=projectInfo.getAt("kuanxing_d").equals("宽松+")? "selected":"" %> >宽松+</option>
				</select> 
				
<%-- 	<input style="border:none;" name="kuanxingD" type="radio" class="radio_1" value="修身" <%if("修身".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>修身
		<input style="border:none;" name="kuanxingD" type="radio" class="radio_1" value="修身+" <%if("修身+".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>修身+
		<input style="border:none;" name="kuanxingD" type="radio" class="radio_1" value="合身" <%if("合身".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>合身
		<input style="border:none;" name="kuanxingD" type="radio" class="radio_1" value="合身+" <%if("合身+".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>合身+
		<input style="border:none;" name="kuanxingD" type="radio" class="radio_1" value="宽松" <%if("宽松".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>宽松
		<input style="border:none;" name="kuanxingD" type="radio" class="radio_1" value="宽松+" <%if("宽松+".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>宽松+ --%>
</td>
			
				<td nowrap="nowrap" align="center" width="7%" rowspan="4">
					<input style="border:none;" type="text"      size="38"  name="dakuang4" id="dakuang4"   value="<%=projectInfo.getAt("dakuang4")%>"  >
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">小腿</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input style="border:none;" type="text"      size="38"  name="xiaotuiC" id="xiaotuiC"   value="<%=projectInfo.getAt("xiaotui_c")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="xiaotuiC2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("xiaotui_c2")%>">
				</td>
				
			
				
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">裤长</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" type="text"      size="38"  name="kuchangC" id="kuchangC"   value="<%=projectInfo.getAt("kuchang_c")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="kuchangC2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("kuchang_c2")%>">
				
				</td>
				
				
				
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">脚口</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input style="border:none;" type="text"      size="38"  name="tuikouC" id="tuikouC"   value="<%=projectInfo.getAt("tuikou_c")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="tuikouC2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("tuikou_c2")%>">
				</td>
				
			
				
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">扣型</td>
				<td nowrap="nowrap" align="center" width="7%">
					<select name="kouxingC" value="kouxingC">
						<option value="" <%=projectInfo.getAt("kouxing_c").equals("")? "selected":"" %> ></option>
						<option value="一粒扣" <%=projectInfo.getAt("kouxing_c").equals("一粒扣")? "selected":"" %>  >一粒扣</option>
						<option value="二粒扣" <%=projectInfo.getAt("kouxing_c").equals("二粒扣")? "selected":"" %> >二粒扣</option>
						<option value="三粒扣" <%=projectInfo.getAt("kouxing_c").equals("三粒扣")? "selected":"" %>  >三粒扣</option>
						<option value="双排二扣一" <%=projectInfo.getAt("kouxing_c").equals("双排二扣一")? "selected":"" %>  >双排二扣一</option>
						<option value="双排四扣二" <%=projectInfo.getAt("kouxing_c").equals("双排四扣二")? "selected":"" %>   >双排四扣二</option>
						<option value="双排六扣二" <%=projectInfo.getAt("kouxing_c").equals("双排六扣二")? "selected":"" %>  >双排六扣二</option>
						<option value="其他" <%=projectInfo.getAt("kouxing_c").equals("其他")? "selected":"" %>  >其他</option>
				</select>
					</td>
				<td nowrap="nowrap" align="center" width="7%">口袋</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="koudaiC" value="koudaiC">
					<option value="" <%=projectInfo.getAt("koudai_c").equals("")? "selected":"" %> ></option>
						<option value="1平袋盖、4斜袋盖" <%=projectInfo.getAt("koudai_c").equals("1平袋盖、4斜袋盖")? "selected":"" %>  >1平袋盖、4斜袋盖</option>
						<option value="2平单线、5斜单线" <%=projectInfo.getAt("koudai_c").equals("2平单线、5斜单线")? "selected":"" %>  >2平单线、5斜单线</option>
						<option value="3平双线、6斜双线" <%=projectInfo.getAt("koudai_c").equals("3平双线、6斜双线")? "selected":"" %>  >3平双线、6斜双线</option>
						<option value="7外贴袋" <%=projectInfo.getAt("koudai_c").equals("7外贴袋")? "selected":"" %> >7外贴袋</option>
						<option value="其他" <%=projectInfo.getAt("koudai_c").equals("其他")? "selected":"" %>  >其他</option>
				</select> <font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%">开叉</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="kaicha" value="kaicha">
					<option value="" <%=projectInfo.getAt("kaicha").equals("")? "selected":"" %> ></option>
						<option value="单叉" <%=projectInfo.getAt("kaicha").equals("单叉")? "selected":"" %> >单叉</option>
						<option value="双叉" <%=projectInfo.getAt("kaicha").equals("双叉")? "selected":"" %>  >双叉</option>
						<option value="不开叉" <%=projectInfo.getAt("kaicha").equals("不开叉")? "selected":"" %>   >不开叉</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">领型</td>
				<td nowrap="nowrap" align="center" width="7%">
				
				<select name="lingkoukuaishiB" value="lingkoukuaishiB">
				<option value="" <%=projectInfo.getAt("lingkoukuaishi_b").equals("")? "selected":"" %> ></option>
						<option value="平驳领" <%=projectInfo.getAt("lingkoukuaishi_b").equals("平驳领")? "selected":"" %>  >平驳领</option>
						<option value="戗驳领" <%=projectInfo.getAt("lingkoukuaishi_b").equals("戗驳领")? "selected":"" %>  >戗驳领</option>
						<option value="青果领" <%=projectInfo.getAt("lingkoukuaishi_b").equals("青果领")? "selected":"" %>  >青果领</option>
						<option value="假青果" <%=projectInfo.getAt("lingkoukuaishi_b").equals("假青果")? "selected":"" %>  >假青果</option>
						<option value="假平驳" <%=projectInfo.getAt("lingkoukuaishi_b").equals("假平驳")? "selected":"" %>  >假平驳</option>
						<option value="宽平驳" <%=projectInfo.getAt("lingkoukuaishi_b").equals("宽平驳")? "selected":"" %>  >宽平驳</option>
						<option value="宽戗驳" <%=projectInfo.getAt("lingkoukuaishi_b").equals("宽戗驳")? "selected":"" %>  >宽戗驳</option>
						<option value="其他" <%=projectInfo.getAt("lingkoukuaishi_b").equals("其他")? "selected":"" %>  >其他</option>
				</select> 
				
				<!-- <input style="border:none;" name="lingkoukuaishiB" size="38"
					id="lingkoukuaishiB" type="text" class="txt_1" maxlength="100" /><font
					color="red"></font> -->
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">下摆</td>
				<td nowrap="nowrap" align="center" width="7%">
					<select name="xiabai" value="xiabai">
					<option value="" <%=projectInfo.getAt("xiabai").equals("")? "selected":"" %> ></option>
						<option value="直角下摆" <%=projectInfo.getAt("xiabai").equals("直角下摆")? "selected":"" %>  >直角下摆</option>
						<option value="圆角下摆" <%=projectInfo.getAt("xiabai").equals("圆角下摆")? "selected":"" %>  >圆角下摆</option>
						<option value="大圆角下摆" <%=projectInfo.getAt("xiabai").equals("大圆角下摆")? "selected":"" %>  >大圆角下摆</option>
						<option value="燕尾下摆" <%=projectInfo.getAt("xiabai").equals("燕尾下摆")? "selected":"" %>  >燕尾下摆</option>
						<option value="其他" <%=projectInfo.getAt("xiabai").equals("其他")? "selected":"" %>   >其他</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">撞色</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="zhuangse" value="zhuangse">
				<option value="" <%=projectInfo.getAt("zhuangse").equals("")? "selected":"" %> ></option>
						<option value="袋条用色丁" <%=projectInfo.getAt("zhuangse").equals("袋条用色丁")? "selected":"" %>  >袋条用色丁</option>
						<option value="领边有色丁" <%=projectInfo.getAt("zhuangse").equals("领边有色丁")? "selected":"" %>  >领边有色丁</option>
						<option value="驳头用色丁" <%=projectInfo.getAt("zhuangse").equals("驳头用色丁")? "selected":"" %>   >驳头用色丁</option>
						<option value="驳头用色丁" <%=projectInfo.getAt("zhuangse").equals("其他")? "selected":"" %>  >其他</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">外珠边</td>
				<td nowrap="nowrap" align="center" width="7%">
				
				<select name="waizhubian" value="waizhubian">
					<option value="" <%=projectInfo.getAt("waizhubian").equals("")? "selected":"" %> ></option>
						<option value="有" <%=projectInfo.getAt("waizhubian").equals("有")? "selected":"" %> >有</option>
						<option value="无" <%=projectInfo.getAt("waizhubian").equals("无")? "selected":"" %> >无</option>
				</select> 
				
			<%-- 	<input style="border:none;" name="waizhubian" size="38"
					id="waizhubian" type="text" class="txt_1" maxlength="100"  value="<%=projectInfo.getAt("waizhubian")%>" /><font
					color="red"></font> --%>
				</td>
				<td nowrap="nowrap" align="center" width="7%">袖叉</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="xiucha" value="xiucha">
				<option value="" <%=projectInfo.getAt("xiucha").equals("")? "selected":"" %> ></option>
						<option value="真袖叉" <%=projectInfo.getAt("xiucha").equals("真袖叉")? "selected":"" %>  >真袖叉</option>
						<option value="假袖叉" <%=projectInfo.getAt("xiucha").equals("假袖叉")? "selected":"" %>  >假袖叉</option>
						<option value="翻袖" <%=projectInfo.getAt("xiucha").equals("翻袖")? "selected":"" %>   >翻袖</option>
						<option value="其它" <%=projectInfo.getAt("xiucha").equals("其它")? "selected":"" %>   >其它</option>
				</select>
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">裤腰</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="kuyao" value="kuyao">
				<option value="" <%=projectInfo.getAt("kuyao").equals("")? "selected":"" %> ></option>
						<option value="伸出订扣" <%=projectInfo.getAt("kuyao").equals("伸出订扣")? "selected":"" %>  >伸出订扣</option>
						<option value="伸出订钩" <%=projectInfo.getAt("kuyao").equals("伸出订钩")? "selected":"" %>  >伸出订钩</option>
						<option value="不伸头" <%=projectInfo.getAt("kuyao").equals("不伸头")? "selected":"" %>  >不伸头</option>
						<option value="松紧" <%=projectInfo.getAt("kuyao").equals("松紧")? "selected":"" %>  >松紧</option>
						<option value="调节扣" <%=projectInfo.getAt("kuyao").equals("调节扣")? "selected":"" %>  >调节扣</option>
						<option value="那不勒斯" <%=projectInfo.getAt("kuyao").equals("那不勒斯")? "selected":"" %>  >那不勒斯</option>
						<option value="其它" <%=projectInfo.getAt("kuyao").equals("其它")? "selected":"" %> >其它</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">裤型</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="kuxing" value="kuxing">
				<option value="" <%=projectInfo.getAt("kuxing").equals("")? "selected":"" %> ></option>
						<option value="修身裤" <%=projectInfo.getAt("kuxing").equals("修身裤")? "selected":"" %>  >修身裤</option>
						<option value="翻边" <%=projectInfo.getAt("kuxing").equals("翻边")? "selected":"" %>  >翻边</option>
						<option value="单褶" <%=projectInfo.getAt("kuxing").equals("单褶")? "selected":"" %>  >单褶</option>
						<option value="双褶" <%=projectInfo.getAt("kuxing").equals("双褶")? "selected":"" %>  >双褶</option>
						<option value="萝卜裤" <%=projectInfo.getAt("kuxing").equals("萝卜裤")? "selected":"" %>  >萝卜裤</option>
						<option value="直筒裤" <%=projectInfo.getAt("kuxing").equals("直筒裤")? "selected":"" %>  >直筒裤</option>
						<option value="其它" <%=projectInfo.getAt("kuxing").equals("其它")? "selected":"" %>  >其它</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">衬衫领</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="chenshanling" value="chenshanling">
				<option value="" <%=projectInfo.getAt("chenshanling").equals("")? "selected":"" %> ></option>
						<option value="小方领" <%=projectInfo.getAt("chenshanling").equals("小方领")? "selected":"" %> >小方领</option>
						<option value="小尖领" <%=projectInfo.getAt("chenshanling").equals("小尖领")? "selected":"" %> >小尖领</option>
						<option value="v尖领" <%=projectInfo.getAt("chenshanling").equals("v尖领")? "selected":"" %> >v尖领</option>
						<option value="正方领" <%=projectInfo.getAt("chenshanling").equals("正方领")? "selected":"" %> >正方领</option>
						<option value="大领" <%=projectInfo.getAt("chenshanling").equals("大领")? "selected":"" %> >大领</option>
						<option value="其它" <%=projectInfo.getAt("chenshanling").equals("其它")? "selected":"" %> >其它</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">衬衫袖</td>
				<td nowrap="nowrap" align="center" width="7%">
					<select name="chenshanxiu" value="chenshanxiu">
					<option value="" <%=projectInfo.getAt("chenshanxiu").equals("")? "selected":"" %> ></option>
						<option value="法式门襟＋袖" <%=projectInfo.getAt("chenshanxiu").equals("法式门襟＋袖")? "selected":"" %> >法式门襟＋袖</option>
						<option value="直角二扣" <%=projectInfo.getAt("chenshanxiu").equals("直角二扣")? "selected":"" %> >直角二扣</option>
						<option value="直角一扣" <%=projectInfo.getAt("chenshanxiu").equals("直角一扣")? "selected":"" %> >直角一扣</option>
						<option value="圆角二扣" <%=projectInfo.getAt("chenshanxiu").equals("圆角二扣")? "selected":"" %> >圆角二扣</option>
						<option value="圆角一扣" <%=projectInfo.getAt("chenshanxiu").equals("圆角一扣")? "selected":"" %> >圆角一扣</option>
						<option value="翻袖" <%=projectInfo.getAt("chenshanxiu").equals("翻袖")? "selected":"" %>  >翻袖</option>
						<option value="其它" <%=projectInfo.getAt("chenshanxiu").equals("其它")? "selected":"" %>  >其它</option>
				</select>
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">面料</td>
				<td nowrap="nowrap" align="center" width="7%">
			<input style="border:none;" type="text"      size="38"  name="miaoliao1" id="miaoliao1"   value="<%=projectInfo.getAt("miao_liao1")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">用途</td>
				<td nowrap="nowrap" align="center" width="7%"><!-- 
					 <input style="border:none;" type="text"   size="38"  name="yongtu1" id="yongtu1"   value="<%=projectInfo.getAt("yong_tu1")%>"  >-->
					
						<select name="yongtu1" value="yongtu1">
						<option value="上衣">上衣</option>
						<option value="裤子">裤子</option>
						<option value="马甲">马甲</option>
						<option value="衬衫">衬衫</option>
						<option value="衬衫">衬衫</option>
						<option value="西装套装">西装套装</option>
						<option value="换片">换片</option>
						<option value="其他">其他</option>
				</select> 
				
				</td>
				<td nowrap="nowrap" align="center" width="7%">米数</td>
				<td nowrap="nowrap" align="center" width="7%">
						<input style="border:none;" name="mi1" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("mi1")%>" >
				</td>
				<td nowrap="nowrap" align="center" width="7%">供应商</td>
				<td nowrap="nowrap" align="center" width="7%">
					<%=request.getAttribute("companyList")%>
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">面料</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" type="text"   size="38"  name="miaoliao2" id="miaoliao2"   value="<%=projectInfo.getAt("miao_liao2")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">用途</td>
				<td nowrap="nowrap" align="center" width="7%">
					<select name="yongtu2" value="yongtu2">
						<option value="上衣">上衣</option>
						<option value="裤子">裤子</option>
						<option value="马甲">马甲</option>
						<option value="衬衫">衬衫</option>
						<option value="衬衫">衬衫</option>
						<option value="西装套装">西装套装</option>
						<option value="换片">换片</option>
						<option value="其他">其他</option>
				</select> 
					<%-- <input style="border:none;" type="text"   size="38"  name="yongtu2" id="yongtu2"   value="<%=projectInfo.getAt("yong_tu2")%>"  > --%>
				</td>
				<td nowrap="nowrap" align="center" width="7%">米数</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="mi2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("mi2")%>" >
				</td>
				<td nowrap="nowrap" align="center" width="7%">供应商</td>
				<td nowrap="nowrap" align="center" width="7%">
					<%=request.getAttribute("companyList1")%>
				</td>
			</tr>
			  <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "客服经理".equals(request.getAttribute("role")) ){ %>
<tr>
				<td nowrap="nowrap" align="center" width="7%">附件</td>
				<td nowrap="nowrap" align="center" width="7%"><input style="border:none;" type="file" name="channelId"  multiple="multiple"
					id="channelId" multiple="multiple" class="imagePath" /> <img alt=""
					src="" id="image1" class="showImage"></td>
			</tr>
			    <%} %>
			    
			
			
			<tr>
				<td nowrap="nowrap" align="center" width="7%">客服备注</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="7">
	<input style="border:none;" type="text"   size="160"  name="remark" id="remark"   value="<%=projectInfo.getAt("remark")%>"  >
</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">批单备注</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="7">
				<input style="border:none;" type="text"    size="160"  name="pidanremark" id="pidanremark"   value="<%=projectInfo.getAt("pidan_remark")%>" >
					
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">跟单备注</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="7">
					<input style="border:none;" type="text"      size="160"  name="gdremark" id="gdremark"   value="<%=projectInfo.getAt("gd_remark")%>"  > 
				</td>
			</tr>
				<%-- <tr>
				<td nowrap="nowrap" align="center" width="7%">提交类型</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="7">
					保存 <input style="border:none;" name="tag" type="radio" class="radio_1" value="1" checked="checked" >
	    保存并提交<input style="border:none;" type="radio" name="tag" class="radio_1" value="2" >
	    
	     <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) || "跟单".equals(request.getAttribute("role")) ){ %>
	     退回 <input style="border:none;" type="radio" name="tag" class="radio_1" value="3" >
			    <%} %>
	    		 --%>
	
	    
				<!-- </td>
			</tr> -->
			
			
			   
			  
			
  

			<tr>
			<td nowrap="nowrap" align="center" width="7%">
			<input style="border:none;" name="anniu" size="200" id="anniu"
					 type="hidden" class="txt_1"  />
			</td>
					
					 
						<td nowrap="nowrap" align="right" width="7%">
						<input style="border:none;" type="button" title ="1"  name="ok" accesskey="y" tabindex="y"  value="保存" class="but_1" onclick="onUpdate(this.title)">
						
						<input style="border:none;" type="button" title ="2"  name="ok" accesskey="y" tabindex="y"  value="保存并提交" class="but_1" onclick="onUpdate(this.title)"  style="font-size:12;width:80px;height:21px;">
						</td>
							<td nowrap="nowrap" align="left" width="7%" colspan="6">
						 
			    
						
	
      <input style="border:none;" type="button" name="back" accesskey="b" tabindex="b" value="返 回" class="but_1" onclick="location='doProjectInfo.do?method=queryProjectInfoXml'">
   <!--    <input style="border:none;" type="reset" name="back" accesskey="b" tabindex="b" value="重置" class="but_1" > -->
      
       <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) || "跟单".equals(request.getAttribute("role")) ){ %>
	<input style="border:none;" type="button"  title ="3" name="ok" accesskey="y" tabindex="y"  value="退回" class="but_1" onclick="onUpdate(this.title)" style="color: red">
			    <%} %>
				</td>
			</tr>
			
              
				
			
		

</table>
</form>
</body>
</html>
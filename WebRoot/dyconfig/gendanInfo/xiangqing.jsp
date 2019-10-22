<%@ page language="java" contentType="text/html;charset=gb2312"%>
<%@ page import = "com.godoing.rose.http.common.*" %>
<%@ page import = "com.godoing.rose.lang.*" %>
<%@ page import="com.care.common.lang.*"%>
<%@ page import="com.care.common.config.Config"%>
<%@ page import="com.care.app.LoginUser"%>
<%@ taglib uri="/WEB-INF/struts-bean" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic" prefix="logic"%>
<jsp:useBean id = "orderall" scope = "request" class = "com.godoing.rose.lang.DataMap"/>
<jsp:useBean id = "projectInfo" scope = "request" class = "com.godoing.rose.lang.DataMap"/>
<jsp:useBean id = "duoyu" scope = "request" class = "com.godoing.rose.lang.DataMap"/>
<%@ page autoFlush="true" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="<%=request.getContextPath()%>/css/tbls.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="<%=request.getContextPath()%>/public/public.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/jquery-1.8.2.js"></script>
<title>无标题文档</title>
</head>
<!--
<style>
select
{outline: none;border: none;
appearance: none;
-moz-appearance: none;
-webkit-appearance: none;
}
</style>
-->
<style>
	.add_order_table tr th, .add_order_table tr td{border-bottom: 1px solid #bbb; border-left:1px solid #bbb; padding:10px;}
	.add_order_table tr th{border-left:0;}
	.add_order_table tr td:last-child{border-right:1px solid #bbb;}
/*	.add_order_table tr td:first-child{border-left: 0;}*/
/*	.add_order_table tr:last-child td{border-bottom:0;}*/
	.add_order_table input, .add_order_table select{width: 100%; padding:5px; border:1px solid #ccc;} 
	.table_title{font-size:22px;}
	.t_subtitle th, .t_subtitle td{background:#F8CBAD;}
	.f_bold{font-weight: bold;}
	.td_bg_pink{background:#FCE4D6;}
	.td_bg_yellow{background:#FFF2CC; white-space: nowrap;}
	.add_order_table .btn{padding:6px 20px; width: auto; height: auto; font-size:14px; background:#337ab7; border-radius: 6px; color: #fff; border:1px solid #286090;}
	.padd0{padding:0 !important;}
	
</style>

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
function onUpdate(){
 	if(frmGo.gdremark.value.trim() == ''){
		alert("跟单备注不能为空!!!");
		frmGo.gdremark.focus();
		return false;
	}
	frmGo.submit();
}

</script>
<body>
<span class="title_1"></span>
<form name="frmGo" method="post" action="doProjectInfo.do?method=updateProjectInfoGenDan" encType="multipart/form-data" onsubmit="return onUpdate()">
<input  name="id" type="hidden" value="<%=projectInfo.getAt("id")%>" >
<!-- <table width="100%" border="0"cellpadding="0" cellspacing="1"  class="tbl_11"> -->
<table width="100%" class="tbl_11 add_order_table" border="0" cellspacing="0" cellpadding="0">
			
			
		   <tr>
				<th colspan="8" nowrap="nowrap" align="left">订单信息</th>
			</tr>

<!--
				<tr class="tr_11">
				<td colspan="8" nowrap="nowrap" align="center" >不一定制和周卢江   客户信息档案表</td>
			</tr>
			
			<tr>
				<td colspan="4" nowrap="nowrap" align="center" >订单信息</td>
				<td colspan="4" nowrap="nowrap" align="center" >订单信息</td>
			</tr>
-->
			
			<tr>
				<td nowrap="nowrap" align="center" class="f_bold">订单编号</td>
				<td nowrap="nowrap" align="center" >
	<input  type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("order_id")%>>
</td>
				<td nowrap="nowrap" align="center" class="f_bold">渠道</td>
				<td nowrap="nowrap" align="center" >
				<input  type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("qudao")%>>
				<!-- <select name="qudao" value="qudao">
						<option value="淘宝">淘宝</option>
						<option value="工单">工单</option>
						<option value="分销">分销</option>
						<option value="线下">线下</option>
						<option value="打样">打样</option>
						<option value="重做">重做</option>
						<option value="其他">其他</option>
				</select>  -->
				
				<%-- 	<input  name="qudao" type="radio" class="radio_1" value="淘宝" <%if("淘宝".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>淘宝
						<input  name="qudao" type="radio" class="radio_1" value="工单" <%if("工单".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>工单
						<input  name="qudao" type="radio" class="radio_1" value="分销" <%if("分销".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>分销
						<input  name="qudao" type="radio" class="radio_1" value="线下" <%if("线下".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>线下
						<input  name="qudao" type="radio" class="radio_1" value="打样" <%if("打样".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>打样
						<input  name="qudao" type="radio" class="radio_1" value="重做" <%if("重做".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>重做
						<input  name="qudao" type="radio" class="radio_1" value="其他" <%if("其他".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>其他 --%>
						</td>
				<td nowrap="nowrap" align="center" class="f_bold">年龄</td>
				<td  nowrap="nowrap" align="center" >
				<input  type="text"        name="age" id="age"   value="<%=projectInfo.getAt("age")%>"  >
					</td>
				<td nowrap="nowrap" align="center" class="f_bold">客户电话</td>	
				<td  nowrap="nowrap" align="center" >
				<input  type="text"      name="kehuPhone" id="kehuPhone"   value="<%=projectInfo.getAt("kehu_phone")%>"  >
					</td>
			</tr>
			
				<tr>
				<td nowrap="nowrap" align="center" class="f_bold">微信号</td>
				<td nowrap="nowrap" align="center" ><input  type="text"     name="wechat" id="wechat"  value=<%=projectInfo.getAt("wechat")%>></td>
				<td nowrap="nowrap" align="center" class="f_bold">下单客服</td>
				<td><input  type="text"      name="project_no" id="project_no"   value="<%=projectInfo.getAt("xiadan_kefu")%>"  ></td>
				<td nowrap="nowrap" align="center" class="f_bold">性别</td>
				<td  nowrap="nowrap" align="center" >
					<input  type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("sex")%>>
			<!-- 	<select name="sex" value="sex">
						<option value="男">男</option>
						<option value="女">女</option>
				</select>  -->
				
				<%-- 	<input  name="sex" type="radio" class="radio_1" value="男" <%if("男".equals("" + projectInfo.getAt("sex"))){%>checked<%}%>>男
	    <input  name="sex" type="radio" class="radio_1" value="女" <%if("女".equals("" + projectInfo.getAt("sex"))){%>checked<%}%>>女 --%>
					</td>
				<td nowrap="nowrap" align="center" class="f_bold">客户姓名</td>	
				<td  nowrap="nowrap" align="center" >
				<input  type="text"      name="kehuName" id="kehuName"   value="<%=projectInfo.getAt("kehu_name")%>"  >
					</td>
			</tr>
			
			<tr>
				<td nowrap="nowrap" align="center" class="f_bold">订单号</td>
				<td nowrap="nowrap" align="center" >
				<input  type="text"     name="orderNumber" id="orderNumber"  value=<%=projectInfo.getAt("order_number")%>>
				</td>
				<td nowrap="nowrap" align="center" class="f_bold">销售价格</td>
				<td nowrap="nowrap" align="center" >
	<input  type="text"     name="salePrice" id="salePrice"  value=<%=projectInfo.getAt("sale_price")%>>
</td>
				<td nowrap="nowrap" align="center" class="f_bold">身高</td>
				<td nowrap="nowrap" align="center" >
				<input  type="text"        name="height" id="height"   value="<%=projectInfo.getAt("height")%>"  >
				</td>
				<td nowrap="nowrap" align="center" class="f_bold">体重</td>
				<td nowrap="nowrap" align="center" >
<input  type="text"        name="weight" id="weight"   value="<%=projectInfo.getAt("weight")%>"  >
</td>
			</tr>
				 <%if(!"".equals(orderall.getAt("orderNumber1"))&& orderall.getAt("orderNumber1")!=null ){ %>
          	<tr>
				<td nowrap="nowrap" align="center" class="f_bold">订单号</td>
				<td nowrap="nowrap" align="center" >
				<input  type="text"     name="orderNumber" id="orderNumber"  value=<%=orderall.getAt("orderNumber1")%>>
				</td>
				<td nowrap="nowrap" align="center" class="f_bold">销售价格</td>
				<td nowrap="nowrap" align="center" >
	<input  type="text"     name="salePrice" id="salePrice"  value=<%=orderall.getAt("xsjg1")%>>
</td>
				<td nowrap="nowrap" align="center" colspan="4"></td>
			</tr>
			 <%} %>
			  <%if(!"".equals(orderall.getAt("orderNumber2"))&& orderall.getAt("orderNumber2")!=null ){ %>
          	<tr>
				<td nowrap="nowrap" align="center" class="f_bold">订单号</td>
				<td nowrap="nowrap" align="center" >
				<input  type="text"     name="orderNumber" id="orderNumber"  value=<%=orderall.getAt("orderNumber2")%>>
				</td>
				<td nowrap="nowrap" align="center" class="f_bold">销售价格</td>
				<td nowrap="nowrap" align="center" >
	<input  type="text"     name="salePrice" id="salePrice"  value=<%=orderall.getAt("xsjg2")%>>
</td>
				<td nowrap="nowrap" align="center" colspan="4"></td>
			</tr>
			 <%} %>
			 
			  <%if(!"".equals(orderall.getAt("orderNumber3"))&& orderall.getAt("orderNumber3")!=null ){ %>
          	<tr>
				<td nowrap="nowrap" align="center" class="f_bold">订单号</td>
				<td nowrap="nowrap" align="center" >
				<input  type="text"     name="orderNumber" id="orderNumber"  value=<%=orderall.getAt("orderNumber3")%>>
				</td>
				<td nowrap="nowrap" align="center" class="f_bold">销售价格</td>
				<td nowrap="nowrap" align="center" >
	<input  type="text"     name="salePrice" id="salePrice"  value=<%=orderall.getAt("xsjg3")%>>
</td>
				<td nowrap="nowrap" align="center" colspan="4"></td>
			</tr>
			 <%} %>
			  <%if(!"".equals(orderall.getAt("orderNumber4"))&& orderall.getAt("orderNumber4")!=null ){ %>
          	<tr>
				<td nowrap="nowrap" align="center" class="f_bold">订单号</td>
				<td nowrap="nowrap" align="center" >
				<input  type="text"     name="orderNumber" id="orderNumber"  value=<%=orderall.getAt("orderNumber4")%>>
				</td>
				<td nowrap="nowrap" align="center" class="f_bold">销售价格</td>
				<td nowrap="nowrap" align="center" >
	<input  type="text"     name="salePrice" id="salePrice"  value=<%=orderall.getAt("xsjg4")%>>
</td>
				<td nowrap="nowrap" align="center" colspan="4"></td>
			</tr>
			 <%} %>
			  <%if(!"".equals(orderall.getAt("orderNumber5"))&& orderall.getAt("orderNumber5")!=null ){ %>
          	<tr>
				<td nowrap="nowrap" align="center" class="f_bold">订单号</td>
				<td nowrap="nowrap" align="center" >
				<input  type="text"     name="orderNumber" id="orderNumber"  value=<%=orderall.getAt("orderNumber5")%>>
				</td>
				<td nowrap="nowrap" align="center" class="f_bold">销售价格</td>
				<td nowrap="nowrap" align="center" >
	<input  type="text"     name="salePrice" id="salePrice"  value=<%=orderall.getAt("xsjg5")%>>
</td>
				<td nowrap="nowrap" align="center" colspan="4"></td>
			</tr>
			 <%} %>
			  <%if(!"".equals(orderall.getAt("orderNumber6"))&& orderall.getAt("orderNumber6")!=null ){ %>
          	<tr>
				<td nowrap="nowrap" align="center" class="f_bold">订单号</td>
				<td nowrap="nowrap" align="center" >
				<input  type="text"     name="orderNumber" id="orderNumber"  value=<%=orderall.getAt("orderNumber6")%>>
				</td>
				<td nowrap="nowrap" align="center" class="f_bold">销售价格</td>
				<td nowrap="nowrap" align="center" >
	<input  type="text"     name="salePrice" id="salePrice"  value=<%=orderall.getAt("xsjg6")%>>
</td>
				<td nowrap="nowrap" align="center" colspan="4"></td>
			</tr>
			 <%} %>
			 
			  <%if(!"".equals(orderall.getAt("orderNumber7"))&& orderall.getAt("orderNumber7")!=null ){ %>
          	<tr>
				<td nowrap="nowrap" align="center" class="f_bold">订单号</td>
				<td nowrap="nowrap" align="center" >
				<input  type="text"     name="orderNumber" id="orderNumber"  value=<%=orderall.getAt("orderNumber7")%>>
				</td>
				<td nowrap="nowrap" align="center" class="f_bold">销售价格</td>
				<td nowrap="nowrap" align="center" >
	<input  type="text"     name="salePrice" id="salePrice"  value=<%=orderall.getAt("xsjg7")%>>
</td>
				<td nowrap="nowrap" align="center" colspan="4"></td>
			</tr>
			 <%} %>
			   <%if(!"".equals(orderall.getAt("orderNumber8"))&& orderall.getAt("orderNumber8")!=null ){ %>
          	<tr>
				<td nowrap="nowrap" align="center" class="f_bold">订单号</td>
				<td nowrap="nowrap" align="center" >
				<input  type="text"     name="orderNumber" id="orderNumber"  value=<%=orderall.getAt("orderNumber8")%>>
				</td>
				<td nowrap="nowrap" align="center" class="f_bold">销售价格</td>
				<td nowrap="nowrap" align="center" >
	<input  type="text"     name="salePrice" id="salePrice"  value=<%=orderall.getAt("xsjg8")%>>
</td>
				<td nowrap="nowrap" align="center" colspan="4"></td>
			</tr>
			 <%} %>
			 
			   <%if(!"".equals(orderall.getAt("orderNumber9"))&& orderall.getAt("orderNumber9")!=null ){ %>
          	<tr>
				<td nowrap="nowrap" align="center" class="f_bold">订单号</td>
				<td nowrap="nowrap" align="center" >
				<input  type="text"     name="orderNumber" id="orderNumber"  value=<%=orderall.getAt("orderNumber9")%>>
				</td>
				<td nowrap="nowrap" align="center" class="f_bold">销售价格</td>
				<td nowrap="nowrap" align="center" >
	<input  type="text"     name="salePrice" id="salePrice"  value=<%=orderall.getAt("xsjg9")%>>
</td>
				<td nowrap="nowrap" align="center" colspan="4"></td>
			</tr>
			 <%} %>
			<tr>
				<td nowrap="nowrap" align="center" class="f_bold">旺旺名</td>
				<td nowrap="nowrap" align="center" >
<input  type="text"     name="projectNo" id="projectNo"  value=<%=projectInfo.getAt("ww_name")%>>
</td>
				<td nowrap="nowrap" align="center" class="f_bold">下单时间</td>
				<td nowrap="nowrap" align="center" >
				<input  type="text"    readOnly="true"   name="project_no" id="project_no"   value="<%=projectInfo.getAt("add_time")%>"  >
				</td>
				<td nowrap="nowrap" align="center" class="f_bold">客户地址</td>
				<td nowrap="nowrap" align="center"  colspan="3">
				<input  type="text"        name="address" id="address"   value="<%=projectInfo.getAt("address")%>"  >
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" class="f_bold">订单类型</td>
				<td nowrap="nowrap" align="center" >
			<%-- 		<input  name="orderType" type="radio" class="radio_1" value="新单" <%if("新单".equals("" + projectInfo.getAt("order_type"))){%>checked<%}%>>新单
	    <input  name="orderType" type="radio" class="radio_1" value="打样" <%if("打样".equals("" + projectInfo.getAt("order_type"))){%>checked<%}%>>打样
	    <input  name="orderType" type="radio" class="radio_1" value="重做" <%if("重做".equals("" + projectInfo.getAt("order_type"))){%>checked<%}%>>重做 --%>
	    	<input  type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("order_type")%>>
	    	<!-- <select name="orderType" value="orderType">
						<option value="新单">新单</option>
						<option value="打样">打样</option>
						<option value="重做">重做</option>
						<option value="其他">其他</option>
				</select>  -->
				
				</td>
				<td nowrap="nowrap" align="center" class="f_bold">交付时间</td>
				<td nowrap="nowrap" align="center" >
					<input  type="text"        name="jiankuanA" id="jiankuanA"   value="<%=projectInfo.getAt("jiaofu_time")%>"  >
				<!-- <select name="jiaofu_time" value="jiaofu_time">
						<option value="10">+10天  加急</option>
						<option value="5">+5天  特别加急</option>
						<option value="3">+3天   非常紧急</option>
				</select> <font color="red"></font> -->
				</td>
				
				<td nowrap="nowrap" align="center" ></td>
				<td nowrap="nowrap" align="center" ></td>
				<td nowrap="nowrap" align="center" ></td>
				<td nowrap="nowrap" align="center" ></td>
			</tr>
			<tr class="t_subtitle">
				<td nowrap="nowrap" align="center" class="f_bold">西装数量</td>
				<td nowrap="nowrap" align="center" >
				<input  name="xizhuang_number"  id="xizhuang_number" type="number"
					class="txt_1"    value="<%=projectInfo.getAt("xizhuang_number")%>" />
			</td>
				<td nowrap="nowrap" align="center" class="f_bold">衣码</td>
				<td nowrap="nowrap" align="center" >
				<input  name="yi_ma"  type="text" class="txt_1"    value="<%=projectInfo.getAt("yi_ma")%>" >
				</td>
				<td nowrap="nowrap" align="center" class="f_bold">衬衫数量</td>
				<td nowrap="nowrap" align="center" >
				<input  name="chenshan_number"  id="chenshan_number" type="number"
					class="txt_1"   value="<%=projectInfo.getAt("chenshan_number")%>" />
				</td>
				<td nowrap="nowrap" align="center" class="f_bold">衬衫码</td>
				<td nowrap="nowrap" align="center" >
				<input  name="chenshan_ma"  type="text" class="txt_1"    value="<%=projectInfo.getAt("chenshan_ma")%>" >
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" class="f_bold">肩宽</td>
				<td nowrap="nowrap" align="center" >
					<input  type="text"        name="jiankuanA" id="jiankuanA"   value="<%=projectInfo.getAt("jiankuan_a")%>"  >
				</td>
				<td nowrap="nowrap" align="center" >
				 <input  name="jiankuanA2"  type="text" class="txt_1"    value="<%=projectInfo.getAt("jiankuan_a2")%>" >
				</td>
				<td nowrap="nowrap" align="center"  rowspan="4">
				<img src="<%=request.getAttribute("erweima_1")%>" width="100" height="100" />
				</td>
				<td nowrap="nowrap" align="center" class="f_bold">领围</td>
				<td nowrap="nowrap" align="center" >
			<input  type="text"        name="lingweiB" id="lingweiB"   value="<%=projectInfo.getAt("lingwei_b")%>"  >
		</td>
				<td nowrap="nowrap" align="center" >
				 <input  name="lingweiB2"  type="text" class="txt_1" value="<%=projectInfo.getAt("lingwei_b2")%>" >
				</td>
				<td nowrap="nowrap" align="center"  rowspan="4">
				<img src="<%=request.getAttribute("erweima_2")%>" width="100" height="100" />
				</td>
			</tr>
			<tr class="td_bg_pink">
				<td nowrap="nowrap" align="center" class="f_bold">胸围</td>
				<td nowrap="nowrap" align="center" >
					<input  type="text"        name="xiongweiA" id="xiongweiA"   value="<%=projectInfo.getAt("xiongwei_a")%>"  >
				</td>
				<td nowrap="nowrap" align="center" >
				
				<input  name="xiongweiA2"  type="text" class="txt_1" value="<%=projectInfo.getAt("xiongwei_a2")%>">
				</td>
				
				<td nowrap="nowrap" align="center" class="f_bold">胸围</td>
				<td nowrap="nowrap" align="center" >
					<input  type="text"        name="xiongweiB" id="xiongweiB"   value="<%=projectInfo.getAt("xiongwei_b")%>"  >
			</td>
				<td nowrap="nowrap" align="center" >
				 <input  name="xiongweiB22"  type="text" class="txt_1"  value="<%=projectInfo.getAt("xiongwei_2")%>">
				</td>
<!--				<td nowrap="nowrap" align="center" ></td>-->
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" class="f_bold">中腰</td>
				<td nowrap="nowrap" align="center" >
			<input  type="text"        name="zhongyaoA" id="zhongyaoA"   value="<%=projectInfo.getAt("zhongyao_a")%>"  >
		</td>
				<td nowrap="nowrap" align="center" >
				 <input  name="zhongyaoA2"  type="text" class="txt_1" value="<%=projectInfo.getAt("zhongyao_a2")%>">
				</td>
			
				<td nowrap="nowrap" align="center" class="f_bold">中腰</td>
				<td nowrap="nowrap" align="center" >
		<input  type="text"        name="zhongyaoA" id="zhongyaoA"   value="<%=projectInfo.getAt("zhongyao_a")%>"  >
	</td>
				<td nowrap="nowrap" align="center" >
				<input  name="zhongyaoB2"  type="text" class="txt_1" value="<%=projectInfo.getAt("zhongyao_b2")%>" ><font color="red"></font>
				</td>
<!--				<td nowrap="nowrap" align="center" ></td>-->
			</tr>
			<tr class="td_bg_pink">
				<td nowrap="nowrap" align="center" class="f_bold">腹围</td>
				<td nowrap="nowrap" align="center" >
			<input  type="text"        name="fuweiA" id="fuweiA"   value="<%=projectInfo.getAt("fuwei_a")%>"  >
		</td>
				<td nowrap="nowrap" align="center" >
				 <input  name="fuweiA2"  type="text" class="txt_1" value="<%=projectInfo.getAt("fuwei_a2")%>">
				</td>
				
				<td nowrap="nowrap" align="center" class="f_bold">腹围</td>
				<td nowrap="nowrap" align="center" >
<input  type="text"        name="fuweiB" id="fuweiB"   value="<%=projectInfo.getAt("fuwei_b")%>"  >
</td>
				<td nowrap="nowrap" align="center" >
				 <input  name="fuweiB2"  type="text" class="txt_1" value="<%=projectInfo.getAt("fuwei_b2")%>"><font color="red"></font>
				
				</td>
<!--				<td nowrap="nowrap" align="center" ></td>-->
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" class="f_bold">后中衣长</td>
				<td nowrap="nowrap" align="center" >
<input  type="text"        name="houzhongyichangA" id="houzhongyichangA"   value="<%=projectInfo.getAt("houzhongyichang_a")%>"  >
</td>
				<td nowrap="nowrap" align="center" >
				 <input  name="houzhongyichangA2"  type="text" class="txt_1" value="<%=projectInfo.getAt("houzhongyichang_a2")%>">
				</td>
				<td nowrap="nowrap" align="center"  rowspan="5">
				 <input  name="dakuang1"  type="text" class="txt_1" value="<%=projectInfo.getAt("dakuang1")%>">
<%-- 				 <textarea name="dakuang1" id="dakuang1" rows="8" cols="8" class="txt_1"  value="<%=projectInfo.getAt("dakuang1")%>"></textarea>
 --%>				</td>
				<td nowrap="nowrap" align="center" class="f_bold">衣长</td>
				<td nowrap="nowrap" align="center" >
				<input  name="yichangB2"  type="text" class="txt_1" value="<%=projectInfo.getAt("yichang_b2")%>">
				</td>
				<td nowrap="nowrap" align="center" >
				<input  name="yichangB2"  type="text" class="txt_1" value="<%=projectInfo.getAt("yichang_q")%>">
				</td>
				<td nowrap="nowrap" align="center" rowspan="5">
				 <input  name="dakuang2"  type="text" class="txt_1" value="<%=projectInfo.getAt("dakuang2")%>">
				 </td>
			</tr>
				<tr class="td_bg_pink">
				<td nowrap="nowrap" align="center" class="f_bold">前衣长</td>
				<td nowrap="nowrap" align="center" >
		<input  type="text"        name="qianyichangA" id="qianyichangA"   value="<%=projectInfo.getAt("qianyichang_a")%>"  >
	</td>
				<td nowrap="nowrap" align="center" >
				 <input  name="qianyichangA2"  type="text" class="txt_1" value="<%=projectInfo.getAt("qianyichang_a2")%>">
				</td>
			<!-- 	<td nowrap="nowrap" align="center" ></td> -->
				<td nowrap="nowrap" align="center" class="f_bold">腹围</td>
				<td nowrap="nowrap" align="center" >
				 <input  name="fuwei_quea"  type="text" class="txt_1" value="<%=request.getAttribute("fuwei_quea")%>">
				</td>
				<td nowrap="nowrap" align="center" >
				 <input  name="fuwei_quea"  type="text" class="txt_1" value="<%=request.getAttribute("fuwei_queb")%>">
				</td>
<!--				<td nowrap="nowrap" align="center" ></td>-->
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" class="f_bold">袖长</td>
				<td nowrap="nowrap" align="center" >
	<input  type="text"        name="xiuchangB" id="xiuchangB"   value="<%=projectInfo.getAt("xiuchang_b")%>"  >
</td>
				<td nowrap="nowrap" align="center" >
					<input  type="text"        name="xiuchangB" id="xiuchangB"   value="<%=projectInfo.getAt("xc_que")%>"  >
				</td>
				<!-- <td nowrap="nowrap" align="center" ></td> -->
				<td nowrap="nowrap" align="center" class="f_bold">袖长</td>
				<td nowrap="nowrap" align="center" >
				<input  type="text"        name="xiuchangA" id="xiuchangA"   value="<%=projectInfo.getAt("xiuchang_a")%>"  >
				</td>
				<td nowrap="nowrap" align="center" >
				 <input  name="xiuchangA2"  type="text" class="txt_1" value="<%=projectInfo.getAt("xiuchang_a2")%>" >
				</td>
<!--				<td nowrap="nowrap" align="center" ></td>-->
			</tr>
			<tr class="td_bg_pink" >
				<td nowrap="nowrap" align="center" class="f_bold">袖肥</td>
				<td nowrap="nowrap" align="center" >
	<input  type="text"        name="xiufeiB" id="xiufeiB"   value="<%=projectInfo.getAt("xiufei_b")%>"  >
</td>
				<td nowrap="nowrap" align="center" >
				 <input  name="xiufeiB2"  type="text" class="txt_1" value="<%=projectInfo.getAt("xiufei_b2")%>">
				</td>
				<!-- <td nowrap="nowrap" align="center" ></td> -->
				<td nowrap="nowrap" align="center" class="f_bold">袖肥</td>
				<td nowrap="nowrap" align="center" >
	<input  type="text"        name="xiufeiA" id="xiufeiA"   value="<%=projectInfo.getAt("xiufei_a")%>"  >
</td>
				<td nowrap="nowrap" align="center" >
			
				
				</td>
<!--				<td nowrap="nowrap" align="center" ></td>-->
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" class="f_bold">袖口</td>
				<td nowrap="nowrap" align="center" >
<input  type="text"        name="xiukouB" id="xiukouB"   value="<%=projectInfo.getAt("xiukou_b")%>"  >
</td>
				<td nowrap="nowrap" align="center" >
				 <input  name="xiukouB2"  type="text" class="txt_1" value="<%=projectInfo.getAt("xiukou_b2")%>">
				</td>
				<!-- <td nowrap="nowrap" align="center" ></td> -->
				<td nowrap="nowrap" align="center" class="f_bold">袖口</td>
				<td nowrap="nowrap" align="center" >
					<input  type="text"        name="xiukouA" id="xiukouA"   value="<%=projectInfo.getAt("xiukou_a")%>"  >
				</td>
				<td nowrap="nowrap" align="center" >
					<input  name="xiukouA2"  type="text" class="txt_1" value="<%=projectInfo.getAt("xiukou_a2")%>">
				</td>
<!--				<td nowrap="nowrap" align="center" ></td>-->
			</tr>
			<tr class="t_subtitle">
				<td nowrap="nowrap" align="center" class="f_bold">西裤数量</td>
				<td nowrap="nowrap" align="center" >
				<input  name="xiku_number"  id="xiku_number" type="number"
					class="txt_1"  value="<%=projectInfo.getAt("xiku_number")%>" />
				</td>
				<td nowrap="nowrap" align="center" class="f_bold">裤码</td>
				<td nowrap="nowrap" align="center" >
				<input  name="ku_ma"  type="text" class="txt_1"   value="<%=projectInfo.getAt("ku_ma")%>" >
				</td>
				<td nowrap="nowrap" align="center" class="f_bold">马甲数量</td>
				<td nowrap="nowrap" align="center" >
					<input  name="majia_number"  id="majia_number" type="number"
					class="txt_1"   value="<%=projectInfo.getAt("majia_number")%>" />
				</td>
				<td nowrap="nowrap" align="center" class="f_bold">马甲码</td>
				<td nowrap="nowrap" align="center" >
				<input  name="majia_ma"  type="text" class="txt_1"   value="<%=projectInfo.getAt("majia_ma")%>">
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" class="f_bold">腰围</td>
				<td nowrap="nowrap" align="center" >	<input  type="text"        name="yaoweiC" id="yaoweiC"   value="<%=projectInfo.getAt("yaowei_c")%>"  ></td>
				<td nowrap="nowrap" align="center" >
				<input  name="yaoweiC22"  type="text" class="txt_1" value="<%=projectInfo.getAt("yaowei_c22")%>">
			
				</td>
				<td nowrap="nowrap" align="center"  rowspan="4">
					<img src="<%=request.getAttribute("erweima_3")%>" width="100" height="100" />
				</td>
				<td nowrap="nowrap" align="center" class="f_bold">肩宽</td>
				<td nowrap="nowrap" align="center" >
					<input  name="jiankuannew"  type="text" class="txt_1" value="<%=projectInfo.getAt("jiankuannew")%>">
				</td>
				<td nowrap="nowrap" align="center" >
					<input  name="jiankuannew"  type="text" class="txt_1" value="<%=projectInfo.getAt("jiankuanque")%>">
				</td>
				<td nowrap="nowrap" align="center"  rowspan="4">
					<img src="<%=request.getAttribute("erweima_4")%>" width="100" height="100" />
				</td>
			</tr>
			<tr class="td_bg_pink">
				<td nowrap="nowrap" align="center" class="f_bold">臀围</td>
				<td nowrap="nowrap" align="center" >	<input  type="text"        name="tuiweiC" id="tuiweiC"   value="<%=projectInfo.getAt("tuiwei_c")%>"  ></td>
				<td nowrap="nowrap" align="center" >
				<input  name="tuiweiC2"  type="text" class="txt_1"  value="<%=projectInfo.getAt("tuiwei_c2")%>">
				
				</td>
				
				<td nowrap="nowrap" align="center" class="f_bold">胸围</td>
				<td nowrap="nowrap" align="center" >
<input  type="text"        name="xiongweiD" id="xiongweiD"   value="<%=projectInfo.getAt("xiongwei_d")%>"  >
</td>
				<td nowrap="nowrap" align="center" >
				<input  name="xiongweiD2"  type="text" class="txt_1" value="<%=projectInfo.getAt("xiongwei_d2")%>">
				</td>
<!--				<td nowrap="nowrap" align="center" ></td>-->
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" class="f_bold">档围</td>
				<td nowrap="nowrap" align="center" >
	<input  type="text"        name="dangweiC" id="dangweiC"   value="<%=projectInfo.getAt("dangwei_c")%>"  >
</td>
				<td nowrap="nowrap" align="center" >
				<input  name="dangweiC2"  type="text" class="txt_1"  value="<%=projectInfo.getAt("dangwei_c2")%>">
				</td>
				
				<td nowrap="nowrap" align="center" class="f_bold">中腰</td>
				<td nowrap="nowrap" align="center" >	<input  type="text"        name="zhongyaoD" id="zhongyaoD"   value="<%=projectInfo.getAt("zhongyao_d")%>"  ></td>
				<td nowrap="nowrap" align="center" >
				<input  name="zhongyaoD2"  type="text" class="txt_1" value="<%=projectInfo.getAt("yaowei_c2")%>">
				</td>
<!--				<td nowrap="nowrap" align="center" ></td>-->
			</tr>
			<tr class="td_bg_pink">
				<td nowrap="nowrap" align="center" class="f_bold">大腿</td>
				<td nowrap="nowrap" align="center" >	<input  type="text"        name="datuiC" id="datuiC"   value="<%=projectInfo.getAt("datui_c")%>"  ></td>
				<td nowrap="nowrap" align="center" >
				<input  name="datuiC2"  type="text" class="txt_1" value="<%=projectInfo.getAt("datui_c2")%>">
				</td>
				
				<td nowrap="nowrap" align="center" class="f_bold">衣长</td>
				<td nowrap="nowrap" align="center" >	<input  type="text"        name="yichangD" id="yichangD"   value="<%=projectInfo.getAt("yichang_d")%>"  ></td>
				<td nowrap="nowrap" align="center" >
				<input  name="yichangD2"  type="text" class="txt_1" value="<%=projectInfo.getAt("yichang_d2")%>">
				
				</td>
<!--				<td nowrap="nowrap" align="center" ></td>-->
			</tr>
			
			<tr>
				<td nowrap="nowrap" align="center" class="f_bold">中腿</td>
				<td nowrap="nowrap" align="center" >	<input  type="text"        name="zhongtuiC" id="zhongtuiC"   value="<%=projectInfo.getAt("zhongtui_c")%>"  ></td>
				<td nowrap="nowrap" align="center" >
				<input  name="zhongtuiC2"  type="text" class="txt_1" value="<%=projectInfo.getAt("zhongtui_c2")%>">
				</td>
				<td nowrap="nowrap" align="center"  rowspan="4">
						<input  name="dakuang3"  type="text" class="txt_1" value="<%=projectInfo.getAt("dakuang3")%>">
				</td>
				<td nowrap="nowrap" align="center" class="f_bold">款型</td>
				<td nowrap="nowrap" align="center" >
					<input  name="dakuang3"  type="text" class="txt_1" value="<%=projectInfo.getAt("kuanxing_d")%>">
			<!-- 	<select name="kuanxingD" value="kuanxingD">
						<option value="修身">修身</option>
						<option value="修身+">修身+</option>
						<option value="合身">合身</option>
						<option value="合身+">合身+</option>
						<option value="宽松">宽松</option>
						<option value="宽松+">宽松+</option>
				</select>  -->
				
<%-- 	<input  name="kuanxingD" type="radio" class="radio_1" value="修身" <%if("修身".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>修身
		<input  name="kuanxingD" type="radio" class="radio_1" value="修身+" <%if("修身+".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>修身+
		<input  name="kuanxingD" type="radio" class="radio_1" value="合身" <%if("合身".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>合身
		<input  name="kuanxingD" type="radio" class="radio_1" value="合身+" <%if("合身+".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>合身+
		<input  name="kuanxingD" type="radio" class="radio_1" value="宽松" <%if("宽松".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>宽松
		<input  name="kuanxingD" type="radio" class="radio_1" value="宽松+" <%if("宽松+".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>宽松+ --%>
</td>
				<td nowrap="nowrap" align="center" ></td>
				<td nowrap="nowrap" align="center"  rowspan="4">
					<input  type="text"        name="dakuang4" id="dakuang4"   value="<%=projectInfo.getAt("dakuang4")%>"  >
				</td>
			</tr>
			<tr class="td_bg_pink">
				<td nowrap="nowrap" align="center" class="f_bold">小腿</td>
				<td nowrap="nowrap" align="center" >
					<input  type="text"        name="xiaotuiC" id="xiaotuiC"   value="<%=projectInfo.getAt("xiaotui_c")%>"  >
				</td>
				<td nowrap="nowrap" align="center" >
				<input  name="xiaotuiC2"  type="text" class="txt_1" value="<%=projectInfo.getAt("xiaotui_c2")%>">
				</td>
				
				<td nowrap="nowrap" align="center" ></td>
				<td nowrap="nowrap" align="center" ></td>
				<td nowrap="nowrap" align="center" ></td>
<!--				<td nowrap="nowrap" align="center" ></td>-->
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" class="f_bold">裤长</td>
				<td nowrap="nowrap" align="center" >
				<input  type="text"        name="kuchangC" id="kuchangC"   value="<%=projectInfo.getAt("kuchang_c")%>"  >
				</td>
				<td nowrap="nowrap" align="center" >
				<input  name="kuchangC2"  type="text" class="txt_1" value="<%=projectInfo.getAt("kuchang_c2")%>">
				
				</td>
				
				<td nowrap="nowrap" align="center" ></td>
				<td nowrap="nowrap" align="center" ></td>
				<td nowrap="nowrap" align="center" ></td>
<!--				<td nowrap="nowrap" align="center" ></td>-->
			</tr>
			<tr class="td_bg_pink">
				<td nowrap="nowrap" align="center" class="f_bold">脚口</td>
				<td nowrap="nowrap" align="center" >
					<input  type="text"        name="tuikouC" id="tuikouC"   value="<%=projectInfo.getAt("tuikou_c")%>"  >
				</td>
				<td nowrap="nowrap" align="center" >
				<input  name="tuikouC2"  type="text" class="txt_1" value="<%=projectInfo.getAt("tuikou_c2")%>">
				</td>
				
				<td nowrap="nowrap" align="center" ></td>
				<td nowrap="nowrap" align="center" ></td>
				<td nowrap="nowrap" align="center" ></td>
<!--				<td nowrap="nowrap" align="center" ></td>-->
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">扣型</td>
				<td nowrap="nowrap" align="center" >
					
						<input  type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("kouxing_c")%>>
					<!--  <select name="kouxingC" value="kouxingC">
						<option value="一粒扣">一粒扣</option>
						<option value="二粒扣">二粒扣</option>
						<option value="三粒扣">三粒扣</option>
						<option value="双排二扣一">双排二扣一</option>
						<option value="双排四扣二">双排四扣二</option>
						<option value="双排六扣二">双排六扣二</option>
						<option value="其他">其他</option>
				</select>  -->
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">口袋</td>
				<td nowrap="nowrap" align="center" >
				<input  type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("koudai_c")%>>
				<!-- <select name="koudaiC" value="koudaiC">
						<option value="1平袋盖、4斜袋盖">1平袋盖、4斜袋盖</option>
						<option value="2平单线、5斜单线">2平单线、5斜单线</option>
						<option value="3平双线、6斜双线">3平双线、6斜双线</option>
						<option value="7外贴袋">7外贴袋</option>
						<option value="其他">其他</option>
				</select> <font color="red"></font></td> -->
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">开叉</td>
				<td nowrap="nowrap" align="center" >
				<input  type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("kaicha")%>>
				<!-- <select name="kaicha" value="kaicha">
						<option value="单叉">单叉</option>
						<option value="双叉">双叉</option>
						<option value="不开叉">不开叉</option>
				</select> -->
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">领型</td>
				<td nowrap="nowrap" align="center" >
					<input  type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("lingkoukuaishi_b")%>>
				<!-- <select name="lingkoukuaishiB" value="lingkoukuaishiB">
						<option value="平驳领">平驳领</option>
						<option value="戗驳领">戗驳领</option>
						<option value="青果领">青果领</option>
						<option value="假青果">假青果</option>
						<option value="假平驳">假平驳</option>
						<option value="宽平驳">宽平驳</option>
						<option value="宽戗驳">宽戗驳</option>
						<option value="其他">其他</option>
				</select>  -->
				
				<!-- <input  name="lingkoukuaishiB" 
					id="lingkoukuaishiB" type="text" class="txt_1"  /><font
					color="red"></font> -->
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">下摆</td>
				<td nowrap="nowrap" align="center" >
						<input  type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("xiabai")%>>
					<!-- <select name="xiabai" value="xiabai">
						<option value="直角下摆">直角下摆）</option>
						<option value="圆角下摆">圆角下摆</option>
						<option value="大圆角下摆">大圆角下摆</option>
						<option value="燕尾下摆">燕尾下摆</option>
						<option value="其他">其他</option>
				</select> -->
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">撞色</td>
				<td nowrap="nowrap" align="center" >
					<input  type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("zhuangse")%>>
			<!-- 	<select name="zhuangse" value="zhuangse">
						<option value="袋条用色丁">袋条用色丁</option>
						<option value="领边有色丁">领边有色丁</option>
						<option value="驳头用色丁">驳头用色丁</option>
						<option value="驳头用色丁">其他</option>
				</select> -->
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">外珠边</td>
				<td nowrap="nowrap" align="center" >
				<input  type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("waizhubian")%>>
				<!-- <select name="waizhubian" value="waizhubian">
						<option value="有">有</option>
						<option value="无">无</option>
				</select>  -->
				
			<%-- 	<input  name="waizhubian" 
					id="waizhubian" type="text" class="txt_1"   value="<%=projectInfo.getAt("waizhubian")%>" /><font
					color="red"></font> --%>
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">袖叉</td>
				<td nowrap="nowrap" align="center" >
					<input  type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("xiucha")%>>
				<!-- <select name="xiucha" value="xiucha">
						<option value="真袖叉">真袖叉</option>
						<option value="假袖叉">假袖叉</option>
						<option value="翻袖">翻袖</option>
						<option value="其它">其它</option>
				</select> -->
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">裤腰</td>
				<td nowrap="nowrap" align="center" >
				<input  type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("kuyao")%>>
				<!-- <select name="kuyao" value="kuyao">
						<option value="伸出订扣">伸出订扣</option>
						<option value="伸出订钩">伸出订钩</option>
						<option value="不伸头">不伸头</option>
						<option value="松紧">松紧</option>
						<option value="调节扣">调节扣</option>
						<option value="那不勒斯">那不勒斯</option>
						<option value="其它">其它</option>
				</select> -->
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">裤型</td>
				<td nowrap="nowrap" align="center" >
				<input  type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("kuxing")%>>
				<!-- <select name="kuxing" value="kuxing">
						<option value="修身裤">修身裤</option>
						<option value="翻边">翻边</option>
						<option value="单褶">单褶</option>
						<option value="双褶">双褶</option>
						<option value="萝卜裤">萝卜裤</option>
						<option value="直筒裤">直筒裤</option>
						<option value="其它">其它</option>
				</select> -->
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">衬衫领</td>
				<td nowrap="nowrap" align="center" >
					<input  type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("chenshanling")%>>
			<!-- 	<select name="chenshanling" value="chenshanling">
						<option value="小方领">小方领</option>
						<option value="小尖领">小尖领</option>
						<option value="v尖领">v尖领</option>
						<option value="正方领">正方领</option>
						<option value="大领">大领</option>
						<option value="其它">其它</option>
				</select> -->
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">衬衫袖</td>
				<td nowrap="nowrap" align="center" >
					<input  type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("chenshanxiu")%>>
					<!-- <select name="chenshanxiu" value="chenshanxiu">
						<option value="法式门襟＋袖">法式门襟＋袖</option>
						<option value="直角二扣">直角二扣</option>
						<option value="直角一扣">直角一扣</option>
						<option value="圆角二扣">圆角二扣</option>
						<option value="圆角一扣">圆角一扣</option>
						<option value="翻袖">翻袖</option>
						<option value="其它">其它</option>
				</select> -->
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
			<input  type="text"        name="miaoliao1" id="miaoliao1"   value="<%=projectInfo.getAt("miao_liao1")%>"  >
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
					 <input  type="text"     name="yongtu1" id="yongtu1"   value="<%=projectInfo.getAt("yong_tu1")%>"  >
					
					<!-- 	<select name="yongtu1" value="yongtu1">
						<option value="上衣">上衣</option>
						<option value="裤子">裤子</option>
						<option value="马甲">马甲</option>
						<option value="衬衫">衬衫</option>
						<option value="衬衫">衬衫</option>
						<option value="西装套装">西装套装</option>
						<option value="换片">换片</option>
						<option value="其他">其他</option>
				</select>  -->
				
				</td>
				<td nowrap="nowrap" class="padd0">
					<table class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">米数</td>
							<td nowrap="nowrap" align="center" style="border: 0;">
								<input  name="mi1"  type="text" class="txt_1" value="<%=projectInfo.getAt("mi1")%>" >
							</td>
						</tr>
					</table>
				</td>
				<td nowrap="nowrap" class="padd0">
					<table class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">价格</td>
							<td nowrap="nowrap" align="center" style="border: 0;">
								<input  type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=duoyu.getAt("jq")%>>
							</td>
						</tr>
					</table>
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
						<input  type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("gongyingshang_1")%>>
				</td>
			</tr>
			
				 <%if(!"".equals(duoyu.getAt("ml1"))&& duoyu.getAt("ml1")!=null ){ %>
          	<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml1" id="ml1"  value="<%=duoyu.getAt("ml1")%>"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yt1" id="yt1"  value="<%=duoyu.getAt("yt1")%>"
					
					type="text"  
					placeholder="" 
					 /></td>

				<td nowrap="nowrap" class="padd0">
					<table class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">米数</td>
							<td nowrap="nowrap" align="center" style="border: 0;">
								<input name="ms1" id="ms1"  value="<%=duoyu.getAt("ms1")%>"	type="text"/>
							</td>
						</tr>
					</table>
				</td>
				<td nowrap="nowrap" class="padd0">
					<table class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">价格</td>
							<td nowrap="nowrap" align="center" style="border: 0;">
								<input  type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=duoyu.getAt("jq1")%>>
							</td>
						</tr>
					</table>
				
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="gys1" id="gys1"  value="<%=duoyu.getAt("gys1")%>"
					type="text"  
					 /></td>
					 
			</tr>
			
				 <%} %>
			
			
			 <%if(!"".equals(duoyu.getAt("ml2"))&& duoyu.getAt("ml2")!=null ){ %>
          
				
				 
			<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml2" id="ml2"  value="<%=duoyu.getAt("ml2")%>"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yt2" id="yt2"  value="<%=duoyu.getAt("yt2")%>"
					
					type="text"  
					placeholder="" 
					 /></td>
				
				<td nowrap="nowrap" class="padd0">
					<table class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">米数</td>
							<td nowrap="nowrap" align="center" style="border: 0;">
								<input name="ms2" id="ms2"  value="<%=duoyu.getAt("ms2")%>"	type="text"/>
							</td>
						</tr>
					</table>
				</td>
				<td nowrap="nowrap" class="padd0">
					<table class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">价格</td>
							<td nowrap="nowrap" align="center" style="border: 0;">
								<input  type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=duoyu.getAt("jq2")%>>
							</td>
						</tr>
					</table>
				
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="gys2" id="gys2"  value="<%=duoyu.getAt("gys2")%>"
					type="text"  
					 /></td>
			</tr>
			 <%} %>
			
			
			 <%if(!"".equals(duoyu.getAt("ml3"))&& duoyu.getAt("ml3")!=null ){ %>
          
			
				 
			<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml3" id="ml3"  value="<%=duoyu.getAt("ml3")%>"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yt3" id="yt3"  value="<%=duoyu.getAt("yt3")%>"
					
					type="text"  
					placeholder="" 
					 /></td>

				<td nowrap="nowrap" class="padd0">
					<table class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">米数</td>
							<td nowrap="nowrap" align="center" style="border: 0;">
								<input name="ms3" id="ms3"  value="<%=duoyu.getAt("ms3")%>" type="text"/>
							</td>
						</tr>
					</table>
				</td>
				<td nowrap="nowrap" class="padd0">
					<table class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">价格</td>
							<td nowrap="nowrap" align="center" style="border: 0;">
								<input  type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=duoyu.getAt("jq3")%>>
							</td>
						</tr>
					</table>
				
				</td>
				
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="gys3" id="gys3"  value="<%=duoyu.getAt("gys3")%>"
					type="text"  
					 /></td>
					  
			</tr>
				 <%} %>
			
			 <%if(!"".equals(duoyu.getAt("ml4"))&& duoyu.getAt("ml4")!=null ){ %>
          
			
				<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml4" id="ml4"  value="<%=duoyu.getAt("ml4")%>"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yt4" id="yt4"  value="<%=duoyu.getAt("yt4")%>"
					
					type="text"  
					placeholder="" 
					   /></td>
				
				<td nowrap="nowrap" class="padd0">
					<table class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">米数</td>
							<td nowrap="nowrap" align="center" style="border: 0;">
								<input name="ms4" id="ms4"  value="<%=duoyu.getAt("ms4")%>" type="text" />
							</td>
						</tr>
					</table>
				</td>
				<td nowrap="nowrap" class="padd0">
					<table class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">价格</td>
							<td nowrap="nowrap" align="center" style="border: 0;">
								<input  type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=duoyu.getAt("jq4")%>>
							</td>
						</tr>
					</table>
				
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="gys4" id="gys4"  value="<%=duoyu.getAt("gys4")%>"
					type="text"  
					 /></td>
					  
			</tr>
				 <%} %>
			
				
				 <%if(!"".equals(duoyu.getAt("ml5"))&& duoyu.getAt("ml5")!=null ){ %>
          
				
				<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml5" id="ml5"  value="<%=duoyu.getAt("ml5")%>"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yt5" id="yt5"  value="<%=duoyu.getAt("yt5")%>"
					
					type="text"  
					placeholder="" 
					 /></td>
					
				<td nowrap="nowrap" class="padd0">
					<table class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">米数</td>
							<td nowrap="nowrap" align="center" style="border: 0;">
								<input name="ms5" id="ms5"  value="<%=duoyu.getAt("ms5")%>" type="text"/>
							</td>
						</tr>
					</table>
				</td>
				<td nowrap="nowrap" class="padd0">
					<table class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">价格</td>
							<td nowrap="nowrap" align="center" style="border: 0;">
								<input  type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=duoyu.getAt("jq5")%>>
							</td>
						</tr>
					</table>
				
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="gys5" id="gys5"  value="<%=duoyu.getAt("gys5")%>"
					type="text"  
					 /></td>
					  
			</tr>
			 <%} %>
			
			
			 <%if(!"".equals(duoyu.getAt("ml6"))&& duoyu.getAt("ml6")!=null ){ %>
          
				
				 
					<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml6" id="ml6"  value="<%=duoyu.getAt("ml6")%>"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yt6" id="yt6"  value="<%=duoyu.getAt("yt6")%>"
					
					type="text"  
					placeholder="" 
					 /></td>

			
				<td nowrap="nowrap" class="padd0">
					<table class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">米数</td>
							<td nowrap="nowrap" align="center" style="border: 0;">
								<input name="ms6" id="ms6"  value="<%=duoyu.getAt("ms6")%>" type="text"/>
							</td>
						</tr>
					</table>
				</td>
				<td nowrap="nowrap" class="padd0">
					<table class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">价格</td>
							<td nowrap="nowrap" align="center" style="border: 0;">
								<input  type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=duoyu.getAt("jq6")%>>
							</td>
						</tr>
					</table>
				
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="gys6" id="gys6"  value="<%=duoyu.getAt("gys6")%>"
					type="text"  
					 /></td>
					  
			</tr>
			 <%} %>
			
			 <%if(!"".equals(duoyu.getAt("ml7"))&& duoyu.getAt("ml1")!=null ){ %>
          
				 
					<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml7" id="ml7"  value="<%=duoyu.getAt("ml7")%>"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yt7" id="yt7"  value="<%=duoyu.getAt("yt7")%>"
					
					type="text"  
					placeholder="" 
					 /></td>

				
				<td nowrap="nowrap" class="padd0">
					<table class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">米数</td>
							<td nowrap="nowrap" align="center" style="border: 0;">
								<input name="ms7" id="ms7"  value="<%=duoyu.getAt("ms7")%>" type="text" />
							</td>
						</tr>
					</table>
				</td>
				<td nowrap="nowrap" class="padd0">
					<table class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">价格</td>
							<td nowrap="nowrap" align="center" style="border: 0;">
								<input  type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=duoyu.getAt("jq7")%>>
							</td>
						</tr>
					</table>
				
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="gys7" id="gys7"  value="<%=duoyu.getAt("gys7")%>"
					type="text"  
					 /></td>
					  
			</tr>
			 <%} %>
			
			
			 <%if(!"".equals(duoyu.getAt("ml8"))&& duoyu.getAt("ml8")!=null ){ %>
          
				
				 
				<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml8" id="ml8"  value="<%=duoyu.getAt("ml8")%>"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yt8" id="yt8"  value="<%=duoyu.getAt("yt8")%>"
					
					type="text"  
					placeholder="" 
					 /></td>

				
				<td nowrap="nowrap" class="padd0">
					<table class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">米数</td>
							<td nowrap="nowrap" align="center" style="border: 0;">
								<input name="ms8" id="ms8"  value="<%=duoyu.getAt("ms8")%>" type="text" />
							</td>
						</tr>
					</table>
				</td>
				<td nowrap="nowrap" class="padd0">
					<table class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">价格</td>
							<td nowrap="nowrap" align="center" style="border: 0;">
								<input  type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=duoyu.getAt("jq8")%>>
							</td>
						</tr>
					</table>
				
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="gys8" id="gys8"  value="<%=duoyu.getAt("gys8")%>"
					type="text"  
					 /></td>
					 
			</tr>
			 <%} %>
			 
			  <%if(!"".equals(duoyu.getAt("ml9"))&& duoyu.getAt("ml9")!=null ){ %>
          
				
				 
				<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml9" id="ml9"  value="<%=duoyu.getAt("ml9")%>"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yt9" id="yt9"  value="<%=duoyu.getAt("yt9")%>"
					
					type="text"  
					placeholder="" 
					 /></td>

				
				<td nowrap="nowrap" class="padd0">
					<table class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">米数</td>
							<td nowrap="nowrap" align="center" style="border: 0;">
								<input name="ms9" id="ms9"  value="<%=duoyu.getAt("ms9")%>" type="text"/>
							</td>
						</tr>
					</table>
				</td>
				<td nowrap="nowrap" class="padd0">
					<table class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">价格</td>
							<td nowrap="nowrap" align="center" style="border: 0;">
								<input  type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=duoyu.getAt("jq9")%>>
							</td>
						</tr>
					</table>
				
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="gys9" id="gys9"  value="<%=duoyu.getAt("gys9")%>"
					type="text"  
					 /></td>
					  
			</tr>
			 <%} %>
			
				 <%if(!"".equals(duoyu.getAt("ml10"))&& duoyu.getAt("ml10")!=null ){ %>
				
					<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml10" id="ml10"  value="<%=duoyu.getAt("ml10")%>"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yt10" id="yt10"  value="<%=duoyu.getAt("yt10")%>"
					
					type="text"  
					placeholder="" 
					 /></td>

				
				<td nowrap="nowrap" class="padd0">
					<table class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">米数</td>
							<td nowrap="nowrap" align="center" style="border: 0;">
								<input name="ms10" id="ms10"  value="<%=duoyu.getAt("ms10")%>" type="text" />
							</td>
						</tr>
					</table>
				</td>
				<td nowrap="nowrap" class="padd0">
					<table class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">价格</td>
							<td nowrap="nowrap" align="center" style="border: 0;">
								<input  type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=duoyu.getAt("jq10")%>>
							</td>
						</tr>
					</table>
				
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="gys10" id="gys10"  value="<%=duoyu.getAt("gys10")%>"
					type="text"  
					 /></td>
					 
					  
			</tr> <%} %>
			
			
			 <%if(!"".equals(duoyu.getAt("ml11"))&& duoyu.getAt("ml11")!=null ){ %>
          
				 
					<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml11" id="ml11"  value="<%=duoyu.getAt("ml11")%>"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yt11" id="yt11"  value="<%=duoyu.getAt("yt11")%>"
					
					type="text"  
					placeholder="" 
					 /></td>

				
				<td nowrap="nowrap" class="padd0">
					<table class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">米数</td>
							<td nowrap="nowrap" align="center" style="border: 0;">
								<input name="ms11" id="ms11"  value="<%=duoyu.getAt("ms11")%>" type="text" />
							</td>
						</tr>
					</table>
				</td>
				<td nowrap="nowrap" class="padd0">
					<table class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">价格</td>
							<td nowrap="nowrap" align="center" style="border: 0;">
								<input  type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=duoyu.getAt("jq11")%>>
							</td>
						</tr>
					</table>
				
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="gys11" id="gys11"  value="<%=duoyu.getAt("gys11")%>"
					type="text"  
					 /></td>
					 
			</tr>
			 <%} %>
			 
			  <%if(!"".equals(duoyu.getAt("ml12"))&& duoyu.getAt("ml12")!=null ){ %>
          
				
				<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml12" id="ml12"  value="<%=duoyu.getAt("ml12")%>"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yt12" id="yt12"  value="<%=duoyu.getAt("yt12")%>"
					
					type="text"  
					placeholder="" 
					 /></td>

				
				<td nowrap="nowrap" class="padd0">
					<table class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">米数</td>
							<td nowrap="nowrap" align="center" style="border: 0;">
								<input name="ms12" id="ms12"  value="<%=duoyu.getAt("ms12")%>" type="text" />
							</td>
						</tr>
					</table>
				</td>
				<td nowrap="nowrap" class="padd0">
					<table class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">价格</td>
							<td nowrap="nowrap" align="center" style="border: 0;">
								<input  type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=duoyu.getAt("jq12")%>>
							</td>
						</tr>
					</table>
				
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="gys12" id="gys12"  value="<%=duoyu.getAt("gys12")%>"
					type="text"  
					 /></td>
					  
			</tr>
			 <%} %>
			 
			  <%if(!"".equals(duoyu.getAt("ml13"))&& duoyu.getAt("ml13")!=null ){ %>
          
				
				<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml13" id="ml13"  value="<%=duoyu.getAt("ml13")%>"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yt13" id="yt13"  value="<%=duoyu.getAt("yt13")%>"
					
					type="text"  
					placeholder="" 
					 /></td>

				
				<td nowrap="nowrap" class="padd0">
					<table class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">米数</td>
							<td nowrap="nowrap" align="center" style="border: 0;">
								<input name="ms13" id="ms13"  value="<%=duoyu.getAt("ms13")%>" type="text" />
							</td>
						</tr>
					</table>
				</td>
				<td nowrap="nowrap" class="padd0">
					<table class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">价格</td>
							<td nowrap="nowrap" align="center" style="border: 0;">
								<input  type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=duoyu.getAt("jq13")%>>
							</td>
						</tr>
					</table>
				
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="gys13" id="gys13"  value="<%=duoyu.getAt("gys13")%>"
					type="text"  
					 /></td>
					  
			</tr>
			 <%} %>
			  <%if(!"".equals(duoyu.getAt("ml14"))&& duoyu.getAt("ml14")!=null ){ %>
			<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml14" id="ml14"  value="<%=duoyu.getAt("ml14")%>"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yt14" id="yt14"  value="<%=duoyu.getAt("yt14")%>"
					
					type="text"  
					placeholder="" 
					 /></td>

				
				<td nowrap="nowrap" class="padd0">
					<table class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">米数</td>
							<td nowrap="nowrap" align="center" style="border: 0;">
								<input name="ms14" id="ms14"  value="<%=duoyu.getAt("ms14")%>" type="text" />
							</td>
						</tr>
					</table>
				</td>
				<td nowrap="nowrap" class="padd0">
					<table class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">价格</td>
							<td nowrap="nowrap" align="center" style="border: 0;">
								<input  type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=duoyu.getAt("jq14")%>>
							</td>
						</tr>
					</table>
				
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="gys14" id="gys14"  value="<%=duoyu.getAt("gys14")%>"
					type="text"  
					 /></td>
					  
			</tr> <%} %>
			
		<%-- 	<tr>
				<td nowrap="nowrap" align="center" >面料</td>
				<td nowrap="nowrap" align="center" >
				<input  type="text"     name="miaoliao2" id="miaoliao2"   value="<%=projectInfo.getAt("miao_liao2")%>"  >
				</td>
				<td nowrap="nowrap" align="center" >用途</td>
				<td nowrap="nowrap" align="center" >
				<input  type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("yong_tu2")%>>
					<!-- <select name="yongtu2" value="yongtu2">
						<option value="上衣">上衣</option>
						<option value="裤子">裤子</option>
						<option value="马甲">马甲</option>
						<option value="衬衫">衬衫</option>
						<option value="衬衫">衬衫</option>
						<option value="西装套装">西装套装</option>
						<option value="换片">换片</option>
						<option value="其他">其他</option>
				</select>  -->
					<input  type="text"     name="yongtu2" id="yongtu2"   value="<%=projectInfo.getAt("yong_tu2")%>"  >
				</td>
				<td nowrap="nowrap" align="center" >米数</td>
				<td nowrap="nowrap" align="center" >
				<input  name="mi2"  type="text" class="txt_1" value="<%=projectInfo.getAt("mi2")%>" >
				</td>
				<td nowrap="nowrap" align="center" >供应商</td>
				<td nowrap="nowrap" align="center" >
				<input  type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("gongyingshang_2")%>>
					<%=request.getAttribute("companyList1")%>
				</td>
			</tr> --%>
			<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">附件</td>
				<td nowrap="nowrap" align="center" >
				    <%if(!"无".equals(request.getAttribute("fujian"))){ %>
                <a href="<%=request.getAttribute("fujian")%>" title="zip" style="color:#0000FF">【下载】</a>
                 
				 <%}else{ %>
				 
				 	 <%} %>
				 	 
				   
				 	 
				 	 <td nowrap="nowrap" align="center" >生成文件(二维码,打标文件,订单详情)</td>
				<td nowrap="nowrap" align="center" >
				  <%if(!"无".equals(request.getAttribute("erweima_zip"))){ %>
                <a href="<%=request.getAttribute("erweima_zip")%>" title="zip" style="color:#0000FF">【下载】</a>
                 
				 <%}else{ %>
				 
				 	 <%} %>
				
				 </td>
					 <td nowrap="nowrap" align="center" ></td>
				<td nowrap="nowrap" align="center" ></td>
				<td nowrap="nowrap" align="center" ></td>
				<td nowrap="nowrap" align="center" ></td>
				<!-- <input  type="file" name="channelId"  multiple="multiple"
					id="channelId" multiple="multiple" class="imagePath" /> <img alt=""
					src="" id="image1" class="showImage"></td> -->
			</tr>
			
			<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">客服备注</td>
				<td nowrap="nowrap" align="left"  colspan="7">
	<input  type="text"     name="remark" id="remark"   value="<%=projectInfo.getAt("remark")%>"  >
</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">批单备注</td>
				<td nowrap="nowrap" align="left"  colspan="7">
				<input  type="text"    name="pidanremark" id="pidanremark"   value="<%=projectInfo.getAt("pidan_remark")%>" >
					
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">跟单备注</td>
				<td nowrap="nowrap" align="left"  colspan="7">
					<input  type="text"      name="gdremark" id="gdremark"   value="<%=projectInfo.getAt("gd_remark")%>"  > 
				</td>
			</tr>
			
			
			   
			  
			
  


			
<%-- 
			<tr>
				<td>面料1</td>
				<td>
				<input  type="text"    readOnly="true"     size="20"  name="miaoliao1" id="miaoliao1"   value="<%=projectInfo.getAt("miao_liao1")%>"  >
				</td>
				<td>米数</td>
				<td>
					<input  type="text"    readOnly="true"  size="20"  name="miaoliao2" id="miaoliao2"   value="<%=projectInfo.getAt("mi1")%>"  >
				</td>
				<td>用途</td>
				<td>
					<input  type="text"    readOnly="true"  size="20"  name="yongtu1" id="yongtu1"   value="<%=projectInfo.getAt("yong_tu1")%>"  >
					</td>
				<td>供应商</td>
				<td>
					<input  type="text"    readOnly="true"  size="20"  name="yongtu2" id="yongtu2"   value="<%=projectInfo.getAt("gongyingshang_1")%>"  >
				<%=request.getAttribute("companyList")%><font color="red">*</font>
				</td>
			</tr>

			<tr>
				<td>面料2</td>
				<td>
						<input  type="text"    readOnly="true"  size="20"  name="miaoliao2" id="miaoliao2"   value="<%=projectInfo.getAt("miao_liao2")%>"  >
				</td>
				<td>米数</td>
				<td>
						<input  type="text"    readOnly="true"  size="20"  name="miaoliao2" id="miaoliao2"   value="<%=projectInfo.getAt("mi2")%>"  >
				</td>
				<td>用途</td>
				<td>
						<input  type="text"    readOnly="true"  size="20"  name="yongtu2" id="yongtu2"   value="<%=projectInfo.getAt("yong_tu2")%>"  >
					</td>
				<td>供应商</td>
				<td>
					<input  type="text"    readOnly="true"  size="20"  name="yongtu2" id="yongtu2"   value="<%=projectInfo.getAt("gongyingshang_2")%>"  >
				<%=request.getAttribute("companyList1")%> <font color="red">*</font>
				</td>
			</tr>

			<tr>
				<td>体型备注</td>
				<td colspan="3">
					<input  type="text"    readOnly="true"  size="20"  name="tixingremark" id="tixingremark"   value="<%=projectInfo.getAt("tixing_remark")%>"  >
					</td>
				<td>备注</td>
				<td colspan="3">
					<input  type="text"    readOnly="true"  size="20"  name="remark" id="remark"   value="<%=projectInfo.getAt("remark")%>"  >
				</td>
			</tr>
			
			
				<tr>
				<td>批单备注</td>
				<td colspan="7">
						<input  type="text"    readOnly="true"  size="20"  name="remark" id="remark"   value="<%=projectInfo.getAt("pidan_remark")%>"  >
					
					</td>
			</tr>
			<tr>
			
				<tr>
				<td>跟单备注</td>
				<td colspan="7">
						<input  type="text"     readOnly="true"  size="100"  name="gdremark" id="gdremark"   value="<%=projectInfo.getAt("gd_remark")%>"  > 
						
					</td>
			</tr> --%>
			
			
			
				
			<tr>
				
					
						<td align="left" colspan="2">
						
	
      <input  type="button" name="back" accesskey="b" tabindex="b" value="返 回" class="but_1 btn" onclick="location='doProjectInfo.do?method=queryProjectInfoXml'">

				</td>
			</tr>
</table>
</form>
</body>
</html>
<%@ page language="java" contentType="text/html;charset=gb2312"%>
<%@ page import = "com.godoing.rose.http.common.*" %>
<%@ page import = "com.godoing.rose.lang.*" %>
<%@ page import="com.care.common.lang.*"%>
<%@ page import="com.care.common.config.Config"%>
<%@ page import="com.care.app.LoginUser"%>
<%@ taglib uri="/WEB-INF/struts-bean" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic" prefix="logic"%>

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
<!-- <style>
select
{outline: none;border: none;
appearance: none;
-moz-appearance: none;
-webkit-appearance: none;
}
</style> -->
<style>
	.add_order_table tr th, .add_order_table tr td{border-bottom: 1px solid #bbb; border-left:1px solid #bbb; padding:10px;}
	.add_order_table tr td:first-child{border-left: 0;}
	.add_order_table tr:last-child td{border-bottom:0;}
	.add_order_table input, .add_order_table select{width: 100%; padding:5px; border:1px solid #ccc;} 
	.table_title{font-size:22px;}
	.t_subtitle th, .t_subtitle td{background:#F8CBAD;}
	.f_bold{font-weight: bold;}
	.td_bg_pink{background:#FCE4D6;}
	.td_bg_yellow{background:#FFF2CC;}
	.add_order_table .btn{padding:6px 20px; width: auto; height: auto; font-size:14px; background:#337ab7; border-radius: 6px; color: #fff; border:1px solid #286090;}
	
</style>
<script language="javascript">
//添加行  id="huanjiename'+n+'"
function addTable(cc) {
	var tab = document.getElementById("tab01"); //获得表格
	//var colsNum = tab.rows.item(0).cells.length; //表格的列数
	//表格当前的行数 
	var num = document.getElementById("tab01").rows.length;

	var rownum = num-5;
	
	tab.insertRow(rownum);

	var n=rownum-28;
	
 
	if(n<15){
	for (var i = 0; i < 9; i++) {
		tab.rows[rownum].insertCell(i);//插入列
		tab.rows[rownum].cells[i].setAttribute("align","center");
		if (i == 0) {
			tab.rows[rownum].cells[i].innerHTML = '面料';
		} else if (i == 1) {
			tab.rows[rownum].cells[i].innerHTML = '<input name="ml'+n+'" type="text"    />';
		} else if (i == 2) {
			tab.rows[rownum].cells[i].innerHTML = '用途';
		} else if( i == 3){
			tab.rows[rownum].cells[i].innerHTML = '<select name="yt'+n+'"  value="" style="width:100%"  > <option value=""></option> <option value="上衣">上衣</option> <option value="裤子">裤子</option>  <option value="马甲">马甲</option> <option value="衬衫">衬衫</option> <option value="西装套装">西装套装</option><option value="换片">换片</option><option value="其他">其他</option></select>';
			 
				/* '<input name="yt'+n+'" type="text"  />'; */
				
				
			/* <option value="上衣">上衣</option>
			<option value="裤子">裤子</option>
			<option value="马甲">马甲</option>
			<option value="衬衫">衬衫</option>
			<option value="西装套装">西装套装</option>
			<option value="换片">换片</option>
			<option value="其他">其他</option> */
				/* '<input name="yt'+n+'" type="text"  />'; */
		}else if(i == 4 ){
			tab.rows[rownum].cells[i].innerHTML = '米数';
		}else if(i == 5){
			tab.rows[rownum].cells[i].innerHTML = '<input name="ms'+n+'" type="text"   readonly="true" />';
		}else if(i == 6){
			tab.rows[rownum].cells[i].innerHTML = '供应商';
		}else  if(i==7){
			/* tab.rows[rownum].cells[i].innerHTML = '<input name="gys' + n + '" type="text"  maxlength="100" readonly="true" />';*/
			 tab.rows[rownum].cells[i].innerHTML = '<select name="gys' + n + '"  value="" style="width:100%"  >'+cc+'</select>';

		}else if(i==8){
			tab.rows[rownum].cells[i].innerHTML = '<input name="jg' + n + '" type="text"  maxlength="100"   />';
		/* 	tab.rows[rownum].cells[i].innerHTML = '价格'; */
		}else{
		}
	}
	tab.rows[rownum].insertCell(i);
	 tab.rows[rownum].cells[i].innerHTML = '<a href="#" onclick="delRow(this)">-</a>'; 
	}else{
		alert("最多新增15行");
		
	}
}
//删除行
function delRow(obj) {
	var Row = obj.parentNode;
	var Row = obj.parentNode; //tr
	while (Row.tagName.toLowerCase() != "tr") {
		Row = Row.parentNode;
	}
	Row.parentNode.removeChild(Row); //删除行
}

function onc(){
	var files = document.getElementById("inputfile").files;
	for(var i=0; i< files.length; i++){
	alert(input.files[i].name);
	}  
	}
	
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
	   }else{
		   if(frmGo.gdremark.value.trim() == ''){
				alert("跟单备注不能为空");
				frmGo.ProjectName.focus();
				return false;
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
<table width="100%" id="tab01" class="tbl_11 add_order_table" border="0" cellspacing="0" cellpadding="0">
			
			  <%--  <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role"))){ %>
			    <%} %>	 --%>
			   
			   <tr>
				<th colspan="8" nowrap="nowrap" align="left"><%=request.getAttribute("role")%>修改订单信息</th>
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
				<input style="border:none;" type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("order_id")%>>
				</td>
				<td nowrap="nowrap" align="center" class="f_bold">渠道</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
				<select name="qudao" value="qudao">
					<option value="" <%=projectInfo.getAt("qudao").equals("")? "selected":"" %>></option>
						<option value="淘宝" <%=projectInfo.getAt("qudao").equals("淘宝")? "selected":"" %>>淘宝</option>
						<option value="工单" <%=projectInfo.getAt("qudao").equals("工单")? "selected":"" %>>工单</option>
						<option value="分销" <%=projectInfo.getAt("qudao").equals("分销")? "selected":"" %>>分销</option>
						<option value="打样" <%=projectInfo.getAt("qudao").equals("打样")? "selected":"" %>>打样</option>
						<option value="重做" <%=projectInfo.getAt("qudao").equals("重做")? "selected":"" %>>重做</option>
						<option value="其他" <%=projectInfo.getAt("qudao").equals("其他")? "selected":"" %>>其他</option>
						<option value="线下转款_曹" <%=projectInfo.getAt("qudao").equals("线下转款_曹")? "selected":"" %>>线下转款_曹</option>
						<option value="线下转款_周" <%=projectInfo.getAt("qudao").equals("线下转款_周")? "selected":"" %>>线下转款_周</option>
						<option value="线下转款_公账" <%=projectInfo.getAt("qudao").equals("线下转款_公账")? "selected":"" %>>线下转款_公账</option>
				</select> 
				<%}else{ %>
					<input style="border:none;" type="text"   readOnly="true"    name="project_no12" id="project_no12" value=<%=projectInfo.getAt("qudao")%>>
				 <%} %>
				
				<%-- 	<input style="border:none;" name="qudao" type="radio" class="radio_1" value="淘宝" <%if("淘宝".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>淘宝
						<input style="border:none;" name="qudao" type="radio" class="radio_1" value="工单" <%if("工单".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>工单
						<input style="border:none;" name="qudao" type="radio" class="radio_1" value="分销" <%if("分销".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>分销
						<input style="border:none;" name="qudao" type="radio" class="radio_1" value="线下" <%if("线下".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>线下
						<input style="border:none;" name="qudao" type="radio" class="radio_1" value="打样" <%if("打样".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>打样
						<input style="border:none;" name="qudao" type="radio" class="radio_1" value="重做" <%if("重做".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>重做
						<input style="border:none;" name="qudao" type="radio" class="radio_1" value="其他" <%if("其他".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>其他 --%>
						</td>
				<td nowrap="nowrap" align="center" class="f_bold">年龄</td>
				<td  nowrap="nowrap" align="center" >
					 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
				<input style="border:none;" type="text"        name="age" id="age"   value="<%=projectInfo.getAt("age")%>"  >
				 <%}else{ %>
				 	<input style="border:none;" type="text"   readOnly="true"      name="age" id="age"   value="<%=projectInfo.getAt("age")%>"  >
          <%} %>
					</td>
				<td nowrap="nowrap" align="center" class="f_bold">客户电话</td>	
				<td  nowrap="nowrap" align="center" >
					 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
				<input style="border:none;" type="text"      name="kehuPhone" id="kehuPhone"   value="<%=projectInfo.getAt("kehu_phone")%>"  >
 <%}else{ %>
 <input style="border:none;" type="text"    readonly="true"   name="kehuPhone" id="kehuPhone"   value="<%=projectInfo.getAt("kehu_phone")%>"  >
 
 <%} %>
					</td>
			</tr>
			
				<tr>
				<td nowrap="nowrap" align="center" class="f_bold">微信号</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
				<input style="border:none; width:auto;" type="text"     name="wechat" id="wechat"  value=<%=projectInfo.getAt("wechat")%>>
				 <input style="border:none; width:auto;" type="text"   readonly="true"    name="project_no2" id="project_no2" value=<%=projectInfo.getAt("order_id")%>>
				 <%}else{ %>
				<input style="border:none;" type="text"  readonly="true"   name="wechat" id="wechat"  value=<%=projectInfo.getAt("wechat")%>>
 <%} %>
				</td>
				<td nowrap="nowrap" align="center" class="f_bold">下单客服</td>
				<td><input style="border:none;" type="text"  readonly="true"    name="project_no" id="project_no"   value="<%=projectInfo.getAt("xiadan_kefu")%>"  ></td>
				<td nowrap="nowrap" align="center" class="f_bold">性别</td>
				<td  nowrap="nowrap" align="center" >
				
					 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
				
				<select name="sex" value="sex">
					<option value="" <%=projectInfo.getAt("sex").equals("")? "selected":"" %>></option>
						<option value="男" <%=projectInfo.getAt("sex").equals("男")? "selected":"" %>>男</option>
						<option value="女" <%=projectInfo.getAt("sex").equals("女")? "selected":"" %>>女</option>
				</select> 
				 <%}else{ %>
				 	<input style="border:none;" type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("sex")%>>
 <%} %>
				
				<%-- 	<input style="border:none;" name="sex" type="radio" class="radio_1" value="男" <%if("男".equals("" + projectInfo.getAt("sex"))){%>checked<%}%>>男
	    <input style="border:none;" name="sex" type="radio" class="radio_1" value="女" <%if("女".equals("" + projectInfo.getAt("sex"))){%>checked<%}%>>女 --%>
					</td>
				<td nowrap="nowrap" align="center" class="f_bold">客户姓名</td>	
				<td  nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
				<input style="border:none;" type="text"      name="kehuName" id="kehuName"   value="<%=projectInfo.getAt("kehu_name")%>"  >
				 <%}else{ %>
				 	<input style="border:none;" type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("kehu_name")%>>
 <%} %>
					</td>
			</tr>
			
			<tr>
				<td nowrap="nowrap" align="center" class="f_bold">订单号</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
				
				<input style="border:none;" type="text"     name="orderNumber" id="orderNumber"  value=<%=projectInfo.getAt("order_number")%>>
				 <%}else{ %>
				<input style="border:none;" type="text"  readonly="true"   name="orderNumber" id="orderNumber"  value=<%=projectInfo.getAt("order_number")%>>
 <%} %>
				</td>
				<td nowrap="nowrap" align="center" class="f_bold">销售价格</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
				
	<input style="border:none;" type="text"     name="salePrice" id="salePrice"  value=<%=projectInfo.getAt("sale_price")%>>
	 <%}else{ %>
	<input style="border:none;" type="text" readonly="true"    name="salePrice" id="salePrice"  value=<%=projectInfo.getAt("sale_price")%>>
 <%} %>
</td>
				<td nowrap="nowrap" align="center" class="f_bold">身高</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
				<input style="border:none;" type="text"        name="height" id="height"   value="<%=projectInfo.getAt("height")%>"  >
 <%}else{ %>
				<input style="border:none;" type="text"    readonly="true"    name="height" id="height"   value="<%=projectInfo.getAt("height")%>"  >
 <%} %>
				</td>
				<td nowrap="nowrap" align="center" class="f_bold">体重</td>
				<td nowrap="nowrap" align="center" >
						 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
<input style="border:none;" type="text"        name="weight" id="weight"   value="<%=projectInfo.getAt("weight")%>"  >
 <%}else{ %>
<input style="border:none;" type="text"     readonly="true"    name="weight" id="weight"   value="<%=projectInfo.getAt("weight")%>"  >
  <%} %>
 
</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" class="f_bold">旺旺名</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
<input style="border:none;" type="text"     name="projectNo" id="projectNo"  value=<%=projectInfo.getAt("ww_name")%>>
 <%}else{ %>
<input style="border:none;" type="text"     readonly="true"  name="projectNo" id="projectNo"  value=<%=projectInfo.getAt("ww_name")%>>
  <%} %>
</td>
				<td nowrap="nowrap" align="center" class="f_bold">下单时间</td>
				<td nowrap="nowrap" align="center" >
				<input style="border:none;" type="text"    readOnly="true"   name="project_no" id="project_no"   value="<%=projectInfo.getAt("add_time")%>"  >
				</td>
				<td nowrap="nowrap" align="center"  rowspan="2">客户地址</td>
				<td nowrap="nowrap" align="center"  colspan="3" rowspan="2">
					 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
				<input style="border:none;" type="text"        name="address" id="address"   value="<%=projectInfo.getAt("address")%>"  >
				 <%}else{ %>
				<input style="border:none;" type="text"    readonly="true"    name="address" id="address"   value="<%=projectInfo.getAt("address")%>"  >
  <%} %>
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" class="f_bold">订单类型</td>
				<td nowrap="nowrap" align="center" >
			<%-- 		<input style="border:none;" name="orderType" type="radio" class="radio_1" value="新单" <%if("新单".equals("" + projectInfo.getAt("order_type"))){%>checked<%}%>>新单
	    <input style="border:none;" name="orderType" type="radio" class="radio_1" value="打样" <%if("打样".equals("" + projectInfo.getAt("order_type"))){%>checked<%}%>>打样
	    <input style="border:none;" name="orderType" type="radio" class="radio_1" value="重做" <%if("重做".equals("" + projectInfo.getAt("order_type"))){%>checked<%}%>>重做 --%>
	    	 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
				
	    	<select name="orderType" value="orderType">
	    		<option value="" <%=projectInfo.getAt("order_type").equals("")? "selected":"" %>></option>
						<option value="新单" <%=projectInfo.getAt("order_type").equals("新单")? "selected":"" %>>新单</option>
						<option value="打样" <%=projectInfo.getAt("order_type").equals("打样")? "selected":"" %>>打样</option>
						<option value="重做" <%=projectInfo.getAt("order_type").equals("重做")? "selected":"" %>>重做</option>
						<option value="其他" <%=projectInfo.getAt("order_type").equals("其他")? "selected":"" %>>其他</option>
				</select> 
							 <%}else{ %>
				<input style="border:none;" type="text"   readOnly="true"   required="true" name="project_no1" id="project_no1" value=<%=projectInfo.getAt("order_type")%>>
	    
  <%} %>
				</td>
				<td nowrap="nowrap" align="center" class="f_bold">交付时间</td>
				<td nowrap="nowrap" align="center" >
					 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
		
				<input style="border:none;" type="text"        name="jiaofu_time" id="jiaofu_time"   value="<%=projectInfo.getAt("jiaofu_time")%>"  >
					 <%}else{ %>
				<input style="border:none;" type="text"        name="jiaofu_time" id="jiaofu_time"  readonly="true"  value="<%=projectInfo.getAt("jiaofu_time")%>"  >
	    
  <%} %>
				<!-- <select name="jiaofu_time" value="jiaofu_time">
						<option value="10">+10天  加急</option>
						<option value="5">+5天  特别加急</option>
						<option value="3">+3天   非常紧急</option>
				</select> <font color="red"></font> -->
				</td>
				
			
			</tr>
			<tr class="t_subtitle">
				<td nowrap="nowrap" align="center" class="f_bold">西装数量</td>
				<td nowrap="nowrap" align="center" >
					 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
		
				<input style="border:none;" name="xizhuang_number"  id="xizhuang_number" type="number"
					class="txt_1"    value="<%=projectInfo.getAt("xizhuang_number")%>" />
					 <%}else{ %>
					 <input style="border:none;"  readonly="true"   name="xizhuang_number"  id="xizhuang_number" type="number"
					class="txt_1"    value="<%=projectInfo.getAt("xizhuang_number")%>" />
 <%} %>
			</td>
				<td nowrap="nowrap" align="center" class="f_bold">衣码</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				<input style="border:none;" name="yi_ma"  type="text" class="txt_1"    value="<%=projectInfo.getAt("yi_ma")%>">
				 <%}else{ %>
				<input style="border:none;" name="yi_ma"  
			readonly="true"	
				type="text" class="txt_1"    value="<%=projectInfo.getAt("yi_ma")%>">
 <%} %>
				</td>
				<td nowrap="nowrap" align="center" class="f_bold">衬衫数量</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
				 
				<input style="border:none;" name="chenshan_number"  id="chenshan_number" type="number"
					class="txt_1"   value="<%=projectInfo.getAt("chenshan_number")%>" />
					<%}else{ %>
					<input style="border:none;" readonly="true"  name="chenshan_number"  id="chenshan_number" type="number"
					class="txt_1"   value="<%=projectInfo.getAt("chenshan_number")%>" />
 <%} %>
 
				</td>
				<td nowrap="nowrap" align="center" class="f_bold">衬衫码</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				<input style="border:none;" name="chenshan_ma"  type="text" class="txt_1"    value="<%=projectInfo.getAt("chenshan_ma")%>">
				 <%}else{ %>
				<input style="border:none;" name="chenshan_ma" readonly="true"   type="text" class="txt_1"    value="<%=projectInfo.getAt("chenshan_ma")%>">
 <%} %>
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" class="f_bold">肩宽</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
					<input style="border:none;" type="text"        name="jiankuanA" id="jiankuanA"   value="<%=projectInfo.getAt("jiankuan_a")%>"  >
					 <%}else{ %>
					<input style="border:none;" type="text"   readonly="true"     name="jiankuanA" id="jiankuanA"   value="<%=projectInfo.getAt("jiankuan_a")%>"  >
 <%} %>
				</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				 <input style="border:none;" name="jiankuanA2"  type="text" class="txt_1"    value="<%=projectInfo.getAt("jiankuan_a2")%>" >
				  <%}else{ %>
				 <input style="border:none;" name="jiankuanA2" readonly="true"   type="text" class="txt_1"    value="<%=projectInfo.getAt("jiankuan_a2")%>" >
 <%} %>
				</td>
				<td nowrap="nowrap" align="center"  rowspan="4">
					<img src="http://47.111.148.8/watch/upload/test.png" width="100" height="100" />
				</td>
				<td nowrap="nowrap" align="center" class="f_bold">领围</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
			<input style="border:none;" type="text"        name="lingweiB" id="lingweiB"   value="<%=projectInfo.getAt("lingwei_b")%>"  >
			 <%}else{ %>
			<input style="border:none;" type="text"  readonly="true"      name="lingweiB" id="lingweiB"   value="<%=projectInfo.getAt("lingwei_b")%>"  >
 <%} %>
		</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				 <input style="border:none;" name="lingweiB2"  type="text" class="txt_1" value="<%=projectInfo.getAt("lingwei_b2")%>" >
				  <%}else{ %>
				 <input style="border:none;" name="lingweiB2" readonly="true"   type="text" class="txt_1" value="<%=projectInfo.getAt("lingwei_b2")%>" >
 <%} %>
				</td>
				<td nowrap="nowrap" align="center"  rowspan="4">
					<img src="http://47.111.148.8/watch/upload/test.png" width="100" height="100" />
				</td>
			</tr>
			<tr class="td_bg_pink">
				<td nowrap="nowrap" align="center" class="f_bold">胸围</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
					<input style="border:none;" type="text"        name="xiongweiA" id="xiongweiA"   value="<%=projectInfo.getAt("xiongwei_a")%>"  >
					 <%}else{ %>
					<input style="border:none;" type="text" readonly="true"       name="xiongweiA" id="xiongweiA"   value="<%=projectInfo.getAt("xiongwei_a")%>"  >
 <%} %>
				</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				<input style="border:none;" name="xiongweiA2"  type="text" class="txt_1" value="<%=projectInfo.getAt("xiongwei_a2")%>">
				 <%}else{ %>
				<input style="border:none;" name="xiongweiA2"  readonly="true"   type="text" class="txt_1" value="<%=projectInfo.getAt("xiongwei_a2")%>">
 <%} %>
				</td>
				
				<td nowrap="nowrap" align="center" class="f_bold">胸围</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
					<input style="border:none;" type="text"        name="xiongweiB" id="xiongweiB"   value="<%=projectInfo.getAt("xiongwei_b")%>"  >
						 <%}else{ %>
					<input style="border:none;" type="text"   readonly="true"     name="xiongweiB" id="xiongweiB"   value="<%=projectInfo.getAt("xiongwei_b")%>"  >
 <%} %>
			</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				 <input style="border:none;" name="xiongweiB22"  type="text" class="txt_1"  value="<%=projectInfo.getAt("xiongwei_2")%>">
				 <%}else{ %>
				 <input style="border:none;" name="xiongweiB22" readonly="true"   type="text" class="txt_1"  value="<%=projectInfo.getAt("xiongwei_2")%>">
 <%} %>
				</td>
<!--				<td nowrap="nowrap" align="center" ></td>-->
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" class="f_bold">中腰</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
			<input style="border:none;" type="text"        name="zhongyaoA" id="zhongyaoA"   value="<%=projectInfo.getAt("zhongyao_a")%>"  >
		 <%}else{ %>
			<input style="border:none;" type="text"  readonly="true"      name="zhongyaoA" id="zhongyaoA"   value="<%=projectInfo.getAt("zhongyao_a")%>"  >
 <%} %>
		</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				 <input style="border:none;" name="zhongyaoA2"  type="text" class="txt_1" value="<%=projectInfo.getAt("zhongyao_a2")%>">
			 <%}else{ %>
				 <input style="border:none;" name="zhongyaoA2" readonly="true"   type="text" class="txt_1" value="<%=projectInfo.getAt("zhongyao_a2")%>">
 <%} %>
				</td>
			
				<td nowrap="nowrap" align="center" class="f_bold">中腰</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
		<input style="border:none;" type="text"        name="zhongyaoA" id="zhongyaoA"   value="<%=projectInfo.getAt("zhongyao_b")%>"  >
		 <%}else{ %>
		<input style="border:none;" type="text"   readonly="true"     name="zhongyaoA" id="zhongyaoA"   value="<%=projectInfo.getAt("zhongyao_b")%>"  >
 <%} %>
	</td>
				<td nowrap="nowrap" align="center" >
					 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				<input style="border:none;" name="zhongyaoB2"  type="text" class="txt_1" value="<%=projectInfo.getAt("zhongyao_b2")%>" ><font color="red"></font>
				 <%}else{ %>
				<input style="border:none;" name="zhongyaoB2" readonly="true"  type="text" class="txt_1" value="<%=projectInfo.getAt("zhongyao_b2")%>" ><font color="red"></font>
 <%} %>
				</td>
<!--				<td nowrap="nowrap" align="center" ></td>-->
			</tr>
			<tr class="td_bg_pink">
				<td nowrap="nowrap" align="center" class="f_bold">腹围</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
			<input style="border:none;" type="text"        name="fuweiA" id="fuweiA"   value="<%=projectInfo.getAt("fuwei_a")%>"  >
			 <%}else{ %>
			<input style="border:none;" type="text"    readonly="true"    name="fuweiA" id="fuweiA"   value="<%=projectInfo.getAt("fuwei_a")%>"  >
 <%} %>
		</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>

				 <input style="border:none;" name="fuweiA2" id="fuweiA2"   type="text" class="txt_1" value="<%=projectInfo.getAt("fuwei_a2")%>">
				 <%}else{ %>
				 <input style="border:none;" readonly="true" name="fuweiA2" id="fuweiA2"   type="text" class="txt_1" value="<%=projectInfo.getAt("fuwei_a2")%>">
 <%} %>
				</td>
				
				<td nowrap="nowrap" align="center" class="f_bold">腹围</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>

<input style="border:none;" type="text"        name="fuweiB" id="fuweiB"   value="<%=projectInfo.getAt("fuwei_b")%>"  >
 <%}else{ %>
<input style="border:none;" type="text"  readonly="true"      name="fuweiB" id="fuweiB"   value="<%=projectInfo.getAt("fuwei_b")%>"  >
 <%} %>
</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				 <input style="border:none;" name="fuweiB2"  type="text" class="txt_1" value="<%=projectInfo.getAt("fuwei_b2")%>"><font color="red"></font>
				<%}else{ %>
				 <input style="border:none;" readonly="true"  name="fuweiB2"  type="text" class="txt_1" value="<%=projectInfo.getAt("fuwei_b2")%>"><font color="red"></font>
 <%} %>
				</td>
<!--				<td nowrap="nowrap" align="center" ></td>-->
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" class="f_bold">后中衣长</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
<input style="border:none;" type="text"        name="houzhongyichangA" id="houzhongyichangA"   value="<%=projectInfo.getAt("houzhongyichang_a")%>"  >
 <%}else{ %>
<input style="border:none;" type="text"  readonly="true"      name="houzhongyichangA" id="houzhongyichangA"   value="<%=projectInfo.getAt("houzhongyichang_a")%>"  >
 <%} %>

</td>
 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
 
				<td nowrap="nowrap" align="center" >
				 <input style="border:none;" name="houzhongyichangA2"  type="text" class="txt_1" value="<%=projectInfo.getAt("houzhongyichang_a2")%>">
				</td>
				<td nowrap="nowrap" align="center"  rowspan="5">
				 <input style="border:none;" name="dakuang1"  type="text" class="txt_1" value="<%=projectInfo.getAt("dakuang1")%>">
<%-- 				 <textarea name="dakuang1" id="dakuang1" rows="8" cols="8" class="txt_1"  value="<%=projectInfo.getAt("dakuang1")%>"></textarea>
 --%>				</td>
  <%}else{ %>
  	<td nowrap="nowrap" align="center" >
				 <input style="border:none;" name="houzhongyichangA2" readonly="true"   type="text" class="txt_1" value="<%=projectInfo.getAt("houzhongyichang_a2")%>">
				</td>
				<td nowrap="nowrap" align="center"  rowspan="5">
				 <input style="border:none;" name="dakuang1" readonly="true"  type="text" class="txt_1" value="<%=projectInfo.getAt("dakuang1")%>">
<%-- 				 <textarea name="dakuang1" id="dakuang1" rows="8" cols="8" class="txt_1"  value="<%=projectInfo.getAt("dakuang1")%>"></textarea>
 --%>				</td>
 <%} %>
 
				<td nowrap="nowrap" align="center" class="f_bold">衣长</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
				<input style="border:none;" name="yichangB2"  type="text" class="txt_1" value="<%=projectInfo.getAt("yichang_b2")%>">
				 <%}else{ %>
				<input style="border:none;" readonly="true"  name="yichangB2"  type="text" class="txt_1" value="<%=projectInfo.getAt("yichang_b2")%>">
 <%} %>
				</td>
				
				
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
 
				<td nowrap="nowrap" align="center" >
				<input style="border:none;" name="yichang_q"  type="text" class="txt_1" value="<%=projectInfo.getAt("yichang_q")%>">
				</td>
				<td nowrap="nowrap" align="center" rowspan="5">
				 <input style="border:none;" name="dakuang2"  type="text" class="txt_1" value="<%=projectInfo.getAt("dakuang2")%>">
				 </td>
				  <%}else{ %>
				  	<td nowrap="nowrap" align="center" >
				<input style="border:none;" name="yichang_q" readonly="true"    type="text" class="txt_1" value="<%=projectInfo.getAt("yichang_q")%>">
				</td>
				<td nowrap="nowrap" align="center" rowspan="5">
				 <input style="border:none;" name="dakuang2" readonly="true"  type="text" class="txt_1" value="<%=projectInfo.getAt("dakuang2")%>">
				 </td>
 <%} %>
 
			</tr>
				<tr class="td_bg_pink">
				<td nowrap="nowrap" align="center" class="f_bold">前衣长</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
		<input style="border:none;" type="text"        name="qianyichangA" id="qianyichangA"   value="<%=projectInfo.getAt("qianyichang_a")%>"  >
	 <%}else{ %>
		<input style="border:none;" type="text"   readonly="true"     name="qianyichangA" id="qianyichangA"   value="<%=projectInfo.getAt("qianyichang_a")%>"  >
 <%} %>
	</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
 
				 <input style="border:none;" name="qianyichangA2"  type="text" class="txt_1" value="<%=projectInfo.getAt("qianyichang_a2")%>">
				<%}else{ %>
				 <input style="border:none;" name="qianyichangA2"  readonly="true"  type="text" class="txt_1" value="<%=projectInfo.getAt("qianyichang_a2")%>">
 <%} %>
				</td>
			<!-- 	<td nowrap="nowrap" align="center" ></td> -->
				<td nowrap="nowrap" align="center" class="f_bold">腹围</td>
				<td nowrap="nowrap" align="center" > 
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
				 <input style="border:none;" name="fuwei_quea"  type="text" class="txt_1" value="<%=duoyu.getAt("fuwei_quea")%>">
			 <%}else{ %>
				 <input style="border:none;"  readonly="true" name="fuwei_quea"  type="text" class="txt_1" value="<%=duoyu.getAt("fuwei_quea")%>">
 <%} %>
				</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				 <input style="border:none;" name="fuwei_queb"  type="text" class="txt_1" value="<%=duoyu.getAt("fuwei_queb")%>">
				 <%}else{ %>
				 <input style="border:none;" readonly="true"  name="fuwei_queb"  type="text" class="txt_1" value="<%=duoyu.getAt("fuwei_queb")%>">
 <%} %>
				</td>
<!--				<td nowrap="nowrap" align="center" ></td>-->
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" class="f_bold">袖长</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>

	<input style="border:none;" type="text"        name="xiuchangB" id="xiuchangB"   value="<%=projectInfo.getAt("xiuchang_b")%>"  >
 <%}else{ %>
	<input style="border:none;" type="text"  readonly="true"      name="xiuchangB" id="xiuchangB"   value="<%=projectInfo.getAt("xiuchang_b")%>"  >
 <%} %>
</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
					<input style="border:none;" type="text"        name="xc_que" id="xc_que"   value="<%=projectInfo.getAt("xc_que")%>"  >
				<%}else{ %>
					<input style="border:none;" type="text"   readonly="true"     name="xc_que" id="xc_que"   value="<%=projectInfo.getAt("xc_que")%>"  >
 <%} %>
				</td>
				<!-- <td nowrap="nowrap" align="center" ></td> -->
				<td nowrap="nowrap" align="center" class="f_bold">袖长</td>
				<td nowrap="nowrap" align="center" >
 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
				<input style="border:none;" type="text"        name="xiuchangA" id="xiuchangA"   value="<%=projectInfo.getAt("xiuchang_a")%>"  >
				 <%}else{ %>
				<input style="border:none;" type="text"   readonly="true"     name="xiuchangA" id="xiuchangA"   value="<%=projectInfo.getAt("xiuchang_a")%>"  >
 <%} %>
				</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				 <input style="border:none;" name="xiuchangA2"  type="text" class="txt_1" value="<%=projectInfo.getAt("xiuchang_a2")%>" >
				 <%}else{ %>
				 <input style="border:none;" readonly="true"  name="xiuchangA2"  type="text" class="txt_1" value="<%=projectInfo.getAt("xiuchang_a2")%>" >
 <%} %>
				</td>
<!--				<td nowrap="nowrap" align="center" ></td>-->
			</tr>
			<tr class="td_bg_pink">
				<td nowrap="nowrap" align="center" class="f_bold">袖肥</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
	<input style="border:none;" type="text"        name="xiufeiB" id="xiufeiB"   value="<%=projectInfo.getAt("xiufei_b")%>"  >
 <%}else{ %>
	<input style="border:none;" type="text"  readonly="true"      name="xiufeiB" id="xiufeiB"   value="<%=projectInfo.getAt("xiufei_b")%>"  >
 <%} %>
</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				 <input style="border:none;" name="xiufeiB2"  type="text" class="txt_1" value="<%=projectInfo.getAt("xiufei_b2")%>">
			 <%}else{ %>
				 <input style="border:none;"  readonly="true" name="xiufeiB2"  type="text" class="txt_1" value="<%=projectInfo.getAt("xiufei_b2")%>">
 <%} %>
				</td>
				<!-- <td nowrap="nowrap" align="center" ></td> -->
				<td nowrap="nowrap" align="center" class="f_bold">袖肥</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
	<input style="border:none;" type="text"        name="xiufeiA" id="xiufeiA"   value="<%=projectInfo.getAt("xiufei_a")%>"  >
<%}else{ %>
	<input style="border:none;" type="text"   readonly="true"     name="xiufeiA" id="xiufeiA"   value="<%=projectInfo.getAt("xiufei_a")%>"  >
 <%} %>
</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				<input style="border:none;" name="xiukouA2"  type="text" class="txt_1" value="<%=projectInfo.getAt("xiukou_a2")%>">
				<%}else{ %>
				<input style="border:none;" readonly="true"  name="xiukouA2"  type="text" class="txt_1" value="<%=projectInfo.getAt("xiukou_a2")%>">
 <%} %>
				</td>
				<!-- <td nowrap="nowrap" align="center" ></td> -->
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" class="f_bold">袖口</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
 
<input style="border:none;" type="text"        name="xiukouB" id="xiukouB"   value="<%=projectInfo.getAt("xiukou_b")%>"  >
<%}else{ %>
<input style="border:none;" type="text"   readonly="true"     name="xiukouB" id="xiukouB"   value="<%=projectInfo.getAt("xiukou_b")%>"  >
 <%} %>
</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				 <input style="border:none;" name="xiukouB2"  type="text" class="txt_1" value="<%=projectInfo.getAt("xiukou_b2")%>">
				 <%}else{ %>
				 <input style="border:none;" readonly="true"  name="xiukouB2"  type="text" class="txt_1" value="<%=projectInfo.getAt("xiukou_b2")%>">
 <%} %>
				</td>
				<!-- <td nowrap="nowrap" align="center" ></td> -->
				<td nowrap="nowrap" align="center" class="f_bold">袖口</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
					<input style="border:none;" type="text"        name="xiukouA" id="xiukouA"   value="<%=projectInfo.getAt("xiukou_a")%>"  >
				 <%}else{ %>
					<input style="border:none;" type="text"   readonly="true"     name="xiukouA" id="xiukouA"   value="<%=projectInfo.getAt("xiukou_a")%>"  >
 <%} %>
				</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				<input style="border:none;" type="text"        name="xiukou_que" id="xiukou_que"   value="<%=projectInfo.getAt("xiukou_que")%>"  >
			 <%}else{ %>
				<input style="border:none;" type="text"  readonly="true"      name="xiukou_que" id="xiukou_que"   value="<%=projectInfo.getAt("xiukou_que")%>"  >
 <%} %>
				</td>
				<!-- <td nowrap="nowrap" align="center" ></td> -->
			</tr>
			<tr class="t_subtitle">
				<td nowrap="nowrap" align="center" class="f_bold">西裤数量</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>

				<input style="border:none;" name="xiku_number"  id="xiku_number" type="number"
					class="txt_1"  value="<%=projectInfo.getAt("xiku_number")%>" />
					 <%}else{ %>
					 	<input style="border:none;"  readonly="true" name="xiku_number"  id="xiku_number" type="number"
					class="txt_1"  value="<%=projectInfo.getAt("xiku_number")%>" />
 <%} %>
				</td>
				<td nowrap="nowrap" align="center" class="f_bold">裤码</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				<input style="border:none;" name="ku_ma"  type="text" class="txt_1"     value="<%=projectInfo.getAt("ku_ma")%>">
				 <%}else{ %>
				<input style="border:none;" name="ku_ma" readonly="true"  type="text" class="txt_1"     value="<%=projectInfo.getAt("ku_ma")%>">
 <%} %>
				</td>
				<td nowrap="nowrap" align="center" class="f_bold">马甲数量</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
					<input style="border:none;" name="majia_number"  id="majia_number" type="number"
					class="txt_1"   value="<%=projectInfo.getAt("majia_number")%>" />
					 <%}else{ %>
					 	<input style="border:none;" readonly="true"  name="majia_number"  id="majia_number" type="number"
					class="txt_1"   value="<%=projectInfo.getAt("majia_number")%>" />
 <%} %>
				</td>
				<td nowrap="nowrap" align="center" class="f_bold">马甲码</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				<input style="border:none;" name="majia_ma"  type="text" class="txt_1"    value="<%=projectInfo.getAt("majia_ma")%>">
				 <%}else{ %>
				<input style="border:none;" readonly="true" name="majia_ma"  type="text" class="txt_1"    value="<%=projectInfo.getAt("majia_ma")%>">
 <%} %>
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" class="f_bold">腰围</td>
				<td nowrap="nowrap" align="center" >	
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
				<input style="border:none;" type="text"        name="yaoweiC" id="yaoweiC"   value="<%=projectInfo.getAt("yaowei_c")%>"  >
				 <%}else{ %>
				<input style="border:none;" type="text"   readonly="true"     name="yaoweiC" id="yaoweiC"   value="<%=projectInfo.getAt("yaowei_c")%>"  >
 <%} %>
				</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				<input style="border:none;" name="yaoweiC22"  type="text" class="txt_1" value="<%=projectInfo.getAt("yaowei_c22")%>">
			 <%}else{ %>
				<input style="border:none;" name="yaoweiC22"  readonly="true"   type="text" class="txt_1" value="<%=projectInfo.getAt("yaowei_c22")%>">
 <%} %>
				</td>
				<td nowrap="nowrap" align="center"  rowspan="4">
					<img src="http://47.111.148.8/watch/upload/test.png" width="100" height="100" />
				</td>
				<td nowrap="nowrap" align="center" class="f_bold">肩宽</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
					<input style="border:none;" name="jiankuannew"  type="text" class="txt_1" value="<%=projectInfo.getAt("jiankuannew")%>">
 <%}else{ %>
					<input style="border:none;" readonly="true" name="jiankuannew"  type="text" class="txt_1" value="<%=projectInfo.getAt("jiankuannew")%>">
 <%} %>
				</td>
				<td nowrap="nowrap" align="center" >
				
 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
					<input style="border:none;" name="jiankuanque"  type="text" class="txt_1" value="<%=projectInfo.getAt("jiankuanque")%>">
 <%}else{ %>
					<input style="border:none;" readonly="true" name="jiankuanque"  type="text" class="txt_1" value="<%=projectInfo.getAt("jiankuanque")%>">
 <%} %>				
				</td>
				<td nowrap="nowrap" align="center"  rowspan="4">
					<img src="http://47.111.148.8/watch/upload/test.png" width="100" height="100" />
				</td>
			</tr>
			<tr class="td_bg_pink">
				<td nowrap="nowrap" align="center" class="f_bold">臀围</td>
				<td nowrap="nowrap" align="center" >	
 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
				<input style="border:none;" type="text"        name="tuiweiC" id="tuiweiC"   value="<%=projectInfo.getAt("tuiwei_c")%>"  >
 <%}else{ %>
				<input style="border:none;" type="text"   readonly="true"     name="tuiweiC" id="tuiweiC"   value="<%=projectInfo.getAt("tuiwei_c")%>"  >
 <%} %>
				
				</td>
				<td nowrap="nowrap" align="center" >

 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				<input style="border:none;" name="tuiweiC2"  type="text" class="txt_1"  value="<%=projectInfo.getAt("tuiwei_c2")%>">
 <%}else{ %>
				<input style="border:none;" name="tuiweiC2"   readonly="true"   type="text" class="txt_1"  value="<%=projectInfo.getAt("tuiwei_c2")%>">
 <%} %>				
				</td>
				
				<td nowrap="nowrap" align="center" class="f_bold">胸围</td>
				<td nowrap="nowrap" align="center" >
				
 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
<input style="border:none;" type="text"        name="xiongweiD" id="xiongweiD"   value="<%=projectInfo.getAt("xiongwei_d")%>"  >
 <%}else{ %>
<input style="border:none;" type="text"    readonly="true"    name="xiongweiD" id="xiongweiD"   value="<%=projectInfo.getAt("xiongwei_d")%>"  >
 <%} %>
</td>
				<td nowrap="nowrap" align="center" >
 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				<input style="border:none;" name="xiongweiD2"  type="text" class="txt_1" value="<%=projectInfo.getAt("xiongwei_d2")%>">
 <%}else{ %>
				<input style="border:none;" name="xiongweiD2"  readonly="true"  type="text" class="txt_1" value="<%=projectInfo.getAt("xiongwei_d2")%>">
 <%} %>
				</td>
				<!-- <td nowrap="nowrap" align="center" ></td> -->
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" class="f_bold">档围</td>
				<td nowrap="nowrap" align="center" >
 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
	<input style="border:none;" type="text"        name="dangweiC" id="dangweiC"   value="<%=projectInfo.getAt("dangwei_c")%>"  >
 <%}else{ %>
	<input style="border:none;" type="text"   readonly="true"     name="dangweiC" id="dangweiC"   value="<%=projectInfo.getAt("dangwei_c")%>"  >
 <%} %>
</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				<input style="border:none;" name="dangweiC2"  type="text" class="txt_1"  value="<%=projectInfo.getAt("dangwei_c2")%>">
 <%}else{ %>
				<input style="border:none;" name="dangweiC2"   readonly="true" type="text" class="txt_1"  value="<%=projectInfo.getAt("dangwei_c2")%>">
 <%} %>
				</td>
				
				<td nowrap="nowrap" align="center" class="f_bold">中腰</td>
				<td nowrap="nowrap" align="center" >	
				
 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
				<input style="border:none;" type="text"        name="zhongyaoD" id="zhongyaoD"   value="<%=projectInfo.getAt("zhongyao_d")%>"  >
 <%}else{ %>
				<input style="border:none;" type="text"    readonly="true"    name="zhongyaoD" id="zhongyaoD"   value="<%=projectInfo.getAt("zhongyao_d")%>"  >
 <%} %>
				</td>
				<td nowrap="nowrap" align="center" >
 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				<input style="border:none;" name="zhongyaoD2"  type="text" class="txt_1" value="<%=projectInfo.getAt("yaowei_c2")%>">
 <%}else{ %>
				<input style="border:none;" readonly="true"  name="zhongyaoD2"  type="text" class="txt_1" value="<%=projectInfo.getAt("yaowei_c2")%>">
 <%} %>
				</td>
				<!-- <td nowrap="nowrap" align="center" ></td> -->
			</tr>
			<tr class="td_bg_pink">
				<td nowrap="nowrap" align="center" class="f_bold">大腿</td>
				<td nowrap="nowrap" align="center" >	
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
				<input style="border:none;" type="text"        name="datuiC" id="datuiC"   value="<%=projectInfo.getAt("datui_c")%>"  >
 <%}else{ %>
				<input style="border:none;" type="text"  readonly="true"      name="datuiC" id="datuiC"   value="<%=projectInfo.getAt("datui_c")%>"  >
 <%} %>
				</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				<input style="border:none;" name="datuiC2"  type="text" class="txt_1" value="<%=projectInfo.getAt("datui_c2")%>">
 <%}else{ %>
				<input style="border:none;" name="datuiC2"   readonly="true"  type="text" class="txt_1" value="<%=projectInfo.getAt("datui_c2")%>">
 <%} %>
				</td>
				
				<td nowrap="nowrap" align="center" class="f_bold">衣长</td>
				<td nowrap="nowrap" align="center" >	
 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
				<input style="border:none;" type="text"        name="yichangD" id="yichangD"   value="<%=projectInfo.getAt("yichang_d")%>"  >
 <%}else{ %>
				<input style="border:none;" type="text"   readonly="true"     name="yichangD" id="yichangD"   value="<%=projectInfo.getAt("yichang_d")%>"  >
 <%} %>				
				</td>
				<td nowrap="nowrap" align="center" >
 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				<input style="border:none;" name="yichangD2"  type="text" class="txt_1" value="<%=projectInfo.getAt("yichang_d2")%>">
 <%}else{ %>
				<input style="border:none;" name="yichangD2"  readonly="true"  type="text" class="txt_1" value="<%=projectInfo.getAt("yichang_d2")%>">
 <%} %>				
				</td>
<!--				<td nowrap="nowrap" align="center" ></td>-->
			</tr>
			
			<tr>
				<td nowrap="nowrap" align="center" class="f_bold">中腿</td>
				<td nowrap="nowrap" align="center" >	
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
				<input style="border:none;" type="text"        name="zhongtuiC" id="zhongtuiC"   value="<%=projectInfo.getAt("zhongtui_c")%>"  >
 <%}else{ %>
				<input style="border:none;" type="text"    readonly="true"    name="zhongtuiC" id="zhongtuiC"   value="<%=projectInfo.getAt("zhongtui_c")%>"  >
 <%} %>
				</td>
				<td nowrap="nowrap" align="center" >
 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				<input style="border:none;" name="zhongtuiC2"  type="text" class="txt_1" value="<%=projectInfo.getAt("zhongtui_c2")%>">
 <%}else{ %>
				<input style="border:none;" name="zhongtuiC2"  readonly="true"  type="text" class="txt_1" value="<%=projectInfo.getAt("zhongtui_c2")%>">
 <%} %>
				</td>
				<td nowrap="nowrap" align="center"  rowspan="4">
						 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
						<input style="border:none;" name="dakuang3"  type="text" class="txt_1" value="<%=projectInfo.getAt("dakuang3")%>" >
 <%}else{ %>
						<input style="border:none;" name="dakuang3" readonly="true"    type="text" class="txt_1" value="<%=projectInfo.getAt("dakuang3")%>" >
 <%} %>
				</td>
				<td nowrap="nowrap" align="center"  rowspan="4" class="f_bold">款型</td>
				<td nowrap="nowrap" align="center"  rowspan="4" colspan="2">
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
<select name="kuanxingD" value="kuanxingD" >
					<option value="" <%=projectInfo.getAt("kuanxing_d").equals("")? "selected":"" %>></option>
						<option value="修身" <%=projectInfo.getAt("kuanxing_d").equals("修身")? "selected":"" %>>修身</option>
						<option value="修身+" <%=projectInfo.getAt("kuanxing_d").equals("修身+")? "selected":"" %>>修身+</option>
						<option value="合身" <%=projectInfo.getAt("kuanxing_d").equals("合身")? "selected":"" %>>合身</option>
						<option value="合身+"  <%=projectInfo.getAt("kuanxing_d").equals("合身+")? "selected":"" %> >合身+</option>
						<option value="宽松" <%=projectInfo.getAt("kuanxing_d").equals("宽松")? "selected":"" %> >宽松</option>
						<option value="宽松+" <%=projectInfo.getAt("kuanxing_d").equals("宽松+")? "selected":"" %> >宽松+</option>
				</select> 
 <%}else{ %>
 		<input style="border:none;" name="dakuang3" readonly="true"  type="text" class="txt_1" value="<%=projectInfo.getAt("kuanxing_d")%>">
 <%} %>
				
				
<%-- 	<input style="border:none;" name="kuanxingD" type="radio" class="radio_1" value="修身" <%if("修身".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>修身
		<input style="border:none;" name="kuanxingD" type="radio" class="radio_1" value="修身+" <%if("修身+".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>修身+
		<input style="border:none;" name="kuanxingD" type="radio" class="radio_1" value="合身" <%if("合身".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>合身
		<input style="border:none;" name="kuanxingD" type="radio" class="radio_1" value="合身+" <%if("合身+".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>合身+
		<input style="border:none;" name="kuanxingD" type="radio" class="radio_1" value="宽松" <%if("宽松".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>宽松
		<input style="border:none;" name="kuanxingD" type="radio" class="radio_1" value="宽松+" <%if("宽松+".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>宽松+ --%>
</td>
			
				<td nowrap="nowrap" align="center"  rowspan="4">
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
					<input style="border:none;" type="text"        name="dakuang4" id="dakuang4"   value="<%=projectInfo.getAt("dakuang4")%>"  >
 <%}else{ %>
					<input style="border:none;" type="text"    readonly="true"    name="dakuang4" id="dakuang4"   value="<%=projectInfo.getAt("dakuang4")%>"  >
 <%} %>
				</td>
			</tr>
			<tr class="td_bg_pink">
				<td nowrap="nowrap" align="center" class="f_bold">小腿</td>
				<td nowrap="nowrap" align="center" >
 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
					<input style="border:none;" type="text"        name="xiaotuiC" id="xiaotuiC"   value="<%=projectInfo.getAt("xiaotui_c")%>"  >
 <%}else{ %>
					<input style="border:none;" type="text"   readonly="true"     name="xiaotuiC" id="xiaotuiC"   value="<%=projectInfo.getAt("xiaotui_c")%>"  >
 <%} %>
				</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				<input style="border:none;" name="xiaotuiC2"  type="text" class="txt_1" value="<%=projectInfo.getAt("xiaotui_c2")%>">
 <%}else{ %>
				<input style="border:none;" name="xiaotuiC2"  readonly="true"  type="text" class="txt_1" value="<%=projectInfo.getAt("xiaotui_c2")%>">
 <%} %>
				</td>
				
			
				
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" class="f_bold">裤长</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
				<input style="border:none;" type="text"        name="kuchangC" id="kuchangC"   value="<%=projectInfo.getAt("kuchang_c")%>"  >
 <%}else{ %>
				<input style="border:none;" type="text"   readonly="true"     name="kuchangC" id="kuchangC"   value="<%=projectInfo.getAt("kuchang_c")%>"  >
 <%} %>
				</td>
				<td nowrap="nowrap" align="center" >
 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				<input style="border:none;" name="kuchangC2"  type="text" class="txt_1" value="<%=projectInfo.getAt("kuchang_c2")%>">
 <%}else{ %>
				<input style="border:none;" name="kuchangC2"  readonly="true" type="text" class="txt_1" value="<%=projectInfo.getAt("kuchang_c2")%>">
 <%} %>				
				</td>
				
				
				
			</tr>
			<tr class="td_bg_pink">
				<td nowrap="nowrap" align="center" class="f_bold">脚口</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
					<input style="border:none;" type="text"        name="tuikouC" id="tuikouC"   value="<%=projectInfo.getAt("tuikou_c")%>"  >
 <%}else{ %>
					<input style="border:none;" type="text"   readonly="true"     name="tuikouC" id="tuikouC"   value="<%=projectInfo.getAt("tuikou_c")%>"  >
 <%} %>
				</td>
				<td nowrap="nowrap" align="center" >
 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				<input style="border:none;" name="tuikouC2"  type="text" class="txt_1" value="<%=projectInfo.getAt("tuikou_c2")%>">
 <%}else{ %>
				<input style="border:none;" name="tuikouC2"  readonly="true"   type="text" class="txt_1" value="<%=projectInfo.getAt("tuikou_c2")%>">
 <%} %>
				</td>
				
			
				
			</tr>
			
			<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">扣型</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
 
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
				 <%}else{ %>
				 	<input style="border:none;" type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("kouxing_c")%>>
 <%} %>
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">口袋</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>

				<select name="koudaiC" value="koudaiC">
					<option value="" <%=projectInfo.getAt("koudai_c").equals("")? "selected":"" %> ></option>
						<option value="平袋盖" <%=projectInfo.getAt("koudai_c").equals("平袋盖")? "selected":"" %> >平袋盖</option>
						<option value="平单线" <%=projectInfo.getAt("koudai_c").equals("平单线")? "selected":"" %> >平单线</option>
						<option value="平双线" <%=projectInfo.getAt("koudai_c").equals("平双线")? "selected":"" %> >平双线</option>
						<option value="斜袋盖" <%=projectInfo.getAt("koudai_c").equals("斜袋盖")? "selected":"" %> >斜袋盖</option>
						<option value="斜单线" <%=projectInfo.getAt("koudai_c").equals("斜单线")? "selected":"" %> >斜单线</option>
						<option value="斜双线" <%=projectInfo.getAt("koudai_c").equals("斜双线")? "selected":"" %> >斜双线</option>
						<option value="外贴袋" <%=projectInfo.getAt("koudai_c").equals("外贴袋")? "selected":"" %> >外贴袋</option>
						<option value="其他" <%=projectInfo.getAt("koudai_c").equals("其他")? "selected":"" %>  >其他</option>
				</select>
				 <%}else{ %>
				 	<input style="border:none;" type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("koudai_c")%>>
 <%} %>
				</td>
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>

				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">开叉</td>
				<td nowrap="nowrap" align="center" >
				<select name="kaicha" value="kaicha">
					<option value="" <%=projectInfo.getAt("kaicha").equals("")? "selected":"" %> ></option>
						<option value="单叉" <%=projectInfo.getAt("kaicha").equals("单叉")? "selected":"" %> >单叉</option>
						<option value="双叉" <%=projectInfo.getAt("kaicha").equals("双叉")? "selected":"" %>  >双叉</option>
						<option value="不开叉" <%=projectInfo.getAt("kaicha").equals("不开叉")? "selected":"" %>   >不开叉</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">领型</td>
				<td nowrap="nowrap" align="center" >
				
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
				
				<!-- <input style="border:none;" name="lingkoukuaishiB" 
					id="lingkoukuaishiB" type="text" class="txt_1"  /><font
					color="red"></font> -->
				</td>
				 <%}else{ %>
				 	<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">开叉</td>
				<td nowrap="nowrap" align="center" >
				<input style="border:none;" type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("kaicha")%>>
				<!-- <select name="kaicha" value="kaicha">
						<option value="单叉">单叉</option>
						<option value="双叉">双叉</option>
						<option value="不开叉">不开叉</option>
				</select> -->
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">领型</td>
				<td nowrap="nowrap" align="center" >
					<input style="border:none;" type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("lingkoukuaishi_b")%>>
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
				
				<!-- <input style="border:none;" name="lingkoukuaishiB" 
					id="lingkoukuaishiB" type="text" class="txt_1"  /><font
					color="red"></font> -->
				</td>
 <%} %>
			</tr>
			 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>

			<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">下摆</td>
				<td nowrap="nowrap" align="center" >
					<select name="xiabai" value="xiabai">
					<option value="" <%=projectInfo.getAt("xiabai").equals("")? "selected":"" %> ></option>
						<option value="直角下摆" <%=projectInfo.getAt("xiabai").equals("直角下摆")? "selected":"" %>  >直角下摆</option>
						<option value="圆角下摆" <%=projectInfo.getAt("xiabai").equals("圆角下摆")? "selected":"" %>  >圆角下摆</option>
						<option value="大圆角下摆" <%=projectInfo.getAt("xiabai").equals("大圆角下摆")? "selected":"" %>  >大圆角下摆</option>
						<option value="燕尾下摆" <%=projectInfo.getAt("xiabai").equals("燕尾下摆")? "selected":"" %>  >燕尾下摆</option>
						<option value="其他" <%=projectInfo.getAt("xiabai").equals("其他")? "selected":"" %>   >其他</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">撞色</td>
				<td nowrap="nowrap" align="center" >
				<select name="zhuangse" value="zhuangse">
				<option value="" <%=projectInfo.getAt("zhuangse").equals("")? "selected":"" %> ></option>
						<option value="袋条用色丁" <%=projectInfo.getAt("zhuangse").equals("袋条用色丁")? "selected":"" %>  >袋条用色丁</option>
						<option value="领边有色丁" <%=projectInfo.getAt("zhuangse").equals("领边有色丁")? "selected":"" %>  >领边有色丁</option>
						<option value="驳头用色丁" <%=projectInfo.getAt("zhuangse").equals("驳头用色丁")? "selected":"" %>   >驳头用色丁</option>
						<option value="驳头用色丁" <%=projectInfo.getAt("zhuangse").equals("其他")? "selected":"" %>  >其他</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">外珠边</td>
				<td nowrap="nowrap" align="center" >
				
				<select name="waizhubian" value="waizhubian">
					<option value="" <%=projectInfo.getAt("waizhubian").equals("")? "selected":"" %> ></option>
						<option value="有" <%=projectInfo.getAt("waizhubian").equals("有")? "selected":"" %> >有</option>
						<option value="无" <%=projectInfo.getAt("waizhubian").equals("无")? "selected":"" %> >无</option>
				</select> 
				
			<%-- 	<input style="border:none;" name="waizhubian" 
					id="waizhubian" type="text" class="txt_1"   value="<%=projectInfo.getAt("waizhubian")%>" /><font
					color="red"></font> --%>
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">袖叉</td>
				<td nowrap="nowrap" align="center" >
				<select name="xiucha" value="xiucha">
				<option value="" <%=projectInfo.getAt("xiucha").equals("")? "selected":"" %> ></option>
						<option value="真袖叉" <%=projectInfo.getAt("xiucha").equals("真袖叉")? "selected":"" %>  >真袖叉</option>
						<option value="假袖叉" <%=projectInfo.getAt("xiucha").equals("假袖叉")? "selected":"" %>  >假袖叉</option>
						<option value="翻袖" <%=projectInfo.getAt("xiucha").equals("翻袖")? "selected":"" %>   >翻袖</option>
						<option value="其它" <%=projectInfo.getAt("xiucha").equals("其它")? "selected":"" %>   >其它</option>
				</select>
				</td>
			</tr>
			
			 <%}else{ %>
			 <tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">下摆</td>
				<td nowrap="nowrap" align="center" >
						<input style="border:none;" type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("xiabai")%>>
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
					<input style="border:none;" type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("zhuangse")%>>
			<!-- 	<select name="zhuangse" value="zhuangse">
						<option value="袋条用色丁">袋条用色丁</option>
						<option value="领边有色丁">领边有色丁</option>
						<option value="驳头用色丁">驳头用色丁</option>
						<option value="驳头用色丁">其他</option>
				</select> -->
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">外珠边</td>
				<td nowrap="nowrap" align="center" >
				<input style="border:none;" type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("waizhubian")%>>
				<!-- <select name="waizhubian" value="waizhubian">
						<option value="有">有</option>
						<option value="无">无</option>
				</select>  -->
				
			<%-- 	<input style="border:none;" name="waizhubian" 
					id="waizhubian" type="text" class="txt_1"   value="<%=projectInfo.getAt("waizhubian")%>" /><font
					color="red"></font> --%>
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">袖叉</td>
				<td nowrap="nowrap" align="center" >
					<input style="border:none;" type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("xiucha")%>>
				<!-- <select name="xiucha" value="xiucha">
						<option value="真袖叉">真袖叉</option>
						<option value="假袖叉">假袖叉</option>
						<option value="翻袖">翻袖</option>
						<option value="其它">其它</option>
				</select> -->
				</td>
			</tr>
 <%} %>
			<tr>
			 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>

				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">裤腰</td>
				<td nowrap="nowrap" align="center" >
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
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">裤型</td>
				<td nowrap="nowrap" align="center" >
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
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">衬衫领</td>
				<td nowrap="nowrap" align="center" >
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
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">衬衫袖</td>
				<td nowrap="nowrap" align="center" >
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
				 <%}else{ %>
				 <td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">裤腰</td>
				<td nowrap="nowrap" align="center" >
				<input style="border:none;" type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("kuyao")%>>
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
				<input style="border:none;" type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("kuxing")%>>
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
					<input style="border:none;" type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("chenshanling")%>>
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
					<input style="border:none;" type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("chenshanxiu")%>>
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
 <%} %>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">
				 <%if("admin".equals(request.getAttribute("role"))|| "客服".equals(request.getAttribute("role"))|| "经理".equals(request.getAttribute("role"))|| "跟单".equals(request.getAttribute("role")) ){ %>
				<button type="button"  value="<%=request.getAttribute("gysall")%>"  onclick="addTable(this.value)"
			style="margin-left: 0px;">+</button>
			 <%} %>
				面料</td>
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>

				<td nowrap="nowrap" align="center" >
			<input style="border:none;" type="text"        name="miaoliao1" id="miaoliao1"   value="<%=projectInfo.getAt("miao_liao1")%>"  >
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
						<select name="yongtu1" value="yongtu1">
						<option value="" <%=projectInfo.getAt("yong_tu1").equals("")? "selected":"" %> ></option>
						<option value="上衣" <%=projectInfo.getAt("yong_tu1").equals("上衣")? "selected":"" %> >上衣</option>
						<option value="裤子" <%=projectInfo.getAt("yong_tu1").equals("裤子")? "selected":"" %>  >裤子</option>
						<option value="马甲"  <%=projectInfo.getAt("yong_tu1").equals("马甲")? "selected":"" %>  >马甲</option>
						<option value="衬衫"  <%=projectInfo.getAt("yong_tu1").equals("衬衫")? "selected":"" %>  >衬衫</option>
						<option value="西装套装" <%=projectInfo.getAt("yong_tu1").equals("西装套装")? "selected":"" %>  >西装套装</option>
						<option value="换片" <%=projectInfo.getAt("yong_tu1").equals("换片")? "selected":"" %>  >换片</option>
						<option value="其他" <%=projectInfo.getAt("yong_tu1").equals("其他")? "selected":"" %>  >其他</option>
				</select> 
				
				</td>
				 <%}else{ %>
				 <td nowrap="nowrap" align="center" >
			<input style="border:none;" type="text"     readonly="true"   name="miaoliao1" id="miaoliao1"   value="<%=projectInfo.getAt("miao_liao1")%>"  >
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
					 <input style="border:none;" type="text" readonly="true"     name="yongtu1" id="yongtu1"   value="<%=projectInfo.getAt("yong_tu1")%>"  >
				</td>
 <%} %>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">米数</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
						<input style="border:none;" name="mi1"  type="text" class="txt_1" value="<%=projectInfo.getAt("mi1")%>" >
 <%}else{ %>
						<input style="border:none;" name="mi1"  readonly="true"  type="text" class="txt_1" value="<%=projectInfo.getAt("mi1")%>" >
 <%} %>
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "跟单".equals(request.getAttribute("role")) ){ %>
					<%=request.getAttribute("companyList")%>
 <%}else{ %>
 					<input style="border:none;" type="text"   readOnly="true"    name="project_no1" id="project_no1" value=<%=projectInfo.getAt("gongyingshang_1")%>>
 <%} %>
				</td>
				
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">价格</td>
					<td nowrap="nowrap" align="center" >
						 <%if("admin".equals(request.getAttribute("role")) || "跟单".equals(request.getAttribute("role")) ){ %>
					<input name="jg"  id="jg" type="text" class="txt_1" maxlength="100"  value=<%=duoyu.getAt("jq")%>>
					 <%}else{ %>
					 <input name="jg"  id="jg" type="text" class="txt_1" maxlength="100" value=<%=duoyu.getAt("jq")%> readonly="true" >
					  <%} %>
					</td>
					
					
			</tr>
			
				 <%if(!"".equals(duoyu.getAt("ml1"))&& duoyu.getAt("ml1")!=null ){ %>
          	<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
				<td nowrap="nowrap" align="center" >
				<input name="ml1" id="ml1"  value="<%=duoyu.getAt("ml1")%>"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				
					<select name="yt1" value="yt1">
						<option value="" <%=duoyu.getAt("yt1").equals("")? "selected":"" %> ></option>
						<option value="上衣" <%=duoyu.getAt("yt1").equals("上衣")? "selected":"" %> >上衣</option>
						<option value="裤子" <%=duoyu.getAt("yt1").equals("裤子")? "selected":"" %>  >裤子</option>
						<option value="马甲"  <%=duoyu.getAt("yt1").equals("马甲")? "selected":"" %>  >马甲</option>
						<option value="衬衫"  <%=duoyu.getAt("yt1").equals("衬衫")? "selected":"" %>  >衬衫</option>
						<option value="西装套装" <%=duoyu.getAt("yt1").equals("西装套装")? "selected":"" %>  >西装套装</option>
						<option value="换片" <%=duoyu.getAt("yt1").equals("换片")? "selected":"" %>  >换片</option>
						<option value="其他" <%=duoyu.getAt("yt1").equals("其他")? "selected":"" %>  >其他</option>
						</select> 
				</td> 
<%}else{ %>
<td nowrap="nowrap" align="center" >
				<input name="ml1" id="ml1"  value="<%=duoyu.getAt("ml1")%>" readonly="true"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yt1" id="yt1"  value="<%=duoyu.getAt("yt1")%>"  readonly="true"
					
					type="text"  
					placeholder="" 
					 /></td>
 <%} %>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">米数</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				 <input name="ms1" id="ms1"  value="<%=duoyu.getAt("ms1")%>"
				
				type="text"  
					 />
 <%}else{ %>
 <input name="ms1" id="ms1"  value="<%=duoyu.getAt("ms1")%>" readonly="true"
				
				type="text"  
					 />
 <%} %>
				
					 
					 
					 </td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "跟单".equals(request.getAttribute("role")) ){ %>
					<%=request.getAttribute("gys1")%>
 <%}else{ %>
 <input
					name="gys1" id="gys1"  value="<%=duoyu.getAt("gys1")%>" readonly="true"
					type="text"  
					 />
 <%} %>
			    </td>
			    
			    	<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">价格</td>
					<td nowrap="nowrap" align="center" >
						 <%if("admin".equals(request.getAttribute("role")) || "跟单".equals(request.getAttribute("role")) ){ %>
					<input name="jg1"  id="jg1" type="text" class="txt_1" maxlength="100"  value=<%=duoyu.getAt("jq1")%>/>
					 <%}else{ %>
					 <input name="jg1"  id="jg1" type="text" class="txt_1" maxlength="100" value=<%=duoyu.getAt("jq1")%> readonly="true" />
					  <%} %>
					</td>
					
			</tr>
			
				 <%} %>
			
			
			 <%if(!"".equals(duoyu.getAt("ml2"))&& duoyu.getAt("ml2")!=null ){ %>
          
				
				 
			<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>

				<td nowrap="nowrap" align="center" >
				<input name="ml2" id="ml2"  value="<%=duoyu.getAt("ml2")%>"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
					<select name="yt2" value="yt2">
						<option value="" <%=duoyu.getAt("yt2").equals("")? "selected":"" %> ></option>
						<option value="上衣" <%=duoyu.getAt("yt2").equals("上衣")? "selected":"" %> >上衣</option>
						<option value="裤子" <%=duoyu.getAt("yt2").equals("裤子")? "selected":"" %>  >裤子</option>
						<option value="马甲"  <%=duoyu.getAt("yt2").equals("马甲")? "selected":"" %>  >马甲</option>
						<option value="衬衫"  <%=duoyu.getAt("yt2").equals("衬衫")? "selected":"" %>  >衬衫</option>
						<option value="西装套装" <%=duoyu.getAt("yt2").equals("西装套装")? "selected":"" %>  >西装套装</option>
						<option value="换片" <%=duoyu.getAt("yt2").equals("换片")? "selected":"" %>  >换片</option>
						<option value="其他" <%=duoyu.getAt("yt2").equals("其他")? "selected":"" %>  >其他</option>
						</select> 
				</td>
 <%}else{ %>
 <td nowrap="nowrap" align="center" >
				<input name="ml2" id="ml2"  value="<%=duoyu.getAt("ml2")%>" readonly="true"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yt2" id="yt2"  value="<%=duoyu.getAt("yt2")%>" readonly="true"
					
					type="text"  
					placeholder="" 
					 /></td>
 <%} %>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">米数</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				 	<input name="ms2" id="ms2"  value="<%=duoyu.getAt("ms2")%>"
				type="text"  
					 />
 <%}else{ %>
 	<input name="ms2" id="ms2"  value="<%=duoyu.getAt("ms2")%>" readonly="true"
				type="text"  
					 />
 <%} %>
			
					 
					 
					 </td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "跟单".equals(request.getAttribute("role")) ){ %>
					<%=request.getAttribute("gys2")%>
 <%}else{ %>
 <input
					name="gys2" id="gys2"  value="<%=duoyu.getAt("gys2")%>" readonly="true"
					type="text"  
					 />
 <%} %>
			
					 </td>
					 	<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">价格</td>
					<td nowrap="nowrap" align="center" >
						 <%if("admin".equals(request.getAttribute("role")) || "跟单".equals(request.getAttribute("role")) ){ %>
					<input name="jg2"  id="jg2" type="text" class="txt_1" maxlength="100"  value=<%=duoyu.getAt("jq2")%>/>
					 <%}else{ %>
					 <input name="jg2"  id="jg2" type="text" class="txt_1" maxlength="100" value=<%=duoyu.getAt("jq2")%> readonly="true" />
					  <%} %>
					</td>
			</tr>
			 <%} %>
			
			
			 <%if(!"".equals(duoyu.getAt("ml3"))&& duoyu.getAt("ml3")!=null ){ %>
          
			
				 
			<tr>
			 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
 	<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml3" id="ml3"  value="<%=duoyu.getAt("ml3")%>"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
					<select name="yt3" value="yt3">
						<option value="" <%=duoyu.getAt("yt3").equals("")? "selected":"" %> ></option>
						<option value="上衣" <%=duoyu.getAt("yt3").equals("上衣")? "selected":"" %> >上衣</option>
						<option value="裤子" <%=duoyu.getAt("yt3").equals("裤子")? "selected":"" %>  >裤子</option>
						<option value="马甲"  <%=duoyu.getAt("yt3").equals("马甲")? "selected":"" %>  >马甲</option>
						<option value="衬衫"  <%=duoyu.getAt("yt3").equals("衬衫")? "selected":"" %>  >衬衫</option>
						<option value="西装套装" <%=duoyu.getAt("yt3").equals("西装套装")? "selected":"" %>  >西装套装</option>
						<option value="换片" <%=duoyu.getAt("yt3").equals("换片")? "selected":"" %>  >换片</option>
						<option value="其他" <%=duoyu.getAt("yt3").equals("其他")? "selected":"" %>  >其他</option>
						</select> 
				</td>
 <%}else{ %>
 <td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml3" id="ml3"  value="<%=duoyu.getAt("ml3")%>" readonly="true"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yt3" id="yt3"  value="<%=duoyu.getAt("yt3")%>"  readonly="true"
					
					type="text"  
					placeholder="" 
					 /></td>
 <%} %>
			

				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">米数</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				 	<input name="ms3" id="ms3"  value="<%=duoyu.getAt("ms3")%>"
				
				type="text"  
					 />
 <%}else{ %>
 	<input name="ms3" id="ms3"  value="<%=duoyu.getAt("ms3")%>" readonly="true"
				
				type="text"  
					 />
 <%} %>
			
					 
					 </td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "跟单".equals(request.getAttribute("role")) ){ %>
					<%=request.getAttribute("gys3")%>
 <%}else{ %>
 <input
					name="gys3" id="gys3"  value="<%=duoyu.getAt("gys3")%>" readonly="true"
					type="text"  
					 /> 
 <%} %>
			<%-- 	--%></td>
			
			<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">价格</td>
					<td nowrap="nowrap" align="center" >
						 <%if("admin".equals(request.getAttribute("role")) || "跟单".equals(request.getAttribute("role")) ){ %>
					<input name="jg3"  id="jg3" type="text" class="txt_1" maxlength="100"  value=<%=duoyu.getAt("jq3")%>/>
					 <%}else{ %>
					 <input name="jg3"  id="jg3" type="text" class="txt_1" maxlength="100" value=<%=duoyu.getAt("jq3")%> readonly="true" />
					  <%} %>
					</td>
			</tr>
				 <%} %>
			
			 <%if(!"".equals(duoyu.getAt("ml4"))&& duoyu.getAt("ml4")!=null ){ %>
          
			
				<tr>
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
 <td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml4" id="ml4"  value="<%=duoyu.getAt("ml4")%>"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
					<select name="yt4" value="yt4">
						<option value="" <%=duoyu.getAt("yt4").equals("")? "selected":"" %> ></option>
						<option value="上衣" <%=duoyu.getAt("yt4").equals("上衣")? "selected":"" %> >上衣</option>
						<option value="裤子" <%=duoyu.getAt("yt4").equals("裤子")? "selected":"" %>  >裤子</option>
						<option value="马甲"  <%=duoyu.getAt("yt4").equals("马甲")? "selected":"" %>  >马甲</option>
						<option value="衬衫"  <%=duoyu.getAt("yt4").equals("衬衫")? "selected":"" %>  >衬衫</option>
						<option value="西装套装" <%=duoyu.getAt("yt4").equals("西装套装")? "selected":"" %>  >西装套装</option>
						<option value="换片" <%=duoyu.getAt("yt4").equals("换片")? "selected":"" %>  >换片</option>
						<option value="其他" <%=duoyu.getAt("yt4").equals("其他")? "selected":"" %>  >其他</option>
						</select> 
			<%-- 	<input
					name="yt4" id="yt4"  value="<%=duoyu.getAt("yt4")%>"
					
					type="text"  
					placeholder="" 
					 /> --%></td>
 <%}else{ %>
 <td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml4" id="ml4"  value="<%=duoyu.getAt("ml4")%>" readonly="true"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yt4" id="yt4"  value="<%=duoyu.getAt("yt4")%>" readonly="true"
					
					type="text"  
					placeholder="" 
					 /></td>
 <%} %>
				

				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">米数</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				<input name="ms4" id="ms4"  value="<%=duoyu.getAt("ms4")%>"
				type="text"  
					 />
 <%}else{ %>
 <input name="ms4" id="ms4"  value="<%=duoyu.getAt("ms4")%>" readonly="true"
				type="text"  
					 />
 <%} %>
				
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "跟单".equals(request.getAttribute("role")) ){ %>
					<%=request.getAttribute("gys4")%>
 <%}else{ %>
 <input
					name="gys4" id="gys4"  value="<%=duoyu.getAt("gys4")%>" readonly="true"
					type="text"  
					 />
 <%} %>
				<%-- <input
					name="gys4" id="gys4"  value="<%=duoyu.getAt("gys4")%>"
					type="text"  
					 /> --%></td>
					 
					 <td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">价格</td>
					<td nowrap="nowrap" align="center" >
						 <%if("admin".equals(request.getAttribute("role")) || "跟单".equals(request.getAttribute("role")) ){ %>
					<input name="jg4"  id="jg4" type="text" class="txt_1" maxlength="100"  value=<%=duoyu.getAt("jq4")%>/>
					 <%}else{ %>
					 <input name="jg4"  id="jg4" type="text" class="txt_1" maxlength="100" value=<%=duoyu.getAt("jq4")%> readonly="true" />
					  <%} %>
					</td>
			</tr>
				 <%} %>
			
				
				 <%if(!"".equals(duoyu.getAt("ml5"))&& duoyu.getAt("ml5")!=null ){ %>
          
				
				<tr>
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>

				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml5" id="ml5"  value="<%=duoyu.getAt("ml5")%>"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				
					<select name="yt5" value="yt5">
						<option value="" <%=duoyu.getAt("yt5").equals("")? "selected":"" %> ></option>
						<option value="上衣" <%=duoyu.getAt("yt5").equals("上衣")? "selected":"" %> >上衣</option>
						<option value="裤子" <%=duoyu.getAt("yt5").equals("裤子")? "selected":"" %>  >裤子</option>
						<option value="马甲"  <%=duoyu.getAt("yt5").equals("马甲")? "selected":"" %>  >马甲</option>
						<option value="衬衫"  <%=duoyu.getAt("yt5").equals("衬衫")? "selected":"" %>  >衬衫</option>
						<option value="西装套装" <%=duoyu.getAt("yt5").equals("西装套装")? "selected":"" %>  >西装套装</option>
						<option value="换片" <%=duoyu.getAt("yt5").equals("换片")? "selected":"" %>  >换片</option>
						<option value="其他" <%=duoyu.getAt("yt5").equals("其他")? "selected":"" %>  >其他</option>
						</select> 
				 <%}else{ %>
				 <td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml5" id="ml5"  value="<%=duoyu.getAt("ml5")%>" readonly="true"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yt5" id="yt5"  value="<%=duoyu.getAt("yt5")%>" readonly="true"
					
					type="text"  
					placeholder="" 
					 /></td>
 <%} %>		
				<%-- <input
					name="yt5" id="yt5"  value="<%=duoyu.getAt("yt5")%>"
					
					type="text"  
					placeholder="" 
					 /> --%></td>

				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">米数</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				 <input name="ms5" id="ms5"  value="<%=duoyu.getAt("ms5")%>"
				
				type="text"  
					 />
 <%}else{ %>
 <input name="ms5" id="ms5"  value="<%=duoyu.getAt("ms5")%>" readonly="true"
				
				type="text"  
					 />
 <%} %>
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				
 <%if("admin".equals(request.getAttribute("role")) || "跟单".equals(request.getAttribute("role")) ){ %>
					<%=request.getAttribute("gys5")%>
 <%}else{ %>
 <input
					name="gys5" id="gys5"  value="<%=duoyu.getAt("gys5")%>" readonly="true"
					type="text"  
					 />
 <%} %>
				<%--  --%></td>
				
					 <td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">价格</td>
					<td nowrap="nowrap" align="center" >
						 <%if("admin".equals(request.getAttribute("role")) || "跟单".equals(request.getAttribute("role")) ){ %>
					<input name="jg5"  id="jg5" type="text" class="txt_1" maxlength="100"  value=<%=duoyu.getAt("jq5")%>/>
					 <%}else{ %>
					 <input name="jg5"  id="jg5" type="text" class="txt_1" maxlength="100" value=<%=duoyu.getAt("jq5")%> readonly="true" />
					  <%} %>
					</td>
			</tr>
			 <%} %>
			
			
			 <%if(!"".equals(duoyu.getAt("ml6"))&& duoyu.getAt("ml6")!=null ){ %>
          
				
				 
					<tr>
					 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>

				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml6" id="ml6"  value="<%=duoyu.getAt("ml6")%>"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
					<select name="yt6" value="yt6">
						<option value="" <%=duoyu.getAt("yt6").equals("")? "selected":"" %> ></option>
						<option value="上衣" <%=duoyu.getAt("yt6").equals("上衣")? "selected":"" %> >上衣</option>
						<option value="裤子" <%=duoyu.getAt("yt6").equals("裤子")? "selected":"" %>  >裤子</option>
						<option value="马甲"  <%=duoyu.getAt("yt6").equals("马甲")? "selected":"" %>  >马甲</option>
						<option value="衬衫"  <%=duoyu.getAt("yt6").equals("衬衫")? "selected":"" %>  >衬衫</option>
						<option value="西装套装" <%=duoyu.getAt("yt6").equals("西装套装")? "selected":"" %>  >西装套装</option>
						<option value="换片" <%=duoyu.getAt("yt6").equals("换片")? "selected":"" %>  >换片</option>
						<option value="其他" <%=duoyu.getAt("yt6").equals("其他")? "selected":"" %>  >其他</option>
						</select> 
						
				<%-- <input
					name="yt6" id="yt6"  value="<%=duoyu.getAt("yt6")%>"
					
					type="text"  
					placeholder="" 
					 /> --%></td>
 <%}else{ %>
 <td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml6" id="ml6"  value="<%=duoyu.getAt("ml6")%>"  readonly="true"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yt6" id="yt6"  value="<%=duoyu.getAt("yt6")%>" readonly="true"
					
					type="text"  
					placeholder="" 
					 /></td>
 <%} %>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">米数</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>

				<input name="ms6" id="ms6"  value="<%=duoyu.getAt("ms6")%>"
				
				type="text"  
					 />
					 
					  <%}else{ %>
					  	<input name="ms6" id="ms6"  value="<%=duoyu.getAt("ms6")%>"
				
				type="text"   readonly="true"
					 />
 <%} %>
					 </td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "跟单".equals(request.getAttribute("role")) ){ %>
					<%=request.getAttribute("gys6")%>
 <%}else{ %>
 <input
					name="gys6" id="gys6"  value="<%=duoyu.getAt("gys6")%>" readonly="true"
					type="text"  
					 /> 
 <%} %>
				<%-- --%></td>
				
				 <td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">价格</td>
					<td nowrap="nowrap" align="center" >
						 <%if("admin".equals(request.getAttribute("role")) || "跟单".equals(request.getAttribute("role")) ){ %>
					<input name="jg6"  id="jg6" type="text" class="txt_1" maxlength="100"  value=<%=duoyu.getAt("jg6")%>/>
					 <%}else{ %>
					 <input name="jg6"  id="jg6" type="text" class="txt_1" maxlength="100" value=<%=duoyu.getAt("jg6")%> readonly="true" />
					  <%} %>
					</td>
			</tr>
			 <%} %>
			
			 <%if(!"".equals(duoyu.getAt("ml7"))&& duoyu.getAt("ml1")!=null ){ %>
          
				 
					<tr>
					 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>

				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml7" id="ml7"  value="<%=duoyu.getAt("ml7")%>"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<select name="yt7" value="yt7">
						<option value="" <%=duoyu.getAt("yt7").equals("")? "selected":"" %> ></option>
						<option value="上衣" <%=duoyu.getAt("yt7").equals("上衣")? "selected":"" %> >上衣</option>
						<option value="裤子" <%=duoyu.getAt("yt7").equals("裤子")? "selected":"" %>  >裤子</option>
						<option value="马甲"  <%=duoyu.getAt("yt7").equals("马甲")? "selected":"" %>  >马甲</option>
						<option value="衬衫"  <%=duoyu.getAt("yt7").equals("衬衫")? "selected":"" %>  >衬衫</option>
						<option value="西装套装" <%=duoyu.getAt("yt7").equals("西装套装")? "selected":"" %>  >西装套装</option>
						<option value="换片" <%=duoyu.getAt("yt7").equals("换片")? "selected":"" %>  >换片</option>
						<option value="其他" <%=duoyu.getAt("yt7").equals("其他")? "selected":"" %>  >其他</option>
						</select> 
						
				<%-- <input
					name="yt7" id="yt7"  value="<%=duoyu.getAt("yt7")%>"
					
					type="text"  
					placeholder="" 
					 /> --%></td>
 <%}else{ %>
 <td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml7" id="ml7"  value="<%=duoyu.getAt("ml7")%>" readonly="true"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yt7" id="yt7"  value="<%=duoyu.getAt("yt7")%>" readonly="true"
					
					type="text"  
					placeholder="" 
					 /></td>
 <%} %>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">米数</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				 <input name="ms7" id="ms7"  value="<%=duoyu.getAt("ms7")%>"
				
				type="text"  
					 />
 <%}else{ %>
 <input name="ms7" id="ms7"  value="<%=duoyu.getAt("ms7")%>" readonly="true"
				
				type="text"  
					 />
 <%} %>
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "跟单".equals(request.getAttribute("role")) ){ %>
					<%=request.getAttribute("gys7")%>
 <%}else{ %>
  <input
					name="gys7" id="gys7"  value="<%=duoyu.getAt("gys7")%>" readonly="true"
					type="text"  
					 />
 <%} %>
				<%-- --%></td>
				 <td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">价格</td>
					<td nowrap="nowrap" align="center" >
						 <%if("admin".equals(request.getAttribute("role")) || "跟单".equals(request.getAttribute("role")) ){ %>
					<input name="jg7"  id="jg7" type="text" class="txt_1" maxlength="100"  value=<%=duoyu.getAt("jq7")%>/>
					 <%}else{ %>
					 <input name="jg7"  id="jg7" type="text" class="txt_1" maxlength="100" value=<%=duoyu.getAt("jq7")%> readonly="true" />
					  <%} %>
					</td>
			</tr>
			 <%} %>
			
			
			 <%if(!"".equals(duoyu.getAt("ml8"))&& duoyu.getAt("ml8")!=null ){ %>
				<tr>
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>

				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml8" id="ml8"  value="<%=duoyu.getAt("ml8")%>"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
					<select name="yt8" value="yt8">
						<option value="" <%=duoyu.getAt("yt8").equals("")? "selected":"" %> ></option>
						<option value="上衣" <%=duoyu.getAt("yt8").equals("上衣")? "selected":"" %> >上衣</option>
						<option value="裤子" <%=duoyu.getAt("yt8").equals("裤子")? "selected":"" %>  >裤子</option>
						<option value="马甲"  <%=duoyu.getAt("yt8").equals("马甲")? "selected":"" %>  >马甲</option>
						<option value="衬衫"  <%=duoyu.getAt("yt8").equals("衬衫")? "selected":"" %>  >衬衫</option>
						<option value="西装套装" <%=duoyu.getAt("yt8").equals("西装套装")? "selected":"" %>  >西装套装</option>
						<option value="换片" <%=duoyu.getAt("yt8").equals("换片")? "selected":"" %>  >换片</option>
						<option value="其他" <%=duoyu.getAt("yt8").equals("其他")? "selected":"" %>  >其他</option>
						</select> 
						
			<%-- 	<input
					name="yt8" id="yt8"  value="<%=duoyu.getAt("yt8")%>"
					
					type="text"  
					placeholder="" 
					 /> --%></td>
					  <%}else{ %>
					  <td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml8" id="ml8"  value="<%=duoyu.getAt("ml8")%>" readonly="true"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yt8" id="yt8"  value="<%=duoyu.getAt("yt8")%>" readonly="true"
					
					type="text"  
					placeholder="" 
					 /></td>
 <%} %>

				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">米数</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>

				<input name="ms8" id="ms8"  value="<%=duoyu.getAt("ms8")%>"
				
				type="text"  
					 />
					 
					  <%}else{ %>
					  	<input name="ms8" id="ms8"  value="<%=duoyu.getAt("ms8")%>" readonly="true"
				
				type="text"  
					 />
 <%} %>
					 </td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "跟单".equals(request.getAttribute("role")) ){ %>
					<%=request.getAttribute("gys8")%>
 <%}else{ %>
  <input
					name="gys8" id="gys8"  value="<%=duoyu.getAt("gys8")%>" readonly="true"
					type="text"  
					 />
 <%} %>
				<%-- --%></td>
				 <td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">价格</td>
					<td nowrap="nowrap" align="center" >
						 <%if("admin".equals(request.getAttribute("role")) || "跟单".equals(request.getAttribute("role")) ){ %>
					<input name="jg8"  id="jg8" type="text" class="txt_1" maxlength="100"  value=<%=duoyu.getAt("jq8")%>/>
					 <%}else{ %>
					 <input name="jg8"  id="jg8" type="text" class="txt_1" maxlength="100" value=<%=duoyu.getAt("jq8")%> readonly="true" />
					  <%} %>
					</td>
			</tr>
			 <%} %>
			 
			  <%if(!"".equals(duoyu.getAt("ml9"))&& duoyu.getAt("ml9")!=null ){ %>
          
				
				 
				<tr>
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>

				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml9" id="ml9"  value="<%=duoyu.getAt("ml9")%>"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
					<select name="yt9" value="yt9">
						<option value="" <%=duoyu.getAt("yt9").equals("")? "selected":"" %> ></option>
						<option value="上衣" <%=duoyu.getAt("yt9").equals("上衣")? "selected":"" %> >上衣</option>
						<option value="裤子" <%=duoyu.getAt("yt9").equals("裤子")? "selected":"" %>  >裤子</option>
						<option value="马甲"  <%=duoyu.getAt("yt9").equals("马甲")? "selected":"" %>  >马甲</option>
						<option value="衬衫"  <%=duoyu.getAt("yt9").equals("衬衫")? "selected":"" %>  >衬衫</option>
						<option value="西装套装" <%=duoyu.getAt("yt9").equals("西装套装")? "selected":"" %>  >西装套装</option>
						<option value="换片" <%=duoyu.getAt("yt9").equals("换片")? "selected":"" %>  >换片</option>
						<option value="其他" <%=duoyu.getAt("yt9").equals("其他")? "selected":"" %>  >其他</option>
						</select> 
						
				<%-- <input
					name="yt9" id="yt9"  value="<%=duoyu.getAt("yt9")%>"
					
					type="text"  
					placeholder="" 
					 /> --%></td>
 <%}else{ %>
 		<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml9" id="ml9"  value="<%=duoyu.getAt("ml9")%>" readonly="true"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yt9" id="yt9"  value="<%=duoyu.getAt("yt9")%>" readonly="true"
					
					type="text"  
					placeholder="" 
					 /></td>
 <%} %>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">米数</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>

				<input name="ms9" id="ms9"  value="<%=duoyu.getAt("ms9")%>"
				
				type="text"  
					 />
					  <%}else{ %>
					  	<input name="ms9" id="ms9"  value="<%=duoyu.getAt("ms9")%>" readonly="true"
				
				type="text"  
					 />
 <%} %>
					 </td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "跟单".equals(request.getAttribute("role")) ){ %>
					<%=request.getAttribute("gys9")%>
 <%}else{ %>
  <input
					name="gys9" id="gys9"  value="<%=duoyu.getAt("gys9")%>"  readonly="true"
					type="text"  
					 /> 
 <%} %>
				<%----%></td>
				 <td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">价格</td>
					<td nowrap="nowrap" align="center" >
						 <%if("admin".equals(request.getAttribute("role")) || "跟单".equals(request.getAttribute("role")) ){ %>
					<input name="jg9"  id="jg9" type="text" class="txt_1" maxlength="100"  value=<%=duoyu.getAt("jq9")%>/>
					 <%}else{ %>
					 <input name="jg9"  id="jg9" type="text" class="txt_1" maxlength="100" value=<%=duoyu.getAt("jq9")%> readonly="true" />
					  <%} %>
					</td>
			</tr>
			 <%} %>
			
				 <%if(!"".equals(duoyu.getAt("ml10"))&& duoyu.getAt("ml10")!=null ){ %>
				
					<tr>
					 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>

				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml10" id="ml10"  value="<%=duoyu.getAt("ml10")%>"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<select name="yt10" value="yt10">
						<option value="" <%=duoyu.getAt("yt10").equals("")? "selected":"" %> ></option>
						<option value="上衣" <%=duoyu.getAt("yt10").equals("上衣")? "selected":"" %> >上衣</option>
						<option value="裤子" <%=duoyu.getAt("yt10").equals("裤子")? "selected":"" %>  >裤子</option>
						<option value="马甲"  <%=duoyu.getAt("yt10").equals("马甲")? "selected":"" %>  >马甲</option>
						<option value="衬衫"  <%=duoyu.getAt("yt10").equals("衬衫")? "selected":"" %>  >衬衫</option>
						<option value="西装套装" <%=duoyu.getAt("yt10").equals("西装套装")? "selected":"" %>  >西装套装</option>
						<option value="换片" <%=duoyu.getAt("yt10").equals("换片")? "selected":"" %>  >换片</option>
						<option value="其他" <%=duoyu.getAt("yt10").equals("其他")? "selected":"" %>  >其他</option>
						</select> 
						
			<%-- 	<input
					name="yt10" id="yt10"  value="<%=duoyu.getAt("yt10")%>"
					
					type="text"  
					placeholder="" 
					 /> --%></td>
 <%}else{ %>
 <td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml10" id="ml10"  value="<%=duoyu.getAt("ml10")%>" readonly="true"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yt10" id="yt10"  value="<%=duoyu.getAt("yt10")%>" readonly="true"
					
					type="text"  
					placeholder="" 
					 /></td>
 <%} %>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">米数</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
 
				<input name="ms10" id="ms10"  value="<%=duoyu.getAt("ms10")%>"
				
				type="text"  
					 />
					 
					 <%}else{ %>
					 	<input name="ms10" id="ms10"  value="<%=duoyu.getAt("ms10")%>"  readonly="true"
				
				type="text"  
					 />
 <%} %>
					 </td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "跟单".equals(request.getAttribute("role")) ){ %>
					<%=request.getAttribute("gys10")%>
 <%}else{ %>
 <input
					name="gys10" id="gys10"  value="<%=duoyu.getAt("gys10")%>"
					type="text"   readonly="true"
					 /> 
					 
					 
 <%} %>
				<%-- --%></td>
				 <td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">价格</td>
					<td nowrap="nowrap" align="center" >
						 <%if("admin".equals(request.getAttribute("role")) || "跟单".equals(request.getAttribute("role")) ){ %>
					<input name="jg10"  id="jg10" type="text" class="txt_1" maxlength="100"  value=<%=duoyu.getAt("jq10")%>/>
					 <%}else{ %>
					 <input name="jg10"  id="jg10" type="text" class="txt_1" maxlength="100" value=<%=duoyu.getAt("jq10")%> readonly="true" />
					  <%} %>
					</td>
			</tr>
			 <%} %>
			
			
			 <%if(!"".equals(duoyu.getAt("ml11"))&& duoyu.getAt("ml11")!=null ){ %>
          
				 
					<tr>
					 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>

				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml11" id="ml11"  value="<%=duoyu.getAt("ml11")%>"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				
				<select name="yt11" value="yt11">
						<option value="" <%=duoyu.getAt("yt11").equals("")? "selected":"" %> ></option>
						<option value="上衣" <%=duoyu.getAt("yt11").equals("上衣")? "selected":"" %> >上衣</option>
						<option value="裤子" <%=duoyu.getAt("yt11").equals("裤子")? "selected":"" %>  >裤子</option>
						<option value="马甲"  <%=duoyu.getAt("yt11").equals("马甲")? "selected":"" %>  >马甲</option>
						<option value="衬衫"  <%=duoyu.getAt("yt11").equals("衬衫")? "selected":"" %>  >衬衫</option>
						<option value="西装套装" <%=duoyu.getAt("yt11").equals("西装套装")? "selected":"" %>  >西装套装</option>
						<option value="换片" <%=duoyu.getAt("yt11").equals("换片")? "selected":"" %>  >换片</option>
						<option value="其他" <%=duoyu.getAt("yt11").equals("其他")? "selected":"" %>  >其他</option>
						</select> 
						
			<%-- 	<input
					name="yt11" id="yt11"  value="<%=duoyu.getAt("yt11")%>"
					
					type="text"  
					placeholder="" 
					 /> --%></td>
 <%}else{ %>
 	<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml11" id="ml11"  value="<%=duoyu.getAt("ml11")%>" readonly="true"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yt11" id="yt11"  value="<%=duoyu.getAt("yt11")%>" readonly="true"
					
					type="text"  
					placeholder="" 
					 /></td>
 <%} %>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">米数</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>

				<input name="ms11" id="ms11"  value="<%=duoyu.getAt("ms11")%>"
				
				type="text"  
					 />
					  <%}else{ %>
					  	<input name="ms11" id="ms11"  value="<%=duoyu.getAt("ms11")%>" readonly="true"
				
				type="text"  
					 />
 <%} %>
					 
					 </td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "跟单".equals(request.getAttribute("role")) ){ %>
					<%=request.getAttribute("gys11")%>
 <%}else{ %>
  <input
					name="gys11" id="gys11"  value="<%=duoyu.getAt("gys11")%>"
					type="text"   readonly="true"
					 /> 
 <%} %>
				<%----%></td>
				 <td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">价格</td>
					<td nowrap="nowrap" align="center" >
						 <%if("admin".equals(request.getAttribute("role")) || "跟单".equals(request.getAttribute("role")) ){ %>
					<input name="jg11"  id="jg11" type="text" class="txt_1" maxlength="100"  value=<%=duoyu.getAt("jq11")%>/>
					 <%}else{ %>
					 <input name="jg11"  id="jg11" type="text" class="txt_1" maxlength="100" value=<%=duoyu.getAt("jq11")%> readonly="true" />
					  <%} %>
					</td>
			</tr>
			 <%} %>
			 
			  <%if(!"".equals(duoyu.getAt("ml12"))&& duoyu.getAt("ml12")!=null ){ %>
          
				
				<tr>
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>

				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml12" id="ml12"  value="<%=duoyu.getAt("ml12")%>"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				
					<select name="yt12" value="yt12">
						<option value="" <%=duoyu.getAt("yt12").equals("")? "selected":"" %> ></option>
						<option value="上衣" <%=duoyu.getAt("yt12").equals("上衣")? "selected":"" %> >上衣</option>
						<option value="裤子" <%=duoyu.getAt("yt12").equals("裤子")? "selected":"" %>  >裤子</option>
						<option value="马甲"  <%=duoyu.getAt("yt12").equals("马甲")? "selected":"" %>  >马甲</option>
						<option value="衬衫"  <%=duoyu.getAt("yt12").equals("衬衫")? "selected":"" %>  >衬衫</option>
						<option value="西装套装" <%=duoyu.getAt("yt12").equals("西装套装")? "selected":"" %>  >西装套装</option>
						<option value="换片" <%=duoyu.getAt("yt12").equals("换片")? "selected":"" %>  >换片</option>
						<option value="其他" <%=duoyu.getAt("yt12").equals("其他")? "selected":"" %>  >其他</option>
						</select> 
						
			<%-- 	<input
					name="yt12" id="yt12"  value="<%=duoyu.getAt("yt12")%>"
					
					type="text"  
					placeholder="" 
					 /> --%></td>
 <%}else{ %>
 	<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml12" id="ml12"  value="<%=duoyu.getAt("ml12")%>" readonly="true"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yt12" id="yt12"  value="<%=duoyu.getAt("yt12")%>" readonly="true"
					
					type="text"  
					placeholder="" 
					 /></td>
 <%} %>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">米数</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				 	<input name="ms12" id="ms12"  value="<%=duoyu.getAt("ms12")%>"
				
				type="text"  
					 />
 <%}else{ %>
 	<input name="ms12" id="ms12"  value="<%=duoyu.getAt("ms12")%>"
				 readonly="true"
				type="text"  
					 />
 <%} %>
			
					 
					 </td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "跟单".equals(request.getAttribute("role")) ){ %>
					<%=request.getAttribute("gys12")%>
 <%}else{ %>
  <input
					name="gys12" id="gys12"  value="<%=duoyu.getAt("gys12")%>"
					type="text"   readonly="true"
					 /> 
 <%} %>
				<%----%></td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">价格</td>
					<td nowrap="nowrap" align="center" >
						 <%if("admin".equals(request.getAttribute("role")) || "跟单".equals(request.getAttribute("role")) ){ %>
					<input name="jg12"  id="jg12" type="text" class="txt_1" maxlength="100"  value=<%=duoyu.getAt("jq12")%>/>
					 <%}else{ %>
					 <input name="jg12"  id="jg12" type="text" class="txt_1" maxlength="100" value=<%=duoyu.getAt("jq12")%> readonly="true" />
					  <%} %>
					</td>
			</tr>
			 <%} %>
			 
			  <%if(!"".equals(duoyu.getAt("ml13"))&& duoyu.getAt("ml13")!=null ){ %>
          
				
				<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>

				<input name="ml13" id="ml13"  value="<%=duoyu.getAt("ml13")%>"
				
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
					<select name="yt13" value="yt13">
						<option value="" <%=duoyu.getAt("yt13").equals("")? "selected":"" %> ></option>
						<option value="上衣" <%=duoyu.getAt("yt13").equals("上衣")? "selected":"" %> >上衣</option>
						<option value="裤子" <%=duoyu.getAt("yt13").equals("裤子")? "selected":"" %>  >裤子</option>
						<option value="马甲"  <%=duoyu.getAt("yt13").equals("马甲")? "selected":"" %>  >马甲</option>
						<option value="衬衫"  <%=duoyu.getAt("yt13").equals("衬衫")? "selected":"" %>  >衬衫</option>
						<option value="西装套装" <%=duoyu.getAt("yt13").equals("西装套装")? "selected":"" %>  >西装套装</option>
						<option value="换片" <%=duoyu.getAt("yt13").equals("换片")? "selected":"" %>  >换片</option>
						<option value="其他" <%=duoyu.getAt("yt13").equals("其他")? "selected":"" %>  >其他</option>
						</select> 
						
			<%-- 	<input
					name="yt13" id="yt13"  value="<%=duoyu.getAt("yt13")%>"
					
					type="text"  
					placeholder="" 
					 /> --%></td>
 <%}else{ %>
 <td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="ml13" id="ml13"  value="<%=duoyu.getAt("ml13")%>"
				 readonly="true"
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yt13" id="yt13"  value="<%=duoyu.getAt("yt13")%>"
					 readonly="true"
					type="text"  
					placeholder="" 
					 /></td>
 <%} %>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">米数</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				 <input name="ms13" id="ms13"  value="<%=duoyu.getAt("ms13")%>"
				
				type="text"  
					 />
 <%}else{ %>
 <input name="ms13" id="ms13"  value="<%=duoyu.getAt("ms13")%>"
				readonly="true"
				type="text"  
					 />
 <%} %>
				
					 
					 </td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "跟单".equals(request.getAttribute("role")) ){ %>
					<%=request.getAttribute("gys13")%>
 <%}else{ %>
  <input
					name="gys13" id="gys13"  value="<%=duoyu.getAt("gys13")%>" readonly="true"
					type="text"  
					 />
 <%} %>
				<%-- --%></td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">价格</td>
					<td nowrap="nowrap" align="center" >
						 <%if("admin".equals(request.getAttribute("role")) || "跟单".equals(request.getAttribute("role")) ){ %>
					<input name="jg13"  id="jg13" type="text" class="txt_1" maxlength="100"  value=<%=duoyu.getAt("jq13")%>/>
					 <%}else{ %>
					 <input name="jg13"  id="jg13" type="text" class="txt_1" maxlength="100" value=<%=duoyu.getAt("jq13")%> readonly="true" />
					  <%} %>
					</td>
			</tr>
			 <%} %>
			  <%if(!"".equals(duoyu.getAt("ml14"))&& duoyu.getAt("ml14")!=null ){ %>
			<tr>
			 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>

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
 <%}else{ %>
 <td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >  
				<input name="ml14" id="ml14"  value="<%=duoyu.getAt("ml14")%>"
				readonly="true"
				 type="text" 
					 placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				

				<input
					name="yt14" id="yt14"  value="<%=duoyu.getAt("yt14")%>"
					readonly="true"
					type="text"  
					placeholder="" 
					 /></td>
 <%} %>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">米数</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>

				<input name="ms14" id="ms14"  value="<%=duoyu.getAt("ms14")%>"
				
				type="text"  
					 />
					 
					  <%}else{ %>
					  	<input name="ms14" id="ms14"  value="<%=duoyu.getAt("ms14")%>"
				readonly="true"
				type="text"  
					 />
 <%} %>
					 </td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				 <%if("admin".equals(request.getAttribute("role")) || "跟单".equals(request.getAttribute("role")) ){ %>
					<%=request.getAttribute("gys14")%>
 <%}else{ %>
 <input
					name="gys14" id="gys14"  value="<%=duoyu.getAt("gys14")%>"
					type="text"   readonly="true"
					 />
 <%} %>
			<%-- 	 --%></td>
			<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">价格</td>
					<td nowrap="nowrap" align="center" >
						 <%if("admin".equals(request.getAttribute("role")) || "跟单".equals(request.getAttribute("role")) ){ %>
					<input name="jg14"  id="jg14" type="text" class="txt_1" maxlength="100"  value=<%=duoyu.getAt("jq14")%>/>
					 <%}else{ %>
					 <input name="jg14"  id="jg14" type="text" class="txt_1" maxlength="100" value=<%=duoyu.getAt("jq14")%> readonly="true" />
					  <%} %>
					</td>
			</tr> <%} %>
		<%-- 	<tr>
				<td nowrap="nowrap" align="center" >面料</td>
				<td nowrap="nowrap" align="center" >
				<input style="border:none;" type="text"     name="miaoliao2" id="miaoliao2"   value="<%=projectInfo.getAt("miao_liao2")%>"  >
				</td>
				<td nowrap="nowrap" align="center" >用途</td>
				<td nowrap="nowrap" align="center" >
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
					<input style="border:none;" type="text"     name="yongtu2" id="yongtu2"   value="<%=projectInfo.getAt("yong_tu2")%>"  >
				</td>
				<td nowrap="nowrap" align="center" >米数</td>
				<td nowrap="nowrap" align="center" >
				<input style="border:none;" name="mi2"  type="text" class="txt_1" value="<%=projectInfo.getAt("mi2")%>" >
				</td>
				<td nowrap="nowrap" align="center" >供应商</td>
				<td nowrap="nowrap" align="center" >
					<%=request.getAttribute("companyList1")%>
				</td>
			</tr> --%>
			  <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "客服经理".equals(request.getAttribute("role")) ){ %>
<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">附件</td>
				<td nowrap="nowrap" align="center" >
				 <%if(!"".equals(projectInfo.getAt("fujian_url"))&& projectInfo.getAt("fujian_url")!=null ){ %>
                <a href="<%=projectInfo.getAt("fujian_url")%>" title="zip" style="color:#0000FF">【下载】</a>
				 <%}else{ %>
				 
				 	 <%} %>
				 	 
				<input  type="file" id="inputfile" name="inputfile"  	 />
					
					
				<!-- 	<input style="border:none;" type="file" name="file"  multiple="multiple"
					id="file"  class="imagePath" /> -->
					
					</td>
			</tr>
			    <%}else{ %>
			    <tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">附件</td>
				<td nowrap="nowrap" align="center" >
				 <%if(!"".equals(projectInfo.getAt("fujian_url"))&& projectInfo.getAt("fujian_url")!=null ){ %>
                <a href="<%=projectInfo.getAt("fujian_url")%>" title="zip" style="color:#0000FF">【下载】</a>
				 <%}else{ %>
				 
				 	 <%} %>
				 	 
			
					
					
				<!-- 	<input style="border:none;" type="file" name="file"  multiple="multiple"
					id="file"  class="imagePath" /> -->
					
					</td>
			</tr>
			     <%} %>
			    
			
			
			<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">客服备注</td>
				<td nowrap="nowrap" align="left"  colspan="7">
				 <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role")) || "经理".equals(request.getAttribute("role")) ){ %>
	<input style="border:none;" type="text"   size="160"  name="remark" id="remark"   value="<%=projectInfo.getAt("remark")%>"  >
 <%}else{ %>
	<input style="border:none;" type="text"   size="160"  name="remark" id="remark"   value="<%=projectInfo.getAt("remark")%>"  readonly="true" >
 <%} %>
</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">批单备注</td>
				<td nowrap="nowrap" align="left"  colspan="7">
				 <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) ){ %>
				<input style="border:none;" type="text"    size="160"  name="pidanremark" id="pidanremark"   value="<%=projectInfo.getAt("pidan_remark")%>" >
 <%}else{ %>
				<input style="border:none;" type="text"    size="160"  name="pidanremark" id="pidanremark" readonly="true"  value="<%=projectInfo.getAt("pidan_remark")%>" >
 <%} %>
					
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">跟单备注</td>
				<td nowrap="nowrap" align="left"  colspan="7">
				 <%if("admin".equals(request.getAttribute("role")) || "跟单".equals(request.getAttribute("role")) ){ %>
					<input style="border:none;" type="text"      size="160"  name="gdremark" id="gdremark"   value="<%=projectInfo.getAt("gd_remark")%>"  > 
 <%}else{ %>
					<input style="border:none;" type="text"  readonly="true"    size="160"  name="gdremark" id="gdremark"   value="<%=projectInfo.getAt("gd_remark")%>"  > 
 <%} %>
				</td>
			</tr>
				<%-- <tr>
				<td nowrap="nowrap" align="center" >提交类型</td>
				<td nowrap="nowrap" align="left"  colspan="7">
					保存 <input style="border:none;" name="tag" type="radio" class="radio_1" value="1" checked="checked" >
	    保存并提交<input style="border:none;" type="radio" name="tag" class="radio_1" value="2" >
	    
	     <%if("admin".equals(request.getAttribute("role")) || "批单".equals(request.getAttribute("role")) || "跟单".equals(request.getAttribute("role")) ){ %>
	     退回 <input style="border:none;" type="radio" name="tag" class="radio_1" value="3" >
			    <%} %>
	    		 --%>
	
	    
				<!-- </td>
			</tr> -->
			
			
			   
			  
			
  

		
			
			
              
				<tr>
			<td nowrap="nowrap" align="center" >
			<input style="border:none;" name="anniu"  id="anniu"
					 type="hidden" class="txt_1"  />
			</td>
					
					 
						<td nowrap="nowrap" align="right" >
						<input style="border:none;" type="button" title ="1"  name="ok" accesskey="y" tabindex="y"  value="保存" class="but_1 btn" onclick="onUpdate(this.title)">
						
						<input style="border:none;" type="button" title ="2"  name="ok" accesskey="y" tabindex="y"  value="保存并提交" class="but_1 btn" onclick="onUpdate(this.title)"  style="font-size:12;width:80px;height:21px;">
						</td>
							<td nowrap="nowrap" align="left"  colspan="6">
						 
			    
						
	
      <input style="border:none;" type="button" name="back" accesskey="b" tabindex="b" value="返 回" class="but_1 btn" onclick="location='doProjectInfo.do?method=queryProjectInfoXml'">
   <!--    <input style="border:none;" type="reset" name="back" accesskey="b" tabindex="b" value="重置" class="but_1" > -->
      
    <%if("批单".equals(request.getAttribute("role")) ){ %>
	<input style="border:none;" type="button"  title ="3" name="ok" accesskey="y" tabindex="y"  value="退回"  class="but_1 btn" onclick="onUpdate(this.title)" style="color: red">
			    <%} %>
			    
			      <%if("跟单".equals(request.getAttribute("role")) ){ %>
	<input style="border:none;" type="button"  title ="3" name="ok" accesskey="y" tabindex="y"  value="退回给批单"  class="but_1 btn" onclick="onUpdate(this.title)" style="color: red">
			 <input style="border:none;" type="button"  title ="4" name="ok" accesskey="y" tabindex="y"  value="退回给客服"  class="but_1 btn" onclick="onUpdate(this.title)" style="color: red">
			    <%} %>
				</td>
			</tr>	
			
		

</table>
</form>
</body>
</html>
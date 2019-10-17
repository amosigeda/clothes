<%@ page language="java" contentType="text/html;charset=gb2312"%>
<%@ page import="com.godoing.rose.http.common.*"%>
<%@ page import="com.godoing.rose.lang.*"%>
<%@ page import="com.care.common.lang.*"%>
<%@ page import="com.care.common.config.Config"%>
<%@ page import="com.care.app.LoginUser"%>
<%@ taglib uri="/WEB-INF/struts-bean" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic" prefix="logic"%>

<jsp:useBean id="msgInfo" scope="request"
	class="com.godoing.rose.lang.DataMap" />
<%@ page autoFlush="true"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="<%=request.getContextPath()%>/css/tbls.css" rel="stylesheet"
	type="text/css">
<script language="JavaScript"
	src="<%=request.getContextPath()%>/public/public.js"></script>
<script language="JavaScript"
	src="<%=request.getContextPath()%>/js/jquery-1.8.2.js"></script>
	<script language="JavaScript" src="<%=request.getContextPath()%>/public/My97DatePicker/WdatePicker.js"></script>
<title>无标题文档</title>
</head>
<style>
	.add_order_table tr th, .add_order_table tr td{border-bottom: 1px solid #bbb; border-left:1px solid #bbb; padding:10px;}
	.add_order_table tr th{border-left:0;}
	.add_order_table tr td:last-child{border-right:1px solid #bbb;}
/*	.add_order_table tr td:first-child{border-left: 0;}*/
/*	.add_order_table tr:last-child td{border-bottom:0;}*/
	.add_order_table input[type="text"], .add_order_table select{width: 100%; padding:5px; border:1px solid #ccc;} 
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
function onAdd(wechat){
	
	 document.getElementById("anniu").setAttribute("value", wechat);
	 
	
	frmGo.submit();
}

</script>
<body>
	<span class="title_1"></span>
	<form name="frmGo" method="post"
		action="doMsgInfo.do?method=updateMsgInfo"
		encType="multipart/form-data" onsubmit="return onAdd()">
		<input name="id" type="hidden" value="<%=msgInfo.getAt("id")%>">
		<input name="role" id="role" type="hidden"
			value="<%=request.getAttribute("role")%>">
		<table width="100%" id="tb1" class="tbl_11 add_order_table" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<th colspan="8" nowrap="nowrap" align="left">售后信息修改</th>
			</tr>

<!--
			<tr>
				<td colspan="8" nowrap="nowrap" align="center" >不一定制售后工单</td>
			</tr>
-->
			
			<tr>
				<td nowrap="nowrap" align="center"  colspan="1">下单号</td>
				<td nowrap="nowrap" align="left"  colspan="1">
				<input 
					name="orderNumber" id="orderNumber" type="text"  value="<%=msgInfo.getAt("order_id")%>"
					 maxlength="30"  >
					</td>
					<td nowrap="nowrap" align="center"  colspan="1">售后下单日期</td>
				<td nowrap="nowrap" align="center"  colspan="1">
				<input
					name="msg_handler_date" id="msg_handler_date"
					value="<%=msgInfo.getAt("msg_handler_date")%>" />
					</td>
					<td nowrap="nowrap" align="center"  colspan="1">交付日期</td>
				<td nowrap="nowrap" align="center"  colspan="3">
			<input
					name="jiaofutime" id="jiaofutime" type="text" maxlength="100" 
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"
					value="<%=msgInfo.getAt("jiaofutime")%>" />
					</td>
			
			
			</tr>
			
			
			<tr>
				<td nowrap="nowrap" align="center"  colspan="1">姓名</td>
				<td nowrap="nowrap" align="cneter"  colspan="1">
				<input
					name="name" id="name" type="text" class="txt_1" maxlength="20"
					value="<%=msgInfo.getAt("name")%>" />
					</td>
					<td nowrap="nowrap" align="center"  colspan="1">电话</td>
				<td nowrap="nowrap" align="center"  colspan="1">
				<input
					name="phone" id="phone" type="text" class="txt_1" maxlength="20" value="<%=msgInfo.getAt("phone")%>"
					/>
					</td>
					<td nowrap="nowrap" align="center"  colspan="1">修改物品</td>
				<td nowrap="nowrap" align="center"  colspan="3">
		<input type="checkbox" name="item1" value="上衣" <%=msgInfo.getAt("item1").equals("上衣")? "checked":"" %>><label>上衣</label>
		<input type="checkbox" name="item2" value="裤子" <%=msgInfo.getAt("item2").equals("裤子")? "checked":"" %>><label>裤子</label>
		<input type="checkbox" name="item3" value="马甲" <%=msgInfo.getAt("item3").equals("马甲")? "checked":"" %> ><label>马甲</label>
		<input type="checkbox" name="item4" value="衬衫" <%=msgInfo.getAt("item4").equals("衬衫")? "checked":"" %>  ><label>衬衫</label>
		<input type="checkbox" name="item5" value="大衣" <%=msgInfo.getAt("item5").equals("大衣")? "checked":"" %>  ><label>大衣</label>
					</td>
			</tr>
			
			
				<tr>
				<td nowrap="nowrap" align="center"  colspan="1">地址</td>
				<td nowrap="nowrap" align="left"  colspan="7"><input
					name="address" id="address" type="text"   value="<%=msgInfo.getAt("address")%>"
					class="txt_1" maxlength="30" />
					</td>
			</tr>


	<tr>
				<td nowrap="nowrap" align="center"  colspan="1">售后类型</td>
				<td nowrap="nowrap" align="left"  colspan="3">
				<select name="shouhou_type" value="shouhou_type">
					<option value="" <%=msgInfo.getAt("shouhou_type").equals("")? "selected":"" %>></option>
						<option value="退款" <%=msgInfo.getAt("shouhou_type").equals("退款")? "selected":"" %>>退款</option>
						<option value="退改" <%=msgInfo.getAt("shouhou_type").equals("退改")? "selected":"" %>>退改</option>
						
					
				</select> 
			
					</td>
					<td nowrap="nowrap" align="center"  colspan="1">售后次数</td>
				<td nowrap="nowrap" align="left"  colspan="3"><input
					name="cishu" id="cishu" type="text"   value="<%=msgInfo.getAt("cishu")%>"
					class="txt_1" maxlength="30" />
					</td>
				
			</tr>
			
				<tr class="td_bg_pink">
				<td nowrap="nowrap" align="center"  colspan="1">寄回物流单号</td>
				<td nowrap="nowrap" align="left"  colspan="3">
				<input
					name="jihui" id="jihui" type="text"   value="<%=msgInfo.getAt("jihui")%>"
					class="txt_1" maxlength="30" />
					</td>
					<td nowrap="nowrap" align="center"  colspan="1">发货物流单号</td>
				<td nowrap="nowrap" align="left"  colspan="3">
				<input
					name="fahuo" id="fahuo" type="text"   value="<%=msgInfo.getAt("fahuo")%>"
					class="txt_1" maxlength="30" />
					</td>
				
			</tr>
			
			
				<tr>
				<td nowrap="nowrap" align="center"  colspan="1">售后原因</td>
				<td nowrap="nowrap" align="left"  colspan="3">
				<select name="reson" value="reson">
					<option value="" <%=msgInfo.getAt("reson").equals("")? "selected":"" %>></option>
						<option value="下单下错" <%=msgInfo.getAt("reson").equals("下单下错")? "selected":"" %>>下单下错</option>
						<option value="尺寸量错" <%=msgInfo.getAt("reson").equals("尺寸量错")? "selected":"" %>>尺寸量错</option>
						<option value="码衣套错" <%=msgInfo.getAt("reson").equals("码衣套错")? "selected":"" %>>码衣套错</option>
						<option value="面料原因" <%=msgInfo.getAt("reson").equals("面料原因")? "selected":"" %>>面料原因</option>
						<option value="做错款式" <%=msgInfo.getAt("reson").equals("做错款式")? "selected":"" %>>做错款式</option>
						<option value="做错尺寸" <%=msgInfo.getAt("reson").equals("做错尺寸")? "selected":"" %>>做错尺寸</option>
						<option value="客服要求" <%=msgInfo.getAt("reson").equals("客服要求")? "selected":"" %>>客服要求</option>
					
				</select> 
				
					</td>
					<td nowrap="nowrap" align="center"  colspan="1">归责</td>
				<td nowrap="nowrap" align="left"  colspan="3">
				<input
					name="guize" id="guize" type="text"    value="<%=msgInfo.getAt("guize")%>"
					class="txt_1" maxlength="30" />
					</td>
			</tr>
			

			

			<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" ><input
					name="mianliao" id="mianliao" type="text" maxlength="100"
					placeholder="面料" value="<%=msgInfo.getAt("mianliao")%>" /></td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
					<!-- <input
					name="yongtu" id="yongtu" type="text" maxlength="100" /> -->

					<select name="yongtu" value="yongtu">
						<option value="上衣"
							<%=msgInfo.getAt("yongtu").equals("上衣")? "selected":"" %>>上衣</option>
						<option value="裤子"
							<%=msgInfo.getAt("yongtu").equals("裤子")? "selected":"" %>>裤子</option>
						<option value="马甲"
							<%=msgInfo.getAt("yongtu").equals("马甲")? "selected":"" %>>马甲</option>
						<option value="衬衫"
							<%=msgInfo.getAt("yongtu").equals("衬衫")? "selected":"" %>>衬衫</option>
						<option value="西装套装"
							<%=msgInfo.getAt("yongtu").equals("衬衫")? "selected":"" %>>西装套装</option>
						<option value="换片"
							<%=msgInfo.getAt("yongtu").equals("换片")? "selected":"" %>>换片</option>
						<option value="其他"
							<%=msgInfo.getAt("yongtu").equals("其他")? "selected":"" %>>其他</option>
				</select>
				</td>
				<td nowrap="nowrap" style="padding: 0;">
						<table width="100%" class="tbl_11" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">米数</td>
								<td nowrap="nowrap" align="center" style="border: 0;">
									<input name="mi" id="mi" type="text" maxlength="100" value="<%=msgInfo.getAt("mi")%>" />
								</td>
							</tr>
						</table>
					</td>
				<td nowrap="nowrap" style="padding: 0;">
						<table width="100%" class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">价格</td>
							<td nowrap="nowrap" align="center" style="border: 0;"><input name="jg" id="jg" type="text" maxlength="100" value="<%=msgInfo.getAt("jq")%>" /></td>
						</tr>
						</table>
				</td>
				
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
					<!-- <input
					name="gongyingshang" id="gongyingshang" type="text" maxlength="100" /> --> <%=request.getAttribute("companyList")%>
				</td>
	
			</tr>
		

		
 <%if(!"".equals(msgInfo.getAt("mianliao1"))&& msgInfo.getAt("mianliao1")!=null ){ %>
			<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="mianliao1" id="mianliao1"
				value="<%=msgInfo.getAt("mianliao1")%>"
				
				 type="text" maxlength="100" placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yongtu1" id="yongtu1" 
					value="<%=msgInfo.getAt("yongtu1")%>"
					
					type="text" maxlength="100"
					placeholder="" 
					 /></td>

				
				<td nowrap="nowrap" style="padding: 0;">
						<table width="100%" class="tbl_11" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">米数</td>
								<td nowrap="nowrap" align="center" style="border: 0;">
									<input name="mi1" id="mi1" value="<%=msgInfo.getAt("mi1")%>" type="text" maxlength="100"/>
								</td>
							</tr>
						</table>
					</td>
				<td nowrap="nowrap" style="padding: 0;">
						<table width="100%" class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">价格</td>
							<td nowrap="nowrap" align="center" style="border: 0;"><input name="jg1"
					id="jg1" type="text" maxlength="100"
					value="<%=msgInfo.getAt("jq1")%>" /></td>
						</tr>
						</table>
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="gys1" id="gys1" value="<%=msgInfo.getAt("gys1")%>"
					type="text" maxlength="100"
					 /></td>
					 
			</tr>
			 <%} %>
			 <%if(!"".equals(msgInfo.getAt("mianliao2"))&& msgInfo.getAt("mianliao2")!=null ){ %>
				<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="mianliao2" id="mianliao2"
				value="<%=msgInfo.getAt("mianliao2")%>"
				
				 type="text" maxlength="100" placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td> 
				<td nowrap="nowrap" align="center" >
				<input
					name="yongtu2" id="yongtu2" 
					value="<%=msgInfo.getAt("yongtu2")%>"
					
					type="text" maxlength="100"
					placeholder="" 
					 /></td>

				
				
				<td nowrap="nowrap" style="padding: 0;">
						<table width="100%" class="tbl_11" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">米数</td>
								<td nowrap="nowrap" align="center" style="border: 0;">
									<input name="mi2" id="mi2" 
				value="<%=msgInfo.getAt("mi2")%>"
				
				type="text" maxlength="100"
					 />
								</td>
							</tr>
						</table>
					</td>
				<td nowrap="nowrap" style="padding: 0;">
						<table width="100%" class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">价格</td>
							<td nowrap="nowrap" align="center" style="border: 0;"><input name="jg2"
					id="jg2" type="text" maxlength="100"
					value="<%=msgInfo.getAt("jq2")%>" /></td>
						</tr>
						</table>
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="gys2" id="gys2" value="<%=msgInfo.getAt("gys2")%>"
					type="text" maxlength="100"
					 /></td>
			</tr>
			 <%} %>
			 <%if(!"".equals(msgInfo.getAt("mianliao3"))&& msgInfo.getAt("mianliao3")!=null ){ %>
				<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="mianliao3" id="mianliao3"
				value="<%=msgInfo.getAt("mianliao3")%>"
				
				 type="text" maxlength="100" placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yongtu3" id="yongtu3" 
					value="<%=msgInfo.getAt("yongtu3")%>"
					
					type="text" maxlength="100"
					placeholder="" 
					 /></td>

					
				<td nowrap="nowrap" style="padding: 0;">
						<table width="100%" class="tbl_11" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">米数</td>
								<td nowrap="nowrap" align="center" style="border: 0;">
									<input name="mi3" id="mi3" 
				value="<%=msgInfo.getAt("mi3")%>"
				
				type="text" maxlength="100"
					 />
								</td>
							</tr>
						</table>
					</td>
				<td nowrap="nowrap" style="padding: 0;">
						<table width="100%" class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">价格</td>
							<td nowrap="nowrap" align="center" style="border: 0;"><input name="jg3"
					id="jg3" type="text" maxlength="100"
					value="<%=msgInfo.getAt("jq3")%>" /></td>
						</tr>
						</table>
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="gys3" id="gys3" value="<%=msgInfo.getAt("gys3")%>"
					type="text" maxlength="100"
					 /></td>
			</tr>
			 <%} %>
			 <%if(!"".equals(msgInfo.getAt("mianliao4"))&& msgInfo.getAt("mianliao4")!=null ){ %>
				<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="mianliao4" id="mianliao4"
				value="<%=msgInfo.getAt("mianliao4")%>"
				
				 type="text" maxlength="100" placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yongtu4" id="yongtu4" 
					value="<%=msgInfo.getAt("yongtu4")%>"
					
					type="text" maxlength="100"
					placeholder="" 
					 /></td>

				<td nowrap="nowrap" style="padding: 0;">
						<table width="100%" class="tbl_11" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">米数</td>
								<td nowrap="nowrap" align="center" style="border: 0;">
									<input name="mi4" id="mi4" 
				value="<%=msgInfo.getAt("mi4")%>"
				
				type="text" maxlength="100"
					 />
								</td>
							</tr>
						</table>
					</td>
				<td nowrap="nowrap" style="padding: 0;">
						<table width="100%" class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">价格</td>
							<td nowrap="nowrap" align="center" style="border: 0;"><input name="jg4"
					id="jg4" type="text" maxlength="100"
					value="<%=msgInfo.getAt("jq4")%>" /></td>
						</tr>
						</table>
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="gys4" id="gys4" value="<%=msgInfo.getAt("gys4")%>"
					type="text" maxlength="100"
					 /></td>
			</tr>
			 <%} %>
			 <%if(!"".equals(msgInfo.getAt("mianliao5"))&& msgInfo.getAt("mianliao5")!=null ){ %>
			<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="mianliao5" id="mianliao5"
				value="<%=msgInfo.getAt("mianliao5")%>"
				
				 type="text" maxlength="100" placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yongtu5" id="yongtu5" 
					value="<%=msgInfo.getAt("yongtu5")%>"
					
					type="text" maxlength="100"
					placeholder="" 
					 /></td>

				<td nowrap="nowrap" style="padding: 0;">
						<table width="100%" class="tbl_11" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">米数</td>
								<td nowrap="nowrap" align="center" style="border: 0;">
									<input name="mi5" id="mi5" 
				value="<%=msgInfo.getAt("mi5")%>"
				
				type="text" maxlength="100"
					 />
								</td>
							</tr>
						</table>
					</td>
				<td nowrap="nowrap" style="padding: 0;">
						<table width="100%" class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">价格</td>
							<td nowrap="nowrap" align="center" style="border: 0;"><input name="jg5"
					id="jg5" type="text" maxlength="100"
					value="<%=msgInfo.getAt("jq5")%>" /></td>
						</tr>
						</table>
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="gys5" id="gys5" value="<%=msgInfo.getAt("gys5")%>"
					type="text" maxlength="100"
					 /></td>
			</tr>
			 <%} %>
			 <%if(!"".equals(msgInfo.getAt("mianliao6"))&& msgInfo.getAt("mianliao6")!=null ){ %>
				<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="mianliao6" id="mianliao6" value="<%=msgInfo.getAt("mianliao6")%>"
				
				 type="text" maxlength="100" placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yongtu6" id="yongtu6"  value="<%=msgInfo.getAt("yongtu6")%>"
					
					type="text" maxlength="100"
					placeholder="" 
					 /></td>

				<td nowrap="nowrap" style="padding: 0;">
						<table width="100%" class="tbl_11" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">米数</td>
								<td nowrap="nowrap" align="center" style="border: 0;">
									<input name="mi6" id="mi6" 
				value="<%=msgInfo.getAt("mi6")%>"
				
				type="text" maxlength="100"
					 />
								</td>
							</tr>
						</table>
					</td>
				<td nowrap="nowrap" style="padding: 0;">
						<table width="100%" class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">价格</td>
							<td nowrap="nowrap" align="center" style="border: 0;"><input name="jg6"
					id="jg6" type="text" maxlength="100"
					value="<%=msgInfo.getAt("jq6")%>" /></td>
						</tr>
						</table>
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="gys6" id="gys6" value="<%=msgInfo.getAt("gys6")%>"
					type="text" maxlength="100"
					 /></td>
			</tr>
			 <%} %>
			 <%if(!"".equals(msgInfo.getAt("mianliao7"))&& msgInfo.getAt("mianliao7")!=null ){ %>
				<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="mianliao7" id="mianliao7" value="<%=msgInfo.getAt("mianliao7")%>"
				
				 type="text" maxlength="100" placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yongtu7" id="yongtu7"  value="<%=msgInfo.getAt("yongtu7")%>"
					
					type="text" maxlength="100"
					placeholder="" 
					 /></td>

				<td nowrap="nowrap" style="padding: 0;">
						<table width="100%" class="tbl_11" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">米数</td>
								<td nowrap="nowrap" align="center" style="border: 0;">
									<input name="mi7" id="mi7" 
				value="<%=msgInfo.getAt("mi7")%>"
				
				type="text" maxlength="100"
					 />
								</td>
							</tr>
						</table>
					</td>
				<td nowrap="nowrap" style="padding: 0;">
						<table width="100%" class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">价格</td>
							<td nowrap="nowrap" align="center" style="border: 0;"><input name="jg7"
					id="jg7" type="text" maxlength="100"
					value="<%=msgInfo.getAt("jq7")%>" /></td>
						</tr>
						</table>
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="gys7" id="gys7" value="<%=msgInfo.getAt("gys7")%>"
					type="text" maxlength="100"
					 /></td>
			</tr>
			 <%} %>
				 <%if(!"".equals(msgInfo.getAt("mianliao8"))&& msgInfo.getAt("mianliao8")!=null ){ %>
			<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="mianliao8" id="mianliao8" value="<%=msgInfo.getAt("mianliao8")%>"
				
				 type="text" maxlength="100" placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yongtu8" id="yongtu8"  value="<%=msgInfo.getAt("yongtu8")%>"
					
					type="text" maxlength="100"
					placeholder="" 
					 /></td>

				<td nowrap="nowrap" style="padding: 0;">
						<table width="100%" class="tbl_11" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">米数</td>
								<td nowrap="nowrap" align="center" style="border: 0;">
									<input name="mi8" id="mi8" 
				value="<%=msgInfo.getAt("mi8")%>"
				
				type="text" maxlength="100"
					 />
								</td>
							</tr>
						</table>
					</td>
				<td nowrap="nowrap" style="padding: 0;">
						<table width="100%" class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">价格</td>
							<td nowrap="nowrap" align="center" style="border: 0;"><input name="jg8"
					id="jg8" type="text" maxlength="100"
					value="<%=msgInfo.getAt("jq8")%>" /></td>
						</tr>
						</table>
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="gys8" id="gys8" value="<%=msgInfo.getAt("gys8")%>"
					type="text" maxlength="100"
					 /></td>
			</tr>
			 <%} %>
				 <%if(!"".equals(msgInfo.getAt("mianliao9"))&& msgInfo.getAt("mianliao9")!=null ){ %>
			<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="mianliao9" id="mianliao9" value="<%=msgInfo.getAt("mianliao9")%>"
				
				 type="text" maxlength="100" placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yongtu9" id="yongtu9"  value="<%=msgInfo.getAt("yongtu9")%>"
					
					type="text" maxlength="100"
					placeholder="" 
					 /></td>

				<td nowrap="nowrap" style="padding: 0;">
						<table width="100%" class="tbl_11" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">米数</td>
								<td nowrap="nowrap" align="center" style="border: 0;">
									<input name="mi9" id="mi9" 
				value="<%=msgInfo.getAt("mi9")%>"
				
				type="text" maxlength="100"
					 />
								</td>
							</tr>
						</table>
					</td>
				<td nowrap="nowrap" style="padding: 0;">
						<table width="100%" class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">价格</td>
							<td nowrap="nowrap" align="center" style="border: 0;"><input name="jg9"
					id="jg9" type="text" maxlength="100"
					value="<%=msgInfo.getAt("jq9")%>" /></td>
						</tr>
						</table>
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="gys9" id="gys9" value="<%=msgInfo.getAt("gys9")%>"
					type="text" maxlength="100"
					 /></td>
			</tr>
			 <%} %>
				 <%if(!"".equals(msgInfo.getAt("mianliao10"))&& msgInfo.getAt("mianliao10")!=null ){ %>
			
			<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="mianliao10" id="mianliao10" value="<%=msgInfo.getAt("mianliao10")%>"
				
				 type="text" maxlength="100" placeholder=""
					 />
					</td>
					
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yongtu10" id="yongtu10"  value="<%=msgInfo.getAt("yongtu10")%>"
					
					type="text" maxlength="100"
					placeholder="" 
					 /></td>

				<td nowrap="nowrap" style="padding: 0;">
						<table width="100%" class="tbl_11" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">米数</td>
								<td nowrap="nowrap" align="center" style="border: 0;">
									<input name="mi10" id="mi10" 
				value="<%=msgInfo.getAt("mi10")%>"
				
				type="text" maxlength="100"
					 />
								</td>
							</tr>
						</table>
					</td>
				<td nowrap="nowrap" style="padding: 0;">
						<table width="100%" class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">价格</td>
							<td nowrap="nowrap" align="center" style="border: 0;"><input name="jg10"
					id="jg10" type="text" maxlength="100"
					value="<%=msgInfo.getAt("jq10")%>" /></td>
						</tr>
						</table>
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="gys10" id="gys10" value="<%=msgInfo.getAt("gys10")%>"
					type="text" maxlength="100"
					 /></td>
			</tr>
			 <%} %>
				 <%if(!"".equals(msgInfo.getAt("mianliao11"))&& msgInfo.getAt("mianliao11")!=null ){ %>
			<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="mianliao11" id="mianliao11" value="<%=msgInfo.getAt("mianliao11")%>"
				
				 type="text" maxlength="100" placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yongtu11" id="yongtu11"  value="<%=msgInfo.getAt("yongtu11")%>"
					
					type="text" maxlength="100"
					placeholder="" 
					 /></td>

				<td nowrap="nowrap" style="padding: 0;">
						<table width="100%" class="tbl_11" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">米数</td>
								<td nowrap="nowrap" align="center" style="border: 0;">
									<input name="mi11" id="mi11" 
				value="<%=msgInfo.getAt("mi11")%>"
				
				type="text" maxlength="100"
					 />
								</td>
							</tr>
						</table>
					</td>
				<td nowrap="nowrap" style="padding: 0;">
						<table width="100%" class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">价格</td>
							<td nowrap="nowrap" align="center" style="border: 0;"><input name="jg11"
					id="jg11" type="text" maxlength="100"
					value="<%=msgInfo.getAt("jq11")%>" /></td>
						</tr>
						</table>
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="gys11" id="gys11" value="<%=msgInfo.getAt("gys11")%>"
					type="text" maxlength="100"
					 /></td>
			</tr>
				 <%} %>
				 <%if(!"".equals(msgInfo.getAt("mianliao12"))&& msgInfo.getAt("mianliao12")!=null ){ %>
			<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="mianliao12" id="mianliao12" value="<%=msgInfo.getAt("mianliao12")%>"
				
				 type="text" maxlength="100" placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yongtu12" id="yongtu12"  value="<%=msgInfo.getAt("yongtu12")%>"
					
					type="text" maxlength="100"
					placeholder="" 
					 /></td>

				<td nowrap="nowrap" style="padding: 0;">
						<table width="100%" class="tbl_11" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">米数</td>
								<td nowrap="nowrap" align="center" style="border: 0;">
									<input name="mi12" id="mi12" 
				value="<%=msgInfo.getAt("mi12")%>"
				
				type="text" maxlength="100"
					 />
								</td>
							</tr>
						</table>
					</td>
				<td nowrap="nowrap" style="padding: 0;">
						<table width="100%" class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">价格</td>
							<td nowrap="nowrap" align="center" style="border: 0;"><input name="jg12"
					id="jg12" type="text" maxlength="100"
					value="<%=msgInfo.getAt("jq12")%>" /></td>
						</tr>
						</table>
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="gys12" id="gys12" value="<%=msgInfo.getAt("gys12")%>"
					type="text" maxlength="100"
					 /></td>
			</tr>
			
			 <%} %>
				 <%if(!"".equals(msgInfo.getAt("mianliao13"))&& msgInfo.getAt("mianliao13")!=null ){ %>
				<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="mianliao13" id="mianliao13" value="<%=msgInfo.getAt("mianliao13")%>"
				
				 type="text" maxlength="100" placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yongtu13" id="yongtu13"  value="<%=msgInfo.getAt("yongtu13")%>"
					
					type="text" maxlength="100"
					placeholder="" 
					 /></td>

				<td nowrap="nowrap" style="padding: 0;">
						<table width="100%" class="tbl_11" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">米数</td>
								<td nowrap="nowrap" align="center" style="border: 0;">
									<input name="mi13" id="mi13" 
				value="<%=msgInfo.getAt("mi13")%>"
				
				type="text" maxlength="100"
					 />
								</td>
							</tr>
						</table>
					</td>
				<td nowrap="nowrap" style="padding: 0;">
						<table width="100%" class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">价格</td>
							<td nowrap="nowrap" align="center" style="border: 0;"><input name="jg13"
					id="jg13" type="text" maxlength="100"
					value="<%=msgInfo.getAt("jq13")%>" /></td>
						</tr>
						</table>
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="gys13" id="gys13" value="<%=msgInfo.getAt("gys13")%>"
					type="text" maxlength="100"
					 /></td>
			</tr>
			
			 <%} %>
				 <%if(!"".equals(msgInfo.getAt("mianliao14"))&& msgInfo.getAt("mianliao14")!=null ){ %>
				<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="mianliao14" id="mianliao14" value="<%=msgInfo.getAt("mianliao14")%>"
				
				 type="text" maxlength="100" placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="yongtu14" id="yongtu14"  value="<%=msgInfo.getAt("yongtu14")%>"
					
					type="text" maxlength="100"
					placeholder="" 
					 /></td>

				<td nowrap="nowrap" style="padding: 0;">
						<table width="100%" class="tbl_11" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">米数</td>
								<td nowrap="nowrap" align="center" style="border: 0;">
									<input name="mi14" id="mi14" 
				value="<%=msgInfo.getAt("mi14")%>"
				
				type="text" maxlength="100"
					 />
								</td>
							</tr>
						</table>
					</td>
				<td nowrap="nowrap" style="padding: 0;">
						<table width="100%" class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">价格</td>
							<td nowrap="nowrap" align="center" style="border: 0;"><input name="jg14"
					id="jg14" type="text" maxlength="100"
					value="<%=msgInfo.getAt("jq14")%>" /></td>
						</tr>
						</table>
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
				<td nowrap="nowrap" align="center" >
				<input
					name="gys14" id="gys14" value="<%=msgInfo.getAt("gys14")%>"
					type="text" maxlength="100"
					 /></td>
			</tr>
				 <%} %>
				
				 
				<tr>
				<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">售后内容</td>
				<td nowrap="nowrap" align="left"  colspan="7"><input
					name="remark" id="remark" type="text" maxlength="100"
					value="<%=msgInfo.getAt("remark")%>" /></td>
			</tr>
				<td nowrap="nowrap" align="center" ><input
					style="border:none;" name="anniu" id="anniu"
					type="hidden" class="txt_1" /></td>
				<td nowrap="nowrap" align="left" colspan="7" > <input
					type="button" name="back" accesskey="b" tabindex="b" value="返 回"
					class="but_1 btn" onclick="location='doMsgInfo.do?method=queryMsgInfo'"></td>
			</tr>
			
		</table>
	</form>
</body>
</html>
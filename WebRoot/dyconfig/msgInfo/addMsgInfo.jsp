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
<title>无标题文档</title>
</head>

<script type="text/javascript">

$(document).ready(function(){
	 $("#orderNumber").blur(function(){
		 var userCodeValue = $("#orderNumber").val().trim();
		 $.ajax({
			 type:"post",
			 url:"doMsgInfo.do?method=verfyDingDan",
		 	 data:"userCode="+userCodeValue,
		 	 success:function(msg){
		 		alert(msg);
		 	/* 	if(msg=="fail"){
		 			 alert("不存在该订单号");
		 		 } 
		 		 if(msg=="fail"){
		 			 $("#orderNumber").focus();
		 			 return false;
		 		 }  */
		 		 
		 		/*  if(msg=="fail"){
		 			 alert("不存在该订单号");
		 			 $("#orderNumber").focus();
		 			 return false;
		 		 } */
		 	 }
		 });
	 });
});

function onAdd(){
	if(frmGo.orderNumber.value.trim() == ""){
		alert("订单号不能为空！");
		frmGo.orderNumber.focus();
		return false;
	} 
	
	frmGo.submit();
}

</script>
<body>
	<form name="frmGo" method="post"
		action="doMsgInfo.do?method=insertMsgInfo" onsubmit="return onAdd()">
		<table width="100%" id="tb1" class="tbl_11" border="1"
			bordercolorlight=#000000 bordercolordark=#000000 bordercolor=#000000
			cellspacing="0" cellpadding="2">
			
<tr>
				<th colspan="7" nowrap="nowrap" align="left">添加售后</th>
			</tr>

			<tr>
				<td colspan="7" nowrap="nowrap" align="center" width="7%">不一定制售后工单</td>
			</tr>

			<tr>
				<td nowrap="nowrap" align="center" width="7%" colspan="2">下单单号</td>
				<td nowrap="nowrap" align="center" width="7%" colspan="2"><input
					name="orderNumber" size="38" id="orderNumber" type="text"
					class="txt_1" maxlength="30" /></td>
				<td nowrap="nowrap" align="center" width="7%">下单人</td>
				<td nowrap="nowrap" align="center" width="7%" colspan="2"><%=request.getAttribute("username")%></td>
			</tr>

			<tr>
				<td nowrap="nowrap" align="center" width="7%" colspan="2">姓名</td>
				<td nowrap="nowrap" align="center" width="7%" colspan="2"><input
					name="name" id="name" type="text" class="txt_1" maxlength="20"
					size="38" /></td>
				<td nowrap="nowrap" align="center" width="7%">售后次数</td>
				<td nowrap="nowrap" align="center" width="7%" colspan="2"><input
					name="cishu" id="cishu" type="number" /></td>
			</tr>

			<tr>
				<td nowrap="nowrap" align="center" width="7%" colspan="2">下单时间</td>
				<td nowrap="nowrap" align="center" width="7%"><%=request.getAttribute("shijian")%></td>
				<td nowrap="nowrap" align="center" width="7%">交付日期</td>
				<td nowrap="nowrap" align="center" width="7%" colspan="3"><input
					name="jiaofutime" id="jiaofutime" type="text" size="38"
					maxlength="100" /></td>
			</tr>

			<tr>
				<td nowrap="nowrap" align="center" width="7%">面料</td>
				<td nowrap="nowrap" align="center" width="7%">用途</td>
				<td nowrap="nowrap" align="center" width="7%"><!-- <input
					name="yongtu" id="yongtu" type="text" size="38" maxlength="100" /> -->
					
					<select name="yongtu" value="yongtu">
						<option value="上衣">上衣</option>
						<option value="裤子">裤子</option>
						<option value="马甲">马甲</option>
						<option value="衬衫">衬衫</option>
						<option value="西装套装">西装套装</option>
						<option value="换片">换片</option>
						<option value="其他">其他</option>
				</select> 
					</td>
				<td nowrap="nowrap" align="center" width="7%">米数</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="mi"
					id="mi" type="text" size="38" maxlength="100" /></td>
				<td nowrap="nowrap" align="center" width="7%">供应商</td>
				<td nowrap="nowrap" align="center" width="7%"><!-- <input
					name="gongyingshang" id="gongyingshang" type="text" size="38"
					maxlength="100" /> -->
						<%=request.getAttribute("companyList")%>
					</td>
			</tr>

			<tr>
				<td nowrap="nowrap" align="center" width="7%" colspan="3"><input
					name="mianliao" id="mianliao" type="text" size="38" maxlength="100"
					placeholder="面料" /></td>
				<td nowrap="nowrap" align="center" width="7%" colspan="4"><input
					name="guize" id="guize" type="text" size="38" maxlength="100"
					placeholder="归责：客户要求（手填，创建时）" /></td>
			</tr>

			<tr>
				<td nowrap="nowrap" align="center" width="7%">备注</td>
				<td nowrap="nowrap" align="center" width="7%" colspan="6"><input
					name="remark" id="remark" type="text" size="200" maxlength="100" />
				</td>
			</tr>

			<tr>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"><input
					type="button" name="ok" accesskey="y" tabindex="y" value="确 定"
					class="but_1" onclick="onAdd()"
					style="font-size:12;width:40px;height:21px;"> <input
					type="reset" name="reset" accesskey="y" tabindex="y" value="重置"
					class="but_1" style="font-size:12;width:40px;height:21px;">
					<input type="button" name="back" accesskey="b" tabindex="b"
					value="返 回" class="but_1"
					onclick="location='doMsgInfo.do?method=queryMsgInfo'"
					style="font-size:12;width:40px;height:21px;"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
		</table>
	</form>
</body>
</html>
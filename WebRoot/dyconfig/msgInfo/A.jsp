<%@ page language="java" contentType="text/html;charset=gb2312"%>
<%@ page import = "com.godoing.rose.http.common.*" %>
<%@ page import = "com.godoing.rose.lang.*" %>
<%@ page import="com.care.common.lang.*"%>
<%@ page import="com.care.common.config.Config"%>
<%@ page import="com.care.app.LoginUser"%>
<%@ taglib uri="/WEB-INF/struts-bean" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic" prefix="logic"%>

<jsp:useBean id = "msgInfo" scope = "request" class = "com.godoing.rose.lang.DataMap"/>
<%@ page autoFlush="true" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="<%=request.getContextPath()%>/css/tbls.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="<%=request.getContextPath()%>/public/public.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/jquery-1.8.2.js"></script>
<title>�ޱ����ĵ�</title>
</head>
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
				alert("��Ŀ���Ѿ�����,���������룡");
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
<form name="frmGo" method="post" action="doMsgInfo.do?method=updateMsgInfo" encType="multipart/form-data" onsubmit="return onAdd()">
<input name="id" type="hidden" value="<%=msgInfo.getAt("id")%>" >
<input name="role"  id="role"   type="hidden" value="<%=request.getAttribute("role")%>" >
<table width="100%" id="tb1" class="tbl_11" border="1"
			bordercolorlight=#000000 bordercolordark=#000000 bordercolor=#000000
			cellspacing="0" cellpadding="2">
  <tr>
				<th colspan="8" nowrap="nowrap" align="left">�ۺ���Ϣ�޸�</th>
			</tr>

			<tr>
				<td colspan="8" nowrap="nowrap" align="center" width="7%">��һ�����ۺ󹤵�</td>
			</tr>

			<tr>
				<td nowrap="nowrap" align="center" width="7%" colspan="2">�µ�����</td>
				<td nowrap="nowrap" align="center" width="7%" colspan="2"><input
					name="orderNumber" size="38" id="orderNumber" type="text"
					class="txt_1" maxlength="30"   value="<%=msgInfo.getAt("order_id")%>" readonly="true" /></td>
				<td nowrap="nowrap" align="center" width="7%">�µ���</td>
				<td nowrap="nowrap" align="center" width="7%" colspan="2">
				<input
					name="add_user" id="add_user" type="text" class="txt_1" maxlength="20"
					size="38"  value="<%=msgInfo.getAt("add_user")%>"/>
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>

			<tr>
				<td nowrap="nowrap" align="center" width="7%" colspan="2">����</td>
				<td nowrap="nowrap" align="center" width="7%" colspan="2"><input
					name="name" id="name" type="text" class="txt_1" maxlength="20"
					size="38"  value="<%=msgInfo.getAt("name")%>" /></td>
				<td nowrap="nowrap" align="center" width="7%">�ۺ����</td>
				<td nowrap="nowrap" align="center" width="7%" colspan="2"><input
					name="cishu" id="cishu" type="number"  value="<%=msgInfo.getAt("cishu")%>" /></td>
						<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>

			<tr>
				<td nowrap="nowrap" align="center" width="7%" colspan="2">�µ�ʱ��</td>
				<td nowrap="nowrap" align="center" width="7%"><input
					name="msg_handler_date" id="msg_handler_date"   value="<%=msgInfo.getAt("msg_handler_date")%>" /></td>
				<td nowrap="nowrap" align="center" width="7%">��������</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="3"><input
					name="jiaofutime" id="jiaofutime" type="text" size="38"
					maxlength="100"  value="<%=msgInfo.getAt("jiaofutime")%>" /></td>
						<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>

			<tr>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%"><input
					name="mianliao" id="mianliao" type="text" size="38" maxlength="100"
					placeholder="����"  value="<%=msgInfo.getAt("mianliao")%>"  /></td>
				<td nowrap="nowrap" align="center" width="7%">��;</td>
				<td nowrap="nowrap" align="center" width="7%">
					<!-- <input
					name="yongtu" id="yongtu" type="text" size="38" maxlength="100" /> -->

					<select name="yongtu" value="yongtu">
						<option value="����" <%=msgInfo.getAt("yongtu").equals("����")? "selected":"" %> >����</option>
						<option value="����" <%=msgInfo.getAt("yongtu").equals("����")? "selected":"" %>  >����</option>
						<option value="����" <%=msgInfo.getAt("yongtu").equals("����")? "selected":"" %>   >����</option>
						<option value="����" <%=msgInfo.getAt("yongtu").equals("����")? "selected":"" %>  >����</option>
						<option value="��װ��װ" <%=msgInfo.getAt("yongtu").equals("����")? "selected":"" %>   >��װ��װ</option>
						<option value="��Ƭ" <%=msgInfo.getAt("yongtu").equals("��Ƭ")? "selected":"" %>    >��Ƭ</option>
						<option value="����" <%=msgInfo.getAt("yongtu").equals("����")? "selected":"" %>     >����</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="mi"
					id="mi" type="text" size="38" maxlength="100"  value="<%=msgInfo.getAt("mi")%>"  /></td>
				<td nowrap="nowrap" align="center" width="7%">��Ӧ��</td>
				<td nowrap="nowrap" align="center" width="7%">
					<!-- <input
					name="gongyingshang" id="gongyingshang" type="text" size="38"
					maxlength="100" /> --> <%=request.getAttribute("companyList")%>
				</td>
				
			</tr>
			<!-- 
			<tr>
				<td nowrap="nowrap" align="center" width="7%" colspan="3"></td>
				<td nowrap="nowrap" align="center" width="7%" colspan="4"><input
					name="guize" id="guize" type="text" size="38" maxlength="100"
					placeholder="���𣺿ͻ�Ҫ���������ʱ��" /></td>
			</tr> -->

			<tr>
				<td nowrap="nowrap" align="center" width="7%">��ע</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="7"><input
					name="remark" id="remark" type="text" size="200" maxlength="100"  value="<%=msgInfo.getAt("remark")%>" />
				</td>
			</tr>
			
			<!-- <tr>
				<td nowrap="nowrap" align="center" width="7%">������ע</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="7"><input
					name="pidanremark" id="pidanremark" type="text" size="200" maxlength="100" />
				</td>
			</tr> -->

			<tr>
				<td nowrap="nowrap" align="center" width="7%">
					<input style="border:none;" name="anniu" size="200" id="anniu"
					 type="hidden" class="txt_1"  />
				</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input
					type="button" name="ok" accesskey="y" tabindex="y" value="����" title ="1" 
					class="but_1" onclick="onAdd(this.title)" 
					style="font-size:12;width:40px;height:21px;"> 
					
							<input
					type="button" name="ok" accesskey="y" tabindex="y" value="�ύ" title ="2" 
					class="but_1" onclick="onAdd(this.title)"
					style="font-size:12;width:40px;height:21px;"> 
					
					
					 <input
					type="button" name="back" accesskey="b" tabindex="b" value="�� ��"
					class="but_1" onclick="location='doMsgInfo.do?method=queryMsgInfo'"
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
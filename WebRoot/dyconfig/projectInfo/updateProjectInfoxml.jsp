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
<title>�ޱ����ĵ�</title>
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
				alert("��Ŀ���Ѿ�����,���������룡");
				 document.all.projectName.value=""; 
			} 
			}
	});

}
function onUpdate(wechat){
	   document.getElementById("anniu").setAttribute("value", wechat);
	   
	   if(wechat == "3"){
		   if(frmGo.role.value=="����"){
			   if(frmGo.pidanremark.value.trim() == ''){
					alert("������ע����Ϊ��");
					frmGo.ProjectName.focus();
					return false;
				}
		   }else if(frmGo.role.value=="����"){
			   if(frmGo.gdremark.value.trim() == ''){
					alert("������ע����Ϊ��");
					frmGo.ProjectName.focus();
					return false;
				}
		   }
	   }
	   
	/* if(frmGo.projectName.value.trim() == ''){
		alert("��Ŀ���Ʋ���Ϊ��");
		frmGo.ProjectName.focus();
		return false;
	} */
	/* if(frmGo.remark.value.trim().length > 30){
		alert("�������ܳ���30��");
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
			
			  <%--  <%if("admin".equals(request.getAttribute("role")) || "�ͷ�".equals(request.getAttribute("role"))){ %>
			    <%} %>	 --%>
			   
			   <tr>
				<th colspan="8" nowrap="nowrap" align="left"><%=request.getAttribute("role")%>�޸Ķ�����Ϣ</th>
			</tr>

			<tr class="tr_11">
				<td colspan="8" nowrap="nowrap" align="center" width="7%">��һ���ƺ���¬��   �ͻ���Ϣ������</td>
			</tr>
			
			<tr>
				<td colspan="4" nowrap="nowrap" align="center" width="7%">������Ϣ</td>
				<td colspan="4" nowrap="nowrap" align="center" width="7%">������Ϣ</td>
			</tr>
			
			<tr>
				<td nowrap="nowrap" align="center" width="7%">�������</td>
				<td nowrap="nowrap" align="center" width="7%">
	<input style="border:none;" type="text"   readOnly="true"  size="38"  name="project_no1" id="project_no1" value=<%=projectInfo.getAt("order_id")%>>
</td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
				
				<select name="qudao" value="qudao">
					<option value="" <%=projectInfo.getAt("qudao").equals("")? "selected":"" %>></option>
						<option value="�Ա�" <%=projectInfo.getAt("qudao").equals("�Ա�")? "selected":"" %>>�Ա�</option>
						<option value="����" <%=projectInfo.getAt("qudao").equals("����")? "selected":"" %>>����</option>
						<option value="����" <%=projectInfo.getAt("qudao").equals("����")? "selected":"" %>>����</option>
						<option value="����" <%=projectInfo.getAt("qudao").equals("����")? "selected":"" %>>����</option>
						<option value="����" <%=projectInfo.getAt("qudao").equals("����")? "selected":"" %>>����</option>
						<option value="����" <%=projectInfo.getAt("qudao").equals("����")? "selected":"" %>>����</option>
						<option value="����" <%=projectInfo.getAt("qudao").equals("����")? "selected":"" %>>����</option>
				</select> 
				
				<%-- 	<input style="border:none;" name="qudao" type="radio" class="radio_1" value="�Ա�" <%if("�Ա�".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>�Ա�
						<input style="border:none;" name="qudao" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>����
						<input style="border:none;" name="qudao" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>����
						<input style="border:none;" name="qudao" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>����
						<input style="border:none;" name="qudao" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>����
						<input style="border:none;" name="qudao" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>����
						<input style="border:none;" name="qudao" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>���� --%>
						</td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td  nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" type="text"      size="38"  name="age" id="age"   value="<%=projectInfo.getAt("age")%>"  >
					</td>
				<td nowrap="nowrap" align="center" width="7%">�ͻ��绰</td>	
				<td  nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" type="text"    size="38"  name="kehuPhone" id="kehuPhone"   value="<%=projectInfo.getAt("kehu_phone")%>"  >
					</td>
			</tr>
			
				<tr>
				<td nowrap="nowrap" align="center" width="7%">΢�ź�</td>
				<td nowrap="nowrap" align="center" width="7%"><input style="border:none;" type="text"   size="38"  name="wechat" id="wechat"  value=<%=projectInfo.getAt("wechat")%>></td>
				<td nowrap="nowrap" align="center" width="7%">�µ��ͷ�</td>
				<td><input style="border:none;" type="text"    size="38"  name="project_no" id="project_no"   value="<%=projectInfo.getAt("xiadan_kefu")%>"  ></td>
				<td nowrap="nowrap" align="center" width="7%">�Ա�</td>
				<td  nowrap="nowrap" align="center" width="7%">
				
				<select name="sex" value="sex">
					<option value="" <%=projectInfo.getAt("sex").equals("")? "selected":"" %>></option>
						<option value="��" <%=projectInfo.getAt("sex").equals("��")? "selected":"" %>>��</option>
						<option value="Ů" <%=projectInfo.getAt("sex").equals("Ů")? "selected":"" %>>Ů</option>
				</select> 
				
				<%-- 	<input style="border:none;" name="sex" type="radio" class="radio_1" value="��" <%if("��".equals("" + projectInfo.getAt("sex"))){%>checked<%}%>>��
	    <input style="border:none;" name="sex" type="radio" class="radio_1" value="Ů" <%if("Ů".equals("" + projectInfo.getAt("sex"))){%>checked<%}%>>Ů --%>
					</td>
				<td nowrap="nowrap" align="center" width="7%">�ͻ�����</td>	
				<td  nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" type="text"    size="38"  name="kehuName" id="kehuName"   value="<%=projectInfo.getAt("kehu_name")%>"  >
					</td>
			</tr>
			
			<tr>
				<td nowrap="nowrap" align="center" width="7%">������</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" type="text"   size="38"  name="orderNumber" id="orderNumber"  value=<%=projectInfo.getAt("order_number")%>>
				</td>
				<td nowrap="nowrap" align="center" width="7%">���ۼ۸�</td>
				<td nowrap="nowrap" align="center" width="7%">
	<input style="border:none;" type="text"   size="38"  name="salePrice" id="salePrice"  value=<%=projectInfo.getAt("sale_price")%>>
</td>
				<td nowrap="nowrap" align="center" width="7%">���</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" type="text"      size="38"  name="height" id="height"   value="<%=projectInfo.getAt("height")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
<input style="border:none;" type="text"      size="38"  name="weight" id="weight"   value="<%=projectInfo.getAt("weight")%>"  >
</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">������</td>
				<td nowrap="nowrap" align="center" width="7%">
<input style="border:none;" type="text"   size="38"  name="projectNo" id="projectNo"  value=<%=projectInfo.getAt("ww_name")%>>
</td>
				<td nowrap="nowrap" align="center" width="7%">�µ�ʱ��</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" type="text"    readOnly="true" size="38"  name="project_no" id="project_no"   value="<%=projectInfo.getAt("add_time")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="2">�ͻ���ַ</td>
				<td nowrap="nowrap" align="center" width="7%" colspan="3" rowspan="2">
				<input style="border:none;" type="text"      size="50"  name="address" id="address"   value="<%=projectInfo.getAt("address")%>"  >
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">��������</td>
				<td nowrap="nowrap" align="center" width="7%">
			<%-- 		<input style="border:none;" name="orderType" type="radio" class="radio_1" value="�µ�" <%if("�µ�".equals("" + projectInfo.getAt("order_type"))){%>checked<%}%>>�µ�
	    <input style="border:none;" name="orderType" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("order_type"))){%>checked<%}%>>����
	    <input style="border:none;" name="orderType" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("order_type"))){%>checked<%}%>>���� --%>
	    
	    	<select name="orderType" value="orderType">
	    		<option value="" <%=projectInfo.getAt("order_type").equals("")? "selected":"" %>></option>
						<option value="�µ�" <%=projectInfo.getAt("order_type").equals("�µ�")? "selected":"" %>>�µ�</option>
						<option value="����" <%=projectInfo.getAt("order_type").equals("����")? "selected":"" %>>����</option>
						<option value="����" <%=projectInfo.getAt("order_type").equals("����")? "selected":"" %>>����</option>
						<option value="����" <%=projectInfo.getAt("order_type").equals("����")? "selected":"" %>>����</option>
				</select> 
				
				</td>
				<td nowrap="nowrap" align="center" width="7%">����ʱ��</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" type="text"      size="38"  name="jiankuanAa" id="jiankuanAa"   value="<%=projectInfo.getAt("jiaofu_time")%>"  >
				<!-- <select name="jiaofu_time" value="jiaofu_time">
						<option value="10">+10��  �Ӽ�</option>
						<option value="5">+5��  �ر�Ӽ�</option>
						<option value="3">+3��   �ǳ�����</option>
				</select> <font color="red"></font> -->
				</td>
				
			
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">��װ����</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="xizhuang_number" size="38" id="xizhuang_number" type="number"
					class="txt_1" maxlength="100"   value="<%=projectInfo.getAt("xizhuang_number")%>" />
			</td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="yi_ma" size="38" type="text" class="txt_1"  maxlength="50"  value="<%=projectInfo.getAt("yi_ma")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%">��������</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="chenshan_number" size="38" id="chenshan_number" type="number"
					class="txt_1" maxlength="100"  value="<%=projectInfo.getAt("chenshan_number")%>" />
				</td>
				<td nowrap="nowrap" align="center" width="7%">������</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="chenshan_ma" size="38" type="text" class="txt_1"  maxlength="50"  value="<%=projectInfo.getAt("chenshan_ma")%>">
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">���</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input style="border:none;" type="text"      size="38"  name="jiankuanA" id="jiankuanA"   value="<%=projectInfo.getAt("jiankuan_a")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input style="border:none;" name="jiankuanA2" size="38" type="text" class="txt_1"  maxlength="50"  value="<%=projectInfo.getAt("jiankuan_a2")%>" >
				</td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="4">
					<img src="http://47.111.148.8/watch/upload/test.png" width="100" height="100" />
				</td>
				<td nowrap="nowrap" align="center" width="7%">��Χ</td>
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
				<td nowrap="nowrap" align="center" width="7%">��Χ</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input style="border:none;" type="text"      size="38"  name="xiongweiA" id="xiongweiA"   value="<%=projectInfo.getAt("xiongwei_a")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">
				
				<input style="border:none;" name="xiongweiA2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("xiongwei_a2")%>">
				</td>
				
				<td nowrap="nowrap" align="center" width="7%">��Χ</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input style="border:none;" type="text"      size="38"  name="xiongweiB" id="xiongweiB"   value="<%=projectInfo.getAt("xiongwei_b")%>"  >
			</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input style="border:none;" name="xiongweiB22" size="38" type="text" class="txt_1"maxlength="50"  value="<%=projectInfo.getAt("xiongwei_2")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
			<input style="border:none;" type="text"      size="38"  name="zhongyaoA" id="zhongyaoA"   value="<%=projectInfo.getAt("zhongyao_a")%>"  >
		</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input style="border:none;" name="zhongyaoA2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("zhongyao_a2")%>">
				</td>
			
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
		<input style="border:none;" type="text"      size="38"  name="zhongyaoA" id="zhongyaoA"   value="<%=projectInfo.getAt("zhongyao_b")%>"  >
	</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="zhongyaoB2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("zhongyao_b2")%>" ><font color="red"></font>
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">��Χ</td>
				<td nowrap="nowrap" align="center" width="7%">
			<input style="border:none;" type="text"      size="38"  name="fuweiA" id="fuweiA"   value="<%=projectInfo.getAt("fuwei_a")%>"  >
		</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input style="border:none;" name="fuweiA2" id="fuweiA2"  size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("fuwei_a2")%>">
				</td>
				
				<td nowrap="nowrap" align="center" width="7%">��Χ</td>
				<td nowrap="nowrap" align="center" width="7%">
<input style="border:none;" type="text"      size="38"  name="fuweiB" id="fuweiB"   value="<%=projectInfo.getAt("fuwei_b")%>"  >
</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input style="border:none;" name="fuweiB2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("fuwei_b2")%>"><font color="red"></font>
				
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">�����³�</td>
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
				<td nowrap="nowrap" align="center" width="7%">�³�</td>
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
				<td nowrap="nowrap" align="center" width="7%">ǰ�³�</td>
				<td nowrap="nowrap" align="center" width="7%">
		<input style="border:none;" type="text"      size="38"  name="qianyichangA" id="qianyichangA"   value="<%=projectInfo.getAt("qianyichang_a")%>"  >
	</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input style="border:none;" name="qianyichangA2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("qianyichang_a2")%>">
				</td>
			<!-- 	<td nowrap="nowrap" align="center" width="7%"></td> -->
				<td nowrap="nowrap" align="center" width="7%">��Χ</td>
				<td nowrap="nowrap" align="center" width="7%"> 
				 <input style="border:none;" name="fuwei_quea" size="38" type="text" class="txt_1"maxlength="50" value="<%=request.getAttribute("fuwei_quea")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input style="border:none;" name="fuwei_queb" size="38" type="text" class="txt_1"maxlength="50" value="<%=request.getAttribute("fuwei_queb")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">�䳤</td>
				<td nowrap="nowrap" align="center" width="7%">
	<input style="border:none;" type="text"      size="38"  name="xiuchangB" id="xiuchangB"   value="<%=projectInfo.getAt("xiuchang_b")%>"  >
</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input style="border:none;" type="text"      size="38"  name="xc_que" id="xc_que"   value="<%=projectInfo.getAt("xc_que")%>"  >
				</td>
				<!-- <td nowrap="nowrap" align="center" width="7%"></td> -->
				<td nowrap="nowrap" align="center" width="7%">�䳤</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" type="text"      size="38"  name="xiuchangA" id="xiuchangA"   value="<%=projectInfo.getAt("xiuchang_a")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input style="border:none;" name="xiuchangA2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("xiuchang_a2")%>" >
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">���</td>
				<td nowrap="nowrap" align="center" width="7%">
	<input style="border:none;" type="text"      size="38"  name="xiufeiB" id="xiufeiB"   value="<%=projectInfo.getAt("xiufei_b")%>"  >
</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input style="border:none;" name="xiufeiB2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("xiufei_b2")%>">
				</td>
				<!-- <td nowrap="nowrap" align="center" width="7%"></td> -->
				<td nowrap="nowrap" align="center" width="7%">���</td>
				<td nowrap="nowrap" align="center" width="7%">
	<input style="border:none;" type="text"      size="38"  name="xiufeiA" id="xiufeiA"   value="<%=projectInfo.getAt("xiufei_a")%>"  >
</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="xiukouA2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("xiukou_a2")%>">
				
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">���</td>
				<td nowrap="nowrap" align="center" width="7%">
<input style="border:none;" type="text"      size="38"  name="xiukouB" id="xiukouB"   value="<%=projectInfo.getAt("xiukou_b")%>"  >
</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input style="border:none;" name="xiukouB2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("xiukou_b2")%>">
				</td>
				<!-- <td nowrap="nowrap" align="center" width="7%"></td> -->
				<td nowrap="nowrap" align="center" width="7%">���</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input style="border:none;" type="text"      size="38"  name="xiukouA" id="xiukouA"   value="<%=projectInfo.getAt("xiukou_a")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" type="text"      size="38"  name="xiukou_que" id="xiukou_que"   value="<%=projectInfo.getAt("xiukou_que")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">��������</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="xiku_number" size="38" id="xiku_number" type="number"
					class="txt_1"  value="<%=projectInfo.getAt("xiku_number")%>" />
				</td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="ku_ma" size="38" type="text" class="txt_1"  maxlength="50"   value="<%=projectInfo.getAt("ku_ma")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%">�������</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input style="border:none;" name="majia_number" size="38" id="majia_number" type="number"
					class="txt_1" maxlength="100"  value="<%=projectInfo.getAt("majia_number")%>" />
				</td>
				<td nowrap="nowrap" align="center" width="7%">�����</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="majia_ma" size="38" type="text" class="txt_1"  maxlength="50"  value="<%=projectInfo.getAt("majia_ma")%>">
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">��Χ</td>
				<td nowrap="nowrap" align="center" width="7%">	<input style="border:none;" type="text"      size="38"  name="yaoweiC" id="yaoweiC"   value="<%=projectInfo.getAt("yaowei_c")%>"  ></td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="yaoweiC22" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("yaowei_c22")%>">
			
				</td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="4">
					<img src="http://47.111.148.8/watch/upload/test.png" width="100" height="100" />
				</td>
				<td nowrap="nowrap" align="center" width="7%">���</td>
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
				<td nowrap="nowrap" align="center" width="7%">��Χ</td>
				<td nowrap="nowrap" align="center" width="7%">	<input style="border:none;" type="text"      size="38"  name="tuiweiC" id="tuiweiC"   value="<%=projectInfo.getAt("tuiwei_c")%>"  ></td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="tuiweiC2" size="38" type="text" class="txt_1"maxlength="50"  value="<%=projectInfo.getAt("tuiwei_c2")%>">
				
				</td>
				
				<td nowrap="nowrap" align="center" width="7%">��Χ</td>
				<td nowrap="nowrap" align="center" width="7%">
<input style="border:none;" type="text"      size="38"  name="xiongweiD" id="xiongweiD"   value="<%=projectInfo.getAt("xiongwei_d")%>"  >
</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="xiongweiD2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("xiongwei_d2")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">��Χ</td>
				<td nowrap="nowrap" align="center" width="7%">
	<input style="border:none;" type="text"      size="38"  name="dangweiC" id="dangweiC"   value="<%=projectInfo.getAt("dangwei_c")%>"  >
</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="dangweiC2" size="38" type="text" class="txt_1"maxlength="50"  value="<%=projectInfo.getAt("dangwei_c2")%>">
				</td>
				
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">	<input style="border:none;" type="text"      size="38"  name="zhongyaoD" id="zhongyaoD"   value="<%=projectInfo.getAt("zhongyao_d")%>"  ></td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="zhongyaoD2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("yaowei_c2")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">	<input style="border:none;" type="text"      size="38"  name="datuiC" id="datuiC"   value="<%=projectInfo.getAt("datui_c")%>"  ></td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="datuiC2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("datui_c2")%>">
				</td>
				
				<td nowrap="nowrap" align="center" width="7%">�³�</td>
				<td nowrap="nowrap" align="center" width="7%">	<input style="border:none;" type="text"      size="38"  name="yichangD" id="yichangD"   value="<%=projectInfo.getAt("yichang_d")%>"  ></td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="yichangD2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("yichang_d2")%>">
				
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			
			<tr>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">	<input style="border:none;" type="text"      size="38"  name="zhongtuiC" id="zhongtuiC"   value="<%=projectInfo.getAt("zhongtui_c")%>"  ></td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="zhongtuiC2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("zhongtui_c2")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="4">
						<input style="border:none;" name="dakuang3" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("dakuang3")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="4">����</td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="4" colspan="2">
				
				<select name="kuanxingD" value="kuanxingD" >
					<option value="" <%=projectInfo.getAt("kuanxing_d").equals("")? "selected":"" %>></option>
						<option value="����" <%=projectInfo.getAt("kuanxing_d").equals("����")? "selected":"" %>>����</option>
						<option value="����+" <%=projectInfo.getAt("kuanxing_d").equals("����+")? "selected":"" %>>����+</option>
						<option value="����" <%=projectInfo.getAt("kuanxing_d").equals("����")? "selected":"" %>>����</option>
						<option value="����+"  <%=projectInfo.getAt("kuanxing_d").equals("����+")? "selected":"" %> >����+</option>
						<option value="����" <%=projectInfo.getAt("kuanxing_d").equals("����")? "selected":"" %> >����</option>
						<option value="����+" <%=projectInfo.getAt("kuanxing_d").equals("����+")? "selected":"" %> >����+</option>
				</select> 
				
<%-- 	<input style="border:none;" name="kuanxingD" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>����
		<input style="border:none;" name="kuanxingD" type="radio" class="radio_1" value="����+" <%if("����+".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>����+
		<input style="border:none;" name="kuanxingD" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>����
		<input style="border:none;" name="kuanxingD" type="radio" class="radio_1" value="����+" <%if("����+".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>����+
		<input style="border:none;" name="kuanxingD" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>����
		<input style="border:none;" name="kuanxingD" type="radio" class="radio_1" value="����+" <%if("����+".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>����+ --%>
</td>
			
				<td nowrap="nowrap" align="center" width="7%" rowspan="4">
					<input style="border:none;" type="text"      size="38"  name="dakuang4" id="dakuang4"   value="<%=projectInfo.getAt("dakuang4")%>"  >
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">С��</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input style="border:none;" type="text"      size="38"  name="xiaotuiC" id="xiaotuiC"   value="<%=projectInfo.getAt("xiaotui_c")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="xiaotuiC2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("xiaotui_c2")%>">
				</td>
				
			
				
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">�㳤</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" type="text"      size="38"  name="kuchangC" id="kuchangC"   value="<%=projectInfo.getAt("kuchang_c")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="kuchangC2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("kuchang_c2")%>">
				
				</td>
				
				
				
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">�ſ�</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input style="border:none;" type="text"      size="38"  name="tuikouC" id="tuikouC"   value="<%=projectInfo.getAt("tuikou_c")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="tuikouC2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("tuikou_c2")%>">
				</td>
				
			
				
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
					<select name="kouxingC" value="kouxingC">
						<option value="" <%=projectInfo.getAt("kouxing_c").equals("")? "selected":"" %> ></option>
						<option value="һ����" <%=projectInfo.getAt("kouxing_c").equals("һ����")? "selected":"" %>  >һ����</option>
						<option value="������" <%=projectInfo.getAt("kouxing_c").equals("������")? "selected":"" %> >������</option>
						<option value="������" <%=projectInfo.getAt("kouxing_c").equals("������")? "selected":"" %>  >������</option>
						<option value="˫�Ŷ���һ" <%=projectInfo.getAt("kouxing_c").equals("˫�Ŷ���һ")? "selected":"" %>  >˫�Ŷ���һ</option>
						<option value="˫���Ŀ۶�" <%=projectInfo.getAt("kouxing_c").equals("˫���Ŀ۶�")? "selected":"" %>   >˫���Ŀ۶�</option>
						<option value="˫�����۶�" <%=projectInfo.getAt("kouxing_c").equals("˫�����۶�")? "selected":"" %>  >˫�����۶�</option>
						<option value="����" <%=projectInfo.getAt("kouxing_c").equals("����")? "selected":"" %>  >����</option>
				</select>
					</td>
				<td nowrap="nowrap" align="center" width="7%">�ڴ�</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="koudaiC" value="koudaiC">
					<option value="" <%=projectInfo.getAt("koudai_c").equals("")? "selected":"" %> ></option>
						<option value="1ƽ���ǡ�4б����" <%=projectInfo.getAt("koudai_c").equals("1ƽ���ǡ�4б����")? "selected":"" %>  >1ƽ���ǡ�4б����</option>
						<option value="2ƽ���ߡ�5б����" <%=projectInfo.getAt("koudai_c").equals("2ƽ���ߡ�5б����")? "selected":"" %>  >2ƽ���ߡ�5б����</option>
						<option value="3ƽ˫�ߡ�6б˫��" <%=projectInfo.getAt("koudai_c").equals("3ƽ˫�ߡ�6б˫��")? "selected":"" %>  >3ƽ˫�ߡ�6б˫��</option>
						<option value="7������" <%=projectInfo.getAt("koudai_c").equals("7������")? "selected":"" %> >7������</option>
						<option value="����" <%=projectInfo.getAt("koudai_c").equals("����")? "selected":"" %>  >����</option>
				</select> <font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="kaicha" value="kaicha">
					<option value="" <%=projectInfo.getAt("kaicha").equals("")? "selected":"" %> ></option>
						<option value="����" <%=projectInfo.getAt("kaicha").equals("����")? "selected":"" %> >����</option>
						<option value="˫��" <%=projectInfo.getAt("kaicha").equals("˫��")? "selected":"" %>  >˫��</option>
						<option value="������" <%=projectInfo.getAt("kaicha").equals("������")? "selected":"" %>   >������</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
				
				<select name="lingkoukuaishiB" value="lingkoukuaishiB">
				<option value="" <%=projectInfo.getAt("lingkoukuaishi_b").equals("")? "selected":"" %> ></option>
						<option value="ƽ����" <%=projectInfo.getAt("lingkoukuaishi_b").equals("ƽ����")? "selected":"" %>  >ƽ����</option>
						<option value="ꨲ���" <%=projectInfo.getAt("lingkoukuaishi_b").equals("ꨲ���")? "selected":"" %>  >ꨲ���</option>
						<option value="�����" <%=projectInfo.getAt("lingkoukuaishi_b").equals("�����")? "selected":"" %>  >�����</option>
						<option value="�����" <%=projectInfo.getAt("lingkoukuaishi_b").equals("�����")? "selected":"" %>  >�����</option>
						<option value="��ƽ��" <%=projectInfo.getAt("lingkoukuaishi_b").equals("��ƽ��")? "selected":"" %>  >��ƽ��</option>
						<option value="��ƽ��" <%=projectInfo.getAt("lingkoukuaishi_b").equals("��ƽ��")? "selected":"" %>  >��ƽ��</option>
						<option value="��ꨲ�" <%=projectInfo.getAt("lingkoukuaishi_b").equals("��ꨲ�")? "selected":"" %>  >��ꨲ�</option>
						<option value="����" <%=projectInfo.getAt("lingkoukuaishi_b").equals("����")? "selected":"" %>  >����</option>
				</select> 
				
				<!-- <input style="border:none;" name="lingkoukuaishiB" size="38"
					id="lingkoukuaishiB" type="text" class="txt_1" maxlength="100" /><font
					color="red"></font> -->
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">�°�</td>
				<td nowrap="nowrap" align="center" width="7%">
					<select name="xiabai" value="xiabai">
					<option value="" <%=projectInfo.getAt("xiabai").equals("")? "selected":"" %> ></option>
						<option value="ֱ���°�" <%=projectInfo.getAt("xiabai").equals("ֱ���°�")? "selected":"" %>  >ֱ���°�</option>
						<option value="Բ���°�" <%=projectInfo.getAt("xiabai").equals("Բ���°�")? "selected":"" %>  >Բ���°�</option>
						<option value="��Բ���°�" <%=projectInfo.getAt("xiabai").equals("��Բ���°�")? "selected":"" %>  >��Բ���°�</option>
						<option value="��β�°�" <%=projectInfo.getAt("xiabai").equals("��β�°�")? "selected":"" %>  >��β�°�</option>
						<option value="����" <%=projectInfo.getAt("xiabai").equals("����")? "selected":"" %>   >����</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">ײɫ</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="zhuangse" value="zhuangse">
				<option value="" <%=projectInfo.getAt("zhuangse").equals("")? "selected":"" %> ></option>
						<option value="������ɫ��" <%=projectInfo.getAt("zhuangse").equals("������ɫ��")? "selected":"" %>  >������ɫ��</option>
						<option value="�����ɫ��" <%=projectInfo.getAt("zhuangse").equals("�����ɫ��")? "selected":"" %>  >�����ɫ��</option>
						<option value="��ͷ��ɫ��" <%=projectInfo.getAt("zhuangse").equals("��ͷ��ɫ��")? "selected":"" %>   >��ͷ��ɫ��</option>
						<option value="��ͷ��ɫ��" <%=projectInfo.getAt("zhuangse").equals("����")? "selected":"" %>  >����</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">�����</td>
				<td nowrap="nowrap" align="center" width="7%">
				
				<select name="waizhubian" value="waizhubian">
					<option value="" <%=projectInfo.getAt("waizhubian").equals("")? "selected":"" %> ></option>
						<option value="��" <%=projectInfo.getAt("waizhubian").equals("��")? "selected":"" %> >��</option>
						<option value="��" <%=projectInfo.getAt("waizhubian").equals("��")? "selected":"" %> >��</option>
				</select> 
				
			<%-- 	<input style="border:none;" name="waizhubian" size="38"
					id="waizhubian" type="text" class="txt_1" maxlength="100"  value="<%=projectInfo.getAt("waizhubian")%>" /><font
					color="red"></font> --%>
				</td>
				<td nowrap="nowrap" align="center" width="7%">���</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="xiucha" value="xiucha">
				<option value="" <%=projectInfo.getAt("xiucha").equals("")? "selected":"" %> ></option>
						<option value="�����" <%=projectInfo.getAt("xiucha").equals("�����")? "selected":"" %>  >�����</option>
						<option value="�����" <%=projectInfo.getAt("xiucha").equals("�����")? "selected":"" %>  >�����</option>
						<option value="����" <%=projectInfo.getAt("xiucha").equals("����")? "selected":"" %>   >����</option>
						<option value="����" <%=projectInfo.getAt("xiucha").equals("����")? "selected":"" %>   >����</option>
				</select>
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="kuyao" value="kuyao">
				<option value="" <%=projectInfo.getAt("kuyao").equals("")? "selected":"" %> ></option>
						<option value="�������" <%=projectInfo.getAt("kuyao").equals("�������")? "selected":"" %>  >�������</option>
						<option value="�������" <%=projectInfo.getAt("kuyao").equals("�������")? "selected":"" %>  >�������</option>
						<option value="����ͷ" <%=projectInfo.getAt("kuyao").equals("����ͷ")? "selected":"" %>  >����ͷ</option>
						<option value="�ɽ�" <%=projectInfo.getAt("kuyao").equals("�ɽ�")? "selected":"" %>  >�ɽ�</option>
						<option value="���ڿ�" <%=projectInfo.getAt("kuyao").equals("���ڿ�")? "selected":"" %>  >���ڿ�</option>
						<option value="�ǲ���˹" <%=projectInfo.getAt("kuyao").equals("�ǲ���˹")? "selected":"" %>  >�ǲ���˹</option>
						<option value="����" <%=projectInfo.getAt("kuyao").equals("����")? "selected":"" %> >����</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="kuxing" value="kuxing">
				<option value="" <%=projectInfo.getAt("kuxing").equals("")? "selected":"" %> ></option>
						<option value="�����" <%=projectInfo.getAt("kuxing").equals("�����")? "selected":"" %>  >�����</option>
						<option value="����" <%=projectInfo.getAt("kuxing").equals("����")? "selected":"" %>  >����</option>
						<option value="����" <%=projectInfo.getAt("kuxing").equals("����")? "selected":"" %>  >����</option>
						<option value="˫��" <%=projectInfo.getAt("kuxing").equals("˫��")? "selected":"" %>  >˫��</option>
						<option value="�ܲ���" <%=projectInfo.getAt("kuxing").equals("�ܲ���")? "selected":"" %>  >�ܲ���</option>
						<option value="ֱͲ��" <%=projectInfo.getAt("kuxing").equals("ֱͲ��")? "selected":"" %>  >ֱͲ��</option>
						<option value="����" <%=projectInfo.getAt("kuxing").equals("����")? "selected":"" %>  >����</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">������</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="chenshanling" value="chenshanling">
				<option value="" <%=projectInfo.getAt("chenshanling").equals("")? "selected":"" %> ></option>
						<option value="С����" <%=projectInfo.getAt("chenshanling").equals("С����")? "selected":"" %> >С����</option>
						<option value="С����" <%=projectInfo.getAt("chenshanling").equals("С����")? "selected":"" %> >С����</option>
						<option value="v����" <%=projectInfo.getAt("chenshanling").equals("v����")? "selected":"" %> >v����</option>
						<option value="������" <%=projectInfo.getAt("chenshanling").equals("������")? "selected":"" %> >������</option>
						<option value="����" <%=projectInfo.getAt("chenshanling").equals("����")? "selected":"" %> >����</option>
						<option value="����" <%=projectInfo.getAt("chenshanling").equals("����")? "selected":"" %> >����</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">������</td>
				<td nowrap="nowrap" align="center" width="7%">
					<select name="chenshanxiu" value="chenshanxiu">
					<option value="" <%=projectInfo.getAt("chenshanxiu").equals("")? "selected":"" %> ></option>
						<option value="��ʽ�Ž���" <%=projectInfo.getAt("chenshanxiu").equals("��ʽ�Ž���")? "selected":"" %> >��ʽ�Ž���</option>
						<option value="ֱ�Ƕ���" <%=projectInfo.getAt("chenshanxiu").equals("ֱ�Ƕ���")? "selected":"" %> >ֱ�Ƕ���</option>
						<option value="ֱ��һ��" <%=projectInfo.getAt("chenshanxiu").equals("ֱ��һ��")? "selected":"" %> >ֱ��һ��</option>
						<option value="Բ�Ƕ���" <%=projectInfo.getAt("chenshanxiu").equals("Բ�Ƕ���")? "selected":"" %> >Բ�Ƕ���</option>
						<option value="Բ��һ��" <%=projectInfo.getAt("chenshanxiu").equals("Բ��һ��")? "selected":"" %> >Բ��һ��</option>
						<option value="����" <%=projectInfo.getAt("chenshanxiu").equals("����")? "selected":"" %>  >����</option>
						<option value="����" <%=projectInfo.getAt("chenshanxiu").equals("����")? "selected":"" %>  >����</option>
				</select>
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
			<input style="border:none;" type="text"      size="38"  name="miaoliao1" id="miaoliao1"   value="<%=projectInfo.getAt("miao_liao1")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">��;</td>
				<td nowrap="nowrap" align="center" width="7%"><!-- 
					 <input style="border:none;" type="text"   size="38"  name="yongtu1" id="yongtu1"   value="<%=projectInfo.getAt("yong_tu1")%>"  >-->
					
						<select name="yongtu1" value="yongtu1">
						<option value="����">����</option>
						<option value="����">����</option>
						<option value="���">���</option>
						<option value="����">����</option>
						<option value="����">����</option>
						<option value="��װ��װ">��װ��װ</option>
						<option value="��Ƭ">��Ƭ</option>
						<option value="����">����</option>
				</select> 
				
				</td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
						<input style="border:none;" name="mi1" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("mi1")%>" >
				</td>
				<td nowrap="nowrap" align="center" width="7%">��Ӧ��</td>
				<td nowrap="nowrap" align="center" width="7%">
					<%=request.getAttribute("companyList")%>
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" type="text"   size="38"  name="miaoliao2" id="miaoliao2"   value="<%=projectInfo.getAt("miao_liao2")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">��;</td>
				<td nowrap="nowrap" align="center" width="7%">
					<select name="yongtu2" value="yongtu2">
						<option value="����">����</option>
						<option value="����">����</option>
						<option value="���">���</option>
						<option value="����">����</option>
						<option value="����">����</option>
						<option value="��װ��װ">��װ��װ</option>
						<option value="��Ƭ">��Ƭ</option>
						<option value="����">����</option>
				</select> 
					<%-- <input style="border:none;" type="text"   size="38"  name="yongtu2" id="yongtu2"   value="<%=projectInfo.getAt("yong_tu2")%>"  > --%>
				</td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input style="border:none;" name="mi2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("mi2")%>" >
				</td>
				<td nowrap="nowrap" align="center" width="7%">��Ӧ��</td>
				<td nowrap="nowrap" align="center" width="7%">
					<%=request.getAttribute("companyList1")%>
				</td>
			</tr>
			  <%if("admin".equals(request.getAttribute("role")) || "�ͷ�".equals(request.getAttribute("role")) || "�ͷ�����".equals(request.getAttribute("role")) ){ %>
<tr>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%"><input style="border:none;" type="file" name="channelId"  multiple="multiple"
					id="channelId" multiple="multiple" class="imagePath" /> <img alt=""
					src="" id="image1" class="showImage"></td>
			</tr>
			    <%} %>
			    
			
			
			<tr>
				<td nowrap="nowrap" align="center" width="7%">�ͷ���ע</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="7">
	<input style="border:none;" type="text"   size="160"  name="remark" id="remark"   value="<%=projectInfo.getAt("remark")%>"  >
</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">������ע</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="7">
				<input style="border:none;" type="text"    size="160"  name="pidanremark" id="pidanremark"   value="<%=projectInfo.getAt("pidan_remark")%>" >
					
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">������ע</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="7">
					<input style="border:none;" type="text"      size="160"  name="gdremark" id="gdremark"   value="<%=projectInfo.getAt("gd_remark")%>"  > 
				</td>
			</tr>
				<%-- <tr>
				<td nowrap="nowrap" align="center" width="7%">�ύ����</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="7">
					���� <input style="border:none;" name="tag" type="radio" class="radio_1" value="1" checked="checked" >
	    ���沢�ύ<input style="border:none;" type="radio" name="tag" class="radio_1" value="2" >
	    
	     <%if("admin".equals(request.getAttribute("role")) || "����".equals(request.getAttribute("role")) || "����".equals(request.getAttribute("role")) ){ %>
	     �˻� <input style="border:none;" type="radio" name="tag" class="radio_1" value="3" >
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
						<input style="border:none;" type="button" title ="1"  name="ok" accesskey="y" tabindex="y"  value="����" class="but_1" onclick="onUpdate(this.title)">
						
						<input style="border:none;" type="button" title ="2"  name="ok" accesskey="y" tabindex="y"  value="���沢�ύ" class="but_1" onclick="onUpdate(this.title)"  style="font-size:12;width:80px;height:21px;">
						</td>
							<td nowrap="nowrap" align="left" width="7%" colspan="6">
						 
			    
						
	
      <input style="border:none;" type="button" name="back" accesskey="b" tabindex="b" value="�� ��" class="but_1" onclick="location='doProjectInfo.do?method=queryProjectInfoXml'">
   <!--    <input style="border:none;" type="reset" name="back" accesskey="b" tabindex="b" value="����" class="but_1" > -->
      
       <%if("admin".equals(request.getAttribute("role")) || "����".equals(request.getAttribute("role")) || "����".equals(request.getAttribute("role")) ){ %>
	<input style="border:none;" type="button"  title ="3" name="ok" accesskey="y" tabindex="y"  value="�˻�" class="but_1" onclick="onUpdate(this.title)" style="color: red">
			    <%} %>
				</td>
			</tr>
			
              
				
			
		

</table>
</form>
</body>
</html>
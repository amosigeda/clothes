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
function onUpdate(){
/* 	if(frmGo.projectName.value.trim() == ''){
		alert("��Ŀ���Ʋ���Ϊ��");
		frmGo.ProjectName.focus();
		return false;
	}
	if(frmGo.remark.value.trim().length > 30){
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
<input name="id" type="hidden" value="<%=projectInfo.getAt("id")%>" >
<%-- <input name="role" type="hidden" value="<%=projectInfo.getAt("role")%>" > --%>
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
	<input type="text"   readOnly="true"  size="38"  name="project_no1" id="project_no1" value=<%=projectInfo.getAt("order_id")%>>
</td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input name="qudao" type="radio" class="radio_1" value="�Ա�" <%if("�Ա�".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>�Ա�
						<input name="qudao" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>����
						<input name="qudao" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>����
						<input name="qudao" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>����
						<input name="qudao" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>����
						<input name="qudao" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>����
						<input name="qudao" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>����
						</td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td  nowrap="nowrap" align="center" width="7%">
				<input type="text"      size="38"  name="age" id="age"   value="<%=projectInfo.getAt("age")%>"  >
					</td>
				<td nowrap="nowrap" align="center" width="7%">�ͻ��绰</td>	
				<td  nowrap="nowrap" align="center" width="7%">
				<input type="text"    size="38"  name="kehuPhone" id="kehuPhone"   value="<%=projectInfo.getAt("kehu_phone")%>"  >
					</td>
			</tr>
			
				<tr>
				<td nowrap="nowrap" align="center" width="7%">΢�ź�</td>
				<td nowrap="nowrap" align="center" width="7%"><input type="text"   size="38"  name="wechat" id="wechat"  value=<%=projectInfo.getAt("wechat")%>></td>
				<td nowrap="nowrap" align="center" width="7%">�µ��ͷ�</td>
				<td><input type="text"    size="38"  name="project_no" id="project_no"   value="<%=projectInfo.getAt("xiadan_kefu")%>"  ></td>
				<td nowrap="nowrap" align="center" width="7%">�Ա�</td>
				<td  nowrap="nowrap" align="center" width="7%">
					<input name="sex" type="radio" class="radio_1" value="��" <%if("��".equals("" + projectInfo.getAt("sex"))){%>checked<%}%>>��
	    <input name="sex" type="radio" class="radio_1" value="Ů" <%if("Ů".equals("" + projectInfo.getAt("sex"))){%>checked<%}%>>Ů
					</td>
				<td nowrap="nowrap" align="center" width="7%">�ͻ�����</td>	
				<td  nowrap="nowrap" align="center" width="7%">
				<input type="text"    size="38"  name="kehuName" id="kehuName"   value="<%=projectInfo.getAt("kehu_name")%>"  >
					</td>
			</tr>
			
			<tr>
				<td nowrap="nowrap" align="center" width="7%">������</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input type="text"   size="38"  name="orderNumber" id="orderNumber"  value=<%=projectInfo.getAt("order_number")%>>
				</td>
				<td nowrap="nowrap" align="center" width="7%">���ۼ۸�</td>
				<td nowrap="nowrap" align="center" width="7%">
	<input type="text"   size="38"  name="salePrice" id="salePrice"  value=<%=projectInfo.getAt("sale_price")%>>
</td>
				<td nowrap="nowrap" align="center" width="7%">���</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input type="text"      size="38"  name="height" id="height"   value="<%=projectInfo.getAt("height")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
<input type="text"      size="38"  name="weight" id="weight"   value="<%=projectInfo.getAt("weight")%>"  >
</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">������</td>
				<td nowrap="nowrap" align="center" width="7%">
<input type="text"   size="38"  name="projectNo" id="projectNo"  value=<%=projectInfo.getAt("ww_name")%>>
</td>
				<td nowrap="nowrap" align="center" width="7%">�µ�ʱ��</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input type="text"    readOnly="true" size="38"  name="project_no" id="project_no"   value="<%=projectInfo.getAt("add_time")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">�ͻ���ַ</td>
				<td nowrap="nowrap" align="center" width="7%" colspan="3">
				<input type="text"      size="50"  name="address" id="address"   value="<%=projectInfo.getAt("address")%>"  >
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">��������</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input name="orderType" type="radio" class="radio_1" value="�µ�" <%if("�µ�".equals("" + projectInfo.getAt("order_type"))){%>checked<%}%>>�µ�
	    <input name="orderType" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("order_type"))){%>checked<%}%>>����
	    <input name="orderType" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("order_type"))){%>checked<%}%>>����
				</td>
				<td nowrap="nowrap" align="center" width="7%">����ʱ��</td>
				<td nowrap="nowrap" align="center" width="7%">
				<!-- <select name="jiaofu_time" value="jiaofu_time">
						<option value="10">+10��  �Ӽ�</option>
						<option value="5">+5��  �ر�Ӽ�</option>
						<option value="3">+3��   �ǳ�����</option>
				</select> <font color="red"></font> -->
				</td>
				
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">��װ����</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="xizhuang_number" size="38" id="xizhuang_number" type="number"
					class="txt_1" maxlength="100"   value="<%=projectInfo.getAt("xizhuang_number")%>" />
			</td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="yi_ma" size="38" type="text" class="txt_1"  maxlength="50">
				</td>
				<td nowrap="nowrap" align="center" width="7%">��������</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="chenshan_number" size="38" id="chenshan_number" type="number"
					class="txt_1" maxlength="100"  value="<%=projectInfo.getAt("chenshan_number")%>" />
				</td>
				<td nowrap="nowrap" align="center" width="7%">������</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="chenshan_ma" size="38" type="text" class="txt_1"  maxlength="50">
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">���</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input type="text"      size="38"  name="jiankuanA" id="jiankuanA"   value="<%=projectInfo.getAt("jiankuan_a")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input name="jiankuanA2" size="38" type="text" class="txt_1"  maxlength="50"  value="<%=projectInfo.getAt("jiankuan_a2")%>" >
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%">��Χ</td>
				<td nowrap="nowrap" align="center" width="7%">
			<input type="text"      size="38"  name="lingweiB" id="lingweiB"   value="<%=projectInfo.getAt("lingwei_b")%>"  >
		</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input name="lingweiB2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("lingwei_b2")%>" >
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">��Χ</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input type="text"      size="38"  name="xiongweiA" id="xiongweiA"   value="<%=projectInfo.getAt("xiongwei_a")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">
				
				<input name="xiongweiA2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("xiongwei_a2")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%">��Χ</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input type="text"      size="38"  name="xiongweiB" id="xiongweiB"   value="<%=projectInfo.getAt("xiongwei_b")%>"  >
			</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input name="xiongweiB22" size="38" type="text" class="txt_1"maxlength="50"  value="<%=projectInfo.getAt("xiongwei_2")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
			<input type="text"      size="38"  name="zhongyaoA" id="zhongyaoA"   value="<%=projectInfo.getAt("zhongyao_a")%>"  >
		</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input name="zhongyaoA2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("zhongyao_a2")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
		<input type="text"      size="38"  name="zhongyaoA" id="zhongyaoA"   value="<%=projectInfo.getAt("zhongyao_a")%>"  >
	</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="zhongyaoB2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("zhongyao_b2")%>" ><font color="red"></font>
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">��Χ</td>
				<td nowrap="nowrap" align="center" width="7%">
			<input type="text"      size="38"  name="fuweiA" id="fuweiA"   value="<%=projectInfo.getAt("fuwei_a")%>"  >
		</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input name="fuweiA2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("fuwei_a2")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%">��Χ</td>
				<td nowrap="nowrap" align="center" width="7%">
<input type="text"      size="38"  name="fuweiB" id="fuweiB"   value="<%=projectInfo.getAt("fuwei_b")%>"  >
</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input name="fuweiB2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("fuwei_b2")%>"><font color="red"></font>
				
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">�����³�</td>
				<td nowrap="nowrap" align="center" width="7%">
<input type="text"      size="38"  name="houzhongyichangA" id="houzhongyichangA"   value="<%=projectInfo.getAt("houzhongyichang_a")%>"  >
</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input name="houzhongyichangA2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("houzhongyichang_a2")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%">�³�</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="yichangB2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("yichang_b2")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
				<tr>
				<td nowrap="nowrap" align="center" width="7%">ǰ�³�</td>
				<td nowrap="nowrap" align="center" width="7%">
		<input type="text"      size="38"  name="qianyichangA" id="qianyichangA"   value="<%=projectInfo.getAt("qianyichang_a")%>"  >
	</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input name="qianyichangA2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("qianyichang_a2")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%">��Χ</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">�䳤</td>
				<td nowrap="nowrap" align="center" width="7%">
	<input type="text"      size="38"  name="xiuchangB" id="xiuchangB"   value="<%=projectInfo.getAt("xiuchang_b")%>"  >
</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%">�䳤</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input type="text"      size="38"  name="xiuchangA" id="xiuchangA"   value="<%=projectInfo.getAt("xiuchang_a")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input name="xiuchangA2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("xiuchang_a2")%>" >
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">���</td>
				<td nowrap="nowrap" align="center" width="7%">
	<input type="text"      size="38"  name="xiufeiB" id="xiufeiB"   value="<%=projectInfo.getAt("xiufei_b")%>"  >
</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input name="xiufeiB2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("xiufei_b2")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%">���</td>
				<td nowrap="nowrap" align="center" width="7%">
	<input type="text"      size="38"  name="xiufeiA" id="xiufeiA"   value="<%=projectInfo.getAt("xiufei_a")%>"  >
</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="xiukouA2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("xiukou_a2")%>">
				
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">���</td>
				<td nowrap="nowrap" align="center" width="7%">
<input type="text"      size="38"  name="xiukouB" id="xiukouB"   value="<%=projectInfo.getAt("xiukou_b")%>"  >
</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input name="xiukouB2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("xiukou_b2")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%">���</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input type="text"      size="38"  name="xiukouA" id="xiukouA"   value="<%=projectInfo.getAt("xiukou_a")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">��������</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="xiku_number" size="38" id="xiku_number" type="number"
					class="txt_1"  value="<%=projectInfo.getAt("xiku_number")%>" />
				</td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="ku_ma" size="38" type="text" class="txt_1"  maxlength="50">
				</td>
				<td nowrap="nowrap" align="center" width="7%">�������</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input name="majia_number" size="38" id="majia_number" type="number"
					class="txt_1" maxlength="100"  value="<%=projectInfo.getAt("majia_number")%>" />
				</td>
				<td nowrap="nowrap" align="center" width="7%">�����</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="majia_ma" size="38" type="text" class="txt_1"  maxlength="50">
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">��Χ</td>
				<td nowrap="nowrap" align="center" width="7%">	<input type="text"      size="38"  name="yaoweiC" id="yaoweiC"   value="<%=projectInfo.getAt("yaowei_c")%>"  ></td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="yaoweiC22" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("yaowei_c22")%>">
			
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%">���</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">��Χ</td>
				<td nowrap="nowrap" align="center" width="7%">	<input type="text"      size="38"  name="tuiweiC" id="tuiweiC"   value="<%=projectInfo.getAt("tuiwei_c")%>"  ></td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="tuiweiC2" size="38" type="text" class="txt_1"maxlength="50"  value="<%=projectInfo.getAt("tuiwei_c2")%>">
				
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%">��Χ</td>
				<td nowrap="nowrap" align="center" width="7%">
<input type="text"      size="38"  name="xiongweiD" id="xiongweiD"   value="<%=projectInfo.getAt("xiongwei_d")%>"  >
</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="xiongweiD2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("xiongwei_d2")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">��Χ</td>
				<td nowrap="nowrap" align="center" width="7%">
	<input type="text"      size="38"  name="dangweiC" id="dangweiC"   value="<%=projectInfo.getAt("dangwei_c")%>"  >
</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="dangweiC2" size="38" type="text" class="txt_1"maxlength="50"  value="<%=projectInfo.getAt("dangwei_c2")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">	<input type="text"      size="38"  name="zhongyaoD" id="zhongyaoD"   value="<%=projectInfo.getAt("zhongyao_d")%>"  ></td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="zhongyaoD2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("yaowei_c2")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">	<input type="text"      size="38"  name="datuiC" id="datuiC"   value="<%=projectInfo.getAt("datui_c")%>"  ></td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="datuiC2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("datui_c2")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%">�³�</td>
				<td nowrap="nowrap" align="center" width="7%">	<input type="text"      size="38"  name="yichangD" id="yichangD"   value="<%=projectInfo.getAt("yichang_d")%>"  ></td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="yichangD2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("yichang_d2")%>">
				
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			
			<tr>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">	<input type="text"      size="38"  name="zhongtuiC" id="zhongtuiC"   value="<%=projectInfo.getAt("zhongtui_c")%>"  ></td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="zhongtuiC2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("zhongtui_c2")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
	<input name="kuanxingD" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>����
		<input name="kuanxingD" type="radio" class="radio_1" value="����+" <%if("����+".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>����+
		<input name="kuanxingD" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>����
		<input name="kuanxingD" type="radio" class="radio_1" value="����+" <%if("����+".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>����+
		<input name="kuanxingD" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>����
		<input name="kuanxingD" type="radio" class="radio_1" value="����+" <%if("����+".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>����+
</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">С��</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input type="text"      size="38"  name="xiaotuiC" id="xiaotuiC"   value="<%=projectInfo.getAt("xiaotui_c")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="xiaotuiC2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("xiaotui_c2")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">�㳤</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input type="text"      size="38"  name="kuchangC" id="kuchangC"   value="<%=projectInfo.getAt("kuchang_c")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="kuchangC2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("kuchang_c2")%>">
				
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">�ſ�</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input type="text"      size="38"  name="tuikouC" id="tuikouC"   value="<%=projectInfo.getAt("tuikou_c")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="tuikouC2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("tuikou_c2")%>">
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
					<select name="kouxingC" value="kouxingC">
						<option value="һ����">һ����</option>
						<option value="������">������</option>
						<option value="������">������</option>
						<option value="˫�Ŷ���һ">˫�Ŷ���һ</option>
						<option value="˫���Ŀ۶�">˫���Ŀ۶�</option>
						<option value="˫�����۶�">˫�����۶�</option>
				</select> <font color="red"></font>
					</td>
				<td nowrap="nowrap" align="center" width="7%">�ڴ�</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="koudaiC" value="koudaiC">
						<option value="1ƽ���ǡ�4б����">1ƽ���ǡ�4б����</option>
						<option value="2ƽ���ߡ�5б����">2ƽ���ߡ�5б����</option>
						<option value="3ƽ˫�ߡ�6б˫��">3ƽ˫�ߡ�6б˫��</option>
						<option value="7������">7������</option>
				</select> <font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="kaicha" value="kaicha">
						<option value="����">����</option>
						<option value="˫��">˫��</option>
						<option value="������">������</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="lingkoukuaishiB" size="38"
					id="lingkoukuaishiB" type="text" class="txt_1" maxlength="100" /><font
					color="red"></font>
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">�°�</td>
				<td nowrap="nowrap" align="center" width="7%">
					<select name="xiabai" value="xiabai">
						<option value="Բ���°�">Բ���°�</option>
						<option value="ֱ���°ڣ�˫�ſ�Ĭ�ϣ�">ֱ���°ڣ�˫�ſ�Ĭ�ϣ�</option>
						<option value="��Բ���°�">��Բ���°�</option>
						<option value="��β�°�">��β�°�</option>
						<option value="����">����</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">ײɫ</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="zhuangse" value="zhuangse">
						<option value="������ɫ��">������ɫ��</option>
						<option value="�����ɫ��">�����ɫ��</option>
						<option value="��ͷ��ɫ��">��ͷ��ɫ��</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">�����</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="waizhubian" size="38"
					id="waizhubian" type="text" class="txt_1" maxlength="100"  value="<%=projectInfo.getAt("waizhubian")%>" /><font
					color="red"></font>
				</td>
				<td nowrap="nowrap" align="center" width="7%">���</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="xiucha" value="xiucha">
						<option value="�����">�����</option>
						<option value="�����">�����</option>
						<option value="����">����</option>
						<option value="����">����</option>
				</select>
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="kuyao" value="kuyao">
						<option value="�������">�������</option>
						<option value="�������">�������</option>
						<option value="����ͷ">����ͷ</option>
						<option value="�ɽ�">�ɽ�</option>
						<option value="���ڿ�">���ڿ�</option>
						<option value="�ǲ���˹">�ǲ���˹</option>
						<option value="����">����</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="kuxing" value="kuxing">
						<option value="�����">�����</option>
						<option value="����">����</option>
						<option value="����">����</option>
						<option value="˫��">˫��</option>
						<option value="�ܲ���">�ܲ���</option>
						<option value="ֱͲ��">ֱͲ��</option>
						<option value="����">����</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">������</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="chenshanling" value="chenshanling">
						<option value="С����">С����</option>
						<option value="С����">С����</option>
						<option value="v����">v����</option>
						<option value="������">������</option>
						<option value="����">����</option>
						<option value="����">����</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">������</td>
				<td nowrap="nowrap" align="center" width="7%">
					<select name="chenshanxiu" value="chenshanxiu">
						<option value="��ʽ�Ž���">��ʽ�Ž���</option>
						<option value="ֱ�Ƕ���">ֱ�Ƕ���</option>
						<option value="ֱ��һ��">ֱ��һ��</option>
						<option value="Բ�Ƕ���">Բ�Ƕ���</option>
						<option value="Բ��һ��">Բ��һ��</option>
						<option value="����">����</option>
						<option value="����">����</option>
				</select>
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
			<input type="text"      size="38"  name="miaoliao1" id="miaoliao1"   value="<%=projectInfo.getAt("miao_liao1")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">��;</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input type="text"   size="38"  name="yongtu1" id="yongtu1"   value="<%=projectInfo.getAt("yong_tu1")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
						<input name="mi1" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("mi1")%>" >
				</td>
				<td nowrap="nowrap" align="center" width="7%">��Ӧ��</td>
				<td nowrap="nowrap" align="center" width="7%">
					<%=request.getAttribute("companyList")%>
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input type="text"   size="38"  name="miaoliao2" id="miaoliao2"   value="<%=projectInfo.getAt("miao_liao2")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">��;</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input type="text"   size="38"  name="yongtu2" id="yongtu2"   value="<%=projectInfo.getAt("yong_tu2")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="mi2" size="38" type="text" class="txt_1"maxlength="50" value="<%=projectInfo.getAt("mi2")%>" >
				</td>
				<td nowrap="nowrap" align="center" width="7%">��Ӧ��</td>
				<td nowrap="nowrap" align="center" width="7%">
					<%=request.getAttribute("companyList1")%>
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%"><input type="file" name="channelId"
					id="channelId" multiple="multiple" class="imagePath" /> <img alt=""
					src="" id="image1" class="showImage"></td>
			</tr>
			
			<tr>
				<td nowrap="nowrap" align="center" width="7%">�ͷ���ע</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="7">
	<input type="text"   size="160"  name="remark" id="remark"   value="<%=projectInfo.getAt("remark")%>"  >
</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">������ע</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="7">
				<input type="text"    size="160"  name="pidanremark" id="pidanremark"   value="<%=projectInfo.getAt("pidan_remark")%>" >
					
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">������ע</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="7">
					<input type="text"      size="160"  name="gdremark" id="gdremark"   value="<%=projectInfo.getAt("gd_remark")%>"  > 
				</td>
			</tr>
				<tr>
				<td nowrap="nowrap" align="center" width="7%">�ύ����</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="7">
					���� <input name="tag" type="radio" class="radio_1" value="1" checked="checked" >
	    ���沢�ύ<input type="radio" name="tag" class="radio_1" value="2" >
	    
	     <%if("admin".equals(request.getAttribute("role")) || "����".equals(request.getAttribute("role")) || "����".equals(request.getAttribute("role")) ){ %>
	     �˻� <input type="radio" name="tag" class="radio_1" value="3" >
			    <%} %>
	    		
	
	    
				</td>
			</tr>
			
			
			   
			  
			
  

			<tr>
				<!-- <td align="left">����</td>
				<td colspan="2"><input type="file" name="channelId"
					id="channelId" multiple="multiple" class="imagePath" /> <img alt=""
					src="" id="image1" class="showImage"></td> -->
					
						<td align="left" colspan="2">
						&nbsp;&nbsp;&nbsp;<input type="button" name="ok" accesskey="y" tabindex="y"  value="ȷ ��" class="but_1" onclick="onUpdate()">
	
      <input type="button" name="back" accesskey="b" tabindex="b" value="�� ��" class="but_1" onclick="location='doProjectInfo.do?method=queryProjectInfoXml'">
      <input type="reset" name="back" accesskey="b" tabindex="b" value="����" class="but_1" >
				</td>
			</tr>
			
              
				
			
		

</table>
</form>
</body>
</html>
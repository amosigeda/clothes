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
<!-- <table width="100%" border="0"cellpadding="0" cellspacing="1"  class="tbl_11"> -->
<table width="100%" class="tbl_11" border="1" bordercolorlight=#000000
			bordercolordark=#000000 bordercolor=#000000 cellspacing="0"
			cellpadding="2">
			
			
			<tr>
				<th colspan="8" nowrap="nowrap" align="left">�޸Ķ�����Ϣ</th>
			</tr>
			
<!--   <tr>
     <th colspan="3" nowrap="nowrap" align="left">
                           �޸Ķ�����Ϣ
     </th>
   </tr> -->
   
   <tr class="tr_11">
				<td colspan="8" nowrap="nowrap" align="center" width="7%">��һ���ƿͻ�����</td>
			</tr>

			<tr>
				<td align="left">�������</td>
				<td colspan="2" align="left"> 
		<input type="text"    readOnly="true"  readOnly="true"  size="20"  name="project_no1" id="project_no1" value=<%=projectInfo.getAt("order_id")%>>
				</td>
				<td align="left">������</td>
				<td colspan="2" align="left">
				<input type="text"    readOnly="true"  readOnly="true"  size="20"  name="projectNo" id="projectNo"  value=<%=projectInfo.getAt("ww_name")%>>
			</td>
				<td align="left">���ۼ۸�</td>
				<td align="left">
				<input type="text"    readOnly="true"  readOnly="true"  size="20"  name="salePrice" id="salePrice"  value=<%=projectInfo.getAt("sale_price")%>>
				</td>
			</tr>

			<tr>
				<td>΢����</td>
				<td colspan="2"><input type="text"    readOnly="true"  readOnly="true" size="20"  name="wechat" id="wechat"  value=<%=projectInfo.getAt("wechat")%>></td>
				<td>������</td>
				<td colspan="2">
                   <input type="text"    readOnly="true"  size="20"  readOnly="true"  name="orderNumber" id="orderNumber"  value=<%=projectInfo.getAt("order_number")%>>
</td>
				<td>�µ�ʱ��</td>
				<td>
				<input type="text"    readOnly="true"   readOnly="true" size="20"  name="project_no" id="project_no"   value="<%=projectInfo.getAt("add_time")%>"  >
				</td>
			</tr>


			<tr>
				<td>�ͻ��绰</td>
				<td colspan="2">
<input type="text"    readOnly="true"   size="20"  name="kehuPhone" id="kehuPhone"  readOnly="true"   value="<%=projectInfo.getAt("kehu_phone")%>"  >
</td>
				<td>��������</td>
				<td colspan="2">
	    
	    <input type="text"    readOnly="true"   size="20"  name="orderType" id="orderType"  readOnly="true"   value="<%=projectInfo.getAt("order_type")%>"  >
				</td>
				<td>����ʱ��</td>
				<td></td>
			</tr>


			<tr>
				<td>�ͻ�����</td>
				<td>
	<input type="text"    readOnly="true"   readOnly="true"  size="20"  name="kehuName" id="kehuName"   value="<%=projectInfo.getAt("kehu_name")%>"  >
</td>
				<td>����</td>
				<td>
					<%-- <input type="text"    readOnly="true"   size="20"  name="qudao" id="qudao"   value="<%=projectInfo.getAt("qudao")%>"  > --%>
				<%-- 		<input name="qudao" type="radio" class="radio_1" value="�Ա�" <%if("�Ա�".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>�Ա�
						<input name="qudao" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>����
						<input name="qudao" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>����
						<input name="qudao" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>����
						<input name="qudao" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>����
						<input name="qudao" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>����
						<input name="qudao" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>���� --%>
						   <input type="text"    readOnly="true"   size="20"  name="qudao" id="qudao"  readOnly="true"   value="<%=projectInfo.getAt("qudao")%>"  >
					<!-- <option value="�Ա�">�Ա�</option>
						<option value="����">����</option>
						<option value="����">����</option>
						<option value="����">����</option>
						<option value="����">����</option>
						<option value="����">����</option>
						<option value="����">����</option> -->
						
				</td>
				<td>�µ��ͷ�</td>
				<td>
				<input type="text"    readOnly="true"   readOnly="true"  size="20"  name="project_no" id="project_no"   value="<%=projectInfo.getAt("xiadan_kefu")%>"  >
				</td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>�ͻ���ַ</td>
				<td colspan="7">
<input type="text"    readOnly="true"     size="50"   readOnly="true" name="address" id="address"   value="<%=projectInfo.getAt("address")%>"  >
				</td>
			</tr>

			<tr>
				<td>���</td>
				<td>
				<input type="text"    readOnly="true"  readOnly="true"    size="20"  name="height" id="height"   value="<%=projectInfo.getAt("height")%>"  >
				</td>
				<td>����</td>
				<td>
					<input type="text"    readOnly="true"   readOnly="true"   size="20"  name="weight" id="weight"   value="<%=projectInfo.getAt("weight")%>"  >
					</td>
				<td>����</td>
				<td>
						<input type="text"    readOnly="true"    readOnly="true"  size="20"  name="age" id="age"   value="<%=projectInfo.getAt("age")%>"  >
					</td>
				<td>�Ա�</td>
				<td>
<%-- 	<input name="sex" type="radio" class="radio_1" value="��" <%if("��".equals("" + projectInfo.getAt("sex"))){%>checked<%}%>>��
	    <input name="sex" type="radio" class="radio_1" value="Ů" <%if("Ů".equals("" + projectInfo.getAt("sex"))){%>checked<%}%>>Ů --%>
	    
	      <input type="text"    readOnly="true"   size="20"  name="sex" id="sex"   value="<%=projectInfo.getAt("sex")%>"  >
</td>
			</tr>

			<tr>
				<td colspan="2">��װ����</td>
				<td>����</td>
				<td colspan="2">��������</td>
				<td>������</td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>���</td>
				<td>
						<input type="text"    readOnly="true"   readOnly="true"   size="20"  name="jiankuanA" id="jiankuanA"   value="<%=projectInfo.getAt("jiankuan_a")%>"  >
				</td>
				<td></td>
				<td>��Χ</td>
				<td>
						<input type="text"    readOnly="true"   readOnly="true"   size="20"  name="lingweiB" id="lingweiB"   value="<%=projectInfo.getAt("lingwei_b")%>"  >
					</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>��Χ</td>
				<td>
							<input type="text"    readOnly="true"   readOnly="true"   size="20"  name="xiongweiA" id="xiongweiA"   value="<%=projectInfo.getAt("xiongwei_a")%>"  >
				</td>
				<td></td>
				<td>��Χ</td>
				<td>
						<input type="text"    readOnly="true"    readOnly="true"  size="20"  name="xiongweiB" id="xiongweiB"   value="<%=projectInfo.getAt("xiongwei_b")%>"  >
				</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>����</td>
				<td>
						<input type="text"    readOnly="true"    readOnly="true"  size="20"  name="zhongyaoA" id="zhongyaoA"   value="<%=projectInfo.getAt("zhongyao_a")%>"  >
				</td>
				<td></td>
				<td>����</td>
				<td>
						<input type="text"    readOnly="true"   readOnly="true"   size="20"  name="zhongyaoA" id="zhongyaoA"   value="<%=projectInfo.getAt("zhongyao_a")%>"  >
				</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>��Χ</td>
				<td>
					<input type="text"    readOnly="true"    readOnly="true"  size="20"  name="fuweiA" id="fuweiA"   value="<%=projectInfo.getAt("fuwei_a")%>"  >
					</td>
				<td></td>
				<td>��Χ</td>
				<td>
						<input type="text"    readOnly="true"   readOnly="true"   size="20"  name="fuweiB" id="fuweiB"   value="<%=projectInfo.getAt("fuwei_b")%>"  >
					</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>�����³�</td>
				<td>
					<input type="text"    readOnly="true"   readOnly="true"   size="20"  name="houzhongyichangA" id="houzhongyichangA"   value="<%=projectInfo.getAt("houzhongyichang_a")%>"  >
					</td>
				<td></td>
				<td>�䳤</td>
				<td>
						<input type="text"    readOnly="true"   readOnly="true"   size="20"  name="xiuchangB" id="xiuchangB"   value="<%=projectInfo.getAt("xiuchang_b")%>"  >
				</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>ǰ�³�</td>
				<td>
						<input type="text"    readOnly="true"  readOnly="true"    size="20"  name="qianyichangA" id="qianyichangA"   value="<%=projectInfo.getAt("qianyichang_a")%>"  >
				</td>
				<td></td>
				<td>���</td>
				<td>
						<input type="text"    readOnly="true"   readOnly="true"   size="20"  name="xiufeiB" id="xiufeiB"   value="<%=projectInfo.getAt("xiufei_b")%>"  >
					</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>�䳤</td>
				<td>
						<input type="text"    readOnly="true"   readOnly="true"   size="20"  name="xiuchangA" id="xiuchangA"   value="<%=projectInfo.getAt("xiuchang_a")%>"  >
				</td>
				<td></td>
				<td>���</td>
				<td>
						<input type="text"    readOnly="true"   readOnly="true"   size="20"  name="xiukouB" id="xiukouB"   value="<%=projectInfo.getAt("xiukou_b")%>"  >
					</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>���</td>
				<td>
					<input type="text"    readOnly="true"    readOnly="true"  size="20"  name="xiufeiA" id="xiufeiA"   value="<%=projectInfo.getAt("xiufei_a")%>"  >
					</td>
				<td></td>
				<td>��ڿ�ʽ</td>
				<td>
						<input type="text"    readOnly="true"   readOnly="true"   size="20"  name="lingkoukuaishiB" id="lingkoukuaishiB"   value="<%=projectInfo.getAt("lingkoukuaishi_b")%>"  >
					</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>


			<tr>
				<td>���</td>
				<td>
						<input type="text"    readOnly="true"     size="20"  name="xiukouA" id="xiukouA"   value="<%=projectInfo.getAt("xiukou_a")%>"  >
					</td>
				<td></td>
				<td>�³�</td>
				<td>
						<input type="text"    readOnly="true"     size="20"  name="yichangB" id="yichangB"   value="<%=projectInfo.getAt("yichang_b")%>"  >
					</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td colspan="2">��������</td>
				<td>����</td>
				<td colspan="2">�������</td>
				<td>�����</td>
				<td></td>
				<td></td>
			</tr>


			<tr>
				<td>�㳤</td>
				<td>
					<input type="text"    readOnly="true"     size="20"  name="kuchangC" id="kuchangC"   value="<%=projectInfo.getAt("kuchang_c")%>"  >
					</td>
				<td></td>
				<td>��Χ</td>
				<td>
						<input type="text"    readOnly="true"     size="20"  name="xiongweiD" id="xiongweiD"   value="<%=projectInfo.getAt("xiongwei_d")%>"  >
				</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>


			<tr>
				<td>��Χ</td>
				<td>
						<input type="text"    readOnly="true"     size="20"  name="yaoweiC" id="yaoweiC"   value="<%=projectInfo.getAt("yaowei_c")%>"  >
					</td>
				<td></td>
				<td>����</td>
				<td>
						<input type="text"    readOnly="true"     size="20"  name="zhongyaoD" id="zhongyaoD"   value="<%=projectInfo.getAt("zhongyao_d")%>"  >
				</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>��Χ</td>
				<td>
						<input type="text"    readOnly="true"     size="20"  name="tuiweiC" id="tuiweiC"   value="<%=projectInfo.getAt("tuiwei_c")%>"  >
					</td>
				<td></td>
				<td>�³�</td>
				<td>
						<input type="text"    readOnly="true"     size="20"  name="yichangD" id="yichangD"   value="<%=projectInfo.getAt("yichang_d")%>"  >
					</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>


			<tr>
				<td>��Χ</td>
				<td>
						<input type="text"    readOnly="true"     size="20"  name="dangweiC" id="dangweiC"   value="<%=projectInfo.getAt("dangwei_c")%>"  >
					</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>����</td>
				<td>
						<input type="text"    readOnly="true"     size="20"  name="datuiC" id="datuiC"   value="<%=projectInfo.getAt("datui_c")%>"  >
					</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>


			<tr>
				<td>����</td>
				<td>
						<input type="text"    readOnly="true"     size="20"  name="zhongtuiC" id="zhongtuiC"   value="<%=projectInfo.getAt("zhongtui_c")%>"  >
				</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>


			<tr>
				<td>С��</td>
				<td>
						<input type="text"    readOnly="true"     size="20"  name="xiaotuiC" id="xiaotuiC"   value="<%=projectInfo.getAt("xiaotui_c")%>"  >
					</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>�ſ�</td>
				<td>
						<input type="text"    readOnly="true"     size="20"  name="tuikouC" id="tuikouC"   value="<%=projectInfo.getAt("tuikou_c")%>"  >
					</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>����</td>
				<td>
						<input type="text"    readOnly="true"     size="20"  name="kouxingC" id="kouxingC"   value="<%=projectInfo.getAt("kouxing_c")%>"  >
					</td>
				<td>��ɫ</td>
				<td>
					<input type="text"    readOnly="true"     size="20"  name="kouseC" id="kouseC"   value="<%=projectInfo.getAt("kouse_c")%>"  >
					</td>
				<td>����</td>
				<td>
<%-- 		<input name="kuanxingD" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>����
		<input name="kuanxingD" type="radio" class="radio_1" value="����+" <%if("����+".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>����+
		<input name="kuanxingD" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>����
		<input name="kuanxingD" type="radio" class="radio_1" value="����+" <%if("����+".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>����+
		<input name="kuanxingD" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>����
		<input name="kuanxingD" type="radio" class="radio_1" value="����+" <%if("����+".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>����+ --%>
		
		  <input type="text"    readOnly="true"   size="20"  name="kuanxingD" id="kuanxingD"   value="<%=projectInfo.getAt("kuanxing_d")%>"  >
				</td>
				<td>��ͷ</td>
				<td>
			<%-- 		<input name="botouD" type="radio" class="radio_1" value="��װ��" <%if("��װ��".equals("" + projectInfo.getAt("botou_d"))){%>checked<%}%>>��װ��
					<input name="botouD" type="radio" class="radio_1" value="ƽ����" <%if("ƽ����".equals("" + projectInfo.getAt("botou_d"))){%>checked<%}%>>ƽ����
					<input name="botouD" type="radio" class="radio_1" value="ꨲ���" <%if("ꨲ���".equals("" + projectInfo.getAt("botou_d"))){%>checked<%}%>>ꨲ���
					<input name="botouD" type="radio" class="radio_1" value="�����" <%if("�����".equals("" + projectInfo.getAt("botou_d"))){%>checked<%}%>>�����
					<input name="botouD" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("botou_d"))){%>checked<%}%>>����
					<input name="botouD" type="radio" class="radio_1" value="�л�����" <%if("�л�����".equals("" + projectInfo.getAt("botou_d"))){%>checked<%}%>>�л�����
					<input name="botouD" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("botou_d"))){%>checked<%}%>>���� --%>
					
					  <input type="text"    readOnly="true"   size="20"  name="botouD" id="botouD"   value="<%=projectInfo.getAt("botou_d")%>"  >
				</td>
			</tr>

			<tr>
				<td>�ڴ�</td>
				<td>
		<%-- 			<input name="koudaiC" type="radio" class="radio_1" value="˫��" <%if("˫��".equals("" + projectInfo.getAt("koudai_c"))){%>checked<%}%>>˫��
					<input name="koudaiC" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("koudai_c"))){%>checked<%}%>>����
					<input name="koudaiC" type="radio" class="radio_1" value="Ʊ��" <%if("Ʊ��".equals("" + projectInfo.getAt("koudai_c"))){%>checked<%}%>>Ʊ��
					<input name="koudaiC" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("koudai_c"))){%>checked<%}%>>���� --%>
					
					  <input type="text"    readOnly="true"   size="20"  name="koudaiC" id="koudaiC"   value="<%=projectInfo.getAt("koudai_c")%>"  >
				</td>
				<td>����</td>
				<td>
				   <%--  <input name="daigai" type="radio" class="radio_1" value="��" <%if("��".equals("" + projectInfo.getAt("dai_gai"))){%>checked<%}%>>��
					<input name="daigai" type="radio" class="radio_1" value="��" <%if("��".equals("" + projectInfo.getAt("dai_gai"))){%>checked<%}%>>��
					<input name="daigai" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("dai_gai"))){%>checked<%}%>>���� --%>
					
					  <input type="text"    readOnly="true"   size="20"  name="daigai" id="daigai"   value="<%=projectInfo.getAt("dai_gai")%>"  >
				</td>
				<td>ƽб��</td>
				<td>
			<%-- 	 <input name="pingxiedai" type="radio" class="radio_1" value="ƽ��" <%if("ƽ��".equals("" + projectInfo.getAt("pingxie_dai"))){%>checked<%}%>>ƽ��
				 <input name="pingxiedai" type="radio" class="radio_1" value="б��" <%if("б��".equals("" + projectInfo.getAt("pingxie_dai"))){%>checked<%}%>>б��
				 <input name="pingxiedai" type="radio" class="radio_1" value="����" <%if("����".equals("" + projectInfo.getAt("pingxie_dai"))){%>checked<%}%>>���� --%>
				 
				  <input type="text"    readOnly="true"   size="20"  name="pingxiedai" id="pingxiedai"   value="<%=projectInfo.getAt("pingxie_dai")%>"  >
				</td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>����1</td>
				<td>
				<input type="text"    readOnly="true"     size="20"  name="miaoliao1" id="miaoliao1"   value="<%=projectInfo.getAt("miao_liao1")%>"  >
				</td>
				<td>����</td>
				<td></td>
				<td>��;</td>
				<td>
					<input type="text"    readOnly="true"  size="20"  name="yongtu1" id="yongtu1"   value="<%=projectInfo.getAt("yong_tu1")%>"  >
					</td>
				<td>��Ӧ��</td>
				<td></td>
			</tr>

			<tr>
				<td>����2</td>
				<td>
						<input type="text"    readOnly="true"  size="20"  name="miaoliao2" id="miaoliao2"   value="<%=projectInfo.getAt("miao_liao2")%>"  >
				</td>
				<td>����</td>
				<td></td>
				<td>��;</td>
				<td>
						<input type="text"    readOnly="true"  size="20"  name="yongtu2" id="yongtu2"   value="<%=projectInfo.getAt("yong_tu2")%>"  >
					</td>
				<td>��Ӧ��</td>
				<td></td>
			</tr>

			<tr>
				<td>���ͱ�ע</td>
				<td colspan="3">
					<input type="text"    readOnly="true"  size="20"  name="tixingremark" id="tixingremark"   value="<%=projectInfo.getAt("tixing_remark")%>"  >
					</td>
				<td>��ע</td>
				<td colspan="3">
					<input type="text"    readOnly="true"  size="20"  name="remark" id="remark"   value="<%=projectInfo.getAt("remark")%>"  >
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
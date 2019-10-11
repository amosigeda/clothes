<%@ page language="java" contentType="text/html;charset=gb2312"%>
<%@ page import="com.godoing.rose.http.common.*"%>
<%@ page import="com.care.common.lang.*"%>
<%@ page import="com.care.common.config.Config"%>
<%@ page import="com.care.app.LoginUser"%>
<%@ taglib uri="/WEB-INF/struts-bean" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic" prefix="logic"%>
<%@ page autoFlush="true"%>
<%
	/*ҳ������*/
	PagePys pys = (PagePys) request.getAttribute("PagePys");
	LoginUser loginUser = (LoginUser)request.getSession().getAttribute(Config.SystemConfig.LOGINUSER); 
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<title>�ޱ����ĵ�</title>
		<link href="<%=request.getContextPath()%>/css/tbls.css"
			rel="stylesheet" type="text/css">
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/public/public.js"></script>   <!-- ���ô˷��� -->
		<script language="JavaScript" src="../../js/jquery-1.8.2.js"></script>
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/public/My97DatePicker/WdatePicker.js"></script>
	</head>
	<script language="javascript">
function finds(wechat){
	  document.getElementById("anniu").setAttribute("value", wechat);
    var st = new Date(frmGo.startTime.value.replace(/-/g,'/'));
	var et = new Date(frmGo.endTime.value.replace(/-/g,'/'));
	if(Date.parse(st) - Date.parse(et)>0){
		alert("��ʼʱ�䲻�ܴ��ڽ���ʱ��!");
		return false;
	} 
	   frmGo.submit();
}

function findss(wechat){
	  document.getElementById("anniu").setAttribute("value", wechat);
		
	   frmGo.submit();
}


function add(){
	frmGo.action = "doProjectInfo.do?method=initInsertxml";
	frmGo.submit();
}
function c(){
     document.all.startTime.value="";
     document.all.endTime.value="";
     document.all.orderId.value="";
     document.all.phone.value="";
    document.all.wwname.value="";
     /* document.all.userId.options[0].selected=true;
    document.all.projectId.options[0].selected=true; */
} 

function changeCompany(obj){
	$.ajax({
		type:"get",
		url:"doProjectInfo.do?method=getProjectByCompanyId",
		data:"companyId="+obj,
		success:function(msg){
			var projectSelect = document.getElementById("projectId");
			projectSelect.length=1;
			if(msg.trim() != ""){				
				var projects = msg.split("&");
				for(i=0;i<projects.length; i++){
					var project = projects[i].split(",");
					if(project.length == 2){
						projectSelect.options[projectSelect.length] = new Option(project[1],project[0]);
						
					}
					
				}
			}
			
		}
	});
}
function update(id){
	frmGo.action="doProjectInfo.do?method=initUpdatexml&id="+id;
	frmGo.submit();
}

function piDanUpdate(id){
	frmGo.action="doProjectInfo.do?method=piDanUpdateInit&id="+id;
	frmGo.submit();
}

function genDanUpdate(id){
	frmGo.action="doProjectInfo.do?method=genDanUpdateInit&id="+id;
	frmGo.submit();
}
function xiangQing(id){
	frmGo.action="doProjectInfo.do?method=xiangQing&id="+id;
	frmGo.submit();
}


function pidanTuiHui(id){
	if(confirm("ȷ���˻���?"))
	{
		frmGo.action="doProjectInfo.do?method=pidanTuiHui&id="+id;
		frmGo.submit();
	}
}

function gendanTuiHui(id){
	if(confirm("ȷ���˻���?"))
	{
		frmGo.action="doProjectInfo.do?method=gendanTuiHui&id="+id;
		frmGo.submit();
	}
}


function deletee(id){
	if(confirm("ȷ��ɾ����?"))
	{
		frmGo.action="doProjectInfo.do?method=deletexml&id="+id;
		frmGo.submit();
	}
	/* frmGo.action="doProjectInfo.do?method=deletexml&id="+id;
	frmGo.submit(); */
}
function keFuTijiao(id){
	if(confirm("ȷ���ύ��?"))
	{
		frmGo.action="doProjectInfo.do?method=keFuTijiao&id="+id;
		frmGo.submit();
	}
}

function genDanTiJiao(id){
	if(confirm("ȷ���ύ��?"))
	{
		frmGo.action="doProjectInfo.do?method=genDanTiJiao&id="+id;
		frmGo.submit();
	}
}


function pidanTijiao(id){
	if(confirm("ȷ���ύ��?"))
	{
		frmGo.action="doProjectInfo.do?method=pidanTijiao&id="+id;
		frmGo.submit();
	}
}

function  updatedangAnStatus(id,status){
	if(confirm("ȷ������?"))
	{
		frmGo.action="doProjectInfo.do?method=updatedangAnStatus&id="+id+"&status="+status;
		frmGo.submit();
	}
}
function ofuncs(projectId){
	window.open("projectRoleFuncFrame.jsp?projectId=" + i);
	//window.showModalDialog("roleFuncFrame.jsp?roleCode=" + rcode,		"","help:0;resizable:0;status=0;scrollbars=0;dialogWidth=25;dialogHeight=35;center=true");;
}

/* function daDan(id,orderid){
		frmGo.action="doProjectInfo.do?method=daDan&id="+id+"&orderid="+orderid;;
		frmGo.submit();
} */
</script>
	<body>
		<span class="title_1"></span>
		<form name="frmGo" method="post" action="doProjectInfo.do?method=queryProjectInfoXml">
			
			<table width="100%" class="table" border=0 cellpadding="0" cellspacing="1">
               <tr>
                <th colspan="50" nowrap="nowrap" align="left">
                                               ������Ϣ
                                                <%if("admin".equals(request.getAttribute("role")) || "�ͷ�".equals(request.getAttribute("role")) || "����".equals(request.getAttribute("role")) ){ %>
                                                	
                     <input type="button" class="but_1" accesskey="a"
							tabindex="a" value="�� ��" onclick="add()">
							 <%} %>	
                </th>
                </tr>
                 <tr class="title_3">
        <td colspan="50">          
              <%--    ������
						    <input id="wwname" name="wwname" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"wwname");%>" size="20"> --%>
						      ����ʱ��
                     <input  name="startTime" type="text" class="txt_1"  id="startTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"fNow_date");%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
								size="20" readonly> -
							<input  style="border:none;" name="endTime" type="text" class="txt_1" id="endTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"now_date");%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
								size="20" readonly>	
								     
								       ������
						    <input id="orderId" name="orderId" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"orderId");%>" size="20">
						    
								                  �ֻ���
						    <input id="phone" name="phone" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"phone");%>" size="20">
						    
                 ������
						    <input id="wwname" name="wwname" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"wwname");%>" size="20">
						    
						    <input name="find1" type="button" class="but_1" accesskey="f" title="1"
							tabindex="f" value="�� ��" onclick="javascript:finds(this.title)">
					     <input name="clear" type="button" class="but_1" accesskey="c"
						    tabindex="c"  value="�������" onclick="c()">
						    
						    <input name="find2" type="button" class="but_1" accesskey="f"  title="2"
							tabindex="f" value="����EXCEL" onclick="javascript:findss(this.title)">
						    
						    <input name="anniu" size="200" id="anniu"
					 type="hidden" class="txt_1"  />
                  <%--      <td colspan="13">
					  ����ʱ��
                     <input name="startTime" type="text" class="txt_1"  id="startTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"fNow_date");%>" onclick="WdatePicker()"
								size="9" readonly> -
							<input name="endTime" type="text" class="txt_1" id="endTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"now_date");%>" onclick="WdatePicker()"
								size="9" readonly>						
						�ͻ�
							<%String userId = (String)request.getAttribute("userId"); %>
							<select id="userId" name="userId" onchange="changeCompany(this.value)">
								<option value="">ȫ��</option>
								<logic:iterate id="com" name="company">
									<bean:define id="company" name="com" property="id" type="java.lang.Integer" />																	
									<option value='<%=company %>' <%=String.valueOf(company).equals(userId)? "selected" : "" %>><bean:write name="com" property="company_name"/></option>
								</logic:iterate>
							</select>
						��Ŀ��		
						<%String projectId = (String)request.getAttribute("projectId"); %>			
							<select id="projectId" name="projectId" >
								<option value="">ȫ��</option>
								<logic:iterate id="pro" name="project">
									<bean:define id="project" name="pro" property="id" type="java.lang.Integer" />																	
									<option value='<%=project %>' <%=String.valueOf(project).equals(projectId)? "selected" : "" %>><bean:write name="pro" property="project_name"/></option>
								</logic:iterate>
							</select>							
						<input name="find1" type="button" class="but_1" accesskey="f"
							tabindex="f" value="�� ��" onclick="javascript:finds()">
					     <input name="clear" type="button" class="but_1" accesskey="c"
						    tabindex="c"  value="�������" onclick="c()"> --%>
				</tr> 
				<%int i=1; %>
                  <tr class="title_2">
                 	<td width="5%">
						ϵͳ���ɶ������
					</td> 
					<td width="5%">
					������
					</td> 
					<td width="5%">
					������
					</td> 
					<td width="5%">
					�ֻ���
					</td> 
						<td width="5%">
					���ۼ۸�
					</td> 
						<td width="5%">
					΢����
					</td>
					
					<td width="5%">
					��������
					</td>
						<td width="5%">
					����
					</td>
					
					<td width="5%">
					�Ա�
					</td>
					<td width="5%">
					�µ�ʱ��
					</td>
						<td width="5%">
					�µ��ͷ�
					</td>
						<td width="5%">
					״̬
					</td>
					<td width="5%">
						����ʱ��
					</td>
					<td width="5%">
						������ע
					</td>
					<td width="5%">
						����ʱ��
					</td>
					
					
             <td width="5%">
						����
					</td>
				
					
				</tr>
 
				<logic:iterate id="element" name="pageList">
					<tr class="tr_5" onmouseover='this.className="tr_4"'
						onmouseout='this.className="tr_5"'>
						<td>							
							<bean:write name="element" property="order_id" />
						</td>
						<td>							
							<bean:write name="element" property="order_number" />
						</td>
						<td>							
							<bean:write name="element" property="ww_name" />
						</td>
						<td>							
							<bean:write name="element" property="kehu_phone" />
						</td>
						<td>							
							<bean:write name="element" property="sale_price" />
						</td>
						<td>							
							<bean:write name="element" property="wechat" />
						</td>
					
						<td>							
							<bean:write name="element" property="order_type" />
						</td>
						<td>							
							<bean:write name="element" property="qudao" />
						</td>
					
						
							<td>							
							<bean:write name="element" property="sex" />
						</td>
							<td>								
							<bean:write name="element" property="add_time" format="yyyy-MM-dd HH:mm:ss"/>
						</td>
							<td>							
							<bean:write name="element" property="xiadan_kefu" />
						</td>
						<td>
						   <logic:empty name="element" property="status">��</logic:empty>							
							<logic:equal name="element" property="status" value="1"><font color="green">�ͷ�����</font></logic:equal>							
							<logic:equal name="element" property="status" value="2"><font color="green">�ͷ��ύ</font></logic:equal>							
							<logic:equal name="element" property="status" value="3"><font color="green">��������</font></logic:equal>
							<logic:equal name="element" property="status" value="4"><font color="red">�����˻�</font></logic:equal>
							<logic:equal name="element" property="status" value="5"><font color="green">�����ύ</font></logic:equal>
							<logic:equal name="element" property="status" value="6"><font color="green">��������</font></logic:equal>
							<logic:equal name="element" property="status" value="7"><font color="green">�����ύ</font></logic:equal>
							<logic:equal name="element" property="status" value="8"><font color="red">�����˻�</font></logic:equal>
							<logic:equal name="element" property="status" value="9"><font color="green">�����ύ</font></logic:equal>
							<logic:equal name="element" property="status" value="10"><font color="green">�ֿ��Ѿ���׼������</font></logic:equal>
						</td>
						
							<%-- <td>							
							<bean:write name="element" property="status" />
						</td> --%>
							<td>			
							<bean:write name="element" property="pidan_time" format="yyyy-MM-dd HH:mm:ss"/>				
						</td>
						<td>			
							<bean:write name="element" property="pidan_remark"/>				
						</td>
						
						<td>			
							<bean:write name="element" property="jiaoLiao_time" format="yyyy-MM-dd HH:mm:ss"/>				
						</td>
						
						
						
						 
						 
						<td>
						<a href=# onclick="xiangQing('<bean:write name="element" property="id" />')" style="color:#0000FF" > [����]</a>
						
						<%if("admin".equals(request.getAttribute("role"))){ %>
						
						<logic:equal name="element" property="status" value="1">	
   							<a href=# onclick="update('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�ͷ��޸�]</a>
   							 <%-- 	<a href=# onclick="keFuTijiao('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�ͷ��ύ]</a> --%>
   							 <a href=# onclick="deletee('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�ͷ�ɾ��]</a> 
   							 
   							 	<%-- <a href=# onclick="piDanUpdate('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�����޸�]</a> --%>
   						</logic:equal>	
   						
   						
   								<logic:equal name="element" property="status" value="2">	
   							 	<a href=# onclick="update('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�����޸�]</a>
   							 		<%-- <a href=# onclick="pidanTuiHui('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�����˻�]</a> --%>
   							 		<%-- 	<a href=# onclick="pidanTijiao('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�����ύ]</a> --%>
   						</logic:equal>	
   						
   					<!-- 	1�ͷ�����  2�ͷ��ύ  3��������  4�����˻�   5�����ύ -->
   								<logic:equal name="element" property="status" value="3">	
   							 	<a href=# onclick="update('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�����޸�]</a>
   							 		<%-- <a href=# onclick="pidanTuiHui('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�����˻�]</a> --%>
   							 			<%-- <a href=# onclick="pidanTijiao('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�����ύ]</a> --%>
   						</logic:equal>	
   						
   						
   									<logic:equal name="element" property="status" value="8">	
   							 	<a href=# onclick="update('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�����޸�]</a>
   							 	<%-- 	<a href=# onclick="pidanTuiHui('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�����˻�]</a> --%>
   							 		<%-- 	<a href=# onclick="pidanTijiao('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�����ύ]</a> --%>
   						</logic:equal>	
   						
   						
   							<logic:equal name="element" property="status" value="4">	
   							<a href=# onclick="update('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�ͷ��޸�]</a>
   							 <%-- 	<a href=# onclick="keFuTijiao('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�ͷ��ύ]</a> --%>
   							 
   							<%--  	<a href=# onclick="piDanUpdate('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�����޸�]</a> --%>
   							 
   						</logic:equal>	
   						
   						
   						
   							<logic:equal name="element" property="status" value="5">	
   							 	<%-- <a href=# onclick="gendanTuiHui('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�����˻�]</a> --%>
   							 	<a href=# onclick="update('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�����޸�]</a>
   						</logic:equal>	
   						
   						
   								<logic:equal name="element" property="status" value="6">	
   							 <%-- 	<a href=# onclick="gendanTuiHui('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�����˻�]</a> --%>
   							 	<a href=# onclick="update('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�����޸�]</a>
   							 <%-- 	<a href=# onclick="genDanTiJiao('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�����ύ]</a> --%>
   						</logic:equal>	
   						
   						
   						<logic:equal name="element" property="status" value="9">	
   							 <%-- 	<a href=# onclick="updatedangAnStatus('<bean:write name="element" property="id" />',10)" style="color:#0000FF" > [����]</a>
   							 	<a href=# onclick="genDanUpdate('<bean:write name="element" property="id" />')" style="color:#0000FF" > [���]</a> --%>
   							 	<a href=# onclick="updatedangAnStatus('<bean:write name="element" property="id" />',10)" style="color:#0000FF" > [����]</a>
   							 	<%-- <logic:equal name="element" property="socket_way" value="0">	
   							  	<a href=# onclick="daDan('<bean:write name="element" property="id" />','<bean:write name="element" property="order_id" />')" style="color:#0000FF" > [��]</a>
   							 		</logic:equal>	 --%>
   						</logic:equal>	
   						
   						
   						
   						
   							<logic:equal name="element" property="status" value="10">	
   							 	<logic:empty name="element" property="fujian_url">��</logic:empty>
							<logic:notEmpty name="element" property="fujian_url">
							       <a href="<bean:write name="element" property="fujian_url" />" title="zip" style="color:#0000FF">[��]</a>	
							</logic:notEmpty>
   						</logic:equal>	
							
						
						 <%} %>	
						 
						 
						 
						 
						 <%if("�ͷ�".equals(request.getAttribute("role"))){ %>
						<logic:equal name="element" property="status" value="1">	
   							<a href=# onclick="update('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�ͷ��޸�]</a>
   							 <%-- 	<a href=# onclick="keFuTijiao('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�ͷ��ύ]</a> --%>
   							 <a href=# onclick="deletee('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�ͷ�ɾ��]</a> 
   						</logic:equal>	
   						
   						<logic:equal name="element" property="status" value="4">	
   							<a href=# onclick="update('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�ͷ��޸�]</a>
   							 <%-- 	<a href=# onclick="keFuTijiao('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�ͷ��ύ]</a> --%>
   							 <a href=# onclick="deletee('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�ͷ�ɾ��]</a> 
   						</logic:equal>	
   						
   							<logic:equal name="element" property="status" value="3">	
   							<a href=# onclick="update('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�ͷ��޸�]</a>
   							 <%-- 	<a href=# onclick="keFuTijiao('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�ͷ��ύ]</a> --%>
   							 <a href=# onclick="deletee('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�ͷ�ɾ��]</a> 
   						</logic:equal>	
   						
   							<logic:equal name="element" property="status" value="10">	
   							 	<logic:empty name="element" property="fujian_url">��</logic:empty>
							<logic:notEmpty name="element" property="fujian_url">
							       <a href="<bean:write name="element" property="fujian_url" />" title="zip" style="color:#0000FF">[��]</a>	
							</logic:notEmpty>
   						</logic:equal>	
   						
   						
   						 <%} %>	
   						 
   						 
   						 
   						 <%if("����".equals(request.getAttribute("role"))){ %>
						<logic:equal name="element" property="status" value="2">	
   							 	<a href=# onclick="update('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�����޸�]</a>
   							 		<%-- <a href=# onclick="pidanTuiHui('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�����˻�]</a> --%>
   							 			<%-- <a href=# onclick="pidanTijiao('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�����ύ]</a> --%>
   						</logic:equal>	
   						<logic:equal name="element" property="status" value="3">	
   							 	<a href=# onclick="update('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�����޸�]</a>
   							 	<%-- 	<a href=# onclick="pidanTuiHui('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�����˻�]</a> --%>
   							 			<%-- <a href=# onclick="pidanTijiao('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�����ύ]</a> --%>
   						</logic:equal>	
   						
   						<logic:equal name="element" property="status" value="8">	
   							 	<a href=# onclick="update('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�����޸�]</a>
   							 	<%-- 	<a href=# onclick="pidanTuiHui('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�����˻�]</a> --%>
   							 			<%-- <a href=# onclick="pidanTijiao('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�����ύ]</a> --%>
   						</logic:equal>	
   						
   						
   								<logic:equal name="element" property="status" value="10">	
   							 	<logic:empty name="element" property="fujian_url">��</logic:empty>
							<logic:notEmpty name="element" property="fujian_url">
							       <a href="<bean:write name="element" property="fujian_url" />" title="zip" style="color:#0000FF">[��]</a>	
							</logic:notEmpty>
   						</logic:equal>	
   						
   							
							
   						 <%} %>	
   						 
   						 
   						 
   						 
   						 	  <%if("����".equals(request.getAttribute("role"))){ %>
						
							<logic:equal name="element" property="status" value="5">	
   							 <%-- 	<a href=# onclick="gendanTuiHui('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�����˻�]</a> --%>
   							 	<a href=# onclick="update('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�����޸�]</a>
   							 	<%-- 	<a href=# onclick="genDanTiJiao('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�����ύ]</a> --%>
   						</logic:equal>	
   						
   						
   								<logic:equal name="element" property="status" value="6">	
   							 <%-- 	<a href=# onclick="gendanTuiHui('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�����˻�]</a> --%>
   							 	<a href=# onclick="update('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�����޸�]</a>
   							 <%-- 	<a href=# onclick="genDanTiJiao('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�����ύ]</a> --%>
   						</logic:equal>	
   						
   					<logic:equal name="element" property="status" value="9">	
   							 	<a href=# onclick="updatedangAnStatus('<bean:write name="element" property="id" />',10)" style="color:#0000FF" > [����]</a> 
   							 <%-- 	<a href=# onclick="updatedangAnStatus('<bean:write name="element" property="id" />',11)" style="color:#0000FF" > [���]</a> --%>
   							 	<%-- <logic:equal name="element" property="socket_way" value="0">	
   							  	<a href=# onclick="daDan('<bean:write name="element" property="id" />','<bean:write name="element" property="order_id" />')" style="color:#0000FF" > [��]</a>
   							 		</logic:equal>	 --%>
   						</logic:equal>	
   						
   								<logic:equal name="element" property="status" value="10">	
   							 	<logic:empty name="element" property="fujian_url">��</logic:empty>
							<logic:notEmpty name="element" property="fujian_url">
							       <a href="<bean:write name="element" property="fujian_url" />" title="zip" style="color:#0000FF">[��]</a>	
							</logic:notEmpty>
   						</logic:equal>	
   						
   							<logic:equal name="element" property="status" value="11">	
   							 	<logic:equal name="element" property="socket_way" value="0">	
   							  	<a href=# onclick="daDan('<bean:write name="element" property="id" />','<bean:write name="element" property="order_id" />')" style="color:#0000FF" > [��]</a>
   							 		</logic:equal>	
   						</logic:equal>	
   						 <%} %>	
   						 
   						 
   						 
   						  <%if("����".equals(request.getAttribute("role"))){ %>
						<logic:equal name="element" property="status" value="1">	
   							<a href=# onclick="update('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�ͷ��޸�]</a>
   							 <%-- 	<a href=# onclick="keFuTijiao('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�ͷ��ύ]</a> --%>
   							 <a href=# onclick="deletee('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�ͷ�ɾ��]</a> 
   						</logic:equal>	
   						<logic:equal name="element" property="status" value="4">	
   							<a href=# onclick="update('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�ͷ��޸�]</a><%-- 
   							 	<a href=# onclick="keFuTijiao('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�ͷ��ύ]</a> --%>
   							 <a href=# onclick="deletee('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�ͷ�ɾ��]</a> 
   						</logic:equal>	
   						
   							<logic:equal name="element" property="status" value="3">	
   							<a href=# onclick="update('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�ͷ��޸�]</a>
   							 	<%-- <a href=# onclick="keFuTijiao('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�ͷ��ύ]</a> --%>
   							 <a href=# onclick="deletee('<bean:write name="element" property="id" />')" style="color:#0000FF" > [�ͷ�ɾ��]</a> 
   						</logic:equal>	
   						
   							<logic:equal name="element" property="status" value="10">	
   							 	<logic:empty name="element" property="fujian_url">��</logic:empty>
							<logic:notEmpty name="element" property="fujian_url">
							       <a href="<bean:write name="element" property="fujian_url" />" title="zip" style="color:#0000FF">[��]</a>	
							</logic:notEmpty>
   						</logic:equal>	
   						 <%} %>	 
   						
   						</td>
   						 
   						 
					</tr>
				</logic:iterate>

			  	<tr class="title_3">
					<td colspan="20" align="left" >  
						<%
							pys.printGoPage(response, "frmGo");
						%>
					</td>
				</tr>  
			</table>
		</form>
	</body>
</html>
<%@ page language="java" contentType="text/html;charset=gb2312"%>
<%@ page import="com.godoing.rose.http.common.*"%>
<%@ page import="com.care.common.lang.*"%>
<%@ page import="com.care.common.config.Config"%>
<%@ page import="com.care.app.LoginUser"%>
<%@ taglib uri="/WEB-INF/struts-bean" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic" prefix="logic"%>
<%@ page autoFlush="true"%>
<%
	/*页面属性*/
	PagePys pys = (PagePys) request.getAttribute("PagePys");
	LoginUser loginUser = (LoginUser)request.getSession().getAttribute(Config.SystemConfig.LOGINUSER); 
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<title>无标题文档</title>
		<link href="<%=request.getContextPath()%>/css/tbls.css"
			rel="stylesheet" type="text/css">
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/public/public.js"></script>   <!-- 调用此方法 -->
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/public/My97DatePicker/WdatePicker.js"></script>
	</head>
	<script language="javascript">
function finds(){
    var st = new Date(frmGo.startTime.value.replace(/-/g,'/'));
	var et = new Date(frmGo.endTime.value.replace(/-/g,'/'));
	if(Date.parse(st) - Date.parse(et)>0){
		alert("开始时间不能大于结束时间!");
		return false;
	}
	   frmGo.submit();
}
function c(){
    document.all.startTime.value="";
    document.all.endTime.value="";
    document.all.user.value="";   
    document.getElementById("belongProject").options[0].selected=true;
} 
function onView(download){
	if(download.length == 0){
		alert("没有头像文件，无法下载！");
		return false;
	}
	frmGo.action="doAppUserInfo.do?method=downloadApk&download="+download;
   	frmGo.submit();
}


function deletee(id){
	if(confirm("确定删除吗?"))
	{
		frmGo.action="doAppUserInfo.do?method=deleteinfo&id="+id;
		frmGo.submit();
	}
}

function update(id){
	if(confirm("确定吗?"))
	{
		frmGo.action="doAppUserInfo.do?method=updateInfo&id="+id;
		frmGo.submit();
	}
}
</script>
	<body>
		<span class="title_1"></span>
		<form name="frmGo" method="post" action="doAppUserInfo.do?method=queryAppUserInfo">						
		
			<table width="100%" class="table" border=0 cellpadding="0" cellspacing="1">
               <tr>
                <th colspan="15" nowrap="nowrap" align="left">
                    扫码用户信息
                </th>
                </tr>
                <% if(request.getAttribute("user_id") == null){%>
                 <tr class="title_3">
                       <td colspan="15">
					  注册时间
                     <input name="startTime" type="text" class="txt_1"  id="startTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"fNow_date");%>" onclick="WdatePicker()"
								size="9" readonly> -
							<input name="endTime" type="text" class="txt_1" id="endTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"now_date");%>" onclick="WdatePicker()"
								size="9" readonly>						
						手机号				
						    <input id="user" name="user" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"user");%>" size="9">
						<%-- 项目
							<%String belongProject = (String)request.getAttribute("belongProject"); %>
							<select id="belongProject" name="belongProject">
								<option value="">全部</option>
								<logic:iterate id="pro" name="project">
									<bean:define id="projectId" name="pro" property="id" type="java.lang.Integer" />																	
									<option value='<%=projectId %>' <%=String.valueOf(projectId).equals(belongProject)? "selected" : "" %>><bean:write name="pro" property="project_name"/></option>
								</logic:iterate>
							</select> --%>
						<input name="find1" type="button" class="but_1" accesskey="f"
							tabindex="f" value="搜 索" onclick="javascript:finds()">
					     <input name="clear" type="button" class="but_1" accesskey="c"
						    tabindex="c"  value="清除搜索" onclick="c()">
				</tr> 
				<%} %>
                  <tr class="title_2"> 
                  	<td width="9%" >注册时间</td>
                  	<td width="8%" >手机号</td> 
                  	<td width="6%" >公司</td>  
                  	<td width="6%" >姓名</td>
                 
                  	<td width="8%" >微信号</td>
                  	<td width="8%" >工种</td>
                  	<td width="8%" >状态</td>
                    <td width="8%" >备注</td>
                    <td width="8%" >操作</td>
                     <!-- <td width="8%" >头像</td> -->
             
				</tr>
 
				<logic:iterate id="element" name="pageList">
					<tr class="tr_5" onmouseover='this.className="tr_4"' onmouseout='this.className="tr_5"' >
						<td>
						<logic:empty name="element" property="create_time">无</logic:empty>
						<logic:notEmpty name="element" property="create_time">
						<bean:write name="element" property="create_time" format="yyyy-MM-dd HH:mm:ss"/>
						</logic:notEmpty>
						</td>
						<td><bean:write name="element" property="user_name"/></td>
						<td>
						<logic:empty name="element" property="first_name">无</logic:empty>
						<logic:notEmpty name="element" property="first_name">
									<bean:write name="element" property="first_name"/>
					</logic:notEmpty>
						</td>
						
						<td>
						<logic:empty name="element" property="nick_name">无</logic:empty>
						<logic:notEmpty name="element" property="nick_name">
						<bean:write name="element" property="nick_name" />
						</logic:notEmpty>
						</td>
					
						<td>
						<logic:empty name="element" property="password" >无</logic:empty>
						<logic:notEmpty name="element" property="password">
						<bean:write name="element" property="password" />
						</logic:notEmpty></td>
						
						<td>
						<logic:empty name="element" property="last_name">无</logic:empty>
							<logic:equal name="element" property="last_name" value="1">裁床</logic:equal>		
							<logic:equal name="element" property="last_name" value="2">前道开包</logic:equal>		
							<logic:equal name="element" property="last_name" value="3">后道</logic:equal>		
							<logic:equal name="element" property="last_name" value="4">大烫</logic:equal>		
							<logic:equal name="element" property="last_name" value="5">质检</logic:equal>		
							<logic:equal name="element" property="last_name" value="6">发货</logic:equal>		
							<logic:equal name="element" property="last_name" value="7">售后修改</logic:equal>		
								
						</td>
							<td>
						
							<logic:equal name="element" property="status" value="0"><font color="red">待确认</font></logic:equal>		
							<logic:equal name="element" property="status" value="1">正常</logic:equal>		
						</td>
						
						<td>
						
						<logic:empty name="element" property="email">无</logic:empty>
						<logic:notEmpty name="element" property="email">
						<bean:write name="element" property="email" />
						</logic:notEmpty></td>																				
						
						<%-- 	<td>
							<logic:empty name="element" property="head">无</logic:empty>
							<logic:notEmpty name="element" property="head">
								<a href=# onclick="onView('<bean:write name="element" property="head"/>')" style="color:#0000FF">下载</a>
							</logic:notEmpty>							
						</td> --%>
						
						<td>
						<logic:equal name="element" property="status" value="0"><font color="red">	<a href=# onclick="update('<bean:write name="element" property="id" />')" style="color:#0000FF" > [同意]</a></font></logic:equal>		
					
						<a href=# onclick="deletee('<bean:write name="element" property="id" />')" style="color:#0000FF" > [删除]</a>
						</td>
					</tr>
				</logic:iterate> 

			  	<tr class="title_3">
					<td colspan="15" align="left" >  
						<%
							pys.printGoPage(response, "frmGo");
						%>
					</td>
				</tr>  
			</table>
		</form>
	</body>
</html>
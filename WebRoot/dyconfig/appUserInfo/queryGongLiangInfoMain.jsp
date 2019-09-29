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
    document.all.phone.value="";   
    document.all.gongzhong.value="";   
} 
function onView(download){
	if(download.length == 0){
		alert("没有头像文件，无法下载！");
		return false;
	}
	frmGo.action="doAppUserInfo.do?method=downloadApk&download="+download;
   	frmGo.submit();
}
</script>
	<body>
		<span class="title_1"></span>
		<form name="frmGo" method="post" action="doAppUserInfo.do?method=queryGongLiangInfo">						
		
			<table width="100%" class="table" border=0 cellpadding="0" cellspacing="1">
               <tr>
                <th colspan="15" nowrap="nowrap" align="left">
                    工量信息
                </th>
                </tr>
                <% if(request.getAttribute("user_id") == null){%>
                 <tr class="title_3">
                       <td colspan="15">
					扫码时间
                     <input name="startTime" type="text" class="txt_1"  id="startTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"fNow_date");%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
								size="15" readonly> -
							<input name="endTime" type="text" class="txt_1" id="endTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"now_date");%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
								size="15" readonly>						
						手机号				
						    <input id="phone" name="phone" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"phone");%>" size="15">
						    工种			
						    <input id="gongzhong" name="gongzhong" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"gongzhong");%>" size="15">
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
                  	<td width="9%" >订单id</td>
                  	<td width="9%" >扫码时间</td>
                  	<td width="8%" >手机号</td> 
                  	<td width="8%" >微信号</td>
                  	<td width="8%" >姓名</td>
                  	<td width="8%" >工种</td>
                  	<td width="8%" >类型</td>
             
				</tr>
 
				<logic:iterate id="element" name="pageList">
					<tr class="tr_5" onmouseover='this.className="tr_4"' onmouseout='this.className="tr_5"' >
					
				<td><bean:write name="element" property="order_id"/></td>
						
						<td>
						<logic:empty name="element" property="create_time">无</logic:empty>
						<logic:notEmpty name="element" property="create_time">
						<bean:write name="element" property="create_time" format="yyyy-MM-dd HH:mm:ss"/>
						</logic:notEmpty>
						</td>
						<td><bean:write name="element" property="user_name"/></td>
						
						<td>
						<logic:empty name="element" property="password">无</logic:empty>
						<logic:notEmpty name="element" property="password">
									<bean:write name="element" property="password"/>
					</logic:notEmpty>
						</td>
						
						
						<td>
						<logic:empty name="element" property="nick_name">无</logic:empty>
						<logic:notEmpty name="element" property="nick_name">
						<bean:write name="element" property="nick_name" />
						</logic:notEmpty>
						</td>
					
					
						
						<td>
						<logic:empty name="element" property="last_name">无</logic:empty>
						<logic:notEmpty name="element" property="last_name">
						<bean:write name="element" property="last_name" />
						</logic:notEmpty>
						</td>
						
							<td>
						<logic:empty name="element" property="clothes_type">无</logic:empty>
						<logic:notEmpty name="element" property="clothes_type">
						<bean:write name="element" property="clothes_type" />
						</logic:notEmpty>
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
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
			src="<%=request.getContextPath()%>/public/public.js"></script>
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/js/jquery.js"></script>
	</head>
<script language="javascript">
function finds(){
	frmGo.submit();
}
function c(){
    document.all.wwname.value="";
} 

</script>
	<body>

		<form name="frmGo" method="post"
			action="doDeviceActiveInfo.do?method=queryCallInfo">
			<table width="100%" class="table" >
               <tr>
                   <th colspan="13" nowrap="nowrap" align="left">�ļ����� 
                   
                  <!--  <input name="inset" type="button" class="but_1" accesskey="a"
							tabindex="a" value="��ӽ�ɫ" onclick="insert()"> --></th>
                </tr>  
                
                  <tr class="title_3">
        <td colspan="13">          
                 ������
						    <input id="wwname" name="wwname" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"wwname");%>" size="20">
						    
						    <input name="find1" type="button" class="but_1" accesskey="f"
							tabindex="f" value="�� ��" onclick="javascript:finds()">
					     <input name="clear" type="button" class="but_1" accesskey="c"
						    tabindex="c"  value="�������" onclick="c()">
				</tr> 
				       
                  <tr class="title_2">
								
					<td width="10%">
						������
					</td>
					<td width="10%">
							����
					</td>
					<td width="10%">
						����ļ�
					</td>
						<td width="10%">
						��ά��ZIP
					</td>
					<td width="10%" >
					��ά��1
					</td>
					<td width="10%">
						��ά��2
					</td>
					<td width="10%">
						��ά��3
					</td>
					<td width="10%">
						��ά��4
					</td>
					
					
				</tr>
				<logic:iterate id="element" name="pageList">
					<tr class="tr_5" onmouseover='this.className="tr_4"' onmouseout='this.className="tr_5"' >
						<td>
							<bean:write name="element" property="orderid" />
						</td>
						<td>
							<logic:empty name="element" property="fujian">��</logic:empty>
							<logic:notEmpty name="element" property="fujian">
								 <a href="<bean:write name="element" property="fujian"/>" title="zip" style="color:#0000FF">�����ء�</a> 
							</logic:notEmpty>
						</td>
						<td>
							<logic:empty name="element" property="dabiao_file">��</logic:empty>
							<logic:notEmpty name="element" property="dabiao_file">
								 <a href="<bean:write name="element" property="dabiao_file"/>" title="zip" style="color:#0000FF">�����ء�</a> 
							</logic:notEmpty>
						</td>
						<td>
						<logic:empty name="element" property="erweima_zip">��</logic:empty>
							<logic:notEmpty name="element" property="erweima_zip">
								 <a href="<bean:write name="element" property="erweima_zip"/>" title="zip" style="color:#0000FF">�����ء�</a> 
							</logic:notEmpty>
						</td>
						<td>
							<logic:empty name="element" property="erweima_1">��</logic:empty>
							<logic:notEmpty name="element" property="erweima_1">
								<img src="<bean:write name="element" property="erweima_1"/>"  style="vertical-align:bottom"  width = "150px" height = "150px"></img> 
							</logic:notEmpty>
						</td>
						<td>
						<logic:empty name="element" property="erweima_2">��</logic:empty>
							<logic:notEmpty name="element" property="erweima_2">
									<img src="<bean:write name="element" property="erweima_2"/>"  style="vertical-align:bottom"  width = "150px" height = "150px"></img> 
							</logic:notEmpty>
						</td>
						<td>
						<logic:empty name="element" property="erweima_3">��</logic:empty>
							<logic:notEmpty name="element" property="erweima_3">
								<img src="<bean:write name="element" property="erweima_3"/>"  style="vertical-align:bottom"  width = "150px" height = "150px"></img> 
							</logic:notEmpty>
						</td>
						<td>
						<logic:empty name="element" property="erweima_4">��</logic:empty>
							<logic:notEmpty name="element" property="erweima_4">
									<img src="<bean:write name="element" property="erweima_4"/>"  style="vertical-align:bottom"  width = "150px" height = "150px"></img> 
							</logic:notEmpty>
						</td>
						
					</tr>
				</logic:iterate>
			 	<tr class="title_3">
					<td colspan="8" align="left" >
						<%
							pys.printGoPage(response, "frmGo");
						%>
					</td>
				</tr>  
			</table>
		</form>
	</body>
</html>

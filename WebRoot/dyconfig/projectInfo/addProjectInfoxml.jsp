<%@ page language="java" contentType="text/html;charset=GB2312"%>
<%@ page autoFlush="true" %>
<%@ page import="com.care.app.LoginUser"%>
<%@ page import="com.care.common.config.Config"%>
<%@ taglib uri="/WEB-INF/struts-bean" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic" prefix="logic"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="<%=request.getContextPath()%>/css/tbls.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/public/public.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery-1.8.2.js" type="text/javascript"></script> 
<title>�ޱ����ĵ�</title>
</head>
<script type="text/javascript">
function onAdd(){
	/* if(frmGo.projectNo.value.trim() == ""){
		alert("��Ŀ��Ų���Ϊ�գ�����������");
		frmGo.projectNo.focus();
		return false;
	}
	if(frmGo.projectName.value.trim() == ""){
		alert("��Ŀ���Ʋ���Ϊ�գ�����������");
		frmGo.projectName.focus();
		return false;
	} */
	frmGo.submit();
} 

function preViews(){
    document.getElementById('preView').style.display="none"
	 document.getElementById('rePicture').style.display="none"
	 document.getElementById('pictureView').style.display="block"
}
/* $(document).ready(function(){ 
$("#province").change(function(){ 
$("#province option").each(function(i,o){ 
if($(this).attr("selected")) 
{ 
$(".city").hide(); 
$(".city").eq(i).show(); 
} 
}); 
}); 
$("#province").change(); 
});  */
</script>
<body>
<span class="title_1"></span>
<form name="frmGo" method="post" action="doProjectInfo.do?method=insertProjectInfoxml" encType="multipart/form-data"  onsubmit="return onAdd()">
<% LoginUser loginUser = (LoginUser)request.getSession().getAttribute(Config.SystemConfig.LOGINUSER);
	String loginUserCode = loginUser.getUserCode();
%>
<!-- <input type="hidden" name="addUser" value="<%=loginUserCode %>"> -->
<!-- <table width="100%" border="0"cellpadding="0" cellspacing="0"  class="tbl_11" > -->
<table width="100%" class="tbl_11" border="1" bordercolorlight=#000000 bordercolordark=#000000 bordercolor=#000000 cellspacing="0" cellpadding="2" >
  <tr>
        <th colspan="8" nowrap="nowrap" align="left">
                                    ��Ӷ�����Ϣ(�ͻ�����)
        </th>
       </tr>
       
       <tr class="tr_11">
<td colspan="8" nowrap="nowrap" align="center" width="7%">��һ���ƿͻ�����</td>
</tr>

<tr>  
<td align="left">�������</td>
<td colspan="2" align="left"></td>
<td align="left">������</td>
<td colspan="2" align="left" ><input name="projectNo" size="20" id="projectNo" type="text" class="txt_1" maxlength="30"/><font color="red">*</font></td>
<td align="left">���ۼ۸�</td>
<td align="left"> <input name="salePrice" size="20" id="salePrice" type="text" class="txt_1"maxlength="30"/><font color="red">*</font></td>
</tr>

<tr>  
<td>΢����</td>
<td colspan="2"><input name="wechat" size="20" id="wechat" type="text" class="txt_1" maxlength="30"/><font color="red">*</font></td>
<td>������</td>
<td colspan="2">
<input name="orderNumber" size="20" id="orderNumber" type="text" class="txt_1" maxlength="30"/><font color="red">*</font>
</td>
<td>�µ�ʱ��</td>
<td></td>
</tr>


<tr>  
<td>�ͻ��绰</td>
<td colspan="2"><input name="kehuPhone" size="20" id="kehuPhone" type="text" class="txt_1" maxlength="30"/><font color="red">*</font></td>
<td>��������</td>
<td colspan="2">
<input name="orderType" size="20" id="orderType" type="text" class="txt_1" maxlength="30"/><font color="red">*</font>
</td>
<td>����ʱ��</td>
<td></td>
</tr>


<tr>  
<td>�ͻ�����</td>
<td>
<input name="kehuName" size="50" id="kehuName" type="text" class="txt_1" maxlength="100"/><font color="red">*</font>
</td>
<td>����</td>
<td>
<input name="qudao" size="50" id="qudao" type="text" class="txt_1" maxlength="100"/><font color="red">*</font>
</td>
<td>�µ��ͷ�</td>
<td></td>
<td></td>
<td></td>
</tr>

<tr>  
<td>�ͻ���ַ</td>
<td colspan="7">
<input name="address" size="50" id="qudao" type="text" class="txt_1" maxlength="100"/><font color="red">*</font>
</td>
</tr>

<tr>  
<td>���</td>
<td></td>
<td>����</td>
<td></td>
<td>����</td>
<td></td>
<td>�Ա�</td>
<td></td>
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
<td></td>
<td></td>
<td>��Χ</td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>

<tr>  
<td>��Χ</td>
<td></td>
<td></td>
<td>��Χ</td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>

<tr>  
<td>����</td>
<td></td>
<td></td>
<td>����</td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>

<tr>  
<td>��Χ</td>
<td></td>
<td></td>
<td>��Χ</td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>

<tr>  
<td>�����³�</td>
<td></td>
<td></td>
<td>�䳤</td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>

<tr>  
<td>ǰ�³�</td>
<td></td>
<td></td>
<td>���</td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>

<tr>  
<td>ǰ�³�</td>
<td></td>
<td></td>
<td>���</td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>

<tr>  
<td>�䳤</td>
<td></td>
<td></td>
<td>���</td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>

<tr>  
<td>���</td>
<td></td>
<td></td>
<td>��ڿ�ʽ</td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>


<tr>  
<td>���</td>
<td></td>
<td></td>
<td>�³�</td>
<td></td>
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
<td></td>
<td></td>
<td>��Χ</td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>


<tr>  
<td>��Χ</td>
<td></td>
<td></td>
<td>����</td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>

<tr>  
<td>��Χ</td>
<td></td>
<td></td>
<td>�³�</td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>


<tr>  
<td>��Χ</td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>

<tr>  
<td>����</td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>


<tr>  
<td>����</td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>


<tr>  
<td>С��</td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>

<tr>  
<td>�ſ�</td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>

<tr>  
<td>����</td>
<td></td>
<td>��ɫ</td>
<td></td>
<td>����</td>
<td></td>
<td>��ͷ</td>
<td></td>
</tr>

<tr>  
<td>�ڴ�</td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>

<tr>  
<td>����</td>
<td></td>
<td>����</td>
<td></td>
<td>��;</td>
<td></td>
<td>��Ӧ��</td>
<td></td>
</tr>

<tr>  
<td>������</td>
<td></td>
<td>����</td>
<td></td>
<td>��;</td>
<td></td>
<td>��Ӧ��</td>
<td></td>
</tr>

<tr>  
<td>���ͱ�ע</td>
<td colspan="3"></td>
<td>��ע</td>
<td colspan="3"></td>
</tr>

 <tr class="tr_11">
  <td width="7%"></td>
    <td align="left" colspan="2">&nbsp;&nbsp;&nbsp;<input type="button" name="ok"accesskey="y" tabindex="y"  value="ȷ ��" class="but_1" onclick="onAdd()" style="font-size:12;width:40px;height:21px;">
      <input type="button" name="back"accesskey="b" tabindex="b" value="�� ��" class="but_1" onclick="location='doProjectInfo.do?method=queryProjectInfoXml'" style="font-size:12;width:40px;height:21px;">
    </td>
  </tr>
</table>

</form>
</body>
</html>
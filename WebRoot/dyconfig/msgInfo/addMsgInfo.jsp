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
<script language="JavaScript" src="<%=request.getContextPath()%>/public/public.js"></script>
<title>�ޱ����ĵ�</title>
</head>
<script language="javascript">
function onAdd(){
	/* if(frmGo.name.value.trim() == ""){
		alert("���Ʋ���Ϊ�գ�����������");
		frmGo.name.focus();
		return false;
	}
	if(frmGo.mName.value.trim() == ""){
		alert("Ӣ�����Ʋ���Ϊ�գ�����������");
		frmGo.mName.focus();
		return false;
	} */
	frmGo.submit();
}

</script>
<body>
<span class="title_1"></span>
<form name="frmGo" method="post" action="doMsgInfo.do?method=insertMsgInfo" onsubmit="return onAdd()">
<% LoginUser loginUser = (LoginUser)request.getSession().getAttribute(Config.SystemConfig.LOGINUSER);
	String loginUserCode = loginUser.getUserCode();
%>
<!-- <input type="hidden" name="addUser" value="<%=loginUserCode %>"> -->
<table width="100%" border="0"cellpadding="0" cellspacing="1"  class="tbl_11">
  <tr>
        <th colspan="3" nowrap="nowrap" align="left">
                                   ����ۺ�
        </th>
       </tr>
  <tr class="tr_11">
    <td align="left" width="7%">&nbsp;&nbsp;ԭ������</td>
    <td align="left" width="20%" colspan="2">
      <input name="order_id" id="order_id" type="text" class="txt_1"maxlength="20"/></font>
    </td>
    </tr>
  
   <tr class="tr_11">
    <td align="left" width="7%">&nbsp;&nbsp;�û��ֻ���</td>
    <td align="left" width="20%" colspan="2">
      <input name="phone" id="phone" type="text" class="txt_1"maxlength="20"><font color="red">*</font>
    </td>
  </tr>
  
    <tr class="tr_11">
    <td align="left" width="7%">&nbsp;&nbsp;��������</td>
    <td align="left" width="20%" colspan="2">
      <input name="fahuo_wuliu" id="fahuo_wuliu" type="text" class="txt_1"maxlength="20"><font color="red">*</font>
    </td>
  </tr>
     <tr class="tr_11">
    <td align="left" width="7%">&nbsp;&nbsp;��������</td>
    <td align="left" width="20%" colspan="2">
      <input name="wuliu_bianma" id="wuliu_bianma" type="text" class="txt_1"maxlength="20"><font color="red">*</font>
    </td>
  </tr>

  
  <tr class="tr_11">
    <td align="left" width="7%">&nbsp;&nbsp;��ע</td>
    <td align="left" width="20%" >
      <textarea name="remark" id="remark" rows="5" cols="50" class="txt_1"></textarea>
    </td>
    <td><font color="red"></font></td>
  </tr>
  
  <tr class="tr_11">
  	<td></td><td></td>
  </tr>
  <tr class="tr_11">
  <td width="7%"></td>
    <td align="left" colspan="2">&nbsp;&nbsp;&nbsp;
    <input type="button" name="ok"accesskey="y" tabindex="y"  value="ȷ ��" class="but_1" onclick="onAdd()" style="font-size:12;width:40px;height:21px;">
    <input type="reset" name="reset"accesskey="y" tabindex="y"  value="����" class="but_1"  style="font-size:12;width:40px;height:21px;">
      <input type="button" name="back"accesskey="b" tabindex="b" value="�� ��" class="but_1" onclick="location='doMsgInfo.do?method=queryMsgInfo'" style="font-size:12;width:40px;height:21px;">
  
    </td>
  </tr>
</table>
</form>
</body>
</html>
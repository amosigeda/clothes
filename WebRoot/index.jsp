<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" contentType="text/html;charset=gb2312"%>
<%
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript" src="public/g_js.js"></script>
<title> ��¼��һ���ƺ���¬������ϵͳ </title>
<link href="css/styles.css" rel="stylesheet" type="text/css">
</head>
<script language="javascript">
function loadimage(){ 
document.getElementById("randImage").src = "image.jsp?"+Math.random(); 
altet(Math.random());
} 
function checkSpace(str){
	for (var i = 0; i < str.length; i++) {
		if (str.charAt(i) == ' ') {
			return false;
		}
	}
	return true;
}
function check(){
	if (frmLogon.code.value ==""){
		alert("�û�������Ϊ�գ�");
		frmLogon.code.focus();
		return false;
	}
	if (frmLogon.paw.value ==""){
		alert("���벻��Ϊ�գ�");
		frmLogon.paw.focus();
		return false;
	}
	if (frmLogon.paw.value !=""){
	  if (!checkSpace(frmLogon.paw.value)){
		alert("���벻���пո�");
		frmLogon.paw.focus();
	  return false;
	  }
	}
	return true;
}
	
function submit(){  
	if(!check()){
	   return false;
	}
	frmLogon.submit();
}

function clears(){
	frmLogon.code.value = "";
	frmLogon.paw.value = "";	
	frmLogon.rand.value = "";
}
</script>
<body>
<div class="loginpage">
<form name="frmLogon" method="post" action="validate.jsp" onSubmit="return check()">
	<div class="loginBox">
		<h2>��һ���ƺ���¬��</h2>
		<div class="loginBox_input">
			<div class="LB_group">
				<label>�� ��</label>
				<input type="text" name="code" value="" placeholder="�������û���">
			</div>
			<div class="LB_group">
				<label>�� ��</label>
				<input type="password" name="paw" value="" placeholder="����������">
			</div>
			<div class="LB_btn">
				<input class="btn" type="submit" name="b1" value="ȷ��">
    			<input class="btn" type="button" name="b2" value="���" onClick="javascript:clears()">
			</div>
		</div>
	</div>
</form>
</div>
</body>
<script language="javascript" type="text/javascript">
frmLogon.code.focus();
</script>
</html>

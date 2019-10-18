<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" contentType="text/html;charset=gb2312"%>
<%@ page autoFlush="true" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>欢迎使用不一订制和周卢江管理系统</title>
<link href="css/style1.css" rel="stylesheet" type="text/css">
<SCRIPT language="javascript">
top.moveTo(0,0);
top.resizeTo(screen.availWidth ,screen.availHeight);
</script>
</head>
<!-- noresize="noresize" -->
<frameset rows="45,*,20" cols="*" name="main" frameborder="NO" border="0" framespacing="0">
  <frame src="Top.jsp" name="topFrame" scrolling="NO"  noresize="noresize">
  <frameset cols="10%,90%" frameborder="NO" border="0" framespacing="0" id=setyou>
    <frame src="Left.jsp" name="leftFrame" scrolling="NO" noresize="noresize">
	<!--  <frame src="L.htm" name="lFrame" scrolling="NO" noresize>-->
    <frame src="About.htm" name="mainFrame" noresize class="main_con">
  </frameset>
  <frame src="down.html" name="bottomFrame" scrolling="No"  id="bottomFrame" noresize="noresize"/>
</frameset><noframes></noframes>

</html>
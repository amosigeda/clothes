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
<title>无标题文档</title>
</head>
<script type="text/javascript">
function onAdd(){
	/* if(frmGo.projectNo.value.trim() == ""){
		alert("项目编号不能为空，请重新输入");
		frmGo.projectNo.focus();
		return false;
	}
	if(frmGo.projectName.value.trim() == ""){
		alert("项目名称不能为空，请重新输入");
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
                                    添加订单信息(客户档案)
        </th>
       </tr>
       
       <tr class="tr_11">
<td colspan="8" nowrap="nowrap" align="center" width="7%">不一定制客户档案</td>
</tr>

<tr>  
<td align="left">订单编号</td>
<td colspan="2" align="left"></td>
<td align="left">旺旺名</td>
<td colspan="2" align="left" ><input name="projectNo" size="20" id="projectNo" type="text" class="txt_1" maxlength="30"/><font color="red">*</font></td>
<td align="left">销售价格</td>
<td align="left"> <input name="salePrice" size="20" id="salePrice" type="text" class="txt_1"maxlength="30"/><font color="red">*</font></td>
</tr>

<tr>  
<td>微信名</td>
<td colspan="2"><input name="wechat" size="20" id="wechat" type="text" class="txt_1" maxlength="30"/><font color="red">*</font></td>
<td>订单号</td>
<td colspan="2">
<input name="orderNumber" size="20" id="orderNumber" type="text" class="txt_1" maxlength="30"/><font color="red">*</font>
</td>
<td>下单时间</td>
<td></td>
</tr>


<tr>  
<td>客户电话</td>
<td colspan="2"><input name="kehuPhone" size="20" id="kehuPhone" type="text" class="txt_1" maxlength="30"/><font color="red">*</font></td>
<td>订单类型</td>
<td colspan="2">
<input name="orderType" size="20" id="orderType" type="text" class="txt_1" maxlength="30"/><font color="red">*</font>
</td>
<td>交付时间</td>
<td></td>
</tr>


<tr>  
<td>客户姓名</td>
<td>
<input name="kehuName" size="50" id="kehuName" type="text" class="txt_1" maxlength="100"/><font color="red">*</font>
</td>
<td>渠道</td>
<td>
<input name="qudao" size="50" id="qudao" type="text" class="txt_1" maxlength="100"/><font color="red">*</font>
</td>
<td>下单客服</td>
<td></td>
<td></td>
<td></td>
</tr>

<tr>  
<td>客户地址</td>
<td colspan="7">
<input name="address" size="50" id="qudao" type="text" class="txt_1" maxlength="100"/><font color="red">*</font>
</td>
</tr>

<tr>  
<td>身高</td>
<td></td>
<td>体重</td>
<td></td>
<td>年龄</td>
<td></td>
<td>性别</td>
<td></td>
</tr>

<tr>  
<td colspan="2">西装数量</td>
<td>衣码</td>
<td colspan="2">衬衫数量</td>
<td>衬衫码</td>
<td></td>
<td></td>
</tr>

<tr>  
<td>肩宽</td>
<td></td>
<td></td>
<td>领围</td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>

<tr>  
<td>胸围</td>
<td></td>
<td></td>
<td>胸围</td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>

<tr>  
<td>中腰</td>
<td></td>
<td></td>
<td>中腰</td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>

<tr>  
<td>腹围</td>
<td></td>
<td></td>
<td>腹围</td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>

<tr>  
<td>后中衣长</td>
<td></td>
<td></td>
<td>袖长</td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>

<tr>  
<td>前衣长</td>
<td></td>
<td></td>
<td>袖肥</td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>

<tr>  
<td>前衣长</td>
<td></td>
<td></td>
<td>袖肥</td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>

<tr>  
<td>袖长</td>
<td></td>
<td></td>
<td>袖口</td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>

<tr>  
<td>袖肥</td>
<td></td>
<td></td>
<td>领口款式</td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>


<tr>  
<td>袖口</td>
<td></td>
<td></td>
<td>衣长</td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>

<tr>  
<td colspan="2">西裤数量</td>
<td>库码</td>
<td colspan="2">马甲数量</td>
<td>马甲码</td>
<td></td>
<td></td>
</tr>


<tr>  
<td>裤长</td>
<td></td>
<td></td>
<td>胸围</td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>


<tr>  
<td>腰围</td>
<td></td>
<td></td>
<td>中腰</td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>

<tr>  
<td>臀围</td>
<td></td>
<td></td>
<td>衣长</td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>


<tr>  
<td>档围</td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>

<tr>  
<td>大腿</td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>


<tr>  
<td>中腿</td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>


<tr>  
<td>小腿</td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>

<tr>  
<td>脚口</td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>

<tr>  
<td>扣型</td>
<td></td>
<td>扣色</td>
<td></td>
<td>款型</td>
<td></td>
<td>驳头</td>
<td></td>
</tr>

<tr>  
<td>口袋</td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>

<tr>  
<td>面料</td>
<td></td>
<td>米数</td>
<td></td>
<td>用途</td>
<td></td>
<td>供应商</td>
<td></td>
</tr>

<tr>  
<td>田面料</td>
<td></td>
<td>米数</td>
<td></td>
<td>用途</td>
<td></td>
<td>供应商</td>
<td></td>
</tr>

<tr>  
<td>体型备注</td>
<td colspan="3"></td>
<td>备注</td>
<td colspan="3"></td>
</tr>

 <tr class="tr_11">
  <td width="7%"></td>
    <td align="left" colspan="2">&nbsp;&nbsp;&nbsp;<input type="button" name="ok"accesskey="y" tabindex="y"  value="确 定" class="but_1" onclick="onAdd()" style="font-size:12;width:40px;height:21px;">
      <input type="button" name="back"accesskey="b" tabindex="b" value="返 回" class="but_1" onclick="location='doProjectInfo.do?method=queryProjectInfoXml'" style="font-size:12;width:40px;height:21px;">
    </td>
  </tr>
</table>

</form>
</body>
</html>
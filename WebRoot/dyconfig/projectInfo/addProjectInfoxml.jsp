<%@ page language="java" contentType="text/html;charset=GB2312"%>
<%@ page autoFlush="true"%>
<%@ page import="com.care.app.LoginUser"%>
<%@ page import="com.care.common.config.Config"%>
<%@ taglib uri="/WEB-INF/struts-bean" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic" prefix="logic"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="<%=request.getContextPath()%>/css/tbls.css" rel="stylesheet"
	type="text/css">
<script type="text/javascript"
	src="<%=request.getContextPath()%>/public/public.js"></script>
	<scripttype="text/javascript"src="http://code.jquery.com/jquery-1.4.1.min.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery-1.8.2.js"
	type="text/javascript"></script>
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/public/My97DatePicker/WdatePicker.js"></script>
<title>�ޱ����ĵ�</title>
</head>
<!-- <style>
select
{outline: none;border: none;
appearance: none;
-moz-appearance: none;
-webkit-appearance: none;
}
</style> -->

<script type="text/javascript">

$(document).ready(function(){
	 $("#orderNumber").blur(function(){
		 var userCodeValue = $("#orderNumber").val().trim();
		 $.ajax({
			 type:"post",
			 url:"doProjectInfo.do?method=verfyDingDan",
		 	 data:"userCode="+userCodeValue,
		 	 success:function(msg){
		 		 if(msg=="fail"){
		 			alert("�������ظ�������");
		 			 $("#orderNumber").focus();
		 			 return false;
		 		 }
		 	 }
		 });
	 });
});

	 
function setSecond(obj){
	  var val = obj.value;
	  if(val == "˫�Ŷ���һ" || val == "˫���Ŀ۶�" ||  val == "˫�����۶�"){
	    var sec = document.getElementById("xiabai");
	    sec.innerHTML = "<option>ֱ���°�</option><option>Բ���°�</option><option>��Բ���°�</option><option>��β�°�</option><option>����</option>";
	    
/* 		<option value="Բ���°�">Բ���°�</option>
		<option value="ֱ���°ڣ�˫�ſ�Ĭ�ϣ�">ֱ���°ڣ�˫�ſ�Ĭ�ϣ�</option>
		<option value="��Բ���°�">��Բ���°�</option>
		<option value="��β�°�">��β�°�</option>
		<option value="����">����</option> */
		
	  }else{
	    var sec = document.getElementById("xiabai");
	    sec.innerHTML = "<option>��</option><option>ֱ���°�</option><option>Բ���°�</option><option>��Բ���°�</option><option>��β�°�</option><option>����</option>";
	  }
	}
	
	
	function onAdd(wechat) {
		   document.getElementById("anniu").setAttribute("value", wechat);
		   
		if(frmGo.orderNumber.value.trim() == ""){
			alert("�����Ų���Ϊ�գ�");
			frmGo.orderNumber.focus();
			return false;
		} 
		frmGo.submit();
	}
	function onAddd(wechat) {
		   document.getElementById("anniu").setAttribute("value", wechat);
		   
		if(frmGo.orderNumber.value.trim() == ""){
			alert("�����Ų���Ϊ�գ�");
			frmGo.orderNumber.focus();
			return false;
		}
		if(frmGo.kehuPhone.value.trim() == ""){
			alert("�ͻ��绰Ϊ�գ�");
			frmGo.kehuPhone.focus();
			return false;
		}
		frmGo.submit();
	}

	function preViews() {
		document.getElementById('preView').style.display = "none"
		document.getElementById('rePicture').style.display = "none"
		document.getElementById('pictureView').style.display = "block"
	}
	
    function InserTab() {
        var trLen = $("#tab1 tr").length;
        var rowT = "<tr><td><input type=text style='width:90px;' value='' id='d" + trLen + "'></td>" +
            "<td><input type=text style='width:90px;' value='' id='d1" + trLen + "'></td>" +
            "<td><input type=text style='width:90px;' value='' id='d2" + trLen + "'></td>" +
            "<td><input type=text style='width:90px;' value='' id='d3" + trLen + "'></td></tr>";
        var trPre = $("#tab1 tr:eq(" + (trLen - 1) + ")");
        $(rowT).insertAfter($(trPre));
    }
    
    function setwechat(wechat) {
        document.getElementById("xiongweiB").setAttribute("value", wechat);
        document.getElementById("xiongweiD").setAttribute("value", wechat);
    }

    function setzhongyao(wechat) {
        document.getElementById("zhongyaoB").setAttribute("value", wechat);
        document.getElementById("zhongyaoD").setAttribute("value", wechat);
    }
    
    
    function setfuwei(wechat) {
        document.getElementById("fuweiB").setAttribute("value", wechat);
    }
    
    function setanniu(wechat) {
        document.getElementById("anniu").setAttribute("value", wechat);
    }
    
</script>
<body>
	<span class="title_1"></span>
	<form name="frmGo" method="post"
		action="doProjectInfo.do?method=insertUserDangAn"
		encType="multipart/form-data" onsubmit="return onAdd()">
		<%
			LoginUser loginUser = (LoginUser) request.getSession()
					.getAttribute(Config.SystemConfig.LOGINUSER);
			String loginUserCode = loginUser.getUserCode();
		%>
		<!-- <input type="hidden" name="addUser" value="<%=loginUserCode%>"> -->
		<!-- <table width="100%" border="0"cellpadding="0" cellspacing="0"  class="tbl_11" > -->
		
		
    
	<table width="100%"  id="tb1"  class="tbl_11" border="1" bordercolorlight=#000000  bordercolordark=#000000  bordercolor=#000000 cellspacing="0"  cellpadding="2"> 
	
	
    		  
		

			<tr>
				<th colspan="8" nowrap="nowrap" align="left">��Ӷ�����Ϣ(�ͻ�����) </th>
			</tr>

			<tr class="tr_11">
				<td colspan="8" nowrap="nowrap" align="center" width="7%">��һ���ƺ���¬��   �ͻ���Ϣ������</td>
			</tr>
			
			<tr>
				<td colspan="4" nowrap="nowrap" align="center" width="7%">������Ϣ</td>
				<td colspan="4" nowrap="nowrap" align="center" width="7%">������Ϣ</td>
			</tr>
			
			<tr>
				<td nowrap="nowrap" align="center" width="7%">�������</td>
				<td nowrap="nowrap" align="center" width="7%"><%=request.getAttribute("dingdan")%></td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="qudao" value="qudao">
						<option value="�Ա�">�Ա�</option>
						<option value="����">����</option>
						<option value="����">����</option>
						<option value="����">����</option>
						<option value="����">����</option>
						<option value="����">����</option>
						<option value="����">����</option>
				</select> <font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td  nowrap="nowrap" align="center" width="7%">
				<input name="age" size="50" id="age" type="number" 
					class="txt_1" maxlength="100" /><font color="red"></font>
					</td>
				<td nowrap="nowrap" align="center" width="7%">�ͻ��绰</td>	
				<td  nowrap="nowrap" align="center" width="7%">
				<input name="kehuPhone" size="38"  
					id="kehuPhone" type="text" class="txt_1" maxlength="30" /><font
					color="red"></font>
					</td>
			</tr>
			
				<tr>
				<td nowrap="nowrap" align="center" width="7%">΢�ź�</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="wechat" size="38" id="wechat"
					type="text" class="txt_1" maxlength="30" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%">�µ��ͷ�</td>
				<td nowrap="nowrap" align="center" width="7%"><%=request.getAttribute("userName")%></td>
				<td nowrap="nowrap" align="center" width="7%">�Ա�</td>
				<td  nowrap="nowrap" align="center" width="7%">
				<select name="sex" value="sex">
						<option value="��">��</option>
						<option value="Ů">Ů</option>
				</select> <font color="red"></font>
					</td>
				<td nowrap="nowrap" align="center" width="7%">�ͻ�����</td>	
				<td  nowrap="nowrap" align="center" width="7%">
			<input name="kehuName" size="38" id="kehuName" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font>
					</td>
			</tr>
			
			<tr>
				<td nowrap="nowrap" align="center" width="7%">������</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="orderNumber" size="38"
					id="orderNumber" type="text" class="txt_1" maxlength="30" /><font
					color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%">���ۼ۸�</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="salePrice" size="38"
					id="salePrice" type="text" class="txt_1" maxlength="30" /><font
					color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%">���</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="height" size="38" id="height" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="weight" size="38" id="weight" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">������</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="projectNo" size="38"
					id="projectNo" type="text" class="txt_1" maxlength="30" /><font
					color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%">�µ�ʱ��</td>
				<td nowrap="nowrap" align="left" width="7%"><%=request.getAttribute("shijian")%>  </td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="2">�ͻ���ַ</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="3" rowspan="2"><input name="address" size="90" id="address"
					type="text" class="txt_1" /><font color="red"></font></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">��������</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="orderType" value="orderType">
						<option value="�µ�">�µ�</option>
						<option value="����">����</option>
						<option value="����">����</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">����ʱ��</td>
				<td nowrap="nowrap" align="left" width="7%">
				
			<!-- 	<input name="startTime1" type="text" class="txt_1"  id="startTime1" style="cursor:text"
								 onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
								size="20" readonly> -->
					
				<select name="jiaofu_time"  id="jiaofu_time" >
						<option value="10">+10��  �Ӽ�</option>
						<option value="5">+5��  �ر�Ӽ�</option>
						<option value="3">+3��   �ǳ�����</option>
				</select> <font color="red"><span id="uNameSpan"></span></font>
				</td>
			
				
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">��װ����</td>
				<td nowrap="nowrap" align="left" width="7%">
				<input name="xizhuang_number" size="38" id="xizhuang_number" type="number"
					class="txt_1" maxlength="100" /><font color="red"></font>
			</td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" width="7%">��������</td>
				<td nowrap="nowrap" align="left" width="7%">
				<input name="chenshan_number" size="38" id="chenshan_number" type="number"
					class="txt_1" maxlength="100" /><font color="red"></font>
				</td>
				<td nowrap="nowrap" align="center" width="7%">������</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">���</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="jiankuanA" size="38" id="jiankuanA"
					type="text" class="txt_1" maxlength="100" /></td>
				<td nowrap="nowrap" align="center" width="7%">
					<input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  />
				</td>
				<td nowrap="nowrap" align="center" width="7%"  rowspan="4">
					<img src="http://47.111.148.8/watch/upload/test.png" width="100" height="100" />
					</td>
				<td nowrap="nowrap" align="center" width="7%">��Χ</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="lingweiB" size="38" id="lingweiB" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"> <input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="4">
					<img src="http://47.111.148.8/watch/upload/test.png" width="100" height="100" />
					</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">��Χ</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="xiongweiA" size="38" id="xiongweiA"
					type="text" class="txt_1" maxlength="100" onchange="setwechat(this.value)" /><font color="red"></font></td>
				
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" width="7%">��Χ</td>
				<td nowrap="nowrap" align="center" width="7%">
			<input name="xiongweiB" size="38" id="xiongweiB"
					type="text" class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
			<input name="zhongyaoA" size="38" id="zhongyaoA"
					type="text" class="txt_1" maxlength="100"  onchange="setzhongyao(this.value)" /><font color="red"></font></td>
				
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
		<input name="zhongyaoB" size="38" id="zhongyaoB"
					type="text" class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">��Χ</td>
				<td nowrap="nowrap" align="center" width="7%">
		<input name="fuweiA" size="38" id="fuweiA" type="text"
					class="txt_1" maxlength="100" onchange="setfuwei(this.value)" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				
				<td nowrap="nowrap" align="center" width="7%">��Χ</td>
				<td nowrap="nowrap" align="center" width="7%">
	<input name="fuweiB" size="38" id="fuweiB" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">�����³�</td>
				<td nowrap="nowrap" align="center" width="7%">
	<input name="houzhongyichangA" size="38" id="houzhongyichangA" type="text" class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="5"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" width="7%">�³�</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input  name="yichangB2" size="38" type="text" class="txt_1"maxlength="50" >
				</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="5"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
			</tr>
				<tr>
				<td nowrap="nowrap" align="center" width="7%">ǰ�³�</td>
				<td nowrap="nowrap" align="center" width="7%">
	<input name="qianyichangA" size="38" id="qianyichangA"
					type="text" class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
			
				<td nowrap="nowrap" align="center" width="7%">��Χ</td>
				<td nowrap="nowrap" align="center" width="7%">
				 <input style="border:none;" name="fuwei_quea" size="38" type="text" class="txt_1"maxlength="50" >
				</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">�䳤</td>
				<td nowrap="nowrap" align="center" width="7%">
	<input name="xiuchangB" size="38" id="xiuchangB"
					type="text" class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
			
				<td nowrap="nowrap" align="center" width="7%">�䳤</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="xiuchangA" size="38" id="xiuchangA"
					type="text" class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
			
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">���</td>
				<td nowrap="nowrap" align="center" width="7%">
	<input name="xiufeiB" size="38" id="xiufeiB" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				
				<td nowrap="nowrap" align="center" width="7%">���</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="xiufeiA" size="38" id="xiufeiA" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
			
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">���</td>
				<td nowrap="nowrap" align="center" width="7%">
<input name="xiukouB" size="38" id="xiukouB" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
			
				<td nowrap="nowrap" align="center" width="7%">���</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="xiukouA" size="38" id="xiukouA" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
			
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">��������</td>
				<td nowrap="nowrap" align="left" width="7%"><input name="xiku_number" size="38" id="xiku_number" type="number"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" width="7%">�������</td>
				<td nowrap="nowrap" align="left" width="7%"><input name="majia_number" size="38" id="majia_number" type="number"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%">�����</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">��Χ</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="yaoweiC" size="38" id="yaoweiC" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="4">
					<img src="http://47.111.148.8/watch/upload/test.png" width="100" height="100" />
				</td>
				<td nowrap="nowrap" align="center" width="7%">���</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input  name="jiankuannew" size="38" type="text" class="txt_1"maxlength="50" >
				</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="4">
					<img src="http://47.111.148.8/watch/upload/test.png" width="100" height="100" />
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">��Χ</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="tuiweiC" size="38" id="tuiweiC" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" width="7%">��Χ</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="xiongweiD" size="38" id="xiongweiD"
					type="text" class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">��Χ</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="dangweiC" size="38" id="dangweiC" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="zhongyaoD" size="38" id="zhongyaoD"
					type="text" class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="datuiC" size="38" id="datuiC" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" width="7%">�³�</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="yichangD" size="38" id="yichangD" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="zhongtuiC" size="38" id="zhongtuiC"
					type="text" class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="4"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="4">����</td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="4" colspan="2"><select name="kuanxingD" value="kuanxingD">
						<option value="����">����</option>
						<option value="����+">����+</option>
						<option value="����">����</option>
						<option value="����+">����+</option>
						<option value="����">����</option>
						<option value="����+">����+</option>
				</select> <font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%" rowspan="4"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">С��</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="xiaotuiC" size="38" id="xiaotuiC" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				
			
				
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">�㳤</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="kuchangC" size="38" id="kuchangC" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				
			
				
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">�ſ�</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="tuikouC" size="38" id="tuikouC" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				
			
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
					<select name="kouxingC" value="kouxingC" onchange="setSecond(this)">
						<option value=""></option>
						<option value="һ����">һ����</option>
						<option value="������">������</option>
						<option value="������">������</option>
						<option value="˫�Ŷ���һ">˫�Ŷ���һ</option>
						<option value="˫���Ŀ۶�">˫���Ŀ۶�</option>
						<option value="˫�����۶�">˫�����۶�</option>
				</select> <font color="red"></font>
					</td>
				<td nowrap="nowrap" align="center" width="7%">�ڴ�</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="koudaiC" value="koudaiC">
				         <option value=""></option>
						<option value="1ƽ���ǡ�4б����">1ƽ���ǡ�4б����</option>
						<option value="2ƽ���ߡ�5б����">2ƽ���ߡ�5б����</option>
						<option value="3ƽ˫�ߡ�6б˫��">3ƽ˫�ߡ�6б˫��</option>
						<option value="7������">7������</option>
				</select> <font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="kaicha" value="kaicha">
				        <option value=""></option>
						<option value="����">����</option>
						<option value="˫��">˫��</option>
						<option value="������">������</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
				<!-- <input name="lingkoukuaishiB" size="38"
					id="lingkoukuaishiB" type="text" class="txt_1" maxlength="100" /><font
					color="red"></font> -->
					<select name="lingkoukuaishiB" value="lingkoukuaishiB">
					    <option value=""></option>
						<option value="ƽ����">ƽ����</option>
						<option value="ꨲ���">ꨲ���</option>
						<option value="�����">�����</option>
						<option value="�����">�����</option>
						<option value="��ƽ��">��ƽ��</option>
						<option value="��ƽ��">��ƽ��</option>
						<option value="��ꨲ�">��ꨲ�</option>
						<option value="����">����</option>
				</select> 
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">�°�</td>
				<td nowrap="nowrap" align="center" width="7%">
					<select id="xiabai" name="xiabai" >
					
					 <option value=""></option>
						<option value="Բ���°�">Բ���°�</option>
						<option value="ֱ���°ڣ�˫�ſ�Ĭ�ϣ�">ֱ���°ڣ�˫�ſ�Ĭ�ϣ�</option>
						<option value="��Բ���°�">��Բ���°�</option>
						<option value="��β�°�">��β�°�</option>
						<option value="����">����</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">ײɫ</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="zhuangse" value="zhuangse">
				<option value=""></option>
						<option value="������ɫ��">������ɫ��</option>
						<option value="�����ɫ��">�����ɫ��</option>
						<option value="��ͷ��ɫ��">��ͷ��ɫ��</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">�����</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="waizhubian" value="waizhubian">
				<option value=""></option>
						<option value="��">��</option>
						<option value="��">��</option>
				</select>
				
			<!-- 	<input name="waizhubian" size="38"
					id="waizhubian" type="text" class="txt_1" maxlength="100" /><font
					color="red"></font> -->
				</td>
				<td nowrap="nowrap" align="center" width="7%">���</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="xiucha" value="xiucha">
				<option value=""></option>
						<option value="�����">�����</option>
						<option value="�����">�����</option>
						<option value="����">����</option>
						<option value="����">����</option>
				</select>
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="kuyao" value="kuyao">
				<option value=""></option>
						<option value="�������">�������</option>
						<option value="�������">�������</option>
						<option value="����ͷ">����ͷ</option>
						<option value="�ɽ�">�ɽ�</option>
						<option value="���ڿ�">���ڿ�</option>
						<option value="�ǲ���˹">�ǲ���˹</option>
						<option value="����">����</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="kuxing" value="kuxing">
				<option value=""></option>
						<option value="�����">�����</option>
						<option value="����">����</option>
						<option value="����">����</option>
						<option value="˫��">˫��</option>
						<option value="�ܲ���">�ܲ���</option>
						<option value="ֱͲ��">ֱͲ��</option>
						<option value="����">����</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">������</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="chenshanling" value="chenshanling">
				<option value=""></option>
						<option value="С����">С����</option>
						<option value="С����">С����</option>
						<option value="v����">v����</option>
						<option value="������">������</option>
						<option value="����">����</option>
						<option value="����">����</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">������</td>
				<td nowrap="nowrap" align="center" width="7%">
					<select name="chenshanxiu" value="chenshanxiu">
					<option value=""></option>
						<option value="��ʽ�Ž���">��ʽ�Ž���</option>
						<option value="ֱ�Ƕ���">ֱ�Ƕ���</option>
						<option value="ֱ��һ��">ֱ��һ��</option>
						<option value="Բ�Ƕ���">Բ�Ƕ���</option>
						<option value="Բ��һ��">Բ��һ��</option>
						<option value="����">����</option>
						<option value="����">����</option>
				</select>
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="miaoliao1" size="38" id="miaoliao1"
					type="text" class="txt_1" maxlength="100" /><font color="red"></font>
				</td>
				<td nowrap="nowrap" align="center" width="7%">��;</td>
				<td nowrap="nowrap" align="center" width="7%">
					<select name="yongtu1" value="yongtu1">
					<option value=""></option>
						<option value="����">����</option>
						<option value="����">����</option>
						<option value="���">���</option>
						<option value="����">����</option>
						<option value="��װ��װ">��װ��װ</option>
						<option value="��Ƭ">��Ƭ</option>
						<option value="����">����</option>
				</select> <font color="red"></font>
				</td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" width="7%">��Ӧ��</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="miaoliao2" size="38" id="miaoliao2"
					type="text" class="txt_1" maxlength="100" /><font color="red"></font>
				</td>
				<td nowrap="nowrap" align="center" width="7%">��;</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="yongtu2" value="yongtu2">
				<option value=""></option>
						<option value="����">����</option>
						<option value="����">����</option>
						<option value="���">���</option>
						<option value="����">����</option>
						<option value="��װ��װ">��װ��װ</option>
						<option value="��Ƭ">��Ƭ</option>
						<option value="����">����</option>
				</select> <font color="red"></font>
				</td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" width="7%">��Ӧ��</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="" size="38" id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input type="file" name="channelId"
					id="channelId" multiple="multiple"  /><!--  <img alt=""
					src="" id="image1" class="showImage"> -->
					
					
					</td>
			</tr>
			
			<tr>
				<td nowrap="nowrap" align="center" width="7%">�ͷ���ע</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="7">
			<input name="remark" size="200" id="remark"
					type="text" class="txt_1" maxlength="1000" /><font color="red"></font></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">������ע</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="7">
					
			<input name="" size="200" id=""
					type="text" class="txt_1" maxlength="1000"  readonly="true"/>
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">������ע</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="7">
				<input name="" size="200" id=""
					type="text" class="txt_1" maxlength="1000"  readonly="true"/>
				</td>
			</tr>
			<!-- 	<tr>
				<td nowrap="nowrap" align="center" width="7%">�ύ����</td>
				<td nowrap="nowrap" align="center" width="7%" colspan="7">
					���� <input name="tag" type="radio" class="radio_1" value="1" checked="checked" >
	    ���沢�ύ<input type="radio" name="tag" class="radio_1" value="2" >
				</td>
			</tr> -->
			
			
			
			
				
		
			<tr>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="right" width="7%">
				<input name="anniu" size="200" id="anniu"
					 type="hidden" class="txt_1"  />
					
				<input id="ok"   title="1"
					type="button" name="ok" accesskey="y" tabindex="y" value="����"
					class="but_1" onclick="onAdd(this.title)"
					style="font-size:12;width:40px;height:21px;">
					</td>
				<td nowrap="nowrap" align="left" width="7%">	
					<input id="ok"   title="2"
					type="button" name="ok" accesskey="y" tabindex="y" value="���沢�ύ" 
					class="but_1" onclick="onAdd(this.title)"
					style="font-size:12;width:80px;height:21px;">
					
					 <input
					type="button" name="back" accesskey="b" tabindex="b" value="����"
					class="but_1"
					onclick="location='doProjectInfo.do?method=queryProjectInfoXml'"
					style="font-size:12;width:40px;height:21px;">
					</td>
			
			</tr>
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			

	<!-- 		<tr>
				<td align="left">�������</td>
				<td colspan="2" align="left">�Զ�����</td>
				<td align="left">������</td>
				<td colspan="2" align="left"></td>
				<td align="left">���ۼ۸�</td>
				<td align="left"></td>
			</tr>

			<tr>
				<td>΢����</td>
				<td colspan="2"></td>
				<td>������</td>
				<td colspan="2"></td>
				<td>�µ�ʱ��</td>
				<td></td>
			</tr>


			<tr>
				<td>�ͻ��绰</td>
				
				<td>��������</td>
				<td colspan="2"></td>
				<td>����ʱ��</td>
				<td>
				</td>
			</tr>


			<tr>
				<td>�ͻ�����</td>
				<td></td>
				<td>����</td>
				
				<td>�µ��ͷ�</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>�ͻ���ַ</td>
				<td colspan="7">
				</td>
			</tr>

			<tr>
				<td>���</td>
				<td></td>
				<td>����</td>
				<td></td>
				<td>����</td>
				
				<td>�Ա�</td>
				<td></td>
			</tr>

			<tr>
				<td >��װ����</td>
						<td></td>
				<td>����</td>
				<td >��������</td>
				<td></td>
				<td>������</td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>���</td>
				<td>
				</td>
				<td></td>
				<td>��Χ</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>��Χ</td>
				<td>
				</td>
				<td></td>
				<td>��Χ</td>
				<td>
				</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>����</td>
				<td>
				</td>
				<td></td>
				<td>����</td>
				<td>
				</td>
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
				<td>
				</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>ǰ�³�</td>
				<td>
				</td>
				<td></td>
				<td>���</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>�䳤</td>
				<td>
				</td>
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
				<td><input name="yichangB" size="38" id="yichangB" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>��������</td>
				<td></td>
				<td>����</td>
				<td >�������</td>
					<td></td>
				<td>�����</td>
				<td></td>
				<td></td>
			</tr>


			<tr>
				<td>�㳤</td>
				<td></td>
				<td></td>
				<td>��Χ</td>
				<td>
				</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>


			<tr>
				<td>��Χ</td>
				<td></td>
				<td></td>
				<td>����</td>
				<td>
				</td>
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
				<td>
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
				<td><input name="kouseC" size="38" id="kouseC" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td>����</td>
				<td></td>
				<td>��ͷ</td>
				<td><select name="botouD" value="botouD">
						<option value="��װ��">��װ��</option>
						<option value="ƽ����">ƽ����</option>
						<option value="ꨲ���">ꨲ���</option>
						<option value="�����">�����</option>
						<option value="����">����</option>
						<option value="�л�����">�л�����</option>
						<option value="����">����</option>
				</select> <font color="red"></font></td>
			</tr>

			<tr>
				<td>�ڴ�</td>
				<td></td>
				<td>����</td>
				<td><select name="daigai" value="daigai">
						<option value="��">��</option>
						<option value="��">��</option>
						<option value="����">����</option>
				</select> <font color="red"></font></td>
				<td>ƽб��</td>
				<td><select name="pingxiedai" value="pingxiedai">
						<option value="ƽ��">ƽ��</option>
						<option value="б��">б��</option>
						<option value="����">����</option>
				</select> <font color="red"></font></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>����1</td>
				<td>
				</td>
				<td>����</td>
				<td></td>
				<td>��;</td>
				<td>
			</td>
				
				<input name="yongtu1" size="38" id="yongtu1" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font>
					
					</td>
				<td>��Ӧ��</td>
				<td></td>
			</tr>
 
			<tr>
				<td>����2</td>
				<td>
				</td>
				<td>����</td>
				<td></td>
				<td>��;</td>
				<td>
				
				</td>
				<input name="yongtu2" size="38" id="yongtu2" type="text"
					class="txt_1" maxlength="100" /><font color="red"></font></td>
				<td>��Ӧ��</td>
				<td></td>
			</tr>

			<tr>
				<td>���ͱ�ע</td>
				<td colspan="3"><input name="tixingremark" size=60"
					id="tixingremark" type="text" class="txt_1" maxlength="1000" /><font
					color="red"></font></td>
				<td>��ע</td>
				<td colspan="3">
				</td>
			</tr>

			<tr>
				<td align="left">����(ZIP)</td>
				<td colspan="2">��ѹ���������--
				</td>
					
						<td align="left" colspan="2">&
				</td>
			</tr>
			
				<tr>
				<td>�ύ����</td>
				<td colspan="7">
						
					</td>
				
			</tr>
			
			<tr>
					<td></td>
				<td colspan="7">
					
					</td>
				
			</tr> -->

		</table>

	</form>
</body>
</html>
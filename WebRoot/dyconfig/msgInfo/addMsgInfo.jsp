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
<scripttype
	="text/javascript"src="http://code.jquery.com/jquery-1.4.1.min.js">
</script> <script src="<%=request.getContextPath()%>/js/jquery-1.8.2.js"
	type="text/javascript"></script>
<title>�ޱ����ĵ�</title>
</head>

<script type="text/javascript">
/* 	$(document).ready(function() {
		$("#orderNumber").blur(function() {
			var userCodeValue = $("#orderNumber").val().trim();
			$.ajax({
				type : "post",
				url : "doMsgInfo.do?method=verfyDingDan",
				data : "userCode=" + userCodeValue,
				success : function(msg) {
					if (msg == "success") {
						alert("�ö����Ų�����");
						$("#orderNumber").focus();
						return false;
					}

				}
			});
		});
	}); */

	function onAdd(wechat) {

		document.getElementById("anniu").setAttribute("value", wechat);

		if (frmGo.orderNumber.value.trim() == "") {
			alert("�����Ų���Ϊ�գ�");
			frmGo.orderNumber.focus();
			return false;
		}

		if (frmGo.name.value.trim() == "") {
			alert("��������Ϊ�գ�");
			frmGo.name.focus();
			return false;
		}

		frmGo.submit();
	}

	//�����  id="huanjiename'+n+'"
	function addTable(cc) {
		var tab = document.getElementById("tab01"); //��ñ��
		//var colsNum = tab.rows.item(0).cells.length; //��������
		//���ǰ������ 
		var num = document.getElementById("tab01").rows.length;
	
		var rownum = num-2;
		tab.insertRow(rownum);

		var n=rownum-8;
		alert(n);
		if(n<=14){
		for (var i = 0; i < 9; i++) {
			tab.rows[rownum].insertCell(i);//������
			tab.rows[rownum].cells[i].setAttribute("align","center");
			if (i == 0) {
				tab.rows[rownum].cells[i].innerHTML = '����';
			} else if (i == 1) {
				tab.rows[rownum].cells[i].innerHTML = '<input name="mianliao'+n+'" type="text"  size="38" maxlength="100" />';
			} else if (i == 2) {
				tab.rows[rownum].cells[i].innerHTML = '��;';
			} else if( i == 3){
				tab.rows[rownum].cells[i].innerHTML = '<select name="yongtu' + n + '"  value="" style="width:100%"  > <option value=""></option> <option value="����">����</option> <option value="����">����</option>  <option value="���">���</option> <option value="����">����</option> <option value="��װ��װ">��װ��װ</option><option value="��Ƭ">��Ƭ</option><option value="����">����</option></select>';

			}else if(i == 4 ){
				tab.rows[rownum].cells[i].innerHTML = '����';
			}else if(i == 5){
				tab.rows[rownum].cells[i].innerHTML = '<input name="mi'+n+'" type="text" size="38" maxlength="100"/>';
			}else if(i == 6){
				tab.rows[rownum].cells[i].innerHTML = '�۸�';
			}else if(i == 7){
				tab.rows[rownum].cells[i].innerHTML = '<input name="jg'+n+'" type="text" size="38" maxlength="100"/>';
			}else if(i == 8){
				tab.rows[rownum].cells[i].innerHTML = '<select name="gys' + n + '"  value="" style="width:100%"  >'+cc+'</select>';
			}else{
				tab.rows[rownum].cells[i].innerHTML = '��Ӧ��';
			}
		}
		tab.rows[rownum].insertCell(i);
		tab.rows[rownum].cells[i].innerHTML = '<a href="#" onclick="delRow(this)">-</a>';
		}else{
			alert("������14��");
		}
	}
	//ɾ����
	function delRow(obj) {
		var Row = obj.parentNode;
		var Row = obj.parentNode; //tr
		while (Row.tagName.toLowerCase() != "tr") {
			Row = Row.parentNode;
		}
		Row.parentNode.removeChild(Row); //ɾ����
	}
</script>
<body>
	<form name="frmGo" method="post"
		action="doMsgInfo.do?method=insertMsgInfo" onsubmit="return onAdd()">
		<table width="100%" id="tab01" class="tbl_11" border="1"
			bordercolorlight=#000000 bordercolordark=#000000 bordercolor=#000000
			cellspacing="0" cellpadding="2">

			<!-- 	<table id="tab01" cellpadding="0" border="2" width="760px"> -->
			<tr>
				<th colspan="9" nowrap="nowrap" align="left">����ۺ�</th>
			</tr>

			<tr>
				<td colspan="9" nowrap="nowrap" align="center" width="7%">��һ�����ۺ󹤵�</td>
			</tr>

<tr>
				<td nowrap="nowrap" align="center" width="7%" colspan="1">�µ���</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="2">
				<input
					name="orderNumber" size="38" id="orderNumber" type="text" 
					class="txt_1" maxlength="30" />
					</td>
					<td nowrap="nowrap" align="center" width="7%" colspan="1">�ۺ��µ�����</td>
				<td nowrap="nowrap" align="center" width="7%" colspan="1">
				<%=request.getAttribute("shijian")%>
					</td>
					<td nowrap="nowrap" align="center" width="7%" colspan="1">��������</td>
				<td nowrap="nowrap" align="center" width="7%" colspan="1">
			<input
					name="jiaofutime" id="jiaofutime" type="text" size="38"
					maxlength="100" />
					</td>
			
			
			</tr>
			
			
			<tr>
				<td nowrap="nowrap" align="center" width="7%" colspan="1">����</td>
				<td nowrap="nowrap" align="cneter" width="7%" colspan="1">
				<input
					name="name" id="name" type="text" class="txt_1" maxlength="20"
					size="38" />
					</td>
					<td nowrap="nowrap" align="center" width="7%" colspan="1">�绰</td>
				<td nowrap="nowrap" align="center" width="7%" colspan="1">
				<input
					name="phone" id="phone" type="text" class="txt_1" maxlength="20"
					size="38" />
					</td>
					<td nowrap="nowrap" align="center" width="7%" colspan="1">�޸���Ʒ</td>
				<td nowrap="nowrap" align="center" width="7%" colspan="1">
		<input type="checkbox" name="item1" value="����"><label>����</label>
		<input type="checkbox" name="item2" value="����"><label>����</label>
		<input type="checkbox" name="item3" value="���"><label>���</label>
		<input type="checkbox" name="item4" value="����"><label>����</label>
		<input type="checkbox" name="item5" value="����"><label>����</label>
					</td>
			</tr>
			
			
				<tr>
				<td nowrap="nowrap" align="center" width="7%" colspan="1">��ַ</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="7"><input
					name="address" size="38" id="address" type="text" 
					class="txt_1" maxlength="30" />
					</td>
			</tr>


	<tr>
				<td nowrap="nowrap" align="center" width="7%" colspan="1">�ۺ�����</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="1"><input
					name="shouhou_type" size="38" id="shouhou_type" type="text" 
					class="txt_1" maxlength="30" />
					</td>
					<td nowrap="nowrap" align="center" width="7%" colspan="1">�ۺ����</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="1"><input
					name="cishu" size="38" id="cishu" type="text" 
					class="txt_1" maxlength="30" />
					</td>
				
			</tr>
			
				<tr>
				<td nowrap="nowrap" align="center" width="7%" colspan="1">�Ļ���������</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="1">
				<input
					name="jihui" size="38" id="jihui" type="text" 
					class="txt_1" maxlength="30" />
					</td>
					<td nowrap="nowrap" align="center" width="7%" colspan="1">������������</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="1">
				<input
					name="fahuo" size="38" id="fahuo" type="text" 
					class="txt_1" maxlength="30" />
					</td>
				
			</tr>
			
			
				<tr>
				<td nowrap="nowrap" align="center" width="7%" colspan="1">�ۺ�ԭ��</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="1">
				<input
					name="reson" size="38" id="reson" type="text" 
					class="txt_1" maxlength="30" />
					</td>
					<td nowrap="nowrap" align="center" width="7%" colspan="1">����</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="3">
				<input
					name="guize" size="38" id="guize" type="text" 
					class="txt_1" maxlength="30" />
					</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%"><button type="button" onclick="addTable(this.value)" value="<%=request.getAttribute("gysall")%>"
			style="margin-left: 0px;">+</button>����</td>
				<td nowrap="nowrap" align="center" width="7%"><input
					name="mianliao" id="mianliao" type="text" size="38" maxlength="100"
					placeholder="����" /></td>
				<td nowrap="nowrap" align="center" width="7%">��;</td>
				<td nowrap="nowrap" align="center" width="7%">
					<!-- <input
					name="yongtu" id="yongtu" type="text" size="38" maxlength="100" /> -->

					<select name="yongtu" value="yongtu">
						<option value="����">����</option>
						<option value="����">����</option>
						<option value="���">���</option>
						<option value="����">����</option>
						<option value="��װ��װ">��װ��װ</option>
						<option value="��Ƭ">��Ƭ</option>
						<option value="����">����</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">����</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="mi"
					id="mi" type="text" size="38" maxlength="100" />
					</td>
					<td nowrap="nowrap" align="center" width="7%">�۸�</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="jg"
					id="jg" type="text" size="38" maxlength="100" />
					</td>
				<td nowrap="nowrap" align="center" width="7%">��Ӧ��</td>
				<td nowrap="nowrap" align="center" width="7%">
					<!-- <input
					name="gongyingshang" id="gongyingshang" type="text" size="38"
					maxlength="100" /> --> <%=request.getAttribute("companyList")%>
				</td>


			</tr>
			
			<tr>
				<td nowrap="nowrap" align="center" width="7%" colspan="1">�ۺ�����</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="6">
				<input
					name="remark" size="38" id="remark" type="text" 
					class="txt_1" maxlength="30" />
					</td>
			
			</tr>
			
						
			
			

			<tr>
				<td nowrap="nowrap" align="center" width="7%"><input
					style="border:none;" name="anniu" size="200" id="anniu"
					type="hidden" class="txt_1" /></td>
				<td nowrap="nowrap" align="center" width="7%"><input
					type="button" name="ok" accesskey="y" tabindex="y" value="����"
					title="1" class="but_1" onclick="onAdd(this.title)"
					style="font-size:12;width:40px;height:21px;"> <input
					type="button" name="ok" accesskey="y" tabindex="y" value="�ύ"
					title="2" class="but_1" onclick="onAdd(this.title)"
					style="font-size:12;width:40px;height:21px;"> <input
					type="button" name="back" accesskey="b" tabindex="b" value="�� ��"
					class="but_1" onclick="location='doMsgInfo.do?method=queryMsgInfo'"
					style="font-size:12;width:40px;height:21px;"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>


		


		</table>
		
		

	</form>
</body>
</html>
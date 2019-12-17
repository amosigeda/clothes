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
	<script language="JavaScript" src="<%=request.getContextPath()%>/public/My97DatePicker/WdatePicker.js"></script>
<title>�ޱ����ĵ�</title>
</head>
<style>
	.add_order_table tr th, .add_order_table tr td{border-bottom: 1px solid #bbb; border-left:1px solid #bbb; padding:10px;}
	.add_order_table tr th{border-left:0;}
	.add_order_table tr td:last-child{border-right:1px solid #bbb;}
/*	.add_order_table tr td:first-child{border-left: 0;}*/
/*	.add_order_table tr:last-child td{border-bottom:0;}*/
	.add_order_table input[type="text"], .add_order_table select{width: 100%; padding:5px; border:1px solid #ccc;} 
	.table_title{font-size:22px;}
	.t_subtitle th, .t_subtitle td{background:#F8CBAD;}
	.f_bold{font-weight: bold;}
	.td_bg_pink{background:#FCE4D6;}
	.td_bg_yellow{background:#FFF2CC; white-space: nowrap;}
	.add_order_table .btn{padding:6px 20px; width: auto; height: auto; font-size:14px; background:#337ab7; border-radius: 6px; color: #fff; border:1px solid #286090;}
	.padd0{padding:0 !important;}
	
</style>
<script type="text/javascript">


	$(document).ready(function() {
		$("#orderNumber").blur(function() {
			var userCodeValue = $("#orderNumber").val().trim();
			$.ajax({
				type : "post",
				url : "doMsgInfo.do?method=verfyDingDan",
				data : "userCode=" + userCodeValue,
				success : function(msg) {
					if (msg == "success") {
						alert("�޸ö�����");
						$("#orderNumber").val("");
						$("#orderNumber").focus();
						return false;
					}else{
						
						var ss = msg;
						var st = ss.split(";");
						var name = st[1];
						var phone =st[2];
						var address = st[3];
						
						   document.getElementById("name").setAttribute("value", name);
						   document.getElementById("phone").setAttribute("value", phone);
						   document.getElementById("address").setAttribute("value", address);
						
						//alert(st[1]);
					}

				}
			});
		});
	}); 

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

		var n=rownum-7;
		if(n<=14){
		for (var i = 0; i < 8; i++) {
			tab.rows[rownum].insertCell(i);//������
			tab.rows[rownum].cells[i].setAttribute("align","center");
			if (i == 0) {
				tab.rows[rownum].cells[i].setAttribute("class", "td_bg_yellow");
				tab.rows[rownum].cells[i].innerHTML = '<button type="button" onclick="delRow(this)">-</button> ����';
			} else if (i == 1) {
				tab.rows[rownum].cells[i].innerHTML = '<input name="mianliao'+n+'" type="text"   maxlength="100" />';
			} else if (i == 2) {
				tab.rows[rownum].cells[i].setAttribute("class", "td_bg_yellow");
				tab.rows[rownum].cells[i].innerHTML = '��;';
			} else if( i == 3){
				tab.rows[rownum].cells[i].innerHTML = '<select name="yongtu' + n + '"  value="" style="width:100%"  > <option value=""></option> <option value="����">����</option> <option value="����">����</option>  <option value="���">���</option> <option value="����">����</option> <option value="��װ��װ">��װ��װ</option><option value="��Ƭ">��Ƭ</option><option value="����">����</option></select>';

			}else if(i == 4 ){
				tab.rows[rownum].cells[i].setAttribute("class", "padd0");
						tab.rows[rownum].cells[i].innerHTML = '<table width="100%" class="tbl_11" cellspacing="0" cellpadding="0" border="0"><tbody><tr><td class="td_bg_yellow" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;" nowrap="nowrap" align="center">����</td><td style="border: 0;" nowrap="nowrap" align="center"><input name="mi'+n+'" type="text"  maxlength="100"/></td></tr></tbody></table>';
			}else if(i == 5){
				tab.rows[rownum].cells[i].setAttribute("class", "padd0");
						tab.rows[rownum].cells[i].innerHTML = '<table width="100%" class="tbl_11" cellspacing="0" cellpadding="0" border="0"><tbody><tr><td class="td_bg_yellow" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;" nowrap="nowrap" align="center">�۸�</td><td style="border: 0;" nowrap="nowrap" align="center"><input name="jg'+n+'" type="text"  maxlength="100"/></td></tr></tbody></table>';
			}else if(i == 6){
				tab.rows[rownum].cells[i].setAttribute("class", "td_bg_yellow");
				tab.rows[rownum].cells[i].innerHTML = '��Ӧ��';
			}else{
				tab.rows[rownum].cells[i].innerHTML = '<select name="gys' + n + '"  value="" style="width:100%"  >'+cc+'</select>';
			}
		}
		//tab.rows[rownum].insertCell(i);
		//tab.rows[rownum].cells[i].innerHTML = '<a href="#" onclick="delRow(this)">-</a>';
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
		<table width="100%" id="tab01" class="tbl_11 add_order_table" border="0" cellspacing="0" cellpadding="0">

			<!-- 	<table id="tab01" cellpadding="0" border="2" width="760px"> -->
			<tr>
				<th colspan="9" nowrap="nowrap" align="left">����ۺ�</th>
			</tr>

<!--
			<tr>
				<td colspan="9" nowrap="nowrap" align="center">��һ�����ۺ󹤵�</td>
			</tr>
-->

<tr>
				<td nowrap="nowrap" align="center" colspan="1">�µ���</td>
				<td nowrap="nowrap" align="left" colspan="1">
				<input
					name="orderNumber"  id="orderNumber" type="text" 
					class="txt_1" maxlength="30" />
					</td>
					<td nowrap="nowrap" align="center" colspan="1">�ۺ��µ�����</td>
				<td nowrap="nowrap" align="center" colspan="1">
				<%=request.getAttribute("shijian")%>
					</td>
					<td nowrap="nowrap" align="center" colspan="1">��������</td>
				<td nowrap="nowrap" align="center" colspan="3">
			<input
					name="jiaofutime" id="jiaofutime" type="text"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"
					maxlength="100" />
					</td>
			
			
			</tr>
			
			
			<tr>
				<td nowrap="nowrap" align="center" colspan="1">����</td>
				<td nowrap="nowrap" align="cneter" colspan="1">
				<input
					name="name" id="name" type="text" class="txt_1" maxlength="20"
					 />
					</td>
					<td nowrap="nowrap" align="center" colspan="1">�绰</td>
				<td nowrap="nowrap" align="center" colspan="1">
				<input
					name="phone" id="phone" type="text" class="txt_1" maxlength="20"
					 />
					</td>
					<td nowrap="nowrap" align="center" colspan="1">�޸���Ʒ</td>
				<td nowrap="nowrap" align="center" colspan="3">
		<input type="checkbox" name="item1" value="����"><label>����</label>
		<input type="checkbox" name="item2" value="����"><label>����</label>
		<input type="checkbox" name="item3" value="���"><label>���</label>
		<input type="checkbox" name="item4" value="����"><label>����</label>
		<input type="checkbox" name="item5" value="����"><label>����</label>
					</td>
			</tr>
			
			
				<tr>
				<td nowrap="nowrap" align="center" colspan="1">��ַ</td>
				<td nowrap="nowrap" align="left" colspan="7"><input
					name="address"  id="address" type="text" 
					class="txt_1" maxlength="30" />
					</td>
			</tr>


	<tr>
				<td nowrap="nowrap" align="center" colspan="1">�ۺ�����</td>
				<td nowrap="nowrap" align="left" colspan="3">
				<select name="shouhou_type" value="shouhou_type">
					<option value=""></option>
							<option value="�˿�">�˿�</option>
							<option value="�޸�">�޸�</option>
						
						</select>
			
					</td>
					<td nowrap="nowrap" align="center" colspan="1">�ۺ����</td>
				<td nowrap="nowrap" align="left" colspan="3"><input
					name="cishu"  id="cishu" type="text" 
					class="txt_1" maxlength="30" />
					</td>
				
			</tr>
			
				<tr class="td_bg_pink">
				<td nowrap="nowrap" align="center" colspan="1">�Ļ���������</td>
				<td nowrap="nowrap" align="left" colspan="3">
				<input
					name="jihui"  id="jihui" type="text" 
					class="txt_1" maxlength="30" />
					</td>
					<td nowrap="nowrap" align="center" colspan="1">������������</td>
				<td nowrap="nowrap" align="left" colspan="3">
				<input
					name="fahuo"  id="fahuo" type="text" 
					class="txt_1" maxlength="30" />
					</td>
				
			</tr>
			
			
				<tr>
				<td nowrap="nowrap" align="center" colspan="1">�ۺ�ԭ��</td>
				<td nowrap="nowrap" align="left" colspan="3">
					<select name="reson" value="reson">
					<option value=""></option>
							<option value="�µ��´�">�µ��´�</option>
							<option value="�ߴ�����">�ߴ�����</option>
							<option value="�����״�">�����״�</option>
							<option value="����ԭ��">����ԭ��</option>
							<option value="�����ʽ">�����ʽ</option>
							<option value="����ߴ�">����ߴ�</option>
							<option value="�ͷ�Ҫ��">����ߴ�</option>
						</select>
						
				
					</td>
					<td nowrap="nowrap" align="center" colspan="1">����</td>
				<td nowrap="nowrap" align="left" colspan="3">
				<input
					name="guize"  id="guize" type="text" 
					class="txt_1" maxlength="30" />
					</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold"><button type="button" onclick="addTable(this.value)" value="<%=request.getAttribute("gysall")%>"
			style="margin-left: 0px;">+</button>����</td>
				<td nowrap="nowrap" align="center"><input
					name="mianliao" id="mianliao" type="text"  maxlength="100"
					placeholder="" /></td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">��;</td>
				<td nowrap="nowrap" align="center">
					<!-- <input
					name="yongtu" id="yongtu" type="text"  maxlength="100" /> -->

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
				
				
				<td nowrap="nowrap" style="padding: 0;">
						<table width="100%" class="tbl_11" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">����</td>
								<td nowrap="nowrap" align="center" style="border: 0;">
									<input name="mi" id="mi" type="text" maxlength="100" />
								</td>
							</tr>
						</table>
					</td>
				<td nowrap="nowrap" style="padding: 0;">
						<table width="100%" class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">�۸�</td>
							<td nowrap="nowrap" align="center" style="border: 0;"><input name="jg" id="jg" type="text"  maxlength="100" /></td>
						</tr>
						</table>
				</td>
				<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">��Ӧ��</td>
				<td nowrap="nowrap" align="center">
					<!-- <input
					name="gongyingshang" id="gongyingshang" type="text" 
					maxlength="100" /> --> <%=request.getAttribute("companyList")%>
				</td>


			</tr>
			
			<tr>
				<td nowrap="nowrap" align="center" colspan="1" class="td_bg_yellow f_bold">�ۺ�����</td>
				<td nowrap="nowrap" align="left" colspan="7">
				<input
					name="remark"  id="remark" type="text" 
					class="txt_1" maxlength="2000" />
					</td>
			
			</tr>
			
						
			
			

			<tr>
				<td nowrap="nowrap" align="center"><input
					style="border:none;" name="anniu" id="anniu"
					type="hidden" class="txt_1" /></td>
				<td nowrap="nowrap" align="left" colspan="7">
					<input
					type="button" name="ok" accesskey="y" tabindex="y" value="����"
					title="1" class="but_1 btn" onclick="onAdd(this.title)"> 
					<input
					type="button" name="ok" accesskey="y" tabindex="y" value="�ύ"
					title="2" class="but_1 btn" onclick="onAdd(this.title)"> 
					<input
					type="button" name="back" accesskey="b" tabindex="b" value="�� ��"
					class="but_1 btn" onclick="location='doMsgInfo.do?method=queryMsgInfo'"></td>
			</tr>


		


		</table>
		
		

	</form>
</body>
</html>
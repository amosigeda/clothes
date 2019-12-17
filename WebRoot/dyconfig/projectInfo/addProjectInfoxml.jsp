<%@ page language="java" contentType="text/html;charset=GB2312"%>
<%@ page autoFlush="true"%>
<%@ page import="com.care.app.LoginUser"%>
<%@ page import="com.care.common.config.Config"%>
<%@ taglib uri="/WEB-INF/struts-bean" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic" prefix="logic"%>
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<link href="<%=request.getContextPath()%>/css/tbls.css" rel="stylesheet" type="text/css">
		<!--<link href="css/tbls.css" rel="stylesheet" type="text/css">-->
		<script type="text/javascript" src="<%=request.getContextPath()%>/public/public.js"></script>
		<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.1.min.js"></script>
		<script src="<%=request.getContextPath()%>/js/jquery-1.8.2.js" type="text/javascript"></script>
		<script language="JavaScript" src="<%=request.getContextPath()%>/public/My97DatePicker/WdatePicker.js"></script>
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
<style>
	.add_order_table tr th, .add_order_table tr td{border-bottom: 1px solid #bbb; border-left:1px solid #bbb; padding:10px;}
	.add_order_table tr th{border-left:0;}
	.add_order_table tr td:last-child{border-right:1px solid #bbb;}
/*	.add_order_table tr td:first-child{border-left: 0;}*/
/*	.add_order_table tr:last-child td{border-bottom:0;}*/
	.add_order_table input, .add_order_table select{width: 100%; padding:5px; border:1px solid #ccc;} 
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
					type: "post",
					url: "doProjectInfo.do?method=verfyDingDan",
					data: "userCode=" + userCodeValue,
					success: function(msg) {
						if(msg == "fail") {
							alert("�������ظ�������");
							$("#orderNumber").val("");
							$("#orderNumber").focus();
							return false;
						}
					}
				});
			});
			
			/* $("#orderNumber1").blur(function() {
				var userCodeValue = $("#orderNumber1").val().trim();
				$.ajax({
					type: "post",
					url: "doProjectInfo.do?method=verfyDingDan",
					data: "userCode=" + userCodeValue,
					success: function(msg) {
						if(msg == "fail") {
							alert("�������ظ�������");
							$("#orderNumber1").val("");
							$("#orderNumber1").focus();
							return false;
						}
					}
				});
			}); */
			
			
		});

		function setSecond(obj) {
			var val = obj.value;
			if(val == "˫�Ŷ���һ" || val == "˫���Ŀ۶�" || val == "˫�����۶�") {
				var sec = document.getElementById("xiabai");
				sec.innerHTML = "<option>ֱ���°�</option><option>Բ���°�</option><option>��Բ���°�</option><option>��β�°�</option><option>����</option>";

				/* 		<option value="Բ���°�">Բ���°�</option>
						<option value="ֱ���°ڣ�˫�ſ�Ĭ�ϣ�">ֱ���°ڣ�˫�ſ�Ĭ�ϣ�</option>
						<option value="��Բ���°�">��Բ���°�</option>
						<option value="��β�°�">��β�°�</option>
						<option value="����">����</option> */

			} else {
				var sec = document.getElementById("xiabai");
				sec.innerHTML = "<option></option><option>ֱ���°�</option><option>Բ���°�</option><option>��Բ���°�</option><option>��β�°�</option><option>����</option>";
			}
		}

		function onAdd(wechat) {
			document.getElementById("anniu").setAttribute("value", wechat);

			if(frmGo.orderNumber.value.trim() == "") {
				alert("�����Ų���Ϊ�գ�");
				frmGo.orderNumber.focus();
				return false;
			}
			
			frmGo.submit();
		}

		function onAddd(wechat) {
			document.getElementById("anniu").setAttribute("value", wechat);

			if(frmGo.orderNumber.value.trim() == "") {
				alert("�����Ų���Ϊ�գ�");
				frmGo.orderNumber.focus();
				return false;
			}
			if(frmGo.kehuPhone.value.trim() == "") {
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

		function addTableOrder() {
			var tab = document.getElementById("tab01"); //��ñ��
			//var colsNum = tab.rows.item(0).cells.length; //��������
			//���ǰ������ 
			var num = document.getElementById("tab01").rows.length;
			/*   alert("��ǰ��="+num); */
				var addhang1 = parseFloat(frmGo.addhang1.value); 
			
			var rownum = num - 30-addhang1;

			tab.insertRow(rownum);

			var n = rownum - 3;
		
			
			/* alert(n);  */
			
			  document.getElementById("addhang").setAttribute("value", n);
			
			if(n <= 9) {
				for(var i = 0; i < 8; i++) {
					tab.rows[rownum].insertCell(i); //������
					tab.rows[rownum].cells[i].setAttribute("align", "center");
					if(i == 0) {
						tab.rows[rownum].cells[i].setAttribute("class", "td_bg_yellow");
						tab.rows[rownum].cells[i].innerHTML = '<button type="button" onclick="delRowOrder(this)">-</button> ������';
					} else if(i == 1) {
						tab.rows[rownum].cells[i].innerHTML = '<input name="orderNumber' + n + '"   id="orderNumber' + n + '" value=""  type="text"   maxlength="100" />';
					} else if(i == 2) {
						tab.rows[rownum].cells[i].setAttribute("class", "td_bg_yellow");
						tab.rows[rownum].cells[i].innerHTML = '���ۼ۸�';
					} else if(i == 3) {
						tab.rows[rownum].cells[i].innerHTML = '<input name="xsjg' + n + '" type="text" value=""  maxlength="100" />';
					}
				}
				//tab.rows[rownum].insertCell(i);
				//tab.rows[rownum].cells[i].innerHTML = '<a href="#" onclick="delRow(this)">-</a>';
			} else {
				alert("�������9��");
			}
		}
		//ɾ����
		function delRowOrder(obj) {
			var Row = obj.parentNode;
			var Row = obj.parentNode; //tr
			while(Row.tagName.toLowerCase() != "tr") {
				Row = Row.parentNode;
			}
			Row.parentNode.removeChild(Row); //ɾ����
		}
		
		//�����  id="huanjiename'+n+'"
		function addTable() {
			var tab = document.getElementById("tab01"); //��ñ��
			//var colsNum = tab.rows.item(0).cells.length; //��������
			//���ǰ������ 
			var num = document.getElementById("tab01").rows.length;
			/*   alert("��ǰ��="+num); */
			var rownum = num - 5;

			tab.insertRow(rownum);

			var n = rownum - 28;
			var addhang = parseFloat(frmGo.addhang.value); 
			n=n-addhang;
			 document.getElementById("addhang1").setAttribute("value", n);
			
			
			if(n <= 14) {
				for(var i = 0; i < 8; i++) {
					tab.rows[rownum].insertCell(i); //������
					tab.rows[rownum].cells[i].setAttribute("align", "center");
					if(i == 0) {
						tab.rows[rownum].cells[i].setAttribute("class", "td_bg_yellow");
						tab.rows[rownum].cells[i].innerHTML = '<button type="button" onclick="delRow(this)">-</button> ����';
					} else if(i == 1) {
						tab.rows[rownum].cells[i].innerHTML = '<input name="ml' + n + '" type="text"   maxlength="100" />';
					} else if(i == 2) {
						tab.rows[rownum].cells[i].setAttribute("class", "td_bg_yellow");
						tab.rows[rownum].cells[i].innerHTML = '��;';
					} else if(i == 3) {
						tab.rows[rownum].cells[i].innerHTML = '<select name="yt' + n + '"  value="" style="width:100%"  > <option value=""></option> <option value="����">����</option> <option value="����">����</option>  <option value="���">���</option> <option value="����">����</option> <option value="��װ��װ">��װ��װ</option><option value="��Ƭ">��Ƭ</option><option value="����">����</option></select>';

						/* '<input name="yt'+n+'" type="text"  maxlength="100"/>'; */

						/* <option value="����">����</option>
						<option value="����">����</option>
						<option value="���">���</option>
						<option value="����">����</option>
						<option value="��װ��װ">��װ��װ</option>
						<option value="��Ƭ">��Ƭ</option>
						<option value="����">����</option> */
						/* '<input name="yt'+n+'" type="text"  maxlength="100"/>'; */
					} else if(i == 4) {
						tab.rows[rownum].cells[i].setAttribute("class", "padd0");
						tab.rows[rownum].cells[i].innerHTML = '<table class="tbl_11" cellspacing="0" cellpadding="0" border="0"><tbody><tr><td class="td_bg_yellow" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;" nowrap="nowrap" align="center">����</td><td style="border: 0;" nowrap="nowrap" align="center"><input name="ms' + n + '" type="text"  maxlength="100" readonly="true" /></td></tr></tbody></table>';
					} else if(i == 5) {
						tab.rows[rownum].cells[i].setAttribute("class", "padd0");
						tab.rows[rownum].cells[i].innerHTML = '<table class="tbl_11" cellspacing="0" cellpadding="0" border="0"><tbody><tr><td class="td_bg_yellow" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;" nowrap="nowrap" align="center">�۸�</td><td style="border: 0;" nowrap="nowrap" align="center"><input name="jq' + n + '" type="text"  maxlength="100" readonly="true" /></td></tr></tbody></table>';
					} else if(i == 6) {
						tab.rows[rownum].cells[i].setAttribute("class", "td_bg_yellow");
						tab.rows[rownum].cells[i].innerHTML = '��Ӧ��';
					} else {
						tab.rows[rownum].cells[i].innerHTML = '<input name="gys' + n + '" type="text"  maxlength="100" readonly="true" />';
					}
				}
				//tab.rows[rownum].insertCell(i);
				//tab.rows[rownum].cells[i].innerHTML = '<a href="#" onclick="delRow(this)">-</a>';
			} else {
				alert("�������15��");
			}
		}
		//ɾ����
		function delRow(obj) {
			var Row = obj.parentNode;
			var Row = obj.parentNode; //tr
			while(Row.tagName.toLowerCase() != "tr") {
				Row = Row.parentNode;
			}
			Row.parentNode.removeChild(Row); //ɾ����
		}
		
		
		

		function look() {
			var value = document.getElementById("jiaofu_time").value; //��ȡֵ
			var a = new Date();
			a = a.valueOf();
			a = a + value * 24 * 60 * 60 * 1000;
			a = new Date(a);

			var months = a.getMonth() + 1;
			var days = a.getDate();
			var hours = a.getHours();
			var min = a.getMinutes();
			var year = a.getFullYear();

			//var xianshi=year+"/"+months+"/"+days+" "+hours+":"+min;
			var xianshi = year + "/" + months + "/" + days;
			document.getElementById("test").setAttribute("value", xianshi);

			var selectObj = document.getElementById("jiaofu_time");
			alert(selectObj);
			selectObj[0].text = xianshi;

		}
	</script>
	<script type="text/javascript">
    function today(){//��������
        var today=new Date();//new ����ǰʱ��
        var h=today.getFullYear();//��ȡ��
        var m=today.getMonth()+1;//��ȡ��
        var d=today.getDate();//��ȡ��
        var H = today.getHours();//��ȡʱ
        var M = today.getMinutes();//��ȡ��
        var S = today.getSeconds();//��ȡ��
        return h+"-"+m+"-"+d+" "+H+":"+M+":"+S; //���� ��-��-�� ʱ:��:��
}
document.getElementById("today").value = today();//����ȡ���� ��-��-�� ʱ:��:�� ����input�ı������
</script>

	<body>
		<span class="title_1"></span>
		<form name="frmGo" method="post" action="doProjectInfo.do?method=insertUserDangAn" encType="multipart/form-data" onsubmit="return onAdd()">
			<%
			LoginUser loginUser = (LoginUser) request.getSession()
					.getAttribute(Config.SystemConfig.LOGINUSER);
			String loginUserCode = loginUser.getUserCode();
		%>
			<!-- <input type="hidden" name="addUser" value="<%=loginUserCode%>"> -->
			<!-- <table width="100%" border="0"cellpadding="0" cellspacing="0"  class="tbl_11" > -->

			<table width="100%" id="tab01" class="tbl_11 add_order_table" border="0" cellspacing="0" cellpadding="0">


				<tr>
					<th colspan="8" nowrap="nowrap" align="left"  >��Ӷ�����Ϣ(�ͻ�����) </th>
				</tr>
			
				

			<!-- 	<tr class="tr_11">
					<td colspan="8" nowrap="nowrap" align="center"  class="table_title">��һ���ƺ���¬�� �ͻ���Ϣ������</td>
				</tr>

			<tr class="t_subtitle">
					<td colspan="4" nowrap="nowrap" align="center" class="f_bold" >������Ϣ</td>
					<td colspan="4" nowrap="nowrap" align="center" class="f_bold">������Ϣ</td>
				</tr> -->

				<tr>
					<td nowrap="nowrap" align="center" class="f_bold">�������</td>
					<td nowrap="nowrap" align="center" >
						  <input name="wechataa"  id="wechataa"  readonly="true" type="text" class="txt_1"  value="<%=request.getAttribute("ding_dan")%>" />
					</td>
					<td nowrap="nowrap" align="center" class="f_bold">����</td>
					<td nowrap="nowrap" align="center" >
						<select name="qudao" value="qudao">
							<option value="�����Ա�">�����Ա�</option>
							<option value="�Ͼ��Ա�">�Ͼ��Ա�</option>
							<option value="����">����</option>
							<option value="����">����</option>
							<option value="����">����</option>
							<option value="����">����</option>
						
							<option value="����ת��_��">����ת��_��</option>
						<option value="����ת��_��">����ת��_��</option>
						<option value="����ת��_����">����ת��_����</option>
							<option value="����">����</option>
						</select>
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" class="f_bold">����</td>
					<td nowrap="nowrap" align="center" >
						<input name="age" id="age" type="number" class="txt_1"  />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" class="f_bold">�ͻ��绰</td>
					<td nowrap="nowrap" align="center" >
						<input name="kehuPhone"  id="kehuPhone" type="text" class="txt_1"  />
						<font color="red"></font>
					</td>
				</tr>

				<tr>
					<td nowrap="nowrap" align="center" class="f_bold">΢�ź�</td>
					<td nowrap="nowrap" align="center" ><input name="wechat"  id="wechat" type="text" class="txt_1"  />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" class="f_bold">�µ��ͷ�</td>
					<td nowrap="nowrap" align="center" >
						<%=request.getAttribute("userName")%>
					</td>
					<td nowrap="nowrap" align="center" class="f_bold">�Ա�</td>
					<td nowrap="nowrap" align="center" >
						<select name="sex" value="sex">
							<option value="��">��</option>
							<option value="Ů">Ů</option>
						</select>
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" class="f_bold">�ͻ�����</td>
					<td nowrap="nowrap" align="center" >
						<input name="kehuName"  id="kehuName" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
				</tr>

				<tr>
					<td nowrap="nowrap" align="center" class="f_bold"><button type="button" onclick="addTableOrder();" style="margin-left: 0px;">+</button>������</td>
<!-- 					<button type="button" onClick="setHiddenRow(document.getElementById('tab01'),0)" style="margin-left: 0px;">+</button> -->
					<td nowrap="nowrap" align="center" >
					<input name="orderNumber"  id="orderNumber" type="text" class="txt_1"  />
							
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" class="f_bold">���ۼ۸�</td>
					<td nowrap="nowrap" align="center" ><input name="salePrice"  id="salePrice" type="text" class="txt_1"  />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" class="f_bold">���</td>
					<td nowrap="nowrap" align="center" ><input name="height"  id="height" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" class="f_bold">����(KG)</td>
					<td nowrap="nowrap" align="center" ><input name="weight"  id="weight" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
				</tr>
				
				
				
				<tr>
					<td nowrap="nowrap" align="center" class="f_bold">������</td>
					<td nowrap="nowrap" align="center" ><input name="projectNo"  id="projectNo" type="text" class="txt_1"  />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" class="f_bold">�µ�ʱ��</td>
					<td nowrap="nowrap" align="left" >
					
						   <input style="border:none;" type="text"      name="kehuPhone1221" id="kehuPhone1212"   value="<%=request.getAttribute("sj_new")%>"  >
					<!-- 	<input type="text" name="date"  id="today"> -->
						 </td>
					<td nowrap="nowrap" align="center"  rowspan="2" class="f_bold">�ͻ���ַ</td>
					<td nowrap="nowrap" align="left"  colspan="3" rowspan="2"><input name="address" id="address" type="text" class="txt_1" />
						<font color="red"></font>
					</td>
				</tr>
				<tr>
					<td nowrap="nowrap" align="center" class="f_bold">��������</td>
					<td nowrap="nowrap" align="center" >
						<select name="orderType" value="orderType">
							<option value="�µ�">�µ�</option>
							<option value="����">����</option>
							<option value="����">����</option>
						</select>
					</td>
					<td nowrap="nowrap" align="center" class="f_bold">����ʱ��</td>
					<td nowrap="nowrap" align="left" >
<input name="jiaofu_time" type="text" class="txt_1"  id="jiaofu_time" style="cursor:text" 
onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"
								
								size="20" > 
						<!-- 	<input name="startTime1" type="text" class="txt_1"  id="startTime1" style="cursor:text"
								 onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
								size="20" readonly> -->
						
						<!-- <select name="jiaofu_time"  id="jiaofu_time" onchange="look();" >
						<option value="10">+10��  �Ӽ�</option>
						<option value="5">+5��  �ر�Ӽ�</option>
						<option value="3">+3��   �ǳ�����</option>
				</select>  -->
					</td>

				</tr>
				<tr class="t_subtitle">
					<td nowrap="nowrap" align="center" class="f_bold">��װ����</td>
					<td nowrap="nowrap" align="left" >
						<input name="xizhuang_number"  id="xizhuang_number" type="number" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" class="f_bold">����</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
					<td nowrap="nowrap" align="center" class="f_bold">��������</td>
					<td nowrap="nowrap" align="left" >
						<input name="chenshan_number"  id="chenshan_number" type="number" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" class="f_bold">������</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
				</tr>
				<tr>
					<td nowrap="nowrap" align="center" class="f_bold">���</td>
					<td nowrap="nowrap" align="center" >
						<input name="jiankuanA"  id="jiankuanA" type="text" class="txt_1" maxlength="100" /></td>
					<td nowrap="nowrap" align="center" >
						<input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" />
					</td>
					<td nowrap="nowrap" align="center"  rowspan="4">
						<img src="http://47.111.148.8/watch/upload/test.png" width="100" height="100" />
					</td>
					<td nowrap="nowrap" align="center" class="f_bold">��Χ</td>
					<td nowrap="nowrap" align="center" >
						<input name="lingweiB"  id="lingweiB" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" > <input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
					<td nowrap="nowrap" align="center"  rowspan="4">
						<img src="http://47.111.148.8/watch/upload/test.png" width="100" height="100" />
					</td>
				</tr>
				<tr class="td_bg_pink">
					<td nowrap="nowrap" align="center" class="f_bold">��Χ</td>
					<td nowrap="nowrap" align="center" >
						<input name="xiongweiA"  id="xiongweiA" type="text" class="txt_1" maxlength="100" onchange="setwechat(this.value)" />
						<font color="red"></font>
					</td>

					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
					<td nowrap="nowrap" align="center" class="f_bold">��Χ</td>
					<td nowrap="nowrap" align="center" >
						<input name="xiongweiB"  id="xiongweiB" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

				</tr>
				<tr>
					<td nowrap="nowrap" align="center" class="f_bold">����</td>
					<td nowrap="nowrap" align="center" >
						<input name="zhongyaoA"  id="zhongyaoA" type="text" class="txt_1" maxlength="100" onchange="setzhongyao(this.value)" />
						<font color="red"></font>
					</td>

					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
					<td nowrap="nowrap" align="center" class="f_bold">����</td>
					<td nowrap="nowrap" align="center" >
						<input name="zhongyaoB"  id="zhongyaoB" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

				</tr>
				<tr class="td_bg_pink">
					<td nowrap="nowrap" align="center" class="f_bold">��Χ</td>
					<td nowrap="nowrap" align="center" >
						<input name="fuweiA"  id="fuweiA" type="text" class="txt_1" maxlength="100" onchange="setfuwei(this.value)" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

					<td nowrap="nowrap" align="center" class="f_bold">��Χ</td>
					<td nowrap="nowrap" align="center" >
						<input name="fuweiB"  id="fuweiB" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

				</tr>
				<tr>
					<td nowrap="nowrap" align="center" class="f_bold">�����³�</td>
					<td nowrap="nowrap" align="center" >
						<input name="houzhongyichangA"  id="houzhongyichangA" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
					<td nowrap="nowrap" align="center"  rowspan="5"><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
					<td nowrap="nowrap" align="center" class="f_bold">�³�</td>
					<td nowrap="nowrap" align="center" >
						<input name="yichangB2"  type="text" class="txt_1" maxlength="50">
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
					<td nowrap="nowrap" align="center"  rowspan="5"><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
				</tr>
				<tr class="td_bg_pink">
					<td nowrap="nowrap" align="center" class="f_bold">ǰ�³�</td>
					<td nowrap="nowrap" align="center" >
						<input name="qianyichangA"  id="qianyichangA" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

					<td nowrap="nowrap" align="center" class="f_bold">��Χ</td>
					<td nowrap="nowrap" align="center" >
						<input style="border:none;" name="fuwei_quea"  type="text" class="txt_1" maxlength="50">
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

				</tr>
				<tr>
					<td nowrap="nowrap" align="center" class="f_bold">�䳤</td>
					<td nowrap="nowrap" align="center" >
						<input name="xiuchangB"  id="xiuchangB" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

					<td nowrap="nowrap" align="center" class="f_bold">�䳤</td>
					<td nowrap="nowrap" align="center" ><input name="xiuchangA"  id="xiuchangA" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

				</tr>
				<tr class="td_bg_pink">
					<td nowrap="nowrap" align="center" class="f_bold">���</td>
					<td nowrap="nowrap" align="center" >
						<input name="xiufeiB"  id="xiufeiB" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

					<td nowrap="nowrap" align="center" class="f_bold">���</td>
					<td nowrap="nowrap" align="center" ><input name="xiufeiA"  id="xiufeiA" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

				</tr>
				<tr>
					<td nowrap="nowrap" align="center" class="f_bold">���</td>
					<td nowrap="nowrap" align="center" >
						<input name="xiukouB"  id="xiukouB" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

					<td nowrap="nowrap" align="center" class="f_bold">���</td>
					<td nowrap="nowrap" align="center" ><input name="xiukouA"  id="xiukouA" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

				</tr>
				<tr class="t_subtitle">
					<td nowrap="nowrap" align="center" class="f_bold">��������</td>
					<td nowrap="nowrap" align="left" ><input name="xiku_number"  id="xiku_number" type="number" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" class="f_bold">����</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
					<td nowrap="nowrap" align="center" class="f_bold">�������</td>
					<td nowrap="nowrap" align="left" ><input name="majia_number"  id="majia_number" type="number" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" class="f_bold">�����</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

				</tr>
				<tr>
					<td nowrap="nowrap" align="center" class="f_bold">��Χ</td>
					<td nowrap="nowrap" align="center" ><input name="yaoweiC"  id="yaoweiC" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
					<td nowrap="nowrap" align="center"  rowspan="4">
						<img src="http://47.111.148.8/watch/upload/test.png" width="100" height="100" />
					</td>
					<td nowrap="nowrap" align="center" class="f_bold">���</td>
					<td nowrap="nowrap" align="center" >
						<input name="jiankuannew"  type="text" class="txt_1" maxlength="50">
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
					<td nowrap="nowrap" align="center"  rowspan="4">
						<img src="http://47.111.148.8/watch/upload/test.png" width="100" height="100" />
					</td>
				</tr>
				<tr class="td_bg_pink">
					<td nowrap="nowrap" align="center" class="f_bold">��Χ</td>
					<td nowrap="nowrap" align="center" ><input name="tuiweiC"  id="tuiweiC" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>

					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
					<td nowrap="nowrap" align="center" class="f_bold">��Χ</td>
					<td nowrap="nowrap" align="center" ><input name="xiongweiD"  id="xiongweiD" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

				</tr>
				<tr>
					<td nowrap="nowrap" align="center" class="f_bold">��Χ</td>
					<td nowrap="nowrap" align="center" ><input name="dangweiC"  id="dangweiC" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>

					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
					<td nowrap="nowrap" align="center" class="f_bold">����</td>
					<td nowrap="nowrap" align="center" ><input name="zhongyaoD"  id="zhongyaoD" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

				</tr>
				<tr class="td_bg_pink">
					<td nowrap="nowrap" align="center" class="f_bold">����</td>
					<td nowrap="nowrap" align="center" ><input name="datuiC"  id="datuiC" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>

					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
					<td nowrap="nowrap" align="center" class="f_bold">�³�</td>
					<td nowrap="nowrap" align="center" ><input name="yichangD"  id="yichangD" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

				</tr>
				<tr>
					<td nowrap="nowrap" align="center" class="f_bold">����</td>
					<td nowrap="nowrap" align="center" ><input name="zhongtuiC"  id="zhongtuiC" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
					<td nowrap="nowrap" align="center"  rowspan="4"><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
					<td nowrap="nowrap" align="center"  rowspan="4" class="f_bold">����</td>
					<td nowrap="nowrap" align="center"  rowspan="4" colspan="2">
						<select name="kuanxingD" value="kuanxingD">
							<option value="����">����</option>
							<option value="����+">����+</option>
							<option value="����">����</option>
							<option value="����+">����+</option>
							<option value="����">����</option>
							<option value="����+">����+</option>
						</select>
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center"  rowspan="4"><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
				</tr>
				<tr class="td_bg_pink">
					<td nowrap="nowrap" align="center" class="f_bold">С��</td>
					<td nowrap="nowrap" align="center" ><input name="xiaotuiC"  id="xiaotuiC" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

				</tr>
				<tr>
					<td nowrap="nowrap" align="center" class="f_bold">�㳤</td>
					<td nowrap="nowrap" align="center" ><input name="kuchangC"  id="kuchangC" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

				</tr>
				<tr class="td_bg_pink">
					<td nowrap="nowrap" align="center" class="f_bold">�ſ�</td>
					<td nowrap="nowrap" align="center" ><input name="tuikouC"  id="tuikouC" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

				</tr>
				<tr>
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">����</td>
					<td nowrap="nowrap" align="center" >
						<select name="kouxingC" value="kouxingC" onchange="setSecond(this)">
							<option value=""></option>
							<option value="һ����">һ����</option>
							<option value="������">������</option>
							<option value="������">������</option>
							<option value="˫�Ŷ���һ">˫�Ŷ���һ</option>
							<option value="˫���Ŀ۶�">˫���Ŀ۶�</option>
							<option value="˫�����۶�">˫�����۶�</option>
							<option value="������">������</option>
							<option value="����">����</option>
						</select>
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">�ڴ�</td>
					<td nowrap="nowrap" align="center" >
						<select name="koudaiC" value="koudaiC">
							<option value=""></option>
							<option value="ƽ����">ƽ����</option>
							<option value="ƽ����">ƽ����</option>
							<option value="ƽ˫��">ƽ˫��</option>
							<option value="б����">б����</option>
							<option value="б����">б����</option>
							<option value="б˫��">б˫��</option>
							<option value="������">������</option>
						</select>
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">����</td>
					<td nowrap="nowrap" align="center" >
						<select name="kaicha" value="kaicha">
							<option value=""></option>
							<option value="����">����</option>
							<option value="˫��">˫��</option>
							<option value="������">������</option>
						</select>
					</td>
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">����</td>
					<td nowrap="nowrap" align="center" >
						<!-- <input name="lingkoukuaishiB" 
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
							<option value="����">����</option>
						</select>
					</td>
				</tr>
				<tr>
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">�°�</td>
					<td nowrap="nowrap" align="center" >
						<select id="xiabai" name="xiabai">

							<option value=""></option>
							<option value="Բ���°�">Բ���°�</option>
							<option value="ֱ���°ڣ�˫�ſ�Ĭ�ϣ�">ֱ���°ڣ�˫�ſ�Ĭ�ϣ�</option>
							<option value="��Բ���°�">��Բ���°�</option>
							<option value="��β�°�">��β�°�</option>
							<option value="����">����</option>
						</select>
					</td>
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">ײɫ</td>
					<td nowrap="nowrap" align="center" >
						<select name="zhuangse" value="zhuangse">
							<option value=""></option>
							<option value="������ɫ��">������ɫ��</option>
							<option value="�����ɫ��">�����ɫ��</option>
							<option value="��ͷ��ɫ��">��ͷ��ɫ��</option>
						</select>
					</td>
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">�����</td>
					<td nowrap="nowrap" align="center" >
						<select name="waizhubian" value="waizhubian">
							<option value=""></option>
							<option value="��">��</option>
							<option value="��">��</option>
						</select>

						<!-- 	<input name="waizhubian" 
					id="waizhubian" type="text" class="txt_1" maxlength="100" /><font
					color="red"></font> -->
					</td>
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">���</td>
					<td nowrap="nowrap" align="center" >
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
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">����</td>
					<td nowrap="nowrap" align="center" >
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
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">����</td>
					<td nowrap="nowrap" align="center" >
						<select name="kuxing" value="kuxing">
							<option value=""></option>
							<option value="�����">�����</option>
							<option value="����">����</option>
							<option value="����">����</option>
							<option value="˫��">˫��</option>
							<option value="�ܲ���">�ܲ���</option>
							<option value="ֱͲ��">ֱͲ��</option>
							<option value="���ȿ�">���ȿ�</option>
							<option value="����">����</option>
						</select>
					</td>
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">������</td>
					<td nowrap="nowrap" align="center" >
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
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">������</td>
					<td nowrap="nowrap" align="center" >
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
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold"><button type="button" onclick="addTable();" style="margin-left: 0px;">+</button>����</td>
					<td nowrap="nowrap" align="center" >
						<input name="miaoliao1"  id="miaoliao1" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">��;</td>
					<td nowrap="nowrap" align="center" >
						<select name="yongtu1" value="yongtu1">
							<option value=""></option>
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
						<table class="tbl_11" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">����</td>
								<td nowrap="nowrap" align="center" style="border: 0;">
									<input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" />
								</td>
							</tr>
						</table>
					</td>
					<td nowrap="nowrap" style="padding: 0;">
						<table class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">�۸�</td>
							<td nowrap="nowrap" align="center" style="border: 0;"><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
						</tr>
						</table>
					</td>
					
					
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">��Ӧ��</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
					
				</tr>
				<!-- <tr>
				<td nowrap="nowrap" align="center" >����</td>
				<td nowrap="nowrap" align="center" >
				<input name="miaoliao2"  id="miaoliao2"
					type="text" class="txt_1" maxlength="100" /><font color="red"></font>
				</td>
				<td nowrap="nowrap" align="center" >��;</td>
				<td nowrap="nowrap" align="center" >
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
				<td nowrap="nowrap" align="center" >����</td>
				<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" >��Ӧ��</td>
				<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
			</tr> -->
				<tr>
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">����</td>
					<td nowrap="nowrap" align="center" >
						<input type="file" name="channelId" />
						<!--  <input type="file" name="impFile[0]"  style="width:50px;"/>
                    <input type="file" name="impFile[1]"  style="width:50px;"/> -->
						<!--  <img alt=""  multiple="multiple"  
					src="" id="image1" class="showImage"> -->

					</td>

					<td nowrap="nowrap" align="center" >

						<input type="file" name="impFile[0]" />
						<!--   <input type="file" name="impFile[1]"  style="width:50px;"/> -->
						<!--  <img alt=""  multiple="multiple"  
					src="" id="image1" class="showImage"> -->

					</td>

					<td nowrap="nowrap" align="center" >
						<input type="file" name="impFile[1]" />
					</td>
					<td nowrap="nowrap" align="center" >
						<input type="file" name="impFile[2]" />
					</td>
					<td nowrap="nowrap" align="center" >
						<input type="file" name="impFile[3]" />
					</td>
					<td nowrap="nowrap" align="center" ></td>
					<td nowrap="nowrap" align="center" ></td>
				</tr>

				<tr>
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">�ͷ���ע</td>
					<td nowrap="nowrap" align="left"  colspan="7">
						<input name="remark" id="remark" type="text" class="txt_1"  />
						<font color="red"></font>
					</td>
				</tr>
				<tr>
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">������ע</td>
					<td nowrap="nowrap" align="left"  colspan="7">

						<input name="" id="" type="text" class="txt_1"  readonly="true" />
					</td>
				</tr>
				<tr>
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">������ע</td>
					<td nowrap="nowrap" align="left"  colspan="7">
						<input name="" id="" type="text" class="txt_1"  readonly="true" />
					</td>
				</tr>
				<!-- 	<tr>
				<td nowrap="nowrap" align="center" >�ύ����</td>
				<td nowrap="nowrap" align="center"  colspan="7">
					���� <input name="tag" type="radio" class="radio_1" value="1" checked="checked" >
	    ���沢�ύ<input type="radio" name="tag" class="radio_1" value="2" >
				</td>
			</tr> -->

				<tr>
					<td nowrap="nowrap" align="center" ></td>
					<td nowrap="nowrap" align="right" >
						<input name="anniu" id="anniu" type="hidden" class="txt_1" />
							<input  name="addhang"  id="addhang" type="hidden" class="txt_1"   value="0"/>
							<input  name="addhang1"  id="addhang1" type="hidden" class="txt_1"   value="0"/>

						<input id="ok" title="1" type="button" name="ok" accesskey="y" tabindex="y" value="����" class="but_1 btn" onclick="onAdd(this.title)">
					</td>
					<td nowrap="nowrap" align="left" >
						<input id="ok" title="2" type="button" name="ok" accesskey="y" tabindex="y" value="���沢�ύ" class="but_1 btn" onclick="onAdd(this.title)">

						<input type="button" name="back" accesskey="b" tabindex="b" value="����" class="but_1 btn" onclick="location='doProjectInfo.do?method=queryProjectInfoXml'">
					</td>

				</tr>

			</table>

		</form>
	</body>

</html>
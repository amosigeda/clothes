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
		<title>无标题文档</title>
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
							alert("订单号重复！！！");
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
							alert("订单号重复！！！");
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
			if(val == "双排二扣一" || val == "双排四扣二" || val == "双排六扣二") {
				var sec = document.getElementById("xiabai");
				sec.innerHTML = "<option>直角下摆</option><option>圆角下摆</option><option>大圆角下摆</option><option>燕尾下摆</option><option>其他</option>";

				/* 		<option value="圆角下摆">圆角下摆</option>
						<option value="直角下摆（双排扣默认）">直角下摆（双排扣默认）</option>
						<option value="大圆角下摆">大圆角下摆</option>
						<option value="燕尾下摆">燕尾下摆</option>
						<option value="其他">其他</option> */

			} else {
				var sec = document.getElementById("xiabai");
				sec.innerHTML = "<option></option><option>直角下摆</option><option>圆角下摆</option><option>大圆角下摆</option><option>燕尾下摆</option><option>其他</option>";
			}
		}

		function onAdd(wechat) {
			document.getElementById("anniu").setAttribute("value", wechat);

			if(frmGo.orderNumber.value.trim() == "") {
				alert("订单号不能为空！");
				frmGo.orderNumber.focus();
				return false;
			}
			
			frmGo.submit();
		}

		function onAddd(wechat) {
			document.getElementById("anniu").setAttribute("value", wechat);

			if(frmGo.orderNumber.value.trim() == "") {
				alert("订单号不能为空！");
				frmGo.orderNumber.focus();
				return false;
			}
			if(frmGo.kehuPhone.value.trim() == "") {
				alert("客户电话为空！");
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
			var tab = document.getElementById("tab01"); //获得表格
			//var colsNum = tab.rows.item(0).cells.length; //表格的列数
			//表格当前的行数 
			var num = document.getElementById("tab01").rows.length;
			/*   alert("当前行="+num); */
				var addhang1 = parseFloat(frmGo.addhang1.value); 
			
			var rownum = num - 30-addhang1;

			tab.insertRow(rownum);

			var n = rownum - 3;
		
			
			/* alert(n);  */
			
			  document.getElementById("addhang").setAttribute("value", n);
			
			if(n <= 9) {
				for(var i = 0; i < 8; i++) {
					tab.rows[rownum].insertCell(i); //插入列
					tab.rows[rownum].cells[i].setAttribute("align", "center");
					if(i == 0) {
						tab.rows[rownum].cells[i].setAttribute("class", "td_bg_yellow");
						tab.rows[rownum].cells[i].innerHTML = '<button type="button" onclick="delRowOrder(this)">-</button> 订单号';
					} else if(i == 1) {
						tab.rows[rownum].cells[i].innerHTML = '<input name="orderNumber' + n + '"   id="orderNumber' + n + '" value=""  type="text"   maxlength="100" />';
					} else if(i == 2) {
						tab.rows[rownum].cells[i].setAttribute("class", "td_bg_yellow");
						tab.rows[rownum].cells[i].innerHTML = '销售价格';
					} else if(i == 3) {
						tab.rows[rownum].cells[i].innerHTML = '<input name="xsjg' + n + '" type="text" value=""  maxlength="100" />';
					}
				}
				//tab.rows[rownum].insertCell(i);
				//tab.rows[rownum].cells[i].innerHTML = '<a href="#" onclick="delRow(this)">-</a>';
			} else {
				alert("最多新增9行");
			}
		}
		//删除行
		function delRowOrder(obj) {
			var Row = obj.parentNode;
			var Row = obj.parentNode; //tr
			while(Row.tagName.toLowerCase() != "tr") {
				Row = Row.parentNode;
			}
			Row.parentNode.removeChild(Row); //删除行
		}
		
		//添加行  id="huanjiename'+n+'"
		function addTable() {
			var tab = document.getElementById("tab01"); //获得表格
			//var colsNum = tab.rows.item(0).cells.length; //表格的列数
			//表格当前的行数 
			var num = document.getElementById("tab01").rows.length;
			/*   alert("当前行="+num); */
			var rownum = num - 5;

			tab.insertRow(rownum);

			var n = rownum - 28;
			var addhang = parseFloat(frmGo.addhang.value); 
			n=n-addhang;
			 document.getElementById("addhang1").setAttribute("value", n);
			
			
			if(n <= 14) {
				for(var i = 0; i < 8; i++) {
					tab.rows[rownum].insertCell(i); //插入列
					tab.rows[rownum].cells[i].setAttribute("align", "center");
					if(i == 0) {
						tab.rows[rownum].cells[i].setAttribute("class", "td_bg_yellow");
						tab.rows[rownum].cells[i].innerHTML = '<button type="button" onclick="delRow(this)">-</button> 面料';
					} else if(i == 1) {
						tab.rows[rownum].cells[i].innerHTML = '<input name="ml' + n + '" type="text"   maxlength="100" />';
					} else if(i == 2) {
						tab.rows[rownum].cells[i].setAttribute("class", "td_bg_yellow");
						tab.rows[rownum].cells[i].innerHTML = '用途';
					} else if(i == 3) {
						tab.rows[rownum].cells[i].innerHTML = '<select name="yt' + n + '"  value="" style="width:100%"  > <option value=""></option> <option value="上衣">上衣</option> <option value="裤子">裤子</option>  <option value="马甲">马甲</option> <option value="衬衫">衬衫</option> <option value="西装套装">西装套装</option><option value="换片">换片</option><option value="其他">其他</option></select>';

						/* '<input name="yt'+n+'" type="text"  maxlength="100"/>'; */

						/* <option value="上衣">上衣</option>
						<option value="裤子">裤子</option>
						<option value="马甲">马甲</option>
						<option value="衬衫">衬衫</option>
						<option value="西装套装">西装套装</option>
						<option value="换片">换片</option>
						<option value="其他">其他</option> */
						/* '<input name="yt'+n+'" type="text"  maxlength="100"/>'; */
					} else if(i == 4) {
						tab.rows[rownum].cells[i].setAttribute("class", "padd0");
						tab.rows[rownum].cells[i].innerHTML = '<table class="tbl_11" cellspacing="0" cellpadding="0" border="0"><tbody><tr><td class="td_bg_yellow" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;" nowrap="nowrap" align="center">米数</td><td style="border: 0;" nowrap="nowrap" align="center"><input name="ms' + n + '" type="text"  maxlength="100" readonly="true" /></td></tr></tbody></table>';
					} else if(i == 5) {
						tab.rows[rownum].cells[i].setAttribute("class", "padd0");
						tab.rows[rownum].cells[i].innerHTML = '<table class="tbl_11" cellspacing="0" cellpadding="0" border="0"><tbody><tr><td class="td_bg_yellow" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;" nowrap="nowrap" align="center">价格</td><td style="border: 0;" nowrap="nowrap" align="center"><input name="jq' + n + '" type="text"  maxlength="100" readonly="true" /></td></tr></tbody></table>';
					} else if(i == 6) {
						tab.rows[rownum].cells[i].setAttribute("class", "td_bg_yellow");
						tab.rows[rownum].cells[i].innerHTML = '供应商';
					} else {
						tab.rows[rownum].cells[i].innerHTML = '<input name="gys' + n + '" type="text"  maxlength="100" readonly="true" />';
					}
				}
				//tab.rows[rownum].insertCell(i);
				//tab.rows[rownum].cells[i].innerHTML = '<a href="#" onclick="delRow(this)">-</a>';
			} else {
				alert("最多新增15行");
			}
		}
		//删除行
		function delRow(obj) {
			var Row = obj.parentNode;
			var Row = obj.parentNode; //tr
			while(Row.tagName.toLowerCase() != "tr") {
				Row = Row.parentNode;
			}
			Row.parentNode.removeChild(Row); //删除行
		}
		
		
		

		function look() {
			var value = document.getElementById("jiaofu_time").value; //获取值
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
    function today(){//构建方法
        var today=new Date();//new 出当前时间
        var h=today.getFullYear();//获取年
        var m=today.getMonth()+1;//获取月
        var d=today.getDate();//获取日
        var H = today.getHours();//获取时
        var M = today.getMinutes();//获取分
        var S = today.getSeconds();//获取秒
        return h+"-"+m+"-"+d+" "+H+":"+M+":"+S; //返回 年-月-日 时:分:秒
}
document.getElementById("today").value = today();//将获取到的 年-月-日 时:分:秒 赋给input文本输入框
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
					<th colspan="8" nowrap="nowrap" align="left"  >添加订单信息(客户档案) </th>
				</tr>
			
				

			<!-- 	<tr class="tr_11">
					<td colspan="8" nowrap="nowrap" align="center"  class="table_title">不一定制和周卢江 客户信息档案表</td>
				</tr>

			<tr class="t_subtitle">
					<td colspan="4" nowrap="nowrap" align="center" class="f_bold" >订单信息</td>
					<td colspan="4" nowrap="nowrap" align="center" class="f_bold">订单信息</td>
				</tr> -->

				<tr>
					<td nowrap="nowrap" align="center" class="f_bold">订单编号</td>
					<td nowrap="nowrap" align="center" >
						  <input name="wechataa"  id="wechataa"  readonly="true" type="text" class="txt_1"  value="<%=request.getAttribute("ding_dan")%>" />
					</td>
					<td nowrap="nowrap" align="center" class="f_bold">渠道</td>
					<td nowrap="nowrap" align="center" >
						<select name="qudao" value="qudao">
							<option value="深圳淘宝">深圳淘宝</option>
							<option value="南京淘宝">南京淘宝</option>
							<option value="工单">工单</option>
							<option value="分销">分销</option>
							<option value="打样">打样</option>
							<option value="重做">重做</option>
						
							<option value="线下转款_曹">线下转款_曹</option>
						<option value="线下转款_周">线下转款_周</option>
						<option value="线下转款_公账">线下转款_公账</option>
							<option value="其他">其他</option>
						</select>
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" class="f_bold">年龄</td>
					<td nowrap="nowrap" align="center" >
						<input name="age" id="age" type="number" class="txt_1"  />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" class="f_bold">客户电话</td>
					<td nowrap="nowrap" align="center" >
						<input name="kehuPhone"  id="kehuPhone" type="text" class="txt_1"  />
						<font color="red"></font>
					</td>
				</tr>

				<tr>
					<td nowrap="nowrap" align="center" class="f_bold">微信号</td>
					<td nowrap="nowrap" align="center" ><input name="wechat"  id="wechat" type="text" class="txt_1"  />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" class="f_bold">下单客服</td>
					<td nowrap="nowrap" align="center" >
						<%=request.getAttribute("userName")%>
					</td>
					<td nowrap="nowrap" align="center" class="f_bold">性别</td>
					<td nowrap="nowrap" align="center" >
						<select name="sex" value="sex">
							<option value="男">男</option>
							<option value="女">女</option>
						</select>
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" class="f_bold">客户姓名</td>
					<td nowrap="nowrap" align="center" >
						<input name="kehuName"  id="kehuName" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
				</tr>

				<tr>
					<td nowrap="nowrap" align="center" class="f_bold"><button type="button" onclick="addTableOrder();" style="margin-left: 0px;">+</button>订单号</td>
<!-- 					<button type="button" onClick="setHiddenRow(document.getElementById('tab01'),0)" style="margin-left: 0px;">+</button> -->
					<td nowrap="nowrap" align="center" >
					<input name="orderNumber"  id="orderNumber" type="text" class="txt_1"  />
							
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" class="f_bold">销售价格</td>
					<td nowrap="nowrap" align="center" ><input name="salePrice"  id="salePrice" type="text" class="txt_1"  />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" class="f_bold">身高</td>
					<td nowrap="nowrap" align="center" ><input name="height"  id="height" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" class="f_bold">体重(KG)</td>
					<td nowrap="nowrap" align="center" ><input name="weight"  id="weight" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
				</tr>
				
				
				
				<tr>
					<td nowrap="nowrap" align="center" class="f_bold">旺旺名</td>
					<td nowrap="nowrap" align="center" ><input name="projectNo"  id="projectNo" type="text" class="txt_1"  />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" class="f_bold">下单时间</td>
					<td nowrap="nowrap" align="left" >
					
						   <input style="border:none;" type="text"      name="kehuPhone1221" id="kehuPhone1212"   value="<%=request.getAttribute("sj_new")%>"  >
					<!-- 	<input type="text" name="date"  id="today"> -->
						 </td>
					<td nowrap="nowrap" align="center"  rowspan="2" class="f_bold">客户地址</td>
					<td nowrap="nowrap" align="left"  colspan="3" rowspan="2"><input name="address" id="address" type="text" class="txt_1" />
						<font color="red"></font>
					</td>
				</tr>
				<tr>
					<td nowrap="nowrap" align="center" class="f_bold">订单类型</td>
					<td nowrap="nowrap" align="center" >
						<select name="orderType" value="orderType">
							<option value="新单">新单</option>
							<option value="打样">打样</option>
							<option value="重做">重做</option>
						</select>
					</td>
					<td nowrap="nowrap" align="center" class="f_bold">交付时间</td>
					<td nowrap="nowrap" align="left" >
<input name="jiaofu_time" type="text" class="txt_1"  id="jiaofu_time" style="cursor:text" 
onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"
								
								size="20" > 
						<!-- 	<input name="startTime1" type="text" class="txt_1"  id="startTime1" style="cursor:text"
								 onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
								size="20" readonly> -->
						
						<!-- <select name="jiaofu_time"  id="jiaofu_time" onchange="look();" >
						<option value="10">+10天  加急</option>
						<option value="5">+5天  特别加急</option>
						<option value="3">+3天   非常紧急</option>
				</select>  -->
					</td>

				</tr>
				<tr class="t_subtitle">
					<td nowrap="nowrap" align="center" class="f_bold">西装数量</td>
					<td nowrap="nowrap" align="left" >
						<input name="xizhuang_number"  id="xizhuang_number" type="number" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" class="f_bold">衣码</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
					<td nowrap="nowrap" align="center" class="f_bold">衬衫数量</td>
					<td nowrap="nowrap" align="left" >
						<input name="chenshan_number"  id="chenshan_number" type="number" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" class="f_bold">衬衫码</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
				</tr>
				<tr>
					<td nowrap="nowrap" align="center" class="f_bold">肩宽</td>
					<td nowrap="nowrap" align="center" >
						<input name="jiankuanA"  id="jiankuanA" type="text" class="txt_1" maxlength="100" /></td>
					<td nowrap="nowrap" align="center" >
						<input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" />
					</td>
					<td nowrap="nowrap" align="center"  rowspan="4">
						<img src="http://47.111.148.8/watch/upload/test.png" width="100" height="100" />
					</td>
					<td nowrap="nowrap" align="center" class="f_bold">领围</td>
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
					<td nowrap="nowrap" align="center" class="f_bold">胸围</td>
					<td nowrap="nowrap" align="center" >
						<input name="xiongweiA"  id="xiongweiA" type="text" class="txt_1" maxlength="100" onchange="setwechat(this.value)" />
						<font color="red"></font>
					</td>

					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
					<td nowrap="nowrap" align="center" class="f_bold">胸围</td>
					<td nowrap="nowrap" align="center" >
						<input name="xiongweiB"  id="xiongweiB" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

				</tr>
				<tr>
					<td nowrap="nowrap" align="center" class="f_bold">中腰</td>
					<td nowrap="nowrap" align="center" >
						<input name="zhongyaoA"  id="zhongyaoA" type="text" class="txt_1" maxlength="100" onchange="setzhongyao(this.value)" />
						<font color="red"></font>
					</td>

					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
					<td nowrap="nowrap" align="center" class="f_bold">中腰</td>
					<td nowrap="nowrap" align="center" >
						<input name="zhongyaoB"  id="zhongyaoB" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

				</tr>
				<tr class="td_bg_pink">
					<td nowrap="nowrap" align="center" class="f_bold">腹围</td>
					<td nowrap="nowrap" align="center" >
						<input name="fuweiA"  id="fuweiA" type="text" class="txt_1" maxlength="100" onchange="setfuwei(this.value)" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

					<td nowrap="nowrap" align="center" class="f_bold">腹围</td>
					<td nowrap="nowrap" align="center" >
						<input name="fuweiB"  id="fuweiB" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

				</tr>
				<tr>
					<td nowrap="nowrap" align="center" class="f_bold">后中衣长</td>
					<td nowrap="nowrap" align="center" >
						<input name="houzhongyichangA"  id="houzhongyichangA" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
					<td nowrap="nowrap" align="center"  rowspan="5"><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
					<td nowrap="nowrap" align="center" class="f_bold">衣长</td>
					<td nowrap="nowrap" align="center" >
						<input name="yichangB2"  type="text" class="txt_1" maxlength="50">
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
					<td nowrap="nowrap" align="center"  rowspan="5"><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
				</tr>
				<tr class="td_bg_pink">
					<td nowrap="nowrap" align="center" class="f_bold">前衣长</td>
					<td nowrap="nowrap" align="center" >
						<input name="qianyichangA"  id="qianyichangA" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

					<td nowrap="nowrap" align="center" class="f_bold">腹围</td>
					<td nowrap="nowrap" align="center" >
						<input style="border:none;" name="fuwei_quea"  type="text" class="txt_1" maxlength="50">
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

				</tr>
				<tr>
					<td nowrap="nowrap" align="center" class="f_bold">袖长</td>
					<td nowrap="nowrap" align="center" >
						<input name="xiuchangB"  id="xiuchangB" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

					<td nowrap="nowrap" align="center" class="f_bold">袖长</td>
					<td nowrap="nowrap" align="center" ><input name="xiuchangA"  id="xiuchangA" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

				</tr>
				<tr class="td_bg_pink">
					<td nowrap="nowrap" align="center" class="f_bold">袖肥</td>
					<td nowrap="nowrap" align="center" >
						<input name="xiufeiB"  id="xiufeiB" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

					<td nowrap="nowrap" align="center" class="f_bold">袖肥</td>
					<td nowrap="nowrap" align="center" ><input name="xiufeiA"  id="xiufeiA" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

				</tr>
				<tr>
					<td nowrap="nowrap" align="center" class="f_bold">袖口</td>
					<td nowrap="nowrap" align="center" >
						<input name="xiukouB"  id="xiukouB" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

					<td nowrap="nowrap" align="center" class="f_bold">袖口</td>
					<td nowrap="nowrap" align="center" ><input name="xiukouA"  id="xiukouA" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

				</tr>
				<tr class="t_subtitle">
					<td nowrap="nowrap" align="center" class="f_bold">西裤数量</td>
					<td nowrap="nowrap" align="left" ><input name="xiku_number"  id="xiku_number" type="number" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" class="f_bold">裤码</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
					<td nowrap="nowrap" align="center" class="f_bold">马甲数量</td>
					<td nowrap="nowrap" align="left" ><input name="majia_number"  id="majia_number" type="number" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" class="f_bold">马甲码</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

				</tr>
				<tr>
					<td nowrap="nowrap" align="center" class="f_bold">腰围</td>
					<td nowrap="nowrap" align="center" ><input name="yaoweiC"  id="yaoweiC" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
					<td nowrap="nowrap" align="center"  rowspan="4">
						<img src="http://47.111.148.8/watch/upload/test.png" width="100" height="100" />
					</td>
					<td nowrap="nowrap" align="center" class="f_bold">肩宽</td>
					<td nowrap="nowrap" align="center" >
						<input name="jiankuannew"  type="text" class="txt_1" maxlength="50">
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
					<td nowrap="nowrap" align="center"  rowspan="4">
						<img src="http://47.111.148.8/watch/upload/test.png" width="100" height="100" />
					</td>
				</tr>
				<tr class="td_bg_pink">
					<td nowrap="nowrap" align="center" class="f_bold">臀围</td>
					<td nowrap="nowrap" align="center" ><input name="tuiweiC"  id="tuiweiC" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>

					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
					<td nowrap="nowrap" align="center" class="f_bold">胸围</td>
					<td nowrap="nowrap" align="center" ><input name="xiongweiD"  id="xiongweiD" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

				</tr>
				<tr>
					<td nowrap="nowrap" align="center" class="f_bold">档围</td>
					<td nowrap="nowrap" align="center" ><input name="dangweiC"  id="dangweiC" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>

					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
					<td nowrap="nowrap" align="center" class="f_bold">中腰</td>
					<td nowrap="nowrap" align="center" ><input name="zhongyaoD"  id="zhongyaoD" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

				</tr>
				<tr class="td_bg_pink">
					<td nowrap="nowrap" align="center" class="f_bold">大腿</td>
					<td nowrap="nowrap" align="center" ><input name="datuiC"  id="datuiC" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>

					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
					<td nowrap="nowrap" align="center" class="f_bold">衣长</td>
					<td nowrap="nowrap" align="center" ><input name="yichangD"  id="yichangD" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

				</tr>
				<tr>
					<td nowrap="nowrap" align="center" class="f_bold">中腿</td>
					<td nowrap="nowrap" align="center" ><input name="zhongtuiC"  id="zhongtuiC" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
					<td nowrap="nowrap" align="center"  rowspan="4"><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
					<td nowrap="nowrap" align="center"  rowspan="4" class="f_bold">款型</td>
					<td nowrap="nowrap" align="center"  rowspan="4" colspan="2">
						<select name="kuanxingD" value="kuanxingD">
							<option value="修身">修身</option>
							<option value="修身+">修身+</option>
							<option value="合身">合身</option>
							<option value="合身+">合身+</option>
							<option value="宽松">宽松</option>
							<option value="宽松+">宽松+</option>
						</select>
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center"  rowspan="4"><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
				</tr>
				<tr class="td_bg_pink">
					<td nowrap="nowrap" align="center" class="f_bold">小腿</td>
					<td nowrap="nowrap" align="center" ><input name="xiaotuiC"  id="xiaotuiC" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

				</tr>
				<tr>
					<td nowrap="nowrap" align="center" class="f_bold">裤长</td>
					<td nowrap="nowrap" align="center" ><input name="kuchangC"  id="kuchangC" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

				</tr>
				<tr class="td_bg_pink">
					<td nowrap="nowrap" align="center" class="f_bold">脚口</td>
					<td nowrap="nowrap" align="center" ><input name="tuikouC"  id="tuikouC" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>

				</tr>
				<tr>
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">扣型</td>
					<td nowrap="nowrap" align="center" >
						<select name="kouxingC" value="kouxingC" onchange="setSecond(this)">
							<option value=""></option>
							<option value="一粒扣">一粒扣</option>
							<option value="二粒扣">二粒扣</option>
							<option value="三粒扣">三粒扣</option>
							<option value="双排二扣一">双排二扣一</option>
							<option value="双排四扣二">双排四扣二</option>
							<option value="双排六扣二">双排六扣二</option>
							<option value="五粒扣">五粒扣</option>
							<option value="其他">其他</option>
						</select>
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">口袋</td>
					<td nowrap="nowrap" align="center" >
						<select name="koudaiC" value="koudaiC">
							<option value=""></option>
							<option value="平袋盖">平袋盖</option>
							<option value="平单线">平单线</option>
							<option value="平双线">平双线</option>
							<option value="斜袋盖">斜袋盖</option>
							<option value="斜单线">斜单线</option>
							<option value="斜双线">斜双线</option>
							<option value="外贴袋">外贴袋</option>
						</select>
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">开叉</td>
					<td nowrap="nowrap" align="center" >
						<select name="kaicha" value="kaicha">
							<option value=""></option>
							<option value="单叉">单叉</option>
							<option value="双叉">双叉</option>
							<option value="不开叉">不开叉</option>
						</select>
					</td>
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">领型</td>
					<td nowrap="nowrap" align="center" >
						<!-- <input name="lingkoukuaishiB" 
					id="lingkoukuaishiB" type="text" class="txt_1" maxlength="100" /><font
					color="red"></font> -->
						<select name="lingkoukuaishiB" value="lingkoukuaishiB">
							<option value=""></option>
							<option value="平驳领">平驳领</option>
							<option value="戗驳领">戗驳领</option>
							<option value="青果领">青果领</option>
							<option value="假青果">假青果</option>
							<option value="假平驳">假平驳</option>
							<option value="宽平驳">宽平驳</option>
							<option value="宽戗驳">宽戗驳</option>
							<option value="立领">立领</option>
							<option value="其他">其他</option>
						</select>
					</td>
				</tr>
				<tr>
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">下摆</td>
					<td nowrap="nowrap" align="center" >
						<select id="xiabai" name="xiabai">

							<option value=""></option>
							<option value="圆角下摆">圆角下摆</option>
							<option value="直角下摆（双排扣默认）">直角下摆（双排扣默认）</option>
							<option value="大圆角下摆">大圆角下摆</option>
							<option value="燕尾下摆">燕尾下摆</option>
							<option value="其他">其他</option>
						</select>
					</td>
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">撞色</td>
					<td nowrap="nowrap" align="center" >
						<select name="zhuangse" value="zhuangse">
							<option value=""></option>
							<option value="袋条用色丁">袋条用色丁</option>
							<option value="领边有色丁">领边有色丁</option>
							<option value="驳头用色丁">驳头用色丁</option>
						</select>
					</td>
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">外珠边</td>
					<td nowrap="nowrap" align="center" >
						<select name="waizhubian" value="waizhubian">
							<option value=""></option>
							<option value="有">有</option>
							<option value="无">无</option>
						</select>

						<!-- 	<input name="waizhubian" 
					id="waizhubian" type="text" class="txt_1" maxlength="100" /><font
					color="red"></font> -->
					</td>
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">袖叉</td>
					<td nowrap="nowrap" align="center" >
						<select name="xiucha" value="xiucha">
							<option value=""></option>
							<option value="真袖叉">真袖叉</option>
							<option value="假袖叉">假袖叉</option>
							<option value="翻袖">翻袖</option>
							<option value="其它">其它</option>
						</select>
					</td>
				</tr>
				<tr>
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">裤腰</td>
					<td nowrap="nowrap" align="center" >
						<select name="kuyao" value="kuyao">
							<option value=""></option>
							<option value="伸出订扣">伸出订扣</option>
							<option value="伸出订钩">伸出订钩</option>
							<option value="不伸头">不伸头</option>
							<option value="松紧">松紧</option>
							<option value="调节扣">调节扣</option>
							<option value="那不勒斯">那不勒斯</option>
							<option value="其它">其它</option>
						</select>
					</td>
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">裤型</td>
					<td nowrap="nowrap" align="center" >
						<select name="kuxing" value="kuxing">
							<option value=""></option>
							<option value="修身裤">修身裤</option>
							<option value="翻边">翻边</option>
							<option value="单褶">单褶</option>
							<option value="双褶">双褶</option>
							<option value="萝卜裤">萝卜裤</option>
							<option value="直筒裤">直筒裤</option>
							<option value="阔腿裤">阔腿裤</option>
							<option value="其它">其它</option>
						</select>
					</td>
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">衬衫领</td>
					<td nowrap="nowrap" align="center" >
						<select name="chenshanling" value="chenshanling">
							<option value=""></option>
							<option value="小方领">小方领</option>
							<option value="小尖领">小尖领</option>
							<option value="v尖领">v尖领</option>
							<option value="正方领">正方领</option>
							<option value="大领">大领</option>
							<option value="其它">其它</option>
						</select>
					</td>
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">衬衫袖</td>
					<td nowrap="nowrap" align="center" >
						<select name="chenshanxiu" value="chenshanxiu">
							<option value=""></option>
							<option value="法式门襟＋袖">法式门襟＋袖</option>
							<option value="直角二扣">直角二扣</option>
							<option value="直角一扣">直角一扣</option>
							<option value="圆角二扣">圆角二扣</option>
							<option value="圆角一扣">圆角一扣</option>
							<option value="翻袖">翻袖</option>
							<option value="其它">其它</option>
						</select>
					</td>
				</tr>
				<tr>
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold"><button type="button" onclick="addTable();" style="margin-left: 0px;">+</button>面料</td>
					<td nowrap="nowrap" align="center" >
						<input name="miaoliao1"  id="miaoliao1" type="text" class="txt_1" maxlength="100" />
						<font color="red"></font>
					</td>
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">用途</td>
					<td nowrap="nowrap" align="center" >
						<select name="yongtu1" value="yongtu1">
							<option value=""></option>
							<option value="上衣">上衣</option>
							<option value="裤子">裤子</option>
							<option value="马甲">马甲</option>
							<option value="衬衫">衬衫</option>
							<option value="西装套装">西装套装</option>
							<option value="换片">换片</option>
							<option value="其他">其他</option>
						</select>
					</td>
					<td nowrap="nowrap" style="padding: 0;">
						<table class="tbl_11" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">米数</td>
								<td nowrap="nowrap" align="center" style="border: 0;">
									<input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" />
								</td>
							</tr>
						</table>
					</td>
					<td nowrap="nowrap" style="padding: 0;">
						<table class="tbl_11" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold" style="border-left: 0; border-bottom: 0; border-right: 1px solid #bbb;">价格</td>
							<td nowrap="nowrap" align="center" style="border: 0;"><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
						</tr>
						</table>
					</td>
					
					
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">供应商</td>
					<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true" /></td>
					
				</tr>
				<!-- <tr>
				<td nowrap="nowrap" align="center" >面料</td>
				<td nowrap="nowrap" align="center" >
				<input name="miaoliao2"  id="miaoliao2"
					type="text" class="txt_1" maxlength="100" /><font color="red"></font>
				</td>
				<td nowrap="nowrap" align="center" >用途</td>
				<td nowrap="nowrap" align="center" >
				<select name="yongtu2" value="yongtu2">
				<option value=""></option>
						<option value="上衣">上衣</option>
						<option value="裤子">裤子</option>
						<option value="马甲">马甲</option>
						<option value="衬衫">衬衫</option>
						<option value="西装套装">西装套装</option>
						<option value="换片">换片</option>
						<option value="其他">其他</option>
				</select> <font color="red"></font>
				</td>
				<td nowrap="nowrap" align="center" >米数</td>
				<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
				<td nowrap="nowrap" align="center" >供应商</td>
				<td nowrap="nowrap" align="center" ><input name=""  id="" type="text" class="txt_1" maxlength="100" readonly="true"  /></td>
			</tr> -->
				<tr>
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">附件</td>
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
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">客服备注</td>
					<td nowrap="nowrap" align="left"  colspan="7">
						<input name="remark" id="remark" type="text" class="txt_1"  />
						<font color="red"></font>
					</td>
				</tr>
				<tr>
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">批单备注</td>
					<td nowrap="nowrap" align="left"  colspan="7">

						<input name="" id="" type="text" class="txt_1"  readonly="true" />
					</td>
				</tr>
				<tr>
					<td nowrap="nowrap" align="center" class="td_bg_yellow f_bold">跟单备注</td>
					<td nowrap="nowrap" align="left"  colspan="7">
						<input name="" id="" type="text" class="txt_1"  readonly="true" />
					</td>
				</tr>
				<!-- 	<tr>
				<td nowrap="nowrap" align="center" >提交类型</td>
				<td nowrap="nowrap" align="center"  colspan="7">
					保存 <input name="tag" type="radio" class="radio_1" value="1" checked="checked" >
	    保存并提交<input type="radio" name="tag" class="radio_1" value="2" >
				</td>
			</tr> -->

				<tr>
					<td nowrap="nowrap" align="center" ></td>
					<td nowrap="nowrap" align="right" >
						<input name="anniu" id="anniu" type="hidden" class="txt_1" />
							<input  name="addhang"  id="addhang" type="hidden" class="txt_1"   value="0"/>
							<input  name="addhang1"  id="addhang1" type="hidden" class="txt_1"   value="0"/>

						<input id="ok" title="1" type="button" name="ok" accesskey="y" tabindex="y" value="保存" class="but_1 btn" onclick="onAdd(this.title)">
					</td>
					<td nowrap="nowrap" align="left" >
						<input id="ok" title="2" type="button" name="ok" accesskey="y" tabindex="y" value="保存并提交" class="but_1 btn" onclick="onAdd(this.title)">

						<input type="button" name="back" accesskey="b" tabindex="b" value="返回" class="but_1 btn" onclick="location='doProjectInfo.do?method=queryProjectInfoXml'">
					</td>

				</tr>

			</table>

		</form>
	</body>

</html>
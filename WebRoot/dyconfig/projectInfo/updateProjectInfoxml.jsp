<%@ page language="java" contentType="text/html;charset=gb2312"%>
<%@ page import = "com.godoing.rose.http.common.*" %>
<%@ page import = "com.godoing.rose.lang.*" %>
<%@ page import="com.care.common.lang.*"%>
<%@ page import="com.care.common.config.Config"%>
<%@ page import="com.care.app.LoginUser"%>
<%@ taglib uri="/WEB-INF/struts-bean" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic" prefix="logic"%>

<jsp:useBean id = "projectInfo" scope = "request" class = "com.godoing.rose.lang.DataMap"/>
<%@ page autoFlush="true" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="<%=request.getContextPath()%>/css/tbls.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="<%=request.getContextPath()%>/public/public.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/jquery-1.8.2.js"></script>
<title>无标题文档</title>
</head>
<script language="javascript">
function selectProject(obj){
    var a=frmGo.projectName1.value;
    var b=frmGo.projectName.value;
	$.ajax({
		type:"get",
		url:"doProjectInfo.do?method=queryProjectName",
		data:"projectName="+obj,
		success:function(msg){
			 if(msg.trim() != ""&&b!=a){	
				alert("项目名已经存在,请重新输入！");
				 document.all.projectName.value=""; 
			} 
			}
	});

}
function onUpdate(){
/* 	if(frmGo.projectName.value.trim() == ''){
		alert("项目名称不能为空");
		frmGo.ProjectName.focus();
		return false;
	}
	if(frmGo.remark.value.trim().length > 30){
		alert("字数不能超过30字");
		frmGo.remark.focus();
		return false;
	} */
	frmGo.submit();
}

</script>
<body>
<span class="title_1"></span>
<form name="frmGo" method="post" action="doProjectInfo.do?method=updateProjectInfodangan" encType="multipart/form-data" onsubmit="return onUpdate()">
<input name="id" type="hidden" value="<%=projectInfo.getAt("id")%>" >
<input name="role" type="hidden" value="<%=projectInfo.getAt("role")%>" >
<!-- <table width="100%" border="0"cellpadding="0" cellspacing="1"  class="tbl_11"> -->
<table width="100%" class="tbl_11" border="1" bordercolorlight=#000000
			bordercolordark=#000000 bordercolor=#000000 cellspacing="0"
			cellpadding="2">
			
			   <%if("admin".equals(request.getAttribute("role")) || "客服".equals(request.getAttribute("role"))){ %>
			   
			   <tr>
				<th colspan="8" nowrap="nowrap" align="left"><%=request.getAttribute("role")%>修改订单信息</th>
			</tr>

			<tr class="tr_11">
				<td colspan="8" nowrap="nowrap" align="center" width="7%">不一定制和周卢江   客户信息档案表</td>
			</tr>
			
			<tr>
				<td colspan="4" nowrap="nowrap" align="center" width="7%">订单信息</td>
				<td colspan="4" nowrap="nowrap" align="center" width="7%">订单信息</td>
			</tr>
			
			<tr>
				<td nowrap="nowrap" align="center" width="7%">订单编号</td>
				<td nowrap="nowrap" align="center" width="7%">
	<input type="text"   readOnly="true"  size="20"  name="project_no1" id="project_no1" value=<%=projectInfo.getAt("order_id")%>>
</td>
				<td nowrap="nowrap" align="center" width="7%">渠道</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input name="qudao" type="radio" class="radio_1" value="淘宝" <%if("淘宝".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>淘宝
						<input name="qudao" type="radio" class="radio_1" value="工单" <%if("工单".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>工单
						<input name="qudao" type="radio" class="radio_1" value="分销" <%if("分销".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>分销
						<input name="qudao" type="radio" class="radio_1" value="线下" <%if("线下".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>线下
						<input name="qudao" type="radio" class="radio_1" value="打样" <%if("打样".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>打样
						<input name="qudao" type="radio" class="radio_1" value="重做" <%if("重做".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>重做
						<input name="qudao" type="radio" class="radio_1" value="其他" <%if("其他".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>其他
						</td>
				<td nowrap="nowrap" align="center" width="7%">年龄</td>
				<td  nowrap="nowrap" align="center" width="7%">
				<input type="text"      size="20"  name="age" id="age"   value="<%=projectInfo.getAt("age")%>"  >
					</td>
				<td nowrap="nowrap" align="center" width="7%">客户电话</td>	
				<td  nowrap="nowrap" align="center" width="7%">
				<input type="text"    size="20"  name="kehuPhone" id="kehuPhone"   value="<%=projectInfo.getAt("kehu_phone")%>"  >
					</td>
			</tr>
			
				<tr>
				<td nowrap="nowrap" align="center" width="7%">微信号</td>
				<td nowrap="nowrap" align="center" width="7%"><input type="text"   size="20"  name="wechat" id="wechat"  value=<%=projectInfo.getAt("wechat")%>></td>
				<td nowrap="nowrap" align="center" width="7%">下单客服</td>
				<td><input type="text"    readOnly="true"  size="20"  name="project_no" id="project_no"   value="<%=projectInfo.getAt("xiadan_kefu")%>"  ></td>
				<td nowrap="nowrap" align="center" width="7%">性别</td>
				<td  nowrap="nowrap" align="center" width="7%">
					<input name="sex" type="radio" class="radio_1" value="男" <%if("男".equals("" + projectInfo.getAt("sex"))){%>checked<%}%>>男
	    <input name="sex" type="radio" class="radio_1" value="女" <%if("女".equals("" + projectInfo.getAt("sex"))){%>checked<%}%>>女
					</td>
				<td nowrap="nowrap" align="center" width="7%">客户姓名</td>	
				<td  nowrap="nowrap" align="center" width="7%">
				<input type="text"    size="20"  name="kehuName" id="kehuName"   value="<%=projectInfo.getAt("kehu_name")%>"  >
					</td>
			</tr>
			
			<tr>
				<td nowrap="nowrap" align="center" width="7%">订单号</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input type="text"   size="20"  name="orderNumber" id="orderNumber"  value=<%=projectInfo.getAt("order_number")%>>
				</td>
				<td nowrap="nowrap" align="center" width="7%">销售价格</td>
				<td nowrap="nowrap" align="center" width="7%">
	<input type="text"   size="20"  name="salePrice" id="salePrice"  value=<%=projectInfo.getAt("sale_price")%>>
</td>
				<td nowrap="nowrap" align="center" width="7%">身高</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input type="text"      size="20"  name="height" id="height"   value="<%=projectInfo.getAt("height")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">体重</td>
				<td nowrap="nowrap" align="center" width="7%">
<input type="text"      size="20"  name="weight" id="weight"   value="<%=projectInfo.getAt("weight")%>"  >
</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">旺旺名</td>
				<td nowrap="nowrap" align="center" width="7%">
<input type="text"   size="20"  name="projectNo" id="projectNo"  value=<%=projectInfo.getAt("ww_name")%>>
</td>
				<td nowrap="nowrap" align="center" width="7%">下单时间</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input type="text"    readOnly="true" size="20"  name="project_no" id="project_no"   value="<%=projectInfo.getAt("add_time")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">客户地址</td>
				<td nowrap="nowrap" align="center" width="7%" colspan="3">
				<input type="text"      size="50"  name="address" id="address"   value="<%=projectInfo.getAt("address")%>"  >
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">订单类型</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input name="orderType" type="radio" class="radio_1" value="新单" <%if("新单".equals("" + projectInfo.getAt("order_type"))){%>checked<%}%>>新单
	    <input name="orderType" type="radio" class="radio_1" value="打样" <%if("打样".equals("" + projectInfo.getAt("order_type"))){%>checked<%}%>>打样
	    <input name="orderType" type="radio" class="radio_1" value="重做" <%if("重做".equals("" + projectInfo.getAt("order_type"))){%>checked<%}%>>重做
				</td>
				<td nowrap="nowrap" align="center" width="7%">交付时间</td>
				<td nowrap="nowrap" align="center" width="7%">
				<!-- <select name="jiaofu_time" value="jiaofu_time">
						<option value="10">+10天  加急</option>
						<option value="5">+5天  特别加急</option>
						<option value="3">+3天   非常紧急</option>
				</select> <font color="red"></font> -->
				</td>
				
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">西装数量</td>
				<td nowrap="nowrap" align="left" width="7%">
				<input name="xizhuang_number" size="38" id="xizhuang_number" type="number"
					class="txt_1" maxlength="100" /><font color="red"></font>
			</td>
				<td nowrap="nowrap" align="center" width="7%">衣码</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%">衬衫数量</td>
				<td nowrap="nowrap" align="left" width="7%">
				<input name="chenshan_number" size="38" id="chenshan_number" type="number"
					class="txt_1" maxlength="100" /><font color="red"></font>
				</td>
				<td nowrap="nowrap" align="center" width="7%">衬衫码</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">肩宽</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input type="text"      size="20"  name="jiankuanA" id="jiankuanA"   value="<%=projectInfo.getAt("jiankuan_a")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%">领围</td>
				<td nowrap="nowrap" align="center" width="7%">
			<input type="text"      size="20"  name="lingweiB" id="lingweiB"   value="<%=projectInfo.getAt("lingwei_b")%>"  >
		</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">胸围</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input type="text"      size="20"  name="xiongweiA" id="xiongweiA"   value="<%=projectInfo.getAt("xiongwei_a")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%">胸围</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input type="text"      size="20"  name="xiongweiB" id="xiongweiB"   value="<%=projectInfo.getAt("xiongwei_b")%>"  >
			</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">中腰</td>
				<td nowrap="nowrap" align="center" width="7%">
			<input type="text"      size="20"  name="zhongyaoA" id="zhongyaoA"   value="<%=projectInfo.getAt("zhongyao_a")%>"  >
		</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%">中腰</td>
				<td nowrap="nowrap" align="center" width="7%">
		<input type="text"      size="20"  name="zhongyaoA" id="zhongyaoA"   value="<%=projectInfo.getAt("zhongyao_a")%>"  >
	</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">腹围</td>
				<td nowrap="nowrap" align="center" width="7%">
			<input type="text"      size="20"  name="fuweiA" id="fuweiA"   value="<%=projectInfo.getAt("fuwei_a")%>"  >
		</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%">腹围</td>
				<td nowrap="nowrap" align="center" width="7%">
<input type="text"      size="20"  name="fuweiB" id="fuweiB"   value="<%=projectInfo.getAt("fuwei_b")%>"  >
</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">后中衣长</td>
				<td nowrap="nowrap" align="center" width="7%">
<input type="text"      size="20"  name="houzhongyichangA" id="houzhongyichangA"   value="<%=projectInfo.getAt("houzhongyichang_a")%>"  >
</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%">衣长</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
				<tr>
				<td nowrap="nowrap" align="center" width="7%">前衣长</td>
				<td nowrap="nowrap" align="center" width="7%">
		<input type="text"      size="20"  name="qianyichangA" id="qianyichangA"   value="<%=projectInfo.getAt("qianyichang_a")%>"  >
	</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%">腹围</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">袖长</td>
				<td nowrap="nowrap" align="center" width="7%">
	<input type="text"      size="20"  name="xiuchangB" id="xiuchangB"   value="<%=projectInfo.getAt("xiuchang_b")%>"  >
</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%">袖长</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input type="text"      size="20"  name="xiuchangA" id="xiuchangA"   value="<%=projectInfo.getAt("xiuchang_a")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">袖肥</td>
				<td nowrap="nowrap" align="center" width="7%">
	<input type="text"      size="20"  name="xiufeiB" id="xiufeiB"   value="<%=projectInfo.getAt("xiufei_b")%>"  >
</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%">袖肥</td>
				<td nowrap="nowrap" align="center" width="7%">
	<input type="text"      size="20"  name="xiufeiA" id="xiufeiA"   value="<%=projectInfo.getAt("xiufei_a")%>"  >
</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">袖口</td>
				<td nowrap="nowrap" align="center" width="7%">
<input type="text"      size="20"  name="xiukouB" id="xiukouB"   value="<%=projectInfo.getAt("xiukou_b")%>"  >
</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%">袖口</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input type="text"      size="20"  name="xiukouA" id="xiukouA"   value="<%=projectInfo.getAt("xiukou_a")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">西裤数量</td>
				<td nowrap="nowrap" align="left" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%">裤码</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%">马甲数量</td>
				<td nowrap="nowrap" align="left" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%">马甲码</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">腰围</td>
				<td nowrap="nowrap" align="center" width="7%">	<input type="text"      size="20"  name="yaoweiC" id="yaoweiC"   value="<%=projectInfo.getAt("yaowei_c")%>"  ></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%">肩宽</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">臀围</td>
				<td nowrap="nowrap" align="center" width="7%">	<input type="text"      size="20"  name="tuiweiC" id="tuiweiC"   value="<%=projectInfo.getAt("tuiwei_c")%>"  ></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%">胸围</td>
				<td nowrap="nowrap" align="center" width="7%">
<input type="text"      size="20"  name="xiongweiD" id="xiongweiD"   value="<%=projectInfo.getAt("xiongwei_d")%>"  >
</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">档围</td>
				<td nowrap="nowrap" align="center" width="7%">
	<input type="text"      size="20"  name="dangweiC" id="dangweiC"   value="<%=projectInfo.getAt("dangwei_c")%>"  >
</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%">中腰</td>
				<td nowrap="nowrap" align="center" width="7%">	<input type="text"      size="20"  name="zhongyaoD" id="zhongyaoD"   value="<%=projectInfo.getAt("zhongyao_d")%>"  ></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">大腿</td>
				<td nowrap="nowrap" align="center" width="7%">	<input type="text"      size="20"  name="datuiC" id="datuiC"   value="<%=projectInfo.getAt("datui_c")%>"  ></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%">衣长</td>
				<td nowrap="nowrap" align="center" width="7%">	<input type="text"      size="20"  name="yichangD" id="yichangD"   value="<%=projectInfo.getAt("yichang_d")%>"  ></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			
			<tr>
				<td nowrap="nowrap" align="center" width="7%">中腿</td>
				<td nowrap="nowrap" align="center" width="7%">	<input type="text"      size="20"  name="zhongtuiC" id="zhongtuiC"   value="<%=projectInfo.getAt("zhongtui_c")%>"  ></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%">款型</td>
				<td nowrap="nowrap" align="center" width="7%">
	<input name="kuanxingD" type="radio" class="radio_1" value="修身" <%if("修身".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>修身
		<input name="kuanxingD" type="radio" class="radio_1" value="修身+" <%if("修身+".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>修身+
		<input name="kuanxingD" type="radio" class="radio_1" value="合身" <%if("合身".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>合身
		<input name="kuanxingD" type="radio" class="radio_1" value="合身+" <%if("合身+".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>合身+
		<input name="kuanxingD" type="radio" class="radio_1" value="宽松" <%if("宽松".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>宽松
		<input name="kuanxingD" type="radio" class="radio_1" value="宽松+" <%if("宽松+".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>宽松+
</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">小腿</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input type="text"      size="20"  name="xiaotuiC" id="xiaotuiC"   value="<%=projectInfo.getAt("xiaotui_c")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">裤长</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input type="text"      size="20"  name="kuchangC" id="kuchangC"   value="<%=projectInfo.getAt("kuchang_c")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">脚口</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input type="text"      size="20"  name="tuikouC" id="tuikouC"   value="<%=projectInfo.getAt("tuikou_c")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">扣型</td>
				<td nowrap="nowrap" align="center" width="7%">
					<select name="kouxingC" value="kouxingC">
						<option value="一粒扣">一粒扣</option>
						<option value="二粒扣">二粒扣</option>
						<option value="三粒扣">三粒扣</option>
						<option value="双排二扣一">双排二扣一</option>
						<option value="双排四扣二">双排四扣二</option>
						<option value="双排六扣二">双排六扣二</option>
				</select> <font color="red"></font>
					</td>
				<td nowrap="nowrap" align="center" width="7%">口袋</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="koudaiC" value="koudaiC">
						<option value="1平袋盖、4斜袋盖">1平袋盖、4斜袋盖</option>
						<option value="2平单线、5斜单线">2平单线、5斜单线</option>
						<option value="3平双线、6斜双线">3平双线、6斜双线</option>
						<option value="7外贴袋">7外贴袋</option>
				</select> <font color="red"></font></td>
				<td nowrap="nowrap" align="center" width="7%">开叉</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="kaicha" value="kaicha">
						<option value="单叉">单叉</option>
						<option value="双叉">双叉</option>
						<option value="不开叉">不开叉</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">领型</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="lingkoukuaishiB" size="38"
					id="lingkoukuaishiB" type="text" class="txt_1" maxlength="100" /><font
					color="red"></font>
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">下摆</td>
				<td nowrap="nowrap" align="center" width="7%">
					<select name="xiabai" value="xiabai">
						<option value="圆角下摆">圆角下摆</option>
						<option value="直角下摆（双排扣默认）">直角下摆（双排扣默认）</option>
						<option value="大圆角下摆">大圆角下摆</option>
						<option value="燕尾下摆">燕尾下摆</option>
						<option value="其他">其他</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">撞色</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="zhuangse" value="zhuangse">
						<option value="袋条用色丁">袋条用色丁</option>
						<option value="领边有色丁">领边有色丁</option>
						<option value="驳头用色丁">驳头用色丁</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">外珠边</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="waizhubian" size="38"
					id="waizhubian" type="text" class="txt_1" maxlength="100"  value="<%=projectInfo.getAt("waizhubian")%>" /><font
					color="red"></font>
				</td>
				<td nowrap="nowrap" align="center" width="7%">袖叉</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="xiucha" value="xiucha">
						<option value="真袖叉">真袖叉</option>
						<option value="假袖叉">假袖叉</option>
						<option value="翻袖">翻袖</option>
						<option value="其它">其它</option>
				</select>
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">裤腰</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="kuyao" value="kuyao">
						<option value="伸出订扣">伸出订扣</option>
						<option value="伸出订钩">伸出订钩</option>
						<option value="不伸头">不伸头</option>
						<option value="松紧">松紧</option>
						<option value="调节扣">调节扣</option>
						<option value="那不勒斯">那不勒斯</option>
						<option value="其它">其它</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">裤型</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="kuxing" value="kuxing">
						<option value="修身裤">修身裤</option>
						<option value="翻边">翻边</option>
						<option value="单褶">单褶</option>
						<option value="双褶">双褶</option>
						<option value="萝卜裤">萝卜裤</option>
						<option value="直筒裤">直筒裤</option>
						<option value="其它">其它</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">衬衫领</td>
				<td nowrap="nowrap" align="center" width="7%">
				<select name="chenshanling" value="chenshanling">
						<option value="小方领">小方领</option>
						<option value="小尖领">小尖领</option>
						<option value="v尖领">v尖领</option>
						<option value="正方领">正方领</option>
						<option value="大领">大领</option>
						<option value="其它">其它</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">衬衫袖</td>
				<td nowrap="nowrap" align="center" width="7%">
					<select name="chenshanxiu" value="chenshanxiu">
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
				<td nowrap="nowrap" align="center" width="7%">面料</td>
				<td nowrap="nowrap" align="center" width="7%">
			<input type="text"      size="20"  name="miaoliao1" id="miaoliao1"   value="<%=projectInfo.getAt("miao_liao1")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">用途</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input type="text"   size="20"  name="yongtu1" id="yongtu1"   value="<%=projectInfo.getAt("yong_tu1")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">米数</td>
				<td nowrap="nowrap" align="center" width="7%">
					
				</td>
				<td nowrap="nowrap" align="center" width="7%">供应商</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">面料</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input type="text"   size="20"  name="miaoliao2" id="miaoliao2"   value="<%=projectInfo.getAt("miao_liao2")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">用途</td>
				<td nowrap="nowrap" align="center" width="7%">
					<input type="text"   size="20"  name="yongtu2" id="yongtu2"   value="<%=projectInfo.getAt("yong_tu2")%>"  >
				</td>
				<td nowrap="nowrap" align="center" width="7%">米数</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
				<td nowrap="nowrap" align="center" width="7%">供应商</td>
				<td nowrap="nowrap" align="center" width="7%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">附件</td>
				<td nowrap="nowrap" align="center" width="7%"><input type="file" name="channelId"
					id="channelId" multiple="multiple" class="imagePath" /> <img alt=""
					src="" id="image1" class="showImage"></td>
			</tr>
			
			<tr>
				<td nowrap="nowrap" align="center" width="7%">客服备注</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="7">
	<input type="text"   size="160"  name="remark" id="remark"   value="<%=projectInfo.getAt("remark")%>"  >
</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">批单备注</td>
				<td nowrap="nowrap" align="center" width="7%" colspan="7">
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">跟单备注</td>
				<td nowrap="nowrap" align="center" width="7%" colspan="7"></td>
			</tr>
				<tr>
				<td nowrap="nowrap" align="center" width="7%">提交类型</td>
				<td nowrap="nowrap" align="center" width="7%" colspan="7">
					保存 <input name="tag" type="radio" class="radio_1" value="1" checked="checked" >
	    保存并提交<input type="radio" name="tag" class="radio_1" value="2" >
				</td>
			</tr>
			
			
			   
			  
			
  

			<tr>
				<!-- <td align="left">附件</td>
				<td colspan="2"><input type="file" name="channelId"
					id="channelId" multiple="multiple" class="imagePath" /> <img alt=""
					src="" id="image1" class="showImage"></td> -->
					
						<td align="left" colspan="2">
						&nbsp;&nbsp;&nbsp;<input type="button" name="ok" accesskey="y" tabindex="y"  value="确 定" class="but_1" onclick="onUpdate()">
	
      <input type="button" name="back" accesskey="b" tabindex="b" value="返 回" class="but_1" onclick="location='doProjectInfo.do?method=queryProjectInfoXml'">
      <input type="reset" name="back" accesskey="b" tabindex="b" value="重置" class="but_1" >
				</td>
			</tr>
			
              
				 <%} %>	
			
		

</table>
</form>
</body>
</html>
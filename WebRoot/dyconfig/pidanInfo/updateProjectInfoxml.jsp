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
<!-- <table width="100%" border="0"cellpadding="0" cellspacing="1"  class="tbl_11"> -->
<table width="100%" class="tbl_11" border="1" bordercolorlight=#000000
			bordercolordark=#000000 bordercolor=#000000 cellspacing="0"
			cellpadding="2">
			
			
			<tr>
				<th colspan="8" nowrap="nowrap" align="left">修改订单信息</th>
			</tr>
			
<!--   <tr>
     <th colspan="3" nowrap="nowrap" align="left">
                           修改订单信息
     </th>
   </tr> -->
   
   <tr class="tr_11">
				<td colspan="8" nowrap="nowrap" align="center" width="7%">不一定制客户档案</td>
			</tr>

			<tr>
				<td align="left">订单编号</td>
				<td colspan="2" align="left"> 
		<input type="text"    readOnly="true"  readOnly="true"  size="20"  name="project_no1" id="project_no1" value=<%=projectInfo.getAt("order_id")%>>
				</td>
				<td align="left">旺旺名</td>
				<td colspan="2" align="left">
				<input type="text"    readOnly="true"  readOnly="true"  size="20"  name="projectNo" id="projectNo"  value=<%=projectInfo.getAt("ww_name")%>>
			</td>
				<td align="left">销售价格</td>
				<td align="left">
				<input type="text"    readOnly="true"  readOnly="true"  size="20"  name="salePrice" id="salePrice"  value=<%=projectInfo.getAt("sale_price")%>>
				</td>
			</tr>

			<tr>
				<td>微信名</td>
				<td colspan="2"><input type="text"    readOnly="true"  readOnly="true" size="20"  name="wechat" id="wechat"  value=<%=projectInfo.getAt("wechat")%>></td>
				<td>订单号</td>
				<td colspan="2">
                   <input type="text"    readOnly="true"  size="20"  readOnly="true"  name="orderNumber" id="orderNumber"  value=<%=projectInfo.getAt("order_number")%>>
</td>
				<td>下单时间</td>
				<td>
				<input type="text"    readOnly="true"   readOnly="true" size="20"  name="project_no" id="project_no"   value="<%=projectInfo.getAt("add_time")%>"  >
				</td>
			</tr>


			<tr>
				<td>客户电话</td>
				<td colspan="2">
<input type="text"    readOnly="true"   size="20"  name="kehuPhone" id="kehuPhone"  readOnly="true"   value="<%=projectInfo.getAt("kehu_phone")%>"  >
</td>
				<td>订单类型</td>
				<td colspan="2">
	    
	    <input type="text"    readOnly="true"   size="20"  name="orderType" id="orderType"  readOnly="true"   value="<%=projectInfo.getAt("order_type")%>"  >
				</td>
				<td>交付时间</td>
				<td></td>
			</tr>


			<tr>
				<td>客户姓名</td>
				<td>
	<input type="text"    readOnly="true"   readOnly="true"  size="20"  name="kehuName" id="kehuName"   value="<%=projectInfo.getAt("kehu_name")%>"  >
</td>
				<td>渠道</td>
				<td>
					<%-- <input type="text"    readOnly="true"   size="20"  name="qudao" id="qudao"   value="<%=projectInfo.getAt("qudao")%>"  > --%>
				<%-- 		<input name="qudao" type="radio" class="radio_1" value="淘宝" <%if("淘宝".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>淘宝
						<input name="qudao" type="radio" class="radio_1" value="工单" <%if("工单".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>工单
						<input name="qudao" type="radio" class="radio_1" value="分销" <%if("分销".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>分销
						<input name="qudao" type="radio" class="radio_1" value="线下" <%if("线下".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>线下
						<input name="qudao" type="radio" class="radio_1" value="打样" <%if("打样".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>打样
						<input name="qudao" type="radio" class="radio_1" value="重做" <%if("重做".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>重做
						<input name="qudao" type="radio" class="radio_1" value="其他" <%if("其他".equals("" + projectInfo.getAt("qudao"))){%>checked<%}%>>其他 --%>
						   <input type="text"    readOnly="true"   size="20"  name="qudao" id="qudao"  readOnly="true"   value="<%=projectInfo.getAt("qudao")%>"  >
					<!-- <option value="淘宝">淘宝</option>
						<option value="工单">工单</option>
						<option value="分销">分销</option>
						<option value="线下">线下</option>
						<option value="打样">打样</option>
						<option value="重做">重做</option>
						<option value="其他">其他</option> -->
						
				</td>
				<td>下单客服</td>
				<td>
				<input type="text"    readOnly="true"   readOnly="true"  size="20"  name="project_no" id="project_no"   value="<%=projectInfo.getAt("xiadan_kefu")%>"  >
				</td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>客户地址</td>
				<td colspan="7">
<input type="text"    readOnly="true"     size="50"   readOnly="true" name="address" id="address"   value="<%=projectInfo.getAt("address")%>"  >
				</td>
			</tr>

			<tr>
				<td>身高</td>
				<td>
				<input type="text"    readOnly="true"  readOnly="true"    size="20"  name="height" id="height"   value="<%=projectInfo.getAt("height")%>"  >
				</td>
				<td>体重</td>
				<td>
					<input type="text"    readOnly="true"   readOnly="true"   size="20"  name="weight" id="weight"   value="<%=projectInfo.getAt("weight")%>"  >
					</td>
				<td>年龄</td>
				<td>
						<input type="text"    readOnly="true"    readOnly="true"  size="20"  name="age" id="age"   value="<%=projectInfo.getAt("age")%>"  >
					</td>
				<td>性别</td>
				<td>
<%-- 	<input name="sex" type="radio" class="radio_1" value="男" <%if("男".equals("" + projectInfo.getAt("sex"))){%>checked<%}%>>男
	    <input name="sex" type="radio" class="radio_1" value="女" <%if("女".equals("" + projectInfo.getAt("sex"))){%>checked<%}%>>女 --%>
	    
	      <input type="text"    readOnly="true"   size="20"  name="sex" id="sex"   value="<%=projectInfo.getAt("sex")%>"  >
</td>
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
				<td>
						<input type="text"    readOnly="true"   readOnly="true"   size="20"  name="jiankuanA" id="jiankuanA"   value="<%=projectInfo.getAt("jiankuan_a")%>"  >
				</td>
				<td></td>
				<td>领围</td>
				<td>
						<input type="text"    readOnly="true"   readOnly="true"   size="20"  name="lingweiB" id="lingweiB"   value="<%=projectInfo.getAt("lingwei_b")%>"  >
					</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>胸围</td>
				<td>
							<input type="text"    readOnly="true"   readOnly="true"   size="20"  name="xiongweiA" id="xiongweiA"   value="<%=projectInfo.getAt("xiongwei_a")%>"  >
				</td>
				<td></td>
				<td>胸围</td>
				<td>
						<input type="text"    readOnly="true"    readOnly="true"  size="20"  name="xiongweiB" id="xiongweiB"   value="<%=projectInfo.getAt("xiongwei_b")%>"  >
				</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>中腰</td>
				<td>
						<input type="text"    readOnly="true"    readOnly="true"  size="20"  name="zhongyaoA" id="zhongyaoA"   value="<%=projectInfo.getAt("zhongyao_a")%>"  >
				</td>
				<td></td>
				<td>中腰</td>
				<td>
						<input type="text"    readOnly="true"   readOnly="true"   size="20"  name="zhongyaoA" id="zhongyaoA"   value="<%=projectInfo.getAt("zhongyao_a")%>"  >
				</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>腹围</td>
				<td>
					<input type="text"    readOnly="true"    readOnly="true"  size="20"  name="fuweiA" id="fuweiA"   value="<%=projectInfo.getAt("fuwei_a")%>"  >
					</td>
				<td></td>
				<td>腹围</td>
				<td>
						<input type="text"    readOnly="true"   readOnly="true"   size="20"  name="fuweiB" id="fuweiB"   value="<%=projectInfo.getAt("fuwei_b")%>"  >
					</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>后中衣长</td>
				<td>
					<input type="text"    readOnly="true"   readOnly="true"   size="20"  name="houzhongyichangA" id="houzhongyichangA"   value="<%=projectInfo.getAt("houzhongyichang_a")%>"  >
					</td>
				<td></td>
				<td>袖长</td>
				<td>
						<input type="text"    readOnly="true"   readOnly="true"   size="20"  name="xiuchangB" id="xiuchangB"   value="<%=projectInfo.getAt("xiuchang_b")%>"  >
				</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>前衣长</td>
				<td>
						<input type="text"    readOnly="true"  readOnly="true"    size="20"  name="qianyichangA" id="qianyichangA"   value="<%=projectInfo.getAt("qianyichang_a")%>"  >
				</td>
				<td></td>
				<td>袖肥</td>
				<td>
						<input type="text"    readOnly="true"   readOnly="true"   size="20"  name="xiufeiB" id="xiufeiB"   value="<%=projectInfo.getAt("xiufei_b")%>"  >
					</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>袖长</td>
				<td>
						<input type="text"    readOnly="true"   readOnly="true"   size="20"  name="xiuchangA" id="xiuchangA"   value="<%=projectInfo.getAt("xiuchang_a")%>"  >
				</td>
				<td></td>
				<td>袖口</td>
				<td>
						<input type="text"    readOnly="true"   readOnly="true"   size="20"  name="xiukouB" id="xiukouB"   value="<%=projectInfo.getAt("xiukou_b")%>"  >
					</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>袖肥</td>
				<td>
					<input type="text"    readOnly="true"    readOnly="true"  size="20"  name="xiufeiA" id="xiufeiA"   value="<%=projectInfo.getAt("xiufei_a")%>"  >
					</td>
				<td></td>
				<td>领口款式</td>
				<td>
						<input type="text"    readOnly="true"   readOnly="true"   size="20"  name="lingkoukuaishiB" id="lingkoukuaishiB"   value="<%=projectInfo.getAt("lingkoukuaishi_b")%>"  >
					</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>


			<tr>
				<td>袖口</td>
				<td>
						<input type="text"    readOnly="true"     size="20"  name="xiukouA" id="xiukouA"   value="<%=projectInfo.getAt("xiukou_a")%>"  >
					</td>
				<td></td>
				<td>衣长</td>
				<td>
						<input type="text"    readOnly="true"     size="20"  name="yichangB" id="yichangB"   value="<%=projectInfo.getAt("yichang_b")%>"  >
					</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td colspan="2">西裤数量</td>
				<td>裤码</td>
				<td colspan="2">马甲数量</td>
				<td>马甲码</td>
				<td></td>
				<td></td>
			</tr>


			<tr>
				<td>裤长</td>
				<td>
					<input type="text"    readOnly="true"     size="20"  name="kuchangC" id="kuchangC"   value="<%=projectInfo.getAt("kuchang_c")%>"  >
					</td>
				<td></td>
				<td>胸围</td>
				<td>
						<input type="text"    readOnly="true"     size="20"  name="xiongweiD" id="xiongweiD"   value="<%=projectInfo.getAt("xiongwei_d")%>"  >
				</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>


			<tr>
				<td>腰围</td>
				<td>
						<input type="text"    readOnly="true"     size="20"  name="yaoweiC" id="yaoweiC"   value="<%=projectInfo.getAt("yaowei_c")%>"  >
					</td>
				<td></td>
				<td>中腰</td>
				<td>
						<input type="text"    readOnly="true"     size="20"  name="zhongyaoD" id="zhongyaoD"   value="<%=projectInfo.getAt("zhongyao_d")%>"  >
				</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>臀围</td>
				<td>
						<input type="text"    readOnly="true"     size="20"  name="tuiweiC" id="tuiweiC"   value="<%=projectInfo.getAt("tuiwei_c")%>"  >
					</td>
				<td></td>
				<td>衣长</td>
				<td>
						<input type="text"    readOnly="true"     size="20"  name="yichangD" id="yichangD"   value="<%=projectInfo.getAt("yichang_d")%>"  >
					</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>


			<tr>
				<td>档围</td>
				<td>
						<input type="text"    readOnly="true"     size="20"  name="dangweiC" id="dangweiC"   value="<%=projectInfo.getAt("dangwei_c")%>"  >
					</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>大腿</td>
				<td>
						<input type="text"    readOnly="true"     size="20"  name="datuiC" id="datuiC"   value="<%=projectInfo.getAt("datui_c")%>"  >
					</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>


			<tr>
				<td>中腿</td>
				<td>
						<input type="text"    readOnly="true"     size="20"  name="zhongtuiC" id="zhongtuiC"   value="<%=projectInfo.getAt("zhongtui_c")%>"  >
				</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>


			<tr>
				<td>小腿</td>
				<td>
						<input type="text"    readOnly="true"     size="20"  name="xiaotuiC" id="xiaotuiC"   value="<%=projectInfo.getAt("xiaotui_c")%>"  >
					</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>脚口</td>
				<td>
						<input type="text"    readOnly="true"     size="20"  name="tuikouC" id="tuikouC"   value="<%=projectInfo.getAt("tuikou_c")%>"  >
					</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>扣型</td>
				<td>
						<input type="text"    readOnly="true"     size="20"  name="kouxingC" id="kouxingC"   value="<%=projectInfo.getAt("kouxing_c")%>"  >
					</td>
				<td>扣色</td>
				<td>
					<input type="text"    readOnly="true"     size="20"  name="kouseC" id="kouseC"   value="<%=projectInfo.getAt("kouse_c")%>"  >
					</td>
				<td>款型</td>
				<td>
<%-- 		<input name="kuanxingD" type="radio" class="radio_1" value="修身" <%if("修身".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>修身
		<input name="kuanxingD" type="radio" class="radio_1" value="修身+" <%if("修身+".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>修身+
		<input name="kuanxingD" type="radio" class="radio_1" value="合身" <%if("合身".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>合身
		<input name="kuanxingD" type="radio" class="radio_1" value="合身+" <%if("合身+".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>合身+
		<input name="kuanxingD" type="radio" class="radio_1" value="宽松" <%if("宽松".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>宽松
		<input name="kuanxingD" type="radio" class="radio_1" value="宽松+" <%if("宽松+".equals("" + projectInfo.getAt("kuanxing_d"))){%>checked<%}%>>宽松+ --%>
		
		  <input type="text"    readOnly="true"   size="20"  name="kuanxingD" id="kuanxingD"   value="<%=projectInfo.getAt("kuanxing_d")%>"  >
				</td>
				<td>驳头</td>
				<td>
			<%-- 		<input name="botouD" type="radio" class="radio_1" value="西装领" <%if("西装领".equals("" + projectInfo.getAt("botou_d"))){%>checked<%}%>>西装领
					<input name="botouD" type="radio" class="radio_1" value="平驳领" <%if("平驳领".equals("" + projectInfo.getAt("botou_d"))){%>checked<%}%>>平驳领
					<input name="botouD" type="radio" class="radio_1" value="戗驳领" <%if("戗驳领".equals("" + projectInfo.getAt("botou_d"))){%>checked<%}%>>戗驳领
					<input name="botouD" type="radio" class="radio_1" value="青果领" <%if("青果领".equals("" + projectInfo.getAt("botou_d"))){%>checked<%}%>>青果领
					<input name="botouD" type="radio" class="radio_1" value="立领" <%if("立领".equals("" + projectInfo.getAt("botou_d"))){%>checked<%}%>>立领
					<input name="botouD" type="radio" class="radio_1" value="中华立领" <%if("中华立领".equals("" + projectInfo.getAt("botou_d"))){%>checked<%}%>>中华立领
					<input name="botouD" type="radio" class="radio_1" value="其它" <%if("其它".equals("" + projectInfo.getAt("botou_d"))){%>checked<%}%>>其它 --%>
					
					  <input type="text"    readOnly="true"   size="20"  name="botouD" id="botouD"   value="<%=projectInfo.getAt("botou_d")%>"  >
				</td>
			</tr>

			<tr>
				<td>口袋</td>
				<td>
		<%-- 			<input name="koudaiC" type="radio" class="radio_1" value="双线" <%if("双线".equals("" + projectInfo.getAt("koudai_c"))){%>checked<%}%>>双线
					<input name="koudaiC" type="radio" class="radio_1" value="单线" <%if("单线".equals("" + projectInfo.getAt("koudai_c"))){%>checked<%}%>>单线
					<input name="koudaiC" type="radio" class="radio_1" value="票据" <%if("票据".equals("" + projectInfo.getAt("koudai_c"))){%>checked<%}%>>票据
					<input name="koudaiC" type="radio" class="radio_1" value="其它" <%if("其它".equals("" + projectInfo.getAt("koudai_c"))){%>checked<%}%>>其它 --%>
					
					  <input type="text"    readOnly="true"   size="20"  name="koudaiC" id="koudaiC"   value="<%=projectInfo.getAt("koudai_c")%>"  >
				</td>
				<td>袋盖</td>
				<td>
				   <%--  <input name="daigai" type="radio" class="radio_1" value="有" <%if("有".equals("" + projectInfo.getAt("dai_gai"))){%>checked<%}%>>有
					<input name="daigai" type="radio" class="radio_1" value="无" <%if("无".equals("" + projectInfo.getAt("dai_gai"))){%>checked<%}%>>无
					<input name="daigai" type="radio" class="radio_1" value="其它" <%if("其它".equals("" + projectInfo.getAt("dai_gai"))){%>checked<%}%>>其它 --%>
					
					  <input type="text"    readOnly="true"   size="20"  name="daigai" id="daigai"   value="<%=projectInfo.getAt("dai_gai")%>"  >
				</td>
				<td>平斜袋</td>
				<td>
			<%-- 	 <input name="pingxiedai" type="radio" class="radio_1" value="平袋" <%if("平袋".equals("" + projectInfo.getAt("pingxie_dai"))){%>checked<%}%>>平袋
				 <input name="pingxiedai" type="radio" class="radio_1" value="斜袋" <%if("斜袋".equals("" + projectInfo.getAt("pingxie_dai"))){%>checked<%}%>>斜袋
				 <input name="pingxiedai" type="radio" class="radio_1" value="其它" <%if("其它".equals("" + projectInfo.getAt("pingxie_dai"))){%>checked<%}%>>其它 --%>
				 
				  <input type="text"    readOnly="true"   size="20"  name="pingxiedai" id="pingxiedai"   value="<%=projectInfo.getAt("pingxie_dai")%>"  >
				</td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>面料1</td>
				<td>
				<input type="text"    readOnly="true"     size="20"  name="miaoliao1" id="miaoliao1"   value="<%=projectInfo.getAt("miao_liao1")%>"  >
				</td>
				<td>米数</td>
				<td></td>
				<td>用途</td>
				<td>
					<input type="text"    readOnly="true"  size="20"  name="yongtu1" id="yongtu1"   value="<%=projectInfo.getAt("yong_tu1")%>"  >
					</td>
				<td>供应商</td>
				<td></td>
			</tr>

			<tr>
				<td>面料2</td>
				<td>
						<input type="text"    readOnly="true"  size="20"  name="miaoliao2" id="miaoliao2"   value="<%=projectInfo.getAt("miao_liao2")%>"  >
				</td>
				<td>米数</td>
				<td></td>
				<td>用途</td>
				<td>
						<input type="text"    readOnly="true"  size="20"  name="yongtu2" id="yongtu2"   value="<%=projectInfo.getAt("yong_tu2")%>"  >
					</td>
				<td>供应商</td>
				<td></td>
			</tr>

			<tr>
				<td>体型备注</td>
				<td colspan="3">
					<input type="text"    readOnly="true"  size="20"  name="tixingremark" id="tixingremark"   value="<%=projectInfo.getAt("tixing_remark")%>"  >
					</td>
				<td>备注</td>
				<td colspan="3">
					<input type="text"    readOnly="true"  size="20"  name="remark" id="remark"   value="<%=projectInfo.getAt("remark")%>"  >
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
</table>
</form>
</body>
</html>
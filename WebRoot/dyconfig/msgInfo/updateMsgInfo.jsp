<%@ page language="java" contentType="text/html;charset=gb2312"%>
<%@ page import="com.godoing.rose.http.common.*"%>
<%@ page import="com.godoing.rose.lang.*"%>
<%@ page import="com.care.common.lang.*"%>
<%@ page import="com.care.common.config.Config"%>
<%@ page import="com.care.app.LoginUser"%>
<%@ taglib uri="/WEB-INF/struts-bean" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic" prefix="logic"%>

<jsp:useBean id="msgInfo" scope="request"
	class="com.godoing.rose.lang.DataMap" />
<%@ page autoFlush="true"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="<%=request.getContextPath()%>/css/tbls.css" rel="stylesheet"
	type="text/css">
<script language="JavaScript"
	src="<%=request.getContextPath()%>/public/public.js"></script>
<script language="JavaScript"
	src="<%=request.getContextPath()%>/js/jquery-1.8.2.js"></script>
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
function onAdd(wechat){
	
	 document.getElementById("anniu").setAttribute("value", wechat);
	 
	
	frmGo.submit();
}

</script>
<body>
	<span class="title_1"></span>
	<form name="frmGo" method="post"
		action="doMsgInfo.do?method=updateMsgInfo"
		encType="multipart/form-data" onsubmit="return onAdd()">
		<input name="id" type="hidden" value="<%=msgInfo.getAt("id")%>">
		<input name="role" id="role" type="hidden"
			value="<%=request.getAttribute("role")%>">
		<table width="100%" id="tb1" class="tbl_11" border="1"
			bordercolorlight=#000000 bordercolordark=#000000 bordercolor=#000000
			cellspacing="0" cellpadding="2">
			<tr>
				<th colspan="8" nowrap="nowrap" align="left">售后信息修改</th>
			</tr>

			<tr>
				<td colspan="8" nowrap="nowrap" align="center" width="7%">不一定制售后工单</td>
			</tr>
			
			<tr>
				<td nowrap="nowrap" align="center" width="7%" colspan="1">下单号</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="2">
				<input 
					name="orderNumber" size="38" id="orderNumber" type="text"  value="<%=msgInfo.getAt("order_id")%>"
					 maxlength="30"  >
					</td>
					<td nowrap="nowrap" align="center" width="7%" colspan="1">售后下单日期</td>
				<td nowrap="nowrap" align="center" width="7%" colspan="1">
				<input
					name="msg_handler_date" id="msg_handler_date"
					value="<%=msgInfo.getAt("msg_handler_date")%>" />
					</td>
					<td nowrap="nowrap" align="center" width="7%" colspan="1">交付日期</td>
				<td nowrap="nowrap" align="center" width="7%" colspan="1">
			<input
					name="jiaofutime" id="jiaofutime" type="text" size="38"
					maxlength="100" value="<%=msgInfo.getAt("jiaofutime")%>" />
					</td>
			
			
			</tr>
			
			
			<tr>
				<td nowrap="nowrap" align="center" width="7%" colspan="1">姓名</td>
				<td nowrap="nowrap" align="cneter" width="7%" colspan="1">
				<input
					name="name" id="name" type="text" class="txt_1" maxlength="20"
					size="38" value="<%=msgInfo.getAt("name")%>" />
					</td>
					<td nowrap="nowrap" align="center" width="7%" colspan="1">电话</td>
				<td nowrap="nowrap" align="center" width="7%" colspan="1">
				<input
					name="phone" id="phone" type="text" class="txt_1" maxlength="20" value="<%=msgInfo.getAt("phone")%>"
					size="38" />
					</td>
					<td nowrap="nowrap" align="center" width="7%" colspan="1">修改物品</td>
				<td nowrap="nowrap" align="center" width="7%" colspan="1">
		<input type="checkbox" name="item1" value="上衣" <%=msgInfo.getAt("item1").equals("上衣")? "checked":"" %>><label>上衣</label>
		<input type="checkbox" name="item2" value="裤子" <%=msgInfo.getAt("item2").equals("裤子")? "checked":"" %>><label>裤子</label>
		<input type="checkbox" name="item3" value="马甲" <%=msgInfo.getAt("item3").equals("马甲")? "checked":"" %> ><label>马甲</label>
		<input type="checkbox" name="item4" value="衬衫" <%=msgInfo.getAt("item4").equals("衬衫")? "checked":"" %>  ><label>衬衫</label>
		<input type="checkbox" name="item5" value="大衣" <%=msgInfo.getAt("item5").equals("大衣")? "checked":"" %>  ><label>大衣</label>
					</td>
			</tr>
			
			
				<tr>
				<td nowrap="nowrap" align="center" width="7%" colspan="1">地址</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="7"><input
					name="address" size="38" id="address" type="text"   value="<%=msgInfo.getAt("address")%>"
					class="txt_1" maxlength="30" />
					</td>
			</tr>


	<tr>
				<td nowrap="nowrap" align="center" width="7%" colspan="1">售后类型</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="1"><input
					name="shouhou_type" size="38" id="shouhou_type" type="text"   value="<%=msgInfo.getAt("shouhou_type")%>"
					class="txt_1" maxlength="30" />
					</td>
					<td nowrap="nowrap" align="center" width="7%" colspan="1">售后次数</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="1"><input
					name="cishu" size="38" id="cishu" type="text"   value="<%=msgInfo.getAt("cishu")%>"
					class="txt_1" maxlength="30" />
					</td>
				
			</tr>
			
				<tr>
				<td nowrap="nowrap" align="center" width="7%" colspan="1">寄回物流单号</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="1">
				<input
					name="jihui" size="38" id="jihui" type="text"   value="<%=msgInfo.getAt("jihui")%>"
					class="txt_1" maxlength="30" />
					</td>
					<td nowrap="nowrap" align="center" width="7%" colspan="1">发货物流单号</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="1">
				<input
					name="fahuo" size="38" id="fahuo" type="text"   value="<%=msgInfo.getAt("fahuo")%>"
					class="txt_1" maxlength="30" />
					</td>
				
			</tr>
			
			
				<tr>
				<td nowrap="nowrap" align="center" width="7%" colspan="1">售后原因</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="1">
				<input
					name="reson" size="38" id="reson" type="text"  value="<%=msgInfo.getAt("reson")%>"
					class="txt_1" maxlength="30" />
					</td>
					<td nowrap="nowrap" align="center" width="7%" colspan="1">归责</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="3">
				<input
					name="guize" size="38" id="guize" type="text"    value="<%=msgInfo.getAt("guize")%>"
					class="txt_1" maxlength="30" />
					</td>
			</tr>
			

			

			<tr>
				<td nowrap="nowrap" align="center" width="7%">面料</td>
				<td nowrap="nowrap" align="center" width="7%"><input
					name="mianliao" id="mianliao" type="text" size="38" maxlength="100"
					placeholder="面料" value="<%=msgInfo.getAt("mianliao")%>" /></td>
				<td nowrap="nowrap" align="center" width="7%">用途</td>
				<td nowrap="nowrap" align="center" width="7%">
					<!-- <input
					name="yongtu" id="yongtu" type="text" size="38" maxlength="100" /> -->

					<select name="yongtu" value="yongtu">
						<option value="上衣"
							<%=msgInfo.getAt("yongtu").equals("上衣")? "selected":"" %>>上衣</option>
						<option value="裤子"
							<%=msgInfo.getAt("yongtu").equals("裤子")? "selected":"" %>>裤子</option>
						<option value="马甲"
							<%=msgInfo.getAt("yongtu").equals("马甲")? "selected":"" %>>马甲</option>
						<option value="衬衫"
							<%=msgInfo.getAt("yongtu").equals("衬衫")? "selected":"" %>>衬衫</option>
						<option value="西装套装"
							<%=msgInfo.getAt("yongtu").equals("衬衫")? "selected":"" %>>西装套装</option>
						<option value="换片"
							<%=msgInfo.getAt("yongtu").equals("换片")? "selected":"" %>>换片</option>
						<option value="其他"
							<%=msgInfo.getAt("yongtu").equals("其他")? "selected":"" %>>其他</option>
				</select>
				</td>
				<td nowrap="nowrap" align="center" width="7%">米数</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="mi"
					id="mi" type="text" size="38" maxlength="100"
					value="<%=msgInfo.getAt("mi")%>" /></td>
					<td nowrap="nowrap" align="center" width="7%">价格</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="jg"
					id="jg" type="text" size="38" maxlength="100"
					value="<%=msgInfo.getAt("jq")%>" />
					</td>
				<td nowrap="nowrap" align="center" width="7%">供应商</td>
				<td nowrap="nowrap" align="center" width="7%">
					<!-- <input
					name="gongyingshang" id="gongyingshang" type="text" size="38"
					maxlength="100" /> --> <%=request.getAttribute("companyList")%>
				</td>
	
			</tr>
		

		
 <%if(!"".equals(msgInfo.getAt("mianliao1"))&& msgInfo.getAt("mianliao1")!=null ){ %>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">面料</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="mianliao1" id="mianliao1"
				value="<%=msgInfo.getAt("mianliao1")%>"
				
				 type="text" size="38"
					maxlength="100" placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" width="7%">用途</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input
					name="yongtu1" id="yongtu1" 
					value="<%=msgInfo.getAt("yongtu1")%>"
					
					type="text" size="38" maxlength="100"
					placeholder="" 
					 /></td>

				<td nowrap="nowrap" align="center" width="7%">米数</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="mi1" id="mi1" 
				value="<%=msgInfo.getAt("mi1")%>"
				
				type="text" size="38" maxlength="100"
					 /></td>
					 	<td nowrap="nowrap" align="center" width="7%">价格</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="jg1"
					id="jg1" type="text" size="38" maxlength="100"
					value="<%=msgInfo.getAt("jq1")%>" />
					</td>
				<td nowrap="nowrap" align="center" width="7%">供应商</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input
					name="gys1" id="gys1" value="<%=msgInfo.getAt("gys1")%>"
					type="text" size="38" maxlength="100"
					 /></td>
					 
			</tr>
			 <%} %>
			 <%if(!"".equals(msgInfo.getAt("mianliao2"))&& msgInfo.getAt("mianliao2")!=null ){ %>
				<tr>
				<td nowrap="nowrap" align="center" width="7%">面料</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="mianliao2" id="mianliao2"
				value="<%=msgInfo.getAt("mianliao2")%>"
				
				 type="text" size="38"
					maxlength="100" placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" width="7%">用途</td> 
				<td nowrap="nowrap" align="center" width="7%">
				<input
					name="yongtu2" id="yongtu2" 
					value="<%=msgInfo.getAt("yongtu2")%>"
					
					type="text" size="38" maxlength="100"
					placeholder="" 
					 /></td>

				<td nowrap="nowrap" align="center" width="7%">米数</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="mi2" id="mi2" 
				value="<%=msgInfo.getAt("mi2")%>"
				
				type="text" size="38" maxlength="100"
					 /></td>
					 <td nowrap="nowrap" align="center" width="7%">价格</td>
				<td nowrap="nowrap" align="center" width="7%"><input name="jg2"
					id="jg2" type="text" size="38" maxlength="100"
					value="<%=msgInfo.getAt("jq2")%>" />
					</td>
				<td nowrap="nowrap" align="center" width="7%">供应商</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input
					name="gys2" id="gys2" value="<%=msgInfo.getAt("gys2")%>"
					type="text" size="38" maxlength="100"
					 /></td>
			</tr>
			 <%} %>
			 <%if(!"".equals(msgInfo.getAt("mianliao3"))&& msgInfo.getAt("mianliao3")!=null ){ %>
				<tr>
				<td nowrap="nowrap" align="center" width="7%">面料</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="mianliao3" id="mianliao3"
				value="<%=msgInfo.getAt("mianliao3")%>"
				
				 type="text" size="38"
					maxlength="100" placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" width="7%">用途</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input
					name="yongtu3" id="yongtu3" 
					value="<%=msgInfo.getAt("yongtu3")%>"
					
					type="text" size="38" maxlength="100"
					placeholder="" 
					 /></td>

				<td nowrap="nowrap" align="center" width="7%">米数</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="mi3" id="mi3" 
				value="<%=msgInfo.getAt("mi3")%>"
				
				type="text" size="38" maxlength="100"
					 /></td>
					 <td nowrap="nowrap" align="center" width="7%">价格</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="jg3"
					id="jg3" 
					value="<%=msgInfo.getAt("jq3")%>"
					type="text" size="38" maxlength="100"
					 />
					</td>
				<td nowrap="nowrap" align="center" width="7%">供应商</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input
					name="gys3" id="gys3" value="<%=msgInfo.getAt("gys3")%>"
					type="text" size="38" maxlength="100"
					 /></td>
			</tr>
			 <%} %>
			 <%if(!"".equals(msgInfo.getAt("mianliao4"))&& msgInfo.getAt("mianliao4")!=null ){ %>
				<tr>
				<td nowrap="nowrap" align="center" width="7%">面料</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="mianliao4" id="mianliao4"
				value="<%=msgInfo.getAt("mianliao4")%>"
				
				 type="text" size="38"
					maxlength="100" placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" width="7%">用途</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input
					name="yongtu4" id="yongtu4" 
					value="<%=msgInfo.getAt("yongtu4")%>"
					
					type="text" size="38" maxlength="100"
					placeholder="" 
					 /></td>

				<td nowrap="nowrap" align="center" width="7%">米数</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="mi4" id="mi4" 
				value="<%=msgInfo.getAt("mi4")%>"
				
				type="text" size="38" maxlength="100"
					 /></td>
					 	<td nowrap="nowrap" align="center" width="7%">
				<input name="jg4"
					id="jg4" 
					value="<%=msgInfo.getAt("jq4")%>"
					type="text" size="38" maxlength="100"
					 />
					</td>
				<td nowrap="nowrap" align="center" width="7%">供应商</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input
					name="gys4" id="gys4" value="<%=msgInfo.getAt("gys4")%>"
					type="text" size="38" maxlength="100"
					 /></td>
			</tr>
			 <%} %>
			 <%if(!"".equals(msgInfo.getAt("mianliao5"))&& msgInfo.getAt("mianliao5")!=null ){ %>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">面料</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="mianliao5" id="mianliao5"
				value="<%=msgInfo.getAt("mianliao5")%>"
				
				 type="text" size="38"
					maxlength="100" placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" width="7%">用途</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input
					name="yongtu5" id="yongtu5" 
					value="<%=msgInfo.getAt("yongtu5")%>"
					
					type="text" size="38" maxlength="100"
					placeholder="" 
					 /></td>

				<td nowrap="nowrap" align="center" width="7%">米数</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="mi5" id="mi5" 
				value="<%=msgInfo.getAt("mi5")%>"
				
				type="text" size="38" maxlength="100"
					 /></td>
					 	<td nowrap="nowrap" align="center" width="7%">
				<input name="jg5"
					id="jg5" 
					value="<%=msgInfo.getAt("jq5")%>"
					type="text" size="38" maxlength="100"
					 />
					</td>
				<td nowrap="nowrap" align="center" width="7%">供应商</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input
					name="gys5" id="gys5" value="<%=msgInfo.getAt("gys5")%>"
					type="text" size="38" maxlength="100"
					 /></td>
			</tr>
			 <%} %>
			 <%if(!"".equals(msgInfo.getAt("mianliao6"))&& msgInfo.getAt("mianliao6")!=null ){ %>
				<tr>
				<td nowrap="nowrap" align="center" width="7%">面料</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="mianliao6" id="mianliao6" value="<%=msgInfo.getAt("mianliao6")%>"
				
				 type="text" size="38"
					maxlength="100" placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" width="7%">用途</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input
					name="yongtu6" id="yongtu6"  value="<%=msgInfo.getAt("yongtu6")%>"
					
					type="text" size="38" maxlength="100"
					placeholder="" 
					 /></td>

				<td nowrap="nowrap" align="center" width="7%">米数</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="mi6" id="mi6" value="<%=msgInfo.getAt("mi6")%>"
				
				type="text" size="38" maxlength="100"
					 /></td>
					 	<td nowrap="nowrap" align="center" width="7%">
				<input name="jg6"
					id="jg6" 
					value="<%=msgInfo.getAt("jq6")%>"
					type="text" size="38" maxlength="100"
					 />
					</td>
				<td nowrap="nowrap" align="center" width="7%">供应商</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input
					name="gys6" id="gys6" value="<%=msgInfo.getAt("gys6")%>"
					type="text" size="38" maxlength="100"
					 /></td>
			</tr>
			 <%} %>
			 <%if(!"".equals(msgInfo.getAt("mianliao7"))&& msgInfo.getAt("mianliao7")!=null ){ %>
				<tr>
				<td nowrap="nowrap" align="center" width="7%">面料</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="mianliao7" id="mianliao7" value="<%=msgInfo.getAt("mianliao7")%>"
				
				 type="text" size="38"
					maxlength="100" placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" width="7%">用途</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input
					name="yongtu7" id="yongtu7"  value="<%=msgInfo.getAt("yongtu7")%>"
					
					type="text" size="38" maxlength="100"
					placeholder="" 
					 /></td>

				<td nowrap="nowrap" align="center" width="7%">米数</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="mi7" id="mi7" value="<%=msgInfo.getAt("mi7")%>"
				
				type="text" size="38" maxlength="100"
					 /></td>
					 	<td nowrap="nowrap" align="center" width="7%">
				<input name="jg7"
					id="jg7" 
					value="<%=msgInfo.getAt("jq7")%>"
					type="text" size="38" maxlength="100"
					 />
					</td>
				<td nowrap="nowrap" align="center" width="7%">供应商</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input
					name="gys7" id="gys7" value="<%=msgInfo.getAt("gys7")%>"
					type="text" size="38" maxlength="100"
					 /></td>
			</tr>
			 <%} %>
				 <%if(!"".equals(msgInfo.getAt("mianliao8"))&& msgInfo.getAt("mianliao8")!=null ){ %>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">面料</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="mianliao8" id="mianliao8" value="<%=msgInfo.getAt("mianliao8")%>"
				
				 type="text" size="38"
					maxlength="100" placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" width="7%">用途</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input
					name="yongtu8" id="yongtu8"  value="<%=msgInfo.getAt("yongtu8")%>"
					
					type="text" size="38" maxlength="100"
					placeholder="" 
					 /></td>

				<td nowrap="nowrap" align="center" width="7%">米数</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="mi8" id="mi8" value="<%=msgInfo.getAt("mi8")%>"
				
				type="text" size="38" maxlength="100"
					 /></td>
					 	<td nowrap="nowrap" align="center" width="7%">
				<input name="jg8"
					id="jg8" 
					value="<%=msgInfo.getAt("jq8")%>"
					type="text" size="38" maxlength="100"
					 />
					</td>
				<td nowrap="nowrap" align="center" width="7%">供应商</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input
					name="gys8" id="gys8" value="<%=msgInfo.getAt("gys8")%>"
					type="text" size="38" maxlength="100"
					 /></td>
			</tr>
			 <%} %>
				 <%if(!"".equals(msgInfo.getAt("mianliao9"))&& msgInfo.getAt("mianliao9")!=null ){ %>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">面料</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="mianliao9" id="mianliao9" value="<%=msgInfo.getAt("mianliao9")%>"
				
				 type="text" size="38"
					maxlength="100" placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" width="7%">用途</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input
					name="yongtu9" id="yongtu9"  value="<%=msgInfo.getAt("yongtu9")%>"
					
					type="text" size="38" maxlength="100"
					placeholder="" 
					 /></td>

				<td nowrap="nowrap" align="center" width="7%">米数</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="mi9" id="mi9" value="<%=msgInfo.getAt("mi9")%>"
				
				type="text" size="38" maxlength="100"
					 /></td>
					 	<td nowrap="nowrap" align="center" width="7%">
				<input name="jg9"
					id="jg9" 
					value="<%=msgInfo.getAt("jq9")%>"
					type="text" size="38" maxlength="100"
					 />
					</td>
				<td nowrap="nowrap" align="center" width="7%">供应商</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input
					name="gys9" id="gys9" value="<%=msgInfo.getAt("gys9")%>"
					type="text" size="38" maxlength="100"
					 /></td>
			</tr>
			 <%} %>
				 <%if(!"".equals(msgInfo.getAt("mianliao10"))&& msgInfo.getAt("mianliao10")!=null ){ %>
			
			<tr>
				<td nowrap="nowrap" align="center" width="7%">面料</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="mianliao10" id="mianliao10" value="<%=msgInfo.getAt("mianliao10")%>"
				
				 type="text" size="38"
					maxlength="100" placeholder=""
					 />
					</td>
					
				<td nowrap="nowrap" align="center" width="7%">用途</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input
					name="yongtu10" id="yongtu10"  value="<%=msgInfo.getAt("yongtu10")%>"
					
					type="text" size="38" maxlength="100"
					placeholder="" 
					 /></td>

				<td nowrap="nowrap" align="center" width="7%">米数</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="mi10" id="mi10" value="<%=msgInfo.getAt("mi10")%>"
				
				type="text" size="38" maxlength="100"
					 /></td>
					 <td nowrap="nowrap" align="center" width="7%">
				<input name="jg10"
					id="jg10" 
					value="<%=msgInfo.getAt("jq10")%>"
					type="text" size="38" maxlength="100"
					 />
					</td>
				<td nowrap="nowrap" align="center" width="7%">供应商</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input
					name="gys10" id="gys10" value="<%=msgInfo.getAt("gys10")%>"
					type="text" size="38" maxlength="100"
					 /></td>
			</tr>
			 <%} %>
				 <%if(!"".equals(msgInfo.getAt("mianliao11"))&& msgInfo.getAt("mianliao11")!=null ){ %>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">面料</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="mianliao11" id="mianliao11" value="<%=msgInfo.getAt("mianliao11")%>"
				
				 type="text" size="38"
					maxlength="100" placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" width="7%">用途</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input
					name="yongtu11" id="yongtu11"  value="<%=msgInfo.getAt("yongtu11")%>"
					
					type="text" size="38" maxlength="100"
					placeholder="" 
					 /></td>

				<td nowrap="nowrap" align="center" width="7%">米数</td>
				<td nowrap="nowrap" align="center" width="7%">
				
				<input name="mi11" id="mi11" value="<%=msgInfo.getAt("mi11")%>"
				
				type="text" size="38" maxlength="100"
					 /></td>
					 <td nowrap="nowrap" align="center" width="7%">
				<input name="jg11"
					id="jg11" 
					value="<%=msgInfo.getAt("jq11")%>"
					type="text" size="38" maxlength="100"
					 />
					</td>
				<td nowrap="nowrap" align="center" width="7%">供应商</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input
					name="gys11" id="gys11" value="<%=msgInfo.getAt("gys11")%>"
					type="text" size="38" maxlength="100"
					 /></td>
			</tr>
				 <%} %>
				 <%if(!"".equals(msgInfo.getAt("mianliao12"))&& msgInfo.getAt("mianliao12")!=null ){ %>
			<tr>
				<td nowrap="nowrap" align="center" width="7%">面料</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="mianliao12" id="mianliao12" value="<%=msgInfo.getAt("mianliao12")%>"
				
				 type="text" size="38"
					maxlength="100" placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" width="7%">用途</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input
					name="yongtu12" id="yongtu12"  value="<%=msgInfo.getAt("yongtu12")%>"
					
					type="text" size="38" maxlength="100"
					placeholder="" 
					 /></td>

				<td nowrap="nowrap" align="center" width="7%">米数</td>
				<td nowrap="nowrap" align="center" width="7%">
				
				<input name="mi12" id="mi12" value="<%=msgInfo.getAt("mi12")%>"
				
				type="text" size="38" maxlength="100"
					 /></td>
					 <td nowrap="nowrap" align="center" width="7%">
				<input name="jg12"
					id="jg12" 
					value="<%=msgInfo.getAt("jq12")%>"
					type="text" size="38" maxlength="100"
					 />
					</td>
				<td nowrap="nowrap" align="center" width="7%">供应商</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input
					name="gys12" id="gys12" value="<%=msgInfo.getAt("gys12")%>"
					type="text" size="38" maxlength="100"
					 /></td>
			</tr>
			
			 <%} %>
				 <%if(!"".equals(msgInfo.getAt("mianliao13"))&& msgInfo.getAt("mianliao13")!=null ){ %>
				<tr>
				<td nowrap="nowrap" align="center" width="7%">面料</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="mianliao13" id="mianliao13" value="<%=msgInfo.getAt("mianliao13")%>"
				
				 type="text" size="38"
					maxlength="100" placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" width="7%">用途</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input
					name="yongtu13" id="yongtu13"  value="<%=msgInfo.getAt("yongtu13")%>"
					
					type="text" size="38" maxlength="100"
					placeholder="" 
					 /></td>

				<td nowrap="nowrap" align="center" width="7%">米数</td>
				<td nowrap="nowrap" align="center" width="7%">
				
				<input name="mi13" id="mi13" value="<%=msgInfo.getAt("mi13")%>"
				
				type="text" size="38" maxlength="100"
					 /></td>
					 <td nowrap="nowrap" align="center" width="7%">
				<input name="jg13"
					id="jg13" 
					value="<%=msgInfo.getAt("jq13")%>"
					type="text" size="38" maxlength="100"
					 />
					</td>
				<td nowrap="nowrap" align="center" width="7%">供应商</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input
					name="gys13" id="gys13" value="<%=msgInfo.getAt("gys13")%>"
					type="text" size="38" maxlength="100"
					 /></td>
			</tr>
			
			 <%} %>
				 <%if(!"".equals(msgInfo.getAt("mianliao14"))&& msgInfo.getAt("mianliao14")!=null ){ %>
				<tr>
				<td nowrap="nowrap" align="center" width="7%">面料</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input name="mianliao14" id="mianliao14" value="<%=msgInfo.getAt("mianliao14")%>"
				
				 type="text" size="38"
					maxlength="100" placeholder=""
					 />
					</td>
				<td nowrap="nowrap" align="center" width="7%">用途</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input
					name="yongtu14" id="yongtu14"  value="<%=msgInfo.getAt("yongtu14")%>"
					
					type="text" size="38" maxlength="100"
					placeholder="" 
					 /></td>

				<td nowrap="nowrap" align="center" width="7%">米数</td>
				<td nowrap="nowrap" align="center" width="7%">
				
				<input name="mi14" id="mi14" value="<%=msgInfo.getAt("mi14")%>"
				
				type="text" size="38" maxlength="100"
					 /></td>
					 <td nowrap="nowrap" align="center" width="7%">
				<input name="jg14"
					id="jg14" 
					value="<%=msgInfo.getAt("jq14")%>"
					type="text" size="38" maxlength="100"
					 />
					</td>
				<td nowrap="nowrap" align="center" width="7%">供应商</td>
				<td nowrap="nowrap" align="center" width="7%">
				<input
					name="gys14" id="gys14" value="<%=msgInfo.getAt("gys14")%>"
					type="text" size="38" maxlength="100"
					 /></td>
			</tr>
				 <%} %>
				
				 
				<tr>
				<tr>
				<td nowrap="nowrap" align="center" width="7%">售后内容</td>
				<td nowrap="nowrap" align="left" width="7%" colspan="7"><input
					name="remark" id="remark" type="text" size="200" maxlength="100"
					value="<%=msgInfo.getAt("remark")%>" /></td>
			</tr>
				<td nowrap="nowrap" align="center" width="7%"><input
					style="border:none;" name="anniu" size="200" id="anniu"
					type="hidden" class="txt_1" /></td>
				<td nowrap="nowrap" align="center" width="7%"><input
					type="button" name="ok" accesskey="y" tabindex="y" value="保存"
					title="1" class="but_1" onclick="onAdd(this.title)"
					style="font-size:12;width:40px;height:21px;"> <input
					type="button" name="ok" accesskey="y" tabindex="y" value="提交"
					title="2" class="but_1" onclick="onAdd(this.title)"
					style="font-size:12;width:40px;height:21px;"> <input
					type="button" name="back" accesskey="b" tabindex="b" value="返 回"
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
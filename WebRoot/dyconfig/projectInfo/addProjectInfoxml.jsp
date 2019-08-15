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
<script src="<%=request.getContextPath()%>/js/jquery-1.8.2.js"
	type="text/javascript"></script>
<title>�ޱ����ĵ�</title>
</head>
<script type="text/javascript">
	function onAdd() {
		/* if(frmGo.projectNo.value.trim() == ""){
			alert("��Ŀ��Ų���Ϊ�գ�����������");
			frmGo.projectNo.focus();
			return false;
		}
		if(frmGo.projectName.value.trim() == ""){
			alert("��Ŀ���Ʋ���Ϊ�գ�����������");
			frmGo.projectName.focus();
			return false;
		} */
		frmGo.submit();
	}

	function preViews() {
		document.getElementById('preView').style.display = "none"
		document.getElementById('rePicture').style.display = "none"
		document.getElementById('pictureView').style.display = "block"
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
		<table width="100%" class="tbl_11" border="1" bordercolorlight=#000000
			bordercolordark=#000000 bordercolor=#000000 cellspacing="0"
			cellpadding="2">
			<tr>
				<th colspan="8" nowrap="nowrap" align="left">��Ӷ�����Ϣ(�ͻ�����)</th>
			</tr>

			<tr class="tr_11">
				<td colspan="8" nowrap="nowrap" align="center" width="7%">��һ���ƿͻ�����</td>
			</tr>

			<tr>
				<td align="left">�������</td>
				<td colspan="2" align="left">�Զ�����</td>
				<td align="left">������</td>
				<td colspan="2" align="left"><input name="projectNo" size="20"
					id="projectNo" type="text" class="txt_1" maxlength="30" /><font
					color="red">*</font></td>
				<td align="left">���ۼ۸�</td>
				<td align="left"><input name="salePrice" size="20"
					id="salePrice" type="text" class="txt_1" maxlength="30" /><font
					color="red">*</font></td>
			</tr>

			<tr>
				<td>΢����</td>
				<td colspan="2"><input name="wechat" size="20" id="wechat"
					type="text" class="txt_1" maxlength="30" /><font color="red">*</font></td>
				<td>������</td>
				<td colspan="2"><input name="orderNumber" size="20"
					id="orderNumber" type="text" class="txt_1" maxlength="30" /><font
					color="red">*</font></td>
				<td>�µ�ʱ��</td>
				<td></td>
			</tr>


			<tr>
				<td>�ͻ��绰</td>
				<td colspan="2"><input name="kehuPhone" size="20"
					id="kehuPhone" type="text" class="txt_1" maxlength="30" /><font
					color="red">*</font></td>
				<td>��������</td>
				<td colspan="2"><select name="orderType" value="orderType">
						<option value="�µ�">�µ�</option>
						<option value="����">����</option>
						<option value="����">����</option>
				</select></td>
				<td>����ʱ��</td>
				<td></td>
			</tr>


			<tr>
				<td>�ͻ�����</td>
				<td><input name="kehuName" size="50" id="kehuName" type="text"
					class="txt_1" maxlength="100" /><font color="red">*</font></td>
				<td>����</td>
				<td><select name="qudao" value="qudao">
						<option value="�Ա�">�Ա�</option>
						<option value="����">����</option>
						<option value="����">����</option>
						<option value="����">����</option>
						<option value="����">����</option>
						<option value="����">����</option>
						<option value="����">����</option>
				</select> <font color="red">*</font></td>
				<td>�µ��ͷ�</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>�ͻ���ַ</td>
				<td colspan="7"><input name="address" size="100" id="address"
					type="text" class="txt_1" maxlength="100" /><font color="red">*</font>
				</td>
			</tr>

			<tr>
				<td>���</td>
				<td><input name="height" size="20" id="height" type="text"
					class="txt_1" maxlength="100" /><font color="red">*</font></td>
				<td>����</td>
				<td><input name="weight" size="20" id="weight" type="text"
					class="txt_1" maxlength="100" /><font color="red">*</font></td>
				<td>����</td>
				<td><input name="age" size="20" id="age" type="text"
					class="txt_1" maxlength="100" /><font color="red">*</font></td>
				<td>�Ա�</td>
				<td><select name="sex" value="sex">
						<option value="��">��</option>
						<option value="Ů">Ů</option>
				</select> <font color="red">*</font></td>
			</tr>

			<tr>
				<td colspan="2">��װ����</td>
				<td>����</td>
				<td colspan="2">��������</td>
				<td>������</td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>���</td>
				<td><input name="jiankuanA" size="20" id="jiankuanA"
					type="text" class="txt_1" maxlength="100" /><font color="red">*</font>
				</td>
				<td></td>
				<td>��Χ</td>
				<td><input name="lingweiB" size="20" id="lingweiB" type="text"
					class="txt_1" maxlength="100" /><font color="red">*</font></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>��Χ</td>
				<td><input name="xiongweiA" size="20" id="xiongweiA"
					type="text" class="txt_1" maxlength="100" /><font color="red">*</font>
				</td>
				<td></td>
				<td>��Χ</td>
				<td><input name="xiongweiB" size="20" id="xiongweiB"
					type="text" class="txt_1" maxlength="100" /><font color="red">*</font>
				</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>����</td>
				<td><input name="zhongyaoA" size="20" id="zhongyaoA"
					type="text" class="txt_1" maxlength="100" /><font color="red">*</font>
				</td>
				<td></td>
				<td>����</td>
				<td><input name="zhongyaoB" size="20" id="zhongyaoB"
					type="text" class="txt_1" maxlength="100" /><font color="red">*</font>
				</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>��Χ</td>
				<td><input name="fuweiA" size="20" id="fuweiA" type="text"
					class="txt_1" maxlength="100" /><font color="red">*</font></td>
				<td></td>
				<td>��Χ</td>
				<td><input name="fuweiB" size="20" id="fuweiB" type="text"
					class="txt_1" maxlength="100" /><font color="red">*</font></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>�����³�</td>
				<td><input name="houzhongyichangA" size="20"
					id="houzhongyichangA" type="text" class="txt_1" maxlength="100" /><font
					color="red">*</font></td>
				<td></td>
				<td>�䳤</td>
				<td><input name="xiuchangB" size="20" id="xiuchangB"
					type="text" class="txt_1" maxlength="100" /><font color="red">*</font>
				</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>ǰ�³�</td>
				<td><input name="qianyichangA" size="20" id="qianyichangA"
					type="text" class="txt_1" maxlength="100" /><font color="red">*</font>
				</td>
				<td></td>
				<td>���</td>
				<td><input name="xiufeiB" size="20" id="xiufeiB" type="text"
					class="txt_1" maxlength="100" /><font color="red">*</font></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>�䳤</td>
				<td><input name="xiuchangA" size="20" id="xiuchangA"
					type="text" class="txt_1" maxlength="100" /><font color="red">*</font>
				</td>
				<td></td>
				<td>���</td>
				<td><input name="xiukouB" size="20" id="xiukouB" type="text"
					class="txt_1" maxlength="100" /><font color="red">*</font></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>���</td>
				<td><input name="xiufeiA" size="20" id="xiufeiA" type="text"
					class="txt_1" maxlength="100" /><font color="red">*</font></td>
				<td></td>
				<td>��ڿ�ʽ</td>
				<td><input name="lingkoukuaishiB" size="20"
					id="lingkoukuaishiB" type="text" class="txt_1" maxlength="100" /><font
					color="red">*</font></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>


			<tr>
				<td>���</td>
				<td><input name="xiukouA" size="20" id="xiukouA" type="text"
					class="txt_1" maxlength="100" /><font color="red">*</font></td>
				<td></td>
				<td>�³�</td>
				<td><input name="yichangB" size="20" id="yichangB" type="text"
					class="txt_1" maxlength="100" /><font color="red">*</font></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td colspan="2">��������</td>
				<td>����</td>
				<td colspan="2">�������</td>
				<td>�����</td>
				<td></td>
				<td></td>
			</tr>


			<tr>
				<td>�㳤</td>
				<td><input name="kuchangC" size="20" id="kuchangC" type="text"
					class="txt_1" maxlength="100" /><font color="red">*</font></td>
				<td></td>
				<td>��Χ</td>
				<td><input name="xiongweiD" size="20" id="xiongweiD"
					type="text" class="txt_1" maxlength="100" /><font color="red">*</font>
				</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>


			<tr>
				<td>��Χ</td>
				<td><input name="yaoweiC" size="20" id="yaoweiC" type="text"
					class="txt_1" maxlength="100" /><font color="red">*</font></td>
				<td></td>
				<td>����</td>
				<td><input name="zhongyaoD" size="20" id="zhongyaoD"
					type="text" class="txt_1" maxlength="100" /><font color="red">*</font>
				</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>��Χ</td>
				<td><input name="tuiweiC" size="20" id="tuiweiC" type="text"
					class="txt_1" maxlength="100" /><font color="red">*</font></td>
				<td></td>
				<td>�³�</td>
				<td><input name="yichangD" size="20" id="yichangD" type="text"
					class="txt_1" maxlength="100" /><font color="red">*</font></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>


			<tr>
				<td>��Χ</td>
				<td><input name="dangweiC" size="20" id="dangweiC" type="text"
					class="txt_1" maxlength="100" /><font color="red">*</font></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>����</td>
				<td><input name="datuiC" size="20" id="datuiC" type="text"
					class="txt_1" maxlength="100" /><font color="red">*</font></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>


			<tr>
				<td>����</td>
				<td><input name="zhongtuiC" size="20" id="zhongtuiC"
					type="text" class="txt_1" maxlength="100" /><font color="red">*</font>
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
				<td><input name="xiaotuiC" size="20" id="xiaotuiC" type="text"
					class="txt_1" maxlength="100" /><font color="red">*</font></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>�ſ�</td>
				<td><input name="tuikouC" size="20" id="tuikouC" type="text"
					class="txt_1" maxlength="100" /><font color="red">*</font></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>����</td>
				<td><input name="kouxingC" size="20" id="kouxingC" type="text"
					class="txt_1" maxlength="100" /><font color="red">*</font></td>
				<td>��ɫ</td>
				<td><input name="kouseC" size="20" id="kouseC" type="text"
					class="txt_1" maxlength="100" /><font color="red">*</font></td>
				<td>����</td>
				<td><select name="kuanxingD" value="kuanxingD">
						<option value="����">����</option>
						<option value="����+">����+</option>
						<option value="����">����</option>
						<option value="����+">����+</option>
						<option value="����">����</option>
						<option value="����+">����+</option>
				</select> <font color="red">*</font></td>
				<td>��ͷ</td>
				<td><select name="botouD" value="botouD">
						<option value="��װ��">��װ��</option>
						<option value="ƽ����">ƽ����</option>
						<option value="ꨲ���">ꨲ���</option>
						<option value="�����">�����</option>
						<option value="����">����</option>
						<option value="�л�����">�л�����</option>
						<option value="����">����</option>
				</select> <font color="red">*</font></td>
			</tr>

			<tr>
				<td>�ڴ�</td>
				<td><select name="koudaiC" value="koudaiC">
						<option value="˫��">˫��</option>
						<option value="����">����</option>
						<option value="Ʊ��">Ʊ��</option>
						<option value="����">����</option>
				</select> <font color="red">*</font></td>
				<td>����</td>
				<td><select name="daigai" value="daigai">
						<option value="��">��</option>
						<option value="��">��</option>
						<option value="����">����</option>
				</select> <font color="red">*</font></td>
				<td>ƽб��</td>
				<td><select name="pingxiedai" value="pingxiedai">
						<option value="ƽ��">ƽ��</option>
						<option value="б��">б��</option>
						<option value="����">����</option>
				</select> <font color="red">*</font></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>����1</td>
				<td><input name="miaoliao1" size="20" id="miaoliao1"
					type="text" class="txt_1" maxlength="100" /><font color="red">*</font>
				</td>
				<td>����</td>
				<td></td>
				<td>��;</td>
				<td><input name="yongtu1" size="20" id="yongtu1" type="text"
					class="txt_1" maxlength="100" /><font color="red">*</font></td>
				<td>��Ӧ��</td>
				<td></td>
			</tr>

			<tr>
				<td>����2</td>
				<td><input name="miaoliao2" size="20" id="miaoliao2"
					type="text" class="txt_1" maxlength="100" /><font color="red">*</font>
				</td>
				<td>����</td>
				<td></td>
				<td>��;</td>
				<td><input name="yongtu2" size="20" id="yongtu2" type="text"
					class="txt_1" maxlength="100" /><font color="red">*</font></td>
				<td>��Ӧ��</td>
				<td></td>
			</tr>

			<tr>
				<td>���ͱ�ע</td>
				<td colspan="3"><input name="tixingremark" size="60"
					id="tixingremark" type="text" class="txt_1" maxlength="100" /><font
					color="red">*</font></td>
				<td>��ע</td>
				<td colspan="3"><input name="remark" size="60" id="remark"
					type="text" class="txt_1" maxlength="100" /><font color="red">*</font>
				</td>
			</tr>

			<tr>
				<td align="left">����</td>
				<td colspan="7"><input type="file" name="channelId"
					id="channelId" multiple="multiple" class="imagePath" /> <img alt=""
					src="" id="image1" class="showImage"></td>
			</tr>

			<tr class="tr_11">
				<td width="7%"></td>
				<td align="left" colspan="2">&nbsp;&nbsp;&nbsp;<input
					type="button" name="ok" accesskey="y" tabindex="y" value="ȷ ��"
					class="but_1" onclick="onAdd()"
					style="font-size:12;width:40px;height:21px;"> <input
					type="button" name="back" accesskey="b" tabindex="b" value="�� ��"
					class="but_1"
					onclick="location='doProjectInfo.do?method=queryProjectInfoXml'"
					style="font-size:12;width:40px;height:21px;">
				</td>
			</tr>
		</table>

	</form>
</body>
</html>
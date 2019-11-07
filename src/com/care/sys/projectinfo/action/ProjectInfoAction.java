package com.care.sys.projectinfo.action;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;

import jxl.Workbook;
import jxl.format.VerticalAlignment;
import jxl.write.BorderLineStyle;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.logging.Log;
import org.apache.ecs.xhtml.u;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.upload.FormFile;

import com.care.app.LoginUser;
import com.care.common.config.Config;
import com.care.common.config.ServiceBean;
import com.care.common.http.BaseAction;
import com.care.common.lang.Base64Convert;
import com.care.common.lang.CommTools;
import com.care.common.lang.CommUtils;
import com.care.common.lang.Constant;
import com.care.common.lang.GetExCel;
import com.care.common.lang.ParseDomDocument;
import com.care.common.lang.TestFileManager;
import com.care.sys.appuserinfo.domain.AppUserInfo;
import com.care.sys.channelinfo.domain.ChannelInfo;
import com.care.sys.companyinfo.domain.CompanyInfo;
import com.care.sys.deviceactiveinfo.domain.DeviceActiveInfo;
import com.care.sys.dynamicInfo.domain.DynamicInfo;
import com.care.sys.feedbackinfo.domain.FeedBackInfo;
import com.care.sys.projectinfo.domain.ProjectInfo;
import com.care.sys.projectinfo.domain.logic.ProjectInfoFacade;
import com.care.sys.projectinfo.form.ProjectInfoForm;
import com.care.sys.shareinfo.domain.ShareInfo;
import com.care.sys.userinfo.domain.UserInfo;
import com.care.sys.userinfo.domain.logic.UserInfoFacade;
import com.care.utils.QRCodeUtil;
import com.care.utils.Utils;
import com.care.utils.ZipUtils;
import com.godoing.rose.http.common.HttpTools;
import com.godoing.rose.http.common.PagePys;
import com.godoing.rose.http.common.Result;
import com.godoing.rose.lang.DataList;
import com.godoing.rose.lang.DataMap;
import com.godoing.rose.lang.SystemException;
import com.godoing.rose.log.LogFactory;

public class ProjectInfoAction extends BaseAction {
	
	  Calendar calendar = Calendar.getInstance();
	Log logger = LogFactory.getLog(ProjectInfoAction.class);
	String xmlfileName = "advertising.xml";
	// String xmlpath="E:/resin/resin-pro-4.0.53/webapps/ads/WIITE/C7/ads/";
	String xmlpath = "/usr/local/resin-pro-4.0.53/webapps/ads/WIITE/C7/ads/";
//	String photoPath = "E:/resin/test/";
	String photoPath = "D:/resin/webapps/watch/upload/fujian/";
	//String qianZhui = "D:/resin/webapps/clothes/upload/photo/";
	// String photoUrl="http://localhost:8080/ads/photo/";

	// String photoPath = "/usr/local/resin-pro-4.0.53/webapps/ads/photo/";
	String photoUrl = "http://www.wiiteer.com:8999/ads/photo/";

	/*************************************************************************************************************/
	String clockskinName = "clockskin.xml";
	// String clockxmlpath =
	// "E:/resin/resin-pro-4.0.53/webapps/ads/WIITE/biaopan/";
	String clockdownloadUrl = "http://www.wiiteer.com:8999/ads/WIITE/biaopan/";
	String clockxmlpath = "/usr/local/resin-pro-4.0.53/webapps/ads/WIITE/biaopan/";
	
	public ActionForward daiban(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String href = request.getServletPath();
		Date start = new Date();
		Result result = new Result();// ���
		
		LoginUser loginUser = (LoginUser)request.getSession().getAttribute(Config.SystemConfig.LOGINUSER);
		if (loginUser == null) {
	           result.setBackPage(Config.INDEX_PAGE);
	           result.setResultCode("timeout");
	           result.setResultType("fail");
	           request.setAttribute("result", null);
	           return mapping.findForward("result");
		}
		
		
		PagePys pys = new PagePys();// ҳ������
		DataList list = null; // ����ҳ��List ��logic itrate��ȡ��
		StringBuffer sb = new StringBuffer();// �����ַ�����
		ProjectInfoFacade info = ServiceBean.getInstance()
				.getProjectInfoFacade();// ����userApp������ȡ��user�ֵ䣩
		ProjectInfo pro = new ProjectInfo();

		try {
			
			
			loginUser.setCvsCode("10");
			request.getSession().setAttribute(
					Config.SystemConfig.LOGINUSER, loginUser);
			String userName = loginUser.getUserName();

			String companyInfoId = loginUser.getCompanyId();
			String projectInfoId = loginUser.getProjectId();
			ProjectInfoForm form = (ProjectInfoForm) actionForm;
			ProjectInfo vo = new ProjectInfo();
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");
			String companyId = request.getParameter("companyId");
			String orderId = request.getParameter("orderId");
			String phone = request.getParameter("phone");

			/* ���û������ֶ� */
			form.setOrderBy("id");
			form.setSort("1");
			sb.append("1=1");

			String wwname = request.getParameter("wwname");

			if (wwname != null && !"".equals(wwname)) {
				sb.append(" and ww_name ='" + wwname + "'");
			}

			if (!projectInfoId.equals("0")) {
				sb.append(" and p.id in(" + projectInfoId + ")");
			} else {
				if (!"0".equals(companyId) && companyId != null) {
					sb.append(" and p.company_id in(" + companyInfoId + ")");
				}
			}
			if (startTime != null && !"".equals(startTime)) {
				sb.append(" and substring(p.add_time,1,10) >= '" + startTime
						+ "'");
			}
			if (endTime != null && !"".equals(endTime)) {
				sb.append(" and substring(p.add_time,1,10) <= '" + endTime
						+ "'");
			}
			if (companyId != null && !"".equals(companyId)) {
				sb.append(" and p.company_id='" + companyId + "'");
			}
			if (phone != null && !"".equals(phone)) {
				sb.append(" and kehu_phone ='" + phone + "'");
				request.setAttribute("phone", phone);
			}
			if (orderId != null && !"".equals(orderId)) {
				sb.append(" and order_number='" + orderId + "'");
				request.setAttribute("orderId", orderId);
			}
			List<DataMap> pros = ServiceBean.getInstance()
					.getProjectInfoFacade().getProjectInfo(pro);
			request.setAttribute("project", pros);

			/*
			 * CompanyInfo ci = new CompanyInfo(); List<DataMap> coms =
			 * ServiceBean.getInstance()
			 * .getCompanyInfoFacade().getCompanyInfo(ci);
			 * request.setAttribute("company", coms);
			 */

			request.setAttribute("wwname", wwname);
			request.setAttribute("fNow_date", startTime);
			request.setAttribute("now_date", endTime);
			request.setAttribute("companyId", companyId);
		/*	request.setAttribute("userId", userId);
			request.setAttribute("projectId", projectId);*/
			
			request.setAttribute("role","admin");
			UserInfo uvo =new UserInfo();
			uvo.setCondition("userCode = '"+userName+"' limit 1");
			List<DataMap> listUo =  ServiceBean.getInstance().getUserInfoFacade().getUserInfo(uvo);
			if(listUo.size()>0){
				String role = listUo.get(0).get("code")+"";
				request.setAttribute("role",role);
				
				if (!"admin".equals(userName)) {
					if("批单".equals(role)){
						if (sb.toString().length() > 0) {
							sb.append(" and status >=2 and status <=8   and status!=4 and status!=5 and status!=6 and status!=7    ");
						} else {
							sb.append("status >=2 and status <=8  and status!=4 and status!=5 and status!=6 and status!=7");
						}
					}else if("客服".equals(role)){
						if (sb.toString().length() > 0) {
							sb.append(" and xiadan_kefu ='" + userName + "'and status>=1 and status<=4 and status!=2  and status!=3 ");
						} else {
							sb.append("xiadan_kefu ='" + userName
									 + "' status<=4 and status != 2 and status != 3");
						}
					}else if("跟单".equals(role)){
						if (sb.toString().length() > 0) {
							sb.append(" and status >=5 and status <=6 ");
						} else {
							sb.append("status >=5 and status <=6");
						}
					}else if("经理".equals(role)){

						if (sb.toString().length() > 0) {
							sb.append( "  AND    STATUS=4 ");
						} else {
							sb.append( "   STATUS<=4 AND STATUS != 2 AND STATUS != 3");
						}
					
					}
					
				}
				
			}
			
			
			
			
			
		
			
			
			vo.setCondition(sb.toString());

			BeanUtils.copyProperties(vo, form);
			list = info.getProjectInfoListByVo(vo);
			BeanUtils.copyProperties(pys, form);
			pys.setCounts(list.getTotalSize());

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(request.getQueryString() + "  " + e);
			result.setBackPage(Config.ABOUT_PAGE); /*
													 * ����Ϊ����ҳ�棬���Գ������ת��ϵ
													 * ͳĬ��ҳ��
													 */
			if (e instanceof SystemException) { /* ����֪�쳣���н��� */
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else { /* ��δ֪�쳣���н�������ȫ�������δ֪�쳣 */
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
			request.setAttribute("pageList", list);
			request.setAttribute("PagePys", pys);
		}
		// CommUtils.getIntervalTime(start, new Date(), href);
		return mapping.findForward("daiban");
	}
	

	public ActionForward verfyDingDan(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {
		List<DataMap> list = null;
		ProjectInfo vo = new ProjectInfo();
		String userCode = request.getParameter("userCode");
		if (userCode != null && !"".equals(userCode)) {
			vo.setCondition("order_number ='" + userCode + "'");
			try {
				list = ServiceBean.getInstance()
						.getProjectInfoFacade().getProjectInfo(vo);
				if (!list.isEmpty()&&list.size()>0) {
				response.getWriter().write("fail");
				} else {
					response.getWriter().write("success");
				}
			} catch (SystemException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	public ActionForward queryProjectInfoXml(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String href = request.getServletPath();
		Date start = new Date();
		Result result = new Result();// ���
		
		LoginUser loginUser = (LoginUser)request.getSession().getAttribute(Config.SystemConfig.LOGINUSER);
		if (loginUser == null) {
	            result.setBackPage(Config.INDEX_PAGE);
	           result.setResultCode("timeout");
	           result.setResultType("fail");
	           request.setAttribute("result", null);
	           return mapping.findForward("result");
		}
		
		PagePys pys = new PagePys();// ҳ������
		DataList list = null; // ����ҳ��List ��logic itrate��ȡ��
		StringBuffer sb = new StringBuffer();// �����ַ�����
		ProjectInfoFacade info = ServiceBean.getInstance()
				.getProjectInfoFacade();// ����userApp������ȡ��user�ֵ䣩
		ProjectInfo pro = new ProjectInfo();

		try {
			
			
			
			String userName = loginUser.getUserName();

			String companyInfoId = loginUser.getCompanyId();
			String projectInfoId = loginUser.getProjectId();
			ProjectInfoForm form = (ProjectInfoForm) actionForm;
			ProjectInfo vo = new ProjectInfo();
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");
			String companyId = request.getParameter("companyId");
			String userId = request.getParameter("userId");
			String orderId = request.getParameter("orderId");
			
			String anniu = request.getParameter("anniu");
			
		

			/* ���û������ֶ� */
			form.setOrderBy("id");
			form.setSort("1");
			sb.append("1=1");

			String wwname = request.getParameter("wwname");
			String phone = request.getParameter("phone");

			if (wwname != null && !"".equals(wwname)) {
				sb.append(" and ww_name ='" + wwname + "'");
			}
			if (phone != null && !"".equals(phone)) {
				sb.append(" and kehu_phone ='" + phone + "'");
			}

			if (!projectInfoId.equals("0")) {
				sb.append(" and p.id in(" + projectInfoId + ")");
			} else {
				if (!"0".equals(companyId) && companyId != null) {
					sb.append(" and p.company_id in(" + companyInfoId + ")");
				}
			}
			if (startTime != null && !"".equals(startTime)) {
				sb.append(" and add_time >= '" + startTime
						+ "'");
			}
			if (endTime != null && !"".equals(endTime)) {
				sb.append(" and add_time <= '" + endTime
						+ "'");
			}
			if (companyId != null && !"".equals(companyId)) {
				sb.append(" and p.company_id='" + companyId + "'");
			}
			if (orderId != null && !"".equals(orderId)) {
				sb.append(" and order_number like '%" + orderId + "%'");
			}
			if (userId != null && !"".equals(userId)) {
				sb.append(" and p.company_id='" + userId + "'");
				pro.setCondition("company_id = '" + userId + "'");
			}
			List<DataMap> pros = ServiceBean.getInstance()
					.getProjectInfoFacade().getProjectInfo(pro);
			
		
			
			request.setAttribute("project", pros);

			/*
			 * CompanyInfo ci = new CompanyInfo(); List<DataMap> coms =
			 * ServiceBean.getInstance()
			 * .getCompanyInfoFacade().getCompanyInfo(ci);
			 * request.setAttribute("company", coms);
			 */

			request.setAttribute("wwname", wwname);
			request.setAttribute("fNow_date", startTime);
			request.setAttribute("now_date", endTime);
			request.setAttribute("companyId", companyId);
			request.setAttribute("userId", userId);
			request.setAttribute("orderId", orderId);
			request.setAttribute("phone", phone);
			
			request.setAttribute("role","admin");
			UserInfo uvo =new UserInfo();
			uvo.setCondition("userCode = '"+userName+"' limit 1");
			List<DataMap> listUo =  ServiceBean.getInstance().getUserInfoFacade().getUserInfo(uvo);
			if(listUo.size()>0){
				String role = listUo.get(0).get("code")+"";
				request.setAttribute("role",role);
				
				if (!"admin".equals(userName)) {
					if("批单".equals(role)){
						if (sb.toString().length() > 0) {
							sb.append(" and status >=2");
						} else {
							sb.append("status >=2");
						}
					}else if("客服".equals(role)){
						if (sb.toString().length() > 0) {
							sb.append(" and xiadan_kefu ='" + userName
									 + "'");
						} else {
							sb.append("xiadan_kefu ='" + userName
									 + "'");
						}
					}else if("跟单".equals(role)){
						if (sb.toString().length() > 0) {
							sb.append(" and status >=5");
						} else {
							sb.append("status >=5");
						}
					}else if("经理".equals(role)){
						
					}
					
				}
				
			}
			
			
			
			
			
			
			
			
			vo.setCondition(sb.toString());

			BeanUtils.copyProperties(vo, form);
			list = info.getProjectInfoListByVo(vo);
			System.out.println("按钮="+anniu);
			System.out.println("搜索到的长度="+pros.size());
			System.err.println(sb.toString());
			
			ProjectInfo prolis = new ProjectInfo();
			prolis.setCondition(sb.toString());
			List<DataMap> proslist = ServiceBean.getInstance()
					.getProjectInfoFacade().getProjectInfo(prolis);
			System.err.println(sb.toString());
			if(proslist.size()>=1 && "2".equals(anniu)){
				
				String orderIdName = System.currentTimeMillis()+"";
				

				String Divpath = "D:/resin/webapps/watch/upload/daochu/";// 文件保存路径
				File dirFile = new File(Divpath);
				if (!dirFile.exists()) {// 文件路径不存在时，自动创建目录
					dirFile.mkdir();
				}
				String path = Divpath +orderIdName+".xls";// 文件名字
				// 创建一个可写入的excel文件对象
				WritableWorkbook workbook = Workbook.createWorkbook(new File(path));
				// 使用第一张工作表，将其命名为“测试”
				WritableSheet sheet = workbook.createSheet("导出", 0);

				// 设置字体种类和格式
				WritableFont bold = new WritableFont(WritableFont.createFont("宋体") , 9,
						WritableFont.BOLD);
				WritableCellFormat bai = new WritableCellFormat();
				bai.setAlignment(jxl.format.Alignment.CENTRE);// 单元格中的内容水平方向居中
				bai.setBorder(jxl.format.Border.ALL, BorderLineStyle.MEDIUM);
				bai.setVerticalAlignment(VerticalAlignment.CENTRE);
				WritableFont bold1 = new WritableFont(WritableFont.createFont("宋体") , 9,
						WritableFont.BOLD);
				WritableCellFormat bai1 = new WritableCellFormat(bold1);
				bai1.setAlignment(jxl.format.Alignment.CENTRE);// 单元格中的内容水平方向居中
				bai1.setBorder(jxl.format.Border.ALL, BorderLineStyle.MEDIUM);
				bai1.setVerticalAlignment(VerticalAlignment.CENTRE);
				
				
				WritableCellFormat hei = new WritableCellFormat(bold);
				hei.setAlignment(jxl.format.Alignment.CENTRE);// 单元格中的内容水平方向居中
				hei.setBorder(jxl.format.Border.ALL, BorderLineStyle.MEDIUM);
				hei.setVerticalAlignment(VerticalAlignment.CENTRE);
				// 单元格是字符串格式！第一个是代表列数,第二是代表行数，第三个代表要写入的内容,第四个代表字体格式
				// （0代表excel的第一行或者第一列）
				
				sheet.addCell(new Label(0, 0, "订单编号", hei));
				sheet.addCell(new Label(1, 0, "旺旺名", hei));
				sheet.addCell(new Label(2, 0, "销售价格", hei));
				sheet.addCell(new Label(3, 0, "微信名", hei));
				sheet.addCell(new Label(4, 0, "订单号", hei));
				sheet.addCell(new Label(5, 0, "下单时间", hei));
				
				sheet.addCell(new Label(6, 0, "产品", hei));
				sheet.addCell(new Label(7, 0, "面料号", hei));
				sheet.addCell(new Label(8, 0, "面料米数", hei));
				sheet.addCell(new Label(9, 0, "面料金额", hei));
				sheet.addCell(new Label(10, 0, "供应商", hei));
				
				sheet.addCell(new Label(11, 0, "客户电话", hei));
				sheet.addCell(new Label(12, 0, "客户姓名", hei));
				sheet.addCell(new Label(13, 0, "客户地址", hei));
				sheet.addCell(new Label(14, 0, "渠道", hei));
				sheet.addCell(new Label(15, 0, "订单类型", hei));
				sheet.addCell(new Label(16, 0, "交付时间", hei));
				sheet.addCell(new Label(17, 0, "发货时间", hei));
				sheet.addCell(new Label(18, 0, "下单客服", hei));
				
				
				
				for(int i=0;i<proslist.size();i++){
					String ooid =proslist.get(i).get("order_id")+"";
				    sheet.addCell(new Label(0, i+1, ooid ,   bai));
					sheet.addCell(new Label(1, i+1, proslist.get(i).get("ww_name")+"", bai));
					sheet.addCell(new Label(2, i+1,  proslist.get(i).get("sale_price")+"", bai));
					sheet.addCell(new Label(3, i+1, proslist.get(i).get("wechat")+"", bai));
					sheet.addCell(new Label(4, i+1, proslist.get(i).get("order_number")+"", bai));
					sheet.addCell(new Label(5, i+1, proslist.get(i).get("add_time")+"", bai));
					
					ProjectInfo duoyu = new ProjectInfo();
					duoyu.setCondition("orderid='" + ooid + "' order by id desc limit 1");
					
					List<DataMap> listDuoyu = ServiceBean.getInstance().getProjectInfoFacade()
							.getProjectInfoDuoYu(duoyu);
					
					StringBuffer sb1= new StringBuffer("");
					StringBuffer sb2= new StringBuffer("");
					StringBuffer sb3= new StringBuffer("");
					StringBuffer sb4= new StringBuffer("");
					StringBuffer sb5= new StringBuffer("");
					if(listDuoyu.size()>0){
						if(!Utils.isEmpty(listDuoyu.get(0).get("yt1")+"")&&!"null".equals(listDuoyu.get(0).get("yt1")+"")){
							sb1.append(",");
							sb1.append(listDuoyu.get(0).get("yt1")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("yt2")+"")&&!"null".equals(listDuoyu.get(0).get("yt2")+"")){
							sb1.append(",");
							sb1.append(listDuoyu.get(0).get("yt2")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("yt3")+"")&&!"null".equals(listDuoyu.get(0).get("yt3")+"")){
							sb1.append(",");
							sb1.append(listDuoyu.get(0).get("yt3")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("yt4")+"")&&!"null".equals(listDuoyu.get(0).get("yt4")+"")){
							sb1.append(",");
							sb1.append(listDuoyu.get(0).get("yt4")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("yt5")+"")&&!"null".equals(listDuoyu.get(0).get("yt5")+"")){
							sb1.append(",");
							sb1.append(listDuoyu.get(0).get("yt5")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("yt6")+"")&&!"null".equals(listDuoyu.get(0).get("yt6")+"")){
							sb1.append(",");
							sb1.append(listDuoyu.get(0).get("yt6")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("yt7")+"")&&!"null".equals(listDuoyu.get(0).get("yt7")+"")){
							sb1.append(",");
							sb1.append(listDuoyu.get(0).get("yt7")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("yt8")+"")&&!"null".equals(listDuoyu.get(0).get("yt8")+"")){
							sb1.append(",");
							sb1.append(listDuoyu.get(0).get("yt8")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("yt9")+"")&&!"null".equals(listDuoyu.get(0).get("yt9")+"")){
							sb1.append(",");
							sb1.append(listDuoyu.get(0).get("yt9")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("yt10")+"")&&!"null".equals(listDuoyu.get(0).get("yt10")+"")){
							sb1.append(",");
							sb1.append(listDuoyu.get(0).get("yt10")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("yt11")+"")&&!"null".equals(listDuoyu.get(0).get("yt11")+"")){
							sb1.append(",");
							sb1.append(listDuoyu.get(0).get("yt11")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("yt12")+"")&&!"null".equals(listDuoyu.get(0).get("yt12")+"")){
							sb1.append(",");
							sb1.append(listDuoyu.get(0).get("yt12")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("yt13")+"")&&!"null".equals(listDuoyu.get(0).get("yt13")+"")){
							sb1.append(",");
							sb1.append(listDuoyu.get(0).get("yt13")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("yt14")+"")&&!"null".equals(listDuoyu.get(0).get("yt14")+"")){
							sb1.append(",");
							sb1.append(listDuoyu.get(0).get("yt14")+"");
						}
						
						
						
						if(!Utils.isEmpty(listDuoyu.get(0).get("ml1")+"")&&!"null".equals(listDuoyu.get(0).get("ml1")+"")){
							sb2.append(",");
							sb2.append(listDuoyu.get(0).get("ml1")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("ml2")+"")&&!"null".equals(listDuoyu.get(0).get("ml2")+"")){
							sb2.append(",");
							sb2.append(listDuoyu.get(0).get("ml2")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("ml3")+"")&&!"null".equals(listDuoyu.get(0).get("ml3")+"")){
							sb2.append(",");
							sb2.append(listDuoyu.get(0).get("ml3")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("ml4")+"")&&!"null".equals(listDuoyu.get(0).get("ml4")+"")){
							sb2.append(",");
							sb2.append(listDuoyu.get(0).get("ml4")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("ml5")+"")&&!"null".equals(listDuoyu.get(0).get("ml5")+"")){
							sb2.append(",");
							sb2.append(listDuoyu.get(0).get("ml5")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("ml6")+"")&&!"null".equals(listDuoyu.get(0).get("ml6")+"")){
							sb2.append(",");
							sb2.append(listDuoyu.get(0).get("ml6")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("ml7")+"")&&!"null".equals(listDuoyu.get(0).get("ml7")+"")){
							sb2.append(",");
							sb2.append(listDuoyu.get(0).get("ml7")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("ml8")+"")&&!"null".equals(listDuoyu.get(0).get("ml8")+"")){
							sb2.append(",");
							sb2.append(listDuoyu.get(0).get("ml8")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("ml9")+"")&&!"null".equals(listDuoyu.get(0).get("ml9")+"")){
							sb2.append(",");
							sb2.append(listDuoyu.get(0).get("ml9")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("ml10")+"")&&!"null".equals(listDuoyu.get(0).get("ml10")+"")){
							sb2.append(",");
							sb2.append(listDuoyu.get(0).get("ml10")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("ml11")+"")&&!"null".equals(listDuoyu.get(0).get("ml11")+"")){
							sb2.append(",");
							sb2.append(listDuoyu.get(0).get("ml11")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("ml12")+"")&&!"null".equals(listDuoyu.get(0).get("ml12")+"")){
							sb2.append(",");
							sb2.append(listDuoyu.get(0).get("ml12")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("ml13")+"")&&!"null".equals(listDuoyu.get(0).get("ml13")+"")){
							sb2.append(",");
							sb2.append(listDuoyu.get(0).get("ml13")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("ml14")+"")&&!"null".equals(listDuoyu.get(0).get("ml14")+"")){
							sb2.append(",");
							sb2.append(listDuoyu.get(0).get("ml14")+"");
						}
						
						
						
						if(!Utils.isEmpty(listDuoyu.get(0).get("ms1")+"")&&!"null".equals(listDuoyu.get(0).get("ms1")+"")){
							sb3.append(",");
							sb3.append(listDuoyu.get(0).get("ms1")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("ms2")+"")&&!"null".equals(listDuoyu.get(0).get("ms2")+"")){
							sb3.append(",");
							sb3.append(listDuoyu.get(0).get("ms2")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("ms3")+"")&&!"null".equals(listDuoyu.get(0).get("ms3")+"")){
							sb3.append(",");
							sb3.append(listDuoyu.get(0).get("ms3")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("ms4")+"")&&!"null".equals(listDuoyu.get(0).get("ms4")+"")){
							sb3.append(",");
							sb3.append(listDuoyu.get(0).get("ms4")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("ms5")+"")&&!"null".equals(listDuoyu.get(0).get("ms5")+"")){
							sb3.append(",");
							sb3.append(listDuoyu.get(0).get("ms5")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("ms6")+"")&&!"null".equals(listDuoyu.get(0).get("ms6")+"")){
							sb3.append(",");
							sb3.append(listDuoyu.get(0).get("ms6")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("ms7")+"")&&!"null".equals(listDuoyu.get(0).get("ms7")+"")){
							sb3.append(",");
							sb3.append(listDuoyu.get(0).get("ms7")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("ms8")+"")&&!"null".equals(listDuoyu.get(0).get("ms8")+"")){
							sb3.append(",");
							sb3.append(listDuoyu.get(0).get("ms8")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("ms9")+"")&&!"null".equals(listDuoyu.get(0).get("ms9")+"")){
							sb3.append(",");
							sb3.append(listDuoyu.get(0).get("ms9")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("ms10")+"")&&!"null".equals(listDuoyu.get(0).get("ms10")+"")){
							sb3.append(",");
							sb3.append(listDuoyu.get(0).get("ms10")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("ms11")+"")&&!"null".equals(listDuoyu.get(0).get("ms11")+"")){
							sb3.append(",");
							sb3.append(listDuoyu.get(0).get("ms11")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("ms12")+"")&&!"null".equals(listDuoyu.get(0).get("ms12")+"")){
							sb3.append(",");
							sb3.append(listDuoyu.get(0).get("ms12")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("ms13")+"")&&!"null".equals(listDuoyu.get(0).get("ms13")+"")){
							sb3.append(",");
							sb3.append(listDuoyu.get(0).get("ms13")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("ms14")+"")&&!"null".equals(listDuoyu.get(0).get("ms14")+"")){
							sb3.append(",");
							sb3.append(listDuoyu.get(0).get("ms14")+"");
						}
						
						
						
						
						
						
						
						if(!Utils.isEmpty(listDuoyu.get(0).get("jq")+"")&&!"null".equals(listDuoyu.get(0).get("jq")+"")){
							sb4.append(listDuoyu.get(0).get("jq")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("jq1")+"")&&!"null".equals(listDuoyu.get(0).get("jq1")+"")){
							sb4.append(",");
							sb4.append(listDuoyu.get(0).get("jq1")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("jq2")+"")&&!"null".equals(listDuoyu.get(0).get("jq2")+"")){
							sb4.append(",");
							sb4.append(listDuoyu.get(0).get("jq2")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("jq3")+"")&&!"null".equals(listDuoyu.get(0).get("jq3")+"")){
							sb4.append(",");
							sb4.append(listDuoyu.get(0).get("jq3")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("jq4")+"")&&!"null".equals(listDuoyu.get(0).get("jq4")+"")){
							sb4.append(",");
							sb4.append(listDuoyu.get(0).get("jq4")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("jq5")+"")&&!"null".equals(listDuoyu.get(0).get("jq5")+"")){
							sb4.append(",");
							sb4.append(listDuoyu.get(0).get("jq5")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("jq6")+"")&&!"null".equals(listDuoyu.get(0).get("jq6")+"")){
							sb4.append(",");
							sb4.append(listDuoyu.get(0).get("jq6")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("jq7")+"")&&!"null".equals(listDuoyu.get(0).get("jq7")+"")){
							sb4.append(",");
							sb4.append(listDuoyu.get(0).get("jq7")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("jq8")+"")&&!"null".equals(listDuoyu.get(0).get("jq8")+"")){
							sb4.append(",");
							sb4.append(listDuoyu.get(0).get("jq8")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("jq9")+"")&&!"null".equals(listDuoyu.get(0).get("jq9")+"")){
							sb4.append(",");
							sb4.append(listDuoyu.get(0).get("jq9")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("jq10")+"")&&!"null".equals(listDuoyu.get(0).get("jq10")+"")){
							sb4.append(",");
							sb4.append(listDuoyu.get(0).get("jq10")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("jq11")+"")&&!"null".equals(listDuoyu.get(0).get("jq11")+"")){
							sb4.append(",");
							sb4.append(listDuoyu.get(0).get("jq11")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("jq12")+"")&&!"null".equals(listDuoyu.get(0).get("jq12")+"")){
							sb4.append(",");
							sb4.append(listDuoyu.get(0).get("jq12")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("jq13")+"")&&!"null".equals(listDuoyu.get(0).get("jq13")+"")){
							sb4.append(",");
							sb4.append(listDuoyu.get(0).get("jq13")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("jq14")+"")&&!"null".equals(listDuoyu.get(0).get("jq14")+"")){
							sb4.append(",");
							sb4.append(listDuoyu.get(0).get("jq14")+"");
						}
						
						if(!Utils.isEmpty(listDuoyu.get(0).get("gys1")+"")&&!"null".equals(listDuoyu.get(0).get("gys1")+"")){
							sb5.append(",");
							sb5.append(listDuoyu.get(0).get("gys1")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("gys2")+"")&&!"null".equals(listDuoyu.get(0).get("gys2")+"")){
							sb5.append(",");
							sb5.append(listDuoyu.get(0).get("gys2")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("gys3")+"")&&!"null".equals(listDuoyu.get(0).get("gys3")+"")){
							sb5.append(",");
							sb5.append(listDuoyu.get(0).get("gys3")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("gys4")+"")&&!"null".equals(listDuoyu.get(0).get("gys4")+"")){
							sb5.append(",");
							sb5.append(listDuoyu.get(0).get("gys4")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("gys5")+"")&&!"null".equals(listDuoyu.get(0).get("gys5")+"")){
							sb5.append(",");
							sb5.append(listDuoyu.get(0).get("gys5")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("gys6")+"")&&!"null".equals(listDuoyu.get(0).get("gys6")+"")){
							sb5.append(",");
							sb5.append(listDuoyu.get(0).get("gys6")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("gys7")+"")&&!"null".equals(listDuoyu.get(0).get("gys7")+"")){
							sb5.append(",");
							sb5.append(listDuoyu.get(0).get("gys7")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("gys8")+"")&&!"null".equals(listDuoyu.get(0).get("gys8")+"")){
							sb5.append(",");
							sb5.append(listDuoyu.get(0).get("gys8")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("gys9")+"")&&!"null".equals(listDuoyu.get(0).get("gys9")+"")){
							sb5.append(",");
							sb5.append(listDuoyu.get(0).get("gys9")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("gys10")+"")&&!"null".equals(listDuoyu.get(0).get("gys10")+"")){
							sb5.append(",");
							sb5.append(listDuoyu.get(0).get("gys10")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("gys11")+"")&&!"null".equals(listDuoyu.get(0).get("gys11")+"")){
							sb5.append(",");
							sb5.append(listDuoyu.get(0).get("gys11")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("gys12")+"")&&!"null".equals(listDuoyu.get(0).get("gys12")+"")){
							sb5.append(",");
							sb5.append(listDuoyu.get(0).get("gys12")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("gys13")+"")&&!"null".equals(listDuoyu.get(0).get("gys13")+"")){
							sb5.append(",");
							sb5.append(listDuoyu.get(0).get("gys13")+"");
						}
						if(!Utils.isEmpty(listDuoyu.get(0).get("gys14")+"")&&!"null".equals(listDuoyu.get(0).get("gys14")+"")){
							sb5.append(",");
							sb5.append(listDuoyu.get(0).get("gys14")+"");
						}
					}
					
					sheet.addCell(new Label(6, i+1, proslist.get(i).get("yong_tu1")+""+sb1.toString(), bai));//yong_tu1  yt1
					sheet.addCell(new Label(7, i+1, proslist.get(i).get("miao_liao1")+""+sb2.toString(), bai));//miao_liao1  duoyu.getAt("ml1")
					sheet.addCell(new Label(8, i+1, proslist.get(i).get("mi1")+""+sb3.toString(), bai));//mi1     duoyu.ms1
					sheet.addCell(new Label(9, i+1, sb4.toString(), bai));//             duoyu.getAt("jq
					sheet.addCell(new Label(10, i+1,  proslist.get(i).get("gongyingshang_1")+""+sb5.toString(), bai));//             duoyu.getAt("jq
					
					
					
					sheet.addCell(new Label(11, i+1, proslist.get(i).get("kehu_phone")+"", bai));
					sheet.addCell(new Label(12, i+1, proslist.get(i).get("kehu_name")+"", bai));
					sheet.addCell(new Label(13, i+1, proslist.get(i).get("address")+"", bai));
					sheet.addCell(new Label(14, i+1, proslist.get(i).get("qudao")+"", bai));
					sheet.addCell(new Label(15, i+1, proslist.get(i).get("order_type")+"", bai));
					sheet.addCell(new Label(16, i+1, proslist.get(i).get("jiaofu_time")+"", bai));
					
					FeedBackInfo voo =new FeedBackInfo();
					voo.setCondition("user_id='"+ooid+"'  order by id desc limit 1");
					List<DataMap> listocc  = ServiceBean.getInstance().getFeedBackInfoFacade().getFeedBackInfo(voo);
					
					
					if(listocc.size()>0){
						sheet.addCell(new Label(17, i+1, listocc.get(0).get("date_time")+"", bai));
					}else{
						sheet.addCell(new Label(17, i+1, "", bai));
					}
					sheet.addCell(new Label(18, i+1, proslist.get(i).get("xiadan_kefu")+"", bai));
				
				
					sheet.setRowView(i+1, 250, false);
				}
				sheet.setColumnView(0, 15);
				sheet.setColumnView(1, 15);
				sheet.setColumnView(2, 15);
				sheet.setColumnView(3, 15);
				sheet.setColumnView(4, 15);
				sheet.setColumnView(5, 15);
				sheet.setColumnView(6, 15);
				sheet.setColumnView(7, 15);
				sheet.setColumnView(8, 15);
				sheet.setColumnView(9, 15);
				sheet.setColumnView(10, 15);
				sheet.setColumnView(11, 15);
				sheet.setColumnView(12, 15);
				sheet.setColumnView(13, 15);
				sheet.setColumnView(14, 15);
				sheet.setColumnView(15, 15);
				sheet.setColumnView(16, 15);
				sheet.setColumnView(17, 15);
				sheet.setColumnView(18, 15);
				sheet.setColumnView(19, 15);
			
				
				sheet.setRowView(0, 300, false);
				workbook.write();
				workbook.close();
	
			
	
	
				
					
					 // path是指欲下载的文件的路径。
				      File file = new File(path);
				      
				      if (file.exists()) {
				    	  System.err.println("文件存在");
				    	   // 取得文件名。
					      String filename = file.getName();
					      // 取得文件的后缀名。
					      //String ext = filename.substring(filename.lastIndexOf(".") + 1).toUpperCase();
					 
					      // 以流的形式下载文件。
					      InputStream fis = new BufferedInputStream(new FileInputStream(path));
					      byte[] buffer = new byte[fis.available()];
					      fis.read(buffer);
					      fis.close();
					      // 清空response
					      response.reset();
					      // 设置response的Header
					      response.addHeader("Content-Disposition", "attachment;filename=" + new String(filename.getBytes()));
					      response.addHeader("Content-Length", "" + file.length());
					      OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
					      response.setContentType("application/octet-stream");
					      toClient.write(buffer);
					      toClient.flush();
					      toClient.close();
						}
			}
			
			BeanUtils.copyProperties(pys, form);
			pys.setCounts(list.getTotalSize());

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(request.getQueryString() + "  " + e);
			result.setBackPage(Config.ABOUT_PAGE); /*
													 * ����Ϊ����ҳ�棬���Գ������ת��ϵ
													 * ͳĬ��ҳ��
													 */
			if (e instanceof SystemException) { /* ����֪�쳣���н��� */
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else { /* ��δ֪�쳣���н�������ȫ�������δ֪�쳣 */
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
			request.setAttribute("pageList", list);
			request.setAttribute("PagePys", pys);
		}
		// CommUtils.getIntervalTime(start, new Date(), href);
		return mapping.findForward("queryProjectInfoxml");
	}

	public ActionForward initInsertxml(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Result result = new Result();// ���
	
		
		LoginUser loginUser = (LoginUser)request.getSession().getAttribute(Config.SystemConfig.LOGINUSER);
		if (loginUser == null) {
	           result.setBackPage(Config.INDEX_PAGE);
	           result.setResultCode("timeout");
	           result.setResultType("fail");
	           request.setAttribute("result", null);
	           return mapping.findForward("result");
		}
		

		String userName = loginUser.getUserName();
		
		request.setAttribute("userName", userName);
		
		/* SimpleDateFormat df = new SimpleDateFormat("yyMMdd");
		 SimpleDateFormat yydf = new SimpleDateFormat("yyyyMMdd");*/
		
	   
	     
	  	String orderId ="";// 订单编号
		
		UserInfo uvo =new UserInfo();
		uvo.setCondition("userCode = '"+userName+"' limit 1");
		List<DataMap> listUo =  ServiceBean.getInstance().getUserInfoFacade().getUserInfo(uvo);
		
	     ProjectInfo voCount = new ProjectInfo();
	     voCount.setCondition("add_time>= '"+Utils.getnewTimeyydf()+"' and xiadan_kefu = '"+userName+"'");
	    int shuliang =   ServiceBean.getInstance()
				.getProjectInfoFacade().getProjectInfoCount(voCount)+1;
	    String compnay = listUo.get(0).get("company")+"";
	    if(compnay == null || "".equals(compnay) ){
	    	compnay="1";
	    }
	   String id =  listUo.get(0).get("id")+"";
	    if(id.length()==4){
	    	id="0"+id;
	    }else if(id.length()==3){
	    	id="00"+id;
	    }else if(id.length()==2){
	    	id="000"+id;
	    }else if(id.length()==1){
	    	id="0000"+id;
	    }
	    	if(shuliang<10){
	    		 orderId = compnay+ Utils.getnewTimedf() +id+"0"+shuliang;
	    	}else{
	    		orderId = compnay+ Utils.getnewTimedf() +id+shuliang;
	    	}
	    	request.setAttribute("ding_dan", orderId);
	    	
	    	request.setAttribute("sj_new", Utils.getnewTime());
	    	
	    	/*StringBuffer sf = new StringBuffer();
			sf.append("<select name='jiaofu_time' id='jiaofu_time'>\n");
			
				sf.append("\t\t\t<option value='10'>"+ "+10天    " +CommTools.getAddTime(10)+ "</option>\n");
				sf.append("\t\t\t<option value='5'>"+ "+5天  特别加急  " +CommTools.getAddTime(5)+ "</option>\n");
				sf.append("\t\t\t<option value='3'>"+ "+3天   非常紧急  " +CommTools.getAddTime(3)+ "</option>\n");
			
			sf.append("\t\t\t</select>");
				request.setAttribute("jiaofu", sf.toString());*/
			
			return mapping.findForward("addProjectInfoxml");
		/*} else 
			return mapping.findForward("addProjectInfoxmlOther");
		}*/
	}

	public ActionForward insertProjectInfoxml(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {

		String companyId = request.getParameter("companyId");
		// String channelId = request.getParameter("channelId");
		Result result = new Result();
		String name = "";
		String fileFormat = "";
		try {
			LoginUser loginUser = (LoginUser) request.getSession()
					.getAttribute(Config.SystemConfig.LOGINUSER);
			if (loginUser == null) {
				return null;
			}
			ProjectInfoForm form = (ProjectInfoForm) actionForm;
			System.out.println(form.getChannelId());
			Hashtable<?, ?> files = form.getMultipartRequestHandler()
					.getFileElements();// 获取所有文件路径的枚举；
			if (files != null & files.size() > 0) {
				Enumeration<?> enums = files.keys();
				String fileKey = null;
				while (enums.hasMoreElements()) {
					fileKey = (String) (enums.nextElement());
					FormFile file = (FormFile) files.get(fileKey);
					if (!file.getFileName().isEmpty()) {
						fileFormat = file.toString().substring(
								file.toString().lastIndexOf("."),
								file.toString().length());
						name = Long.toString(new Date().getTime()) + fileFormat;
						// CommUtils.createDateFile(dir); //创建当前文件夹，存在则返回文件名；
						InputStream in = file.getInputStream();
						// photoPath = photoPath + name; //输出文件路径
						System.out.println(photoPath + name);
						File f = new File(photoPath + name);
						if (f.exists()) {
							f.delete();
						}

						OutputStream out = new FileOutputStream(photoPath
								+ name);
						out.write(file.getFileData(), 0, file.getFileSize());

						out.close();
						out = null;
						in.close();
					}

				}

			}

			StringBuffer sb = new StringBuffer();
			String userName = loginUser.getUserName();
			// ProjectInfoForm form = (ProjectInfoForm) actionForm;
			ProjectInfoFacade facade = ServiceBean.getInstance()
					.getProjectInfoFacade();
			ProjectInfo vo = new ProjectInfo();
			int num = ServiceBean.getInstance().getProjectInfoFacade()
					.getProjectInfoCount(vo) + 1;
			BeanUtils.copyProperties(vo, form);
			// vo.setId(num);
			String proNo = form.getProjectNo();
			System.out.println(proNo);
			vo.setProjectNo(proNo);
			vo.setCompanyId(companyId);
			vo.setChannelId(photoUrl + name);
			if ("".equals(name) || name == "" || name == null) {
				vo.setChannelId("");
			}
			vo.setProjectName(form.getProjectName());
			vo.setAddTime(new Date());
			vo.setHeartS(proNo);
			vo.setAdTitle(form.getAdTitle());
			vo.setAdDetail(form.getAdDetail());
			facade.insertProjectInfo(vo);

			List<DataMap> getProjectInfo = ServiceBean.getInstance()
					.getProjectInfoFacade().getProjectInfo(vo);
			if (getProjectInfo.size() > 0) {
				sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
				sb.append("<ads>");

				for (int i = 0; i < getProjectInfo.size(); i++) {
					sb.append("<advertising>");
					sb.append("<customerName>");
					sb.append(getProjectInfo.get(i).get("project_no") + "");
					sb.append("</customerName>");
					sb.append("<advertisingUrl>");
					sb.append(getProjectInfo.get(i).get("project_name") + "");
					sb.append("</advertisingUrl>");
					sb.append("<iconUrl>");
					sb.append(getProjectInfo.get(i).get("channel_id") + "");
					sb.append("</iconUrl>");
					sb.append("<lanugage>");
					sb.append(getProjectInfo.get(i).get("company_id") + "");
					sb.append("</lanugage>");
					sb.append("<adTitle>");
					sb.append(getProjectInfo.get(i).get("adTitle") + "");
					sb.append("</adTitle>");
					sb.append("<adDetail>");
					sb.append(getProjectInfo.get(i).get("adDetail") + "");
					sb.append("</adDetail>");
					sb.append("</advertising>");
				}

				sb.append("</ads>");

			}
			Constant.deleteFile(xmlpath + xmlfileName);
			Constant.createFileContent(xmlpath, xmlfileName, sb.toString()
					.getBytes("UTF-8"));

			result.setBackPage(HttpTools.httpServletPath(request, // ����ɹ�����ת��ԭ��ҳ��
					"queryProjectInfoXml"));
			result.setResultCode("inserts"); // ���ò���Code
			result.setResultType("success"); // ���ò���ɹ�
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"initInsertxml"));
			if (e instanceof SystemException) { /* ����֪�쳣���н��� */
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else { /* ��δ֪�쳣���н�������ȫ�������δ֪�쳣 */
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}

	public ActionForward insertProjectInfoxmlOther(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {

		String companyId = request.getParameter("companyId");
		String channelId = request.getParameter("channelId");
		System.out.println(channelId);
		Result result = new Result();
		try {
			LoginUser loginUser = (LoginUser) request.getSession()
					.getAttribute(Config.SystemConfig.LOGINUSER);
			if (loginUser == null) {
				return null;
			}

			StringBuffer sb = new StringBuffer();
			String userName = loginUser.getUserName();
			ProjectInfoForm form = (ProjectInfoForm) actionForm;
			String name = "";
			String fileFormat = "";
			Hashtable<?, ?> files = form.getMultipartRequestHandler()
					.getFileElements();// 获取所有文件路径的枚举；
			if (files != null & files.size() > 0) {
				Enumeration<?> enums = files.keys();
				String fileKey = null;
				while (enums.hasMoreElements()) {
					fileKey = (String) (enums.nextElement());
					FormFile file = (FormFile) files.get(fileKey);
					if (!file.getFileName().isEmpty()) {
						fileFormat = file.toString().substring(
								file.toString().lastIndexOf("."),
								file.toString().length());
						name = Long.toString(new Date().getTime()) + fileFormat;
						// CommUtils.createDateFile(dir); //创建当前文件夹，存在则返回文件名；
						InputStream in = file.getInputStream();
						// photoPath = photoPath + name; //输出文件路径
						System.out.println(photoPath + name);
						File f = new File(photoPath + name);
						if (f.exists()) {
							f.delete();
						}

						OutputStream out = new FileOutputStream(photoPath
								+ name);
						out.write(file.getFileData(), 0, file.getFileSize());

						out.close();
						out = null;
						in.close();
					}

				}

			}

			ProjectInfoFacade facade = ServiceBean.getInstance()
					.getProjectInfoFacade();
			ProjectInfo vo = new ProjectInfo();
			int num = ServiceBean.getInstance().getProjectInfoFacade()
					.getProjectInfoCount(vo) + 1;
			BeanUtils.copyProperties(vo, form);
			// vo.setId(num);
			vo.setProjectNo(userName);
			vo.setCompanyId(companyId);
			vo.setChannelId(photoUrl + name);
			if ("".equals(name) || name == "" || name == null) {
				vo.setChannelId("");
			}
			vo.setProjectName(form.getProjectName());
			vo.setAddTime(new Date());
			vo.setHeartS(userName);
			vo.setAdTitle(form.getAdTitle());
			vo.setAdDetail(form.getAdDetail());
			facade.insertProjectInfo(vo);

			List<DataMap> getProjectInfo = ServiceBean.getInstance()
					.getProjectInfoFacade().getProjectInfo(vo);
			if (getProjectInfo.size() > 0) {
				sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
				sb.append("<ads>");
				for (int i = 0; i < getProjectInfo.size(); i++) {
					sb.append("<advertising>");
					sb.append("<customerName>");
					sb.append(getProjectInfo.get(i).get("project_no") + "");
					sb.append("</customerName>");
					sb.append("<advertisingUrl>");
					sb.append(getProjectInfo.get(i).get("project_name") + "");
					sb.append("</advertisingUrl>");
					sb.append("<iconUrl>");
					sb.append(getProjectInfo.get(i).get("channel_id") + "");
					sb.append("</iconUrl>");
					sb.append("<lanugage>");
					sb.append(getProjectInfo.get(i).get("company_id") + "");
					sb.append("</lanugage>");
					sb.append("<adTitle>");
					sb.append(getProjectInfo.get(i).get("adTitle") + "");
					sb.append("</adTitle>");
					sb.append("<adDetail>");
					sb.append(getProjectInfo.get(i).get("adDetail") + "");
					sb.append("</adDetail>");
					sb.append("</advertising>");
				}
				sb.append("</ads>");
			}
			Constant.deleteFile(xmlpath + xmlfileName);
			Constant.createFileContent(xmlpath, xmlfileName, sb.toString()
					.getBytes("UTF-8"));

			result.setBackPage(HttpTools.httpServletPath(request, // ����ɹ�����ת��ԭ��ҳ��
					"queryProjectInfoXml"));
			result.setResultCode("inserts"); // ���ò���Code
			result.setResultType("success"); // ���ò���ɹ�
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"initInsertxml"));
			if (e instanceof SystemException) { /* ����֪�쳣���н��� */
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else { /* ��δ֪�쳣���н�������ȫ�������δ֪�쳣 */
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}

	public ActionForward initUpdatexml(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		LoginUser loginUser = (LoginUser) request.getSession().getAttribute(
				Config.SystemConfig.LOGINUSER);
		if (loginUser == null) {
			return null;
		}

		String userName = loginUser.getUserName();
		request.setAttribute("role","admin");
		UserInfo uvo =new UserInfo();
		uvo.setCondition("userCode = '"+userName+"' limit 1");
		List<DataMap> listUo =  ServiceBean.getInstance().getUserInfoFacade().getUserInfo(uvo);
		if(listUo.size()>0){
			String role = listUo.get(0).get("code")+"";
			request.setAttribute("role",role);
		}

		
		
		
		String id = request.getParameter("id");
		ProjectInfo vo = new ProjectInfo();
		vo.setCondition("id='" + id + "'");
		List<DataMap> list = ServiceBean.getInstance().getProjectInfoFacade()
				.getProjectInfo(vo);
		if (list == null || list.size() == 0) {
			Result result = new Result();
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryProjectInfoXml"));
			result.setResultCode("rowDel");
			result.setResultType("success");
			return mapping.findForward("result");
		}
		
		
		
		request.setAttribute("projectInfo", list.get(0));
		
		String orderNumberOne = list.get(0).get("order_number")+"";
	
		request.setAttribute("orderNumberOne", orderNumberOne);
		if(orderNumberOne.contains(",")){
			request.setAttribute("orderNumberOne", orderNumberOne.split(",")[0]);
		}
		
		String sale_price = list.get(0).get("sale_price")+"";
		request.setAttribute("sale_price", sale_price);
		if(sale_price.contains(",")){
			request.setAttribute("sale_price", sale_price.split(",")[0]);
		}
	
		
		ProjectInfo voo = new ProjectInfo();
		List<DataMap> Clist = ServiceBean.getInstance().getProjectInfoFacade()
				.getProjectWatchInfo(voo);
		String sb = CommUtils.getPrintSelect(Clist, "project_no11",
				"project_no", "project_no", list.get(0).get("gongyingshang_1")+"", 1);
		request.setAttribute("companyList", sb);

		String sb1 = CommUtils.getPrintSelect(Clist, "project_no2",
				"project_no", "project_no", list.get(0).get("gongyingshang_2")+"", 1);

		request.setAttribute("companyList1", sb1);
		
		String orderId=  list.get(0).get("order_id")+"";
		
		ProjectInfo duoyu = new ProjectInfo();
		duoyu.setCondition("orderid='" + orderId + "' order by id desc limit 1");
		
		request.setAttribute("fuwei_quea", "");
		request.setAttribute("fuwei_queb", "");
		
		List<DataMap> listDuoyu = ServiceBean.getInstance().getProjectInfoFacade()
				.getProjectInfoDuoYu(duoyu);
		if(listDuoyu.size()>0){
			/*request.setAttribute("fuwei_quea", listDuoyu.get(0).get("fuwei_quea")+"");
			request.setAttribute("fuwei_queb", listDuoyu.get(0).get("fuwei_queb")+"");*/
			
			request.setAttribute("duoyu", listDuoyu.get(0));
			
			String gysall = CommUtils.getPrintSelectAll(Clist, "gys1","project_no", "project_no", listDuoyu.get(0).get("gys1")+"", 1);
			request.setAttribute("gysall", gysall);
			System.err.println(gysall);
			
			String gys1 = CommUtils.getPrintSelectGys(Clist, "gys1","project_no", "project_no", listDuoyu.get(0).get("gys1")+"", 1);
			request.setAttribute("gys1", gys1);
			
			String gys2 = CommUtils.getPrintSelectGys(Clist, "gys2","project_no", "project_no", listDuoyu.get(0).get("gys2")+"", 1);
			request.setAttribute("gys2", gys2);
			
			String gys3 = CommUtils.getPrintSelectGys(Clist, "gys3","project_no", "project_no", listDuoyu.get(0).get("gys3")+"", 1);
			request.setAttribute("gys3", gys3);
			
			String gys4 = CommUtils.getPrintSelectGys(Clist, "gys4","project_no", "project_no", listDuoyu.get(0).get("gys4")+"", 1);
			request.setAttribute("gys4", gys4);
			
			String gys5 = CommUtils.getPrintSelectGys(Clist, "gys5","project_no", "project_no", listDuoyu.get(0).get("gys5")+"", 1);
			request.setAttribute("gys5", gys5);
			
			String gys6 = CommUtils.getPrintSelectGys(Clist, "gys6","project_no", "project_no", listDuoyu.get(0).get("gys6")+"", 1);
			request.setAttribute("gys6", gys6);
			
			String gys7 = CommUtils.getPrintSelectGys(Clist, "gys7","project_no", "project_no", listDuoyu.get(0).get("gys7")+"", 1);
			request.setAttribute("gys7", gys7);
			
			String gys8 = CommUtils.getPrintSelectGys(Clist, "gys8","project_no", "project_no", listDuoyu.get(0).get("gys8")+"", 1);
			request.setAttribute("gys8", gys8);
			
			String gys9 = CommUtils.getPrintSelectGys(Clist, "gys9","project_no", "project_no", listDuoyu.get(0).get("gys9")+"", 1);
			request.setAttribute("gys9", gys9);
			
			String gys10 = CommUtils.getPrintSelectGys(Clist, "gys10","project_no", "project_no", listDuoyu.get(0).get("gys10")+"", 1);
			request.setAttribute("gys10", gys10);
			
			String gys11 = CommUtils.getPrintSelectGys(Clist, "gys11","project_no", "project_no", listDuoyu.get(0).get("gys11")+"", 1);
			request.setAttribute("gys11", gys11);
			
			String gys12 = CommUtils.getPrintSelectGys(Clist, "gys12","project_no", "project_no", listDuoyu.get(0).get("gys12")+"", 1);
			request.setAttribute("gys12", gys12);
			
			String gys13 = CommUtils.getPrintSelectGys(Clist, "gys13","project_no", "project_no", listDuoyu.get(0).get("gys13")+"", 1);
			request.setAttribute("gys13", gys13);
			
			String gys14 = CommUtils.getPrintSelectGys(Clist, "gys14","project_no", "project_no", listDuoyu.get(0).get("gys14")+"", 1);
			request.setAttribute("gys14", gys14);
		}
		
		ShareInfo vso = new ShareInfo(); 
		vso.setCondition("order_id='"+orderId+"' order by id desc limit 1");
		List<DataMap> listorderall = ServiceBean.getInstance().getShareInfoFacade().getShareInfo(vso);
		if(listorderall.size()>0){
			request.setAttribute("orderall", listorderall.get(0));
		}
		
		
	/*	StringBuffer sf = new StringBuffer();
		sf.append("<select name='jiaofu_time' id='jiaofu_time'>\n");
		
			sf.append("\t\t\t<option value='10'>"+ "+10天  加急  " +CommTools.getAddTime(10)+ "</option>\n");
			sf.append("\t\t\t<option value='5'>"+ "+5天  特别加急  " +CommTools.getAddTime(5)+ "</option>\n");
			sf.append("\t\t\t<option value='3'>"+ "+3天   非常紧急  " +CommTools.getAddTime(3)+ "</option>\n");
		
		sf.append("\t\t\t</select>");
			request.setAttribute("jiaofu", sf.toString());*/
			
			
			
			return mapping.findForward("updateProjectInfoxml");
		/*	if ("admin".equals(userName)) {
		} else {
			return mapping.findForward("updateProjectInfoxmlOther");
		}*/
	}

	public ActionForward updateProjectInfoxml(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {

		Result result = new Result();
		try {
			String id = request.getParameter("id");
			String project_no = request.getParameter("project_no");
			String project_name = request.getParameter("project_name");
			String channel_id = request.getParameter("channel_id");
			String company_id = request.getParameter("company_id");
			String adTitle = request.getParameter("adTitle");
			String adDetail = request.getParameter("adDetail");

			// ProjectInfoForm form = (ProjectInfoForm) actionForm;

			ProjectInfoForm form = (ProjectInfoForm) actionForm;
			String name = "";
			String fileFormat = "";
			Hashtable<?, ?> files = form.getMultipartRequestHandler()
					.getFileElements();// 获取所有文件路径的枚举；
			if (files != null & files.size() > 0) {
				Enumeration<?> enums = files.keys();
				String fileKey = null;
				while (enums.hasMoreElements()) {
					fileKey = (String) (enums.nextElement());
					FormFile file = (FormFile) files.get(fileKey);
					if (!file.getFileName().isEmpty()) {
						fileFormat = file.toString().substring(
								file.toString().lastIndexOf("."),
								file.toString().length());
						name = Long.toString(new Date().getTime()) + fileFormat;
						// CommUtils.createDateFile(dir); //创建当前文件夹，存在则返回文件名；
						InputStream in = file.getInputStream();
						// photoPath = photoPath + name; //输出文件路径
						System.out.println(photoPath + name);
						File f = new File(photoPath + name);
						if (f.exists()) {
							f.delete();
						}

						OutputStream out = new FileOutputStream(photoPath
								+ name);
						out.write(file.getFileData(), 0, file.getFileSize());

						out.close();
						out = null;
						in.close();
					}

				}

			}

			ProjectInfo vo = new ProjectInfo();
			vo.setCondition("id='" + id + "'");
			vo.setProjectName(project_name);
			vo.setProjectNo(project_no);
			vo.setChannelId(photoUrl + name);
			if ("".equals(name) || name == "" || name == null) {
				vo.setChannelId("");
			}
			vo.setCompanyId(company_id);
			vo.setAdDetail(adDetail);
			vo.setAdTitle(adTitle);
			// BeanUtils.copyProperties(vo, form);
			/*ServiceBean.getInstance().getProjectInfoFacade()
					.updatePorjectInfo(vo);*/
			StringBuffer sb = new StringBuffer();
			ProjectInfo voo = new ProjectInfo();
			List<DataMap> getProjectInfo = ServiceBean.getInstance()
					.getProjectInfoFacade().getProjectInfo(voo);
			if (getProjectInfo.size() > 0) {
				sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
				sb.append("<ads>");
				for (int i = 0; i < getProjectInfo.size(); i++) {
					sb.append("<advertising>");
					sb.append("<customerName>");
					sb.append(getProjectInfo.get(i).get("project_no") + "");
					sb.append("</customerName>");
					sb.append("<advertisingUrl>");
					sb.append(getProjectInfo.get(i).get("project_name") + "");
					sb.append("</advertisingUrl>");
					sb.append("<iconUrl>");
					sb.append(getProjectInfo.get(i).get("channel_id") + "");
					sb.append("</iconUrl>");
					sb.append("<lanugage>");
					sb.append(getProjectInfo.get(i).get("company_id") + "");
					sb.append("</lanugage>");
					sb.append("<adTitle>");
					sb.append(getProjectInfo.get(i).get("adTitle") + "");
					sb.append("</adTitle>");
					sb.append("<adDetail>");
					sb.append(getProjectInfo.get(i).get("adDetail") + "");
					sb.append("</adDetail>");
					sb.append("</advertising>");
				}
				sb.append("</ads>");
			}
			Constant.deleteFile(xmlpath + xmlfileName);
			Constant.createFileContent(xmlpath, xmlfileName, sb.toString()
					.getBytes("UTF-8"));

			result.setBackPage(HttpTools.httpServletPath(request,
					"queryProjectInfoXml"));
			result.setResultCode("updates");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryProjectInfoXml"));
			if (e instanceof SystemException) { /* ����֪�쳣���н��� */
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else { /* ��δ֪�쳣���н�������ȫ�������δ֪�쳣 */
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}

	public ActionForward updateProjectInfoxmlOther(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {

		Result result = new Result();
		try {
			String id = request.getParameter("id");
			// String project_no = request.getParameter("project_no");
			String project_name = request.getParameter("project_name");
			String channel_id = request.getParameter("channel_id");
			String company_id = request.getParameter("company_id");
			String adTitle = request.getParameter("adTitle");
			String adDetail = request.getParameter("adDetail");

			// ProjectInfoForm form = (ProjectInfoForm) actionForm;

			ProjectInfoForm form = (ProjectInfoForm) actionForm;
			String name = "";
			String fileFormat = "";
			Hashtable<?, ?> files = form.getMultipartRequestHandler()
					.getFileElements();// 获取所有文件路径的枚举；
			if (files != null & files.size() > 0) {
				Enumeration<?> enums = files.keys();
				String fileKey = null;
				while (enums.hasMoreElements()) {
					fileKey = (String) (enums.nextElement());
					FormFile file = (FormFile) files.get(fileKey);
					if (!file.getFileName().isEmpty()) {
						fileFormat = file.toString().substring(
								file.toString().lastIndexOf("."),
								file.toString().length());
						name = Long.toString(new Date().getTime()) + fileFormat;
						// CommUtils.createDateFile(dir); //创建当前文件夹，存在则返回文件名；
						InputStream in = file.getInputStream();
						// photoPath = photoPath + name; //输出文件路径
						System.out.println(photoPath + name);
						File f = new File(photoPath + name);
						if (f.exists()) {
							f.delete();
						}

						OutputStream out = new FileOutputStream(photoPath
								+ name);
						out.write(file.getFileData(), 0, file.getFileSize());

						out.close();
						out = null;
						in.close();
					}

				}

			}

			ProjectInfo vo = new ProjectInfo();
			vo.setCondition("id='" + id + "'");
			vo.setProjectName(project_name);
			// vo.setProjectNo(project_no);
			vo.setChannelId(photoUrl + name);
			if ("".equals(name) || name == "" || name == null) {
				vo.setChannelId("");
			}
			vo.setCompanyId(company_id);
			vo.setAdDetail(adDetail);
			vo.setAdTitle(adTitle);
			// BeanUtils.copyProperties(vo, form);
		/*	ServiceBean.getInstance().getProjectInfoFacade()
					.updatePorjectInfo(vo);*/
			StringBuffer sb = new StringBuffer();
			ProjectInfo voo = new ProjectInfo();
			List<DataMap> getProjectInfo = ServiceBean.getInstance()
					.getProjectInfoFacade().getProjectInfo(voo);
			if (getProjectInfo.size() > 0) {
				sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
				sb.append("<ads>");
				for (int i = 0; i < getProjectInfo.size(); i++) {
					sb.append("<advertising>");
					sb.append("<customerName>");
					sb.append(getProjectInfo.get(i).get("project_no") + "");
					sb.append("</customerName>");
					sb.append("<advertisingUrl>");
					sb.append(getProjectInfo.get(i).get("project_name") + "");
					sb.append("</advertisingUrl>");
					sb.append("<iconUrl>");
					sb.append(getProjectInfo.get(i).get("channel_id") + "");
					sb.append("</iconUrl>");
					sb.append("<lanugage>");
					sb.append(getProjectInfo.get(i).get("company_id") + "");
					sb.append("</lanugage>");
					sb.append("<adTitle>");
					sb.append(getProjectInfo.get(i).get("adTitle") + "");
					sb.append("</adTitle>");
					sb.append("<adDetail>");
					sb.append(getProjectInfo.get(i).get("adDetail") + "");
					sb.append("</adDetail>");
					sb.append("</advertising>");
				}
				sb.append("</ads>");
			}
			Constant.deleteFile(xmlpath + xmlfileName);
			Constant.createFileContent(xmlpath, xmlfileName, sb.toString()
					.getBytes("UTF-8"));

			result.setBackPage(HttpTools.httpServletPath(request,
					"queryProjectInfoXml"));
			result.setResultCode("updates");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryProjectInfoXml"));
			if (e instanceof SystemException) { /* ����֪�쳣���н��� */
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else { /* ��δ֪�쳣���н�������ȫ�������δ֪�쳣 */
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}

	public ActionForward deletexml(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {

		Result result = new Result();
		try {
			ProjectInfoForm form = (ProjectInfoForm) actionForm;

			ProjectInfo vo = new ProjectInfo();
			vo.setCondition("id='" + form.getId() + "'");
			BeanUtils.copyProperties(vo, form);
			ServiceBean.getInstance().getProjectInfoFacade()
					.deletePorjectInfoxml(vo);

			result.setBackPage(HttpTools.httpServletPath(request,
					"queryProjectInfoXml"));
			result.setResultCode("deletes");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryProjectInfoXml"));
			if (e instanceof SystemException) { /* ����֪�쳣���н��� */
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else { /* ��δ֪�쳣���н�������ȫ�������δ֪�쳣 */
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}

	/*-----------------------表盘---------------------------------------------------------------------------------*/

	public ActionForward queryWatchInfo(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String href = request.getServletPath();
		Date start = new Date();
		Result result = new Result();// ���
		
		LoginUser loginUser = (LoginUser)request.getSession().getAttribute(Config.SystemConfig.LOGINUSER);
		if (loginUser == null) {
	            result.setBackPage(Config.INDEX_PAGE);
	           result.setResultCode("timeout");
	           result.setResultType("fail");
	           request.setAttribute("result", null);
	           return mapping.findForward("result");
		}
		
		PagePys pys = new PagePys();// ҳ������
		DataList list = null; // ����ҳ��List ��logic itrate��ȡ��
		StringBuffer sb = new StringBuffer();// �����ַ�����
		ProjectInfoFacade info = ServiceBean.getInstance()
				.getProjectInfoFacade();// ����userApp������ȡ��user�ֵ䣩
		ProjectInfo pro = new ProjectInfo();
	

		String userName = loginUser.getUserName();

		try {

			String companyInfoId = loginUser.getCompanyId();
			String projectInfoId = loginUser.getProjectId();
			ProjectInfoForm form = (ProjectInfoForm) actionForm;
			ProjectInfo vo = new ProjectInfo();
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");
			String companyId = request.getParameter("companyId");
			String userId = request.getParameter("userId");
			String projectId = request.getParameter("projectId");

			String projectNo = request.getParameter("project_no");
			String project_name = request.getParameter("project_name");

			/* ���û������ֶ� */
			form.setOrderBy("p.add_time");
			form.setSort("1");
			// sb.append("1=1");
			if (!"admin".equals(userName)) {
				UserInfo voa = new UserInfo();
				voa.setCondition("userCode ='" + userName + "'");
				List<DataMap> listt = ServiceBean.getInstance()
						.getUserInfoFacade().getUserInfo(voa);
				if (listt.size() > 0) {
					String companys = listt.get(0).getAt("company_id") + "";
					if (!"0".equals(companys)) {
						String[] strArray = companys.split(",");
						if (strArray.length > 0) {
							sb.append("(");
							for (int i = 0; i < strArray.length; i++) {
								if (strArray[i] != projectNo) {
									if (strArray[i] != null
											&& !"".equals(strArray[i])) {
										if (sb.length() > 1) {
											sb.append(" or ");
										}
										sb.append("   p.project_no='"
												+ strArray[i] + "'");
									}
								}
							}
							sb.append(" ) ");
						} else {
							if (sb.length() > 0) {
								sb.append(" or ");
							}
							sb.append("   p.project_no='" + userName + "'");
						}
					} else {
						if (sb.length() > 0) {
							sb.append(" and ");
						}
						sb.append("   p.project_no='" + userName + "'");
					}
				}

			}

			if (projectNo != null && !"".equals(projectNo)) {
				if (sb.length() <= 0) {
					sb.append(" p.project_no like '%" + projectNo + "%'");
				} else {
					sb.append(" and p.project_no like '%" + projectNo + "%'");
				}
			}
			if (project_name != null && !"".equals(project_name)) {
				if (sb.length() <= 0) {
					sb.append("p.project_name like '%" + project_name + "%'");
				} else {
					sb.append(" and p.project_name  like '%" + project_name + "%'");
				}
			}

			if (!projectInfoId.equals("0")) {
				sb.append(" and p.id in(" + projectInfoId + ")");
			} else {
				if (!"0".equals(companyId) && companyId != null) {
					sb.append(" and p.company_id in(" + companyInfoId + ")");
				}
			}
			if (startTime != null && !"".equals(startTime)) {
				sb.append(" and substring(p.add_time,1,10) >= '" + startTime
						+ "'");
			}
			if (endTime != null && !"".equals(endTime)) {
				sb.append(" and substring(p.add_time,1,10) <= '" + endTime
						+ "'");
			}
			if (companyId != null && !"".equals(companyId)) {
				sb.append(" and p.company_id='" + companyId + "'");
			}
			if (projectId != null && !"".equals(projectId)) {
				sb.append(" and p.id ='" + projectId + "'");
			}
			if (userId != null && !"".equals(userId)) {
				sb.append(" and p.company_id='" + userId + "'");
				pro.setCondition("company_id = '" + userId + "'");
			}
			List<DataMap> pros = ServiceBean.getInstance()
					.getProjectInfoFacade().getProjectInfo(pro);
			request.setAttribute("project", pros);

			CompanyInfo ci = new CompanyInfo();
			List<DataMap> coms = ServiceBean.getInstance()
					.getCompanyInfoFacade().getCompanyInfo(ci);
			request.setAttribute("company", coms);

			request.setAttribute("project_no", projectNo);
			request.setAttribute("project_name", project_name);

			request.setAttribute("fNow_date", startTime);
			request.setAttribute("now_date", endTime);
			request.setAttribute("companyId", companyId);
			request.setAttribute("userId", userId);
			request.setAttribute("projectId", projectId);

			if (!"admin".equals(userName)) {
				if (sb.length() <= 0) {
					sb.append("p.status='" + 1 + "'");
				} else {
					sb.append(" and p.status='" + 1 + "'");
				}
			}

			vo.setCondition(sb.toString());

			BeanUtils.copyProperties(vo, form);
			list = info.getWatchInfoListByVo(vo);
			BeanUtils.copyProperties(pys, form);
			pys.setCounts(list.getTotalSize());

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(request.getQueryString() + "  " + e);
			result.setBackPage(Config.ABOUT_PAGE);
			if (e instanceof SystemException) {
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else {
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
			request.setAttribute("pageList", list);
			request.setAttribute("PagePys", pys);
		}
		CommUtils.getIntervalTime(start, new Date(), href);
		if ("admin".equals(userName)) {
			return mapping.findForward("queryWatchInfoAdmin");
		}
		return mapping.findForward("queryWatchInfo");
	}

	public ActionForward initInsertWatch(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		LoginUser loginUser = (LoginUser) request.getSession().getAttribute(
				Config.SystemConfig.LOGINUSER);
		if (loginUser == null) {
			return null;
		}

		String userName = loginUser.getUserName();
		if ("admin".equals(userName)) {
			return mapping.findForward("addProjectInfoWatch");
		} else {
			return mapping.findForward("addProjectInfoWatchOther");
		}
	}

	public ActionForward insertProjectInfoWatch(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {

		String companyId = request.getParameter("companyId");
		// String channelId = request.getParameter("channelId");
		Result result = new Result();
		String name = "";
		String fileFormat = "";
		String zipName = "";
		String fileName = Long.toString(new Date().getTime());
		try {
			LoginUser loginUser = (LoginUser) request.getSession()
					.getAttribute(Config.SystemConfig.LOGINUSER);
			if (loginUser == null) {
				return null;
			}
			ProjectInfoForm form = (ProjectInfoForm) actionForm;
			System.out.println(form.getChannelId());
			Hashtable<?, ?> files = form.getMultipartRequestHandler()
					.getFileElements();// 获取所有文件路径的枚举；

			if (files != null & files.size() > 0) {
				Enumeration<?> enums = files.keys();
				String fileKey = null;
				while (enums.hasMoreElements()) {
					fileKey = (String) (enums.nextElement());
					FormFile file = (FormFile) files.get(fileKey);
					if (!file.getFileName().isEmpty()) {
						fileFormat = file.toString().substring(
								file.toString().lastIndexOf("."),
								file.toString().length());
						name = fileName + fileFormat;
						System.out.println(name);
						if (name.contains(".zip")) {
							zipName = name;
						}
						// CommUtils.createDateFile(dir); //创建当前文件夹，存在则返回文件名；
						InputStream in = file.getInputStream();
						// photoPath = photoPath + name; //输出文件路径
						System.out.println(clockxmlpath + name);
						File f = new File(clockxmlpath + name);
						if (f.exists()) {
							f.delete();
						}

						OutputStream out = new FileOutputStream(clockxmlpath
								+ name);
						out.write(file.getFileData(), 0, file.getFileSize());

						out.close();
						out = null;
						in.close();
					}

				}

			}

			StringBuffer sb = new StringBuffer();
			String userName = loginUser.getUserName();
			// ProjectInfoForm form = (ProjectInfoForm) actionForm;
			ProjectInfoFacade facade = ServiceBean.getInstance()
					.getProjectInfoFacade();
			ProjectInfo vo = new ProjectInfo();
			int num = ServiceBean.getInstance().getProjectInfoFacade()
					.getProjectInfoCount(vo) + 1;
			BeanUtils.copyProperties(vo, form);
			// vo.setId(num);
			String proNo = form.getProjectNo();
			System.out.println(proNo);
			if ("admin".equals(userName)) {
				vo.setProjectNo(proNo);
				vo.setHeartS(proNo);
			} else {
				vo.setProjectNo(userName);
				vo.setHeartS(userName);
			}
			vo.setCompanyId(companyId);
			vo.setChannelId(zipName);
			vo.setRemark(fileName);
			if ("".equals(name) || name == "" || name == null) {
				vo.setChannelId("");
				vo.setAdTitle("");
				vo.setAdDetail("");
				vo.setRemark("");
			}
			vo.setProjectName(form.getProjectName());
			vo.setAddTime(new Date());
			String suoZaiDi = request.getParameter("suozaidi");
			String phone = request.getParameter("phone");
			vo.setAdTitle(suoZaiDi);
			vo.setAdDetail(phone);
			vo.setStatus("1");
			vo.setChannelId(phone);
			vo.setRemark(request.getParameter("remark"));

			String addType = request.getParameter("addType");
			vo.setSocketWay(addType);

			facade.insertProjectWatchInfo(vo);

			result.setBackPage(HttpTools.httpServletPath(request, // ����ɹ�����ת��ԭ��ҳ��
					"queryWatchInfo"));
			result.setResultCode("inserts"); // ���ò���Code
			result.setResultType("success"); // ���ò���ɹ�
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"initInsertWatch"));
			if (e instanceof SystemException) { /* ����֪�쳣���н��� */
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else { /* ��δ֪�쳣���н�������ȫ�������δ֪�쳣 */
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}

	public ActionForward initUpdateWatch(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		LoginUser loginUser = (LoginUser) request.getSession().getAttribute(
				Config.SystemConfig.LOGINUSER);
		if (loginUser == null) {
			return null;
		}

		String userName = loginUser.getUserName();

		String id = request.getParameter("id");
		ProjectInfo vo = new ProjectInfo();
		vo.setCondition("id='" + id + "'");
		List<DataMap> list = ServiceBean.getInstance().getProjectInfoFacade()
				.getProjectWatchInfo(vo);
		if (list == null || list.size() == 0) {
			Result result = new Result();
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryWatchInfo"));
			result.setResultCode("rowDel");
			result.setResultType("success");
			return mapping.findForward("result");
		}
		request.setAttribute("projectInfo", list.get(0));
		return mapping.findForward("updateProjectWatchInfo");
		/*	if ("admin".equals(userName)) {
		} else {
			return mapping.findForward("updateProjectWatchInfoOther");
		}*/
	}

	public ActionForward updateProjectWatchInfo(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {
		LoginUser loginUser = (LoginUser) request.getSession().getAttribute(
				Config.SystemConfig.LOGINUSER);
		if (loginUser == null) {
			return null;
		}
		String userName = loginUser.getUserName();

		Result result = new Result();
		String zipName = "";
		String fileName = Long.toString(new Date().getTime());
		try {
			String id = request.getParameter("id");
			String project_no = request.getParameter("project_no");
			String project_name = request.getParameter("project_name");
			String company_id = request.getParameter("company_id");

			// ProjectInfoForm form = (ProjectInfoForm) actionForm;

			ProjectInfoForm form = (ProjectInfoForm) actionForm;
			String name = "";
			String fileFormat = "";
			Hashtable<?, ?> files = form.getMultipartRequestHandler()
					.getFileElements();// 获取所有文件路径的枚举；
			if (files != null & files.size() > 0) {
				Enumeration<?> enums = files.keys();
				String fileKey = null;
				while (enums.hasMoreElements()) {
					fileKey = (String) (enums.nextElement());
					FormFile file = (FormFile) files.get(fileKey);
					if (!file.getFileName().isEmpty()) {
						fileFormat = file.toString().substring(
								file.toString().lastIndexOf("."),
								file.toString().length());
						name = fileName + fileFormat;
						if (name.contains(".zip")) {
							zipName = name;
						}
						// CommUtils.createDateFile(dir); //创建当前文件夹，存在则返回文件名；
						InputStream in = file.getInputStream();
						// photoPath = photoPath + name; //输出文件路径
						System.out.println(clockxmlpath + name);
						File f = new File(clockxmlpath + name);
						if (f.exists()) {
							f.delete();
						}

						OutputStream out = new FileOutputStream(clockxmlpath
								+ name);
						out.write(file.getFileData(), 0, file.getFileSize());

						out.close();
						out = null;
						in.close();
					}

				}

			}

			ProjectInfo vo = new ProjectInfo();
			vo.setCondition("id='" + id + "'");

			vo.setProjectName(project_name);
			if ("admin".equals(userName)) {
				vo.setProjectNo(project_no);
				vo.setHeartS(project_no);
			}
			vo.setChannelId(zipName);
			vo.setAdTitle(clockdownloadUrl + zipName);
			vo.setAdDetail(clockdownloadUrl + name);
			vo.setRemark(fileName);
			if ("".equals(name) || name == "" || name == null) {
				vo.setChannelId("");
				vo.setAdTitle("");
				vo.setAdDetail("");
				vo.setRemark("");
			}
			vo.setCompanyId(company_id);

			String channel_id = request.getParameter("channel_id");
			String remark = request.getParameter("remark");
			String remarka = request.getParameter("remarka");
			String adTitle = request.getParameter("adTitle");
              System.out.println("remark= "+remark);
              System.out.println("remark= "+remarka);
			vo.setChannelId(channel_id);
			vo.setRemark(remarka);
			vo.setAdTitle(adTitle);

			String addType = request.getParameter("addType");

			vo.setSocketWay(addType);

			ServiceBean.getInstance().getProjectInfoFacade()
					.updatePorjectWatchInfo(vo);

			result.setBackPage(HttpTools.httpServletPath(request, // ����ɹ�����ת��ԭ��ҳ��
					"queryWatchInfo"));
			result.setResultCode("updates");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryWatchInfo"));
			if (e instanceof SystemException) { /* ����֪�쳣���н��� */
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else { /* ��δ֪�쳣���н�������ȫ�������δ֪�쳣 */
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}

	public ActionForward deletewatch(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {

		Result result = new Result();
		try {
			ProjectInfoForm form = (ProjectInfoForm) actionForm;

			ProjectInfo vo = new ProjectInfo();
			vo.setCondition("id='" + form.getId() + "'");
			BeanUtils.copyProperties(vo, form);
			ServiceBean.getInstance().getProjectInfoFacade()
					.deletePorjectInfoWatch(vo);
			ProjectInfo voo = new ProjectInfo();
			StringBuffer sb = new StringBuffer();
			List<DataMap> getProjectInfo = ServiceBean.getInstance()
					.getProjectInfoFacade().getProjectWatchInfo(voo);
			if (getProjectInfo.size() > 0) {
				sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
				sb.append("<clockskins>");

				for (int i = 0; i < getProjectInfo.size(); i++) {
					sb.append("<clockskin>");
					sb.append("<name id=\"");
					sb.append(getProjectInfo.get(i).get("project_name") + "");
					sb.append("\"/>");
					sb.append("<skinid id=\"");
					sb.append(getProjectInfo.get(i).get("remark") + "");
					sb.append("\"/>");
					sb.append("<file id=\"");
					sb.append(getProjectInfo.get(i).get("channel_id") + "");
					sb.append("\"/>");
					sb.append("<customer id=\"");
					sb.append(getProjectInfo.get(i).get("project_no") + "");
					if ("0".equals(getProjectInfo.get(i).get("status") + "")) {
						sb.append("-hide");
					}
					sb.append("\"/>");
					sb.append("<type id=\"");
					sb.append(getProjectInfo.get(i).get("company_id") + "");
					sb.append("\"/>");
					sb.append("</clockskin>");
				}

				sb.append("</clockskins>");

			}
			Constant.deleteFile(clockxmlpath + clockskinName);
			Constant.createFileContent(clockxmlpath, clockskinName, sb
					.toString().getBytes("UTF-8"));

			result.setBackPage(HttpTools.httpServletPath(request,
					"queryWatchInfo"));
			result.setResultCode("deletes");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryWatchInfo"));
			if (e instanceof SystemException) { /* ����֪�쳣���н��� */
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else { /* ��δ֪�쳣���н�������ȫ�������δ֪�쳣 */
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}

	public ActionForward initUpdateWatchStatus(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {
		LoginUser loginUser = (LoginUser) request.getSession().getAttribute(
				Config.SystemConfig.LOGINUSER);
		if (loginUser == null) {
			return null;
		}
		String userName = loginUser.getUserName();

		Result result = new Result();

		try {
			String id = request.getParameter("id");
			String status = request.getParameter("s");

			ProjectInfo vo = new ProjectInfo();
			vo.setCondition("id='" + id + "'");
			vo.setStatus(status);

			ServiceBean.getInstance().getProjectInfoFacade()
					.updatePorjectWatchInfo(vo);
			StringBuffer sb = new StringBuffer();
			ProjectInfo voo = new ProjectInfo();
			List<DataMap> getProjectInfo = ServiceBean.getInstance()
					.getProjectInfoFacade().getProjectWatchInfo(voo);
			if (getProjectInfo.size() > 0) {
				sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
				sb.append("<clockskins>");

				for (int i = 0; i < getProjectInfo.size(); i++) {
					sb.append("<clockskin>");
					sb.append("<name id=\"");
					sb.append(getProjectInfo.get(i).get("project_name") + "");
					sb.append("\"/>");
					sb.append("<skinid id=\"");
					sb.append(getProjectInfo.get(i).get("remark") + "");
					sb.append("\"/>");
					sb.append("<file id=\"");
					sb.append(getProjectInfo.get(i).get("channel_id") + "");
					sb.append("\"/>");
					sb.append("<customer id=\"");
					sb.append(getProjectInfo.get(i).get("project_no") + "");
					if ("0".equals(getProjectInfo.get(i).get("status") + "")) {
						sb.append("-hide");
					}
					sb.append("\"/>");
					sb.append("<type id=\"");
					sb.append(getProjectInfo.get(i).get("company_id") + "");
					sb.append("\"/>");
					sb.append("</clockskin>");
				}

				sb.append("</clockskins>");

			}
			Constant.deleteFile(clockxmlpath + clockskinName);
			Constant.createFileContent(clockxmlpath, clockskinName, sb
					.toString().getBytes("UTF-8"));

			result.setBackPage(HttpTools.httpServletPath(request, // ����ɹ�����ת��ԭ��ҳ��
					"queryWatchInfo"));
			result.setResultCode("updates");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryWatchInfo"));
			if (e instanceof SystemException) { /* ����֪�쳣���н��� */
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else { /* ��δ֪�쳣���н�������ȫ�������δ֪�쳣 */
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}

	public ActionForward insertUserDangAn(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {
		// String companyId = request.getParameter("companyId");
		// String channelId = request.getParameter("channelId");
		Result result = new Result();
		/*String name = "";
		String fileFormat = "";*/
		try {
			LoginUser loginUser = (LoginUser) request.getSession()
					.getAttribute(Config.SystemConfig.LOGINUSER);
			if (loginUser == null) {
				return null;
			}

		 	String orderId ="";// 订单编号
			String userName = loginUser.getUserName();
			UserInfo uvo =new UserInfo();
			uvo.setCondition("userCode = '"+userName+"' limit 1");
			List<DataMap> listUo =  ServiceBean.getInstance().getUserInfoFacade().getUserInfo(uvo);
			
			 SimpleDateFormat df = new SimpleDateFormat("yyMMdd");
			 SimpleDateFormat yydf = new SimpleDateFormat("yyyyMMdd");
		     Calendar calendar = Calendar.getInstance();
		     
		     ProjectInfo voCount = new ProjectInfo();
		     voCount.setCondition("add_time>= '"+yydf.format(calendar.getTime())+"' and xiadan_kefu = '"+userName+"'");
		    int shuliang =   ServiceBean.getInstance()
					.getProjectInfoFacade().getProjectInfoCount(voCount)+1;
		    String compnay = listUo.get(0).get("company")+"";
		    if(compnay == null || "".equals(compnay) ){
		    	compnay="1";
		    }
		    
		    String id =  listUo.get(0).get("id")+"";
		    if(id.length()==4){
		    	id="0"+id;
		    }else if(id.length()==3){
		    	id="00"+id;
		    }else if(id.length()==2){
		    	id="000"+id;
		    }else if(id.length()==1){
		    	id="0000"+id;
		    }
		    
		    
		    	if(shuliang<10){
		    		 orderId = compnay+ df.format(calendar.getTime()) +id+"0"+shuliang;
		    	}else{
		    		orderId = compnay+ df.format(calendar.getTime()) +id+shuliang;
		    	}
		    
		     
		    	ProjectInfo vo = new ProjectInfo();
		    
			
			ProjectInfoForm form = (ProjectInfoForm) actionForm;
			Hashtable<?, ?> files = form.getMultipartRequestHandler()
					.getFileElements();
			
			   Hashtable<Object, FormFile> fileMap = form.getMultipartRequestHandler().getFileElements();
               //遍历文件列表
               for(Object key : fileMap.keySet()){ 
                   FormFile file =  fileMap.get(key);
                   System.out.println("遍历文件"+file.getFileName());
               }
               
		   int fileIsEmpty = 0;
			
			if (files != null & files.size() > 0) {
				
				//String qianZhui = "D:/resin/webapps/watch/upload/fujian/";
				String path = "D:/resin/webapps/watch/upload/photo/" + orderId;
				
				Constant.deleteFile(path);
				Constant.createFile(path);
				
				Enumeration<?> enums = files.keys();
				String fileKey = null;
				while (enums.hasMoreElements()) {
					fileKey = (String) (enums.nextElement());
					FormFile file = (FormFile) files.get(fileKey);
					if (!file.getFileName().isEmpty()) {
						fileIsEmpty = 1;
						/*fileFormat = file.toString().substring(
								file.toString().lastIndexOf("."),
								file.toString().length());
						name = Long.toString(new Date().getTime()) + fileFormat;*/
					//	 CommUtils.createDateFile(dir); //创建当前文件夹，存在则返回文件名；
						InputStream in = file.getInputStream();
						// photoPath = photoPath + name; //输出文件路径
						
						File f = new File(path+"/" + file.getFileName());
						if (f.exists()) {
							f.delete();
						}

						OutputStream out = new FileOutputStream(path+"/"
								+ file.getFileName());
						out.write(file.getFileData(), 0, file.getFileSize());

						out.close();
						out = null;
						in.close();
						
						

						
					}

				}
			
				if (fileIsEmpty == 1) {
				String zipName = "D:/resin/webapps/watch/upload/fujianzip/" + orderId + ".zip";
				FileOutputStream fos1 = new FileOutputStream(new File(zipName));
				ZipUtils.toZip(path, fos1, true);
				
				String downloadUrl ="http://47.111.148.8:80/watch/upload/fujianzip/"+orderId+".zip";
				vo.setFujian_url(downloadUrl);
				
				DeviceActiveInfo vod = new DeviceActiveInfo();

				vod.setCondition("orderid = '" + orderId + "'");

				List<DataMap> list = ServiceBean.getInstance()
						.getDeviceActiveInfoFacade().getAllCallInfo(vod);

				
				
				
				if (list.size() > 0) {
					vod.setCondition("id='" + list.get(0).get("id") + "'");
					vod.setFujian(downloadUrl);
					ServiceBean.getInstance().getDeviceActiveInfoFacade()
							.updateCallInfo(vod);

				} else {
					vod.setOrderid(orderId);
					vod.setFujian(downloadUrl);
					ServiceBean.getInstance().getDeviceActiveInfoFacade()
							.insertCallInfo(vod);
				}
				
				}
			
				

			}
			
			String salePrice = request.getParameter("salePrice");
			String orderNumber = request.getParameter("orderNumber");
			
			String orderNumber1 = request.getParameter("orderNumber1");
			String orderNumber2 = request.getParameter("orderNumber2");
			String orderNumber3 = request.getParameter("orderNumber3");
			String orderNumber4 = request.getParameter("orderNumber4");
			String orderNumber5 = request.getParameter("orderNumber5");
			String orderNumber6 = request.getParameter("orderNumber6");
			String orderNumber7 = request.getParameter("orderNumber7");
			String orderNumber8 = request.getParameter("orderNumber8");
			String orderNumber9 = request.getParameter("orderNumber9");
			
			
			
			StringBuffer oderSb = new StringBuffer();
			oderSb.append(orderNumber);
			if(!Utils.isEmpty(orderNumber1)){
				oderSb.append(",").append(orderNumber1);
			}
			if(!Utils.isEmpty(orderNumber2)){
				oderSb.append(",").append(orderNumber2);
			}
			if(!Utils.isEmpty(orderNumber3)){
				oderSb.append(",").append(orderNumber3);
			}
			if(!Utils.isEmpty(orderNumber4)){
				oderSb.append(",").append(orderNumber4);
			}
			if(!Utils.isEmpty(orderNumber5)){
				oderSb.append(",").append(orderNumber5);
			}
			if(!Utils.isEmpty(orderNumber6)){
				oderSb.append(",").append(orderNumber6);
			}
			if(!Utils.isEmpty(orderNumber7)){
				oderSb.append(",").append(orderNumber7);
			}
			if(!Utils.isEmpty(orderNumber8)){
				oderSb.append(",").append(orderNumber8);
			}
			if(!Utils.isEmpty(orderNumber9)){
				oderSb.append(",").append(orderNumber9);
			}
			
			
			
			String xsjg1 = request.getParameter("xsjg1");
			String xsjg2 = request.getParameter("xsjg2");
			String xsjg3 = request.getParameter("xsjg3");
			String xsjg4 = request.getParameter("xsjg4");
			String xsjg5 = request.getParameter("xsjg5");
			String xsjg6 = request.getParameter("xsjg6");
			String xsjg7 = request.getParameter("xsjg7");
			String xsjg8 = request.getParameter("xsjg8");
			String xsjg9 = request.getParameter("xsjg9");
			
			StringBuffer xsjgsb = new StringBuffer();
			xsjgsb.append(salePrice);
			if(!Utils.isEmpty(xsjg1)){
				xsjgsb.append(",").append(xsjg1);
			}
			if(!Utils.isEmpty(xsjg2)){
				xsjgsb.append(",").append(xsjg2);
			}
			if(!Utils.isEmpty(xsjg3)){
				xsjgsb.append(",").append(xsjg3);
			}
			if(!Utils.isEmpty(xsjg4)){
				xsjgsb.append(",").append(xsjg4);
			}
			if(!Utils.isEmpty(xsjg5)){
				xsjgsb.append(",").append(xsjg5);
			}
			if(!Utils.isEmpty(xsjg6)){
				xsjgsb.append(",").append(xsjg6);
			}
			if(!Utils.isEmpty(xsjg7)){
				xsjgsb.append(",").append(xsjg7);
			}
			if(!Utils.isEmpty(xsjg8)){
				xsjgsb.append(",").append(xsjg8);
			}
			if(!Utils.isEmpty(xsjg9)){
				xsjgsb.append(",").append(xsjg9);
			}
			
			
			
			String addhang1 = request.getParameter("addhang1");
			String addhang = request.getParameter("addhang");
			
					
					ShareInfo vso = new ShareInfo(); 
					vso.setOrderNumber(orderNumber);
					vso.setOrderNumber1(orderNumber1);
					vso.setOrderNumber2(orderNumber2);
					vso.setOrderNumber3(orderNumber3);
					vso.setOrderNumber4(orderNumber4);
					vso.setOrderNumber5(orderNumber5);
					vso.setOrderNumber6(orderNumber6);
					vso.setOrderNumber7(orderNumber7);
					vso.setOrderNumber8(orderNumber8);
					vso.setOrderNumber9(orderNumber9);
					vso.setXsjg(salePrice);;
				vso.setXsjg1(xsjg1);
				vso.setXsjg2(xsjg2);
				vso.setXsjg3(xsjg3);
				vso.setXsjg4(xsjg4);
				vso.setXsjg5(xsjg5);
				vso.setXsjg6(xsjg6);
				vso.setXsjg7(xsjg7);
				vso.setXsjg8(xsjg8);
				vso.setXsjg9(xsjg9);
				vso.setAddhang(addhang);
				vso.setAddhang1(addhang1);
				vso.setOrder_id(orderId);
				
				ServiceBean.getInstance().getShareInfoFacade().insertShareInfo(vso);
		/*	String ok = request.getParameter("okk");
			System.out.println("ok="+ok);*/
			System.out.println("按钮值="+request.getParameter("anniu"));
			String wwName = request.getParameter("projectNo");
		
			String wechat = request.getParameter("wechat");
			
			Date addTime = new Date();
			String kehuPhone = request.getParameter("kehuPhone");
			String orderType = request.getParameter("orderType");
			String kehuName = request.getParameter("kehuName");
			String qudao = request.getParameter("qudao");
			String xiadanKeFu = loginUser.getUserName();
			String address = request.getParameter("address");
			String height = request.getParameter("height");
			String weight = request.getParameter("weight");
			String age = request.getParameter("age");
			String sex = request.getParameter("sex");
			String jiankuanA = request.getParameter("jiankuanA");
			String lingweiB = request.getParameter("lingweiB");
			String xiongweiA = request.getParameter("xiongweiA");
			String xiongweiB = request.getParameter("xiongweiB");
			String zhongyaoA = request.getParameter("zhongyaoA");
			String zhongyaoB = request.getParameter("zhongyaoB");
			String fuweiA = request.getParameter("fuweiA");
			String fuweiB = request.getParameter("fuweiB");
			String houzhongyichangA = request.getParameter("houzhongyichangA");
			String xiuchangB = request.getParameter("xiuchangB");
			String qianyichangA = request.getParameter("qianyichangA");
			String xiufeiB = request.getParameter("xiufeiB");
			String xiuchangA = request.getParameter("xiuchangA");
			String xiukouB = request.getParameter("xiukouB");
			String xiufeiA = request.getParameter("xiufeiA");
			String lingkoukuaishiB = request.getParameter("lingkoukuaishiB");
			String xiukouA = request.getParameter("xiukouA");
			String yichangB = request.getParameter("yichangB");
			String kuchangC = request.getParameter("kuchangC");
			String xiongweiD = request.getParameter("xiongweiD");
			String yaoweiC = request.getParameter("yaoweiC");
			String zhongyaoD = request.getParameter("zhongyaoD");
			String tuiweiC = request.getParameter("tuiweiC");
			String yichangD = request.getParameter("yichangD");
			String dangweiC = request.getParameter("dangweiC");
			String datuiC = request.getParameter("datuiC");
			String zhongtuiC = request.getParameter("zhongtuiC");
			String xiaotuiC = request.getParameter("xiaotuiC");
			String tuikouC = request.getParameter("tuikouC");
			String kouxingC = request.getParameter("kouxingC");
			String kouseC = request.getParameter("kouseC");
			String kuanxingD = request.getParameter("kuanxingD");
			String botouD = request.getParameter("botouD");
			String koudaiC = request.getParameter("koudaiC");
			String daigai = request.getParameter("daigai");
			String pingxiedai = request.getParameter("pingxiedai");
			String miaoliao1 = request.getParameter("miaoliao1");
			String yongtu1 = request.getParameter("yongtu1");
			String miaoliao2 = request.getParameter("miaoliao2");
			String yongtu2 = request.getParameter("yongtu2");
			String tixingremark = request.getParameter("tixingremark");
			String remark = request.getParameter("remark");

			
			

			ProjectInfoFacade facade = ServiceBean.getInstance()
					.getProjectInfoFacade();
		
			vo.setOrderId(orderId);
			vo.setWwName(wwName);
			vo.setSalePrice(xsjgsb.toString());
			vo.setWechat(wechat);
			vo.setOrderNumber(oderSb.toString());
			vo.setAddTime(addTime);
			vo.setKehuPhone(kehuPhone);
			vo.setOrderType(orderType);
			vo.setKehuName(kehuName);
			vo.setQudao(qudao);
			vo.setXiadanKeFu(xiadanKeFu);
			vo.setAddress(address);
			vo.setHeight(height);
			vo.setWeight(weight);
			vo.setAge(age);
			vo.setJiankuanA(jiankuanA);
			vo.setLingweiB(lingweiB);
			vo.setXiongweiA(xiongweiA);
			vo.setXiongweiB(xiongweiB);
			vo.setZhongyaoA(zhongyaoA);
			vo.setZhongyaoB(zhongyaoB);
			vo.setFuweiA(fuweiA);
			vo.setFuweiB(fuweiB);
			vo.setHouzhongyichangA(houzhongyichangA);
			vo.setXiuchangB(xiuchangB);
			vo.setQianyichangA(qianyichangA);
			vo.setXiufeiB(xiufeiB);
			vo.setXiuchangA(xiuchangA);
			vo.setXiukouB(xiukouB);
			vo.setXiufeiA(xiufeiA);
			vo.setYichangB(yichangB);
			vo.setKuchangC(kuchangC);
			vo.setXiongweiD(xiongweiD);
			vo.setYaoweiC(yaoweiC);
			vo.setZhongyaoD(zhongyaoD);
			vo.setTuiweiC(tuiweiC);
			vo.setYichangD(yichangD);
			vo.setDangweiC(dangweiC);
			vo.setDatuiC(datuiC);
			vo.setZhongtuiC(zhongtuiC);
			vo.setXiaotuiC(xiaotuiC);
			vo.setTuikouC(tuikouC);
			vo.setKouxingC(kouxingC);
			vo.setKouseC(kouseC);
			vo.setKuanxingD(kuanxingD);
			vo.setBotouD(botouD);
			vo.setKoudaiC(koudaiC);
			vo.setDaigai(daigai);
			vo.setPingxiedai(pingxiedai);
			vo.setMiaoliao1(miaoliao1);
			vo.setYongtu1(yongtu1);
			vo.setMiaoliao2(miaoliao2);
			vo.setYongtu2(yongtu2);
			vo.setTixingremark(tixingremark);
			vo.setRemark(remark);
			
			// vo.setUpdateTime(addTime);
			vo.setSex(sex);

			vo.setLingkoukuaishiB(lingkoukuaishiB);
			vo.setXiukouA(xiukouA);

			String xizhuang_number = request.getParameter("xizhuang_number");
			String chenshan_number = request.getParameter("chenshan_number");
			String xiku_number = request.getParameter("xiku_number");
			String majia_number = request.getParameter("majia_number");
			
			if(xizhuang_number == null || "".equals(xizhuang_number)){
				xizhuang_number = "0";
			}
			if(chenshan_number == null || "".equals(chenshan_number)){
				chenshan_number = "0";
			}
			if(xiku_number == null || "".equals(xiku_number)){
				xiku_number = "0";
			}
			if(majia_number == null || "".equals(majia_number)){
				majia_number = "0";
			}
			vo.setXizhuang_number(xizhuang_number);
			vo.setChenshan_number(chenshan_number);
			vo.setXiku_number(xiku_number);
			vo.setMajia_number(majia_number);
			
			//String tag = request.getParameter("tag");
			String tag =request.getParameter("anniu");
			vo.setStatus(tag);
			if("2".equals(tag)){
				  ChannelInfo chInfo = new ChannelInfo();
			       chInfo.setOrder_id(orderId);
			       chInfo.setPhone(kehuPhone);
			       chInfo.setAddTime(new Date());
			       chInfo.setRemark("【"+Utils.getnewTime()+"】【"+orderId+"】订单已收录入库，分配【不一订制-南京中央工厂】制作.</br>(订单我们已收到)");
			     ServiceBean.getInstance().getChannelInfoFacade().insertChannelInfo(chInfo);
			}
			
			String jiaofu_time= request.getParameter("jiaofu_time");
			
			
//			vo.setJiaofu_time(CommTools.getAddTime(Integer.valueOf(jiaofu_time)));
			vo.setJiaofu_time(jiaofu_time);
			
			
			String kaicha = request.getParameter("kaicha");
			String xiabai  = request.getParameter("xiabai");
			String zhuangse  = request.getParameter("zhuangse");
			String waizhubian  = request.getParameter("waizhubian");
			String xiucha  = request.getParameter("xiucha");
			String kuyao  = request.getParameter("kuyao");
			String kuxing  = request.getParameter("kuxing");
			String chenshanling  = request.getParameter("chenshanling");
			String chenshanxiu  = request.getParameter("chenshanxiu");
			//System.out.println("衬衫袖"+chenshanxiu);
			

			vo.setKaicha(kaicha);
			vo.setXiabai(xiabai);
			vo.setZhuangse(zhuangse);
			vo.setWaizhubian(waizhubian);
			vo.setXiucha(xiucha);
			vo.setKuyao(kuyao);
			vo.setKuxing(kuxing);
			vo.setChenshanling(chenshanling);
			vo.setChenshanxiu(chenshanxiu);
			
			
			
			
			
			String yichangB2 = request.getParameter("yichangB2");
		
			String jiankuannew = request.getParameter("jiankuannew");
			
			vo.setYichangB2(yichangB2);
			vo.setJiankuannew(jiankuannew);
			
			facade.insertKeHuDangAnInfo(vo);
			
			
			ProjectInfo insertVO = new ProjectInfo();
			String fuwei_quea = request.getParameter("fuwei_quea");
			System.out.println("fuwei_quea="+fuwei_quea);
			insertVO.setFuwei_quea(fuwei_quea);
			
			insertVO.setOrderNumber(orderId);
			insertVO.setFuwei_queb(" ");
			
			String ml1 = request.getParameter("ml1");
			String ml2 = request.getParameter("ml2");
			String ml3 = request.getParameter("ml3");
			String ml4 = request.getParameter("ml4");
			String ml5 = request.getParameter("ml5");
			String ml6 = request.getParameter("ml6");
			String ml7 = request.getParameter("ml7");
			String ml8 = request.getParameter("ml8");
			String ml9 = request.getParameter("ml9");
			String ml10 = request.getParameter("ml10");
			String ml11 = request.getParameter("ml11");
			String ml12 = request.getParameter("ml12");
			String ml13 = request.getParameter("ml13");
			String ml14 = request.getParameter("ml14");
			insertVO.setMl1(ml1);
			insertVO.setMl2(ml2);
			insertVO.setMl3(ml3);
			insertVO.setMl4(ml4);
			insertVO.setMl5(ml5);
			insertVO.setMl6(ml6);
			insertVO.setMl7(ml7);
			insertVO.setMl8(ml8);
			insertVO.setMl9(ml9);
			insertVO.setMl10(ml10);
			insertVO.setMl11(ml11);
			insertVO.setMl12(ml12);
			insertVO.setMl13(ml13);
			insertVO.setMl14(ml14);
			
			String yt1 = request.getParameter("yt1");
			System.out.println("用途1="+yt1);
			String yt2 = request.getParameter("yt2");
			String yt3 = request.getParameter("yt3");
			String yt4 = request.getParameter("yt4");
			String yt5 = request.getParameter("yt5");
			String yt6 = request.getParameter("yt6");
			String yt7 = request.getParameter("yt7");
			String yt8 = request.getParameter("yt8");
			String yt9 = request.getParameter("yt9");
			String yt10 = request.getParameter("yt10");
			String yt11 = request.getParameter("yt11");
			String yt12 = request.getParameter("yt12");
			String yt13 = request.getParameter("yt13");
			String yt14 = request.getParameter("yt14");
			insertVO.setYt1(yt1);
			insertVO.setYt2(yt2);
			insertVO.setYt3(yt3);
			insertVO.setYt4(yt4);
			insertVO.setYt5(yt5);
			insertVO.setYt6(yt6);
			insertVO.setYt7(yt7);
			insertVO.setYt8(yt8);
			insertVO.setYt9(yt9);
			insertVO.setYt10(yt10);
			insertVO.setYt11(yt11);
			insertVO.setYt12(yt12);
			insertVO.setYt13(yt13);
			insertVO.setYt14(yt14);
			
			
			
			
			ServiceBean.getInstance().getProjectInfoFacade()
			.insertPorjectInfoDuoyu(insertVO);
			
			
			
			

			result.setBackPage(HttpTools.httpServletPath(request,
					"daiban"));
			result.setResultCode("inserts");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"initInsertxml"));
			if (e instanceof SystemException) {
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else {
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}

	public ActionForward updateProjectInfodangan(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {

		Result result = new Result();
		try {

			LoginUser loginUser = (LoginUser) request.getSession()
					.getAttribute(Config.SystemConfig.LOGINUSER);
			if (loginUser == null) {
				return null;
			}

			String id = request.getParameter("id");
			String project_no1 = request.getParameter("project_no1");
			String orderId = project_no1;
			ProjectInfo vo = new ProjectInfo();
			
			
			String downloadUrl ="http://47.111.148.8:80/watch/upload/fujianzip/"+orderId+".zip";
			vo.setFujian_url(downloadUrl);
			
			String qianZhui = "D:/resin/webapps/watch/upload/photo/";
			String path = qianZhui + orderId;
			ProjectInfoForm form = (ProjectInfoForm) actionForm;
			Hashtable<?, ?> files = form.getMultipartRequestHandler()
					.getFileElements();
			System.out.println("文件数量="+ files.size());
			if (files != null & files.size() > 0) {
				
				//Constant.deleteFile(path);
				Constant.createFile(path);
				
				Enumeration<?> enums = files.keys();
				String fileKey = null;
				while (enums.hasMoreElements()) {
					fileKey = (String) (enums.nextElement());
					FormFile file = (FormFile) files.get(fileKey);
					System.out.println("文件名称="+file.getFileName());
					if (!file.getFileName().isEmpty()) {
						/*fileFormat = file.toString().substring(
								file.toString().lastIndexOf("."),
								file.toString().length());
						name = Long.toString(new Date().getTime()) + fileFormat;*/
					//	 CommUtils.createDateFile(dir); //创建当前文件夹，存在则返回文件名；
						InputStream in = file.getInputStream();
						// photoPath = photoPath + name; //输出文件路径
						
						File f = new File(path+"/" + file.getFileName());
						if (f.exists()) {
							f.delete();
						}

						OutputStream out = new FileOutputStream(path+"/"
								+ file.getFileName());
						out.write(file.getFileData(), 0, file.getFileSize());

						out.close();
						out = null;
						in.close();
						
						

						
					}

				}
				
				
				/*
				 *         FileOutputStream fos1 = new FileOutputStream(new File("F:/UI/test/wei.zip"));
	        ZipUtils.toZip("F:/UI/test/chicun", fos1,true);
				 * */

			}
			
			
			
		
			
			
			
			File file = new File(path);
			if (file.exists()) {
				String zipName =  "D:/resin/webapps/watch/upload/fujianzip/" + orderId + ".zip";
				FileOutputStream fos1 = new FileOutputStream(new File(zipName));
				ZipUtils.toZip(path, fos1, true);
				
				
			/*	List<File> fileList = new ArrayList<>();
		        fileList.add(new File(path));
		        FileOutputStream fos2 = new FileOutputStream(new File(zipName));
		        ZipUtils.toZip(fileList, fos2);*/
		        
				DeviceActiveInfo vod = new DeviceActiveInfo();

				vod.setCondition("orderid = '" + orderId + "'");

				List<DataMap> list = ServiceBean.getInstance()
						.getDeviceActiveInfoFacade().getAllCallInfo(vod);

				// String url =
				// "http://localhost:8080/clothes/upload/photo/"+orderid+"/";
			
				
				if (list.size() > 0) {
					vod.setCondition("id='" + list.get(0).get("id") + "'");
					vod.setFujian(downloadUrl);
					ServiceBean.getInstance().getDeviceActiveInfoFacade()
							.updateCallInfo(vod);

				} else {
					vod.setOrderid(orderId);
					vod.setFujian(downloadUrl);
					ServiceBean.getInstance().getDeviceActiveInfoFacade()
							.insertCallInfo(vod);
				}
			}
			
			
		

		
			vo.setCondition("id='" + id + "'");
			String wwName = request.getParameter("projectNo");
					
			//String orderId = System.currentTimeMillis() + "";// 订单编号
			String xizhuang_number = request.getParameter("xizhuang_number");
			String chenshan_number = request.getParameter("chenshan_number");
			String xiku_number = request.getParameter("xiku_number");
			String majia_number = request.getParameter("majia_number");
			
			if(xizhuang_number == null || "".equals(xizhuang_number)){
				xizhuang_number = "0";
			}
			if(chenshan_number == null || "".equals(chenshan_number)){
				chenshan_number = "0";
			}
			if(xiku_number == null || "".equals(xiku_number)){
				xiku_number = "0";
			}
			if(majia_number == null || "".equals(majia_number)){
				majia_number = "0";
			}
			vo.setXizhuang_number(xizhuang_number);
			vo.setChenshan_number(chenshan_number);
			vo.setXiku_number(xiku_number);
			vo.setMajia_number(majia_number);
			
			
			String orderNumber1 = request.getParameter("orderNumber1");
			String orderNumber2 = request.getParameter("orderNumber2");
			String orderNumber3 = request.getParameter("orderNumber3");
			String orderNumber4 = request.getParameter("orderNumber4");
			String orderNumber5 = request.getParameter("orderNumber5");
			String orderNumber6 = request.getParameter("orderNumber6");
			String orderNumber7 = request.getParameter("orderNumber7");
			String orderNumber8 = request.getParameter("orderNumber8");
			String orderNumber9 = request.getParameter("orderNumber9");
			
			String xsjg1 = request.getParameter("xsjg1");
			String xsjg2 = request.getParameter("xsjg2");
			String xsjg3 = request.getParameter("xsjg3");
			String xsjg4 = request.getParameter("xsjg4");
			String xsjg5 = request.getParameter("xsjg5");
			String xsjg6 = request.getParameter("xsjg6");
			String xsjg7 = request.getParameter("xsjg7");
			String xsjg8 = request.getParameter("xsjg8");
			String xsjg9 = request.getParameter("xsjg9");
			
			String addhang1 = request.getParameter("addhang1");
			String addhang = request.getParameter("addhang");
			
			
			
			String salePrice = request.getParameter("salePrice");
			String wechat = request.getParameter("wechat");
			String orderNumber = request.getParameter("orderNumber");
			Date addTime = new Date();
			String kehuPhone = request.getParameter("kehuPhone");
			String orderType = request.getParameter("orderType");
			String kehuName = request.getParameter("kehuName");
			String qudao = request.getParameter("qudao");
			//String xiadanKeFu = loginUser.getUserName();
			String address = request.getParameter("address");
			String height = request.getParameter("height");
			String weight = request.getParameter("weight");
			String age = request.getParameter("age");
			String sex = request.getParameter("sex");
			String jiankuanA = request.getParameter("jiankuanA");
			String lingweiB = request.getParameter("lingweiB");
			String xiongweiA = request.getParameter("xiongweiA");
			String xiongweiB = request.getParameter("xiongweiB");
			String zhongyaoA = request.getParameter("zhongyaoA");
			String zhongyaoB = request.getParameter("zhongyaoB");
			String fuweiA = request.getParameter("fuweiA");
			System.out.println("腹围A="+fuweiA);
			String fuweiB = request.getParameter("fuweiB");
			String houzhongyichangA = request.getParameter("houzhongyichangA");
			String xiuchangB = request.getParameter("xiuchangB");
			String qianyichangA = request.getParameter("qianyichangA");
			String xiufeiB = request.getParameter("xiufeiB");
			String xiuchangA = request.getParameter("xiuchangA");
			String xiukouB = request.getParameter("xiukouB");
			String xiufeiA = request.getParameter("xiufeiA");
			String lingkoukuaishiB = request.getParameter("lingkoukuaishiB");
			String xiukouA = request.getParameter("xiukouA");
			String yichangB = request.getParameter("yichangB");
			String kuchangC = request.getParameter("kuchangC");
			String xiongweiD = request.getParameter("xiongweiD");
			String yaoweiC = request.getParameter("yaoweiC");
			String zhongyaoD = request.getParameter("zhongyaoD");
			String tuiweiC = request.getParameter("tuiweiC");
			String yichangD = request.getParameter("yichangD");
			String dangweiC = request.getParameter("dangweiC");
			String datuiC = request.getParameter("datuiC");
			String zhongtuiC = request.getParameter("zhongtuiC");
			String xiaotuiC = request.getParameter("xiaotuiC");
			String tuikouC = request.getParameter("tuikouC");
			String kouxingC = request.getParameter("kouxingC");
			String kouseC = request.getParameter("kouseC");
			String kuanxingD = request.getParameter("kuanxingD");
			String botouD = request.getParameter("botouD");
			String koudaiC = request.getParameter("koudaiC");
			String daigai = request.getParameter("daigai");
			String pingxiedai = request.getParameter("pingxiedai");
			String miaoliao1 = request.getParameter("miaoliao1");
			String yongtu1 = request.getParameter("yongtu1");
			String miaoliao2 = request.getParameter("miaoliao2");
			String yongtu2 = request.getParameter("yongtu2");
			String tixingremark = request.getParameter("tixingremark");
			String remark = request.getParameter("remark");
			String jiaofu_time = request.getParameter("jiaofu_time");

			
			
			StringBuffer oderSb = new StringBuffer();
			oderSb.append(orderNumber);
			if(!Utils.isEmpty(orderNumber1)){
				oderSb.append(",").append(orderNumber1);
			}
			if(!Utils.isEmpty(orderNumber2)){
				oderSb.append(",").append(orderNumber2);
			}
			if(!Utils.isEmpty(orderNumber3)){
				oderSb.append(",").append(orderNumber3);
			}
			if(!Utils.isEmpty(orderNumber4)){
				oderSb.append(",").append(orderNumber4);
			}
			if(!Utils.isEmpty(orderNumber5)){
				oderSb.append(",").append(orderNumber5);
			}
			if(!Utils.isEmpty(orderNumber6)){
				oderSb.append(",").append(orderNumber6);
			}
			if(!Utils.isEmpty(orderNumber7)){
				oderSb.append(",").append(orderNumber7);
			}
			if(!Utils.isEmpty(orderNumber8)){
				oderSb.append(",").append(orderNumber8);
			}
			if(!Utils.isEmpty(orderNumber9)){
				oderSb.append(",").append(orderNumber9);
			}


     StringBuffer xsjgsb = new StringBuffer();
			xsjgsb.append(salePrice);
			if(!Utils.isEmpty(xsjg1)){
				xsjgsb.append(",").append(xsjg1);
			}
			if(!Utils.isEmpty(xsjg2)){
				xsjgsb.append(",").append(xsjg2);
			}
			if(!Utils.isEmpty(xsjg3)){
				xsjgsb.append(",").append(xsjg3);
			}
			if(!Utils.isEmpty(xsjg4)){
				xsjgsb.append(",").append(xsjg4);
			}
			if(!Utils.isEmpty(xsjg5)){
				xsjgsb.append(",").append(xsjg5);
			}
			if(!Utils.isEmpty(xsjg6)){
				xsjgsb.append(",").append(xsjg6);
			}
			if(!Utils.isEmpty(xsjg7)){
				xsjgsb.append(",").append(xsjg7);
			}
			if(!Utils.isEmpty(xsjg8)){
				xsjgsb.append(",").append(xsjg8);
			}
			if(!Utils.isEmpty(xsjg9)){
				xsjgsb.append(",").append(xsjg9);
			}
			
			
			vo.setJiaofu_time(jiaofu_time);
			//vo.setOrderId(orderId);
			vo.setWwName(wwName);
			vo.setSalePrice(xsjgsb.toString());
			vo.setWechat(wechat);
			vo.setOrderNumber(oderSb.toString());
			vo.setAddTime(addTime);
			vo.setKehuPhone(kehuPhone);
			vo.setOrderType(orderType);
			vo.setKehuName(kehuName);
			vo.setQudao(qudao);
			//vo.setXiadanKeFu(xiadanKeFu);
			vo.setAddress(address);
			vo.setHeight(height);
			vo.setWeight(weight);
			vo.setAge(age);
			vo.setJiankuanA(jiankuanA);
			vo.setLingweiB(lingweiB);
			vo.setXiongweiA(xiongweiA);
			vo.setXiongweiB(xiongweiB);
			vo.setZhongyaoA(zhongyaoA);
			vo.setZhongyaoB(zhongyaoB);
			vo.setFuweiA(fuweiA);
			vo.setFuweiB(fuweiB);
			vo.setHouzhongyichangA(houzhongyichangA);
			vo.setXiuchangB(xiuchangB);
			vo.setQianyichangA(qianyichangA);
			vo.setXiufeiB(xiufeiB);
			vo.setXiuchangA(xiuchangA);
			vo.setXiukouB(xiukouB);
			vo.setXiufeiA(xiufeiA);
			vo.setYichangB(yichangB);
			vo.setKuchangC(kuchangC);
			vo.setXiongweiD(xiongweiD);
			vo.setYaoweiC(yaoweiC);
			vo.setZhongyaoD(zhongyaoD);
			vo.setTuiweiC(tuiweiC);
			vo.setYichangD(yichangD);
			vo.setDangweiC(dangweiC);
			vo.setDatuiC(datuiC);
			vo.setZhongtuiC(zhongtuiC);
			vo.setXiaotuiC(xiaotuiC);
			vo.setTuikouC(tuikouC);
			vo.setKouxingC(kouxingC);
			vo.setKouseC(kouseC);
			vo.setKuanxingD(kuanxingD);
			vo.setBotouD(botouD);
			vo.setKoudaiC(koudaiC);
			vo.setDaigai(daigai);
			vo.setPingxiedai(pingxiedai);
			vo.setMiaoliao1(miaoliao1);
			vo.setYongtu1(yongtu1);
			vo.setMiaoliao2(miaoliao2);
			vo.setYongtu2(yongtu2);
			vo.setTixingremark(tixingremark);
			vo.setRemark(remark);
			
			// vo.setUpdateTime(addTime);
			vo.setSex(sex);

			vo.setLingkoukuaishiB(lingkoukuaishiB);
			vo.setXiukouA(xiukouA);
			
			//String tag = request.getParameter("tag");
			String tag =request.getParameter("anniu");
			vo.setStatus(tag);
			
			
			String kaicha = request.getParameter("kaicha");
			String xiabai  = request.getParameter("xiabai");
			String zhuangse  = request.getParameter("zhuangse");
			String waizhubian  = request.getParameter("waizhubian");
			String xiucha  = request.getParameter("xiucha");
			String kuyao  = request.getParameter("kuyao");
			String kuxing  = request.getParameter("kuxing");
			String chenshanling  = request.getParameter("chenshanling");
			String chenshanxiu  = request.getParameter("chenshanxiu");
					vo.setKaicha(kaicha);
			vo.setXiabai(xiabai);
			vo.setZhuangse(zhuangse);
			vo.setWaizhubian(waizhubian);
			vo.setXiucha(xiucha);
			vo.setKuyao(kuyao);
			vo.setKuxing(kuxing);
			vo.setChenshanling(chenshanling);
			vo.setChenshanxiu(chenshanxiu);
			
			
			String jiankuanA2 = request.getParameter("jiankuanA2");
			vo.setJiankuanA2(jiankuanA2);
			String lingweiB2 = request.getParameter("lingweiB2");
			vo.setLingweiB2(lingweiB2);
			String xiongweiA2 = request.getParameter("xiongweiA2");
			vo.setXiongweiA2(xiongweiA2);
			String xiongweiB22 = request.getParameter("xiongweiB22");
			vo.setXiongweiB22(xiongweiB22);
			String zhongyaoA2 = request.getParameter("zhongyaoA2");
			vo.setZhongyaoA2(zhongyaoA2);
			String zhongyaoB2 = request.getParameter("zhongyaoB2");
			vo.setZhongyaoB2(zhongyaoB2);
			String fuweiA2 = request.getParameter("fuweiA2");
			vo.setFuweiA2(fuweiA2);
			String fuweiB2 = request.getParameter("fuweiB2");
			vo.setFuweiB2(fuweiB2);
			String houzhongyichangA2 = request
					.getParameter("houzhongyichangA2");
			vo.setHouzhongyichangA2(houzhongyichangA2);
			String xiuchangB2 = request.getParameter("xiuchangB2");
			vo.setXiuchangB2(xiuchangB2);
			String qianyichangA2 = request.getParameter("qianyichangA2");
			vo.setQianyichangA2(qianyichangA2);
			String xiufeiB2 = request.getParameter("xiufeiB2");
			vo.setXiufeiB2(xiufeiB2);
			String xiuchangA2 = request.getParameter("xiuchangA2");
			vo.setXiuchangA2(xiuchangA2);
			String xiukouB2 = request.getParameter("xiukouB2");
			vo.setXiukouB2(xiukouB2);
			String lingkoukuaishiB2 = request.getParameter("lingkoukuaishiB2");
			vo.setLingkoukuaishiB2(lingkoukuaishiB2);
			String xiukouA2 = request.getParameter("xiukouA2");
			vo.setXiukouA2(xiukouA2);
			String yichangB2 = request.getParameter("yichangB2");
			vo.setYichangB2(yichangB2);
			String kuchangC2 = request.getParameter("kuchangC2");
			vo.setKuchangC2(kuchangC2);
			String xiongweiD2 = request.getParameter("xiongweiD2");
			vo.setXiongweiD2(xiongweiD2);
			String yaoweiC22 = request.getParameter("yaoweiC22");
			vo.setYaoweiC22(yaoweiC22);
			String zhongyaoD2 = request.getParameter("zhongyaoD2");
			vo.setZhongyaoD2(zhongyaoD2);
			String tuiweiC2 = request.getParameter("tuiweiC2");
			vo.setTuiweiC2(tuiweiC2);
			String yichangD2 = request.getParameter("yichangD2");
			vo.setYichangD2(yichangD2);
			String dangweiC2 = request.getParameter("dangweiC2");
			vo.setDangweiC2(dangweiC2);
			String datuiC2 = request.getParameter("datuiC2");
			vo.setDatuiC2(datuiC2);
			String zhongtuiC2 = request.getParameter("zhongtuiC2");
			vo.setZhongtuiC2(zhongtuiC2);
			String xiaotuiC2 = request.getParameter("xiaotuiC2");
			vo.setXiaotuiC2(xiaotuiC2);
			String tuikouC2 = request.getParameter("tuikouC2");
			vo.setTuikouC2(tuikouC2);
			String mi1 = request.getParameter("mi1");
			vo.setMi1(mi1);
			String mi2 = request.getParameter("mi2");
			vo.setMi2(mi2);

			String xiufeiA2 = request.getParameter("xiufeiA2");
			vo.setXiufeiA2(xiufeiA2);

			String pidanremark = request.getParameter("pidanremark");
			vo.setPidanremark(pidanremark);
			
			String yi_ma = request.getParameter("yi_ma");
			String chenshan_ma = request.getParameter("chenshan_ma");
			String ku_ma = request.getParameter("ku_ma");
			String majia_ma = request.getParameter("majia_ma");
			//String project_no1 = request.getParameter("project_no1");
			
			vo.setYi_ma(yi_ma);
			vo.setChenshan_ma(chenshan_ma);
			vo.setKu_ma(ku_ma);
			vo.setMajia_ma(majia_ma);
			
			
			


			String project_no2 = request.getParameter("project_no2");
			String project_no11 = request.getParameter("project_no11");
					String gdremark = request.getParameter("gdremark");
					
					System.out.println("供应商1="+project_no11);
					System.out.println("供应商2="+project_no2);
					vo.setGongyingshang1(project_no11);
					vo.setGongyingshang2(project_no2);
					vo.setGd_remark(gdremark);
					
					
					String jiankuannew = request.getParameter("jiankuannew");
					vo.setJiankuannew(jiankuannew);
					
					String dakuang1 = request.getParameter("dakuang1");
					String dakuang2 = request.getParameter("dakuang2");
					String dakuang3 = request.getParameter("dakuang3");
					String dakuang4 = request.getParameter("dakuang4");
					vo.setDakuang1(dakuang1);
					vo.setDakuang2(dakuang2);
					vo.setDakuang3(dakuang3);
					vo.setDakuang4(dakuang4);
					
					
					String xc_que = request.getParameter("xc_que");
					
					vo.setXc_que(xc_que);
					String xiukou_que = request.getParameter("xiukou_que");
				vo.setMiaoliao2(xiukou_que);
					
					String jiankuanque = request.getParameter("jiankuanque");
					vo.setJiankuanque(jiankuanque);
					String yichang_q = request.getParameter("yichang_q");
					vo.setYichang_q(yichang_q);
					
				
					
				
					
					/*	String yichang_q = request.getParameter("yichang_q");
					vo.setYichang_q(yichang_q);
					String xiukou_que = request.getParameter("xiukou_que");
					vo.setXiukou_que(xiukou_que);
					String fuwei_quea = request.getParameter("fuwei_quea");
					vo.setFuwei_quea(fuwei_quea);
					String fuwei_queb = request.getParameter("fuwei_queb");
					vo.setFuwei_queb(fuwei_queb);*/
					
					String jiankuan_a = request.getParameter("jiankuanA");
					
					vo.setJiankuan_a(jiankuan_a);
					
			ServiceBean.getInstance().getProjectInfoFacade()
					.updatePorjectInfoDangAn(vo);
			String fuwei_quea = request.getParameter("fuwei_quea");
			String fuwei_queb = request.getParameter("fuwei_queb");
			
			//if(!"".equals(fuwei_quea) || !"".equals(fuwei_queb) ){
				ProjectInfo insertVO = new ProjectInfo();
				
				System.out.println("fuwei_quea="+fuwei_quea);
				insertVO.setFuwei_quea(fuwei_quea);
				
				insertVO.setFuwei_queb(fuwei_queb);
				System.out.println("fuwei_quea="+fuwei_queb);
				
				insertVO.setOrderNumber(orderId);
				
				String ml1 = request.getParameter("ml1");
				String ml2 = request.getParameter("ml2");
				String ml3 = request.getParameter("ml3");
				String ml4 = request.getParameter("ml4");
				String ml5 = request.getParameter("ml5");
				String ml6 = request.getParameter("ml6");
				String ml7 = request.getParameter("ml7");
				String ml8 = request.getParameter("ml8");
				String ml9 = request.getParameter("ml9");
				String ml10 = request.getParameter("ml10");
				String ml11 = request.getParameter("ml11");
				String ml12 = request.getParameter("ml12");
				String ml13 = request.getParameter("ml13");
				String ml14 = request.getParameter("ml14");
				insertVO.setMl1(ml1);
				insertVO.setMl2(ml2);
				insertVO.setMl3(ml3);
				insertVO.setMl4(ml4);
				insertVO.setMl5(ml5);
				insertVO.setMl6(ml6);
				insertVO.setMl7(ml7);
				insertVO.setMl8(ml8);
				insertVO.setMl9(ml9);
				insertVO.setMl10(ml10);
				insertVO.setMl11(ml11);
				insertVO.setMl12(ml12);
				insertVO.setMl13(ml13);
				insertVO.setMl14(ml14);
				
				String yt1 = request.getParameter("yt1");
				String yt2 = request.getParameter("yt2");
				String yt3 = request.getParameter("yt3");
				String yt4 = request.getParameter("yt4");
				String yt5 = request.getParameter("yt5");
				String yt6 = request.getParameter("yt6");
				String yt7 = request.getParameter("yt7");
				String yt8 = request.getParameter("yt8");
				String yt9 = request.getParameter("yt9");
				String yt10 = request.getParameter("yt10");
				String yt11 = request.getParameter("yt11");
				String yt12 = request.getParameter("yt12");
				String yt13 = request.getParameter("yt13");
				String yt14 = request.getParameter("yt14");
				insertVO.setYt1(yt1);
				insertVO.setYt2(yt2);
				insertVO.setYt3(yt3);
				insertVO.setYt4(yt4);
				insertVO.setYt5(yt5);
				insertVO.setYt6(yt6);
				insertVO.setYt7(yt7);
				insertVO.setYt8(yt8);
				insertVO.setYt9(yt9);
				insertVO.setYt10(yt10);
				insertVO.setYt11(yt11);
				insertVO.setYt12(yt12);
				insertVO.setYt13(yt13);
				insertVO.setYt13(yt14);
				
				String ms1 = request.getParameter("ms1");
				String ms2 = request.getParameter("ms2");
				String ms3 = request.getParameter("ms3");
				String ms4 = request.getParameter("ms4");
				String ms5 = request.getParameter("ms5");
				String ms6 = request.getParameter("ms6");
				String ms7 = request.getParameter("ms7");
				String ms8 = request.getParameter("ms8");
				String ms9 = request.getParameter("ms9");
				String ms10 = request.getParameter("ms10");
				String ms11 = request.getParameter("ms11");
				String ms12 = request.getParameter("ms12");
				String ms13 = request.getParameter("ms13");
				String ms14 = request.getParameter("ms14");
				insertVO.setMs1(ms1);
				insertVO.setMs2(ms2);
				insertVO.setMs3(ms3);
				insertVO.setMs4(ms4);
				insertVO.setMs5(ms5);
				insertVO.setMs6(ms6);
				insertVO.setMs7(ms7);
				insertVO.setMs8(ms8);
				insertVO.setMs9(ms9);
				insertVO.setMs10(ms10);
				insertVO.setMs11(ms11);
				insertVO.setMs12(ms12);
				insertVO.setMs13(ms13);
				insertVO.setMs14(ms14);
				
				
				String gys1 = request.getParameter("gys1");
				String gys2 = request.getParameter("gys2");
				String gys3 = request.getParameter("gys3");
				String gys4 = request.getParameter("gys4");
				String gys5 = request.getParameter("gys5");
				String gys6 = request.getParameter("gys6");
				String gys7 = request.getParameter("gys7");
				String gys8 = request.getParameter("gys8");
				String gys9 = request.getParameter("gys9");
				String gys10 = request.getParameter("gys10");
				String gys11 = request.getParameter("gys11");
				String gys12 = request.getParameter("gys12");
				String gys13 = request.getParameter("gys13");
				String gys14 = request.getParameter("gys14");
				insertVO.setGys1(gys1);
				insertVO.setGys2(gys2);
				insertVO.setGys3(gys3);
				insertVO.setGys4(gys4);
				insertVO.setGys5(gys5);
				insertVO.setGys6(gys6);
				insertVO.setGys7(gys7);
				insertVO.setGys8(gys8);
				insertVO.setGys9(gys9);
				insertVO.setGys10(gys10);
				insertVO.setGys11(gys11);
				insertVO.setGys12(gys12);
				insertVO.setGys13(gys13);
				insertVO.setGys14(gys14);
				
				
				String jq = request.getParameter("jg");
				String jq1 = request.getParameter("jg1");
				String jq2 = request.getParameter("jg2");
				String jq3 = request.getParameter("jg3");
				String jq4 = request.getParameter("jg4");
				String jq5 = request.getParameter("jg5");
				String jq6 = request.getParameter("jg6");
				String jq7 = request.getParameter("jg7");
				String jq8 = request.getParameter("jg8");
				String jq9 = request.getParameter("jg9");
				String jq10 = request.getParameter("jg10");
				String jq11 = request.getParameter("jg11");
				String jq12 = request.getParameter("jg12");
				String jq13 = request.getParameter("jg13");
				String jq14 = request.getParameter("jg14");
				
				System.err.println("jq1="+jq1);
				System.err.println("jq2="+jq2);
				System.err.println("jq3="+jq3);
				System.err.println("jq4="+jq4);
				System.err.println("jq5="+jq5);
				System.err.println("jq6="+jq6);
				System.err.println("jq7="+jq7);
				System.err.println("jq8="+jq8);
				System.err.println("jq9="+jq9);
				System.err.println("jq10="+jq10);
				System.err.println("jq11="+jq11);
				System.err.println("jq12="+jq12);
				System.err.println("jq13="+jq13);
				System.err.println("jq14="+jq14);
				
				insertVO.setJq(jq);
				insertVO.setJq1(jq1);
				insertVO.setJq2(jq2);
				insertVO.setJq3(jq3);
				insertVO.setJq4(jq4);
				insertVO.setJq5(jq5);
				insertVO.setJq6(jq6);
				insertVO.setJq7(jq7);
				insertVO.setJq8(jq8);
				insertVO.setJq9(jq9);
				insertVO.setJq10(jq10);
				insertVO.setJq11(jq11);
				insertVO.setJq12(jq12);
				insertVO.setJq13(jq13);
				insertVO.setJq14(jq14);
				
				
				ServiceBean.getInstance().getProjectInfoFacade()
				.insertPorjectInfoDuoyu(insertVO);
			//}
			
			
			
			System.out.println("tag="+tag);
			
			String userName = loginUser.getUserName();
			
			UserInfo uvo =new UserInfo();
			uvo.setCondition("userCode = '"+userName+"' limit 1");
			List<DataMap> listUo =  ServiceBean.getInstance().getUserInfoFacade().getUserInfo(uvo);
			if(listUo.size()>0){
				String role = listUo.get(0).get("code")+"";
				if("批单".equals(role)){
					if("1".equals(tag)){
						vo.setStatus("3");
					}else if("3".equals(tag)){
						vo.setStatus("4");
						vo.setTuihui_time(new Date());
					}else if("2".equals(tag)){
						vo.setStatus("5");
						vo.setPidan_time(new Date());
						
						 ChannelInfo chInfo = new ChannelInfo();
					       chInfo.setOrder_id(orderId);
					       chInfo.setPhone(kehuPhone);
					       chInfo.setAddTime(new Date());
					       chInfo.setRemark("【"+Utils.getnewTime()+"】【"+orderId+"】订单信息已经批核</br>(订单数据分析完成)！");
					     ServiceBean.getInstance().getChannelInfoFacade().insertChannelInfo(chInfo);
					}
					
					vo.setCondition("id='" + id + "'");
					ServiceBean.getInstance().getProjectInfoFacade()
							.updatePorjectInfo(vo);
				}else if("跟单".equals(role)){
					if("1".equals(tag)){
						vo.setStatus("6");
						vo.setGendan_fuze(loginUser.getUserName()+"");
					}else if("3".equals(tag)){
						vo.setStatus("8");
						vo.setGendan_fuze(loginUser.getUserName()+"");
					}else if("2".equals(tag)){
						vo.setStatus("9");
						vo.setGendan_fuze(loginUser.getUserName()+"");
						vo.setGendan_tijiao_time(new Date());
						
						//跟单提交
					
						
					}else if("4".equals(tag)){
						vo.setStatus("4");
						vo.setTuihui_time(new Date());
					}
				
					ServiceBean.getInstance().getProjectInfoFacade()
							.updatePorjectInfo(vo);
				}
			}
				
			
			
			
			
		
			
					
					ShareInfo vso = new ShareInfo(); 
					vso.setOrderNumber(orderNumber);
					vso.setOrderNumber1(orderNumber1);
					vso.setOrderNumber2(orderNumber2);
					vso.setOrderNumber3(orderNumber3);
					vso.setOrderNumber4(orderNumber4);
					vso.setOrderNumber5(orderNumber5);
					vso.setOrderNumber6(orderNumber6);
					vso.setOrderNumber7(orderNumber7);
					vso.setOrderNumber8(orderNumber8);
					vso.setOrderNumber9(orderNumber9);
					vso.setXsjg(salePrice);;
				vso.setXsjg1(xsjg1);
				vso.setXsjg2(xsjg2);
				vso.setXsjg3(xsjg3);
				vso.setXsjg4(xsjg4);
				vso.setXsjg5(xsjg5);
				vso.setXsjg6(xsjg6);
				vso.setXsjg7(xsjg7);
				vso.setXsjg8(xsjg8);
				vso.setXsjg9(xsjg9);
				vso.setAddhang(addhang);
				vso.setAddhang1(addhang1);
				vso.setOrder_id(orderId);
				
				ServiceBean.getInstance().getShareInfoFacade().insertShareInfo(vso);
			
			
			

			result.setBackPage(HttpTools.httpServletPath(request,
					"daiban"));
			result.setResultCode("updates");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"daiban"));
			if (e instanceof SystemException) { /* ����֪�쳣���н��� */
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else { /* ��δ֪�쳣���н�������ȫ�������δ֪�쳣 */
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}

	public ActionForward keFuTijiao(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {

		Result result = new Result();
		try {
			ProjectInfoForm form = (ProjectInfoForm) actionForm;

			ProjectInfo vo = new ProjectInfo();
			vo.setCondition("id='" + form.getId() + "'");
			vo.setStatus("2");
			ServiceBean.getInstance().getProjectInfoFacade()
					.updatePorjectInfo(vo);

			result.setBackPage(HttpTools.httpServletPath(request,
					"queryProjectInfoXml"));
			result.setResultCode("deletes");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryProjectInfoXml"));
			if (e instanceof SystemException) { /* ����֪�쳣���н��� */
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else { /* ��δ֪�쳣���н�������ȫ�������δ֪�쳣 */
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}

	public ActionForward pidanTuiHui(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {

		Result result = new Result();
		try {
			ProjectInfoForm form = (ProjectInfoForm) actionForm;

			ProjectInfo vo = new ProjectInfo();
			vo.setCondition("id='" + form.getId() + "'");
			vo.setStatus("4");
			vo.setTuihui_time(new Date());
			ServiceBean.getInstance().getProjectInfoFacade()
					.updatePorjectInfo(vo);

			result.setBackPage(HttpTools.httpServletPath(request,
					"queryProjectInfoXml"));
			result.setResultCode("deletes");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryProjectInfoXml"));
			if (e instanceof SystemException) { /* ����֪�쳣���н��� */
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else { /* ��δ֪�쳣���н�������ȫ�������δ֪�쳣 */
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}

	public ActionForward genDanTiJiao(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {

		Result result = new Result();
		try {
			LoginUser loginUser = (LoginUser) request.getSession()
					.getAttribute(Config.SystemConfig.LOGINUSER);
			if (loginUser == null) {
				return null;
			}
			
			ProjectInfoForm form = (ProjectInfoForm) actionForm;

			ProjectInfo vo = new ProjectInfo();
			vo.setCondition("id='" + form.getId() + "'");
			vo.setStatus("9");
			vo.setGendan_fuze(loginUser.getUserName()+"");
			vo.setGendan_tijiao_time(new Date());
			ServiceBean.getInstance().getProjectInfoFacade()
					.updatePorjectInfo(vo);

			result.setBackPage(HttpTools.httpServletPath(request,
					"queryProjectInfoXml"));
			result.setResultCode("deletes");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryProjectInfoXml"));
			if (e instanceof SystemException) { /* ����֪�쳣���н��� */
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else { /* ��δ֪�쳣���н�������ȫ�������δ֪�쳣 */
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}

	public ActionForward gendanTuiHui(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {

		Result result = new Result();
		try {
			LoginUser loginUser = (LoginUser) request.getSession()
					.getAttribute(Config.SystemConfig.LOGINUSER);
			if (loginUser == null) {
				return null;
			}
			
			ProjectInfoForm form = (ProjectInfoForm) actionForm;

			ProjectInfo vo = new ProjectInfo();
			vo.setCondition("id='" + form.getId() + "'");
			vo.setStatus("8");
			vo.setGendan_fuze(loginUser.getUserName()+"");
			vo.setTuihui_time(new Date());
			
			ServiceBean.getInstance().getProjectInfoFacade()
					.updatePorjectInfo(vo);

			result.setBackPage(HttpTools.httpServletPath(request,
					"queryProjectInfoXml"));
			result.setResultCode("deletes");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryProjectInfoXml"));
			if (e instanceof SystemException) { /* ����֪�쳣���н��� */
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else { /* ��δ֪�쳣���н�������ȫ�������δ֪�쳣 */
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}

	public ActionForward pidanTijiao(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {

		Result result = new Result();
		try {
			ProjectInfoForm form = (ProjectInfoForm) actionForm;

			ProjectInfo vo = new ProjectInfo();
			vo.setCondition("id='" + form.getId() + "'");
			vo.setStatus("5");
			vo.setPidan_time(new Date());
			ServiceBean.getInstance().getProjectInfoFacade()
					.updatePorjectInfo(vo);

			result.setBackPage(HttpTools.httpServletPath(request,
					"queryProjectInfoXml"));
			result.setResultCode("deletes");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryProjectInfoXml"));
			if (e instanceof SystemException) { /* ����֪�쳣���н��� */
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else { /* ��δ֪�쳣���н�������ȫ�������δ֪�쳣 */
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}

	public ActionForward piDanUpdateInit(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		LoginUser loginUser = (LoginUser) request.getSession().getAttribute(
				Config.SystemConfig.LOGINUSER);
		if (loginUser == null) {
			return null;
		}

		String userName = loginUser.getUserName();

		String id = request.getParameter("id");
		ProjectInfo vo = new ProjectInfo();
		vo.setCondition("id='" + id + "'");
	//	vo.setPidan_time(new Date());
		// ServiceBean.getInstance().getProjectInfoFacade().updatePorjectInfoDangAn(vo);
			
		List<DataMap> list = ServiceBean.getInstance().getProjectInfoFacade()
				.getProjectInfo(vo);
		if (list == null || list.size() == 0) {
			Result result = new Result();
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryProjectInfoXml"));
			result.setResultCode("rowDel");
			result.setResultType("success");
			return mapping.findForward("result");
		}
		request.setAttribute("projectInfo", list.get(0));

		return mapping.findForward("updateProjectInfoPiDan");

	}

	public ActionForward genDanUpdateInit(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		LoginUser loginUser = (LoginUser) request.getSession().getAttribute(
				Config.SystemConfig.LOGINUSER);
		if (loginUser == null) {
			return null;
		}

		// String userName = loginUser.getUserName();

		String id = request.getParameter("id");
		ProjectInfo vo = new ProjectInfo();
		vo.setCondition("id='" + id + "'");
		List<DataMap> list = ServiceBean.getInstance().getProjectInfoFacade()
				.getProjectInfo(vo);
		if (list == null || list.size() == 0) {
			Result result = new Result();
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryProjectInfoXml"));
			result.setResultCode("rowDel");
			result.setResultType("success");
			return mapping.findForward("result");
		}
		request.setAttribute("projectInfo", list.get(0));

		ProjectInfo voo = new ProjectInfo();
		List<DataMap> Clist = ServiceBean.getInstance().getProjectInfoFacade()
				.getProjectWatchInfo(voo);
		String sb = CommUtils.getPrintSelect(Clist, "project_no11",
				"project_no", "project_no", "", 1);
		request.setAttribute("companyList", sb);

		String sb1 = CommUtils.getPrintSelect(Clist, "project_no2",
				"project_no", "project_no", "", 1);

		request.setAttribute("companyList1", sb1);

		return mapping.findForward("updateProjectInfoGenDan");

	}
	
	
	public ActionForward xiangQing(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		LoginUser loginUser = (LoginUser) request.getSession().getAttribute(
				Config.SystemConfig.LOGINUSER);
		if (loginUser == null) {
			return null;
		}

		// String userName = loginUser.getUserName();

		String id = request.getParameter("id");
		ProjectInfo vo = new ProjectInfo();
		vo.setCondition("id='" + id + "'");
		List<DataMap> list = ServiceBean.getInstance().getProjectInfoFacade()
				.getProjectInfo(vo);
		if (list == null || list.size() == 0) {
			Result result = new Result();
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryProjectInfoXml"));
			result.setResultCode("rowDel");
			result.setResultType("success");
			return mapping.findForward("result");
		}
		request.setAttribute("projectInfo", list.get(0));
		
		String orderNumberOne = list.get(0).get("order_number")+"";
		
		String sale_price = list.get(0).get("sale_price")+"";
		request.setAttribute("sale_pricebb", sale_price);
		System.out.println("sale_price="+sale_price);
		if(sale_price.contains(",")){
			String cc= sale_price.split(",")[0];
			System.err.println("sale_pricebb="+cc);
			request.setAttribute("sale_pricebb",cc );
		}
		
		request.setAttribute("orderNumberOne", orderNumberOne);
		if(orderNumberOne.contains(",")){
			request.setAttribute("orderNumberOne", orderNumberOne.split(",")[0]);
		}
		
		String orderId = list.get(0).get("order_id")+"";
		DeviceActiveInfo vod = new DeviceActiveInfo();
		vod.setCondition("orderid = '" + orderId + "' limit 1");

		List<DataMap> downlist = ServiceBean.getInstance()
				.getDeviceActiveInfoFacade().getAllCallInfo(vod);
		String pngmoren ="http://47.111.148.8/watch/upload/test.png";
		if(downlist.size()>0){
			String fujian =downlist.get(0).get("fujian")+"";
	
			if("".equals(fujian) || fujian == null ||fujian.length()<10 ){
				request.setAttribute("fujian", "无");
			}else{
				request.setAttribute("fujian", downlist.get(0).get("fujian")+"");
			}
			
			String erweima_zip =downlist.get(0).get("erweima_zip")+"";
			
			if("".equals(erweima_zip) || erweima_zip == null ||erweima_zip.length()<10 ){
				request.setAttribute("erweima_zip", "无");
			}else{
				request.setAttribute("erweima_zip", downlist.get(0).get("erweima_zip")+"");
			}
			
		
            String erweima_1 =downlist.get(0).get("erweima_1")+"";
			if("".equals(erweima_1) || erweima_1 == null ||erweima_1.length()<10 ){
				request.setAttribute("erweima_1", pngmoren);
			}else{
				request.setAttribute("erweima_1", erweima_1);
			}
			 String erweima_2 =downlist.get(0).get("erweima_2")+"";
				if("".equals(erweima_2) || erweima_2 == null ||erweima_2.length()<10 ){
					request.setAttribute("erweima_2", pngmoren);
				}else{
					request.setAttribute("erweima_2", erweima_2);
				}
				 String erweima_3 =downlist.get(0).get("erweima_3")+"";
					if("".equals(erweima_3) || erweima_3 == null ||erweima_3.length()<10 ){
						request.setAttribute("erweima_3", pngmoren);
					}else{
						request.setAttribute("erweima_3", erweima_3);
					}
					String erweima_4 =downlist.get(0).get("erweima_4")+"";
					if("".equals(erweima_4) || erweima_4 == null ||erweima_4.length()<10 ){
						request.setAttribute("erweima_4", erweima_4);
					}else{
						request.setAttribute("erweima_4", erweima_4);
					}
				
			
			
		}else{
			request.setAttribute("erweima_1", pngmoren);
			request.setAttribute("erweima_2", pngmoren);
			request.setAttribute("erweima_3", pngmoren);
			request.setAttribute("erweima_4", pngmoren);
			request.setAttribute("fujian", "无");
			request.setAttribute("erweima_zip", "无");
		}
		
		ProjectInfo duoyu = new ProjectInfo();
		duoyu.setCondition("orderid='" + orderId + "' order by id desc limit 1");
		
		request.setAttribute("fuwei_quea", "");
		request.setAttribute("fuwei_queb", "");
		
		List<DataMap> listDuoyu = ServiceBean.getInstance().getProjectInfoFacade()
				.getProjectInfoDuoYu(duoyu);
		if(listDuoyu.size()>0){
			request.setAttribute("fuwei_quea", listDuoyu.get(0).get("fuwei_quea")+"");
			request.setAttribute("fuwei_queb", listDuoyu.get(0).get("fuwei_queb")+"");
			request.setAttribute("duoyu", listDuoyu.get(0));
		}
		
		ShareInfo vso = new ShareInfo(); 
		vso.setCondition("order_id='"+orderId+"' order by id desc limit 1");
		List<DataMap> listorderall = ServiceBean.getInstance().getShareInfoFacade().getShareInfo(vso);
		if(listorderall.size()>0){
			request.setAttribute("orderall", listorderall.get(0));
		}
		
	
		

		/*ProjectInfo voo = new ProjectInfo();
		List<DataMap> Clist = ServiceBean.getInstance().getProjectInfoFacade()
				.getProjectWatchInfo(voo);
		String sb = CommUtils.getPrintSelect(Clist, "project_no1",
				"project_no", "project_no", "", 1);
		request.setAttribute("companyList", sb);

		String sb1 = CommUtils.getPrintSelect(Clist, "project_no2",
				"project_no", "project_no", "", 1);

		request.setAttribute("companyList1", sb1);*/

		return mapping.findForward("xiangQing");

	}

	public ActionForward updateProjectInfopidan(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {

		Result result = new Result();
		try {

			LoginUser loginUser = (LoginUser) request.getSession()
					.getAttribute(Config.SystemConfig.LOGINUSER);
			if (loginUser == null) {
				return null;
			}

			
			String id = request.getParameter("id");

			ProjectInfo vo = new ProjectInfo();
			vo.setCondition("id='" + id + "'");
			String jiankuanA2 = request.getParameter("jiankuanA2");
			vo.setJiankuanA2(jiankuanA2);
			String lingweiB2 = request.getParameter("lingweiB2");
			vo.setLingweiB2(lingweiB2);
			String xiongweiA2 = request.getParameter("xiongweiA2");
			vo.setXiongweiA2(xiongweiA2);
			String xiongweiB22 = request.getParameter("xiongweiB22");
			vo.setXiongweiB22(xiongweiB22);
			String zhongyaoA2 = request.getParameter("zhongyaoA2");
			vo.setZhongyaoA2(zhongyaoA2);
			String zhongyaoB2 = request.getParameter("zhongyaoB2");
			vo.setZhongyaoB2(zhongyaoB2);
			String fuweiA2 = request.getParameter("fuweiA2");
			vo.setFuweiA2(fuweiA2);
			String fuweiB2 = request.getParameter("fuweiB2");
			vo.setFuweiB2(fuweiB2);
			String houzhongyichangA2 = request
					.getParameter("houzhongyichangA2");
			vo.setHouzhongyichangA2(houzhongyichangA2);
			String xiuchangB2 = request.getParameter("xiuchangB2");
			vo.setXiuchangB2(xiuchangB2);
			String qianyichangA2 = request.getParameter("qianyichangA2");
			vo.setQianyichangA2(qianyichangA2);
			String xiufeiB2 = request.getParameter("xiufeiB2");
			vo.setXiufeiB2(xiufeiB2);
			String xiuchangA2 = request.getParameter("xiuchangA2");
			vo.setXiuchangA2(xiuchangA2);
			String xiukouB2 = request.getParameter("xiukouB2");
			vo.setXiukouB2(xiukouB2);
			String lingkoukuaishiB2 = request.getParameter("lingkoukuaishiB2");
			vo.setLingkoukuaishiB2(lingkoukuaishiB2);
			String xiukouA2 = request.getParameter("xiukouA2");
			vo.setXiukouA2(xiukouA2);
			String yichangB2 = request.getParameter("yichangB2");
			vo.setYichangB2(yichangB2);
			String kuchangC2 = request.getParameter("kuchangC2");
			vo.setKuchangC2(kuchangC2);
			String xiongweiD2 = request.getParameter("xiongweiD2");
			vo.setXiongweiD2(xiongweiD2);
			String yaoweiC22 = request.getParameter("yaoweiC22");
			vo.setYaoweiC22(yaoweiC22);
			String zhongyaoD2 = request.getParameter("zhongyaoD2");
			vo.setZhongyaoD2(zhongyaoD2);
			String tuiweiC2 = request.getParameter("tuiweiC2");
			vo.setTuiweiC2(tuiweiC2);
			String yichangD2 = request.getParameter("yichangD2");
			vo.setYichangD2(yichangD2);
			String dangweiC2 = request.getParameter("dangweiC2");
			vo.setDangweiC2(dangweiC2);
			String datuiC2 = request.getParameter("datuiC2");
			vo.setDatuiC2(datuiC2);
			String zhongtuiC2 = request.getParameter("zhongtuiC2");
			vo.setZhongtuiC2(zhongtuiC2);
			String xiaotuiC2 = request.getParameter("xiaotuiC2");
			vo.setXiaotuiC2(xiaotuiC2);
			String tuikouC2 = request.getParameter("tuikouC2");
			vo.setTuikouC2(tuikouC2);
			String mi1 = request.getParameter("mi1");
			vo.setMi1(mi1);
			String mi2 = request.getParameter("mi2");
			vo.setMi2(mi2);

			String xiufeiA2 = request.getParameter("xiufeiA2");
			vo.setXiufeiA2(xiufeiA2);

			String pidanremark = request.getParameter("pidanremark");
			vo.setPidanremark(pidanremark);
			
			String yi_ma = request.getParameter("yi_ma");
			String chenshan_ma = request.getParameter("chenshan_ma");
			String ku_ma = request.getParameter("ku_ma");
			String majia_ma = request.getParameter("majia_ma");
			
			vo.setYi_ma(yi_ma);
			vo.setChenshan_ma(chenshan_ma);
			vo.setKu_ma(ku_ma);
			vo.setMajia_ma(majia_ma);

			ServiceBean.getInstance().getProjectInfoFacade()
					.updatePorjectInfoDangAn(vo);

			String tag = request.getParameter("tag");
			System.out.println("tag="+tag);
			if("1".equals(tag)){
				vo.setStatus("3");
			}else if("2".equals(tag)){
				vo.setStatus("4");
				vo.setTuihui_time(new Date());
			}else if("3".equals(tag)){
				vo.setStatus("5");
				vo.setPidan_time(new Date());
			}
			
			vo.setCondition("id='" + id + "'");
			ServiceBean.getInstance().getProjectInfoFacade()
					.updatePorjectInfo(vo);

			result.setBackPage(HttpTools.httpServletPath(request,
					"queryProjectInfoXml"));
			result.setResultCode("updates");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryProjectInfoXml"));
			if (e instanceof SystemException) { /* ����֪�쳣���н��� */
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else { /* ��δ֪�쳣���н�������ȫ�������δ֪�쳣 */
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}

	public ActionForward updateProjectInfoGenDan(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {

		Result result = new Result();
		try {

			LoginUser loginUser = (LoginUser) request.getSession()
					.getAttribute(Config.SystemConfig.LOGINUSER);
			if (loginUser == null) {
				return null;
			}

			String id = request.getParameter("id");
			String project_no1 = request.getParameter("project_no1");
			String project_no2 = request.getParameter("project_no2");

			ProjectInfo vo = new ProjectInfo();
			vo.setCondition("id='" + id + "'");
			vo.setGongyingshang1(project_no1);
			vo.setGongyingshang2(project_no2);
			String gdremark = request.getParameter("gdremark");
			vo.setGd_remark(gdremark);
			

			ServiceBean.getInstance().getProjectInfoFacade()
					.updatePorjectInfoDangAn(vo);

			String tag = request.getParameter("tag");
			
			vo.setCondition("id='" + id + "'");
			if("1".equals(tag)){
				vo.setStatus("6");
			}else if("2".equals(tag)){
				vo.setStatus("8");
			}else if("3".equals(tag)){
				vo.setStatus("9");
				vo.setGendan_fuze(loginUser.getUserName()+"");
				vo.setGendan_tijiao_time(new Date());
			}
			vo.setGendan_fuze(loginUser.getUserName()+"");
			ServiceBean.getInstance().getProjectInfoFacade()
					.updatePorjectInfo(vo);

			result.setBackPage(HttpTools.httpServletPath(request,
					"queryProjectInfoXml"));
			result.setResultCode("updates");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryProjectInfoXml"));
			if (e instanceof SystemException) { /* ����֪�쳣���н��� */
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else { /* ��δ֪�쳣���н�������ȫ�������δ֪�쳣 */
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}

	public ActionForward updatedangAnStatus(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {

		Result result = new Result();
		try {
			ProjectInfoForm form = (ProjectInfoForm) actionForm;
			
			ProjectInfo voStatus = new ProjectInfo();
			voStatus.setCondition("id='" + form.getId() + "'");
			String status = request.getParameter("status");
			voStatus.setStatus(status);

			if ("10".equals(status)) {
				
				
			     
			     
				voStatus.setJiaoLiaoTime(new Date());
				  String qianZhui = "D:/resin/webapps/watch/upload/photo/";
					
					ProjectInfo vo = new ProjectInfo();
					vo.setCondition("id='" + form.getId() + "'");
					String orderid = "";
					
					List<DataMap>  listOrder =ServiceBean.getInstance().getProjectInfoFacade().getProjectInfo(vo);
					DeviceActiveInfo vod = new DeviceActiveInfo();	
					if(listOrder.size()>0){
						orderid = listOrder.get(0).get("order_id")+"";
						
						String orderNumber = listOrder.get(0).get("order_number")+"";
						String kehuPhone = listOrder.get(0).get("kehu_phone")+"";
						
						 ChannelInfo chInfo = new ChannelInfo();
					       chInfo.setOrder_id(orderid);
					       chInfo.setPhone(kehuPhone);
					       chInfo.setAddTime(new Date());
					       chInfo.setRemark("【"+Utils.getnewTime()+"】【"+orderid+"】仓库已备料，发往【南京中央工厂】备裁.</br>(正在配备布料，长路漫漫，未来可期)!");
					     ServiceBean.getInstance().getChannelInfoFacade().insertChannelInfo(chInfo);
					     chInfo.setRemark("【"+Utils.getnewTime()+"】【"+orderid+"】订单已经做好全部制前准备，将送【南京中央工厂-二号车间】生产。</br>(所有准备工作完成！即将开始制作，所有美好的事物都值得等待)。");
					     ServiceBean.getInstance().getChannelInfoFacade().insertChannelInfo(chInfo);
					     

						String url = "http://47.111.148.8:80/watch/upload/zip/";
						String urlPhoto = "http://47.111.148.8:80/watch/upload/photo/"+orderid+"/";
						/*ProjectInfo fujianVo = new ProjectInfo();
						fujianVo.setCondition("id='" + form.getId() + "'")*/
						voStatus.setProjectName(url + orderid + ".zip");
						
								
						String nickName = listOrder.get(0).get("kehu_name")+"";
						String riqi = listOrder.get(0).get("add_time")+"";
						String yaowei = listOrder.get(0).get("yaowei_c")+"";
						
						String path= qianZhui + orderid;
						/*Constant.deleteFile(path);
						Constant.createFile(path);*/
					
						
						int xizhuang_number= Integer.valueOf(listOrder.get(0).get("xizhuang_number")+"");
						int chenshan_number= Integer.valueOf(listOrder.get(0).get("chenshan_number")+"");
						int xiku_number= Integer.valueOf(listOrder.get(0).get("xiku_number")+"");
						int majia_number= Integer.valueOf(listOrder.get(0).get("majia_number")+"");
						
				
					
						String photo1="";
						String photo2="";
						String photo3="";
						String photo4="";
						
						String baise = "D:/bai.png";
						
						String wechatUrlQian= "http://www.bzsxt.com/ClothesWechat/scan?state=";
						//String wechatUrlhou="#wechat_redirect";
						String xmlYuanPath = "D:/不一定制洗水标.xml";
						
						String Divpath = "D:/resin/webapps/watch/upload/photo/"+orderid+"/";// 文件保存路径
						
						File dirFile = new File(Divpath);
						
						if (!dirFile.exists()) {// 文件路径不存在时，自动创建目录
							dirFile.mkdir();
						}
						
					System.err.println("xizhuang_number="+xizhuang_number);
						
						if(xizhuang_number!=0){
							String text = wechatUrlQian+orderid+",1";
							// 嵌入二维码的图片路径
							// String imgPath = "F:/UI/test/1.png";
							String imgPath = "D:/1.png";
							// 生成的二维码的路径及名称
							String imgName =  "1.png";
							String destPath = path + "/" + imgName;
							photo1 = destPath;
							// 生成二维码
							QRCodeUtil.encode(text, imgPath, destPath, true);
							
							//QRCodeUtil.diErZhong(text,destPath);
							//GetExCel.writeExcelDaBiao("1",orderid, nickName, riqi, yaowei,destPath);
							
							  File source = new File(xmlYuanPath);//原复制文件
					    	  String lastName = Divpath + "1.xml";//复制到的地方路径和名称
					    	  File dest = new File(lastName);
					    	  TestFileManager.copyFileUsingFileChannels(source,dest);
					    	  ParseDomDocument.xmlReadDemo(lastName,orderid,nickName,riqi,yaowei,Base64Convert.GetImageStr(photo1),"西装");
					    	  ParseDomDocument.xmlReadDemopng(lastName,Base64Convert.GetImageStr(photo1));
					    	  File file = new File(lastName);
					    	  String lastNameddl = Divpath + "1.ddl";//最终修改的名称
					    	  file.renameTo(new File(lastNameddl));
							
							vod.setErweima_1(urlPhoto + "1.png");
							//http://47.111.148.8:80/watch/upload/zip/4.png
						}else{
							photo1 = baise;
						}
						if(chenshan_number!=0){
							String text = wechatUrlQian+orderid+",4";
							// 嵌入二维码的图片路径
							// String imgPath = "F:/UI/test/1.png";
							String imgPath = "D:/1.png";
							// 生成的二维码的路径及名称
							String imgName =  "2.png";
							String destPath = path + "/" + imgName;
							photo2 = destPath;
							// 生成二维码
							QRCodeUtil.encode(text, imgPath, destPath, true);
							//QRCodeUtil.diErZhong(text,destPath);
							//GetExCel.writeExcelDaBiao("2",orderid, nickName, riqi, yaowei,destPath);
							  File source = new File(xmlYuanPath);//原复制文件
					    	  String lastName = Divpath + "2.xml";//复制到的地方路径和名称
					    	  File dest = new File(lastName);
					    	  TestFileManager.copyFileUsingFileChannels(source,dest);
					    	  ParseDomDocument.xmlReadDemo(lastName,orderid,nickName,riqi,yaowei,Base64Convert.GetImageStr(photo2),"衬衫");
					    	  ParseDomDocument.xmlReadDemopng(lastName,Base64Convert.GetImageStr(photo2));
					    	  File file = new File(lastName);
					    	  String lastNameddl = Divpath + "2.ddl";//最终修改的名称
					    	  file.renameTo(new File(lastNameddl));
							
							vod.setErweima_2(urlPhoto + "2.png");
						}else{
							photo2 = baise;
						}
						if(xiku_number!=0){
							String text =wechatUrlQian+ orderid+",3";
							// 嵌入二维码的图片路径
							// String imgPath = "F:/UI/test/1.png";
							String imgPath = "D:/1.png";
							// 生成的二维码的路径及名称
							String imgName =  "3.png";
							String destPath = path + "/" + imgName;
							photo3 = destPath;
							// 生成二维码
							QRCodeUtil.encode(text, imgPath, destPath, true);
							//QRCodeUtil.diErZhong(text,destPath);
							//GetExCel.writeExcelDaBiao("3",orderid, nickName, riqi, yaowei,destPath);
							  File source = new File(xmlYuanPath);//原复制文件
					    	  String lastName = Divpath + "3.xml";//复制到的地方路径和名称
					    	  File dest = new File(lastName);
					    	  TestFileManager.copyFileUsingFileChannels(source,dest);
					    	  ParseDomDocument.xmlReadDemo(lastName,orderid,nickName,riqi,yaowei,Base64Convert.GetImageStr(photo3),"西裤");
					    	  ParseDomDocument.xmlReadDemopng(lastName,Base64Convert.GetImageStr(photo3));
					    	  File file = new File(lastName);
					    	  String lastNameddl = Divpath + "3.ddl";//最终修改的名称
					    	  file.renameTo(new File(lastNameddl));
							
							vod.setErweima_3(urlPhoto + "3.png");
						}else{
							photo3 = baise;
						}
						if(majia_number!=0){
							String text = wechatUrlQian+orderid+",2";
							// 嵌入二维码的图片路径
							// String imgPath = "F:/UI/test/1.png";
							String imgPath = "D:/1.png";
							// 生成的二维码的路径及名称
							String imgName =  "4.png";
							String destPath = path + "/" + imgName;
							photo4 = destPath;
							// 生成二维码
							QRCodeUtil.encode(text, imgPath, destPath, true);
							//QRCodeUtil.diErZhong(text,destPath);
						//	GetExCel.writeExcelDaBiao("4",orderid, nickName, riqi, yaowei,destPath);
							  File source = new File(xmlYuanPath);//原复制文件
					    	  String lastName = Divpath + "4.xml";//复制到的地方路径和名称
					    	  File dest = new File(lastName);
					    	  TestFileManager.copyFileUsingFileChannels(source,dest);
					    	  ParseDomDocument.xmlReadDemo(lastName,orderid,nickName,riqi,yaowei,Base64Convert.GetImageStr(photo4),"马甲");
					    	  ParseDomDocument.xmlReadDemopng(lastName,Base64Convert.GetImageStr(photo4));
					    	  File file = new File(lastName);
					    	  String lastNameddl = Divpath + "4.ddl";//最终修改的名称
					    	  file.renameTo(new File(lastNameddl));
							vod.setErweima_4(urlPhoto + "4.png");
						}else{
							photo4 = baise;
						}
						
						
						
						Map<String, Object> hs1 = new HashMap<>();
						Map<String, Object> hs2 = new HashMap<>();
						Map<String, Object> hs3 = new HashMap<>();
						Map<String, Object> hs4 = new HashMap<>();
						Map<String, Object> hs5 = new HashMap<>();
						Map<String, Object> hs6 = new HashMap<>();
						Map<String, Object> hs7 = new HashMap<>();
						Map<String, Object> hs8 = new HashMap<>();
						Map<String, Object> hs9 = new HashMap<>();
						Map<String, Object> hs10 = new HashMap<>();
						Map<String, Object> hs11 = new HashMap<>();
						Map<String, Object> hs12 = new HashMap<>();
						Map<String, Object> hs13 = new HashMap<>();
						Map<String, Object> hs14 = new HashMap<>();
						ProjectInfo duoyu = new ProjectInfo();
						duoyu.setCondition("orderid='" + orderid + "' order by id desc limit 1");
						List<DataMap> listDuoyu = ServiceBean.getInstance().getProjectInfoFacade()
								.getProjectInfoDuoYu(duoyu);
						if(listDuoyu.size()>0){
							String ml1 = listDuoyu.get(0).get("ml1")+"";
							if(!Utils.isEmpty(ml1)){
								hs1.put("ml", ml1);
								hs1.put("yt", listDuoyu.get(0).get("yt1")+"");
								hs1.put("ms", listDuoyu.get(0).get("ms1")+"");
								hs1.put("gys", listDuoyu.get(0).get("gys1")+"");
							}
							
							if(!Utils.isEmpty(listDuoyu.get(0).get("ml2")+"")){
								
								hs2.put("ml", listDuoyu.get(0).get("ml2")+"");
								hs2.put("yt", listDuoyu.get(0).get("yt2")+"");
								hs2.put("ms", listDuoyu.get(0).get("ms2")+"");
								hs2.put("gys", listDuoyu.get(0).get("gys2")+"");
							}
if(!Utils.isEmpty(listDuoyu.get(0).get("ml3")+"")){
								
	hs3.put("ml", listDuoyu.get(0).get("ml3")+"");
	hs3.put("yt", listDuoyu.get(0).get("yt3")+"");
	hs3.put("ms", listDuoyu.get(0).get("ms3")+"");
	hs3.put("gys", listDuoyu.get(0).get("gys3")+"");
							}

if(!Utils.isEmpty(listDuoyu.get(0).get("ml4")+"")){
	
	hs4.put("ml", listDuoyu.get(0).get("ml4")+"");
	hs4.put("yt", listDuoyu.get(0).get("yt4")+"");
	hs4.put("ms", listDuoyu.get(0).get("ms4")+"");
	hs4.put("gys", listDuoyu.get(0).get("gys4")+"");
}
if(!Utils.isEmpty(listDuoyu.get(0).get("ml5")+"")){
	
	hs5.put("ml", listDuoyu.get(0).get("ml5")+"");
	hs5.put("yt", listDuoyu.get(0).get("yt5")+"");
	hs5.put("ms", listDuoyu.get(0).get("ms5")+"");
	hs5.put("gys", listDuoyu.get(0).get("gys5")+"");
}

if(!Utils.isEmpty(listDuoyu.get(0).get("ml6")+"")){
	
	hs6.put("ml", listDuoyu.get(0).get("ml6")+"");
	hs6.put("yt", listDuoyu.get(0).get("yt6")+"");
	hs6.put("ms", listDuoyu.get(0).get("ms6")+"");
	hs6.put("gys", listDuoyu.get(0).get("gys6")+"");
}

if(!Utils.isEmpty(listDuoyu.get(0).get("ml7")+"")){
	
	hs7.put("ml", listDuoyu.get(0).get("ml7")+"");
	hs7.put("yt", listDuoyu.get(0).get("yt7")+"");
	hs7.put("ms", listDuoyu.get(0).get("ms7")+"");
	hs7.put("gys", listDuoyu.get(0).get("gys7")+"");
}

if(!Utils.isEmpty(listDuoyu.get(0).get("ml8")+"")){
	
	hs8.put("ml", listDuoyu.get(0).get("ml8")+"");
	hs8.put("yt", listDuoyu.get(0).get("yt8")+"");
	hs8.put("ms", listDuoyu.get(0).get("ms8")+"");
	hs8.put("gys", listDuoyu.get(0).get("gys8")+"");
}

if(!Utils.isEmpty(listDuoyu.get(0).get("ml9")+"")){
	
	hs9.put("ml", listDuoyu.get(0).get("ml9")+"");
	hs9.put("yt", listDuoyu.get(0).get("yt9")+"");
	hs9.put("ms", listDuoyu.get(0).get("ms9")+"");
	hs9.put("gys", listDuoyu.get(0).get("gys9")+"");
}

if(!Utils.isEmpty(listDuoyu.get(0).get("ml10")+"")){
	
	hs10.put("ml", listDuoyu.get(0).get("ml10")+"");
	hs10.put("yt", listDuoyu.get(0).get("yt10")+"");
	hs10.put("ms", listDuoyu.get(0).get("ms10")+"");
	hs10.put("gys", listDuoyu.get(0).get("gys10")+"");
}
if(!Utils.isEmpty(listDuoyu.get(0).get("ml11")+"")){
	
	hs11.put("ml", listDuoyu.get(0).get("ml11")+"");
	hs11.put("yt", listDuoyu.get(0).get("yt11")+"");
	hs11.put("ms", listDuoyu.get(0).get("ms11")+"");
	hs11.put("gys", listDuoyu.get(0).get("gys11")+"");
}
if(!Utils.isEmpty(listDuoyu.get(0).get("ml12")+"")){
	
	hs12.put("ml", listDuoyu.get(0).get("ml12")+"");
	hs12.put("yt", listDuoyu.get(0).get("yt12")+"");
	hs12.put("ms", listDuoyu.get(0).get("ms12")+"");
	hs12.put("gys", listDuoyu.get(0).get("gys12")+"");
}
if(!Utils.isEmpty(listDuoyu.get(0).get("ml13")+"")){
	
	hs13.put("ml", listDuoyu.get(0).get("ml13")+"");
	hs13.put("yt", listDuoyu.get(0).get("yt13")+"");
	hs13.put("ms", listDuoyu.get(0).get("ms13")+"");
	hs13.put("gys", listDuoyu.get(0).get("gys13")+"");
}//面料，用途，米数，供应商
if(!Utils.isEmpty(listDuoyu.get(0).get("ml14")+"")){
	
	hs14.put("ml", listDuoyu.get(0).get("ml14")+"");
	hs14.put("yt", listDuoyu.get(0).get("yt14")+"");
	hs14.put("ms", listDuoyu.get(0).get("ms14")+"");
	hs14.put("gys", listDuoyu.get(0).get("gys14")+"");
}
							
						}
 						
						
						
						ProjectInfo duoyuaa = new ProjectInfo();
						duoyuaa.setCondition("orderid='" + orderid + "' order by id desc limit 1");
						
						
						
						List<DataMap> listDuoyuaa = ServiceBean.getInstance().getProjectInfoFacade()
								.getProjectInfoDuoYu(duoyuaa);
						String que4 ="";
						if(listDuoyu.size()>0){
							
							 que4 =  listDuoyuaa.get(0).get("fuwei_queb")+"";
						
						}
						GetExCel.writeExcelXiangQing(orderid, 
								orderid,listOrder.get(0).get("qudao")+"",listOrder.get(0).get("age")+"",listOrder.get(0).get("kehu_phone")+"",
								listOrder.get(0).get("wechat")+"",listOrder.get(0).get("xiadan_kefu")+"",listOrder.get(0).get("sex")+"",listOrder.get(0).get("kehu_name")+"",
								listOrder.get(0).get("order_number")+"",listOrder.get(0).get("sale_price")+"",listOrder.get(0).get("height")+"",listOrder.get(0).get("weight")+"",
								listOrder.get(0).get("ww_name")+"",listOrder.get(0).get("add_time")+"",listOrder.get(0).get("address")+"",
								listOrder.get(0).get("order_type")+"",listOrder.get(0).get("jiaofu_time")+"",
								listOrder.get(0).get("xizhuang_number")+"",listOrder.get(0).get("yi_ma")+"",listOrder.get(0).get("chenshan_number")+"",listOrder.get(0).get("chenshan_ma")+"",
								listOrder.get(0).get("jiankuan_a")+"",listOrder.get(0).get("jiankuan_a2")+"",listOrder.get(0).get("lingwei_b")+"",listOrder.get(0).get("lingwei_b2")+"",
								listOrder.get(0).get("xiongwei_a")+"",listOrder.get(0).get("xiongwei_a2")+"",listOrder.get(0).get("xiongwei_b")+"",listOrder.get(0).get("xiongwei_2")+"",
								listOrder.get(0).get("zhongyao_a")+"",listOrder.get(0).get("zhongyao_a2")+"",listOrder.get(0).get("zhongyao_a")+"",listOrder.get(0).get("zhongyao_b2")+"",
								listOrder.get(0).get("fuwei_a")+"",listOrder.get(0).get("fuwei_a2")+"",listOrder.get(0).get("fuwei_b")+"",listOrder.get(0).get("fuwei_b2")+"",
								listOrder.get(0).get("houzhongyichang_a")+"",listOrder.get(0).get("houzhongyichang_a2")+"",listOrder.get(0).get("dakuang1")+"",listOrder.get(0).get("yichang_b2")+"",listOrder.get(0).get("dakuang2")+"",
								listOrder.get(0).get("qianyichang_a")+"",listOrder.get(0).get("qianyichang_a2")+"",listOrder.get(0).get("fuwei_b")+"",listOrder.get(0).get("fuwei_b2")+"",//腹围可能需要更改
								listOrder.get(0).get("xiuchang_b")+"",listOrder.get(0).get("xc_que")+"",listOrder.get(0).get("xiuchang_a")+"",listOrder.get(0).get("xiuchang_a2")+"",
								listOrder.get(0).get("xiufei_b")+"",listOrder.get(0).get("xiufei_b2")+"",listOrder.get(0).get("xiufei_a")+"","",
								listOrder.get(0).get("xiukou_b")+"",listOrder.get(0).get("xiukou_b2")+"",listOrder.get(0).get("xiukou_a")+"",listOrder.get(0).get("xiukou_a2")+"",
								listOrder.get(0).get("xiku_number")+"",listOrder.get(0).get("ku_ma")+"",listOrder.get(0).get("majia_number")+"",listOrder.get(0).get("majia_ma")+"",
								listOrder.get(0).get("yaowei_c")+"",listOrder.get(0).get("yaowei_c22")+"",listOrder.get(0).get("jiankuannew")+"",listOrder.get(0).get("jiankuanque")+"",
								listOrder.get(0).get("tuiwei_c")+"",listOrder.get(0).get("tuiwei_c2")+"",listOrder.get(0).get("xiongwei_d")+"",listOrder.get(0).get("xiongwei_d2")+"",
								listOrder.get(0).get("dangwei_c")+"",listOrder.get(0).get("dangwei_c2")+"",listOrder.get(0).get("zhongyao_d")+"",listOrder.get(0).get("yaowei_c2")+"",
								listOrder.get(0).get("datui_c")+"",listOrder.get(0).get("datui_c2")+"",listOrder.get(0).get("yichang_d")+"",listOrder.get(0).get("yichang_d2")+"",
								listOrder.get(0).get("zhongtui_c")+"",listOrder.get(0).get("zhongtui_c2")+"",listOrder.get(0).get("dakuang3")+"",listOrder.get(0).get("kuanxing_d")+"",listOrder.get(0).get("dakuang4")+"",
								listOrder.get(0).get("xiaotui_c")+"",listOrder.get(0).get("xiaotui_c2")+"",
								listOrder.get(0).get("kuchang_c")+"",listOrder.get(0).get("kuchang_c2")+"",
								listOrder.get(0).get("tuikou_c")+"",listOrder.get(0).get("tuikou_c2")+"",
								
								
								listOrder.get(0).get("kouxing_c")+"",listOrder.get(0).get("koudai_c")+"",	listOrder.get(0).get("kaicha")+"",listOrder.get(0).get("lingkoukuaishi_b")+"",
								listOrder.get(0).get("xiabai")+"",listOrder.get(0).get("zhuangse")+"",	listOrder.get(0).get("waizhubian")+"",listOrder.get(0).get("xiucha")+"",
								listOrder.get(0).get("kuyao")+"",listOrder.get(0).get("kuxing")+"",	listOrder.get(0).get("chenshanling")+"",listOrder.get(0).get("chenshanxiu")+"",

								listOrder.get(0).get("miao_liao1")+"",listOrder.get(0).get("yong_tu1")+"",	listOrder.get(0).get("mi1")+"",listOrder.get(0).get("gongyingshang_1")+"",
								listOrder.get(0).get("miao_liao2")+"",listOrder.get(0).get("yong_tu2")+"",	listOrder.get(0).get("mi2")+"",listOrder.get(0).get("gongyingshang_2")+"",
								
								listOrder.get(0).get("remark")+"",
								listOrder.get(0).get("pidan_remark")+"",
								listOrder.get(0).get("gd_remark")+""  ,
								photo1,photo2,photo3,photo4,
								hs1,
								hs2,
								hs3,
								hs4,
								hs5,
								hs6,
								hs7,
								hs8,
								hs9,
								hs10,
								hs11,
								hs12,
								hs13,
								hs14,
								listOrder.get(0).get("lingwei_b2")+"",
								listOrder.get(0).get("yichang_q")+"",
								listOrder.get(0).get("fuwei_queb")+"",
								listOrder.get(0).get("miao_liao2")+"",
								que4
								
								);
						
						if(xizhuang_number!=0 || chenshan_number!=0 || xiku_number!=0 || majia_number==0 ){
							String zipName = path + "/" + orderid + ".zip";
							String aa = "D:/resin/webapps/watch/upload/zip/"+orderid + ".zip";
							FileOutputStream fos1 = new FileOutputStream(new File(aa));
							System.out.println("path="+path);
							//System.out.println("zipName="+zipName);
							ZipUtils.toZip(path, fos1, true);
							//ZipUtils.toZip(path, fos1, true);
							
							
							/*String excelzipName = qianZhuiExcel + "/" + orderid + ".zip";
							FileOutputStream fos2 = new FileOutputStream(new File(excelzipName));
							ZipUtils.toZip(pathExcle, fos2, true);*/

						
							vod.setCondition("orderid = '" + orderid + "'");

							List<DataMap> list = ServiceBean.getInstance()
									.getDeviceActiveInfoFacade().getAllCallInfo(vod);

							// String url =
							// "http://localhost:8080/clothes/upload/photo/"+orderid+"/";
							vod.setErweima_zip(url + orderid + ".zip");
							vod.setDabiao_file(url + orderid + ".zip");
							if (list.size() > 0) {
								vod.setCondition("id='" + list.get(0).get("id") + "'");
								/*vod.setErweima_1(url + "1.png");
							
								vod.setErweima_3(url + "3.png");
								vod.setErweima_4(url + "4.png");*/
							
								ServiceBean.getInstance().getDeviceActiveInfoFacade()
										.updateCallInfo(vod);

							} else {
								vod.setOrderid(orderid);
								/*vod.setErweima_1(url + "1.png");
								vod.setErweima_2(url + "2.png");*/
								ServiceBean.getInstance().getDeviceActiveInfoFacade()
										.insertCallInfo(vod);
							}

							
							vo.setCondition("id='" + form.getId() + "'");
							vo.setFujian_url(url + orderid + ".zip");
						
							//vo.setSocketWay("1");
							/*ServiceBean.getInstance().getProjectInfoFacade()
									.updatePorjectInfo(vo);*/
							
						}		
						}
					
			}else if("11".equals(status)){
				System.out.println("打标-----------------------------------------------------------------");
			
			}else if("0".equals(status)){
				System.out.println("作废");
			}
			
          
			
			
			
			ServiceBean.getInstance().getProjectInfoFacade()
					.updatePorjectInfo(voStatus);
		

			result.setBackPage(HttpTools.httpServletPath(request,
					"queryProjectInfoXml"));
			result.setResultCode("deletes");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryProjectInfoXml"));
			if (e instanceof SystemException) { /* ����֪�쳣���н��� */
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else { /* ��δ֪�쳣���н�������ȫ�������δ֪�쳣 */
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}

	public ActionForward daDan(ActionMapping mapping, ActionForm actionForm,
			HttpServletRequest request, HttpServletResponse response) {
				return null;/*

		Result result = new Result();
		try {
			ProjectInfoForm form = (ProjectInfoForm) actionForm;

		
			String qianZhui = "D:/resin/webapps/watch/upload/photo/";
			
			ProjectInfo vo = new ProjectInfo();
			vo.setCondition("id='" + form.getId() + "'");
			String orderid = request.getParameter("orderid");
					
			List<DataMap>  listOrder =ServiceBean.getInstance().getProjectInfoFacade().getProjectInfo(vo);
			DeviceActiveInfo vod = new DeviceActiveInfo();
			
			if(listOrder.size()>0){
				
				String nickName = listOrder.get(0).get("kehu_name")+"";
				String riqi = listOrder.get(0).get("add_time")+"";
				String yaowei = listOrder.get(0).get("yaowei_c")+"";
				
				String path= qianZhui + orderid;
				Constant.deleteFile(path);
				Constant.createFile(path);
			
				
				int xizhuang_number= Integer.valueOf(listOrder.get(0).get("xizhuang_number")+"");
				int chenshan_number= Integer.valueOf(listOrder.get(0).get("chenshan_number")+"");
				int xiku_number= Integer.valueOf(listOrder.get(0).get("xiku_number")+"");
				int majia_number= Integer.valueOf(listOrder.get(0).get("majia_number")+"");
				
				String url = "http://47.111.148.8:80/watch/upload/photo/"+ orderid + "/";
			
				String photo1="";
				String photo2="";
				String photo3="";
				String photo4="";
				
				
				if(xizhuang_number!=0){
					String text = "测试内容";
					// 嵌入二维码的图片路径
					// String imgPath = "F:/UI/test/1.png";
					String imgPath = "D:/1.png";
					// 生成的二维码的路径及名称
					String imgName =  "1.png";
					String destPath = path + "/" + imgName;
					photo1 = destPath;
					// 生成二维码
					QRCodeUtil.encode(text, imgPath, destPath, true);
					
					GetExCel.writeExcelDaBiao("1",orderid, nickName, riqi, yaowei,destPath);
					vod.setErweima_1(url + "1.png");
				}
				if(chenshan_number!=0){
					String text = "测试内容";
					// 嵌入二维码的图片路径
					// String imgPath = "F:/UI/test/1.png";
					String imgPath = "D:/1.png";
					// 生成的二维码的路径及名称
					String imgName =  "2.png";
					String destPath = path + "/" + imgName;
					photo2 = destPath;
					// 生成二维码
					QRCodeUtil.encode(text, imgPath, destPath, true);
					
					GetExCel.writeExcelDaBiao("2",orderid, nickName, riqi, yaowei,destPath);
					vod.setErweima_2(url + "2.png");
				}
				if(xiku_number!=0){
					String text = "测试内容";
					// 嵌入二维码的图片路径
					// String imgPath = "F:/UI/test/1.png";
					String imgPath = "D:/1.png";
					// 生成的二维码的路径及名称
					String imgName =  "3.png";
					String destPath = path + "/" + imgName;
					photo3 = destPath;
					// 生成二维码
					QRCodeUtil.encode(text, imgPath, destPath, true);
					
					GetExCel.writeExcelDaBiao("3",orderid, nickName, riqi, yaowei,destPath);
					vod.setErweima_3(url + "3.png");
				}
				if(majia_number!=0){
					String text = "测试内容";
					// 嵌入二维码的图片路径
					// String imgPath = "F:/UI/test/1.png";
					String imgPath = "D:/1.png";
					// 生成的二维码的路径及名称
					String imgName =  "4.png";
					String destPath = path + "/" + imgName;
					photo4 = destPath;
					// 生成二维码
					QRCodeUtil.encode(text, imgPath, destPath, true);
					
					GetExCel.writeExcelDaBiao("4",orderid, nickName, riqi, yaowei,destPath);
					vod.setErweima_4(url + "4.png");
				}
				
				GetExCel.writeExcelXiangQing(orderid, 
						listOrder.get(0).get("order_id")+"",listOrder.get(0).get("qudao")+"",listOrder.get(0).get("age")+"",listOrder.get(0).get("kehu_phone")+"",
						listOrder.get(0).get("wechat")+"",listOrder.get(0).get("xiadan_kefu")+"",listOrder.get(0).get("sex")+"",listOrder.get(0).get("kehu_name")+"",
						listOrder.get(0).get("order_number")+"",listOrder.get(0).get("sale_price")+"",listOrder.get(0).get("height")+"",listOrder.get(0).get("weight")+"",
						listOrder.get(0).get("ww_name")+"",listOrder.get(0).get("add_time")+"",listOrder.get(0).get("address")+"",
						listOrder.get(0).get("order_type")+"",listOrder.get(0).get("jiaofu_time")+"",
						listOrder.get(0).get("xizhuang_number")+"",listOrder.get(0).get("yi_ma")+"",listOrder.get(0).get("chenshan_number")+"",listOrder.get(0).get("chenshan_ma")+"",
						listOrder.get(0).get("jiankuan_a")+"",listOrder.get(0).get("jiankuan_a2")+"",listOrder.get(0).get("lingwei_b")+"",listOrder.get(0).get("lingwei_b2")+"",
						listOrder.get(0).get("xiongwei_a")+"",listOrder.get(0).get("xiongwei_a2")+"",listOrder.get(0).get("xiongwei_b")+"",listOrder.get(0).get("xiongwei_2")+"",
						listOrder.get(0).get("zhongyao_a")+"",listOrder.get(0).get("zhongyao_a2")+"",listOrder.get(0).get("zhongyao_a")+"",listOrder.get(0).get("zhongyao_b2")+"",
						listOrder.get(0).get("fuwei_a")+"",listOrder.get(0).get("fuwei_a2")+"",listOrder.get(0).get("fuwei_b")+"",listOrder.get(0).get("fuwei_b2")+"",
						listOrder.get(0).get("houzhongyichang_a")+"",listOrder.get(0).get("houzhongyichang_a2")+"",listOrder.get(0).get("dakuang1")+"",listOrder.get(0).get("yichang_b2")+"",listOrder.get(0).get("dakuang2")+"",
						listOrder.get(0).get("qianyichang_a")+"",listOrder.get(0).get("qianyichang_a2")+"",listOrder.get(0).get("fuwei_b")+"",listOrder.get(0).get("fuwei_b2")+"",//腹围可能需要更改
						listOrder.get(0).get("xiuchang_b")+"",listOrder.get(0).get("xc_que")+"",listOrder.get(0).get("xiuchang_a")+"",listOrder.get(0).get("xiuchang_a2")+"",
						listOrder.get(0).get("xiufei_b")+"",listOrder.get(0).get("xiufei_b2")+"",listOrder.get(0).get("xiufei_a")+"","",
						listOrder.get(0).get("xiukou_b")+"",listOrder.get(0).get("xiukou_b2")+"",listOrder.get(0).get("xiukou_a")+"",listOrder.get(0).get("xiukou_a2")+"",
						listOrder.get(0).get("xiku_number")+"",listOrder.get(0).get("ku_ma")+"",listOrder.get(0).get("majia_number")+"",listOrder.get(0).get("majia_ma")+"",
						listOrder.get(0).get("yaowei_c")+"",listOrder.get(0).get("yaowei_c22")+"",listOrder.get(0).get("jiankuannew")+"",listOrder.get(0).get("jiankuanque")+"",
						listOrder.get(0).get("tuiwei_c")+"",listOrder.get(0).get("tuiwei_c2")+"",listOrder.get(0).get("xiongwei_d")+"",listOrder.get(0).get("xiongwei_d2")+"",
						listOrder.get(0).get("dangwei_c")+"",listOrder.get(0).get("dangwei_c2")+"",listOrder.get(0).get("zhongyao_d")+"",listOrder.get(0).get("yaowei_c2")+"",
						listOrder.get(0).get("datui_c")+"",listOrder.get(0).get("datui_c2")+"",listOrder.get(0).get("yichang_d")+"",listOrder.get(0).get("yichang_d2")+"",
						listOrder.get(0).get("zhongtui_c")+"",listOrder.get(0).get("zhongtui_c2")+"",listOrder.get(0).get("dakuang3")+"",listOrder.get(0).get("kuanxing_d")+"",listOrder.get(0).get("dakuang4")+"",
						listOrder.get(0).get("xiaotui_c")+"",listOrder.get(0).get("xiaotui_c2")+"",
						listOrder.get(0).get("kuchang_c")+"",listOrder.get(0).get("kuchang_c2")+"",
						listOrder.get(0).get("tuikou_c")+"",listOrder.get(0).get("tuikou_c2")+"",
						
						
						listOrder.get(0).get("kouxing_c")+"",listOrder.get(0).get("koudai_c")+"",	listOrder.get(0).get("kaicha")+"",listOrder.get(0).get("lingkoukuaishi_b")+"",
						listOrder.get(0).get("xiabai")+"",listOrder.get(0).get("zhuangse")+"",	listOrder.get(0).get("waizhubian")+"",listOrder.get(0).get("xiucha")+"",
						listOrder.get(0).get("kuyao")+"",listOrder.get(0).get("kuxing")+"",	listOrder.get(0).get("chenshanling")+"",listOrder.get(0).get("chenshanxiu")+"",

						listOrder.get(0).get("miao_liao1")+"",listOrder.get(0).get("yong_tu1")+"",	listOrder.get(0).get("mi1")+"",listOrder.get(0).get("gongyingshang_1")+"",
						listOrder.get(0).get("miao_liao2")+"",listOrder.get(0).get("yong_tu2")+"",	listOrder.get(0).get("mi2")+"",listOrder.get(0).get("gongyingshang_2")+"",
						
						listOrder.get(0).get("remark")+"",
						listOrder.get(0).get("pidan_remark")+"",
						listOrder.get(0).get("gd_remark")+""  ,
						photo1,photo2,photo3,photo4
						);
				
				if(xizhuang_number!=0 || chenshan_number!=0 || xiku_number!=0 || majia_number==0 ){
					String zipName = path + "/" + orderid + ".zip";
					FileOutputStream fos1 = new FileOutputStream(new File(zipName));
					ZipUtils.toZip(path, fos1, true);
					
					
					String excelzipName = qianZhuiExcel + "/" + orderid + ".zip";
					FileOutputStream fos2 = new FileOutputStream(new File(excelzipName));
					ZipUtils.toZip(pathExcle, fos2, true);

				
					vod.setCondition("orderid = '" + orderid + "'");

					List<DataMap> list = ServiceBean.getInstance()
							.getDeviceActiveInfoFacade().getAllCallInfo(vod);

					// String url =
					// "http://localhost:8080/clothes/upload/photo/"+orderid+"/";
					vod.setErweima_zip(url + orderid + ".zip");
					vod.setDabiao_file(url + orderid + ".zip");
					if (list.size() > 0) {
						vod.setCondition("id='" + list.get(0).get("id") + "'");
						vod.setErweima_1(url + "1.png");
					
						vod.setErweima_3(url + "3.png");
						vod.setErweima_4(url + "4.png");
					
						ServiceBean.getInstance().getDeviceActiveInfoFacade()
								.updateCallInfo(vod);

					} else {
						vod.setOrderid(orderid);
						vod.setErweima_1(url + "1.png");
						vod.setErweima_2(url + "2.png");
						ServiceBean.getInstance().getDeviceActiveInfoFacade()
								.insertCallInfo(vod);
					}

					
					vo.setCondition("id='" + form.getId() + "'");
					//vo.setSocketWay("1");
					ServiceBean.getInstance().getProjectInfoFacade()
							.updatePorjectInfo(vo);
					
				}		
				}
				
				
				
			
		

		

			result.setBackPage(HttpTools.httpServletPath(request,
					"queryProjectInfoXml"));
			result.setResultCode("deletes");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryProjectInfoXml"));
			if (e instanceof SystemException) {  ����֪�쳣���н��� 
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else {  ��δ֪�쳣���н�������ȫ�������δ֪�쳣 
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	*/}

}

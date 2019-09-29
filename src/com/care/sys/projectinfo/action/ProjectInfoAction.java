package com.care.sys.projectinfo.action;

import java.io.File;
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
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;

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
import com.care.common.lang.CommTools;
import com.care.common.lang.CommUtils;
import com.care.common.lang.Constant;
import com.care.common.lang.GetExCel;
import com.care.sys.companyinfo.domain.CompanyInfo;
import com.care.sys.deviceactiveinfo.domain.DeviceActiveInfo;
import com.care.sys.dynamicInfo.domain.DynamicInfo;
import com.care.sys.projectinfo.domain.ProjectInfo;
import com.care.sys.projectinfo.domain.logic.ProjectInfoFacade;
import com.care.sys.projectinfo.form.ProjectInfoForm;
import com.care.sys.userinfo.domain.UserInfo;
import com.care.sys.userinfo.domain.logic.UserInfoFacade;
import com.care.utils.QRCodeUtil;
import com.care.utils.ZipUtils;
import com.godoing.rose.http.common.HttpTools;
import com.godoing.rose.http.common.PagePys;
import com.godoing.rose.http.common.Result;
import com.godoing.rose.lang.DataList;
import com.godoing.rose.lang.DataMap;
import com.godoing.rose.lang.SystemException;
import com.godoing.rose.log.LogFactory;

public class ProjectInfoAction extends BaseAction {

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
							sb.append(" and status >=2 and status <=8  and status!=3 and status!=4 and status!=5 and status!=6 and status!=7    ");
						} else {
							sb.append("status >=2 and status <=8  and status!=4 and status!=5 and status!=6 and status!=7");
						}
					}else if("客服".equals(role)){
						if (sb.toString().length() > 0) {
							sb.append(" and xiadan_kefu ='" + userName + "' and status=4 ");
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
				sb.append(" and order_number ='" + orderId + "'");
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

		LoginUser loginUser = (LoginUser) request.getSession().getAttribute(
				Config.SystemConfig.LOGINUSER);
		if (loginUser == null) {
			return null;
		}

		String userName = loginUser.getUserName();
		
		request.setAttribute("userName", userName);
		
		 SimpleDateFormat df = new SimpleDateFormat("yyMMdd");
		 SimpleDateFormat yydf = new SimpleDateFormat("yyyyMMdd");
		 SimpleDateFormat yydfhh = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	     Calendar calendar = Calendar.getInstance();
	     
	  	String orderId ="";// 订单编号
		
		UserInfo uvo =new UserInfo();
		uvo.setCondition("userCode = '"+userName+"' limit 1");
		List<DataMap> listUo =  ServiceBean.getInstance().getUserInfoFacade().getUserInfo(uvo);
		
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
	    	request.setAttribute("dingdan", orderId);
	    	request.setAttribute("shijian", yydfhh.format(calendar.getTime()));
			return mapping.findForward("addProjectInfoxml");
		/*} else {
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
			request.setAttribute("fuwei_quea", listDuoyu.get(0).get("fuwei_quea")+"");
			request.setAttribute("fuwei_queb", listDuoyu.get(0).get("fuwei_queb")+"");
		}
		
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
		   int fileIsEmpty = 0;
			
			if (files != null & files.size() > 0) {
				
				//String qianZhui = "D:/resin/webapps/watch/upload/fujian/";
				String path = "D:/resin/webapps/watch/upload/fujian/" + orderId;
				
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

		/*	String ok = request.getParameter("okk");
			System.out.println("ok="+ok);*/
			System.out.println("按钮值="+request.getParameter("anniu"));
			String wwName = request.getParameter("projectNo");
			String salePrice = request.getParameter("salePrice");
			String wechat = request.getParameter("wechat");
			String orderNumber = request.getParameter("orderNumber");
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
			vo.setSalePrice(salePrice);
			vo.setWechat(wechat);
			vo.setOrderNumber(orderNumber);
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
			
			
			String jiaofu_time = request.getParameter("jiaofu_time");
			
			
			vo.setJiaofu_time(CommTools.getAddTime(Integer.valueOf(jiaofu_time)));
			
			
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
			
			String qianZhui = "D:/resin/webapps/watch/upload/fujian/";
			String path = qianZhui + orderId;
			ProjectInfoForm form = (ProjectInfoForm) actionForm;
			Hashtable<?, ?> files = form.getMultipartRequestHandler()
					.getFileElements();
			System.out.println("文件数量="+ files.size());
			if (files != null & files.size() > 0) {
				
				Constant.deleteFile(path);
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

			//vo.setOrderId(orderId);
			vo.setWwName(wwName);
			vo.setSalePrice(salePrice);
			vo.setWechat(wechat);
			vo.setOrderNumber(orderNumber);
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
			
			if(!"".equals(fuwei_quea) || !"".equals(fuwei_queb) ){
				ProjectInfo insertVO = new ProjectInfo();
				
				System.out.println("fuwei_quea="+fuwei_quea);
				insertVO.setFuwei_quea(fuwei_quea);
				
				insertVO.setFuwei_queb(fuwei_queb);
				System.out.println("fuwei_quea="+fuwei_queb);
				
				insertVO.setOrderNumber(orderId);
				
				ServiceBean.getInstance().getProjectInfoFacade()
				.insertPorjectInfoDuoyu(insertVO);
			}
			
			
			
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
					}
					
					vo.setCondition("id='" + id + "'");
					ServiceBean.getInstance().getProjectInfoFacade()
							.updatePorjectInfo(vo);
				}else if("跟单".equals(role)){
					if("1".equals(tag)){
						vo.setStatus("6");
					}else if("3".equals(tag)){
						vo.setStatus("8");
					}else if("2".equals(tag)){
						vo.setStatus("9");
						vo.setGendan_fuze(loginUser.getUserName()+"");
						vo.setGendan_tijiao_time(new Date());
					}
					vo.setGendan_fuze(loginUser.getUserName()+"");
					ServiceBean.getInstance().getProjectInfoFacade()
							.updatePorjectInfo(vo);
				}
			}
				
			
			
			
			

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
		
		String orderId = list.get(0).get("order_id")+"";
		DeviceActiveInfo vod = new DeviceActiveInfo();
		vod.setCondition("orderid = '" + orderId + "' limit 1");

		List<DataMap> downlist = ServiceBean.getInstance()
				.getDeviceActiveInfoFacade().getAllCallInfo(vod);
		
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
			
			
		}else{
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
			}else if("11".equals(status)){
				System.out.println("打标-----------------------------------------------------------------");
			
			}
			
            String qianZhui = "D:/resin/webapps/watch/upload/photo/";
			
			ProjectInfo vo = new ProjectInfo();
			vo.setCondition("id='" + form.getId() + "'");
			String orderid = "";
			
			List<DataMap>  listOrder =ServiceBean.getInstance().getProjectInfoFacade().getProjectInfo(vo);
			DeviceActiveInfo vod = new DeviceActiveInfo();	
			if(listOrder.size()>0){
				orderid = listOrder.get(0).get("order_id")+"";

				String url = "http://47.111.148.8:80/watch/upload/zip/";
				String urlPhoto = "http://47.111.148.8:80/watch/upload/photo/"+orderid+"/";
				/*ProjectInfo fujianVo = new ProjectInfo();
				fujianVo.setCondition("id='" + form.getId() + "'")*/
				voStatus.setProjectName(url + orderid + ".zip");
				
						
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
				
		
			
				String photo1="";
				String photo2="";
				String photo3="";
				String photo4="";
				
				String baise = "D:/bai.png";
				
				String wechatUrlQian= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx72e5182a29950eb2&redirect_uri=http%3A%2F%2Fwww.bzsxt.com%2FClothesWechat%2Fwechat_request&response_type=code&scope=snsapi_base&state=";
				String wechatUrlhou="#wechat_redirect";
				if(xizhuang_number!=0){
					String text = wechatUrlQian+orderid+",xizhuang"+wechatUrlhou;
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
					vod.setErweima_1(urlPhoto + "1.png");
					//http://47.111.148.8:80/watch/upload/zip/4.png
				}else{
					photo1 = baise;
				}
				if(chenshan_number!=0){
					String text = wechatUrlQian+orderid+",chenshan"+wechatUrlhou;
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
					vod.setErweima_2(urlPhoto + "2.png");
				}else{
					photo1 = baise;
				}
				if(xiku_number!=0){
					String text =wechatUrlQian+ orderid+",xiku"+wechatUrlhou;
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
					vod.setErweima_3(urlPhoto + "3.png");
				}else{
					photo1 = baise;
				}
				if(majia_number!=0){
					String text = wechatUrlQian+orderid+",majia"+wechatUrlhou;
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
					vod.setErweima_4(urlPhoto + "4.png");
				}else{
					photo1 = baise;
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

package com.care.sys.projectinfo.action;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.List;
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
import com.care.common.lang.CommUtils;
import com.care.common.lang.Constant;
import com.care.sys.companyinfo.domain.CompanyInfo;
import com.care.sys.projectinfo.domain.ProjectInfo;
import com.care.sys.projectinfo.domain.logic.ProjectInfoFacade;
import com.care.sys.projectinfo.form.ProjectInfoForm;
import com.care.sys.userinfo.domain.UserInfo;
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
    String photoPath="E:/resin/test/";
	// String photoUrl="http://localhost:8080/ads/photo/";

	//String photoPath = "/usr/local/resin-pro-4.0.53/webapps/ads/photo/";
	String photoUrl = "http://www.wiiteer.com:8999/ads/photo/";

	/*************************************************************************************************************/
	String clockskinName = "clockskin.xml";
	//String clockxmlpath = "E:/resin/resin-pro-4.0.53/webapps/ads/WIITE/biaopan/";
	String clockdownloadUrl = "http://www.wiiteer.com:8999/ads/WIITE/biaopan/";
  String clockxmlpath = "/usr/local/resin-pro-4.0.53/webapps/ads/WIITE/biaopan/";

	public ActionForward queryProjectInfoXml(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String href = request.getServletPath();
		Date start = new Date();
		Result result = new Result();// ���
		PagePys pys = new PagePys();// ҳ������
		DataList list = null; // ����ҳ��List ��logic itrate��ȡ��
		StringBuffer sb = new StringBuffer();// �����ַ�����
		ProjectInfoFacade info = ServiceBean.getInstance()
				.getProjectInfoFacade();// ����userApp������ȡ��user�ֵ䣩
		ProjectInfo pro = new ProjectInfo();

		try {
			LoginUser loginUser = (LoginUser) request.getSession()
					.getAttribute(Config.SystemConfig.LOGINUSER);
			if (loginUser == null) {
				return null;
			}

			String userName = loginUser.getUserName();

			String companyInfoId = loginUser.getCompanyId();
			String projectInfoId = loginUser.getProjectId();
			ProjectInfoForm form = (ProjectInfoForm) actionForm;
			ProjectInfo vo = new ProjectInfo();
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");
			String companyId = request.getParameter("companyId");
			String userId = request.getParameter("userId");
			String projectId = request.getParameter("projectId");

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

			/*CompanyInfo ci = new CompanyInfo();
			List<DataMap> coms = ServiceBean.getInstance()
					.getCompanyInfoFacade().getCompanyInfo(ci);
			request.setAttribute("company", coms);*/

			request.setAttribute("wwname", wwname);
			request.setAttribute("fNow_date", startTime);
			request.setAttribute("now_date", endTime);
			request.setAttribute("companyId", companyId);
			request.setAttribute("userId", userId);
			request.setAttribute("projectId", projectId);
			if (!"admin".equals(userName)) {
				if (sb.toString().length() > 0) {
					sb.append(" and p.heart_s ='" + userName
							+ "' AND p.project_no='" + userName + "'");
				} else {
					sb.append("p.heart_s ='" + userName
							+ "' AND p.project_no='" + userName + "'");
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
		//CommUtils.getIntervalTime(start, new Date(), href);
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
		if ("admin".equals(userName)) {
			return mapping.findForward("addProjectInfoxml");
		} else {
			return mapping.findForward("addProjectInfoxmlOther");
		}
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
		if ("admin".equals(userName)) {
			return mapping.findForward("updateProjectInfoxml");
		} else {
			return mapping.findForward("updateProjectInfoxmlOther");
		}
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
			ServiceBean.getInstance().getProjectInfoFacade()
					.updatePorjectInfo(vo);
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
			ServiceBean.getInstance().getProjectInfoFacade()
					.updatePorjectInfo(vo);
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
		PagePys pys = new PagePys();// ҳ������
		DataList list = null; // ����ҳ��List ��logic itrate��ȡ��
		StringBuffer sb = new StringBuffer();// �����ַ�����
		ProjectInfoFacade info = ServiceBean.getInstance()
				.getProjectInfoFacade();// ����userApp������ȡ��user�ֵ䣩
		ProjectInfo pro = new ProjectInfo();
		LoginUser loginUser = (LoginUser) request.getSession()
				.getAttribute(Config.SystemConfig.LOGINUSER);
		if (loginUser == null) {
			return null;
		}

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
			//sb.append("1=1");
			if (!"admin".equals(userName)) {
				UserInfo voa = new UserInfo();
				voa.setCondition("userCode ='"+userName+"'");
				List<DataMap> listt = ServiceBean.getInstance().getUserInfoFacade()
						.getUserInfo(voa); 
				if(listt.size()>0){
					String companys=listt.get(0).getAt("company_id")+"";
					if(!"0".equals(companys)){
					 String[] strArray =  companys.split(",");  
					 if(strArray.length>0){
							sb.append("(");
					for(int i=0;i<strArray.length;i++){
						if(strArray[i] != projectNo){
							if(strArray[i] != null && !"".equals(strArray[i])){
								if(sb.length()>1){
									sb.append(" or ");
								}
								sb.append("   p.project_no='" + strArray[i] + "'");
							}
						}
					}
					sb.append(" ) ");
				}else{
					if(sb.length()>0){
						sb.append(" or ");
					}
					sb.append("   p.project_no='" + userName + "'");
				}
				}else{
					if(sb.length()>0){
						sb.append(" and ");
					}
					sb.append("   p.project_no='" + userName + "'");
				}
				}
			
			}
			
			
			if (projectNo != null && !"".equals(projectNo)) {
				if(sb.length()<=0){
					sb.append(" p.project_no='" + projectNo + "'");
				}else{
					sb.append(" and p.project_no='" + projectNo + "'");
				}
			}
			if (project_name != null && !"".equals(project_name)) {
				if(sb.length()<=0){
					sb.append("p.project_name='" + project_name + "'");
				}else{
					sb.append(" and p.project_name='" + project_name + "'");
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
				if(sb.length()<=0){
					sb.append("p.status='" + 1 + "'");
				}else{
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
		if("admin".equals(userName)){
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
		String zipName="";
		String  fileName=Long.toString(new Date().getTime()) ;
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
						name = fileName+ fileFormat;
						System.out.println(name);
						if(name.contains(".zip")){
							zipName=name;
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
            String suoZaiDi  = request.getParameter("suozaidi");
            String phone  = request.getParameter("phone");
			vo.setAdTitle(suoZaiDi);
			vo.setAdDetail(phone);
			vo.setStatus("1");
			vo.setChannelId(phone);
			vo.setRemark(request.getParameter("remark"));
			
			 String addType  = request.getParameter("addType");
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
		if ("admin".equals(userName)) {
			return mapping.findForward("updateProjectWatchInfo");
		} else {
			return mapping.findForward("updateProjectWatchInfoOther");
		}
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
		String zipName="";
		String  fileName=Long.toString(new Date().getTime()) ;
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
						if(name.contains(".zip")){
							zipName=name;
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
			   String remark= request.getParameter("remark");
			   String adTitle= request.getParameter("adTitle");
			   
			   vo.setChannelId(channel_id);
			   vo.setRemark(remark);
			   vo.setAdTitle(adTitle);
			   
			   String addType= request.getParameter("addType");
			   
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
					if("0".equals(getProjectInfo.get(i).get("status") + "")){
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
					if("0".equals(getProjectInfo.get(i).get("status") + "")){
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
	//	String companyId = request.getParameter("companyId");
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
					.getFileElements();
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
			
			
			 String orderId = System.currentTimeMillis()+"";//订单编号
				String wwName =request.getParameter("projectNo"); 
				String salePrice =request.getParameter("salePrice"); 
				String wechat =request.getParameter("wechat"); 
				String orderNumber =request.getParameter("orderNumber"); 
				Date addTime =new Date();
				String kehuPhone =request.getParameter("kehuPhone"); 
				String orderType =request.getParameter("orderType"); 
				String kehuName =request.getParameter("kehuName"); 
				String qudao =request.getParameter("qudao"); 
			    String xiadanKeFu =loginUser.getUserName();
			    String address =request.getParameter("address"); 
			    String height =request.getParameter("height"); 
			    String weight =request.getParameter("weight"); 
			    String age =request.getParameter("age"); 
			    String sex =request.getParameter("sex"); 
			    String jiankuanA =request.getParameter("jiankuanA"); 
			    String lingweiB =request.getParameter("lingweiB"); 
			    String xiongweiA =request.getParameter("xiongweiA"); 
			    String xiongweiB =request.getParameter("xiongweiB"); 
			    String zhongyaoA =request.getParameter("zhongyaoA"); 
			    String zhongyaoB =request.getParameter("zhongyaoB"); 
			    String fuweiA =request.getParameter("fuweiA"); 
			    String fuweiB =request.getParameter("fuweiB"); 
			    String houzhongyichangA =request.getParameter("houzhongyichangA"); 
			    String xiuchangB =request.getParameter("xiuchangB"); 
			    String qianyichangA =request.getParameter("qianyichangA"); 
			    String xiufeiB =request.getParameter("xiufeiB"); 
			    String xiuchangA =request.getParameter("xiuchangA"); 
			    String xiukouB =request.getParameter("xiukouB"); 
			    String xiufeiA =request.getParameter("xiufeiA"); 
			    String lingkoukuaishiB =request.getParameter("lingkoukuaishiB"); 
			    String xiukouA =request.getParameter("xiukouA"); 
			    String yichangB =request.getParameter("yichangB"); 
			    String kuchangC =request.getParameter("kuchangC"); 
			    String xiongweiD =request.getParameter("xiongweiD"); 
			    String yaoweiC =request.getParameter("yaoweiC"); 
			    String zhongyaoD =request.getParameter("zhongyaoD"); 
			    String tuiweiC =request.getParameter("tuiweiC"); 
			    String yichangD =request.getParameter("yichangD"); 
			    String dangweiC =request.getParameter("dangweiC"); 
			    String datuiC =request.getParameter("datuiC"); 
			    String zhongtuiC =request.getParameter("zhongtuiC"); 
			    String xiaotuiC =request.getParameter("xiaotuiC"); 
			    String tuikouC =request.getParameter("tuikouC"); 
			    String kouxingC =request.getParameter("kouxingC"); 
			    String kouseC =request.getParameter("kouseC"); 
			    String kuanxingD =request.getParameter("kuanxingD"); 
			    String botouD =request.getParameter("botouD"); 
			    String koudaiC =request.getParameter("koudaiC"); 
			    String daigai =request.getParameter("daigai"); 
			    String pingxiedai =request.getParameter("pingxiedai"); 
			    String miaoliao1 =request.getParameter("miaoliao1"); 
			    String yongtu1 =request.getParameter("yongtu1"); 
			    String miaoliao2 =request.getParameter("miaoliao2"); 
			    String yongtu2 =request.getParameter("yongtu2"); 
			    String tixingremark =request.getParameter("tixingremark"); 
			    String remark =request.getParameter("remark"); 
			    

			ProjectInfoFacade facade = ServiceBean.getInstance()
					.getProjectInfoFacade();
			ProjectInfo vo = new ProjectInfo();
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
			vo.setStatus("1");
			//vo.setUpdateTime(addTime);
			vo.setSex(sex);
			
			vo.setLingkoukuaishiB(lingkoukuaishiB);
			vo.setXiukouA(xiukouA);
		
			facade.insertKeHuDangAnInfo(vo);
			

			result.setBackPage(HttpTools.httpServletPath(request, 
					"queryProjectInfoXml"));
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
			

			/*ProjectInfoForm form = (ProjectInfoForm) actionForm;
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
						InputStream in = file.getInputStream();
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

			}*/

			ProjectInfo vo = new ProjectInfo();
			vo.setCondition("id='" + id + "'");
			 String orderId = System.currentTimeMillis()+"";//订单编号
				String wwName =request.getParameter("projectNo"); 
				String salePrice =request.getParameter("salePrice"); 
				String wechat =request.getParameter("wechat"); 
				String orderNumber =request.getParameter("orderNumber"); 
				Date addTime =new Date();
				String kehuPhone =request.getParameter("kehuPhone"); 
				String orderType =request.getParameter("orderType"); 
				String kehuName =request.getParameter("kehuName"); 
				String qudao =request.getParameter("qudao"); 
			    String xiadanKeFu =loginUser.getUserName();
			    String address =request.getParameter("address"); 
			    String height =request.getParameter("height"); 
			    String weight =request.getParameter("weight"); 
			    String age =request.getParameter("age"); 
			    String sex =request.getParameter("sex"); 
			    String jiankuanA =request.getParameter("jiankuanA"); 
			    String lingweiB =request.getParameter("lingweiB"); 
			    String xiongweiA =request.getParameter("xiongweiA"); 
			    String xiongweiB =request.getParameter("xiongweiB"); 
			    String zhongyaoA =request.getParameter("zhongyaoA"); 
			    String zhongyaoB =request.getParameter("zhongyaoB"); 
			    String fuweiA =request.getParameter("fuweiA"); 
			    String fuweiB =request.getParameter("fuweiB"); 
			    String houzhongyichangA =request.getParameter("houzhongyichangA"); 
			    String xiuchangB =request.getParameter("xiuchangB"); 
			    String qianyichangA =request.getParameter("qianyichangA"); 
			    String xiufeiB =request.getParameter("xiufeiB"); 
			    String xiuchangA =request.getParameter("xiuchangA"); 
			    String xiukouB =request.getParameter("xiukouB"); 
			    String xiufeiA =request.getParameter("xiufeiA"); 
			    String lingkoukuaishiB =request.getParameter("lingkoukuaishiB"); 
			    String xiukouA =request.getParameter("xiukouA"); 
			    String yichangB =request.getParameter("yichangB"); 
			    String kuchangC =request.getParameter("kuchangC"); 
			    String xiongweiD =request.getParameter("xiongweiD"); 
			    String yaoweiC =request.getParameter("yaoweiC"); 
			    String zhongyaoD =request.getParameter("zhongyaoD"); 
			    String tuiweiC =request.getParameter("tuiweiC"); 
			    String yichangD =request.getParameter("yichangD"); 
			    String dangweiC =request.getParameter("dangweiC"); 
			    String datuiC =request.getParameter("datuiC"); 
			    String zhongtuiC =request.getParameter("zhongtuiC"); 
			    String xiaotuiC =request.getParameter("xiaotuiC"); 
			    String tuikouC =request.getParameter("tuikouC"); 
			    String kouxingC =request.getParameter("kouxingC"); 
			    String kouseC =request.getParameter("kouseC"); 
			    String kuanxingD =request.getParameter("kuanxingD"); 
			    String botouD =request.getParameter("botouD"); 
			    String koudaiC =request.getParameter("koudaiC"); 
			    String daigai =request.getParameter("daigai"); 
			    String pingxiedai =request.getParameter("pingxiedai"); 
			    String miaoliao1 =request.getParameter("miaoliao1"); 
			    String yongtu1 =request.getParameter("yongtu1"); 
			    String miaoliao2 =request.getParameter("miaoliao2"); 
			    String yongtu2 =request.getParameter("yongtu2"); 
			    String tixingremark =request.getParameter("tixingremark"); 
			    String remark =request.getParameter("remark"); 
			    

			
			
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
			vo.setStatus("1");
			//vo.setUpdateTime(addTime);
			vo.setSex(sex);
			
			vo.setLingkoukuaishiB(lingkoukuaishiB);
			vo.setXiukouA(xiukouA);
		
			ServiceBean.getInstance().getProjectInfoFacade()
					.updatePorjectInfoDangAn(vo);
		

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

}


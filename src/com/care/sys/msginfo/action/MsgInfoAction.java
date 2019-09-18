package com.care.sys.msginfo.action;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.logging.Log;
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
import com.care.sys.msginfo.domain.MsgInfo;
import com.care.sys.msginfo.domain.logic.MsgInfoFacade;
import com.care.sys.msginfo.form.MsgInfoForm;
import com.care.sys.projectinfo.domain.ProjectInfo;
import com.care.sys.projectinfo.domain.logic.ProjectInfoFacade;
import com.care.sys.projectinfo.form.ProjectInfoForm;
import com.care.sys.roleinfo.domain.RoleInfo;
import com.godoing.rose.http.common.HttpTools;
import com.godoing.rose.http.common.PagePys;
import com.godoing.rose.http.common.Result;
import com.godoing.rose.lang.DataList;
import com.godoing.rose.lang.DataMap;
import com.godoing.rose.lang.SystemException;
import com.godoing.rose.log.LogFactory;

public class MsgInfoAction extends BaseAction {

	Log logger = LogFactory.getLog(MsgInfoAction.class);
	
	
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
					response.getWriter().write("success");
				} else {
					response.getWriter().write("不存在该订单号");
					//response.getWriter().write("fail");
				}
			} catch (SystemException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	

	public ActionForward queryMsgInfo(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Date start = new Date();
		String href = request.getServletPath();
		Result result = new Result();// ���
		PagePys pys = new PagePys();// ҳ������
		DataList list = null; // ����ҳ��List ��logic itrate��ȡ��
		StringBuffer sb = new StringBuffer();// �����ַ�����
		MsgInfoFacade info = ServiceBean.getInstance().getMsgInfoFacade();// ����userApp������ȡ��user�ֵ䣩
		try {
			LoginUser loginUser = (LoginUser)request.getSession().getAttribute(Config.SystemConfig.LOGINUSER);
			if (loginUser == null) {
		            result.setBackPage(Config.INDEX_PAGE);
		           result.setResultCode("timeout");
		           result.setResultType("fail");
		           request.setAttribute("result", null);
		           return mapping.findForward("result");
			}
			String companyInfoId = loginUser.getCompanyId();
			String projectInfoId = loginUser.getProjectId();

			MsgInfoForm form = (MsgInfoForm) actionForm;
			MsgInfo vo = new MsgInfo();
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");
			String fromUserName = request.getParameter("fromUserName");
			String toUserName = request.getParameter("toUserName");
			String status = request.getParameter("statusSelect");
			String content = request.getParameter("content");
			String serieNo = request.getParameter("serieNo");
			String startTime1 = request.getParameter("startTime1");
			String endTime1 = request.getParameter("endTime1");
			String belongProject = request.getParameter("belongProject");

			/* ���û������ֶ� */
			form.setOrderBy("id");
			form.setSort("1");

			sb.append("1=1");
			if (!projectInfoId.equals("0")) {
				sb.append(" and m.belong_project in(" + projectInfoId + ")");
			} else {
				if (!companyInfoId.equals("0")) {
					ProjectInfo pro = new ProjectInfo();
					pro.setCondition("company_id in(" + companyInfoId + ")");
					List<DataMap> proList = ServiceBean.getInstance()
							.getProjectInfoFacade().getProjectInfo(pro);
					if (proList.size() > 0) {
						int num = proList.size();
						String str = "";
						for (int i = 0; i < num; i++) {
							Integer id = (Integer) proList.get(i).getAt("id");
							str += String.valueOf(id);
							if (i != num - 1) {
								str += ",";
							}
						}
						sb.append(" and m.belong_project in(" + str + ")");
					}
				}
			}
			if (fromUserName != null && !"".equals(fromUserName)) {
				sb.append(" and phone = '" + fromUserName + "'");
			}
			if (toUserName != null && !"".equals(toUserName)) {
				sb.append(" and a2.user_name = '" + toUserName + "'");
			}
			if (startTime != null && !"".equals(startTime)) {
				sb.append(" and substring(msg_handler_date,1,10) >= '"
						+ startTime + "'");
			}
			if (endTime != null && !"".equals(endTime)) {
				sb.append(" and substring(msg_handler_date,1,10) <= '"
						+ endTime + "'");
			}
			if (startTime1 != null && !"".equals(startTime1)) {
				sb.append(" and msg_handler_date >= '"
						+ startTime1 + "'");
			}
			if (endTime1 != null && !"".equals(endTime1)) {
				sb.append(" and msg_handler_date <= '" + endTime1
						+ "'");
			}
			if (status != null && !"".equals(status)) {
				sb.append(" and is_handler ='" + status + "'");
				request.setAttribute(
						"statusSelect",
						CommUtils.getSelectMess("statusSelect",
								Integer.parseInt(status)));
			}
			if (content != null && !"".equals(content)) {
				sb.append(" and msg_content like '%" + content + "%'");
			}
			if (serieNo != null && !"".equals(serieNo)) {
				sb.append(" and msg_content like '%" + serieNo + "%'");
			}
			if (belongProject != null && !"".equals(belongProject)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("m.belong_project = '" + belongProject + "'");
			}
			ProjectInfo pro = new ProjectInfo();
			List<DataMap> pros = ServiceBean.getInstance()
					.getProjectInfoFacade().getProjectInfo(pro);
			request.setAttribute("project_name", pros);

			request.setAttribute("fNow_date", startTime);
			request.setAttribute("now_date", endTime);
			request.setAttribute("fromUserName", fromUserName);
			request.setAttribute("toUserName", toUserName);
			request.setAttribute("content", content);
			request.setAttribute("serieNo", serieNo);
			request.setAttribute("fNow_date1", startTime1);
			request.setAttribute("now_date1", endTime1);
			request.setAttribute("belongProject", belongProject);

			vo.setCondition(sb.toString());

			BeanUtils.copyProperties(vo, form);
			list = info.getMsgInfoListByVo(vo);
			BeanUtils.copyProperties(pys, form);
			pys.setCounts(list.getTotalSize());
			/* ���û������ֶ� */

		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(Config.ABOUT_PAGE); /*
													 * ����Ϊ����ҳ�棬���Գ������ת��ϵͳĬ
													 * ��ҳ��
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
		CommUtils.getIntervalTime(start, new Date(), href);
		return mapping.findForward("queryMsgInfo");
	}
	
	public ActionForward initInsert(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		LoginUser loginUser = (LoginUser) request.getSession().getAttribute(
				Config.SystemConfig.LOGINUSER);
		if (loginUser == null) {
			return null;
		}

		String userName = loginUser.getUserName();
		
		request.setAttribute("username", userName);
		 SimpleDateFormat yydfhh = new SimpleDateFormat("yyyyMMdd HH:mm:ss");
	     Calendar calendar = Calendar.getInstance();
		request.setAttribute("shijian", yydfhh.format(calendar.getTime()));
		return mapping.findForward("insertMsgInfo");
	}
	
	public ActionForward insertMsgInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Result result = new Result();
		try {
			
			LoginUser loginUser = (LoginUser) request.getSession()
					.getAttribute(Config.SystemConfig.LOGINUSER);
			if (loginUser == null) {
				return null;
			}
			MsgInfo vo = new MsgInfo();
		/*	String order_id = request.getParameter("order_id");
			String phone = request.getParameter("phone");
			String fahuo_wuliu = request.getParameter("fahuo_wuliu");
			String wuliu_bianma = request.getParameter("wuliu_bianma");*/
			
			
			
			String orderNumber = request.getParameter("orderNumber");
			vo.setOrder_id(orderNumber);
			String userName = loginUser.getUserName();
			vo.setAdd_user(userName);
			String name = request.getParameter("name");
			vo.setName(name);
			String cishu = request.getParameter("cishu");
			vo.setCishu(cishu);
			vo.setMsgHandlerDate(new Date());
			String jiaofutime = request.getParameter("jiaofutime");
			vo.setJiaofutime(jiaofutime);
			String mi = request.getParameter("mi");
			vo.setMi(mi);
			String gongyingshang = request.getParameter("gongyingshang");
			vo.setGongyingshang(gongyingshang);
			String mianliao = request.getParameter("mianliao");
			vo.setMianliao(mianliao);
			String guize = request.getParameter("guize");
			vo.setGuize(guize);
			String remark = request.getParameter("remark");
			vo.setRemark(remark);
			
			
		
			
			vo.setIsHandler("0");
			ServiceBean.getInstance().getMsgInfoFacade().insertMsgInfo(vo);
			
			result.setBackPage(HttpTools.httpServletPath(request, // ����ɹ�����ת��ԭ��ҳ��
					"queryMsgInfo"));
			result.setResultCode("inserts"); // ���ò���Code
			result.setResultType("success"); // ���ò���ɹ�
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"initInsert"));
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
	

}

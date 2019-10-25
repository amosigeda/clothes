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
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

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
import com.care.common.lang.GetExCel;
import com.care.sys.channelinfo.domain.ChannelInfo;
import com.care.sys.dynamicInfo.domain.DynamicInfo;
import com.care.sys.dynamicInfo.form.DynamicInfoForm;
import com.care.sys.msginfo.domain.MsgInfo;
import com.care.sys.msginfo.domain.logic.MsgInfoFacade;
import com.care.sys.msginfo.form.MsgInfoForm;
import com.care.sys.projectinfo.domain.ProjectInfo;
import com.care.sys.projectinfo.domain.logic.ProjectInfoFacade;
import com.care.sys.projectinfo.form.ProjectInfoForm;
import com.care.sys.roleinfo.domain.RoleInfo;
import com.care.sys.userinfo.domain.UserInfo;
import com.care.utils.Utils;
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
			vo.setCondition("order_id ='" + userCode + "'");
			try {
				list = ServiceBean.getInstance()
						.getProjectInfoFacade().getProjectInfo(vo);
				if (!list.isEmpty()&&list.size()>0) {
					String name = list.get(0).get("kehu_name")+"";
					String phone = list.get(0).get("kehu_phone")+"";
					String address = list.get(0).get("address")+"";
					StringBuffer sb = new StringBuffer("fail");
					sb.append(";").append(name).append(";").append(phone).append(";").append(address);
					response.getWriter().write(sb.toString());
				} else {
					response.getWriter().write("success");
				}
					//response.getWriter().write("fail");
				
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
		Result result = new Result();// ���
		LoginUser loginUser = (LoginUser)request.getSession().getAttribute(Config.SystemConfig.LOGINUSER);
		if (loginUser == null) {
	           result.setBackPage(Config.INDEX_PAGE);
	           result.setResultCode("timeout");
	           result.setResultType("fail");
	           request.setAttribute("result", null);
	           return mapping.findForward("result");
		}
		
		Date start = new Date();
		String href = request.getServletPath();
	
		PagePys pys = new PagePys();// ҳ������
		DataList list = null; // ����ҳ��List ��logic itrate��ȡ��
		StringBuffer sb = new StringBuffer();// �����ַ�����
		MsgInfoFacade info = ServiceBean.getInstance().getMsgInfoFacade();// ����userApp������ȡ��user�ֵ䣩
		try {
		
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
			String order_id = request.getParameter("order_id");

			/* ���û������ֶ� */
			form.setOrderBy("id");
			form.setSort("1");

			sb.append("1=1");
			request.setAttribute("role","admin");
			String userName = loginUser.getUserName();
			UserInfo uvo =new UserInfo();
			uvo.setCondition("userCode = '"+userName+"' limit 1");
			List<DataMap> listUo =  ServiceBean.getInstance().getUserInfoFacade().getUserInfo(uvo);
			if(listUo.size()>0){
				String role = listUo.get(0).get("code")+"";
				request.setAttribute("role",role);
				/*if("客服".equals(role)){
					sb.append("    and add_user = '" + userName+"'");
				}else if("批单".equals(role)){
					sb.append("    and is_handler >= 2 and is_handler <= 3 ");
					//1客服保存 2客服提交 3批单保存 4批单提交  5跟单保存 6跟单提交 7跟单退回  8批单退回
				}else if("跟单".equals(role)){
					sb.append("    and is_handler >= 4 and is_handler <= 5   ");
				}*/
			}
			
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
			if (order_id != null && !"".equals(order_id)) {
				sb.append(" and order_id = '" + order_id + "'");
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
			request.setAttribute("order_id", order_id);

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

		ProjectInfo voo = new ProjectInfo();
		List<DataMap> Clist = ServiceBean.getInstance().getProjectInfoFacade()
				.getProjectWatchInfo(voo);
		String sb = CommUtils.getPrintSelect(Clist, "gongyingshang",
				"project_no", "project_no", "", 1);
		request.setAttribute("companyList", sb);
		
		String userName = loginUser.getUserName();
		
		request.setAttribute("username", userName);
		 SimpleDateFormat yydfhh = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	     Calendar calendar = Calendar.getInstance();
		request.setAttribute("shijian", yydfhh.format(calendar.getTime()));
		
		String gysall = CommUtils.getPrintSelectAll(Clist, "gys1","project_no", "project_no", "", 1);
		request.setAttribute("gysall", gysall);
		
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
		
			String item = request.getParameter("item");
			System.err.println("item="+item);
			
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
			String yongtu = request.getParameter("yongtu");
			vo.setYongtu(yongtu);
			
			String anniu = request.getParameter("anniu");
			String phone = request.getParameter("phone");
			System.out.println("按钮="+anniu);
			if("2".equals(anniu)){
				ChannelInfo chInfo = new ChannelInfo();
				chInfo.setOrder_id(orderNumber);
				chInfo.setPhone(phone);
				chInfo.setAddTime(new Date());
				chInfo.setRemark("【"
						+ new SimpleDateFormat(
								"yyyy-MM-dd HH:mm")
								.format(Calendar
										.getInstance()
										.getTime())
						+ "】【"
						+ orderNumber
						+ "】订单售后需求已收到，需求已入库，等待收到修改订单。<br/>（数据已经修正！正在核对修改数据内容！不要慌！问题不大。）");
				chInfo.setStatus("11");
				ServiceBean.getInstance()
						.getChannelInfoFacade()
						.insertChannelInfo(chInfo);
				
				ProjectInfo voStatus = new ProjectInfo();
				voStatus.setCondition("order_id='" + orderNumber + "'");

				voStatus.setStatus("31");
				ServiceBean.getInstance().getProjectInfoFacade()
				.updatePorjectInfo(voStatus);
				
			}
		
			
			vo.setIsHandler(anniu);
			
			String mianliao1 = request.getParameter("mianliao1");
			String mianliao2 = request.getParameter("mianliao2");
			String mianliao3 = request.getParameter("mianliao3");
			String mianliao4 = request.getParameter("mianliao4");
			String mianliao5 = request.getParameter("mianliao5");
			String mianliao6 = request.getParameter("mianliao6");
			String mianliao7 = request.getParameter("mianliao7");
			String mianliao8 = request.getParameter("mianliao8");
			String mianliao9 = request.getParameter("mianliao9");
			String mianliao10 = request.getParameter("mianliao10");
			String mianliao11 = request.getParameter("mianliao11");
			String mianliao12 = request.getParameter("mianliao12");
			String mianliao13 = request.getParameter("mianliao13");
			String mianliao14 = request.getParameter("mianliao14");
			
			vo.setMianliao1(mianliao1);
			vo.setMianliao2(mianliao2);
			vo.setMianliao3(mianliao3);
			vo.setMianliao4(mianliao4);
			vo.setMianliao5(mianliao5);
			vo.setMianliao6(mianliao6);
			vo.setMianliao7(mianliao7);
			vo.setMianliao8(mianliao8);
			vo.setMianliao9(mianliao9);
			vo.setMianliao10(mianliao10);
			vo.setMianliao11(mianliao11);
			vo.setMianliao12(mianliao12);
			vo.setMianliao13(mianliao13);
			vo.setMianliao14(mianliao14);
			
			
			String yongtu1 = request.getParameter("yongtu1");
			String yongtu2 = request.getParameter("yongtu2");
			String yongtu3 = request.getParameter("yongtu3");
			String yongtu4 = request.getParameter("yongtu4");
			String yongtu5 = request.getParameter("yongtu5");
			String yongtu6 = request.getParameter("yongtu6");
			String yongtu7 = request.getParameter("yongtu7");
			String yongtu8 = request.getParameter("yongtu8");
			String yongtu9 = request.getParameter("yongtu9");
			String yongtu10 = request.getParameter("yongtu10");
			String yongtu11 = request.getParameter("yongtu11");
			String yongtu12 = request.getParameter("yongtu12");
			String yongtu13 = request.getParameter("yongtu13");
			String yongtu14 = request.getParameter("yongtu14");
			
			vo.setYongtu1(yongtu1);
			vo.setYongtu2(yongtu2);
			vo.setYongtu3(yongtu3);
			vo.setYongtu4(yongtu4);
			vo.setYongtu5(yongtu5);
			vo.setYongtu6(yongtu6);
			vo.setYongtu7(yongtu7);
			vo.setYongtu8(yongtu8);
			vo.setYongtu9(yongtu9);
			vo.setYongtu10(yongtu10);
			vo.setYongtu11(yongtu11);
			vo.setYongtu12(yongtu12);
			vo.setYongtu13(yongtu13);
			vo.setYongtu14(yongtu14);
			
			
			String mi1 = request.getParameter("mi1");
			String mi2 = request.getParameter("mi2");
			String mi3 = request.getParameter("mi3");
			String mi4 = request.getParameter("mi4");
			String mi5 = request.getParameter("mi5");
			String mi6 = request.getParameter("mi6");
			String mi7 = request.getParameter("mi7");
			String mi8 = request.getParameter("mi8");
			String mi9 = request.getParameter("mi9");
			String mi10 = request.getParameter("mi10");
			String mi11 = request.getParameter("mi11");
			String mi12 = request.getParameter("mi12");
			String mi13 = request.getParameter("mi13");
			String mi14 = request.getParameter("mi14");
			
			vo.setMi1(mi1);
			vo.setMi2(mi2);
			vo.setMi3(mi3);
			vo.setMi4(mi4);
			vo.setMi5(mi5);
			vo.setMi6(mi6);
			vo.setMi7(mi7);
			vo.setMi8(mi8);
			vo.setMi9(mi9);
			vo.setMi10(mi10);
			vo.setMi11(mi11);
			vo.setMi12(mi12);
			vo.setMi13(mi13);
			vo.setMi14(mi14);
			
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
			
			vo.setGys1(gys1);
			vo.setGys2(gys2);
			vo.setGys3(gys3);
			vo.setGys4(gys4);
			vo.setGys5(gys5);
			vo.setGys6(gys6);
			vo.setGys7(gys7);
			vo.setGys8(gys8);
			vo.setGys9(gys9);
			vo.setGys10(gys10);
			vo.setGys11(gys11);
			vo.setGys12(gys12);
			vo.setGys13(gys13);
			vo.setGys14(gys14);
			
			
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
			vo.setJq(jq);
			vo.setJq1(jq1);
			vo.setJq2(jq2);
			vo.setJq3(jq3);
			vo.setJq4(jq4);
			vo.setJq5(jq5);
			vo.setJq6(jq6);
			vo.setJq7(jq7);
			vo.setJq8(jq8);
			vo.setJq9(jq9);
			vo.setJq10(jq10);
			vo.setJq11(jq11);
			vo.setJq12(jq12);
			vo.setJq13(jq13);
			vo.setJq14(jq14);
			//phone  item address  shouhou_type  jihui  fahuo  reson
			
			String address = request.getParameter("address");
			String shouhou_type = request.getParameter("shouhou_type");
			String jihui = request.getParameter("jihui");
			String fahuo = request.getParameter("fahuo");
			String reson = request.getParameter("reson");
			String item1 = request.getParameter("item1");
			String item2 = request.getParameter("item2");
			String item3 = request.getParameter("item3");
			String item4 = request.getParameter("item4");
			String item5 = request.getParameter("item5");
			
			vo.setPhone(phone);
			vo.setAddress(address);
			vo.setShouhou_type(shouhou_type);
			vo.setJihui(jihui);
			vo.setFahuo(fahuo);
			vo.setReson(reson);
			vo.setItem1(item1);
			vo.setItem2(item2);
			vo.setItem3(item3);
			vo.setItem4(item4);
			vo.setItem5(item5);
			
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
	
	public ActionForward initUpdate(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		LoginUser loginUser = (LoginUser) request.getSession().getAttribute(
				Config.SystemConfig.LOGINUSER);
		/*if (loginUser == null) {
			return null;
		}*/

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
		MsgInfo vo = new MsgInfo();
		vo.setCondition("id='" + id + "' limit 1");
		List<DataMap> list = ServiceBean.getInstance().getMsgInfoFacade().getMsgInfoByIdUpdate(vo);
		if (list == null || list.size() == 0) {
			Result result = new Result();
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryMsgInfo"));
			result.setResultCode("rowDel");
			result.setResultType("success");
			return mapping.findForward("result");
		}
		
		
		
		request.setAttribute("msgInfo", list.get(0));
		
		ProjectInfo voo = new ProjectInfo();
		List<DataMap> Clist = ServiceBean.getInstance().getProjectInfoFacade()
				.getProjectWatchInfo(voo);
		String sb = CommUtils.getPrintSelect(Clist, "project_no11",
				"project_no", "project_no", list.get(0).get("gongyingshang")+"", 1);
		request.setAttribute("companyList", sb);
		
		String gysall = CommUtils.getPrintSelectAll(Clist, "gys1","project_no", "project_no", "", 1);
		request.setAttribute("gysall", gysall);
		System.err.println(gysall);

		
			return mapping.findForward("a");
		/*	if ("admin".equals(userName)) {
		} else {
			return mapping.findForward("updateProjectInfoxmlOther");
		}*/
	}
	
	
	public ActionForward xiangqing(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		LoginUser loginUser = (LoginUser) request.getSession().getAttribute(
				Config.SystemConfig.LOGINUSER);
		/*if (loginUser == null) {
			return null;
		}*/

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
		MsgInfo vo = new MsgInfo();
		vo.setCondition("id='" + id + "' limit 1");
		List<DataMap> list = ServiceBean.getInstance().getMsgInfoFacade().getMsgInfoByIdUpdate(vo);
		if (list == null || list.size() == 0) {
			Result result = new Result();
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryMsgInfo"));
			result.setResultCode("rowDel");
			result.setResultType("success");
			return mapping.findForward("result");
		}
		
		
		
		request.setAttribute("msgInfo", list.get(0));
		
		ProjectInfo voo = new ProjectInfo();
		List<DataMap> Clist = ServiceBean.getInstance().getProjectInfoFacade()
				.getProjectWatchInfo(voo);
		String sb = CommUtils.getPrintSelect(Clist, "project_no11",
				"project_no", "project_no", list.get(0).get("gongyingshang")+"", 1);
		request.setAttribute("companyList", sb);
		
		String gysall = CommUtils.getPrintSelectAll(Clist, "gys1","project_no", "project_no", "", 1);
		request.setAttribute("gysall", gysall);
		System.err.println(gysall);

		
			return mapping.findForward("xiangqing");
		/*	if ("admin".equals(userName)) {
		} else {
			return mapping.findForward("updateProjectInfoxmlOther");
		}*/
	}
	
	
	public ActionForward updateMsgInfo(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {
		
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
			String id = request.getParameter("id");
			vo.setCondition("id='" + id + "'");
			
			/*String orderNumber = request.getParameter("orderNumber");
			vo.setOrder_id(orderNumber);
			String userName = loginUser.getUserName();
			vo.setAdd_user(userName);*/
			
		
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
			String yongtu = request.getParameter("yongtu");
			vo.setYongtu(yongtu);
			
			String anniu = request.getParameter("anniu");
			String orderNumber = request.getParameter("orderNumber");
			String phone = request.getParameter("phone");
			System.out.println("按钮="+anniu);
			String role = request.getParameter("role");
			System.out.println("角色="+role);
			if("1".equals(anniu)){
				if("客服".equals(role)){
					vo.setIsHandler("1");
				}else if("经理".equals(role)){
					vo.setIsHandler("1");
				}else if("批单".equals(role)){
					vo.setIsHandler("3");
				}else if("跟单".equals(role)){
					vo.setIsHandler("5");
				}
			}else if("2".equals(anniu)){

				if("客服".equals(role)||"经理".equals(role)){
					vo.setIsHandler("2");
					
					ChannelInfo chInfo = new ChannelInfo();
					chInfo.setOrder_id(orderNumber);
					chInfo.setPhone(phone);
					chInfo.setAddTime(new Date());
					chInfo.setRemark("【"
							+ new SimpleDateFormat(
									"yyyy-MM-dd HH:mm")
									.format(Calendar
											.getInstance()
											.getTime())
							+ "】【"
							+ orderNumber
							+ "】订单售后需求已收到，需求已入库，等待收到修改订单。<br/>（数据已经修正！正在核对修改数据内容！不要慌！问题不大。）");
					chInfo.setStatus("11");
					ServiceBean.getInstance()
							.getChannelInfoFacade()
							.insertChannelInfo(chInfo);
					
					ProjectInfo voStatus = new ProjectInfo();
					voStatus.setCondition("order_id='" + orderNumber + "'");

					voStatus.setStatus("31");
					ServiceBean.getInstance().getProjectInfoFacade()
					.updatePorjectInfo(voStatus);
					
				}else if("批单".equals(role)){
					vo.setIsHandler("4");
				}else if("跟单".equals(role)){
					vo.setIsHandler("6");
					
				}
			
			}
//1客服保存 2客服提交 3批单保存 4批单提交  5跟单保存 6跟单提交 7跟单退回  8批单退回
			
			
			String mianliao1 = request.getParameter("mianliao1");
			String mianliao2 = request.getParameter("mianliao2");
			String mianliao3 = request.getParameter("mianliao3");
			String mianliao4 = request.getParameter("mianliao4");
			String mianliao5 = request.getParameter("mianliao5");
			String mianliao6 = request.getParameter("mianliao6");
			String mianliao7 = request.getParameter("mianliao7");
			String mianliao8 = request.getParameter("mianliao8");
			String mianliao9 = request.getParameter("mianliao9");
			String mianliao10 = request.getParameter("mianliao10");
			String mianliao11 = request.getParameter("mianliao11");
			String mianliao12 = request.getParameter("mianliao12");
			String mianliao13 = request.getParameter("mianliao13");
			String mianliao14 = request.getParameter("mianliao14");
			
			vo.setMianliao1(mianliao1);
			vo.setMianliao2(mianliao2);
			vo.setMianliao3(mianliao3);
			vo.setMianliao4(mianliao4);
			vo.setMianliao5(mianliao5);
			vo.setMianliao6(mianliao6);
			vo.setMianliao7(mianliao7);
			vo.setMianliao8(mianliao8);
			vo.setMianliao9(mianliao9);
			vo.setMianliao10(mianliao10);
			vo.setMianliao11(mianliao11);
			vo.setMianliao12(mianliao12);
			vo.setMianliao13(mianliao13);
			vo.setMianliao14(mianliao14);
			
			
			String yongtu1 = request.getParameter("yongtu1");
			String yongtu2 = request.getParameter("yongtu2");
			String yongtu3 = request.getParameter("yongtu3");
			String yongtu4 = request.getParameter("yongtu4");
			String yongtu5 = request.getParameter("yongtu5");
			String yongtu6 = request.getParameter("yongtu6");
			String yongtu7 = request.getParameter("yongtu7");
			String yongtu8 = request.getParameter("yongtu8");
			String yongtu9 = request.getParameter("yongtu9");
			String yongtu10 = request.getParameter("yongtu10");
			String yongtu11 = request.getParameter("yongtu11");
			String yongtu12 = request.getParameter("yongtu12");
			String yongtu13 = request.getParameter("yongtu13");
			String yongtu14 = request.getParameter("yongtu14");
			
			vo.setYongtu1(yongtu1);
			vo.setYongtu2(yongtu2);
			vo.setYongtu3(yongtu3);
			vo.setYongtu4(yongtu4);
			vo.setYongtu5(yongtu5);
			vo.setYongtu6(yongtu6);
			vo.setYongtu7(yongtu7);
			vo.setYongtu8(yongtu8);
			vo.setYongtu9(yongtu9);
			vo.setYongtu10(yongtu10);
			vo.setYongtu11(yongtu11);
			vo.setYongtu12(yongtu12);
			vo.setYongtu13(yongtu13);
			vo.setYongtu14(yongtu14);
			
			
			String mi1 = request.getParameter("mi1");
			String mi2 = request.getParameter("mi2");
			String mi3 = request.getParameter("mi3");
			String mi4 = request.getParameter("mi4");
			String mi5 = request.getParameter("mi5");
			String mi6 = request.getParameter("mi6");
			String mi7 = request.getParameter("mi7");
			String mi8 = request.getParameter("mi8");
			String mi9 = request.getParameter("mi9");
			String mi10 = request.getParameter("mi10");
			String mi11 = request.getParameter("mi11");
			String mi12 = request.getParameter("mi12");
			String mi13 = request.getParameter("mi13");
			String mi14 = request.getParameter("mi14");
			
			vo.setMi1(mi1);
			vo.setMi2(mi2);
			vo.setMi3(mi3);
			vo.setMi4(mi4);
			vo.setMi5(mi5);
			vo.setMi6(mi6);
			vo.setMi7(mi7);
			vo.setMi8(mi8);
			vo.setMi9(mi9);
			vo.setMi10(mi10);
			vo.setMi11(mi11);
			vo.setMi12(mi12);
			vo.setMi13(mi13);
			vo.setMi14(mi14);
			
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
			
			vo.setGys1(gys1);
			vo.setGys2(gys2);
			vo.setGys3(gys3);
			vo.setGys4(gys4);
			vo.setGys5(gys5);
			vo.setGys6(gys6);
			vo.setGys7(gys7);
			vo.setGys8(gys8);
			vo.setGys9(gys9);
			vo.setGys10(gys10);
			vo.setGys11(gys11);
			vo.setGys12(gys12);
			vo.setGys13(gys13);
			vo.setGys14(gys14);
			
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
			vo.setJq(jq);
			vo.setJq1(jq1);
			vo.setJq2(jq2);
			vo.setJq3(jq3);
			vo.setJq4(jq4);
			vo.setJq5(jq5);
			vo.setJq6(jq6);
			vo.setJq7(jq7);
			vo.setJq8(jq8);
			vo.setJq9(jq9);
			vo.setJq10(jq10);
			vo.setJq11(jq11);
			vo.setJq12(jq12);
			vo.setJq13(jq13);
			vo.setJq14(jq14);
			//phone  item address  shouhou_type  jihui  fahuo  reson
			
		
			String address = request.getParameter("address");
			String shouhou_type = request.getParameter("shouhou_type");
			String jihui = request.getParameter("jihui");
			String fahuo = request.getParameter("fahuo");
			String reson = request.getParameter("reson");
			String item1 = request.getParameter("item1");
			String item2 = request.getParameter("item2");
			String item3 = request.getParameter("item3");
			String item4 = request.getParameter("item4");
			String item5 = request.getParameter("item5");
			
			vo.setPhone(phone);
			vo.setAddress(address);
			vo.setShouhou_type(shouhou_type);
			vo.setJihui(jihui);
			vo.setFahuo(fahuo);
			vo.setReson(reson);
			vo.setItem1(item1);
			vo.setItem2(item2);
			vo.setItem3(item3);
			vo.setItem4(item4);
			vo.setItem5(item5);
			
			
			
			ServiceBean.getInstance().getMsgInfoFacade().updateMsgInfo(vo);
			
			if("2".equals(anniu)&&"跟单".equals(role)){
				
				ChannelInfo chInfo = new ChannelInfo();
				chInfo.setOrder_id(orderNumber);
				chInfo.setPhone(phone);
				chInfo.setAddTime(new Date());
				chInfo.setRemark("【"
						+ new SimpleDateFormat(
								"yyyy-MM-dd HH:mm")
								.format(Calendar
										.getInstance()
										.getTime())
						+ "】【"
						+ orderNumber
						+ "】已经收到售后订单，开始准备修改。。<br/>（数据传输完成，问题不大，别慌，我们能赢！）");
				chInfo.setStatus("12");
				ServiceBean.getInstance()
						.getChannelInfoFacade()
						.insertChannelInfo(chInfo);
				ProjectInfo voStatus = new ProjectInfo();
				voStatus.setCondition("order_id='" + orderNumber + "'");

				voStatus.setStatus("32");
				ServiceBean.getInstance().getProjectInfoFacade()
				.updatePorjectInfo(voStatus);
				
				
				MsgInfo voDaYin = new MsgInfo();
				voDaYin.setCondition("id='" + id + "' limit 1");
				List<DataMap> listExcel = ServiceBean.getInstance().getMsgInfoFacade().getMsgInfoById(voDaYin);
				if(listExcel.size()>0){
					String orderId = listExcel.get(0).get("order_id")+"";
					StringBuffer sb =new StringBuffer();
					if(!Utils.isEmpty(listExcel.get(0).get("item1")+"")&&!"null1".equals(listExcel.get(0).get("item1")+"1")){
						sb.append(listExcel.get(0).get("item1")+"");
					}
					if(!Utils.isEmpty(listExcel.get(0).get("item2")+"")&&!"null1".equals(listExcel.get(0).get("item2")+"1")){
						if(sb.length()>0){
							sb.append(",");
						}
						sb.append(listExcel.get(0).get("item2")+"");
					}
					if(!Utils.isEmpty(listExcel.get(0).get("item3")+"")&&!"null1".equals(listExcel.get(0).get("item3")+"1")){
						if(sb.length()>0){
							sb.append(",");
						}
						sb.append(listExcel.get(0).get("item3")+"");
					}
					if(!Utils.isEmpty(listExcel.get(0).get("item4")+"")&&!"null1".equals(listExcel.get(0).get("item4")+"1")){
						if(sb.length()>0){
							sb.append(",");
						}
						sb.append(listExcel.get(0).get("item4")+"");
					}
					
					if(!Utils.isEmpty(listExcel.get(0).get("item5")+"")&&!"null1".equals(listExcel.get(0).get("item5")+"1")){
						if(sb.length()>0){
							sb.append(",");
						}
						sb.append(listExcel.get(0).get("item5")+"");
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
					
					if(!Utils.isEmpty(listExcel.get(0).get("mianliao1")+"")){
						hs1.put("ml", listExcel.get(0).get("mianliao1")+"");
						hs1.put("yt", listExcel.get(0).get("yongtu1")+"");
						hs1.put("ms", listExcel.get(0).get("mi1")+"");
						hs1.put("jg", listExcel.get(0).get("jg1")+"");
						hs1.put("gys", listExcel.get(0).get("gys1")+"");
					}
					if(!Utils.isEmpty(listExcel.get(0).get("mianliao2")+"")){
						hs2.put("ml", listExcel.get(0).get("mianliao2")+"");
						hs2.put("yt", listExcel.get(0).get("yongtu2")+"");
						hs2.put("ms", listExcel.get(0).get("mi2")+"");
						hs2.put("jg", listExcel.get(0).get("jg2")+"");
						hs2.put("gys", listExcel.get(0).get("gys2")+"");
					}
					if(!Utils.isEmpty(listExcel.get(0).get("mianliao3")+"")){
						hs3.put("ml", listExcel.get(0).get("mianliao3")+"");
						hs3.put("yt", listExcel.get(0).get("yongtu3")+"");
						hs3.put("ms", listExcel.get(0).get("mi3")+"");
						hs3.put("jg", listExcel.get(0).get("jg3")+"");
						hs3.put("gys", listExcel.get(0).get("gys3")+"");
					}
					if(!Utils.isEmpty(listExcel.get(0).get("mianliao4")+"")){
						hs4.put("ml", listExcel.get(0).get("mianliao4")+"");
						hs4.put("yt", listExcel.get(0).get("yongtu4")+"");
						hs4.put("ms", listExcel.get(0).get("mi4")+"");
						hs4.put("jg", listExcel.get(0).get("jg4")+"");
						hs4.put("gys", listExcel.get(0).get("gys4")+"");
					}
					if(!Utils.isEmpty(listExcel.get(0).get("mianliao5")+"")){
						hs5.put("ml", listExcel.get(0).get("mianliao5")+"");
						hs5.put("yt", listExcel.get(0).get("yongtu5")+"");
						hs5.put("ms", listExcel.get(0).get("mi5")+"");
						hs5.put("jg", listExcel.get(0).get("jg5")+"");
						hs5.put("gys", listExcel.get(0).get("gys5")+"");
					}
					
					if(!Utils.isEmpty(listExcel.get(0).get("mianliao6")+"")){
						hs6.put("ml", listExcel.get(0).get("mianliao6")+"");
						hs6.put("yt", listExcel.get(0).get("yongtu6")+"");
						hs6.put("ms", listExcel.get(0).get("mi6")+"");
						hs6.put("jg", listExcel.get(0).get("jg6")+"");
						hs6.put("gys", listExcel.get(0).get("gys6")+"");
					}
					if(!Utils.isEmpty(listExcel.get(0).get("mianliao7")+"")){
						hs7.put("ml", listExcel.get(0).get("mianliao7")+"");
						hs7.put("yt", listExcel.get(0).get("yongtu7")+"");
						hs7.put("ms", listExcel.get(0).get("mi7")+"");
						hs7.put("jg", listExcel.get(0).get("jg7")+"");
						hs7.put("gys", listExcel.get(0).get("gys7")+"");
					}
					if(!Utils.isEmpty(listExcel.get(0).get("mianliao8")+"")){
						hs8.put("ml", listExcel.get(0).get("mianliao8")+"");
						hs8.put("yt", listExcel.get(0).get("yongtu8")+"");
						hs8.put("ms", listExcel.get(0).get("mi8")+"");
						hs8.put("jg", listExcel.get(0).get("jg8")+"");
						hs8.put("gys", listExcel.get(0).get("gys8")+"");
					}
					if(!Utils.isEmpty(listExcel.get(0).get("mianliao9")+"")){
						hs9.put("ml", listExcel.get(0).get("mianliao9")+"");
						hs9.put("yt", listExcel.get(0).get("yongtu9")+"");
						hs9.put("ms", listExcel.get(0).get("mi9")+"");
						hs9.put("jg", listExcel.get(0).get("jg9")+"");
						hs9.put("gys", listExcel.get(0).get("gys9")+"");
					}
					if(!Utils.isEmpty(listExcel.get(0).get("mianliao10")+"")){
						hs10.put("ml", listExcel.get(0).get("mianliao10")+"");
						hs10.put("yt", listExcel.get(0).get("yongtu10")+"");
						hs10.put("ms", listExcel.get(0).get("mi10")+"");
						hs10.put("jg", listExcel.get(0).get("jg10")+"");
						hs10.put("gys", listExcel.get(0).get("gys10")+"");
					}
					if(!Utils.isEmpty(listExcel.get(0).get("mianliao11")+"")){
						hs11.put("ml", listExcel.get(0).get("mianliao11")+"");
						hs11.put("yt", listExcel.get(0).get("yongtu11")+"");
						hs11.put("ms", listExcel.get(0).get("mi11")+"");
						hs11.put("jg", listExcel.get(0).get("jg11")+"");
						hs11.put("gys", listExcel.get(0).get("gys11")+"");
					}
					if(!Utils.isEmpty(listExcel.get(0).get("mianliao12")+"")){
						hs12.put("ml", listExcel.get(0).get("mianliao12")+"");
						hs12.put("yt", listExcel.get(0).get("yongtu12")+"");
						hs12.put("ms", listExcel.get(0).get("mi12")+"");
						hs12.put("jg", listExcel.get(0).get("jg12")+"");
						hs12.put("gys", listExcel.get(0).get("gys12")+"");
					}
					if(!Utils.isEmpty(listExcel.get(0).get("mianliao13")+"")){
						hs13.put("ml", listExcel.get(0).get("mianliao13")+"");
						hs13.put("yt", listExcel.get(0).get("yongtu13")+"");
						hs13.put("ms", listExcel.get(0).get("mi13")+"");
						hs13.put("jg", listExcel.get(0).get("jg13")+"");
						hs13.put("gys", listExcel.get(0).get("gys13")+"");
					}
					if(!Utils.isEmpty(listExcel.get(0).get("mianliao14")+"")){
						hs14.put("ml", listExcel.get(0).get("mianliao14")+"");
						hs14.put("yt", listExcel.get(0).get("yongtu14")+"");
						hs14.put("ms", listExcel.get(0).get("mi14")+"");
						hs14.put("jg", listExcel.get(0).get("jg14")+"");
						hs14.put("gys", listExcel.get(0).get("gys14")+"");
					}
							
					GetExCel.writeExcelShouHou1024(
							orderId,
							orderId,
							listExcel.get(0).get("msg_handler_date")+"",
							listExcel.get(0).get("jiaofutime")+"",
							listExcel.get(0).get("name")+"",
							listExcel.get(0).get("phone")+"",
							sb.toString(),
							listExcel.get(0).get("address")+"",
							listExcel.get(0).get("shouhou_type")+"",
							listExcel.get(0).get("cishu")+"",
							listExcel.get(0).get("jihui")+"",
							listExcel.get(0).get("fahuo")+"",
							listExcel.get(0).get("reson")+"",
							listExcel.get(0).get("guize")+"",
							listExcel.get(0).get("mianliao")+"",
							listExcel.get(0).get("yongtu")+"",
							listExcel.get(0).get("mi")+"",
							listExcel.get(0).get("jq")+"",
							listExcel.get(0).get("gongyingshang")+"",
							listExcel.get(0).get("remark")+"",
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
							hs14
							
							);
					
					MsgInfo voexcel = new MsgInfo();
					voexcel.setUrl("http://47.111.148.8:80/watch/upload/shouhou/"+orderId+".xls");
					voexcel.setCondition("id='" + id + "'");
					ServiceBean.getInstance().getMsgInfoFacade().updateMsgInfo(voexcel);
					
				}
			}
			
			
			
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryMsgInfo"));
			result.setResultCode("updates");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryMsgInfo"));
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

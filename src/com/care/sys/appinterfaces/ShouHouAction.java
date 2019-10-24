package com.care.sys.appinterfaces;

/**
 * �ֻ��ϴ���Ϣ�ӿ�
 */
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.io.Writer;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.care.common.config.ServiceBean;
import com.care.common.http.BaseAction;
import com.care.common.lang.Constant;
import com.care.sys.appuserinfo.domain.AppUserInfo;
import com.care.sys.appuserinfo.domain.logic.AppUserInfoFacade;
import com.care.sys.channelinfo.domain.ChannelInfo;
import com.care.sys.deviceactiveinfo.domain.DeviceActiveInfo;
import com.care.sys.deviceactiveinfo.domain.logic.DeviceActiveInfoFacade;
import com.care.sys.locationinfo.domain.LocationInfo;
import com.care.sys.locationinfo.domain.logic.LocationInfoFacade;
import com.care.sys.projectinfo.domain.ProjectInfo;
import com.godoing.rose.lang.DataMap;
import com.godoing.rose.log.LogFactory;

public class ShouHouAction extends BaseAction {
	Log logger = LogFactory.getLog(setSportInfoAction.class);

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		request.setCharacterEncoding("UTF-8");
		String href = request.getServletPath();
		JSONObject json = new JSONObject();

		ServletInputStream input = request.getInputStream();
		BufferedReader reader = new BufferedReader(new InputStreamReader(input));
		StringBuffer sb = new StringBuffer();
		String online = "";

		while ((online = reader.readLine()) != null) {
			sb.append(online);
		}
		JSONObject object = JSONObject.fromObject(sb.toString());

		/*
		 * d、裁床-----，扫码，一扫码状态自动更新，流程下一步 1 2 E、前道开包-----，扫码 2 F、后道-----，扫码 3
		 * G、大汤-----，扫码4 F、质检-----，扫码 5
		 * G、发货-----，扫码，6需要填写物流单号，给客户发短信，短信内容暂定，至少要包含物流单号
		 */
		int zhijian = 10;
		ChannelInfo cvo = new ChannelInfo();
		try {
			String orderid = object.getString("orderid");
			String wechat = object.getString("wechat");
			System.out.println("wechat=" + wechat);
			String token = object.getString("token");
			String clothes_type = object.getString("clothesType");// xizhuang

			AppUserInfo vo = new AppUserInfo();

			vo.setCondition("  password = '" + wechat + "'   and token='"
					+ token + "'  order by id desc limit 1");
			List<DataMap> list = ServiceBean.getInstance()
					.getAppUserInfoFacade().getAppUserInfo(vo);
			if (list.size() > 0) {
				String status = list.get(0).get("status") + "";
				if ("1".equals(status)) {
					int typePerson = Integer.valueOf(list.get(0).get(
							"last_name")
							+ "");
					String phone = list.get(0).get("user_name") + "";
					String nickName = list.get(0).get("nick_name") + "";

					ProjectInfo voStatus = new ProjectInfo();
					voStatus.setCondition("order_id='" + orderid + "'");

					

					// 这个人的状态值
					if (typePerson == 7) {
						voStatus.setStatus("33");
						vo.setCondition("order_id='" + orderid
								+ "' and  clothes_type= '" + clothes_type
								+ "'   and last_name='7'   limit 1");
						List<DataMap> listSaoMa = ServiceBean.getInstance()
								.getAppUserInfoFacade().getSaoMaInfoNew(vo);

						if (listSaoMa.size() > 0) {
							result = 2;
						} else {

							vo.setPassword(wechat);
							vo.setNickName(nickName);
							vo.setCreateTime(new Date());
							vo.setLast_name(typePerson + "");
							vo.setOrder_id(orderid);
							vo.setClothes_type(clothes_type);
							vo.setUserName(phone);
							vo.setStatus("7");
							ServiceBean.getInstance().getAppUserInfoFacade()
									.insertSaoMaInfoNew(vo);
							zhijian = 11;
							result = Constant.SUCCESS_CODE;
							ServiceBean.getInstance().getProjectInfoFacade()
									.updatePorjectInfo(voStatus);

							cvo.setCondition("order_id = '" + orderid
									+ "' and  status='7' limit 1");
							List<DataMap> msgList = ServiceBean.getInstance()
									.getChannelInfoFacade().getChannelInfo(cvo);
							if (msgList.size() <= 0) {
								ProjectInfo pvo = new ProjectInfo();
								pvo.setCondition("order_id='" + orderid + "'");
								List<DataMap> listOrder = ServiceBean
										.getInstance().getProjectInfoFacade()
										.getProjectInfo(pvo);
								if (listOrder.size() > 0) {
									String orderNumber = listOrder.get(0).get(
											"order_id")
											+ "";
									String kehuPhone = listOrder.get(0).get(
											"kehu_phone")
											+ "";
									ChannelInfo chInfo = new ChannelInfo();
									chInfo.setOrder_id(orderNumber);
									chInfo.setPhone(kehuPhone);
									chInfo.setAddTime(new Date());
									chInfo.setRemark("【"
											+ new SimpleDateFormat(
													"yyyy-MM-dd HH:mm")
													.format(Calendar
															.getInstance()
															.getTime())
											+ "】【"
											+ orderNumber
											+ "】订单开始修改。<br/>（准备工作完成，现在开始修改！不要慌！慌也没用！）");
									chInfo.setStatus("7");
									ServiceBean.getInstance()
											.getChannelInfoFacade()
											.insertChannelInfo(chInfo);
								}
							}

						}

					} else if (typePerson == 5) {

						vo.setCondition("order_id='" + orderid
								+ "'  and  clothes_type= '" + clothes_type
								+ "'   and last_name='" + (typePerson - 1)
								+ "'   limit 1");
						List<DataMap> listSaoMa = ServiceBean.getInstance()
								.getAppUserInfoFacade().getSaoMaInfoNew(vo);

						if (listSaoMa.size() > 0) {
							
							vo.setCondition("order_id='" + orderid
									+ "'  and  clothes_type= '" + clothes_type
									+ "'   and last_name='" + typePerson 
									+ "'   limit 1");
							List<DataMap> listSaoMaa = ServiceBean.getInstance()
									.getAppUserInfoFacade().getSaoMaInfoNew(vo);
							
							if(listSaoMaa.size()<=0){
							
								vo.setPassword(wechat);
								vo.setNickName(nickName);
								vo.setCreateTime(new Date());
								vo.setLast_name(typePerson + "");
								vo.setOrder_id(orderid);
								vo.setClothes_type(clothes_type);
								vo.setUserName(phone);
								
								ServiceBean.getInstance().getAppUserInfoFacade()
										.insertSaoMaInfoNew(vo);
								zhijian=11;
								// 如果等于1说明有人扫过
								/*if (listSaoMa.size() == 1) {*/
								voStatus.setStatus("34");
									result = Constant.SUCCESS_CODE;
									ServiceBean.getInstance()
											.getProjectInfoFacade()
											.updatePorjectInfo(voStatus);

									cvo.setCondition("order_id = '" + orderid
											+ "' and status='8' limit 1");
									List<DataMap> msgList = ServiceBean
											.getInstance().getChannelInfoFacade()
											.getChannelInfo(cvo);
									if (msgList.size() <= 0) {
										ProjectInfo pvo = new ProjectInfo();
										pvo.setCondition("order_id='" + orderid
												+ "'");
										List<DataMap> listOrder = ServiceBean
												.getInstance()
												.getProjectInfoFacade()
												.getProjectInfo(pvo);
										if (listOrder.size() > 0) {
											String orderNumber = listOrder.get(0)
													.get("order_id") + "";
											String kehuPhone = listOrder.get(0)
													.get("kehu_phone") + "";
											ChannelInfo chInfo = new ChannelInfo();
											chInfo.setOrder_id(orderNumber);
											chInfo.setPhone(kehuPhone);
											chInfo.setAddTime(new Date());
											if (typePerson == 5) {
												chInfo.setRemark("【"
														+ new SimpleDateFormat(
																"yyyy-MM-dd HH:mm")
																.format(Calendar
																		.getInstance()
																		.getTime())
														+ "】【"
														+ orderNumber
														+ "】订单修改完毕，开始出厂质检程序。<br/>（（西装已经修改完成！质检小哥哥正在为你检查效果。）");
											} 
											chInfo.setStatus("8");
											ServiceBean.getInstance()
													.getChannelInfoFacade()
													.insertChannelInfo(chInfo);
										}
									}
								/*} else {
									result = Constant.SUCCESS_CODE;

								}*/
							}
						

						} else {
							result = Constant.FAIL_CODE;
						}

					} 

				} else {
					result = Constant.STATUSS_CODE;
				}

			} else {
				result = Constant.EXCEPTION_CODE;
			}

			if (result == 1) {
				System.out.println("走到这里了没");

				if(zhijian==11){
				AppUserInfo voNumber = new AppUserInfo();
				voNumber.setCondition("password ='" + wechat + "'   limit 1");
				List<DataMap> listSaoMaNumber = ServiceBean.getInstance()
						.getAppUserInfoFacade().getSaoMaInfo(voNumber);

				ProjectInfo pvo = new ProjectInfo();
				pvo.setCondition("order_id='" + orderid + "'");
				List<DataMap> listOrder = ServiceBean.getInstance()
						.getProjectInfoFacade().getProjectInfo(pvo);
				if (listOrder.size() > 0) {
					if (listSaoMaNumber.size() > 0) {
						String id = listSaoMaNumber.get(0).get("id") + "";
						Integer xzNumber = Integer.valueOf(listOrder.get(0)
								.get("xizhuang_number") + "")
								+ Integer.valueOf(listSaoMaNumber.get(0).get(
										"xizhuang_number")
										+ "");
						Integer csNumber = Integer.valueOf(listOrder.get(0)
								.get("chenshan_number") + "")
								+ Integer.valueOf(listSaoMaNumber.get(0).get(
										"chenshan_number")
										+ "");
						Integer xkNumber = Integer.valueOf(listOrder.get(0)
								.get("xiku_number") + "")
								+ Integer.valueOf(listSaoMaNumber.get(0).get(
										"xiku_number")
										+ "");
						Integer mjNumber = Integer.valueOf(listOrder.get(0)
								.get("majia_number") + "")
								+ Integer.valueOf(listSaoMaNumber.get(0).get(
										"majia_number")
										+ "");

						if ("1".equals(clothes_type)) {
							vo.setXizhuang_number(xzNumber);
						} else if ("3".equals(clothes_type)) {
							vo.setXiku_number(xkNumber);
						} else if ("4".equals(clothes_type)) {
							vo.setChenshan_number(csNumber);
						} else if ("2".equals(clothes_type)) {
							vo.setMajia_number(mjNumber);
						}
						vo.setCondition("id='" + id + "'");
						ServiceBean.getInstance().getAppUserInfoFacade()
								.updateSaoMaInfo(vo);

					} else {

						vo.setXizhuang_number(0);

						vo.setXiku_number(0);

						vo.setChenshan_number(0);

						vo.setMajia_number(0);

						Integer xzNumber = Integer.valueOf(listOrder.get(0)
								.get("xizhuang_number") + "");
						Integer csNumber = Integer.valueOf(listOrder.get(0)
								.get("chenshan_number") + "");
						Integer xkNumber = Integer.valueOf(listOrder.get(0)
								.get("xiku_number") + "");
						Integer mjNumber = Integer.valueOf(listOrder.get(0)
								.get("majia_number") + "");

						if ("1".equals(clothes_type)) {
							vo.setXizhuang_number(xzNumber);
						} else if ("3".equals(clothes_type)) {
							vo.setXiku_number(xkNumber);
						} else if ("4".equals(clothes_type)) {
							vo.setChenshan_number(csNumber);
						} else if ("2".equals(clothes_type)) {
							vo.setMajia_number(mjNumber);
						}
						ServiceBean.getInstance().getAppUserInfoFacade()
								.insertSaoMaInfo(vo);
					}
				}}

			}

		} catch (Exception e) {
			e.printStackTrace();
			StringBuffer sb1 = new StringBuffer();
			Writer writer = new StringWriter();
			PrintWriter printWriter = new PrintWriter(writer);
			Throwable cause = e.getCause();
			while (cause != null) {
				cause.printStackTrace(printWriter);
				cause = cause.getCause();
			}
			printWriter.close();
			String resultSb = writer.toString();
			sb1.append(resultSb);
			logger.error(e);
			result = Constant.EXCEPTION_CODE;
		}
		json.put("resultCode", result);

		json.put("request", href);
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(json.toString());
		return null;
	}

}

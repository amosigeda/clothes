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
import javax.transaction.xa.Xid;

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

public class SaoMaAction extends BaseAction {
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
			
			ProjectInfo pvoo = new ProjectInfo();
			pvoo.setCondition("order_id='" + orderid + "'");
			
			List<DataMap> listOrdero = ServiceBean.getInstance()
					.getProjectInfoFacade().getProjectInfo(pvoo);
			Integer xzNumberr = Integer.valueOf(listOrdero.get(0)
					.get("xizhuang_number") + "");
			Integer csNumberr = Integer.valueOf(listOrdero.get(0)
					.get("chenshan_number") + "");
			Integer xkNumberr = Integer.valueOf(listOrdero.get(0)
					.get("xiku_number") + "");
			Integer mjNumberr = Integer.valueOf(listOrdero.get(0)
					.get("majia_number") + "");
			

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

					voStatus.setStatus("2" + typePerson);

					// 这个人的状态值
					if (typePerson == 1) {

						vo.setCondition("order_id='" + orderid
								+ "' and  clothes_type= '" + clothes_type
								+ "'   and last_name='1'   limit 1");
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
							
							vo.setXizhuang_number(0);
							vo.setXiku_number(0);
							vo.setChenshan_number(0);
							vo.setMajia_number(0);
							
							if ("1".equals(clothes_type)) {
								vo.setXizhuang_number(xzNumberr);
							} else if ("3".equals(clothes_type)) {
								vo.setXiku_number(xkNumberr);
							} else if ("4".equals(clothes_type)) {
								vo.setChenshan_number(csNumberr);
							} else if ("2".equals(clothes_type)) {
								vo.setMajia_number(mjNumberr);
							}

							ServiceBean.getInstance().getAppUserInfoFacade()
									.insertSaoMaInfoNew(vo);
							zhijian = 11;
							result = Constant.SUCCESS_CODE;
							ServiceBean.getInstance().getProjectInfoFacade()
									.updatePorjectInfo(voStatus);

							cvo.setCondition("order_id = '" + orderid
									+ "' and  status='1' limit 1");
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
											+ "】已经开始裁剪</br>(剪裁师傅已经收到你的订单，并觉得你骨骼惊奇，是个穿西装的好苗子!)");
									chInfo.setStatus("1");
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
								
								vo.setXizhuang_number(0);
								vo.setXiku_number(0);
								vo.setChenshan_number(0);
								vo.setMajia_number(0);
								
								if ("1".equals(clothes_type)) {
									vo.setXizhuang_number(xzNumberr);
								} else if ("3".equals(clothes_type)) {
									vo.setXiku_number(xkNumberr);
								} else if ("4".equals(clothes_type)) {
									vo.setChenshan_number(csNumberr);
								} else if ("2".equals(clothes_type)) {
									vo.setMajia_number(mjNumberr);
								}
								ServiceBean.getInstance().getAppUserInfoFacade()
										.insertSaoMaInfoNew(vo);
								zhijian=11;
								// 如果等于1说明有人扫过
								/*if (listSaoMa.size() == 1) {*/
									result = Constant.SUCCESS_CODE;
									ServiceBean.getInstance()
											.getProjectInfoFacade()
											.updatePorjectInfo(voStatus);

									cvo.setCondition("order_id = '" + orderid
											+ "' and status='" +typePerson+"' limit 1");
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
														+ "】订单定型完毕，开始出厂质检程序。（现在我们正在给它仔细检查是否和我们的期待的效果一样");
											} else if (typePerson == 6) {
												chInfo.setRemark("【"
														+ new SimpleDateFormat(
																"yyyy-MM-dd HH:mm")
																.format(Calendar
																		.getInstance()
																		.getTime())
														+ "】【"
														+ orderNumber
														+ "】订单已通过质检流程，现已为您发货物流单号为【物流单号】</br>（顺丰特快）（西装在我们质检小哥哥的检查下已经成功盖章！现在由快递界的老大哥顺丰运输！安排上了！那些将要去的地方，都是素未谋面的故乡！）");
											}
											chInfo.setStatus(typePerson+"");
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

					} else {

						vo.setCondition("order_id='" + orderid
								+ "'  and  clothes_type= '" + clothes_type
								+ "'   and last_name='" + (typePerson - 1)
								+ "'   limit 1");
						List<DataMap> listSaoMa = ServiceBean.getInstance()
								.getAppUserInfoFacade().getSaoMaInfoNew(vo);

						if (listSaoMa.size() > 0) {

							vo.setCondition("order_id='" + orderid
									+ "' and   clothes_type= '" + clothes_type
									+ "'   and last_name='" + typePerson
									+ "'   limit 1");
							List<DataMap> listSaoMaEr = ServiceBean
									.getInstance().getAppUserInfoFacade()
									.getSaoMaInfoNew(vo);

							if (listSaoMaEr.size() > 0) {
								result = 2;
							} else {
								// vo.setUserName(phone);
								vo.setPassword(wechat);
								vo.setNickName(nickName);
								vo.setCreateTime(new Date());
								vo.setLast_name(typePerson + "");
								vo.setOrder_id(orderid);
								vo.setClothes_type(clothes_type);
								vo.setUserName(phone);
							

								vo.setXizhuang_number(0);
								vo.setXiku_number(0);
								vo.setChenshan_number(0);
								vo.setMajia_number(0);
								
								if ("1".equals(clothes_type)) {
									vo.setXizhuang_number(xzNumberr);
								} else if ("3".equals(clothes_type)) {
									vo.setXiku_number(xkNumberr);
								} else if ("4".equals(clothes_type)) {
									vo.setChenshan_number(csNumberr);
								} else if ("2".equals(clothes_type)) {
									vo.setMajia_number(mjNumberr);
								}
								ServiceBean.getInstance()
										.getAppUserInfoFacade()
										.insertSaoMaInfoNew(vo);
								zhijian=11;
								result = Constant.SUCCESS_CODE;
								ServiceBean.getInstance()
										.getProjectInfoFacade()
										.updatePorjectInfo(voStatus);

								cvo.setCondition("order_id = '" + orderid
										+ "' and status='" +typePerson+"' limit 1");
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
										if (typePerson == 2) {
											chInfo.setRemark("【"
													+ new SimpleDateFormat(
															"yyyy-MM-dd HH:mm")
															.format(Calendar
																	.getInstance()
																	.getTime())
													+ "】【"
													+ orderNumber
													+ "】订单已经开始前道制作工序。</br>（前道开包师傅开始作业，随口一句：看长身玉立，精神耿耿。必定以后事业有成！）");
											
										} else if (typePerson == 3) {
											chInfo.setRemark("【"
													+ new SimpleDateFormat(
															"yyyy-MM-dd HH:mm")
															.format(Calendar
																	.getInstance()
																	.getTime())
													+ "】【"
													+ orderNumber
													+ "】订单已经开始后道制作工序。</br>（后道师傅已经接手，制作工序已经到了最后的要紧关头！稳住我们能赢！）");
											chInfo.setStatus(clothes_type);
										} else if (typePerson == 4) {
											chInfo.setRemark("【"
													+ new SimpleDateFormat(
															"yyyy-MM-dd HH:mm")
															.format(Calendar
																	.getInstance()
																	.getTime())
													+ "】【"
													+ orderNumber
													+ "】订单已制作完毕，开始整烫定型。</br>（大烫师傅为了保证衣服的版型，正在给衣服做洗剪吹服务，tony老师已经开始整烫定型！）");
										}
										chInfo.setStatus(typePerson+"");
										ServiceBean.getInstance()
												.getChannelInfoFacade()
												.insertChannelInfo(chInfo);
									}

								}
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

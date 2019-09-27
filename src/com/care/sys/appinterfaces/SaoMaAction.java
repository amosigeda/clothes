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
d、裁床-----，扫码，一扫码状态自动更新，流程下一步  1
E、前道开包-----，扫码  2
F、后道-----，扫码  3
G、大汤-----，扫码4
F、质检-----，扫码 5
G、发货-----，扫码，6需要填写物流单号，给客户发短信，短信内容暂定，至少要包含物流单号*/
		
		try {
			String orderid = object.getString("orderid");
			String wechat = object.getString("wechat");
			String token = object.getString("token");
			String clothes_type = object.getString("clothesType");//xizhuang
			
			
			AppUserInfo vo = new AppUserInfo(); 
			
		
			
			
			vo.setCondition("  password = '"+wechat +  "'   and token='"+token+"'  limit 1");
			List<DataMap> list  = ServiceBean.getInstance().getAppUserInfoFacade().getAppUserInfo(vo);
			if(list.size()>0){
			int typePerson = Integer.valueOf(list.get(0).get("last_name")+"");
			//这个人的状态值
			if(typePerson == 1){
				
				vo.setCondition("order_id='"+orderid +"'  clothes_type= '"+clothes_type +  "'   and last_name='1'   limit 1");
				List<DataMap> listSaoMa  = ServiceBean.getInstance().getAppUserInfoFacade().getSaoMaInfo(vo);
				
				if(listSaoMa.size()>0){
					result = Constant.FAIL_CODE;
				}else{
					//vo.setUserName(phone);
					vo.setPassword(wechat);
					vo.setNickName(list.get(0).get("nick_name")+"");
					vo.setCreateTime(new Date());
					vo.setLast_name(typePerson+"");
					vo.setOrder_id(orderid);
					vo.setClothes_type(clothes_type);
					
					ServiceBean.getInstance().getAppUserInfoFacade().insertSaoMaInfo(vo);
					result = Constant.SUCCESS_CODE;
				}
				
				
			}else if(typePerson == 5 || typePerson == 6){


				
				vo.setCondition("order_id='"+orderid +"'  clothes_type= '"+clothes_type +  "'   and last_name='"+(typePerson-1)+"'   limit 1");
				List<DataMap> listSaoMa  = ServiceBean.getInstance().getAppUserInfoFacade().getSaoMaInfo(vo);
				
				if(listSaoMa.size()>0){
					//vo.setUserName(phone);
					vo.setPassword(wechat);
					vo.setNickName(list.get(0).get("nick_name")+"");
					vo.setCreateTime(new Date());
					vo.setLast_name(typePerson+"");
					vo.setOrder_id(orderid);
					vo.setClothes_type(clothes_type);
					
					ServiceBean.getInstance().getAppUserInfoFacade().insertSaoMaInfo(vo);
					result = Constant.SUCCESS_CODE;
				}else{
					result = Constant.FAIL_CODE;
				}
				
			
			
			}else{

				
				vo.setCondition("order_id='"+orderid +"'  clothes_type= '"+clothes_type +  "'   and last_name='"+(typePerson-1)+"'   limit 1");
				List<DataMap> listSaoMa  = ServiceBean.getInstance().getAppUserInfoFacade().getSaoMaInfo(vo);
				
				if(listSaoMa.size()>0){
					
					vo.setCondition("order_id='"+orderid +"'  clothes_type= '"+clothes_type +  "'   and last_name='"+typePerson+"'   limit 1");
					List<DataMap> listSaoMaEr  = ServiceBean.getInstance().getAppUserInfoFacade().getSaoMaInfo(vo);
					
					if(listSaoMaEr.size()>0){
						result = Constant.STATUS_CODE;
					}else{
						//vo.setUserName(phone);
						vo.setPassword(wechat);
						vo.setNickName(list.get(0).get("nick_name")+"");
						vo.setCreateTime(new Date());
						vo.setLast_name(typePerson+"");
						vo.setOrder_id(orderid);
						vo.setClothes_type(clothes_type);
						
						ServiceBean.getInstance().getAppUserInfoFacade().insertSaoMaInfo(vo);
						result = Constant.SUCCESS_CODE;
					}
					
				}else{
					result = Constant.FAIL_CODE;
				}
				
			
			}
			
	       
			
				
			
				
			}else{
				result = Constant.EXCEPTION_CODE;
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

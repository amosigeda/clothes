package com.care.sys.appinterfaces;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.io.Writer;
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
import com.care.sys.channelinfo.domain.ChannelInfo;
import com.care.sys.msginfo.domain.MsgInfo;
import com.godoing.rose.lang.DataMap;
import com.godoing.rose.log.LogFactory;

public class IsShouHouByIdOrderAction extends BaseAction{

	Log logger = LogFactory.getLog(doGetMsgAction.class);
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		request.setCharacterEncoding("UTF-8");
		String href= request.getServletPath();
		Date start = new Date();
		ServiceBean instance = ServiceBean.getInstance();
		JSONObject json = new JSONObject();
		JSONArray msgData = new JSONArray();
	
		
		
			ServletInputStream input = request.getInputStream();
			BufferedReader reader = new BufferedReader(new InputStreamReader(input));
			StringBuffer sb = new StringBuffer();
			String online = "";
			while((online = reader.readLine()) != null){
				sb.append(online);
			}
			//JSONObject object = JSONObject.fromObject(sb.toString());
			String orderid =request.getParameter("orderid"); 
			String fanhui="0";
		
			
			try{		//get����
//			String user_id = request.getParameter("user_id");
			
				MsgInfo vo = new MsgInfo();
			vo .setCondition("order_id = '"+orderid+"' limit 1");
			
		
			List<DataMap> list= ServiceBean.getInstance().getMsgInfoFacade().getMsgInfoById(vo);
			if(list.size()>0){
				fanhui="1";
			}
			
			result = Constant.SUCCESS_CODE;
			
		}catch(Exception e){
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
			json.put(Constant.EXCEPTION, sb1.toString());
		}
		json.put("request", href);
		json.put(Constant.RESULTCODE, result);
		response.setCharacterEncoding("UTF-8");	
		response.getWriter().write(fanhui);		
		return null;
	}
}

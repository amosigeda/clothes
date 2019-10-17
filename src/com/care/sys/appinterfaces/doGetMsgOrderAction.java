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

public class doGetMsgOrderAction extends BaseAction{

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
			
		
			
			try{		//get����
//			String user_id = request.getParameter("user_id");
			
			ChannelInfo vo = new ChannelInfo(); 
			vo .setCondition("order_id ='"+orderid+"' order by id");
		
    		
			List<DataMap> msgList = instance.getChannelInfoFacade().getChannelInfo(vo);
			int msgCount = msgList.size();
			for(int j=0;j<msgCount;j++){
				JSONObject msgJson = new JSONObject();
				String msg_id = ""+ msgList.get(j).getAt("id");
				String remark = ""+ msgList.get(j).getAt("remark");
				String msg_date = "" + msgList.get(j).getAt("add_time");
				
				msgJson.put("id", msg_id);
				msgJson.put("content", remark);
				msgJson.put("add_time", msg_date);
				
				msgData.add(j,msgJson);
			}
			
			//json.put("msg_count", msgCount);  //��Ϣ����
			json.put("msg_array", msgData); 
			json.put("orderid", orderid); 
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
		response.getWriter().write(json.toString());		
		return null;
	}
}

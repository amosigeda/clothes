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
import com.care.sys.msginfo.domain.MsgInfo;
import com.care.sys.projectinfo.domain.ProjectInfo;
import com.godoing.rose.lang.DataMap;
import com.godoing.rose.log.LogFactory;

public class doGetClothesCountAction extends BaseAction{

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
			JSONObject object = JSONObject.fromObject(sb.toString());
			String starttime =object.getString("starttime");
			String endtime =object.getString("endtime"); 
			String kehu_phone =object.getString("phone"); 
			
		
			
			try{		//get����
		ProjectInfo vo = new ProjectInfo();
		vo.setCondition("add_time >='" + starttime + "' and add_time <='"+endtime +"' and kehu_phone='"+kehu_phone+"'");
		List<DataMap> list = ServiceBean.getInstance()
				.getProjectInfoFacade().getProjectInfo(vo);
		int xizhuang_number =0;
		int chenshan_number =0;
		int xiku_number =0;
		int majia_number =0;
		
		if(list.size()>0){
	
			for(int i=0;i<list.size();i++){
				xizhuang_number=xizhuang_number+Integer.valueOf(list.get(i).get("xizhuang_number")+"");
				chenshan_number=chenshan_number+Integer.valueOf(list.get(i).get("chenshan_number")+"");
				xiku_number=xiku_number+Integer.valueOf(list.get(i).get("xiku_number")+"");
				majia_number=majia_number+Integer.valueOf(list.get(i).get("majia_number")+"");
			}
			
		}
		
		
		json.put("xizhuang_number", xizhuang_number);
		json.put("chenshan_number", chenshan_number);
		json.put("xiku_number", xiku_number);
		json.put("majia_number", majia_number);
		
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

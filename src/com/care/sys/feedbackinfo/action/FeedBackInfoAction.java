package com.care.sys.feedbackinfo.action;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;
import java.util.List;

import javax.servlet.http.*;

import jxl.Workbook;
import jxl.format.VerticalAlignment;
import jxl.write.BorderLineStyle;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import org.apache.commons.beanutils.*;
import org.apache.struts.action.*;

import com.care.app.LoginUser;
import com.care.common.config.Config;
import com.care.common.config.ServiceBean;
import com.care.common.http.BaseAction;
import com.care.common.lang.CommUtils;
import com.care.sys.feedbackinfo.domain.FeedBackInfo;
import com.care.sys.feedbackinfo.domain.logic.FeedBackInfoFacade;
import com.care.sys.feedbackinfo.form.FeedBackInfoForm;
import com.care.sys.projectinfo.domain.ProjectInfo;
import com.care.sys.roleinfo.domain.RoleInfo;
import com.care.sys.userinfo.domain.*;
import com.care.sys.userinfo.domain.logic.*;
import com.care.sys.userinfo.form.*;
import com.care.utils.Utils;
import com.godoing.rose.http.common.HttpTools;
import com.godoing.rose.http.common.PagePys;
import com.godoing.rose.http.common.Result;
import com.godoing.rose.lang.*;

import org.apache.commons.logging.Log;

import com.godoing.rose.log.LogFactory;
import com.godoing.rose.http.common.*;

/* rose1.2 to files
 * rose anthor:wlb  1.0 version by time 2005/12/12
 * rose anthor:wlb  1.1 version by time 2006/06/06
 * rose anthor:wlb  1.2 version by time 2006/12/27*/
public class FeedBackInfoAction extends BaseAction {
	
	Log logger = LogFactory.getLog(FeedBackInfoAction.class);

	public ActionForward queryFeedBackInfo(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String href= request.getServletPath();
		Date start = new Date();		
		Result result = new Result();
		PagePys pys = new PagePys();
		DataList list = null;
		StringBuffer sb = new StringBuffer();//锟斤拷锟斤拷锟街凤拷锟斤拷锟斤拷
		FeedBackInfoFacade info = ServiceBean.getInstance().getFeedBackInfoFacade();
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
			
			FeedBackInfoForm form = (FeedBackInfoForm) actionForm;
			/* 锟斤拷锟矫筹拷始锟斤拷锟斤拷锟斤拷锟斤拷锟?*/			
			form.setOrderBy("id");
			form.setSort("1");

			FeedBackInfo vo = new FeedBackInfo();
			String userName = request.getParameter("userName");
			String startTime = request.getParameter("startTime");
			String endTime   = request.getParameter("endTime");		
			String belongProject = request.getParameter("belongProject");
			String feedbackStatus = request.getParameter("feedbackStatus");
		    String userfeedbackcontent=request.getParameter("userfeedbackcontent");
		    String protime=request.getParameter("protime");
		    
		    
			/*锟斤拷锟矫伙拷锟斤拷锟斤拷锟街讹拷*/
            form.setOrderBy("id"); 
            form.setSort("1"); 
          
            if(!projectInfoId.equals("0")){
				sb.append("f.belong_project in(" + projectInfoId + ")");
			}else{
				if(!companyInfoId.equals("0")){
					ProjectInfo pro = new ProjectInfo();
					pro.setCondition("company_id in(" + companyInfoId + ")");
					List<DataMap> proList = ServiceBean.getInstance().getProjectInfoFacade().getProjectInfo(pro);
					if(proList.size() > 0){
						int num = proList.size();
						String str = "";
						for(int i=0; i<num; i++){
							Integer id = (Integer)proList.get(i).getAt("id");
							str += String.valueOf(id);
							if(i != num-1){
								str += ",";
							}
						}
						sb.append("f.belong_project in(" + str + ")");
					}					
				}
			}
			if(startTime != null && !"".equals(startTime)){				
				if(sb.length() > 0){
					sb.append(" and ");
				}
				sb.append("substring(date_time,1,10) >= '"+startTime+"'");
			}
			if(endTime != null && !"".equals(endTime)){
				if(sb.length() > 0){
					sb.append(" and ");
				}
				sb.append("substring(date_time,1,10) <= '"+endTime+"'");
			}
			if(userName != null && !"".equals(userName)){
				if(sb.length() > 0){
					sb.append(" and ");
				}
				sb.append("user_id like '%" + userName + "%'");
			}
			if(userfeedbackcontent !=null && !"".equals(userfeedbackcontent)){
				if(sb.length()>0){
					sb.append(" and ");
				}
				sb.append("f.user_feedback_content like '%" + userfeedbackcontent +"%'");
			}
			if(belongProject != null && !"".equals(belongProject)){
				if(sb.length() > 0){
					sb.append(" and ");
				}
				sb.append("f.belong_project = '" + belongProject + "'");
			}
			
			if(feedbackStatus!=null && !"".equals(feedbackStatus)){
				if(sb.length()>0){
					sb.append(" and ");
				}
				sb.append("f.feedback_status ='"+ feedbackStatus +"'");
				request.setAttribute("feedbackStatus", CommUtils.getSelectMess("feedbackStatus", Integer.parseInt(feedbackStatus)));
			}
		
			vo.setCondition(sb.toString());
			
			
			ProjectInfo pro = new ProjectInfo();
			List<DataMap> pros = ServiceBean.getInstance().getProjectInfoFacade().getProjectInfo(pro);
			request.setAttribute("project", pros);
			request.setAttribute("userfeedbackcontent", userfeedbackcontent);
			request.setAttribute("fNow_date", startTime);
		    request.setAttribute("now_date", endTime);
		    request.setAttribute("userName", userName);
		    request.setAttribute("belongProject", belongProject);
			BeanUtils.copyProperties(vo, form);
			list = info.getDataFeedBackInfoListByVo(vo);
			
			
			String anniu = request.getParameter("anniu");
			
			if(list.size()>=1 && "2".equals(anniu)){
				FeedBackInfo voo = new FeedBackInfo();
				voo.setCondition(sb.toString());
				System.err.println("**********************************************");
				List<DataMap>  proslist = info.getFeedBackInfo(voo);

				
				String orderIdName = System.currentTimeMillis()+"";
				

				String Divpath = "D:/resin/webapps/watch/upload/daochu/";// 文件保存路径
				File dirFile = new File(Divpath);
				if (!dirFile.exists()) {// 文件路径不存在时，自动创建目录
					dirFile.mkdir();
				}
				String path = Divpath +orderIdName+".xls";// 文件名字
				// 创建一个可写入的excel文件对象
				WritableWorkbook workbook = Workbook.createWorkbook(new File(path));
				// 使用第一张工作表，将其命名为“测试”
				WritableSheet sheet = workbook.createSheet("导出", 0);

				// 设置字体种类和格式
				WritableFont bold = new WritableFont(WritableFont.createFont("宋体") , 9,
						WritableFont.BOLD);
				WritableCellFormat bai = new WritableCellFormat();
				bai.setAlignment(jxl.format.Alignment.CENTRE);// 单元格中的内容水平方向居中
				bai.setBorder(jxl.format.Border.ALL, BorderLineStyle.MEDIUM);
				bai.setVerticalAlignment(VerticalAlignment.CENTRE);
				WritableFont bold1 = new WritableFont(WritableFont.createFont("宋体") , 9,
						WritableFont.BOLD);
				WritableCellFormat bai1 = new WritableCellFormat(bold1);
				bai1.setAlignment(jxl.format.Alignment.CENTRE);// 单元格中的内容水平方向居中
				bai1.setBorder(jxl.format.Border.ALL, BorderLineStyle.MEDIUM);
				bai1.setVerticalAlignment(VerticalAlignment.CENTRE);
				
				
				WritableCellFormat hei = new WritableCellFormat(bold);
				hei.setAlignment(jxl.format.Alignment.CENTRE);// 单元格中的内容水平方向居中
				hei.setBorder(jxl.format.Border.ALL, BorderLineStyle.MEDIUM);
				hei.setVerticalAlignment(VerticalAlignment.CENTRE);
				// 单元格是字符串格式！第一个是代表列数,第二是代表行数，第三个代表要写入的内容,第四个代表字体格式
				// （0代表excel的第一行或者第一列）
				
				sheet.addCell(new Label(0, 0, "订单编号", hei));
				sheet.addCell(new Label(1, 0, "快递类型", hei));
				sheet.addCell(new Label(2, 0, "快递号", hei));
				sheet.addCell(new Label(3, 0, "价格", hei));
				sheet.addCell(new Label(4, 0, "录入时间", hei));
				sheet.addCell(new Label(5, 0, "上衣数量", hei));
				
				sheet.addCell(new Label(6, 0, "裤子数量", hei));
				sheet.addCell(new Label(7, 0, "马甲数量", hei));
				sheet.addCell(new Label(8, 0, "衬衫数量", hei));
				sheet.addCell(new Label(9, 0, "领导数量", hei));
				
				
				
				
				for(int i=0;i<proslist.size();i++){
					String ooid =proslist.get(i).get("user_id")+"";
				    sheet.addCell(new Label(0, i+1, ooid ,   bai));
					sheet.addCell(new Label(1, i+1, proslist.get(i).get("project_name")+"", bai));
					sheet.addCell(new Label(2, i+1,  proslist.get(i).get("user_feedback_content")+"", bai));
					sheet.addCell(new Label(3, i+1, proslist.get(i).get("price")+"", bai));
					sheet.addCell(new Label(4, i+1, proslist.get(i).get("date_time")+"", bai));
					sheet.addCell(new Label(5, i+1, proslist.get(i).get("shangyi")+"", bai));
					sheet.addCell(new Label(6, i+1, proslist.get(i).get("kuzi")+"", bai));
					sheet.addCell(new Label(7, i+1, proslist.get(i).get("majia")+"", bai));
					sheet.addCell(new Label(8, i+1, proslist.get(i).get("chenshan")+"", bai));
					sheet.addCell(new Label(9, i+1, proslist.get(i).get("lingdai")+"", bai));
					
				
				
					sheet.setRowView(i+1, 250, false);
				}
				sheet.setColumnView(0, 15);
				sheet.setColumnView(1, 15);
				sheet.setColumnView(2, 15);
				sheet.setColumnView(3, 15);
				sheet.setColumnView(4, 15);
				sheet.setColumnView(5, 15);
				sheet.setColumnView(6, 15);
				sheet.setColumnView(7, 15);
				sheet.setColumnView(8, 15);
				sheet.setColumnView(9, 15);
				sheet.setColumnView(10, 15);
				sheet.setColumnView(11, 15);
				sheet.setColumnView(12, 15);
				sheet.setColumnView(13, 15);
				sheet.setColumnView(14, 15);
				sheet.setColumnView(15, 15);
				sheet.setColumnView(16, 15);
				sheet.setColumnView(17, 15);
				sheet.setColumnView(18, 15);
				sheet.setColumnView(19, 15);
			
				
				sheet.setRowView(0, 300, false);
				workbook.write();
				workbook.close();
	
			
	
	
				
					
					 // path是指欲下载的文件的路径。
				      File file = new File(path);
				      
				      if (file.exists()) {
				    	  System.err.println("文件存在");
				    	   // 取得文件名。
					      String filename = file.getName();
					      // 取得文件的后缀名。
					      //String ext = filename.substring(filename.lastIndexOf(".") + 1).toUpperCase();
					 
					      // 以流的形式下载文件。
					      InputStream fis = new BufferedInputStream(new FileInputStream(path));
					      byte[] buffer = new byte[fis.available()];
					      fis.read(buffer);
					      fis.close();
					      // 清空response
					      response.reset();
					      // 设置response的Header
					      response.addHeader("Content-Disposition", "attachment;filename=" + new String(filename.getBytes()));
					      response.addHeader("Content-Length", "" + file.length());
					      OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
					      response.setContentType("application/octet-stream");
					      toClient.write(buffer);
					      toClient.flush();
					      toClient.close();
						}
			
			}
			
			BeanUtils.copyProperties(pys, form);
			pys.setCounts(list.getTotalSize());
			/* 锟斤拷锟矫伙拷锟斤拷锟斤拷锟街讹拷 */

		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(Config.ABOUT_PAGE); /* 锟斤拷锟斤拷为锟斤拷锟斤拷页锟芥，锟斤拷锟皆筹拷锟斤拷锟斤拷锟阶拷锟较低衬拷锟揭筹拷锟?*/
			if (e instanceof SystemException) { /* 锟斤拷锟斤拷知锟届常锟斤拷锟叫斤拷锟斤拷 */
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else { /* 锟斤拷未知锟届常锟斤拷锟叫斤拷锟斤拷锟斤拷锟斤拷全锟斤拷锟斤拷锟斤拷锟轿粗拷斐?*/
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
			request.setAttribute("pageList", list);
			request.setAttribute("PagePys", pys);
		}
		CommUtils.getIntervalTime(start, new Date(), href);
		return mapping.findForward("queryFeedBackInfo");
	}

	public ActionForward deleteFeedBackInfo(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {
		Result result = new Result();
		try {
			String id = request.getParameter("id");
			FeedBackInfo vo = new FeedBackInfo();
				vo.setCondition("id ='"+id+"'");    
				//锟斤拷锟斤拷锟矫伙拷锟剿伙拷
				ServiceBean.getInstance().getFeedBackInfoFacade()
						.deleteFeedBackInfo(vo);   //锟斤拷bean锟斤拷删锟斤拷锟矫伙拷
			
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryFeedBackInfo"));
			result.setResultCode("deletes");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryFeedBackInfo"));
			if (e instanceof SystemException) { /* 锟斤拷锟斤拷知锟届常锟斤拷锟叫斤拷锟斤拷 */
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else { /* 锟斤拷未知锟届常锟斤拷锟叫斤拷锟斤拷锟斤拷锟斤拷全锟斤拷锟斤拷锟斤拷锟轿粗拷斐?*/
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}
	public ActionForward initFeedBackInfoUpdate(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		FeedBackInfo vo = new FeedBackInfo();
		vo.setCondition("id='"+id+"'");
		List<DataMap> list = ServiceBean.getInstance().getFeedBackInfoFacade().getFeedBackInfo(vo);
		if (list == null || list.size() == 0) {
			Result result = new Result();
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryFeedBackInfo"));
			result.setResultCode("rowDel");
			result.setResultType("success");
			return mapping.findForward("result");
		}
		request.setAttribute("feedBackInfo", list.get(0));
		return mapping.findForward("updateFeedBackInfo");
	}
	public ActionForward updateFeedBackInfo(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {
		
		Result result = new Result();
		String feedbackstatus="1";
		Date protime = new Date();
		try {
			FeedBackInfoForm form = (FeedBackInfoForm) actionForm;			
			FeedBackInfo vo = new FeedBackInfo();
			vo.setCondition("id='" + form.getId() + "'");
			BeanUtils.copyProperties(vo, form);
			vo.setFeedbackstatus(feedbackstatus);
			vo.setProtime(protime);
			ServiceBean.getInstance().getFeedBackInfoFacade().updateFeedBackInfo(vo);
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryFeedBackInfo"));
			result.setResultCode("updates");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryFeedBackInfo"));
			if (e instanceof SystemException) { /* 锟斤拷锟斤拷知锟届常锟斤拷锟叫斤拷锟斤拷 */
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else { /* 锟斤拷未知锟届常锟斤拷锟叫斤拷锟斤拷锟斤拷锟斤拷全锟斤拷锟斤拷锟斤拷锟轿粗拷斐?*/
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}
	
}

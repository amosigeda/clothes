package com.care.sys.appuserinfo.action;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.format.VerticalAlignment;
import jxl.write.BorderLineStyle;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.logging.Log;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.care.app.LoginUser;
import com.care.common.config.Config;
import com.care.common.config.ServiceBean;
import com.care.common.http.BaseAction;
import com.care.common.lang.CommUtils;
import com.care.sys.appuserinfo.domain.AppUserInfo;
import com.care.sys.appuserinfo.domain.logic.AppUserInfoFacade;
import com.care.sys.appuserinfo.form.AppUserInfoForm;
import com.care.sys.projectinfo.domain.ProjectInfo;
import com.care.sys.projectinfo.form.ProjectInfoForm;
import com.care.sys.sysregisterinfo.domain.UserInfo;
import com.godoing.rose.http.common.HttpTools;
import com.godoing.rose.http.common.PagePys;
import com.godoing.rose.http.common.Result;
import com.godoing.rose.lang.DataList;
import com.godoing.rose.lang.DataMap;
import com.godoing.rose.lang.SystemException;
import com.godoing.rose.log.LogFactory;

public class AppUserInfoAction extends BaseAction{
	
	Log logger = LogFactory.getLog(AppUserInfoAction.class);
	
	public ActionForward queryAppUserInfo(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Date start = new Date();
		String href= request.getServletPath();		 
		Result result = new Result();//���
		PagePys pys = new PagePys();//ҳ������
		DataList list = null; //����ҳ��List  ��logic itrate��ȡ��
		StringBuffer sb = new StringBuffer();//�����ַ�����
		AppUserInfoFacade info = ServiceBean.getInstance().getAppUserInfoFacade();//����userApp������ȡ��user�ֵ䣩
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
			AppUserInfoForm form = (AppUserInfoForm) actionForm;
			AppUserInfo vo = new AppUserInfo(); 
			String userName = request.getParameter("user");
			String startTime = request.getParameter("startTime");
			String endTime   = request.getParameter("endTime");	
			String user_id = request.getParameter("user_id");
			String belongProject = request.getParameter("belongProject");

			/*���û������ֶ�*/
            form.setOrderBy("create_time"); 
            form.setSort("1"); 

            if(!projectInfoId.equals("0")){
				sb.append("a.belong_project in(" + projectInfoId + ")");
			}else{
				if(!"0".equals(companyInfoId)){
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
						sb.append("a.belong_project in(" + str + ")");
					}					
				}
			}
			if(startTime != null && !"".equals(startTime)){		
				if(sb.length() > 0){
					sb.append(" and ");
				}
				sb.append("substring(create_time,1,10) >= '"+startTime+"'");
			}
			if(endTime != null && !"".equals(endTime)){
				if(sb.length() > 0){
					sb.append(" and ");
				}
				sb.append("substring(create_time,1,10) <= '"+endTime+"'");
			}
			if(userName != null && !"".equals(userName)){
				if(sb.length() > 0){
					sb.append(" and ");
				}
				sb.append("user_name like '%" + userName + "%'");
			}
			if(user_id != null && !"".equals(user_id)){				
				if(sb.length() > 0){
					sb.append(" and ");
				}
				sb.append("a.id = '" + user_id + "'");
			}
			if(belongProject != null && !"".equals(belongProject)){
				if(sb.length() > 0){
					sb.append(" and ");
				}
				sb.append("a.belong_project='"+belongProject+"'");
			}
			/*ProjectInfo pro = new ProjectInfo();
			List<DataMap> pros = ServiceBean.getInstance().getProjectInfoFacade().getProjectInfo(pro);
			request.setAttribute("project", pros);*/
			
			request.setAttribute("fNow_date", startTime);
		    request.setAttribute("now_date", endTime);
		    request.setAttribute("user", userName);
		    request.setAttribute("user_id", user_id);
		    request.setAttribute("belongProject", belongProject);
		    
			vo.setCondition(sb.toString());
			
         	BeanUtils.copyProperties(vo,form);			
         	list = info.getAppUserInfoListByVo(vo);  
			BeanUtils.copyProperties(pys, form); 
			pys.setCounts(list.getTotalSize());   
			/* ���û������ֶ� */ 
			 
		} catch (Exception e) { 
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(Config.ABOUT_PAGE); /* ����Ϊ����ҳ�棬���Գ������ת��ϵͳĬ��ҳ�� */
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
		return mapping.findForward("queryAppUserInfo");
	}
	
	public ActionForward queryAppUserCount(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Date start = new Date();
		String href= request.getServletPath();		 
		Result result = new Result();//���
		PagePys pys = new PagePys();//ҳ������
		DataList list = null; //����ҳ��List  ��logic itrate��ȡ��
		StringBuffer sb = new StringBuffer();//�����ַ�����
		AppUserInfoFacade info = ServiceBean.getInstance().getAppUserInfoFacade();//����userApp������ȡ��user�ֵ䣩
		try {
			AppUserInfoForm form = (AppUserInfoForm) actionForm;
			AppUserInfo vo = new AppUserInfo(); 
			String startTime = request.getParameter("startTime");
			String endTime   = request.getParameter("endTime");	

			/*���û������ֶ�*/
            form.setOrderBy("create_time"); 
            form.setSort("1"); 
           
			if(startTime != null && !"".equals(startTime)){				
				sb.append("substring(create_time,1,10) >= '"+startTime+"'");
			}
			if(endTime != null && !"".equals(endTime)){
				if(sb.length() > 0){
					sb.append(" and ");
				}
				sb.append("substring(create_time,1,10) <= '"+endTime+"'");
			}			
			
			request.setAttribute("fNow_date", startTime);
		    request.setAttribute("now_date", endTime);		    
		    
			vo.setCondition(sb.toString());
			
         	BeanUtils.copyProperties(vo,form);			
         	list = info.getAppUserInfoGroupByTime(vo); 
			BeanUtils.copyProperties(pys, form); 
			pys.setCounts(list.getTotalSize());   
			/* ���û������ֶ� */ 
			 
		} catch (Exception e) { 
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(Config.ABOUT_PAGE); /* ����Ϊ����ҳ�棬���Գ������ת��ϵͳĬ��ҳ�� */
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
		return mapping.findForward("queryAppUserCount");
	}
	
	public ActionForward downloadApk(ActionMapping mapping, ActionForm actionForm,HttpServletRequest request,HttpServletResponse response) throws Exception{
		Result result = new Result();
		boolean isOnLine = true;
		try {
			String downloadUrl = request.getParameter("download");
			String dir = request.getSession(true).getServletContext()
					.getRealPath("/upload");
			String apkname = CommUtils.getSubStr(downloadUrl,3);
			File f = new File(dir + "/" + apkname);
			if (!f.exists()) {
				throw new SystemException("fail", "noIconPath");
			}
           
			FileInputStream fin = new FileInputStream(f);

			BufferedInputStream br = new BufferedInputStream(fin);
			byte[] buf = new byte[1024 * 8];
			int len = 0;

		        response.reset(); 
		        if (!isOnLine) { 
		            URL u = new URL("file:///" + dir);
		            response.setContentType(u.openConnection().getContentType());
		            response.setHeader("Content-Disposition", "inline; filename=" + apkname);
		            // �ļ���Ӧ�ñ����UTF-8
		        } else { // �����ط�ʽ
		            response.setContentType("application/x-msdownload");
		            response.setHeader("Content-Disposition", "attachment; filename=" + f.getName());
		        }
		        OutputStream out = response.getOutputStream();
		        while ((len = br.read(buf)) > 0)
		            out.write(buf, 0, len);
		        br.close();
		        out.close();
		        return null;
		}catch (Exception e) {
			e.printStackTrace();
			result.setBackPage(HttpTools.httpServletPath(request,"queryAppUserInfo"));
			if (e instanceof SystemException) { /* ����֪�쳣���н��� */
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else { /* ��δ֪�쳣���н�������ȫ�������δ֪�쳣 */
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		}finally {
			request.setAttribute("result", result);				
			}
		return mapping.findForward("result");
	}
	
	
	public ActionForward queryGongLiangInfo(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Date start = new Date();
		String href= request.getServletPath();		 
		Result result = new Result();//���
		PagePys pys = new PagePys();//ҳ������
		DataList list = null; //����ҳ��List  ��logic itrate��ȡ��
		StringBuffer sb = new StringBuffer();//�����ַ�����
		AppUserInfoFacade info = ServiceBean.getInstance().getAppUserInfoFacade();//����userApp������ȡ��user�ֵ䣩
		try {
			LoginUser loginUser = (LoginUser)request.getSession().getAttribute(Config.SystemConfig.LOGINUSER);
			if (loginUser == null) {
		            result.setBackPage(Config.INDEX_PAGE);
		           result.setResultCode("timeout");
		           result.setResultType("fail");
		           request.setAttribute("result", null);
		           return mapping.findForward("result");
			}
			
			String anniu =request.getParameter("anniu");
			System.err.println("按钮="+anniu);
			//1 查询   2导出
			
			
              

			
			String companyInfoId = loginUser.getCompanyId();
			String projectInfoId = loginUser.getProjectId();
			AppUserInfoForm form = (AppUserInfoForm) actionForm;
			AppUserInfo vo = new AppUserInfo(); 
			String userName = request.getParameter("user");
			String startTime = request.getParameter("startTime");
			String endTime   = request.getParameter("endTime");	
			String user_id = request.getParameter("user_id");
			String phone = request.getParameter("phone");
			String nickname = request.getParameter("nickname");
			String gongzhong = request.getParameter("gongzhong");

			/*���û������ֶ�*/
            form.setOrderBy("id"); 
            form.setSort("1"); 

          
			if(startTime != null && !"".equals(startTime)){		
				if(sb.length() > 0){
					sb.append(" and ");
				}
				sb.append("create_time >= '"+startTime+"'");
			}
			if(endTime != null && !"".equals(endTime)){
				if(sb.length() > 0){
					sb.append(" and ");
				}
				sb.append("create_time<= '"+endTime+"'");
			}
			if(userName != null && !"".equals(userName)){
				if(sb.length() > 0){
					sb.append(" and ");
				}
				sb.append("user_name like '%" + userName + "%'");
			}
			if(user_id != null && !"".equals(user_id)){				
				if(sb.length() > 0){
					sb.append(" and ");
				}
				sb.append("a.id = '" + user_id + "'");
			}
			if(gongzhong != null && !"".equals(gongzhong)){
				if(sb.length() > 0){
					sb.append(" and ");
				}
				sb.append("last_name='"+gongzhong+"'");
			}
			if(phone != null && !"".equals(phone)){
				if(sb.length() > 0){
					sb.append(" and ");
				}
				sb.append("user_name='"+phone+"'");
			}
			if(nickname != null && !"".equals(nickname)){
				if(sb.length() > 0){
					sb.append(" and ");
				}
				sb.append("nick_name='"+nickname+"'");
			}
			/*ProjectInfo pro = new ProjectInfo();
			List<DataMap> pros = ServiceBean.getInstance().getProjectInfoFacade().getProjectInfo(pro);
			request.setAttribute("project", pros);*/
			
			request.setAttribute("fNow_date", startTime);
		    request.setAttribute("now_date", endTime);
		    request.setAttribute("user", userName);
		    request.setAttribute("nickname", nickname);
		    request.setAttribute("user_id", user_id);
		    request.setAttribute("phone", phone);
		    request.setAttribute("gongzhong", gongzhong);
		    
			vo.setCondition(sb.toString());
			
			
			   if("2".equals(anniu)){
					
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
					
					Label label00 = new Label(0, 0, "扫码人", hei); // 这里的（0,0）表示第一行第一列的表格
					sheet.addCell(label00);
					
					Label label10 = new Label(1, 0, "订单号", hei); // 这里的（0,0）表示第一行第一列的表格
					sheet.addCell(label10);
					Label label20 = new Label(2, 0, "上衣数量", hei); // 这里的（0,0）表示第一行第一列的表格
					sheet.addCell(label20);
					Label label30 = new Label(3, 0, "衬衫数量", hei); // 这里的（0,0）表示第一行第一列的表格
					sheet.addCell(label30);
					Label label40 = new Label(4, 0, "裤子数量", hei); // 这里的（0,0）表示第一行第一列的表格
					sheet.addCell(label40);
					Label label50 = new Label(5, 0, "马甲数量", hei); // 这里的（0,0）表示第一行第一列的表格
					sheet.addCell(label50);
					Label label60 = new Label(6, 0, "客户姓名", hei); // 这里的（0,0）表示第一行第一列的表格
					sheet.addCell(label60);
					Label label70 = new Label(7, 0, "订单状态", hei); // 这里的（0,0）表示第一行第一列的表格
					sheet.addCell(label70);
					
					AppUserInfo avo = new AppUserInfo();
					avo.setCondition(sb.toString());
					List<DataMap> proslist = ServiceBean.getInstance()
							.getAppUserInfoFacade().getSaoMaInfoNew(vo);
					
			/*		for(int i=0;i<proslist.size();i++){
						String ooid =proslist.get(i).get("order_id")+"";
					    sheet.addCell(new Label(0, i+1, ooid ,   bai));
						sheet.addCell(new Label(1, i+1, proslist.get(i).get("nick_name")+"", bai));
						sheet.addCell(new Label(2, i+1,  proslist.get(i).get("order_id")+"", bai));
						sheet.addCell(new Label(3, i+1, proslist.get(i).get("wechat")+"", bai));
						sheet.addCell(new Label(4, i+1, proslist.get(i).get("order_number")+"", bai));
						sheet.addCell(new Label(5, i+1, proslist.get(i).get("add_time")+"", bai));
						sheet.addCell(new Label(6, i+1, proslist.get(i).get("kehu_phone")+"", bai));
						sheet.addCell(new Label(7, i+1, proslist.get(i).get("kehu_name")+"", bai));
					
						
						AppUserInfo voapp = new AppUserInfo(); 
						
						voapp.setCondition("order_id='"+ooid +"'  and last_name='6'   limit 1"); //
						List<DataMap> listSaoMa  = ServiceBean.getInstance().getAppUserInfoFacade().getSaoMaInfo(voapp);
						
						sheet.addCell(new Label(12, i+1, "", bai));
						if(listSaoMa.size()>0){
							sheet.addCell(new Label(12, i+1, listSaoMa.get(0).get("create_time")+"", bai));
						}
						sheet.addCell(new Label(13, i+1, proslist.get(i).get("xiadan_kefu")+"", bai));
					
					
						sheet.setRowView(i+1, 250, false);
					}*/
					
					
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
			   
			   
         	BeanUtils.copyProperties(vo,form);			
         	list = info.getSaoMaInfoListByVo(vo);  
			BeanUtils.copyProperties(pys, form); 
			pys.setCounts(list.getTotalSize());   
			/* ���û������ֶ� */ 
			 
		} catch (Exception e) { 
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(Config.ABOUT_PAGE); /* ����Ϊ����ҳ�棬���Գ������ת��ϵͳĬ��ҳ�� */
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
		return mapping.findForward("queryGongLiangInfo");
	}
	
	
	public ActionForward deleteinfo(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {

		Result result = new Result();
		try {
		
			AppUserInfo vo = new AppUserInfo(); 
			vo.setCondition("id='" + request.getParameter("id") + "'");
		
			ServiceBean.getInstance().getAppUserInfoFacade().deleteById(vo);

			result.setBackPage(HttpTools.httpServletPath(request,
					"queryAppUserInfo"));
			result.setResultCode("deletes");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryAppUserInfo"));
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
	public ActionForward updateInfo(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {

		Result result = new Result();
		try {
		
			AppUserInfo vo = new AppUserInfo(); 
			vo.setCondition("id='" + request.getParameter("id") + "'");
		vo.setStatus("1");
			ServiceBean.getInstance().getAppUserInfoFacade().updateAppUserInfo(vo);

			result.setBackPage(HttpTools.httpServletPath(request,
					"queryAppUserInfo"));
			result.setResultCode("deletes");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryAppUserInfo"));
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

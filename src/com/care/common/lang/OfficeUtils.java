package com.care.common.lang;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.WorkbookSettings;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

public class OfficeUtils {

	public static void main(String[] args) {
		List<Map<String,String>> datas = new ArrayList<Map<String,String>>();

		/*for (int i = 0; i < 10; i++) {
			Map<String,String> data = new HashMap<String, String>();
			data.put("用户编号", "用户编号" + i);
		data.put("姓名", "张三" + i);
		data.put("电话", "1532645451" + i);
		datas.add(data);
	}*/
		
		Map<String,String> data1 = new HashMap<String, String>();
		
		data1.put("1", "不一订制和周卢江  客户信息档案表");
		data1.put("2", "");
		data1.put("3", "");
		data1.put("4", "");
		data1.put("5", "");
		data1.put("6", "");
		data1.put("7", "");
		data1.put("8", "");
	datas.add(data1);
	
	
	Map<String,String> data2 = new HashMap<String, String>();
		data2.put("1", "订单信息");
		data2.put("2", "");
		data2.put("3", "");
		data2.put("4", "");
		data2.put("5", "订单信息");
		data2.put("6", "");
		data2.put("7", "");
		data2.put("8", "");
	datas.add(data2);
	
	Map<String,String> data3 = new HashMap<String, String>();
		data3.put("1", "订单编号");
		data3.put("2", "11900901701");
		data3.put("3", "渠道");
		data3.put("4", "淘宝");
		data3.put("5", "年龄");
		data3.put("6", "26");
		data3.put("7", "客户电话");
		data3.put("8", "18013866641");
	datas.add(data3);
	//data.clear();
	
	
	
		System.out.println(datas);
		String format = new SimpleDateFormat("yyyyMMdd-HHmmss").format(new Date());
		System.out.println(format);
	System.out.println(OfficeUtils.createExcel(format,"", "E:\\idea\\test\\1.xls", "1,2,3,4,5,6,7,8".split(","),
			datas,"".split(",")));
}

/**
 * 创建Excel包含数据
 * 数组都按顺序对应列名和字段值
 * @param folder	  存放文件夹路径 ：download
 * @param filename	 文件名   ：统计信息.xls
 * @param columnNames 列名
 * @param dataSource  数据源
 * @param valueNames  字段名
 * @param bottom_row_str  底部自定义行    
 * @return
 */
public static synchronized WritableWorkbook createExcel(String name,String folder,String filename,String[] columnNames,List<Map<String,String>> datas,String[] bottom_row_str){
	try {
		folder=folder+ ((folder.endsWith("/")||folder.endsWith("\\")) ? "" : File.separator);
		File fold=new File("/"+folder);
		//			File fold=new File(serverPath+folder);
		if (!fold.exists()) {
			fold.mkdirs();
		}
		String saveFileName=folder+filename;
		saveFileName=saveFileName.replaceAll("\\\\", "/").replaceAll("//", "/");
	   //saveFileName=saveFileName.substring(0,saveFileName.lastIndexOf("."))+"_"+new SimpleDateFormat("yyyyMMdd-HHmmss").format(new Date())+saveFileName.substring(saveFileName.lastIndexOf("."),saveFileName.length());
		saveFileName=saveFileName.substring(0,saveFileName.lastIndexOf("."))+"_"+name+saveFileName.substring(saveFileName.lastIndexOf("."),saveFileName.length());
System.out.println("saveFileName="+saveFileName);
		File file=new File("/"+saveFileName);
		// 创建可写入的excel工作簿
		WritableWorkbook writableWorkbook = Workbook.createWorkbook(file);
		// 创建可写的工作表
		WritableSheet wtSheet = writableWorkbook.createSheet("create", 0);
		for (int i=0;i<columnNames.length;i++) {
			wtSheet.addCell(new Label(i, 0, columnNames[i].trim()));
		}
		for (int j = 1; j <= datas.size(); j++) {
			for (int i = 0; i < columnNames.length; i++) {
				Map<String,String> data = datas.get(j-1);
				wtSheet.addCell(new Label(i, j, String.valueOf(data.get(columnNames[i])==null?"":data.get(columnNames[i]))));

			}

		}
		if (bottom_row_str!=null) {
			for (int i = 0; i < bottom_row_str.length; i++) {
				wtSheet.addCell(new Label(i, datas.size()+1,bottom_row_str[i] ));
			}
		}
		writableWorkbook.write();
		writableWorkbook.close();
		return writableWorkbook;
	} catch (Exception e) {
		e.printStackTrace();
		return null;
	} 
} 

public static synchronized boolean createExcelTemplete(String serverPath,String folder,String filename,String[] columnNames){
	try {
		String savePath = serverPath+((serverPath.endsWith("/")||serverPath.endsWith("\\")) ? "" : File.separator) + folder
				+ ((folder.endsWith("/")||folder.endsWith("\\")) ? "" : File.separator);

		File fold=new File(savePath);
		if (!fold.exists()) {
			fold.mkdirs();
		}
		File file=new File(savePath+filename);
		// 创建可写入的excel工作簿
		WritableWorkbook writableWorkbook = Workbook.createWorkbook(file);
		// 创建可写的工作表
		WritableSheet wtSheet = writableWorkbook.createSheet("create", 0);
		for (int i=0;i<columnNames.length;i++) {
			wtSheet.addCell(new Label(i, 0, columnNames[i].trim()));
		}

		writableWorkbook.write();
		writableWorkbook.close();
		return true;
	} catch (Exception e) {
		e.printStackTrace();
		return false;
	} 
} 
/**
 * 解析Excel 返回List对象
 * @param <T>
 * @param path excel文件物理路径
 * @param clazz 需要返回的对象
 * @param fields 需要赋值的字段，必须和excel列的中顺序相同
 * @return
 */
public static synchronized <T>List<T> parseExcel(String path,Class<T> clazz,String fields) {
	InputStream ios =null;
	Workbook writablebook=null;
	File f=null;
	try {
		List<T> list=new ArrayList<T>();
		T obj=null;

		try {
			ios = new BufferedInputStream(new FileInputStream(path));
			f=new File(path);
		} catch (Exception e) {
			System.out.println(path+"文件不存在");
			return null;
		}
		WorkbookSettings setting=new WorkbookSettings();
		Locale local=new Locale("zh","CN");
		setting.setLocale(local);
		setting.setEncoding("ISO-8859-1");
		writablebook = Workbook.getWorkbook(ios,setting); 
		Sheet sheetArray = writablebook.getSheet(0); 
		Cell[] cells = null;
		Field field=null;
		int rows=	sheetArray.getRows();
		for (int i = 1; i < rows; i++) {
			cells= sheetArray.getRow(i);
			obj=clazz.newInstance();
			String[] fieldstr=fields.split(",");
			for (int j = 0; j < fieldstr.length; j++) {
				if(j == 3 && cells.length <= 3) {
					break;
				}
				if (fieldstr[j]!=null&&!fieldstr[j].trim().equals("")){
					field=clazz.getDeclaredField(fieldstr[j]);
					set(field, obj, cells[j].getContents().toString());
				}
			}
			list.add(obj);
		}
		return list;
	} catch (Exception e) {
		e.printStackTrace();
		return null;
	} finally{
		try {
			if(writablebook!=null)
				writablebook.close();
			if(ios!=null)
				ios.close();
			if(f!=null&&f.exists())
				f.delete();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
/**
 * 解析Excel为对象赋值
 * @param field
 * @param obj
 * @param context
 * @throws Exception
 */
private static  void  set(Field field,Object obj,String context) throws Exception{
	field.setAccessible(true);
	field.set(obj, context);
	field.setAccessible(false);
}
}

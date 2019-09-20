package com.care.common.lang;

import java.io.File;
import java.io.IOException;
import java.util.Date;

import jxl.Workbook;
import jxl.write.BorderLineStyle;
import jxl.write.DateFormat;
import jxl.write.DateTime;
import jxl.write.NumberFormat;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableImage;
import jxl.write.Number;
import jxl.write.Boolean;

public class GetExCel {

	// 生成excel文件
	public static void writeExcel() throws IOException {
		try {
			String Divpath = "E:\\idea\\test\\";// 文件保存路径
			File dirFile = new File(Divpath);
			if (!dirFile.exists()) {// 文件路径不存在时，自动创建目录
				dirFile.mkdir();
			}
			String path = Divpath + "test.xls";// 文件名字
			// 创建一个可写入的excel文件对象
			WritableWorkbook workbook = Workbook.createWorkbook(new File(path));
			// 使用第一张工作表，将其命名为“测试”
			WritableSheet sheet = workbook.createSheet("档案", 0);

			// 设置字体种类和格式
			WritableFont bold = new WritableFont(WritableFont.ARIAL, 16,
					WritableFont.BOLD);
			WritableCellFormat wcfFormat = new WritableCellFormat(bold);
			wcfFormat.setAlignment(jxl.format.Alignment.CENTRE);// 单元格中的内容水平方向居中

			// 单元格是字符串格式！第一个是代表列数,第二是代表行数，第三个代表要写入的内容,第四个代表字体格式
			// （0代表excel的第一行或者第一列）
			Label label01 = new Label(0, 0, "测试数据：", wcfFormat); // 这里的（0,0）表示第一行第一列的表格
			sheet.addCell(label01);
			Label label02 = new Label(1, 0, "测试的结果是成功的");
			sheet.addCell(label02);

			// 合并单元格,合并既可以是横向的，也可以是纵向的
			// 这里的第一个数据代表第二列，第二个数据代表第一行，第三个数据代表第四列，第四个数据代表第二行
			sheet.mergeCells(1, 0, 3, 1);   //横 1 4  纵   纵 0 2
			// 设置第2行的高度
			sheet.setRowView(1, 400, false);
			// 设置列宽
			sheet.setColumnView(0, 15);
			sheet.setColumnView(1, 40);

			// 插入图片
			File file = new File("e:\\test\\123.png");
			// WritableImage前面四个参数的类型都是double，依次是 x, y, width,
			// height,这里的宽和高可不是图片的宽和高，而是图片所要占的单位格的个数
			WritableImage image = new WritableImage(1, 3, 1, 3, file);
			sheet.addImage(image);

			// 整型数据
			Number label2 = new Number(0, 1, 31415926);
			sheet.addCell(label2);

			// 添加带有formatting的Number对象
			NumberFormat nf = new NumberFormat("#.##");
			WritableCellFormat wcfN = new WritableCellFormat(nf);
			Number labelNF = new Number(0, 3, 3.1415926, wcfN);
			sheet.addCell(labelNF);
			// boolean型数据
			Boolean label3 = new Boolean(0, 4, true);
			sheet.addCell(label3);

			// 添加DateTime对象
			DateTime labelDT = new DateTime(0, 5, new Date());
			sheet.addCell(labelDT);
			// 添加带有formatting的DateFormat对象
			DateFormat df = new DateFormat("yyyy-MM-dd HH:mm:ss"); // HH是24小时制，hh是12小时制
			WritableCellFormat wcfDF = new WritableCellFormat(df);
			DateTime labelDTF = new DateTime(4, 1, new Date(), wcfDF);
			sheet.addCell(labelDTF);
			// 关闭对象，释放资源
			workbook.write();
			workbook.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	
	// 生成excel文件
		public static void writeExcelDaBiao(String name,String orderId) throws IOException {
			try {
//				String Divpath = "E:\\idea\\test\\";// 文件保存路径
				String Divpath = "D:/resin/webapps/watch/upload/excel/"+orderId+"/";// 文件保存路径
				File dirFile = new File(Divpath);
				if (!dirFile.exists()) {// 文件路径不存在时，自动创建目录
					dirFile.mkdir();
				}
				String path = Divpath + name+".xls";// 文件名字
				// 创建一个可写入的excel文件对象
				WritableWorkbook workbook = Workbook.createWorkbook(new File(path));
				// 使用第一张工作表，将其命名为“测试”
				WritableSheet sheet = workbook.createSheet("档案", 0);

				// 设置字体种类和格式
				WritableFont bold = new WritableFont(WritableFont.ARIAL, 12,
						WritableFont.BOLD);
				WritableCellFormat wcfFormat = new WritableCellFormat();
				wcfFormat.setAlignment(jxl.format.Alignment.CENTRE);// 单元格中的内容水平方向居中
				wcfFormat.setBorder(jxl.format.Border.ALL, BorderLineStyle.MEDIUM);
				
				WritableCellFormat leftwcfFormat = new WritableCellFormat();
				leftwcfFormat.setAlignment(jxl.format.Alignment.LEFT);// 单元格中的内容水平方向居中
				leftwcfFormat.setBorder(jxl.format.Border.ALL, BorderLineStyle.MEDIUM);
				// 单元格是字符串格式！第一个是代表列数,第二是代表行数，第三个代表要写入的内容,第四个代表字体格式
				// （0代表excel的第一行或者第一列）
				Label label01 = new Label(0, 0, "订单编号", wcfFormat); // 这里的（0,0）表示第一行第一列的表格
				sheet.addCell(label01);
				Label label03 = new Label(0, 1, "生产车间",wcfFormat);
				sheet.addCell(label03);
				Label label05 = new Label(0, 2, "客户姓名",wcfFormat);
				sheet.addCell(label05);
				Label label06 = new Label(0, 3, "执行标准-西装",wcfFormat);
				sheet.addCell(label06);
				Label label07 = new Label(0, 4, "执行标准-西裤",wcfFormat);
				sheet.addCell(label07);
				Label label08 = new Label(0, 5, "尺码",wcfFormat);
				sheet.addCell(label08);
				Label label09 = new Label(0, 6, "数量",wcfFormat);
				sheet.addCell(label09);
				Label label10 = new Label(0, 7, "辅助数量",wcfFormat);
				sheet.addCell(label10);
				Label label11 = new Label(0, 8, "下单日期",wcfFormat);
				sheet.addCell(label11);
				Label label12 = new Label(0, 9, "洗涤方式",wcfFormat);
				sheet.addCell(label12);
				Label label13 = new Label(0, 10, "操作员",wcfFormat);
				sheet.addCell(label13);
				Label label14 = new Label(0, 11, "质检员",wcfFormat);
				sheet.addCell(label14);
				Label label15 = new Label(0, 12, "工艺等级",wcfFormat);
				sheet.addCell(label15);
				Label label16 = new Label(0, 13, "裤腰围",wcfFormat);
				sheet.addCell(label16);
				
				
				Label label02 = new Label(1, 0, "1568018281989",leftwcfFormat);
				sheet.addCell(label02);
				Label label04 = new Label(1, 1, "不一定制-南京中央工厂",leftwcfFormat);
				sheet.addCell(label04);
				Label label17 = new Label(1, 2, "盘文青",leftwcfFormat);
				sheet.addCell(label17);
				Label label18 = new Label(1, 3, "GB/T2664-2009",leftwcfFormat);
				sheet.addCell(label18);
				Label label19 = new Label(1, 4, "GB/T2664-2009",leftwcfFormat);
				sheet.addCell(label19);
				Label label20 = new Label(1, 5, "定制",leftwcfFormat);
				sheet.addCell(label20);
				Label label21 = new Label(1, 6, "套西",leftwcfFormat);
				sheet.addCell(label21);
				Label label22 = new Label(1, 7, "1",leftwcfFormat);
				sheet.addCell(label22);
				Label label23 = new Label(1, 8, "2019/09/08",leftwcfFormat);
				sheet.addCell(label23);
				Label label24 = new Label(1, 9, "只可干洗",leftwcfFormat);
				sheet.addCell(label24);
				Label label25 = new Label(1, 10, "12号",leftwcfFormat);
				sheet.addCell(label25);
				Label label26 = new Label(1, 11, "8号",leftwcfFormat);
				sheet.addCell(label26);
				Label label27 = new Label(1, 12, "手工定制",leftwcfFormat);
				sheet.addCell(label27);
				Label label28 = new Label(1, 13, "74",leftwcfFormat);
				sheet.addCell(label28);
				
			
				sheet.setColumnView(0, 20);
				sheet.setColumnView(1, 24);
				
				sheet.setRowView(0, 400, false);
				sheet.setRowView(1, 400, false);
				sheet.setRowView(2, 400, false);
				sheet.setRowView(3, 400, false);
				sheet.setRowView(4, 400, false);
				sheet.setRowView(5, 400, false);
				sheet.setRowView(6, 400, false);
				sheet.setRowView(7, 400, false);
				sheet.setRowView(8, 400, false);
				sheet.setRowView(9, 400, false);
				sheet.setRowView(10, 400, false);
				sheet.setRowView(11, 400, false);
				sheet.setRowView(12, 400, false);
				sheet.setRowView(13, 400, false);
				
				// 插入图片
				File file = new File("D:/123.png");
				// WritableImage前面四个参数的类型都是double，依次是 x, y, width,height
				// ,这里的宽和高可不是图片的宽和高，而是图片所要占的单位格的个数
				WritableImage image = new WritableImage(1.5, 8, 0.5, 3, file);
				sheet.addImage(image);
				
				
				// 这里的第一个数据代表第二列，第二个数据代表第一行，第三个数据代表第四列，第四个数据代表第二行
				//sheet.mergeCells(1, 1, 2, 15);   //横 1 4  纵   纵 1 2   0 3 0 1  1  3  01
				// 关闭对象，释放资源
				workbook.write();
				workbook.close();
System.out.println("生成EXCEL文件 名称="+name+"         订单号="+orderId);
			} catch (Exception e) {
				e.printStackTrace();
			}

		}

	public static void main(String[] args) {
		try {
			//writeExcel();
			
			writeExcelDaBiao("4","11909200007001");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}

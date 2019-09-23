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
		public static void writeExcelDaBiao(String name,String orderId,String username,String riqi,String yaowei,String pngLujing) throws IOException {
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
				
				
				Label label02 = new Label(1, 0, orderId,leftwcfFormat);
				sheet.addCell(label02);
				Label label04 = new Label(1, 1, "不一定制-南京中央工厂",leftwcfFormat);
				sheet.addCell(label04);
				Label label17 = new Label(1, 2, username,leftwcfFormat);
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
//				Label label23 = new Label(1, 8, "2019/09/08",leftwcfFormat);
				Label label23 = new Label(1, 8, riqi,leftwcfFormat);
				sheet.addCell(label23);
				Label label24 = new Label(1, 9, "只可干洗",leftwcfFormat);
				sheet.addCell(label24);
				Label label25 = new Label(1, 10, "12号",leftwcfFormat);
				sheet.addCell(label25);
				Label label26 = new Label(1, 11, "8号",leftwcfFormat);
				sheet.addCell(label26);
				Label label27 = new Label(1, 12, "手工定制",leftwcfFormat);
				sheet.addCell(label27);
				Label label28 = new Label(1, 13, yaowei,leftwcfFormat);
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
//				File file = new File("D:/123.png");
				File file = new File(pngLujing);
				// WritableImage前面四个参数的类型都是double，依次是 x, y, width,height
				// ,这里的宽和高可不是图片的宽和高，而是图片所要占的单位格的个数
				WritableImage image = new WritableImage(1.5, 8, 0.5, 3, file);
				sheet.addImage(image);
				
				sheet.mergeCells(1, 0, 3, 1);
				
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

	
	
	// 生成excel文件
	public static void writeExcelXiangQing(String name,String orderId) throws IOException {
		try {
//			String Divpath = "E:\\idea\\test\\";// 文件保存路径
			String Divpath = "E:/idea/test/";// 文件保存路径
			//String Divpath = "D:/resin/webapps/watch/upload/excel/"+orderId+"/";// 文件保存路径
			File dirFile = new File(Divpath);
			if (!dirFile.exists()) {// 文件路径不存在时，自动创建目录
				dirFile.mkdir();
			}
			String path = Divpath + System.currentTimeMillis()+".xls";// 文件名字
			// 创建一个可写入的excel文件对象
			WritableWorkbook workbook = Workbook.createWorkbook(new File(path));
			// 使用第一张工作表，将其命名为“测试”
			WritableSheet sheet = workbook.createSheet("档案", 0);

			// 设置字体种类和格式
			WritableFont bold = new WritableFont(WritableFont.ARIAL, 11,
					WritableFont.BOLD);
			WritableCellFormat aFormat = new WritableCellFormat();
			aFormat.setAlignment(jxl.format.Alignment.CENTRE);// 单元格中的内容水平方向居中
			aFormat.setBorder(jxl.format.Border.ALL, BorderLineStyle.MEDIUM);
			
			WritableCellFormat bFormat = new WritableCellFormat(bold);
			bFormat.setAlignment(jxl.format.Alignment.CENTRE);// 单元格中的内容水平方向居中
			bFormat.setBorder(jxl.format.Border.ALL, BorderLineStyle.MEDIUM);
			// 单元格是字符串格式！第一个是代表列数,第二是代表行数，第三个代表要写入的内容,第四个代表字体格式
			// （0代表excel的第一行或者第一列）
			Label label00 = new Label(0, 0, "不一订制和周卢江  客户信息档案表", bFormat); // 这里的（0,0）表示第一行第一列的表格
			sheet.addCell(label00); 
			
			Label label01 = new Label(0, 1, "订单信息", bFormat); // 这里的（0,0）表示第一行第一列的表格
			sheet.addCell(label01); 
			Label label41 = new Label(4, 1, "订单信息", bFormat);
			sheet.addCell(label41);
			//第三行
			Label label02 = new Label(0, 2, "订单编号", bFormat);
			sheet.addCell(label02);
			            Label label12 = new Label(1, 2, "11900901701", aFormat);
			sheet.addCell(label12);
			Label label22 = new Label(2, 2, "渠道", bFormat);
			sheet.addCell(label22);
			                 Label label32 = new Label(3, 2, "淘宝", aFormat);
			sheet.addCell(label32);
			Label label42 = new Label(4, 2, "年龄", bFormat);
			sheet.addCell(label42);
			                  Label label52 = new Label(5, 2, "26", aFormat);
			sheet.addCell(label52);
			Label label62 = new Label(6, 2, "客户电话", bFormat);
			sheet.addCell(label62);
			             Label label72 = new Label(7, 2, "18013866641", aFormat);
			sheet.addCell(label72);
			
			//第四行
			Label label03 = new Label(0, 3, "微信名", bFormat);
			sheet.addCell(label03);
			Label label13 = new Label(1, 3, "钟", aFormat);
			sheet.addCell(label13);
			Label label23 = new Label(2, 3, "下单客服", bFormat);
			sheet.addCell(label23);
			Label label33 = new Label(3, 3, "sjsj", aFormat);
			sheet.addCell(label33);
			Label label43 = new Label(4, 3, "性别", bFormat);
			sheet.addCell(label43);
			Label label53 = new Label(5, 3, "男", aFormat);
			sheet.addCell(label53);
			Label label63 = new Label(6, 3, "客户姓名", bFormat);
			sheet.addCell(label63);
			 Label label73 = new Label(7, 3, "abcdeft", aFormat);
			sheet.addCell(label73);
			
			//第五行
			Label label04 = new Label(0, 4, "订单号", bFormat);
			sheet.addCell(label04);
			Label label14 = new Label(1, 4, "603720737614501053", aFormat);
			sheet.addCell(label14);
			Label label24 = new Label(2, 4, "销售价格", bFormat);
			sheet.addCell(label24);
			Label label34 = new Label(3, 4, "5662", aFormat);
			sheet.addCell(label34);
			Label label44 = new Label(4, 4, "身高", bFormat);
			sheet.addCell(label44);
			Label label54 = new Label(5, 4, "187", aFormat);
			sheet.addCell(label54);
			Label label64 = new Label(6, 4, "体重", bFormat);
			sheet.addCell(label64);
			 Label label74 = new Label(7, 4, "70", aFormat);
			sheet.addCell(label74);
			
			
			//第六行
			Label label05 = new Label(0, 5, "旺旺名", bFormat);
			sheet.addCell(label05);
			Label label15 = new Label(1, 5, "本小明", aFormat);
			sheet.addCell(label15);
			Label label25 = new Label(2, 5, "下单时间", bFormat);
			sheet.addCell(label25);
			Label label35 = new Label(3, 5, "2019.9.1", aFormat);
			sheet.addCell(label35);
			Label label45 = new Label(4, 5, "客户地址", bFormat);
			sheet.addCell(label45);
			Label label55 = new Label(5, 5, "江苏省南京雨花台区雨花客厅3栋309室", aFormat);
			sheet.addCell(label55);
			
			
			//第七行
			Label label06 = new Label(0, 6, "订单类型", bFormat);
			sheet.addCell(label06);
			Label label16 = new Label(1, 6, "新单", aFormat);
			sheet.addCell(label16);
			Label label26 = new Label(2, 6, "交付时间", bFormat);
			sheet.addCell(label26);
			Label label36 = new Label(3, 6, "2019.9.1", aFormat);
			sheet.addCell(label36);
			
			
			//第八行
			Label label07 = new Label(0, 7, "西装数量", bFormat);
			sheet.addCell(label07);
			Label label17 = new Label(1, 7, "1", aFormat);
			sheet.addCell(label17);
			Label label27 = new Label(2, 7, "衣码", bFormat);
			sheet.addCell(label27);
			Label label37 = new Label(3, 7, "48A", aFormat);
			sheet.addCell(label37);
			Label label47 = new Label(4, 7, "衬衫数量", bFormat);
			sheet.addCell(label47);
			Label label57 = new Label(5, 7, "2", aFormat);
			sheet.addCell(label57);
			Label label67 = new Label(6, 7, "衬衫码", bFormat);
			sheet.addCell(label67);
			Label label77 = new Label(7, 7, "L", aFormat);
			sheet.addCell(label77);
		
			
			//第九行
			Label label08 = new Label(0, 8, "肩宽", aFormat);
			sheet.addCell(label08);
			Label label18 = new Label(1, 8, "44", aFormat);
			sheet.addCell(label18);
			Label label28 = new Label(2, 8, "+4", aFormat);
			sheet.addCell(label28);
			Label label38 = new Label(3, 8, "", aFormat);
			sheet.addCell(label38);
			Label label48 = new Label(4, 8, "领围", aFormat);
			sheet.addCell(label48);
			Label label58 = new Label(5, 8, "44", aFormat);
			sheet.addCell(label58);
			
			//第十行
			Label label09 = new Label(0, 9, "胸围", aFormat);
			sheet.addCell(label09);
			Label label19 = new Label(1, 9, "56", aFormat);
			sheet.addCell(label19);
			Label label29 = new Label(2, 9, "", aFormat);
			sheet.addCell(label29);
			Label label39 = new Label(3, 9, "", aFormat);
			sheet.addCell(label39);
			Label label49 = new Label(4, 9, "胸围", aFormat);
			sheet.addCell(label49);
			Label label59 = new Label(5, 9, "44", aFormat);
			sheet.addCell(label59);
			
			//第十一行
			Label label010 = new Label(0, 10, "中腰", aFormat);
			sheet.addCell(label010);
			Label label110 = new Label(1, 10, "56", aFormat);
			sheet.addCell(label110);
			Label label210 = new Label(2, 10, "", aFormat);
			sheet.addCell(label210);
			Label label310 = new Label(3, 10, "", aFormat);
			sheet.addCell(label310);
			Label label410 = new Label(4, 10, "中腰", aFormat);
			sheet.addCell(label410);
			Label label510 = new Label(5, 10, "44", aFormat);
			sheet.addCell(label510);
			
			//第十二行
			Label label011 = new Label(0, 11, "腹围", aFormat);
			sheet.addCell(label011);
			Label label111 = new Label(1, 11, "56", aFormat);
			sheet.addCell(label111);
			Label label211 = new Label(2, 11, "", aFormat);
			sheet.addCell(label211);
			Label label311 = new Label(3, 11, "", aFormat);
			sheet.addCell(label311);
			Label label411 = new Label(4, 11, "肩宽", aFormat);
			sheet.addCell(label411);
			Label label511 = new Label(5, 11, "44", aFormat);
			sheet.addCell(label511);
			
			//第十三行
			Label label012 = new Label(0, 12, "后中衣长", aFormat);
			sheet.addCell(label012);
			Label label112 = new Label(1, 12, "56", aFormat);
			sheet.addCell(label112);
			Label label212 = new Label(2, 12, "", aFormat);
			sheet.addCell(label212);
			Label label312 = new Label(3, 12, "斜度＋1度", aFormat);
			sheet.addCell(label312);
			Label label412 = new Label(4, 12, "衣长", aFormat);
			sheet.addCell(label412);
			Label label512 = new Label(5, 12, "44", aFormat);
			sheet.addCell(label512);
			Label label612 = new Label(6, 12, "", aFormat);
			sheet.addCell(label612);
			Label label712 = new Label(7, 12, "修身款", aFormat);
			sheet.addCell(label712);
			
			//第十四行
			Label label013 = new Label(0, 13, "前衣长", aFormat);
			sheet.addCell(label013);
			Label label113 = new Label(1, 13, "56", aFormat);
			sheet.addCell(label113);
			Label label213 = new Label(2, 13, "", aFormat);
			sheet.addCell(label213);
			Label label313 = new Label(3, 13, "", aFormat);
			sheet.addCell(label313);
			Label label413 = new Label(4, 13, "腹围", aFormat);
			sheet.addCell(label413);
			Label label513 = new Label(5, 13, "44", aFormat);
			sheet.addCell(label513);
			
			//第十五行
			Label label014 = new Label(0, 14, "袖长", aFormat);
			sheet.addCell(label014);
			Label label114 = new Label(1, 14, "56", aFormat);
			sheet.addCell(label114);
			Label label214 = new Label(2, 14, "", aFormat);
			sheet.addCell(label214);
			Label label314 = new Label(3, 14, "", aFormat);
			sheet.addCell(label314);
			Label label414 = new Label(4, 14, "袖长", aFormat);
			sheet.addCell(label414);
			Label label514 = new Label(5, 14, "44", aFormat);
			sheet.addCell(label514);
			
			
			//第十六行
			Label label015 = new Label(0, 15, "袖肥", aFormat);
			sheet.addCell(label015);
			Label label115 = new Label(1, 15, "56", aFormat);
			sheet.addCell(label115);
			Label label215 = new Label(2, 15, "", aFormat);
			sheet.addCell(label215);
			Label label315 = new Label(3, 15, "", aFormat);
			sheet.addCell(label315);
			Label label415 = new Label(4, 15, "袖肥", aFormat);
			sheet.addCell(label415);
			Label label515 = new Label(5, 15, "44", aFormat);
			sheet.addCell(label515);
			
			
			//第十七行
			Label label016 = new Label(0, 16, "袖口", aFormat);
			sheet.addCell(label016);
			Label label116 = new Label(1, 16, "56", aFormat);
			sheet.addCell(label116);
			Label label216 = new Label(2, 16, "", aFormat);
			sheet.addCell(label216);
			Label label316 = new Label(3, 16, "", aFormat);
			sheet.addCell(label316);
			Label label416 = new Label(4, 16, "袖口", aFormat);
			sheet.addCell(label416);
			Label label516 = new Label(5, 16, "44", aFormat);
			sheet.addCell(label516);
			
			
			//第十八行
			Label label017 = new Label(0, 17, "西裤数量", bFormat);
			sheet.addCell(label017);
			Label label117 = new Label(1, 17, "1", aFormat);
			sheet.addCell(label117);
			Label label217 = new Label(2, 17, "裤码", bFormat);
			sheet.addCell(label217);
			Label label317 = new Label(3, 17, "43码", aFormat);
			sheet.addCell(label317);
			Label label417 = new Label(4, 17, "马甲数量", bFormat);
			sheet.addCell(label417);
			Label label517 = new Label(5, 17, "2", aFormat);
			sheet.addCell(label517);
			Label label617 = new Label(6, 17, "马甲码", bFormat);
			sheet.addCell(label617);
			Label label717 = new Label(7, 17, "33码", aFormat);
			sheet.addCell(label717);
			
			//第十九行
			Label label018 = new Label(0, 18, "腰围", aFormat);
			sheet.addCell(label018);
			Label label118 = new Label(1, 18, "56", aFormat);
			sheet.addCell(label118);
			Label label218 = new Label(2, 18, "", aFormat);
			sheet.addCell(label218);
			Label label318 = new Label(3, 18, "", aFormat);
			sheet.addCell(label318);
			Label label418 = new Label(4, 18, "肩宽", aFormat);
			sheet.addCell(label418);
			Label label518 = new Label(5, 18, "44", aFormat);
			sheet.addCell(label518);
			
			//第十九行
			Label label019 = new Label(0, 19, "臀围", aFormat);
			sheet.addCell(label019);
			Label label119 = new Label(1, 19, "56", aFormat);
			sheet.addCell(label119);
			Label label219 = new Label(2, 19, "", aFormat);
			sheet.addCell(label219);
			Label label319 = new Label(3, 19, "", aFormat);
			sheet.addCell(label319);
			Label label419 = new Label(4, 19, "胸围", aFormat);
			sheet.addCell(label419);
			Label label519 = new Label(5, 19, "44", aFormat);
			sheet.addCell(label519);
			
			//第二十行
			Label label020 = new Label(0, 20, "裆围", aFormat);
			sheet.addCell(label020);
			Label label120 = new Label(1, 20, "56", aFormat);
			sheet.addCell(label120);
			Label label220 = new Label(2, 20, "", aFormat);
			sheet.addCell(label220);
			Label label320 = new Label(3, 20, "", aFormat);
			sheet.addCell(label320);
			Label label420 = new Label(4, 20, "中腰", aFormat);
			sheet.addCell(label420);
			Label label520 = new Label(5, 20, "44", aFormat);
			sheet.addCell(label520);
			
			
			//第二十一行
			Label label021 = new Label(0, 21, "大腿", aFormat);
			sheet.addCell(label021);
			Label label121 = new Label(1, 21, "56", aFormat);
			sheet.addCell(label121);
			Label label221 = new Label(2, 21, "", aFormat);
			sheet.addCell(label221);
			Label label321 = new Label(3, 21, "", aFormat);
			sheet.addCell(label321);
			Label label421 = new Label(4, 21, "衣长", aFormat);
			sheet.addCell(label421);
			Label label521 = new Label(5, 21, "44", aFormat);
			sheet.addCell(label521);
			
			//第二十一行
			Label label022 = new Label(0, 22, "中腿", aFormat);
			sheet.addCell(label022);
			Label label122 = new Label(1, 22, "56", aFormat);
			sheet.addCell(label122);
			Label label222 = new Label(2, 22, "", aFormat);
			sheet.addCell(label222);
			Label label322 = new Label(3, 22, "裤裆下挖1公分", aFormat);
			sheet.addCell(label322);
			Label label422 = new Label(4, 22, "款型", aFormat);
			sheet.addCell(label422);
			Label label522 = new Label(5, 22, "修身、合身、宽松", aFormat);
			sheet.addCell(label522);
			Label label622 = new Label(6, 22, "", aFormat);
			sheet.addCell(label622);
			Label label722 = new Label(7, 22, "短一点", aFormat);
			sheet.addCell(label722);
			
			
			//第二十二行
			Label label023 = new Label(0, 23, "小腿", aFormat);
			sheet.addCell(label023);
			Label label123 = new Label(1, 23, "56", aFormat);
			sheet.addCell(label123);
			Label label223 = new Label(2, 23, "", aFormat);
			sheet.addCell(label223);
			
			
			//第二十三行
			Label label024 = new Label(0, 24, "裤长", aFormat);
			sheet.addCell(label024);
			Label label124 = new Label(1, 24, "56", aFormat);
			sheet.addCell(label124);
			Label label224 = new Label(2, 24, "", aFormat);
			sheet.addCell(label224);
			
			//第二十四行
			Label label025 = new Label(0, 25, "脚口", aFormat);
			sheet.addCell(label025);
			Label label125 = new Label(1, 25, "56", aFormat);
			sheet.addCell(label125);
			Label label225 = new Label(2, 25, "", aFormat);
			sheet.addCell(label225);
			
			
			//第二十五行
			Label label026 = new Label(0, 26, "扣型", bFormat);
			sheet.addCell(label026);
			Label label126 = new Label(1, 26, "", aFormat);
			sheet.addCell(label126);
			Label label226 = new Label(2, 26, "口袋", bFormat);
			sheet.addCell(label226);
			Label label326 = new Label(3, 26, "", aFormat);
			sheet.addCell(label326);
			Label label426 = new Label(4, 26, "开叉", bFormat);
			sheet.addCell(label426);
			Label label526 = new Label(5, 26, "", aFormat);
			sheet.addCell(label526);
			Label label626 = new Label(6, 26, "领型", bFormat);
			sheet.addCell(label626);
			Label label726 = new Label(7, 26, "", aFormat);
			sheet.addCell(label726);
			
			//第二十六行
			Label label027 = new Label(0, 27, "下摆", bFormat);
			sheet.addCell(label027);
			Label label127 = new Label(1, 27, "", aFormat);
			sheet.addCell(label127);
			Label label227 = new Label(2, 27, "撞色", bFormat);
			sheet.addCell(label227);
			Label label327 = new Label(3, 27, "", aFormat);
			sheet.addCell(label327);
			Label label427 = new Label(4, 27, "外珠边", bFormat);
			sheet.addCell(label427);
			Label label527 = new Label(5, 27, "", aFormat);
			sheet.addCell(label527);
			Label label627 = new Label(6, 27, "袖叉", bFormat);
			sheet.addCell(label627);
			Label label727 = new Label(7, 27, "", aFormat);
			sheet.addCell(label727);
			
			
			//第二十七行
			Label label028 = new Label(0, 28, "裤腰", bFormat);
			sheet.addCell(label028);
			Label label128 = new Label(1, 28, "", aFormat);
			sheet.addCell(label128);
			Label label228 = new Label(2, 28, "裤型", bFormat);
			sheet.addCell(label228);
			Label label328 = new Label(3, 28, "", aFormat);
			sheet.addCell(label328);
			Label label428 = new Label(4, 28, "衬衫领", bFormat);
			sheet.addCell(label428);
			Label label528 = new Label(5, 28, "", aFormat);
			sheet.addCell(label528);
			Label label628 = new Label(6, 28, "衬衫袖", bFormat);
			sheet.addCell(label628);
			Label label728 = new Label(7, 28, "", aFormat);
			sheet.addCell(label728);
			
			
			//第二十八行
			Label label029 = new Label(0, 29, "面料1", bFormat);
			sheet.addCell(label029);
			Label label129 = new Label(1, 29, "5567-09", aFormat);
			sheet.addCell(label129);
			Label label229 = new Label(2, 29, "米数", bFormat);
			sheet.addCell(label229);
			Label label329 = new Label(3, 29, "2.8", aFormat);
			sheet.addCell(label329);
			Label label429 = new Label(4, 29, "用途", bFormat);
			sheet.addCell(label429);
			Label label529 = new Label(5, 29, "套西", aFormat);
			sheet.addCell(label529);
			Label label629 = new Label(6, 29, "供应商", bFormat);
			sheet.addCell(label629);
			Label label729 = new Label(7, 29, "美酷", aFormat);
			sheet.addCell(label729);
			
			//第二十九行
			Label label030 = new Label(0, 30, "面料1", bFormat);
			sheet.addCell(label030);
			Label label130 = new Label(1, 30, "5567-09", aFormat);
			sheet.addCell(label130);
			Label label230 = new Label(2, 30, "米数", bFormat);
			sheet.addCell(label230);
			Label label330 = new Label(3, 30, "2.8", aFormat);
			sheet.addCell(label330);
			Label label430 = new Label(4, 30, "用途", bFormat);
			sheet.addCell(label430);
			Label label530 = new Label(5, 30, "套西", aFormat);
			sheet.addCell(label530);
			Label label630 = new Label(6, 30, "供应商", bFormat);
			sheet.addCell(label630);
			Label label730 = new Label(7, 30, "美酷", aFormat);
			sheet.addCell(label730);
			
			//第三十行
			Label label031 = new Label(0, 31, "客服备注", bFormat);
			sheet.addCell(label031);
			Label label131 = new Label(1, 31, "", aFormat);
			sheet.addCell(label131);
			
			
			//第三十一行
			Label label032 = new Label(0, 32, "批单备注", bFormat);
			sheet.addCell(label032);
			Label label132 = new Label(1, 32, "", aFormat);
			sheet.addCell(label132);
			
			//第三十二行
			Label label033 = new Label(0, 33, "跟单备注", bFormat);
			sheet.addCell(label033);
			Label label133 = new Label(1, 33, "", aFormat);
			sheet.addCell(label133);
			
			
			//第三十二行
			Label label034 = new Label(0, 34, "备注", bFormat);
			sheet.addCell(label034);
			Label label134 = new Label(1, 34, "", aFormat);
			sheet.addCell(label134);
			
			
			
			
			
			
			
			
		
			sheet.setColumnView(0, 10);
			sheet.setColumnView(1, 12);
			sheet.setColumnView(2, 10);
			sheet.setColumnView(3, 12);
			sheet.setColumnView(4, 10);
			sheet.setColumnView(5, 12);
			sheet.setColumnView(6, 10);
			sheet.setColumnView(7, 12);
			sheet.setColumnView(8, 10);
			sheet.setColumnView(9, 12);
			
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
			sheet.setRowView(14, 400, false);
			sheet.setRowView(15, 400, false);
			sheet.setRowView(16, 400, false);
			sheet.setRowView(17, 400, false);
			sheet.setRowView(18, 400, false);
			sheet.setRowView(19, 400, false);
			sheet.setRowView(20, 400, false);
			sheet.setRowView(21, 400, false);
			sheet.setRowView(22, 400, false);
			sheet.setRowView(23, 400, false);
			sheet.setRowView(24, 400, false);
			sheet.setRowView(25, 400, false);
			sheet.setRowView(26, 400, false);
			sheet.setRowView(27, 400, false);
			sheet.setRowView(28, 400, false);
			sheet.setRowView(29, 400, false);
			sheet.setRowView(30, 400, false);
			sheet.setRowView(31, 400, false);
			sheet.setRowView(32, 400, false);
			sheet.setRowView(33, 400, false);
			sheet.setRowView(34, 400, false);
			sheet.setRowView(35, 400, false);
			sheet.setRowView(36, 400, false);
			sheet.setRowView(37, 400, false);
			sheet.setRowView(38, 400, false);
			sheet.setRowView(39, 400, false);
		
			
			
//		      File file = new File("D:/123.png");
		     File file = new File("E:/test/123.png");
			WritableImage image1 = new WritableImage(3, 8, 1, 4, file);
			sheet.addImage(image1);
			
			WritableImage image2 = new WritableImage(7, 8, 1, 4, file);
			sheet.addImage(image2);
			
			WritableImage image3 = new WritableImage(3, 18, 1, 4, file);
			sheet.addImage(image3);
			
			WritableImage image4 = new WritableImage(7, 18, 1, 4, file);
			sheet.addImage(image4);
			
			
			// 这里的第一个数据代表第二列，第二个数据代表第一行，第三个数据代表第四列，第四个数据代表第二行
			sheet.mergeCells(0, 0, 7, 0);   //横 1 4  纵   纵 0 2
			
			sheet.mergeCells(0, 1, 3, 1);   //横 1 4  纵   纵 0 2
			
		    sheet.mergeCells(4, 1, 7, 1);   //横 1 4  纵   纵 0 2
		    
		    sheet.mergeCells(4, 5, 4, 6);   //横 1 4  纵   纵 0 2
		    
		    sheet.mergeCells(5, 5, 7, 6);   //横 1 4  纵   纵 0 2
		    
		    
		    
		    sheet.mergeCells(3, 12, 3, 16);   //横 1 4  纵   纵 0 2
		    sheet.mergeCells(7, 12, 7, 16);   //横 1 4  纵   纵 0 2
		    
		    
		    sheet.mergeCells(3, 22, 3, 26);   //横 1 4  纵   纵 0 2
		
		    
		    sheet.mergeCells(1, 31, 7, 31);   //横 1 4  纵   纵 0 2
		    sheet.mergeCells(1, 32, 7, 32);   //横 1 4  纵   纵 0 2
		    sheet.mergeCells(1, 33, 7, 33);   //横 1 4  纵   纵 0 2
		    sheet.mergeCells(1, 34, 7, 34);   //横 1 4  纵   纵 0 2
		    
		    
		    sheet.mergeCells(4, 22, 4, 25);   //横 1 4  纵   纵 0 2
		    sheet.mergeCells(5, 22, 6, 25);   //横 1 4  纵   纵 0 2
		    sheet.mergeCells(7, 22, 7, 25);   //横 1 4  纵   纵 0 2
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
			
			//writeExcelDaBiao("4","11909200007001");
			writeExcelXiangQing("123","11909200007001");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}

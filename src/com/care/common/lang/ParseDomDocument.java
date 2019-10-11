package com.care.common.lang;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;

public class ParseDomDocument {

	// private static String xmlFileString = "F:/test/不一定制洗水标.xml";
	/**
	 * load 载入一个xml文档
	 * 
	 * @return 成功返回Document对象，失败返回null
	 * @param uri
	 *            文件路径
	 */
	public static Document load(String filename) {
		Document document = null;
		try {
			SAXReader saxReader = new SAXReader();
			document = saxReader.read(new File(filename));
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return document;
	}

	public static void xmlReadDemo(String filePath, String orderId,
			String kehuName, String riqi, String yaowei, String png)
			throws IOException {
System.err.println(png);
		Document doc = load(filePath);
		/** 先用xpath查找所有ftp节点 并输出它的name属性值 */
		List list = doc
				.selectNodes("/DLabel/paper/labelobjects/drawobj/textlist");
		Iterator it = list.iterator();
		while (it.hasNext()) {
			Element ftpElement = (Element) it.next();
			String valueString = ((Element) ftpElement.content().get(1))
					.attribute("value").getValue();
			
			/******************** 在这里设置值 **********************/
			if (valueString.equals("11909080602")) {
				((Element) ftpElement.content().get(1)).attribute("value")
						.setValue(orderId);
			}

			if (valueString.equals("盘文清")) {
				((Element) ftpElement.content().get(1)).attribute("value")
						.setValue(kehuName);
			}

			if (valueString.equals("2019/9/8")) {
				if (riqi.length() > 10) {

					((Element) ftpElement.content().get(1)).attribute("value")
							.setValue(riqi.substring(0, 10));
				} else {
					((Element) ftpElement.content().get(1)).attribute("value")
							.setValue(riqi);
				}
			}
			if (valueString.equals("74")) {
				((Element) ftpElement.content().get(1)).attribute("value")
						.setValue(yaowei);
			}
			
			if (valueString.equals("哈哈哈哈")) {
				((Element) ftpElement.content().get(1)).attribute("value")
						.setValue(png);
			}
			System.out.println("ftp_name1="+ ((Element)ftpElement.content().get(1)).attribute("value").getValue()); 
		
			
		}
		
		
	/*	list = doc.selectNodes("/DLabel/paper/labelobjects");
		it = list.iterator();
		while (it.hasNext()) {
			Element ftpElement = (Element) it.next();
			String valueString = ((Element) ftpElement.content().get(1))
					.attribute("image").getValue();
		
			if (valueString
					.equals("C:/Users/Administrator/Desktop/8888/74ea755f957dde2b4862a6b7c24389ef_.jpg")) {
				((Element) ftpElement.content().get(1)).attribute("base64")
						.setValue(png);
			}

		}*/

		// 此时 数据保存在内存中而本地xml没有同步 这时 我们需要内存中的对象 回写到xml
		OutputFormat format = OutputFormat.createPrettyPrint();
		XMLWriter xmlWriter = new XMLWriter(new FileOutputStream(filePath),
				format);
		xmlWriter.write(doc);
		xmlWriter.close();
	}

	public static void main(String[] args) throws Exception {

		try {
			// 先复制 后修改 再改名
			// xmlReadDemo();

			File source = new File("F:/test/不一定制洗水标.xml");// 原复制文件
			String lastName = "F:/test/testte.xml";// 复制到的地方路径和名称
			String lastNameddl = "F:/test/testte.ddl";// 最终修改的名称
			File dest = new File(lastName);
			TestFileManager.copyFileUsingFileChannels(source, dest);

			// xmlReadDemo(lastName,"妮妮","喔喔","嘻嘻","哈哈");

			File file = new File(lastName);
			file.renameTo(new File(lastNameddl));
		} catch (Exception ex) {
			System.out.println(ex.toString());
			throw new Exception(ex);
		}

	}
}

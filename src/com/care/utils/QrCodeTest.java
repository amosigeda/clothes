package com.care.utils;

public class QrCodeTest {
	public static void main(String[] args) throws Exception {
		// 存放在二维码中的内容
		String text = "我是小铭";
		// 嵌入二维码的图片路径
		String imgPath = "F:/UI/test/1.png";
		// 生成的二维码的路径及名称
		String destPath = "F:/UI/test/2.jpg";
		//生成二维码
		QRCodeUtil.encode(text, imgPath, destPath, true);
		// 解析二维码
		String str = QRCodeUtil.decode(destPath);
		// 打印出解析出的内容
		System.out.println(str);
 
	}

}

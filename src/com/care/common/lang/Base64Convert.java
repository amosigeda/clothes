package com.care.common.lang;


 

import java.io.*;

import org.apache.commons.codec.binary.Base64;


public class Base64Convert {


    /**
     * @Description： 图片转化成base64字符串
     * @param:    path
     * @Return:
     */
    public static String GetImageStr(String path)
    {
        //将图片文件转化为字节数组字符串，并对其进行Base64编码处理
        //待处理的图片
        String imgFile = path;
        InputStream in = null;
        byte[] data = null;
        //读取图片字节数组
        try
        {
            in = new FileInputStream(imgFile);
            data = new byte[in.available()];
            in.read(data);
            in.close();
        }
        catch (IOException e)
        {
            e.printStackTrace();
        }
        //对字节数组Base64编码

        //返回Base64编码过的字节数组字符串
        return     new String(Base64.encodeBase64(data));
    }
   
public static void main(String[] args) {
	System.out.println(GetImageStr("D:/1.png"));
}

}

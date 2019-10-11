package com.care.common.lang;

import java.io.*;
import java.nio.channels.FileChannel;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class TestFileManager {
	
	public static void copyFileUsingFileChannels(File source, File dest) throws IOException {    
        FileChannel inputChannel = null;    
        FileChannel outputChannel = null;    
    try {
        inputChannel = new FileInputStream(source).getChannel();
        outputChannel = new FileOutputStream(dest).getChannel();
        outputChannel.transferFrom(inputChannel, 0, inputChannel.size());
    } finally {
        inputChannel.close();
        outputChannel.close();
    }
}
	
	/**
     * 通过文件路径直接修改文件名
     * 
     * @param filePath    需要修改的文件的完整路径
     * @param newFileName 需要修改的文件的名称
     * @return
     */
    static String FixFileName(String filePath, String newFileName) {
        File f = new File(filePath);
        if (!f.exists()) { // 判断原文件是否存在（防止文件名冲突）
            return null;
        }
        newFileName = newFileName.trim();
        if ("".equals(newFileName) || newFileName == null) // 文件名不能为空
            return null;
        String newFilePath = null;
        if (f.isDirectory()) { // 判断是否为文件夹
            newFilePath = filePath.substring(0, filePath.lastIndexOf("/")) + "/" + newFileName;
        } else {
            newFilePath = filePath.substring(0, filePath.lastIndexOf("/")) + "/" + newFileName
                    + filePath.substring(filePath.lastIndexOf("."));
        }
        File nf = new File(newFilePath);
        try {
            f.renameTo(nf); // 修改文件名
        } catch (Exception err) {
            err.printStackTrace();
            return null;
        }
        return newFilePath;
    }
    
	static void getNew(String path,String name) {
		File file = new File(path);
		//得到文件夹下的所有文件和文件夹
		String[] list = file.list();
		
		if(list!=null && list.length>0){
			for (String oldName : list) {
				File oldFile = new File(path,oldName);
				//判断出文件和文件夹
				if(!oldFile.isDirectory()){
					//文件则判断是不是要修改的
					if(oldName.contains(".xml")){
						System.out.println(oldName);
						String newoldName = oldName.substring(0, oldName.lastIndexOf("."))+".ddl";
						System.out.println(newoldName);
						File newFile = new File(path,newoldName);
						boolean flag = oldFile.renameTo(newFile);
						System.out.println(flag);
					}
				}else{
					//文件夹则迭代
					String newpath=path+"/"+oldName;
					getNew(newpath,name);
				}
			}
		}
	}


}

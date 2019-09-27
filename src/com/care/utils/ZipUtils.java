package com.care.utils;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class ZipUtils {
	
	public static String zip(String fileName) {

        String zipName=UUID.randomUUID().toString();//压缩以后的文件名
       // String zipPath = "/mnt/fileserver"; //压缩以后文件的存放路径
        String zipPath = "D:\\resin\\webapps\\watch\\upload\\photo\\11909270007001"; //压缩以后文件的存放路径
        String sourcePath="D:\\resin\\webapps\\watch\\upload\\photo\\11909270007001";//要压缩的文件的路径
        File sourceFile = new File(sourcePath);  
        FileInputStream fis = null;  
        BufferedInputStream bis = null;  
        FileOutputStream fos = null;  
        ZipOutputStream zos = null;  
 
        if (sourceFile.exists() == false) {  
            System.out.println("File catalog:" + sourcePath + "not exist!");  
        } else {  
            try {  
                if(!new File(zipPath).exists()){  
                    new File(zipPath).mkdirs();  
                }  
                File zipFile = new File(zipPath + "/" + zipName + ".zip");  
                System.out.println(zipFile);
                if (zipFile.exists()) {  
                    System.out.println(zipPath + "Catalog File: " + zipName + ".zip" + "pack file.");  
                } else {  
                    File[] sourceFiles = sourceFile.listFiles();  
                    if (null == sourceFiles || sourceFiles.length < 1) {  
                        System.out.println("File Catalog:" + sourcePath + "nothing in there,don't hava to compress!");  
                    } else {  
                        fos = new FileOutputStream(zipFile);  
                        zos = new ZipOutputStream(new BufferedOutputStream(fos));  
                        byte[] bufs = new byte[1024 * 10];  
                        for (int i = 0; i < sourceFiles.length; i++) {
                            if(sourceFiles[i].getName().equals(fileName)){                               
                                // create .zip and put pictures in  
                                ZipEntry zipEntry = new ZipEntry(sourceFiles[i].getName());  
                                zos.putNextEntry(zipEntry);  
                                // read documents and put them in the zip  
                                fis = new FileInputStream(sourceFiles[i]);  
                                bis = new BufferedInputStream(fis, 1024 * 10);  
                                int read = 0;  
                                while ((read = bis.read(bufs, 0, 1024 * 10)) != -1) {  
                                    zos.write(bufs, 0, read);  
                                }  
                            }
                        }   
                    }  
                }  
            } catch (FileNotFoundException e) {  
                e.printStackTrace();  
                throw new RuntimeException(e);  
            } catch (IOException e) {  
                e.printStackTrace();  
                throw new RuntimeException(e);  
            } finally {  
                try {  
                    if (null != bis)  
                        bis.close();  
                    if (null != zos)  
                        zos.close();  
                } catch (IOException e) {  
                    e.printStackTrace();  
                    throw new RuntimeException(e);  
                }  
            }  
        }  
        return zipName;  
    }
	
	private static final int  BUFFER_SIZE = 2 * 1024;
	

	 
	
	    /**
	23
	     * 压缩成ZIP 方法1
	24
	     * @param srcDir 压缩文件夹路径 
	25
	     * @param out    压缩文件输出流
	26
	     * @param KeepDirStructure  是否保留原来的目录结构,true:保留目录结构; 
	27
	     *                          false:所有文件跑到压缩包根目录下(注意：不保留目录结构可能会出现同名文件,会压缩失败)
	28
	     * @throws RuntimeException 压缩失败会抛出运行时异常
	29
	     */
	
	    public static void toZip(String srcDir, OutputStream out, boolean KeepDirStructure)
	
	            throws RuntimeException{

	    	
	        long start = System.currentTimeMillis();
	
	        ZipOutputStream zos = null ;
	
	        try {
	
	            zos = new ZipOutputStream(out);
	            File sourceFile = new File(srcDir);
	            compress(sourceFile,zos,sourceFile.getName(),KeepDirStructure);
	            long end = System.currentTimeMillis();
	            System.out.println("压缩完成，耗时：" + (end - start) +" ms");
	        } catch (Exception e) {
	            throw new RuntimeException("zip error from ZipUtils",e);
	        }finally{
	            if(zos != null){
	                try {
	                    zos.close();
	                } catch (IOException e) {
	                    e.printStackTrace();
	                }
	            }
	        }
	        
	    }
	    

	    public static void toZip(List<File> srcFiles , OutputStream out)throws RuntimeException {
	        long start = System.currentTimeMillis();
	        ZipOutputStream zos = null ;
	        try {
	            zos = new ZipOutputStream(out);
	            for (File srcFile : srcFiles) {
	                byte[] buf = new byte[BUFFER_SIZE];
	                zos.putNextEntry(new ZipEntry(srcFile.getName()));
	                int len;
	                FileInputStream in = new FileInputStream(srcFile);
	                while ((len = in.read(buf)) != -1){
	                    zos.write(buf, 0, len);
	                }
	                zos.closeEntry();
	                in.close();
	            }
	            long end = System.currentTimeMillis();
	            System.out.println("压缩完成，耗时：" + (end - start) +" ms");
	        } catch (Exception e) {
	            throw new RuntimeException("zip error from ZipUtils",e);
	        }finally{
	            if(zos != null){
	                try {
	                    zos.close();
	                } catch (IOException e) {
	                    e.printStackTrace();
	                }
	            }
	        }
	    }
	    

	    private static void compress(File sourceFile, ZipOutputStream zos, String name,
	            boolean KeepDirStructure) throws Exception{
	        byte[] buf = new byte[BUFFER_SIZE];
	        if(sourceFile.isFile()){
	            // 向zip输出流中添加一个zip实体，构造器中name为zip实体的文件的名字
	            zos.putNextEntry(new ZipEntry(name));
	            // copy文件到zip输出流中
	            int len;
	            FileInputStream in = new FileInputStream(sourceFile);
	            while ((len = in.read(buf)) != -1){
	                zos.write(buf, 0, len);
	            }
	            // Complete the entry
	            zos.closeEntry();
	            in.close();
	        } else {
	            File[] listFiles = sourceFile.listFiles();
	            if(listFiles == null || listFiles.length == 0){
	                // 需要保留原来的文件结构时,需要对空文件夹进行处理
	                if(KeepDirStructure){
	                    // 空文件夹的处理
	                    zos.putNextEntry(new ZipEntry(name + "/"));
	                    // 没有文件，不需要文件的copy
	                    zos.closeEntry();
	                }
	                
	            }else {
	                for (File file : listFiles) {
	                    // 判断是否需要保留原来的文件结构
	                    if (KeepDirStructure) {
	                        // 注意：file.getName()前面需要带上父文件夹的名字加一斜杠,
	                        // 不然最后压缩包中就不能保留原来的文件结构,即：所有文件都跑到压缩包根目录下了
	                        compress(file, zos, name + "/" + file.getName(),KeepDirStructure);
	                    } else {
	                        compress(file, zos, file.getName(),KeepDirStructure);
	                    }
	                    
	                }
	            }
	        }
	    }
	    
	    public static ZipOutputStream craeteZipPath(String path) throws IOException{
	        ZipOutputStream zipOutputStream = null;
	        File file = new File(path+System.currentTimeMillis()+".zip");
	        zipOutputStream = new ZipOutputStream(new BufferedOutputStream(new FileOutputStream(file)));
	        File[] files = new File(path).listFiles();
	        FileInputStream fileInputStream = null;
	        byte[] buf = new byte[1024];
	        int len = 0;
	        if(files!=null && files.length > 0){
	            for(File excelFile:files){
	                String fileName = excelFile.getName();
	                fileInputStream = new FileInputStream(excelFile);
	                //放入压缩zip包中;
	                zipOutputStream.putNextEntry(new ZipEntry(path + "/"+fileName));
	                //读取文件;
	                while((len=fileInputStream.read(buf)) >0){
	                    zipOutputStream.write(buf, 0, len);
	                }
	                //关闭;
	                zipOutputStream.closeEntry();
	                if(fileInputStream != null){
	                    fileInputStream.close();
	                }
	                System.out.println(1);
	            }
	        }

	        /*if(zipOutputStream !=null){
	            zipOutputStream.close();
	        }*/
	        return zipOutputStream;
	    }
	    
	    
	    public static void zipAA(String input, String output, String name) throws Exception {
	        ZipOutputStream out = new ZipOutputStream(new FileOutputStream(output));
	        String[] paths = input.split("\\|");
	        File[] files = new File[paths.length];
	        byte[] buffer = new byte[1024];
	        for (int i = 0; i < paths.length; i++) {
	          files[i] = new File(paths[i]);
	        }
	        for (int i = 0; i < files.length; i++) {
	          FileInputStream fis = new FileInputStream(files[i]);
	          if (files.length == 1 && name != null) {
	            out.putNextEntry(new ZipEntry(name));
	          } else {
	            out.putNextEntry(new ZipEntry(files[i].getName()));
	          }
	          int len;
	          // 读入需要下载的文件的内容，打包到zip文件
	          while ((len = fis.read(buffer)) > 0) {
	            out.write(buffer, 0, len);
	          }
	          out.closeEntry();
	          fis.close();
	          System.out.println("结束");
	        }
	        out.close();
	      }
	    

		
	    public static void main(String[] args) throws Exception {
	    	//craeteZipPath("D:/resin/webapps/watch/upload/photo/123/");
	    	
	    	zipAA("D:/resin/webapps/watch/upload/photo/zip","D:/resin/webapps/watch/upload/photo/","zz.zip");
	    	//zip("11909270007001.xls"); //压缩一个
	        /** 测试压缩方法1  */
	      /*  FileOutputStream fos1 = new FileOutputStream(new File("F:/UI/test/wei.zip"));
	        ZipUtils.toZip("F:/UI/test/chicun", fos1,true);*/
	        
	        /** 测试压缩方法2  */
	        /*List<File> fileList = new ArrayList<>();
	        fileList.add(new File("D:/Java/jdk1.7.0_45_64bit/bin/jar.exe"));
	        fileList.add(new File("D:/Java/jdk1.7.0_45_64bit/bin/java.exe"));
	        FileOutputStream fos2 = new FileOutputStream(new File("c:/mytest02.zip"));
	        ZipUtils.toZip(fileList, fos2);*/
	    }

}

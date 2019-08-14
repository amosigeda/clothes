package com.yingguo.controller.master;

import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class LinRouHua {
	 private final static Lock lock = new ReentrantLock();

	public static void main(String[] args) {
		
		       /* float a = 1.0f - 0.9f;
		        float b = 0.9f - 0.8f;
		        if (a == b) {
		            System.out.println("true");
		        } else {
		            System.out.println("false");
		        }*/
		        
		        
		      /*  Float a = Float.valueOf(1.0f - 0.9f);
		        Float b = Float.valueOf(0.9f - 0.8f);
		        if (a.equals(b)) {
		            System.out.println("true");
		        } else {
		            System.out.println("false");
		        }*/
		
		
		 /* String param = null;
	        switch (param) {
	            case "null":
	                System.out.println("null");
	                break;
	            default:
	                System.out.println("default");
	        }*/
		
	
		   
		        try {
		            lock.tryLock();
		        } catch (Exception e) {
		            e.printStackTrace();
		        } finally {
		            lock.unlock();
		        }
		    
		    
		//printTopRen(10);
	}
	
	  /*
     * 打印正人字状
     */
    public static void printTopRen(int n){
        for(int i = 1; i <= n; i ++){
            for(int j = i; j < n; j ++){
                System.out.print("   ");
            }
            //左半部分
            for(int j = 1; j <= i; j++){
                if(j == 1)
                    System.out.print(" * ");
                else
                    System.out.print("   ");
            }
            //右半部分
            for(int j = 1; j < i; j++){
                if(j == i - 1)
                    System.out.print(" * ");
                else 
                    System.out.print("   ");
            }
            System.out.println();
        }
    }


}

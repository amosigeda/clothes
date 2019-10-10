package com.care.common.lang;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

public class CommTools {
	public CommTools() {
	}

	public static String  getAddTime(int add) {
//		 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		 String temp = "";
				try {
				     Date date = sdf.parse(sdf.format(new Date()));
					 Calendar cl = Calendar.getInstance();
			            cl.setTime(date);
			            // cl.set(Calendar.DATE, day);
			            cl.add(Calendar.DATE, add);
			           
			            temp = sdf.format(cl.getTime());
			            System.out.println(temp);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	         return   temp;

	}

	// �ڶ����������һ������
	public static String[] compareStr(String[] str1, String[] str2) {
		String str = "";
		for (int i = 0; i < str2.length; i++) {
			boolean is = true;
			String s1 = str2[i];
			for (int j = 0; j < str1.length; j++) {
				String s2 = str1[j];
				if (s1.equals(s2)) {
					is = false;
					break;
				}
			}
			if (is) {
				if ("".equals(str)) {
					str = s1;
				} else {
					str = str + "," + s1;
				}
			}
		}
		String[] s = {};
		if ("".equals(str))
			return s;
		return str.split(",");
	}

	// �ڶ����������һ������
	public static String[] compareStrArray(ArrayList<String> str1,
			ArrayList<String> str2) {
		String str = "";
		for (int i = 0; i < str2.size(); i++) {
			boolean is = true;
			String s1 = str2.get(i);
			for (int j = 0; j < str1.size(); j++) {
				String s2 = str1.get(j);
				if (s1.equals(s2)) {
					is = false;
					break;
				}
			}
			if (is) {
				if ("".equals(str)) {
					str = s1;
				} else {
					str = str + "," + s1;
				}
			}
		}
		String[] s = {};
		if ("".equals(str))
			return s;
		return str.split(",");
	}

	public static void main(String[] str) {
		String[] s1 = { "2" };
		String[] s2 = {};
		System.out.println("CommTools.compareStr(s1,s2);="
				+ CommTools.compareStr(s1, s2));
		
		getAddTime(5);
	}

}

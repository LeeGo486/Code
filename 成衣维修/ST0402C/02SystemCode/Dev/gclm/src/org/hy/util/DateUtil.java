package org.hy.util;


import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import java.util.Locale;



public class DateUtil {

	public static String getFormatDate(String pattern){
		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat(pattern);
		return dateFormat.format(date);
	}
	
	/**
	 * 根据制定的格式将DATE类型转换为制定的字符串格式
	 * @param date
	 * @param pattern
	 * @return String
	 */
	public static String getFormatDate(Date date,String pattern){
		SimpleDateFormat dateFormat = new SimpleDateFormat(pattern);
		return dateFormat.format(date);
	}
	
	/**
	 * 根据传入的延长时间，获取从现在开始延长后的日期
	 * @param int  delayDay
	 * @return String
	 */
	public static String getExpectDateFromNow(int delayDay){
		Calendar cal=Calendar.getInstance(Locale.CHINA);
		cal.add(Calendar.DAY_OF_MONTH, delayDay);
		return getFormatDate(cal.getTime(),"yyyy-MM-dd");
	}
	
	/**
	 * @param args
	 */
	public static void main(String[] arg0){
		System.out.println(getFormatDate("yyyy-MM-dd"));
	}

}

package ep.org.clothingmaintenance.util;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.Locale;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;

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
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String dbip="";
		String port="";
		String dataBaseName=PropertiesUtil.getProperties().getProperty("DataBaseName");
		String pwd = "";
		
		
		int index= Integer.parseInt( PropertiesUtil.getProperties().getProperty("DateSourceIndex"));
		String DBDataSourceFile = "F:/jboss-4.0.5.GA/server/all/deploy/mssql-ds.xml";
		File inputXml=new File(DBDataSourceFile);   
		SAXReader saxReader = new SAXReader();  
		
		try {
			Document document = saxReader.read(inputXml);
			Element root = document.getRootElement();
			Iterator dataSources = root.elementIterator();
			for(int i=1;i<2;i++){
				dataSources.next();
			}
			Element dataSource = (Element) dataSources.next();
			dataSource.selectSingleNode("connection-url").setText("jdbc:sqlserver://"+dbip+":"+port+";DatabaseName="+dataBaseName);
			dataSource.selectSingleNode("password").setText(pwd);
			FileWriter fw = new FileWriter(DBDataSourceFile); 
			XMLWriter writer = new XMLWriter(fw); 
			writer.write(document); 
			fw.close();



			
			
			
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

}

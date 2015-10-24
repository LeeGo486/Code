package org.hy.util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

public class PropertiesUtil {

	private static Properties dbConfigProperties = null;
	private static Properties restParaConfigProperties = null;
	private static Properties properties = null;
	
	/**
	 * 载入dbConfigProperties文件（数据库配置文件）
	 * @param propertesUrl
	 * @throws FileNotFoundException
	 * @throws IOException
	 */
	public static void loadDBProperties(String propertesUrl) throws FileNotFoundException, IOException{
		if(dbConfigProperties==null){
			dbConfigProperties = new Properties();
			dbConfigProperties.load(new FileInputStream(propertesUrl));
		}
	}
	
	/**
	 * 获取数据库配置文件
	 * @return
	 */
	public static Properties getDBProperties(){
		return dbConfigProperties;
	}
	
	
	/**
	 * 载入restParaConfigProperties文件（rest参数库配置文件）
	 * @param propertesUrl
	 * @throws FileNotFoundException
	 * @throws IOException
	 */
	public static void loadRestConfigProperties(String propertesUrl) throws FileNotFoundException, IOException{
		if(restParaConfigProperties==null){
			restParaConfigProperties = new Properties();
			restParaConfigProperties.load(new FileInputStream(propertesUrl));
		}
	}
	
	/**
	 * rest参数库配置文件
	 * @return
	 */
	public static Properties getRestConfigProperties(){
		return restParaConfigProperties;
	}
	
	
	
	public static void loadProperties(String propertesUrl) throws FileNotFoundException, IOException{
		if(properties==null){
			properties = new Properties();
			properties.load(new FileInputStream(propertesUrl));
		}
	}
	
	public static Properties getProperties(){
		return properties;
	}
	
	
	

}

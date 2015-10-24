package org.hy.util;

import org.hy.model.SystemInfo;



public class SystemInfoUtil {
	private static SystemInfo systemInfo;
	
	public static void instanceSystemInfo(){
		if(systemInfo==null){
			systemInfo = new SystemInfo();
			systemInfo.setEnv(PropertiesUtil.getProperties().getProperty("system.env"));
			systemInfo.setLoginEnv(PropertiesUtil.getProperties().getProperty("system.loginEnv"));
		}
		
	}
	
	public static SystemInfo getSystemInfo(){
		instanceSystemInfo();
		return systemInfo;
	}
}

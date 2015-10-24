package org.hy.spring;

public class DataSourceTypeChoose {
	private static final ThreadLocal  threadLocal = new ThreadLocal();
	
	public static void setThreadLocal(String value) {
		threadLocal.set(value);
	}
	
	public static ThreadLocal getThreadLocal() {
		return threadLocal;
	}
	
	public static void clearDataSourceType () { 
		threadLocal.remove();
	} 
	
}

package org.hy.spring;

public class CustomerContextHolder {
	private static final ThreadLocal contextHolder = new ThreadLocal();

	public static void setCustomerType(String com) {
		String customerType="";
		if("雅莹".equals(com)){
			customerType="sessionFactoryDRP";
		}else if("贝爱".equals(com)){
			customerType="sessionFactoryDRPTBF";
		}else if("纳卉".equals(com)){
			customerType="sessionFactoryDRPTEST";
		}else if("X6".equals(com)){
			customerType="sessionFactoryX6";
		}else{
			customerType="sessionFactoryX6";
		}
		
	   System.out.println(customerType+"  customerType cannot be null");
	   contextHolder.set(customerType);
	}

	public static String getCustomerType() {
	   return (String) contextHolder.get();
	}

	public static void clearCustomerType() {
	   contextHolder.remove();
	}


}

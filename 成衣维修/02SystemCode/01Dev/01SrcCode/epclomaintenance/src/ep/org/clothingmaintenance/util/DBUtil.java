package ep.org.clothingmaintenance.util;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBUtil {

	public static Connection getConnection() throws Exception{
		
		InitialContext ctx = new InitialContext();
		String jndiName="java:/"+PropertiesUtil.getProperties().getProperty("dataSourceJNDIName");
		DataSource ds = (DataSource)ctx.lookup(jndiName);//这里要和mysql-ds.xml中对应
		try {
			return ds.getConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			ModifyDataSourceConfig.updateDataSourceFile();
			Thread.sleep(10000);
			ds = (DataSource)ctx.lookup(jndiName);//这里要和mysql-ds.xml中对应
			return ds.getConnection();
			
		
		}

	}

	public static List convertResultToMapList(ResultSet rs) throws SQLException {
		List list = new ArrayList();
		ResultSetMetaData md = rs.getMetaData();
		int columnCount = md.getColumnCount(); // Map rowData;
		while (rs.next()) { // rowData = new HashMap(columnCount);
			Map rowData = new HashMap();
			for (int i = 1; i <= columnCount; i++) {
				rowData.put(md.getColumnName(i), rs.getObject(i));
			}
			list.add(rowData);

		}
		return list;

	}

	
	
	public static Object convertResultTojavaBean(ResultSet rs,String className) throws Exception{
		ResultSetMetaData md = rs.getMetaData();
		int columnCount = md.getColumnCount(); // Map rowData;
		Method method;
		String columnName;
		String methodName;
		Object obj = null;
		if (rs.next()) { // rowData = new HashMap(columnCount);
			obj = Class.forName(className).newInstance();
			for (int i = 1; i <= columnCount; i++) {
				columnName=md.getColumnName(i);
				methodName="set"+  columnName.substring(0, 1).toUpperCase() + columnName.substring(1);
				Object object = rs.getObject(i);
				method = obj.getClass().getMethod(methodName,  new Class[]{String.class});
				
				if(object!=null){
					method.invoke(obj, new Object[]{object.getClass().equals(String.class)?object:object.toString()});
				}
				//rowData.put(md.getColumnName(i), rs.getObject(i));
			}

		}
		return obj;
		
	}
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		try {
			System.out.println(new String("俞晓东".getBytes(),"ASCII"));
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

			
	}

	/**
	 * 根据数据库函数自动生成主键
	 * @return
	 * @throws Exception
	 */
	public static String genarateGuid() throws Exception {
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		String guid = null;
		try {
			conn = DBUtil.getConnection();
			st = conn.createStatement();

			rs = st.executeQuery("select newid()");
			if (rs.next()) {
				guid = rs.getString(1);
			}
			String[] guids = guid.split("-");
			guid = guids[0] + guids[1] + guids[2] + guids[3] + guids[4];

		} finally {
			if (rs != null) {
				rs.close();
			}

			if (st != null) {
				st.close();
			}

			if (conn != null) {
				conn.close();
			}

		}
		return guid;
	}
	
	public Connection getDrpConnection(String com) throws Exception{
		InitialContext ctx = new InitialContext();
		String jndiName="java:/"+PropertiesUtil.getProperties().getProperty("dataSourceJNDIName");
		DataSource ds = (DataSource)ctx.lookup(jndiName);//这里要和mysql-ds.xml中对应
		try {
			return ds.getConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			ModifyDataSourceConfig.updateDataSourceFile();
			Thread.sleep(10000);
			ds = (DataSource)ctx.lookup(jndiName);//这里要和mysql-ds.xml中对应
			return ds.getConnection();
			
		
		}
	}
}

package ep.org.clothingmaintenance.util;

import java.io.File;
import java.io.FileWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Iterator;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;

public class ModifyDataSourceConfig {

	public synchronized static void updateDataSourceFile() throws Exception {
		//System.out.println("in"+PropertiesUtil.getProperties().getProperty("DBDataSourceFile"));
		String[] dataSourceInfo = getAuthInfo();
		String connection_url = dataSourceInfo[0];
		// String username = dataSourceInfo[1];
		String pwd = dataSourceInfo[2];

		int index = Integer.parseInt(PropertiesUtil.getProperties()
				.getProperty("DateSourceIndex"));
		String DBDataSourceFile = PropertiesUtil.getProperties().getProperty("DBDataSourceFile");
		File inputXml = new File(DBDataSourceFile);
		SAXReader saxReader = new SAXReader();

	
			Document document = saxReader.read(inputXml);
			Element root = document.getRootElement();
			Iterator dataSources = root.elementIterator();
			for (int i = 1; i < index; i++) {
				dataSources.next();
			}
			Element dataSource = (Element) dataSources.next();
			dataSource.selectSingleNode("connection-url").setText(
					connection_url);
			dataSource.selectSingleNode("password").setText(pwd);
			FileWriter fw = new FileWriter(DBDataSourceFile);
			XMLWriter writer = new XMLWriter(fw);
			writer.write(document);
			fw.close();

		
	}

	public static String[] getAuthInfo() throws Exception {
		String gantAuthCode = PropertiesUtil.getProperties().getProperty(
				"gantAuthCode");
		String authLinkDB = PropertiesUtil.getProperties().getProperty(
				"authLinkDB");
		String authLinkEnvo = PropertiesUtil.getProperties().getProperty(
				"authLinkEnvo");
		String authLinkUse = PropertiesUtil.getProperties().getProperty(
				"authLinkUser");
		String sql = "select  IPAddress,port,AccessDatabaselist,dbo.F_decrypt(EncrPassword,'"
				+ gantAuthCode
				+ "') pwd "
				+ " from AccountQuery where SystemName='"
				+ authLinkDB
				+ "' AND Envo='"
				+ authLinkEnvo
				+ "' AND UserName='"
				+ authLinkUse + "'";
		String authserver_url = "jdbc:sqlserver://192.168.0.89:1433;DatabaseName=servermdm";
		String username = "Appclient";
		String password = "elegant";
		String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		String connection_url = "";
		String pwd = "";
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(authserver_url, username,
					password);
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			if (rs.next()) {
				connection_url = "jdbc:sqlserver://"
						+ rs.getString("IPAddress") + ":"
						+ rs.getString("port") + ";DatabaseName="
						+ rs.getString("AccessDatabaselist");
				pwd = rs.getString("pwd");
			} else {
				throw new Exception("连接认证数据库失败，请联系IT部！");
			}
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new Exception("连接认证数据库失败，请联系IT部！");
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

		return new String[] { connection_url, authLinkUse, pwd };
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}

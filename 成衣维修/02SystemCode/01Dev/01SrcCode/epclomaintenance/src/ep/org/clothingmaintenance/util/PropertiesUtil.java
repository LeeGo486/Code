package ep.org.clothingmaintenance.util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

public class PropertiesUtil {

	private static Properties properties = null;
	
	public static void loadProperties(String propertesUrl) throws FileNotFoundException, IOException{
		if(properties==null){
			properties = new Properties();
			properties.load(new FileInputStream(propertesUrl));
		}
	}
	
	public static Properties getProperties(){
		return properties;
	}
	
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		try {
			loadProperties(System.getProperty("user.dir")+"/WebRoot/WEB-INF/classes/dbconfig.Properties");
			System.out.println(properties.get("dbip"));
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
	
	}

}

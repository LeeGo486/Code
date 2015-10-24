package ep.org.clothingmaintenance.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hy.SSO.service.PubWSService;

import ep.org.clothingmaintenance.util.DBUtil;
import ep.org.clothingmaintenance.util.PropertiesUtil;
/**
@description: 
@author: DLY
@version：2.00
@date：2014-2-12  
@historyfile：AjaxDao140212
*/
public class AjaxDao {
	/**
	 * @category 款号验证
	 * @author DLY
	 * @date 2014-2-12
	 * @param kh 
	 * @return kh
	 * @throws Exception
	 */
	public static String isExsitClothingKH(String kh) throws Exception{ 
		String isExist = "0";
		//组合条件   
		String wsid = "9534098c-56f3-49bd-b255-b00628075276";
		String env = "ITDC_EXCEL";
		String sessionID = "";
		String ConditionStr = "【操作类型,GET】【实体,j_clothing】【返回内容,款号,颜色,尺码】"
				+ "【条件内容,《W》项目代号】【《W》项目代号,"+kh+"】";
		Map map = new HashMap();
		map.put("InputFormat", "AML");
		map.put("OutputContentType", "RS");
		map.put("ConditionStr", ConditionStr);   
		/*String com =  PubWSService.callWSRR(wsid, env, "", map); */
		List<Map> khList = PubWSService.callWSRRToList(wsid, env, "", map); 
		if (khList == null || khList.size() == 0) {
			isExist="0";
		} else { 
			String ys =  (String) khList.get(0).get("COLORID");
			String ms =  (String) khList.get(0).get("SIZEID");
			String ks =  (String) khList.get(0).get("STYLEID");  
			if(ks == null|| "".equals(ys)){
				isExist="0";
			}else{
				isExist=ys;
				if(!(ms == null|| "".equals(ms))){
					isExist=isExist+","+ms;
				}
				if(!(ys == null|| "".equals(ys))){
					isExist=isExist+","+ys;
				} 
			} 
			//System.out.println(isExist);
		}    
		
		return isExist;
	}
}

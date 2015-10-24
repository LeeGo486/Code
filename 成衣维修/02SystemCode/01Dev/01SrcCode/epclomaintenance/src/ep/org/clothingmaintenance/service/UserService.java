package ep.org.clothingmaintenance.service;

import ep.org.clothingmaintenance.bean.UserInfo;
import ep.org.clothingmaintenance.dao.UserDao;

/**
  @description: 用户信息服务类
  @author: 俞晓东
  @version：1.00
  @date：2012-7-11 下午04:13:28
 */

public class UserService {
	/**
	 * 根据用户ID和密码获取用户的基础信息
	 * @param userID
	 * @param pwd
	 * @return UserInfo
	 * @throws Exception
	 */
	public UserInfo getUserInfo(String userID,String pwd) throws Exception{
		UserDao dao = new UserDao();
		return dao.getUserInfo(userID, pwd);
	}
}

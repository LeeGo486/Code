package org.hy.resteasyservice;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;

/**
  @description: 
  @author: 俞晓东
  @version：1.00
  @date：2012-9-10 上午10:53:29
 */
@Path(value = "/rest")
public class RestEasyDemoService {
	@GET
	@Path(value = "/echo/{message}")
	public String getTestMssage(@PathParam(value = "message") String message){
		return "hello:"+message;
	}
}

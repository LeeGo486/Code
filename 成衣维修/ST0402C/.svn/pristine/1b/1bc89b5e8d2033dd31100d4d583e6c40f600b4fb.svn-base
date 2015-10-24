package org.hy.resteasyservice;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;

import org.hy.model.Role;
import org.hy.model.Typzb;
import org.hy.service.ITypzbService;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@Path(value = "/rest/Typzb")
@Service
public class TypzbRs {
	@Resource(name="typzbService")
	private ITypzbService typzbService;

	public ITypzbService getTypzbService() {
		return typzbService;
	}

	public void setTypzbService(ITypzbService typzbService) {
		this.typzbService = typzbService;
	}
	

	@GET
	@Path(value = "queryTypes")
	@Produces("text/html;charset=GBK")
	//@Consumes("application/json;charset=GBK")	
	public String queryTypes(@QueryParam(value = "type") String type,@Context HttpServletRequest request){
		String jpql  = "select distinct a.typeName as typeName from Typzb a where a.type='"+type+"'";
		List list = typzbService.queryTypzb(jpql);
		List list1 = new ArrayList();
		Map map = null;
		for(int i=0;i<list.size();i++){
			map = new HashMap();
			map.put("typeName", list.get(i));
			list1.add(map);
		}
		Gson gson = new Gson();
		//return gson.toJson(list);
		return gson.toJson(list1);
	}
	
	
	
	@GET
	@Path(value = "queryEntities")
	@Produces("text/html;charset=GBK")
	public String queryEntities(@QueryParam(value = "type") String type,@Context HttpServletRequest request,@Context HttpServletResponse response) throws Exception{
		String jpql = "select a from Typzb a where a.type='"+type+"'";
		List list = typzbService.queryTypzb(jpql);
		Gson gson = new Gson();
		/*PrintWriter pwriter = response.getWriter();
		pwriter.print(gson.toJson(list));
		pwriter.close();*/
		return gson.toJson(list);
		
	}
	
	@GET
	@Path(value = "queryEntitiesByAttr")
	@Produces("text/html;charset=GBK")
	public String queryEntitiesByAttr(@QueryParam(value = "filter") String filter,@QueryParam(value = "type") String type,@Context HttpServletRequest request){
		String[] attr_array = filter.split(",");
		StringBuffer sb = new StringBuffer();
		String[] key_value = null;
		for(String temp : attr_array){
			key_value = temp.split("_");
			sb.append(" and a.").append(key_value[0]).append("='").append(key_value[1]).append("' ");
		}
		StringBuffer jpql = new StringBuffer("select a from Typzb a where a.type='"+type+"'").append(sb);	
		List list = typzbService.queryTypzb(jpql.toString());
		Gson gson = new Gson();
		return gson.toJson(list);
	}
	
	
	
	@POST
	@Path(value = "saveEntities")
	@Produces("text/html;charset=GBK")
	public String saveEntities(@Context HttpServletRequest request,@Context HttpServletResponse response){
		Gson gson = new Gson();
		String inserted = request.getParameter("inserted");
		String updated =  request.getParameter("updated");
		Type type = new TypeToken<List<Typzb>>(){}.getType(); 
		List<Typzb> list = gson.fromJson(inserted, type);
		if(list != null){
			for(Typzb entity : list){
				entity.setGuid(UUID.randomUUID().toString().trim());
				typzbService.saveEntity(entity);
			}
		}
		
		list = gson.fromJson(updated, type);
		if(list != null){
			for(Typzb entity : list){
				typzbService.updateEntity(entity);
			}
		}
		
		return "1";
	}

	@DELETE
	@Path(value = "deleteEntities/{guid}")
	@Produces("text/html;charset=GBK")
	public String deleteEntities(@PathParam(value = "guid") String guid){
		 typzbService.deleteEntityByID(guid) ;
		 return "1";
	}
	
}

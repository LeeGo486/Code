package org.hy.resteasyservice;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;

import org.hy.model.Tybmb;
import org.hy.service.ITybmbService;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@Path(value = "/rest/Tybmb")
@Service
public class TybmbRs {
	private ITybmbService tybmbService;

	public ITybmbService getTybmbService() {
		return tybmbService;
	}

	public void setTybmbService(ITybmbService tybmbService) {
		this.tybmbService = tybmbService;
	}
	

	@GET
	@Path(value = "queryTypes")
	@Produces("text/html;charset=GBK")
	//@Consumes("application/json;charset=GBK")	
	public String queryTypes(@QueryParam(value = "type") String type,@Context HttpServletRequest request){
		String jpql  = "select distinct a.code as typeCode,a.scope as typeName   from Tybmb a ";
		List list = tybmbService.queryTybmb(jpql);
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
		String jpql = "select a from Tybmb a where a.scope='"+type+"'";
		List list = tybmbService.queryTybmb(jpql);
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
		StringBuffer jpql = new StringBuffer("select a from Tybmb a where a.scope='"+type+"'").append(sb);	
		List list = tybmbService.queryTybmb(jpql.toString());
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
		Type type = new TypeToken<List<Tybmb>>(){}.getType(); 
		List<Tybmb> list = gson.fromJson(inserted, type);
		if(list != null){
			for(Tybmb entity : list){
				entity.setGuid(UUID.randomUUID().toString().trim());
				tybmbService.saveEntity(entity);
			}
		}
		
		list = gson.fromJson(updated, type);
		if(list != null){
			for(Tybmb entity : list){
				tybmbService.updateEntity(entity);
			}
		}
		
		return "1";
	}

	@DELETE
	@Path(value = "deleteEntities/{guid}")
	@Produces("text/html;charset=GBK")
	public String deleteEntities(@PathParam(value = "guid") String guid){
		 tybmbService.deleteEntityByID(guid) ;
		 return "1";
	}
	
	
}

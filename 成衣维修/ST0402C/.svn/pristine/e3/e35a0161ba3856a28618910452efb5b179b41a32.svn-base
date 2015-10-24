package org.hy.resteasyservice;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;

import net.sf.json.JSONObject;

import org.hy.beans.base.PageView;
import org.hy.model.MaintainRegister;
import org.hy.model.Ppwxcdyb;
import org.hy.model.UserInfo;
import org.hy.model.Ysgsxxb;
import org.hy.service.IMaintainRegisterService;
import org.hy.service.impl.MaintainRegisterServiceImpl;
import org.hy.util.QueryBean;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.Gson;

@Path(value = "/rest")
@Service
public class MaintainRegisterList {
	private JSONObject resultObj;

	private int page;

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	@Resource(name = "mrService")
	private IMaintainRegisterService mrService = new MaintainRegisterServiceImpl();

	private List<QueryBean> zt;

	private List<QueryBean> wtd;

	private List<QueryBean> qy;

	private List<QueryBean> xxd;

	private List<QueryBean> tybmname;

	// private HttpServletResponse response;

	public IMaintainRegisterService getMrService() {
		return mrService;
	}

	public void setMrService(IMaintainRegisterService mrService) {
		this.mrService = mrService;
	}

	// 分页查询列
	@POST
	@Path(value = "/getQueryList/{message}")
	@Produces({ "application/json;charset=UTF-8"})
	public String getDatagrid(@PathParam(value = "message") String message,
			@Context HttpServletRequest request) throws Exception {

		int page = Integer.parseInt(request.getParameter("page"));
		int maxResult = Integer.parseInt(request.getParameter("rows"));
		String sort = request.getParameter("sort");
		String order = request.getParameter("order");
		// 组合条件 dh,dp,vipkh, ydh,kh,zt, dd1,dd2,lx;
		String dh = request.getParameter("dh");
		String dp = request.getParameter("dp");
		String vipkh = request.getParameter("vipkh");
		String ydh = request.getParameter("ydh");
		String kh = request.getParameter("kh");
		String zt = request.getParameter("zt");
		String closed = request.getParameter("closed");
		String dd1 = request.getParameter("dd1");
		String dd2 = request.getParameter("dd2");
		String lx = request.getParameter("lx");
		String pl = request.getParameter("pl");
		// System.out.println(request.getParameter("status"));
		UserInfo userInfo = (UserInfo) request.getSession().getAttribute(
				"userInfo");
		String newCom = "('" + userInfo.getCom().replaceAll(",", "','") + "')";
		
		String wherejpql = " Branch in "+newCom
				+ " and  isnull(o.closed,0) = " + closed ;
		if ("all".equals(message)) {
		} else {
			wherejpql = wherejpql + " and o.zt in (" + message + ")";
		}
		;

		// Object[] queryParams = {dh,dp,vipkh, ydh,kh,zt, dd1,dd2,lx};

		if (null != dh && !"".equals(dh)) {
			wherejpql = wherejpql + " and o.dh like '%" + dh + "%'";
		}
		if (null != dp && !"".equals(dp)) {
			wherejpql = wherejpql + " and o.dpmc like '%" + dp + "%'";
		}
		if (null != vipkh && !"".equals(vipkh)) {
			wherejpql = wherejpql + " and o.vipkh like '%" + vipkh + "%'";
		}
		if (null != ydh && !"".equals(ydh)) {
			wherejpql = wherejpql + " and o.ydh like '%" + ydh + "%'";
		}
		if (null != kh && !"".equals(kh)) {
			wherejpql = wherejpql + " and o.kh like '%" + kh + "%'";
		}
		if (null != zt && !"".equals(zt)) {
			wherejpql = wherejpql + " and o.zt = " + zt;
		}
		if (null != dd1 && !"".equals(dd1)) {
			wherejpql = wherejpql + " and o.pjpdsj >= '" + dd1 + "'";
		}
		if (null != dd2 && !"".equals(dd2)) {
			wherejpql = wherejpql + " and o.pjpdsj <= '" + dd2 + "'";
		}
		if (null != lx && !"".equals(lx)) {
			if ("0".equals(lx)) {
				lx = "1,2";
			}
			wherejpql = wherejpql + " and o.dplx in (" + lx + ")";
		}
		if (null != pl && !"".equals(pl)) {
			wherejpql = wherejpql + " and substring(o.kh,6,1) = '" + pl + "'";
		}

		// wherejpql =wherejpql+" order by o.zt asc ,o.djsj desc ";

		LinkedHashMap<String, String> orderby = new LinkedHashMap<String, String>();
		if (null != sort && !"".equals(sort)) {
			orderby.put(sort, order);
		} else {
			//orderby.put("zt", "asc");
			//orderby.put("djsj", "desc");
			if("all".equals(message)){
				orderby.put("djsj", "desc");
			}else if("1".equals(message)){
				orderby.put("djsj", "desc");
			}else if("5".equals(message)){
				orderby.put("pjpdsj", "desc");
			}else if("4,7".equals(message)){
				orderby.put("wxqrsj", "desc");
			}else{
				orderby.put("zt", "asc");
				orderby.put("djsj", "desc");
			}
		}

		// System.out.println("列表查询条件"+wherejpql);
		// CustomerContextHolder.setCustomerType("x6");
		PageView<MaintainRegister> pageView = new PageView<MaintainRegister>(
				maxResult, page);
		pageView.setQueryResult(mrService.getScrollData(
				pageView.getFirstResult(), maxResult, wherejpql, null, orderby));

		Gson gson = new Gson();
		// here

		List<MaintainRegister> list = pageView.getRecords();
		if (this.tybmname == null) {
			String wheresql = "    SELECT FCODE,FSCOPE, FCONTENT  FROM SCFX_TYBMB where fscope in('成衣维修状态','成衣问题现象点','成衣问题起因','成衣问题点' ) ";
			tybmname = mrService.getTybmb(wheresql);
		}

		for (int i = 0; i < list.size(); i++) {
			String ztcode = list.get(i).getZt();
			String wtdcode = list.get(i).getWtd1();
			String xxdcode = list.get(i).getXxd1();
			String qycode = list.get(i).getQy1();
			for (int j = 0; j < tybmname.size(); j++) {
				String fcode = tybmname.get(j).getFcode();
				String fscope = tybmname.get(j).getFscope();
				String fcontent = tybmname.get(j).getFcontent();
				if ("成衣维修状态".equals(fscope)) {
					if (fcode.equals(ztcode)) {
						list.get(i).setZt_name(fcontent);
					}
				}
				if ("成衣问题点".equals(fscope)) {
					if (fcode.equals(wtdcode)) {
						list.get(i).setWtd_name(fcontent);
					}
				}
				if ("成衣问题现象点".equals(fscope)) {
					if (fcode.equals(xxdcode)) {
						list.get(i).setXxd_name(fcontent);
					}
				}
				if ("成衣问题起因".equals(fscope)) {
					if (fcode.equals(qycode)) {
						list.get(i).setQy_name(fcontent);
					}
				}
			}
		}

		String totalrecords = gson.toJson(pageView.getTotalRecord());
		String gs1 = gson.toJson(list);

		gs1 = " { \"total\":" + totalrecords + " , \"rows\": " + gs1 + " }";
		
		return gs1;
	}

	// 根据guid 获得详细
	@POST
	@Path(value = "/getDetail/{message}")
	public void getDetail(@PathParam(value = "message") String message,
			@Context HttpServletRequest request,
			@Context HttpServletResponse response) throws Exception {

		// MaintainRegister mr = new MaintainRegister();
		// mr = mrService.find(request.getParameter("guid").toString());
		// CustomerContextHolder.setCustomerType("x6");
		List<MaintainRegister> mrList = mrService.findByProperty("guid", request
				.getParameter("guid").toString());
		MaintainRegister mr = null;
		List list = new ArrayList();
		if (mrList.size() < 0) {
			mrList = (List<MaintainRegister>) new MaintainRegister();			
		}else{
			mr =  mrList.get(0);
			mr.setDjrName(mrService.getUserName(mr.getDjr()));
			String pjpdname = mrService.getUserName(mr.getPjpdr());
			if(!"".equals(pjpdname.trim())){
				mr.setPjpdrName(pjpdname);
			}else{
				mr.setPjpdrName(mr.getPjpdr());
			}
			
			list.add(mr);
		}
		
		
		
		
		Gson gson = new Gson();
		String detail = gson.toJson(list);
		PrintWriter pwriter = response.getWriter();
		pwriter.print(detail);
		pwriter.close();

	}

	@POST
	@Path(value = "/getFilterdp/{message}")
	public void getFilterdp(@PathParam(value = "message") String message,
			@Context HttpServletRequest request,
			@Context HttpServletResponse response) throws Exception {
		String depotid = request.getParameter("depotid");
		String p = request.getParameter("q");
		Gson gson = new Gson();
		List jdepot = null;
		UserInfo userInfo = (UserInfo) request.getSession().getAttribute(
				"userInfo");
		// CustomerContextHolder.setCustomerType(userInfo.getCom());
		if (null != depotid) {
			jdepot = mrService.filterDp(userInfo.getSsoSessionID(), depotid,
					userInfo.getCom());
		} else {
			if (null == p) {
				p = "0";
			}
			// jdepot = mrService.filterDp(p);
			if (p.length() < p.getBytes().length) {
				jdepot = mrService.filterDpByName(userInfo.getSsoSessionID(),
						p, userInfo.getCom());
			} else {
				jdepot = mrService.filterDp(userInfo.getSsoSessionID(), p,
						userInfo.getCom());
			}
		}

		if ("withCom".equals(message)) {
			Map jdepotInfo = new HashMap();
			if (jdepot != null && jdepot.size() != 0) {
				jdepotInfo = (Map) jdepot.get(0);
				String com = mrService.getComByDepot(depotid);
				if(com.length()>3){
					jdepotInfo.put("COM", com.substring(0, com.length()-3));
				}else{
					jdepotInfo.put("COM", com);
				}
			}

		}

		String queryfilter = gson.toJson(jdepot);
		PrintWriter pwriter = response.getWriter();
		pwriter.print(queryfilter);
		pwriter.close();

	}

	// 选择店铺后带出受理导购
	@POST
	@Path(value = "/getSldg/{message}")
	public void getSldg(@PathParam(value = "message") String message,
			@Context HttpServletRequest request,
			@Context HttpServletResponse response) throws Exception {
		String depotid = message;
		Gson gson = new Gson();
		// String wheresql =
		// "   SELECT employeeid, names ,telephone FROM J_EMPLOYEE  where depotid= '"+depotid+"'";
		UserInfo userInfo = (UserInfo) request.getSession().getAttribute(
				"userInfo");
		// CustomerContextHolder.setCustomerType(userInfo.getCom());

		List sldg = mrService.getSldg(userInfo.getSsoSessionID(), depotid);
		String sldgs = gson.toJson(sldg);
		PrintWriter pwriter = response.getWriter();
		pwriter.print(sldgs);
		pwriter.close();
	}
	
	// 选择店铺后带出供应商
		@POST
		@Path(value = "/getGys/{message}")
		public void getGys(@PathParam(value = "message") String message,
				@Context HttpServletRequest request,
				@Context HttpServletResponse response) throws Exception {
			String kh = message;
			Gson gson = new Gson();
			List gys = mrService.querySupplierByStyleID(kh);
			String sldgs = gson.toJson(gys);
			PrintWriter pwriter = response.getWriter();
			pwriter.print(sldgs);
			pwriter.close();
		}
	
	

	/**
	 * 根据店铺ID获取店铺所属公司
	 * 
	 * @param depotID
	 * @return
	 * @throws Exception
	 */
	@POST
	@Path(value = "/getComByDept")
	public void getComByDepot(String message,
			@Context HttpServletRequest request,
			@Context HttpServletResponse response) throws Exception {
		String depotID = request.getParameter("depotID");
		String com = mrService.getComByDepot(depotID);
		PrintWriter pwriter = response.getWriter();
		pwriter.print(com);
		pwriter.close();

	}

	// 店铺对应维修仓信息
	@POST
	@Path(value = "/getWxcdp/{message}")
	public void getWxc(@PathParam(value = "message") String message,
			@Context HttpServletRequest request,
			@Context HttpServletResponse response) throws Exception {
		// CustomerContextHolder.setCustomerType(DynamicDataSourceType.S2);
		// UserInfo userInfo =
		// (UserInfo)request.getSession().getAttribute("userInfo");
		/*String pp = request.getParameter("pp");
		String ldplx = request.getParameter("ldplx");
		String com = request.getParameter("com");*/
		String depotid =  request.getParameter("depotid");
		
		Gson gson = new Gson();
		String wheresql = " select WXCBM,WXCMC from PPWXCDYB where PP=left ('"+depotid+"',1) ";
  
		// CustomerContextHolder.setCustomerType("x6test");
		List<Ppwxcdyb> ppwxc = mrService.filterWxc(wheresql);

		String wxc = gson.toJson(ppwxc);
		PrintWriter pwriter = response.getWriter();
		pwriter.print(wxc);
		pwriter.close();
	}

	@POST
	@Path(value = "/getFilterzt/{message}")
	public String getFilterzt(@PathParam(value = "message") String message,
			@Context HttpServletRequest request,
			@Context HttpServletResponse response) {

		String sql1 = "SELECT SCFX_TYBMB.FCODE as bh, SCFX_TYBMB.FCONTENT as mc,FSEQUENCE as sx  FROM SCFX_TYBMB"
				+ " WHERE SCFX_TYBMB.FSCOPE = '成衣维修状态' and FCODE =" + message;
		String sql = "select bh,mc,sx from (select '-1' as bh ,'全部' as mc,-1 as sx union "
				+ "SELECT SCFX_TYBMB.FCODE as bh, SCFX_TYBMB.FCONTENT as mc,FSEQUENCE as sx  FROM SCFX_TYBMB "
				+ "WHERE SCFX_TYBMB.FSCOPE = '成衣维修状态' )a order by sx";
		if ("S1".equals(message)) {
			zt = mrService.filterZt(sql);
		} else {
			zt = mrService.filterZt(sql1);
		}
		;
		Gson gson = new Gson();

		String queryfilter = gson.toJson(zt);
		return queryfilter;
	}

	// 获取品类下来列表
	@POST
	@Path(value = "/getFilterpl/{message}")
	public String getFilterpl(@PathParam(value = "message") String message,
			@Context HttpServletRequest request,
			@Context HttpServletResponse response) {
		/*
		 * Map<String,String> mappl = new HashMap<String,String>();
		 * mappl.put("1", "大衣"); mappl.put("2", "裤子");
		 */
		// Gson gson = new Gson();
		String pls = "[{\"plid\":\"1\",\"plmc\":\"外  套\"},"
				+ "{\"plid\":\"2\",\"plmc\":\"衬衫类\"},"
				+ "{\"plid\":\"3\",\"plmc\":\"群  类\"},"
				+ "{\"plid\":\"4\",\"plmc\":\"连衣裙类\"},"
				+ "{\"plid\":\"5\",\"plmc\":\"针织衫类\"},"
				+ "{\"plid\":\"6\",\"plmc\":\"裤  类\"},"
				+ "{\"plid\":\"7\",\"plmc\":\"风衣类\"},"
				+ "{\"plid\":\"8\",\"plmc\":\"大衣类\"},"
				+ "{\"plid\":\"9\",\"plmc\":\"纱线类毛衣\"},"
				+ "{\"plid\":\"Y\",\"plmc\":\"羽绒服\"},"
				+ "{\"plid\":\"M\",\"plmc\":\"棉  服\"},"
				+ "{\"plid\":\"Q\",\"plmc\":\"裘皮类\"},"
				+ "{\"plid\":\"P\",\"plmc\":\"皮  装\"},"
				+ "{\"plid\":\"N\",\"plmc\":\"呢克服\"}]";
		return pls;
	}

	// 获取维修单号
	@POST
	@Path(value = "/getWxdh/{message}")
	public void getWxdh(@PathParam(value = "message") String message,
			@Context HttpServletRequest request,
			@Context HttpServletResponse response) throws IOException {
		UserInfo userInfo = (UserInfo) request.getSession().getAttribute(
				"userInfo");

		String sql = "select max(dh) from cywxdjb where len(dh)=6 ";
		String wxdh = mrService.getWxdh(sql);
		PrintWriter pwriter = response.getWriter();
		pwriter.print(wxdh);
		pwriter.close();
	}

	// 获取运输公司
	@POST
	@Path(value = "/getYsgs/{message}")
	public void getYsgs(@PathParam(value = "message") String message,
			@Context HttpServletRequest request,
			@Context HttpServletResponse response) throws IOException {
		// Ysgsxxb ysgs= new Ysgsxxb();
		PageView<Ysgsxxb> pageView = new PageView<Ysgsxxb>(10, 1);
		// CustomerContextHolder.setCustomerType("x6");
		pageView.setQueryResult(mrService.getYsgs());
		Gson gson = new Gson();
		String ysgs1 = gson.toJson(pageView.getRecords());
		PrintWriter pwriter = response.getWriter();
		pwriter.print(ysgs1);
		pwriter.close();
	}

	// 保存提交
	@POST
	@Path(value = "/saveRegister/{message}")
	public void saveRegister(@PathParam(value = "message") String message,
			@Context HttpServletRequest request,
			@Context HttpServletResponse response) throws Exception {

		String isdone; // 按钮执行成功标记
		String iscansave = "1";// 允许保存
		String uuid = "uuid", tcjginfo = "保存成功", flag = "error";
		String user, id, zt, guid, wxdh, dpbm, dpmc, dplx, dzxm, dzlxdh, wxcbm, wxcmc, sldg, dglxdh, isgkwx, vipkh, gkxm, gklxdh, isffwx, jjcd, kh, wtms, ysgs, ydh, fhdz, shdz, shr, shrlxdh, bzxx, wxxz1, wtd1, qy1, xxd1, wxbw, wxxz2, wtd2, qy2, xxd2, pdclfs, tccljg, zrbm, thdh = null, jcyy, nx, sfsf, sfnr, pjpdbz, wxr, zbfhYsgs, zbfhYsdh, zbfhShr, zbfhShrdh, zbfhShdz, zbfhFhdz, zbfhBz, zbfhBzr;
		String gysbh,gysmc,wxjefw,branch,pp,sldgxm;
		int jhwxts;
		double sfje;
		UserInfo userInfo = (UserInfo) request.getSession().getAttribute(
				"userInfo");
		user = userInfo.getUsername();
		// id 按钮 zt 状态
		id = request.getParameter("id");
		zt = request.getParameter("zt");
		
		guid = request.getParameter("guid");
		dpbm = request.getParameter("dpbm");
		wxdh = request.getParameter("wxdh");
		branch = request.getParameter("branch");
		pp = request.getParameter("pp");
		
		// 维修单号生成
		try {
			if ("".equals(wxdh) || null == wxdh) {

				wxdh = mrService
						.getWxdh("select max(DH) from cywxdjb where len(DH)=6");
			}else{
				if("save0123456".equals(id) && mrService.isDhExists("select dh from cywxdjb where dh='"+wxdh+"'")){
					tcjginfo = "维修单号已被使用,请重新保存";
					PrintWriter pwriter = response.getWriter();
					pwriter.print(tcjginfo);
					pwriter.close();
					return;
				}
				
			}
		} catch (Exception e) {
			tcjginfo = "维修单号生成失败";
		}
		dpmc = request.getParameter("dpmc");
		dplx = request.getParameter("dplx");

		dzxm = request.getParameter("dzxm");
		dzlxdh = request.getParameter("dzlxdh");

		wxcbm = request.getParameter("wxcbm");
		wxcmc = request.getParameter("wxcmc");

		sldg = request.getParameter("sldg");
		sldgxm =  request.getParameter("sldgxm");
		
		dglxdh = request.getParameter("dglxdh");
		isgkwx = request.getParameter("isgkwx");

		vipkh = request.getParameter("vipkh");
		gkxm = request.getParameter("gkxm");

		gklxdh = request.getParameter("gklxdh");
		// scsj = request.getParameter("scsj");

		isffwx = request.getParameter("isffwx");
		jjcd = request.getParameter("jjcd");

		kh = request.getParameter("kh");
		// thrq = request.getParameter("thrq");
		wtms = request.getParameter("wtms");

		ysgs = request.getParameter("ysgs");
		ydh = request.getParameter("ydh");
		fhdz = request.getParameter("fhdz");
		shdz = request.getParameter("shdz");
		shr = request.getParameter("shr");
		shrlxdh = request.getParameter("shrlxdh");
		bzxx = request.getParameter("bzxx");
		
		gysbh = request.getParameter("gysbh");
		gysmc = request.getParameter("gysmc");
		wxjefw = request.getParameter("wxjefw");
		
		

		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		format.setLenient(false);
		Timestamp scsj = new Timestamp(format.parse("1900-01-01").getTime());
		if (!"".equals(request.getParameter("scsj"))) {
			scsj = new Timestamp(format.parse(request.getParameter("scsj"))
					.getTime());
		}
		Timestamp thrq = new Timestamp(format.parse(
				request.getParameter("thrq")).getTime());
		Timestamp d = new Timestamp(System.currentTimeMillis());
		Timestamp zbfhBzrq = d;
		// zbfhBzrq = request.getParameter("zbfh_bzrq");
		// System.out.println(d);

		MaintainRegister mrbean = null;
		mrbean = mrService.find(guid);

		if (null == mrbean) {
			mrbean = new MaintainRegister();
			mrbean.setZt("0");
		}
		if ("null".equals(guid) || "".equals(guid)) {
			// 新增
			uuid = UUID.randomUUID().toString().trim().replaceAll("-", "");
			mrbean.setGuid(uuid);
			mrbean.setZt("0");
		} else {
			// 修改
			mrbean.setGuid(guid);
		}

		// 获取现在的维修单状态
		String ztold = mrbean.getZt();

		// 状态 保存参数来自设定好的流程
		mrbean.setZt(zt);
		mrbean.setXgr(user);
		mrbean.setXgrq(d);
		mrbean.setBranch(branch);
		mrbean.setPp(pp);
		List styleInfoList = null;

		if ("save0123456".equals(id)) {// 维修登记判定
			mrbean.setDh(wxdh);
			mrbean.setDpbm(dpbm);
			mrbean.setDpmc(dpmc);
			mrbean.setDplx(dplx);
			mrbean.setDzxm(dzxm);
			mrbean.setDzlxdh(dzlxdh);
			mrbean.setWxcbm(wxcbm);
			mrbean.setWxcmc(wxcmc);
			mrbean.setSldg(sldg);
			mrbean.setSldgxm(sldgxm);
			mrbean.setDglxdh(dglxdh);
			mrbean.setSffgkwx(Integer.valueOf(isgkwx));
			mrbean.setVipkh(vipkh);
			mrbean.setGkxm(gkxm);
			mrbean.setGklxdh(gklxdh);

			mrbean.setScsj(scsj);
			mrbean.setSftyffwx(Integer.valueOf(isffwx));
			mrbean.setJjcd(jjcd);
			mrbean.setKh(kh);

			styleInfoList = mrService.checkKh(userInfo.getSsoSessionID(), kh);
			if (styleInfoList != null && styleInfoList.size() != 0
					&& styleInfoList.get(0) != null) {
				Map map = (Map) styleInfoList.get(0);
				mrbean.setYs((String) map.get("COLORID"));
				mrbean.setMs((String) map.get("SIZEID"));
			} else {
				tcjginfo = "产品退仓失败，无法找到款式信息，请联系IT部门协助解决。";
				iscansave = "0";
			}
			mrbean.setThrq(thrq);
			mrbean.setWtms(wtms);
			mrbean.setYsgs(ysgs);
			mrbean.setYdh(ydh);
			mrbean.setFhdz(fhdz);
			mrbean.setShdz(shdz);
			mrbean.setShr(shr);
			mrbean.setShrlxdh(shrlxdh);
			mrbean.setBzxx(bzxx);
			//mrbean.setBranch(userInfo.getCom());

			mrbean.setDjr(userInfo.getUserid());
			mrbean.setDjsj(d);

			wxxz1 = request.getParameter("wxxz1");
			wtd1 = request.getParameter("wtd1");
			qy1 = request.getParameter("qy1");
			xxd1 = request.getParameter("xxd1");
			wxbw = request.getParameter("wxbw");
			wxxz2 = request.getParameter("wxxz2");
			wtd2 = request.getParameter("wtd2");
			qy2 = request.getParameter("qy2");
			xxd2 = request.getParameter("xxd2");

			pdclfs = request.getParameter("pdclfs");
			tccljg = request.getParameter("tccljg");
			zrbm = request.getParameter("zrbm");
			thdh = request.getParameter("thdh");
			jcyy = request.getParameter("jcyy");
			nx = request.getParameter("nx");
			jhwxts = ("".equals(request.getParameter("jhwxts")) ? 0 : Integer
					.valueOf(request.getParameter("jhwxts")));
			sfsf = request.getParameter("sfsf");
		/*	sfje = ("".equals(request.getParameter("sfje")) ? 0 : Double
					.valueOf(request.getParameter("sfje")));*/
			wxjefw = request.getParameter("wxjefw");
			sfnr = request.getParameter("sfnr");
			pjpdbz = request.getParameter("pjpdbz");

			mrbean.setWxxz1(wxxz1);
			mrbean.setWtd1(wtd1);
			mrbean.setQy1(qy1);
			mrbean.setXxd1(xxd1);
			mrbean.setWxbw(wxbw);
			mrbean.setWxxz2(wxxz2);
			mrbean.setWtd2(wtd2);
			mrbean.setQy2(qy2);
			mrbean.setXxd2(xxd2);
			mrbean.setPdclfs(pdclfs);
			mrbean.setTccljg(tccljg);
			mrbean.setZrbm(zrbm);
			mrbean.setJcyy(jcyy);
			mrbean.setNx(nx);
			mrbean.setJhwxts(jhwxts);
			mrbean.setSfsf(sfsf);
			//mrbean.setSfje(sfje);
			mrbean.setWxjefw(wxjefw);
			mrbean.setSfnr(sfnr);
			mrbean.setPjpdbz(pjpdbz);
			// mrbean.setWxr(wxr);mrbean.setWxsj(wxsj);
			mrbean.setPjpdr(userInfo.getUserid());
			mrbean.setPjpdsj(d);
			mrbean.setClosed(0);
			mrbean.setKh(kh);
			mrbean.setDpbm(dpbm);
			mrbean.setWxcbm(wxcbm);
			/*String thdhjg = mrService.sendGoods(mrbean.getDpbm(),mrbean.getWxcbm(),mrbean.getKh(), userInfo,
					userInfo.getUserid());
			thdh = thdhjg.split(",")[0];
			mrbean.setThdh(thdh);
			if ("error".equals(thdhjg.split(",")[1])) {
				tcjginfo = "登陆时DRP退仓失败，请联系IT部门协助解决。";
				mrbean.setZt("0");// 操作时候，做补偿策略的撤销操作
				iscansave = "0";
			}*/
			mrbean.setGysbh(gysbh);
			mrbean.setGysmc(gysmc);
			mrbean.setWxjefw(wxjefw);

		} else if ("save10".equals(id) || "save50".equals("id")) { // 品鉴判定临时保存或者维修临时保存
			tcjginfo = "品鉴判定临时保存";
			wxxz1 = request.getParameter("wxxz1");
			wtd1 = request.getParameter("wtd1");
			qy1 = request.getParameter("qy1");
			xxd1 = request.getParameter("xxd1");
			wxbw = request.getParameter("wxbw");
			wxxz2 = request.getParameter("wxxz2");
			wtd2 = request.getParameter("wtd2");
			qy2 = request.getParameter("qy2");
			xxd2 = request.getParameter("xxd2");
			
			pdclfs = request.getParameter("pdclfs");
			tccljg = request.getParameter("tccljg");
			zrbm = request.getParameter("zrbm");
			thdh = request.getParameter("thdh");
			jcyy = request.getParameter("jcyy");
			nx = request.getParameter("nx");
			jhwxts = ("".equals(request.getParameter("jhwxts")) ? 0 : Integer
					.valueOf(request.getParameter("jhwxts")));
			sfsf = request.getParameter("sfsf");
			/*sfje = ("".equals(request.getParameter("sfje")) ? 0 : Double
					.valueOf(request.getParameter("sfje")));*/
			wxjefw  = request.getParameter("wxjefw");
			sfnr = request.getParameter("sfnr");
			pjpdbz = request.getParameter("pjpdbz");

			mrbean.setWxxz1(wxxz1);
			mrbean.setWtd1(wtd1);
			mrbean.setQy1(qy1);
			mrbean.setXxd1(xxd1);
			mrbean.setWxbw(wxbw);
			mrbean.setWxxz2(wxxz2);
			mrbean.setWtd2(wtd2);
			mrbean.setQy2(qy2);
			mrbean.setXxd2(xxd2);
			mrbean.setPdclfs(pdclfs);
			mrbean.setTccljg(tccljg);
			mrbean.setZrbm(zrbm);
			mrbean.setJcyy(jcyy);
			mrbean.setNx(nx);
			mrbean.setJhwxts(jhwxts);
			mrbean.setSfsf(sfsf);
			mrbean.setWxjefw(wxjefw);
			mrbean.setSfnr(sfnr);
			mrbean.setPjpdbz(pjpdbz);
			mrbean.setWtms(wtms);
			
		} else if ("save020".equals(id)) {
			// 重新判定
			tcjginfo = "重新判定并保存成功";
			tccljg = request.getParameter("tccljg");
			mrbean.setTccljg(tccljg);
		} else if ("save07".equals(id)) {
			// 维修完成
			tcjginfo = "维修完成确认并保存成功";
			wxr = request.getParameter("wxr");
			nx = request.getParameter("nx");
			Timestamp wxsj = null;
			if (!"".equals(request.getParameter("wxsj"))) {
				wxsj = new Timestamp(format.parse(request.getParameter("wxsj"))
						.getTime());
			}
			
			
			sfje = ("".equals(request.getParameter("sfje")) || request.getParameter("sfje")==null) ? 0 : Double
					.valueOf(request.getParameter("sfje"));
			mrbean.setNx(nx);
			mrbean.setSfje(sfje);
			mrbean.setZzwxd(request.getParameter("zzwxd"));
			
			mrbean.setWxr(wxr);
			mrbean.setWxsj(wxsj);
			mrbean.setWxqrr(user);
			mrbean.setWxqrsj(d);
			mrbean.setGysbh(gysbh);
			mrbean.setGysmc(gysmc);
			mrbean.setWxjefw(wxjefw);
			
		} else if ("save00".equals(id)) {// 维修登记
			tcjginfo = "维修登记保存成功";
			mrbean.setDh(wxdh);
			mrbean.setDpbm(dpbm);
			mrbean.setDpmc(dpmc);
			mrbean.setDplx(dplx);
			mrbean.setDzxm(dzxm);
			mrbean.setDzlxdh(dzlxdh);
			mrbean.setWxcbm(wxcbm);
			mrbean.setWxcmc(wxcmc);
			mrbean.setSldg(sldg);
			mrbean.setSldgxm(sldgxm);
			mrbean.setDglxdh(dglxdh);
			mrbean.setSffgkwx(Integer.valueOf(isgkwx));
			mrbean.setVipkh(vipkh);
			mrbean.setGkxm(gkxm);
			mrbean.setGklxdh(gklxdh);

			mrbean.setScsj(scsj);
			mrbean.setSftyffwx(Integer.valueOf(isffwx));
			mrbean.setJjcd(jjcd);
			mrbean.setKh(kh);

			styleInfoList = mrService.checkKh(userInfo.getSsoSessionID(), kh);
			if (styleInfoList != null && styleInfoList.size() != 0
					&& styleInfoList.get(0) != null) {
				Map map = (Map) styleInfoList.get(0);
				mrbean.setYs((String) map.get("COLORID"));
				mrbean.setMs((String) map.get("SIZEID"));
			} else {
				tcjginfo = "产品退仓失败，无法找到款式信息，请联系IT部门协助解决。";
				iscansave = "0";
			}
			mrbean.setThrq(thrq);
			mrbean.setWtms(wtms);
			mrbean.setYsgs(ysgs);
			mrbean.setYdh(ydh);
			mrbean.setFhdz(fhdz);
			mrbean.setShdz(shdz);
			mrbean.setShr(shr);
			mrbean.setShrlxdh(shrlxdh);
			mrbean.setBzxx(bzxx);
			//mrbean.setBranch(userInfo.getCom());
			mrbean.setDjr(userInfo.getUserid());

			mrbean.setDjsj(d);
			mrbean.setClosed(0);
		} else if ("save20".equals(id)) {
			// 品检判定
			tcjginfo = "品检判定并保存成功";
			wxxz1 = request.getParameter("wxxz1");
			wtd1 = request.getParameter("wtd1");
			qy1 = request.getParameter("qy1");
			xxd1 = request.getParameter("xxd1");
			wxxz2 = request.getParameter("wxxz2");
			wtd2 = request.getParameter("wtd2");
			qy2 = request.getParameter("qy2");
			xxd2 = request.getParameter("xxd2");

			pdclfs = request.getParameter("pdclfs");
			tccljg = request.getParameter("tccljg");
			zrbm = request.getParameter("zrbm");
			thdh = request.getParameter("thdh");
			jcyy = request.getParameter("jcyy");
			nx = request.getParameter("nx");
			jhwxts = ("".equals(request.getParameter("jhwxts")) ? 0 : Integer
					.valueOf(request.getParameter("jhwxts")));
			sfsf = request.getParameter("sfsf");
			/*sfje = ("".equals(request.getParameter("sfje")) ? 0 : Double
					.valueOf(request.getParameter("sfje")));*/
			wxjefw = request.getParameter("wxjefw");
			sfnr = request.getParameter("sfnr");
			pjpdbz = request.getParameter("pjpdbz");

			mrbean.setWxxz1(wxxz1);
			mrbean.setWtd1(wtd1);
			mrbean.setQy1(qy1);
			mrbean.setXxd1(xxd1);
			mrbean.setWxxz2(wxxz2);
			mrbean.setWtd2(wtd2);
			mrbean.setQy2(qy2);
			mrbean.setXxd2(xxd2);
			mrbean.setPdclfs(pdclfs);
			mrbean.setTccljg(tccljg);
			mrbean.setZrbm(zrbm);
			mrbean.setJcyy(jcyy);
			mrbean.setNx(nx);
			mrbean.setJhwxts(jhwxts);
			mrbean.setSfsf(sfsf);
			//mrbean.setSfje(sfje);
			mrbean.setWxjefw(wxjefw);
			mrbean.setSfnr(sfnr);
			mrbean.setPjpdbz(pjpdbz);
			// mrbean.setWxr(wxr);mrbean.setWxsj(wxsj);
			mrbean.setPjpdr(user);
			mrbean.setPjpdsj(d);
			mrbean.setGysbh(gysbh);
			mrbean.setGysmc(gysmc);
			mrbean.setWxjefw(wxjefw);
			mrbean.setWtms(wtms);

		} else if ("save020".equals(id)) {
			// 重新判定
			tcjginfo = "重新判定并保存成功";
			tccljg = request.getParameter("tccljg");
			mrbean.setTccljg(tccljg);
		} else if ("save07".equals(id)) {
			// 维修完成
			tcjginfo = "维修完成确认并保存成功";
			wxr = request.getParameter("wxr");
			Timestamp wxsj = null;
			if (!"".equals(request.getParameter("wxsj"))) {
				wxsj = new Timestamp(format.parse(request.getParameter("wxsj"))
						.getTime());
			}

			mrbean.setWxr(wxr);
			mrbean.setWxsj(wxsj);
			mrbean.setWxqrr(user);
			mrbean.setWxqrsj(d);
		} else if ("save08".equals(id)) {
			// 总部发货
			tcjginfo = "总部发货并保存成功";
			zbfhYsgs = request.getParameter("zbfh_ysgs");
			zbfhYsdh = request.getParameter("zbfh_ysdh");
			zbfhShdz = request.getParameter("zbfh_shdz");
			zbfhFhdz = request.getParameter("zbfh_fhdz");
			zbfhShr = request.getParameter("zbfh_shr");
			zbfhShrdh = request.getParameter("zbfh_shrdh");
			zbfhBz = request.getParameter("zbfh_bz");
			zbfhBzr = user;

			mrbean.setZbfhYsgs(zbfhYsgs);
			mrbean.setZbfhYsdh(zbfhYsdh);
			mrbean.setZbfhShr(zbfhShr);
			mrbean.setZbfhShrdh(zbfhShrdh);
			mrbean.setZbfhShdz(zbfhShdz);
			mrbean.setZbfhFhdz(zbfhFhdz);
			mrbean.setZbfhBz(zbfhBz);
			mrbean.setZbfhBzr(zbfhBzr);
			mrbean.setZbfhBzrq(zbfhBzrq);
		} else if ("save015".equals(id)) {
			mrbean.setZt(ztold);
			mrbean.setClosed(1);
			tcjginfo = "维修单已关闭";

		} else if ("save016".equals(id)) {
			mrbean.setZt(ztold);
			mrbean.setClosed(0);
			tcjginfo = "维修单已激活";

		}

		if (iscansave.equals("1")) {
			mrService.saveRegister(mrbean);
		}

		// 本地保存信息成功 再执行退仓发货收货
		if ("save0123456".equals(id) || "save20".equals(id)) {
			// 品鉴判定 获取成功信息
			
			if("3".equals(zt)){
				String thdhjg = mrService.sendGoodsA(mrbean.getDpbm(),mrbean.getWxcbm(),mrbean.getKh(), userInfo,
						userInfo.getUserid(),mrbean.getDh());
				if ("error".equals(thdhjg.split(",")[1])) {
					tcjginfo = "登陆时DRP退仓失败，请联系IT部门协助解决。";
					if(!"error".equals(thdhjg.split(",")[2])){ 
						tcjginfo = thdhjg.split(",")[2]+"， 请联系IT部门协助解决。";
					}
					mrbean.setZt(ztold);// 操作时候，做补偿策略的撤销操作
					mrService.saveRegister(mrbean);
				
				}else{
					thdh = thdhjg.split(",")[0];
					mrbean.setThdh(thdh);
					try {
						thdhjg = mrService.receiveGoods(mrbean.getThdh(), mrbean.getDpbm(), mrbean.getWxcbm(), kh, userInfo, mrbean.getDjr());
						
					} catch (Exception e) {
						mrbean.setZt(ztold);
						mrService.saveRegister(mrbean);// 操作时候，做补偿策略的撤销操作
						tcjginfo = "品鉴判定失败，pos生成收回单失败。";
					}
					
				}
				
				
				
				
				if (!"".equals(thdhjg)) {
					if ("ok".equals(thdhjg)) {
						tcjginfo = "品鉴判定退仓成功。";
						flag = "OK";
						mrService.saveRegister(mrbean);
						List list = mrService.queryRemainUnJudgeNum("select count(1) from cywxdjb a  where exists(select 1 from cywxdjb b where b.YSGS=a.YSGS and  b.YDH=a.YDH and guid='"+guid+"') and zt=1");
						int remainNum =  (Integer) list.get(0);
						if(remainNum>0){
							tcjginfo = "品鉴判定成功,相同快递单中还剩余"+remainNum+"个未判定。";
						} 
					} else if ("error".equals(thdhjg)) {
						tcjginfo = "品鉴判定失败，请联系IT部门协助解决。";
						mrbean.setZt(ztold);// 操作时候，做补偿策略的撤销操作
						mrService.saveRegister(mrbean);
					}

				}
			
			}
			
			/*// 移到品鉴判定退仓成功下面
			if("save20".equals(id)){
				List list = mrService.queryRemainUnJudgeNum("select count(1) from cywxdjb a  where exists(select 1 from cywxdjb b where b.YSGS=a.YSGS and  b.YDH=a.YDH and guid='"+guid+"') and zt=1");
				int remainNum =  (Integer) list.get(0);
				if(remainNum>0){
					tcjginfo = "品鉴判定成功,相同快递单中还剩余"+remainNum+"个未判定。";
				}
			}
			*/ 

		}
		
		
		String reinfo = " [{ \"uuid\":\"" + uuid + "\" , \"tcjginfo\":\""
				+ tcjginfo+ "\" , \"flag\":\""
						+ flag+ "\" }]";
		PrintWriter pwriter = response.getWriter();
		pwriter.print(reinfo);
		pwriter.close();
	}

	// 选择维修性质1 带出问题点
	@POST
	@Path(value = "/getWtd/{message}")
	public void getWtd(@PathParam(value = "message") String message,
			@Context HttpServletRequest request,
			@Context HttpServletResponse response) throws Exception {
		String wxxz = message;
		Gson gson = new Gson();
		String wheresql = "  SELECT FCODE, FCONTENT, FPARENTCODE FROM SCFX_TYBMB WHERE FSCOPE = '成衣问题点'  and FPARENTCODE= '"
				+ wxxz + "'";
		wtd = mrService.getWtd(wheresql);
		String wtds = gson.toJson(wtd);
		PrintWriter pwriter = response.getWriter();
		pwriter.print(wtds);
		pwriter.close();
	}

	// 选择 问题点 带出起因
	@POST
	@Path(value = "/getQy/{message}")
	public void getQy(@PathParam(value = "message") String message,
			@Context HttpServletRequest request,
			@Context HttpServletResponse response) throws Exception {
		String wtd = message;
		Gson gson = new Gson();
		String wheresql = " SELECT FCODE, FCONTENT  FROM SCFX_TYBMB   WHERE FSCOPE = '成衣问题起因' and  FPARENTCODE= '"
				+ wtd + "'";
		// CustomerContextHolder.setCustomerType("x6");
		qy = mrService.getQy(wheresql);

		String qys = gson.toJson(qy);
		PrintWriter pwriter = response.getWriter();
		pwriter.print(qys);
		pwriter.close();
	}

	// 选择 问题点 带出起因
	@POST
	@Path(value = "/getXxd/{message}")
	public void getXxd(@PathParam(value = "message") String message,
			@Context HttpServletRequest request,
			@Context HttpServletResponse response) throws Exception {
		String qy = message;
		Gson gson = new Gson();
		String wheresql = "  SELECT FCODE, FCONTENT  FROM SCFX_TYBMB   WHERE FSCOPE = '成衣问题现象点' and FPARENTCODE = '"
				+ qy + "'";
		// CustomerContextHolder.setCustomerType("x6");
		xxd = mrService.getXxd(wheresql);

		String xxds = gson.toJson(xxd);
		PrintWriter pwriter = response.getWriter();
		pwriter.print(xxds);
		pwriter.close();
	}

	// 判定结果处理
	@POST
	@Path(value = "/getTybmb/{message}")
	public void getTybmb(@PathParam(value = "message") String message,
			//@QueryParam(value="para") String para,
			@Context HttpServletRequest request,
			@Context HttpServletResponse response) throws Exception {
		//System.out.println( request.getContextPath());
		
		String where = "";
		if ("wtd".equals(message)) {
			where = "WHERE FSCOPE = '成衣问题点'";
		}
		;
		if ("qy".equals(message)) {
			where = "WHERE FSCOPE = '成衣问题起因'";
		}
		;
		if ("xxd".equals(message)) {
			where = "WHERE FSCOPE = '成衣问题现象点'";
		}
		;
		if ("tccljg".equals(message)) {
			where = "WHERE FSCOPE = '退仓处理结果'";
		}
		;
		if ("zrbm".equals(message)) {
			where = "WHERE FSCOPE = '维修_责任部门'";
		}
		;
		if ("jhwxts".equals(message)) {
			where = "WHERE FSCOPE = '计划维修天数'";
		}
		if ("wxry".equals(message)) {
			where = "WHERE FSCOPE = '维修人员'";
		}
		if ("gys".equals(message)) {
			where = "WHERE FSCOPE = '供应商维护'";
		}
		if("wxjefw".equals(message)){
			String parentCode = request.getParameter("parentCode");
			where = "WHERE FSCOPE = '成衣维修金额范围' and FPARENTCODE='"+parentCode+"' ";
		}
		if("zzwxd".equals(message)){
			where = "WHERE FSCOPE = '最终维修点'";
		}
		
		if("sfje".equals(message)){
			String parentCode = request.getParameter("parentCode");
			where = "WHERE FSCOPE = '成衣维修收费金额' and FPARENTCODE='"+parentCode+"' ";
		}
		if("wxwxje".equals(message)){
			String kh = request.getParameter("kh");
			//String kh1 = (String) request.getAttribute("kh");
			String category = mrService.getCategoryByKh(kh);
			where = "Where FSCOPE = '成衣维修外修金额'  AND FDESCRIPTION='"+category+"' ";
		}
		
		
		Gson gson = new Gson();
		// CustomerContextHolder.setCustomerType("x6");
		String wheresql = "  SELECT FCODE,FSCOPE, FCONTENT  FROM SCFX_TYBMB  "
				+ where;
		// WHERE FSCOPE = '"+request.getParameter("fscope")+"' and FPARENTCODE =
		// '"+request.getParameter("fcode")+"'";
		List<QueryBean> tybm = mrService.getTybmb(wheresql);

		String tybms = gson.toJson(tybm);
		PrintWriter pwriter = response.getWriter();
		pwriter.print(tybms);
		pwriter.close();
	}

	// 校验款号
	@POST
	@Path(value = "/checkKh/{message}")
	public void checkKh(@PathParam(value = "message") String message,
			@Context HttpServletRequest request,
			@Context HttpServletResponse response) throws Exception {
		String kh = request.getParameter("params");
		Gson gson = new Gson();
		UserInfo userInfo = (UserInfo) request.getSession().getAttribute(
				"userInfo");
		// CustomerContextHolder.setCustomerType(userInfo.getCom());
		List styleInfoList = mrService.checkKh(userInfo.getSsoSessionID(), kh);
		// String clothingid2 = "";
		// 如果直接根据新sku找不到数据记录就去 根据 旧sku oldclothingid 找新clothingid

		PrintWriter pwriter = response.getWriter();
		pwriter.print(gson.toJson(styleInfoList));
		pwriter.close();

	}
	
	//批量总部发货
	@POST
	@Path(value = "/send/{message}")
	@Transactional
	public void sendFromHQBatch(@Context HttpServletRequest request,
			@Context HttpServletResponse response) throws Exception{
		String guids = request.getParameter("guid");
		String ysgs = request.getParameter("ysgs");
		UserInfo userInfo = (UserInfo) request.getSession().getAttribute(
				"userInfo");	
		String[] array_guid = guids.split(",");
		MaintainRegister mrbean = null;
		String tcjginfo = "总部 批量发货不成功";
		for (int i = 0; i < array_guid.length; i++) {
			mrbean = mrService.find(array_guid[i]);
			//mrbean.setZbfhdh(mrService.sendGoods(mrbean.getWxcbm(),mrbean.getDpbm(),mrbean.getKh(), userInfo,userInfo.getUserid()).split(",")[0]);
			mrbean.setZt("8");
			// 总部发货
			mrbean.setZbfhYsgs(ysgs);
			mrbean.setZbfhShr(mrbean.getDzxm());
			mrbean.setZbfhShrdh(mrbean.getDzlxdh());
			mrbean.setZbfhShdz(mrbean.getFhdz());
			mrbean.setZbfhFhdz(mrbean.getShdz());
					
			mrbean.setZbfhBzr(userInfo.getUsername());
			mrbean.setZbfhBzrq(new Timestamp(System.currentTimeMillis()));
			mrService.update(mrbean);
			tcjginfo = "总部 批量发货部分不成功";
		}
		tcjginfo = "总部批量发货并保存成功";
		PrintWriter pwriter = response.getWriter();
		pwriter.print(tcjginfo);
		pwriter.close();
		
	}
	
	
	
	public static void main(String[] arg0) {
		String wxdh = "雅莹,贝爱,雅兰";

		System.out.println("'" + wxdh.replaceAll(",", "','") + "'");
	}

}

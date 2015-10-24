package com.nh.action;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.nh.model.DOutindentChk;
import com.nh.model.DOutindentChksub;
import com.nh.model.DOutindentSet;
import com.nh.model.DOutindentSetsub;
import com.nh.model.DOutindentSetsubId;
import com.nh.model.JClothing;
import com.nh.model.JDepot;
import com.nh.model.SysStylepower18ql;
import com.nh.service.DOutindentService;
import com.nh.util.User;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class returnGoodsAction extends ActionSupport implements
		ModelDriven<DOutindentSetsub> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 632855731623581210L;

	private JDepot jDepot;
	private DOutindentSet dOutindentSet;
	private List<DOutindentSetsub> dOutindentSetsub;
	private DOutindentSetsub DOutindentSetsub1 = new DOutindentSetsub();
	private Date suredate;
	private String outindentid;
	private String surename;
	
	public DOutindentSet getDOutindentSet() {
		return dOutindentSet;
	}

	public void setDOutindentSet(DOutindentSet dOutindentSet) {
		this.dOutindentSet = dOutindentSet;
	}
	
	public DOutindentSet getdOutindentSet() {
		return dOutindentSet;
	}

	public void setdOutindentSet(DOutindentSet dOutindentSet) {
		this.dOutindentSet = dOutindentSet;
	}

	public Date getSuredate() {
		return suredate;
	}

	public void setSuredate(Date suredate) {
		this.suredate = suredate;
	}

	public String getOutindentid() {
		return outindentid;
	}

	public void setOutindentid(String outindentid) {
		this.outindentid = outindentid;
	}

	public String getSurename() {
		return surename;
	}

	public void setSurename(String surename) {
		this.surename = surename;
	}

	public List<DOutindentSetsub> getDOutindentSetsub() {
		return dOutindentSetsub;
	}

	public void setDOutindentSetsub(List<DOutindentSetsub> dOutindentSetsub) {
		this.dOutindentSetsub = dOutindentSetsub;
	}



	public JDepot getJDepot() {
		return jDepot;
	}

	public void setJDepot(JDepot jDepot) {
		this.jDepot = jDepot;
	}

	public DOutindentSetsub getModel() {
		// TODO Auto-generated method stub
		return DOutindentSetsub1;
	}

	private DOutindentService service;

	public DOutindentService getDOutindentService() {
		return service;
	}

	public void setDOutindentService(DOutindentService service) {
		this.service = service;
	}
	
	private User user;
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	
	private int radio=1;

	public int getRadio() {
		return radio;
	}

	public void setRadio(int radio) {
		this.radio = radio;
	}

	@Override
	public String execute() throws Exception {
		HttpServletRequest request=ServletActionContext.getRequest();
        String userid=request.getParameter("userid");
        Map<String,Object> session = ActionContext.getContext().getSession();
        //session.put("userid",userid);
        session.put("userid",userid);
        String outindentid=request.getParameter("outindentid");
		//System.out.println(outindentid);
		//判断在退货发货单DOutindentSet中是否存在
        List<DOutindentSet> list = service.queryByOutindentid(outindentid);
        //List<DOutindentChk> list = service.queryById(outindentid);
        if (null!=list && list.size()>0){
        	//判断是否已审核
        	this.dOutindentSet = list.get(0);
        	
        	if (dOutindentSet.getSure()==1){
        		request.setAttribute("ischeck", "单号"+outindentid+"已登帐!");
        		return INPUT;
        	}
        	if (dOutindentSet.getChksure()==1){
        		request.setAttribute("ischeck", "单号"+outindentid+"已审核!");
        		return INPUT;
        	}
        	
        	//System.out.println(dOutindentSet.getChksure());
        	//System.out.println(dOutindentSet.getSure());
        	
        	//退货单号存在后，判断是否有退货权限
        	String s = service.exeGetUserProc(userid);
        	//System.out.println("权限："+s);
        	if(null==s){
        		this.addFieldError("error0", "用户'"+userid+"'没有退货权限!");
    			return INPUT;
        	}
			
			dOutindentSet.setCrdate(dOutindentSet.getCrdate().substring(0, 10));//改变时间格式
			//获取店铺名称
			this.jDepot = service.queryBydepotid(dOutindentSet.getDepotid());
			//退货发货单明细表
			this.dOutindentSetsub = service.execRightProc1("NULL", outindentid);
			DOutindentSetsub1.setNums(1);
			return SUCCESS;
		}
		else{
			this.addFieldError("error", "退货发货单号'"+outindentid+"'不存在!");
			return INPUT;
		}
	}
	
	public String addColorid() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		String outindentid = request.getParameter("outindentid");
		Map<String,Object> session = ActionContext.getContext().getSession();
	    String userid = session.get("userid").toString();
	    List<DOutindentSet> listset = service.queryByOutindentid(outindentid);
	    this.dOutindentSet = listset.get(0);	
	    dOutindentSet.setCrdate(dOutindentSet.getCrdate().substring(0, 10));//改变时间格式
		String clothingid = DOutindentSetsub1.getId().getClothingid();// 获取页面款号
		//判断款号是否存在
		List<JClothing> listJCothing = service.getClothing(clothingid);
		if(null != listJCothing && listJCothing.size() > 0){
			//this.addFieldError("Colorid", "款号'"+clothingid+"'存在!");
			JClothing jcothing = listJCothing.get(0);
			//款号存在后，判断是否有款式操作权限
			List<SysStylepower18ql> listsysstyle = service.getSysStyle(jcothing.getJStyle(), userid);
			
			
			if(null != listsysstyle && listsysstyle.size() >0){
				//this.addFieldError("sysStyle", "拥有款号'"+clothingid+"'退货操作权限!");			
				int num = DOutindentSetsub1.getNums();//获取页面数量
				//判断审批单中是否存在	

				//List<DOutindentChk> listChk = service.queryById(outindentid);		
				//System.out.println("========="+listChk.size());
				
				if (null!=dOutindentSet.getQuotaid()&& !dOutindentSet.getQuotaid().equals("")){		
//				System.out.println("--"+dOutindentSet.getQuotaid());
//				if(null != listChk && listChk.size() >0){
					//存在审批单，判断款号存在和数量大小
					// 退货审批单明细表 判断款号是否存在，判断数量是否在范围内
					List<DOutindentChksub> list = service.clothOrNum(dOutindentSet.getQuotaid(),clothingid);
					int chknum = 0;
					if (null != list && list.size() > 0) {
						DOutindentChksub DOutindentChksub = list.get(0);
						//获取审批的数量
						chknum = DOutindentChksub.getNums();
						//this.addFieldError("ChkColorid", "退货审批单中款号"+clothingid+"存在!");
						if ( num >= 0 ) {
							if (radio == 0) { // 负数
								//System.out.println(radio);
								num = -num;
							}
						}else{
							this.addFieldError("Nums", "数量不能为负!");
						}
						
						//1.判断退货明细单是否存在款号，不存在的款号添加，存在的款号数量增加
						//jcothing.getClothingid();//款号
						//jcothing.getOldclothingid();//老款号
						//System.out.println(clothingid);
						//System.out.println(jcothing.getOldclothingid());
						if(jcothing.getOldclothingid()==clothingid){
							clothingid = jcothing.getClothingid();
							//this.addFieldError("oldclothingid", "你输入的是老款号,新款号是"+jcothing.getClothingid()+"!");
						}
						// 退货单明细表
						List<DOutindentSetsub> list1 = service.getColorid(outindentid,clothingid);
						DOutindentSetsub DOutindentSetsub = null;
						if (null != list1 && list1.size() > 0) {
							//System.out.println("update");
							DOutindentSetsub = list1.get(0);
							//System.out.println(list1.size());
							//System.out.println("修改的款号是："+DOutindentSetsub.getId().getClothingid());
							
							int setnum = DOutindentSetsub.getNums();
							if (chknum >= num + setnum){
								//System.out.println(service.execRightProc(clothingid));
								if (service.execRightProc(clothingid).equals("EP")){
									request.setAttribute("sound", "EP");
								}else{
									request.setAttribute("sound", "OTHERS");
								}
								
								DOutindentSetsub.setNums(setnum + num);
								service.saveSetsub(DOutindentSetsub);
							}
							else{
								this.addFieldError("Nums", "数量超过了审批单最大数量!");
							}					
						}
						else{
							//System.out.println("add");
							//System.out.println(chknum+","+num);
							if (chknum >= num){
								DOutindentSetsub = new DOutindentSetsub();
								DOutindentSetsubId DOutindentSetsubId = new DOutindentSetsubId();
								DOutindentSetsubId.setDOutindentSet(service.queryByOutindentid(outindentid).get(0));
								DOutindentSetsubId.setBoxid(DOutindentChksub.getId().getBoxid());
								DOutindentSetsubId.setClothingid(DOutindentChksub.getId().getClothingid());
								DOutindentSetsub.setId(DOutindentSetsubId);
								DOutindentSetsub.setStyleid(DOutindentChksub.getStyleid());
								DOutindentSetsub.setColorid(DOutindentChksub.getColorid());
								DOutindentSetsub.setSizeid(DOutindentChksub.getSizeid());
								DOutindentSetsub.setCost(DOutindentChksub.getCost());
								DOutindentSetsub.setSPrice(DOutindentChksub.getSPrice());
								DOutindentSetsub.setNums(num);
								//DOutindentSetsub.setDiscount(DOutindentChksub.getDiscount());
								DOutindentSetsub.setJPrice(DOutindentChksub.getJPrice());
								// 获取现价、折扣
								//System.out.println(dOutindentSet.getSetdepotid());
								double[] aa = new double[2];
								aa = service.exePriceProc(dOutindentSet.getSetdepotid(), clothingid);
								DOutindentSetsub.setXPrice(aa[0]);
								DOutindentSetsub.setDiscount(aa[1]);
								DOutindentSetsub.setChknums(DOutindentChksub.getChknums());
								SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:MM:ss");
								DOutindentSetsub.setCrdate(Timestamp.valueOf(sdf.format(new Date())));
								//System.out.println(sdf);
								service.saveSetsub(DOutindentSetsub);
								
								//System.out.println(service.execRightProc(clothingid));
								if (service.execRightProc(clothingid).equals("EP")){
									request.setAttribute("sound", "EP");
								}else{
									request.setAttribute("sound", "OTHERS");
								}
							}
							else{
								this.addFieldError("Nums", "数量超过了审批单最大数量!");
							}		
						}		
					}
					else{
						
						this.addFieldError("ChkColorid", "退货审批单中款号'"+clothingid+"'不存在!添加失败！");
					}
					
				}else{
					//this.addFieldError("ChkColorid", "款号'"+clothingid+"'添加成功!");
					//不存在审批单
					if ( num >= 0 ) {
						if (radio == 0) { // 负数		
							//System.out.println("=="+radio);
							
							num = -num;
						}
					}else{
						this.addFieldError("Nums", "数量不能为负!");
					}
					//System.out.println(clothingid);
					//System.out.println(jcothing.getOldclothingid());
					if(jcothing.getOldclothingid().equals(clothingid)){
						clothingid = jcothing.getClothingid();
						//this.addFieldError("oldclothingid", "你输入的是老款号,新款号是"+jcothing.getClothingid()+"!");
					}
					// 退货单明细表
					List<DOutindentSetsub> list1 = service.getColorid(outindentid,clothingid);
					//1.判断退货明细单是否存在款号，不存在的款号添加，存在的款号数量增加
					DOutindentSetsub DOutindentSetsub = null;
					if (null != list1 && list1.size() > 0) {
						DOutindentSetsub = list1.get(0);
						int setnum = DOutindentSetsub.getNums();
						DOutindentSetsub.setNums(setnum + num);
						service.saveSetsub(DOutindentSetsub);
						
						//System.out.println(service.execRightProc(clothingid));
						if (service.execRightProc(clothingid).equals("EP")){
							request.setAttribute("sound", "EP");
						}else{
							request.setAttribute("sound", "OTHERS");
						}
					}
					else{
						DOutindentSetsub = new DOutindentSetsub();
						DOutindentSetsubId DOutindentSetsubId = new DOutindentSetsubId();
						DOutindentSetsubId.setDOutindentSet(service.queryByOutindentid(outindentid).get(0));	
						DOutindentSetsubId.setBoxid("tm"+userid);
						DOutindentSetsubId.setClothingid(clothingid);
						DOutindentSetsub.setId(DOutindentSetsubId);
						DOutindentSetsub.setStyleid(jcothing.getJStyle());
						DOutindentSetsub.setColorid(jcothing.getColorid());
						DOutindentSetsub.setSizeid(jcothing.getSizeid());
						DOutindentSetsub.setCost(jcothing.getJCost());
						DOutindentSetsub.setSPrice(jcothing.getXPrice());
						DOutindentSetsub.setNums(num);
						DOutindentSetsub.setJPrice(jcothing.getJPrice());
						// 获取现价
						//System.out.println(dOutindentSet.getSetdepotid());
						double[] aa = new double[2];
						aa = service.exePriceProc(dOutindentSet.getSetdepotid(), clothingid);
						DOutindentSetsub.setXPrice(aa[0]);
						DOutindentSetsub.setDiscount(aa[1]);
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:MM:ss");
						DOutindentSetsub.setCrdate(Timestamp.valueOf(sdf.format(new Date())));
						//System.out.println(sdf);
						service.saveSetsub(DOutindentSetsub);
						
						//System.out.println(service.execRightProc(clothingid));
						if (service.execRightProc(clothingid).equals("EP")){
							request.setAttribute("sound", "EP");
						}else{
							request.setAttribute("sound", "OTHERS");
						}
					}				
				}
			}else{
				//request.setAttribute("sound", "error");//
				this.addFieldError("sysStyle", "此用户不拥有款号'"+clothingid+"'退货操作权限!");
				
			}	
		}
		else{
			//request.setAttribute("sound", "error");
			this.addFieldError("Colorid", "款号'"+clothingid+"'不存在!");
		}

		// 获取店铺名称
		this.jDepot = service.queryBydepotid(service.queryByOutindentid(outindentid).get(0).getDepotid());
		// 退货发货单明细表
		this.dOutindentSetsub = service.execRightProc1("NULL", outindentid);
		
		
		return SUCCESS;
	}
	
/**
 var storeData2 = {identifier: 'abbr',
		    label: 'name',
		    items: [
		        {abbr:'ec', name:'Ecuador',           capital:'Quito'},
		        {abbr:'eg', name:'Egypt',             capital:'Cairo'},
		        {abbr:'sv', name:'El Salvador',       capital:'San Salvador'},
		        {abbr:'gq', name:'Equatorial Guinea', capital:'Malabo'},
		        {abbr:'er', name:'Eritrea',           capital:'Asmara'},
		        {abbr:'ee', name:'Estonia',           capital:'Tallinn'},
		        {abbr:'et', name:'Ethiopia',          capital:'Addis Ababa'}
		]};
		
		{"user":{"id":"123","name":"Struts2","password":"123","say":"Hello world !"}}
		{'data':[{'name':'Wallace'},{'name':'Grommit'}]}
 */

		public String testByJSP() {
			//System.out.println("testByJSP()");
			/*user = new User();
			user.setId("123");
			user.setName("Struts2");
			user.setPassword("123");
			user.setSay("Hello world !");
			JSONObject jsonObject = new JSONObject();
			jsonObject.accumulate("user", user);
			//System.out.println(jsonObject.toString());
			// 这里在request对象中放了一个data，所以struts的result配置中不能有type="redirect"
			ServletActionContext.getRequest().setAttribute("data", jsonObject.toString());
			ServletActionContext.getRequest().setAttribute("data1", "json");
			
			service.exePriceProc("NF001A85", "E12PB9127AM3");*/
			
			service.isEpDepot("E12PB9127AM3");
			
			return SUCCESS;
		}


		public String crmMethod() throws Exception {
			HttpServletRequest request = ServletActionContext.getRequest();
			String error="";
			//判断锁账日期，若选择的登帐日期<=此查询出的日期时则提示帐目已经锁定，不能登帐
			List<DOutindentSet> list = service.queryByOutindentid(outindentid);
			if (null!=list && list.size()>0){
				this.dOutindentSet=list.get(0);
				this.jDepot = service.queryBydepotid(dOutindentSet.getDepotid());
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date date = sdf.parse(jDepot.getZmrqdate());
				if (suredate.compareTo(date) < 0){
					error="帐目已经锁定，不能登帐!";
					request.setAttribute("error", error);
					return SUCCESS;
				}else{
					//判断合同是否到期，若查询出的记录为空则提示合同到期，不能登帐
					//System.out.println(dOutindentSet.getMerchantid());
					if(null==dOutindentSet.getMerchantid() && dOutindentSet.getMerchantid().equals("")){
						error="合同到期，不能登帐!";
						request.setAttribute("error", error);
						return SUCCESS;
					}
					else{
						//判断登帐后是否有盘点单，若查询有记录则提示此登帐日期之后已有盘点单，不能登帐
						//System.out.println(dOutindentSet.getSetdepotid());
						SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						//System.out.println(format1.format(suredate));
						List<Object> list1 = service.haveInventory(dOutindentSet.getSetdepotid(), format1.format(suredate));
						if(null != list1 && list1.size() >0){
							error="此登帐日期之后已有盘点单，不能登帐!";
							request.setAttribute("error", error);
							return SUCCESS;
						}else{
							//System.out.println("service.exeSplitListProc");
							service.exeSplitListProc(outindentid, surename, suredate);
							error="登帐成功!";
							request.setAttribute("error", error);
							return SUCCESS;
						}
					}
				}
				
			}else{
				error="单号"+outindentid+"不存在!";
				request.setAttribute("error", error);
				return SUCCESS;
			}
		};
				
		
		

	

}

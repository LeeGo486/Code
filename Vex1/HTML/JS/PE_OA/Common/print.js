//审批历史记录集
var flowHis = [];
var pobjsqr = new Object(); //申请人
var pobjdd = new Object();  //督导
var pobjbmzs = [];  //部门长
var pobjcw = new Object();  //财务
var pobjcwfgzg = new Object();  //财务分管主管
var pobjfzjl = new Object();  //副总经理
var pobjzjl = new Object();  //总经理
var pobjcn = new Object();  //出纳  
  

/***********************************************************************
 *  获取打印信息
 *  DLY
 *  2014-02-14
 */ 
function   print_getFlowHis(billCode,comid)  {   
	//获取审批历史记录
	flowHis = basedate_getFlowHis(billCode,comid);
	//整理有效审批信息
	for(var i=0; i<flowHis.length; i++){ 
		if(flowHis[i].refuseCode!=undefined && flowHis[i].refuseCode==1 ){
			continue;
		}
		if(flowHis[i].approveEffect!=undefined && flowHis[i].approveEffect==1 ){
			continue;
		}
		if(flowHis[i].actor == '申请人'){
			if(flowHis[i].id*1>print_undefinedOrNull(pobjsqr.id,0)){
				pobjsqr = flowHis[i];
			} 
			continue; 
		}else if(flowHis[i].actor == '督导'){
			if(flowHis[i].id*1>print_undefinedOrNull(pobjdd.id,0)){
				pobjdd = flowHis[i];
			}
			continue;
		}else if(flowHis[i].actor == '部门长'){
			pobjbmzs.push(flowHis[i]); 
			continue;  
		}else if(flowHis[i].actor == '财务'){
			if(flowHis[i].id*1>print_undefinedOrNull(pobjcw.id,0)){
				pobjcw = flowHis[i];
			} 
			continue; 
		}else if(flowHis[i].actor == '财务分管主管'){
			if(flowHis[i].id*1>print_undefinedOrNull(pobjcwfgzg.id,0)){
				pobjcwfgzg = flowHis[i];
			} 
			continue; 
		}if(flowHis[i].actor == '副总经理'){
			if(flowHis[i].id*1>print_undefinedOrNull(pobjfzjl.id,0)){
				pobjfzjl = flowHis[i];
			} 
			continue; 
		}else if(flowHis[i].actor == '总经理'){
			if(flowHis[i].id*1>print_undefinedOrNull(pobjzjl.id,0)){
				pobjzjl = flowHis[i];
			} 
			continue;  
		}else if(flowHis[i].actor == '出纳'){
			if(flowHis[i].id*1>print_undefinedOrNull(pobjcn.id,0)){
				pobjcn = flowHis[i];
			} 
			continue; 
		}
	}
	//获取各角色对应签名信息 
	var ps = basedate_getBaseDate(comid,'签名打印控制');   
	if(print_undefinedOrNull(pobjsqr.id,'') != ''){
		pobjsqr.qmnr =  print_undefinedOrNull(pobjsqr.excuteUser,''); 
		for(var i=0; i<ps.length; i++){
			if(ps[i].typeName == pobjsqr.excuteUser ){
				pobjsqr.qmlx =  print_undefinedOrNull(ps[i].typeAttr2,'');
				pobjsqr.qmnr =  print_undefinedOrNull(ps[i].typeAttr1,pobjsqr.excuteUser);  
				break;
			}
		}
	}
	if(print_undefinedOrNull(pobjdd.id,'') != ''){
		pobjdd.qmnr =  print_undefinedOrNull(pobjdd.excuteUser,''); 
		for(var i=0; i<ps.length; i++){
			if(ps[i].typeName == pobjdd.excuteUser){
				pobjdd.qmlx =  print_undefinedOrNull(ps[i].typeAttr2,'');
				pobjdd.qmnr =  print_undefinedOrNull(ps[i].typeAttr1,pobjdd.excuteUser);  
				break;
			}
		}
	} 
	for(var b=0; b<pobjbmzs.length; b++){  
		pobjbmzs[b].qmnr = print_undefinedOrNull(pobjbmzs[b].excuteUser,''); 
		for(var i=0; i<ps.length; i++){ 
			if(ps[i].typeName == pobjbmzs[b].excuteUser){ 
				pobjbmzs[b].qmlx =  print_undefinedOrNull(ps[i].typeAttr2,'');
				pobjbmzs[b].qmnr =  print_undefinedOrNull(ps[i].typeAttr1,pobjbmzs[b].excuteUser);  
				break;
			}
		} 
	}
	if(print_undefinedOrNull(pobjcw.id,'') != ''){
		pobjcw.qmnr =  print_undefinedOrNull(pobjcw.excuteUser,''); 
		for(var i=0; i<ps.length; i++){
			if(ps[i].typeName == pobjcw.excuteUser){
				pobjcw.qmlx =  print_undefinedOrNull(ps[i].typeAttr2,'');
				pobjcw.qmnr =  print_undefinedOrNull(ps[i].typeAttr1,pobjcw.excuteUser); 
				break;
			}
		}
	}
	if(print_undefinedOrNull(pobjcwfgzg.id,'') != ''){
		pobjcwfgzg.qmnr =  print_undefinedOrNull(pobjcwfgzg.excuteUser,''); 
		for(var i=0; i<ps.length; i++){
			if(ps[i].typeName == pobjcwfgzg.excuteUser){
				pobjcwfgzg.qmlx =  print_undefinedOrNull(ps[i].typeAttr2,'');
				pobjcwfgzg.qmnr =  print_undefinedOrNull(ps[i].typeAttr1,pobjcwfgzg.excuteUser); 
				break;
			}
		}
	}
	if(print_undefinedOrNull(pobjfzjl.id,'') != ''){
		pobjfzjl.qmnr =  print_undefinedOrNull(pobjfzjl.excuteUser,''); 
		for(var i=0; i<ps.length; i++){
			if(ps[i].typeName == pobjfzjl.excuteUser){
				pobjfzjl.qmlx =  print_undefinedOrNull(ps[i].typeAttr2,'');
				pobjfzjl.qmnr =  print_undefinedOrNull(ps[i].typeAttr1,pobjfzjl.excuteUser);  
				break;
			}
		}
	}
	if(print_undefinedOrNull(pobjzjl.id,'') != ''){
		pobjzjl.qmnr =  print_undefinedOrNull(pobjzjl.excuteUser,''); 
		for(var i=0; i<ps.length; i++){
			if(ps[i].typeName == pobjzjl.excuteUser){
				pobjzjl.qmlx =  print_undefinedOrNull(ps[i].typeAttr2,'');
				pobjzjl.qmnr =  print_undefinedOrNull(ps[i].typeAttr1,pobjzjl.excuteUser);  
				break;
			}
		}
	}
	if(print_undefinedOrNull(pobjcn.id,'') != ''){
		pobjcn.qmnr =  print_undefinedOrNull(pobjcn.excuteUser,''); 
		for(var i=0; i<ps.length; i++){
			if(ps[i].typeName == pobjcn.excuteUser){
				pobjcn.qmlx =  print_undefinedOrNull(ps[i].typeAttr2,'');
				pobjcn.qmnr =  print_undefinedOrNull(ps[i].typeAttr1,pobjcn.excuteUser);  
				break;
			}
		}
	}
	
	var fhobj = new Object();  //返回信息
	fhobj.pobjsqr = pobjsqr;
	fhobj.pobjdd = pobjdd;
	fhobj.pobjbmzs = pobjbmzs;
	fhobj.pobjcw = pobjcw;
	fhobj.pobjcwfgzg = pobjcwfgzg;
	fhobj.pobjfzjl = pobjfzjl;
	fhobj.pobjzjl = pobjzjl;
	fhobj.pobjcn = pobjcn; 
	return fhobj;
}	


/***********************************************************************
 *  undefined 或 null  转换成 制定值
 *  DLY
 *  2013-04-18
 */ 
function print_undefinedOrNull(obj,value){ 
	 if(obj == undefined || obj == null){
		 return value;
	 }else{
		 return obj;
	 }
}



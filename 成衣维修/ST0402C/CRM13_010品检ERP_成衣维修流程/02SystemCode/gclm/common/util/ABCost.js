	
 var lb_lastIndex = -1;  //费用明细列表最后一次选中行下标 
 var lb_lastIndex1 = -1;  //费用分摊列表最后一次选中行下标 
 var lb_lastIndex2 = -1;  //费用预算科目列表最后一次选中行下标 
 
// var ftGrid_ExcelRows = 0;	//	分摊导入excel行数
 
 //币种json数组
 var protimesBZ = []; 
 //付款类型json数组
 var protimesFKLX = []; 
 //付款方式json数组
 var protimesFKFS = [];  
 //人员json数组
 var protimesRY = [];  
 //供应商json数组
 var protimesGYS = []; 
 //汇率json数组
 var protimesHL = []; 
 
 //科目大小类数组
 var protimesDLA = []; 
 var protimesDLB = []; 
 var protimesXLA = []; 
 var protimesXLB = []; 
 
 //分摊信息数组
 var fyftLists = []; 

 var val_dept = [];
 
 var protimesBZ = basedate_getBZ();
 var acccode   ;
/* 
 protimesBZ = basedate_getBZ(); 
	protimesFKLX = basedate_getFKLX();
	protimesFKFS = basedate_getFKFS();  */
	
	/*
	 * protimesDLA = basedate_getDL('22','A帐','2013-05-26');  
	  protimesDLB = basedate_getDL('22','B帐','2013-05-26');*/
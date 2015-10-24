//************* 初始化*****//
var protimesZT = [ {statets:'启用',statevs:'启用'},{statets:'禁用',statevs:'禁用'} ];
var editIndex = undefined;
var protimesRemark = [];
var type1 = "基础类型";
var JCSJ = basedate_getJCSJ(encodeURI(type1));//获取基础数据
var JCSJinfo =basedate_getJCSJinfo(encodeURI(type1));//基础数据 信息
var userName = null;

$(function(){
	userName = $('#userName').attr('value');
	$('#jclx_combobox').combobox('setValue',type1);
	//$('#dg').datagrid('loadData',JCSJinfo);
	
	$('#dg').datagrid({
		//iconCls:'icon-save',
		pageSize : 200,
		width:'1200',
	 	height:'400',
		//nowrap: true,
	 	sortName: 'typeSeqID',
		sortOrder: 'asc',
		remoteSort: false,
		autoRowHeight: false,
		striped: true,
		collapsible:true,
		//loadMsg:'正在努力查找数据……',
		//url:'/gclm/web/maintainregister!execute',
		//url:'/gclm/rest/Typzb/queryEntities?type=基础资料&s='+new Date().getTime(),
		method:'get',
		onDblClickRow:onDblClickRow,
		columns:[[
			{field:'guid',title:'主键',hidden:true},
			{field:'type',title:'类型',width:80,sortable:true},
			{field:'typeSeqID',title:'类型序号',width:80,sortable:true,
				editor:{type:'numberbox',options:{precision:0}}
			},
			{field:'typeCode',title:'类型代号',width:80,sortable:true,editor:'text'},
			{field:'typeName',title:'类型名称',width:120,sortable:true,editor:'text'},
			{field:'remark',title:'备注',width:100,sortable:true,editor:'text'},
			{field:'typeAttr1',title:'属性1',width:100,sortable:true,editor:'text'},
			{field:'typeAttr2',title:'属性2',width:100,sortable:true,editor:'text'},
			{field:'typeAttr3',title:'属性3',width:100,sortable:true,editor:'text'},
			{field:'typeAttr4',title:'属性4',width:100,sortable:true,editor:'text'},
			{field:'typeAttr5',title:'属性5',width:100,sortable:true,editor:'text'},
			{field:'status',title:'状态',width:100,sortable:true,
				feditor:{
					type:'combobox',
					options:{
						valueField:'statevs',
						textField:'statets',
						data:protimesZT,
						panelHeight:'auto'
					}	
				}
			},
			
			{field:'modifier',title:'修改人',width:100,sortable:true},
			{field:'modifyTime',title:'修改时间',width:100,sortable:true}
			
			
		]],
		rownumbers:true
	});
	$('#dg').datagrid('loadData',JCSJinfo);  //清空当前分摊记录  
	//$('#dg').datagrid('load');
	
});

function endEditing(){
	if (editIndex == undefined){return true;}
	if ($('#dg').datagrid('validateRow', editIndex)){
		$('#dg').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function onDblClickRow(index){
	if (editIndex != index){
		if (endEditing()){
			$('#dg').datagrid('selectRow', index).datagrid('beginEdit', index);
			editIndex = index;
		} else {
			$('#dg').datagrid('selectRow', editIndex);
		}
	}
}
function append(){
	if (endEditing()){
		var text = $('#jclx_combobox').combobox('getValue');
		$('#dg').datagrid('appendRow', {
			type:text,
			modifyTime: dateUtil_dateFomaterD(new Date(),'-'),
			modifier: userName,
			status:'启用'
		});
		editIndex = $('#dg').datagrid('getRows').length-1;
		$('#dg').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
	}
}
function removed(){
	var rows = $('#dg').datagrid('getSelections');
	if (null == rows || rows.length == 0) {  
		$.messager.alert('提醒','请选择要删除的数据!'); 
		return;  
	}
	$.messager.confirm('Confirm','确认要删除操作吗?',function(r){
		if (r){
			for ( var i = 0; i < rows.length; i++) { 
				var durl = '/gclm/rest/Typzb/deleteEntities/'+rows[i].guid;
			   	$.ajax({
				    url: durl,
				    type: 'DELETE',
				    async: false,
				    success: function(result) {
				    	//$('#dg').datagrid('deleteRow',i);
				        Refresh();
				    }
				});
			   	$('#jclx_combobox').combobox('loadData',basedate_getJCSJ(encodeURI(type1)));
			}  
		}
	});
}
function accept(){
	if (endEditing()){
		if ($('#dg').datagrid('getChanges').length) {
		   	var inserted = $('#dg').datagrid('getChanges',"inserted");  
		   	var updated = $('#dg').datagrid('getChanges',"updated");   		   
		   	var effectRow = new Object();
			if (inserted.length) {
				effectRow["inserted"] = jsonUtil_jsonToStr(inserted);
			}
			if (updated.length) {
				effectRow["updated"] = jsonUtil_jsonToStr(updated);
			}
			$.post(	$('#path').attr('value')+ '/rest/Typzb/saveEntities',effectRow,function(rsp) {
				$.messager.alert("提示","提交成功！");
				$('#dg').datagrid('acceptChanges');
				$('#jclx_combobox').combobox('loadData',basedate_getJCSJ(encodeURI(type1)));
			},'text').error(function() {$.messager.alert("提示","提交错误了！");											});
			
		   	
		   	/*if (inserted.length) {  
			   	for ( var i = 0; i < inserted.length; i++) {
				   	var durl = '/gclm/rest/Typzb/BBaseInf/';
				   //	var durl = getwsaddress("/FBI/BankInfo")
				   	var ss = new Object();
				   	for (var key in inserted[i]) 
					{
						//alert(key);//属性
					  	//alert(jsons[key]);//值
						if(key=='TypeAttr4'||key=='TypeAttr5'){
							if(inserted[i][key]!=''){
								ss[key]=inserted[i][key];
							}
						}else{
							ss[key]=inserted[i][key];
						}
					}
				   	var inserted1 = jsonUtil_jsonToStr(ss);  
				
				  	$.ajax({
					    url: durl,
					    type: 'POST',
					    async: false,
					    dateType:'json',
					    contentType:'application/json;charset=UTF-8',
					    data:inserted1,
					    success: function(result) {
					        //alert(jsonUtil_jsonToStr(result));
					    	$('#dg').datagrid('acceptChanges');
					    	//$('#dg').datagrid('getSelected').id=result.id;
					    	alert('保存成功!');
					    }
					});				    
				}   
		   	}		   
		   	if (updated.length) {
			   	for ( var i = 0; i < updated.length; i++) {  
				   	updated[i].updateDate = dateUtil_dateFomaterC(new Date(),'-');
				   	updated[i].updateName = userInfo.username;
				   	var durl = '/expenseServer/resteasy/entity/BBaseInf/'+updated[i].id;
				   	var ss = new Object();
				   	for (var key in updated[i]) 
					{
						if(key=='typeAttr4'||key=='typeAttr5'){
							if(updated[i][key]!=''){
								ss[key]=updated[i][key];
							}
						}else{
							ss[key]=updated[i][key];
						}
					}
				   	var updated1 = jsonUtil_jsonToStr(ss); 
				   	//alert(durl);
				   	//alert(updated1);
				   	$.ajax({
					    url: durl,
					    type: 'PUT',
					    async: false,//同步,
					    dateType:'json',
					    contentType:'application/json;charset=UTF-8',
					    data:updated1,
					    success: function(result) {
					       // alert(result);
					    	$('#dg').datagrid('acceptChanges');
					    	alert('保存成功!');
					    }
					});
			   	}    
		   	}	     */
		
		}
		
	}
}
function reject(){
	$('#dg').datagrid('rejectChanges');
	editIndex = undefined;
}
function getChanges(){
	var rows = $('#dg').datagrid('getChanges');
	alert(rows.length+' rows are changed!');
}
function Refresh(){
	var typeName = $('#jclx_combobox').combobox('getValue');
	$('#dg').datagrid('loadData',basedate_getJCSJinfo(encodeURI(typeName)));  //清空当前分摊记录  
}

//处理键盘事件 禁止后退键（Backspace）密码或单行、多行文本框除外
function forbidBackSpace(e) {
    var ev = e || window.event; //获取event对象 
    var obj = ev.target || ev.srcElement; //获取事件源 
    var t = obj.type || obj.getAttribute('type'); //获取事件源类型 
    var vReadOnly = obj.readOnly;
    var vDisabled = obj.disabled;
    vReadOnly = (vReadOnly == undefined) ? false : vReadOnly;
    vDisabled = (vDisabled == undefined) ? true : vDisabled;
    var flag1 = ev.keyCode == 8 && (t == "password" || t == "text" || t == "textarea") && (vReadOnly == true || vDisabled == true);
    var flag2 = ev.keyCode == 8 && t != "password" && t != "text" && t != "textarea";
    if (flag2 || flag1) return false;
}
document.onkeypress = forbidBackSpace;
document.onkeydown = forbidBackSpace;

//************* ��ʼ��*****//
var protimesZT = [ {statets:'����',statevs:'����'},{statets:'����',statevs:'����'} ];
var editIndex = undefined;
var protimesRemark = [];
var type1 = "������";
var JCSJ = basedate_getJCSJ(encodeURI(type1));//��ȡ��������
var JCSJinfo =basedate_getJCSJinfo(encodeURI(type1));//�������� ��Ϣ
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
	 	sortName: 'sequence',
		sortOrder: 'asc',
		remoteSort: false,
		autoRowHeight: false,
		striped: true,
		collapsible:true,
		//loadMsg:'����Ŭ���������ݡ���',
		//url:'/gclm/web/maintainregister!execute',
		//url:'/gclm/rest/Typzb/queryEntities?type=��������&s='+new Date().getTime(),
		method:'get',
		onDblClickRow:onDblClickRow,
		columns:[[
			{field:'guid',title:'����',hidden:true},
			{field:'code',title:'����',width:80,sortable:true,editor:'text'},
			{field:'content',title:'����',width:80,sortable:true,editor:'text'},
			{field:'description',title:'����',width:80,sortable:true,editor:'text'/*,
				editor:{type:'numberbox',options:{precision:0}}*/
			},
			{field:'sequence',title:'˳��',width:80,sortable:true,editor:'text'},
			{field:'parentCode',title:'�ϼ�����',width:120,sortable:true,editor:'text'},
			{field:'scope',title:'���',width:100,sortable:true,editor:'text'},
			{field:'deleteFlag',title:'״̬',width:100,sortable:true,
				editor:{
					type:'combobox',
					options:{
						valueField:'statevs',
						textField:'statets',
						data:protimesZT,
						panelHeight:'auto'
					}	
				}
			}
			
			
		]],
		rownumbers:true
	});
	$('#dg').datagrid('loadData',JCSJinfo);  //��յ�ǰ��̯��¼  
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
		if(text=='������'){
			text = "";
		}else{
			text = $('#jclx_combobox').combobox('getValue').split(',')[1];
		}
		$('#dg').datagrid('appendRow', {
			scope:text,
			/*modifyTime: dateUtil_dateFomaterD(new Date(),'-'),
			modifier: userName,*/
			deleteFlag:'����'
		});
		editIndex = $('#dg').datagrid('getRows').length-1;
		$('#dg').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
	}
}
function removed(){
	var rows = $('#dg').datagrid('getSelections');
	if (null == rows || rows.length == 0) {  
		$.messager.alert('����','��ѡ��Ҫɾ��������!'); 
		return;  
	}
	$.messager.confirm('Confirm','ȷ��Ҫɾ��������?',function(r){
		if (r){
			for ( var i = 0; i < rows.length; i++) { 
				var durl = '/gclm/rest/Tybmb/deleteEntities/'+rows[i].guid;
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
			$.post(	$('#path').attr('value')+ '/rest/Tybmb/saveEntities',effectRow,function(rsp) {
				$.messager.alert("��ʾ","�ύ�ɹ���");
				$('#dg').datagrid('acceptChanges');
				$('#jclx_combobox').combobox('loadData',basedate_getJCSJ(encodeURI(type1)));
			},'text').error(function() {$.messager.alert("��ʾ","�ύ�����ˣ�");											});
			
		   	
		   	/*if (inserted.length) {  
			   	for ( var i = 0; i < inserted.length; i++) {
				   	var durl = '/gclm/rest/Typzb/BBaseInf/';
				   //	var durl = getwsaddress("/FBI/BankInfo")
				   	var ss = new Object();
				   	for (var key in inserted[i]) 
					{
						//alert(key);//����
					  	//alert(jsons[key]);//ֵ
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
					    	alert('����ɹ�!');
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
					    async: false,//ͬ��,
					    dateType:'json',
					    contentType:'application/json;charset=UTF-8',
					    data:updated1,
					    success: function(result) {
					       // alert(result);
					    	$('#dg').datagrid('acceptChanges');
					    	alert('����ɹ�!');
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
	$('#dg').datagrid('loadData',basedate_getJCSJinfo(encodeURI(typeName)));  //��յ�ǰ��̯��¼  
}

//��������¼� ��ֹ���˼���Backspace��������С������ı������
function forbidBackSpace(e) {
    var ev = e || window.event; //��ȡevent���� 
    var obj = ev.target || ev.srcElement; //��ȡ�¼�Դ 
    var t = obj.type || obj.getAttribute('type'); //��ȡ�¼�Դ���� 
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

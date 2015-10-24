var m_DatagridID = '#ryxxlb'; //列表ID
 var m_LastIndex = -1;  //人员列表最后一次选中行下标
 var m_LastIndex1 = -1;  //关联部门列表最后一次选中行下标
 var m_PageNumber = 1;  //当前页码
 var m_PageSize = 20;  //每页显示行数
 
 //状态下拉选择
 var m_protimesZT = [ {statets:'启用',statevs:'启用'},{statets:'禁用',statevs:'禁用'} ];
 var m_depttree = []; //组织架构树
 
 //用户信息
 var m_UserInfo = basedata_getUserInfo();
 

 // 过滤条件
 var m_Filter = '';  //主的条件
 var m_Filter1 = ''; //查询条件
 var m_OrderBy = ' EE1_EmpCode '; //排序方式

 /***********************************************************************
  *  初始化
  *  DLY 
  */ 
 $(function () { 
     // 当窗口大小发生变化时，调整DataGrid的大小
     $(window).resize(function () {
         //根据index.html页面的高度设置列表高度 
         $(m_DatagridID).datagrid('resize', {
             width: $(document.body).width(),
             //height: getcurheight()
         });
     });
	
	//状态类型
	$('#cxstatus').combobox({ 
		panelWidth:"80",
		panelHeight:"60" , 
		editable:false,
		multiple:false,
		data:m_protimesZT, 
		valueField:'statets', 
		textField:'statevs' 
	});
	
	 //信息列表
	 $(m_DatagridID).datagrid({
			//title:'人员信息表',
			//iconCls:'icon-save',
			width:document.body.clientWidth, 
			height:480,
			nowrap: true,
			striped: true,
			collapsible:true,
			//url:'mroomlist.action',
			sortName: 'ee1_empcode',
			sortOrder: 'asc',
			remoteSort: false,
			idField: 'ee1_id', 
			frozenColumns:[[
	            //{field:'ck',checkbox:true},
			]],
			columns:[[ 	     
	            { field: 'ee1_id', title: 'FID', width: 80, hidden: true },
		        { field: 'ee1_empname', title: '登录名', width: 70, sortable: true, editor: 'text' },
	            { field: 'ee1_empcode', title: '职员编码', width: 70, sortable: true, editor: 'text' },
		        { field: 'ee1_empnamech', title: '职员姓名', width: 70, sortable: true, editor: 'text' },
		        { field: 'ee1_emppost', title: '职称', width: 150, sortable: true, editor: 'text' },   
		        { field: 'ee1_telephone', title: '电话号码', width: 88, editor: 'text' },
		        { field: 'ee1_mobilephone', title: '移动号码', width: 88, editor: 'text' },
		        { field: 'ee1_bankname', title: '开户银行', width: 120, sortable: true, editor: 'text' },
		        { field: 'ee1_bankaccount', title: '银行账号', width: 130, editor: 'text' },
		        { field: 'ee1_state', title: '状态', width: 80
		        	, editor:{ type:'combobox', 
		        		options:{valueField:'statevs',textField:'statets',
		        			data:m_protimesZT,panelHeight:"auto",editable:false  }}},
		        { field: 'ee1_remark', title: '备注', width: 120, editor: 'text' },
		        { field: 'ee1_rgdt', title: '创建时间', width: 105 },
			    { field: 'ee1_rguser', title: '创建人', width: 70 },
		        { field: 'ee1_lmdt', title: '修改时间', width: 105 },
                { field: 'ee1_lmuser', title: '修改人', width: 70 },
                { field: 'ee1_uptno', title: '修改次数', width: 70 }
			]], 
			rownumbers:true,
			singleSelect:true,
			//onRowContextMenu:onRowContextMenu,
			onDblClickRow :function(){  
			},
			onClickRow :function(rowIndex){   
				$(m_DatagridID).datagrid('endEdit', m_LastIndex); 
				$(m_DatagridID).datagrid('selectRow', rowIndex);
				$(m_DatagridID).datagrid('beginEdit', rowIndex); 
				m_LastIndex = rowIndex; 	
			}, 
			toolbar:'#xxcxk' 
		});  
	 
	 	//设置查询分页控件  
		//pager.pagination("options")
		//对象如下：total | pageSize | pageNumber | pageList | loading | buttons | showPageList | showRefresh | onSelectPage 
		//| onBeforeRefresh | onRefresh | onChangePageSize | beforePageText | afterPageText | displayMsg | 
		 
	 	$('#cxpager').pagination({  
	 		   total:0,
	 		   pageNumber:1,
	 		   pageSize: m_PageSize,//每页显示的记录条数  
	 	       pageList: [20,50,100,200],//可以设置每页记录条数的列表  
	 	       showPageList: false, //不显示每页记录数列表
	 	       beforePageText: '第',//页数文本框前显示的汉字  
	 	       afterPageText: '页    共 {pages} 页',  
	 	       displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',
	 	       exportExcel: false,
	 	       onBeforeRefresh: function () {
	 	       },
	 	       onSelectPage:function(pageNumber,pageSize){   
	 		        actLoadData(pageNumber,pageSize); 
	 	       },
	 	       buttons:[{
	 	 			text:'添加',
	 	 			iconCls:'icon-add',
	 	 			handler:function(){  
	 	 				$(m_DatagridID).datagrid('endEdit', m_LastIndex); 
	 	 				var row = $(m_DatagridID).datagrid('getSelected'); 
	 					if(row){
	 						var checkInfo = rowCheck(row);
	 						if((checkInfo!=undefined) && (checkInfo != '')){
	 							$(m_DatagridID).datagrid('beginEdit', m_LastIndex);
	 							alert('当前行的'+checkInfo);					
	 							return false;
	 						}  
	 					}		
	 	 				$(m_DatagridID).datagrid('insertRow',{
	 	 					index:0,
	 	 					row: { 
	 	 					    ee1_id: dataUtil_NewGuid(),
	 	 					    ee1_rguser: m_UserInfo.UserName,
	 	 					    ee1_state: '启用'
	 	 					}
	 	 				});
	 	 				m_LastIndex = 0; 
	 	 				$(m_DatagridID).datagrid('selectRow', m_LastIndex);
	 	 				$(m_DatagridID).datagrid('beginEdit', m_LastIndex);  
	 	 			}
	 	 		},'-',{
	 	 			text:'保存',
	 	 			iconCls:'icon-save',
	 	 			handler:function(){ 	    
	 	 				  actsave() ;
	 	 			} 
	 	 		},'-',{
	 	 			text:'关联部门',
	 	 			iconCls:'icon-houselink',
	 	 			handler:function(){ 	    
	 	 				actDeptLike();
	 	 			} 
	 	 		}] 
	 	   }); 
	 	// 初始化查询
	 	searchByCons();
	    setPerLikeDeptgrid(); 
 }); 
 
 
 /***********************************************************************
  *  查询按钮事件 ：根据条件查询
  *  DLY 
  */ 
 function   actLoadData(page,number)   {   
    var totalCount = 0;
    $(m_DatagridID).datagrid('loadData', []);
 	var cXML = '<Page>' + page + '</Page><Num>' + number + '</Num>'
            + '<Cons>' + m_Filter + m_Filter1 + '</Cons><OrderBy>' + m_OrderBy + '</OrderBy>';
 	cXML = basedata_addROOT(cXML);
 	var curl = GetWSRRURL(peoa_GetWSRRURL(4)) + "&type=GetEmpsByCons&XML=" + encodeURIComponent(cXML); //拼接url
     //alert(cXML);	
 	$.ajax({
 	    url: curl,
 	    type: "GET",
 	    async: false, 
 	    dataType: "json",
 	    success: function (data) {
 	        //alert(jsonUtil_jsonToStr(data));
 	        if (data && data.rows) {
 	            if (dataUtil_undefinedOrNull(data.total, 0) == 0) {
 	                $(m_DatagridID).datagrid('loadData', []);
 	                totalCount = 0;
 	            } else { 
 	                totalCount = dataUtil_undefinedOrNull(data.total, 0);
 	                $(m_DatagridID).datagrid('loadData', data.rows);
 	                $(m_DatagridID).datagrid('clearSelections');
 	            }
 	        } 
 	    }
 	}) 
 	
 	$('#cxpager').pagination({
 		total:totalCount,
 		pageNumber:page
 	});  

	m_PageNumber = page;
	m_PageSize = number;
 } 

 
 /***********************************************************************
  *  清除按钮事件  
  *  DLY
  *  2014-03-03
  */ 
function clearText(){ 
	$('#cxempCode').attr('value','');  
	$('#cxempName').attr('value','');  
	$('#cxempPost').attr('value','');   
	$('#cxstatus').combobox('setValue','');
}
 

/***********************************************************************
 *  获取条件查询
 *  DLY 
 */ 
function searchByCons() {
    m_PageNumber = 1;
	var filter1 = '';
	if($('#cxempCode').attr('value')!=''){
		filter1 = filter1 + ' AND ee1_empCode like \'%'+$('#cxempCode').attr('value')+'%\'';
	}  
	if($('#cxempName').attr('value')!=''){
	    filter1 = filter1 + ' AND ( ee1_empName like \'%' + $('#cxempName').attr('value') + '%\'';
	    filter1 = filter1 + ' OR ee1_empNameCH like \'%' + $('#cxempName').attr('value') + '%\')';
	} 
	if($('#cxempPost').attr('value')!=''){
	    filter1 = filter1 + ' AND ee1_empPost like \'%' + $('#cxempPost').attr('value') + '%\'';
	} 
	if($('#cxstatus').combobox('getValue')!=''){
	    filter1 = filter1 + ' AND ee1_state = \'' + $('#cxstatus').combobox('getValue') + '\'';
	}
	m_Filter1 = filter1;
    //alert(m_Filter1);
	actLoadData(m_PageNumber, m_PageSize);
} 
 

 /***********************************************************************
  *  保存
  *  DLY
  *  2014-03-03
  */ 
function actsave() {
    var flag = false;
	$(m_DatagridID).datagrid('endEdit', m_LastIndex); //结束最后编辑行的编辑状态
	//保存前校验
	var rows = $(m_DatagridID).datagrid('getRows'); 
	for(var i=0; i<rows.length; i++){ 
		var j=i+1;
		var checkInfo = rowCheck(rows[i]);
		if((checkInfo!=undefined) && (checkInfo != '')){
			$(m_DatagridID).datagrid('selectRow', i);
			$(m_DatagridID).datagrid('beginEdit', i);
			m_LastIndex = i;
			alert('第'+j+'行的'+checkInfo);	
			return false;
		} 
	} 
	
	if ($(m_DatagridID).datagrid('getChanges').length) {   		    
		   var inserted = $(m_DatagridID).datagrid('getChanges',"inserted");  
		   var updated = $(m_DatagridID).datagrid('getChanges', "updated");
		   for (var i = 0; i < inserted.length; i++) {  
	       }
		   for (var i = 0; i < updated.length; i++) { 
		       updated[i].ee1_lmdt = dateUtil_dateFomaterA(new Date(), '/')
		       updated[i].ee1_lmuser = m_UserInfo.UserName;
		       updated[i].ee1_uptno = updated[i].ee1_uptno * 1 + 1;
		   }
		   cXML1 = GetEditJson(inserted, updated, []);//json转xml 不做新增和删除 
		   var cxmlsJson = { XML: cXML1 };
		   var curl = GetWSRRURL(peoa_GetWSRRURL(4)) + "&type=Save"
               + "&s=" + new Date().getTime();; //拼接url 
		   $.ajax({
		       url: curl,
		       type: "POST",
		       async: false,
		       data: cxmlsJson, 
		       dataType: "json",
		       success: function (data) {
		           //alert(jsonUtil_jsonToStr(data)); 
		           if (data && data.rows) {
		               if (data.rows[0].result.toUpperCase() == 'TRUE') {
		                   actLoadData(m_PageNumber, m_PageSize); 
		                   flag = true;
		               }
		           }
		       }
		   })
		   if (flag) {
		       alert('保存成功！');
		   } else {
		       alert('保存失败！');
		   }
		   return flag;
	} 
} 
 
 

/***********************************************************************
 *  行必填信息校验   
 *  DLY
 *  2014-03-03
 */  
function rowCheck(row)   
{  
	 var errorInfo = ''; 
	 if(row.ee1_empCode == '' ){ 
			errorInfo = '“职员编码”必填';
			return errorInfo;
	 } 
	 if (row.ee1_empName == '') {
			errorInfo = '“职员名称”必填';
			return errorInfo;
	 } 
	 if (row.ee1_status == '') {
			errorInfo = '“状态”必填';
			return errorInfo;
	 }   
	 return errorInfo; 
}  


/***********************************************************************
 *  添加右击菜单内容
 *  DLY
 *  2013-08-12
 */ 
function onRowContextMenu(e, rowIndex, rowData){
    e.preventDefault();  
    $('#mm').menu('show', {
        left:e.pageX,
        top:e.pageY
    });  
} 


/***********************************************************************
 *  关联部门
 *  DLY 
 */ 
function actDeptLike() {
    $('#deptID').combotree('setValue', '');
	var rowData = $(m_DatagridID).datagrid('getSelected'); 
	if(!rowData){
		alert('请先选中记录！');
		return;
	}
	if (dataUtil_undefinedOrNull(rowData.ee1_empcode) == '') {
		alert('职员编码为空，不可关联操作！');
		return;
	}   
	document.getElementById('perInfoSpan').innerText = '职员： ' + rowData.ee1_empname
		+' — '+rowData.ee1_empcode;  
	$('#perLinkDeptdig').dialog('open'); 
	var filter = ' AND A.EO1_EE1_EmpCode = \'' + rowData.ee1_empcode + '\''
	var cXML = '<Page>' + '1' + '</Page><Num>' + '200' + '</Num>'
            + '<Cons>' + filter + '</Cons><OrderBy> OZ1_OrgName </OrderBy>';
    //alert(cXML);
	cXML = basedata_addROOT(cXML);
	var curl = GetWSRRURL(peoa_GetWSRRURL(4)) + "&type=GetEpmLinkDepts&XML=" + encodeURIComponent(cXML); //拼接url
	$.ajax({
	    url: curl,
	    type: "GET",
	    async: false,
	    dataType: "json",
	    success: function (data) {
	        //alert(jsonUtil_jsonToStr(data));
	        if (data && data.rows) {
	            if (dataUtil_undefinedOrNull(data.total, 0) == 0) {
	                $('#ryglbmlb').datagrid('loadData', []);
	            } else { 
	                $('#ryglbmlb').datagrid('loadData', data.rows);
	            }
	        } 
	    }
	})

	  
}

/***********************************************************************
 *  关联部门列表设置
 *  DLY 
 */ 
function setPerLikeDeptgrid(){  
	$('#ryglbmlb').datagrid({
			title:'已关联部门列表', 
			width:270, 
			height:135,
			nowrap: true,
			striped: true,
			collapsible:true, 
			//sortName: 'oz1_orgname',
			//sortOrder: 'asc',
			remoteSort: false,
			idField: 'eo1_id',
			pageSize:30,
			frozenColumns:[[        
			]],
			columns:[[ 	        
		        { field: 'eo1_id', title: 'fid', width: 88, hidden: true },
		        { field: 'oz1_orgcode', title: '部门编码', width: 75, sortable: true },
		        { field: 'oz1_orgname', title: '部门名称', width: 115, sortable: true },
		        { field: 'eo1_state', title: '状态', width: 40, sortable: true }
			]], 
			rownumbers:true,
			singleSelect:true, 
			onDblClickRow :function(){  
			},
			onClickRow :function(rowIndex){    
				$('#ryglbmlb').datagrid('selectRow', rowIndex); 
				m_LastIndex1 = rowIndex; 	
			} 
	});   
	
    //组织架构级联树  
	var m_depttree = []; 

	//部门 下拉框设置
	$('#deptID').combotree({
		panelWidth:"260",
		panelHeight:"260",   
		animate:true,
		onlyLeafCheck:true,
		editable:false,
		idField:'id',
		textField: 'text',
		data: m_depttree,
	 	onSelect:function(data){  	  
	    },
	 	onShowPanel: function (rowIndex) {
	 	    if (m_depttree.length == 0) {
	 	        var cXML = '<Page>0</Page><Num>0</Num>'
                   + '<Cons></Cons><OrderBy></OrderBy>'
	 	        cXML = basedata_addROOT(cXML);
	 	        //alert(cXML);	
	 	        var curl = GetTreeWSRRURL(peoa_GetWSRRURL(11), undefined, '1', "1")
                        + "&MenuCodeContains=0&type=GetORGTree&XML=" + encodeURIComponent(cXML)
                        + "&s=" + new Date().getTime();  //拼接url   
	 	        $.ajax({
	 	            url: curl,
	 	            options: "JSON",
	 	            async: false,
	 	            success: function (data) {
	 	                var data1 = eval('(' + data + ')');
	 	                m_depttree = data1; 
	 	                $('#deptID').combotree('loadData', m_depttree);
	 	                $('#deptID').combotree('tree').tree('collapseAll');
	 	            }
	 	        });
	 	    }
		}
	});

    
    
}

 
/***********************************************************************
 *  添加或删除关联部门
 *  DLY 
 */ 
function addORdelete(type){ 
    var flag = 'f';
    var rowData = $(m_DatagridID).datagrid('getSelected');
    if (!rowData) {
        alert('请先选中记录！');
        return;
    }
    if (dataUtil_undefinedOrNull(rowData.ee1_empcode) == '') {
        alert('职员编码为空，不可关联操作！');
        return;
    }
	if(type=='add'){
	    if (dataUtil_undefinedOrNull($('#deptID').combotree('getValue')) == '') {
			alert('请先选择部门！');
			return;
		} 
		var obj = new Object();
		obj.eo1_id = dataUtil_NewGuid();
		obj.eo1_ee1_empcode = rowData.ee1_empcode;
		obj.eo1_state = '启用'; 
		obj.eo1_begindt = '2014-01-01';
		obj.eo1_enddt = '2024-01-01';
		obj.eo1_rguser = m_UserInfo.UserName;
		obj.eo1_oz1_orgcode = $('#deptID').combotree('getValue');
		var inserted = [];
		inserted.push(obj);
		cXML1 = GetEditJson(inserted, [], []);//json转xml 删除 
		var cxmlsJson = { XML: cXML1 };
		var curl = GetWSRRURL(peoa_GetWSRRURL(4)) + "&type=SaveRowLinks"
            + "&s=" + new Date().getTime();; //拼接url 
		$.ajax({
		    url: curl,
		    type: "POST",
		    async: false,
		    data: cxmlsJson,
		    dataType: "json",
		    success: function (data) {
		        //alert(jsonUtil_jsonToStr(data)); 
		        if (data && data.rows) {
		            if (data.rows[0].result.toUpperCase() == 'TRUE') {
		                actDeptLike();
		                alert('添加关联成功！');
		            } else {
		                alert('添加关联失败！');
		            }
		        }
		    }
		});
	}else if (type=='del'){ 
		var rowData1 = $('#ryglbmlb').datagrid('getSelected'); 
		if (dataUtil_undefinedOrNull(rowData1) == '') {
			alert('请先选择需删除的已关联部门记录！');
			return;
		}  
		if (dataUtil_undefinedOrNull(rowData1.eo1_id) == '') {
		    alert('已关联部门记录eo1_id无效，请于管理员联系！');
			return;
		}
		if(!confirm('确认删除关联部门“'+rowData1.oz1_orgname+'”吗？')){ 
			return;
		}
		var deleted = [];
		var delrow = {};
		delrow.eo1_id = rowData1.eo1_id;
		deleted.push(delrow);
		cXML1 = GetEditJson([], [], deleted);//json转xml 删除 
		var cxmlsJson = { XML: cXML1 };
		var curl = GetWSRRURL(peoa_GetWSRRURL(4)) + "&type=SaveRowLinks"
            + "&s=" + new Date().getTime();; //拼接url 
		$.ajax({
		    url: curl,
		    type: "POST",
		    async: false,
		    data: cxmlsJson,
		    dataType: "json",
		    success: function (data) {
		        //alert(jsonUtil_jsonToStr(data)); 
		        if (data && data.rows) {
		            if (data.rows[0].result.toUpperCase() == 'TRUE') {
		                actDeptLike();
		                alert('删除关联成功！');
		            } else {
		                alert('删除关联失败！');
		            }
		        }
		    }
		});
	}else if (type=='upd'){ 
		var rowData1 = $('#ryglbmlb').datagrid('getSelected'); 
		if (dataUtil_undefinedOrNull(rowData1) == '') {
			alert('请先选择需修改的已关联部门记录！');
			return;
		}  
		if (dataUtil_undefinedOrNull(rowData1.linkid) == '') {
		    alert('已关联部门记录eo1_id无效，请于管理员联系！');
			return;
		}
		if (!confirm('确认修改关联“' + rowData1.oz1_orgname + '”的状态吗？')) {
			return;
		}
		var updated = [];
		var updrow = {};
		updrow.eo1_id = rowData1.eo1_id;
		if (rowData1.eo1_state == '启用') {
		    updrow.eo1_state = '禁用'
		} else {
		    updrow.eo1_state = '启用'
		}
		updated.push(updrow);
		cXML1 = GetEditJson([], updated, []);//json转xml 删除 
		var cxmlsJson = { XML: cXML1 };
		var curl = GetWSRRURL(peoa_GetWSRRURL(4)) + "&type=SaveRowLinks"
            + "&s=" + new Date().getTime();; //拼接url 
		$.ajax({
		    url: curl,
		    type: "POST",
		    async: false,
		    data: cxmlsJson,
		    dataType: "json",
		    success: function (data) {
		        //alert(jsonUtil_jsonToStr(data)); 
		        if (data && data.rows) {
		            if (data.rows[0].result.toUpperCase() == 'TRUE') {
		                actDeptLike();
		                alert('修改状态成功！');
		            } else {
		                alert('修改状态失败！');
		            }
		        }
		    }
		});
	} 
	
}


 
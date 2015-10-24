$(function(){
	
	$('#shsj').datebox({
        formatter: function(date){  
			 return  dateUtil_dateFomaterB(date,'-'); 
		  }
        	// function(date){ return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate(); }
       /* parser: function(date){ return new Date(Date.parse(date.replace(/-/g,"/"))); }*/
        });  
	
	$('#grid').datagrid({
		//iconCls:'icon-save',
		pageSize : 1,
		width:805,
	 	height:400,
		singleSelect:true,
		nowrap: true,
		autoRowHeight: false,
		striped: true,
		collapsible:true,
		loadMsg:'正在努力查找数据……',
		//url:'/gclm/web/maintainregister!execute',
		url:'/gclm/rest/logistics/page',
		queryParams:{},
		method:'post',
		toolbar:[{     
			text:'导出Excel',     
			iconCls:'icon-excel',     
			handler:function(){      
				$('#excelbtn').click();
				//exportExcel();
			} 
		}],
		columns: [[
	    			{field:'ydh',title:'快递单号',width:120,sortable:true},
	    			 {field:'wlgs',title:'快递公司',width:120,sortable:true},
	    			{field:'fhdp',title:'发货店铺',width:180,sortable:true},
	    			{field:'js',title:'件数',width:40,sortable:true},
	    			{field:'fhsj',title:'发货时间',width:120,sortable:true},
	    			{field:'shsj',title:'收货时间',width:120,sortable:true},
	    			{field:'zt',title:'状态',width:80,sortable:true}
	    			
	    		]],
		pagination:true,
		rownumbers:true
	});
	
	
	
	var p = $('#grid').datagrid('getPager');
	$(p).pagination( {
		pageSize : 10,//每页显示的记录条数，默认为10  
		pageList : [ 10, 20, 50,200 ],//可以设置每页记录条数的列表  
		beforePageText : '第',//页数文本框前显示的汉字  
		afterPageText : '页    共 {pages} 页',
		displayMsg : '当前显示 {from} - {to} 条记录   共 {total} 条记录',
		onBeforeRefresh : function() {
			$('#operateRecordGrid').datagrid('reload');
		}
	});
	
});



function exportExcel(){
	var ydh = $('#ydh').attr('value');
  	var wlgs = $('#wlgs').attr('value');
  	var fhdp = $('#fhdp').attr('value');
  	var shsj = $('#shsj').datebox('getValue');
  	var zt = $('#zt').attr('value');
  	var query={'ydh':ydh,'wlgs':wlgs,'fhdp':fhdp,'shsj':shsj,'zt':zt}; //把查询条件拼接成JSON
  	$.post(	'/gclm/rest/logistics/getExcelList',
  			query,function(queryfilter) {
				
				
			}, 'text').error(function() {
			$.messager.alert("提示", "信息获取失败");});	      
}

var m_finJson = null;

$(document).ready(function(){
	//初始化插件
	initPlugins();
});

function initPlugins(){

	//查询
	initSearch();
	//按钮
	initLinkBtn();
	//窗口
	initWin();
	//下拉日期
	initComboboxDatebox();
	//快递单
	initTextBox();
	//列表
	var url = GetWSRRURL('3a9cf88e-fc42-485d-9dff-96c35a8a1750')
		+ "&XML=" + GetGetJson([], 'getWXList');
	initDataGrid(url);
}

function initSearch(){
    $("#search").textbox({
		width:400,
		prompt:'请输入：维修单号或店铺名称',
		type:'text',
		buttonIcon:'icon-search',
		buttonText:'搜索',
		onClickButton:function(){search()}
    }).textbox('setValue',"");

    // when press ENTER key, accept the inputed value.
	$("#search").textbox('textbox')
		.bind('keydown', function(e){
			if (e.keyCode == 13){ 
			    search();
			};
	});
}

function initTextBox(){
	$("#expNo").textbox({
		width:'150',
		required:true,
		type:'text'
	});
}

function initWin(){
	$("#finishWin").window({
		title:'维修完成确认',
		width:350,
    	height:400,
    	modal:true,
    	collapsible:false,
    	minimizable:false,
    	maximizable:false,
    	closable:false,
    	shadow:true,
    	closed:true,
    	draggable:false
	});

	$("#expressWin").window({
		title:'寄回门店',
		width:350,
    	height:400,
    	modal:true,
    	collapsible:false,
    	minimizable:false,
    	maximizable:false,
    	closable:false,
    	shadow:true,
    	closed:true,
    	draggable:false
	});
}

function initDataGrid(url){
	$("#tab_list").datagrid({
		url:url,
        singleSelect: true,
        selectOnCheck: false,
        checkOnSelect: true,
        height:700,
        fit:false,
        striped:true,
        columns: [[
        	{ field: 'ck',checkbox:true},
            { field: 'wxno', title: '维修单号', width: 100 },
            { field: 'wxstname', title: '维修单类型', width: 70 },
            { field: 'sku', title: '维修款号', width: 100 },
            { field: 'statusname', title: '维修单状态', width: 75 },
			{ field: 'drname', title: '处理结果', width: 70 },
			{ field: 'question', title: '问题描述', width: 300 },
            { field: 'backdate', title: '退回日期', width: 100 },
            { field: 'respname', title: '店长姓名', width: 70 },
            { field: 'respphone', title: '店长电话', width: 100 },
            { field: 'staffname', title: '受理导购', width: 70 },
            { field: 'staffphone', title: '导购电话', width: 100 },
        ]],
        onClickRow:function(index,row){
        	//control button is enable or disable.
        	var rowStatus = row.status;
        	var rowRst = row.deciderst;
        	checkStatusAndRst(rowStatus,rowRst,index);

        },
        onDblClickRow:function(index,row){
        	// open tabs to fix detail info.
        	var wxno = row.wxno;
        	linkNewPage(wxno,"info");
        },
        onCheck:function(index,row){
        	//check row result and status.
        	var rowStatus = row.status;
        	var rowRst = row.deciderst;
        	checkStatusAndRst(rowStatus,rowRst,index);
        },
        pagination: true, //是否开启分页
        pageNumber: 1, //默认索引页
        pageSize: 20, //默认一页数据条数
	});
}

function initLinkBtn(){

	$("#again").linkbutton({
		iconCls:'icon-edit',
		plain:true,
		onClick:function(){
			var data = $("#tab_list").datagrid('getSelected');
			if(data != null)
			{
				linkNewPage(data.wxno,"again");
			};
		}
	});
	$("#accomplish").linkbutton({
		iconCls:'icon-ok',
		plain:true,
		onClick:function(){
			var rowdata 
				= $("#tab_list").datagrid('getSelected');
			if (rowdata != null){
				$("#finishWin").panel('open');
			}
			else{
				$.messager.alert('warning','请选择一行数据.','warning');
			}
			
		}
	});             
    $("#back").linkbutton({
    	iconCls:'icon-undo',
		plain:true,
		onClick:function(){
			sendDeport();
		}
    });

    $("#finSave").linkbutton({
    	iconCls:'icon-save',
		plain:true,
		onClick:function(){
			saveFinRst();
		}
    });
    $("#finClose").linkbutton({
    	iconCls:'icon-undo',
		plain:true,
		onClick:function(){
			closeWin();
		}
    });

    $("#submitExp").linkbutton({
    	iconCls:'icon-save',
		plain:true,
		text:'保存',
		onClick:function(){
		    submitExp();
		}
    })

    $("#closeExpWin").linkbutton({
    	iconCls:'icon-undo',
		plain:true,
		text:'关闭',
		onClick:function(){
			closeExp();
		}
    });
}

function initComboboxDatebox(){

	var url = GetWSRRURL('3a9cf88e-fc42-485d-9dff-96c35a8a1750')
        + "&XML=" + GetFormJson([], 'getFinInfo') + "&MultiTable=true";
     $.post(url, function (data) {
      	
	      	var json = eval ("("+data+")");
			
			m_finJson = json;

			if(m_finJson != null && m_finJson.length == 4){
	    	//是否完成
			$("#isFinish").combobox({
				width:150,
				data: m_finJson[0].rows,
		        valueField: 'value',
		        textField:'name',
		        editable:false,
		        panelHeight:"auto",
			}).combobox('setValue', m_finJson[0].rows[1].value);
			//维修人
			$("#FinishMan").combobox({
				width:150,
				data: m_finJson[1].rows,
				required:true,
				editable:false,
		        valueField: 'value',
		        textField:'name',
		        panelHeight:"220",
			});
			//最终维修点
			$("#FinishPoint").combobox({
				width:150,
				data: m_finJson[2].rows,
				required:true,
				editable:false,
		        valueField: 'point',
		        textField:'pointname',
		        panelHeight:"220",
		        onSelect:function(record){
		        	for(var i=0;i<m_finJson[2].rows.length;i++){
		        		if(record.point == m_finJson[2].rows[i].point){
		        			$("#money").empty()
		        				.append(m_finJson[2].rows[i].moneyname);
		        			break;
		        		};
		        	};
		        }
			});
			$("#expName").combobox({
				width:150,
				data: m_finJson[3].rows,
				required:true,
				editable:false,
			 	valueField: 'value',
		        textField:'name',
		        panelHeight:"220",
			});
    	};

	});
	$("#FinDate").datebox({
		editable:false,
		required:true,
		width:150,
		formatter: function(date){ return formatter(date);},
    	parser: function(s){ return parser(s);}
	});
}

function search(){
	
	var wxno = $("#search").textbox('getValue');

	var url = GetWSRRURL('3a9cf88e-fc42-485d-9dff-96c35a8a1750');
	if(wxno.length == 0){
		url += "&XML=" + GetGetJson([], 'getWXList');
	}
	else{
		var isNum = isNaN(wxno);
		if(isNum){
			wxno = escape(wxno);
			url += "&XML=" + GetFormJson([{"name":"txtDepotName","value":wxno}], 'getWXList');
		}
		else{
			url += "&XML=" + GetFormJson([{"name":"txtWxno","value":wxno}], 'getWXList');
		};
		
	};

    initDataGrid(url);
}

function checkStatusAndRst(rowStatus,rowRst,rowindex){
	if(rowStatus == 60){
		$("#again").linkbutton('disable');
		$("#accomplish").linkbutton('disable');
		$("#tab_list").datagrid('uncheckRow',rowindex);
	}
	else if(rowStatus >= 45){
		$("#again").linkbutton('enable');
		$("#accomplish").linkbutton('disable');
		$("#tab_list").datagrid('uncheckRow',rowindex);
	}
	else if(rowStatus >= 40){
		$("#again").linkbutton('enable');
		$("#accomplish").linkbutton('disable');
	}
	else if(rowStatus <= 25){
		$("#tab_list").datagrid('uncheckRow',rowindex);
		$("#accomplish").linkbutton('enable');
		$("#again").linkbutton('enable');
	}
	else{
		$("#again").linkbutton('enable');
		$("#accomplish").linkbutton('enable');
	};

	if(rowRst =="rst0"){
		$("#tab_list").datagrid('uncheckRow',rowindex);
	};
}

function linkNewPage(wxno,type){
	if(type == "info"){
		var url = "../../WEB/SPWX/SPWX_WXDetailInfo.html?wxno="+wxno;

		var content = "<iframe id=\"newWx\" scrolling=\"auto\" frameborder=\"0\" src=\""+url+"\"";
		content += " style=\"width:100%;height:95%\"></iframe>";

		window.parent.$("#mainTabs").tabs('add',{
       	title: '维修单明细信息',
        content: content,
        iconCls: 'icon-search',
        closable: true
    	});
	}
	else if(type == "again"){
		var url = "../../WEB/SPWX/SPWX_WXAgain.html?wxno="+wxno;
		var content = "<iframe id=\"newAgain\" scrolling=\"auto\" frameborder=\"0\" src=\""+url+"\"";
		content += " style=\"width:100%;height:95%\"></iframe>";

		window.parent.$("#mainTabs").tabs('add',{
       	title: '维修单再判定',
        content: content,
        iconCls: 'icon-edit',
        closable: true
    	});
	};
}

function closeWin(){
	$("#isFinish").combobox('setValue', m_finJson[0].rows[1].value);
	$("#FinishMan").combobox('setValue','');
	$("#FinishPoint").combobox('setValue','');
	$("#FinDate").datebox('setValue','');
	$("#money").empty();

	$("#finishWin").window('close');
}

function saveFinRst(){

	var isValid = $("#finForm").form('validate');
		if(!isValid){
			return;
		};

	var data = $("#finForm").serializeArray();

	data.push(
        { "name": "txtFinishMoney", "value": $("#money").text() }
        );
	data.push(
		{ "name": "txtWxno", "value":$("#tab_list").datagrid('getSelected').wxno }
		);

	var url = GetWSRRURL('3a9cf88e-fc42-485d-9dff-96c35a8a1750')
		+ "&XML=" + escape(GetFormJson(data, 'saveFin'));
	
	$.messager.confirm('提示框', '确认提交吗？', function (r) {
		if(r){
			$.messager.progress({ title: '请稍后', msg: '提交中' });
			$.post(url,function(data){
			    $.messager.progress('close');
			    var rst = eval("(" + data + ")");

			    if (rst.rows[0].result == "False") {
			        $.messager.alert("error", rst.rows[0].message, "error");
			        return;
			    }
			    else if (rst.rows[0].result == "True") {
			        $.messager.alert("ok", rst.rows[0].message, "ok");
					$("tab_list").datagrid('reload');
					closeWin();
			    };
			});
		};
	});
}

function formatter(date){
	var y = date.getFullYear();
	var m = date.getMonth()+1;
	var d = date.getDate();
	return y+'-'+m+'-'+d;
}

function parser(s){
	var t = Date.parse(s);
	if (!isNaN(t)){
		return new Date(t);
	} else {
		return new Date();
	};
}

function sendDeport(){

	var data = $("#tab_list").datagrid('getChecked');

	//验证空
	if(data.length == 0){
		$.messager.alert('warning','请勾选需要寄往门店的维修单','warning');
		return;
	};
    //清洗维修单状态

    do{
    	var count = data.length -1;
    	var status = data[count].status;

		if(!(status == '40' || status == '26')){
			
			var index = $("#tab_list").datagrid('getRowIndex',data[count]);
			$("#tab_list").datagrid('uncheckRow',index);

			data.splice(count,1);
		};
		
    } while (count > 0);

    if (data.length == 0) {
        $.messager.alert('warning', '没有符合寄回条件的维修单', 'warning');
        return;
    };
	
	//判断店铺的唯一性
	var dpIDOld = data[0].depotid;
	for(var j=1;j<data.length;j++){
		var dpIDNew = data[j].depotid;
		if(dpIDOld != dpIDNew){
			$.messager.alert(
				"warning",
				"存在两个店铺("+data[0].depotname+","+data[j].depotname+"),建议用店铺搜索维修单。",
				"warning"
				);
			return;
		};
	};
	
	$("#expressWin").window('open');

	var wxnoText = "";

	for(var k=0;k<data.length;k++){
		if (k!=data.length-1){
			wxnoText += data[k].wxno + ", ";
		}
		else{
			wxnoText += data[k].wxno + " ";
		};
	};

	$("#wxno").empty().append(wxnoText);
	$("#deport").empty().append(data[0].depotname);
	

	var url = GetWSRRURL('3a9cf88e-fc42-485d-9dff-96c35a8a1750')
        + "&XML=" + GetFormJson([{"name":"txtDepotId","value":data[0].depotid}], 'getDepotInfo');

	$.messager.progress({ title: '请稍后', msg: '正在获取信息' });
    $.post(url, function (data) {
    	$.messager.progress('close');
    	var rst = eval("("+data+")");

        $("#address").empty().append(rst.rows[0].g_address);
       	$("#wxaddress").empty().append(rst.rows[0].j_wxaddress);
    });
}

function submitExp(){

	var expCom = $("#expName").combobox('getValue');
	var expNo = $("#expNo").textbox('getValue');

	if(expCom.length == 0 
		|| expNo.length == 0){

		$.messager.alert(
			"warning",
			"请将物流信息填写完成",
			"warning");
		return;
	};

	var data = $("#tab_list").datagrid('getChecked');
	//添加快递
	var submitData = [];
	

	for(var i=0;i<data.length;i++){
	    submitData.push(
	    	{"name":"Wxno","value":data[i].wxno});
	    submitData.push(
	    	{"name":"ExpName","value":expCom});
	    submitData.push(
			{"name":"ExpNo","value":expNo});
	};

	var url = GetWSRRURL("3a9cf88e-fc42-485d-9dff-96c35a8a1750")
			+ "&XML=" + GetFormArray(submitData, "saveExp","ExpNo");

	$.messager.confirm('提示框', '确认提交吗？', function (r) {
		if(r){
			$.messager.progress({ title: '请稍后', msg: '正在提交' });
			$.post(url,function(data){
				$.messager.progress('close');
				var rst = eval("(" + data + ")");
				if (rst.rows[0].result == "True") {
				    $.messager.alert("ok", rst.rows[0].message, "ok");
				    closeExp();
				    $("#tab_list").datagrid('reload');

				} else if (rst.rows[0].result == "False") {
				    $.messager.alert("error", rst.rows[0].message, "error");
				    return;
				}
			});
		}
	});
}

function closeExp(){
	$("#wxno").empty();
	$("#deport").empty()
	$("#address").empty()
	$("#wxaddress").empty()
	$("#expName").combobox('setValue','');
	$("#expNo").textbox('setValue','');
	$("#expressWin").window('close');
}

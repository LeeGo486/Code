
//控件ID
var m_TabsId = '#IPDRtabs';         //选项卡id
var m_DatagridId = '#Billlb';   //单据列表id

var m_LastIndex = -1;  //列表最后一次选中行下标
var m_PageNumber = 1;  //当前页码
var m_PageSize = 20;  //每页显示行数

 
//用户信息
var m_UserInfo = basedata_getUserInfo(); 
 
  
// 过滤条件
var m_Filter = '';  //主的条件
var m_Filter1 = ''; //查询条件
var m_OrderBy = '  fa3_rgdt DESC '; //排序方式


//打开详细页事件
var m_Act = 'none'; 
var m_Role = ''; //操作员身份
 
 

/***********************************************************************
 *  初始化
 *  DLY 
 */ 
$(function () {
    var cxml = ''; 
    // 当窗口大小发生变化时，调整DataGrid的大小
    $(window).resize(function () {
        //根据index.html页面的高度设置选项卡大小 
        $(m_TabsId).tabs('resize', {
            width: $(document.body).width(),
            height: getcurheight()
        });
        //根据index.html页面的高度设置列表高度 
        $(m_DatagridId).datagrid('resize', {
            width: $(document.body).width() * 0.997,
            height: getcurheight()
        });

    });

    //鉴定日期格式化及值变化控制
    $('#fa3_filldate').datebox({
        closeText: '关闭',
        editable: false,
        formatter: function (date) {
            return dateUtil_dateFomaterB(date, '-');
        },
        parser: function (s) {
            var t = Date.parse(s);
            if (!isNaN(t)) {
                return new Date(t);
            } else {
                return new Date();
            }
        },
        onChange: function (newValue, oldValue) {
            if (newValue != oldValue) {

            }
        }
    });

    //获取部门组织架构
    var orgs = [];
    var cXML = '<Page>0</Page><Num>0</Num>'
              + '<Cons></Cons><OrderBy></OrderBy>'
    cXML = basedata_addROOT(cXML);
    var curl = GetTreeWSRRURL(peoa_GetWSRRURL(11), undefined, "1", "1")
            + "&MenuCodeContains=0&type=GetORGTree&XML=" + encodeURIComponent(cXML)
            + "&s=" + new Date().getTime();  //拼接url   
    $.ajax({
        url: curl,
        options: "JSON",
        async: false,
        success: function (data) {
            var data1 = eval('(' + data + ')');
            orgs.push(data1[0]);
        }
    });

    //部门 下拉框设置
    $('#fa3_department').combotree({
        panelWidth: "205",
        panelHeight: "130",
        animate: true,
        onlyLeafCheck: true,
        editable: false,
        idField: 'id',
        textField: 'text',
        data: orgs,
        onSelect: function (data) {
            $('#fa3_cono').attr('value', data.attributes.OZ1_CONO);
            $('#fa3_divi').attr('value', data.attributes.OZ1_DIVI);
        },
        onShowPanel: function (rowIndex) {
        }
    });

    // 标签页选中
    $(m_TabsId).tabs({
        border: false,
        onSelect: function (title) {  
            if (title == '详细页') {
                if (m_Act == 'none') {
                    var selected = $(m_DatagridId).datagrid('getSelected');
                    if (selected) {
                        m_Act = 'upd'
                        turnToDetail(m_Act, selected);
                    } else {
                        $(m_TabsId).tabs('select', '列表页'); // 返回列表页  
                        $.messager.alert("提示", "请先选择一条记录！");
                    }
                }
            }
        }

    });


    //成本中心 下拉框设置
    $('#cxState').combobox({
        panelHeight: "100",
        editable: false,
        multiple: false,
        valueField: 'text',
        textField: 'text',
        data: [{ "text": "未提交" }, { "text": "已提交" }, { "text": "已审核" },{ "text": "全部" }]
    });

     
     
    //诊断报告列表
    $(m_DatagridId).datagrid({
		//title:'',
		//iconCls:'icon-save',
		//width:document.body.clientWidth*0.997,
        height: getcurheight(),
	    //url:'datagrid_data1.json',
		nowrap: true,
		striped: false,
		collapsible:true,
		//sortName: 'id',
		//sortOrder: 'desc',
		remoteSort: false,
		idField: 'fa3_id',
		singleSelect:true,
		frozenColumns:[[  
		]],
		columns:[[  		          
		    { field: 'fa3_id', title: 'fa3_id', width: 100, hidden: true }, 
	        { field: 'fa3_state', title: '状态', width: 70 },
	        { field: 'fa3_department', title: '部门', width: 100 },
	        { field: 'fa3_name', title: '姓名', width: 70 },
	        { field: 'fa3_deviceno', title: '设备型号', width: 160  },
	        { field: 'fa3_assetsno', title: '资产编码', width: 100 },
	        { field: 'fa3_filldate', title: '诊断日期', width: 100 }, 
	        { field: 'fa3_diagnosisdept', title: '诊断部门', width: 100  },
	        { field: 'fa3_diagnosispeople', title: '诊断人', width: 90 },
	        { field: 'fa3_audit', title: '审核人', width: 80 },
	        { field: 'fa3_auditdate', title: '审核日期', width: 90  },
		    { field: 'fa3_rgdt', title: '创建时间', width: 105},
		    { field: 'fa3_rguser', title: '创建人', width: 80},
	        { field: 'fa3_lmdt', title: '修改时间', width: 105  },
	        { field: 'fa3_lmuser', title: '修改人', width: 80 },
	        { field: 'fa3_uptno', title: '修改次数', width: 80 }
             
		]],
		pagination:false,
		rownumbers:true, 
		toolbar: '#tjcxk',  
		onDblClickRow :function(rowIndex, rowData){   
		    m_Act = 'upd';
		    var selected = $(m_DatagridId).datagrid('getSelected');
		    if (selected) {
		        $(m_TabsId).tabs('select', '详细页'); // 激活标签   
		        turnToDetail(m_Act, selected);
		    } else {
		        $.messager.alert("提示", "请先选择一条记录！");
		    }
		},
		onClickRow :function(rowIndex){    
		} 
	}); 
	
	//设置查询分页控件  
	//pager.pagination("options")
	//对象如下：total | pageSize | pageNumber | pageList | loading | buttons | showPageList | showRefresh | onSelectPage 
	//| onBeforeRefresh | onRefresh | onChangePageSize | beforePageText | afterPageText | displayMsg | 
	 
   $('#cxpager').pagination({  
	   total:0,
	   pageNumber:1,
	   pageSize: m_PageSize,//每页显示的记录条数，默认为20  
	   pageList: [20, 50, 100, 200, 1],//可以设置每页记录条数的列表  
       showPageList: true, //不显示每页记录数列表
       beforePageText: '第',//页数文本框前显示的汉字  
       afterPageText: '页    共 {pages} 页',  
       displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',
       exportExcel: false,
       onBeforeRefresh: function () {
       },
       onSelectPage: function (pageNumber, pageSize) { 
	        actLoadData(pageNumber,pageSize);
       },
       buttons: [{
                    text: '新建',
                    iconCls: 'icon-add',
                    handler: function () {
                        m_Act = 'add';
                        $(m_TabsId).tabs('select', '详细页'); // 激活标签   
                        turnToDetail(m_Act, null);
                    }
               }, '-', {
                   text: '编辑',
                   iconCls: 'icon-edit',
                   handler: function () { 
                       m_Act = 'upd';
                       var selected = $(m_DatagridId).datagrid('getSelected');
                       if (selected) {
                           $(m_TabsId).tabs('select', '详细页'); // 激活标签   
                           turnToDetail(m_Act, selected);
                       } else {
                           $.messager.alert("提示", "请先选择一条记录！");
                       }
                   }
           }]
    	   
   });   
   actLoadData(1, m_PageSize);
    //searchByCons() ;

    //锁定光标
   document.getElementById("cxDeptName").focus();

    //确认操作员
   for (var i = 0; i < m_UserInfo.roles.length; i++) {
       var authorization_id = m_UserInfo.roles[i].authorization_id;
       if (authorization_id == peoa_GetActorID(9)) {
           m_Role = 'A'
       } else if (authorization_id == peoa_GetActorID(10)) {
           m_Role = 'B';
           break;
       }
   }
    
});

  
/***********************************************************************
 *  打开明细页
 *  DLY
 *  2014-06-16
 */
function turnToDetail(act, row) {
    if (act == "add") {
        $('#fa3_id').attr('value', '');
        $('#fa3_cono').attr('value', '');
        $('#fa3_divi').attr('value', '');
        $('#fa3_rguser').attr('value', m_UserInfo.UserName);
        $('#fa3_uptno').attr('value', 0);
        $('#fa3_rgdt').attr('value', dateUtil_dateFomaterB(new Date(), '-'));
        $('#fa3_state').attr('value', '未提交');
        $('#fa3_department').combotree('setValue', '');
        $('#fa3_name').attr('value', '');
        $('#fa3_deviceno').attr('value', '');
        $('#fa3_assetsno').attr('value', ''); 
        $('#fa3_filldate').datebox('setValue', dateUtil_dateFomaterB(new Date(), '-'));//鉴定日期-当前日期
        $('#fa3_faultphenomenon').attr('value', '');
        $('#fa3_diagnosisresults').attr('value', '');
        $('#fa3_solution').attr('value', '');  
        $('#fa3_brandmodel1').attr('value', '');
        $('#fa3_num1').attr('value', '');
        $('#fa3_remarks1').attr('value', '');
        $('#fa3_brandmodel2').attr('value', '');
        $('#fa3_num2').attr('value', '');
        $('#fa3_remarks2').attr('value', '');
        $('#fa3_brandmodel3').attr('value', '');
        $('#fa3_num3').attr('value', '');
        $('#fa3_remarks3').attr('value', '');
        $('#fa3_diagnosisdept').attr('value', '');
        $('#fa3_diagnosispeople').attr('value', m_UserInfo.UserName);
        $('#fa3_audit').attr('value', '');
        $('#fa3_auditdate').attr('value', '');
        //状态控制
        stateContral($('#fa3_state').attr('value'));
    } else if (act == "upd") {
        $('#fa3_id').attr('value', row.fa3_id);
        $('#fa3_cono').attr('value', row.fa3_cono);
        $('#fa3_divi').attr('value', row.fa3_divi);
        $('#fa3_rguser').attr('value', row.fa3_rguser);
        $('#fa3_uptno').attr('value', row.fa3_uptno);
        $('#fa3_rgdt').attr('value', row.fa3_rgdt);
        $('#fa3_state').attr('value', row.fa3_state);
        $('#fa3_department').combotree('setValue', row.fa3_department);
        $('#fa3_name').attr('value', row.fa3_name);
        $('#fa3_deviceno').attr('value', row.fa3_deviceno);
        $('#fa3_assetsno').attr('value', row.fa3_assetsno);
        $('#fa3_filldate').datebox('setValue', row.fa3_filldate);//鉴定日期-当前日期
        $('#fa3_faultphenomenon').attr('value', decodeURIComponent(row.fa3_faultphenomenon));
        $('#fa3_diagnosisresults').attr('value', decodeURIComponent(row.fa3_diagnosisresults));
        $('#fa3_solution').attr('value', decodeURIComponent(row.fa3_solution));
        $('#fa3_brandmodel1').attr('value', row.fa3_brandmodel1);
        $('#fa3_num1').attr('value', row.fa3_num1);
        $('#fa3_remarks1').attr('value', row.fa3_remarks1);
        $('#fa3_brandmodel2').attr('value', row.fa3_brandmodel2);
        $('#fa3_num2').attr('value', row.fa3_num2);
        $('#fa3_remarks2').attr('value', row.fa3_remarks2);
        $('#fa3_brandmodel3').attr('value', row.fa3_brandmodel3);
        $('#fa3_num3').attr('value', row.fa3_num3);
        $('#fa3_remarks3').attr('value', row.fa3_remarks3);
        $('#fa3_diagnosisdept').attr('value', row.fa3_diagnosisdept);
        $('#fa3_diagnosispeople').attr('value', row.fa3_diagnosispeople);
        $('#fa3_audit').attr('value', row.fa3_audit);
        $('#fa3_auditdate').attr('value', row.fa3_auditdate);
        //状态控制
        stateContral($('#fa3_state').attr('value')); 
    }
    m_Act = 'none';
}


/***********************************************************************
 * 状态控制
 *  DLY 
 */
function stateContral(state) { 
    if (state == '已审核' || state == '已取消') { 
        //按钮控制
        $('#btnSave').hide();
        $('#btnTurn').hide();
        //字段只读控制 
        $("form input").prop("disabled", true);
        $("form textarea").prop("disabled", true); 
        $('#fa3_filldate').datebox('disable');
        $('#fa3_department').combotree('disable');
    } else {
        //按钮控制
        $('#btnSave').show();
        $('#btnTurn').show();
        if (state == '已提交') {
            $('#btnTurnSpan').text('审核');
        } else { 
            $('#btnTurnSpan').text('提交');
        } 
        //字段只读控制 
        $("form select").prop("disabled", false);
        $("form input").prop("disabled", false);
        $("form textarea").prop("disabled", false);
        $('#fa3_filldate').datebox('enable');
        $('#fa3_department').combotree('enable');
    } 
}



/***********************************************************************
 *  清除按钮事件：清除查询条件
 *  DLY
 *  2013-05-25
 */ 
function clearText() { 
    $('#cxDeptName').attr('value', '');
    $('#cxName').attr('value', '');
    $('#cxChecker').attr('value', '');
    $('#cxState').combobox('setValue', '');
    $('#cxDate').attr('value', ''); 
}


/***********************************************************************
 *  查询按钮事件：根据条件查询
 *  DLY
 *  2013-06-15
 */ 
function searchByCons()  { 
	m_PageNumber = 1; 
	var cfilter = ''
      
	var cxDeptName = dataUtil_trim($('#cxDeptName').attr('value'));
	var cxName = dataUtil_trim($('#cxName').attr('value'));
	var cxChecker = dataUtil_trim($('#cxChecker').attr('value'));
	var cxState = dataUtil_trim($('#cxState').combobox('getValue'));
	var cxDate = dataUtil_trim($('#cxDate').attr('value'));

	if (cxDeptName != '') {
	    cfilter = cfilter + ' AND FA3_Department LIKE \'%' + cxDeptName + '%\'';
	}
	if (cxName != '') {
	    cfilter = cfilter + ' AND FA3_Name LIKE \'%' + cxName + '%\'';
	}
	if (cxChecker != '') {
	    cfilter = cfilter + ' AND FA3_Audit LIKE \'%' + cxChecker + '%\'';
	}
	if (cxState != '' && cxState != '全部') {
	    cfilter = cfilter + ' AND FA3_State = \'' + cxState + '\'';
	}
	if (cxDate != '') {
	    cfilter = cfilter + ' AND  convert(varchar(10),FA3_FillDate,120) LIKE \'' + cxDate + '%\'';
	} 
	m_Filter1 = cfilter;
	//alert(m_Filter1);
	actLoadData(m_PageNumber, m_PageSize); 
}
 
 
/***********************************************************************
 *  刷新列表数据
 *  DLY
 *  2014-05-25
 */ 
function actLoadData(page, number) {
    
    var totalCount = 0;
    m_PageNumber = page;
    m_PageSize = number;
    var cXML = '<Page>' + m_PageNumber + '</Page><Num>' + m_PageSize + '</Num>'
             + '<Cons>' + m_Filter + m_Filter1 + '</Cons><OrderBy>' + m_OrderBy + '</OrderBy>'
    cXML = basedata_addROOT(cXML); 

    var curl = GetWSRRURL(peoa_GetWSRRURL(6)) + "&type=GetHs&XML="+ encodeURIComponent(cXML)
            + "&s=" + new Date().getTime();  //拼接url  

    //alert(cXML);	
	$.ajax({
	    url: curl,
	    type: "GET",
	    async: false,
	    //data: cxmlsJson,
	    dataType: "json",
	    success: function (result) {
	        try {
	            //alert(jsonUtil_jsonToStr(result));  
	            if (result.Error) {
	                $.messager.alert("系统错误", result.Error, 'error');
	            } else if (result.rows.length>0 && result.rows[0].result == "False") {
	                $.messager.alert("提示", result.rows[0].message, 'error');
	            } else { 
	                //回写单据信息
	                if (result.rows && result.rows.length > 0) {
	                    $(m_DatagridId).datagrid('loadData', result.rows);
	                    totalCount = result.total;
	                } else {
	                    $(m_DatagridId).datagrid('loadData', []);
	                } 
	                $(m_DatagridId).datagrid('clearSelections'); 
	            }
	        } catch (ex) {
	            $.messager.alert("提示", ex, 'error');
	        }
	    },
	    error: function () {
	        $.messager.alert("提示", "查询错误！", 'error');
	    }
	})
	$('#cxpager').pagination({
		total:totalCount,
		pageNumber:page
	});  
} 
 

/***********************************************************************
 *  保存
 *  DLY 
 */
function actSaveZ() {
    var flag = false;

    //保存校验  
    if (!saveCheck()) {
        return flag;
    }
    

    //保存操作
    var billInfo = eval('[{' + jsonUtil_form2json('#FA_IPDRForm') + '}]'); //获取单据主信息json  
    var curl = GetWSRRURL(peoa_GetWSRRURL(6));
    if ($('#fa3_id').attr('value') == '') {  //新增单据  
        billInfo[0].fa3_id = dataUtil_NewGuid();  //赋值ID    
        curl = curl + "&type=New&actor=" + m_UserInfo.UserName;
    } else {        //修改单据  
        billInfo[0].fa3_uptno = billInfo[0].fa3_uptno*1+1;  
        billInfo[0].fa3_lmuser = m_UserInfo.UserName;
        billInfo[0].fa3_lmdt = dateUtil_dateFomaterB(new Date(), '-');   
        curl = curl + "&type=Upd&actor=" + m_UserInfo.UserName; //拼接url 
    }
    var cXML = GetEditJson(billInfo, [], []); //json转xml  
    var cxmlsJson = { XML: cXML };
    $.ajax({
        url: curl,
        type: "POST",
        async: false,
        data: cxmlsJson,
        dataType: "json",
        success: function (result) {
            try {
                //alert(jsonUtil_jsonToStr(result));
                if (result.Error) {
                    $.messager.alert("系统错误", result.Error, 'error');
                } else if (result.rows[0].result == "False") {
                    $.messager.alert("提示", result.rows[0].message, 'error');
                } else if (result.rows[0].result == "True") {
                    //回写单据信息
                    $('#fa3_id').attr('value', billInfo[0].fa3_id);
                    flag = true;
                }
            } catch (ex) {
                $.messager.alert("提示", ex, 'error');
            }
        },
        error: function () {
            $.messager.alert("提示", "保存失败！", 'error');
        }
    })
    return flag;
}


/**
* 保存校验
* DLY 
*/
function saveCheck() {
    //保存中文部门名称
    $('#fa3_department').combotree('setValue', $('#fa3_department').combotree('getText'));
    //主信息部分校验
    if ($('#fa3_department').combotree('getValue') == '') {
        $.messager.alert('提示框', '部门名称必填!', "worning");
        return false;
    }
    if ($('#fa3_name').attr('value') == '') {
        $.messager.alert('提示框', '姓名必填!', "worning");
        return false;
    }
    if ($('#fa3_deviceno').attr('value') == '') {
        $.messager.alert('提示框', '设备型号必填!', 'worning');
        return false;
    }
    if ($('#fa3_filldate').datebox('getValue') == null || $('#fa3_filldate').datebox('getValue') == '') {
        $.messager.alert('提示框', '日期必填!', 'worning');
        return false;
    }
     
    return true;
}


/**
* 取消单据
* DLY 
*/
function actCancel() {
    //主信息部分校验
    if ($('#fa3_id').attr('value') == '') {
        $.messager.alert('提示框', '单据未保存，无需取消!', "worning");
        return false;
    }
    if ($('#fa3_state').attr('value') == '已取消') {
        $.messager.alert('提示框', '单据已取消，无需取消!', "worning");
        return false;
    }
    //取消操作 
    $.messager.confirm('确认框', '确认取消该报告单吗？', function (r) {
        if (r) {
            var curl = GetWSRRURL(peoa_GetWSRRURL(6)) + "&type=Upd&actor=" + m_UserInfo.UserName; //拼接url  
            var billInfo = eval('[{"fa3_id":"' + $('#fa3_id').attr('value') + '"}]'); //获取单据主信息json    
            billInfo[0].fa3_uptno = $('#fa3_uptno').attr('value') * 1 + 1;
            billInfo[0].fa3_lmuser = m_UserInfo.UserName;
            billInfo[0].fa3_lmdt = dateUtil_dateFomaterB(new Date(), '-');
            billInfo[0].fa3_state = '已取消';
            var cXML = GetEditJson(billInfo, [], []); //json转xml  
            var cxmlsJson = { XML: cXML };
            $.ajax({
                url: curl,
                type: "POST",
                async: false,
                data: cxmlsJson,
                dataType: "json",
                success: function (result) {
                    try {
                        //alert(jsonUtil_jsonToStr(result));
                        if (result.Error) {
                            $.messager.alert("系统错误", result.Error, 'error');
                        } else if (result.rows[0].result == "False") {
                            $.messager.alert("提示", result.rows[0].message, 'error');
                        } else if (result.rows[0].result == "True") {
                            //回写单据信息
                            $.messager.alert("提示", "取消成功！");
                            //状态控制
                            $('#fa3_state').attr('value', billInfo[0].fa3_state);
                            stateContral($('#fa3_state').attr('value')); 
                            actLoadData(m_PageNumber, m_PageSize);
                        }
                    } catch (ex) {
                        $.messager.alert("提示", ex, 'error');
                    }
                },
                error: function () {
                    $.messager.alert("提示", "取消失败！", 'error');
                }
            })
        }
    }); 
    
}


/**
* 提交/审核单据
* DLY 
*/
function actTurnTo() { 
    if ($('#fa3_state').attr('value') == '已提交') {
        if (m_Role != 'B') {
            alert('您没有审核权限！');
            return false;
        }
    }
    if (!actSaveZ) {
        return false;
    }
    //设置提交相关信息
    var billInfo = eval('[{"fa3_id":"' + $('#fa3_id').attr('value') + '"}]'); //获取单据主信息json    
    var info = '';
    var state = '';
    if ($('#fa3_state').attr('value') == '未提交') {
        billInfo[0].fa3_state = '已提交';
        info = '确认提交该报告单吗？';
    } else if ($('#fa3_state').attr('value') == '已提交') { 
        billInfo[0].fa3_state = '已审核';
        billInfo[0].fa3_audit = m_UserInfo.UserName;
        billInfo[0].fa3_auditdate = dateUtil_dateFomaterB(new Date(), '-');
        info = '确认审核该报告单吗？';
    } else {
        return false;
    }
   
    //执行操作 
    $.messager.confirm('确认框', info, function (r) {
        if (r) {
            var curl = GetWSRRURL(peoa_GetWSRRURL(6)) + "&type=Upd&actor=" + m_UserInfo.UserName; //拼接url  
            var cXML = GetEditJson(billInfo, [], []); //json转xml  
            var cxmlsJson = { XML: cXML };
            $.ajax({
                url: curl,
                type: "POST",
                async: false,
                data: cxmlsJson,
                dataType: "json",
                success: function (result) {
                    try {
                        //alert(jsonUtil_jsonToStr(result));
                        if (result.Error) {
                            $.messager.alert("系统错误", result.Error, 'error');
                        } else if (result.rows[0].result == "False") {
                            $.messager.alert("提示", result.rows[0].message, 'error');
                        } else if (result.rows[0].result == "True") {
                            //回写单据信息
                            $.messager.alert("提示", "操作成功！");
                            //状态控制
                            $('#fa3_state').attr('value', billInfo[0].fa3_state);
                            stateContral($('#fa3_state').attr('value'));
                            actLoadData(m_PageNumber, m_PageSize);
                        }
                    } catch (ex) {
                        $.messager.alert("提示", ex, 'error');
                    }
                },
                error: function () {
                    $.messager.alert("提示", "操作失败！", 'error');
                }
            })
        }
    });

}

/*******************
 * 调用打印页
 */
function print() {
    var fid = $("#fa3_id").attr("value");
    if (fid == null || fid == '' || fid == '（系统自动生成）') {
        $.messager.alert('提示', '保存成功后才能打印！');
        return;
    } 
    window.open("../../../WEB/PE_OA/FA/FA_IPDR_print.html?v0=" + fid);
}


/*******************
 * 获取列表高度
 */
function getcurheight() {
    var htjcxk = document.getElementById("tjcxk").style.height.replace('px', '');
    var curheight = parent.getTabsHeight() * 1 - htjcxk * 1 + 24;
    return curheight;
}

 

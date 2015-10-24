
//控件ID
var m_TabsId = '#CCAStabs';         //选项卡id
var m_DatagridId = '#Billlb';   //单据列表id

var m_LastIndex = -1;  //列表最后一次选中行下标
var m_PageNumber = 1;  //当前页码
var m_PageSize = 20;  //每页显示行数

 
//用户信息
var m_UserInfo = basedata_getUserInfo(); 
 
  
// 过滤条件
var m_Filter = '';  //主的条件
var m_Filter1 = ''; //查询条件
var m_OrderBy = '  fa4_rgdt DESC '; //排序方式


//打开详细页事件
var m_Act = 'none'; 
var m_Role = ''; //操作员身份


var m_DatagridId1 = '#BMlb';   //部门列表id
var deptdlgFlag = 0;    //首次打开选择窗标志
 

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
            width: $(document.body).width()*0.997,
            height: getcurheight()
        }); 
    });


    //鉴定日期格式化及值变化控制
    $('#fa4_filldate').datebox({
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

    // 标签页选中
    $(m_TabsId).tabs({  
        border: false,//边框 
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


    //状态 下拉框设置
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
        //width: document.body.clientWidth * 0.997,
        height: getcurheight(),
	    //url:'datagrid_data1.json',
		nowrap: true,
		striped: false,
		collapsible:true,
		//sortName: 'id',
		//sortOrder: 'desc',
		remoteSort: false,
		idField: 'fa4_id',
		singleSelect:true,
		frozenColumns:[[  
		]],
		columns:[[  		          
		    { field: 'fa4_id', title: 'fa4_id', width: 100, hidden: true }, 
	        { field: 'fa4_state', title: '状态', width: 70 },
	        { field: 'fa4_department', title: '部门名称', width: 100 },
	        { field: 'fa4_name', title: '使用人', width: 70 }, 
	        { field: 'fa4_notebook', title: '笔记本', width: 100 },  
	        { field: 'fa4_computer', title: '台式机', width: 100 },
	        { field: 'fa4_deviceno', title: '型号', width: 100 },
	        { field: 'fa4_cpu', title: 'CPU', width: 100 },
	        { field: 'fa4_mem', title: '内存', width: 80 },
	        { field: 'fa4_hd', title: '硬盘', width: 80 },
	        { field: 'fa4_buydate', title: '购买日期', width: 80 },
	        { field: 'fa4_diagnosispeople', title: '鉴定人', width: 70 },
	        { field: 'fa4_filldate', title: '鉴定日期', width: 80 },
	        { field: 'fa4_audit', title: '审核人', width: 70 },
	        { field: 'fa4_auditdate', title: '审核日期', width: 80  },
		    { field: 'fa4_rgdt', title: '创建时间', width: 105},
		    { field: 'fa4_rguser', title: '创建人', width: 80},
	        { field: 'fa4_lmdt', title: '修改时间', width: 105  },
	        { field: 'fa4_lmuser', title: '修改人', width: 80 },
	        { field: 'fa4_uptno', title: '修改次数', width: 80 } 
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
        $("form input").attr("value", "");
        $("form textarea").attr("value", "");
        $('#fa4_filldate').datebox('setValue', dateUtil_dateFomaterB(new Date(), '-'));//鉴定日期-当前日期 
        $('#fa4_department').attr('value', '');
        $('#fa4_id').attr('value', '');
        $('#fa4_cono').attr('value', '');
        $('#fa4_divi').attr('value', '');
        $('#fa4_rguser').attr('value', m_UserInfo.UserName);
        $('#fa4_uptno').attr('value', 0);
        $('#fa4_rgdt').attr('value', dateUtil_dateFomaterB(new Date(), '-'));
        $('#fa4_state').attr('value', '未提交'); 
        $('#fa4_diagnosispeople').attr('value', m_UserInfo.UserName);  
        //状态控制
        stateContral($('#fa4_state').attr('value')); 
    } else if (act == "upd") {
        $('#fa4_id').attr('value', row.fa4_id);
        $('#fa4_cono').attr('value', row.fa4_cono);
        $('#fa4_divi').attr('value', row.fa4_divi);
        $('#fa4_rguser').attr('value', row.fa4_rguser);
        $('#fa4_uptno').attr('value', row.fa4_uptno);
        $('#fa4_rgdt').attr('value', row.fa4_rgdt);
        $('#fa4_state').attr('value', row.fa4_state);
        $('#fa4_department').attr('value', row.fa4_department);
        $('#fa4_name').attr('value', row.fa4_name);
        $('#fa4_diagnosispeople').attr('value', row.fa4_diagnosispeople);
        $('#fa4_filldate').datebox('setValue', row.fa4_filldate);//鉴定日期-当前日期 

        $('#fa4_notebook').attr('value', row.fa4_notebook);
        $('#fa4_computer').attr('value', row.fa4_computer);
        $('#fa4_deviceno').attr('value', row.fa4_deviceno);
        $('#fa4_cpu').attr('value', row.fa4_cpu);
        $('#fa4_mem').attr('value', row.fa4_mem);
        $('#fa4_hd').attr('value', row.fa4_hd);
        $('#fa4_buydate').attr('value', row.fa4_buydate);
        $('#fa4_omoney').attr('value', row.fa4_omoney);
        $('#fa4_rmoney').attr('value', row.fa4_rmoney);
        $('#fa4_officewarebef1').attr('value', row.fa4_officewarebef1);
        $('#fa4_officewarebef2').attr('value', row.fa4_officewarebef2);
        $('#fa4_officewarebef3').attr('value', row.fa4_officewarebef3);
        $('#fa4_officewarebef4').attr('value', row.fa4_officewarebef4);
        $('#fa4_officewarebef5').attr('value', row.fa4_officewarebef5);
        $('#fa4_officewarebef6').attr('value', row.fa4_officewarebef6);
        $('#fa4_officewarebef7').attr('value', row.fa4_officewarebef7);
        $('#fa4_officewarebef8').attr('value', row.fa4_officewarebef8);
        $('#fa4_unofficewarebef1').attr('value', row.fa4_unofficewarebef1);
        $('#fa4_unofficewarebef2').attr('value', row.fa4_unofficewarebef2);
        $('#fa4_unofficewarebef3').attr('value', row.fa4_unofficewarebef3);
        $('#fa4_unofficewarebef4').attr('value', row.fa4_unofficewarebef4);
        $('#fa4_unofficewarebef5').attr('value', row.fa4_unofficewarebef5);
        $('#fa4_unofficewarebef6').attr('value', row.fa4_unofficewarebef6);
        $('#fa4_unofficewarebef7').attr('value', row.fa4_unofficewarebef7);
        $('#fa4_unofficewarebef8').attr('value', row.fa4_unofficewarebef8);
        $('#fa4_opentimebef1').attr('value', row.fa4_opentimebef1);
        $('#fa4_opentimebef2').attr('value', row.fa4_opentimebef2);
        $('#fa4_opentimebef3').attr('value', row.fa4_opentimebef3);
        $('#fa4_opentimebef4').attr('value', row.fa4_opentimebef4);
        $('#fa4_officewareaft1').attr('value', row.fa4_officewareaft1);
        $('#fa4_officewareaft2').attr('value', row.fa4_officewareaft2);
        $('#fa4_officewareaft3').attr('value', row.fa4_officewareaft3);
        $('#fa4_officewareaft4').attr('value', row.fa4_officewareaft4);
        $('#fa4_officewareaft5').attr('value', row.fa4_officewareaft5);
        $('#fa4_officewareaft6').attr('value', row.fa4_officewareaft6);
        $('#fa4_officewareaft7').attr('value', row.fa4_officewareaft7);
        $('#fa4_officewareaft8').attr('value', row.fa4_officewareaft8);
        $('#fa4_unofficewareaft1').attr('value', row.fa4_unofficewareaft1);
        $('#fa4_unofficewareaft2').attr('value', row.fa4_unofficewareaft2);
        $('#fa4_unofficewareaft3').attr('value', row.fa4_unofficewareaft3);
        $('#fa4_unofficewareaft4').attr('value', row.fa4_unofficewareaft4);
        $('#fa4_unofficewareaft5').attr('value', row.fa4_unofficewareaft5);
        $('#fa4_unofficewareaft6').attr('value', row.fa4_unofficewareaft6);
        $('#fa4_unofficewareaft7').attr('value', row.fa4_unofficewareaft7);
        $('#fa4_unofficewareaft8').attr('value', row.fa4_unofficewareaft8);
        $('#fa4_opentimeaft1').attr('value', row.fa4_opentimeaft1);
        $('#fa4_opentimeaft2').attr('value', row.fa4_opentimeaft2);
        $('#fa4_opentimeaft3').attr('value', row.fa4_opentimeaft3);
        $('#fa4_opentimeaft4').attr('value', row.fa4_opentimeaft4);
        $('#fa4_compreheevaluation').attr('value', decodeURIComponent(row.fa4_compreheevaluation));
        $('#fa4_specificrequire').attr('value', decodeURIComponent(row.fa4_specificrequire));
        $('#fa4_suggest').attr('value', decodeURIComponent(row.fa4_suggest));
        $('#fa4_audit').attr('value', row.fa4_audit);
        $('#fa4_auditdate').attr('value', row.fa4_auditdate);
        //状态控制
        stateContral($('#fa4_state').attr('value')); 
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
        $('#deptqybtn').hide();
        //字段只读控制 
        $("form input").prop("disabled", true);
        $("form textarea").prop("disabled", true); 
        $('#fa4_filldate').datebox('disable'); 
    } else {
        //按钮控制     
        $('#btnSave').show();
        $('#btnTurn').show(); 
        $('#deptqybtn').show();
        if (state == '已提交') {
            $('#btnTurnSpan').text('审核');
        } else { 
            $('#btnTurnSpan').text('提交');
        } 
        //字段只读控制  
        $("form input").prop("disabled", false);
        $("form textarea").prop("disabled", false);
        $('#fa4_filldate').datebox('enable');
        $('#fa4_department').prop("disabled", true);
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
	    cfilter = cfilter + ' AND fa4_Department LIKE \'%' + cxDeptName + '%\'';
	}
	if (cxName != '') {
	    cfilter = cfilter + ' AND fa4_Name LIKE \'%' + cxName + '%\'';
	}
	if (cxChecker != '') {
	    cfilter = cfilter + ' AND fa4_Audit LIKE \'%' + cxChecker + '%\'';
	}
	if (cxState != '' && cxState != '全部') {
	    cfilter = cfilter + ' AND fa4_State = \'' + cxState + '\'';
	}
	if (cxDate != '') {
	    cfilter = cfilter + ' AND  convert(varchar(10),fa4_FillDate,120) LIKE \'' + cxDate + '%\'';
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

    var curl = GetWSRRURL(peoa_GetWSRRURL(10)) + "&type=GetHs&XML="+ encodeURIComponent(cXML)
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
	                    result.rows = strSerialize(result.rows);
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
    var billInfo = eval('[{' + jsonUtil_form2json1('#FA_IPDRForm') + '}]'); //获取单据主信息json  
    var curl = GetWSRRURL(peoa_GetWSRRURL(10));
    if ($('#fa4_id').attr('value') == '') {  //新增单据  
        billInfo[0].fa4_id = dataUtil_NewGuid();  //赋值ID    
        curl = curl + "&type=New&actor=" + m_UserInfo.UserName;
    } else {        //修改单据  
        billInfo[0].fa4_uptno = billInfo[0].fa4_uptno*1+1;  
        billInfo[0].fa4_lmuser = m_UserInfo.UserName;
        billInfo[0].fa4_lmdt = dateUtil_dateFomaterB(new Date(), '-');   
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
                    $('#fa4_id').attr('value', billInfo[0].fa4_id);
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
     

    //主信息部分校验
    if ($('#fa4_department').attr('value') == '') {
        $.messager.alert('提示框', '部门名称必填!', "worning");
        return false;
    }
    if ($('#fa4_name').attr('value') == '') {
        $.messager.alert('提示框', '姓名必填!', "worning");
        return false;
    } 
    if ($('#fa4_filldate').datebox('getValue') == null || $('#fa4_filldate').datebox('getValue') == '') {
        $.messager.alert('提示框', '鉴定日期必填!', 'worning');
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
    if ($('#fa4_id').attr('value') == '') {
        $.messager.alert('提示框', '单据未保存，无需取消!', "worning");
        return false;
    }
    if ($('#fa4_state').attr('value') == '已取消') {
        $.messager.alert('提示框', '单据已取消，无需取消!', "worning");
        return false;
    }
    //取消操作 
    $.messager.confirm('确认框', '确认取消该鉴定单吗？', function (r) {
        if (r) {
            var curl = GetWSRRURL(peoa_GetWSRRURL(10)) + "&type=Upd&actor=" + m_UserInfo.UserName; //拼接url  
            var billInfo = eval('[{"fa4_id":"' + $('#fa4_id').attr('value') + '"}]'); //获取单据主信息json    
            billInfo[0].fa4_uptno = $('#fa4_uptno').attr('value') * 1 + 1;
            billInfo[0].fa4_lmuser = m_UserInfo.UserName;
            billInfo[0].fa4_lmdt = dateUtil_dateFomaterB(new Date(), '-');
            billInfo[0].fa4_state = '已取消';
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
                            $('#fa4_state').attr('value', billInfo[0].fa4_state);
                            stateContral($('#fa4_state').attr('value')); 
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
    if ($('#fa4_state').attr('value') == '已提交') {
        if (m_Role != 'B') {
            alert('您没有审核权限！');
            return false;
        }
    }
    if (!actSaveZ) {
        return false;
    }
    //设置提交相关信息
    var billInfo = eval('[{"fa4_id":"' + $('#fa4_id').attr('value') + '"}]'); //获取单据主信息json    
    var info = '';
    var state = '';
    if ($('#fa4_state').attr('value') == '未提交') {
        billInfo[0].fa4_state = '已提交';
        info = '确认提交该鉴定单吗？';
    } else if ($('#fa4_state').attr('value') == '已提交') { 
        billInfo[0].fa4_state = '已审核';
        billInfo[0].fa4_audit = m_UserInfo.UserName;
        billInfo[0].fa4_auditdate = dateUtil_dateFomaterB(new Date(), '-');
        info = '确认审核该鉴定单吗？';
    } else {
        return false;
    }
   
    //执行操作 
    $.messager.confirm('确认框', info, function (r) {
        if (r) {
            var curl = GetWSRRURL(peoa_GetWSRRURL(10)) + "&type=Upd&actor=" + m_UserInfo.UserName; //拼接url  
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
                            $('#fa4_state').attr('value', billInfo[0].fa4_state);
                            stateContral($('#fa4_state').attr('value'));
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
 * 字符串序列号
 */
function strSerialize(rows) { 
    var reg = new RegExp("《br》", "g");
    for (var i = 0; i < rows.length; i++) { 
        var row = rows[i];
        row.fa4_notebook = row.fa4_notebook.replace(reg, '\n');
        row.fa4_computer = row.fa4_computer.replace(reg, '\n');
        row.fa4_deviceno = row.fa4_deviceno.replace(reg, '\n');
        row.fa4_cpu = row.fa4_cpu.replace(reg, '\n');
        row.fa4_mem = row.fa4_mem.replace(reg, '\n');
        row.fa4_hd = row.fa4_hd.replace(reg, '\n');
        row.fa4_buydate = row.fa4_buydate.replace(reg, '\n');
        row.fa4_omoney = row.fa4_omoney.replace(reg, '\n');
        row.fa4_rmoney = row.fa4_rmoney.replace(reg, '\n');
        row.fa4_officewarebef1 = row.fa4_officewarebef1.replace(reg, '\n');
        row.fa4_officewarebef2 = row.fa4_officewarebef2.replace(reg, '\n');
        row.fa4_officewarebef3 = row.fa4_officewarebef3.replace(reg, '\n');
        row.fa4_officewarebef4 = row.fa4_officewarebef4.replace(reg, '\n');
        row.fa4_officewarebef5 = row.fa4_officewarebef5.replace(reg, '\n');
        row.fa4_officewarebef6 = row.fa4_officewarebef6.replace(reg, '\n');
        row.fa4_officewarebef7 = row.fa4_officewarebef7.replace(reg, '\n');
        row.fa4_officewarebef8 = row.fa4_officewarebef8.replace(reg, '\n');
        row.fa4_unofficewarebef1 = row.fa4_unofficewarebef1.replace(reg, '\n');
        row.fa4_unofficewarebef2 = row.fa4_unofficewarebef2.replace(reg, '\n');
        row.fa4_unofficewarebef3 = row.fa4_unofficewarebef3.replace(reg, '\n');
        row.fa4_unofficewarebef4 = row.fa4_unofficewarebef4.replace(reg, '\n');
        row.fa4_unofficewarebef5 = row.fa4_unofficewarebef5.replace(reg, '\n');
        row.fa4_unofficewarebef6 = row.fa4_unofficewarebef6.replace(reg, '\n');
        row.fa4_unofficewarebef7 = row.fa4_unofficewarebef7.replace(reg, '\n');
        row.fa4_unofficewarebef8 = row.fa4_unofficewarebef8.replace(reg, '\n');
        row.fa4_officewareaft1 = row.fa4_officewareaft1.replace(reg, '\n');
        row.fa4_officewareaft2 = row.fa4_officewareaft2.replace(reg, '\n');
        row.fa4_officewareaft3 = row.fa4_officewareaft3.replace(reg, '\n');
        row.fa4_officewareaft4 = row.fa4_officewareaft4.replace(reg, '\n');
        row.fa4_officewareaft5 = row.fa4_officewareaft5.replace(reg, '\n');
        row.fa4_officewareaft6 = row.fa4_officewareaft6.replace(reg, '\n');
        row.fa4_officewareaft7 = row.fa4_officewareaft7.replace(reg, '\n');
        row.fa4_officewareaft8 = row.fa4_officewareaft8.replace(reg, '\n');
        row.fa4_unofficewareaft1 = row.fa4_unofficewareaft1.replace(reg, '\n');
        row.fa4_unofficewareaft2 = row.fa4_unofficewareaft2.replace(reg, '\n');
        row.fa4_unofficewareaft3 = row.fa4_unofficewareaft3.replace(reg, '\n');
        row.fa4_unofficewareaft4 = row.fa4_unofficewareaft4.replace(reg, '\n');
        row.fa4_unofficewareaft5 = row.fa4_unofficewareaft5.replace(reg, '\n');
        row.fa4_unofficewareaft6 = row.fa4_unofficewareaft6.replace(reg, '\n');
        row.fa4_unofficewareaft7 = row.fa4_unofficewareaft7.replace(reg, '\n');
        row.fa4_unofficewareaft8 = row.fa4_unofficewareaft8.replace(reg, '\n');
        row.fa4_compreheevaluation = row.fa4_compreheevaluation.replace(reg, '\n');
        row.fa4_specificrequire = row.fa4_specificrequire.replace(reg, '\n');
        row.fa4_suggest = row.fa4_suggest.replace(reg, '\n');
    }
    return rows;
}


/*******************
 * 调用打印页
 */
function print() {
    var fid = $("#fa4_id").attr("value");
    if (fid == null || fid == '' || fid == '（系统自动生成）') {
        $.messager.alert('提示', '保存成功后才能打印！');
        return;
    } 
    window.open("../../../WEB/PE_OA/FA/FA_CCAS_print.html?v0=" + fid);
}



/*******************
 * 获取列表高度
 */
function openDeptDlg() {
    if (deptdlgFlag == 0) {
        //公司 下拉框设置
        $('#cx1Com').combotree({
            panelWidth: "280",
            panelHeight: "360",
            animate: true,
            onlyLeafCheck: true,
            editable: false,
            idField: 'id',
            textField: 'text',
            onSelect: function (data) {
                actDeptsQuery('1', data.id);
            },
            onShowPanel: function (rowIndex) {
                var cXMLc = '<Page>0</Page><Num>0</Num>'
                 + '<Cons> AND OZ1_OrgType = \'公司\' </Cons><OrderBy></OrderBy>';
                cXMLc = basedata_addROOT(cXMLc);
                var curlc = GetTreeWSRRURL(peoa_GetWSRRURL(11), undefined, "1", "1")
                        + "&MenuCodeContains=0&type=GetORGTree&XML=" + encodeURIComponent(cXMLc)
                        + "&s=" + new Date().getTime();  //拼接url   
                $.ajax({
                    url: curlc,
                    options: "JSON",
                    async: false,
                    success: function (data) {
                        var data1 = eval('(' + data + ')');
                        $('#cx1Com').combotree('loadData', data1);
                    }
                });

            }
        });

        //部门1 下拉框设置
        $('#cx1DeptID').combotree({
            panelWidth: "280",
            panelHeight: "360",
            animate: true,
            onlyLeafCheck: true,
            editable: false,
            idField: 'id',
            textField: 'text',
            onSelect: function (data) {
                actDeptsQuery('1', data.id);
            },
            onShowPanel: function (rowIndex) {
                var fatherid = $('#cx1Com').combotree('getValue');
                var consc = 'AND (OZ1_FatherId = \'' + fatherid + '\' OR OZ1_OrgCode = \'' + fatherid + '\' ) ';
                var cXMLc = '<Page>0</Page><Num>0</Num>'
                 + '<Cons> ' + consc + '</Cons><OrderBy></OrderBy>';
                cXMLc = basedata_addROOT(cXMLc);
                var curlc = GetTreeWSRRURL(peoa_GetWSRRURL(11), undefined, fatherid, "0")
                        + "&MenuCodeContains=0&type=GetORGTree&XML=" + encodeURIComponent(cXMLc)
                        + "&s=" + new Date().getTime();  //拼接url   
                $.ajax({
                    url: curlc,
                    options: "JSON",
                    async: false,
                    success: function (data) {
                        var data1 = eval('(' + data + ')');
                        $('#cx1DeptID').combotree('loadData', data1);
                    }
                });

            }
        });



        //部门2 下拉框设置
        $('#cx2DeptID').combotree({
            panelWidth: "280",
            panelHeight: "360",
            animate: true,
            onlyLeafCheck: true,
            editable: false,
            idField: 'id',
            textField: 'text',
            onSelect: function (data) {
                actDeptsQuery('1', data.id);
            },
            onShowPanel: function (rowIndex) {
                var fatherid = $('#cx1DeptID').combotree('getValue');
                var cXMLc = '<Page>0</Page><Num>0</Num>'
                 + '<Cons></Cons><OrderBy></OrderBy>';
                cXMLc = basedata_addROOT(cXMLc);
                var curlc = GetTreeWSRRURL(peoa_GetWSRRURL(11), undefined, fatherid, "0")
                        + "&MenuCodeContains=0&type=GetORGTree&XML=" + encodeURIComponent(cXMLc)
                        + "&s=" + new Date().getTime();  //拼接url   
                $.ajax({
                    url: curlc,
                    options: "JSON",
                    async: false,
                    success: function (data) {
                        var data1 = eval('(' + data + ')');
                        $('#cx2DeptID').combotree('loadData', data1);
                        $('#cx2DeptID').combotree('tree').tree('collapseAll');
                    }
                });

            }
        });


        //部门列表设置
        $(m_DatagridId1).datagrid({
            //title:'列表', 
            //width: 500,
            height: 260,
            nowrap: true,
            striped: false,
            collapsible: true,
            //sortName: 'oz1_orgname',
            //sortOrder: 'asc', 
            remoteSort: false,
            idField: 'oz1_id',
            frozenColumns: [[

            ]],
            columns: [[
                { field: 'oz1_id', title: 'oz1_id', width: 100, hidden: true },
                { field: 'oz1_cono', title: 'oz1_cono', width: 100, hidden: true },
                { field: 'oz1_divi', title: 'oz1_divi', width: 100, hidden: true },
                { field: 'oz1_orgcode', title: '部门代码', width: 150, hidden: true },
                { field: 'oz1_orgname', title: '部门名称', width: 220, sortable: true },
                { field: 'oz1_costcentercode2', title: '成本中心', width: 120 },
                { field: 'oz1_com1', title: '公司1', width: 220, sortable: true }
            ]],
            pagination: false,
            rownumbers: true,
            singleSelect: true,
            onDblClickRow: function (rowIndex, rowData) {
                $('#fa4_cono').attr('value', rowData.oz1_cono);
                $('#fa4_divi').attr('value', rowData.oz1_divi);
                $('#fa4_department').attr('value', rowData.oz1_orgname);
                $('#bmdlg').dialog('close');
            },
        });
        deptdlgFlag = 1;
    } 
    $('#cx1Com').combotree('setValue', '');
    $('#cx1DeptID').combotree('setValue', '');
    $('#cx2DeptID').combotree('setValue', '');
    $('#cx3DeptID').attr('value', '');
    $('#bmdlg').dialog('open');
}

/***********************************************************************
 *  查询部门(模糊 名称) 到数据库
 *  DLY 
 */
function actDeptsQuery(type, oz1_code) {
    var mDepts = [];
    var orderby = ' ORDER BY oz1_com1 ';
    var cons = '';
    if (type == '1') {
        cons = cons + ' AND OZ1_OrgCode = \'' + oz1_code + '\'';
    } else if (type == '2') {
        if ($('#cx3DeptID').val() != '') {
            cons = cons + ' AND oz1_orgname LIKE \'%' + $('#cx3DeptID').val() + '%\'';
        } else {
            cons = cons + ' AND 1 = 2 ';
        }
    }
    if (cons != '') {
        cons = ' AND OZ1_State=\'启用\' ' + cons;
        var cXML = '<Page>' + '' + '</Page><Num>' + '' + '</Num>'
            + '<Cons>' + cons + '</Cons><OrderBy>' + orderby + '</OrderBy>';
        cXML = basedata_addROOT(cXML);
        var curl = GetWSRRURL(peoa_GetWSRRURL(11)) + "&type=GetOrgs&XML=" + encodeURIComponent(cXML); //拼接url 
        $.ajax({
            url: curl,
            options: "JSON",
            async: false,
            success: function (data) {
                var data1 = eval('(' + data + ')');
                if (data1.rows) {
                    mDepts = data1.rows;
                }
            }
        });
    }

    if (mDepts.length == 0 || mDepts[0].oz1_id == undefined || mDepts[0].oz1_id == '') {
        $(m_DatagridId1).datagrid('loadData', []);
    } else {
        $(m_DatagridId1).datagrid('loadData', mDepts);
    }
}
 
/*******************
 * 获取列表高度
 */
function getcurheight() {
    var htjcxk = document.getElementById("tjcxk").style.height.replace('px', '');
    var curheight = parent.getTabsHeight() * 1 - htjcxk * 1 + 24;
    return curheight;
}
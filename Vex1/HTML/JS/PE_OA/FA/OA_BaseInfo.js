var m_DatagridID = '#BaseDatalb'; //列表ID
var m_LastIndex = -1;  //列表最后一次编辑行下标  
var m_PageNumber = 1;  //当前页码
var m_PageSize = 20;  //每页显示行数
  
var m_DLList = [];  //记录数组 
var m_DLrow ;  //记录编辑行 

//状态
var m_States = [{ "text": "启用" }, { "text": "禁用" }];

//用户信息
var m_UserInfo = basedata_getUserInfo();

// 过滤条件
var m_Filter = '';  //主的条件
var m_Filter1 = ''; //查询条件
var m_OrderBy = 'ct1_fatherid, ct1_code '; //排序方式


/***********************************************************************
 *  初始化设置
 *  DLY 
 */
$(function () { 
    //列表设置
    initdatagrid();

    //初始化查询
    clearText();
    searchByCons();
});

 

/***********************************************************************
 *  添加记录
 *  DLY 
 */
function actADD() {
    $(m_DatagridID).datagrid('appendRow', {
        ct1_id: dataUtil_NewGuid(),
        ct1_fatherid: '',
        ct1_code: '',
        ct1_codename: '',
        ct1_state: '启用',
        ct1_cono: basedata_getCommonData('CONOT'),
        ct1_divi: basedata_getCommonData('DIVI')
    });
    $(m_DatagridID).datagrid('endEdit', m_LastIndex);
    m_LastIndex = $(m_DatagridID).datagrid('getRows').length - 1;
    $(m_DatagridID).datagrid('selectRow', m_LastIndex);
    $(m_DatagridID).datagrid('beginEdit', m_LastIndex);  
}

 

/***********************************************************************
 *  保存记录
 *  DLY 
 */
function actSave() {
    var flag = false;
    $(m_DatagridID).datagrid('endEdit', m_LastIndex);
    //以下拼接修改记录信息json
    if ($(m_DatagridID).datagrid('getChanges').length > 0) {
        //if (!shopaveCheck()) {
        //    return flag;
        //}
        var gridDataChanges = [];
        var inserted = $(m_DatagridID).datagrid('getChanges', "inserted");
        var updated = $(m_DatagridID).datagrid('getChanges', "updated");
        var deleted = $(m_DatagridID).datagrid('getChanges', "deleted");
        for (var i = 0; i < inserted.length; i++) { 
            inserted[i].ct1_rguser = m_UserInfo.UserName;
            inserted[i].ct1_uptno = 0;
        }
        for (var i = 0; i < updated.length; i++) { 
            updated[i].ct1_lmdt = dateUtil_dateFomaterA(new Date(), '/')
            updated[i].ct1_lmuser = m_UserInfo.UserName;
            updated[i].ct1_uptno = updated[i].ct1_uptno * 1 + 1;
        } 
        cXML1 = GetEditJson(inserted, updated, deleted);//json转xml
        //alert(cXML1);
    } else {
        alert('没有修改信息！');
        return flag;
    }
    var cxmlsJson = { XML: cXML1 };
    var curl = GetWSRRURL(peoa_GetWSRRURL(2)) + "&type=SaveRows"; //拼接url 
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
                    flag = true;
                }
            }
        }
    });

    if (flag) {
        alert('保存成功！');
        actLoadData(m_PageNumber, m_PageSize);
    } else {
        alert('保存失败！');
    }
    return flag;
}
 

/***********************************************************************
 * 可保存校验
 *  DLY 
 */
function actSaveCheck(row1, row2) {
    var flag = false;
    if(row1.ct1_code = '' || row1.ct1_codename != row2.ct1_codename
        || row1.ct1_state != row2.ct1_state ){
        flag = true;
    }
    return flag; 
}


/***********************************************************************
 *  清除条件
 *  DLY 
 */
function clearText() {  
    $('#cxFID').val('');
    $('#cxFatherid').val('');
    $('#cxCode').val('');
    $('#cxCodename').val('基础数据类型');
    $('#cxFieldvalues1').val('');
}


/***********************************************************************
 *  查询事件：根据条件查询
 *  DLY 
 */
function searchByCons() { 
    //拼接条件 获取数据集 
    var cfilter = ' ';
    var cxFID = $('#cxFID').val();
    var cxFatherid = $('#cxFatherid').val();
    var cxCode = $('#cxCode').val();
    var cxCodename = $('#cxCodename').val();
    var cxFieldvalues1 = $('#cxFieldvalues1').val();
    if (cxFID != '') {
        cfilter = cfilter + ' AND  ct1_id = \'' + cxFID + '\'';
    }
    if (cxFatherid != '') {
        cfilter = cfilter + ' AND  ct1_Fatherid = \'' + cxFatherid + '\'';
    }
    if (cxCode != '') {
        cfilter = cfilter + ' AND  ct1_Code like \'%' + cxCode + '%\'';
    }
    if (cxCodename != '') {
        cfilter = cfilter + ' AND  ct1_Codename like \'%' + cxCodename + '%\'';
    }
    if (cxFieldvalues1 != '') {
        cfilter = cfilter + ' AND  ct1_Fieldvalues1 like \'%' + cxFieldvalues1 + '%\'';
    }
    //alert(cfilter)
    m_Filter1 = cfilter; 
    m_PageNumber = 1;
    actLoadData(m_PageNumber, m_PageSize);

}


/***********************************************************************
 *  数据加载
 *  DLY 
 */
function actLoadData(page, number) {
    var totalCount = 0;
    $(m_DatagridID).datagrid('loadData', []);
    var cXML = '<Page>' + page + '</Page><Num>' + number + '</Num>'
             + '<Cons>' + m_Filter + m_Filter1 + '</Cons><OrderBy>' + m_OrderBy + '</OrderBy>';
    cXML = basedata_addROOT(cXML);
    var curl = GetWSRRURL(peoa_GetWSRRURL(2)) + "&type=gbd13&XML=" + encodeURIComponent(cXML)
             + "&s=" + new Date().getTime(); //拼接url
    //alert(cXML);	
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows && data.rows.length > 0) {
                $(m_DatagridID).datagrid('loadData', data.rows);
                totalCount = data.total;
            }
        }
    });
    $('#cxpager').pagination({
        total: totalCount,
        pageNumber: page
    }); 
}
  

/***********************************************************************
 *  列表设置
 *  DLY 
 */
function initdatagrid() {
    $(m_DatagridID).datagrid({
        //title:'列表', 
        //width: 500,
        height: 470,
        nowrap: true,
        striped: false,
        collapsible: true,
        sortName: 'ct1_code',
        sortOrder: 'asc',
        data: m_DLList,
        remoteSort: false,
        idField: 'ct1_id',
        frozenColumns: [[

        ]],
        columns: [[
            { field: 'ct1_id', title: 'Fid', width: 260 },
            { field: 'ct1_fatherid', title: 'Fatherid', width: 100, editor: 'text' },
            { field: 'ct1_cono', title: 'cono', width: 60, editor: 'text' },
            { field: 'ct1_divi', title: 'divi', width: 60, editor: 'text' },
			{ field: 'ct1_code', title: 'code', width: 100, sortable: true, editor: 'text' },
			{ field: 'ct1_codename', title: 'codename', width: 160, sortable: true, editor: 'text' },
			{ field: 'ct1_keyid', title: 'keyid', width: 100, sortable: true, editor: 'text' },
			{ field: 'ct1_keyname', title: 'keyname', width: 160, sortable: true, editor: 'text' },
			{ field: 'ct1_optionsvalues', title: 'optionsvalues', width: 100, sortable: true, editor: 'text' },
			{ field: 'ct1_options', title: 'options', width: 160, sortable: true, editor: 'text' },
			{ field: 'ct1_fieldvalues1', title: 'fieldvalues1', width: 160, sortable: true, editor: 'text' },
			{ field: 'ct1_fieldvalues2', title: 'fieldvalues2', width: 160, sortable: true, editor: 'text' },
			{ field: 'ct1_fieldvalues3', title: 'fieldvalues3', width: 160, sortable: true, editor: 'text' },
			{ field: 'ct1_fieldvalues4', title: 'fieldvalues4', width: 160, sortable: true, editor: 'text' },
			{ field: 'ct1_fieldvalues5', title: 'fieldvalues5', width: 160, sortable: true, editor: 'text' },
			{ field: 'ct1_fieldvalues6', title: 'fieldvalues6', width: 160, sortable: true, editor: 'text' },
			{ field: 'ct1_remark', title: 'remark', width: 160, sortable: true, editor: 'text' },
			{
			    field: 'ct1_state', title: 'state', width: 100, editor: {
			        type: 'combobox', options: {
			            valueField: 'text', textField: 'text',
			            editable: false, panelHeight: "70",
			            data: m_States
			        }
			    }
			},
			{ field: 'ct1_rgdt', title: '创建时间', width: 105 },
			{ field: 'ct1_rguser', title: '创建人', width: 70 },
		    { field: 'ct1_lmdt', title: '修改时间', width: 105 },
            { field: 'ct1_lmuser', title: '修改人', width: 70 },
            { field: 'ct1_uptno', title: '修改次数', width: 70 }
        ]],
        pagination: false,
        rownumbers: true,
        singleSelect: true,
        onClickRow: function (rowIndex, data) {
            //结束前一次选中的行，自动调用onAfterEdit
            if (m_LastIndex != undefined && m_LastIndex>=0) {
                $(m_DatagridID).datagrid('endEdit', m_LastIndex);
            }
            $(m_DatagridID).datagrid('selectRow', rowIndex);
            $(m_DatagridID).datagrid('beginEdit', rowIndex);
            m_LastIndex = rowIndex; 
        }, onAfterEdit: function (rowIndex, rowData, changes) { 
        }

    });
    $('#cxpager').pagination({
        total: 0,
        pageNumber: 1,
        pageSize: m_PageSize,//每页显示的记录条数，默认为20  
        //pageList: [20, 50, 100, 200, 1],//可以设置每页记录条数的列表  
        showPageList: false, //不显示每页记录数列表
        beforePageText: '第',//页数文本框前显示的汉字  
        afterPageText: '页    共 {pages} 页',
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',
        onBeforeRefresh: function () {
        },
        onSelectPage: function (pageNumber, pageSize) {
            actLoadData(pageNumber, pageSize);
        },
        buttons: [{
            text: '添加',
            iconCls: 'icon-add',
            handler: function () {
                actADD();
            }
        }, '-', {
            text: '保存',
            iconCls: 'icon-save',
            handler: function () {
                actSave();
            }
        }, '-', {
            text: '删除',
            iconCls: 'icon-delete',
            handler: function () {
                var row = $(m_DatagridID).datagrid("getSelected"); 
                var rindex = $(m_DatagridID).datagrid('getRowIndex', row);
                $(m_DatagridID).datagrid('deleteRow', rindex);	//通过行号移除该行  
            }
        }]

    });
}
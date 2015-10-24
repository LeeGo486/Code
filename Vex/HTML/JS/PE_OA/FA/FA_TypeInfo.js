var m_DatagridID = '#TypeDLlb'; //大类列表ID
var m_LastIndex = undefined;  //大类列表最后一次编辑行下标  

var m_DatagridID1 = '#TypeXLlb'; //小类列表ID
var m_LastIndex1 = undefined;  //小类列表最后一次编辑行下标  


 

//固定资产类别
var m_DLListid = peoa_GetBDFID(13); //大类编码
var m_DLList = [];  //大类数组
var m_XLList = [];  //小类数组
var m_DLrow ;  //大类编辑行
var m_XLrow;   //小类编辑行

//状态
var m_States = [{ "text": "启用" }, { "text": "禁用" }];

//用户信息
var m_UserInfo = basedata_getUserInfo();

// 过滤条件
var m_Filter = '';  //主的条件
var m_Filter1 = ''; //查询条件
var m_OrderBy = ''; //排序方式


/***********************************************************************
 *  初始化设置
 *  DLY 
 */
$(function () {

    //资产大类获取  
    var cons = ' AND CT1_FatherID = \'' + m_DLListid + '\'';
    var m_DLList = basedata_getBDCommon('gbd12', cons);
    if (m_DLList == undefined || m_DLList[0].ct1_id == undefined
        || m_DLList[0].ct1_id == '') {
        m_DLList = [];
    }

    //大类列表设置
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
            { field: 'ct1_id', title: 'ct1_id', width: 100, hidden: true },
            { field: 'ct1_fatherid', title: 'ct1_fatherid', width: 100, hidden: true },
            { field: 'ct1_cono', title: 'ct1_cono', width: 100, hidden: true },
            { field: 'ct1_divi', title: 'ct1_divi', width: 100, hidden: true },
			{ field: 'ct1_code', title: '大类编码', width: 100, sortable: true },
			{ field: 'ct1_codename', title: '大类名称', width: 160, sortable: true, editor: 'text' },
			{ field: 'ct1_state', title: '状态', width: 100, editor: {
			        type: 'combobox', options: {
			            valueField: 'text', textField: 'text',
			            editable: false, panelHeight: "70",
			            data:m_States
			        }
			    }
			}
        ]],
        pagination: false,
        rownumbers: true,
        singleSelect: true,
        onClickRow: function (rowIndex, data) {
            //结束前一次选中的行，自动调用onAfterEdit
            if (m_LastIndex != undefined) {
                $(m_DatagridID).datagrid('endEdit', m_LastIndex);
            }
            $(m_DatagridID).datagrid('selectRow', rowIndex);
            $(m_DatagridID).datagrid('beginEdit', rowIndex); 
            m_LastIndex = rowIndex;  

            //关联显示小类
            var cons = ' AND CT1_FatherID = \'' + data.ct1_id + '\'';
            var m_XLList = basedata_getBDCommon('gbd12', cons);
            if (m_XLList[0].ct1_id == '') {
                $(m_DatagridID1).datagrid('loadData', []);
            } else {
                $(m_DatagridID1).datagrid('loadData', m_XLList);
            }
        }, onAfterEdit: function (rowIndex, rowData, changes) {  
            if (jsonUtil_jsonToStr(changes) != '{}') {
                actSave(rowData);
            }
            
        }

    });


    //小类列表设置
    $(m_DatagridID1).datagrid({
        //title:'预算列表', 
        //width: 500,
        height: 470,
        nowrap: true,
        striped: false,
        collapsible: true,
        sortName: 'ct1_code',
        sortOrder: 'asc',
        remoteSort: false,
        idField: 'ct1_id',
        frozenColumns: [[

        ]],
        columns: [[
            { field: 'ct1_id', title: 'ct1_id', width: 100, hidden: true },
            { field: 'ct1_fatherid', title: 'ct1_fatherid', width: 100, hidden: true },
            { field: 'ct1_cono', title: 'ct1_cono', width: 100, hidden: true },
            { field: 'ct1_divi', title: 'ct1_divi', width: 100, hidden: true },
			{ field: 'ct1_code', title: '小类编码', width: 100, sortable: true },
			{ field: 'ct1_codename', title: '小类名称', width: 200, sortable: true, editor: 'text' },
			{ field: 'ct1_fieldvalues1', title: '参考价', width: 100
			    , editor: { type: 'numberbox', options: { precision: 0, min: 0 } }
                , formatter: function (val) { return dataUtil_formatNum1(val); } },
			{
			    field: 'ct1_state', title: '状态', width: 100, editor: {
			        type: 'combobox', options: {
			            valueField: 'text', textField: 'text',
			            editable: false, panelHeight: "70",
			            data: m_States
			        }
			    }
			}
        ]],
        pagination: false,
        rownumbers: true,
        singleSelect: true,
        onClickRow: function (rowIndex) { 
            //结束前一次选中的行，自动调用onAfterEdit
            if (m_LastIndex1 != undefined) {
                $(m_DatagridID1).datagrid('endEdit', m_LastIndex1);
            }
            $(m_DatagridID1).datagrid('selectRow', rowIndex);
            $(m_DatagridID1).datagrid('beginEdit', rowIndex);
            m_LastIndex1 = rowIndex;

        }, onAfterEdit: function (rowIndex, rowData, changes) {
            if (jsonUtil_jsonToStr(changes) != '{}') {
                actSave1(rowData);
            }

        }
    }); 
 
});

 

/***********************************************************************
 *  添加大类
 *  DLY 
 */
function actADD() {
    $(m_DatagridID).datagrid('appendRow', {
        ct1_id: dataUtil_NewGuid(),
        ct1_fatherid: m_DLListid,
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
    $(m_DatagridID1).datagrid('loadData', []);
}

 

/***********************************************************************
 *  保存大类
 *  DLY 
 */
function actSave(updrow) {
    if (updrow == undefined && m_LastIndex != undefined) {
        $(m_DatagridID).datagrid('endEdit', m_LastIndex);
    }

    if (updrow == undefined) {
        return false;
    }
    //保存操作      
    var curl = GetWSRRURL(peoa_GetWSRRURL(2));
    if (updrow.ct1_code == '') { //新增
        curl = curl + "&type=NewFATypeDL&actor=" + m_UserInfo.UserName;
        updrow.ct1_rguser = m_UserInfo.UserName;
    } else { //修改
        curl = curl + "&type=UpdFAType&actor=" + m_UserInfo.UserName;
        updrow.ct1_lmdt = dateUtil_dateFomaterA(new Date(), '-');
        updrow.ct1_lmuser = m_UserInfo.UserName;
    } 
    var billInfo = [];
    billInfo.push(updrow);
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
                    //回写信息
                    if (updrow.ct1_code == '') { //新增  
                        updrow.ct1_code = result.rows[0].message;
                        $(m_DatagridID).datagrid('updateRow', { index: m_LastIndex, row: updrow });
                    }
                }
            } catch (ex) {
                $.messager.alert("提示", ex, 'error');
            }
        },
        error: function () {
            $.messager.alert("提示", "保存失败！", 'error');
        }
    }) 
}



/***********************************************************************
 *  添加小类
 *  DLY 
 */
function actADD1() {
    var row = $(m_DatagridID).datagrid('getSelected');
    if (!row) {
        alert('请先选择一个大类！');
        return false;
    }
    if (row.ct1_code == '') {
        alert('请先保存大类信息！');
        return false;
    }
    $(m_DatagridID1).datagrid('endEdit', m_LastIndex1); 
    $(m_DatagridID1).datagrid('appendRow', {
        ct1_id: dataUtil_NewGuid(),
        ct1_fatherid: row.ct1_id,
        ct1_code: '',
        ct1_codename: '',
        ct1_state: '启用',
        ct1_cono: row.ct1_cono,
        ct1_divi: row.ct1_divi
    });
    m_LastIndex1 = $(m_DatagridID1).datagrid('getRows').length - 1;
    $(m_DatagridID1).datagrid('selectRow', m_LastIndex1);
    $(m_DatagridID1).datagrid('beginEdit', m_LastIndex1);
} 


/***********************************************************************
 *  保存小类
 *  DLY 
 */
function actSave1(updrow) {
    if (updrow == undefined && m_LastIndex1 != undefined) {
        $(m_DatagridID1).datagrid('endEdit', m_LastIndex1);
    }

    if (updrow == undefined) {
        return false;
    }
    //保存操作      
    var curl = GetWSRRURL(peoa_GetWSRRURL(2));
    if (updrow.ct1_code == '') { //新增
        curl = curl + "&type=NewFATypeXL&actor=" + m_UserInfo.UserName;
        updrow.ct1_rguser = m_UserInfo.UserName;
    } else { //修改
        curl = curl + "&type=UpdFAType&actor=" + m_UserInfo.UserName;
        updrow.ct1_lmdt = dateUtil_dateFomaterA(new Date(), '-');
        updrow.ct1_lmuser = m_UserInfo.UserName;
    } 
    var billInfo = [];
    billInfo.push(updrow);
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
                    //回写信息
                    if (updrow.ct1_code == '') { //新增  
                        updrow.ct1_code = result.rows[0].message;
                        $(m_DatagridID1).datagrid('updateRow', { index: m_LastIndex1, row: updrow });
                    }
                }
            } catch (ex) {
                $.messager.alert("提示", ex, 'error');
            }
        },
        error: function () {
            $.messager.alert("提示", "保存失败！", 'error');
        }
    })
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
 *  查询小类(模糊查询编码或名称)
 *  DLY 
 */
function actDLQuery() {
    var row = $(m_DatagridID).datagrid('getSelected');
    if (!row) { 
        return false;
    }
    var cons = ' AND CT1_FatherID = \'' + row.ct1_id + '\''; 
    var cxXLName = $('#cxXLName').attr('value');
    if (cxXLName != '') {
        cons = cons + ' AND ( CT1_CodeName like \'%' + cxXLName + '%\' OR '
             + ' CT1_Code like \'%' + cxXLName + '%\' )';
    }
             
    var m_XLList = basedata_getBDCommon('gbd12', cons);
    if (m_XLList[0].ct1_id == '') {
        $(m_DatagridID1).datagrid('loadData', []);
    } else {
        $(m_DatagridID1).datagrid('loadData', m_XLList);
    } 
}


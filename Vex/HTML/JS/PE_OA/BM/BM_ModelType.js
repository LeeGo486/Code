 
var m_DatagridID = '#ModelTypelb'; //模板类别列表ID
var m_LastIndex = undefined;  //模板类别列表最后一次编辑行下标  

var m_DatagridID1 = '#ModelDetaillb'; //模板明细列表ID
var m_LastIndex1 = undefined;  //模板明细列表最后一次编辑行下标  
 

var m_DatagridID2 = '#TypeDXLlb'; //大小类选择列表ID
var m_LastIndex2 = undefined;  //大小类列表最后一次编辑行下标  


 

//模板主从
var m_MDListid = peoa_GetBDFID(18); //模板类别fatherid
var m_MDList = [];  //模板数组
var m_MDDList = [];  //模板明细数组
var m_MDrow;    //模板编辑行
var m_DXLrow;   //大小类编辑行

//科目类别
var m_DLListid = peoa_GetBDFID(17); //大类fatherid
var m_DLList = [];  //大类数组
var m_XLList = [];  //小类数组 
var m_DXLList = [];  //大小类联合数组

//状态
var m_States = [{ "text": "启用" }, { "text": "禁用" }];

//用户信息
var m_UserInfo = basedata_getUserInfo();

// 过滤条件
var m_Filter = '';  //主的条件
var m_Filter1 = ''; //查询条件
var m_OrderBy = ' ORDER BY '; //排序方式


/***********************************************************************
 *  初始化设置
 *  DLY 
 */
$(function () {

    //模板类别及科目大类获取  
    var cons = ' AND CT1_FatherID in (\'' + m_MDListid + '\',\'' + m_DLListid + '\')';
    var res = basedata_getBDCommon('gbd12', cons); 
    var cons1 = ' AND CT1_FatherID in (\'11111111-1111-1111-1111-111111111111\'';  // 小类fatherid拼接
    for (var i = 0; i < res.length; i++) {  
        var f1 = res[i].ct1_fatherid.toUpperCase();
        if (f1 == m_MDListid.toUpperCase()) {
            m_MDList.push(res[i]);
        } else if (f1 == m_DLListid.toUpperCase()) {
            cons1 = cons1 + ', \'' + res[i].ct1_id + '\'';
            if(res[i].ct1_state == '启用'){
                //res[i].vtext = res[i].ct1_codename+'/'+res[i].ct1_code //暂时没用
                m_DLList.push(res[i]);
            }
        } 
    }
    cons1 = cons1 + ')';

    //取所有的小类
    m_XLList = basedata_getBDCommon('gbd12', cons1);

    //联合大小类 用于选择窗
    for (var i = 0; i < m_XLList.length; i++) {
        //m_XLList[i].vtext = m_XLList[i].ct1_codename + '/' + m_XLList[i].ct1_code; //暂时没用
        if(m_XLList[i].ct1_state == '启用'){
            for (var j = 0; j < m_DLList.length; j++) {
                if (m_DLList[j].ct1_id == m_XLList[i].ct1_fatherid) {
                    var dxl = {};
                    dxl.xlid = m_XLList[i].ct1_id;
                    dxl.xlcode = m_XLList[i].ct1_code;
                    dxl.xlname = m_XLList[i].ct1_codename;
                    dxl.dlcode = m_DLList[j].ct1_code;
                    dxl.dlname = m_DLList[j].ct1_codename;
                    m_DXLList.push(dxl); 
                }
            } 
         }
    }
     
    //模板类别列表设置
    $(m_DatagridID).datagrid({
        //title:'列表', 
        //width: 500,
        height: 470,
        nowrap: true,
        striped: false,
        collapsible: true,
        sortName: 'ct1_code',
        sortOrder: 'asc',
        data: m_MDList,
        remoteSort: false,
        idField: 'ct1_id',
        frozenColumns: [[

        ]],
        columns: [[
            { field: 'ct1_id', title: 'ct1_id', width: 100, hidden: true },
            { field: 'ct1_fatherid', title: 'ct1_fatherid', width: 100, hidden: true },
            { field: 'ct1_cono', title: 'ct1_cono', width: 100, hidden: true },
            { field: 'ct1_divi', title: 'ct1_divi', width: 100, hidden: true }, 
			{ field: 'ct1_code', title: '模板编码', width: 70, sortable: true, editor: 'text' },
			{ field: 'ct1_codename', title: '模板名称', width: 160, sortable: true, editor: 'text' }, 
			{ field: 'ct1_state', title: '状态', width: 70, editor: {
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
            m_MDDList = basedata_getBDCommon('gbd12', cons);
            if (m_MDDList[0].ct1_id == '') {
                $(m_DatagridID1).datagrid('loadData', []);
            } else {
                $(m_DatagridID1).datagrid('loadData', m_MDDList);
            }
        }, onAfterEdit: function (rowIndex, rowData, changes) {  
            if (jsonUtil_jsonToStr(changes) != '{}') {
                actSave(rowData);
            }
            
        }

    });


    //模板明细列表设置
    $(m_DatagridID1).datagrid({
        //title:'预算列表', 
        //width: 500,
        height: 400,
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
			{ field: 'ct1_fieldvalues2', title: '大类名称', width: 160, sortable: true
                , formatter: function (val, row, index) {
                    return basedata_getCodename(m_DLList, row.ct1_codename, 'ct1_code', 'ct1_codename');
                }
			},
			{ field: 'ct1_codename', title: '大类编码', width: 100, sortable: true},
			{ field: 'ct1_fieldvalues1', title: '科目小类', width: 160, sortable: true 
                , formatter: function (val, row, index) {
                    return basedata_getCodename(m_XLList, row.ct1_code, 'ct1_code', 'ct1_codename');
                }
			},
			{ field: 'ct1_code', title: '小类编码', width: 120, sortable: true},
			{
			    field: 'ct1_state', title: '状态', width: 70, editor: {
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


    //大小类选择列表设置
    $(m_DatagridID2).datagrid({
        //title:'预算列表', 
        //width: 500,
        height: 300,
        nowrap: true,
        striped: false,
        collapsible: true,
        remoteSort: false,
        idField: 'xlid',
        sortName: 'xlcode',
        sortOrder: 'asc',
        data: m_DXLList,
        frozenColumns: [[ 
        ]],
        columns: [[
		    { field: 'ck', checkbox: true },
            { field: 'xlid', title: 'xlid', width: 100, hidden: true },
			{ field: 'dlname', title: '大类名称', width: 160, sortable: true },
			{ field: 'dlcode', title: '大类编码', width: 100, sortable: true },
			{ field: 'xlname', title: '科目小类', width: 160, sortable: true },
			{ field: 'xlcode', title: '小类编码', width: 120, sortable: true } 
        ]],
        pagination: false,
        rownumbers: true,
        singleSelect: false,
        onClickRow: function (rowIndex) { 
        },
        onAfterEdit: function (rowIndex, rowData, changes) { 
        }
    }); 
 
});
 

/***********************************************************************
 *  添加模板
 *  DLY 
 */
function actADD() {
    $(m_DatagridID).datagrid('appendRow', {
        ct1_id: '',
        ct1_fatherid: m_MDListid,
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
 *  保存模板
 *  DLY 
 */
function actSave(updrow) {
    var flag = 0;
    if (updrow == undefined && m_LastIndex != undefined) {
        $(m_DatagridID).datagrid('endEdit', m_LastIndex);
    }

    if (updrow == undefined) {
        return false;
    }
    //保存操作      
    var curl = GetWSRRURL(peoa_GetWSRRURL(2));
    if (updrow.ct1_id == '') { //新增
        flag = 1;
        updrow.ct1_id = dataUtil_NewGuid();
        curl = curl + "&type=NewBMType&actor=" + m_UserInfo.UserName;
        updrow.ct1_rguser = m_UserInfo.UserName;
    } else { //修改
        curl = curl + "&type=UpdBMType&actor=" + m_UserInfo.UserName;
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
                    if (flag == 1) { //新增   
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
 *  添加明细大小类
 *  DLY 
 */
function actADD1() {
    var row = $(m_DatagridID).datagrid('getSelected');
    if (!row) {
        alert('请先选择一个模板！');
        return false;
    }
    if (row.ct1_id == '') {
        alert('请先保存模板信息！');
        return false;
    }
    $('#dxlxzdlg').dialog('open');
    $(m_DatagridID2).datagrid('clearSelections');
} 


/***********************************************************************
 *  保存明细大小类
 *  DLY 
 */
function actSave1(updrow, type) {
    if (type == undefined) {
        var flag = 0;
        if (updrow == undefined && m_LastIndex1 != undefined) {
            $(m_DatagridID1).datagrid('endEdit', m_LastIndex1);
        }

        if (updrow == undefined) {
            return false;
        }
        //保存操作      
        var curl = GetWSRRURL(peoa_GetWSRRURL(2));
        if (updrow.ct1_id == '') { //新增
            flag = 1;
            updrow.ct1_id = dataUtil_NewGuid();
            curl = curl + "&type=NewBMType&actor=" + m_UserInfo.UserName;
            updrow.ct1_rguser = m_UserInfo.UserName;
        } else { //修改
            curl = curl + "&type=UpdBMType&actor=" + m_UserInfo.UserName;
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
                        if (flag == 1) { //新增   
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
    } else {
        var row = $(m_DatagridID).datagrid('getSelected');
        //关联显示小类
        var cons = ' AND CT1_FatherID = \'' + row.ct1_id + '\'';
        var rows1t = basedata_getBDCommon('gbd12', cons); 
        var rows1 = $(m_DatagridID1).datagrid('getRows');
        var rows2 = $(m_DatagridID2).datagrid('getSelections'); 
        var addrows = [];
        for (var i = 0; i < rows2.length; i++) {
            var f = 0;
            for (var j = 0; j < rows1t.length; j++) {
                if (rows2[i].xlcode == rows1t[j].ct1_code && rows2[i].dlcode == rows1t[j].ct1_codename) {
                    f = 1;
                    break;
                }
            }
            if (f == 0) {
                var newrow = {};
                newrow.ct1_id = dataUtil_NewGuid();
                newrow.ct1_fatherid = row.ct1_id,
                newrow.ct1_code = rows2[i].xlcode,
                newrow.ct1_codename = rows2[i].dlcode,
                newrow.ct1_state = '启用',
                newrow.ct1_cono = basedata_getCommonData('CONOT'),
                newrow.ct1_divi = basedata_getCommonData('DIVI'),
                newrow.ct1_rguser = m_UserInfo.UserName;
                rows1t.push(newrow);
                rows1.push(newrow);
                addrows.push(newrow);
            }
        }
        if (addrows.length == 0) {
            alert('没有可添加记录！'); 
            return false;
        }
        var curl = GetWSRRURL(peoa_GetWSRRURL(2)) + "&type=NewBMType&actor=" + m_UserInfo.UserName
        var cXML = GetEditJson(addrows, [], []); //json转xml  
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
                        $(m_DatagridID1).datagrid('loadData', rows1);
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
 *  查询模板明细(模糊查询编码或名称)(不到数据库)
 *  DLY 
 */
function actMDDQuery() {
    var cxtext = $('#cxDXLName').attr('value');
    if (cxtext != '') {
        var curdxllist = [];
        for (var i = 0; i < m_MDDList.length; i++) {
            if ((m_MDDList[i].ct1_code).indexOf(cxtext) >= 0 || (m_MDDList[i].ct1_fieldvalues1).indexOf(cxtext) >= 0
                || (m_MDDList[i].ct1_codename).indexOf(cxtext) >= 0 || (m_MDDList[i].ct1_fieldvalues2).indexOf(cxtext) >= 0) {
                curdxllist.push(m_MDDList[i]);
            }
        }
        $(m_DatagridID1).datagrid('loadData', curdxllist);
        //$('#cxDXLName').attr('value', '');
    } else {
        $(m_DatagridID1).datagrid('loadData', m_MDDList);
    }
}


/***********************************************************************
 *  选择窗——查询大小类(模糊查询编码或名称) (不到数据库)
 *  DLY 
 */
function actDXLQuery() {
    var cxtext = $('#cxDXLkey').attr('value'); 
    if (cxtext != '') {
        var curdxllist = [];
        for (var i = 0; i < m_DXLList.length; i++) {
            if ((m_DXLList[i].xlcode).indexOf(cxtext) >= 0 || (m_DXLList[i].dlcode).indexOf(cxtext) >= 0
                || (m_DXLList[i].xlname).indexOf(cxtext) >= 0 || (m_DXLList[i].dlname).indexOf(cxtext) >= 0) {
                curdxllist.push(m_DXLList[i]);
            }
        }
        $(m_DatagridID2).datagrid('loadData', curdxllist);
        //$('#cxDXLkey').attr('value', '');
    } else {
        $(m_DatagridID2).datagrid('loadData', m_DXLList);
    }
}

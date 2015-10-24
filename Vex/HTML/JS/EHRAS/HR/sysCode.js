var m_DatagridID = '#TypeDLlb'; //大类列表ID
var m_LastIndex = undefined;  //大类列表最后一次编辑行下标  

var m_DatagridID1 = '#TypeXLlb'; //小类列表ID
var m_LastIndex1 = undefined;  //小类列表最后一次编辑行下标  


 

//基础数据类别 
var m_DLList = [];  //大类数组
var m_XLList = [];  //小类数组
var m_DLrow ;  //大类编辑行
var m_XLrow;   //小类编辑行 

//状态
var m_States = [{ "value": "0", "text": "无效" }, { "value": "1", "text": "有效" }];

//用户信息
var m_UserInfo = parent.m_UserInfo;

// 过滤条件
var m_Filter = '';  //主的条件
var m_Filter1 = ''; //查询条件
var m_OrderBy = ''; //排序方式
var m_OrderBy1 = 'typecode, seq'; //排序方式



/***********************************************************************
 *  初始化设置
 *  DLY 
 */
$(function () {

    //设置列表
    setDataGrid(m_UserInfo.actor);

    //权限
    m_Filter = ' AND 1 = 2 ';
    if (m_UserInfo.actor == 'E') {
        $('#tool1').show(); //可编辑大类-显示 
        $(m_DatagridID1).datagrid('showColumn', "typecode"); //可调整小类列表中的大类编码-显示
        m_Filter = '';
    } else {
        $('#tool1').hide(); //不可编辑大类-隐藏
        m_Filter = ' AND sadd01 like \'%' + m_UserInfo.actor + '%\''; 
    }

    //初始化条件
    actDLQuery();
    
});
 

/***********************************************************************
 *  添加大类
 *  DLY 
 */
function actADD() {
    //保存 
    if (!actSave()) {
        return false;
    }
    $(m_DatagridID).datagrid('appendRow', {
        id:dataUtil_NewGuid(),
        code: '',
        name: '',
        status: '1'
    });
    m_LastIndex = $(m_DatagridID).datagrid('getRows').length - 1;
    $(m_DatagridID).datagrid('selectRow', m_LastIndex);
    $(m_DatagridID).datagrid('beginEdit', m_LastIndex); 
    $(m_DatagridID1).datagrid('loadData', []);
} 
 

/***********************************************************************
 *  保存大类
 *  DLY 
 */
function actSave() {
    var flag = true;
    var cXMLd = GetEditJson([], [], []);//json转xml
    if (m_LastIndex != undefined) {
        $(m_DatagridID).datagrid('endEdit', m_LastIndex); 
        $(m_DatagridID).datagrid('selectRow', m_LastIndex);
    }
    var rows = $(m_DatagridID).datagrid('getChanges');
    if (rows.length == 0) {
        return flag;
    } 
    var srow = $(m_DatagridID).datagrid('getSelected');
    if (rows[0].id != srow.id) {
        alert('数据不一致，请刷新数据后重试！')
        flag = false;
    } else { 
        var drows = $(m_DatagridID1).datagrid('getRows');
        if (drows.length > 0) {
            if (drows[0].typecode != srow.code) {
                alert(srow.code + "大类存在对应的小类, 不允许再调整大类编码！");
                flag = false;
            }
        }  
        if (flag) {
            //以下拼接修改记录信息json
            var saverows = [];
            // 新增
            if (dataUtil_undefinedOrNull(srow.lmdt, '') == '') {
                srow.lmdt = dateUtil_dateFomaterA(new Date(), '-')
                srow.lmuser = m_UserInfo.userName;
                saverows.push(srow);
                cXMLd = GetEditJson(saverows, [], []);
            } else { //修改
                srow.lmdt = dateUtil_dateFomaterA(new Date(), '-')
                srow.lmuser = m_UserInfo.userName;
                saverows.push(srow);
                cXMLd = GetEditJson([], saverows, []);
            }
            flag = hr_saveSYSCode(cXMLd, m_UserInfo.UserName, "SaveSYSCodeClass");
        }
    } 
    
    if (!flag) {
        $(m_DatagridID).datagrid('beginEdit', m_LastIndex);
    } else {  
        $(m_DatagridID).datagrid('loadData', $(m_DatagridID).datagrid('getRows'));
    } 
    return flag;

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
    if (row.code == '') {
        alert('请先填写大类编码！');
        return false;
    }
    $(m_DatagridID1).datagrid('endEdit', m_LastIndex1); 
    $(m_DatagridID1).datagrid('appendRow', {
        id: dataUtil_NewGuid(),
        typecode: row.code,
        code: '',
        name: '',
        status: '1',
        lmdt: dateUtil_dateFomaterA(new Date(), '-'),
        lmuser: m_UserInfo.userName
    });
    m_LastIndex1 = $(m_DatagridID1).datagrid('getRows').length - 1;
    $(m_DatagridID1).datagrid('selectRow', m_LastIndex1);
    $(m_DatagridID1).datagrid('beginEdit', m_LastIndex1);
} 


/***********************************************************************
 *  保存小类
 *  DLY 
 */
function actSave1(flag) {
    var row = $(m_DatagridID).datagrid('getSelected');
    if (flag == false && m_LastIndex1 != undefined) {
        $(m_DatagridID1).datagrid('endEdit', m_LastIndex1);
        return false;
    }
    //以下拼接修改记录信息json
    if ($(m_DatagridID1).datagrid('getChanges').length > 0) {
        var inserted = $(m_DatagridID1).datagrid('getChanges', "inserted");
        var updated = $(m_DatagridID1).datagrid('getChanges', "updated");
        var deleted = $(m_DatagridID1).datagrid('getChanges', "deleted");
        for (var i = 0; i < updated.length; i++) {
            updated[i].lmdt = dateUtil_dateFomaterA(new Date(), '-')
            updated[i].lmuser = m_UserInfo.userName;
        }
        var cXMLx = GetEditJson(inserted, updated, deleted);//json转xml 
        hr_saveSYSCode(cXMLx, m_UserInfo.UserName, "SaveSYSCodeItem");
        actLoadXL();
    } 
}
 


/***********************************************************************
 *  查询大类(模糊查询编码或名称)
 *  DLY 
 */
function actDLQuery() {
    var cons = '';
    var dl = $('#cxDLName').val(); 
    if (dl != '') {
        cons = ' AND ( Code LIKE \'%' + dl + '%\''
                 + ' OR Name LIKE \'%' + dl + '%\' ) ';
    }
    cons = m_Filter + cons;
    m_DLList = hr_getDBCode(cons, '1', '50', m_OrderBy, 'GetSYSCodeClass');
    $(m_DatagridID).datagrid('clearSelections');
    $(m_DatagridID).datagrid('loadData', m_DLList); 
    actLoadXL();
}


/***********************************************************************
 *  加载小类
 *  DLY 
 */
function actLoadXL() { 
    var row = $(m_DatagridID).datagrid('getSelected');
    if (!row) {
        $(m_DatagridID1).datagrid('loadData', []);
        return false;
    }
    //关联显示小类
    var cons = ' AND typecode =\'' + row.code + '\'';
    m_XLList = hr_getDBCode(cons, '1', '1000', m_OrderBy1, 'GetSYSCodeItem');
    $(m_DatagridID1).datagrid('clearSelections');
    $(m_DatagridID1).datagrid('loadData', m_XLList);
}



/***********************************************************************
 *  设置列表
 *  DLY 
 */
function setDataGrid(actor) {
    if (actor == 'E') {
        //大类列表设置
        $(m_DatagridID).datagrid({
            //title:'列表',  
            height: 400,
            nowrap: true,
            striped: false,
            collapsible: true,
            sortName: 'code',
            sortOrder: 'asc',
            data: m_DLList,
            remoteSort: false,
            idField: 'id',
            frozenColumns: [[

            ]],
            columns: [[
                { field: 'id', title: 'id', width: 100, hidden: true },
                { field: 'code', title: '大类编码', width: 130, sortable: true, editor: 'text' },
                { field: 'name', title: '大类名称', width: 130, sortable: true, editor: 'text' },
                {
                    field: 'status', title: '状态', width: 60
                    , editor: {
                        type: 'combobox', options: {
                            valueField: 'value', textField: 'text',
                            editable: false, panelHeight: "60",
                            data: m_States
                        }
                    }
                   , formatter: function (val, row, index) {
                       return dataUtil_getCodename(m_States, val, 'value', 'text');
                   }
                },
                { field: 'sadd01', title: '权限', width: 70, editor: 'text', hidden: true },
                { field: 'sadd02', title: '属性2', width: 100, editor: 'text' },
                { field: 'sadd03', title: '属性3', width: 100, editor: 'text' },
                { field: 'sadd04', title: '属性4', width: 100, editor: 'text' },
                { field: 'sadd05', title: '属性5', width: 160, editor: 'text' },
                { field: 'Remark', title: '备注', width: 160, editor: 'text' }
            ]],
            pagination: false,
            rownumbers: true,
            singleSelect: true,
            onClickRow: function (rowIndex, data) {
                //保存
                if (!actSave()) {
                    return false;
                }
                $(m_DatagridID).datagrid('selectRow', rowIndex);
                $(m_DatagridID).datagrid('beginEdit', rowIndex);
                m_LastIndex = rowIndex;
                //关联显示小类
                actLoadXL();
            }

        });
    } else {
        //大类列表设置
        $(m_DatagridID).datagrid({
            //title:'列表',  
            height: 400,
            nowrap: true,
            striped: false,
            collapsible: true,
            sortName: 'code',
            sortOrder: 'asc',
            data: m_DLList,
            remoteSort: false,
            idField: 'id',
            frozenColumns: [[

            ]],
            columns: [[
                { field: 'id', title: 'id', width: 100, hidden: true },
                { field: 'code', title: '大类编码', width: 130, sortable: true},
                { field: 'name', title: '大类名称', width: 130, sortable: true},
                { field: 'status', title: '状态', width: 60 
                   , formatter: function (val, row, index) {
                       return dataUtil_getCodename(m_States, val, 'value', 'text');
                   }
                },
                { field: 'sadd01', title: '权限', width: 70},
                { field: 'sadd02', title: '属性2', width: 100},
                { field: 'sadd03', title: '属性3', width: 100},
                { field: 'sadd04', title: '属性4', width: 100},
                { field: 'sadd05', title: '属性5', width: 160},
                { field: 'Remark', title: '备注', width: 160}
            ]],
            pagination: false,
            rownumbers: true,
            singleSelect: true,
            onClickRow: function (rowIndex, data) {  
                m_LastIndex = rowIndex;
                //关联显示小类
                actLoadXL();
            }

        });
    } 

    //小类列表设置
    $(m_DatagridID1).datagrid({
        //title:'列表', 
        height: 400,
        nowrap: true,
        striped: false,
        collapsible: true,
        sortName: 'seq',
        sortOrder: 'asc',
        remoteSort: false,
        idField: 'id',
        frozenColumns: [[

        ]],
        columns: [[
            { field: 'id', title: 'id', width: 100, hidden: true },
            { field: 'typecode', title: '大类编码', width: 130, editor: 'text', hidden: true },
			{ field: 'code', title: '小类编码', width: 130, sortable: true, editor: 'text' },
			{ field: 'name', title: '小类名称', width: 160, sortable: true, editor: 'text' },
			{ field: 'seq', title: '排序', width: 60, sortable: true, editor: 'text' },
			{
			    field: 'status', title: '状态', width: 70
                , editor: {
                    type: 'combobox', options: {
                        valueField: 'value', textField: 'text',
                        editable: false, panelHeight: "70",
                        data: m_States
                    }
                }
               , formatter: function (val, row, index) {
                   return dataUtil_getCodename(m_States, val, 'value', 'text');
               }
			},
            { field: 'sadd01', title: '属性1', width: 100, editor: 'text' },
            { field: 'sadd02', title: '属性2', width: 100, editor: 'text' },
            { field: 'sadd03', title: '属性3', width: 100, editor: 'text' },
            { field: 'sadd04', title: '属性4', width: 100, editor: 'text' },
            { field: 'sadd05', title: '属性5', width: 160, editor: 'text' },
            { field: 'Remark', title: '备注', width: 160, editor: 'text' }
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
                actSave1(true);
            }
        }
    });
}
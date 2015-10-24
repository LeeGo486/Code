
var m_DatagridID = '#BMlb'; //部门列表ID
var m_LastIndex = undefined;  //部门列表最后一次编辑行下标  

var m_DatagridID1 = '#XMlb'; //项目列表ID
var m_LastIndex1 = undefined;  //项目列表最后一次编辑行下标  

//部门
var m_Depts = [];
 

//基础数组 
var m_ModelTypes = [] //科目模板类别  
var m_XMList = [];  //小类数组 
var m_Coms = [];  //公司
var m_Brands = []; //品牌

//状态
var m_States = [{ "text": "启用" }, { "text": "禁用" }];
var m_Configs = [{ "text": "已配置" }, { "text": "全部" }];//状态  
var m_YesOrNo = [{ "text": "是" }, { "text": "否" }];

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
      
    //基础数据获取   
    var Comid = peoa_GetBDFID(14);//公司
    var Brandid = peoa_GetBDFID(15);//品牌
    var ModelTypeid = peoa_GetBDFID(18);//科目模板类别 
    var cons = ' AND CT1_FatherID in ('
             + '\'' + Comid + '\', ' + '\'' + Brandid + '\', '
             + '\'' + ModelTypeid + '\''
             + ') AND CT1_State=\'启用\'';
    var res = basedata_getBDCommon('gbd12', cons);
    for (var i = 0; i < res.length; i++) {
        var f1 = res[i].ct1_fatherid.toUpperCase();
        if (f1 == ModelTypeid.toUpperCase()) {
            res[i].text = res[i].ct1_code + '/' + res[i].ct1_codename;
            m_ModelTypes.push(res[i]);
        } else if (f1 == Comid.toUpperCase()) {
            m_Coms.push(res[i]);
        } else if (f1 == Brandid.toUpperCase()) { 
            m_Brands.push(res[i]); 
        }
    }   

    $('#cxConfig').combobox({
        panelWidth: "90",
        panelHeight: "80",
        editable: false,
        multiple: false,
        valueField: 'text',
        textField: 'text',
        data: m_Configs,
        onChange: function (data) {
            actDeptsQuery('2');
        }
    });
    

     
    //组织架构级联树  
    var depttree = [];
    $('#cxDeptID').combotree('setValue', '');
    //部门查询 下拉框设置
    $('#cxDeptID').combotree({ 
        panelWidth: "240",
        panelHeight: "450",
        animate: true,
        onlyLeafCheck: true,
        editable: true,
        idField: 'id',
        textField: 'text',
        data: depttree,
        onChange: function (data) {
            actDeptsQuery('0');
        },
        onBeforeExpand: function (node, param) { 
            var t = $('#cxDeptID');  
            t.tree('append',{
                parent:node.target,
                data:[]
            }); 
        },
        onShowPanel: function (rowIndex) {
            if (depttree.length == 0) {
                var cXML = '<Page>0</Page><Num>0</Num>'
                   + '<Cons> AND OZ1_State=\'启用\'</Cons><OrderBy></OrderBy>'
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
                        depttree = data1;
                    }
                });
                $('#cxDeptID').combotree('loadData', depttree);
                $('#cxDeptID').combotree('tree').tree('collapseAll');
            }
        }
    });
   
     
     
    

    //部门列表设置
    $(m_DatagridID).datagrid({
        //title:'列表', 
        //width: 500,
        height: 470,
        nowrap: true,
        striped: false,
        collapsible: true,
        //sortName: 'oz1_orgname',
        //sortOrder: 'asc',
        data: m_Depts,
        remoteSort: false,
        idField: 'oz1_id',
        frozenColumns: [[

        ]],
        columns: [[
            { field: 'oz1_id', title: 'oz1_id', width: 100, hidden: true },
            { field: 'oz1_orgcode', title: '部门代码', width: 150, hidden: true },
            { field: 'oz1_orgname', title: '部门名称', width: 130, sortable: true },
            { field: 'oz1_costcentercode1', title: '成本中心', width: 70, editor: 'text' },
            { field: 'oz1_brand', title: '品牌', width: 60, sortable: true
                , editor: {
                    type: 'combobox', options: {
                        valueField: 'ct1_code', textField: 'ct1_code',
                        editable: false, panelHeight: "100",
                        data: m_Brands
                    }
                }
            },
            { field: 'oz1_com', title: '公司', width: 70, sortable: true
                , editor: {
                    type: 'combobox', options: {
                        valueField: 'ct1_codename', textField: 'ct1_codename', 
                        multiple: true, editable: false, panelHeight: "100",
                        data: m_Coms
                    }
                }
            },
            { field: 'oz1_bmmoney', title: '预算总金额', width: 100, align: "right"
                , editor: { type: 'numberbox', options: { precision: 0} }  
            },
            { field: 'oz1_modeltype', title: '科目模板', width: 70
                , editor: {
                    type: 'combobox', options: {
                        valueField: 'ct1_id', textField: 'text',
                        editable: false, panelHeight: "100",
                        data: m_ModelTypes
                    }
                }
                , formatter: function (val) { 
                    return basedata_getCodename(m_ModelTypes, val, 'ct1_id', 'text');
                }
            },
            { field: 'oz1_bmper', title: '预算专员', width: 100, editor: 'text', sortable: true },
            {
                field: 'oz1_isbranch', title: '是否大区', width: 80, sortable: true
                , editor: {
                    type: 'combobox', options: {
                        valueField: 'text', textField: 'text',
                        editable: false, panelHeight: "80",
                        data: m_YesOrNo
                    }
                }
            },
            { field: 'oz1_com1', title: '公司1', width: 160, sortable: true},
            { field: 'oz1_fatherid', title: 'oz1_fatherid', width: 100, hidden: true }
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
            //关联显示项目
            actXMQuery();
        }, onAfterEdit: function (rowIndex, rowData, changes) {  
            if (jsonUtil_jsonToStr(changes) != '{}') {
                actSave(rowData);
            }
            
        }

    });


    //项目列表设置
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
            { field: 'ct1_fieldvalues1', title: 'ct1_fieldvalues1', width: 100, hidden: true },
            { field: 'ct1_cono', title: 'ct1_cono', width: 100, hidden: true },
            { field: 'ct1_divi', title: 'ct1_divi', width: 100, hidden: true },
			{ field: 'ct1_code', title: '项目编码', width: 80, sortable: true, editor: 'text' },
			{ field: 'ct1_codename', title: '项目名称', width: 200, sortable: true, editor: 'text' },
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

    //项目选择列表设置
    $('#TypeXMlb').datagrid({
        height: 300,
        nowrap: true,
        striped: false,
        collapsible: true,
        remoteSort: false,
        idField: 'xmid',
        sortName: 'oz1_brand',
        sortOrder: 'asc',
        frozenColumns: [[
        ]],
        columns: [[
		    { field: 'ck', checkbox: true },
            { field: 'xmid', title: 'xmid', width: 100, hidden: true },
			{ field: 'oz1_brand', title: '品牌', width: 80, sortable: true },
			{ field: 'ct1_code', title: '项目编码', width: 100, sortable: true },
			{ field: 'ct1_codename', title: '项目名称', width: 260, sortable: true }
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
 *  保存部门
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
    var curl = GetWSRRURL(peoa_GetWSRRURL(11));
    //修改
    curl = curl + "&type=UpdDept&actor=" + m_UserInfo.UserName; 
    updrow.oz1_lmdt = dateUtil_dateFomaterA(new Date(), '-');
    updrow.oz1_lmuser = m_UserInfo.UserName;
    if (updrow.oz1_bmmoney * 1 <= 0) {
        updrow.oz1_bmmoney = 0;
    } 
    var rowInfo = [];
    rowInfo.push(updrow);
    var cXML = GetEditJson(rowInfo, [], []); //json转xml  
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
 *  添加项目
 *  DLY 
 */
function actADD1() {
    var row = $(m_DatagridID).datagrid('getSelected');
    if (!row) {
        alert('请先选择一个部门！');
        return false;
    } 
    $(m_DatagridID1).datagrid('endEdit', m_LastIndex1); 
    $(m_DatagridID1).datagrid('appendRow', {
        ct1_id: '',
        ct1_fatherid: row.oz1_id,
        ct1_fieldvalues1: 'XM',
        ct1_code: '',
        ct1_codename: '',
        ct1_state: '启用',
        ct1_cono: basedata_getCommonData('CONOT'),
        ct1_divi: basedata_getCommonData('DIVI')
    });
    m_LastIndex1 = $(m_DatagridID1).datagrid('getRows').length - 1;
    $(m_DatagridID1).datagrid('selectRow', m_LastIndex1);
    $(m_DatagridID1).datagrid('beginEdit', m_LastIndex1);
}
 

/***********************************************************************
 *  保存项目
 *  DLY 
 */
function actSave1(updrow) { 
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
    });
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
 *  查询项目(模糊查询编码或名称) 到数据库
 *  DLY 
 */
function actXMQuery() {
    var row = $(m_DatagridID).datagrid('getSelected');
    if (!row) {
        return false;
    }
    var cons = ' AND CT1_FatherID = \'' + row.oz1_id + '\'  ';
    cons = cons + ' AND ISNULL(CT1_FieldValues1,\'\') = \'XM\' ';
    var cxXMName = $('#cxXMName').attr('value');
    if (cxXMName != '') {
        cons = cons + ' AND ( CT1_CodeName like \'%' + cxXMName + '%\' OR '
             + ' CT1_Code like \'%' + cxXMName + '%\' )';
    }

    m_XMList = basedata_getBDCommon('gbd12', cons);
    if (m_XMList[0].ct1_id == '') {
        $(m_DatagridID1).datagrid('loadData', []);
    } else {
        $(m_DatagridID1).datagrid('loadData', m_XMList);
    }
}
 

/***********************************************************************
 *  查询相关部门 
 *  下拉选择查询当前及下属，  回车或点击查询获取名称模糊查询
 *  DLY 
 */
function actDeptsQuery(type) {
    var orderby = '';
    var cons = '';
    if ($('#cxConfig').combobox("getValue") == '已配置') {
        cons = ' AND ISNULL(oz1_bmper,\'\') NOT IN (\'\') ';
    }
    if (type == '2') {
       $('#cxDeptID').combotree("setValue", '')

    } else if (type == '1') {
        if($('#cxDeptID').combotree('getText') != ''){
            cons = cons + ' AND oz1_orgname LIKE \'%' + $('#cxDeptID').combotree('getText') + '%\'';
        }  
    } else if (type == '0') {
        if ($('#cxDeptID').combotree("getValue") != '') {
            cons = cons +' AND ( oz1_fatherid = \'' + $('#cxDeptID').combotree("getValue")
             + '\' OR oz1_orgcode = \'' + $('#cxDeptID').combotree("getValue")
             + '\')';
            orderby = 'ORDER BY CASE WHEN oz1_orgcode = \'' + $('#cxDeptID').combotree("getValue") + '\' THEN 0 ELSE 1 END ASC '
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
                //alert(data);
                var data1 = eval('(' + data + ')');
                if (data1.rows) {
                    m_Depts = data1.rows;
                }
            }
        });
    }
    
    if (cons == '' || m_Depts.length==0 || m_Depts[0].oz1_id==undefined || m_Depts[0].oz1_id == '') {
        $(m_DatagridID).datagrid('loadData', []);
    } else {
        $(m_DatagridID).datagrid('loadData', m_Depts);
    }
}
 

/***********************************************************************
 *  添加项目(项目选择窗)
 *  DLY 
 */
function actADD2() {
    var row = $(m_DatagridID).datagrid('getSelected');
    if (!row) {
        alert('请先选择一个部门！');
        return false;
    } 
    $('#xmdlg').dialog('open');  
    $('#cxXMkey').attr('value', ''); 
    $('#TypeXMlb').datagrid('loadData', []);
    actXMQuery2(); 
}


/***********************************************************************
 *  选择窗 查询项目(模糊查询品牌/编码/名称) 到数据库
 *  DLY 
 */
function actXMQuery2() {
    var cxtext = $('#cxXMkey').attr('value');
    var cons = '';
    var orderby = '';
    if (cxtext != '') {
        cons = cons + ' AND B.OZ1_Brand+\'-\'+A.CT1_Code+\'-\'+A.CT1_CodeName like \'%' + cxtext + '%\'';
    } 
    var cXML = '<Page>' + '1' + '</Page><Num>' + '200' + '</Num>'
        + '<Cons>' + cons + '</Cons><OrderBy>' + orderby + '</OrderBy>';
    cXML = basedata_addROOT(cXML);
    var curl = GetWSRRURL(peoa_GetWSRRURL(2)) + "&type=gbckxm&XML=" + encodeURIComponent(cXML); //拼接url 
    $.ajax({
        url: curl,
        options: "JSON",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(data.rows);
            if (data && data.rows) { 
                $('#TypeXMlb').datagrid('loadData', data.rows);
            }
        }
    });
    $('#TypeXMlb').datagrid('clearSelections');
}


/***********************************************************************
 *  保存选择窗选择项目
 *  DLY 
 */
function actSave2() { 
    $(m_DatagridID1).datagrid('endEdit', m_LastIndex1);
    actXMQuery();
    var flag = 0;
    var row = $(m_DatagridID).datagrid('getSelected');
    var rows1 = $(m_DatagridID1).datagrid('getRows');
    var rows2 = $('#TypeXMlb').datagrid('getSelections'); 
    var addrows = [];
    for (var i = 0; i < rows2.length; i++) {
        var f = 0;
        for (var j = 0; j < rows1.length; j++) {
            if (rows2[i].ct1_code == rows1[j].ct1_code && rows2[i].ct1_codename == rows1[j].ct1_codename) {
                f = 1;
                break;
            }
        }
        if (f == 0) {
            var newrow = {}; 
            newrow.ct1_id = dataUtil_NewGuid();
            newrow.ct1_fatherid = row.oz1_id,
            newrow.ct1_code = rows2[i].ct1_code,
            newrow.ct1_codename = rows2[i].ct1_codename,
            newrow.ct1_state = '启用',
            newrow.ct1_fieldvalues1 = 'XM',
            newrow.ct1_cono = basedata_getCommonData('CONOT'),
            newrow.ct1_divi = basedata_getCommonData('DIVI'),
            newrow.ct1_rguser = m_UserInfo.UserName; 
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
    }); 
    $('#xmdlg').dialog('close');
}
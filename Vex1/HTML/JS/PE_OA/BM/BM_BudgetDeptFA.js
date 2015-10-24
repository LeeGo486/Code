var m_DatagridID = '#Budgetlb'; //预算列表ID
var m_LastIndex = undefined;  //预算列表最后一次选中行下标 
var m_PageNumber = 1;  //当前页码
var m_PageSize = 20;  //每页显示行数


//固定资产类别数组
var m_DLList = [];
var m_XLList = [];

//用户信息
var m_UserInfo = basedata_getUserInfo();

//状态
var m_States = [{ "text": "启用" }, { "text": "禁用" }];

//行动计划
var m_PlanUse = [];

//年份
var m_Years = [{ "text": "2014" }, { "text": "2015" }, { "text": "2016" }, { "text": "2017" }, { "text": "2018" }];

//基础数据
var m_Coms = [];  //公司
var m_Brands = []; //品牌
var m_CostCenters = [];  //成本中心

// 过滤条件
var m_Filter = '';  //主的条件
var m_Filter1 = ''; //查询条件
var m_Filter2 = ''; //主记录条件
var m_OrderBy = ' ORDER BY BG1_CONO, BG1_Years, BG1_CenterCode, BG1_LargeClassCode, BG1_SmallClassCode, BG1_AssetsName '; //排序方式

//主条件切换时，是否放弃数据保存标志， 品牌，大小类，年份切换时用
var m_changeFlag = 0;
var m_Role = 'A'; //操作员身份
var m_FuncType = 'BZ'; //功能页面打开方式
var m_BillInfo = ''; //审批记录信息
var m_EditFlag = 0; //是否可编辑状态




/***********************************************************************
 *  初始化设置
 *  DLY 
 */
$(function () {
    // 当窗口大小发生变化时，调整DataGrid的大小
    $(window).resize(function () {
        //根据index.html页面的高度设置列表高度 
        $(m_DatagridID).datagrid('resize', {
            width: $(document.body).width(),
            height: getcurheight()
        });
    });

    //确认操作员
    for (var i = 0; i < m_UserInfo.roles.length; i++) {
        var authorization_text = m_UserInfo.roles[i].authorization_name;
        var authorization_id = m_UserInfo.roles[i].authorization_id;
        if (authorization_text == '预算专员') {
            m_Role = 'A'
        } else if (authorization_text == '固定资产预算专员') {
            m_Role = 'B';
            break;
        }
    }

    //审批记录 
    if (dataUtil_undefinedOrNull(basedata_getUrlParam("v0"), '') == 'sp') {
        m_FuncType = 'SP';
        var fid = basedata_getUrlParam("v1");
        var cons_sp = ' AND BG4_id = \'' + fid + '\' ';
        var cXML_sp = '<Page>1</Page><Num>1</Num>'
                 + '<Cons>' + cons_sp + '</Cons><OrderBy>' + '' + '</OrderBy>';
        cXML_sp = basedata_addROOT(cXML_sp);
        var curl_sp = GetWSRRURL(peoa_GetWSRRURL(14)) + "&type=GetApH&XML=" + encodeURIComponent(cXML_sp)
                 + "&s=" + new Date().getTime();//拼接url 
        $.ajax({
            url: curl_sp,
            type: "GET",
            async: false,
            dataType: "json",
            success: function (data) {
                if (data && data.rows && data.rows.length > 0) {
                    if (dataUtil_undefinedOrNull(data.rows[0].bg4_id, '') != '') {
                        m_BillInfo = data.rows[0];
                    }
                }
            }
        });
    }

    //初始化赋值
    var cxml = '';
    $('#cxBrand').attr('value', '');
    $('#cxYear').combobox('setValue', basedata_getBMYear());

    //基础数据获取
    var Brandid = peoa_GetBDFID(15);//品牌  
    var PlanUseid = peoa_GetBDFID(6);//行动计划 
    var DLListid = peoa_GetBDFID(13);//资产大类  
    var cons = ' AND CT1_FatherID in ('
             + '\'' + Brandid + '\',' + '\'' + PlanUseid + '\','
             + '\'' + DLListid + '\''
             + ')';
    var res = basedata_getBDCommon('gbd12', cons);
    for (var i = 0; i < res.length; i++) {
        var f1 = res[i].ct1_fatherid.toUpperCase();
        if (f1 == Brandid.toUpperCase()) {
            m_Brands.push(res[i]);
        } else if (f1 == PlanUseid.toUpperCase()) {
            m_PlanUse.push(res[i]);
        } else if (f1 == DLListid.toUpperCase()) {
            m_DLList.push(res[i]);
        }
    }




    //大类名称
    $('#cxDLMC').combobox({
        panelWidth: "150",
        panelHeight: "100",
        editable: true,
        multiple: false,
        valueField: 'ct1_code',
        textField: 'ct1_codename',
        data: m_DLList
    });
    $('#cxDLMC').combobox('loadData', m_DLList);

    //小类名称
    $('#cxXLMC').combobox({
        panelWidth: "155",
        panelHeight: "100",
        editable: true,
        multiple: false,
        valueField: 'codename',
        textField: 'codename',
        onShowPanel: function (rowIndex) {
            //重新小类信息                       
            if ($('#cxDLMC').combobox('getValue') == '') {
                $('#cxXLMC').combobox('loadData', []);
            } else {
                $('#cxXLMC').combobox('loadData', basedata_getBDX('gbd2', basedata_getCommonData('CONOT')
                    , basedata_getCommonData('DIVI'), '2', '启用', 'FAClaseType', $('#cxDLMC').combobox('getValue'), '', ''));
            }
        }
    });

    //所属公司
    $('#cxCom').combobox({
        panelWidth: "130",
        panelHeight: "100",
        editable: true,
        multiple: false,
        valueField: 'text',
        textField: 'text',
        data: m_Coms,
        onShowPanel: function () {
            $('#cxCom').combobox("loadData", m_Coms);
        }

    });

    //获取部门数组 编制和审批
    if (m_FuncType == 'BZ') {
        // 部门获取通过预算专员
        m_UserInfo.depts = [];
        var cons = ' AND OZ1_State=\'启用\'  AND OZ1_BMPer LIKE \'%|' + m_UserInfo.UserName + '|%\' ';
        var cXML = '<Page>' + '' + '</Page><Num>' + '' + '</Num>'
            + '<Cons>' + cons + '</Cons><OrderBy>' + '' + '</OrderBy>';
        cXML = basedata_addROOT(cXML);
        var curl = GetWSRRURL(peoa_GetWSRRURL(11)) + "&type=GetOrgs&XML=" + encodeURIComponent(cXML)
            + "&s=" + new Date().getTime();  //拼接url   
        $.ajax({
            url: curl,
            options: "JSON",
            async: false,
            success: function (data) {
                m_UserInfo.depts = [];
                var data1 = eval('(' + data + ')');
                if (data1.rows && dataUtil_undefinedOrNull(data1.rows[0].oz1_id, '') != '') {
                    m_UserInfo.depts = data1.rows;
                }
            }
        });
    } else if (m_FuncType == 'SP') {
        // 部门获取通过记录部门
        var cons = ' AND OZ1_OrgCode=\'' + m_BillInfo.bg4_deptid + '\' ';
        var cXML = '<Page>0</Page><Num>0</Num>'
                  + '<Cons>' + cons + '</Cons><OrderBy></OrderBy>'
        cXML = basedata_addROOT(cXML);
        //alert(cXML);	
        var curl = GetWSRRURL(peoa_GetWSRRURL(11)) + "&type=GetOrgs&XML=" + encodeURIComponent(cXML)
            + "&s=" + new Date().getTime();  //拼接url   
        $.ajax({
            url: curl,
            options: "JSON",
            async: false,
            success: function (data) {
                //alert(data);
                m_UserInfo.depts = [];
                var data1 = eval('(' + data + ')');
                if (data1.rows[0]) {
                    m_UserInfo.depts.push(data1.rows[0]);
                }
            }
        });
    }

    //部门 下拉框设置
    if (m_UserInfo.depts.length == 1) {
        $('#cxDept').combobox({
            panelWidth: "155",
            panelHeight: "130",
            animate: true,
            onlyLeafCheck: true,
            editable: false,
            multiple: false,
            valueField: 'oz1_orgcode',
            textField: 'oz1_orgname',
            data: m_UserInfo.depts
        });
        m_deptchoose = m_UserInfo.depts[0];
        $('#cxDept').combobox('disable');
        $('#cxDept').combobox('setValue', m_UserInfo.depts[0].oz1_orgcode);
        $('#cxBrand').val(m_deptchoose.oz1_brand); //设置品牌 
        changeDept(m_UserInfo.depts[0].oz1_orgcode);
    } else {
        $('#cxDept').combobox({
            panelWidth: "155",
            panelHeight: "130",
            animate: true,
            onlyLeafCheck: true,
            editable: false,
            valueField: 'oz1_orgcode',
            textField: 'oz1_orgname',
            data: m_UserInfo.depts,
            onSelect: function (data) {
                m_deptchoose = data;
                $('#cxBrand').val(m_deptchoose.oz1_brand); //设置品牌 
                changeDept(m_deptchoose.oz1_orgcode);
                //重新加载数据
                searchByCons();
            },
            onChange: function (newValue, oldValue) {

            },
            onShowPanel: function (rowIndex) {
                //actContralSave('combo', '#cxDept');
            }
        });
    }
      
    actyslbcsh(m_DatagridID);

    searchByCons();

    //鼠标单击后事件设置选中行合计金额
    document.onmouseup = function (e) {
        getRowTotal(m_LastIndex, 'dg');
        return true;
    }

});


/***********************************************************************
 *  清除按钮事件：清除查询条件
 *  DLY
 *  2013-05-25
 */
function clearText() {
    $('#cxCostCenter').attr('value', ''); 
    $('#cxCom').combobox('setValue', '');  
    $('#cxDLMC').combobox('setValue', '');
    $('#cxXLMC').combobox('setValue', '');
}

/***********************************************************************
 *  查询按钮事件：根据条件查询
 *  DLY
 *  2013-06-15
 */
function searchByCons() {
    $(m_DatagridID).datagrid("clearSelections");
    m_PageNumber = 1; 
    var cfilter = ''; 
    var sdept = $('#cxDept').combobox('getValue');
    var syear = $('#cxYear').combobox('getValue');
    var sbrand = $('#cxBrand').attr('value');

    if (syear == '' || sbrand == '' || sdept == '') {
        cfilter = ' AND 1=2 ';
    } else { 
        cfilter = cfilter + ' AND bg1_years = \'' + syear + '\'';
        cfilter = cfilter + ' AND bg1_brand = \'' + sbrand + '\'';
        cfilter = cfilter + ' AND bg1_deptid = \'' + sdept + '\'';
    }

    m_Filter2 = cfilter; 
    
    if ($('#cxCostCenter').attr('value') != '') {
        cfilter = cfilter + ' AND bg1_centercode LIKE \'%' + $('#cxCostCenter').attr('value') + '%\'';
    } 
    if ($('#cxCom').combobox('getValue') != '') {
        cfilter = cfilter + ' AND  bg1_com LIKE \'%' + $('#cxCom').combobox('getValue') + '%\'';
    } 
    if ($('#cxDLMC').combobox('getValue') != '') {
        cfilter = cfilter + ' AND  bg1_largeclassname = \'' + $('#cxDLMC').combobox('getText') + '\'';
    }
    if ($('#cxXLMC').combobox('getValue') != '') {
        cfilter = cfilter + ' AND  bg1_smallclassname LIKE \'%' + $('#cxXLMC').combobox('getText') + '%\'';
    } 
    m_Filter1 = cfilter; 
    actLoadData(m_PageNumber, m_PageSize);
}



/***********************************************************************
 *  刷新列表数据
 *  DLY
 *  2014-05-28
 */
function actLoadData(page, number) {  
    $(m_DatagridID).datagrid("clearSelections");
    $("#spanTatolpage").attr('value', 0);
    $("#spanTatolT").attr('value', 0);
    var totalCount = 0;
    m_PageNumber = page;
    m_PageSize = number;
    var cXML = '<Page>' + page + '</Page><Num>' + number + '</Num>'
             + '<Cons>' + m_Filter + m_Filter1 + '</Cons><OrderBy>' + m_OrderBy + '</OrderBy>';
    cXML = basedata_addROOT(cXML);
    var curl = GetWSRRURL(peoa_GetWSRRURL(5)) + "&type=Gets&XML=" + encodeURIComponent(cXML); //拼接url
    //alert(cXML);	
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        //contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            $(m_DatagridID).datagrid('loadData', []);
            if (data && data.rows) {
                if (dataUtil_undefinedOrNull(data.rows[0].totalnum, 0) == 0) {
                    $(m_DatagridID).datagrid('loadData', []);
                    totalCount = 0;
                } else {
                    $(m_DatagridID).datagrid('loadData', data.rows);
                    totalCount = dataUtil_undefinedOrNull(data.rows[0].totalnum, 0); 
                    $("#spanTatolT").attr('value', dataUtil_formatNum1(dataUtil_toFixed(data.rows[0].totalsum, 0), '0'));
                }
            }
        }
    })
    // 合计当前页金额  
    var sum = 0;
    var rows = $(m_DatagridID).datagrid('getRows');
    for (var i = 0; i < rows.length; i++) {
        sum = sum * 1 + rows[i].bg1_sureamount * 1;
    }
    $("#spanTatolpage").attr('value',dataUtil_formatNum1(dataUtil_toFixed(sum, 0), '0'));


    $('#cxpager').pagination({
        total: totalCount,
        pageNumber: page
    });

}


/***********************************************************************
 *  保存固定资产预算信息
 *  DLY 
 */
function actSave() {
    var flag = false;
    $(m_DatagridID).datagrid('endEdit', m_LastIndex);
    var dataRows = $(m_DatagridID).datagrid('getRows');
    var cXML1 = '';
    //以下拼接修改记录信息json
    if ($(m_DatagridID).datagrid('getChanges').length > 0) {
        if (dataRows.length>0 && !actSaveCheck()) {
            return flag;
        } 
        var gridDataChanges = [];
        var inserted = $(m_DatagridID).datagrid('getChanges', "inserted");
        var updated = $(m_DatagridID).datagrid('getChanges', "updated");
        var deleted = $(m_DatagridID).datagrid('getChanges', "deleted");
        for (var i = 0; i < inserted.length; i++) {
            inserted[i].otype = 'inserted';
            gridDataChanges.push(inserted[i]);
        }
        for (var i = 0; i < updated.length; i++) {
            updated[i].otype = 'updated';
            updated[i].bg1_lmuser = m_UserInfo.UserName;
            updated[i].bg1_lmdt = dateUtil_dateFomaterA(new Date(), '-');
            gridDataChanges.push(updated[i]);
        }
        for (var i = 0; i < deleted.length; i++) {
            var obj = new Object();
            obj.bg1_id = deleted[i].bg1_id;
            obj.otype = 'deleted';
            gridDataChanges.push(obj);
        }
        cXML1 = GetEditJson(gridDataChanges, [], []);//json转xml
        //alert(cXML1);
        /*
        for (var i = 0; i < inserted.length; i++) { 
            inserted[i].bg1_rguser = m_UserInfo.UserName;
            inserted[i].bg1_uptno = 0;
        }
        for (var i = 0; i < updated.length; i++) { 
            updated[i].bg1_lmdt = dateUtil_dateFomaterA(new Date(), '/')
            updated[i].bg1_lmuser = m_UserInfo.UserName;
            updated[i].bg1_uptno = updated[i].bg1_uptno * 1 + 1;
        }
        for (var i = 0; i < deleted.length; i++) { 
        } 
        cXML1 = GetEditJson(inserted, updated, deleted);//json转xml   
        */
    } else {
        alert('没有修改信息！');
        return flag;
    }
    var cxmlsJson = { XML: cXML1 };
    var curl = GetWSRRURL(peoa_GetWSRRURL(5)) + "&type=Save"; //拼接url
    //alert(cXML);	
    $.ajax({
        url: curl,
        type: "POST",
        async: false,
        data: cxmlsJson,
        //contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) { 
                if (data.rows[0].flag.toUpperCase() == 'TRUE') { 
                    actLoadData(m_PageNumber, m_PageSize);
                    flag = saveSPRow();
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


/***********************************************************************
 *  保存审批记录
 *  DLY 
 */
function saveSPRow() {
    var flag = false;
    var curlt = ''
    var cxmlsJsont = {};
    var rowt = {}; 
    //首次保存生成审批记录
    if ($("#spanbg4_id").html() == '') {
        rowt.bg4_id = dataUtil_NewGuid();
        rowt.bg4_state = '未提交';
        rowt.bg4_rguser = m_UserInfo.UserName;
        rowt.bg4_type = '3';
        rowt.bg4_year = $('#cxYear').combobox('getValue');
        rowt.bg4_brand = $('#cxBrand').attr('value');
        rowt.bg4_subject = rowt.bg4_year + '-' + $('#cxBrand').attr('value')
                          + '-' + $('#cxDept').combobox('getText') + '-' + '固定资产预算编制';
        var reg = new RegExp(",", "g");
        rowt.bg4_total = $("#spanTatolT").val().replace(reg, '') * 1;
        rowt.bg4_deptid = $('#cxDept').combobox('getValue');
        rowt.bg4_deptname = $('#cxDept').combobox('getText');
        curlt = GetWSRRURL(peoa_GetWSRRURL(14));
        curlt = curlt + "&type=NewApH&actor=" + m_UserInfo.UserName + "&s=" + new Date().getTime();
        var rowInfot = [];
        rowInfot.push(rowt);
        var cXMLt = GetEditJson(rowInfot, [], []); //json转xml   
        cxmlsJsont = { XML: cXMLt };
    } else if ($("#spanbg4_id").html() != '') {
        //修改总金额 begin
        rowt.bg4_id = $("#spanbg4_id").html();
        var reg = new RegExp(",", "g");
        rowt.bg4_total = $("#spanTatolT").val().replace(reg, '') * 1;
        var rowInfot = [];
        rowInfot.push(rowt);
        var cXMLt = GetEditJson(rowInfot, [], []); //json转xml   
        cxmlsJsont = { XML: cXMLt };
        curlt = GetWSRRURL(peoa_GetWSRRURL(14));
        curlt = curlt + "&type=SetApH&actor=" + m_UserInfo.UserName + "&s=" + new Date().getTime();
    }
    $.ajax({
        url: curlt,
        type: "POST",
        async: false,
        data: cxmlsJsont,
        dataType: "json",
        success: function (result) {
            try {
                //alert(jsonUtil_jsonToStr(result));
                if (result.Error) {
                    $.messager.alert("系统错误", result.Error, 'error');
                } else if (result.rows[0].result == "False") {
                    $.messager.alert("提示", result.rows[0].message, 'error');
                } else if (result.rows[0].result == "True") {
                    flag = true;
                    $("#spanbg4_id").html(rowt.bg4_id);
                }
            } catch (ex) {
                $.messager.alert("提示", ex, 'error');
            }
        },
        error: function () {
            $.messager.alert("提示", "保存主记录失败！", 'error');
        }
    });
    return flag;
}
 

/***********************************************************************
 *  保存校验固定资产预算信息
 *  DLY 
 */
function actSaveCheck() {
    var flag = false;
    $(m_DatagridID).datagrid('endEdit', m_LastIndex);
    var dataRows = $(m_DatagridID).datagrid('getRows');
    var j = 0;
    for (var i = 0; i < dataRows.length; i++) {
        j = i * 1 + 1;
        flag = false; 
        if (dataUtil_undefinedOrNull(dataRows[i].bg1_com, '') == '') {
            $.messager.alert("提示", '第' + j + '行的“公司”必填！'); 
            break;
        } 
        if (dataUtil_undefinedOrNull(dataRows[i].bg1_centercode, '') == '') {
            $.messager.alert("提示", '第' + j + '行的“成本中心”必填！');
            break;
        } 
        if (dataUtil_undefinedOrNull(dataRows[i].bg1_largeclassname, '') == '') {
            $.messager.alert("提示", '第' + j + '行的“资产大类”必填！');
            break;
        } 
        if (dataUtil_undefinedOrNull(dataRows[i].bg1_largeclasscode, '') == '') {
            $.messager.alert("提示", '第' + j + '行的“大类编码不能为空！');
            break;
        }
        if (dataUtil_undefinedOrNull(dataRows[i].bg1_smallclassname, '') == '') {
            $.messager.alert("提示", '第' + j + '行的“资产小类”必填！');
            break;
        }
        if (dataUtil_undefinedOrNull(dataRows[i].bg1_smallclasscode, '') == '') {
            $.messager.alert("提示", '第' + j + '行的“小类编码”不能为空！');
            break;
        }
        if (dataUtil_undefinedOrNull(dataRows[i].bg1_number, 0) <= 0) {
            $.messager.alert("提示", '第' + j + '行的“数量”必须大于0！');
            break;
        }
        if (dataUtil_undefinedOrNull(dataRows[i].bg1_price, 0) <= 0) {
            $.messager.alert("提示", '第' + j + '行的“资产单价”必须大于0！');
            break;
        }
        if (dataUtil_undefinedOrNull(dataRows[i].bg1_sureamount, 0) <= 0) {
            $.messager.alert("提示", '第' + j + '行的“总金额”必须大于0！');
            break;
        }
        if (dataUtil_undefinedOrNull(dataRows[i].bg1_planuse, '') == '') {
            $.messager.alert("提示", '第' + j + '行的“行动计划”必填！');
            break;
        } 
        flag = true;
    }
    if (!flag) {
        m_LastIndex = j * 1 - 1;
        if (m_LastIndex >= 0) {
            $(m_DatagridID).datagrid('selectRow', m_LastIndex);
            $(m_DatagridID).datagrid('beginEdit', m_LastIndex);
        }
    }
    return flag;
}


/***********************************************************************
 *  固定资产预算列表初始化
 *  DLY
 *  2014-04-28
 */
function actyslbcsh(dgid) {
    $(dgid).datagrid({
        //title:'预算列表', 
        //width: document.body.clientWidth,
        height: 480,
        nowrap: true,
        striped: false,
        collapsible: true,
        sortName: 'sid',
        sortOrder: 'asc',
        remoteSort: false,
        idField: 'bg1_id',
        frozenColumns: [[

        ]],
        columns: [[
            { field: 'sid', title: 'sid', width: 100, hidden: true },
			{ field: 'bg1_id', title: 'FID', width: 100, hidden: true },
            { field: 'bg1_cono', title: 'cono', width: 100, hidden: true },
            { field: 'bg1_divi', title: 'divi', width: 40, hidden: true },
            { field: 'bg1_years', title: '<input id=\"detailcheckbox\" type=\"checkbox\">&nbsp;&nbsp;年份', width: 60 },
            { field: 'bg1_brand', title: '品牌', width: 50 },
            { field: 'bg1_com', title: '公司', width: 80
                , editor: {
                    type: 'combobox', options: {
                        valueField: 'text', textField: 'text',
                        data: m_Coms, editable: false, panelHeight: "80",
                        onShowPanel: function () {
                            var ed = $(dgid).datagrid('getEditor', { index: m_LastIndex, field: 'bg1_com' });
                            $(ed.target).combobox("loadData", m_Coms);
                        }
                    }
                }
            },
            { field: 'bg1_deptid', title: '部门编码', width: 100, hidden: true },
            { field: 'bg1_deptname', title: '部门名称', width: 100, hidden: true },
            { field: 'bg1_centercode', title: '成本中心', width: 80
                , editor: {
                    type: 'combobox', options: {
                        valueField: 'text', textField: 'text',
                        data: m_CostCenters, editable: false, panelHeight: "80",
                        onShowPanel: function () {
                            var ed = $(dgid).datagrid('getEditor', { index: m_LastIndex, field: 'bg1_centercode' });
                            $(ed.target).combobox("loadData", m_CostCenters);
                        }
                    }
                }
            },
			{
			    field: 'bg1_largeclassname', title: '资产大类', width: 100
                , editor: {
                    type: 'combobox', options: {
                        valueField: 'ct1_codename', textField: 'ct1_codename',
                        data: m_DLList, editable: false, panelHeight: "100",
                        onShowPanel: function () {
                        },
                        onSelect: function (record) { 
                            //填充大类编码 
                            var ed = $(dgid).datagrid('getEditor', { index: m_LastIndex, field: 'bg1_largeclasscode' });
                            ed.target.val(record.ct1_code);
                            var ed1 = $(dgid).datagrid('getEditor', { index: m_LastIndex, field: 'bg1_smallclasscode' });
                            ed1.target.val('');
                            var ed2 = $(dgid).datagrid('getEditor', { index: m_LastIndex, field: 'bg1_smallclassname' });
                            ed2.target.combobox('setValue', '');
                        }
                    }
                }
			},
			{ field: 'bg1_largeclasscode', title: '大类编码', width: 100, editor: 'text', hidden: true },
			{
			    field: 'bg1_smallclassname', title: '资产小类', width: 100
                , editor: {
                    type: 'combobox', options: {
                        valueField: 'codename', textField: 'codename',
                        data: m_XLList, editable: false, panelHeight: "100",
                        onShowPanel: function () {
                            var ed = $(dgid).datagrid('getEditor', { index: m_LastIndex, field: 'bg1_largeclasscode' });
                            if (dataUtil_undefinedOrNull(ed.target.val(), '') == '') {
                                alert('请先选择资产大类！');
                                return false;
                            }
                            //重新小类信息                          
                            var cxml = '<CONO>HWA</CONO><DIVI>D01</DIVI><Level>2</Level><State>启用</State>'
                                        + '<Code0>FAClaseType</Code0><Code1>'
                                        + ed.target.val()
                                        + '</Code1><Code2></Code2><Order></Order>'
                            m_XLList = basedata_getBD('gbd2', cxml);
                            var ed1 = $(dgid).datagrid('getEditor', { index: m_LastIndex, field: 'bg1_smallclassname' });
                            ed1.target.combobox('loadData', m_XLList);
                        },
                        onSelect: function (record) {
                            //填充小类编码 
                            var ed1 = $(dgid).datagrid('getEditor', { index: m_LastIndex, field: 'bg1_smallclasscode' });
                            ed1.target.val(record.code); 
                            //参考价
                            var ed2 = $(dgid).datagrid('getEditor', { index: m_LastIndex, field: 'bg1_price' }); 
                            ed2.target.numberbox('setValue', '');
                            if (record.ct1_fieldvalues1 * 1 > 0) {
                                ed2.target.numberbox('setValue',record.ct1_fieldvalues1);
                            }
                        }
                    }
                }
			},
			{ field: 'bg1_smallclasscode', title: '小类编码', width: 100, editor: 'text', hidden: true },
            { field: 'bg1_assetsname', title: '资产名称', width: 100, editor: 'text' },
			{
			    field: 'bg1_number', title: '数量', width: 60, align: "right"
				, editor: { type: 'numberbox', options: { precision: 0, min: 0 } }
			},
			{
			    field: 'bg1_price', title: '资产单价', width: 80, align: "right"
				, editor: { type: 'numberbox', options: { precision: 0, min: 0 } }
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
			},
           {
               field: 'bg1_sureamount', title: '总金额', width: 100, align: "right"
				, editor: { type: 'numberbox', options: { disabled: true, precision: 0, min: 0 } }
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
           },
		    {
		        field: 'bg1_planuse', title: '行动计划', width: 80
                , editor: {
                    type: 'combobox', options: {
                        valueField: 'ct1_code', textField: 'ct1_codename',
                        data: m_PlanUse, editable: false, panelHeight: "70"
                    }
                }
		    },
		    {
		        field: 'bg1_state', title: '状态', width: 50
                , editor: {
                    type: 'combobox', options: {
                        valueField: 'text', textField: 'text',
                        data: m_States, editable: false, panelHeight: "60"
                    }
                }
		    },
            { field: 'bg1_remark', title: '备注', width: 150, editor: 'text' },
			{ field: 'bg1_rgdt', title: '创建时间', width: 105 },
			{ field: 'bg1_rguser', title: '创建人', width: 70 },
		    { field: 'bg1_lmdt', title: '修改时间', width: 105 },
            { field: 'bg1_lmuser', title: '修改人', width: 70 },
            { field: 'bg1_uptno', title: '修改次数', width: 70 }
        ]],
        pagination: false,
        rownumbers: true,
        singleSelect: false,
        onDblClickRow: function (rowIndex) {
            $(dgid).datagrid("clearSelections");
            $(dgid).datagrid('selectRow', rowIndex);
            if (m_EditFlag == 1) { // 不可编辑
                return false;
            }
            m_LastIndex = rowIndex;
            $(dgid).datagrid('beginEdit', rowIndex);
        },
        onClickRow: function (rowIndex) { 
            $(dgid).datagrid('endEdit', m_LastIndex);
        },
        onClickCell: function (rowIndex, field, value) {
        },
        onAfterEdit: function (index, row) {

        },
        toolbar: '#tjcxk'
    });


    //设置查询分页控件  
    //pager.pagination("options")
    //对象如下：total | pageSize | pageNumber | pageList | loading | buttons | showPageList | showRefresh | onSelectPage 
    //| onBeforeRefresh | onRefresh | onChangePageSize | beforePageText | afterPageText | displayMsg | 

    $('#cxpager').pagination({
        total: 0,
        pageNumber: 1,
        pageSize: m_PageSize,//每页显示的记录条数，默认为20  
        //pageList: [20, 50, 100, 200, 1],//可以设置每页记录条数的列表  
        showPageList: false, //不显示每页记录数列表
        beforePageText: '第',//页数文本框前显示的汉字  
        afterPageText: '页    共 {pages} 页',
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',
        exportExcel: false,
        onBeforeRefresh: function () {
        },
        onSelectPage: function (pageNumber, pageSize) {
            actLoadData(pageNumber, pageSize); 
        }
        //, buttons: [] 
    });
}


/***********************************************************************
 *  删除事件
 *  DLY 
 */
function actDelete() {
    m_LastIndex = actEndEdit(m_DatagridID, m_LastIndex);
    var rows = $(m_DatagridID).datagrid("getSelections");
    //alert(rows.length);
    if (rows.length == 0) {
        return false;
    }
    $.messager.confirm('确认框', '确认删除选中记录吗？', function (r) {
        if (r) {
            var rowsindexs = [];
            for (var i = 0; i < rows.length; i++) {
                var rindex = $(m_DatagridID).datagrid('getRowIndex', rows[i]);
                rowsindexs.push(rindex*1+100);
            }
            rowsindexs.sort();  // index 排序
            var len = rowsindexs.length;
            for (var i = len - 1; i >= 0; i--) {
                var index = rowsindexs[i] - 100; 
                $(m_DatagridID).datagrid('deleteRow', index);	//通过行号移除该行  
            }
        }
    });
}


/***********************************************************************
 *  添加事件
 *  DLY 
 */
function actAdd() {
    if ($('#cxDept').combobox('getValue') == '') {
        alert('请先选择部门！');
        return false;
    }
    if ($('#cxYear').combobox('getValue') == '') {
        alert('年份不能为空！');
        return false;
    }
    if ($('#cxBrand').attr('value') == '') {
        alert('品牌不能为空！');
        return false;
    } 

    m_LastIndex = actEndEdit(m_DatagridID, m_LastIndex);
    $(m_DatagridID).datagrid("clearSelections"); 
    $(m_DatagridID).datagrid('appendRow', {
        bg1_id: dataUtil_NewGuid(),
        bg1_rgdt: dateUtil_dateFomaterA(new Date(), '-'),
        bg1_rguser: m_UserInfo.UserName,
        bg1_uptno: 0,
        bg1_brand: $('#cxBrand').attr('value'),
        bg1_years: $('#cxYear').combobox('getValue'),
        bg1_state: '启用',
        bg1_deptid:$('#cxDept').combobox('getValue'),
        bg1_deptname: $('#cxDept').combobox('getText')
    }); 
    m_LastIndex = $(m_DatagridID).datagrid('getRows').length - 1;
    $(m_DatagridID).datagrid('selectRow', m_LastIndex);
    $(m_DatagridID).datagrid('beginEdit', m_LastIndex);
}


/***********************************************************************
 *  复制事件
 *  DLY 
 */
function actCopy() {
    var insertRowIndex = [];
    m_LastIndex = actEndEdit(m_DatagridID, m_LastIndex);
    var rows = $(m_DatagridID).datagrid("getSelections"); 
    var rowsindexs = [];
    for (var i = 0; i < rows.length; i++) {
        var rindex = $(m_DatagridID).datagrid('getRowIndex', rows[i]);
        rowsindexs.push({ r: rindex, row: rows[i] });
    }
    // 借用rowsindexs对选择行排序，便于复制操作
    rowsindexs.sort(function (a, b) {
        return a.r - b.r
    });
    var len = rowsindexs.length;
    $(m_DatagridID).datagrid("clearSelections"); 
    for (var i = len - 1; i >= 0; i--) {
        var rindex = rowsindexs[i].r;
        //alert(rindex);
        var rownew = new Object(); 
        rownew.bg1_id = dataUtil_NewGuid(),
        rownew.bg1_rgdt = dateUtil_dateFomaterA(new Date(), '-');
        rownew.bg1_rguser = m_UserInfo.UserName;
        rownew.bg1_state = '启用';
        rownew.bg1_deptid = rowsindexs[i].row.bg1_deptid;
        rownew.bg1_deptname = rowsindexs[i].row.bg1_deptname;
        rownew.bg1_uptno = 0;
        rownew.bg1_cono = rowsindexs[i].row.bg1_cono;
        rownew.bg1_divi = rowsindexs[i].row.bg1_divi;
        rownew.bg1_brand = rowsindexs[i].row.bg1_brand; 
        rownew.bg1_com = rowsindexs[i].row.bg1_com;
        rownew.bg1_years = rowsindexs[i].row.bg1_years;
        rownew.bg1_centercode = rowsindexs[i].row.bg1_centercode;
        rownew.bg1_planuse = rowsindexs[i].row.bg1_planuse;
        rownew.bg1_largeclasscode = rowsindexs[i].row.bg1_largeclasscode;
        rownew.bg1_largeclassname = rowsindexs[i].row.bg1_largeclassname;
        rownew.bg1_smallclassname = rowsindexs[i].row.bg1_smallclassname;
        rownew.bg1_smallclasscode = rowsindexs[i].row.bg1_smallclasscode;
        rownew.bg1_assetsname = rowsindexs[i].row.bg1_assetsname;
        rownew.bg1_number = rowsindexs[i].row.bg1_number;
        rownew.bg1_price = rowsindexs[i].row.bg1_price;
        rownew.bg1_sureamount = rowsindexs[i].row.bg1_sureamount;
        rownew.bg1_remark = rowsindexs[i].row.bg1_remark;
        $(m_DatagridID).datagrid('insertRow', {
            index: rindex * 1 + 1,
            row: rownew
        });
        $(m_DatagridID).datagrid('selectRow', rindex + 1);

    }

}


/***********************************************************************
 * 结束编辑行
 *  DLY 
 */
function actEndEdit(dgid, index) {
    if (index != undefined && index >= 0) {
        $(dgid).datagrid('endEdit', index);
    }
    return -1;
}


/***********************************************************************
 *  设置选中行合计金额
 *  DLY 
 */
function getRowTotal(rowIndex, type) { 
    var sum = 0;
    if (type == 'dg') {
        if (rowIndex != undefined && rowIndex >= 0) {
            var edt = $(m_DatagridID).datagrid('getEditor', { index: rowIndex, field: 'bg1_sureamount' });
            if (edt == undefined) {
                return false;
            }
            var ed1 = $(m_DatagridID).datagrid('getEditor', { index: rowIndex, field: 'bg1_number' });
            var ed2 = $(m_DatagridID).datagrid('getEditor', { index: rowIndex, field: 'bg1_price' }); 
            if (ed1 != undefined && !isNaN(ed1.target.val()) && !isNaN(ed2.target.val())) {
                sum = sum * 1 + 1 * ed1.target.val() * ed2.target.val();
            } 
            var sum1 = edt.target.val() * 1;
            if (dataUtil_toFixed(sum1, 2) != dataUtil_toFixed(sum, 2)) {
                edt.target.numberbox('setValue', dataUtil_toFixed(sum, 2) * 1);
            }

        }
    } 
    return sum;
}


/***********************************************************************
 *  部门改变事件 
 *  DLY 
 */
function changeDept(deptid) {
    //拆分公司和成本中心
    m_Coms = [];
    if (dataUtil_undefinedOrNull(m_deptchoose.oz1_com, '') != '') {
        var coms = m_deptchoose.oz1_com.split(',');
        for (var i = 0; i < coms.length; i++) {
            if (coms[i] != '') {
                m_Coms.push({ text: coms[i] });
            }
        }
    }

    m_CostCenters = [];
    if (dataUtil_undefinedOrNull(m_deptchoose.oz1_com, '') != '') {
        var cccs = m_deptchoose.oz1_costcentercode1.split(',');
        for (var i = 0; i < cccs.length; i++) {
            if (cccs[i] != '') {
                m_CostCenters.push({ text: cccs[i] });
            }
        }
    } 
    //状态控制 分编制和审核
    if (m_FuncType == 'BZ') {
        $('#dnbtn').hide(); // 隐藏驳回按钮
        var flag = 0;
        m_EditFlag = 1;
        var cons = ' AND BG4_Type = \'3\' AND BG4_Year = \'' + $('#cxYear').combobox('getValue') + '\' ';
        cons = cons + ' AND BG4_DeptID = \'' + deptid + '\' ';
        var cXML = '<Page>1</Page><Num>1</Num>'
                 + '<Cons>' + cons + '</Cons><OrderBy>' + '' + '</OrderBy>';
        cXML = basedata_addROOT(cXML);
        var curl = GetWSRRURL(peoa_GetWSRRURL(14)) + "&type=GetApH&XML=" + encodeURIComponent(cXML)
                 + "&s=" + new Date().getTime();//拼接url 
        $.ajax({
            url: curl,
            type: "GET",
            async: false,
            dataType: "json",
            success: function (data) {
                if (data.rows && data.rows.length >= 0) {
                    flag = 1;
                    if (data.rows.length > 0 && dataUtil_undefinedOrNull(data.rows[0].bg4_id, '') != '') {
                        $("#spanbg4_id").html(data.rows[0].bg4_id);
                        if ((data.rows[0].bg4_state != '未提交' && m_Role == 'A')
                            || data.rows[0].bg4_state == '已审核') {
                            $('#cxpager').pagination({
                                buttons: gettoolbtns(4)
                            });
                            m_EditFlag = 1;
                        } else {
                            $('#cxpager').pagination({
                                buttons: gettoolbtns(2)
                            });
                            m_EditFlag = 0;
                        }
                    } else {
                        $("#spanbg4_id").html('');
                        $('#cxpager').pagination({
                            buttons: gettoolbtns(2)
                        });
                        m_EditFlag = 0;
                    }
                } else {
                    $("#spanbg4_id").html('');
                    $('#cxpager').pagination({
                        buttons: gettoolbtns(1)
                    });
                }
            }
        });
        if (flag == 0) {
            $('#cxpager').pagination({
                buttons: gettoolbtns(4)
            });
            m_EditFlag = 1;
        } 
    } else if (m_FuncType == 'SP') {
        $("#spanbg4_id").html(m_BillInfo.bg4_id); 
        if (m_BillInfo.bg4_state == '已提交' && m_Role == 'B') { 
            m_EditFlag = 0;
            $('#cxpager').pagination({
                buttons: gettoolbtns(3)
            });
        } else {
            $('#cxpager').pagination({
                buttons: gettoolbtns(4)
            });
            m_EditFlag = 1;
        }
    } 
}


/***********************************************************************
 *  提交事件 
 *  DLY 
 */
function actUp(type) {
    m_LastIndex = actEndEdit(m_DatagridID, m_LastIndex);
    if ($(m_DatagridID).datagrid('getChanges').length > 0) {
        alert('数据已修改，请先保存！');
        return false;
    }
     
    if (m_FuncType == 'BZ') {
        var info = '';
        var row = {};
        row.bg4_id = $("#spanbg4_id").html();
        if (type == 'up') {
            row.bg4_upper1 = m_UserInfo.UserName;
            row.bg4_updt1 = dateUtil_dateFomaterB(new Date(), '-');
            row.bg4_updt2 = '';
            row.bg4_upper2 = '';
            row.bg4_state = '已提交';
            info = '确认提交当前部门预算编制吗？';
        }
        var curl = GetWSRRURL(peoa_GetWSRRURL(14));
        curl = curl + "&type=SetApH&actor=" + m_UserInfo.UserName + "&s=" + new Date().getTime();
        var rowInfo = [];
        rowInfo.push(row);
        var cXML = GetEditJson(rowInfo, [], []); //json转xml   
        var cxmlsJson = { XML: cXML };
        $.messager.confirm('确认框', info, function (r) {
            if (r) {
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
                                changeDept($('#cxDept').combobox('getValue'));
                                $.messager.alert("提示", "提交成功！");
                            }
                        } catch (ex) {
                            $.messager.alert("提示", ex, 'error');
                        }
                    },
                    error: function () {
                        $.messager.alert("提示", "提交失败！", 'error');
                    }
                });
            }
        });
    } else if (m_FuncType == 'SP') {
        var info = '';
        var actinfo = '';
        var row = {};
        row.bg4_id = m_BillInfo.bg4_id;
        if (type == 'up') {
            if ($("#spanbtnUp").html() == '审核') {
                row.bg4_upper1 = m_BillInfo.bg4_upper1;
                row.bg4_updt1 = m_BillInfo.bg4_updt1;
                row.bg4_upper2 = m_UserInfo.UserName;
                row.bg4_updt2 = dateUtil_dateFomaterB(new Date(), '-');
                row.bg4_state = '已审核';
                info = '确认审核“' + m_BillInfo.bg4_subject + '”吗？';
                actinfo = '审核';
            }
        } else if (type == 'dn') {
            row.bg4_upper1 = m_BillInfo.bg4_upper1;
            row.bg4_updt1 = m_BillInfo.bg4_updt1;
            row.bg4_upper2 = m_UserInfo.UserName;
            row.bg4_updt2 = dateUtil_dateFomaterB(new Date(), '-') + ' (驳回)';
            row.bg4_state = '未提交';
            info = '确认驳回“' + m_BillInfo.bg4_subject + '”吗？';
            actinfo = '驳回';
        }
        var curl = GetWSRRURL(peoa_GetWSRRURL(14));
        curl = curl + "&type=SetApH&actor=" + m_UserInfo.UserName + "&s=" + new Date().getTime();
        var rowInfo = [];
        rowInfo.push(row);
        var cXML = GetEditJson(rowInfo, [], []); //json转xml   
        var cxmlsJson = { XML: cXML };
        $.messager.confirm('确认框', info, function (r) {
            if (r) {
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
                                alert(actinfo + "成功！");
                                parent.closeTab(m_BillInfo.bg4_subject);  //关闭当前选项卡，待办任务
                            }
                        } catch (ex) {
                            $.messager.alert("提示", ex, 'error');
                        }
                    },
                    error: function () {
                        $.messager.alert("提示", actinfo + "失败！", 'error');
                    }
                })
            }
        });
    }

}
 

/*******************
 * 获取列表高度
 */
function gettoolbtns(type) {
    var btns = [{
        text: '添加',
        iconCls: 'icon-add',
        handler: function () {
            actAdd();
        }
    }, {
        text: '复制',
        iconCls: 'icon-design',
        handler: function () {
            actCopy();
        }
    }, {
        text: '保存',
        iconCls: 'icon-save',
        handler: function () {
            actSave();
        }
    }, {
        text: '提交',
        iconCls: 'icon-ok',
        handler: function () {
            actUp('up');
        }
    }, {
        text: '驳回',
        iconCls: 'icon-ok',
        handler: function () {
            actUp('dn');
        }
    }, {
        text: '删除',
        iconCls: 'icon-remove',
        handler: function () {
            actDelete();
        }
    }];
    if (type == 1) {
        btns = [];
    } else if (type == 2) {
        btns[4].hidden = true;
    } else if (type == 3) {
        btns[3].text = '审核';
    } else if (type == 4) {
        btns = [{
            text: '<font color="red">不可编辑，只可查看!</font>',
            handler: function () { 
            }
        }];
    }
    return btns;
}


/*******************
 * 获取列表高度
 */
function getcurheight() {
    return;
    var htjcxk = document.getElementById("tjcxk").style.height.replace('px', '');
    var curheight = parent.getTabsHeight() * 1 - htjcxk * 1 + 80;
    return curheight;
}
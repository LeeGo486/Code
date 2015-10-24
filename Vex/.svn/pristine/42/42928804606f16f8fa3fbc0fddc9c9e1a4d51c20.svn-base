var m_DatagridID = '#dpxsmblb'; //列表ID
var m_PaginationID = '#cxpager';   //分页ID
var m_LastIndex = -1;  //人员列表最后一次选中行下标 
var m_PageNumber = 1;  //当前页码
var m_PageSize = 10;  //每页显示行数 

var m_dlgcfgID = '#dpxsmbcfgdlg'; //更新
var m_dlgexcelImportID = '#excelimportdlg';//导入EXCEL
var m_dlgexcelExportID = '#excelExportdlg';//导出模板

//用户信息
var m_UserInfo = parent.m_UserInfo;

var m_Filter = '';  //主的条件
var m_Filter1 = ''; //查询条件
var m_FilterAll = '';   //记录当前查询条件
var m_OrderBy = 'fYear,fMonth,CompanyID,shopid'; //排序方式
//设置当前可导入和导出模板的信息
var m_ExcelYear = "";
var m_ExcelMonth = "";

//基础数据
var m_Companys = [];    // 当前用户负责的店铺
var m_Fyear = [{ value: '2015', text: '2015' }, { value: '2016', text: '2016' }, { value: '2017', text: '2017' }];
var m_Fmonth = [{ value: '1', text: '1' }, { value: '2', text: '2' }, { value: '3', text: '3' },
                { value: '4', text: '4' }, { value: '5', text: '5' }, { value: '6', text: '6' },
                { value: '7', text: '7' }, { value: '8', text: '8' }, { value: '9', text: '9' },
                { value: '10', text: '10' }, { value: '11', text: '11' }, { value: '12', text: '12' }];

//宽度设置
var m_widths = [120, 150, 120, 100, 70, 200, 300];


/***********************************************************************
 *  初始化
 *  DLY 
 */
$(function () {
    // 滚动条居顶
    parent.sc();

    //用户认证
    if (m_UserInfo == undefined || m_UserInfo.userName == undefined) {
        top.location.href = 'error.html';
        return;
    }

    //权限的设置
    var cons = ' AND HR9_TYPE = 0';  //获取公司
    //用户为人资时，显示负责的公司
    if (m_UserInfo.actor == 'C') {
        //获取当前人资负责的公司
        cons += ' AND HR9_RZEmpCode=\'' + m_UserInfo.empCode + '\'';
        m_Companys = hr_getSYSConfig(cons, 1, 1000, 'HR9_Com');
        m_Filter = ' AND State = 1 ';
    }
    //用户为管理员时，显示所有公司
    if (m_UserInfo.actor == 'E') {
        //获取当前人资负责的公司
        m_Companys = hr_getSYSConfig(cons, 1, 1000, 'HR9_Com');
    }

    //设置下拉菜单
    setCombobox('#orgname', m_widths[0], m_widths[0], m_widths[4], true, false, 'hr9_ehrorgid', 'hr9_com', m_Companys);
    setCombobox('#fyear', m_widths[4], m_widths[4], m_widths[4], true, false, 'value', 'text', m_Fyear);
    setCombobox('#fmonth', m_widths[4], m_widths[4], m_widths[4], true, false, 'value', 'text', m_Fmonth);

    //设置表格
    setDataGrid(m_DatagridID);

    // 校验（每月一单）
    var curmonth = dateUtil_getMonthByDay('', '-', '5').substring(0, 7);//新建月份 
    m_ExcelYear = curmonth.substring(0, 4);
    m_ExcelMonth = curmonth.substring(5, 7) * 1;
});


/***********************************************************************
 *  设置下拉控件
 *  DLY 
 */
function setCombobox(field, width, pwidth, pheight, edit, multi, vfield, tfield, data) {
    $(field).combobox({
        width: width,
        panelWidth: pwidth,
        panelHeight: pheight,
        editable: edit,
        multiple: multi,
        valueField: vfield,
        textField: tfield,
        data: data
    });
}


/***********************************************************************
 *  加载数据
 *  DLY 
 */
function actLoadData(page, number) {
    var totalCount = 0;
    $(m_DatagridID).datagrid('loadData', []);
    m_PageNumber = page;
    m_PageSize = number;

    // 拼接查询条
    var cons = m_Filter;
    var orgname = $('#orgname').combobox('getValue');
    var fyear = $('#fyear').combobox('getValue');
    var fmonth = $('#fmonth').combobox('getValue');
    var shopname = $('#shopname').val();

    if (orgname == '' || fyear == '' || fmonth == '') {
        alert('请输入完整的查询信息！');
        return;
    }

    cons += ' AND CompanyID=\'' + orgname + '\'';
    cons += ' AND fyear =\'' + fyear + '\'';
    cons += ' AND fmonth=\'' + fmonth + '\'';
    if (shopname != '') {
        cons += ' AND HR9_PosShopName like\'%' + shopname + '%\'';
    }

    m_FilterAll = cons;
    var res = hr_getShopSalesTarget(cons, page, number, m_OrderBy);

    //alert(jsonUtil_jsonToStr(res));
    if (res == '') {
        alert('查询失败！');
    } else if (res.total > 0) {
        $(m_DatagridID).datagrid('loadData', res.rows);
        totalCount = res.total;
    }
    $(m_DatagridID).datagrid("clearSelections");
    $('#cxpager').pagination({
        total: totalCount,
        pageNumber: page
    });
}


/***********************************************************************
 *  清除
 *  DLY 
 */
function clearText() {
    $('#orgname').combobox('setValue', '');
    $('#fyear').combobox('setValue', '');
    $('#fmonth').combobox('setValue', '');
    $('#shopname').val('');
}


/***********************************************************************
*  设置列表
*  DLY 
*/
function setDataGrid() {
    //信息列表
    $(m_DatagridID).datagrid({
        //title:'店铺销售目标配置表',
        //iconCls:'icon-save',
        width: $(document.body).width(),
        height: 400,
        nowrap: true,
        striped: true,
        collapsible: true,
        //url:'mroomlist.action',
        //sortName: 'c_code',
        //sortOrder: 'asc',
        remoteSort: false,
        idField: 'id',
        frozenColumns: [[
            //{field:'ck',checkbox:true},
        ]],
        columns: [[
            { field: 'id', title: 'FID', width: 80, hidden: true },
            { field: 'companyid', title: '公司编号', width: 80, hidden: true },
            { field: 'hr9_com', title: '公司', width: 80 },
            { field: 'shopid', title: '店铺编号', width: 80, hidden: true },
            { field: 'hr9_posshopname', title: '店铺名称', width: 180 },
            { field: 'fyear', title: '年份', width: 60, align: "center" },
            { field: 'fmonth', title: '月份', width: 80, align: "center" },
            { field: 'targetamount', title: '销售目标', width: 80 },
            { field: 'finishamount', title: '实际销售', width: 80 },
            { field: 'state', title: '状态', width: 60, hidden: true },
            {
                field: 'rgdt', title: '创建时间', width: 130, hidden: true,
                formatter: function (val, row, index) {
                    if (val) {
                        return dateUtil_dateFomaterA(new Date(val), '-');
                    }
                }
            },
            { field: 'rguser', title: '创建人', width: 60, hidden: true },
            {
                field: 'lmdt', title: '修改时间', width: 130,
                formatter: function (val, row, index) {
                    if (val) {
                        return dateUtil_dateFomaterA(new Date(val), '-');
                    }
                }
            },
            { field: 'lmuser', title: '修改人', width: 130 },
            { field: 'uptno', title: '修改次数', width: 60, hidden: true }
        ]],
        rownumbers: true,
        singleSelect: true,
        onDblClickRow: function (rowIndex, rowData) {
            m_LastIndex = rowIndex;
            if (m_LastIndex == -1) {
                alert('请选中一行信息进行配置！');
                return;
            }
            if (m_UserInfo.actor == 'C') {
                if (rowData.state = 0) {
                    alert('当前状态不能进行修改！');
                    return;
                }
            }
            opendlg();
        },
        onClickRow: function (rowIndex) {
            m_LastIndex = rowIndex;
        }
    });

    //设置分页控件
    $(m_PaginationID).pagination({
        total: 0,
        pageNumber: 1,
        pageSize: m_PageSize,//每页显示的记录条数  
        //pageList: [20, 50, 100, 200],//可以设置每页记录条数的列表  
        showPageList: false, //不显示每页记录数列表
        beforePageText: '第',//页数文本框前显示的汉字  
        afterPageText: '页    共 {pages} 页',
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',
        exportExcel: false,
        onBeforeRefresh: function () {
        },
        onSelectPage: function (pageNumber, pageSize) {
            actLoadData(pageNumber, pageSize);
        },
        buttons: [{
            id: 'btnExportT',
            text: dataUtil_actSetNStr('导出模板', 1),
            iconCls: 'icon-redo-green',
            handler: function () {
                //设置下拉菜单
                setCombobox('#orgnameselect', m_widths[0], m_widths[0], m_widths[4], true, false, 'hr9_ehrorgid', 'hr9_com', m_Companys);
                setCombobox('#fyearselect', m_widths[4], m_widths[4], m_widths[4], false, false, 'value', 'text', m_Fyear);
                setCombobox('#fmonthselect', m_widths[4], m_widths[4], m_widths[4], false, false, 'value', 'text', m_Fmonth);
                $('#fyearselect').combobox('setValue', m_ExcelYear);
                $('#fmonthselect').combobox('setValue', m_ExcelMonth);
                $(m_dlgexcelExportID).dialog('open');
            }
        },
        {
            id: 'btnExportAll',
            text: dataUtil_actSetNStr('导出全部', 1),
            iconCls: 'icon-edit-green',
            handler: function () {
                excelExportAll();
            }
        },
        {
            id: 'btnImport',
            text: dataUtil_actSetNStr('导入', 1),
            iconCls: 'icon-edit-green',
            handler: function () {
                excelImport();
                $(m_dlgexcelImportID).dialog('open');
            }
        }]
    });
}


/***********************************************************************
 *  打开配置窗体
 *  DLY 
 */
function opendlg() {
    //获取当前选中人员信息
    var rowData = $(m_DatagridID).datagrid('getSelected');

    $('#shopnamespan').html(rowData.hr9_posshopname);
    $('#fyearspan').html(rowData.fyear);
    $('#fmonthspan').html(rowData.fmonth);
    $('#finishamount').numberbox('setValue', rowData.targetamount);
    $('#targetamount').numberbox('setValue', rowData.finishamount);

    $(m_dlgcfgID).dialog('open');
}


/***********************************************************************
 *  提交配置
 *  SY
 */
function upCfgdlg() {
    //校验
    var targetamount = $('#targetamount').numberbox('getValue');
    if (targetamount == '') {
        alert('销售目标不能为空！');
        return false;
    }
    //更新
    var row = $(m_DatagridID).datagrid('getSelected');
    if (row) {
        if (targetamount == row.targetamount) { // 没有更新
            alert('未存在更新数据！');
            $(m_dlgcfgID).dialog('close');
        } else {
            $.messager.confirm('确认框', '确认提交该配置吗？', function (r) {
                if (r) {
                    //提交配置
                    var res = {
                        mid: row.id, targetamount: targetamount,
                        uptno: row.uptno * 1 + 1, actor: m_UserInfo.userName
                    };
                    var resresult = hr_updShopSalesTargetCfg(res);
                    if (resresult[0].result.toLowerCase() == 'false') {
                        alert(resresult[0].message);
                    } else {
                        alert('保存成功！');
                        $(m_dlgcfgID).dialog('close');
                        actLoadData(m_PageNumber, m_PageSize);
                    }
                }
            });
        }
    } else {
        alert('未找到选择行，请重新选择行！');
        $(m_dlgcfgID).dialog('close');
    }

}


/***********************************************************************
 *  导出模板
 *  SY
 */
function excelExportT() {
    var orgname = $('#orgnameselect').combobox('getValue');
    var fyear = $('#fyearselect').combobox('getValue');
    var fmonth = $('#fmonthselect').combobox('getValue');

    var cons = m_Filter;
    cons += ' AND CompanyID=\'' + orgname + '\'';
    cons += ' AND fyear =\'' + fyear + '\'';
    cons += ' AND fmonth=\'' + fmonth + '\'';

    var cXML = '<Page>1</Page><Num>50000</Num>'
                    + '<Cons>' + cons + '</Cons><OrderBy>' + m_OrderBy + '</OrderBy>';
    cXML = dataUtil_addROOT(cXML);
    var strUrl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=GetShopSalesTargetExcel&XML=" + encodeURIComponent(cXML); //拼接url
    var title = "店铺销售目标配置导入模板";

    var dataParam = {};

    var strXMLCol = "<Root><List>";
    strXMLCol += "<Rows>";
    strXMLCol += "<field>rowindex</field>";
    strXMLCol += "<title>序号</title>";
    strXMLCol += "<width>60</width>";
    strXMLCol += "<hidden>false</hidden>";
    strXMLCol += "<formatDataType></formatDataType>";
    strXMLCol += "</Rows>";
    strXMLCol += "<Rows>";
    strXMLCol += "<field>CompanyID</field>";
    strXMLCol += "<title>公司编号</title>";
    strXMLCol += "<width>120</width>";
    strXMLCol += "<hidden>false</hidden>";
    strXMLCol += "<formatDataType></formatDataType>";
    strXMLCol += "</Rows>";
    strXMLCol += "<Rows>";
    strXMLCol += "<field>HR9_Com</field>";
    strXMLCol += "<title>公司名称</title>";
    strXMLCol += "<width>120</width>";
    strXMLCol += "<hidden>false</hidden>";
    strXMLCol += "<formatDataType></formatDataType>";
    strXMLCol += "</Rows>";
    strXMLCol += "<Rows>";
    strXMLCol += "<field>shopid</field>";
    strXMLCol += "<title>店铺编号</title>";
    strXMLCol += "<width>120</width>";
    strXMLCol += "<hidden>false</hidden>";
    strXMLCol += "<formatDataType></formatDataType>";
    strXMLCol += "</Rows>";
    strXMLCol += "<Rows>";
    strXMLCol += "<field>HR9_PosShopName</field>";
    strXMLCol += "<title>店铺名称</title>";
    strXMLCol += "<width>120</width>";
    strXMLCol += "<hidden>false</hidden>";
    strXMLCol += "<formatDataType></formatDataType>";
    strXMLCol += "</Rows>";
    strXMLCol += "<Rows>";
    strXMLCol += "<field>fYear</field>";
    strXMLCol += "<title>年份</title>";
    strXMLCol += "<width>120</width>";
    strXMLCol += "<hidden>false</hidden>";
    strXMLCol += "<formatDataType></formatDataType>";
    strXMLCol += "</Rows>";
    strXMLCol += "<Rows>";
    strXMLCol += "<field>fMonth</field>";
    strXMLCol += "<title>月份</title>";
    strXMLCol += "<width>120</width>";
    strXMLCol += "<hidden>false</hidden>";
    strXMLCol += "<formatDataType></formatDataType>";
    strXMLCol += "</Rows>";
    strXMLCol += "<Rows>";
    strXMLCol += "<field>salestarget</field>";
    strXMLCol += "<title>销售目标</title>";
    strXMLCol += "<width>120</width>";
    strXMLCol += "<hidden>false</hidden>";
    strXMLCol += "<formatDataType></formatDataType>";
    strXMLCol += "</Rows>";
    strXMLCol += "</List></Root>";

    strXMLCol = strXMLCol.replace(/\(/g, "").replace(/\)/g, "");
    dataParam.ExcelExportColumns = strXMLCol;

    $.messager.confirm('提示框', "是否导出", function (e) {
        if (e) {
            $.messager.progress({ title: '请稍后', msg: '处理中' });

            $.ajax({
                url: strUrl + "&pagerows=0&pageNumber=1&ExcelExport=true&title=" + escape(title) + "&rd=" + Math.random(),
                data: dataParam,
                type: 'POST',
                options: "JSON",
                success: function (data) {
                    $.messager.progress('close');
                    if (eval("[" + data + "]")[0].Error) {
                        $.messager.alert("导出Excel出错了", eval("[" + data + "]")[0].Error, 'error');
                        return;
                    }
                    if (eval("[" + data + "]")[0].Error == "") {
                        $.messager.alert("导出Excel出错了", "导出出错了", 'error');
                        return;
                    }
                    var strFileName = eval("[" + data + "]")[0].FileName;
                    //strFileName = strFileName.substring(0, 29) + FileName.substring(4);
                    window.location.href = strFileName;
                },
                error: function (date) {
                    alert("错误!");
                    $.messager.progress('close');
                }

            });
        }
    });
}


/***********************************************************************
 *  导出表中全部数据
 *  SY
 */
function excelExportAll() {

    var listData = $(m_DatagridID).datagrid('getRows');

    if (listData.length <= 1 || listData == undefined) {
        alert("请先加载数据");
        return;
    }

    EasyUI_DataGrid_ExcelExport1($(m_DatagridID), $(m_DatagridID));
}


//导出Exel主函数
function EasyUI_DataGrid_ExcelExport1(pgrid, pagination) {
    var dataOptions = pgrid.datagrid("options");

    var cXML = '<Page>1</Page><Num>50000</Num>'
                    + '<Cons>' + m_FilterAll + '</Cons><OrderBy>' + m_OrderBy + '</OrderBy>';
    cXML = dataUtil_addROOT(cXML);
    //alert(cXML);	
    var strUrl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=GetShopSalesTarget&XML=" + encodeURIComponent(cXML); //拼接url

    //var strUrl = dataOptions.url;
    var dataColumns = dataOptions.columns;
    var dataColumnsFrozen = dataOptions.frozenColumns;
    var dataParam = dataOptions.queryParams;
    var pageSize = dataOptions.pageSize;
    var pageNumber = dataOptions.pageNumber;
    //var title = dataOptions.title;
    var title = "店铺销售目标配置";

    var strXMLCol = "<Root><List>";

    if (dataColumnsFrozen != null && dataColumnsFrozen.length > 0) {
        for (var i = 0; i < dataColumnsFrozen[0].length; i++) {

            if (dataColumnsFrozen[0][i].checkbox == true) {
                continue;
            }

            strXMLCol += "<Rows>";
            strXMLCol += "<field>" + dataColumnsFrozen[0][i].field + "</field>";

            if (dataColumnsFrozen[0][i].title) {
                strXMLCol += "<title>" + dataColumnsFrozen[0][i].title + "</title>";
            }
            else {
                strXMLCol += "<title>" + dataColumnsFrozen[0][i].field + "</title>";

            }
            if (dataColumnsFrozen[0][i].width) {
                strXMLCol += "<width>" + dataColumnsFrozen[0][i].width + "</width>";
            }
            else {
                strXMLCol += "<width></width>";

            }

            if (dataColumnsFrozen[0][i].hidden) {
                strXMLCol += "<hidden>true</hidden>";
            }
            else {
                strXMLCol += "<hidden>false</hidden>";
            }

            if (dataColumnsFrozen[0][i].formatDataType) {
                strXMLCol += "<formatDataType>" + dataColumnsFrozen[0][i].formatDataType + "</formatDataType>";
            }
            else {
                strXMLCol += "<formatDataType></formatDataType>";
            }
            strXMLCol += "</Rows>";
        }
    }
    if (dataColumns != null && dataColumns.length > 0) {
        for (var i = 0; i < dataColumns[0].length; i++) {

            if (dataColumns[0][i].checkbox == true) {
                continue;
            }

            strXMLCol += "<Rows>";
            strXMLCol += "<field>" + (dataColumns[0][i].field) + "</field>";

            if (dataColumns[0][i].title) {
                strXMLCol += "<title>" + (dataColumns[0][i].title) + "</title>";
            }
            else {
                strXMLCol += "<title>" + (dataColumns[0][i].field) + "</title>";

            }

            if (dataColumns[0][i].width) {
                strXMLCol += "<width>" + dataColumns[0][i].width + "</width>";
            }
            else {
                strXMLCol += "<width></width>";

            }

            if (dataColumns[0][i].hidden) {
                strXMLCol += "<hidden>true</hidden>";
            }
            else {
                strXMLCol += "<hidden>false</hidden>";
            }

            if (dataColumns[0][i].formatDataType) {
                strXMLCol += "<formatDataType>" + dataColumns[0][i].formatDataType + "</formatDataType>";
            }
            else {
                strXMLCol += "<formatDataType></formatDataType>";
            }

            //if (dataColumns[0][i].align) {
            //    strXMLCol += "<align>" + dataColumns[0][i].align + "</align>";
            //}
            //else {
            //    strXMLCol += "<align>left</align>";
            //} 


            //if (dataColumns[0][i].halign) {
            //    strXMLCol += "<halign>" + dataColumns[0][i].halign + "</halign>";
            //}
            //else {
            //    strXMLCol += "<halign>center</halign>";
            //}
            strXMLCol += "</Rows>";
        }
    }

    strXMLCol += "</List></Root>";

    strXMLCol = strXMLCol.replace(/\(/g, "").replace(/\)/g, "");
    dataParam.ExcelExportColumns = strXMLCol;

    $.messager.confirm('提示框', "是否导出", function (e) {
        if (e) {
            $.messager.progress({ title: '请稍后', msg: '处理中' });

            $.ajax({
                url: strUrl + "&pagerows=0&pageNumber=1&ExcelExport=true&title=" + escape(title) + "&rd=" + Math.random(),
                data: dataParam,
                type: 'POST',
                options: "JSON",
                success: function (data) {
                    $.messager.progress('close');
                    if (eval("[" + data + "]")[0].Error) {
                        $.messager.alert("导出Excel出错了", eval("[" + data + "]")[0].Error, 'error');
                        return;
                    }
                    if (eval("[" + data + "]")[0].Error == "") {
                        $.messager.alert("导出Excel出错了", "导出出错了", 'error');
                        return;
                    }
                    var strFileName = eval("[" + data + "]")[0].FileName;
                    //strFileName = strFileName.substring(0, 29) + FileName.substring(4);
                    window.location.href = strFileName;
                },
                error: function (date) {
                    alert("错误!");
                    $.messager.progress('close');
                }

            });
        }
    });
}


//导入EXCEL
function excelImport() {
    //文件上传相关-----------------
    var btnUpExcel = $('#txtBrowseUp'), interval;

    var cXML = '<role>' + m_UserInfo.actor + '</role><empcode>' + m_UserInfo.empCode + '</empcode>'
              + '<fyear>' + m_ExcelYear + '</fyear><fmonth>' + m_ExcelMonth + '</fmonth>';
    cXML = dataUtil_addROOT(cXML);

    new AjaxUpload(btnUpExcel, {
        action: '/Handler_PE_OA.ashx?filePath=3S&ExcelImport=true',
        data: {
            "WSID": peoa_GetWSRRURL(1001), "XML": cXML,
            "type": 'CheckShopSalesTargetCfg', "actor": m_UserInfo.userName
        },
        name: 'myfile',
        onSubmit: function (file, ext) {
            $.messager.progress({ title: '请稍后', msg: '请耐心等待' });
            if (!(ext && /^(xls|xlsx)$/.test(ext))) {
                $.messager.progress('close');
                alert('文件格式不正确,请选择 xls,xlsx 格式的文件!', '系统提示');
                return false;
            }

            //btnUpExcel.text('浏览');

            this.disable();
            interval1 = window.setInterval(function () {
                var text = btnUpExcel.text();
                if (text.length < 1) {
                    btnUpExcel.text(text + '.');
                } else {
                    // btnUpExcel.text('浏览');
                }
            }, 200);
        },
        onComplete: function (file, response) {
            //file 本地文件名称，response 服务器端传回的信息
            //btnUpExcel.text('浏览');

            window.clearInterval(interval1);

            // enable upload button
            this.enable();
            var k = response.replace("<pre>", "").replace("</pre>", "").replace("<PRE>", "").replace("</PRE>", "");
            $.messager.progress('close');

            var result = eval("[" + k + "]");
            if (result[0].Error) {
                $.messager.alert("系统错误", result[0].Error, 'error');
            }
            else if (result[0].rows[0].result == "False") {
                $.messager.alert("警告", result[0].rows[0].message);
            }
            else {
                $.messager.alert("提示", "成功");
            }

            //一下google 不支持
            //try {
            //    var result = eval("[" + k + "]");
            //    if (result[0].Error) {
            //        $.messager.progress('close');

            //        $.messager.alert("系统错误", result[0].Error, 'error');
            //    }
            //    else if (result[0].rows[0].result == "False") {
            //        //var errormessage = result[0].rows[0].message;
            //        $.messager.progress('close');

            //        alert("异常!请联系信息管理部");
            //    }
            //    else {
            //        //$("#txtRoute").val(result[0].rows[0].message);
            //        $.messager.alert("提示", "成功");
            //        $.messager.progress('close');
            //    }
            //} catch (ex) {
            //    $.messager.progress('close');

            //    $.messager.alert("提示", ex, 'error');
            //}

        }
    });
    //文件上传相关-----------------
};
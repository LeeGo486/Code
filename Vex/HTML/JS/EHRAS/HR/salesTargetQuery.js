var m_DatagridID = '#dpxsmblb'; //列表ID
var m_PaginationID = '#cxpager';   //分页ID
var m_LastIndex = -1;  //人员列表最后一次选中行下标 
var m_PageNumber = 1;  //当前页码
var m_PageSize = 10;  //每页显示行数  

//用户信息
var m_UserInfo = parent.m_UserInfo;

var m_Filter = '';  //主的条件
var m_Filter1 = ''; //查询条件
var m_FilterAll = '';   //记录当前查询条件
var m_OrderBy = 'fYear, fMonth, CompanyID, shopid'; //排序方式
 

//基础数据
var m_Companys = [];    // 当前用户负责的店铺
var m_Fyear = [{ value: '2015', text: '2015' }, { value: '2016', text: '2016' }, { value: '2017', text: '2017' }];
var m_Fmonth = [{ value: '', text: '--' }, { value: '01', text: '01' }, { value: '02', text: '02' }, { value: '03', text: '03' },
                { value: '04', text: '04' }, { value: '05', text: '05' }, { value: '06', text: '06' },
                { value: '07', text: '07' }, { value: '08', text: '08' }, { value: '09', text: '09' },
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
    m_Filter = ' AND 1 = 2 ';
    if (m_UserInfo.actor == 'E') { 
        m_Filter = '';
    } else if (m_UserInfo.actor == 'A') { //店长只可查看本部门
        m_Filter = 'AND HR9_EHRUnitID = \'' + m_UserInfo.deptID + '\' ';
    } else if (m_UserInfo.actor == 'C') { //人资 大区经理或城市经理只可查看涉及部门
        m_Filter = 'AND ( CompanyID IN (' + m_UserInfo.comIDs + '-2 )';
        m_Filter = m_Filter + ' OR ( HR9_EHRUnitID in (' + m_UserInfo.shopids + ') '
                 + ' OR HR9_EHRUnitID in (' + m_UserInfo.shopids1 + ') ) )';
    } else {  //大区经理或城市经理只可查看涉及部门
        m_Filter = ' AND ( HR9_EHRUnitID in (' + m_UserInfo.shopids + ') '
                 + ' OR HR9_EHRUnitID in (' + m_UserInfo.shopids1 + ') )';
    }

    //获取公司 
    var cons = ' AND HR9_TYPE = 0';  
    m_Companys = hr_getSYSConfig(cons, 1, 1000, 'HR9_Com'); 

    //设置下拉菜单
    hr_setCombobox('#orgname', m_widths[0], m_widths[0], m_widths[1], true, false, 'hr9_ehrorgid', 'hr9_com', m_Companys);
    hr_setCombobox('#fyear', m_widths[4], m_widths[4], m_widths[4], true, false, 'value', 'text', m_Fyear);
    hr_setCombobox('#fmonth', m_widths[4], m_widths[4], m_widths[1], true, false, 'value', 'text', m_Fmonth);
    
    //设置表格
    setDataGrid(m_DatagridID);

    //初始化数据  
    var filter = parent.actsonfilter('get');
    if (filter.type != undefined && filter.type == 'salesTargetQ') { //恢复到跳转前参数
        setCons(filter);
    }
    else {
        clearText();
        actLoadData(1, m_PageSize);
    }
});

 
/***********************************************************************
 *  根据跳转前的参数设置页面
 *  DLY
 */
function setCons(filter) { 
    $('#orgname').combobox('setValue', filter.comanyid);
    $('#fyear').combobox('setValue', filter.fyear);
    $('#fmonth').combobox('setValue', filter.fmonth);
    $('#shopname').val(filter.shopname);
    m_Filter = filter.fil;
    m_Filter1 = filter.fil1;
    actLoadData(filter.page, m_PageSize);
    var rows = $(m_DatagridID).datagrid('getRows');
    for (var i = 0; i < rows.length; i++) {
        if (filter.sid.toUpperCase() == rows[i].id.toUpperCase()) {
            $(m_DatagridID).datagrid('selectRow', i);
        }
    }
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
    var cons = '';
    var orgname = $('#orgname').combobox('getValue');
    var fyear = $('#fyear').combobox('getValue');
    var fmonth = $('#fmonth').combobox('getValue');
    var shopname = $('#shopname').val();

    if (orgname != '') {
        cons += ' AND CompanyID=\'' + orgname + '\'';
    }
    if (fyear != '') {
        cons += ' AND fyear =\'' + fyear + '\'';
    }
    if (fmonth != '') {
        cons += ' AND fmonth=\'' + fmonth + '\'';
    }
    if (shopname != '') {
        cons += ' AND HR9_PosShopName like\'%' + shopname + '%\'';
    }

    m_FilterAll = m_Filter + m_Filter1 + cons;
    //alert(m_FilterAll); 
    var res = hr_getShopSalesTarget(m_FilterAll, page, number, m_OrderBy);

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
    var curmonth = dateUtil_getMonthByDay('', '-', '5').substring(0, 7);
    $('#fyear').combobox('setValue', curmonth.substring(0, 4));
    $('#fmonth').combobox('setValue', curmonth.substring(5, 7));
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
            //查看均不可修改
            var v0 = 'old';
            var v1 = 'list';
            var curl = 'salesTargetMake.html?' + 'v0=' + v0 + '&v1=' + v1
                     + '&v2=' + rowData.id + '&l3=销售目标查询'
                     + '&s=' + new Date().getTime(); 

            //设置当前加班申请跳转明细前的参数
            var filter = {
                type: 'salesTargetQ',
                comanyid: $('#orgname').combobox('getValue'),
                fyear: $('#fyear').combobox('getValue'),
                fmonth: $('#fmonth').combobox('getValue'),
                shopname: $('#shopname').val(),
                page: m_PageNumber,
                rowindex: rowIndex,
                sid: rowData.id,
                fil: m_Filter,
                fil1: m_Filter1,
                url_local: window.location.href
            };
            //保存当前页参数到父页面
            parent.actsonfilter('set', filter);

            //跳转明细页
            parent.menus_turnPage('B', '', curl);
        },
        onClickRow: function (rowIndex) { 
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
        buttons: [
        {
            id: 'btnExportAll',
            text: '导出全部',
            iconCls: 'icon-excel-green1',
            handler: function () {
                excelExportAll();
            }
        }]
    });
}
   

/***********************************************************************
 *  导出表中全部数据
 *  SY
 */
function excelExportAll() { 
    var listData = $(m_DatagridID).datagrid('getRows'); 
    if (listData.length <= 0 || listData == undefined) {
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

    $.messager.confirm('提示框', "确定导出全部吗？", function (e) {
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

 
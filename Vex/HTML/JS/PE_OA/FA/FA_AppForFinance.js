/* 全局变量*/
var m_DatagridID = '#wgdzcbxlb';//未勾对固定资产报销列表
var m_DatagridAllID = '#gdzcbxlb';//所有固定资产报销列表 

var m_PageNumber = 1;  //当前页码
var m_PageSize = 20;  //每页显示行数 

//宽度设置
var m_widths = [120, 150, 120, 100, 70, 200, 300];
//状态选择
var m_State = [{ typeid: '已报销', typetext: '已报销' }, { typeid: '未报销', typetext: '未报销' }, { typeid: '全部', typetext: '全部' }];

var m_LastIndex = undefined;

//var res = [{ "fa2_largeclassname": "电子设备", "fa2_smallclassname": "打印机", "fa2_brandcode": "EPSONL", "fa2_model": "L1300", "fa2_number": "1", "fa2_applyprice": "3000.00", "fa2_sureprice": "2900.00", "fa2_username": "testuser", "fa2_poapplycode": "EP-FA-20141104002", "fa1_applyuser": "testuser", "fa1_deptname": "testdept", "fa1_centername": "testcenter", "fa1_state": "未勾选"}];

var m_Filter1 = ''; //查询条件

var m_FilterAll = '';

//用户信息
var m_UserInfo = parent.m_UserInfo;

var m_TabFlag = false;

/***********************************************************************
 *  初始化
 *  
 */
$(function () {
    //alert(m_UserInfo);
    //滚动条居顶
    sc();

    //setDatebox('#gdDate');
    //setDatebox('#applyDate');

    setDataGrid(m_DatagridID, "#cxpager", 0);
    $(m_DatagridID).datagrid({
        frozenColumns: [[
        { field: 'ck', checkbox: true }
        ]]
    });

    $(m_DatagridAllID).datagrid({ singleSelect: true });
    m_Filter1 = ' AND ( FA2_EState = \'未报销\')';
    //设置相关控件
    $('#gdxx').tabs('update', {
        tab: $('#gdxx').tabs('getTab', 0),
        options: {
            selected: true
        }
    });
    $('#gdxx').tabs({
        onSelect: function (title,index) {
            if (title == '未勾对' && index == 0) {
                clearText();
                actLoadData(1, m_PageSize);
            }
            else {
                if (m_TabFlag == false) {
                    setCombobox('#state', m_widths[0], 118, 70, false, false, 'typeid', 'typetext', m_State);
                    setDataGrid(m_DatagridAllID, "#cxpagerall", 1);
                    $(m_DatagridAllID).datagrid({ singleSelect: true });
                    m_TabFlag = true;
                }
                clearTextAll();
                actLoadDataAll(1, m_PageSize);
            }
        }
    });
});


/*********************************************************************** 
 * 滚动条在居顶
 * 
 */
function sc() {
    //var e = document.getElementById("body"); 
    //e.scrollTop = -10;
    //alert($('#body').scrollTop());
    //$('#body').scrollTop(0); 
    document.getElementById('gdxx').scrollIntoView();

}


/***********************************************************************
 *  设置日期控件
 *  
 */
function setDatebox(field) {
    $(field).datebox({
        width: m_widths[0],
        closeText: '关闭',
        editable: true,
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
}


/***********************************************************************
 *  设置下拉控件
 *  
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
*  设置列表
*  
*/
function setDataGrid(datagridID, pageID, type) {
    //信息列表
    $(datagridID).datagrid({
        //title:'固定资产报销表',
        //width: $(document.body).width(),
        height: 350,
        nowrap: true,
        striped: true,
        collapsible: true,
        //url:'mroomlist.action',
        //sortName: 'c_code',
        //sortOrder: 'asc',
        remoteSort: false,
        idField: 'fa2_id',
        columns: [[
            { field: 'fa2_id', title: 'FID', width: 80, hidden: true },
            { field: 'fa2_largeclasscode', title: '大类编号', width: 80, hidden: true },
            { field: 'fa2_largeclassname', title: '大类名称', width: 80 },
            { field: 'fa2_smallclasscode', title: '小类编号', width: 80, hidden: true },
            { field: 'fa2_smallclassname', title: '小类名称', width: 70 },
            { field: 'fa2_assetsname', title: '资产名称', width: 70 },
            { field: 'fa1_assetstype', title: '资产类别', width: 70, hidden: true },
            { field: 'fa1_budgettype', title: '预算类别', width: 70, hidden: true },
            { field: 'fa2_brandcode', title: '品牌', width: 80 },
            { field: 'fa2_model', title: '规格/型号', width: 80 },
            { field: 'fa2_number', title: '数量', width: 50, align: "center" },
            { field: 'fa2_applyprice', title: '申请单价', width: 80, align: "center" },
            { field: 'fa2_sureprice', title: '确认单价', width: 80, align: "center" },
            { field: 'fa2_usercode', title: '使用人编号', width: 80, hidden: true },
            { field: 'fa2_username', title: '使用人', width: 60 },
            { field: 'fa2_poapplycode', title: '申购单号', width: 130 },
            { field: 'fa1_applyuser', title: '申请人', width: 60 },
            { field: 'fa1_applydt', title: '申请日期', width: 75, hidden: true },
            { field: 'fa1_deptid', title: '申请部门编号', width: 100, hidden: true },
            { field: 'fa1_centercode', title: '成本中心', width: 80 },
            { field: 'fa1_deptname', title: '申请部门', width: 100 },
            { field: 'fa2_estate', title: '状态', width: 50 },
            { field: 'fa2_gduser', title: '勾对人', width: 60 },
            { field: 'fa2_gddt', title: '勾对时间', width: 100 } 
        ]],
        rownumbers: true,
        singleSelect: false,
        onDblClickRow: function (rowIndex) {
            if (rowIndex >= 0) {
                $(datagridID).datagrid('selectRow', rowIndex);
                print(datagridID);
            }
            else {
                alert("请选中一行");
            }
        },
        onClickRow: function (rowIndex) {          
        }
    });

    //显示未勾对选项卡的分页信息
    if (type == 0) {
        $(pageID).pagination({
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
                text: dataUtil_actSetNStr('单据明细', 1),
                iconCls: 'icon-menu',
                handler: function () { 
                    var data = $(datagridID).datagrid('getSelected');
                    if (data) {
                        print(datagridID);
                    }
                    else {
                        alert("请选中一行");
                    }
                }
            },
                {
                    text: dataUtil_actSetNStr('批量勾对', 1),
                    iconCls: 'icon-ok',
                    handler: function () { actSubmit(); }
                }]
        });
    }
    else {
        $(pageID).pagination({
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
                actLoadDataAll(pageNumber, pageSize);
            },
            buttons: [{
                text: dataUtil_actSetNStr('单据明细', 1),
                iconCls: 'icon-menu',
                handler: function () {
                    var data = $(datagridID).datagrid('getSelected');
                    if (data) {
                        print(datagridID);
                    }
                    else {
                        alert("请选中一行");
                    }
                }
            },
                {
                    text: dataUtil_actSetNStr('导出Excel', 1),
                    iconCls: 'icon-excel',
                    handler: function () { excelExport();}
                }]
        });
    }
}


/***********************************************************************
 *  批量勾对（未勾对的选项卡）
 *  
 */
function actSubmit() {
    var flag = false;

    var dataRows = $(m_DatagridID).datagrid('getSelections');

    var submitList = '';

    for (var i = 0; i < dataRows.length; i++) {
        if (dataRows[i].fa2_id && dataRows[i].fa2_id != '')
        {
            submitList +='\'' +dataRows[i].fa2_id + '\',';
        }
    }
    submitList = submitList.substring(0, submitList.length - 1);
    if (submitList != '') {
        $.messager.confirm('确认框', '确认勾对所选记录吗？', function (r) {
            if (r) {
                flag = setSubmit(submitList, m_UserInfo.UserName); 
                if (flag) {
                    alert('勾对成功！');
                    $(m_DatagridID).datagrid("clearSelections");
                    m_LastIndex = undefined;
                    actLoadData(1, m_PageSize);
                } else {
                    alert('勾对失败！');
                }
            }
        });
    } else {
        alert('请选择需勾对的记录！');
    }
    
    return flag;
}
 

/***********************************************************************
*  获取当前固定资产报销信息
* 
*/
function getPOApplyInfo(cons, page, num, orderby) {
    var res = '';
    var cXML = '<Page>' + m_PageNumber + '</Page><Num>' + m_PageSize + '</Num>'
            + '<Cons>' + cons + '</Cons><OrderBy>' + orderby + '</OrderBy>';
    cXML = basedata_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(3)) + "&type=GetPO&XML=" + encodeURIComponent(cXML) + "&s=" + new Date().getTime(); //拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (data.rows.length == 0) {
                    res = '';
                } else if (data.rows[0].fa2_id && data.rows[0].fa2_id != '') {
                    res = data;
                }
            }
        }
    })
    return res;
}


/***********************************************************************
*  固定资产报销勾对
*/
function setSubmit(submitlist, actor) {
    var res = false; 
    var cXML = '<submitid>' + submitlist + '</submitid>'
              + '<actor>' + actor + '</actor>';
    cXML = basedata_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(3)) + "&type=SetPO&XML=" + encodeURIComponent(cXML) + "&s=" + new Date().getTime(); //拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (data.rows[0].flag != undefined && data.rows[0].flag == 'F') {
                    res = false;
                }
                else {
                    res = true;
                }
            }
        }
    })
    return res;
}


///***********************************************************************
// *  打开配置窗体
// *  DLY 
// */
//function openExceldlg() {
//    $('#excelName').val('固定资产报销明细');
//    $('#exceldlg').dialog('open');
//}


///*******************
// * 文件夹目录选择
// */
//function browseFolder() {
//    try {
//        var message = "\u8bf7\u9009\u62e9\u6587\u4ef6\u5939"; //选择框提示信息
//        var shell = new ActiveXObject("Shell.Application");
//        var folder = shell.BrowseForFolder(0, message, 64, 17); //起始目录为：我的电脑
//        //var folder = shell.BrowseForFolder(0, message, 0); //起始目录为：桌面
//        if (folder != null) {
//            folder = folder.items(); // 返回 FolderItems 对象
//            folder = folder.item(); // 返回 Folderitem 对象
//            folder = folder.Path; // 返回路径
//            if (folder.charAt(folder.length - 1) != "\\") {
//                folder = folder + "\\";
//            }
//            $('#excelURL').val(folder);
//        }
//    }
//    catch (e) {
//        alert(e.message);
//    }
//}


///*******************
// * 固定资产报销信息导出Excel
// */
//function dataToExcel() {
//    if ($('#excelURL').val() == '')
//    {
//        alert(" 请选择文件目录！");
//    }
//    else if ($('#excelName').val() == '') {
//        alert("请输入文件名！");
//    } else {
//        var res = '';
//        var filename = $('#excelURL').val() + $('#excelName').val();
//        var fso = new ActiveXObject("Scripting.FileSystemObject");
//        //文件存在是否替换
//        var flag=true;
//        if (fso.FileExists(filename))
//        {
//            $.messager.confirm('确认框', '文件已存在，是否替换吗？', function (r) {
//                if (r) 
//                {
//                    flag=true;
//                }
//                else
//                {
//                    flag=false;
//                }
//            })
//        }
//        if (flag) {
//            var cXML = '<Page>' + m_PageNumber + '</Page><Num>' + m_PageSize + '</Num>'
//                    + '<Cons>' + m_FilterAll + '</Cons><OrderBy>' + 'FA2_POApplyCode DESC' + '</OrderBy>'
//                    + '<FileName>' + filename + '</FileName>';
//            cXML = basedata_addROOT(cXML);
//            //alert(cXML);	
//            var curl = GetWSRRURL(peoa_GetWSRRURL(3)) + "&type=ToExcel&XML=" + encodeURIComponent(cXML) + "&s=" + new Date().getTime(); //拼接url
//            $.ajax({
//                url: curl,
//                type: "GET",
//                async: false,
//                dataType: "json",
//                success: function (data) {
//                    //alert(jsonUtil_jsonToStr(data));
//                    if (data && data.rows) {
//                        if (data.rows.length == 0) {
//                            alert("Excel导出失败！");
//                        } else if (data.rows[0].filename && data.rows[0].filename != '') {
//                            //$.messager.alert("URL", "Excel的URL:" + data.rows[0].filename, "info");
//                            $.messager.alert("提示", "Excel导出成功！");
//                            $('#exceldlg').dialog('close');
//                        }
//                    }
//                }
//            })
//        }
//    }
    
//}


/***********************************************************************
 *  加载数据（未勾对的选项卡）
 *  
 */
function actLoadData(page, number) {
    var totalCount = 0;
    $(m_DatagridID).datagrid('loadData', []);
    m_PageNumber = page;
    m_PageSize = number;

    // 拼接查询条件
    var cons = m_Filter1;
    var poApplyCode = $('#poApplyCode').val();
    var applyUser = $('#applyUser').val();
    var deptName = $('#deptName').val();
    if (poApplyCode != '') {
        cons = cons + ' AND ( FA2_POApplyCode LIKE \'%' + poApplyCode + '%\')';
    }
    if (applyUser != '') {
        cons = cons + ' AND ( FA1_ApplyUser LIKE \'%' + applyUser + '%\')';
    }
    if (deptName != '') {
        cons = cons + ' AND ( FA1_DeptID LIKE \'%' + deptName + '%\''
                    + ' OR FA1_DeptName LIKE \'%' + deptName + '%\')';
    }
    var res = getPOApplyInfo(cons, page, number, ' FA2_POApplyCode DESC, FA2_Seq ');

    //alert(jsonUtil_jsonToStr(res));
    if (res == '') {
        alert('不存在相关报销未勾对！！');
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
 *  加载数据（所有的选项卡）
 *  
 */
function actLoadDataAll(page, number) {
    var totalCount = 0;
    $(m_DatagridAllID).datagrid('loadData', []);
    m_PageNumber = page;
    m_PageSize = number;
    //用于导出Excel的条件获取
    m_FilterAll = '';
    /// 拼接查询条件
    var cons = '';
    var state = $('#state').combobox('getValues');
    var applyUserAll = $('#applyUserAll').val();
    var deptNameAll = $('#deptNameAll').val();
    var gdDate = $('#gdDate').val();
    var gdUser = $('#gdUser').val();
    var applyDate = $('#applyDate').val();

    if (state != '' && state != '全部') {
        cons = cons + ' AND ( FA2_EState LIKE \'%' + state + '%\')';
    }
    if (applyUserAll != '') {
        cons = cons + ' AND ( FA1_ApplyUser LIKE \'%' + applyUserAll + '%\')';
    }
    if (deptNameAll != '') {
        cons = cons + ' AND ( FA1_DeptID LIKE \'%' + deptNameAll + '%\''
                    + ' OR FA1_DeptName LIKE \'%' + deptNameAll + '%\')';
    }
    if (gdDate != '') {
        cons = cons + ' AND ( CONVERT(varchar(50),FA2_GDDt,120) like \'%' + gdDate + '%\')';
    }
    if (gdUser != '') {
        cons = cons + ' AND ( FA2_GDUser LIKE \'%' + gdUser + '%\')';
    }
    if (applyDate != '') {
        cons = cons + ' AND ( CONVERT(varchar(50),FA1_ApplyDt,120) like \'%' + applyDate + '%\')';
    }
    var res = getPOApplyInfo(cons, page, number, ' FA2_POApplyCode DESC, FA2_Seq  ');

    //alert(jsonUtil_jsonToStr(res));
    if (res == '') {
        alert('不存在相关报销信息！');
    } else if (res.total > 0) {
        $(m_DatagridAllID).datagrid('loadData', res.rows);
        totalCount = res.total;
        m_FilterAll = cons;
    }

    $(m_DatagridAllID).datagrid("clearSelections");
    $('#cxpagerall').pagination({
        total: totalCount,
        pageNumber: page
    });
}



/***********************************************************************
 *  清除未勾选的选项卡
 *  
 */
function clearText() {
    $('#poApplyCode').val('');
    $('#applyUser').val('');
    $('#deptName').val('');
}


/***********************************************************************
 *  清除所有的选项卡
 *  
 */
function clearTextAll() {
    $('#state').combobox('setValue', '');
    $('#applyUserAll').val('');
    $('#deptNameAll').val('');
    $('#gdDate').val('');
    $('#gdUser').val('');
    $('#applyDate').val('');
}


/*******************
 * 调用打印页
 */
function print(datagridid) {
    var billcode = $(datagridid).datagrid('getSelected').fa2_poapplycode;
    window.open("../../../WEB/PE_OA/FA/FA_App_print.html?v0=" + billcode+"&v1=query");
}


function excelExport() {

    var listData = $(m_DatagridAllID).datagrid('getRows')

    if (listData.length <= 1 || listData == undefined) {
        alert("请先加载数据");
        return;
    }

    EasyUI_DataGrid_ExcelExport1($(m_DatagridAllID), $(m_DatagridAllID))
}


//导出Exel主函数
function EasyUI_DataGrid_ExcelExport1(pgrid, pagination) {
    var dataOptions = pgrid.datagrid("options");

    var cXML = '<Page>1</Page><Num>50000</Num>'
                    + '<Cons>' + m_FilterAll + '</Cons><OrderBy>' + 'FA2_POApplyCode DESC, FA2_Seq' + '</OrderBy>';
    cXML = basedata_addROOT(cXML);
    //alert(cXML);	
    var strUrl = GetWSRRURL(peoa_GetWSRRURL(3)) + "&type=GetPO&XML=" + encodeURIComponent(cXML); //拼接url

    //var strUrl = dataOptions.url;
    var dataColumns = dataOptions.columns;
    var dataColumnsFrozen = dataOptions.frozenColumns;
    var dataParam = dataOptions.queryParams;
    var pageSize = dataOptions.pageSize;
    var pageNumber = dataOptions.pageNumber;
    //var title = dataOptions.title;
    var title = "固定资产报销明细";

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
                    if (eval("[" + data + "]")[0].Error =="") {
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
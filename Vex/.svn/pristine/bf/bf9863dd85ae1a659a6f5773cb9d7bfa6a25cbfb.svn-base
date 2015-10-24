/* 全局变量*/
var m_DatagridID = '#wgddzyhplb';//未勾对低值易耗品报销列表
var m_DatagridAllID = '#dzyhplb';//所有低值易耗品报销列表 

var m_PageNumber = 1;  //当前页码
var m_PageSize = 20;  //每页显示行数 

//宽度设置
var m_widths = [120, 150, 120, 100, 70, 200, 300];
//状态选择
var m_State = [{ typeid: '已报销', typetext: '已报销' }, { typeid: '未报销', typetext: '未报销' }, { typeid: '全部', typetext: '全部' }];

var m_LastIndex = undefined;

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
 
    m_Filter1 = ' AND ( LV2_EState = \'未报销\')';
    //设置相关控件
    $('#gdxx').tabs('update', {
        tab: $('#gdxx').tabs('getTab', 0),
        options: {
            selected: true
        }
    });
    $('#gdxx').tabs({
        onSelect: function (title, index) {
            if (title == '未勾对' && index == 0) {
                clearText();
                actLoadData(1, m_PageSize);
            }
            else {
                if (m_TabFlag == false)
                {
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
        //title:'低值易耗品报销表',
        //width: $(document.body).width(),
        height: 350,
        nowrap: true,
        striped: true,
        collapsible: true,
        //url:'mroomlist.action',
        //sortName: 'c_code',
        //sortOrder: 'asc',
        remoteSort: false,
        idField: 'lv2_id',
        columns: [[
            { field: 'lv2_id', title: 'FID', width: 80, hidden: true },
            { field: 'lv2_assetsname', title: '资产名称', width: 120 },
            { field: 'lv1_assetstype', title: '资产类别', width: 70, hidden: true },
            { field: 'lv2_brandcode', title: '品牌', width: 80 },
            { field: 'lv2_model', title: '规格/型号', width: 80 },
            { field: 'lv2_number', title: '数量', width: 50, align: "center" },
            { field: 'lv2_applyprice', title: '申请单价', width: 80, align: "center" },
            { field: 'lv2_sureprice', title: '确认单价', width: 80, align: "center" },
            { field: 'lv2_usercode', title: '使用人编号', width: 80, hidden: true },
            { field: 'lv2_username', title: '使用人', width: 60 },
            { field: 'lv2_poapplycode', title: '申购单号', width: 130 },
            { field: 'lv1_applyuser', title: '申请人', width: 60 },
            { field: 'lv1_applydt', title: '申请日期', width: 75, hidden: true },
            { field: 'lv1_deptid', title: '申请部门编号', width: 100, hidden: true },
            { field: 'lv1_centercode', title: '成本中心', width: 80 },
            { field: 'lv1_deptname', title: '申请部门', width: 100 },
            { field: 'lv2_estate', title: '状态', width: 50 },
            { field: 'lv2_gduser', title: '勾对人', width: 60 },
            { field: 'lv2_gddt', title: '勾对时间', width: 125 }
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
                    handler: function () { excelExport(); }
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
        if (dataRows[i].lv2_id && dataRows[i].lv2_id != '') {
            submitList += '\'' + dataRows[i].lv2_id + '\',';
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
*  获取当前低值易耗品报销信息
* 
*/
function getPOApplyInfo(cons, page, num, orderby) {
    var res = '';
    var cXML = '<Page>' + m_PageNumber + '</Page><Num>' + m_PageSize + '</Num>'
            + '<Cons>' + cons + '</Cons><OrderBy>' + orderby + '</OrderBy>';
    cXML = basedata_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(15)) + "&type=GetPO&XML=" + encodeURIComponent(cXML) + "&s=" + new Date().getTime(); //拼接url
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
                } else if (data.rows[0].lv2_id && data.rows[0].lv2_id != '') {
                    res = data;
                }
            }
        }
    })
    return res;
}


/***********************************************************************
*  低值易耗品报销勾对
*/
function setSubmit(submitlist, actor) {
    var res = false;
    var cXML = '<submitid>' + submitlist + '</submitid>'
              + '<actor>' + actor + '</actor>';
    cXML = basedata_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(15)) + "&type=SetPO&XML=" + encodeURIComponent(cXML) + "&s=" + new Date().getTime(); //拼接url
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
        cons = cons + ' AND ( LV2_POApplyCode LIKE \'%' + poApplyCode + '%\')';
    }
    if (applyUser != '') {
        cons = cons + ' AND ( LV1_ApplyUser LIKE \'%' + applyUser + '%\')';
    }
    if (deptName != '') {
        cons = cons + ' AND ( LV1_DeptID LIKE \'%' + deptName + '%\''
                    + ' OR LV1_DeptName LIKE \'%' + deptName + '%\')';
    }
    var res = getPOApplyInfo(cons, page, number, ' LV2_POApplyCode DESC, LV2_Seq ');

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
        cons = cons + ' AND ( LV2_EState LIKE \'%' + state + '%\')';
    }
    if (applyUserAll != '') {
        cons = cons + ' AND ( LV1_ApplyUser LIKE \'%' + applyUserAll + '%\')';
    }
    if (deptNameAll != '') {
        cons = cons + ' AND ( LV1_DeptID LIKE \'%' + deptNameAll + '%\''
                    + ' OR LV1_DeptName LIKE \'%' + deptNameAll + '%\')';
    }
    if (gdDate != '') {
        cons = cons + ' AND ( CONVERT(varchar(50),LV2_GDDt,120) like \'%' + gdDate + '%\')';
    }
    if (gdUser != '') {
        cons = cons + ' AND ( LV2_GDUser LIKE \'%' + gdUser + '%\')';
    }
    if (applyDate != '') {
        cons = cons + ' AND ( CONVERT(varchar(50),LV1_ApplyDt,120) like \'%' + applyDate + '%\')';
    }
    var res = getPOApplyInfo(cons, page, number, ' LV2_POApplyCode DESC, LV2_Seq  ');

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
    $('#gdDate').val( '');
    $('#gdUser').val('');
    $('#applyDate').val( '');
}


/*******************
 * 调用打印页
 */
function print(datagridid) {
    var billcode = $(datagridid).datagrid('getSelected').lv2_poapplycode;
    window.open("../../../WEB/PE_OA/LV/LV_App_print.html?v0=" + billcode);
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
                    + '<Cons>' + m_FilterAll + '</Cons><OrderBy>' + 'LV2_POApplyCode DESC, LV2_Seq' + '</OrderBy>';
    cXML = basedata_addROOT(cXML);
    //alert(cXML);	
    var strUrl = GetWSRRURL(peoa_GetWSRRURL(15)) + "&type=GetPO&XML=" + encodeURIComponent(cXML); //拼接url

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
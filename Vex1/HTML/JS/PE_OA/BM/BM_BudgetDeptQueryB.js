 
var m_DatagridID = '#Budgetlb'; //预算列表ID 
var m_LastIndex = undefined;  //预算列表最后一次选中行下标  
var m_PageNumber = 1;  //当前页码
var m_PageSize = 1000;  //每页显示行数

var m_DatagridID1 = '#kmyshzlb'; //科目预算汇总列表ID- 分品牌
var m_TabsId = '#maintabs';// 主选择卡ID

var m_DatagridID2 = '#Budgetkmhzlb'; //部门预算科目汇总列表ID
var m_LastIndex2 = -1;  //部门预算科目汇总列表最后一次选中行下标   

//用户信息
var m_UserInfo = basedata_getUserInfo();


//基础数据
var m_Coms = [];  //公司
var m_Brands = []; //品牌
var m_Branchs = []; //大区

  

//预算科目类别数组
var m_DLList = [];
var m_XLList = [];  //随大类的小类
var m_XLList1 = []; //全部小类 


//状态
var m_States = [{ id: "0", text: "未提交" }, { id: "1", text: "已提交" }
    , { id: "2", text: "已审核" }, { id: "3", text: "全部" }];
//年份
var m_Years = [{ "text": "2014" }, { "text": "2015" }];
//部门类型
var m_ShopTypes = [{ "text": "自营" }, { "text": "加盟" }]; 

// 过滤条件
var m_FilterZHZ = 'AND 1 = 2';  //预算汇总主的条件
var m_Filter = '';  //主的条件
var m_Filter1 = ''; //第一页
var m_Filter2 = ''; //第二页 
var m_Filter3 = ''; //第三页 
var m_OrderBy = ' BG3_Com, BG3_Brand, BG3_Branch, BG3_CenterCode, BG3_DeptName, BG3_DLCode, BG3_XLCode'; //排序方式


//首次打开详细页标志
var m_openXXYFlag = 0;
var m_openHZYFlag = 0;
var m_Role = ''; //操作员身份

var m_btn3bgcolor = '#28b779';
/***********************************************************************
 *  初始化设置
 *  DLY 
 */
$(function () {
    // 当窗口大小发生变化时，调整DataGrid的大小
    $(window).resize(function () {
        $(m_TabsId).tabs('resize', {
            width: $(document.body).width()
            //height: getcurheight()
        }); 
        $(m_DatagridID1).datagrid('resize', {
            width: $(document.body).width()
            //height: getcurheight()
        }); 
        $(m_DatagridID).datagrid('resize', {
            width: $(document.body).width()
            //height: getcurheight()
        });
    });

    var cxml = '';

     
    //基础数据获取  
    var Comid = peoa_GetBDFID(14);//公司
    var Brandid = peoa_GetBDFID(15);//品牌
    var Branchid = peoa_GetBDFID(16);//大区
    var DLListid = peoa_GetBDFID(17);//预算科目大类
    var cons = ' AND CT1_FatherID in ('
             + '\'' + Comid + '\',' + '\'' + Brandid + '\','
             + '\'' + Branchid + '\',' + '\'' + DLListid + '\''
             + ') AND CT1_State=\'启用\''; 
    var res = basedata_getBDCommon('gbd12', cons); 
    var cons1 = ' AND CT1_FatherID in (\'11111111-1111-1111-1111-111111111111\'';  // 小类fatherid拼接
    for (var i = 0; i < res.length; i++) {
        var f1 = res[i].ct1_fatherid.toUpperCase();
        if (f1 == Comid.toUpperCase()) {
            m_Coms.push(res[i]);
        } else if (f1 == Brandid.toUpperCase()) {
            if (res[i].ct1_fieldvalues2 == m_UserInfo.UserName) {
                m_Brands.push(res[i]);
            }
        } else if (f1 == Branchid.toUpperCase()) {
            m_Branchs.push(res[i]);
        } else if (f1 == DLListid.toUpperCase()) {
            m_DLList.push(res[i]);
            cons1 = cons1 + ', \'' + res[i].ct1_id + '\'';
        }
    }
    cons1 = cons1 + ')';
    //取所有的小类
    m_XLList1 = basedata_getBDCommon('gbd12', cons1);
     
     

    //年份
    $('#cxYear').combobox({
        panelWidth: "90",
        panelHeight: "80",
        editable: false,
        multiple: false,
        valueField: 'text',
        textField: 'text',
        data: m_Years,
        onChange: function (data) {
        },
        onSelect: function (record) { 
        }
    });

    //品牌选项获取  
    $('#cxBrand').combobox({
        panelWidth: "90",
        panelHeight: "120",
        editable: false,
        multiple: false,
        valueField: 'ct1_code',
        textField: 'ct1_code',
        data: m_Brands,
        onChange: function (newValue, oldValue) { 
        },
        onSelect: function (record) { 
        },
        onShowPanel: function () { 
        }
    });

    //状态
    $('#cxState').combobox({
        panelWidth: "90",
        panelHeight: "100",
        editable: false,
        multiple: false,
        valueField: 'text',
        textField: 'text',
        data: m_States,
        onChange: function (data) {
        },
        onSelect: function (record) { 
        }
    });


    //部门选项获取  
    $('#cxDept').combobox({
        panelWidth: "160",
        panelHeight: "200",
        editable: true,
        multiple: true,
        valueField: 'oz1_orgcode',
        textField: 'oz1_orgname',
        data: [],
        onShowPanel: function (rowIndex) {
            $('#cxDept').combobox('loadData', []);
            var sbrand = $('#cxBrand').combobox('getValue');
            if (sbrand == '') {
                alert('请先选择品牌');
            } else {
                var cons = ' AND OZ1_Brand = \'' + sbrand + '\' '
                         + ' AND OZ1_State = \'' + '启用' + '\' '
                         + ' AND ISNULL(oz1_bmper,\'\') NOT IN (\'\') ';
                var cXML = '<Page>0</Page><Num>0</Num>'
                          + '<Cons>' + cons + '</Cons><OrderBy> ORDER BY oz1_orgname </OrderBy>'
                cXML = basedata_addROOT(cXML); 
                var curl = GetWSRRURL(peoa_GetWSRRURL(11)) + "&type=GetOrgs&XML=" + encodeURIComponent(cXML)
                    + "&s=" + new Date().getTime();  //拼接url   
                $.ajax({
                    url: curl,
                    options: "JSON",
                    async: false,
                    dataType: "json",
                    success: function (data) {
                        if (data.rows[0]) {  
                            $('#cxDept').combobox('loadData', data.rows);
                        }
                    }
                }); 
            }
        }  
    });
    


    // 标签页选中
    $(m_TabsId).tabs({
        border: false,//边框 
        onSelect: function (title) {
            if (title == '分部门汇总') {
                openHZY();  
            } if (title == '详细页') {
                openXXY();
            }
        }

    }); 
   
    //初始化赋值 
    clearText(1);  
    actspjllbcsh(m_DatagridID1);
});

 
/***********************************************************************
 *  清除条件
 *  DLY 
 */
function clearText(type) {
    if (type == 1) {
        $('#cxYear').combobox('setValue', basedata_getBMYear());
        $('#cxBrand').combobox('setValue', '');
        $('#cxState').combobox('setValue', '');
        $('#cxDept').combobox('setValues', '');
        $('#cxCostCenter').attr('value', '');
        $('#cxProject').attr('value', '');
    }
}


/***********************************************************************
 *  预算汇总列表初始化
 *  DLY 
 */
function actspjllbcsh(dgid) {
    $(dgid).datagrid({
        //title:'预算汇总列表', 
        //width: document.body.clientWidth,
        //height: getcurheight(), 
        height: 510,
        nowrap: true,
        striped: false,
        collapsible: true,
        //sortName: 'id',
        //sortOrder: 'asc',
        remoteSort: false,
        idField: 'id',
        frozenColumns: [[
        ]],
        columns: [[ 
            { field: 'id', title: 'FID', width: 100, hidden: true },  
            { field: 'bg3_year', title: '年份', width: 55},
            { field: 'bg3_brand', title: '品牌', width: 70 },
            {
                field: 'bg3_dlname', title: '大类名称', width: 80
                , formatter: function (val, row, index) {
                    return basedata_getCodename(m_DLList, row.bg3_dlcode, 'ct1_code', 'ct1_codename');
                }
            },
		    { field: 'bg3_dlcode', title: '大类代码', width: 80 },
		    {
		        field: 'bg3_xlname', title: '小类名称', width: 80
                , formatter: function (val, row, index) {
                    return basedata_getCodename(m_XLList1, row.bg3_xlcode, 'ct1_code', 'ct1_codename');
                }
		    },
		    { field: 'bg3_xlcode', title: '小类代码', width: 80 }, 
            {
                field: 'bg3_total', title: '合计', width: 90, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m1', title: '1月', width: 80, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m2', title: '2月', width: 80, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m3', title: '3月', width: 80, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m4', title: '4月', width: 80, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m5', title: '5月', width: 80, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m6', title: '6月', width: 80, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m7', title: '7月', width: 80, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m8', title: '8月', width: 80, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m9', title: '9月', width: 80, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m10', title: '10月', width: 80, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m11', title: '11月', width: 80, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m12', title: '12月', width: 80, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            }
        ]],
        pagination: false,
        rownumbers: true,
        singleSelect: true,
        onDblClickRow: function (rowIndex) {
            $(m_TabsId).tabs('select', '分部门汇总'); // 打开分部门汇总
        },
        onClickRow: function (rowIndex) {
        },
        onClickCell: function (rowIndex, field, value) {
        },
        onAfterEdit: function (index, row) {

        }, 
        toolbar: '#tjcxk1'
    }); 
}

 
/***********************************************************************
 *  加载预算汇总
 *  DLY 
 */
function actLoadDateSP() {
    $(m_DatagridID1).datagrid('loadData', []);
    $("#spanTatolpage").html(0);
    //拼接条件 获取数据集
    var syear = $('#cxYear').combobox('getValue');
    var sbrand = $('#cxBrand').combobox('getValue');
    var sdeptid = $('#cxDept').combobox('getValues'); 
    sdeptid = sdeptid == '' ? '' : ',' + sdeptid + ','; //两头加‘，’
    var scostcenter = $('#cxCostCenter').attr('value');
    var sproject = $('#cxProject').attr('value');
    var sstate = $('#cxState').combobox('getValue'); 
    sstate = sstate == '全部' ? '' : sstate;  //排除全部
    if (syear == '' || sbrand == '') {
        alert('年份和品牌必选！');
        return false;
    } 
    m_Filter1 = '<CONO></CONO><DIVI></DIVI>'
               + '<Year>' + syear + '</Year>'
               + '<Brand>' + sbrand + '</Brand>'
               + '<Dept>' + sdeptid + '</Dept>'
               + '<Project>' + sproject + '</Project>'
               + '<CostCenter>' + scostcenter + '</CostCenter>' 
               + '<State>' + sstate + '</State>';
    //alert(m_Filter1);
    var cXML = m_Filter1
             + '<Type>' + '品牌' + '</Type>' + '<DLCode></DLCode><XLCode></XLCode>';
    cXML = basedata_addROOT(cXML);
    var curl = GetWSRRURL(peoa_GetWSRRURL(14)) + "&type=GetDeptKMGQRows&XML=" + encodeURIComponent(cXML)
             + "&s=" + new Date().getTime(); //拼接url
    //alert(cXML);	
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        //contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows && data.rows.length > 0) {
                if (dataUtil_undefinedOrNull(data.rows[0].id, '') != '') {
                    $(m_DatagridID1).datagrid('loadData', data.rows);
                }
            }
        }
    });
    $(m_DatagridID1).datagrid("clearSelections");

    // 合计当前页金额  
    var sum = 0;
    var rows = $(m_DatagridID1).datagrid('getRows');
    for (var i = 0; i < rows.length; i++) {
        sum = sum * 1 + rows[i].bg3_total * 1;
    }
    $("#spanTatolpage").html(dataUtil_formatNum1(dataUtil_toFixed(sum, 0), '0'));
     

    //拼接第三页所需主条件
    var cfilter = ' AND bg3_type = \'1\'  AND isnull(bg3_state,0) = 0 ';
    cfilter = cfilter + ' AND  bg3_year = \'' + syear + '\'';
    cfilter = cfilter + ' AND  bg3_brand = \'' + sbrand + '\'';
    if (scostcenter != '') {
        cfilter = cfilter + ' AND  bg3_centercode like \'%' + scostcenter + '%\'';
    }
    if (sproject != '') {
        cfilter = cfilter + ' AND  bg3_project like \'%' + sproject + '%\'';
    }
    m_Filter3 = cfilter;

}
 

/***********************************************************************
 *  部门预算列表初始化
 *  DLY 
 */
function actyslbcsh(dgid) {
    $(dgid).datagrid({
        //title:'预算列表', 
        //width: document.body.clientWidth,
        //height: getcurheight(), 
        height: 510,
        nowrap: true,
        striped: false,
        collapsible: true,
        //sortName: 'id',
        //sortOrder: 'asc',
        remoteSort: false,
        idField: 'bg3_id',
        frozenColumns: [[ 
        ]],
        columns: [[
            { field: 'bg3_id', title: 'FID', width: 100, hidden: true },
            { field: 'bg3_cono', title: 'cono', width: 40, hidden: true },
            { field: 'bg3_divi', title: 'divi', width: 40, hidden: true },
            { field: 'bg3_type', title: '类别', width: 40, hidden: true },
            { field: 'bg3_year', title: '年份', width: 50, hidden: true },
            { field: 'bg3_brand', title: '品牌', width: 50, hidden: true },
            { field: 'bg3_com', title: '公司', width: 80, hidden: true },
            { field: 'bg3_branch', title: '大区', width: 80, hidden: true, hidden: true },
            { field: 'bg3_centercode', title: '成本中心', width: 80  },
            { field: 'bg3_project', title: '项目', width: 100 },
            { field: 'bg3_deptid', title: '部门编码', width: 100, hidden: true },
            { field: 'bg3_deptname', title: '部门名称', width: 100, hidden: true },
		    {
		        field: 'bg3_dlname', title: '大类名称', width: 80
                , formatter: function (val, row, index) {
                    return basedata_getCodename(m_DLList, row.bg3_dlcode, 'ct1_code', 'ct1_codename');
                }
		    },
		    { field: 'bg3_dlcode', title: '大类代码', width: 80 },
		    {
		        field: 'bg3_xlname', title: '小类名称', width: 80
                , formatter: function (val, row, index) {
                    return basedata_getCodename(m_XLList1, row.bg3_xlcode, 'ct1_code', 'ct1_codename');
                }
		    },
		    { field: 'bg3_xlcode', title: '小类代码', width: 80 },
            { field: 'bg3_remark1', title: '说明', width: 150},
            { field: 'bg3_total', title: '合计', width: 90, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            { field: 'bg3_m1', title: '1月', width: 80, align: "right" 
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            { field: 'bg3_m2', title: '2月', width: 80, align: "right" 
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            { field: 'bg3_m3', title: '3月', width: 80, align: "right" 
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            { field: 'bg3_m4', title: '4月', width: 80, align: "right" 
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            { field: 'bg3_m5', title: '5月', width: 80, align: "right" 
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            { field: 'bg3_m6', title: '6月', width: 80, align: "right" 
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            { field: 'bg3_m7', title: '7月', width: 80, align: "right" 
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            { field: 'bg3_m8', title: '8月', width: 80, align: "right" 
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            { field: 'bg3_m9', title: '9月', width: 80, align: "right" 
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            { field: 'bg3_m10', title: '10月', width: 80, align: "right" 
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            { field: 'bg3_m11', title: '11月', width: 80, align: "right" 
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            { field: 'bg3_m12', title: '12月', width: 80, align: "right" 
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
		    { field: 'bg3_state', title: '状态', width: 60, hidden: true }, 
            { field: 'bg3_remark2', title: '说明2', width: 100, editor: 'text', hidden: true },
			{ field: 'bg3_rgdt', title: '创建时间', width: 105 },
			{ field: 'bg3_rguser', title: '创建人', width: 70 },
		    { field: 'bg3_lmdt', title: '修改时间', width: 105 },
            { field: 'bg3_lmuser', title: '修改人', width: 70 },
            { field: 'bg3_uptno', title: '修改次数', width: 70 }
        ]],
        pagination: false,
        rownumbers: true,
        singleSelect: true,
        onDblClickRow: function (rowIndex) { 
        },
        onClickRow: function (rowIndex) { 
        },
        onClickCell: function (rowIndex, field, value) {
        },
        onAfterEdit: function (index, row) {

        },
        //onRowContextMenu: onRowContextMenu, 
        toolbar: '#tjcxkxxy'
    });

    $('#cxpagerxxy').pagination({
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
        },
        buttons: [  {
            text: '导出',
            iconCls: 'icon-menu',
            handler: function () {
                toExcel(3);
            }
        }]

    });
}
   

/***********************************************************************
 *  刷新费用明细列表数据
 *  DLY 
 */
function actLoadData() {
    var totalCount = 0; 
    page = 1;
    number = 1000;
    $(m_DatagridID).datagrid('loadData', []);
    var row = $(m_DatagridID2).datagrid('getSelected');
    if (!row) {
        $(m_TabsId).tabs('select', '分部门汇总'); // 返回分部门汇总
        alert('请先选择一条分部门汇总记录');
        return false;
    }
    //拼接条件 获取数据集
    var cons3 = '';
    cons3 = cons3 + ' AND  bg3_deptid = \'' + row.bg3_deptid + '\'';
    cons3 = cons3 + ' AND  bg3_dlcode = \'' + row.bg3_dlcode + '\'';
    cons3 = cons3 + ' AND  bg3_xlcode = \'' + row.bg3_xlcode + '\'';
    //alert(m_Filter3 + cons3);
    var cXML = '<Page>' + page + '</Page><Num>' + number + '</Num>'
             + '<Cons>' + m_Filter3 + cons3 + '</Cons><OrderBy>' + m_OrderBy + '</OrderBy>';
    cXML = basedata_addROOT(cXML);
    var curl = GetWSRRURL(peoa_GetWSRRURL(14)) + "&type=GetHs&XML=" + encodeURIComponent(cXML)
             + "&s=" + new Date().getTime(); //拼接url
    //alert(cXML);	
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        //contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows && data.rows.length > 0) {
                if (dataUtil_undefinedOrNull(data.rows[0].bg3_id, '') != '') { 
                    $(m_DatagridID).datagrid('loadData', data.rows);
                    totalCount = data.rows.length;
                }
            }
        }
    })
    $(m_DatagridID).datagrid("clearSelections"); 
    $('#cxpagerxxy').pagination({
        total: totalCount,
        pageNumber: page
    });
}
  
 
/*******************
 * 打开详细页
 */
function openXXY() { 
    if (m_openXXYFlag == 0) { 
        //初始化列表
        actyslbcsh(m_DatagridID); 
        m_openXXYFlag = 1;
    }
    actLoadData();
}
 

/***********************************************************************
 *  部门预算汇总列表初始化
 *  DLY 
 */
function actysHZlbcsh(dgid) { 
    $(dgid).datagrid({
        //title:'预算科目汇总列表', 
        //width: document.body.clientWidth,
        //height: getcurheight(), 
        height: 420,
        nowrap: true,
        striped: false,
        collapsible: true,
        //sortName: 'id',
        //sortOrder: 'asc',
        remoteSort: false,
        idField: 'id',
        frozenColumns: [[
        ]],
        columns: [[
            { field: 'id', title: 'FID', width: 100, hidden: true },
            { field: 'bg3_year', title: '年份', width: 50, hidden: true },
            { field: 'bg3_brand', title: '品牌', width: 50, hidden: true },
            { field: 'bg3_project', title: '项目', width: 100, hidden: true },
            { field: 'bg3_centercode', title: '成本中心', width: 80, hidden: true },
            { field: 'bg3_deptid', title: '部门编码', width: 100},
            { field: 'bg3_deptname', title: '部门名称', width: 100},
		    {
		        field: 'bg3_dlname', title: '大类名称', width: 80
                , formatter: function (val, row, index) {
                    return basedata_getCodename(m_DLList, row.bg3_dlcode, 'ct1_code', 'ct1_codename');
                }
		    },
		    { field: 'bg3_dlcode', title: '大类代码', width: 80 },
		    {
		        field: 'bg3_xlname', title: '小类名称', width: 80
                , formatter: function (val, row, index) {
                    return basedata_getCodename(m_XLList1, row.bg3_xlcode, 'ct1_code', 'ct1_codename');
                }
		    },
		    { field: 'bg3_xlcode', title: '小类代码', width: 80 },
            {
                field: 'bg3_total', title: '合计', width: 90, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m1', title: '1月', width: 80, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m2', title: '2月', width: 80, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m3', title: '3月', width: 80, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m4', title: '4月', width: 80, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m5', title: '5月', width: 80, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m6', title: '6月', width: 80, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m7', title: '7月', width: 80, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m8', title: '8月', width: 80, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m9', title: '9月', width: 80, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m10', title: '10月', width: 80, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m11', title: '11月', width: 80, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
            {
                field: 'bg3_m12', title: '12月', width: 80, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            }
        ]],
        pagination: false,
        rownumbers: true,
        singleSelect: true,
        onDblClickRow: function (rowIndex) {
            $(m_TabsId).tabs('select', '详细页'); // 打开详细页
        },
        onClickRow: function (rowIndex) {
        },
        onClickCell: function (rowIndex, field, value) {
        },
        onAfterEdit: function (index, row) {

        },
        //onRowContextMenu: onRowContextMenu, 
        toolbar: '#tjcxk'
    });

    $('#cxpager').pagination({
        total: 0,
        pageNumber: 1,
        pageSize: 300,//每页显示的记录条数，默认为20  
        //pageList: [20, 50, 100, 200, 1],//可以设置每页记录条数的列表  
        showPageList: false, //不显示每页记录数列表
        beforePageText: '第',//页数文本框前显示的汉字  
        afterPageText: '页    共 {pages} 页',
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',
        exportExcel: false,
        onBeforeRefresh: function () {
        },
        onSelectPage: function (pageNumber, pageSize) {
            actHZLoadData();
        },
        buttons: [{
            text: '导出',
            iconCls: 'icon-menu',
            handler: function () {
                toExcel(2);
            }
        }]

    });
}
 

/***********************************************************************
 *  刷新费用汇总列表数据
 *  DLY 
 */
function actHZLoadData() {
    var totalCount = 0;
    $(m_DatagridID2).datagrid('loadData', []);
    var row = $(m_DatagridID1).datagrid('getSelected');
    if (!row) {
        $(m_TabsId).tabs('select', '科目预算汇总'); // 返回科目预算汇总  
        alert('请先选择一条记录');
        return false;
    }
    //拼接条件 获取数据集 
    var sdlcode = row.bg3_dlcode;
    var sxlcode = row.bg3_xlcode;
    m_Filter2 = m_Filter1
              + '<Type>' + '部门B' + '</Type>'
              + '<DLCode>' + sdlcode + '</DLCode>'
              + '<XLCode>' + sxlcode + '</XLCode>'; 
    var cXML = basedata_addROOT(m_Filter2);
    var curl = GetWSRRURL(peoa_GetWSRRURL(14)) + "&type=GetDeptKMGQRows&XML=" + encodeURIComponent(cXML)
             + "&s=" + new Date().getTime(); //拼接url
    //alert(cXML);	
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        //contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows && data.rows.length > 0) {
                if (dataUtil_undefinedOrNull(data.rows[0].id, '') != '') { 
                    $(m_DatagridID2).datagrid('loadData', data.rows);
                    totalCount = data.rows.length;
                }
            }
        }
    })
    $(m_DatagridID2).datagrid("clearSelections");

    $('#cxpager').pagination({
        total: totalCount,
        pageNumber: 1
    });
} 
 

/*******************
 * 打开分部门汇总
 */
function openHZY(flag) {
    if (m_openHZYFlag == 0) {  
        //初始化列表
        actysHZlbcsh(m_DatagridID2); 
        m_openHZYFlag = 1;
    }
    actHZLoadData();
}


/*******************
 * 获取列表高度
 */
function toExcel(type) { 
    if (type == 1) {
        var rows = $(m_DatagridID1).datagrid('getRows');
        dataExpotToFile('3B', rows, m_DLList, m_XLList1);
    } else if (type == 2) {
        var rows = $(m_DatagridID2).datagrid('getRows');
        dataExpotToFile('3A', rows, m_DLList, m_XLList1);
    } else if (type == 3) { 
        var rows = $(m_DatagridID).datagrid('getRows');
        dataExpotToFile('3', rows, m_DLList, m_XLList1);
    }
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



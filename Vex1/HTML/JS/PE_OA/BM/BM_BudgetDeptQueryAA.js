 
var m_DatagridID = '#Budgetlb'; //预算列表ID 
var m_LastIndex = undefined;  //预算列表最后一次选中行下标  
var m_PageNumber = 1;  //当前页码
var m_PageSize = 1000;  //每页显示行数

var m_DatagridID1 = '#Tasklb'; //审批记录列表ID
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
var m_FilterSP = 'AND 1 = 2';  //审批记录主的条件
var m_Filter = '';  //主的条件
var m_Filter1 = ''; //查询条件
var m_Filter2 = ''; //查询条件到大类
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
    //确认操作员
    for (var i = 0; i < m_UserInfo.roles.length; i++) {
        var authorization_text = m_UserInfo.roles[i].authorization_name;
        var authorization_id = m_UserInfo.roles[i].authorization_id;
        if (authorization_text == '预算专员') {
            m_Role = 'A'
        } else if (authorization_text == '预算经理') {
            m_Role = 'B';
            break;
        }
    }


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
            if ((res[i].ct1_fieldvalues1).indexOf('|' + m_UserInfo.UserName + '|') >= 0
                || res[i].ct1_fieldvalues2 == m_UserInfo.UserName) {
                m_Brands.push(res[i]);
            }
        } else if (f1 == Branchid.toUpperCase()) {
            m_Branchs.push(res[i]);
        } else if (f1 == DLListid.toUpperCase()) {
            m_DLList.push(res[i]);
            cons1 = cons1 + ', \'' + res[i].ct1_id + '\'';
        }
    }
    m_Brands.push({ ct1_code: '全部', ct1_codename: '全部' });
    cons1 = cons1 + ')';
    //取所有的小类
    m_XLList1 = basedata_getBDCommon('gbd12', cons1);

  
    //根据角色拼接主查询条件
    if (m_Role == 'A') {
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
                var data1 = eval('(' + data + ')');
                if (data1.rows) {
                    m_UserInfo.depts = data1.rows;
                }
            }
        });
        m_FilterSP = ' AND bg4_deptid in (\'0000\' ';
        for (var i = 0; i < m_UserInfo.depts.length; i++) {
            m_FilterSP = m_FilterSP + ', \''+m_UserInfo.depts[i].oz1_orgcode+'\'';
        }
        m_FilterSP = m_FilterSP + ')';
        //m_FilterSP = ' AND bg4_rguser = \'' + m_UserInfo.UserName + '\' ';
    } else if (m_Role == 'B') {
        m_FilterSP = ' AND bg4_brand in ( \'00\''
        for (var i = 0; i < m_Brands.length; i++) {
            if (m_Brands[i].ct1_fieldvalues2 == m_UserInfo.UserName) {
                m_FilterSP = m_FilterSP + ', \'' + m_Brands[i].ct1_code + '\'';
            }
        }
        m_FilterSP = m_FilterSP + ')';
    }
     

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
            actLoadDateSP(); 
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
            actLoadDateSP(); 
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
            actLoadDateSP(); 
        }
    });


    // 标签页选中
    $(m_TabsId).tabs({
        border: false,//边框 
        onSelect: function (title) {
            if (title == '汇总页') { 
                openHZY();  
            } if (title == '详细页') {
                openXXY();
            }
        }

    }); 
   
    //初始化赋值 
    clearText(1); 
    actspjllbcsh(m_DatagridID1); 
    actLoadDateSP(); 
    
});

 
/***********************************************************************
 *  清除条件
 *  DLY 
 */
function clearText(type) {
    if (type == 1) {
        $('#cxYear').combobox('setValue', basedata_getBMYear());
        $('#cxBrand').combobox('setValue', '');
        $('#cxState').combobox('setValue', '已审核');
        $('#cxDept').val('');
    } else if (type == 2) { 
        $('#cxDLCode').combogrid('setValue', '');
        $('#cxXLCode').combobox('setValue', ''); 
        $('#cxCostCenter').attr('value', '');
        $('#cxProject').attr('value', '');
    }
}


/***********************************************************************
 *  审批记录列表初始化
 *  DLY 
 */
function actspjllbcsh(dgid) {
    $(dgid).datagrid({
        //title:'审批记录列表', 
        //width: document.body.clientWidth,
        //height: getcurheight(), 
        height: 510,
        nowrap: true,
        striped: false,
        collapsible: true,
        //sortName: 'id',
        //sortOrder: 'asc',
        remoteSort: false,
        idField: 'bg4_id',
        frozenColumns: [[
        ]],
        columns: [[ 
            { field: 'bg4_id', title: 'FID', width: 100, hidden: true },  
            { field: 'bg4_year', title: '年份', width: 55},
            { field: 'bg4_brand', title: '品牌', width: 70 },
            { field: 'bg4_deptid', title: '部门ID', width: 80},
            { field: 'bg4_deptname', title: '部门', width: 260 }, 
            {
                field: 'bg4_total', title: '总金额', width: 110, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val,0); }
            } 
        ]],
        pagination: false,
        rownumbers: true,
        singleSelect: true,
        onDblClickRow: function (rowIndex) {
            $(m_TabsId).tabs('select', '汇总页'); // 打开汇总页
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
            { field: 'bg3_centercode', title: '成本中心', width: 80, hidden: true  },
            { field: 'bg3_project', title: '项目', width: 100, hidden: true },
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
		    { field: 'bg4_subject', title: '主题', width: 260},
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
                var rows = $(m_DatagridID).datagrid('getRows');
                dataExpotToFile('3C_1', rows, m_DLList, m_XLList1);
            }
        }]

    });
}
 

/***********************************************************************
 *  费用明细查询事件：根据条件查询
 *  DLY 
 */
function searchByCons() { 
    $(m_DatagridID).datagrid('loadData', []);
    var row = $(m_DatagridID2).datagrid('getSelected');
    if (!row) {
        $(m_TabsId).tabs('select', '汇总页'); // 返回汇总页  
        alert('请先选择一条汇总页记录'); 
        return false;
    } 
    //拼接条件 获取数据集
    var syear = row.bg3_year;
    var sbrand = row.bg3_brand;
    var sdeptid = row.bg3_deptid;  
    var sdlcode = row.bg3_dlcode;
    var sxlcode = row.bg3_xlcode;
    var scostcenter = row.bg3_centercode;
    var sproject = row.bg3_project;
    var sstate = $("#cxState").combobox('getValue');
    var cfilter = ' AND bg3_type = \'1\'  AND isnull(bg3_state,0) = 0 ';
    cfilter = cfilter + ' AND  bg3_year = \'' + syear + '\'';
    cfilter = cfilter + ' AND  bg3_brand = \'' + sbrand + '\'';
    cfilter = cfilter + ' AND  bg3_deptid = \'' + sdeptid + '\''; 
    if (sdlcode != '') {
        cfilter = cfilter + ' AND  bg3_dlcode = \'' + sdlcode + '\'';
    }
    if (sxlcode != '') {
        cfilter = cfilter + ' AND  bg3_xlcode = \'' + sxlcode + '\'';
    } 
    if (scostcenter != '') {
        cfilter = cfilter + ' AND  bg3_centercode like \'%' + scostcenter + '%\'';
    }
    if (sproject != '') {
        cfilter = cfilter + ' AND  bg3_project like \'%' + sproject + '%\'';
    }
    if (sstate != '') {
        cfilter = cfilter + ' AND  bg4_state = \'' + sstate + '\'';
    }
    m_Filter2 = cfilter;
    m_PageNumber = 1;
    actLoadData(m_PageNumber, m_PageSize);

}
 

/***********************************************************************
 *  刷新费用明细列表数据
 *  DLY 
 */
function actLoadData(page, number) {
    var totalCount = 0; 
    m_PageNumber = page;
    m_PageSize = number;
    var cXML = '<Page>' + page + '</Page><Num>' + number + '</Num>'
             + '<Cons>' + m_Filter + m_Filter2 + '</Cons><OrderBy>' + m_OrderBy + '</OrderBy>';
    cXML = basedata_addROOT(cXML);
    var curl = GetWSRRURL(peoa_GetWSRRURL(14)) + "&type=GetHAAlls&XML=" + encodeURIComponent(cXML)
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
 

/***********************************************************************
 *  加载审批记录
 *  DLY 
 */
function actLoadDateSP() {   
    $(m_DatagridID1).datagrid('loadData', []);
    var cons = ' AND BG4_Type = \'1\' ';
    if ($('#cxYear').combobox('getValue') != '') {
        cons = cons + 'AND BG4_Year = \'' + $('#cxYear').combobox('getValue') + '\' ';
    }
    if ($('#cxBrand').combobox('getValue') != '' && $('#cxBrand').combobox('getValue') != '全部') {
        cons = cons + ' AND BG4_Brand = \'' + $('#cxBrand').combobox('getValue') + '\' ';
    }
    if ($('#cxState').combobox('getValue') != '' && $('#cxState').combobox('getValue') != '全部') {
        cons = cons + ' AND BG4_State = \'' + $('#cxState').combobox('getValue') + '\' ';
    }
    if ($('#cxDept').val() != '') {
        cons = cons + ' AND BG4_DeptName like \'%' + $('#cxDept').val() + '%\' ';
    }
    //alert(m_FilterSP + cons);
    var cXML = '<Page>1</Page><Num>1000</Num>'
             + '<Cons>' + m_FilterSP + cons + '</Cons><OrderBy>' + '' + '</OrderBy>'; 
    cXML = basedata_addROOT(cXML);
    var curl = GetWSRRURL(peoa_GetWSRRURL(14)) + "&type=GetApAAH&XML=" + encodeURIComponent(cXML)
             + "&s=" + new Date().getTime();//拼接url 
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) { 
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows && data.rows.length > 0) {
                if (dataUtil_undefinedOrNull(data.rows[0].bg4_id, '') != '') { 
                    $(m_DatagridID1).datagrid('loadData', data.rows); 
                }
            }
        }
    })
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
    searchByCons(); 
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
            { field: 'bg3_project', title: '项目', width: 100 },
            { field: 'bg3_centercode', title: '成本中心', width: 80 },
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
                var rows = $(m_DatagridID2).datagrid('getRows');
                dataExpotToFile('3A', rows, m_DLList, m_XLList1);
            }
        }]

    });
}


/***********************************************************************
 *  费用汇总查询事件：根据条件查询
 *  DLY 
 */
function searchHZByCons() { 
    $(m_DatagridID2).datagrid('loadData', []);
    var row = $(m_DatagridID1).datagrid('getSelected');
    if (!row) {
        $(m_TabsId).tabs('select', '列表页'); // 返回列表页  
        alert('请先选择一条记录');
        return false;
    }
    $("#spansubject").html(row.bg4_year + '-' + row.bg4_brand+'-'+row.bg4_deptname+'-部门预算');
    $("#spanstate").html('已审核');
    $("#spanTatol").html(dataUtil_formatNum1(dataUtil_toFixed(row.bg4_total*1, 0), '0'));

    //拼接条件 获取数据集
    var syear = row.bg4_year;
    var sbrand = row.bg4_brand;
    var sdeptid = row.bg4_deptid;
    var sdlcode = $('#cxDLCode').combogrid('getValue');
    var sxlcode = $("#cxXLCode").combobox('getValue');
    var scostcenter = $('#cxCostCenter').attr('value');
    var sproject = $('#cxProject').attr('value');
    var sstate = $("#cxState").combobox('getValue');
     
    var cfilter =  '<CONO></CONO><DIVI></DIVI>'
                + '<Type>' + '部门' + '</Type>'
                + '<Year>' + syear + '</Year>'
                + '<Brand>' + sbrand + '</Brand>'
                + '<Dept>' + sdeptid + '</Dept>'
                + '<Project>' + sproject + '</Project>'
                + '<CostCenter>' + scostcenter + '</CostCenter>'
                + '<DLCode>' + sdlcode + '</DLCode>'
                + '<XLCode>' + sxlcode + '</XLCode>'
                + '<State>' + sstate + '</State>';
      
    m_Filter1 = cfilter;  
    actHZLoadData();

}


/***********************************************************************
 *  刷新费用汇总列表数据
 *  DLY 
 */
function actHZLoadData() {
    var totalCount = 0; 
    $("#spanTatolpage").html(0); 
    var cXML = m_Filter1;
    //alert(m_Filter1);
    cXML = basedata_addROOT(cXML);
    var curl = GetWSRRURL(peoa_GetWSRRURL(14)) + "&type=GetDeptKMGQRowsA&XML=" + encodeURIComponent(cXML)
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


    // 合计当前页金额  
    var sum = 0;
    var rows = $(m_DatagridID2).datagrid('getRows');
    for (var i = 0; i < rows.length; i++) {
        sum = sum * 1 + rows[i].bg3_total * 1;
    }
    $("#spanTatolpage").html(dataUtil_formatNum1(dataUtil_toFixed(sum, 0), '0'));

     

    $('#cxpager').pagination({
        total: totalCount,
        pageNumber: 1
    });
} 


/*******************
 * 打开汇总页
 */
function openHZY(flag) {
    if (m_openHZYFlag == 0) { 
        //科目大类选项获取  
        $('#cxDLCode').combogrid({
            panelWidth: "200",
            panelHeight: "160",
            editable: false,
            multiple: false,
            idField: 'ct1_code',
            textField: 'ct1_codename',
            data: m_DLList,
            columns: [[
                { field: 'ct1_code', title: '代码', width: 50 },
                { field: 'ct1_codename', title: '大类名称', width: 130 }
            ]],
            onClickRow: function (rowIndex) {
                var row = $('#cxDLCode').combogrid('grid').datagrid('getSelected');
                //设置小类选择div
                var XLListid = row.ct1_id; //预算科目小类
                var cons = ' AND CT1_FatherID = \'' + XLListid + '\''
                         + ' AND CT1_State=\'启用\'';
                m_XLList = basedata_getBDCommon('gbd12', cons);
            }
        });

        //科目小类选项获取  
        $('#cxXLCode').combobox({
            panelWidth: "130",
            panelHeight: "120",
            editable: false,
            multiple: false,
            valueField: 'ct1_code',
            textField: 'ct1_codename',
            data: m_XLList,
            onChange: function (newValue, oldValue) {
            },
            onShowPanel: function () {
                $('#cxXLCode').combobox('loadData', m_XLList);
            }
        });

        //初始化列表
        actysHZlbcsh(m_DatagridID2); 
        m_openHZYFlag = 1;
    }
     searchHZByCons();
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



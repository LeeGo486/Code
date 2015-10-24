var m_DatagridID = '#Budgetlb'; //预算列表ID
var m_LastIndex = undefined;  //预算列表最后一次选中行下标  
var m_PageNumber = 1;  //当前页码
var m_PageSize = 20;  //每页显示行数

var m_DatagridID1 = '#Tasklb'; //审批记录列表ID
var m_TabsId = '#maintabs';// 主选择卡ID

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
var m_FilterSP = '';  //审批记录主的条件
var m_Filter = '';  //主的条件
var m_Filter1 = ''; //查询条件
var m_Filter2 = ''; //查询条件到大类
var m_OrderBy = ' BG3_Com, BG3_Brand, BG3_Branch, BG3_CenterCode, BG3_DeptName, BG3_DLCode, BG3_XLCode'; //排序方式


//首次打开详细页标志
var m_openXXYFlag = 0; 
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
        //根据index.html页面的高度设置列表高度 
        $(m_DatagridID1).datagrid('resize', {
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
    m_Brands.push({ ct1_code: '全部', ct1_codename: '全部' });
    cons1 = cons1 + ')';
    //取所有的小类
    m_XLList1 = basedata_getBDCommon('gbd12', cons1);

  
    //根据角色拼接主查询条件
    if (m_Role == 'A') {
        m_FilterSP = ' AND bg4_rguser = \'' + m_UserInfo.UserName + '\' AND 1<>1 ';
    } else if (m_Role == 'B') {
        m_FilterSP = ' AND bg4_brand in ( \'00\''
        for (var i = 0; i < m_Brands.length; i++) { 
             m_FilterSP = m_FilterSP + ', \'' + m_Brands[i].ct1_code + '\''; 
        }
        m_FilterSP = m_FilterSP + ') AND  bg4_state = \'已提交\' ';
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
            if (title == '详细页') { 
                openXXY(m_openXXYFlag); 
                m_openXXYFlag = 1;
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
        $('#cxState').combobox('setValue', '');
        $('#cxDept').val('');
    } else if (type == 2) {
        $('#cxCom').combobox('setValue', '');
        $('#cxBranch').combobox('setValue', '');
        $('#cxDLCode').combogrid('setValue', '');
        $('#cxXLCode').combobox('setValue', '');
        $('#cxShopType').combobox('setValue', '');
        $('#cxCostCenter').attr('value', '');
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
            { field: 'bg4_cono', title: 'cono', width: 40, hidden: true },
            { field: 'bg4_divi', title: 'divi', width: 40, hidden: true },
            { field: 'bg4_type', title: '类别', width: 40, hidden: true },
            { field: 'bg4_year', title: '年份', width: 55},
            { field: 'bg4_brand', title: '品牌', width: 70 },
            { field: 'bg4_deptid', title: '部门id', width: 130, hidden: true },
            { field: 'bg4_deptname', title: '部门', width: 130 },
            { field: 'bg4_subject', title: '主题', width: 200 },
            {
                field: 'bg4_total', title: '总金额', width: 110, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val,0); }
            },
            { field: 'bg4_upper1', title: '提交人', width: 60},
            { field: 'bg4_updt1', title: '提交日期', width: 80},
            { field: 'bg4_upper2', title: '审批人', width: 60},
            { field: 'bg4_updt2', title: '审批日期', width: 110}, 
            { field: 'bg4_state', title: '状态', width: 60 },
            { field: 'bg4_rguser', title: '创建人', width: 60 }
        ]],
        pagination: false,
        rownumbers: true,
        singleSelect: true,
        onDblClickRow: function (rowIndex, rowData) { 
            var title = rowData.bg4_subject;
            var curl = ''; 
            curl = '../../../WEB/PE_OA/BM/BM_BudgetDept.html?v0=sp&v1=' + rowData.bg4_id;
            addTab(title, curl);
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
            { field: 'bg3_brand', title: '品牌', width: 50 },
            { field: 'bg3_com', title: '公司', width: 80 },
            { field: 'bg3_branch', title: '大区', width: 80, hidden: true },
            { field: 'bg3_centercode', title: '成本中心', width: 80},
            { field: 'bg3_deptid', title: '部门编码', width: 100, hidden: true },
            { field: 'bg3_deptname', title: '部门名称', width: 100 },
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
        toolbar: '#tjcxk'
    });

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
        },
        buttons: [  {
            text: '导出当前页',
            iconCls: 'icon-menu',
            handler: function () {
                var rows = $(m_DatagridID).datagrid('getRows');
                dataExpotToFile('1', rows, m_DLList, m_XLList1);
            }
        }, '-', {
            text: '导出全部',
            iconCls: 'icon-menu',
            handler: function () {
                var cXML = '<Page>' + 1 + '</Page><Num>' + 5000 + '</Num>'
                         + '<Cons>' + m_Filter + m_Filter1 + '</Cons><OrderBy>' + m_OrderBy + '</OrderBy>';
                cXML = basedata_addROOT(cXML);
                var curl = GetWSRRURL(peoa_GetWSRRURL(14)) + "&type=GetHs&XML=" + encodeURIComponent(cXML)
                         + "&s=" + new Date().getTime(); //拼接url 
                $.ajax({
                    url: curl,
                    type: "GET",
                    async: false,
                    //contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) { 
                        if (data && data.rows && data.rows.length > 0) {
                            if (dataUtil_undefinedOrNull(data.rows[0].bg3_id, '') != '') {
                                dataExpotToFile('1', data.rows, m_DLList, m_XLList1);
                            }
                        }
                    }
                })
                
            }
        }]

    });
}
 

/***********************************************************************
 *  查询事件：根据条件查询
 *  DLY 
 */
function searchByCons() {
    $("#spanTatolpage").html('');
    $("#spanTatol").html('');
    $(m_DatagridID).datagrid('loadData', []);
    var row = $(m_DatagridID1).datagrid('getSelected');
    if (!row) {
        $(m_TabsId).tabs('select', '列表页'); // 返回列表页  
        alert('请先选择一条记录'); 
        return false;
    }
    //拼接条件 获取数据集
    var syear = row.bg4_year;
    var sbrand = row.bg4_brand;
    var sdeptid = row.bg4_deptid;  
    var sdlcode = $('#cxDLCode').combogrid('getValue');
    var sxlcode = $("#cxXLCode").combobox('getValue'); 
    var scostcenter = $('#cxCostCenter').attr('value');
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
    m_Filter1 = cfilter;
    m_Filter2 = cfilter;
    m_PageNumber = 1;
    actLoadData(m_PageNumber, m_PageSize);

}
 

/***********************************************************************
 *  刷新列表数据
 *  DLY 
 */
function actLoadData(page, number) {
    var totalCount = 0;
    $("#spanTatol").html(0);
    $("#spanTatolpage").html(0);
    m_PageNumber = page;
    m_PageSize = number;
    var cXML = '<Page>' + page + '</Page><Num>' + number + '</Num>'
             + '<Cons>' + m_Filter + m_Filter1 + '</Cons><OrderBy>' + m_OrderBy + '</OrderBy>';
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
                    var rows = [];
                    for (var i = 0; i < 20; i++) {
                        rows.push(data.rows[1]);
                    }
                    $(m_DatagridID).datagrid('loadData', data.rows); 
                }
            }
        }
    })
    $(m_DatagridID).datagrid("clearSelections");


    // 合计当前页金额  
    var sum = 0;
    var rows = $(m_DatagridID).datagrid('getRows');
    for (var i = 0; i < rows.length; i++) {
        sum = sum * 1 + rows[i].bg3_total * 1;
    }
    $("#spanTatolpage").html(dataUtil_formatNum1(dataUtil_toFixed(sum, 0), '0'));

    // 合计总金额
    var cXML = '<Page>1</Page><Num>1</Num>'
             + '<Cons>' + m_Filter + m_Filter2 + '</Cons><OrderBy>' + m_OrderBy + '</OrderBy>';
    cXML = basedata_addROOT(cXML);
    var curl = GetWSRRURL(peoa_GetWSRRURL(14)) + "&type=GetSums&XML=" + encodeURIComponent(cXML)
             + "&s=" + new Date().getTime(); //拼接url 
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        //contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            $("#spanTatol").html('0');
            if (data && data.rows && data.rows.length > 0) {
                if (dataUtil_undefinedOrNull(data.rows[0].totalcount, 0) > 0) {
                    $("#spanTatol").html(dataUtil_formatNum1(data.rows[0].stotal, '0'));
                    totalCount = data.rows[0].totalcount;
                }
            }
        }
    })

    $('#cxpager').pagination({
        total: totalCount,
        pageNumber: page
    });
}
 

/***********************************************************************
 *  加载审批记录
 *  DLY 
 */
function actLoadDateSP() {  
    $("#btnUp").hide();
    $("#btnDn").hide();
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
    var cXML = '<Page>1</Page><Num>1000</Num>'
             + '<Cons>' + m_FilterSP + cons + '</Cons><OrderBy>' + '' + '</OrderBy>'; 
    cXML = basedata_addROOT(cXML);
    var curl = GetWSRRURL(peoa_GetWSRRURL(14)) + "&type=GetApH&XML=" + encodeURIComponent(cXML)
             + "&s=" + new Date().getTime();//拼接url 
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            if (data && data.rows && data.rows.length > 0) {
                if (dataUtil_undefinedOrNull(data.rows[0].bg4_id, '') != '') { 
                    $(m_DatagridID1).datagrid('loadData', data.rows); 
                }
            }
        }
    })
}
 

/***********************************************************************
 *  流程记录改变事件 
 *  DLY 
 */
function changeSPRow() { 
    $("#btnUp").hide();
    $("#btnDn").hide();
    var row = $(m_DatagridID1).datagrid('getSelected');
    if (!row) {
        return false;
    } 
    $("#spansubject").html(row.bg4_subject);
    $("#spanstate").html(row.bg4_state); 
           
    if (row.bg4_state == '未提交') {
        $("#spanbtnUp").html('提交');
        $("#btnUp").show();
        $("#btnDn").hide();
    } else if (row.bg4_state == '已提交' && m_Role == 'B') {
        $("#spanbtnUp").html('审核');
        $("#btnUp").show();
        $("#btnDn").show();
    } else{
        $("#btnUp").hide();
        $("#btnDn").hide();
    } 
}


/***********************************************************************
 *  提交或审核事件 
 *  DLY 
 */
function actUp(type) { 
    var info = '';
    var actinfo = '';
    var selrow = $(m_DatagridID1).datagrid('getSelected');
    var rindex = $(m_DatagridID1).datagrid('getRowIndex', selrow);
    var row = {};
    row.bg4_id = selrow.bg4_id;
    if (type == 'up') {
        //提交校验
        if (!upCheck(selrow)) {
            return false;
        }
        if ($("#spanbtnUp").html() == '提交') {
            row.bg4_upper1 = m_UserInfo.UserName;
            row.bg4_updt1 = dateUtil_dateFomaterB(new Date(), '-');
            row.bg4_updt2 = '';
            row.bg4_upper2 = '';
            row.bg4_state = '已提交';
            info = '确认提交“' + selrow.bg4_subject + '”吗？';
            actinfo = '提交';
        } else if ($("#spanbtnUp").html() == '审核') {
            row.bg4_upper1 = selrow.bg4_upper1;
            row.bg4_updt1 = selrow.bg4_updt1;
            row.bg4_upper2 = m_UserInfo.UserName;
            row.bg4_updt2 = dateUtil_dateFomaterB(new Date(), '-');
            row.bg4_state = '已审核';
            info = '确认审核“' + selrow.bg4_subject + '”吗？';
            actinfo = '审核';
        }
    } else if (type == 'dn') {
        row.bg4_upper1 = selrow.bg4_upper1;
        row.bg4_updt1 = selrow.bg4_updt1;
        row.bg4_upper2 = m_UserInfo.UserName;
        row.bg4_updt2 = dateUtil_dateFomaterB(new Date(), '-') + ' (驳回)';
        row.bg4_state = '未提交';
        info = '确认驳回“' + selrow.bg4_subject + '”吗？';
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
                            selrow.bg4_upper1 = row.bg4_upper1;
                            selrow.bg4_updt1 = row.bg4_updt1;
                            selrow.bg4_updt2 = row.bg4_updt2;
                            selrow.bg4_upper2 = row.bg4_upper2;
                            selrow.bg4_state = row.bg4_state;
                            $(m_DatagridID1).datagrid('updateRow', {
                                index: rindex,
                                row: selrow
                            }); 
                            changeSPRow();
                            $(m_DatagridID1).datagrid('selectRow', rindex); 
                            $.messager.alert("提示", actinfo + "成功！");
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


/*******************
 * 提交校验
 */
function upCheck(currow) {
    var flag = true;
    var curmoney = currow.bg4_total;
    if (curmoney==undefined || curmoney <= 0) {
        alert('总金额必须大于0！');
        return false;
    } 

    var bmmoney = 0; 
    var cons = ' AND OZ1_OrgCode=\'' + currow.bg4_deptid + '\' ';
    var cXML = '<Page>' + '' + '</Page><Num>' + '' + '</Num>'
        + '<Cons>' + cons + '</Cons><OrderBy>' + ' order by isnull(oz1_bmmoney,0) desc ' + '</OrderBy>';
    cXML = basedata_addROOT(cXML);
    var curl = GetWSRRURL(peoa_GetWSRRURL(11)) + "&type=GetOrgs&XML=" + encodeURIComponent(cXML); //拼接url 
    $.ajax({
        url: curl,
        options: "JSON",
        async: false,
        success: function (data) { 
            var data1 = eval('(' + data + ')');
            if (data1.rows && data1.rows.length>0) {
                bmmoney = data1.rows[0].oz1_bmmoney;
            }
        }
    });
     
    if (bmmoney > 0 && curmoney > bmmoney) {
        alert('总金额不能大于' + bmmoney + '！');
        flag = false;
    }

    return flag; 

}


/***********************************************************************
 *  打开单据明细
 *  DLY
 *  2014-05-15
 */
function addTab(title, url) {
    var content = '未实现';
    if ($(m_TabsId).tabs('exists', title)) {
        $(m_TabsId).tabs('select', title);
    } else {
        var h = window.screen.height - 20;
        h = 500;
        if (url) {
            content = '<iframe frameborder="0"  src="'
		        + url + '" style="overflow:hidden;width:100%;height:' + h + 'px;"></iframe>';
        } else {
            content = '未实现';
        }
        $(m_TabsId).tabs('add', {
            title: title,
            content: content,
            closable: true
        });
    }
}


/***********************************************************************
	 *  根据title关闭选项卡
	 *  DLY
	 *  2013-05-25
	 */
function closeTab(title) {
    //alert(title);
    $(m_TabsId).tabs('close', title);
    actLoadDateSP();
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



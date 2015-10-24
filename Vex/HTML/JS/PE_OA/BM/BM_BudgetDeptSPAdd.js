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
var m_OrderBy = ' convert(varchar(20),BG7_RgDt,120) desc '; //排序方式


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
        m_FilterSP = ' AND bg7_deptid in (\'0000\' ';
        for (var i = 0; i < m_UserInfo.depts.length; i++) {
            m_FilterSP = m_FilterSP + ', \'' + m_UserInfo.depts[i].oz1_orgcode + '\'';
        }
        m_FilterSP = m_FilterSP + ')';
    } else if (m_Role == 'B') {
        m_FilterSP = ' AND bg7_brand in ( \'00\''
        for (var i = 0; i < m_Brands.length; i++) { 
             m_FilterSP = m_FilterSP + ', \'' + m_Brands[i].ct1_code + '\''; 
        }
        m_FilterSP = m_FilterSP + ') AND bg7_state not in (\'未提交\') '; // 
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
            actLoadDateSP(m_PageNumber, m_PageSize);
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
            actLoadDateSP(m_PageNumber, m_PageSize);
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
            actLoadDateSP(m_PageNumber, m_PageSize);
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
    if (m_Role == 'A') {
        $('#cxState').combobox('setValue','未提交');
    } else if (m_Role == 'B') { 
        $('#cxState').combobox('setValue', '已提交');
    }
    actLoadDateSP(m_PageNumber, m_PageSize); 
    
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
        idField: 'bg7_id',
        frozenColumns: [[
        ]],
        columns: [[ 
            { field: 'bg7_id', title: 'FID', width: 100, hidden: true },
            { field: 'bg7_cono', title: 'cono', width: 40, hidden: true },
            { field: 'bg7_divi', title: 'divi', width: 40, hidden: true },
            { field: 'bg7_type', title: '类别', width: 40, hidden: true },
            { field: 'bg7_year', title: '年份', width: 55},
            { field: 'bg7_brand', title: '品牌', width: 60 },
            { field: 'bg7_deptid', title: '部门id', width: 130, hidden: true },
            { field: 'bg7_deptname', title: '部门', width: 130 },
            { field: 'bg7_subject', title: '主题', width: 260 },
            {
                field: 'bg7_total', title: '总金额', width: 110, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val,0); }
            },
            { field: 'bg7_upper1', title: '提交人', width: 60},
            { field: 'bg7_updt1', title: '提交日期', width: 80},
            { field: 'bg7_upper2', title: '审批人', width: 60},
            { field: 'bg7_updt2', title: '审批日期', width: 110}, 
            { field: 'bg7_state', title: '状态', width: 60 },
            { field: 'bg7_rguser', title: '创建人', width: 60 },
            { field: 'bg7_rgdt', title: '创建时间', width: 105 }
        ]],
        pagination: false,
        rownumbers: true,
        singleSelect: true,
        onDblClickRow: function (rowIndex, rowData) { 
            var title = rowData.bg7_subject;
            var curl = ''; 
            curl = '../../../WEB/PE_OA/BM/BM_BudgetDeptAdd.html?v0=sp&v1=' + rowData.bg7_id;
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

    $('#cxpager').pagination({
        total: 0,
        pageNumber: 1,
        pageSize: m_PageSize,//每页显示的记录条数，默认为10  
        pageList: [20, 100, 200],//可以设置每页记录条数的列表  
        showPageList: false, //不显示每页记录数列表
        beforePageText: '第',//页数文本框前显示的汉字  
        afterPageText: '页    共 {pages} 页',
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',
        exportExcel: false,
        onBeforeRefresh: function () {
        },
        onSelectPage: function (pageNumber, pageSize) {
            actLoadDateSP(pageNumber, pageSize);
        },
        buttons: [{
            text: '新建',
            iconCls: 'icon-add',
            handler: function () {
                var title = '新追加部门预算';
                var curl = '';
                curl = '../../../WEB/PE_OA/BM/BM_BudgetDeptAdd.html?v0=add&v1=' + dataUtil_NewGuid(); 
                addTab(title, curl); 
            }
        }]

    });
} 

/***********************************************************************
 *  加载审批记录
 *  DLY 
 */
function actLoadDateSP(page, size) {
    if (page != undefined && size != undefined) {
        m_PageNumber = page;
        m_PageSize = size;
    }
    var totalCount = 0;
    $("#btnUp").hide();
    $("#btnDn").hide();
    $(m_DatagridID1).datagrid('loadData', []);
    var cons = ' AND bg7_Type = \'1\' ';
    if ($('#cxYear').combobox('getValue') != '') {
        cons = cons + 'AND bg7_Year = \'' + $('#cxYear').combobox('getValue') + '\' ';
    }
    if ($('#cxBrand').combobox('getValue') != '' && $('#cxBrand').combobox('getValue') != '全部') {
        cons = cons + ' AND bg7_Brand = \'' + $('#cxBrand').combobox('getValue') + '\' ';
    }
    if ($('#cxState').combobox('getValue') != '' && $('#cxState').combobox('getValue') != '全部') {
        cons = cons + ' AND bg7_State = \'' + $('#cxState').combobox('getValue') + '\' ';
    }
    if ($('#cxDept').val() != '') {
        cons = cons + ' AND bg7_DeptName like \'%' + $('#cxDept').val() + '%\' ';
    } 
    var cXML = '<Page>' + m_PageNumber + '</Page><Num>' + m_PageSize + '</Num>'
             + '<Cons>' + m_FilterSP + cons + '</Cons><OrderBy>' + m_OrderBy + '</OrderBy>';
    cXML = basedata_addROOT(cXML);
    var curl = GetWSRRURL(peoa_GetWSRRURL(14)) + "&type=GetApAH&XML=" + encodeURIComponent(cXML)
             + "&s=" + new Date().getTime();//拼接url 
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            if (data && data.rows && data.rows.length > 0) {
                if (dataUtil_undefinedOrNull(data.rows[0].bg7_id, '') != '') {
                    $(m_DatagridID1).datagrid('loadData', data.rows);
                    totalCount = data.total;
                }
            }
        }
    });

    $(m_DatagridID1).datagrid('clearSelections');
    $('#cxpager').pagination({
        total: totalCount,
        pageNumber: m_PageNumber
    });

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
    actLoadDateSP(m_PageNumber, m_PageSize);
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



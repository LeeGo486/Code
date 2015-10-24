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
  

//资产类别数组
var m_DLList = [];
var m_XLList = [];   


//状态
var m_States = [{ id: "0", text: "未提交" }, { id: "1", text: "已提交" }
    , { id: "2", text: "已审核" }, { id: "3", text: "全部" }];
//年份
var m_Years = [{ "text": "2014" }, { "text": "2015" }]; 

// 过滤条件
var m_FilterSP = '';  //审批记录主的条件
var m_Filter = '';  //主的条件
var m_Filter1 = ''; //查询条件
var m_Filter2 = ''; //查询条件到大类
var m_OrderBy = ' BG1_Years, BG1_Com, BG1_CenterCode, BG1_LargeClassCode, BG1_SmallClassCode, BG1_AssetsName '; //排序方式


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
        //根据index.html页面的高度设置列表高度 
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
        if (authorization_text == '固定资产预算专员') {
            m_Role = 'A'
        } else if (authorization_text == '预算经理') {
            m_Role = 'B';
            break;
        }
    }


    //基础数据获取  
    var Comid = peoa_GetBDFID(14);//公司
    var Brandid = peoa_GetBDFID(15);//品牌 
    var DLListid = peoa_GetBDFID(13);//预算资产大类 
    var cons = ' AND CT1_FatherID in ('
             + '\'' + Comid + '\',' + '\'' + Brandid + '\','
             + '\'' + DLListid + '\''
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
        m_FilterSP = ' AND bg4_rguser = \'' + m_UserInfo.UserName + '\' AND 1<> 1';
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
            //actLoadDateSP(); 
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
            //actLoadDateSP(); 
        },
        onShowPanel: function () { 
        }
    });
      
    //公司选项获取  
    $('#cxCom').combobox({
        panelWidth: "130",
        panelHeight: "120",
        editable: false,
        multiple: false,
        valueField: 'ct1_codename',
        textField: 'ct1_codename',
        data: m_Coms,
        onChange: function (newValue, oldValue) {
        }
    }); 

    //资产大类选项获取  
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
            var XLListid = row.ct1_id; //预算资产小类
            var cons = ' AND CT1_FatherID = \'' + XLListid + '\''
                        + ' AND CT1_State=\'启用\'';
            m_XLList = basedata_getBDCommon('gbd12', cons);
        }
    });

    //资产小类选项获取  
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

    //状态
    $('#cxState').combobox({
        panelWidth: "95",
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
     
     
    //初始化列表
    clearText(1);
    actyslbcsh(m_DatagridID); 
    searchByCons(); 
    
    
});

 
/***********************************************************************
 *  清除条件
 *  DLY 
 */
function clearText(type) {
    if (type == 1) {
        $('#cxYear').combobox('setValue', basedata_getBMYear());
        $('#cxBrand').combobox('setValue', ''); 
        $('#cxDept').attr('value', '');   
        $('#cxDLCode').combogrid('setValue', '');
        $('#cxXLCode').combobox('setValue', ''); 
        $('#cxCostCenter').attr('value', '');
        $('#cxCom').combobox('setValue', '');
        $('#cxState').combobox('setValue', '');
    }
} 


/***********************************************************************
 *  固定资产预算列表初始化
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
			{ field: 'bg1_id', title: 'FID', width: 100, hidden: true },
            { field: 'bg1_cono', title: 'cono', width: 100, hidden: true },
            { field: 'bg1_divi', title: 'divi', width: 40, hidden: true },
            { field: 'bg1_years', title: '年份', width: 50 },
            { field: 'bg1_brand', title: '品牌', width: 50 },
            { field: 'bg1_com', title: '公司', width: 80 },
            { field: 'bg1_deptid', title: '部门编码', width: 100, hidden: true },
            { field: 'bg1_deptname', title: '部门名称', width: 100},
            { field: 'bg1_centercode', title: '成本中心', width: 80 },
			{ field: 'bg1_largeclassname', title: '资产大类', width: 100 },
			{ field: 'bg1_largeclasscode', title: '大类编码', width: 100, hidden: true },
			{ field: 'bg1_smallclassname', title: '资产小类', width: 100 },
			{ field: 'bg1_smallclasscode', title: '小类编码', width: 100, hidden: true },
            { field: 'bg1_assetsname', title: '资产名称', width: 100 },
			{ field: 'bg1_number', title: '数量', width: 60, align: "right" },
			{
			    field: 'bg1_price', title: '资产单价', width: 80, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
			},
            {
                field: 'bg1_sureamount', title: '总金额', width: 100, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum1(val); }
            },
		    { field: 'bg1_planuse', title: '行动计划', width: 80 },
		    { field: 'bg1_state', title: '状态', width: 50 },
            { field: 'bg1_remark', title: '备注', width: 150 },
			{ field: 'bg1_rgdt', title: '创建时间', width: 105 },
			{ field: 'bg1_rguser', title: '创建人', width: 70 },
		    { field: 'bg1_lmdt', title: '修改时间', width: 105 },
            { field: 'bg1_lmuser', title: '修改人', width: 70 },
            { field: 'bg1_uptno', title: '修改次数', width: 70 }
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
                dataExpotToFile('7', rows, [], []);
            }
        }, '-', {
            text: '导出全部',
            iconCls: 'icon-menu',
            handler: function () {
                var cXML = '<Page>' + 1 + '</Page><Num>' + 50000 + '</Num>'
                         + '<Cons>' + m_Filter + m_Filter1 + '</Cons><OrderBy>' + m_OrderBy + '</OrderBy>';
                cXML = basedata_addROOT(cXML);
                var curl = GetWSRRURL(peoa_GetWSRRURL(5)) + "&type=GetHs&XML=" + encodeURIComponent(cXML)
                         + "&s=" + new Date().getTime(); //拼接url 
                $.ajax({
                    url: curl,
                    type: "GET",
                    async: false,
                    //contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) { 
                        if (data && data.rows && data.rows.length > 0) {
                            if (dataUtil_undefinedOrNull(data.rows[0].bg1_id, '') != '') {
                                dataExpotToFile('7', data.rows, [], []);
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
    //拼接条件 获取数据集
    var syear = $("#cxYear").combobox('getValue');
    var sbrand = $("#cxBrand").combobox('getValue');
    var sdeptname = $('#cxDept').attr('value');
    var sdlcode = $('#cxDLCode').combogrid('getValue');
    var sxlcode = $("#cxXLCode").combobox('getValue'); 
    var scostcenter = $('#cxCostCenter').attr('value');
    var scom = $('#cxCom').combobox('getValue');
    var sstate = $("#cxState").combobox('getValue');
    var cfilter = '  AND isnull(bg1_state,\'0\') = \'启用\' '; 
    cfilter = cfilter + ' AND  bg1_years = \'' + syear + '\''; 
    if (sbrand != '' && sbrand != '全部') {
        cfilter = cfilter + ' AND  bg1_brand = \'' + sbrand + '\'';
    } 
    if (sdeptname != '') {
        cfilter = cfilter + ' AND  bg1_deptname like \'%' + sdeptname + '%\'';
    }
    if (sdlcode != '') {
        cfilter = cfilter + ' AND  BG1_LargeClassCode = \'' + sdlcode + '\'';
    }
    if (sxlcode != '') {
        cfilter = cfilter + ' AND  BG1_SmallClassCode = \'' + sxlcode + '\'';
    } 
    if (scostcenter != '') {
        cfilter = cfilter + ' AND  BG1_CenterCode like \'%' + scostcenter + '%\'';
    }
    if (scom != '') {
        cfilter = cfilter + ' AND  BG1_Com like \'%' + scom + '%\'';
    }
    if (sstate != '' && sstate != '全部') {
        cfilter = cfilter + ' AND  bg1_deptid in (\'000\'';
        var consp = ' AND bg4_type = \'3\' '
                  + ' AND  bg4_year = \'' + syear + '\''
                  + ' AND isnull(bg4_state,0) = \'' + sstate + '\' '; 
        var cXML_sp = '<Page>1</Page><Num>1000</Num>'
             + '<Cons>' + consp +'</Cons><OrderBy>' + '' + '</OrderBy>';
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
                    for (var i = 0; i < data.rows.length; i++) {
                        if (dataUtil_undefinedOrNull(data.rows[i].bg4_deptid, '') != '') { 
                            cfilter = cfilter + ', \'' + data.rows[i].bg4_deptid + '\'';
                        }
                    }
                    
                }
            }
        }) 
        cfilter = cfilter + ')';
    }
    //alert(cfilter);
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
    var curl = GetWSRRURL(peoa_GetWSRRURL(5)) + "&type=GetHs&XML=" + encodeURIComponent(cXML)
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
                if (dataUtil_undefinedOrNull(data.rows[0].bg1_id, '') != '') {
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
        sum = sum * 1 + rows[i].bg1_sureamount * 1;
    }
    $("#spanTatolpage").html(dataUtil_formatNum1(dataUtil_toFixed(sum, 0), '0'));

    // 合计总金额
    var cXML = '<Page>1</Page><Num>1</Num>'
             + '<Cons>' + m_Filter + m_Filter2 + '</Cons><OrderBy>' + m_OrderBy + '</OrderBy>';
    cXML = basedata_addROOT(cXML);
    var curl = GetWSRRURL(peoa_GetWSRRURL(5)) + "&type=GetSums&XML=" + encodeURIComponent(cXML)
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
  
 
/*******************
 * 获取列表高度
 */
function getcurheight() {
    return;
    var htjcxk = document.getElementById("tjcxk").style.height.replace('px', '');
    var curheight = parent.getTabsHeight() * 1 - htjcxk * 1 + 80;
    return curheight;
}



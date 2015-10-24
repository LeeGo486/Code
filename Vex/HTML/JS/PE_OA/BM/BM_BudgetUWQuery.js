var m_DatagridID = '#Budgetlb'; //预算列表ID
var m_LastIndex = undefined;  //预算列表最后一次选中行下标  
var m_PageNumber = 1;  //当前页码
var m_PageSize = 20;  //每页显示行数

//用户信息
var m_UserInfo = basedata_getUserInfo();


//基础数据
var m_Coms = [];  //公司
var m_Brands = []; //品牌 

  

//预算科目类别数组
var m_DLList = [];
var m_XLList = [];  //随大类的小类 


//状态
var m_States = [ { id: "0", text: "未提交" }, { id: "1", text: "已提交" }, { id: "2", text: "已审核" }]; 
//年份
var m_Years = [{ "text": "2014" }, { "text": "2015" }]; 

// 过滤条件
var m_Filter = '';  //主的条件
var m_Filter1 = ''; //查询条件
var m_Filter2 = ''; //查询条件到大类
var m_OrderBy = ' BG3_Com, BG3_Brand, BG3_Branch, BG3_CenterCode, BG3_DeptName, BG3_DLCode, BG3_XLCode'; //排序方式


//主条件切换时，是否放弃数据保存标志， 品牌，大小类，年份切换时用
var m_changeFlag = 0; 
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
        if (authorization_text == '统一费用预算专员') {
            m_Role = 'A'
        } else if (authorization_text == '预算经理') {
            m_Role = 'B';
            break;
        }
    }


    //基础数据获取  
    var Comid = peoa_GetBDFID(14);//公司
    var Brandid = peoa_GetBDFID(15);//品牌 
    var DLListid = peoa_GetBDFID(21);//预算科目大类
    var cons = ' AND ( CT1_FatherID in ('
             + '\'' + Comid + '\',' + '\'' + Brandid + '\','
             + '\'' + DLListid + '\''
             + ') OR ( CT1_ID = \''+DLListid+'\')) AND CT1_State=\'启用\'';
    var res = basedata_getBDCommon('gbd12', cons);  
    for (var i = 0; i < res.length; i++) {
        var f1 = res[i].ct1_fatherid.toUpperCase();
        var f2 = res[i].ct1_id.toUpperCase();
        if (f1 == Comid.toUpperCase()) {
            m_Coms.push(res[i]);
        } else if (f1 == Brandid.toUpperCase()) {
            if ((res[i].ct1_fieldvalues3).indexOf('|' + m_UserInfo.UserName + '|') >= 0
                || res[i].ct1_fieldvalues2 == m_UserInfo.UserName) {
                m_Brands.push(res[i]);
            }
        } else if (f1 == DLListid.toUpperCase()) {
            m_XLList.push(res[i]);
        } else if (f2 == DLListid.toUpperCase()) {
            m_DLList.push(res[i]); 
        }
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
            changeYear();
            searchByCons();
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
            changeYear();
            searchByCons();
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
     
   
    //初始化赋值
    $('#cxYear').combobox('setValue', basedata_getBMYear());
    if (m_Brands.length > 0) {
        $('#cxBrand').combobox('setValue', m_Brands[0].ct1_code);
    } else { 
        $('#cxBrand').combobox('setValue', '');
    }
    changeYear();
    clearText();

    //初始化列表
    actyslbcsh(m_DatagridID);
    searchByCons();
});

 
/***********************************************************************
 *  清除条件
 *  DLY 
 */
function clearText() {
    $('#cxCom').combobox('setValue', '');
    $('#cxDLCode').combogrid('setValue', m_DLList[0].ct1_code);
    $('#cxXLCode').combobox('setValue', ''); 
    $('#cxCostCenter').attr('value', '');
    $('#cxDept').attr('value', '');
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
    var syear = $('#cxYear').combobox('getValue');
    var sbrand = $('#cxBrand').combobox('getValue');
    var scom = $('#cxCom').combobox('getValue');
    var sdlcode = $('#cxDLCode').combogrid('getValue');
    var sxlcode = $("#cxXLCode").combobox('getValue');
    var sdept = $('#cxDept').attr('value');
    var scostcenter = $('#cxCostCenter').attr('value');
    var cfilter = ' AND bg3_type = \'2\' AND bg3_state = \'0\'';
    cfilter = cfilter + ' AND  bg3_year = \'' + syear + '\''; 
    cfilter = cfilter + ' AND  bg3_brand = \'' + sbrand + '\''; 
    if (scom != '') {
        cfilter = cfilter + ' AND  bg3_com = \'' + scom + '\'';
    }
    if (sdlcode != '') {
        cfilter = cfilter + ' AND  bg3_dlcode = \'' + sdlcode + '\'';
    }
    if (sxlcode != '') {
        cfilter = cfilter + ' AND  bg3_xlcode = \'' + sxlcode + '\'';
    }
    if (sdept != '') {
        cfilter = cfilter + ' AND  bg3_deptname like \'%' + sdept + '%\'';
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
    $("#spanTatolpage").html(dataUtil_formatNum1(dataUtil_toFixed(sum, 0),'0'));
     
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
 *  统一费用预算列表初始化
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
                    return basedata_getCodename(m_XLList, row.bg3_xlcode, 'ct1_code', 'ct1_codename');
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
                dataExpotToFile('6', rows, m_DLList, m_XLList);
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
                                dataExpotToFile('6', data.rows, m_DLList, m_XLList);
                            }
                        }
                    }
                })
                
            }
        }]

    });
}
 

/***********************************************************************
 *  年份改变事件 
 *  DLY 
 */
function changeYear() { 
    $("#spanbg4_id").html('');
    $("#spanTatol1").html('');
    $("#spanSubject").html('');
    $("#spanState").html('');
    $("#spanUp1").html('');
    $("#spanUp2").html('');
    var cons = ' AND BG4_Type = \'2\' AND BG4_Year = \'' + $('#cxYear').combobox('getValue') + '\' ';
    cons = cons + ' AND BG4_Brand = \'' + $('#cxBrand').combobox('getValue') + '\' '; 
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
            if (data && data.rows && data.rows.length > 0) {
                if (dataUtil_undefinedOrNull(data.rows[0].bg4_id, '') != '') {
                    $("#spanbg4_id").html(data.rows[0].bg4_id);
                    $("#spanTatol1").html(dataUtil_formatNum1(data.rows[0].bg4_total, 0));
                    $("#spanSubject").html(data.rows[0].bg4_subject);
                    $("#spanBrand").html(data.rows[0].bg4_brand);
                    $("#spanState").html(data.rows[0].bg4_state);
                    $("#spanUp1").html(data.rows[0].bg4_upper1 + '&nbsp;&nbsp;&nbsp;&nbsp;' + data.rows[0].bg4_updt1);
                    $("#spanUp2").html(data.rows[0].bg4_upper2 + '&nbsp;&nbsp;&nbsp;&nbsp;' + data.rows[0].bg4_updt2);

                }
            }
        }
    })
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



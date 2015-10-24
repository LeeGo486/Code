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
var m_OrderBy = ''; //排序方式


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
        } else if (authorization_text == '固定资产预算专员') {
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
        }
    }
    m_Brands.push({ ct1_code: '全部', ct1_codename: '全部' }); 

  
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
            { field: 'bg4_subject', title: '主题', width: 260 },
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
            curl = '../../../WEB/PE_OA/BM/BM_BudgetDeptFA.html?v0=sp&v1=' + rowData.bg4_id;
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
 *  加载审批记录
 *  DLY 
 */
function actLoadDateSP() {  
    $("#btnUp").hide();
    $("#btnDn").hide();
    $(m_DatagridID1).datagrid('loadData', []);
    var cons = ' AND BG4_Type = \'3\' ';
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



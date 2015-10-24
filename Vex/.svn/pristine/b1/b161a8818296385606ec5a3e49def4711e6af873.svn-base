var m_DatagridID = '#Budgetlb'; //预算列表ID
var m_LastIndex = undefined;  //预算列表最后一次选中行下标  
var m_PageNumber = 1;  //当前页码
var m_PageSize = 2000;  //每页显示行数

//用户信息
var m_UserInfo = basedata_getUserInfo();


//基础数据
var m_Coms = [];  //公司
var m_Brands = []; //品牌
var m_Branchs = []; //大区

  

//状态
var m_States = [{ id: "0", text: "启用" }, { id: "1", text: "禁用" }];

//CONO
var m_CONOs = [{ "text": "EP" }, { "text": "DL" }];

//年份
var m_Years = [{ "text": "2014" }, { "text": "2015" }, { "text": "2016" }];
var m_ShopTypes = [{ "text": "自营" }, { "text": "加盟" }, { "text": "全部" }];
var m_ShopTypes1 = [{ "text": "自营" }, { "text": "加盟" } ];
var m_TabTypes = [{ "id": "xssl", "text": "销售数量" }, { "id": "dpje", "text": "吊牌金额" }
                    , { "id": "sxsr", "text": "实销收入" }, { "id": "jssr", "text": "结算收入" }
                    , { "id": "jxse", "text": "净销售额" }, { "id": "sjcb", "text": "实际成本" }
                    , { "id": "xncb", "text": "虚拟成本" }];

// 过滤条件
var m_Filter = '';  //主的条件
var m_Filter1 = ''; //查询条件
var m_Filter2 = ''; //查询条件到大类
var m_OrderBy = ' BG5_Year, BG5_Brand, BG5_Com, BG5_Branch '; //排序方式


//主条件切换时，是否放弃数据保存标志， 品牌，大小类，年份切换时用
var m_changeFlag = 0; 
var m_addFlag = 0; //从未打开过编辑窗标志
var m_XXStr = ''; //选项id
var m_Role = 'A'; //操作员身份

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

    /*
    //确认操作员
    for (var i = 0; i < m_UserInfo.roles.length; i++) {
        var authorization_text = m_UserInfo.roles[i].authorization_name;
        var authorization_id = m_UserInfo.roles[i].authorization_id;
        if (authorization_text == '店铺预算专员') {
            m_Role = 'A'
        } else if (authorization_text == '预算经理') {
            m_Role = 'B';
            break;
        }
    }
    */

    //基础数据获取  
    var Comid = peoa_GetBDFID(14);//公司
    var Brandid = peoa_GetBDFID(15);//品牌
    var Branchid = peoa_GetBDFID(16);//大区 
    var cons = ' AND CT1_FatherID in ('
             + '\'' + Comid + '\',' + '\'' + Brandid + '\','
             + '\'' + Branchid  + '\''
             + ') AND CT1_State=\'启用\'';
    var res = basedata_getBDCommon('gbd12', cons);
    for (var i = 0; i < res.length; i++) {
        var f1 = res[i].ct1_fatherid.toUpperCase();
        if (f1 == Comid.toUpperCase()) {
            m_Coms.push(res[i]);
        } else if (f1 == Brandid.toUpperCase()) {
            if ((res[i].ct1_fieldvalues4).indexOf('|' + m_UserInfo.UserName + '|') >= 0 ) {
                m_Brands.push(res[i]);
            } 
        } else if (f1 == Branchid.toUpperCase()) {
            m_Branchs.push(res[i]);
        } 
    }

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
            searchByCons();
        },
        onShowPanel: function () {
            actContralSave('combo', '#cxBrand');
        }
    }); 
   
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
            //重新加载数据
            searchByCons();
        },
        onShowPanel: function (rowIndex) {
            actContralSave('combo', '#cxYear');
        }
    });
     
     
    //大区选项获取  
    $('#cxBranch').combobox({
        panelWidth: "120",
        panelHeight: "120",
        editable: true,
        multiple: true,
        valueField: 'oz1_orgname',
        textField: 'oz1_orgname',
        data: [],
        onShowPanel: function (rowIndex) {
            $('#cxBranch').combobox('loadData', []);
            var sbrand = $('#cxBrand').combobox('getValue');
            if(sbrand==''){
                alert('请先选择品牌'); 
            }else{ 
                var rs = basedata_getBranchByBrand(sbrand); 
                $('#cxBranch').combobox('loadData', rs);
            } 
        }
        
    });

    //店铺类型选项获取  
    $('#cxShopType').combobox({
        panelWidth: "90",
        panelHeight: "90",
        editable: false,
        multiple: false,
        valueField: 'text',
        textField: 'text',
        data: m_ShopTypes
    });

    //初始化赋值
    $('#cxBrand').combobox('setValue', '');
    $('#cxYear').combobox('setValue', basedata_getBMYear());
    setXLTypes(); //设置选项 

    //初始化列表
    actyslbcsh(m_DatagridID);

    /*
    //鼠标单击后事件设置选中行合计值
    document.onmouseup = function (e) {
        getRowTotal(m_LastIndex, 'dg');
        return true;
    }
    */
});
 

/***********************************************************************
 *  店铺销售预算列表初始化
 *  DLY 
 */
function actyslbcsh(dgid) {
    $(dgid).datagrid({
        //title:'预算列表', 
        //width: document.body.clientWidth,
        //height: getcurheight(), 
        height: 520,
        nowrap: true,
        striped: false,
        collapsible: true,
        //sortName: 'id',
        //sortOrder: 'asc',
        remoteSort: false,
        idField: 'bg5_id',
        frozenColumns: [[ 
        ]],
        columns: [[
            { field: 'bg5_id', title: 'FID', width: 100, hidden: true } 
        ]],
        pagination: false,
        rownumbers: true,
        singleSelect: true,
        onDblClickRow: function (rowIndex) { 
            $(dgid).datagrid('selectRow', rowIndex);
            open_rowdlg('修改记录');
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
}
 

/***********************************************************************
 *  列设置
 *  DLY 
 */function setyslbcolumns(xxtype) {
    if (xxtype == '') {
        return [];
    }
    var clos =  [[
        { field: 'bg5_id', title: 'FID', width: 100, hidden: true },
        { field: 'bg5_cono', title: 'cono', width: 40, hidden: true },
        { field: 'bg5_divi', title: 'divi', width: 40, hidden: true },
        { field: 'bg5_brand', title: '品牌', width: 50 },
        { field: 'bg5_year', title: '年份', width: 50},
        { field: 'bg5_com', title: '公司', width: 70 },
        { field: 'bg5_branch', title: '大区', width: 70 },
        { field: 'bg5_shoptype', title: '店铺类型', width: 70 },
        { field: 'bg5_centercode', title: '成本中心', width: 70 },
        { field: 'bg5_deptid', title: '店铺编码', width: 100, hidden: true },
        { field: 'bg5_deptname', title: '店铺名称', width: 160 },
        {
            field: 'bg5_' + m_XXStr + 'm1', title: '1月', width: 80, align: "right"
			, formatter: function (val) { return dataUtil_formatNum1(val); }
        },
        {
            field: 'bg5_' + m_XXStr + 'm2', title: '2月', width: 80, align: "right"
			, formatter: function (val) { return dataUtil_formatNum1(val); }
        },
        {
            field: 'bg5_' + m_XXStr + 'm3', title: '3月', width: 80, align: "right"
			, formatter: function (val) { return dataUtil_formatNum1(val); }
        },
        {
            field: 'bg5_' + m_XXStr + 'm4', title: '4月', width: 80, align: "right"
			, formatter: function (val) { return dataUtil_formatNum1(val); }
        },
        {
            field: 'bg5_' + m_XXStr + 'm5', title: '5月', width: 80, align: "right"
			, formatter: function (val) { return dataUtil_formatNum1(val); }
        },
        {
            field: 'bg5_' + m_XXStr + 'm6', title: '6月', width: 80, align: "right"
			, formatter: function (val) { return dataUtil_formatNum1(val); }
        },
        {
            field: 'bg5_' + m_XXStr + 'm7', title: '7月', width: 80, align: "right"
			, formatter: function (val) { return dataUtil_formatNum1(val); }
        },
        {
            field: 'bg5_' + m_XXStr + 'm8', title: '8月', width: 80, align: "right"
			, formatter: function (val) { return dataUtil_formatNum1(val); }
        },
        {
            field: 'bg5_' + m_XXStr + 'm9', title: '9月', width: 80, align: "right"
			, formatter: function (val) { return dataUtil_formatNum1(val); }
        },
        {
            field: 'bg5_' + m_XXStr + 'm10', title: '10月', width: 80, align: "right"
			, formatter: function (val) { return dataUtil_formatNum1(val); }
        },
        {
            field: 'bg5_' + m_XXStr + 'm11', title: '11月', width: 80, align: "right"
			, formatter: function (val) { return dataUtil_formatNum1(val); }
        },
        {
            field: 'bg5_' + m_XXStr + 'm12', title: '12月', width: 80, align: "right"
			, formatter: function (val) { return dataUtil_formatNum1(val); }
        },
		{
		    field: 'bg5_state', title: '状态', width: 60
            , formatter: function (val) { return basedata_getCodename(m_States, val, 'id', 'text'); }
		},
		{ field: 'bg5_rgdt', title: '创建时间', width: 105, sortable: true },
		{ field: 'bg5_rguser', title: '创建人', width: 70 },
		{ field: 'bg5_lmdt', title: '修改时间', width: 105, sortable: true },
        { field: 'bg5_lmuser', title: '修改人', width: 70 },
        { field: 'bg5_uptno', title: '修改次数', width: 70 }
    ]]
    return clos;
}
 

/***********************************************************************
 *  查询事件：根据条件查询
 *  DLY 
 */
 function searchByCons() {
    m_Filter1 = ' AND 1<> 1';
    m_Filter2 = ' AND 1<> 1';
    $("#spanTatolpage").html('0');
    $("#spanTatol").html('0');
    $(m_DatagridID).datagrid('loadData', []);
    m_PageNumber = 1;

    //拼接条件 获取数据集
    var sbrand = $('#cxBrand').combobox('getValue');
    var syear = $('#cxYear').combobox('getValue');
    var sbranch = $('#cxBranch').combobox('getValue');
    var sshoptype = $('#cxShopType').combobox('getValue');
    var sbranchs = $('#cxBranch').combobox('getValues');
    if (sbrand == '' || syear == '' || m_XXStr == '') { 
        $(m_DatagridID).datagrid('loadData', []);
        return true;
    }
    var cfilter = ' ';
    cfilter = cfilter + ' AND  bg5_brand = \'' + sbrand + '\'';
    cfilter = cfilter + ' AND  bg5_year = \'' + syear + '\''; 
    m_Filter2 = cfilter;

    if (sbranchs != '') {
        sbranchs = sbranchs.join('\',\'');
        sbranchs = '\'' + sbranchs + '\'';
        cfilter = cfilter + ' AND  bg5_branch in (' + sbranchs + ')';
    }
    if (sshoptype != '' && sshoptype != '全部') {
        cfilter = cfilter + ' AND  bg5_shoptype = \'' + sshoptype + '\'';
    }
    m_Filter1 = cfilter;
    //alert(m_Filter1);
    actLoadData(m_PageNumber, m_PageSize); 

 }


 /***********************************************************************
  *  高级查询事件：根据条件查询
  *  DLY 
  */
 function searchByCons1(type) {
     if (type == 'open') {
         if ($('#cxBrand').combobox('getValue') == '') {
             alert('请先选择品牌！');
             return false;
         }
         if ($('#cxYear').combobox('getValue') == '') {
             alert('请先选择年份！');
             return false;
         }
         if (m_XXStr == '') {
             alert('请先选择一个选项！');
             return false;
         }
         $('#searchdlg').dialog('open');
     } else if (type == 'close') {
         //拼接条件 获取数据集
         var scbzx = $('#cxcbzx').val();
         var sdpmc = $('#cxdpmc').val();
         if (scbzx == '' && sdpmc == '') {
             alert('请至少填写一个查询条件！');
             return false;
         }

         $('#searchdlg').dialog('close');
         m_PageNumber = 1;
         $("#spanTatolpage").html('0');
         $("#spanTatol").html('0');
         var cfilter = ' ';
         if (scbzx != '') {
             cfilter = cfilter + ' AND  bg5_centercode like \'%' + scbzx + '%\'';
         }
         if (sdpmc != '') {
             cfilter = cfilter + ' AND  bg5_deptname like \'%' + sdpmc + '%\'';
         } 
         m_Filter1 = m_Filter2 + cfilter; 
         //alert(m_Filter1);
         actLoadData(m_PageNumber, m_PageSize); 
         var scbzx = $('#cxcbzx').val('');
         var sdpmc = $('#cxdpmc').val('');
     } 
 }


/***********************************************************************
 *  刷新列表数据
 *  DLY 
 */
function actLoadData(page, number) {
    var totalCount = 0;
    m_PageNumber = page;
    m_PageSize = number;
    var cXML = '<Page>' + page + '</Page><Num>' + number + '</Num>'
             + '<Cons>' + m_Filter + m_Filter1 + '</Cons><OrderBy>' + m_OrderBy + '</OrderBy>'
             + '<XXStr>' + m_XXStr + '</XXStr>';
    cXML = basedata_addROOT(cXML);
    var curl = GetWSRRURL(peoa_GetWSRRURL(14)) + "&type=GetShopSBHs1&XML=" + encodeURIComponent(cXML); //拼接url
    //alert(cXML);	
    $.ajax({
        url: curl,
        type: "GET",
        async: false, 
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows && data.rows.length > 0) {
                if (dataUtil_undefinedOrNull(data.rows[0].bg5_id, '') != '') {
                    $(m_DatagridID).datagrid({
                        columns: setyslbcolumns(m_XXStr)
                    });
                    $(m_DatagridID).datagrid('loadData', data.rows);
                }
            }
        }
    })
}


//添加右击菜单内容
function onRowContextMenu(e, rowIndex, rowData) {
    e.preventDefault();
    //var selected = $("#test").datagrid('getRows'); //获取所有行集合对象
    //selected[rowIndex].id; //index为当前右键行的索引，指向当前行对象
    //$('#mm').menu('show', {
    //    left: e.pageX,
    //    top: e.pageY
    //});
}
 

/***********************************************************************
 *  设置选中行合计值 或 设置行编辑窗合计
 *  DLY 
 */
function getRowTotal(rowIndex, type) {
    var sum = 0;
    if (type == 'dg') {
        if (rowIndex != undefined && rowIndex >= 0) {
            var edt = $(m_DatagridID).datagrid('getEditor', { index: rowIndex, field: 'bg5_total' });
            if (edt == undefined) {
                return false;
            }
            for (var i = 1; i < 13; i++) {
                var ed = $(m_DatagridID).datagrid('getEditor', { index: rowIndex, field: 'bg5_m' + i });
                if (ed != undefined && !isNaN(ed.target.val())) {
                    sum = sum * 1 + dataUtil_toFixed(ed.target.val(), 2) * 1;
                }
            }
            var sum1 = edt.target.val() * 1;
            if (dataUtil_toFixed(sum1, 2) != dataUtil_toFixed(sum, 2)) {
                edt.target.numberbox('setValue', dataUtil_toFixed(sum, 2) * 1);
            }

        }
    } 
    return sum;
}


/***********************************************************************
 *  excel复制添加事件
 *  DLY 
 */
function actCopeToAdd(text) { 
    var flag = 0;   
    if ($('#cxBrand').combobox('getValue') == '') {
        alert('请先选择品牌！');
        return false;
    } 
    if ($('#cxYear').combobox('getValue') == '') {
        alert('请先选择年份！');
        return false;
    }
    if (m_XXStr == '') {
        alert('请先选择一个选项！');
        return false;
    } 
    var rows = $(m_DatagridID).datagrid('getRows');
    if (text == undefined) {
        if (navigator.appName.toLowerCase() == 'microsoft internet explorer') {
            text = window.clipboardData.getData("text");
        } else {
            $('#textexcelcope').val('');
            $('#excelcopedlg').dialog('open');
            return false;
        }
    }
    if (dataUtil_undefinedOrNull(text, '') != '') {
        $('#waitdlg').dialog('open');
        flag = 1;
        setTimeout(function () {
            var reg = new RegExp("本行止\n", "g");
            text = text.replace(reg, '本行止\r\n');
            var reg2 = new RegExp("\"", "g");
            text = text.replace(reg2, '');
            var strlist1 = text.split('\r\n');
            var copyrows = [];
            var updated = $(m_DatagridID).datagrid('getChanges', "updated");
            for (var i = 0; i < strlist1.length; i++) {
                var strlist2 = strlist1[i].split('\t'); 
                if (strlist2.length >= 20) {
                    for (var j = 0; j < rows.length; j++) {
                        if (rows[j].bg5_centercode == strlist2[5]) {
                            for (var x = 1; x < 13; x++) {
                                var sm = x * 1 + 6; 
                                rows[j]["bg5_"+m_XXStr+"m"+x] = strlist2[sm];
                            } 
                            updated.push(rows[j]);
                            copyrows.push(rows[j]);
                            break;
                        }
                    }
                }
                if (i == strlist1.length - 1) {
                    $(m_DatagridID).datagrid('loadData', rows);
                    var updated1 = $(m_DatagridID).datagrid('getChanges', "updated");
                    for (var k = 0; k < updated.length; k++) {
                        updated1.push(updated[k]);
                    }
                }
            }
        }, 100);
    }
    if (flag == 1) {
        setTimeout(function () {
            $('#waitdlg').dialog('close');
        }, 1000);
    }
}
 

/***********************************************************************
 *  添加事件
 *  DLY 
 */
function actAdd() {
    if ($('#cxBrand').combobox('getValue') == '') {
        alert('请先选择品牌！');
        return false;
    } 
    if ($('#cxYear').combobox('getValue') == '') {
        alert('请先选择年份！');
        return false;
    }
    if (m_XXStr == '') {
        alert('请先选择一个选项！');
        return false;
    } 
    open_rowdlg('新建记录'); 
}
 

/***********************************************************************
 *  保存事件
 *  DLY 
 */
function actSave() {
    var flag = false;  

    var dataRows = $(m_DatagridID).datagrid('getRows');
    var cXML1 = '';
    //以下拼接修改记录信息json
    if ($(m_DatagridID).datagrid('getChanges').length > 0) {
        //if (!shopaveCheck()) {
        //    return flag;
        //}
        var gridDataChanges = [];
        var inserted = $(m_DatagridID).datagrid('getChanges', "inserted");
        var updated = $(m_DatagridID).datagrid('getChanges', "updated"); 
        for (var i = 0; i < inserted.length; i++) { 
            for (var j = 1; j < 13; j++) {
                inserted[i]["bg5_" + m_XXStr + "m" + j] = inserted[i]["bg5_" + m_XXStr + "m" + j] * 1;
            }
            inserted[i].bg5_rgdt = dateUtil_dateFomaterA(new Date(), '/')
            inserted[i].bg5_rguser = m_UserInfo.UserName;
        }
        for (var i = 0; i < updated.length; i++) {
            for (var j = 1; j < 13; j++) {
                updated[i]["bg5_" + m_XXStr + "m" + j] = updated[i]["bg5_" + m_XXStr + "m" + j] * 1;
            }
            updated[i].bg5_lmdt = dateUtil_dateFomaterA(new Date(), '/')
            updated[i].bg5_lmuser = m_UserInfo.UserName;
            updated[i].bg5_uptno = updated[i].bg5_uptno * 1 + 1;
        } 
        cXML1 = GetEditJson(inserted, updated, []);//json转xml
    } else {
        alert('没有修改信息！');
        return flag;
    } 
    //alert(cXML1);
    var cxmlsJson = { XML: cXML1 };
    var curl = GetWSRRURL(peoa_GetWSRRURL(14)) + "&type=SaveShopSB"; //拼接url
    $.ajax({
        url: curl,
        type: "POST",
        async: false,
        data: cxmlsJson,
        //contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data)); 
            if (data && data.rows) {
                if (data.rows[0].result.toUpperCase() == 'TRUE') {
                    actLoadData(m_PageNumber, m_PageSize);
                    flag = true;
                }
            }
        }
    })
    if (flag) {
        alert('保存成功！');
    } else {
        alert('保存失败！');
    }
    return flag;
}


/***********************************************************************
 *  保存费用预算信息
 *  DLY 
 */
function shopaveCheck() {
    var flag = false; 
    return flag;
}


/***********************************************************************
 * 结束编辑行
 *  DLY 
 */
function actEndEdit(dgid, index) {
    if (index != undefined && index >= 0) {
        $(dgid).datagrid('endEdit', index);
    }
    return -1;
}


/***********************************************************************
 *  新增行对象
 *  DLY 
 */
function newRow() {
    var rownew = {};
    rownew.bg5_id = dataUtil_NewGuid(); 
    rownew.bg5_state = '0';
    rownew.bg5_year = $('#cxYear').combobox('getValue');
    rownew.bg5_brand = $('#cxBrand').combobox('getValue');  
    return rownew;
}
 

/***********************************************************************
 *  设置选项div
 *  DLY 
 */
function setXLTypes() {
    var xllist = m_TabTypes
    if (xllist && xllist.length > 0) {
        var shtml = ''; 
        for (var i = 0; i < xllist.length; i++) {
            if (xllist[i].id != '' && xllist[i].text != '') {
                shtml = shtml + '&nbsp;&nbsp;&nbsp;&nbsp;';
                shtml = shtml + '<input type="button" id="' + xllist[i].id
                    + '" value="' + xllist[i].text
                    + '" class="btn3" onclick="chooseXL(\'' + xllist[i].id + '\')">'
            }
        } 
        $('#cxXLTypes').html(shtml);
    } else {
        $('#cxXLTypes').html('');
    } 
}


/***********************************************************************
 *  选择选项事件
 *  DLY 
 *  spanXLCode : 存放选项id
 */
function chooseXL(xlid) {
    m_LastIndex = actEndEdit(m_DatagridID, m_LastIndex);
    // 切换前提示保存
    if ($(m_DatagridID).datagrid('getChanges').length > 0) {
        $.messager.defaults = { ok: "保存", cancel: "不保存" }; // 修改按钮
        $.messager.confirm('警示', '当前数据已修改，是否先保存数据？'
            , function (r) {
                $.messager.defaults = { ok: "确定", cancel: "取消" }; // 还原按钮;
                if (r) {  //保存，不切换
                    actSave();
                    flag = false;
                } else {  //不保存，切换
                    if (xlid != undefined && xlid != '') {
                        if (m_XXStr != '') {
                            $('#' + m_XXStr).removeClass("btn3_choose");
                        } 
                        $('#' + xlid).addClass("btn3_choose");
                        //存放小类id 
                        m_XXStr = xlid;
                    }
                    //重新加载数据
                    searchByCons();
                }
            });
    } else {  //切换   $.messager 变态，跟其他代码会同步执行，不能控制先后
        if (xlid != undefined && xlid != '') {
            if (m_XXStr != '') {
                $('#' + m_XXStr).removeClass("btn3_choose");
            } 
            $('#' + xlid).addClass("btn3_choose");

            //存放小类id
            m_XXStr = xlid;
        }
        //重新加载数据
        searchByCons();
    }
}


/***********************************************************************
 *  调整主条件，防止数据丢失控制
 *  DLY 
 *  m_changeFlag : 0 不可调整， 1 可调整
 */
function actContralSave(type, field1) {
    m_LastIndex = actEndEdit(m_DatagridID, m_LastIndex);
    if (type == undefined) {
        m_changeFlag = 0;
    } else if (type == 'combo') {
        if (field1 == '#cxBrand' || field1 == '#cxYear') {
            if (m_changeFlag != 1 && $(m_DatagridID).datagrid('getChanges').length > 0) {
                $.messager.defaults = { ok: "保存", cancel: "不保存" }; // 修改按钮
                $.messager.confirm('警示', '当前数据已修改，是否先保存数据？'
                    , function (r) {
                        $.messager.defaults = { ok: "确定", cancel: "取消" }; // 还原按钮;
                        if (r) {
                            if (field1 == '#cxDLCode') {
                                $(field1).combogrid('hidePanel');
                            } else {
                                $(field1).combobox('hidePanel');
                            }
                            actSave();
                        } else {
                            m_changeFlag = 1; //设置可下拉标志
                            if (field1 == '#cxDLCode') {
                                $(field1).combogrid('showPanel');
                            } else {
                                $(field1).combobox('showPanel');
                            }
                            return;
                        }
                    });
            }
            m_changeFlag = 0;
        }
    }
}


/*******************
 * 打开记录编辑窗
 *  DLY 
 */
function open_rowdlg(type) {
    $("#rowdlg_btnok").html(type); 
    if (m_addFlag == 0) {
        //公司选项获取  
        $('#rbg3_com').combobox({
            panelWidth: "110",
            panelHeight: "120",
            editable: false,
            multiple: false,
            valueField: 'ct1_codename',
            textField: 'ct1_codename',
            data: m_Coms
        });
        //大区选项获取  
        $('#rbg3_branch').combobox({
            panelWidth: "110",
            panelHeight: "120",
            editable: false,
            multiple: false,
            valueField: 'oz1_orgname',
            textField: 'oz1_orgname',
            data: [],
            onShowPanel: function (rowIndex) {
                $('#cxBranch').combobox('loadData', []);
                var sbrand = $('#cxBrand').combobox('getValue');
                if (sbrand == '') {
                    alert('请先选择品牌');
                } else {
                    var rs = basedata_getBranchByBrand(sbrand);
                    $('#rbg3_branch').combobox('loadData', rs);
                }
            }
        });
        //店铺类型选项获取  
        $('#rbg3_shoptype').combobox({
            panelWidth: "110",
            panelHeight: "80",
            editable: false,
            multiple: false,
            valueField: 'text',
            textField: 'text',
            data: m_ShopTypes1
        });
        m_addFlag = 1;
    } 
    if (type == '新建记录') {
        $("#rbg3_com").combobox('setValue', '');
        $("#rbg3_branch").combobox('setValue', '');
        $("#rbg3_shoptype").combobox('setValue', '');
        $("#rbg3_centercode").attr('value', '');
        $("#rbg3_deptname").attr('value', '');
        for (var i = 1; i < 13; i++) {
            $("#rbg3_m"+i).numberbox('setValue', '');
        } 
    } 
    else if (type == '修改记录') {
        var row = $(m_DatagridID).datagrid('getSelected'); 
        $("#rbg3_com").combobox('setValue', row.bg5_com);
        $("#rbg3_branch").combobox('setValue', row.bg5_branch);
        $("#rbg3_shoptype").combobox('setValue', row.bg5_shoptype);
        $("#rbg3_centercode").attr('value', row.bg5_centercode);
        $("#rbg3_deptname").attr('value', row.bg5_deptname); 
        for (var i = 1; i < 13; i++) {
            $("#rbg3_m" + i).numberbox('setValue', row["bg5_" + m_XXStr + "m" + i]);
        } 
    }
    $("#xxspan").html(basedata_getCodename(m_TabTypes, m_XXStr, 'id', 'text')); 
    $('#rowdlg').dialog('open');
}


/*******************
 * 关闭记录编辑窗
 *  DLY 
 */
function close_rowdlg() { 
    var currow = {};
    if ($("#rowdlg_btnok").html() == '新建记录') {
        currow = newRow();
    }
    else if ($("#rowdlg_btnok").html() == '修改记录') {
        currow = $(m_DatagridID).datagrid('getSelected');
    }  
    var sbg5_com = $("#rbg3_com").combobox('getValue');
    var sbg5_branch = $("#rbg3_branch").combobox('getValue');
    var sbg5_shoptype = $("#rbg3_shoptype").combobox('getValue');
    var sbg5_centercode = $("#rbg3_centercode").attr('value').toUpperCase();
    var sbg5_deptname = $("#rbg3_deptname").attr('value'); 
    
    if (dataUtil_undefinedOrNull(currow.bg5_id, '') == '') {
        alert("fid 不能为空，未选中记录或系统错误！");
        return false;
    }
    if (dataUtil_undefinedOrNull(sbg5_com, '') == '') {
        alert("公司必填！");
        return false;
    }
    if (dataUtil_undefinedOrNull(sbg5_branch, '') == '') {
        alert("大区必填！");
        return false;
    }
    if (dataUtil_undefinedOrNull(sbg5_shoptype, '') == '') {
        alert("店铺类型必填！");
        return false;
    }
    if (dataUtil_undefinedOrNull(sbg5_deptname, '') == '') {
        alert("店铺名称必填！");
        return false;
    }
    if (dataUtil_undefinedOrNull(sbg5_centercode, '') == '') {
        alert("成本中心必填！");
        return false;
    }
    //成本中心校验
    var cflag = 0;
    var cfilter = ' ';
    cfilter = cfilter + ' AND  bg5_brand = \'' + currow.bg5_brand + '\'';
    cfilter = cfilter + ' AND  bg5_year = \'' + currow.bg5_year + '\'';
    cfilter = cfilter + ' AND  bg5_centercode = \'' + sbg5_centercode + '\'';
    var cXML = '<Page>1</Page><Num>1</Num>'
             + '<Cons>' + cfilter + '</Cons><OrderBy></OrderBy>' 
    cXML = basedata_addROOT(cXML);
    var curl = GetWSRRURL(peoa_GetWSRRURL(14)) + "&type=GetShopSBHs&XML=" + encodeURIComponent(cXML); //拼接url 
    $.ajax({
        url: curl,
        type: "GET",
        async: false, 
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                cflag = 1;
                if (data.rows.length > 0) {
                    if (dataUtil_undefinedOrNull(data.rows[0].bg5_id, '') != '' && data.rows[0].bg5_id != currow.bg5_id) {
                        alert(sbg5_centercode + "成本中心已存在，对应店铺名称“" + data.rows[0].bg5_deptname + "”,请查看！");
                        cflag = 2;
                    }
                }  
            }
        }
    })
    if (cflag == 0) {
        alert("成本中心校验失败！");
        return false;
    }
    if (cflag == 2) { 
        return false;
    }

    currow.bg5_com = sbg5_com;
    currow.bg5_branch = sbg5_branch;
    currow.bg5_shoptype = sbg5_shoptype;
    currow.bg5_centercode = sbg5_centercode;
    currow.bg5_deptname = sbg5_deptname;

    for (var i = 1; i < 13; i++) { 
        currow["bg5_" + m_XXStr + "m" + i] = $("#rbg3_m" + i).numberbox('getValue');
    } 

    if ($("#rowdlg_btnok").html() == '新建记录') {
        $(m_DatagridID).datagrid('appendRow', currow);
        var rindex = $(m_DatagridID).datagrid('getRows').length - 1;
        $(m_DatagridID).datagrid('selectRow', rindex);
    }
    else if ($("#rowdlg_btnok").html() == '修改记录') {
        var rindex = $(m_DatagridID).datagrid('getRowIndex', currow);
        $(m_DatagridID).datagrid('updateRow', { index: rindex, row: currow });  
        var updated1 = $(m_DatagridID).datagrid('getChanges', "updated"); 
        updated1.push(currow); 
    } 
    $('#rowdlg').dialog('close');
}


/*******************
 * 启用/禁用
 *  DLY 
 */
function actState() {
    var currow = $(m_DatagridID).datagrid('getSelected');
    if (!currow) {
        alert('请选择店铺记录，方可进行此操作！');
    }
    if (currow.bg5_state == "0") {
        currow.bg5_state = "1";
    } else {
        currow.bg5_state = "0";
    } 
    var rindex = $(m_DatagridID).datagrid('getRowIndex', currow);
    $(m_DatagridID).datagrid('updateRow', { index: rindex, row: currow });
    var updated1 = $(m_DatagridID).datagrid('getChanges', "updated");
    updated1.push(currow); 
    $(m_DatagridID).datagrid('selectRow', rindex);
}


/***********************************************************************
*  导出Excel
*  DLY 
*/
function actToExcel(type) {
    var rows = []
    if (type == 'page') {
        rows = $(m_DatagridID).datagrid('getRows');
        if (rows.length > 0) { 
            dataExpotToFile('8', rows, [], [], m_XXStr);
        }
    } else if (type == 'all') {
        //拼接条件 获取数据集
        var sbrand = $('#cxBrand').combobox('getValue');
        var syear = $('#cxYear').combobox('getValue'); 
        if (sbrand == '' || syear == '') {
            alert('请选择品牌和年份！');
            return true;
        }
        var cfilter = ' ';
        cfilter = cfilter + ' AND  bg5_brand = \'' + sbrand + '\'';
        cfilter = cfilter + ' AND  bg5_year = \'' + syear + '\''; 
        var cXML = '<Page>1</Page><Num>2000</Num>'
             + '<Cons>' + m_Filter + cfilter + '</Cons><OrderBy>' + m_OrderBy + '</OrderBy>'
             + '<XXStr></XXStr>';
        cXML = basedata_addROOT(cXML);
        var curl = GetWSRRURL(peoa_GetWSRRURL(14)) + "&type=GetShopSBHs&XML=" + encodeURIComponent(cXML); //拼接url
        $.ajax({
            url: curl,
            type: "GET",
            async: false,
            dataType: "json",
            success: function (data) {
                //alert(jsonUtil_jsonToStr(data));
                if (data && data.rows && data.rows.length > 0) {
                    if (dataUtil_undefinedOrNull(data.rows[0].bg5_id, '') != '') {
                        dataExpotToFile('9', data.rows, [], [], '');
                    }
                }
            }
        }) 
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



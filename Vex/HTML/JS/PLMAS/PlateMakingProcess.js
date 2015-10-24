/// JS名：PlateMakingProcess.js
/// 说明：制版流程操作界面的JS控制 
/// 创建人：马卫清 
/// 创建日期：2014-06-16

var m_SearchData = [];
var m_UserID = GetLoginUser();
var m_DDHComboxData = null;
var m_PDReview = null;//图稿评审人信息
var m_Pattern = null;//品牌
var m_EditIndex;
var m_Brand = "";
var m_CGSource = null;
var m_zt;//帐套
//初始化
$(function () {

    m_zt = $.cookie('m_zt');
    //款式类别
    $('#cmbBrand').combobox({
        url: GetComboxWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', "", "cbtx40", "cbtx40") + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetBrand'),
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false,
        required: true,
        multiple: true,
        onSelect: function (record) {
            getSampleWorker(record.text);
            GetCGSource(record.text);
            //getPDReview(record.text);
            ChangeDHHJJ();
        }
    });

    //查询方式
    $('#cmbSelectType').combobox({
        data: [{ "id": "date", text: "日期", selected: true }, { "id": "orderPlacing", text: "季节" }, { "id": "design", text: "样板号" }, { "id": "productid", text: "大货号" }],
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false,
        onSelect: function (record) {
            slectTypeChange(record);
        }
    });

    $("#txtBeginDate").datebox("setValue", (new Date()).DateAdd('d', -15).format("yyyy-MM-dd"));
    $("#txtEndDate").datebox("setValue", (new Date()).format("yyyy-MM-dd"));

    //订货会季节
    //$('#cmbdhhjj').combobox({
    //    url: GetComboxWSRRURL('bd4c0ca6-42c7-4e5c-a432-515b63f5cc16', "", "orderseason", "orderseason") + "&DIVI=" + m_zt,
    //    valueField: 'id',
    //    textField: 'text',
    //    panelHeight: 'auto',
    //    editable: false,
    //    required: true,
    //    async: false,
    //    onLoadSuccess: function (data) {
    //        if (m_DDHComboxData == null) {
    //            m_DDHComboxData = data;
    //            ChangeDHHJJ();
    //        }
    //    }
    //});




    //初始化品类下拉数据
    $('#txtpl').combobox({
        url: GetComboxWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', '', 'category', 'category') + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GETCATEGORY'),
        valueField: 'id',
        textField: 'text',
        panelHeight: '200',
        editable: false,
        required: false,
        multiple: true
    });






    //品牌
    $('#cmbBrand').combobox({
        //url: GetComboxWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', "", "cbtx40", "cbtx40") + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetBrand'),
        url: GetComboxWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', "", "cbtx40", "cbtx40") + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetBrandProductLine'),
        panelHeight: 'auto',
        valueField: 'id',
        textField: 'text',
        editable: false,
        required: true,
        async: false, //异步
        //success: function (data) {
        //    //m_OwnedBrand = eval(data);
        //    //if (m_OwnedBrand.length > 0 && m_OwnedBrand[0].id) {
        //    //    $('#cmbBrand').combobox('setValue', m_OwnedBrand[0].text);

        //    //    //getPDReview(m_OwnedBrand[0].text);
        //    //    //ChangeDHHJJ();
        //    //}
        //},
        onSelect: function (brand) {
            //初始化季节
            $('#cmbdhhjj').combobox({
                //url: GetComboxWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', "", "cbtx40", "cbtx40") + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetFlexPLMSeason') + "&Where=CBSTKY='" + escape(brand.text) + "'",
                url: GetComboxWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', "", "cbtx40", "cbtx40") + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetStyleSeason'),
                valueField: 'id',
                textField: 'text',
                panelHeight: 'auto',
                editable: false,
                required: true,
                async: false
            });
            getSampleWorker(brand.text);
            GetCGSource(brand.text);
        }
    });
});


function getPDReview(record) {
    //图稿评审人
    $.ajax({
        url: GetComboxALLColumnWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', "", "derwpe", "derwpe") + "&XML=" + escape(GetFormJson([{ "name": "txtDEBRAN", "value": record }, { "name": "txtzt", "value": m_zt }], 'GetPDReview')),
        async: false,
        success: function (data) {
            m_PDReview = eval(data);
        }
    });

}

//获取版师
function getSampleWorker(brand) {
    //初始化品类下拉数据
    var xml = GetFormJson([{ "name": "txtzt", "value": m_zt }, { "name": "txtBrand", "value": brand }], 'GetPattern');
    var htmlobj = $.ajax({
        url: GetComboxWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', "", "UserNameC", "UserNameC"),
        data: { "XML": xml },
        type: 'post',
        async: false
    });
    m_Pattern = $.parseJSON(htmlobj.responseText);
    $('#txtpatterner').combobox({
        data: m_Pattern,
        valueField: 'id',
        textField: 'text',
        panelHeight: '200',
        editable: false,
        required: true,
        multiple: true
    });
}
//获取采购来源
function GetCGSource(record) {

    //采购来源
    $.ajax({
        url: GetComboxALLColumnWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', "", "cbtx40", "cbtx15") + "&XML=" + escape(GetFormJson([{ "name": "txtPLMKey", "value": record }, { "name": "txtzt", "value": m_zt }], 'GetCGSource')),
        async: true,
        success: function (data) {
            m_CGSource = eval(data);
        }
    });
}

//修改订货会季节的下拉框数据
function ChangeDHHJJ() {

    var strGroupType = $('#cmbBrand').combobox("getText");

    if (strGroupType == "") {
        $('#cmbdhhjj').combobox("loadData", []);
        return;
    }

    if (strGroupType.substr(0, 2) == "EP") {
        strGroupType = "EP"
    }
    else if (strGroupType.substr(0, 2) == "E.P") {
        strGroupType = "E.Prosper"
    }
    else if (strGroupType.substr(0, 2) == "Do") {
        strGroupType = "Do"
    }
    else if (strGroupType.substr(0, 2) == "Ki") {
        strGroupType = "Kids"
    }

    if (m_DDHComboxData == null) {
        return;
    }
    var data = m_DDHComboxData;
    var data1 = [];
    for (var i = 0; i < data.length; i++) {
        if (data[i].id.toString().indexOf(strGroupType) > 0) {
            data1.push(data[i]);
        }
    }
    $('#cmbdhhjj').combobox("loadData", data1);

}

//查询条件改变
function slectTypeChange(type) {
    $("#date")[0].style.display = "none";
    $("#orderPlacing")[0].style.display = "none";
    $("#design")[0].style.display = "none";
    $("#productid")[0].style.display = "none";

    $("#" + type.id)[0].style.display = "inline-block";

}

//查询事件
function SearchClick() {

    var brand = $("#cmbBrand").combobox("getValues");
    if (brand == "") {
        $.messager.alert("提示", "请选择品牌", "warnin");
        return;
    }
    brand = '#' + brand.join('#,#') + '#';
    //m_Brand = brand;
    var start = "";
    var end = "";
    var designId = "";
    var username = window.m_UserID;
    var season = "";
    var txtpatterner = "";
    var txtpl = "";
    var pid = "";
    if (brand == "") {
        $.messager.alert("提示", "请先选择品牌！", 'error');
        return;
    }

    var selectType = $('#cmbSelectType').combobox("getValue");
    //根据日期
    if (selectType == "date") {
        $("#txtBeginDate").datebox("setValue", $("#txtBeginDate").datebox("getText"));
        $("#txtEndDate").datebox("setValue", $("#txtEndDate").datebox("getText"));

        start = $("#txtBeginDate").datebox("getValue");
        end = $("#txtEndDate").datebox("getValue");

        if (start == "") {
            $.messager.alert("提示", "开始时间不能为空！", 'error');
            return;
        }

        if (end == "") {
            $.messager.alert("提示", "结束时间不能为空！", 'error');
            return;
        }
    }
    else if (selectType == "orderPlacing") {//订货会
        season = $('#cmbdhhjj').combobox("getValue");
        txtpatterner = $('#txtpatterner').combobox('getValues');
        txtpl = $('#txtpl').combobox('getValues');
        if (season == "") {
            $.messager.alert("提示", "订货会季节不能为空！", 'error');
            return;
        }
    }
    else if (selectType == "design") {//设计号
        designId = $('#txtDesignerId').val();
        if (designId == "") {
            $.messager.alert("提示", "设计号不能为空！", 'error');
            return;
        }
    }
    else if (selectType == "productid") {
        pid = $("#txtproductid").val();

        if (pid.length == 0) {
            $.messager.alert("提示", "大货号不能为空！", 'error');
            return;
        }
    };

    m_SearchData = "";
    m_SearchData += "&brand=" + escape(brand);
    m_SearchData += "&muser=" + escape(txtpatterner);
    m_SearchData += "&category=" + escape(txtpl);
    m_SearchData += "&start=" + start;
    m_SearchData += "&end=" + end;
    m_SearchData += "&designId=" + designId;
    m_SearchData += "&username=" + escape(username);
    m_SearchData += "&season=";
    m_SearchData += "&plmseason=" + escape(season);
    m_SearchData += "&DIVI=" + m_zt;
    m_SearchData += "&productid=" + pid;

    InitGird();

    //m_Pattern = null;
    m_EditIndex = undefined;

}

//初始化表格
function InitGird() {
    $('#tabList').datagrid(
        {
            //title: '服务申请：1、系统提交申请后，与总监当面确认；2、打印申请单给研发；3、研发完成后，录入SP代码；4、与总监确认定稿；',
            //queryParams: { "XML": GetFormJson(m_SearchData, 'GET') },
            url: GetWSRRURL('dfaf0456-4114-4d51-8fce-7f71beb526e2') + m_SearchData,
            nowrap: true, //是否换行，True 就会把数据显示在一行里
            striped: true, //True 奇偶行使用不同背景色
            collapsible: false, //可折叠
            remoteSort: true, //定义是否从服务器给数据排序
            fit: true,
            loadMsg: '数据努力加载中...',
            singleSelect: true, //单行选择 
            columns: [[
                //{ field: 'designer', title: '设计师', width: 160 },
                {
                    field: 'designimagesmall', title: '款图', width: 100, formatter: function (value, row, index) {
                        var data = "<a href='http://192.168.0.72/FlexPLMAPI/GetFlexImage.aspx?DT=true&IMG=" + escape(row.designimagebig) + "' target='_blank'><img  src='" + value + "' style='height:70px' border='0'/></a>";
                        return data;

                    }
                },
                { field: 'designerid', title: '设计号', width: 80 },
                { field: 'splitnumber', title: '驳样号', width: 80, hidden: true },
                { field: 'measurementsid', title: '样板号', width: 80 },
                { field: 'productname', title: '款号', width: 80 },
                { field: 'plmseason', title: '季节', width: 140 },
                { field: 'designer', title: '设计师', width: 60 },
                { field: 'muser', title: '版师', width: 80, editor: { type: 'combobox' } },
                { field: 'recdate', title: '接版日期', width: 80 },
                { field: 'mcount', title: '版型创建', width: 80, hidden: true },
                { field: 'changecount', title: '调板次数', width: 80 },
                { field: 'changedesc', title: '调板原因', width: 80, hidden: true },
                { field: 'deliverdate', title: '交版日期', width: 80 },
                { field: 'derwpe', title: '图稿评审人', width: 80, editor: { type: 'combobox', options: { data: m_PDReview, required: true, editable: false, valueField: 'id', textField: 'text' } } },
                { field: 'rectype', title: '接收品类型', width: 80, hidden: true },
                { field: 'dyfactory', title: '打样工厂', width: 80, hidden: true },
                { field: 'cgsource', title: '采购来源', width: 80, hidden: true },
                { field: 'boduanseries', title: '系列', width: 80 },
                { field: 'category', title: '品类', width: 80 },
                { field: 'producttype', title: '产品类型', width: 80 },
                { field: 'stat', title: '状态', width: 80 },
                { field: 'curwfname', title: '款式生命周期', width: 120 },
                { field: 'muser1', title: '开发员', width: 100 },
                { field: 'recdate1', title: '开发接收日期', width: 100 },
                { field: 'deliverdate1', title: '开发完成日期', width: 100 }
            ]],
            pagination: false, //是否开启分页
            pageNumber: 1, //默认索引页
            pageSize: 20, //默认一页数据条数
            rownumbers: true, //行号
            //onDblClickRow: function () { EditOnClick(); },
            onDblClickRow: onDblClickRow,
            onClickRow: function (rowIndex, rowData) {
                getRowData(rowData);
                onClickRow(rowIndex, rowData);
            },
            onLoadSuccess: function () {
                m_EditIndex = undefined;
            },
            toolbar: [
            {
                id: 'btnAllocate',
                text: '确认分配',
                iconCls: 'icon-edit',
                hidden: false,
                handler: function () {
                    allocateClick();
                }
            },
            {
                id: 'btnSubmit',
                text: '确认交版',
                iconCls: 'icon-edit',
                hidden: false,
                handler: function () {
                    submitClick();
                }
            },
            {
                id: 'sampleInfo',
                text: '工艺包打印',
                iconCls: 'icon-print',
                hidden: true,
                handler: function () {
                    getSample();
                }
            },
            {
                id: 'btnPause',
                text: '暂停',
                iconCls: 'icon-edit',
                hidden: true,
                handler: function () {
                    pauseClick(this);
                }
            }
            ]
        }
        );

}

//表格单击
function onClickRow(index, rowData) {

    if (rowData.stat == "") {
        $("#btnPause").hide();
    }
    else {
        $("#btnPause").show();
        if (rowData.stat == "已取消") {
            $('#btnPause span:last').html('启用')
        }
        else {
            $('#btnPause span:last').html('暂停')

        }
    };

    //确认样打印按钮
    if (rowData.measurementsid == "") {
        $("#sampleInfo").hide();
    } else {
        $("#sampleInfo").show();
    }

    if (m_Pattern.length == 0 ||
               (m_Pattern.length == 1 && m_Pattern[0].id == "")) {
        //$("#btnSubmit").hide();
    }
    else if (rowData.curwfname == "创建版型和缝制工艺并上载CAD文件") {
        $("#btnSubmit").show();
    }
    else {
        //$("#btnSubmit").hide();
    };

}


//表格双击
function onDblClickRow(index, rowData) {

    //如果没有权限，不能进入编辑
    if (m_Pattern.length == 0 || (m_Pattern.length == 1 && m_Pattern[0].id == "")) {
        return;
    }


    var rowBrand = rowData.brand;

    getPDReview(rowBrand);
    if (m_EditIndex != index) {
        if (endEditing()) {
            m_EditIndex = index;
            if (!rowData.load) {
                var $dg = $('#tabList');
                var col = $dg.datagrid('getColumnOption', 'derwpe');

                var data1 = [];
                for (var i = 0; i < m_PDReview.length; i++) {
                    if (rowData.boduanseries == m_PDReview[i].DESERI) {
                        data1[data1.length] = m_PDReview[i];
                    }
                }
                col.editor = {
                    type: 'combobox', options:
                    {
                        data: data1, required: true, editable: false, valueField: 'id', textField: 'text'
                    }
                };


                col = $dg.datagrid('getColumnOption', 'muser');
                col.editor = {
                    type: 'combobox', options:
                    { data: m_Pattern, required: true, editable: false, valueField: 'id', textField: 'text' }
                };

                rowData.load = true;
            }

            $('#tabList').datagrid('selectRow', m_EditIndex).datagrid('beginEdit', m_EditIndex);
        }
    }
}

//结束编辑
function endEditing() {
    //如果没有权限，不能进入编辑
    if (m_Pattern.length == 0 || (m_Pattern.length == 1 && m_Pattern[0].id == "")) {
        return false;
    }

    if (m_EditIndex != undefined) {

        if ($('#tabList').datagrid('validateRow', m_EditIndex)) {
            $('#tabList').datagrid('endEdit', m_EditIndex);
            editIndex = undefined;
        }
        else {
            $.messager.alert("提示", "请先将第" + (m_EditIndex + 1) + "行的必填项填完", 'error');
            return false;
        }
    }
    return true;
}

//分配按钮调用
function allocateClick() {
    if (endEditing() == false) {
        return;
    }

    var seleted = $('#tabList').datagrid("getChanges");


    if (seleted.length == 0) {
        $.messager.alert("提示", "请先选择需要分配的行", 'error');
        return;
    }
    if (seleted.length != 1) {
        $.messager.alert("提示", "只能选择一行，进行操作", 'error');
        return;
    }
    else {
        var deleteMessage = '您本次要分配' + seleted.length + '行记录，确认提交吗?';

        $.messager.confirm('提示框', deleteMessage, function (r) {
            if (r) {
                allocateData(seleted)
            }
        })
    }


}

//分配数据提交
function allocateData(seleted) {
    var xmlData = [];
    for (var i = 0; i < seleted.length; i++) {
        //seleted[i].recdate = "20130101"
        var rowData = [];
        rowData.CurUser = window.m_UserID;
        //rowData.DIVI = m_zt;
        if (seleted[i].splitnumber == undefined) {
            rowData.SplitNumber = "";
        }
        else {
            rowData.SplitNumber = seleted[i].splitnumber;
        }

        if (seleted[i].productname == undefined) {
            rowData.ProductName = "";
        }
        else {
            rowData.ProductName = seleted[i].productname;
        }

        if (seleted[i].designer == undefined) {
            rowData.Designer = "";
        }
        else {
            rowData.Designer = seleted[i].designer;
        }

        if (seleted[i].muser == undefined) {
            rowData.MUser = "";
        }
        else {
            rowData.MUser = seleted[i].muser;
        }

        if (seleted[i].derwpe == undefined) {
            rowData.DERWPE = "";
        }
        else {
            rowData.DERWPE = seleted[i].derwpe;
        }

        if (seleted[i].rectype == undefined) {
            rowData.RecType = "";
        }
        else {
            rowData.RecType = seleted[i].rectype;
        }
        rowData.RecType = "设计图稿";

        //if (seleted[i].dyfactory == undefined) {
        //    rowData.DYFactory = "";
        //}
        //else {
        //    rowData.DYFactory = seleted[i].dyfactory;
        //}
        rowData.DYFactory = m_CGSource[0].CBTX40;

        //if (seleted[i].cgsource == undefined) {
        //    rowData.CGSource = "";
        //}
        //else {
        //    rowData.CGSource = seleted[i].cgsource;
        //}
        rowData.CGSource = m_CGSource[0].CBTX15;

        if (seleted[i].producttype == undefined) {
            rowData.ProductType = "";
        }
        else {
            rowData.ProductType = seleted[i].producttype;
        }
        xmlData[xmlData.length] = rowData;

    }

    //data1.xml = XML;


    var xml = GetEditJsonbyType1(xmlData, "SAVE");

    var data99 = new Object();
    data99.xml = xml
    data99.DIVI = m_zt;

    $.ajax({
        url: GetWSRRURL('1db27a39-c771-4173-a738-20be64170202'),
        data: data99,
        type: 'post',
        async: true, //异步,
        success: function (result) {
            try {
                var data = eval("[" + result + "]");
                if (data[0].Error != undefined) {
                    $.messager.alert("提示", data[0].Error, 'error');
                }
                else {
                    $.messager.alert("提示", data[0].Result);
                    for (var i = 0; i < seleted.length; i++) {
                        seleted[i].recdate = (new Date()).format("yyyyMMdd");
                        $('#tabList').datagrid('refreshRow', $('#tabList').datagrid('getRowIndex', seleted[i]));
                    }

                    $('#tabList').datagrid("unselectAll");
                    $('#tabList').datagrid("acceptChanges");
                    m_EditIndex = undefined;
                }


            } catch (ex) {
                $.messager.progress('close');

                $.messager.alert("提示", ex, 'error');
            }
        },
        error: function () {
            $.messager.progress('close');
            $.messager.alert("提示", "提交错误了！", 'error');
        }
    });
}

//交版按钮调用
function submitClick() {
    var seleted = $('#tabList').datagrid("getSelected");
    if (seleted == 0) {
        $.messager.alert("提示", "请先选择需要交版的行", 'error');
        return;
    }
    else {
        var message = '确定对款' + seleted.productname + '执行交版吗?';

        $.messager.confirm('提示框', message, function (r) {
            if (r) {
                //allocateData(seleted)
                submitData(seleted);
            }
        })
    }
}

//交版数据提交
function submitData(seleted) {

    var rowData1 = [];

    rowData1.ProductName = seleted.productname;

    var xmlData1 = [];
    xmlData1[0] = rowData1;

    m_Brand = seleted.brand;

    var xml = {};
    xml.skc = seleted.productname;
    xml.brand = m_Brand;
    xml.mt = getMT(seleted.productname);
    xml.mn = getMN(seleted.productname);
    xml.sourcingName = seleted.cgsource;
    xml.specName = seleted.dyfactory;


    xml.xml1 = GetEditJsonbyType1(xmlData1, "UPDATEMCOUNT");
    xml.username = seleted.muser;
    xml.xml2 = "<ROOT><ProductNo>" + seleted.productname + "</ProductNo><UserName>" + seleted.muser + "</UserName></ROOT>";
    xml.xml3 = "<ROOT><ProductName>" + seleted.productname + "</ProductName>"
        + "<ProductNo>" + seleted.productname + "</ProductNo>"
        + "<ProofingNo></ProofingNo>"
        + "<UserName>" + seleted.designer + "</UserName>"
        + "<TypeName>确认交版</TypeName></ROOT>";


    //var data99 = new Object();
    //data99.xml = xml
    xml.DIVI = m_zt;

    $.ajax({
        url: GetWSRRURL('2b00f1dd-1b73-4b94-b518-29ac2e76cfc9'),
        data: xml,
        type: 'post',
        async: true, //异步,
        success: function (result) {
            try {
                var data = eval("[" + result + "]");
                if (data[0].Error != undefined) {
                    $.messager.alert("提示", data[0].Error, 'error');
                }
                else {
                    $.messager.alert("提示", data[0].Result);

                    seleted.curwfname = "创建白坯样申请";
                    $('#tabList').datagrid('refreshRow', $('#tabList').datagrid('getRowIndex', seleted));

                    $('#tabList').datagrid("unselectAll");
                    //$('#tabList').datagrid("acceptChanges");
                    m_EditIndex = undefined;
                }


            } catch (ex) {
                $.messager.progress('close');

                $.messager.alert("提示", ex, 'error');
            }
        },
        error: function () {
            $.messager.progress('close');
            $.messager.alert("提示", "提交错误了！", 'error');
        }
    });
}

//获取MT的配置值
function getMT(data) {

    if (data.substr(5, 1) == "3") {
        return m_Brand + "下装";
    }
    else if (data.substr(5, 1) == "6") {
        return m_Brand + "下装";
    }
    else if ("1245789PQMNY".indexOf(data.substr(5, 1)) > -1) {
        return m_Brand + "上装";
    }
    else {
        return m_Brand + "服饰品";
    }
}

//获取MN的配置值
function getMN(data) {
    if (data.substr(5, 1) == "4") {
        return "上装-连衣裙-通用";
    }
    else if (data.substr(5, 1) == "3") {
        return "下装-通用";
    }
    else if (data.substr(5, 1) == "6") {
        return "下装-通用";
    }
    else if ("1245789PQMNY".indexOf(data.substr(5, 1)) > -1) {
        return "上装-通用";
    }
    else {
        return "服饰品-通用";
    }
}

//adarpt 格式转换：json-->XML
function GetEditJsonbyType1(data, optype) {
    var updatedData = '<ROOT>'
    //如果没有传入optype参数，将不再生成OPTYPE节点
    if (optype != undefined) {
        updatedData += "<OPTYPE>" + optype + "</OPTYPE>";
    }
    if (data != null && data.length) {
        updatedData += '<PARAMS>'
        for (var i = 0; i < data.length; i++) {
            updatedData += '<ROW>'

            for (var key in data[i]) {
                if (key) {
                    updatedData += '<' + key + '>' + ReplaceSpecialXMLString(data[i][key]) + '</' + key + '>';
                }
            }
            updatedData += '</ROW>'

        }
        updatedData += "</PARAMS>";
    }
    updatedData += "</ROOT>";
    return updatedData;
}

//暂停启用按钮调用
function pauseClick(btn) {
    var seleted = $('#tabList').datagrid("getSelected");
    if (!seleted) {
        $.messager.alert("提示", "请先选择需要暂停或启用的行", 'error');
        return;
    }
    else {
        var message = '确定' + btn.text + '款' + seleted.productname + '吗?';

        $.messager.confirm('提示框', message, function (r) {
            if (r) {
                pauseData(seleted, btn);
            }
        })
    }
}

//暂停启用数据提交
function pauseData(seleted, btn) {

    var rowData = [];

    if (seleted.productname == undefined) {
        rowData.ProductName = "";
    }
    else {
        rowData.ProductName = seleted.productname;
    }

    if (btn.text == "暂停") {
        rowData.Stat = "已取消";
    }
    else {
        rowData.Stat = "";
    }
    rowData.CurUser = window.m_UserID;

    var xmlData = [];
    xmlData[0] = rowData;
    var xml = GetEditJsonbyType1(xmlData, "PAUSE");


    var data99 = new Object();
    data99.xml = xml
    data99.DIVI = m_zt;

    $.ajax({
        url: GetWSRRURL('1db27a39-c771-4173-a738-20be64170202'),
        data: data99,
        type: 'post',
        async: true, //异步,
        success: function (result) {
            try {
                var data = eval("[" + result + "]");
                if (data[0].Error != undefined) {
                    $.messager.alert("提示", data[0].Error, 'error');
                }
                else {
                    $.messager.alert("提示", data[0].Result);

                    if (rowData.Stat == "") {
                        seleted.stat = "已分配";
                    }
                    else {
                        seleted.stat = rowData.Stat;
                    }
                    $('#tabList').datagrid('refreshRow', $('#tabList').datagrid('getRowIndex', seleted));

                    $('#tabList').datagrid("unselectAll");
                    //$('#tabList').datagrid("acceptChanges");
                    //m_EditIndex = undefined;
                }


            } catch (ex) {
                $.messager.progress('close');

                $.messager.alert("提示", ex, 'error');
            }
        },
        error: function () {
            $.messager.progress('close');
            $.messager.alert("提示", "提交错误了！", 'error');
        }
    });
}

function getRowData(rowData) {
    return function () {
        var data = [];
        data.push(rowData.orderseason, rowData.measurementsid);
        alert(data.length);
        return data;
    };
}

//LeeGo--整合功能：确认样打印
function getSample() {
    var rowData = $("#tabList").datagrid("getSelected"),
        smpData = [rowData.plmseason, rowData.measurementsid, m_UserID, rowData.brand],
        data = initArray(),
        url = GetWSRRURL('adeb3eda-43df-4c82-a5b3-38f18c216ed8'),
        xmlData = "";

    data.push(
        { "name": "txt实体", "value": "GetProductCGSource" },
        { "name": "txt季节", "value": smpData[0] },
        { "name": "txt样板号", "value": smpData[1] },
        { "name": "txt操作人", "value": smpData[2] },

        //{ "name": "txtXML", "value": "" },
        { "name": "txt品牌", "value": smpData[3] }
        );

    xmlData = GetDBFrameAML(data);//组成调用APIxml
    url += xmlData;
    //ZH5100
    $.messager.progress({ title: '请稍后', msg: '处理中' });
    $.post(url, function (data) {
        try {
            var rltJson = $.parseJSON(data),
                rltLength = rltJson.rows.length,
                isResult = rltJson.rows[0].result,
                rltMessage = rltJson.rows[0].message,
                checkMsg = typeof (isResult);
            if (checkMsg != "undefind") {
                if (rltLength == 1) {
                    if (rltJson.strt == "") {
                        $.messager.progress("close");
                        $.messager.alert("警告", "无确认样数据", "warning");
                    } else {
                        var strt = rltJson.rows[0].strt;
                        getBomInfo(smpData[0], smpData[1], strt, smpData[2], smpData[3]);
                    }
                } else {
                    getProduct(smpData[0], rltJson.rows, smpData[3]);
                };
            } else {
                $.messager.progress("close");
                $.messager.alert("错误", rltMessage, "error");
            };
        } catch (ex) {
            $.messager.progress("close");
            alert(ex.message);
        };
    })

}

function getBomInfo(_season, _sample, _strt, _muser, _brand) {
    var data = initArray(),
        xmlData = "",
        url = GetWSRRURL('adeb3eda-43df-4c82-a5b3-38f18c216ed8');

    data.push(
        { "name": "txt实体", "value": "GetProductSample" },
        { "name": "txt返回内容", "value": "必填" },
        { "name": "txt季节", "value": _season },
        { "name": "txt样板号", "value": _sample },
        { "name": "txt操作人", "value": _muser },
        { "name": "txtBomList", "value": "" },
        { "name": "txtSTRT", "value": _strt }
        );

    xmlData = GetDBFrameAML(data);
    url += xmlData;

    $.post(url, function (result) {
        try {
            var rltJson = $.parseJSON(result),
                rltLength = rltJson.rows.length,
                winProperties = initWin();

            $("#smpShtBtn").linkbutton({ plain: true, text: "关闭", iconCls: "icon-undo" });
            $("#smpShtBtn").unbind("click").click(function () { shutdownWin("winSample"); });
            $("#winSample").window(winProperties).window('open');

            $("#tt").tabs("select", "选择样衣");
            if (rltLength > 0) {
                $("#win_list").datagrid({
                    data: rltJson.rows,
                    singleSelect: true,
                    striped: true,
                    fit: true,
                    columns: [[
                        { field: 'measurementsid', title: '样版号', width: 80 },
                        { field: 'dyyyno', title: '样衣号', width: 80 },
                        { field: 'dycolorname', title: '颜色', width: 140 },
                        { field: 'dyovdt', title: '完成时间' }
                    ]],
                    toolbar: [
                      {
                          id: 'btnSamplePrint',
                          text: '确认样打印',
                          iconCls: 'icon-print',
                          handler: function () { printSample(_season, _muser, _brand); }
                      }, {
                          id: 'btnSampClose',
                          text: '关闭',
                          iconCls: 'icon-undo',
                          handler: function () { shutdownWin("winSample"); }
                      }
                    ],
                    onDblClickRow: function () { printSample(_season, _muser, _brand); }
                });
                $.messager.progress("close");
            };
        }
        catch (ex) {
            $.messager.progress("close");
            alert(ex.message);
        };
    });

}

function printSample(_season, _muser, _brand) {
    var data
            = $("#win_list").datagrid("getSelected"),
        dataMain
            = $('#tabList').datagrid("getSelected"),
        isObj = data instanceof Object;

    var plmseason = dataMain.plmseason;
    if (isObj && data.dyyyno != "") {
        //订货会季节
        $("#txtcmbdhhjj").val(_season);
        //样衣号
        $("#txtdyyyno").val(data.dyyyno);


        $.messager.progress({ title: '请稍后', msg: '处理中' });

        initPrintGird(_muser, plmseason, _brand);

        $.messager.progress('close');
    } else {
        $.messager.alert("警告", "请选择样衣进行打印。", "warning");
    };
}

function getProduct(_season, _source, _brand) {
    var win = new initWin();
    win.title = "采购来源";

    $("#winProduct").window(win).window("open");

    $("#ProductList").datagrid({
        data: _source,
        singleSelect: true,
        striped: true,
        fit: true,
        columns: [[
            { field: "dyfactory", title: "打样工厂", width: 130 },
            { field: 'cgsource', title: '采购来源', width: 100 },
            { field: 'measurementsid', title: '样版号', width: 80 },
            { field: 'strt', title: '序号', width: 80 },
            { field: 'muser', title: '操作员', width: 100 }
        ]],
        toolbar: [
          {
              id: 'btnSampleInfo',
              text: '选择采购来源',
              iconCls: 'icon-search',
              handler: function () { affirmProduct(_season, _brand) }
          },
          {
              id: 'btnProClose',
              text: '关闭',
              iconCls: 'icon-undo',
              handler: function () { shutdownWin("winProduct"); }
          }
        ]
    });

    $.messager.progress("close");
}

function affirmProduct(_season,_brand) {
    var getRow = $("#ProductList").datagrid("getSelected"),
        isObj = getRow instanceof Object;

    if (isObj && getRow.strt != "") {
        $.messager.progress({ title: '请稍后', msg: '处理中' });

        $('#formSub').find("input[type='checkbox']").attr("checked", false);
        $('#formSub').find("textarea").val("");

        getBomInfo(_season, getRow.measurementsid, getRow.strt, m_UserID, _brand);
    }
    else {
        $.messager.alert("警告", "请确认采购来源。", "warning");
    };
}
//基础模块
function initArray() {
    var data = [];
    data.push(
        { "name": "txt操作类型", "value": "GET" },
        { "name": "txt返回内容", "value": "必填" },
        { "name": "txtCONO", "value": "HFYG" },
        { "name": "txtDIVI", "value": m_zt }
    );
    return data;
}

function initWin() {
    var o = new Object();
    o.title = "确认样";
    o.collapsible = false;
    o.minimizable = false;
    o.maximizable = false;
    o.closable = false;
    o.draggable = false;
    o.resizable = false;
    o.shadow = true;
    o.maximized = true;
    return o;
}

function shutdownWin(_winName) {
    if (_winName == "winSample") {
        ClearGrid("#win_table");
        initTabs();
        $("#winSample").window('close');
    }
    else {
        ClearGrid("#ProductList");
        $("#winProduct").window('close');
    }
}

function initTabs() {
    //订货会季节
    $("#txtcmbdhhjj").val("");
    //样衣号
    $("#txtdyyyno").val("");
    //去掉勾
    $('#formSub').find("input[type='checkbox']").attr("checked", false);
    $('#formSub').find("textarea").val("");
    ClearGrid("#tabPrint");
}
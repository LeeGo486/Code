//郭琦琦添加20140721
//暂停启用按钮调用


//--2014-10-16--添加“图稿打印”按钮,以及右键菜单
//添加人：刘洪(LeeGo)


//--2014-10-27--材料功能开发,代码开发为在原来的基础上增加代码，不修改现有的任何代码。
//添加人：刘洪(LeeGo)

//var m_loginName = '';
var m_SearchData = [];
var m_zt;


var rowData_Right = null;
//初始化
$(function () {

    m_zt = $.cookie('m_zt');

    

    $("#txtBeginDate").datebox("setValue", (new Date()).DateAdd('d', -1).format("yyyy-MM-dd"));
    $("#txtEndDate").datebox("setValue", (new Date()).DateAdd('d', 0).format("yyyy-MM-dd"));

    //款式类别
    $('#cmbkslb').combobox({
        url: GetComboxWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', "", "plmkey", "cbtx40") + "&XML=" + GetFormJson([{ "name": "txtCBSTCO", "value": escape("上下装") }, { "name": "txtzt", "value": m_zt }], 'GET'),
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false,
        required: true
    });

    //款式类型
    $('#cmbkslx').combobox({
        url: GetComboxWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', "", "plmkey", "cbtx40") + "&XML=" + GetFormJson([{ "name": "txtCBSTCO", "value": escape("款式类型") }, { "name": "txtzt", "value": m_zt }], 'GET'),
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false,
        required: true
    });

    //订货会季节
    $('#cmbdhhjj').combobox({
        url: GetComboxWSRRURL('bd4c0ca6-42c7-4e5c-a432-515b63f5cc16', "", "orderseason", "orderseason") + "&DIVI=" + m_zt,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false,
        required: true
    });
    $('#cmbDesigner').combobox({
        url: GetComboxWSRRURL('3090fcec-e79e-49e3-a64d-2c3eac0bbdfb', "", "usernamec", "usernamec") + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GETComboxBySession'),
        valueField: 'id',
        textField: 'text',
        panelHeight: 300,
        editable: false,
        multiple: true
    });
    SearchClick();


    //右键打印事件(LeeGo)
    $("#mm-print").click(printRight);
    //右键材料关联(LeeGo)
    $("#mm-linking").click(materialLink);
    //材料关联窗口
    $("#linkShow").window().window('close');

    //关闭按钮
    $("#close").linkbutton({ iconCls: 'icon-undo', plain: true }).click(function () {
        $("#linkShow img").attr("src", "");
        $("#linkShow").window('close');
    });
    //面/辅/里布
    $("#addM").linkbutton({ iconCls: 'icon-add', plain: true }).click(function(){winSearch("面料")});
    $("#addL").linkbutton({ iconCls: 'icon-add', plain: true }).click(function(){winSearch("里布")});
    $("#addF").linkbutton({ iconCls: 'icon-add', plain: true }).click(function(){winSearch("辅料")});
    $("#delete").linkbutton({ iconCls: 'icon-remove', plain: true }).click(delMaterial);
    //查询--关闭
    $("#btnSearch").linkbutton({ iconCls: 'icon-search', plain: true }).click(btnSearch);
    $("#btnSave").linkbutton({ iconCls: 'icon-save', plain: true }).click(btnSave);
    $("#btnClose").linkbutton({ iconCls: 'icon-undo', plain: true }).click(winSearchClose);
});

function SearchClick() {

    $("#txtBeginDate").datebox("setValue", $("#txtBeginDate").datebox("getText"));
    $("#txtEndDate").datebox("setValue", $("#txtEndDate").datebox("getText"));

    m_SearchData = $('#frmSeach').serializeArray();
    m_SearchData = MergeComboboxData(m_SearchData);


    var obj = new Object();
    obj.name = "txtzt";
    obj.value = m_zt;
    m_SearchData.push(obj)

    InitGird();
}

//初始化表格
function InitGird() {
    $('#tabList').datagrid(
        {
            //title: '服务申请：1、系统提交申请后，与总监当面确认；2、打印申请单给研发；3、研发完成后，录入SP代码；4、与总监确认定稿；',
            queryParams: { "XML": GetFormJson(m_SearchData, 'GET') },
            url: GetWSRRURL('39ad2a7c-bbd2-4c92-9a69-efc17708c898'),
            nowrap: true, //是否换行，True 就会把数据显示在一行里
            striped: true, //True 奇偶行使用不同背景色
            collapsible: false, //可折叠
            remoteSort: true, //定义是否从服务器给数据排序
            fit: true,
            singleSelect: true, //单行选择

            columns: [[
                //{ field: 'designer', title: '设计师', width: 160, search: true, sortable: true },
                {
                    field: 'designimagesmall', title: '款图', width: 100, formatter: function (value, row, index) {
                        var data = "<a href='http://192.168.0.72/FlexPLMAPI/GetFlexImage.aspx?DT=true&IMG=" + row.designimagebig + "' target='_blank'><img  src='http://192.168.0.72/FlexPLMAPI/GetFlexImage.aspx?DT=true&IMG=" + value + "' style='height:70px' border='0'/></a>";
                        return data;

                    }
                },
                { field: 'designerid', title: '设计号', width: 80, search: true, sortable: true },
                { field: 'category', title: '品类', width: 80, search: true, sortable: true },
                { field: 'boduan', title: '波段', width: 125, search: true, sortable: true, formatter: Formater.Date },
                { field: 'boduanseries', title: '系列', width: 125, search: true, sortable: true },
                { field: 'producttype', title: '款式类型', width: 125, search: true, sortable: true },
                { field: 'orderseason', title: '订货会季节', width: 180, search: true, sortable: true },
                { field: 'part', title: '款式类别', width: 80, search: true, sortable: true },
                { field: 'productname', title: '款式名称', width: 125, hidden: true },
                { field: 'stat', title: '当前状态', width: 80 },
                { field: 'createdate', title: '日期', width: 130, search: true, hidden: false, formatter: Formater.Date }
            ]],
            onRowContextMenu: onRowContextMenu,
            view: groupview,
            groupField: 'designer',
            groupFormatter: function (value, rows) {
                return value;
            },
            pagination: false, //是否开启分页
            pageNumber: 1, //默认索引页
            pageSize: 20, //默认一页数据条数
            rownumbers: true, //行号
            onDblClickRow: function () { EditOnClick(); },
            onClickRow: onClickRow,
            toolbar: [
            {
                id: 'btnEdit',
                text: '编辑',
                iconCls: 'icon-edit',
                handler: function () {
                    EditOnClick();
                }
            }, {
                id: 'btnDelete',
                text: '删除',
                iconCls: 'icon-cancel',
                handler: function () {
                    DeleteClick();
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
            }, {
                id: 'btnPrint',
                text: '图稿打印',
                iconCls: 'icon-print',
                handler: function () {
                    printClick("");
                }
            }, {
                id: 'btnMaterial',
                text: '材料关联',
                iconCls: 'icon-add',
                handler: function () {
                    materialLink();
                }
            }]
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
    }
}



function EditOnClick(isAdd) {
    var selectedRow = $('#tabList').datagrid('getSelected');

    $('#divEdit').window({
        top: 20,
        modal: true,
        closed: false
    });


    $('#txtskc').val(selectedRow.productname);
    $('#txtDesignerId1').val(selectedRow.designerid);

    $('#cmbdhhjj').combobox('setValue', selectedRow.orderseason);
    SetCommboboxValueByText('#cmbkslx', selectedRow.producttype)
    SetCommboboxValueByText('#cmbkslb', selectedRow.part)
    $('#frmEdit').form('validate');
    $('#cmbProductType').focus();


}

function EditSubmit() {
    $('#frmEdit').form('submit', {
        onSubmit: function (e) {
            if ($('#formEdit').form('validate') == false) {
                return false;
            }

            var url = "&type=upd&skc=" + escape($("#txtskc").val())
                + "&kslx=" + escape($("#cmbkslx").combobox("getValue"))
                + "&kslxText=" + escape($("#cmbkslx").combobox("getText"))
                + "&kslb=" + escape($("#cmbkslb").combobox("getValue"))
                + "&kslbText=" + escape($("#cmbkslb").combobox("getText"))
                + "&dhhjj=" + escape($("#cmbdhhjj").combobox("getValue"))

            $.messager.progress({ title: '请稍后', msg: '处理中' });

            $.ajax({
                url: GetWSRRURL('3495b554-04fb-42dd-a7b8-1e9ab7153a0b') + url,
                type: 'post',
                async: true, //异步,
                success: function (result) {
                    try {
                        $.messager.progress('close');

                        if (result == "0") {
                            $('#divEdit').window('close');
                            $('#tabList').datagrid("reload");

                            var data = [];
                            data[data.length] = { "name": "txtProductName", "value": escape($("#txtskc").val()) };
                            data[data.length] = { "name": "txtzt", "value": m_zt };

                            var XMLData = GetFormJson(data, 'SendAM');

                            $.ajax({
                                url: GetWSRRURL('d6d09579-f786-4253-92e4-dddfef010116') + "&XML=" + XMLData,
                                options: "JSON",
                                async: false,
                                success: function (data) {
                                    //alert(data);
                                }
                            });

                        }
                        else {
                            $.messager.alert("提示", result, 'error');
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

            return false;
        }
    });
}

function DeleteClick() {
    //郭琦琦 添加删除验证
    var selectedRow = $('#tabList').datagrid('getSelected');
    var orderseason = selectedRow.orderseason;
    var designerid = selectedRow.designerid;

    var data = [];
    data[data.length] = { "name": "txtorderseason", "value": orderseason };
    data[data.length] = { "name": "txtdesignerid", "value": designerid };
    data[data.length] = { "name": "txtzt", "value": m_zt };

    var xmlData = GetFormJson(data, 'VerificationDelete');
    htmlobj = $.ajax({
        url: GetWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9'),
        data: { "XML": xmlData },
        type: 'post',
        async: false
    });
    var result = $.parseJSON(htmlobj.responseText);
    var stat = result.rows[0]['stat']//判断是否有权限

    if (stat == "已分配" || stat == "已取消") {
        alert("该款式已经指派版型任务，无法删除！");
        return;
    }
    $.messager.confirm('提示框', "确认删除吗？删除后数据将无法恢复！", function (r) {
        if (r) {

            var url = "&type=del&skc=" + escape(selectedRow.productname);
            $.messager.progress({ title: '请稍后', msg: '处理中' });

            $.ajax({
                url: GetWSRRURL('3495b554-04fb-42dd-a7b8-1e9ab7153a0b') + url,
                type: 'post',
                async: true,
                success: function (result) {
                    $.messager.progress('close');

                    try {

                        if (result == "0") {
                            $('#divEdit').window('close');
                            $('#tabList').datagrid("reload");
                        }
                        else {
                            $.messager.alert("提示", result, 'error');
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
    });
}

//郭琦琦添加20140721

//暂停启用按钮调用
function pauseClick(btn) {
    var seleted = $('#tabList').datagrid("getSelected");
    if (seleted == 0) {
        $.messager.alert("提示", "请先选择需要暂停或启用的行", 'error');
        return;
    }
    else {
        var message = '确定' + btn.innerText + '款' + seleted.productname + '吗?';

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

    if (btn.innerText == "暂停") {
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


//------------以下是刘洪(LeeGo)添加的代码------------

//添加右键菜单方法
function onRowContextMenu(e, rowIndex, rowData) {
    e.preventDefault();//防止冒泡
    //赋值
    rowData_Right = rowData;
    var selected = $("#tabList").datagrid('getRows'); //获取所有行集合对象
    selected[rowIndex].id; //index为当前右键行的索引，指向当前行对象
    $('#mm').menu('show', {
        left: e.pageX,
        top: e.pageY
    });
}

//添加图稿打印的方法
function printRight() {
    if (rowData_Right == null) {
        $.messager.alert("提示", "请选中要打印的行", "warning");
        return;
    };
    printClick(rowData_Right);
}

//图稿打印
function printClick(rowData) {
    var printData;

    //里布
    var lb = [];

    //普通面料
    var ml = [];

    //其他材料
    var other = [];

    if (rowData == "") {
        printData = $('#tabList').datagrid("getSelected");
        if (printData == null) {
            $.messager.alert("提示", "请先选择需要打印的行", 'warning');
            return;
        };
    }
    else printData = rowData;

    

    var XMLData = "<ROOT><OPTYPE>GetMaterial</OPTYPE><LIST><ROWS><ProductName>" + printData.productname + "</ProductName><zt>" + m_zt + "</zt></ROWS></LIST></ROOT>";

    $.post(GetWSRRURL('39ad2a7c-bbd2-4c92-9a69-efc17708c898'), { "XML": XMLData }, function (data) {

        data = eval('(' + data + ')');

        
        var now = new Date();

        var year = now.getFullYear();
        var month = now.getMonth();
        var day = now.getDate();

        month = +month + 1;

        var formatdate = year + "-" + month + "-" + day + " " + now.getHours() + ":" + now.getMinutes() + ":" + now.getSeconds();

        console.log("时间----------------------" + formatdate);

        //-----------------Print Start----------------
        LODOP = getLodop(document.getElementById('LODOP_OB'), document.getElementById('LODOP_EM'));
        LODOP.SET_LICENSES("浙江雅莹服装有限公司", "853717765858688748719056235623", "", "");
        LODOP.PRINT_INITA("0mm", "0mm", "2100.6mm", "2970.1mm", "");
        LODOP.SET_PRINT_PAGESIZE(1, "210mm", "297mm", "");
        
        LODOP.ADD_PRINT_RECT(119, 19, 735, 910, 0, 1);
        //LODOP.ADD_PRINT_RECT(119, 19, 735, 958, 0, 1);
        //--
        LODOP.ADD_PRINT_RECT(119, 19, 735, 45, 0, 1);
        LODOP.ADD_PRINT_RECT(163, 529, 225, 840, 0, 1);
        LODOP.ADD_PRINT_RECT(163, 529, 225, 34, 0, 1);
        LODOP.ADD_PRINT_RECT(196, 529, 225, 196, 0, 1);
        LODOP.ADD_PRINT_RECT(391, 529, 225, 196, 0, 1);
        LODOP.ADD_PRINT_RECT(586, 529, 225, 196, 0, 1);
        LODOP.ADD_PRINT_RECT(781, 529, 225, 147, 0, 1);
        LODOP.ADD_PRINT_RECT(196, 529, 225, 65, 0, 1);
        LODOP.ADD_PRINT_RECT(196, 529, 225, 34, 0, 1);
        LODOP.ADD_PRINT_RECT(196, 529, 67, 65, 0, 1);
        LODOP.ADD_PRINT_RECT(391, 529, 225, 65, 0, 1);
        LODOP.ADD_PRINT_RECT(586, 529, 225, 65, 0, 1);
        LODOP.ADD_PRINT_RECT(781, 529, 225, 65, 0, 1);
        LODOP.ADD_PRINT_RECT(391, 529, 225, 34, 0, 1);
        LODOP.ADD_PRINT_RECT(586, 529, 225, 34, 0, 1);
        LODOP.ADD_PRINT_RECT(781, 529, 225, 34, 0, 1);
        LODOP.ADD_PRINT_RECT(391, 529, 67, 65, 0, 1);
        LODOP.ADD_PRINT_RECT(586, 529, 67, 65, 0, 1);
        LODOP.ADD_PRINT_RECT(781, 529, 67, 65, 0, 1);
        LODOP.ADD_PRINT_RECT(927, 529, 225, 26, 0, 1);
        LODOP.ADD_PRINT_RECT(952, 529, 225, 26, 0, 1);
        LODOP.ADD_PRINT_RECT(927, 529, 67, 102, 0, 1);
        //--
        LODOP.ADD_PRINT_TEXT(38, 43, 191, 46, "款式设计稿");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 27);
        LODOP.ADD_PRINT_TEXT(47, 241, 249, 30, printData.orderseason);//季节
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 15);
        LODOP.ADD_PRINT_TEXT(88, 381, 122, 30, printData.boduanseries);//系列
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 15);
        LODOP.ADD_PRINT_TEXT(86, 515, 85, 34, "样板号");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 18);
        LODOP.ADD_PRINT_TEXT(87, 641, 100, 30, printData.designerid); //样板号
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 18);
        //LODOP.ADD_PRINT_RECT(119, 19, 735, 45, 0, 1);
        LODOP.ADD_PRINT_TEXT(128, 154, 466, 34, "款式正反面平面以及款式明细说明");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 17);
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
        //LODOP.ADD_PRINT_RECT(163, 529, 225, 914, 0, 1);
        //LODOP.ADD_PRINT_RECT(163, 529, 225, 34, 0, 1);
        LODOP.ADD_PRINT_TEXT(172, 532, 162, 25, "衣长/群长/裤长：");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 12);
        //LODOP.ADD_PRINT_RECT(196, 529, 225, 196, 0, 1);
        //LODOP.ADD_PRINT_RECT(391, 529, 225, 196, 0, 1);
        //LODOP.ADD_PRINT_RECT(586, 529, 225, 196, 0, 1);
        //LODOP.ADD_PRINT_RECT(781, 529, 225, 196, 0, 1);
        //LODOP.ADD_PRINT_RECT(196, 529, 225, 65, 0, 1);
        //LODOP.ADD_PRINT_RECT(196, 529, 225, 34, 0, 1);
        //LODOP.ADD_PRINT_RECT(196, 529, 67, 65, 0, 1);
        LODOP.ADD_PRINT_TEXT(206, 544, 49, 25, "主料A\n");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 11);
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);

        //变量
        for (i = 0; i < data.rows.length; i++) {
            var print = data.rows[i];
           
            if (print.dfmfat != "" && print.dfmfat == "1") {
                LODOP.ADD_PRINT_TEXT(206, 602, 152, 25, print.dfitno); //主料A
                LODOP.SET_PRINT_STYLEA(0, "FontSize", 11);
                LODOP.ADD_PRINT_TEXT(236, 601, 155, 25, print.mmitds); //成分
                LODOP.SET_PRINT_STYLEA(0, "FontSize", 7);
            };

            //普通面料
            if (print.dfmfat != "" && print.dfmfat == "2") {
                var obj = new Object();
                obj.name = print.dfitno;
                obj.value = print.mmitds;
                ml.push(obj);
                continue;
            };

            //里布
            if (print.dfmfat != "" && print.dfmfat == "3") {
                var obj = new Object();
                obj.name = print.dfitno;
                obj.value = print.mmitds;
                lb.push(obj);
                continue;
            };

            //辅料
            if (print.dfmfat != "" && print.dfmfat == "4") {
                var obj = new Object();
                obj.name = print.dfitno;
                obj.value = print.mmitds;
                other.push(obj);
                continue;
            };
        };

        LODOP.ADD_PRINT_TEXT(595, 544, 49, 25, "里布A");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 11);
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
        //里布(只取前两个)
        if (lb.length > 0) {
            for (j = 0; j < lb.length; j++) {
                if (j == 0) {
                    LODOP.ADD_PRINT_TEXT(596, 600, 152, 25, lb[0].name);
                    LODOP.SET_PRINT_STYLEA(0, "FontSize", 11);
                    LODOP.ADD_PRINT_TEXT(625, 601, 154, 25, lb[0].value);
                    LODOP.SET_PRINT_STYLEA(0, "FontSize", 7);
                };
                if (j == 1) {
                    LODOP.ADD_PRINT_TEXT(790, 600, 154, 25, lb[1].name);
                    LODOP.SET_PRINT_STYLEA(0, "FontSize", 11);
                    LODOP.ADD_PRINT_TEXT(821, 600, 156, 25, lb[1].value);
                    LODOP.SET_PRINT_STYLEA(0, "FontSize", 7);
                };
            };
        };

        //其他材料
        if (other.length > 0) {
            for (k = 0; k < other.length; k++) {
                if (k == 0) {
                    LODOP.ADD_PRINT_TEXT(983, 602, 152, 25, other[0].name);
                    LODOP.SET_PRINT_STYLEA(0, "FontSize", 11);
                };
                if (k == 1) {
                    LODOP.ADD_PRINT_TEXT(1006, 602, 151, 25, other[1].name);
                    LODOP.SET_PRINT_STYLEA(0, "FontSize", 11);
                };
                if (k == 2) {
                    LODOP.ADD_PRINT_TEXT(1031, 603, 149, 25, other[2].name);
                    LODOP.SET_PRINT_STYLEA(0, "FontSize", 11);
                };
                if (k == 3) {
                    LODOP.ADD_PRINT_TEXT(1054, 603, 148, 25, other[3].name);
                    LODOP.SET_PRINT_STYLEA(0, "FontSize", 11);
                };
            };
        };



        LODOP.ADD_PRINT_TEXT(236, 543, 49, 25, "成分");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 11);
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
        LODOP.ADD_PRINT_TEXT(264, 535, 70, 25, "面料小样");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 11);
        //LODOP.ADD_PRINT_RECT(391, 529, 225, 65, 0, 1);
        //LODOP.ADD_PRINT_RECT(586, 529, 225, 65, 0, 1);
        //LODOP.ADD_PRINT_RECT(781, 529, 225, 65, 0, 1);
        //LODOP.ADD_PRINT_RECT(391, 529, 225, 34, 0, 1);
        //LODOP.ADD_PRINT_RECT(586, 529, 225, 34, 0, 1);
        //LODOP.ADD_PRINT_RECT(781, 529, 225, 34, 0, 1);
        //LODOP.ADD_PRINT_RECT(391, 529, 67, 65, 0, 1);
        //LODOP.ADD_PRINT_RECT(586, 529, 67, 65, 0, 1);
        //LODOP.ADD_PRINT_RECT(781, 529, 67, 65, 0, 1);
        LODOP.ADD_PRINT_TEXT(626, 544, 49, 25, "成分");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 11);
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
        LODOP.ADD_PRINT_TEXT(430, 543, 49, 25, "成分");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 11);
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
        LODOP.ADD_PRINT_TEXT(821, 544, 49, 25, "成分");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 11);
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
        LODOP.ADD_PRINT_TEXT(400, 545, 49, 25, "主料B");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 11);
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
        if (ml.length > 0) {
            LODOP.ADD_PRINT_TEXT(400, 604, 152, 25, ml[0].name);
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 11);
            LODOP.ADD_PRINT_TEXT(434, 605, 149, 20, ml[0].value);
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 7);
        };



        LODOP.ADD_PRINT_TEXT(792, 524, 69, 25, "特殊里布");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 11);
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
        LODOP.ADD_PRINT_TEXT(460, 534, 70, 25, "面料小样");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 11);
        LODOP.ADD_PRINT_TEXT(655, 533, 70, 25, "面料小样");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 11);
        LODOP.ADD_PRINT_TEXT(850, 533, 70, 25, "面料小样");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 11);
        //LODOP.ADD_PRINT_RECT(976, 529, 225, 26, 0, 1);
        //LODOP.ADD_PRINT_RECT(1001, 529, 225, 26, 0, 1);
        //LODOP.ADD_PRINT_RECT(1026, 529, 225, 26, 0, 1);
        //LODOP.ADD_PRINT_RECT(976, 529, 67, 101, 0, 1);
        LODOP.ADD_PRINT_TEXT(934, 524, 69, 25, "其他材料");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 11);
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
        LODOP.ADD_PRINT_IMAGE(293, 65, 436, 723, "<img src=http://192.168.0.72/FlexPLMAPI/GetFlexImage.aspx?DT=true&IMG=" + printData.designimagebig + "/>");//图片
        LODOP.SET_PRINT_STYLEA(0, "Stretch", 2);
        LODOP.SET_PRINT_STYLEA(0, "Stretch", 2); 
        LODOP.ADD_PRINT_BARCODE(24, 517, 195, 60, "128Auto", printData.productname);//条码


        LODOP.ADD_PRINT_TEXT(1038, 24, 61, 25, "打印人：");
        LODOP.ADD_PRINT_TEXT(1038, 84, 74, 25, $.cookie('m_UserNameC'));
        LODOP.ADD_PRINT_TEXT(1066, 23, 69, 25, "打印时间：");
        LODOP.ADD_PRINT_TEXT(1066, 91, 130, 25, formatdate);
        LODOP.ADD_PRINT_TEXT(1039, 231, 58, 25, "设计师：");
        LODOP.ADD_PRINT_TEXT(1039, 287, 100, 25, printData.designer);
        LODOP.ADD_PRINT_TEXT(1039, 417, 105, 25, "款式图交稿日期：");
        LODOP.ADD_PRINT_TEXT(1067, 410, 103, 25, "通过审稿确认：");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);


        LODOP.PREVIEW();    //浏览模式
        //LODOP.PRINT_DESIGN();//设计模式
        //-----------------Print End--------------------

    });
    






}

//材料关联窗口
function materialLink() {
    //图片地址
    var imgURL = "http://192.168.0.72/FlexPLMAPI/GetFlexImage.aspx?DT=true&IMG=";

    //data获取数据优先级：高--右键，低--选中行
    var data = rowData_Right;

    if (data == null) {
        //获取选中数据
        data = $("#tabList").datagrid('getSelected');
    };

    //data数据判断
    if (data == null) {
        $.messager.alert("提示", "请选中一行", "warning");
        return;
    };
    
    //图片赋值
    imgURL += data.designimagebig;
    //季节
    $("#season").val(data.orderseason);
    //设计号
    $("#code").val(data.designerid);
    //图片地址追加
    $("#linkShow img").attr("src", imgURL);
    //ProductName
    $("#prno").val("").val(data.productname);
    //Designer
    $("#dspe").val("").val(data.designer);
    //展现窗口
    $("#linkShow").window({
        title: '材料关联',
        collapsible: false, //折叠按钮
        minimizable: false, //最小窗口
        maximizable: false, //最大窗口
        closable: false,     //关闭窗口
        maximized: true     //最大话
    }).window('open');

    //初始化材料dg
    material_dg();
    //置空
    rowData_Right = null;
}

//材料关联列表
function material_dg() {
    //data获取数据优先级：高--右键，低--选中行
    var data = rowData_Right;

    if (data == null) {
        //获取选中数据
        data = $("#tabList").datagrid('getSelected');
    };

    var productName = data.productname;

    var XMLData = "<ROOT><OPTYPE>GetMaterial</OPTYPE><LIST><ROWS><ProductName>" + productName + "</ProductName><zt>" + m_zt + "</zt></ROWS></LIST></ROOT>";
    
    $("#material_list").datagrid({
        url: GetWSRRURL('39ad2a7c-bbd2-4c92-9a69-efc17708c898'),
        queryParams: { "XML": XMLData },
        fit: true,
        singleSelect: false,
        checkOnSelect: true,
        striped: true,
        columns: [[
            { field: 'ck', checkbox: true },
            { field: 'dfmfatname', title: '主面料标识', width: 80 },
            { field: 'dfitno', title: '物料编号', width: 120 },
            { field: 'mlstqt', title: '物料库存', width: 100 },
            { field: 'mmitds', title: '物料成分', width: 150 },
            { field: 'dfcrpe', title: '创建人', width: 60 },
            { field: 'dfcrdt', title: '创建时间', width: 100 }
        ]]
    });
}

//材料查询窗口
function winSearch(itgr) {

    //类型
    $("#itgr").val("").val(itgr);
    $("#itno").val("");

    $("#materialSearch").window({
        title: '材料查询',
        collapsible: false, //折叠按钮
        minimizable: false, //最小窗口
        maximizable: false, //最大窗口
        closable: false,     //关闭窗口
        width: 600,
        height: 550
    }).window('open');
    
    ClearGrid("#search_list");
    
    //dg
    search_dg();

}

//材料查询窗口关闭
function winSearchClose() {
    //类型
    $("#itgr").val("");
    $("#itno").val("");
    ClearGrid("#search_list");
    //关闭窗口
    $("#materialSearch").window('close');
}

//材料dg
function search_dg() {
    $("#search_list").datagrid({
        fit: true,
        singleSelect: true,
        columns: [[
            { field: 'ck', checkbox: true },
            { field: 'mmitno', title: '物料编号', width: 120 },
            { field: 'mlstqt', title: '物料库存', width: 80 },
            { field: 'mlwhsl', title: '物料储位', width: 80 },
            { field: 'mtacrf', title: '领料部门', width: 100 },
            { field: 'mtrgdt', title: '最后异动日期', width: 100 }
        ]],
        pagination: false, //是否开启分页
        pageNumber: 1, //默认索引页
        rownumbers: true
        //pageSize: 20,//默认一页数据条数
        //pageList: [20]   //固定每页行数
    });
}

//材料查询
function btnSearch() {

    //编号
    var itno = $("#itno").val();
    //物料类型
    var itgr = ""
    var $itgr = $("#itgr").val();
    if ($itgr == "面料" || $itgr == "里布") {
        itgr = "N002"
    }
    else {
        itgr = "N003" //辅料
    };

    var url = GetWSRRURL('39ad2a7c-bbd2-4c92-9a69-efc17708c898');
    var XMLData = "<ROOT><OPTYPE>SearchDg</OPTYPE><LIST><ROWS><ITGR>" + itgr + "</ITGR><ITNO>" + itno + "</ITNO><zt>" + m_zt + "</zt></ROWS></LIST></ROOT>";


    //验证空值
    if (itno == "") {
        $.messager.alert("提示", "请输入物料编号", "warning");
        return;
    };

    //进度条
    $.messager.progress();
    $.post(url, { "XML": XMLData }, function (data) {
        $.messager.progress('close');
        data = eval('('+data+')');
        $("#search_list").datagrid('loadData', data);
    });
    
}

//材料保存
function btnSave() {

    var data = $("#search_list").datagrid('getChecked');

    if (data.length == 0) {
        $.messager("提示", "请选择需要保存的物料", "warning");
        return;
    };

    //主面料标识
    var mfat = "";

    //物料类型
    var $itgr = $("#itgr").val();

    if ($itgr == "面料") {
        $.messager.confirm("提示", "请问是否选定为主面料?", function (r) {
            if (r) { mfat = "1"; Submit(data, mfat); } else { mfat = "2"; Submit(data, mfat);};
        });
    }
    else if ($itgr == "里布") {
        mfat = "3";
        Submit(data, mfat);
    }
    else if ($itgr == "辅料") {
        mfat = "4";
        Submit(data, mfat);
    };
}

function Submit(data, mfat) {

    //ProductName
    var prno = $("#prno").val();

    //Designer
    var dspe = $("#dspe").val();

    //XML
    var XMLData = "<ROOT><OPTYPE>materialSave</OPTYPE><LIST><ROWS><zt>" + m_zt + "</zt></ROWS>";

    XMLData += "<ROWS><DFPRID></DFPRID><DFPRNO>" + prno + "</DFPRNO><DFDSPE>" + dspe + "</DFDSPE>";
    XMLData += "<DFITNO>" + data[0].mmitno + "</DFITNO><DFCLID></DFCLID><DFSTQT>0</DFSTQT><DFREMK></DFREMK><DFSTAT>1</DFSTAT>";
    XMLData += "<DFMFAT>" + mfat + "</DFMFAT><DFCRDT></DFCRDT><DFCRPE></DFCRPE></ROWS></LIST></ROOT>";

    $.post(GetWSRRURL('39ad2a7c-bbd2-4c92-9a69-efc17708c898'), { "XML": XMLData }, function (result) {
        result = eval("[" + result + "]");

        try {
            if (result[0].Error) {
                $.messager.progress('close');

                $.messager.alert("系统错误", result[0].Error, 'error');
            } else if (result[0].rows[0].result == "False") {
                $.messager.progress('close');

                $.messager.alert("提示", result[0].rows[0].message, 'error');
                $("#materialSearch").window('close');
            }
            else {
                $("#material_list").datagrid('reload');
                $.messager.alert("提示", result[0].rows[0].message);
                $("#materialSearch").window('close');
            }
        } catch (ex) {
            $.messager.progress('close');
            $.messager.alert("提示", ex, 'error');
        };
    });
}

//删除材料
function delMaterial() {
    $.messager.confirm("操作提示", "您确定要删除该物料吗？", function (r) {
        if (r) {
            var data = $("#material_list").datagrid('getChecked');

            //空行验证
            if (data.length == 0) {
                $.messager("提示", "请选择要删除的行", "warning");
                return;
            };

            var XMLData = "<ROOT><OPTYPE>materialUpdate</OPTYPE><LIST><ROWS><zt>" + m_zt + "</zt></ROWS>";

            for (i = 0; i < data.length; i++) {
                XMLData += "<ROWS><DFRCID>" + data[i].dfrcid + "</DFRCID><DFSTAT>9</DFSTAT></ROWS>";
            };

            XMLData += "</LIST></ROOT>";

            $.post(GetWSRRURL('39ad2a7c-bbd2-4c92-9a69-efc17708c898'), { "XML": XMLData }, function (result) {
                result = eval("[" + result + "]");

                try {
                    if (result[0].Error) {
                        $.messager.progress('close');

                        $.messager.alert("系统错误", result[0].Error, 'error');
                    } else if (result[0].rows[0].result == "False") {
                        $.messager.progress('close');

                        $.messager.alert("提示", result[0].rows[0].message, 'error');
                        $("#materialSearch").window('close');
                    }
                    else {
                        $("#material_list").datagrid('reload');
                        $.messager.alert("提示", result[0].rows[0].message);
                    }
                } catch (ex) {
                    $.messager.progress('close');
                    $.messager.alert("提示", ex, 'error');
                };
            });
        };
    });
}
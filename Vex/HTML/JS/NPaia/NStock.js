//创建者:LeeGo
//WSID--F22: 1b4b1e63-da9f-40e2-a4f2-c4bdaa7ce16e
//WSID--NPaia: bb1d5a13-afd3-49d9-8891-219fe83b295a

var GV = {
    State: [{ "id": "20", "text": "启用" }, { "id": "90", "text": "禁用" }],
    DeopotCode: "",
    rowData: null
};

//初始化
$(document).ready(function () {
    //主页面按钮
    $("#btnNew").linkbutton({ iconCls: 'icon-add', plain: true }).click(function () {
        winOpen('new');
    });
    $("#btnEdit").linkbutton({ iconCls: 'icon-edit', plain: true }).click(function () {
        winOpen('edit');
    });
    $("#btnSearch").linkbutton({ iconCls: 'icon-search', plain: true }).click(mainSearch);

    //回车事件
    $("#DepotCode").keydown(function (e) {
        if (e.keyCode == 13) {
            //调用查询方法
            winSearch();
        }
    });

    //窗口按钮
    $("#winSave").linkbutton({ iconCls: 'icon-save', plain: true }).click(function (event) {
        event.stopPropagation();
        winSave();
    });
    $("#winClose").linkbutton({ iconCls: 'icon-undo', plain: true }).click(winClose);

    //初始dg
    initGrid("");
});

//初始话dg
function initGrid(where) {
    $('#tab_list').datagrid({
        url: GetWSRRURL('bb1d5a13-afd3-49d9-8891-219fe83b295a'),
        queryParams: { "XML": GetFormJson([], 'GetWarehouse'), "WHERE": where },
        title: '库存列表',
        width: '90%',
        singleSelect: true,
        striped: true,
        fit: true,
        columns: [[
            { field: 'wahs_id', hidden: true },
            { field: 'wahs_code', title: '店铺编号', width: 150 },
            { field: 'wahs_name', title: '店铺名称', width: 180 },
            { field: 'wahs_statename', title: '状态', width: 80 },
            { field: 'wahs_rgdt', title: '创建时间', width: 100, formatter: Formater.Date },
            { field: 'wahs_rguser', title: '创建人', width: 100 },
            { field: 'wahs_lmdt', title: '修改时间', width: 100, formatter: Formater.Date },
            { field: 'wahs_lmuser', title: '修改人', width: 100 }
        ]],
        pagination: true, //是否开启分页
        tpageNumber: 1, //默认索引页
        pageSize: 20, //默认一页数据条数
        onClickRow: function (rowIndex, rowData) {
            GV.rowData = rowData;
        }
    });
}

//初始化窗口
function winBeforeOpen(type) {

    //清空Input
    $("#formStock input[name='State']").val('');

    //状态配置
    $("#state").combobox({
        editable: false,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto'
    }).combobox('loadData', GV.State);

    //修改
    if (type == 'edit') {

        //检查
        if (GV.rowData == null) {
            $.messager.alert("提示", "请选中一行！", "warning");
            return;
        };

        //赋值
        $("#ID").val(GV.rowData.wahs_id);
        $("#DepotCode").val(GV.rowData.wahs_code).attr("readonly", "readonly");
        $("#depotName").val(GV.rowData.wahs_name);

        //状态
        $("#state").combobox('setValue', GV.rowData.wahs_state).combobox('setText',GV.rowData.wahs_statename);
        
    } else {
        var p_readonly = $("#DepotCode").attr("readonly");

        if (p_readonly != undefined) {
            $("#DepotCode").removeAttr("readonly");
        };
        
    };

    //窗口配置
    $("#winEdit").window({
        width: 600,
        height: 300,
        top: 60,
        title: '库存维护'
    }).window('open');
}

//打开窗口
function winOpen(type) {

    //新建维护
    if (type == 'new') {
        winBeforeOpen('new');
    }

    //修改维护
    if (type == 'edit') {
        winBeforeOpen('edit');
    };
};

//关闭窗口
function winClose() {
    //清空所有值
    $("#formStock input").val('');
    //关闭窗口
    $("#winEdit").window('close');

}

//查询方法(窗口)
function winSearch() {
    //查询条件
    var condition = $("#DepotCode").val();

    //判断
    if (condition == "") {
        $.messager.alert("提示", "请输入店铺编号", "warning");
        return;
    };

    //组建XML
    var XMLData = "<ROOT><OPTYPE>GetInventory</OPTYPE><LIST><Rows><Where>" + condition + "</Where></Rows></LIST></ROOT>";

    //查询提交
    $.post(GetWSRRURL('1b4b1e63-da9f-40e2-a4f2-c4bdaa7ce16e'), { "XML": XMLData }, function (data) {

        data = eval("[" + data + "]");
        //赋值
        var depotName = data[0].rows[0].message;

        if (data[0].rows[0].result == "True") {
            //赋值，保存时用作验证依据
            GV.DeopotCode = condition;

            //店铺名
            $("#formStock input[name=DepotName]").val(depotName);
        } else {
            $.messager.alert("提示", depotName, "error");
        };

    });
};

//查询方法(主页)
function mainSearch() {
    var code = $("#mainDpCode").val();
    var where = null;

    //检查空值
    if (code == "") {
        initGrid("");
        return;
    };

    //查询条件
    where = " WAHS_Code = '" + code + "'";

    //查询
    initGrid(where);
}

//保存方法
function winSave() {

    var data = $("#formStock").serializeArray();

    var sumbit = false;

    //验证
    if (data[1].value == "") {
        $.messager.alert("提示", "请输入店铺编号", "warning");
        return;
    };

    //新建时提交检查
    if (data[0].value == "") {

        //取值与保存的店铺编号是否一致
        if (data[1].value != GV.DeopotCode) {
            $.messager.alert("错误", "请检查店铺编号是否正确", "error");
            $("#DepotCode").val('').focus();
            return;
        };

        //检查数据库中是否存在款号
        var XMLCheck = "<ROOT><OPTYPE>CheckDepot</OPTYPE><LIST><Rows><DepotCode>" + data[1].value + "</DepotCode></Rows></LIST></ROOT>";

        //提交检查
        $.post(GetWSRRURL('bb1d5a13-afd3-49d9-8891-219fe83b295a'), { "XML": XMLCheck }, function (data) {

            data = eval("[" + data + "]");

            if (data[0].rows[0].result == "False") {
                $.messager.alert("提示", "店铺已存在，请检查", "warning");
                sumbit = false;
            } else {
                sumbit = true;
            };
        });
    };

    //保存数据
    var XMLData = "";

    if (data[0].value == "") {
        XMLData += "<ROOT><OPTYPE>AddWarehouse</OPTYPE><LIST><Rows><DepotCode>" + data[1].value + "</DepotCode><DepotName>" + data[2].value + "</DepotName><State>" + data[3].value + "</State>";
    }
    else {
        XMLData += "<ROOT><OPTYPE>EditWarehouse</OPTYPE><LIST><Rows><WAHS_ID>" + data[0].value + "</WAHS_ID><WAHS_State>" + data[3].value + "</WAHS_State>";
        //保证修改保存可以提交
        sumbit = true;
    };

    XMLData += "</Rows></LIST></ROOT>";

    //保存提交
    if (sumbit) {

        $.ajax({
            url: GetWSRRURL('bb1d5a13-afd3-49d9-8891-219fe83b295a'),
            data: { "XML": XMLData },
            type: "post",
            async: false,
            success: function (data) {
                var date = new Date()
                
                data = eval("[" + data + "]");
                //赋值
                var id = data[0].rows[0].message;

                if (data[0].rows[0].result == "True") {

                    $.messager.alert("提示", "保存成功", "ok");

                    $("#tab_list").datagrid('reload');
                    $("#ID").val('').val(id);
                    $("#DepotCode").attr("readyonly", "readyonly");


                    GV.rowData = null;
                    GV.DeopotCode = "";
                } else {
                    $.messager.alert("提示", "保存失败", "error");
                };
            }
        });
        //$.post(GetWSRRURL('bb1d5a13-afd3-49d9-8891-219fe83b295a'), { "XML": XMLData }, function (data) {

            
        //});
    };

}


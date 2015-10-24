//创建者:LeeGo
//WSID: 8501f40e-134f-4f6d-b604-b37705c986d1

var GV = new Object();
GV.tData = {
    state: [{ "id": "20", "text": "启用", "selected": true }, { "id": "90", "text": "禁用" }],
    rowData: null

};
GV.comb = {
    province: null
};

$(document).ready(function () {
    //主界面查询按钮
    $("#btnSearch").linkbutton({ iconCls: 'icon-search', plain: true })
                   .click(btnSearch);
    $("#btnMainClean").linkbutton({ iconCls: 'icon-undo', plain: true })
                   .click();

    //保存，关闭按钮
    $("#winSave").linkbutton({ iconCls: 'icon-save', plain: true })
                 .click(winSave);
    $("#winClose").linkbutton({ iconCls: 'icon-undo', plain: true })
                 .click(winClose);


    //主界面新增
    $("#btnNew").linkbutton({ iconCls: 'icon-add', plain: true })
                .click(function () { winInitialise('btnNew') });

    $("#btnEdit").linkbutton({ iconCls: 'icon-edit', plain: true })
                 .click(function () { winInitialise('btnEdit') });

    initGird("");

    //初始化市
    $("#mainCity").combobox({
        panelHeight:'10'
    });
    $("#txtDISP_ID_City").combobox({
        panelHeight: '10'
    });

    //加载数据
    //省
    $.post(GetComboxWSRRURL('a88077d9-9bb9-4f3f-9567-e7f913b3c667') + "&AreaType=" + escape("省份"), function (data) {

        GV.comb.province = eval('(' + data + ')');
        cityInitialise('main', GV.comb.province);
    });    
})

//主界面dg
function initGird(where) {
    $('#tab_list').datagrid({
        url: GetWSRRURL('8501f40e-134f-4f6d-b604-b37705c986d1'),
        queryParams: { "XML": GetFormJson([], 'GetDepot'), "WHERE": where },
        title: '店铺列表',
        width: '90%',
        singleSelect: true,
        striped: true,
        fit: true,
        columns: [[
            { field: 'dept_id', hidden: true },
            { field: 'dept_disp_id_province', title: '省', width: 100 },
            { field: 'dept_disp_id_city', title: '市', width: 100 },
            { field: 'dept_name', title: '店铺名', width: 180 },
            { field: 'dept_phone', title: '联系电话', width: 130 },
            { field: 'dept_statename', title: '状态', width: 60 },
            { field: 'dept_address', title: '详细地址', width: 550 }
        ]],
        pagination: true, //是否开启分页
        tpageNumber: 1, //默认索引页
        pageSize: 20, //默认一页数据条数
        onClickRow: function (rowIndex, rowData) {
            GV.tData.rowData = rowData;
        }
    });
}

//初始化窗口
function winInitialise(type) {
    //省市
    cityInitialise('win', GV.comb.province);
    //状态
    $("#txtState").combobox({
        data: GV.tData.state,
        editable: false,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto'
    });

    if (type == 'btnNew') {
        $("#formDepot :input").val('');
        $("#txtState").combobox('setValue', '20');
        //店铺名称解除只读属性
        $("#formDepot :input[name='txtDEPT_Name']")
            .attr("readonly", "readonly").removeAttr("readonly");
    } else {
        //是否选中
        if (GV.tData.rowData == null) {
            $("#formDepot :input").val(''); //form选择器
            $.messager.alert('提示', '请选中一行', 'warning');
            return;
            
        }
        //ID
        $("#winEdit form :input[name='txtDEPT_ID']").val(GV.tData.rowData.dept_id);
        //联系电话
        $("#formDepot :input[name='txtDEPT_Phone']").val(GV.tData.rowData.dept_phone);
        //详细地址
        $("#formDepot :input[name='txtDEPT_Address']").val(GV.tData.rowData.dept_address);
        //省
        $("#txtDISP_ID_Province").combobox('setValue', GV.tData.rowData.dept_disp_id_province);
        //市
        $("#txtDISP_ID_City").combobox('setValue', GV.tData.rowData.dept_disp_id_city);
        //状态
        $("#txtState").combobox('setValue', GV.tData.rowData.dept_state);


        //店铺名称
        $("#formDepot :input[name='txtDEPT_Name']")
            .val(GV.tData.rowData.dept_name)
            .attr("readonly", "readonly");
    };


    $("#winEdit").window({
        width: 600,
        height: 300,
        top: 60,
        //maximized: true,
        title: '店铺维护'
    }).window('open');
}

//初始化省市
function cityInitialise(type,data) {
    //省市
    var prov, city;

    if (type == 'main') {
        prov = $("#mainProvince");
        city = $("#mainCity");
    };

    if (type == 'win') {
        prov = $("#txtDISP_ID_Province");
        city = $("#txtDISP_ID_City");
    };

    prov.combobox({
        editable: false,
        valueField: 'text',
        textField: 'text',
        panelHeight:'200',
        onSelect: function (record) {
            var provText = record.text;
            $.post(GetComboxWSRRURL('a88077d9-9bb9-4f3f-9567-e7f913b3c667') + "&AreaType=" + escape("地级市") + "&Province=" + escape(provText), function (data) {
                data = eval('(' + data + ')');
                city.combobox({
                    editable: false,
                    valueField: 'text',
                    textField: 'text',
                    panelHeight: '200'
                }).combobox('loadData', data);
            })
        }
    }).combobox('loadData', data);
}

//关闭窗口
function winClose() {
    $("#formDepot :input").val(''); //form选择器
    $("#winEdit").window().window('close');
}

//保存方法
function winSave() {
    var id = $("#winEdit form :input[name='txtDEPT_ID']").val();   //找到winEdit下的form后代元素，然后取得form表单的input元素集，最后通过属性[name=‘txtID’]找到值。
    var data = $('#winEdit form').serializeArray();
    if (id == "") {     //新增
        var XMLData = GetFormJson(data, 'AddDepot');
    } else {        //修改
        var XMLData = GetFormJson(data, 'EditDepot');
    }

    $.ajax({
        url: GetWSRRURL('8501f40e-134f-4f6d-b604-b37705c986d1'),
        type: 'post',
        async: false, //同步,
        data: { "XML": XMLData },
        success: function (result) {
            try {
                var result = eval("[" + result + "]");
                if (result[0].Error) {
                    $.messager.progress('close');
                    $.messager.alert("系统错误", result[0].Error, 'error');
                }
                else if (result[0].rows[0].result == "False") {
                    $.messager.progress('close');
                    $.messager.alert("提示", result[0].rows[0].message, 'error');
                }
                else {
                    $.messager.alert("提示", result[0].rows[0].message, 'ok');
                    var id = result[0].rows[1].message
                    $("#winEdit form :input[name='txtDEPT_ID']").val("");
                    $("#winEdit form :input[name='txtDEPT_ID']").val(id);
                    $('#tab_list').datagrid('reload');
                };
            }
            catch (ex) {
                $.messager.progress('close');
                $.messager.alert("提示", ex, 'error');
            }
        },
        error: function () {
            $.messager.alert("提示", "提交错误了！", 'error');
        }
    });
}

//查询方法
function btnSearch() {
    var data = $('#mainForm').serializeArray();
    var where = "";
    //省
    var province = data[0].value;
    //市
    var city = data[1].value;
    //店铺名
    var deportName = data[2].value;

    if (province == "" && city == "" && deportName == "") {
        initGird("");
        return;
    };

    if (province != "" && where != "") {
        where += " AND [DEPT_DISP_ID_Province] = '" + province + "'";
    } else {
        where = " [DEPT_DISP_ID_Province] = '" + province + "'";
    };

    if (city != "" && where != "") {
        where += " AND [DEPT_DISP_ID_City] = '" + city + "'";
    } else {
        where = " [DEPT_DISP_ID_City] = '" + city + "'";
    };

    if (deportName != "" && where == "") {
        where = " [DEPT_Name] LIKE '%" + deportName + "%'";
    } else if (deportName != "" && where != "") {
        where += " AND [DEPT_Name] LIKE '%" + deportName + "%'";
    };
    initGird(where);
}
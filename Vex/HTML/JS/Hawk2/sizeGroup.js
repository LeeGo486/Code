/// JS名：sizeGroup.js
/// 说明：尺码号型维护
/// 创建人：刘洪
/// 创建日期：2014-11-08
/// WSID:09ff9c05-e23e-4d77-a82c-955dbfab0b04

var g_win = null;
var editIndex = undefined;
var g_combobox = [{ "id": "20", "text": "启用" }, { "id": "99", "text": "禁用" }]

$(document).ready(function () {
    g_win = $("#winNew").window({
        title: '尺码/尺码组维护',
        width: 600,
        height: 450,
        closed: true,
        minimizable: false,
        maximizable: false,
        draggable: false,   //窗口拖动
        collapsible: false, //折叠按钮
        closable: false    //关闭按钮
    });
    g_win.window('close');

    $("#groupNew").linkbutton({ iconCls: 'icon-add', plain: true }).click(function () { groupClick(); });
    $("#sizeNew").linkbutton({ iconCls: 'icon-add', plain: true }).click(function () { sizeClick(); });
    $("#search").linkbutton({ iconCls: 'icon-search', plain: true }).click(function () { search(); });
    $("#clean").linkbutton({ iconCls: 'icon-undo', plain: true }).click(function () { clean(); });
    $("#editGroup").linkbutton({ iconCls: 'icon-edit', plain: true }).click(function () { eidtGroup(); });
    $("#editSize").linkbutton({ iconCls: 'icon-edit', plain: true }).click(function () { editSize(); });


    //var a = $(window).height();
    //var b = $(window).width();

    //$('dg').css('height', a).css('width',b);

    initDg(GetGetJson([]));

});

//初始化dg
function initDg(xml) {
    $('#tab_list').datagrid({
        url: GetWSRRURL('09ff9c05-e23e-4d77-a82c-955dbfab0b04'),
        queryParams: { "XML": xml },
        //title: '尺码列表',
        width: '70%',
        heigth: '100%',
        singleSelect: true,
        fit: true,
        sortName: 'lmdt',
        sortOrder: 'desc',
        striped: true,
        columns: [[
            { field: 'groupid', hidden: true },
            { field: 'sizeid', hidden: true },
            { field: 'groupcode', title: '尺码组编号', width: 100 },
            { field: 'groupname', title: '尺码组名称', width: 100 },
            { field: 'sizeov', title: '尺码编号', width: 100 },
            { field: 'sizeo', title: '尺码名称', width: 100 },
            { field: 'sizecode', title: '号型编号', width: 100 },
            { field: 'sizename', title: '号型名称', width: 100 },
            { field: 'groupstate', title: '尺码组状态', width: 100 },
            { field: 'state', title: '尺码状态', width: 100 }
        ]],
        onClickRow: function (index, row) {
            if (row.groupstate == '99') {
                $("#sizeNew").hide();
                $("#editSize").hide();
            }
            else {
                $("#sizeNew").show();
                $("#editSize").show();
            };
        },
        pagination: true, //是否开启分页
        pageNumber: 1, //默认索引页
        pageSize: 20 //默认一页数据条数
    });
}

//主界面查询
function search() {
    var sizeGroup = $("#sizeGroup").val();
    var size = $("#size").val();
    var ov = $("#ov").val();

    var XMLData = "<ROOT><OPTYPE>Search</OPTYPE><LIST><ROWS><Group>" + sizeGroup + "</Group><Size>" + size + "</Size><ov>" + ov + "</ov></ROWS></LIST></ROOT>";

    initDg(XMLData);
}

//主界面清空
function clean() {
    $("#main input").val("");
}

//新建尺码组
function groupClick() {

    var html = "<fieldset><legend style=\"color:#009933\">尺码组</legend><div><input type=\"hidden\" id=\"CTID\"/><span>尺码组编号</span><input id=\"keyID\" /><span>尺码组名称</span><input id=\"KeyName\" /><span>状态</span>";
    html += "<select id = \"State\"><option value=\"20\">启用</option><option value=\"99\">禁用</option></select>";
    html += "</div></fieldset><br /><div style=\"margin-top:10px;\"><a id=\"save\" onclick=\"saveGroup('new')\">保存</a><a id = \"close\" onclick=\"winClose()\">关闭</a><div>";
    $("#winNew").html("");
    $("#winNew").html(html);

    $("#save").linkbutton({ iconCls: 'icon-save', plain: true });
    $("#close").linkbutton({ iconCls: 'icon-undo', plain: true });
    g_win.window('open');
}

//修改尺码组
function eidtGroup() {
    var data = $("#tab_list").datagrid("getSelected");

    //验证空
    if (data == null) {
        $.messager.alert("提示", "请选择一行", "warning");
        return;
    };

    var html = "<fieldset><legend style=\"color:#009933\">尺码组</legend><div><input type=\"hidden\" id=\"CTID\"/><span >尺码组编号:&nbsp;&nbsp;<span style=\"color:#FFCC00\">" + data.groupcode;
    html += "</span></span>&nbsp;&nbsp;<span>尺码组名称:&nbsp;&nbsp;</span><input id=\"KeyName\" /><span>&nbsp;&nbsp;状态:&nbsp;&nbsp;</span>";
    html += "<select id = \"State\"><option value=\"20\">启用</option><option value=\"99\">禁用</option></select>";
    html += "</div></fieldset><br /><div style=\"margin-top:10px;\"><a id=\"save\" onclick=\"\">保存</a><a id=\"close\" onclick=\"winClose()\">关闭</a><div>";

    $("#winNew").html("");
    $("#winNew").html(html);

    $("#save").linkbutton({ iconCls: 'icon-save', plain: true }).click(function () { saveGroup('edit') });
    $("#close").linkbutton({ iconCls: 'icon-undo', plain: true }).click(function () { winClose() });

    //赋值
    $("#CTID").val(data.groupid);
    $("#KeyName").val(data.groupname);
    $("#State").val(data.state);
    g_win.window('open');

}

//尺码dg
function sizedg(url, data) {
    $('#size_list').datagrid({
        url: url,
        queryParams: data,
        width: '90%',
        height: '100%',
        singleSelect: true,
        fit: true,
        sortName: 'lmdt',
        sortOrder: 'desc',
        striped: true,
        columns: [[
            { field: 'sizeov', title: '尺码编号', width: 100, editor: { type: 'validatebox', options: { required: true } } },
            { field: 'sizeo', title: '尺码名称', width: 100, editor: { type: 'validatebox', options: { required: true } } },
            { field: 'sizecode', title: '号型编号', width: 100, editor: { type: 'validatebox', options: { required: true } } },
            { field: 'sizename', title: '号型名称', width: 100, editor: { type: 'validatebox', options: { required: true } } },
            { field: 'state', title: '状态', width: 100 }
        ]],
        toolbar: [{
            text: '新增',
            iconCls: 'icon-add',
            handler: function () { append(); }
        }, {
            text: '删除',
            iconCls: 'icon-remove',
            handler: function () { removeit(); }
        }, '-', {
            text: '保存',
            iconCls: 'icon-save',
            handler: function () { saveSize('new') }
        }, {
            text: '关闭',
            iconCls: 'icon-undo',
            handler: function () { winClose(); }
        }],
        onClickRow: function (index, row) {
            onClickRow(index);
        }
    });
    if (url != "") {
        $('#size_list').datagrid({
            columns: [[
                { field: 'sizeov', title: '尺码编号', width: 100 },
                { field: 'sizeo', title: '尺码名称', width: 100 },
                { field: 'sizecode', title: '号型编号', width: 100, editor: { type: 'validatebox', options: { required: true } } },
                { field: 'sizename', title: '号型名称', width: 100, editor: { type: 'validatebox', options: { required: true } } },
                {
                    field: 'state', title: '状态', width: 100,
                    editor:
                        {
                            type: 'combobox',
                            options:
                                {
                                    panelHeight: 'auto',
                                    editable: false,
                                    required: true,
                                    valueField: 'id',
                                    textField: 'text',
                                    data: g_combobox
                                }
                        }
                }
            ]],
            toolbar: [{
                text: '保存',
                iconCls: 'icon-add',
                handler: function () { saveSize('edit') }
            }, {
                text: '关闭',
                iconCls: 'icon-undo',
                handler: function () { winClose(); }
            }],
        })
    }
}

//新建尺码
function sizeClick() {
    var data = $("#tab_list").datagrid("getSelected");

    //验证空
    if (data == null) {
        $.messager.alert("提示", "请选择一行", "warning");
        return;
    };
    //验证尺码组状态
    if (data.groupstate != 20) {
        $.messager.alert("错误", "尺码组状态非20", "error");
        return;
    };

    var html = "<fieldset><legend style=\"color:#009933\">尺码组</legend><div><input type=\"hidden\" id=\"CTID\"/><span >尺码组编号:&nbsp;&nbsp;<span style=\"color:#FFCC00\">" + data.groupcode;
    html += "</span></span>&nbsp;&nbsp;<span>尺码组名称:&nbsp;&nbsp;</span><span style=\"color:#FFCC00\">" + data.groupname;
    html += "</span><span>&nbsp;&nbsp;状态:&nbsp;&nbsp;</span><span style=\"color:#FFCC00\">" + data.groupstate + "</span></div></fieldset>";
    html += "<table id=\"size_list\"></table>";
    html += "<br /><a id=\"save\">保存</a><a id=\"close\">关闭</a></div>";
    //<fieldset style=\"margin-top:5px;\"></fieldset>
    $("#winNew").html("");
    $("#winNew").html(html);

    $("#close").linkbutton({ iconCls: 'icon-undo', plain: true }).click(function () { winClose() });
    $("#save").linkbutton({ iconCls: 'icon-save', plain: true });
    //赋值
    $("#CTID").val(data.groupid);
    $("#KeyName").val(data.groupname);
    $("#State").val(data.state);

    //初始化dg
    sizedg("", "");

    g_win.window('open');
}

//修改尺码
function editSize() {
    var data = $("#tab_list").datagrid("getSelected");

    //验证空
    if (data == null) {
        $.messager.alert("提示", "请选择一行", "warning");
        return;
    };

    var html = "<fieldset><legend style=\"color:#009933\">尺码组</legend><div><input type=\"hidden\" id=\"CTID\"/><span >尺码组编号:&nbsp;&nbsp;<span style=\"color:#FFCC00\">" + data.groupcode;
    html += "</span></span>&nbsp;&nbsp;<span>尺码组名称:&nbsp;&nbsp;</span><span style=\"color:#FFCC00\">" + data.groupname;
    html += "</span><span>&nbsp;&nbsp;状态:&nbsp;&nbsp;</span><span style=\"color:#FFCC00\">" + data.groupstate + "</span></div></fieldset>";
    html += "<table id=\"size_list\"></table>";
    html += "<br /><a id=\"save\">保存</a><a id=\"close\">关闭</a></div>";
    //<fieldset style=\"margin-top:5px;\"></fieldset>
    $("#winNew").html("");
    $("#winNew").html(html);

    $("#close").linkbutton({ iconCls: 'icon-undo', plain: true }).click(function () { winClose() });
    $("#save").linkbutton({ iconCls: 'icon-save', plain: true });
    //赋值
    $("#CTID").val(data.groupid);
    $("#KeyName").val(data.groupname);
    $("#State").val(data.state);

    //初始化dg

    var XMLData = "<ROOT><OPTYPE>sizeList</OPTYPE><LIST><ROWS><fatherid>" + data.groupid + "</fatherid></ROWS></LIST></ROOT>";

    sizedg(GetWSRRURL('09ff9c05-e23e-4d77-a82c-955dbfab0b04'), { "XML": XMLData });

    g_win.window('open');

}

//尺码数据(beforeSumbit)
function saveSize(type) {

    var groupData = $("#tab_list").datagrid("getSelected");

    var fatherid = groupData.groupid;

    var sizeData = [];

    //取出尺码数据
    if (endEditing()) {
        if (type == 'new') {
            sizeData = $("#size_list").datagrid("getChanges", "inserted");
        } else {
            sizeData = $("#size_list").datagrid("getChanges", "updated");
        };
    }
    else {
        return;
    };

    //判断空行
    if (sizeData.length == 0 && type == 'new') {
        $.messager.alert("提示", "未添加任何行", "warning");
        return;
    }
    else if (sizeData.length == 0 && type == 'edit') {
        $.messager.alert("提示", "未修改任何行", "warning");
        return;
    }


    var XMLData = "<ROOT><OPTYPE>saveSize</OPTYPE><LIST>";

    if (type == "new") {
        for (i = 0; i < sizeData.length; i++) {
            XMLData += "<ROWS>";

            XMLData += "<CT1_ID></CT1_ID><CT1_CONO>HYFG</CT1_CONO><CT1_DIVI>LX</CT1_DIVI><CT1_Code>SIDE</CT1_Code><CT1_CodeName>尺码</CT1_CodeName>";
            XMLData += "<CT1_KeyID>" + sizeData[i].sizecode + "</CT1_KeyID><CT1_KeyName>" + sizeData[i].sizename + "</CT1_KeyName>";
            XMLData += "<CT1_OptionsValues>" + sizeData[i].sizeov + "</CT1_OptionsValues><CT1_Options>" + sizeData[i].sizeo + "</CT1_Options>";
            XMLData += "<CT1_State>" + sizeData[i].state + "</CT1_State><CT1_FatherID>" + fatherid + "</CT1_FatherID><CT1_RgDt></CT1_RgDt><CT1_RgUser></CT1_RgUser>";
            XMLData += "<CT1_LmUser></CT1_LmUser><CT1_LmDt></CT1_LmDt><CT1_UptNo>0</CT1_UptNo>";

            XMLData += "</ROWS>";
        };
    }
    else {
        for (i = 0; i < sizeData.length; i++) {
            XMLData += "<ROWS>";

            XMLData += "<CT1_ID>" + sizeData[i].ct1_id + "</CT1_ID>";
            XMLData += "<CT1_KeyID>" + sizeData[i].sizecode + "</CT1_KeyID><CT1_KeyName>" + sizeData[i].sizename + "</CT1_KeyName>";
            XMLData += "<CT1_State>" + sizeData[i].state + "</CT1_State>";
            XMLData += "<CT1_LmUser></CT1_LmUser><CT1_LmDt></CT1_LmDt><CT1_UptNo>0</CT1_UptNo>";

            XMLData += "</ROWS>";
        };
    };

    XMLData += "</LIST></ROOT>";

    //提交
    submit(XMLData);

}

//尺码组数据（beforeSumbit）
function saveGroup(type) {

    var $CT1_ID = $("#CTID").val();
    var $keyID = $("#keyID").val();
    var $keyName = $("#KeyName").val();
    var $state = $("#State").val();
    //验证
    if ($keyID == "" && $keyName == "") {
        $.messager.alert("提示", "请将信息填写完整!", "warning");
        return;
    };

    var XMLData = "<ROOT><OPTYPE>SaveGroup</OPTYPE>";
    if (type == "new") {
        XMLData += "<LIST><ROWS><CT1_ID>" + $CT1_ID + "</CT1_ID><CT1_CONO>HYFG</CT1_CONO><CT1_DIVI>LX</CT1_DIVI>";
        XMLData += "<CT1_Code>SDGP</CT1_Code><CT1_CodeName>尺码组</CT1_CodeName>";
        XMLData += "<CT1_KeyID>" + $keyID + "</CT1_KeyID><CT1_KeyName>" + $keyName + "</CT1_KeyName>";
        XMLData += "<CT1_OptionsValues>" + $keyID + "</CT1_OptionsValues><CT1_Options>" + $keyName + "</CT1_Options>";
        XMLData += "<CT1_State>" + $state + "</CT1_State><CT1_RgDt></CT1_RgDt><CT1_RgUser></CT1_RgUser>";
        XMLData += "<CT1_LmDt></CT1_LmDt><CT1_LmUser></CT1_LmUser><CT1_UptNo>0</CT1_UptNo></ROWS></LIST></ROOT>";
    }
    else {
        XMLData += "<LIST><ROWS><CT1_ID>" + $CT1_ID + "</CT1_ID>";
        XMLData += "<CT1_KeyName>" + $keyName + "</CT1_KeyName>";
        XMLData += "<CT1_Options>" + $keyName + "</CT1_Options>";
        XMLData += "<CT1_State>" + $state + "</CT1_State><CT1_LmDt></CT1_LmDt><CT1_LmUser></CT1_LmUser><CT1_UptNo>1</CT1_UptNo></ROWS></LIST></ROOT>";
    }
    //提交
    submit(XMLData);
}

//提交
function submit(xml) {
    var url = GetWSRRURL('09ff9c05-e23e-4d77-a82c-955dbfab0b04');
    $.post(url, { "XML": xml }, function (result) {
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
                $("#tab_list").datagrid("reload");
                $("#winNew").window("close");
            };
        }
        catch (ex) {
            $.messager.progress('close');
            $.messager.alert("提示", ex, 'error');
        };
    });
}

//------DataGrid操作--------

//结束编辑
function endEditing() {
    if (editIndex == undefined) { return true };
    if ($('#size_list').datagrid('validateRow', editIndex)) {
        //var ed = $('#size_list').datagrid('getEditor', { index: editIndex, field: 'productid' });
        //var productname = $(ed.target).combobox('getText');
        //$('#size_list').datagrid('getRows')[editIndex]['productname'] = productname;
        $('#size_list').datagrid('endEdit', editIndex);
        editIndex = undefined;
        return true;
    } else {
        return false;
    }
}

//新增一行
function append() {
    if (endEditing()) {
        $('#size_list').datagrid('appendRow', {});
        editIndex = $('#size_list').datagrid('getRows').length - 1;
        $('#size_list').datagrid('selectRow', editIndex)
                       .datagrid('updateRow', {
                           index: editIndex,
                           row: { 'state': '20' }
                       })
                       .datagrid('beginEdit', editIndex);
    };
}

//删除一行
function removeit() {
    if (editIndex == undefined) { return };
    $('#size_list').datagrid('cancelEdit', editIndex)
            .datagrid('deleteRow', editIndex);
    editIndex = undefined;
}

//单击一行
function onClickRow(index) {
    if (editIndex != index) {
        if (endEditing()) {
            $('#size_list').datagrid('selectRow', index)
                    .datagrid('beginEdit', index);
            editIndex = index;
        } else {
            $('#size_list').datagrid('selectRow', editIndex);
        }
    }
}

//修改
function getChanges() {
    var rows = $('#size_list').datagrid('getChanges');
    alert(rows.length + ' rows are changed!');
}

//---------------------------


//关闭窗口
function winClose() {
    $("#winNew").window("close");
}


//WSID:GetWSRRURL('94032146-87d3-47c3-b6da-93423349a73f'),

$().ready(function () {
    
    initParts("main");
    initWin("close");
    initGrid("");
    
})
//初始化
function initParts(type) {
    if (type == "main") {
        $("#upload").linkbutton({ iconCls: 'icon-add', plain: true });
        upFiles();//上传
        $("#search").linkbutton({ iconCls: 'icon-search', plain: true }).click(search);
        $("#reset").linkbutton({ iconCls: 'icon-undo', plain: true }).click(function () { reset("main") });
        $("#new").linkbutton({ iconCls: 'icon-add', plain: true }).click(crtEmp);
        $("#delete").linkbutton({ iconCls: 'icon-cancel', plain: true }).click(delEmp);


        $("#year").combobox({
            url: GetComboxWSRRURL('94032146-87d3-47c3-b6da-93423349a73f') + "&XML=" + GetFormJson([], "GetYear"),
            type: 'post',
            editable: false,
            valueField: 'id',
            textField: 'text',
            panelHeight: 'auto'
        });

        $("#month").combobox({
            url: GetComboxWSRRURL('94032146-87d3-47c3-b6da-93423349a73f') + "&XML=" + GetFormJson([], "GetMonth"),
            type: 'post',
            editable: false,
            valueField: 'id',
            textField: 'text',
            panelHeight: 'auto'
        });
    }
    else {

        $("#sumbit").linkbutton({ iconCls: 'icon-ok', plain: true }).click(saveEmp);
        $("#resetWin").linkbutton({ iconCls: 'icon-undo', plain: true }).click(function () { reset("win") });

        $("#winForm input[name=txtEmployeeNo]").numberbox(); 
        $("#winForm input[name=txtBirthday]").numberbox();
        $("#winForm input[name=txtCredits]").numberbox({value:100});

        $("#winYear").combobox({
            url: GetComboxWSRRURL('94032146-87d3-47c3-b6da-93423349a73f') + "&XML=" + GetFormJson([], "GetYear"),
            type: 'post',
            editable: false,
            valueField: 'id',
            textField: 'text',
            panelHeight: 'auto'
        });

        $("#winMonth").combobox({
            url: GetComboxWSRRURL('94032146-87d3-47c3-b6da-93423349a73f') + "&XML=" + GetFormJson([], "GetMonth"),
            type: 'post',
            editable: false,
            valueField: 'id',
            textField: 'text',
            panelHeight: 'auto'
        });
    }
}
function initGrid(url) {
    $("#tab_list").datagrid({
        title: "主表",
        url: url,
        height: $(document).height() * 0.87,
        singleSelect: true,
        striped: true,
        singleSelect: true, //单行选择
        pagination: true, //是否开启分页
        pageSize: 20, //默认一页数据条数 
        rownumbers: true,//行号
        columns: [[
            { field: 'ck', checkbox: true },
            { field: 'year', title: '年份', width: 80 },
            { field: 'month', title: '月份', width: 80 },
            { field: 'employeeno', title: '员工号', width: 100 },
            { field: 'employeename', title: '姓名', width: 100 },
            { field: 'employeeid', title: '员工身份证号', width: 200 },
            { field: 'credits', title: '初始积分', width: 100 },
            { field: 'unusedcredits', title: '未用积分', width: 100 },
            { field: 'usecredits', title: '已用积分', width: 100 },
            { field: 'status', title: '状态', width: 100 },
            { field: 'createdate', title: '导入时间', width: 120 }
        ]]
    });
}
function initWin(type) {
    $("#window").window({
        title:"新建窗口",
        width: 450,
        height: 400,
        modal: true,
        minimizable: false,
        maximizable: false,
        resizable:false,
        draggable:false,
        collapsible: false
    });

    if (type == 'open') {
        $("#window").window("open");
    } else {
        $("#window").window("close");
    }
}
//文件上传的方法
function upFiles() {
    //文件上传相关-----------------
    var btnUpExcel = $('#upload'), interval;

    new AjaxUpload(btnUpExcel, {
        action: '/Handler_HZY_Present.ashx?filePath=Present&ExcelImport=true',
        data: { "WSID": "94032146-87d3-47c3-b6da-93423349a73f", "XML": GetGetJson('', 'Excel') },
        name: 'myfile',
        onSubmit: function (file, ext) {
            $.messager.progress({ title: '请稍后', msg: '上传中' });
            if (!(ext && /^(xls|xlsx)$/.test(ext))) {
                alert('文件格式不正确,请选择 xls,xlsx 格式的文件!', '系统提示');
                return false;
            };
            this.disable();
        },
        onComplete: function (file, response) {
            this.enable();

            var k = response.replace(/<pre.*>{/, "{").replace("</pre>", "").replace(/"<PRE.*>/, "").replace("</PRE>\"", "");

            try {
                var result = eval("[" + k + "]");
                if (result[0].Error) {
                    $.messager.progress('close');

                    $.messager.alert("系统错误", result[0].Error, 'error');
                }
                else if (result[0].rows[0].result == "False") {
                    var errormessage = result[0].rows[1].message;

                    $.messager.progress('close');

                    alert(result[0].rows[0].message + '\r' + errormessage);
                }
                else {
                    $.messager.progress('close');
                    $("#year").combobox({
                        url: GetComboxWSRRURL('94032146-87d3-47c3-b6da-93423349a73f') + "&XML=" + GetFormJson([], "GetYear"),
                        type: 'post',
                        editable: false,
                        valueField: 'id',
                        textField: 'text',
                        panelHeight: 'auto'
                    });

                    $("#month").combobox({
                        url: GetComboxWSRRURL('94032146-87d3-47c3-b6da-93423349a73f') + "&XML=" + GetFormJson([], "GetMonth"),
                        type: 'post',
                        editable: false,
                        valueField: 'id',
                        textField: 'text',
                        panelHeight: 'auto'
                    });
                    alert(result[0].rows[0].message);
                }
            } catch (ex) {
                $.messager.progress('close');

                $.messager.alert("提示", ex, 'error');
            }

        }
    });
    //文件上传相关-----------------
}
//查询
function search() {
    var data = $("#mainForm").serializeArray();

    if (data[0].value == "" && data[1].value == "" && data[2].value == "") {
        $.messager.alert('警告', '请输入查询条件!');
        return;
    };

    var url = GetWSRRURL('94032146-87d3-47c3-b6da-93423349a73f') + "&XML=" + GetFormJson(data, "GetSearch");

    initGrid(url);
}
//清空
function reset(type) {
    if (type == "main") {
        $("#mainForm input").val("");
    } else {
        $("#winForm input").val("");
        $("#winForm input[name=txtEmployeeName]").focus();
    };
}
//新增
function crtEmp() {
    reset("win");
    initParts("win");
    initWin("open");
}
//删除
function delEmp() {
    var data = $("#tab_list").datagrid("getChecked");
    if (data.length == 0) {
        $.messager.alert("错误", "请选择要删除的行！");
        return;
    };
    var XMLData = GetEditJsonbyType(data, "DelEmp");
    $.messager.confirm('提示框', '确认提交？', function (r) {
        if (r) {
            sumbit(XMLData);
        };
    });
}
//保存
function saveEmp() {
    var data = $("#winForm").serializeArray();

    var count = data.length;
    for (i = 0; i < count; i++) {
        if (data[i].value == "") {
            $.messager.alert("错误", "请将员工信息填写完整");
            return;
        };
    };

    var XMLdata = GetFormJson(data, "SaveEmp");
    XMLdata = escape(XMLdata);
    XMLdata = XMLdata.replace(/\%3C/g, "<").replace(/\%3E/g, ">");

    sumbit(XMLdata);
}
//Ajax提交
function sumbit(XMLdata) {
    $.post(GetWSRRURL('94032146-87d3-47c3-b6da-93423349a73f') + "&XML=" + XMLdata, function (result) {
        try {
            var result = eval("[" + result + "]");
            if (result[0].Error) {
                $.messager.progress('close');

                $.messager.alert("系统错误", result[0].Error, 'error');
            }
            else if (result[0].rows[0].result == "False") {
                var errormessage = result[0].rows[1].message;

                $.messager.progress('close');

                alert(result[0].rows[0].message);
            }
            else {
                $.messager.progress('close');
                $.messager.alert("提示", result[0].rows[0].message, "ok");
                $("#tab_list").datagrid("reload");
                initWin("close");
            }
        } catch (ex) {
            $.messager.progress('close');
            $.messager.alert("提示", ex, 'error');
        };
    });
}

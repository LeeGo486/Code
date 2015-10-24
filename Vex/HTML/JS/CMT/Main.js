// 名称：Main.js
// 说明：对MainHTML进行各种前台控制
// 创建人：刘洪
// 创建日期：2014-07-04
// 修改人：郭琦琦
// 修改日期：2014-09-26
// 修改内容：1e658718-4466-4cf9-99d9-f2f7e88b9aec

//导入方式数组
var dataCombox = [{
    "id": 1,
    "text": "EXCEL导入"
}, {
    "id": 2,
    "text": "CRM导入"
}, {
    "id": 3,
    "text": "DAT导入"
}];

//任务单状态
var dataStatus = [{
    "id": "未审核",
    "text": "未审核"
}, {
    "id": "进行中",
    "text": "进行中"
}];

//任务ID
var m_JobID = undefined;
//公司ID
var m_CompanyID = undefined;
//用户ID
var m_UserId = undefined;

$(document).ready(function () {
    //格式化日期样式:yyyy-mm-dd
    $.fn.datebox.defaults.formatter = function (date) {
        var y = date.getFullYear();
        var m = date.getMonth() + 1;
        var d = date.getDate();
        return y + '-' + m + '-' + d;
    };

    //初始化各类按钮,控件

    //下拉框
    $('#MainState').combobox({ panelHeight: 'auto', editable: false });
    $('#winJobType').combobox({ panelHeight: 'auto', editable: false });
    $('#winInType').combobox({ panelHeight: 'auto', editable: false });
    $('#winDeliver').combobox({ panelHeight: 'auto', editable: false });

    $('#MainState').combobox({
        data: dataStatus,
        valueField: 'id',
        textField: 'text'
    });

    //日期
    $('#MainStart').datebox();
    $('#MainEnd').datebox();
    $('#winStart').datebox({ 'disabled':true });
    $('#winEnd').datebox({ 'disabled': true });

    //按钮
    $('#MainSearch').linkbutton({ iconCls: 'icon-search',plain:true});
    $('#MainCancel').linkbutton({ iconCls: 'icon-undo', plain: true });
    $('#MainNew').linkbutton({ iconCls: 'icon-add', plain: true });
    $('#MainPublish').linkbutton({ iconCls: 'icon-ok', plain: true });
    $('#winSave').linkbutton({ iconCls: 'icon-save', plain: true });
    $('#winCancel').linkbutton({ iconCls: 'icon-undo', plain: true });
    $('#mainAnalyse1').linkbutton({ iconCls: 'icon-edit', plain: true });
    $('#mainAnalyse2').linkbutton({ iconCls: 'icon-edit', plain: true });
    $('#mainAnalyse3').linkbutton({ iconCls: 'icon-edit', plain: true });
    $('#MainCloseTake').linkbutton({ iconCls: 'icon-stop', plain: true }).click(stopTask);
    //$('#MainUpPower').linkbutton({ iconCls: 'icon-reload', plain: true }).click();
    $('#winNum').validatebox({ required: true });//批次号

    //获取用户ID
    htmlobj = $.ajax({
        url: GetWSRRURL('LoginName'),
        options: "JSON",
        async: false
    });
    var result = $.parseJSON(htmlobj.responseText);
    if (result.UserName != "") {
        m_UserId = result.UserName;
    };

    //新建任务单Window
    $('#winCreate').window({
        title: '新建任务',
        top: 10,
        width: 600,
        height: 450,
        modal: true
    }).window('close');

    //锁定导入方式与日期
    $('#winNum').attr("disabled", true);
    $('#winUP').attr('disabled', true);
    $('#winStart').attr("disabled", true);
    $('#winEnd').attr("disabled", true);

    //活动类型
    $('#MainType').combobox({
        url: GetComboxALLColumnWSRRURL('1e658718-4466-4cf9-99d9-f2f7e88b9aec', "", "ID", "Name") + "&XML=" + GetFormJson([], 'TaskType'),
        required: false,
        type: 'post',
        editable: false,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto'
    });
    
    //上传初始化
    UpFiles();

    //获取公司,并控制按钮权限
    getCompany();

    //初始化
    data = [];
    data[data.length] = { "name": "txtID", "value": m_UserId };
    XMLData = GetFormJson(data, 'Get');
    initGird(XMLData);
});

//初始化initGird
function initGird(XMLData) {

    $('#mainTab_List').datagrid({
        url: GetWSRRURL('1e658718-4466-4cf9-99d9-f2f7e88b9aec'),
        queryParams: { "XML": XMLData },
        width: '90%',
        singleSelect: true,
        fit: true,
        sortName: 'rgdt',
        sortOrder: 'desc',
        striped: true,
        columns: [[
            { field: 'TaskType', title: '任务类型', width: 75 },
            { field: 'jobname', title: '任务名称', width: 200 },
            { field: 'customernum', title: '预约人数', width: 70, align: 'right', formatter: Formater.Num },
            { field: 'bespeaknum', title: '已预约人数', width: 70, align: 'right', formatter: Formater.Num },
            { field: 'validatefrom', title: '开始时间', width: 80 },
            { field: 'validateto', title: '结束时间', width: 80 },
            { field: 'validatestate', title: '状态', width: 60 },
            { field: 'desp', title: '任务描述', width: 450 },
            { field: 'rguser', title: '创建人', width: 60 },
            { field: 'rgdt', title: '创建时间', width: 80 }
        ]],
        pagination: true, //是否开启分页
        pageNumber: 1, //默认索引页
        pageSize: 20, //默认一页数据条数
        onClickRow: function (rowIndex, rowData) {
            var status = rowData.validatestate; //状态

            m_JobID = rowData.tk1_id;   //任务ID

            if (status == "未审核" && m_CompanyID == "") {
                $('#MainPublish').linkbutton('enable');
            } else {
                $('#MainPublish').linkbutton('disable');
            }; 
        }
    });
};

//新建任务窗口方法
function OpenWindow() {

    //任务名称
    $('#winJobName').validatebox({ required: true });

    //导入方式
    $('#winInType').combobox({
        data: dataCombox,
        required: true,
        valueField: 'id',
        textField: 'text',
        onSelect: function (rec) {
            if (rec.id == '1') {    //excel
                //上传按钮
                $('#winUP').removeAttr("disabled");

                //批次号
                $('#winNum').attr("disabled", true);
                $('#winNum').validatebox({ required: true });
                $('#winRoute').validatebox({ required: true });

                //开始结束时间
                $('#winStart').datebox('setValue', '');
                $('#winEnd').datebox('setValue', '');
                $('#winStart').datebox({ 'disabled': false, required: true });
                $('#winEnd').datebox({ 'disabled': false, required: true });
            } else {
                //按钮
                $('#winUP').attr('disabled', true);

                //批次号
                $('#winNum').removeAttr("disabled");
                $('#winNum').validatebox({ required: true });
                $('#winNum').focus();

                $('#winRoute').validatebox({ required: false });

                //开始结束时间
                $('#winStart').datebox({ 'disabled': false, required: true });
                $('#winEnd').datebox({ 'disabled': false, required: true });
            };
        }
    });

    //任务类型
    $('#winJobType').combobox({
        url: GetComboxALLColumnWSRRURL('1e658718-4466-4cf9-99d9-f2f7e88b9aec', "", "ID", "Name") + "&XML=" + GetFormJson([], 'TaskType'),
        required: true,
        type: 'post',
        editable: false,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto'
    });

    //分发策略
    $('#winDeliver').combobox({
        url: GetComboxALLColumnWSRRURL('1e658718-4466-4cf9-99d9-f2f7e88b9aec', "", "ID", "Name") + "&XML=" + GetFormJson([], 'DeliverType'),
        required: true,
        type: 'post',
        editable: false,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto'
    });
    $('#fCreate input').val('');
    $('#winRemark').val('');

    $('#winCreate').window('open');
    $('#winJobName').focus();
};

//文件上传的方法
function UpFiles() {
    //文件上传相关-----------------
    var btnUpExcel = $('#winUP'), interval;
    
    new AjaxUpload(btnUpExcel, {
        action: '/Handler_HZY_CMT.ashx?filePath=CMT&ExcelImport=true',
        data: { "WSID": "1e658718-4466-4cf9-99d9-f2f7e88b9aec", "XML": GetGetJson('','Excel') },
        name: 'myfile',
        onSubmit: function (file, ext) {
            $.messager.progress({ title: '请稍后', msg: '上传中' });
            if (!(ext && /^(xls|xlsx)$/.test(ext))) {
                alert('文件格式不正确,请选择 xls,xlsx 格式的文件!', '系统提示');
                return false;
            }

            // change button text, when user selects file
            btnUpExcel.text('浏览');

            // If you want to allow uploading only 1 file at time,
            // you can disable upload button
            this.disable();

            // Uploding -> Uploading. -> Uploading...
            interval1 = window.setInterval(function () {
                var text = btnUpExcel.text();
                if (text.length < 1) {
                    btnUpExcel.text(text + '.');
                } else {
                    btnUpExcel.text('浏览');
                }
            }, 200);
        },
        onComplete: function (file, response) {
            //file 本地文件名称，response 服务器端传回的信息
            btnUpExcel.text('浏览');

            window.clearInterval(interval1);

            // enable upload button
            this.enable();
            //var k = response.replace("<pre>", "").replace("</pre>", "");
            var k = response.replace("<pre>", "").replace("</pre>", "").replace("<PRE>", "").replace("</PRE>", "");

            try {
                var result = eval("[" + k + "]");
                if (result[0].Error) {
                    $.messager.progress('close');

                    $.messager.alert("系统错误", result[0].Error, 'error');
                }
                else if (result[0].rows[0].result == "False") {
                    var errormessage = result[0].rows[1].message;

                    $.messager.progress('close');

                    alert(result[0].rows[0].message + '\r' +errormessage);

                    $("#winNum").removeAttr("disabled");
                    $("#winNum").focus();
                    $('#winNum').val('');
                    $('#winRoute').val('');
                    $('#winNum').validatebox({ required: true });
                    $("#winNum").attr("disabled", "disabled");
                    
                }
                else {
                    $("#winNum").removeAttr("disabled");
                    $("#winNum").focus();
                    $("#winRoute").val(result[0].rows[0].message);
                    $("#winNum").val(result[0].rows[1].message);
                    $('#winNum').validatebox({ required: false });
                    $("#winNum").attr("disabled", "disabled");
                    
                    $.messager.progress('close');
                    $("<img />").appendTo($('#imglist')).attr("src", result[0].rows[0].message);

                }
            } catch (ex) {
                $.messager.progress('close');

                $.messager.alert("提示", ex, 'error');
            }

        }
    });
    //文件上传相关-----------------
};

//保存按钮
function Save() {
    if ($('#fCreate').form('validate')) {

        var data = $('#fCreate').serializeArray();
        if ($('#winRoute').val() != "") {
            data[data.length] = { "name": "winRoute", "value": $('#winRoute').val() };
            data[data.length] = { "name": "winBatch", "value": $('#winNum').val() };
        }
        XMLData = GetFormJson(data, 'INSERT');

        $.ajax({
            url: GetWSRRURL('1e658718-4466-4cf9-99d9-f2f7e88b9aec'),
            type: 'post',
            async: false, //异步,
            data: { "XML": XMLData },
            success: function (result) {
                try {
                    var result = eval("[" + result + "]");
                    if (result[0].Error) {
                        $.messager.progress('close');

                        $.messager.alert("系统错误", result[0].Error, 'error');
                    } else if (result[0].rows[0].result == "False") {
                        $.messager.progress('close');

                        $.messager.alert("提示", result[0].rows[0].message, 'error');
                    }
                    else {
                        $('#winCreate').window('close');
                        //$('#tab_list').datagrid('reload');
                        $.messager.alert("提示", result[0].rows[0].message,'ok'); //提示信息
                    }
                } catch (ex) {
                    $.messager.progress('close');
                    $.messager.alert("提示", ex, 'error');
                }
            },
            error: function () {
                $.messager.alert("提示", "提交错误了！", 'error');
            }
        });
    }
};

//窗口取消按钮
function Cancel() {
    $('#fCreate input').val('');
    $('#winCreate').window('close');
};

//主界面取消按钮
function mainCancel() {
    $('#fSearch input').val('');
};

//主界面查询按钮
function mainSearch() {
    var data = $('#fSearch').serializeArray();

    //条件全空
    if (data[0].value == "" && data[1].value == "" && data[2].value == "" && data[3].value == "" && data[4].value == "") {
        alert("请输入查询条件");
        return;
    };

    //日期区间不完整
    if ((data[3].value != "" && data[4].value == "") || (data[3].value == "" && data[4].value != "")) {
        alert("请将日期区间选择完整");
        return;
    };

    data[data.length] = { "name": "txtID", "value": m_UserId };

    XMLData = GetFormJson(data, 'GetSearch');

    ClearGrid("#mainTab_List");

    initGird(XMLData);
    
};

//发布按钮
function btnPublish() {
    var rowData = $('#mainTab_List').datagrid('getSelected');
    var id = rowData.tk1_id;
    
    var data = [];
    data[data.length] = { "name": "txtID", "value": id };

    XMLData = GetFormJson(data, 'Update');

    $.ajax({
        url: GetWSRRURL('1e658718-4466-4cf9-99d9-f2f7e88b9aec'),
        type: 'post',
        async: false, //异步,
        data: { "XML": XMLData },
        success: function (result) {
            try {
                var result = eval("[" + result + "]");
                if (result[0].Error) {
                    $.messager.progress('close');

                    $.messager.alert("系统错误", result[0].Error, 'error');
                } else if (result[0].rows[0].result == "False") {
                    $.messager.progress('close');

                    $.messager.alert("提示", result[0].rows[0].message, 'error');
                }
                else {
                    ClearGrid("#mainTab_List");
                    $('#mainTab_List').datagrid('reload');

                    $.messager.alert("提示", result[0].rows[0].message, 'ok'); //提示信息
                }
            } catch (ex) {
                $.messager.progress('close');
                $.messager.alert("提示", ex, 'error');
            }
        },
        error: function () {
            $.messager.alert("提示", "提交错误了！", 'error');
        }
    });
};

//分析1按钮
function btnAnalyse1() {
    if (m_JobID == undefined) {
        alert("请选中一行");
        return;
    };
    //测试  
    //window.location.href = "Analyse1.HTML?target='_blank'";
    window.open("Analyse1.HTML?id="+m_JobID+"&depotid=", target = '_blank')


};

//分析1按钮
function btnAnalyse2() {
    if (m_JobID == undefined) {
        alert("请选中一行");
        return;
    };
    //测试  
    //window.location.href = "Analyse1.HTML?target='_blank'";
    window.open("Analyse2.HTML?id=" + m_JobID, target = '_blank')


};

//批次号检查
function winNumCheck() {
    var BatchNo = $('#winNum').val();

    if (BatchNo == "") {
        return;
    };

    var data = [];
    data[data.length] = { "name": "txtBatchNo", "value": BatchNo };

    XMLData = GetFormJson(data, 'BatchNo');

    $.ajax({
        url: GetWSRRURL('1e658718-4466-4cf9-99d9-f2f7e88b9aec'),
        type: 'post',
        async: true, //异步,
        data: { "XML": XMLData },
        success: function (result) {
            try {
                var result = eval("[" + result + "]");
                if (result[0].Error) {
                    $.messager.progress('close');

                    $.messager.alert("系统错误", result[0].Error, 'error');
                } else if (result[0].rows[0].result == "False") {
                    $.messager.progress('close');

                    $.messager.alert("提示", result[0].rows[0].message, 'error');
                }
                else {
                    if (result[0].rows[0].message == "无数据") {
                        return;
                    } else {
                        $('#winNum').val('');
                        $('#winNum').focus();
                        $.messager.alert("提示", result[0].rows[0].message, 'ok'); //提示信息
                    };
                }
            } catch (ex) {
                $.messager.progress('close');
                $.messager.alert("提示", ex, 'error');
            }
        },
        error: function () {
            $.messager.alert("提示", "提交错误了！", 'error');
        }
    });
};

//获取公司
function getCompany() {
    var data = [];
    data[data.length] = { "name": "txtID", "value": m_UserId };
    XMLData = GetFormJson(data, "GetCompany");
    $.ajax({
        url: GetWSRRURL('1e658718-4466-4cf9-99d9-f2f7e88b9aec'),
        type: 'post',
        async: false, //异步,
        data: { "XML": XMLData },
        success: function (result) {
            try {
                var result = eval("[" + result + "]");
                if (result[0].Error) {
                    $.messager.progress('close');

                    $.messager.alert("系统错误", result[0].Error, 'error');
                } else if (result[0].rows[0].result == "False") {
                    $.messager.progress('close');

                    $.messager.alert("提示", result[0].rows[0].message, 'error');
                }
                else {
                    var companyId = result[0].rows[0].code;
                    m_CompanyID = companyId;
                    if (companyId != "") {
                        $('#MainPublish').linkbutton('disable');
                        $('#MainCloseTake').linkbutton('disable');
                        //$('#MainUpPower').linkbutton('disable');
                    } else {
                        $('#MainPublish').linkbutton('enable');
                        $('#MainCloseTake').linkbutton('enable');
                        //$('#MainUpPower').linkbutton('enable');
                    };
                }
            } catch (ex) {
                $.messager.progress('close');
                $.messager.alert("提示", ex, 'error');
            }
        },
        error: function () {
            $.messager.alert("提示", "提交错误了！", 'error');
        }
    });
};

//分析3按钮
function btnAnalyse3() {
    window.open("Analyse3.HTML", target = '_blank')
};

//终止任务
function stopTask() {
    var rowData = $('#mainTab_List').datagrid('getSelected');
    if (!rowData) { alert("请选择要终止的任务!"); return;};
    var id = rowData.tk1_id;

    var data = [];
    data[data.length] = { "name": "txtID", "value": id };

    XMLData = GetFormJson(data, 'CloseTask');
    $.messager.confirm('提示框', '确认提交？', function (r) {
        if (r) {
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('1e658718-4466-4cf9-99d9-f2f7e88b9aec'),
                type: 'post',
                async: false, //异步,
                data: { "XML": XMLData },
                success: function (result) {
                    try {
                        var result = eval("[" + result + "]");
                        if (result[0].Error) {
                            $.messager.progress('close');

                            $.messager.alert("系统错误", result[0].Error, 'error');
                        } else if (result[0].rows[0].result == "False") {
                            $.messager.progress('close');

                            $.messager.alert("提示", result[0].rows[0].message, 'error');
                        }
                        else {
                            $.messager.progress('close');
                            ClearGrid("#mainTab_List");
                            $('#mainTab_List').datagrid('reload');

                            $.messager.alert("提示", result[0].rows[0].message, 'ok'); //提示信息
                        }
                    } catch (ex) {
                        $.messager.progress('close');
                        $.messager.alert("提示", ex, 'error');
                    }
                },
                error: function () {
                    $.messager.alert("提示", "提交错误了！", 'error');
                }
            });
        };
    });
};
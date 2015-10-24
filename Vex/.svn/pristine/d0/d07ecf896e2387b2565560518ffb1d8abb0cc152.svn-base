/*
    创建者：HWA-沈加华
    创建时间：2014-11-12
    功能：WS服务调度管理界面前台JS函数
*/
var selected_Row;   //任务列表选中行
var selected_Param_Row; //任务列表参数选中行
var m_RouteCode = 'Dev';

//以小时为单位执行的数据
var dataHour = [
        { text: '1', value: '1', 'selected': true },
        { text: '2', value: '2' },
        { text: '3', value: '3' },
        { text: '4', value: '4' },
        { text: '5', value: '5' },
        { text: '6', value: '6' },
        { text: '7', value: '7' },
        { text: '8', value: '8' },
        { text: '9', value: '9' },
        { text: '10', value: '10' },
        { text: '11', value: '11' },
        { text: '12', value: '12' },
        { text: '24', value: '24' }
];
////以分和秒为单位执行的数据
var dataMinAndSec = [
        { text: '1', value: '1','selected':true },
        { text: '2', value: '2' },
        { text: '3', value: '3' },
        { text: '4', value: '4' },
        { text: '5', value: '5' },
        { text: '6', value: '6' },
        { text: '10', value: '10' },
        { text: '12', value: '12' },
        { text: '15', value: '15' },
        { text: '20', value: '20' },
        { text: '30', value: '30' }
];

$(function () { 
    InitGird();

    //放在这个位置有个问题：如果信息维护了，不能够马上更新  TODO
    InitWSIDSelect();
    InitRouteInfo();

    Init_ComBoxExecuteTime();

    //注册事件，用于ComboGrid填充
    $('#txtWS_ID').siblings('span').find('input').first().blur(function () {
        getGridSelectValue();
    });
});

function InitRouteInfo() {
    $('#cmbRoute').combobox({
        url: GetComboxWSRRURL('8a2768bb-b5eb-4fc4-b6ac-83e3677191dd', "", "serverpath", "name") + "&XML=" + GetFormJson([], 'All'),
        required: true,
        panelHeight: 'auto',
        valueField: 'id',
        textField: 'text',
        editable: false,
        onLoadSuccess: function () { //加载完成后,设置选中第一项
           
            var val = $(this).combobox("getData");
           
            for (var item in val[0]) {
                if (item == "id") {
                    $(this).combobox("select", val[0][item]);
                }
            }
        }
    });
}

//初始化WS编号的combogrid
function InitWSIDSelect() {
    $('#txtWS_ID').combogrid({
        panelWidth: 500,
        idField: 'wsid',
        textField: 'wsid',
        url: GetWSRRURL('152cd154-0aa7-437c-9cea-05168395406e') + "&WSRRRouteCode=" + m_RouteCode,
        queryParams: { "XML": GetGetJson([{}]) },
        method: 'get',
        //mode:'local',
        //filter: function(q, row){
        //    var opts = $(this).combogrid('options');
        //    return row[opts.textField].indexOf(q) == 0;
        //},
        columns: [[
            { field: 'wsid', title: 'WSID', width: 150 },
            { field: 'wsname', title: 'WS名称', width: 150 },
            { field: 'servicepath', title: '服务路径', width: 150 }
        ]],
        fitColumns: true
    });


}

//初始化任务列表
function InitGird() {
    $('#tab_list').datagrid(
        {
            url: GetWSRRURL('ef2747d0-4075-4616-8979-c80396b99b00') + "&WSRRRouteCode=" + m_RouteCode,
            queryParams: { "XML": GetGetJson([{}]) },
            nowrap: false, //是否换行，True 就会把数据显示在一行里
            striped: true, //True 奇偶行使用不同背景色
            collapsible: false, //可折叠
            remoteSort: true, //定义是否从服务器给数据排序
            fit: true,
            singleSelect: true, //单行选择
            frozenColumns: [[//冻结的列，不会随横向滚动轴移动
	            { field: 'ws_id', title: 'WSID', width: 150, search: true, sortable: true },
	            { field: 'ws_name', title: '任务名', width: 180, search: true, sortable: true }

            ]],
            columns: [[
                //{ field: 'ws_logicname', title: '执行类', width: 80, search: true, sortable: true },
                //{ field: 'ws_pid', title: 'PID', width: 160, search: true, sortable: true },
                { field: 'last_execute_time', title: '上次执行时间', width: 100, sortable: true },
                { field: 'last_execute_right_time', title: '上次正确执行时间', width: 100, sortable: true },
                { field: 'error_count', title: '执行错误次数', width: 80, sortable: true },
                { field: 'url', title: 'WSRR服务URL', width: 150, search: true, sortable: true },
                { field: 'execute_type', title: '执行类别', width: 50, search: true, sortable: true,
                        formatter:function(val){
                            if ("day" == val) {
                                return "天";
                            } else if ("week" == val) {
                                return "周";
                            } else {
                                return "月";
                            }
                        }
                },
                { field: 'execute_starttime', title: '执行开始时间', width: 100, sortable: true },
                { field: 'execute_endtime', title: '执行结束时间', width: 100, sortable: true },
                {field: 'execute_cycle', title: '执行周期', width: 100, sortable: true,
                        formatter: function (val) {
                            var nExecuteCycle=parseInt(val)
                            if (nExecuteCycle < 60) {
                                return nExecuteCycle + "秒";
                            } else if (nExecuteCycle / 60 < 60) {
                                return nExecuteCycle / 60 + "分";
                            } else {
                                return nExecuteCycle / 3600 + "小时";
                            }
                        }
                },
                { field: 'execute_daystarttime', title: '执行开始日期', width: 100, sortable: true },
                { field: 'execute_dayendtime', title: '执行结束日期', width: 100, sortable: true },
                { field: 'execute_weektime', title: '执行周时间', width: 100, sortable: true },
                { field: 'execute_monthtime', title: '执行月时间', width: 100, sortable: true },
                { field: 'enabled', title: '是否可用', width: 60, sortable: true,
                        formatter: function (val) {
                            if ("True"==val) {
                                return "是";
                            }else {
                                return "否";
                            }
                        }
                },
               { field: 'remind_errorcount', title: '提醒错误次数', width: 80, sortable: true },
               { field: 'remind_username', title: '提醒用户', width: 80, sortable: true, search: true },
                //{ field: 'createuser', title: '创建者', width: 100, sortable: false },
                //{ field: 'createtime', title: '创建时间', width: 100, sortable: true },
                //{ field: 'updateuser', title: '更新者', width: 100, sortable: false },
                //{ field: 'updatetime', title: '更新时间', width: 100, sortable: true },
                { field: 'task_id', title: 'TASK_ID', width: 20, hidden: true, sortable: true }
            ]],
            pagination: true, //是否开启分页
            pageNumber: 1, //默认索引页
            pageSize: 20, //默认一页数据条数
            rownumbers: true, //行号

            onDblClickRow: function () { Edit_OnClick(false); },
            onClickRow: function () { DBlClickRowGrid(); },

            toolbar: [
            {
                id: 'btn_Add',
                text: '添加',
                iconCls: 'icon-add',
                handler: function () {
                    Add_OnClick(false);
                }
            },
            {
                id: 'btn_Edit',
                text: '编辑',
                iconCls: 'icon-edit',
                handler: function () {
                    Edit_OnClick(false);
                }
            },
            {
                id: 'btn_Copy',
                text: '复制',
                iconCls: 'icon-pagecopy',
                handler: function () {
                    Edit_OnClick(true);
                }
            },
            {
                id: 'btn_Delete',
                text: '删除',
                iconCls: 'icon-cancel',
                handler: function () {
                    Delete_OnClick();
                }
            }
            ]
        }
        );
}

//添加任务
function Add_OnClick() {
    $('#divEditWSRR').window({
        title: "添加",
        width: 640,
        height: 530,
        top: 20,
        modal: true
    });
    $('#form_Edit #txtTask_ID').val("");    //清空TASK_ID
    $('#form_Edit #txtTaskIDShow').val("系统自动生成");    //显示TASK_ID的信息
    $('#form_Edit #txtWS_ID').combogrid('setValue', '');    //清空WSID
    $('#form_Edit #txtWS_Name').val('');    //设置任务名称
    $('#trShowWSName').hide();  //隐藏WS名称
    $('#txtShowWSName').val('');    //WS名称清空
    $('#form_Edit #cmbRoute').combobox('setValue', '');   //设置URL
    $('#form_Edit #comExecute_Type').combobox('setValue', 'day'); //设置执行类型（默认为“天”）
    TR_Display('day');
    //设置每天开始时间
    $('#form_Edit #txtExecute_StartTime').val('00:00:00');
    //设置每天结束时间
    $('#form_Edit #txtExecute_EndTime').val('23:59:59');
    //设置执行周期
    $('#form_Edit #comExecute_CycleType').combobox('setValue', 'sec');  //默认为秒
    $('#comExecute_Time').combobox('loadData', dataMinAndSec);
    $('#form_Edit #comExecute_Time').combobox('setValue', 20);    //默认20秒
    //设置从哪天开始
    $('#form_Edit #txtExecute_DayStartTime').datebox('setValue', '');
    //设置到哪天结束
    $('#form_Edit #txtExecute_DayEndTime').datebox('setValue', '');
    $('#form_Edit #chkEnabled').attr("checked", 'True'); //默认可用
    $('#form_Edit #txtError_Count').numberspinner('setValue',0);        //设置错误执行次数
    $('#form_Edit #txtRemind_ErrorCount').numberspinner('setValue', 5);        //设置错误执行次数，默认5次
    $('#form_Edit #txtRemind_UserName').val('');        //设置提醒用户
    //验证Form
    $('#form_Edit').form('validate');
    //设置cmbRoute焦点
    $('#form_Edit #cmbRoute').focus();
}

//任务列表项目编辑
function Edit_OnClick(IsCopy) {
    if (!selected_Row) {
        $.messager.alert("提示", "请选择一行数据", 'error');
        return;
    }

    //如何是复制
    if (IsCopy) {
        $('#divEditWSRR').window({
            title: "复制",
            width: 640,
            height: 530,
            top: 20,
            modal: true
        });

        $('#form_Edit #txtWS_ID').combogrid('setValue', '');    //清空WSID
        $('#form_Edit #txtTask_ID').val("");    //清空TASK_ID
        $('#form_Edit #txtTaskIDShow').val("系统自动生成");    //显示TASK_ID的信息
        $('#form_Edit #txtError_Count').numberspinner('setValue', 0);        //设置错误执行次数
    }//如果是编辑
    else {
        $('#divEditWSRR').window({
            title: "编辑",
            width: 640,
            top: 20,
            height: 530,
            modal: true
        });
        $('#form_Edit #txtTaskIDShow').val(selected_Row.task_id);   //显示TASK_ID的信息
        $('#form_Edit #txtTask_ID').val(selected_Row.task_id);  //设置Task_ID
        $('#form_Edit #txtWS_ID').combogrid('setValue', selected_Row.ws_id);    //设置WS_ID
        //$('#form_Edit #txtWS_ID').combogrid('grid').datagrid('selectRecord', selected_Row.ws_id)    //选中Grid中的行
        $('#form_Edit #txtError_Count').numberspinner('setValue', selected_Row.error_count);        //设置错误执行次数
    }
    $('#trShowWSName').hide();  //隐藏WS名称
    $('#txtShowWSName').val('');    //WS名称清空
    $('#form_Edit #txtWS_Name').val(selected_Row.ws_name);    //设置任务名称
    $('#form_Edit #cmbRoute').combobox('setValue', selected_Row.url);   //设置URL
    //$('#form_Edit #txtWS_LogicName').val(selected_Row.ws_logicname);    //设置执行类
    //设置执行类型（day,week,month）
    $('#form_Edit #comExecute_Type').combobox('setValue', selected_Row.execute_type);
    TR_Display(selected_Row.execute_type);
    //设置每天开始时间
    $('#form_Edit #txtExecute_StartTime').val(selected_Row.execute_starttime);
    //设置每天结束时间
    $('#form_Edit #txtExecute_EndTime').val(selected_Row.execute_endtime);
    //设置执行周期（秒，分，小时）
    var nExecuteCycle=parseInt(selected_Row.execute_cycle);
    if (nExecuteCycle < 60) {
        //秒
        $('#form_Edit #comExecute_CycleType').combobox('setValue', 'sec');
        $('#comExecute_Time').combobox('loadData', dataMinAndSec);
        $('#form_Edit #comExecute_Time').combobox('setValue', nExecuteCycle);
    }else if(nExecuteCycle/60<60){
        //分钟
        $('#form_Edit #comExecute_CycleType').combobox('setValue', 'min');
        $('#comExecute_Time').combobox('loadData', dataMinAndSec);
        $('#form_Edit #comExecute_Time').combobox('setValue', nExecuteCycle/60);
    }else{
        //小时
        $('#form_Edit #comExecute_CycleType').combobox('setValue', 'hou');
        $('#comExecute_Time').combobox('loadData', dataHour);
        $('#form_Edit #comExecute_Time').combobox('setValue', nExecuteCycle/3600);
    }
    //设置从哪天开始
    $('#form_Edit #txtExecute_DayStartTime').datebox('setValue', selected_Row.execute_daystarttime);
    //设置到哪天结束
    $('#form_Edit #txtExecute_DayEndTime').datebox('setValue', selected_Row.execute_dayendtime);

    //执行周时间选择（星期一，星期二......）,先清空再选择
    $('#form_Edit input[name="chkExecute_WeekTime"]').each(function () {
        $(this).removeAttr("checked");
    });
    if (selected_Row.execute_weektime) {
        var strs = selected_Row.execute_weektime.split(',');
        $.each(strs, function (index, tx) {
            $('#form_Edit input[name="chkExecute_WeekTime"]').each(function () {
                if (this.defaultValue == tx) {
                    $(this).attr("checked", "true");
                }
            });
        });
    }
    //设置月执行日
    $('#form_Edit #txtExecute_MonthTime').val(selected_Row.execute_monthtime);
    //设置是否可用
    if ("False" == selected_Row.enabled) {
        $('#form_Edit #chkEnabled').removeAttr("checked");
    } else {
        $('#form_Edit #chkEnabled').attr("checked", selected_Row.enabled);
    }
    $('#form_Edit #txtRemind_ErrorCount').numberspinner('setValue', selected_Row.remind_errorcount);        //设置错误执行次数
    $('#form_Edit #txtRemind_UserName').val(selected_Row.remind_username);        //设置提醒用户
    //验证Form
    $('#form_Edit').form('validate');
    //设置cmbRoute焦点
    $('#form_Edit #cmbRoute').focus();
}

//任务列表项目编辑提交
function Edit_Submit() {
    $('#form_Edit').form('submit', {
        onSubmit: function (e) {
            if ($('#form_Edit').form('validate') == false) {
                return false;
            }
            //验证：开始日期不能大于结束日期，结束日期不能比当前日期小
            var startDateTime = new Date($('#txtExecute_DayStartTime').datebox('getValue').replace(/\-/g, "\/"));
            var endDateTime = new Date($('#txtExecute_DayEndTime').datebox('getValue').replace(/\-/g, "\/"));
            var nowTime = new Date();
            //var todayDate = new Date(nowTime.getFullYear(),nowTime.getMonth(),nowTime.getDate(),0,0,0,0);
            if (startDateTime > endDateTime) {
                $.messager.alert("提示", "开始日期不能大于结束日期", 'error');
                return false;
            }
            //if (todayDate > endDateTime) {
            //    $.messager.alert("提示", "结束日期不能比当前日期小", 'error');
            //    return false;
            //}

            //验证：执行类别为月时，执行月的时间不能为空
            if ("month" == $('#comExecute_Type').combobox('getValue') && "" == $('#txtExecute_MonthTime').val()) {
                $.messager.alert("提示", "执行月时间不能为空", 'error');
                $('#txtExecute_MonthTime').focus();
                return false;
            }

            //验证：开始时间不能大于结束时间
            var startHour = $('#txtExecute_StartTime').timespinner('getHours');
            var startMin = $('#txtExecute_StartTime').timespinner('getMinutes');
            var startSec = $('#txtExecute_StartTime').timespinner('getSeconds');
            var startTotalTime = startHour * 3600 + startMin * 60 + startSec;
            var endHour = $('#txtExecute_EndTime').timespinner('getHours');
            var endMin = $('#txtExecute_EndTime').timespinner('getMinutes');
            var endSec = $('#txtExecute_EndTime').timespinner('getMinutes');
            var endTotalTime = endHour * 3600 + endMin * 60 + endSec;
            if (startTotalTime > endTotalTime) {
                $.messager.alert("提示", "开始时间不能大于结束时间", 'error');
                return false;
            }

            //最终结束时间不能比当前时间小
            var endExecuteTime = new Date(endDateTime.getFullYear(), endDateTime.getMonth(), endDateTime.getDate(), endHour, endMin, endSec);
            if (endExecuteTime< nowTime) {
                $.messager.alert("提示", "该任务永远无法执行", 'error');
                return false;
            }

            //获取周执行时间
            var strWeekTime = "";
            $('#form_Edit input[name="chkExecute_WeekTime"]').each(function () {
                if ($(this).attr("checked")) {
                    strWeekTime = strWeekTime + this.value + ",";
                }
            });
            if (strWeekTime) {
                strWeekTime = strWeekTime.substr(0, strWeekTime.length - 1);
            }
            //验证：执行类别为周时，执行周的时间不能为空
            if ("week" == $('#comExecute_Type').combobox('getValue') && "" == strWeekTime) {
                $.messager.alert("提示", "请选择周几执行", 'error');
                $('#trWeekTime input[name="chkExecute_WeekTime"]').first().focus();
                return false;
            }

            //获取执行周期（转化为秒）
            var strExecute_Cycle = "";
            var strCycleType = $('#form_Edit #comExecute_CycleType').combobox('getValue');
            var strCycleTime = $('#form_Edit #comExecute_Time').combobox('getValue');
            if ("sec" == strCycleType) {
                //秒
                strExecute_Cycle = strCycleTime;
            } else if ("min" == strCycleType) {
                //分
                strExecute_Cycle = 60 * strCycleTime;
            } else {
                //小时
                strExecute_Cycle = 3600 * strCycleTime;
            }

            //设置Request对象
            var data = [];
            data[data.length] = { "name": "txtTask_ID", "value": $('#txtTask_ID').val() };
            data[data.length] = { "name": "txtWS_ID", "value": $('#txtWS_ID').combogrid('getValue') };
            data[data.length] = { "name": "cmbURL", "value": $('#cmbRoute').combobox('getValue') };
            data[data.length] = { "name": "txtWS_Name", "value": $('#txtWS_Name').val() };
            data[data.length] = { "name": "txtWS_LogicName", "value": ''};
            data[data.length] = { "name": "comExecute_Type", "value": $('#comExecute_Type').combobox('getValue') };
            data[data.length] = { "name": "chkExecute_WeekTime", "value": strWeekTime };
            data[data.length] = { "name": "txtExecute_MonthTime", "value": $('#txtExecute_MonthTime').val() };
            data[data.length] = { "name": "txtExecute_StartTime", "value": $('#txtExecute_StartTime').timespinner('getValue') };
            data[data.length] = { "name": "txtExecute_EndTime", "value": $('#txtExecute_EndTime').timespinner('getValue') };
            data[data.length] = { "name": "txtExecute_Cycle", "value": strExecute_Cycle };
            data[data.length] = { "name": "txtExecute_DayStartTime", "value": $('#txtExecute_DayStartTime').datebox('getValue') };
            data[data.length] = { "name": "txtExecute_DayEndTime", "value": $('#txtExecute_DayEndTime').datebox('getValue') };
            data[data.length] = { "name": "chkEnabled", "value": $('#chkEnabled').attr("checked") ?"True":"False"};
            data[data.length] = { "name": "txtError_Count", "value":  $('#chkEnabled').attr("checked") ?$('#txtError_Count').numberspinner('getValue'):0 };//若设置不可用，将执行错误次数清0
            data[data.length] = { "name": "txtRemind_ErrorCount", "value": $('#txtRemind_ErrorCount').numberspinner('getValue') };
            data[data.length] = { "name": "txtRemind_UserName", "value": $('#txtRemind_UserName').val() };
            var XMLData = GetFormJson(data, 'EDIT');
            $.ajax({
                url: GetWSRRURL('ef2747d0-4075-4616-8979-c80396b99b00') + "&WSRRRouteCode=" + m_RouteCode,
                type: 'post',
                async: true, //异步,
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

                            $('#divEditWSRR').window('close');
                            $('#tab_list').datagrid("reload");
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

            return false;
        }
    });
}

//任务列表项目删除
function Delete_OnClick() {
    if (!selected_Row) {
        $.messager.alert("提示", "请选择一行", 'error');
        return;
    }
    $.messager.confirm('提示框', '你确定要删除吗?', function (r) {
        if (r) {
            var data = eval("[]");
            data[data.length] = { "name": "txtTask_ID", "value": selected_Row.task_id }
            var XMLData = GetFormJson(data, 'DELETE');

            $.ajax({
                url: GetWSRRURL('ef2747d0-4075-4616-8979-c80396b99b00') + "&WSRRRouteCode=" + m_RouteCode,
                type: 'post',
                async: true, //异步,
                data: { "XML": XMLData },
                success: function (result) {
                    try {
                        var result = eval("[" + result + "]");
                        if (result[0].Error) {
                            $.messager.progress('close');

                            $.messager.alert("系统错误", result[0].Error, 'error');
                        }
                        else if (result[0].rows[0].result == "False") {
                            $.messager.alert("提示", result[0].rows[0].message, 'error');
                        }
                        else {
                            $('#tab_list').datagrid("unselectAll");
                            selected_Row = undefined
                            $('#tab_list').datagrid("reload");
                            //$.messager.alert("提示", result[0].rows[0].message);
                        }
                    } catch (ex) {
                        $.messager.alert("提示", ex, 'error');
                    }
                },
                error: function () {
                    $.messager.alert("提示", "提交错误了！", 'error');
                }
            });
        }
    })
};

//双击任务列表项目
function DBlClickRowGrid() {
    var selected = $('#tab_list').datagrid('getSelected');

    if (selected) {
        selected_Row = selected;
        $('#form_ParamEdit input[name="txtTask_ID"]').val(selected_Row.task_id);
        InitTab();
    }
}

//双击任务列表后初始化任务参数列表
function InitTab() {
    if (selected_Row) {
        try {
            var row = $('#divParamInfo').datagrid('getSelected');
            var rowIndex = $('#divParamInfo').datagrid('getRowIndex', row);
            $('#divParamInfo').datagrid('unselectRow', rowIndex);
            $('#mainTabs').tabs("select", 0);
        }
        catch (e) {
        }

        InitParamInfo();
        InitLogInfo();
    }
}

function InitLogInfo() {
    $('#tblLogInfo').datagrid(
           {
               title: selected_Row.ws_name, //表格标题
               url: GetWSRRURL('46d78b79-f44e-42ba-bd76-3f963bb03c05') + "&WSRRRouteCode=" + m_RouteCode,
               queryParams: { "XML": GetGetJson([{ "task_id": selected_Row.task_id }]) },
               iconCls: '', //标题左边的图标
               striped: true, //True 奇偶行使用不同背景色
               collapsible: false, //可折叠
               nowrap: false, //是否换行，True 就会把数据显示在一行里
               fit: true,
               singleSelect: true, //单行选择
               columns: [[
                   { field: 'auto_id', title: '日志编号', width: 30, hidden: true },
                   { field: 'task_id', title: '任务编号', width: 30, hidden: true },
                   { field: 'execute_starttime', title: '开始时间', width: 80 },
                   { field: 'execute_endtime', title: '结束时间', width: 80 },
                   {field: 'execute_result', title: '结果', width: 40,
                       formatter: function (val) {
                           if ("True" == val) {
                               return "成功";
                           } else {
                               return "失败";
                           }
                       }
                   },
                   {field: 'execute_message', title: '错误信息', width: 150,
                       formatter: function (val) {
                           if (val.length > 18) {
                               var subVal=val.substr(0,18)+"...";
                                return '<span title="'+val+'" class="easyui-tooltip">'+subVal+'</span>';
                           }
                           return val;
                       }
                   }
               ]],
               pagination: true, //是否开启分页
               pageNumber: 1, //默认索引页
               pageSize: 20, //默认一页数据条数
               onLoadSuccess: function (data) {
                   if (data.rows.length == 1 && data.rows[0].auto_id == "") {
                       ClearGrid("#tblLogInfo");
                   }
               }
           }
           );
}

//初始化任务参数列表信息
function InitParamInfo() {
    $('#divParamInfo').datagrid(
            {
                title: selected_Row.ws_name, //表格标题
                url: GetWSRRURL('799ff52e-4b08-4c55-94f4-bbbee32de72b') + "&WSRRRouteCode=" + m_RouteCode,
                queryParams: { "XML": GetGetJson([{ "task_id": selected_Row.task_id }]) },
                iconCls: '', //标题左边的图标
                striped: true, //True 奇偶行使用不同背景色
                collapsible: false, //可折叠
                fit: true,
                singleSelect: true, //单行选择
                columns: [[
                    { field: 'param_id', title: '参数编号', width: 30, hidden: true },
                    { field: 'task_id', title: '任务编号', width: 30, hidden: true },
                    { field: 'param_name', title: '参数名', width: 150 },
                    { field: 'param_value', title: '参数值', width: 150 }
                ]],
                onLoadSuccess: function (data) {
                    if (data.rows.length == 1 && data.rows[0].param_id == "") {
                        ClearGrid("#divParamInfo");
                    }
                },
                onDblClickRow: function () { AddParam_OnClick(true); },
                toolbar: [
                {
                    id: 'btn_AddParam',
                    text: '添加',
                    iconCls: 'icon-add',
                    handler: function () {
                        AddParam_OnClick();
                    }
                },
                {
                    id: 'btn_EditParam',
                    text: '编辑',
                    iconCls: 'icon-edit',
                    handler: function () {
                        AddParam_OnClick(true);
                    }
                },
                {
                    id: 'btn_DeleteParam',
                    text: '删除',
                    iconCls: 'icon-cancel',
                    handler: function () {
                        DeleteParam_OnClick();
                    }
                }]
            }
            );
}

//添加任务项目参数
function AddParam_OnClick(isEdit) {
    selected_Param_Row = $('#divParamInfo').datagrid('getSelected');

    if (isEdit && !selected_Param_Row) {
        $.messager.alert("系统错误", "请选择一行数据！", 'error');
        return;
    }
    if (isEdit) {
        //编辑的场合
        $('#divEditWSParam').window({
            title: "编辑",
            width: 500,
            height: 300,
            top: 20,
            modal: true
        });

        $('#form_ParamEdit #txtParamIDShow').val(selected_Param_Row.param_id);  //设置显示ParamID
        $('#form_ParamEdit #txtParam_ID').val(selected_Param_Row.param_id); //设置ParamID
        $('#form_ParamEdit #txtTask_ID').val(selected_Param_Row.task_id);    //设置Task_ID
        $('#form_ParamEdit #txtParam_Name').val(selected_Param_Row.param_name); //设置参数名称
        $('#form_ParamEdit #txtParam_Value').val(selected_Param_Row.param_value); //设置参数值
    }
    else {
        //新增的场合
        $('#divEditWSParam').window({
            title: "添加",
            width: 500,
            top: 20,
            height: 300,
            modal: true
        });

        $('#form_ParamEdit #txtParamIDShow').val('系统自动生成'); //显示“系统自动生成”
        $('#form_ParamEdit #txtParam_ID').val('');  //清空ParamID
        $('#form_ParamEdit #txtTask_ID').val(selected_Row.task_id); //设置选中任务项目的TaskID
        $('#form_ParamEdit #txtParam_Name').val('');    //清空参数名称
        $('#form_ParamEdit #txtParam_Value').val('');   //清空参数值

    }
    $('#form_ParamEdit').form('validate');  //验证
    $('#form_ParamEdit #txtParam_Name').focus();    //参数名称获取焦点
}

//编辑任务项目参数
function Edit_ParamSubmit() {
    $('#form_ParamEdit').form('submit', {
        onSubmit: function () {
            if ($('#form_ParamEdit').form('validate') == false) {
                return false;
            }
            var data = $('#form_ParamEdit').serializeArray();   //Form序列化
            var XMLData = GetFormJson(data, 'EDIT');    //获取XML格式

            $.ajax({
                url: GetWSRRURL('799ff52e-4b08-4c55-94f4-bbbee32de72b') + "&WSRRRouteCode=" + m_RouteCode,
                type: 'post',
                async: true, //异步,
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
                            //$.messager.progress('close');
                            $('#divEditWSParam').window('close');
                            $('#divParamInfo').datagrid("unselectAll");
                            $('#divParamInfo').datagrid("reload");
                            //$.messager.alert("提示", result[0].rows[0].message);
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
    });
}

//删除任务项目参数
function DeleteParam_OnClick() {
    var selected = $('#divParamInfo').datagrid('getSelected');
    if (!selected) {
        $.messager.alert("提示", "请选择一行", 'error');
        return;
    }
    $.messager.confirm('提示框', '你确定要删除吗?', function (r) {
        if (r) {
            var data = eval("[]");
            data[data.length] = { "name": "txtParam_ID", "value": selected.param_id }   //设置删除所需参数
            var XMLData = GetFormJson(data, 'DELETE');

            $.ajax({
                url: GetWSRRURL('799ff52e-4b08-4c55-94f4-bbbee32de72b') + "&WSRRRouteCode=" + m_RouteCode,
                type: 'post',
                async: true, //异步,
                data: { "XML": XMLData },
                success: function (result) {
                    try {
                        var result = eval("[" + result + "]");
                        if (result[0].Error) {
                            $.messager.progress('close');

                            $.messager.alert("系统错误", result[0].Error, 'error');
                        }
                        else if (result[0].rows[0].result == "False") {
                            $.messager.alert("提示", result[0].rows[0].message, 'error');
                        }
                        else {
                            $('#divParamInfo').datagrid("unselectAll");
                            $('#divParamInfo').datagrid("reload");
                        }
                    } catch (ex) {
                        $.messager.alert("提示", ex, 'error');
                    }
                },
                error: function () {
                    $.messager.alert("提示", "提交错误了！", 'error');
                }
            });
        }
    })
};

//选中执行周期类型时触发事件
function ExecuteCycleType_OnSelect(com)
{
    var strCycleTyle = com.value;
    if (strCycleTyle == "hou") {
        //当执行周期类型为小时时，加载dataHour
        $('#comExecute_Time').combobox('clear');
        $('#comExecute_Time').combobox('loadData', dataHour);
    } else {
        //当执行周期类型为分或秒时，加载dataMinAndSec
        $('#comExecute_Time').combobox('clear');
        $('#comExecute_Time').combobox('loadData', dataMinAndSec);
    }
}

//选中执行类型时触发事件
function ExecuteType_OnSelect(com) {
    TR_Display( com.value);
}

//选中执行类型时，执行周和执行月的行显示与否
function TR_Display(value) {
    if (value == "day") {
        //当执行类型为天时，隐藏trWeekTime行和trMonthTime行
        $('#trWeekTime').hide();
        $('#trMonthTime').hide();
        //清空周
        $('#form_Edit input[name="chkExecute_WeekTime"]').each(function () {
            $(this).removeAttr("checked");
        });
        //清空月
        $('#form_Edit #txtExecute_MonthTime').val('');
    } else if (value == "week") {
        //当执行类型为周时，显示trWeekTime行，隐藏trMonthTime行
        $('#trWeekTime').show();
        $('#trMonthTime').hide();
        //清空月
        $('#form_Edit #txtExecute_MonthTime').val('');
    } else {
        //当执行类型为月时，隐藏trWeekTime行，显示trMonthTime行
        $('#trWeekTime').hide();
        $('#trMonthTime').show();
        //清空周
        $('#form_Edit input[name="chkExecute_WeekTime"]').each(function () {
            $(this).removeAttr("checked");
        });
    }
}

//初始化以秒为单位的执行时间
function Init_ComBoxExecuteTime() {
    $('#comExecute_Time').combobox('clear');
    $('#comExecute_Time').combobox('loadData', dataMinAndSec);
}

//日期控件DateBox的格式化函数（2014-01-01）
function DateFormatter(date) {
    var y = date.getFullYear();
    var m = date.getMonth() + 1;
    var d = date.getDate();
    return y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d);
}

//日期控件DateBox的解释器
function DateParser(s) {
    if (!s) return new Date();
    var ss = (s.split('-'));
    var y = parseInt(ss[0], 10);
    var m = parseInt(ss[1], 10);
    var d = parseInt(ss[2], 10);
    if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
        return new Date(y, m - 1, d);
    } else {
        return new Date();
    }
}

//扩展easyui表单的验证  
$.extend($.fn.validatebox.defaults.rules, {
    MonthExecute: {
        validator:function (value) {
            return value.match(/^([1-9]|[12][0-9]|30|31)(,([1-9]|[12][0-9]|30|31))*$/);
        },
        message: '格式不正确，正确格式如"8,10"，表示每月的8号，10号执行'
    }
});

//获取选中的表格的数据 
function getGridSelectValue() {
    var grid = $("#txtWS_ID").combogrid("grid");//获取表格对象 
    var row = grid.datagrid('getSelected');//获取行数据 
    if (row) {
        $('#txtWS_ID').combogrid('setValue', row.wsid);
        $('#trShowWSName').show();
        $('#txtShowWSName').val(row.wsname);
        
    } else {
        $('#txtWS_ID').combogrid('setValue', '');
        $('#trShowWSName').hide();
        $('#txtShowWSName').val('');
    }
}

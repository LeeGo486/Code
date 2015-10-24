var m_selected;
var Env_ID;
$(function () {
    //$('#txtEnv_IDShow').combobox({
    //    url: GetComboxWSRRURL('6d171a64-a0b1-4468-a0d7-af219c35b049') + "&XML=" + GetGetJson([]),
    //    required: true,
    //    panelHeight: 200,
    //    editable: true,
    //    valueField: 'id',
    //    textField: 'text',
    //    onChange: function () { InitGird(); GetAuthorizationValue(); }
    //});

    $('#txtEnv_IDShow').combobox({
        url: GetComboxWSRRURL('07978308-6591-4ba4-ba69-fc5d5c6a7c3f') + "&XML=" + GetFormJson([], 'GETENV'),
        required: true,
        panelHeight: 200,
        editable: false,
        valueField: 'id',
        textField: 'text',
        onChange: function () { InitGird(); GetAuthorizationValue(); }
    });
})

function InitGird() {

    Env_ID = $('#txtEnv_IDShow').combobox('getValue');

    $('#tab_list').datagrid(
        {
            title: '集团人员列表', //表格标题
            url: GetWSRRURL('96e98385-78a2-43ab-a437-577ad71094ff'),
            queryParams: { "XML": GetGetJson([{ "Env_ID": Env_ID }]) },
            sortable: true,
            width: '90%', //宽度
            height: $(document).height() - 25, //高度
            nowrap: true, //是否换行，True 就会把数据显示在一行里
            remoteSort: true, //定义是否从服务器给数据排序
            collapsible: false, //可折叠
            striped: true, //True 奇偶行使用不同背景色
            singleSelect: true, //单行选择
            //fit: true,
            pagination: true, //是否开启分页
            pageSize: 20, //默认一页数据条数
            onSelect: function () { m_selected = $('#tab_list').datagrid('getSelected'); GetAuthorizationValue(); },
            frozenColumns: [[//冻结的列，不会随横向滚动轴移动
	            {
	                field: 'vexssonewid', title: 'SSO人员编号',
	                searchfield: "VEXSSOUser.vexssonewid", width: 100, search: true, sortable: true
	            }
            ]],
            columns: [[
                { field: 'name', title: 'SSO姓名', width: 100, search: true, sortable: true },
                { field: 'vexssologinuser', title: 'SSO用户名', width: 100, search: true, sortable: true },
                { field: 'app_userid', title: '应用用户ID', width: 100, search: true, sortable: true },
                { field: 'app_username', title: '应用用户名', width: 100, search: true, sortable: true },
                { field: 'app_username_cn', title: '应用用户姓名', width: 100, search: true, sortable: true }
            ]],
            onLoadSuccess: function () { $('#tab_list').datagrid('selectRow', 0); }
        });
}

function GetAuthorizationValue() {
    if (Env_ID == "") {
        return;
    }
    var vexssonewid = "";
    var App_UserID = -1
    if (m_selected) {
        if (m_selected.vexssonewid != "") {
            vexssonewid = m_selected.vexssonewid;
        }
        if (m_selected.app_userid != "") {
            App_UserID = m_selected.app_userid;
        }
    }
    //根据环境编号和用户编号信息取到系统用户权限
    $("#tree_Menu").tree({
        url: GetTreeWSRRURL('4fc5a903-516c-456b-bd6f-9a1e67689330', "HavaFlag") + "&XML=" + GetGetJson([{ "Env_ID": Env_ID, "VexSSONewID": vexssonewid, "app_userid": App_UserID }])
        , checkbox: true
    })
}

function Authorization_Submit() {

    if (m_selected == undefined) {
        return false;
    }
    var nodes = $('#tree_Menu').tree('getChecked');
    var s = '';
    for (var i = 0; i < nodes.length; i++) {
        if (s != '') s += ',';
        s += nodes[i].id;
    }
    $('#txtform_AuthorizationSubmit_AUZlist').val(s);
    $('#txtform_AuthorizationSubmit_VexSSONewID').val(m_selected.vexssonewid);
    $('#txtform_AuthorizationSubmit_App_UserID').val(m_selected.app_userid);
    $('#txtEnv_ID').val($('#txtEnv_IDShow').combobox('getValue'));

    var data = $('#form_AuthorizationSubmit').serializeArray();
    var XMLData = GetFormJson(data, 'UPDATE');
    $.messager.progress({ title: '请稍后', msg: '处理中' });
    $.ajax({
        url: GetWSRRURL('4fc5a903-516c-456b-bd6f-9a1e67689330'),
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
                    $.messager.progress('close');
                    $('#tab_list').datagrid("unselectAll");
                    $('#tab_list').datagrid("reload");

                    $.messager.alert("提示", result[0].rows[0].message);
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

var m_selected;

$(function () {
    InitGird();
})

function InitGird() {

    $('#tab_list').datagrid(
        {
            title: '集团人员列表', //表格标题
            url: GetWSRRURL('D8640684-505A-69EA-6572-2BBA43C3CE13'),        
            queryParams: { "XML": GetGetJson() },
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
            columns: [[
	            { field: 'userid', title: '用户ID', width: 100, search: true, sortable: true },
                { field: 'username', title: '用户姓名', width: 100, search: true, sortable: true },
            ]],
            onLoadSuccess: function () { $('#tab_list').datagrid('selectRow', 0); }
        });
}

function GetAuthorizationValue() {
    
    if (m_selected) {
        $("#tree_Menu").tree({
            url: GetTreeWSRRURL('E1D92923-8A3C-1034-B63E-8B627852C34F', "HavaFlag") + "&XML=" + GetGetJson([{ "username": m_selected.username }]),
            checkbox: true
        })
    }

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
    //$('#txtform_AuthorizationSubmit_VexSSONewID').val(m_selected.vexssonewid);
    $('#txtform_AuthorizationSubmit_App_UserID').val(m_selected.userid);
    $('#txtEnv_ID').val($('#txtEnv_IDShow').combobox('getValue'));

    var data = $('#form_AuthorizationSubmit').serializeArray();
    var XMLData = GetFormJson(data, 'UPDATE');
    $.messager.progress({ title: '请稍后', msg: '处理中' });
    $.ajax({
        url: GetWSRRURL('E1D92923-8A3C-1034-B63E-8B627852C34F'),
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
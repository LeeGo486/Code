var lastTabs;
var m_selected;

$(function () {
    $('#cmbEnv_ID').combobox({
        //url: '../Common/Combox.aspx?ComboxType=MDM_Sysenv',
        //url: GetWSRRURL('6d171a64-a0b1-4468-a0d7-af219c35b049'),
        //url: GetWSRRURL('6d171a64-a0b1-4468-a0d7-af219c35b049') + "&XML=" + GetGetJson([]),
        url: GetComboxWSRRURL('6d171a64-a0b1-4468-a0d7-af219c35b049') + "&XML=" + GetGetJson([]),
        required: true,
        valueField: 'id',
        textField: 'text',
        editable: false
    });
    $('#AuthorizationSubmit').linkbutton({
        plain: false
    });
    $('#btn_Add').linkbutton({
        plain: false
    });
    $('#btn_Del').linkbutton({
        plain: false
    });
    $('#btn_Submit').linkbutton({
        plain: false
    });
    InitGird();
    Edit_OnClick();
});

//初始化表格
function InitGird() {
    $('#tab_list').datagrid(
{
    title: '权限列表', //表格标题
    url: GetWSRRURL('59f31018-58d8-429b-90bd-e8ad0a91da94'),
    queryParams: { "XML": GetGetJson([{}]) },
    sortable: true,
    iconCls: '', //标题左边的图标
    width: '90%', //宽度
    //height: $(parent.document).find("#mainPanle").height() - 10 > 0 ? $(parent.document).find("#mainPanle").height() - 10 : 500, //高度
    height: $(document).height() - 20, //高度
    nowrap: false, //是否换行，True 就会把数据显示在一行里
    striped: true, //True 奇偶行使用不同背景色
    collapsible: false, //可折叠
    sortOrder: 'DESC', //排序类型
    remoteSort: false, //定义是否从服务器给数据排序
    fit: true,
    singleSelect: true, //单行选择
    frozenColumns: [[//冻结的列，不会随横向滚动轴移动
        { field: 'authorization_id', title: '权限编号', width: 60, sortable: true }

    ]],
    columns: [[
        { field: 'env_sn', title: '环境简称', width: 120, search: true,sortable: true },
        { field: 'env_name', title: '环境名称', width: 200, search: true,sortable: true },
        { field: 'env_id', title: '环境编号', width: 2, hidden: true, sortable: true },
        { field: 'authorization_name', title: '权限名称', width: 150, search: true, sortable: true }

    ]],
    toolbar: "#tab_toolbar",
    pagination: true, //是否开启分页
    pageNumber: 1, //默认索引页
    pageSize: 20, //默认一页数据条数
    rownumbers: true, //行号
    onSelect: function () { DBlClickRowGrid(); }
}
);
}

function DBlClickRowGrid() {
    var selected = $('#tab_list').datagrid('getSelected');
    if (selected != m_selected) {
        m_selected = selected;
        Edit_OnClick(selected);
        GetTree(selected);
    }
}

function GetTree(selected) {
    if (selected) {
        $("#tree_Menu").tree({
            url: GetTreeWSRRURL('e5e03694-cab8-418b-be53-3b5bc10d8ce8', 'HavaFlag') + "&XML="
                + GetGetJson([{ "env_id": selected.env_id, "type": "env_right", "authorization_id": selected.authorization_id }]),
            //url: "?action=tree&env_id=" + selected.env_id + "&authorization_id=" + selected.authorization_id,
            checkbox: true
        })
    }
}

function Edit_OnClick(selected) {
    if (selected) {
        //$.messager.alert("消息框", selected);
        $('#txtAuthorization_ID').val(selected.authorization_id);
        $('#txtAuthorization_ID_Show').val(selected.authorization_id);
        $('#cmbEnv_ID').combobox('setValue', selected.env_id);
        $('#cmbEnv_ID').combobox('disable');
        $('#txtAuthorization_Name').val(selected.authorization_name);
        $('#Div_Edit').panel({
            title: "修改数据"
        });
    }
    else {
        $('#tab_list').datagrid("clearSelections");
        m_selected = undefined;
        $('#txtAuthorization_ID').val("");
        $('#txtAuthorization_ID_Show').val("系统自动生成");
        $('#cmbEnv_ID').combobox('enable');
        $('#txtAuthorization_Name').val("");
        $('#Div_Edit').panel({
            title: "添加数据"
        });
    }
    $('#form_Edit').form('validate');
}

function Edit_Submnit() {
    $('#form_Edit').form('submit', {
        //url: '?action=Edit',
        onSubmit: function () {
            //$('#txtEnv_ID').val($('#cmbEnv_ID').combobox('getValue'));
            //return $('#form_Edit').form('validate');
            if ($('#form_Edit').form('validate') == false) {
                return false;
            }
            var data = $('#form_Edit').serializeArray();
            var txtAuthorization_ID_Show = $('#txtAuthorization_ID_Show').attr("value");
            var XMLData;
            if (txtAuthorization_ID_Show == "系统自动生成") {
                XMLData = GetFormJson(data, 'INSERT');
            }
            else {
                XMLData = GetFormJson(data, 'EDIT');
            }
            //alert(XMLData);
            $.ajax({
                url: GetWSRRURL('59f31018-58d8-429b-90bd-e8ad0a91da94'), //请求数据的页面
                type: 'post',
                async: true, //异步,
                data: { "XML": XMLData },
                success: function (result) {
                    //$.messager.alert("提示", result);
                    var result = eval("[" + result + "]");
                    $.messager.alert("提示", result[0].rows[0].message);
                    //$('#divEditTrue').dialog('close');
                    if (result[0].rows[0].result == 'True') {
                        $('#tab_list').datagrid('reload');
                    }
                },
                error: function () {
                    $.messager.alert("提示", "提交错误了！", 'error');
                }
            });
        }
    });
}

function Delete_OnClick() {
    if (!m_selected) {
        $.messager.alert("消息框", "请选择行", '');
        return;
    }
    $.messager.confirm('提示框', '你确定要删除吗?', function (r) {
        if (r) {
            $('#form_Edit').form('submit', {
                //url: '?action=Del',
                onSubmit: function () {
                    if ($('#form_Edit').form('validate') == false) {
                        return false;
                    }
                    var data = $('#form_Edit').serializeArray();
                    var txtAuthorization_ID_Show = $('#txtAuthorization_ID_Show').attr("value");
                    var XMLData;
                    XMLData = GetFormJson(data, 'DELETE');
                    //alert(XMLData);
                    $.ajax({
                        url: GetWSRRURL('59f31018-58d8-429b-90bd-e8ad0a91da94'), //请求数据的页面
                        type: 'post',
                        async: true, //异步,
                        data: { "XML": XMLData },
                        success: function (result) {
                            //$.messager.alert("提示", result);
                            var result = eval("[" + result + "]");
                            $.messager.alert("提示", result[0].rows[0].message);
                            //$('#divEditTrue').dialog('close');
                            if (result[0].rows[0].result == 'True') {
                                $('#tab_list').datagrid('reload');
                            }
                        },
                        error: function () {
                            $.messager.alert("提示", "提交错误了！", 'error');
                        }
                    });
                }
            });
        }

    })
}

//分配权限按钮
function Authorization_Submit() {
    var nodes = $('#tree_Menu').tree('getChecked');
    var s = '';
    for (var i = 0; i < nodes.length; i++) {
        if (s != '') s += ',';
        s += nodes[i].id;
    }
    $('#txtform_AuthorizationSubmit_Menulist').val(s);
    $('#txtform_AuthorizationSubmit_Env_ID').val(m_selected.env_id);
    $('#txtform_AuthorizationSubmit_Auz_ID').val(m_selected.authorization_id);
    $('#form_AuthorizationSubmit').form('submit', {
        //url: '?action=AuthorizationSubmit',
        //url: GetWSRRURL('59f31018-58d8-429b-90bd-e8ad0a91da94'),
        onSubmit: function () {
            if ($('#form_AuthorizationSubmit').form('validate') == false) {
                return false;
            }
            var data = $('#form_AuthorizationSubmit').serializeArray();
            var XMLData = GetFormJson(data, 'UPDATE');
            //alert(XMLData);
            $.ajax({
                url: GetWSRRURL('59f31018-58d8-429b-90bd-e8ad0a91da94'),
                type: 'post',
                async: true, //异步,
                data: { "XML": XMLData },
                success: function (result) {
                    //$.messager.alert("提示", result);
                    var result = eval("[" + result + "]");
                    $.messager.alert("提示", result[0].rows[0].message);
                    //$('#divEditTrue').dialog('close');
                    //if (result[0].rows[0].result == 'True') {
                    //    Env_Click(m_selected);//更新树
                    //}
                },
                error: function () {
                    $.messager.alert("提示", "提交错误了！", 'error');
                }
            });
        }
    });
}
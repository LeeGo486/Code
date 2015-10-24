var lastTabs;
var m_selected;
var m_selected_tree_node;
var MENU_TYPE;

$(function () { 
    InitGird();
    Env_Click();
    getMenuType();
    $('#btn_Submit').linkbutton({
        plain: false
    });

});

//初始化表格
function InitGird() {
    $('#tab_list').datagrid(
{
    title: '环境列表', //表格标题
    url: GetWSRRURL('6d171a64-a0b1-4468-a0d7-af219c35b049'), //请求数据的页面
    queryParams: { "XML": GetGetJson([{}]) },
    sortable: true,
    iconCls: '', //标题左边的图标  
    width: '90%', //宽度
    height: $(document).height() - 20, //高度
    nowrap: false, //是否换行，True 就会把数据显示在一行里
    striped: true, //True 奇偶行使用不同背景色
    collapsible: false, //可折叠
    sortOrder: 'DESC', //排序类型
    remoteSort: false, //定义是否从服务器给数据排序
    fit: true,
    singleSelect: true, //单行选择
    frozenColumns: [[//冻结的列，不会随横向滚动轴移动
        { field: 'env_id', title: '环境ID', width: 60, search: true },
        { field: 'env_sn', title: '环境简称', width: 100, search: true }
    ]],
    columns: [[
         { field: 'system_sn', title: '系统简称', width: 100, search: true },
        { field: 'system_name', title: '系统名称', width: 200, search: true }
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
        Env_Click(selected);
    }
    
}

function Env_Click(selected) {
    //e5e03694-cab8-418b-be53-3b5bc10d8ce8
    if (selected) {
        $("#tree_dept").tree({
            url: GetTreeWSRRURL('e5e03694-cab8-418b-be53-3b5bc10d8ce8') + "&XML=" + GetGetJson([{ "env_id": selected.env_id, "type": "env" }]),
            onDblClick: function (node) {
                m_selected_tree_node = node;
                Edit_Tree(true);
            },
            onContextMenu: function (e, node) {//右击
                Tree_onContextMenu(e, node);
            }
        })
    }
}

function Tree_onContextMenu(e, node) {
    e.preventDefault();
    this.m_selected_tree_node = node;
    $('#Menu_Tree').menu('show', {
        left: e.pageX,
        top: e.pageY
    });
}

function Delete_Tree() {
    if (m_selected_tree_node.id == "0") {
        $.messager.alert("消息框", "根目录不能删除", '');
        return false;
    }
    $.messager.confirm('提示框', '你确定要删除吗?', function (r) {
        if (r) {
            $('#txtMenu_Id').val(this.m_selected_tree_node.id);
            //alert(this.m_selected_tree_node.id);
            var data = [];
            data[data.length] = { "name": "TxtMenu_Id", "value": this.m_selected_tree_node.id }
            var XMLData = GetFormJson(data, 'DELETE');
            $('#form_Edit').form('submit', {
                onSubmit: function () {
                    //return $('#form_Edit').form('validate');
                    $.ajax({
                        url: GetWSRRURL('e5e03694-cab8-418b-be53-3b5bc10d8ce8'), //请求数据的页面
                        data: { "XML": XMLData },
                        type: 'post',
                        async: true, //异步,
                        success: function (result) {
                            //$.messager.alert("提示", result);
                            var result = eval("[" + result + "]");
                            $.messager.alert("提示", result[0].rows[0].message);
                            
                            if (result[0].rows[0].result == 'True') {
                                Env_Click(m_selected);//更新树
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

//ture 编辑  --- false 添加
function Edit_Tree(bIsEdit) {
    //$.messager.alert("消息框", MENU_TYPE);
    if (MENU_TYPE == "") {
        getMenuType();
    }
    $('#txtMenuType').combobox({
        //url: GetComboxWSRRURL('da174767-b356-444f-b289-f817f5a13047') +
        //    "&XML=" + GetGetJson([{ "common_config_type": escape("菜单类型") }]), //请求数据的页面
        required: true,
        valueField: 'id',
        textField: 'text',
        editable: false
    });
    $('#txtMenuType').combobox("loadData",eval('(' + MENU_TYPE + ')') );
    
    var node = this.m_selected_tree_node;
    if (bIsEdit) {//编辑
        if (m_selected_tree_node.id == "-1") {
            $.messager.alert("消息框", "根目录不能编辑", '');
            return false;
        }
        $('#txtMenu_Id').val(node.id);
        $('#txtMenu_Id_Show').val(node.id);
        $('#txtMenu_Code').val(node.attributes.Menu_Code);
        $('#txtMenu_Name').val(node.attributes.Menu_Name);
        $('#txtActionURL').val(node.attributes.ActionURL);
        $('#txtMenu_Father_ID').val(node.attributes.Menu_Father_ID);
        $('#txtEnv_ID').val(m_selected.env_id);
        $('#divEditTrue').dialog({
            modal: true,
            title: "菜单编辑"
        });
        $('#txtMenuType').combobox('setValue', node.attributes.MenuType);
        $('#txtMenu_Code').focus();
    }
    else {
        $('#txtMenu_Id').val("");
        $('#txtMenu_Id_Show').val("系统自动生成");
        $('#txtMenu_Code').val("");
        $('#txtMenu_Name').val("");
        $('#txtActionURL').val("");
        $('#txtMenu_Father_ID').val(node.id);
        $('#txtEnv_ID').val(m_selected.env_id);
        $('#divEditTrue').dialog({
            modal: true,
            title: "添加菜单"
        });
        $('#txtMenuType').combobox('setValue', '');
        $('#txtMenu_Code').focus();
    }
}
//提交
function Edit_Submnit() {
    $('#form_Edit').form('submit', {
        //url: GetWSRRURL('e5e03694-cab8-418b-be53-3b5bc10d8ce8'), //请求数据的页面
        onSubmit: function () {
            if ($('#form_Edit').form('validate') == false) {
                return false;
            }
            var data = $('#form_Edit').serializeArray();
            //$.messager.alert("提示", $('#txtMenu_Id_Show').attr("value"));
            var txtMenu_Id_Show = $('#txtMenu_Id_Show').attr("value");
            var XMLData;
            if (txtMenu_Id_Show == "系统自动生成") {
                XMLData = GetFormJson(data, 'INSERT');
            }
            else {
                XMLData = GetFormJson(data, 'EDIT');
            }
            //alert(XMLData);
            $.ajax({
                url: GetWSRRURL('e5e03694-cab8-418b-be53-3b5bc10d8ce8'), //请求数据的页面
                type: 'post',
                async: true, //异步,
                data: { "XML": XMLData },
                success: function (result) {
                    //$.messager.alert("提示", result);
                    var result = eval("[" + result + "]");
                    $.messager.alert("提示", result[0].rows[0].message);
                    $('#divEditTrue').dialog('close');
                    if (result[0].rows[0].result == 'True') {
                         Env_Click(m_selected);//更新树
                    }
                },
                error: function () {
                    $.messager.alert("提示", "提交错误了！", 'error');
                }
            });
        }
    });
}

//获取菜单类型
function getMenuType() {
    var result1 = "";
    $.ajax({
        url: GetComboxWSRRURL('da174767-b356-444f-b289-f817f5a13047') +
            "&XML=" + GetGetJson([{ "common_config_type": escape("菜单类型") }]), //请求数据的页面
        type: 'get',
        async: false, //同步
        success: function (result) {
            result1 = result;
        },
        error: function () {
            $.messager.alert("提示", "提交错误了！", 'error');
        }
    });
    MENU_TYPE = result1;
}
///郭琦琦 20140826
var 组织单元系统编号id;//组织机构单元编号
var 组织单元系统名称;//组织单元系统名称
var organizationCostCenert_body_id;//组织成本中心IDbody_id
var organization成本中心ID;//组织机构成本中心ID
var personlCostCenert_body_id;//人员成本中心IDbody_id
var m_columns;//列名
var selected; //人员信息选择行

$(function () {

    //初始化加载员工列名
    var htmlobj = $.ajax({
        url: GetGridColumnsWSRRURL('6b84f1e9-3124-468a-8c42-6cc773c36e8e', "120", "false", "false"),

        //var urlCol = GetGridColumnsWSRRURL('6b84f1e9-3124-468a-8c42-6cc773c36e8e', "80", "false", "false") + XMLData

        data: "XML=" + GetFormJson([], 'getPersonl'), async: false
    });
    var Text = $.parseJSON(htmlobj.responseText);
    m_columns = Text.Col;

    //获取组织架构树
    $('#treeOrganization').tree({
        checkbox: false,
        url: GetTreeWSRRURL('7c1f7337-972b-456c-961a-598a7da5e086'),
        onClick: function (node) {
            $(this).tree('toggle', node.target);//单击的时候打开树
        },
        onContextMenu: function (e, node) { Tree_onContextMenu(e, node); },
        onLoadSuccess: function (node, data) {
            if (data.Error != null) {
                $.messager.alert("提示", data.error, 'error');
            }
            else {
                $('#treeOrganization').tree('collapseAll');
            }
        }
    });

    //加载成本中心编号下拉支持模糊查询
    $('#txt成本中心').combogrid({
        panelWidth: 240,
        url: GetWSRRURL('a5ce3b96-4b3d-4385-b11b-0c3887a6e41d') + "&XML=" + GetFormJson([], 'GETCOSTCENTER'),
        idField: '系统编号',
        textField: '编码',
        mode: 'remote',
        required: true,
        columns: [[
                { field: '系统编号', title: '系统编号', width: 80, hidden: true },
                { field: '编码', title: '编码', width: 50 },
                { field: '名称', title: '名称', width: 165 }
        ]],
        onSelect: function (rowIndex, rowData) {
            var 系统编号 = rowData['系统编号'];
            $('#txt成本中心ID').val(系统编号);
        }
    });

    //加载人成本中心编号下拉支持模糊查询
    $('#txt人成本中心').combogrid({
        panelWidth: 240,
        url: GetWSRRURL('a5ce3b96-4b3d-4385-b11b-0c3887a6e41d') + "&XML=" + GetFormJson([], 'GETCOSTCENTER'),
        idField: '系统编号',
        textField: '编码',
        mode: 'remote',
        required: true,
        columns: [[
                { field: '系统编号', title: '系统编号', width: 80, hidden: true },
                { field: '编码', title: '编码', width: 50 },
                { field: '名称', title: '名称', width: 165 }
        ]],
        onSelect: function (rowIndex, rowData) {
            var 系统编号 = rowData['系统编号'];
            $('#txt人成本中心ID').val(系统编号);
        }
    });

    $('#divEditOrganizationCostCenert').hide()
    $('#divEditPersonlCostCenert').hide();
})
//右击树
function Tree_onContextMenu(e, node) {
    e.preventDefault();
    this.m_selected_tree_node = node;
    $('#Menu_Tree').menu('show', {
        left: e.pageX,
        top: e.pageY
    });
    组织单元系统编号id = node.id;
    组织单元系统名称 = node.text;
    organizationCostCenert_body_id = node.attributes.ORGBody_ID;
    organization成本中心ID = node.attributes.成本中心ID;

}

//右击树加载员工信息
function searchPersonl() {
    InitGird();
}

//加载部门对应的人员
function InitGird() {
    ClearGrid("#tab_list");
    var data = [];
    data[data.length] = { "name": "txt现所在组织单元系统编号", "value": 组织单元系统编号id };
    var xmlData = GetFormJson(data, 'getPersonl');
    var url = GetWSRRURL('6b84f1e9-3124-468a-8c42-6cc773c36e8e')

    //获取人员所有数据
    var htmlobj = $.ajax({
        url: url,
        data: { "XML": xmlData },
        type: 'post',
        async: false
    });
    var Text = $.parseJSON(htmlobj.responseText);

    //生成数据
    $('#tab_list').datagrid(
            {
                data: Text,
                title: '人员信息', //表格标题
                nowrap: true, //是否换行，True 就会把数据显示在一行里
                striped: true, //True 奇偶行使用不同背景色
                singleSelect: true, //单行选择
                fit: true,
                columns: eval(m_columns),
                pagination: true, //是否开启分页
                pageSize: 20,//默认一页数据条数
                //onLoadSuccess: function (data) { $.messager.progress('close'); },
                //onLoadError: function (data) { $.messager.progress('close'); }
                onRowContextMenu: onRowContextMenu
            });

    var $dg = $('#tab_list');
    //隐藏特殊列
    $dg.datagrid("hideColumn", "timestamps");
    $dg.datagrid("hideColumn", "rowindex");
    $dg.datagrid("hideColumn", "body_id");
    $dg.datagrid("hideColumn", "成本中心id");
    
}

//右击树加载部门成本中心维护界面
function editCostCenter() {

    $('#divEditOrganizationCostCenert').show().window({
        title: "组织机构成本中心维护",
        //maximized: true,
        top: 20,
        width: 400,
        height: 200,
        modal: true
    });
    $('#txt成本中心ID').val(organization成本中心ID);
    $('#txt组织单元系统编号').val(组织单元系统编号id);
    $('#txt组织单元系统名称').val(组织单元系统名称);
    $('#txt成本中心').combogrid('setValue', organization成本中心ID);
}

//组织成本中心提交
function 组织_Submit() {
    $('#form_EditOrganizationCostCenert').form('submit', {
        onSubmit: function (e) {

            if ($('#form_EditOrganizationCostCenert').form('validate') == false) {
                $.messager.alert("提示", "请把必填项填完！", 'error');
                return false;
            }
            $('#divEditOrganizationCostCenert').window('close');

            var data = [];
            data[data.length] = { "name": "txtbody_ID", "value": organizationCostCenert_body_id }
            data[data.length] = { "name": "txt成本中心ID", "value": $('#txt成本中心ID').val() }

            var XMLData = GetFormJson(data, 'UPDATE');
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('6888a4ba-6747-4659-8d27-7de4274749a6'),
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
                            updaterole();
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

            return false;
        }
    });
}

//更新组织之后修改组织节点信息
function updaterole(nodetext) {
    var node = $("#treeOrganization").tree("getSelected");
    if (node) {
        node.attributes.成本中心ID = $('#txt成本中心ID').val();
        $("#treeOrganization").tree("update", node);
    }
}

//右击修改人成本中心
function onRowContextMenu(e, rowIndex, rowData) {
    e.preventDefault();

    $('#tab_list').datagrid('selectRow', rowIndex).datagrid('getSelected')
    selected = $("#tab_list").datagrid('getSelected'); //获取所有行集合对象
    //selected[rowIndex].id; //index为当前右键行的索引，指向当前行对象
    //if (!selected) {
    //    alert("请选择一行!");
    //    return;
    //}
    $('#mm').menu('show', {
        left: e.pageX,
        top: e.pageY
    });
}

//修改人成本中心
function editPersonlCostCenter() {

    $('#divEditPersonlCostCenert').show().window({
        title: "人成本中心维护",
        //maximized: true,
        top: 20,
        width: 440,
        height: 200,
        modal: true
    });

    personlCostCenert_body_id = selected.body_id;//人员成本中心IDbody_id
    $('#txt人成本中心ID').val(selected.成本中心id);
    $('#txt现所在组织单元名称').val(selected.现所在组织单元名称);
    $('#txt姓名').val(selected.姓名);
    $('#txt人成本中心').combogrid('setValue', selected.成本中心id);
}

//人成本中心提交
function 人员_Submit() {
    $('#form_EditPersonlCostCenert').form('submit', {
        onSubmit: function (e) {

            if ($('#form_EditPersonlCostCenert').form('validate') == false) {
                $.messager.alert("提示", "请把必填项填完！", 'error');
                return false;
            }
            $('#divEditPersonlCostCenert').window('close');

            var data = [];
            data[data.length] = { "name": "txtbody_ID", "value": personlCostCenert_body_id }
            data[data.length] = { "name": "txt成本中心ID", "value": $('#txt人成本中心ID').val() }

            var XMLData = GetFormJson(data, 'UPDATE');
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('57ddf3b1-a0cf-4e26-adba-48c25e87307d'),
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
                            InitGird();
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

            return false;
        }
    });
}

//取消
function cancel(type) {
    if (type == '组织成本中心取消') {
        $('#divEditOrganizationCostCenert').window('close');
    }
    else if (type == '人成本中心取消') {
        $('#divEditPersonlCostCenert').window('close');
    }
}

function loadFrame(node) {

    var obj = new Object();
    obj.id = "280";
    obj.url = "/WEB/MDM2/Organization_Personl_CostCenterEdit.html";
    obj.attributes = new Object();
    obj.attributes.ActionURL = "/WEB/MDM2/Organization_Personl_CostCenterEdit.html";
    obj.text = "成本中心管理";

    var url = obj.url;
    if (url == null || url == "") {
        return;
    }

    if (url.indexOf("?") > 0) {
        url += "&vexmenuid=" + obj.id;
    }
    else {
        url += "?vexmenuid=" + obj.id;
    }
    var title = obj.text;

    window.parent.loadFrame(obj);
}

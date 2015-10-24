var m_columns = null;
var editIndex;
var Province = "V_0014";//省
var divPrefectureInfo = "V_0015";//地级市
var divcityInfo = "V_0016";//县级市
var lastTabs;
var selected_Row;
var selected_PrefectureList_Row;
var selected_city_Row;
var index;
var rowData;
//初始化
$(function () {
    InitGird();
});

//初始化表格加载省数据
function InitGird() {

    $('#tab_list').datagrid(
            {
                title: '省份', //表格标题
                url: GetWSRRURL('1a2ec2ce-f85d-4b68-a63e-60cdf22b7c2b'),
                //+ "&Where=AreaType='" + escape("省份") + "'",
                queryParams: { "XML": GetGetJson([{ "TableName": Province }]) },
                nowrap: true, //是否换行，True 就会把数据显示在一行里
                striped: true, //True 奇偶行使用不同背景色
                singleSelect: true, //单行选择
                fit: true,
                frozen: true,
                fitColumns: true,
                pagination: true, //是否开启分页
                pageSize: 10, //默认一页数据条数
                toolbar: "#tab_toolbar",
                onDblClickRow: function () { onDblClickRow(false); },
                onClickRow: function () { onClickRowGrid(); },
                frozenColumns: [[
                    { field: 'body_id', title: 'body_id', width: 200, search: true, sortable: true },
                    { field: '国家编号', title: '国家编号', width: 200, search: true, sortable: true },
                    { field: '编号', title: '编号', width: 200, search: true, sortable: true },
                    { field: '名称', title: '名称', width: 200, search: true, sortable: true }
                ]],
                toolbar: [
                {
                    id: 'btn_Add',
                    text: '添加',
                    iconCls: 'icon-edit',
                    handler: function () {
                        onDblClickRow(true);//是否新增
                    }
                },
                {
                    id: 'btn_Delete',
                    text: '删除',
                    iconCls: 'icon-remove',
                    handler: function () {
                        Delete()
                    }
                }
                ]
            }
        );

    var $dg = $('#tab_list');

    $dg.datagrid("hideColumn", "国家编号");
    //$dg.datagrid("hideColumn", "timestamps");
    $dg.datagrid("hideColumn", "body_id");

}

//省增加或者修改弹窗
function onDblClickRow(isadd) {

    //var selected = $('#tab_list').datagrid('getSelected');


    $('#form_Edit').window({
        top: 20,
        width: 350,
        height: 530,
        modal: true

    });

    if (isadd) {
        $('#tab_list').datagrid('selectRow', 0);
        $('#txtBody_ID').val("");
        $('#txt编号').val("");
        $('#txt名称').val("");
        //document.getElementByName("txt编号").setAttribute("readOnly", true);
    }

    else {
        var selected = $('#tab_list').datagrid('getSelected');
        $('#txtBody_ID').val(selected.body_id);
        $('#txt编号').val(selected.编号);
        $('#txt名称').val(selected.名称);
    }
}

//省新增修改提交
function Edit_Submit() {
    $('#form_Edit').form('submit', {
        onSubmit: function (e) {

            if ($('#form_Edit').form('validate') == false) {
                $.messager.alert("提示", "请把必填项填完！", 'error');
                return false;
            }
            $('#form_Edit').window('close');
            var data = $('#form_Edit').serializeArray();

            var wwwww = document.getElementsByName("txtBody_ID")[0].value;
            if (wwwww == "") {

                data[data.length] = { "name": "txtBody_ID", "value": "" }
                //data[data.length] = { "name": "txt编号", "value": $('#txt编号').val }
                //data[data.length] = { "name": "txt名称", "value": $('#txt名称').val }
                var XMLData = GetFormJson(data, 'INSERT');
            }
            else {
                var selected_Row = $('#tab_list').datagrid('getSelected');
                data[data.length] = { "name": "txtbody_id", "value": selected_Row.body_id }
                //data[data.length] = { "name": "txt编号", "value": selected_Row.编号 }
                var XMLData = GetFormJson(data, 'UPDATE');
            }

            //alert(XMLData);
            //return;
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('a9cb9080-b07b-4c7c-b47d-52efc1bf9a92'),
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
                            ClearGrid("#divPrefectureInfo");
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

//省删除
function Delete() {

    var selected = $('#tab_list').datagrid('getSelected');
    if (!selected) {
        alert('请选择一行');
        return;
    }
    var deleteMessage = '删除提交后数据无法恢复，你确定要删除吗?';
    $.messager.confirm('提示框', deleteMessage, function (r) {
        if (r) {
            var data = [];
            data[data.length] = { "name": "txtBody_id", "value": selected.body_id }
            var XMLData = GetFormJson(data, 'DELETE');

            $.ajax({
                url: GetWSRRURL('a9cb9080-b07b-4c7c-b47d-52efc1bf9a92'),
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
                            InitGird();
                            ClearGrid("#divcityInfo");
                            ClearGrid("#divPrefectureInfo");
                            $.messager.alert("提示", result[0].rows[0].message);
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


}
 
//点击省，关联出相应的地级市数据
function onClickRowGrid() {
    var selected = $('#tab_list').datagrid('getSelected');
    selected_Row = selected;
    InitPrefectureListInfo();//获取地级市数据
    ClearGrid("#divcityInfo");//清理县级市数据
    ClearGrid("#divPrefectureInfo")
}
 

//初始化参数信息加载地级市
function InitPrefectureListInfo() {
    $('#divPrefectureInfo').datagrid(
            {
                //url: GetWSRRURL('1a2ec2ce-f85d-4b68-a63e-60cdf22b7c2b') + "&Where=省编号='" + escape(selected_Row.编号) + "'",
                url: GetWSRRURL('1a2ec2ce-f85d-4b68-a63e-60cdf22b7c2b') + "&Where=" + escape("省编号") + "='" + escape(selected_Row.编号) + "'",
                queryParams: { "XML": GetGetJson([{ "TableName": divPrefectureInfo }]) },
                border: false,
                singleSelect: true,
                //striped: true,
                fit: true,
                fitColumns: true,
                pagination: true, //是否开启分页
                pageSize: 5, //默认一页数据条数
                onDblClickRow: function () { onDblClickRow1(false); },

                columns: [[
                    //{ field: 'body_id', title: 'body_id', width: 30 },
                    //{ field: 'timestamps', title: 'timestamps', width: 30, search: true, sortable: true },
                    { field: '编号', title: '编号', width: 30, search: true, sortable: true },
                    { field: '名称', title: '名称', width: 30, search: true, sortable: true },
                    //{ field: '省编号', title: '省编号', width: 120, search: true, sortable: true },
                    { field: '城市等级', title: '城市等级', width: 50, search: true, sortable: true }
                ]],
                onClickRow: function () { onClickRowGrid2(); },

                toolbar: [
                {
                    id: 'btn_AddPrefecture',
                    text: '添加',
                    iconCls: 'icon-add',
                    handler: function () {
                        onDblClickRow1(true)
                    }
                },
                {
                    id: 'btn_DeletePrefecture',
                    text: '删除',
                    iconCls: 'icon-remove',
                    handler: function () {
                        Delete地级市()
                    }
                }
                ]

            }
            );

}   

//地级市增加或者修改弹窗
function onDblClickRow1(isadd) {

    //var selected_PrefectureList_Row = $('#divPrefectureInfo').datagrid('getSelected');

    if (isadd) {

        var 省份临时 = $('#tab_list').datagrid('getSelected');
        if (!省份临时) {
           
            alert('请选择相应的省份');
            return;
        }

        $('#form_PrefectureEdit').window({
            top: 20,
            width: 410,
            height: 530,
            modal: true

        });

        $('#divPrefectureInfo').datagrid('selectRow', 0);
        selected_PrefectureList_Row = $('#divPrefectureInfo').datagrid('getSelected');
        $('#txt名称').val("");
        $('#txt编号').val("");
        $('#txt城市等级').val("");
        $('#txtBody_ID_0015').val("");
        $('#txt省编号').val("新增无需输入");
    }
    else {

        $('#form_PrefectureEdit').window({
            top: 20,
            width: 410,
            height: 530,
            modal: true

        });
        var selected_PrefectureList_Row = $('#divPrefectureInfo').datagrid('getSelected');

        $('#txt名称').val(selected_PrefectureList_Row.名称);
        $('#txt编号').val(selected_PrefectureList_Row.编号);
        $('#txt省编号').val(selected_PrefectureList_Row.省编号);
        $('#txt城市等级').val(selected_PrefectureList_Row.城市等级);
        $('#txtBody_ID_0015').val(selected_PrefectureList_Row.body_id_0015);
        $('#txtBody_ID_0014').val(selected_PrefectureList_Row.body_id_0014);
    }

}

//地级市新增修改提交
function btn_Prefecture_Submit() {
    $('#form_PrefectureEdit').form('submit', {
        onSubmit: function (e) {

            if ($('#form_PrefectureEdit').form('validate') == false) {
                $.messager.alert("提示", "请把必填项填完！", 'error');
                return false;
            }
            $('#form_PrefectureEdit').window('close');
            var data = $('#form_PrefectureEdit').serializeArray();

            //$('#divPrefectureInfo').datagrid('selectRow', 0);
            test = $('#tab_list').datagrid('getSelected');

            var dijishi = document.getElementsByName("txtBody_ID_0015")[0].value;
            if (dijishi == "") {

                data[data.length] = { "name": "txtBody_ID_0015", "value": "" }
                data[data.length] = { "name": "txtBody_ID_0014", "value": test.body_id }
                data[data.length] = { "name": "txtBody_ID", "value": "" }
                var XMLData = GetFormJson(data, 'INSERT');
            }
            else {
                data[data.length] = { "name": "txtbody_id_0014", "value": selected_PrefectureList_Row.body_id_0014 }
                data[data.length] = { "name": "txt省编号", "value": selected_PrefectureList_Row.省编号 }
                data[data.length] = { "name": "txtBody_ID", "value": selected_PrefectureList_Row.body_id }
                data[data.length] = { "name": "txtBody_ID_0015", "value": selected_PrefectureList_Row.body_id_0015 }
                var XMLData = GetFormJson(data, 'UPDATE');
            }

            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('53c2c976-a240-4470-afa0-81e831cc5399'),
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
                            $('#divPrefectureInfo').datagrid("unselectAll"); 
                            $('#divPrefectureInfo').datagrid("reload");
                            ClearGrid("#divcityInfo");

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

//地级市删除 
function Delete地级市() {

    var selected = $('#divPrefectureInfo').datagrid('getSelected');
    if (!selected) {
        alert('请选择一行');
        return;
    }
    var deleteMessage = '删除提交后数据无法恢复，你确定要删除吗?';
    $.messager.confirm('提示框', deleteMessage, function (r) {
        if (r) {
            var data = [];
            data[data.length] = { "name": "txtBody_id_0015", "value": selected.body_id_0015 }
            data[data.length] = { "name": "txtBody_id", "value": selected.body_id }
            //data[data.length] = { "name": "txtBody_id_0014", "value": selected.body_id_0014 }
            var XMLData = GetFormJson(data, 'DELETE');

            $.ajax({
                url: GetWSRRURL('53c2c976-a240-4470-afa0-81e831cc5399'),
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

                            $('#divPrefectureInfo').datagrid("unselectAll");
                            ClearGrid("#divcityInfo");
                            ClearGrid("#divPrefectureInfo");
                            InitPrefectureListInfo();


                            $.messager.alert("提示", result[0].rows[0].message);
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


}
  
//点击地级市关联出县级市
function onClickRowGrid2() {
    var selected = $('#divPrefectureInfo').datagrid('getSelected');

    selected_PrefectureList_Row = selected;
    ClearGrid("#divcityInfo");
    InitcityInfo()//获取县级市数据

}

//初始化参数信息加载县级市数据
function InitcityInfo() {
    $('#divcityInfo').datagrid(
            {
                url: GetWSRRURL('1a2ec2ce-f85d-4b68-a63e-60cdf22b7c2b') + "&Where=" + escape("地级市编号") + "='" + escape(selected_PrefectureList_Row.编号) + "'",
                queryParams: { "XML": GetGetJson([{ "TableName": divcityInfo }]) },
                nowrap: true,
                fit: true,
                fitColumns: true,
                //striped: true,
                singleSelect: true, //单行选择
                pagination: true, //是否开启分页
                pageSize: 5, //默认一页数据条数
                onDblClickRow: function () { onDblClickRow3(false); },
                columns: [[
                    { field: '编号', title: '编号', width: 50 },
                    { field: '名称', title: '名称', width: 120 },
                    { field: '城市等级', title: '城市等级值', width: 120 }
                ]],
                toolbar: [
                {
                    id: 'btn_AddCity',
                    text: '添加',
                    iconCls: 'icon-add',
                    handler: function () {
                        onDblClickRow3(true)
                    }
                },
                {
                    id: 'btn_DeleteCity',
                    text: '删除',
                    iconCls: 'icon-remove',
                    handler: function () {

                        Delete县级市()
                    }
                }
                ]
            }
            );

}

//县级市增加或者修改弹窗
function onDblClickRow3(isadd) {

   

    if (isadd) {
        var 地级市临时 = $('#divPrefectureInfo').datagrid('getSelected');
        if (!地级市临时) {
           
                alert('请选择相应的地级市');
                return;
        }
        $('#form_City_Edit').window({
            top: 20,
            width: 400,
            height: 530,
            modal: true

        });

        $('#divcityInfo').datagrid('selectRow', 0);
        selected_CityList_Row = $('#divcityInfo').datagrid('getSelected');
        $('#txt名称').val("");
        $('#txt编号').val("");
        $('#txt城市等级').val("");
        $('#txtBody_ID_0016').val("");
        $('#txt地级市编号').val("新增无需输入");

    }

    else {

        $('#form_City_Edit').window({
            top: 20,
            width: 400,
            height: 530,
            modal: true

        });
        var selected_CityList_Row = $('#divcityInfo').datagrid('getSelected');
        $('#txt名称').val(selected_CityList_Row.名称);
        $('#txt编号').val(selected_CityList_Row.编号);
        $('#txt地级市编号').val(selected_CityList_Row.地级市编号);
        $('#txt城市等级').val(selected_CityList_Row.城市等级);
        //$('#txtBody_ID_0015').val(selected_CityList_Row.body_id_0015);
        $('#txtBody_ID_0016').val(selected_CityList_Row.body_id_0016);
    }
}

//县级市新增修改提交
function Edit_City_Submit() {
    $('#form_City_Edit').form('submit', {
        onSubmit: function (e) {
            if ($('#form_City_Edit').form('validate') == false) {
                $.messager.alert("提示", "请把必填项填完！", 'error');
                return false;
            }
            $('#form_City_Edit').window('close');
            var data = $('#form_City_Edit').serializeArray();

            var selected_city_Row = $('#divcityInfo').datagrid('getSelected');
            var test2 = $('#divPrefectureInfo').datagrid('getSelected');


            var xianjishi = document.getElementsByName("txtBody_ID_0016")[0].value;
            if (xianjishi == "") {
                data[data.length] = { "name": "txtBody_ID_0016", "value": "" }
                data[data.length] = { "name": "txtbody_id_0015", "value": test2.body_id_0015 }
                data[data.length] = { "name": "txtBody_ID", "value": "" }
                var XMLData = GetFormJson(data, 'INSERT');
            }
            else {
                data[data.length] = { "name": "txtbody_id_0015", "value": selected_city_Row.body_id_0015 }
                data[data.length] = { "name": "txt地级市编号", "value": selected_city_Row.地级市编号 }
                data[data.length] = { "name": "txtBody_ID", "value": selected_city_Row.body_id }
                data[data.length] = { "name": "txtBody_ID_0016", "value": selected_city_Row.body_id_0016 }
                var XMLData = GetFormJson(data, 'UPDATE');
            }

            //alert(XMLData);
            //return;
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('dc635aa8-424b-4328-8ec0-060940117499'),
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
                            $('#divcityInfo').datagrid("unselectAll"); 
                            //InitcityInfo();
                            $('#divcityInfo').datagrid("reload");

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

//县级市删除
function Delete县级市() {

    var selected = $('#divcityInfo').datagrid('getSelected');
    if (!selected) {
        alert('请选择一行');
        return;
    }
    var deleteMessage = '删除提交后数据无法恢复，你确定要删除吗?';
    $.messager.confirm('提示框', deleteMessage, function (r) {
        if (r) {
            var data = [];
            //data[data.length] = { "name": "txtBody_id_0015", "value": selected.body_id_0015 }
            data[data.length] = { "name": "txtBody_id", "value": selected.body_id }
            data[data.length] = { "name": "txtBody_id_0016", "value": selected.body_id_0016 }
            var XMLData = GetFormJson(data, 'DELETE');

            $.ajax({
                url: GetWSRRURL('dc635aa8-424b-4328-8ec0-060940117499'),
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
                            $('#divcityInfo').datagrid("unselectAll"); 
                            ClearGrid("#divcityInfo");
                            InitcityInfo();
                            $.messager.alert("提示", result[0].rows[0].message);
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


}


//清除Grid数据
function ClearGrid(gridName) {

    try {
        $(gridName).datagrid('loadData', { total: 0, rows: [] });
    } catch (e) {
        return;
    }
}


function Cancel1() {
    $('#form_Edit').window('close')

}
function Cancel2() {
    $('#form_PrefectureEdit').window('close')

}
function Cancel3() {
    $('#form_City_Edit').window('close')

}
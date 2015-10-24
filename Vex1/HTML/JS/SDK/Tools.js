/// JS名：Tools.js
/// 说明：SDK工具
/// 创建人：郭琦琦 
/// 创建日期：2014-06-06


var selected_Row;
$(function () {
    //文件上传相关-----------------
    var button = $('#btnUp'), interval;
    new AjaxUpload(button, {
        //action: 'upload-test.php',文件上传服务器端执行的地址
        action: '/Handler_Upload.ashx?filePath=SDK',
        name: 'myfile',
        onError:function(daa)
        {
            alert("error");
        },
        onSubmit: function (file, ext) {
            //if (!(ext && /^(jpg|jpeg|JPG|JPEG|PNG|GIF|gif|png)$/.test(ext))) {
            //    alert('图片格式不正确,请选择 jpg,gif,png 格式的文件!', '系统提示');
            //    return false;
            //}
            // change button text, when user selects file
            button.val('文件上传中');
            // If you want to allow uploading only 1 file at time,
            // you can disable upload button
            this.disable();
            // Uploding -> Uploading. -> Uploading...
            interval = window.setInterval(function () {
                var text = button.val();
                if (text.length < 10) {
                    button.val(text + '.');
                } else {
                    button.val('文件上传中');
                }
            }, 200);
        },
        onComplete: function (file, response) {
            //file 本地文件名称，response 服务器端传回的信息
            button.val('成功');

            window.clearInterval(interval);

            // enable upload button
            this.enable();
            var k = response.replace("<pre>", "").replace("</pre>", "").replace("<PRE>", "").replace("</PRE>", "");

            try {
                var result = eval("[" + k + "]");
                if (result[0].Error) {
                    $.messager.progress('close');

                    $.messager.alert("系统错误", result[0].Error, 'error');
                }
                else if (result[0].rows[0].result == "False") {
                    $.messager.progress('close');

                    $.messager.alert("提示", result[0].rows[0].message, 'error');
                }
                else {
                    $("#txtpcf_downloadurl").val(result[0].rows[0].message);
                    $("#txtpcf_filesize").val(result[0].rows[1].message);

                }
            } catch (ex) {
                $.messager.progress('close');

                $.messager.alert("提示", ex, 'error');
            }
        }
    });
    //文件上传相关-----------------
    InitGird();
})
//加载数据
function InitGird() {
    $('#tab_list').datagrid(
            {
                title: 'HZYTOOLS', //表格标题
                url: GetWSRRURL('954f5d1c-2cfe-4239-824c-3dc34613c8bb') + "&XML=" + GetFormJson([], 'ToolsInfo'),
                sortName: 'pdc_code', //排序字段
                idField: 'pdc_id', //标识字段,主键
                width: '90%', //宽度
                height: $(document).height() - 100, //高度
                nowrap: false, //是否换行，True 就会把数据显示在一行里
                remoteSort: true, //定义是否从服务器给数据排序
                collapsible: false, //可折叠
                sortOrder: 'DESC', //排序类型
                sortable: true,
                striped: true, //True 奇偶行使用不同背景色
                singleSelect: true, //单行选择
                fit: true,
                pagination: true, //是否开启分页
                pageSize: 20, //默认一页数据条数 
                rownumbers: true,//行号
                onClickRow: function () { onClickRowGrid(); },
                //onDblClickRow: onDblClickRow,
                columns: [[
                    { field: 'PDC_Code', title: '产品端编号', width: 100, search: true, sortable: true },
                    { field: 'PDC_Name', title: '产品端名称', width: 150, search: true, sortable: true },
                    { field: 'PDC_Desp', title: '产品端描述', width: 150, search: true },
                    { field: 'PCF_DownLoadURL', title: '最新版下载', width: 80, search: true, sortable: true, formatter: rowFormater }
                ]]
            });
}
function rowFormater(value, row, index) {
    if (row.pcf_downloadurl == "") {
        return "无"
    }
    else {
        return "<a href='" + row.pcf_downloadurl + "' target='_blank'>下载</a>";
    }
}
function rowFormaterForKB(value, row, index) {
    if (row.pcf_filesize == "") {
        return ""
    }
    else {
        return (row.pcf_filesize * 1 / 1024).toFixed(0) + "KB";
    }
}



//function onDblClickRow() {
//    AddNew('修改');
//}
//修改不能对产品进行新增修改
//function AddNew(type) {
//    if (type == '新增') {
//        $('#divAddTools').window({
//            title: "新增",
//            top: 100,
//            width: 430,
//            height: 260,
//            modal: true
//        });
//        $('#txtts0_productsid').val("系统自动生成");//编号
//        $('#txtts0_name').val("");//产品名称
//        $('#txtts0_productsexplain').val("");//主表说明
//        $('#form_AddTools').form('validate')
//    }
//    else {
//        var strSelectRow = $('#tab_list').datagrid('getSelected')
//        if (!strSelectRow) {
//            alert('请选择一行');
//            return;
//        }
//        $('#divAddTools').window({
//            title: "修改",
//            top: 100,
//            width: 430,
//            height: 260,
//            modal: true
//        });

//        var reg = new RegExp("ㄧ", "g");
//        var strts0_productsexplain = strSelectRow.ts0_productsexplain.replace(reg, "\n");

//        $('#txtts0_name').val(strSelectRow.ts0_name);//产品名称
//        $('#txtts0_productsid').val(strSelectRow.ts0_productsid);//编号
//        $('#txtts0_productsexplain').val(unescape(strts0_productsexplain));//主表说明
//        $('#form_AddTools').form('validate')
//    }
//}
function onClickRowGrid() {
    var selected = $('#tab_list').datagrid('getSelected');
    selected_Row = selected;
    ClearGrid("#tab_list_Detail");
    InitDetailListInfo();
}
function Cancel(type) {
    if (type == 'A2') {
        $('#divtoolsdetail').window('close');
    }
}
//按照需求取消产品保存呢
//function FormHeadSubmit() {
//    var strts0_productsid = $('#txtts0_productsid').val();//产品编号
//    if ($('#form_AddTools').form('validate') == false) {
//        $.messager.alert("提示", "请把必填项填完！", 'error');
//        return false;
//    }

//    $('#divAddTools').window('close');
//    var data = $('#form_AddTools').serializeArray();
//    data[data.length] = { "name": "txtts0_productsid", "value": strts0_productsid }

//    var XMLData = GetFormJson(data, 'ToolsEdit');
//    //return;
//    $.messager.progress({ title: '请稍后', msg: '处理中' });
//    $.ajax({
//        url: GetWSRRURL('954f5d1c-2cfe-4239-824c-3dc34613c8bb'),
//        type: 'post',
//        async: true, //异步,
//        data: { "XML": XMLData },
//        success: function (result) {
//            try {
//                var result = eval("[" + result + "]");
//                if (result[0].Error) {
//                    $.messager.progress('close');
//                    $.messager.alert("系统错误", result[0].Error, 'error');
//                }
//                else if (result[0].rows[0].result == "False") {
//                    $.messager.alert("提示", result[0].rows[0].message, 'error');
//                }
//                else {
//                    $.messager.progress('close');
//                    $('#tab_list').datagrid("unselectAll");
//                    $('#tab_list').datagrid("reload");
//                    ClearGrid("#tab_list_Detail");
//                    $.messager.alert("提示", result[0].rows[0].message);
//                }
//            } catch (ex) {
//                $.messager.alert("提示", ex, 'error');
//            }
//        },
//        error: function () {
//            $.messager.alert("提示", "提交错误了！", 'error');
//        }
//    });
//    return false;
//}

//加载产品版本列表
function InitDetailListInfo() {
    $('#tab_list_Detail').datagrid(
            {
                url: GetWSRRURL('954f5d1c-2cfe-4239-824c-3dc34613c8bb') + "&pagerows=20000&XML=" + GetFormJson([], 'GetDetail') + "&Where=PCF_PDC_ID='" + selected_Row.pdc_id + "'",
                sortName: 'PCF_Rgdt', //排序字段
                idField: 'PCF_ID', //标识字段,主键
                border: false,
                singleSelect: true,
                sortOrder: 'DESC', //排序类型
                fit: true,
                fitColumns: true,
                //pagination: true, //是否开启分页
                //pageSize: 5, //默认一页数据条数
                rownumbers: true,//行号
                nowrap: false, //是否换行，True 就会把数据显示在一行里
                onDblClickRow: function () { onDoubleClick() },
                columns: [[
                    { field: 'PCF_Name', title: '产品端文件名称', width: 90, search: true, sortable: true },
                    { field: 'PCF_Version', title: '产品端文件版本', width: 90 },
                    { field: 'PCF_Desp', title: '产品端文件描述', width: 130, search: true },
                    { field: 'PCF_FileSize', title: '产品端文件大小', width: 90,formatter: rowFormaterForKB },
                    { field: 'PCF_DownLoadURL', title: '产品端文件下载地址', width: 100, sortable: true, formatter: rowFormater },
                ]],
                onLoadSuccess: function () {
                    $('#tab_list_Detail').datagrid("clearSelections");
                },
                toolbar: [
                {
                    id: 'btn_AddDetail',
                    text: '新增',
                    iconCls: 'icon-add',
                    handler: function () {
                        AddDetail('新增子表');
                    }
                },
                {
                    id: 'btn_EditDetail',
                    text: '修改',
                    iconCls: 'icon-edit',
                    handler: function () {
                        AddDetail('修改子表');
                    }
                },
                {
                    id: 'btn_DeleteDetail',
                    text: '删除',
                    iconCls: 'icon-remove',
                    handler: function () {
                        DeleteDetail();
                    }
                }
                ]
            }
            );
}


function onDoubleClick() {
    AddDetail('修改子表');
}


function AddDetail(type) {
    var strSelectRow = $('#tab_list').datagrid('getSelected')//主表行是否被选择
    if (!strSelectRow) {
        alert('请先选择产品');
        return;
    }
    if (type == '新增子表') {
        $('#divtoolsdetail').window({
            title: "新增",
            top: 100,
            width: 500,
            height: 400,
            modal: true
        });
        $('#txtpcf_id').val("系统自动生成");//编号
        $('#txtpcf_pdc_id').val(strSelectRow.pdc_id);//产品GUID
        $('#txtpcf_name').val("").focus();//产品名称
        $('#txtpcf_version').val("");//版本
        $('#txtpcf_desp').val("");//文件描述
        $('#txtpcf_filesize').val("");//文件大小
        $('#txtpcf_downloadurl').val("");//路径
        $('#btnUp').val("浏览");
        $('#formtoolsdetail').form('validate')
    }
    else {
        var strSelectDetailRow = $('#tab_list_Detail').datagrid('getSelected')
        if (!strSelectDetailRow) {
            alert('请选择一行');
            return;
        }
        $('#divtoolsdetail').window({
            title: "修改",
            top: 100,
            width: 500,
            height: 400,
            modal: true
        });
        var reg = new RegExp("ㄧ", "g");
        var pcf_desp = strSelectDetailRow.pcf_desp.replace(reg, "\n");
        $('#txtpcf_id').val(strSelectDetailRow.pcf_id);//编号
        $('#txtpcf_pdc_id').val(strSelectRow.pdc_id);//主表编号
        $('#txtpcf_name').val(strSelectDetailRow.pcf_name);//名称
        $('#txtpcf_version').val(strSelectDetailRow.pcf_version);//版本号
        $('#txtpcf_desp').val(pcf_desp);//版本说明
        $('#txtpcf_filesize').val(strSelectDetailRow.pcf_filesize);//大小
        $('#txtpcf_downloadurl').val(strSelectDetailRow.pcf_downloadurl);//路径
        $('#formtoolsdetail').form('validate')
        $('#btnUp').val("浏览");
    }
}
function FormDetailSubmit() {
    var strSelectRow = $('#tab_list').datagrid('getSelected')//主表行是否被选择

    var pcf_id = $('#txtpcf_id').val();//子表GUID编号
    var pcf_downloadurl = $('#txtpcf_downloadurl').val();//路径
    var tpcf_filesize = $('#txtpcf_filesize').val();//大小

    if ($('#formtoolsdetail').form('validate') == false) {
        $.messager.alert("提示", "请把必填项填完！", 'error');
        return false;
    }
    var ckeckPcf_DownLoadUrl = $('#txtpcf_downloadurl').val();
    if (ckeckPcf_DownLoadUrl == "") {
        $.messager.alert("提示", "请上传文件！", 'error');
        return false;
    }

    var data = $('#formtoolsdetail').serializeArray();
    data[data.length] = { "name": "txtpcf_id", "value": pcf_id }
    data[data.length] = { "name": "txtpcf_downloadurl", "value": pcf_downloadurl }
    data[data.length] = { "name": "txtpcf_filesize", "value": tpcf_filesize }
    var XMLData = GetFormJson(data, 'EDITDetail');
    //return;
    $.messager.progress({ title: '请稍后', msg: '处理中' });
    $.ajax({
        url: GetWSRRURL('954f5d1c-2cfe-4239-824c-3dc34613c8bb'),
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
                    $('#divtoolsdetail').window('close');
                    $.messager.progress('close');
                    //$('#tab_list_Detail').datagrid("unselectAll");
                    $('#tab_list').datagrid("reload");
                    $('#tab_list_Detail').datagrid("reload");
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
    return false;
}
function DeleteDetail() {
    var selected = $('#tab_list_Detail').datagrid('getSelected');
    if (!selected) {
        alert('请选择数据');
        return;
    }
    $.messager.confirm('提示框', '是否确认删除', function (r) {
        if (r) {
            var data = [];
            data[data.length] = { "name": "txtpcf_id", "value": selected.pcf_id };
            var XMLData = GetFormJson(data, 'DeleteDetail');
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('954f5d1c-2cfe-4239-824c-3dc34613c8bb'),
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
                            $('#tab_list').datagrid("reload");
                            $('#tab_list_Detail').datagrid("reload");
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
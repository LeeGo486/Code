/*
    创建者：Zillionstar-Gavin
    创建时间：2015-04-09
    功能：形象管理前台JS函数
*/
var GV = {};

GV.Pic = {
    type: undefined,
    smallPicMaxNum: 0,
    bigPicMaxNum: 0,
    maxNum: 0,
    picPatch: "",
    bigPatch: "",
    picName: ""
};

var selected_Row;   //形象列表选中行
var selected_Style_Row; //形象列表参数选中行
$(function () {
    InitThemeSelect();
    InitGird();
    InitStyleSelect();
});

//初始化主题的combogrid
function InitThemeSelect() {
    $('#txtTheme').combogrid({
        panelWidth: 500,
        idField: 'tid',
        textField: 'themename',
        url: GetWSRRURL('d34f919c-707a-43b5-913a-0c2b3dc9d11d'),
        queryParams: { "XML": GetGetJson([{}], "GETALL") },
        method: 'get',
        columns: [[
            { field: 'year', title: '年份', width: 30,align:'right' },
            { field: 'themecode', title: '主题编号', width: 100 },
            { field: 'themename', title: '主题名称', width: 180 }
        ]],
        fitColumns: true
    });
}

//初始化款式的combogrid
function InitStyleSelect() {
    $('#form_StyleEdit #txtStyle').combogrid({
        panelWidth: 500,
        idField: 'styl_id',
        textField: 'styl_code',
        url: GetWSRRURL('eb226fa0-fdb3-4ce5-8e88-90d8bc73cf79'),
        queryParams: { "XML": GetGetJson([{}], "GETSTYLE") },
        method: 'get',
        columns: [[
            { field: 'styl_year', title: '年份', width: 30 },
            { field: 'styl_code', title: '款式编号', width: 60 },
            { field: 'styl_name', title: '款式名称', width: 100 },
            { field: 'styl_desp', title: '款式描述', width: 100 }
        ]],
        fitColumns: true
    });
}

//初始化形象列表
function InitGird() {
    $('#tab_list').datagrid(
        {
            url: GetWSRRURL('11adf90e-564d-4aee-9312-c5532a09dd7f'),
            queryParams: { "XML": GetGetJson([{}]) },
            nowrap: false, //是否换行，True 就会把数据显示在一行里
            striped: true, //True 奇偶行使用不同背景色
            collapsible: false, //可折叠
            remoteSort: true, //定义是否从服务器给数据排序
            fit: true,
            singleSelect: true, //单行选择
            checkOnSelect: false, selectOnCheck: false,
            columns: [[
                {
                    field: 'vid',
                    title: '<input id="detailcheckbox" type="checkbox"  >',
                    formatter:function(val) {
                        return "<input type='checkbox' name='chkVid' value='"+val+"'>";
                    }
                },
                {
                    field: 'image',
                    title: '形象图片',
                    width: 80,
                    formatter: function (val,row) {
                        var imageName = val;
                        var bigImageName = row.bigimage;
                        if (val.indexOf(',') > 0) {
                            imageName = val.substr(0, val.indexOf(','));
                        }
                        if (bigImageName.indexOf(',') > 0) {
                            bigImageName = bigImageName.substr(0, bigImageName.indexOf(','));
                        }
                        
                        return "<a id='imageShow' href='" + bigImageName + "' rel='[" + bigImageName + "]' ><img  src='" + imageName + "' style='height:50px'/></a>";
                    }
                },
                { field: 'year', title: '年份', width: 35, search: true, sortable: true,align:'right' },
                { field: 'themecode', title: '主题编号', width: 80, search: true, sortable: true },
	            { field: 'themename', title: '主题名称', width: 140, search: true, sortable: true },
                { field: 'code', title: '形象编号', width: 80, search: true, sortable: true },
	            { field: 'name', title: '形象名称', width: 140, search: true, sortable: true },
                {
                    field: 'status', title: '状态', width: 50, sortable: true,
                    formatter:function(val) {
                        return "<label name='lblStatus' >"+val+"</label>";
                    }
                },
                { field: 'description', title: '形象描述', width: 140, search: true, sortable: true },
                { field: 'createtime', title: '创建时间', width: 100, sortable: true },
                { field: 'createuser', title: '创建人', width: 80, sortable: true },
                { field: 'createtime', title: '更新时间', width: 100, sortable: true },
                { field: 'createuser', title: '更新人', width: 80, sortable: true }
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
                    var rows = $('#tab_list').datagrid('getSelections');
                    if (rows.length !== 1) {
                        $.messager.alert("提示", "请选择一行", 'error');
                        return;
                    }
                    Edit_OnClick(false);
                }
            },
            {
                id: 'btn_Delete',
                text: '删除',
                iconCls: 'icon-cancel',
                handler: function () {
                    Delete_OnClick();
                }
            },
            {
                id: 'btn_batchangestatus',
                text: '批量变更状态',
                iconCls: 'icon-design',
                handler: function () {
                    ChangeStatus_OnClick();
                }
            },
            {
                id: 'btn_ThemeManage',
                text: '主题维护',
                iconCls: 'icon-menu',
                handler: function () {
                    ThemeManage_OnClick();
                }
            }
            ],
            onLoadSuccess: function (data) {
                //展示图片
                $('a[rel]').foxibox();

                $("#detailcheckbox").unbind();
                //对Checkbox全选添加监听
                $('#detailcheckbox').click(function () {
                    if ($(this).attr('checked') === 'checked') {
                        $("input[name='chkVid']").attr("checked", 'checked');
                    } else {
                        $("input[name='chkVid']").removeAttr("checked");
                    }
                });

                if (data.rows.length === 1 && data.rows[0].vid === "") {
                    ClearGrid("#tab_list");
                }
            }
        }
        );
}

//添加形象
function Add_OnClick() {
    $('#divEditView').window({
        title: "添加",
        width: 640,
        height: 530,
        top: 20,
        modal: true
    });
    InitThemeSelect();
    $('#form_Edit #txtTheme').combogrid('setValue', '');    //清空主题
    $('#form_Edit #txtVID').val("");    //清空ViewID
    $('#form_Edit #txtCode').val("");    //清空编号
    $('#form_Edit #txtCodeShow').val("系统自动生成");    //显示编号的信息
    $('#form_Edit #txtName').val('');    //设置名称
    $('#form_Edit #txtDescription').val('');    //设置秒速
    $('#form_Edit #comStatus').combobox('setValue', '未上架'); //设置状态
    //清空Select控件
    $('#form_Edit #txtPicturePath').find("option").remove();
    $('#form_Edit #picShow').html("");
    //$('#form_Edit #txtBigPicPath').find("option").remove();
    //验证Form
    $('#form_Edit').form('validate');
    //设置焦点
    $('#form_Edit #txtTheme').focus();
}

//形象列表项目编辑提交
function Edit_Submit() {
    $('#form_Edit').form('submit', {
        onSubmit: function (e) {
            if ($('#form_Edit').form('validate') === false) {
                return false;
            }

            if ($('#txtPicturePath').find('option').length === 0) {
                $.messager.alert("错误", "请上传形象图片", 'error');
                return false;
            }

            //获取图片路径
            var imagePath = "";
            var bigImagePath = "";
            $("#txtPicturePath option").each(function () {
                var imageName = $(this).text();
                bigImagePath += imageName.replace('thumbnail_', '') + ",";
                imagePath += imageName + ",";
            });
            if (imagePath) {   //去除最后的逗号
                imagePath = imagePath.substr(0, imagePath.length - 1);
            }
            if (bigImagePath) {//去除最后的逗号
                bigImagePath = bigImagePath.substr(0, bigImagePath.length - 1);
            }

            //设置Request对象
            var data = [];
            data[data.length] = { "name": "txtViewID", "value": $('#txtVID').val() };
            data[data.length] = { "name": "txtThemeID", "value": $('#txtTheme').combogrid('getValue') };
            data[data.length] = { "name": "txtCode", "value": $('#txtCode').val() };
            data[data.length] = { "name": "txtName", "value": $('#txtName').val() };
            data[data.length] = { "name": "txtDescription", "value": $('#txtDescription').val() };
            data[data.length] = { "name": "txtStatus", "value": $('#comStatus').combobox('getValue') };
            data[data.length] = { "name": "txtImage", "value": imagePath };
            data[data.length] = { "name": "txtBigImage", "value":bigImagePath };
            var XMLData = GetFormJson(data, 'EDIT');
            $.ajax({
                url: GetWSRRURL('11adf90e-564d-4aee-9312-c5532a09dd7f') ,
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
                            $('#divEditView').window('close');
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

//形象列表项目编辑
function Edit_OnClick(IsCopy) {
    if (!selected_Row) {
        $.messager.alert("提示", "请选择一行", 'error');
        return;
    }

    $('#divEditView').window({
        title: "编辑",
        width: 640,
        top: 20,
        height: 530,
        modal: true
    });
    $('#form_Edit #txtTheme').combogrid('setValue', selected_Row.tid);    //设置主题
    $('#form_Edit #txtVID').val(selected_Row.vid);   //设置形象ID
    $('#form_Edit #txtCode').val(selected_Row.code);  //设置编号
    $('#form_Edit #txtCodeShow').val(selected_Row.code);  //显示编号
    $('#form_Edit #txtName').val(selected_Row.name);  //设置名称
    $('#form_Edit #txtDescription').val(selected_Row.description);  //设置名称
    $('#form_Edit #comStatus').combobox('setValue', selected_Row.status);    //设置主题
    //$('#form_Edit #txtImage').val(selected_Row.image);  //设置名称
    $('#form_Edit #txtPicturePath').find("option").remove();
    $('#form_Edit #picShow').html("");
    //$('#form_Edit #txtBigPicPath').find("option").remove();

    GV.Pic.picPatch = selected_Row.image;
    //GV.Pic.bigPatch = selected_Row.bigimage;

    if (GV.Pic.picPatch !== "") {
        var strs = new Array(); //定义一数组 
        strs = GV.Pic.picPatch.split(","); //字符分割
        var select = $('#txtPicturePath');

        if (strs[strs.length - 1] === "") {
            strs.length = strs.length - 1;
        }

        for (var i = 0; i <= strs.length - 1; i++) {
            select.append("<option value='" + strs[i] + "'>" + strs[i] + "</option>");
        };
        
        select[0].options[0].selected = true;
        selectviw('txtPicturePath', 'picShow');
    }

    //验证Form
    $('#form_Edit').form('validate');
    //设置txtURL焦点
    $('#form_Edit #txtTheme').focus();
}

//单击形象列表项目
function DBlClickRowGrid() {
    var selected = $('#tab_list').datagrid('getSelected');

    if (selected) {
        selected_Row = selected;
        //$('#form_StyleEdit input[name="txtTask_ID"]').val(selected_Row.task_id);
        //InitTab();
        InitStyleInfo();
    }
}

//形象列表项目删除
function Delete_OnClick() {
    var rows = $('#tab_list').datagrid('getSelections');
    if (rows.length !== 1) {
        $.messager.alert("提示", "请选择一行", 'error');
        return;
    }

    if (selected_Row.status === "上架") {
        $.messager.alert("提示", "已上架不可删除", 'error');
        return;
    }
    $.messager.confirm('提示框', '你确定要删除吗?', function(r) {
        if (r) {
            var data = eval("[]");
            data[data.length] = { "name": "txtVID", "value": selected_Row.vid }
            var XMLData = GetFormJson(data, 'DELETE');

            $.ajax({
                url: GetWSRRURL('11adf90e-564d-4aee-9312-c5532a09dd7f'),
                type: 'post',
                async: true, //异步,
                data: { "XML": XMLData },
                success: function(result) {
                    try {
                        var result = eval("[" + result + "]");
                        if (result[0].Error) {
                            $.messager.progress('close');

                            $.messager.alert("系统错误", result[0].Error, 'error');
                        } else if (result[0].rows[0].result == "False") {
                            $.messager.alert("提示", result[0].rows[0].message, 'error');
                        } else {
                            $('#tab_list').datagrid("unselectAll");
                            selected_Row = undefined
                            $('#tab_list').datagrid("reload");
                        }
                    } catch (ex) {
                        $.messager.alert("提示", ex, 'error');
                    }
                },
                error: function() {
                    $.messager.alert("提示", "提交错误了！", 'error');
                }
            });
        }
    });
};

//批量变更状态
function ChangeStatus_OnClick() {
    var items = $("input[name='chkVid']:checked");
    if (items.length===0) {
        $.messager.alert("提示", "请至少选择一行", 'error');
        return;
    }
    var firstRowStatus = $(items[0]).closest('tr').find('label[name="lblStatus"]')[0].innerHTML;
    var isStatusOK = true;
    //检查所有状态是否一致
    $.each(items, function (index, item) {
        var tr = $(this).closest('tr');
        var strStatus = tr.find('label[name="lblStatus"]')[0].innerHTML;
        if (firstRowStatus !== strStatus) {
            isStatusOK = false;
        }
    });
    if (!isStatusOK) {
        $.messager.alert("提示", "选中行状态不一致", 'error');
        return;
    }

     $('#divChangeStatusView').window({
         title: "状态批量变更",
         width: 440,
         top: 20,
         height: 330,
         modal: true
     });

}

//批量变更状态保存
function ChangeStatus_Submit() {
    //var rows = $('#tab_list').datagrid('getSelections');
    //if (rows.length === 0) {
    //    $.messager.alert("提示", "请至少选择一行", 'error');
    //    return;
    //}
    var vids = "";
    var items = $("input[name='chkVid']:checked");
    $.each(items, function (index, item) {
        vids = vids + item.value + ",";
    });
    vids = vids.substr(0, vids.length - 1); //去除结尾的“，”
    //statuses = statuses.substr(0, vids.length - 1); //去除结尾的“，”

    //设置Request对象
    var data = [];
    data[data.length] = { "name": "txtVIDS", "value": vids };
    data[data.length] = { "name": "txtStatuses", "value": $('#comChangeStatus').combobox('getValue') };
    var XMLData = GetFormJson(data, 'ChangeStatus');
    $.ajax({
        url: GetWSRRURL('11adf90e-564d-4aee-9312-c5532a09dd7f') ,
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
                    $('#divChangeStatusView').window('close');
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
}

//显示图片
function selectviw(id, picid) {
    eval("var selOpt" + "=" + "$('#" + id + " option:selected " + "')");
    eval("var picShow" + "=" + "$('#" + picid + " option:selected " + "')");

    var domObj = document.getElementById(picid);
    var jQyObj = $(domObj);

    if (selOpt == undefined || selOpt.length == 0) {
        return;
    } else {
        jQyObj.html("");
        $("<img style='width:100px;height:100px'/>").appendTo(jQyObj).attr("src", selOpt[0].innerHTML);
    }
}

//文件上传
function pic_onSubmit(id) {
    var btn = document.getElementById(id);
    var button = $(btn);
    GV.Pic.picName = picName(id);
    var test = new AjaxUpload(button, {
        //action: 'upload-test.php',文件上传服务器端执行的地址
        action: '/Handler_Image_Upload.ashx?filePath=NPaia_Views&fileName=' + GV.Pic.picName,
        name: 'fileName',
        inputName: $('#txtCode').val(),
        onSubmit: function (file, ext) {
            if (!(ext && /^(jpg|jpeg|png|JPG|JPEG|PNG)$/.test(ext))) {
                alert('文本格式不正确,请选择 jpg,png 格式的文件!', '系统提示');
                return false;
            };
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
            return true;
        },
        onComplete: function (file, response) {
            //file 本地文件名称，response 服务器端传回的信息
            button.val('上传');

            window.clearInterval(interval);

            // enable upload button
            this.enable();
            var start = response.indexOf(">");
            if (start !== -1) {
                var end = response.indexOf("<", start + 1);
                if (end != -1) {
                    response = response.substring(start + 1, end);
                }
            }
            //var k = response.replace("<pre>", "").replace("</pre>", "").replace("<PRE>", "").replace("</PRE>", "");
            var k = response;
            try {
                var result = eval("[" + k + "]");
                if (result[0].Error) {
                    $.messager.progress('close');

                    $.messager.alert("系统错误", result[0].Error, 'error');
                }
                else {
                    this.disable();
                    var value = result[0].Success;
                    col_add(id, value);
                    GV.Pic.picName = picName(id);

                    if (id == "picUp") {
                        GV.Pic.smallPicMaxNum = GV.Pic.smallPicMaxNum + 1;
                    }
                    //else {
                    //    GV.Pic.bigPicMaxNum = GV.Pic.bigPicMaxNum + 1;
                    //}
                    pic_onSubmit(id);
                }
            } catch (ex) {
                $.messager.progress('close');

                $.messager.alert("提示", ex, 'error');
            }
        }
    });
    //文件上传相关-----------------
}

//图片名字
function picName() {
    var date = new Date();
    return date.getFullYear()+""+date.getMonth()+date.getDate()+date.getHours()+date.getMinutes()+date.getSeconds()+date.getMilliseconds();
}

//赋值选择
function col_add(id, text) {
    var selObj = $("#txtPicturePath");
    selObj.val("");
    selObj.append("<option selected>" + text + "</option>");
    selectviw('txtPicturePath', 'picShow');
}

//删除图片
function col_delete(id) {
    var selOpt = null;
    selOpt = document.getElementById('txtPicturePath');
    $('#picShow').html("");
    selOpt = $(selOpt).find('option:selected');
    selOpt.remove();
}

//初始化款式信息
function InitStyleInfo() {
    $('#tblStyleInfo').datagrid(
            {
                title: selected_Row.ws_name, //表格标题
                url: GetWSRRURL('eb226fa0-fdb3-4ce5-8e88-90d8bc73cf79'),
                queryParams: { "XML": GetGetJson([{ "view_id": selected_Row.vid }]) },
                iconCls: '', //标题左边的图标
                striped: true, //True 奇偶行使用不同背景色
                collapsible: false, //可折叠
                fit: true,
                singleSelect: true, //单行选择
                rownumbers: true, //行号
                columns: [[
                    { field: 'sid', title: 'ID', width: 30, hidden: true },
                    { field: 'viewid', title: '形象ID', width: 30, hidden: true },
                    { field: 'styl_year', title: '年份', width: 60, search: true, sortable: true },
                    { field: 'styl_code', title: '款式编号', width: 100, search: true, sortable: true },
                    { field: 'styl_name', title: '款式名称', width: 120, search: true, sortable: true },
                    { field: 'updatetime', title: '维护时间', width: 120, search: true, sortable: true }
                ]],
                pagination: true, //是否开启分页
                pageNumber: 1, //默认索引页
                pageSize: 20, //默认一页数据条数
                onLoadSuccess: function (data) {
                    if (data.rows.length === 1 && data.rows[0].sid === "") {
                        ClearGrid("#tblStyleInfo");
                    }
                },
                onDblClickRow: function () { AddStyle_OnClick(true); },
                toolbar: [
                {
                    id: 'btn_AddParam',
                    text: '添加',
                    iconCls: 'icon-add',
                    handler: function () {
                        AddStyle_OnClick();
                    }
                },
                {
                    id: 'btn_EditParam',
                    text: '编辑',
                    iconCls: 'icon-edit',
                    handler: function () {
                        AddStyle_OnClick(true);
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

//添加形象项目参数
function AddStyle_OnClick(isEdit) {
    selected_Style_Row = $('#tblStyleInfo').datagrid('getSelected');

    if (isEdit && !selected_Style_Row) {
        $.messager.alert("错误", "请选择一行数据！", 'error');
        return;
    }
    if (isEdit) {
        //编辑的场合
        $('#divEditStyle').window({
            title: "编辑",
            width: 500,
            height: 300,
            top: 20,
            modal: true
        });

        //$('#form_StyleEdit #txtSIDShow').val(selected_Style_Row.sid);  //设置显示SID
        $('#form_StyleEdit #txtSID').val(selected_Style_Row.sid); //设置SID
        $('#form_StyleEdit #txtViewID').val(selected_Style_Row.viewid);    //设置Task_ID
        $('#form_StyleEdit #txtViewCode').val(selected_Row.code);    //设置形象编号
        $('#form_StyleEdit #txtStyle').combogrid('setValue', selected_Style_Row.styl_code); //设置款式
        $('#form_StyleEdit #txtStyleCode').val(selected_Style_Row.styl_code);    //设置形象编号
    }
    else {
        //新增的场合
        $('#divEditStyle').window({
            title: "添加",
            width: 500,
            top: 20,
            height: 300,
            modal: true
        });

        //$('#form_StyleEdit #txtSIDShow').val('系统自动生成'); //显示“系统自动生成”
        $('#form_StyleEdit #txtSID').val('');  //清空SID
        $('#form_StyleEdit #txtViewCode').val(selected_Row.code);    //设置形象编号
        $('#form_StyleEdit #txtViewID').val(selected_Row.vid); //设置选中形象项目的ViewID
        $('#form_StyleEdit #txtStyle').val('');    //清空款式
        $('#form_StyleEdit #txtStyleID').val('');    //清空款式ID
        //$('#form_StyleEdit #txtStyleCode').val('');    //清空款式
        //$('#form_StyleEdit #txtStyleName').val('');    //清空款式

    }
    $('#form_StyleEdit').form('validate');  //验证
    $('#form_StyleEdit #txtStyle').focus();    //参数名称获取焦点
}


//编辑形象项目参数
function Edit_StyleSubmit() {
    $('#form_StyleEdit').form('submit', {
        onSubmit: function () {
            if ($('#form_StyleEdit').form('validate') === false) {
                return false;
            }

            if ($('#form_StyleEdit #txtStyle').combogrid('getValue') === $('#form_StyleEdit #txtStyleCode').val()) {
                $.messager.alert("错误", "没有更改,请选择需要更改的款式！", 'error');
                return false;
            }

            //设置Request对象
            var data = [];
            data[data.length] = { "name": "txtSID", "value": $('#txtSID').val() };
            data[data.length] = { "name": "txtViewID", "value": selected_Row.vid };
            data[data.length] = { "name": "txtStyleID", "value": $('#form_StyleEdit #txtStyle').combogrid('getValue') };
            //var data = $('#form_StyleEdit').serializeArray();   //Form序列化
            var XMLData = GetFormJson(data, 'EDIT');    //获取XML格式
            $.ajax({
                url: GetWSRRURL('eb226fa0-fdb3-4ce5-8e88-90d8bc73cf79'),
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
                            $('#divEditStyle').window('close');
                            $('#tblStyleInfo').datagrid("unselectAll");
                            $('#tblStyleInfo').datagrid("reload");
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


//删除形象项目参数
function DeleteParam_OnClick() {
    var selected = $('#tblStyleInfo').datagrid('getSelected');
    if (!selected) {
        $.messager.alert("提示", "请选择一行", 'error');
        return;
    }
    $.messager.confirm('提示框', '你确定要删除吗?', function (r) {
        if (r) {
            var data = eval("[]");
            data[data.length] = { "name": "txtSID", "value": selected.sid }   //设置删除所需参数
            //data[data.length] = { "name": "txtTask_ID", "value": selected_Row.task_id }   //设置删除所需参数
            var XMLData = GetFormJson(data, 'DELETE');

            $.ajax({
                url: GetWSRRURL('eb226fa0-fdb3-4ce5-8e88-90d8bc73cf79') ,
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
                            $('#tblStyleInfo').datagrid("unselectAll");
                            $('#tblStyleInfo').datagrid("reload");
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

function ThemeManage_OnClick() {
    //主题维护界面
    $('#divThemeManage').window({
        title: "主题维护",
        width: 800,
        top: 20,
        height: 450,
        modal: true
    });
}


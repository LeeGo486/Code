var m_class;
var m_state = [{ "id": 0, "text": "未上报", "selected": true }, { "id": 1, "text": "已上报", "selected": true }, { "id": 2, "text": "已跟进", "selected": true },
               { "id": 3, "text": "已更改", "selected": true }, { "id": 4, "text": "已退回", "selected": true }, { "id": 5, "text": "施工超期", "selected": true }, { "id": 6, "text": "处理超期", "selected": true }, { "id": 7, "text": "完成", "selected": true }];
var m_month = [{ "id": 1, "text": "1月" }, { "id": 2, "text": "2月" }, { "id": 3, "text": "3月" }, { "id": 4, "text": "4月" }, { "id": 5, "text": "5月" }, { "id": 6, "text": "6月" },
            { "id": 7, "text": "7月" }, { "id": 8, "text": "8月" }, { "id": 9, "text": "9月" }, { "id": 10, "text": "10月" }, { "id": 11, "text": "11月" }, { "id": 12, "text": "12月" }];
var m_year = [{ "id": "2011", "text": "2011年" }, { "id": "2012", "text": "2012年" }, { "id": "2013", "text": "2013年" }, { "id": "2014", "text": "2014年", "selected": true }, { "id": "2015", "text": "2015年" }, { "id": "2016", "text": "2016年" }];

var m_com = [{ "id": 0, "text": "全部", "selected": true }, { "id": 1, "text": "泓雅" }, { "id": 2, "text": "纳卉" }, { "id": 3, "text": "卓莱雅" }, { "id": 4, "text": "西南" }, { "id": 5, "text": "雅斓" }, { "id": 6, "text": "华南" },
            { "id": 7, "text": "郑州" }, { "id": 8, "text": "雅莹" }, { "id": 9, "text": "新疆" }, { "id": 10, "text": "贝爱" }, { "id": 11, "text": "华中" }, { "id": 12, "text": "维姬" }, { "id": 13, "text": "诺珂" }, { "id": 14, "text": "东北" }];

var m_form = [{ "id": 1, "text": "自营" }, { "id": 2, "text": "加盟" }, { "id": 0, "text": "全部", "selected": true }];
var m_DepotID = "";
var m_DepotName = "";
var m_Jform = "";
var m_dataAUZ = [];
var m_selectorg = "";

var m_ExportFlag = false;
$(function () {
    //文件上传相关-----------------
    var button = $('#btnUp'), interval;
    new AjaxUpload(button, {
        //action: 'upload-test.php',文件上传服务器端执行的地址
        action: '/Handler_Upload.ashx?filePath=HZY_mat',
        name: 'myfile',
        onSubmit: function (file, ext) {
            if (!(ext && /^(jpg|jpeg|JPG|JPEG|PNG|GIF|gif|png)$/.test(ext))) {
                alert('图片格式不正确,请选择 jpg,gif,png 格式的文件!', '系统提示');
                return false;
            }
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
            button.val('上传');

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
                    $("#txtimg").val(result[0].rows[0].message);
                    $('#txtimgupload').html("");

                    var value = result[0].rows[0].message;
                    var strSmallImg = value.substr(0, value.length - 4) + "small" + value.substr(value.length - 4);
                    $("<img style='width:150px;height:90px'/>").appendTo($('#txtimgupload')).attr("src", strSmallImg);


                }
            } catch (ex) {
                $.messager.progress('close');

                $.messager.alert("提示", ex, 'error');
            }

            //if (k == '-1') {
            //    alert('您上传的文件太大啦!请不要超过150K');
            //}
            //else {
            //    alert("服务器端传回的串：" + k);
            //    alert("本地文件名称：" + file);
            //    $("<img />").appendTo($('#imglist')).attr("src", k);
            //}
        }
    });
    //文件上传相关-----------------


    $.ajax({
        url: GetWSRRURL('DepotID'),
        options: "JSON",
        async: false,
        success: function (data) {
            //alert(data);
            if (eval("[" + data + "]")[0].Error) {
                $.messager.alert("出错了", eval("[" + data + "]")[0].Error, 'error');
                return;
            }
            m_DepotID = eval("[" + data + "]")[0].DepotID;
        }
    });

    $.ajax({
        url: GetWSRRURL('DepotName'),
        options: "JSON",
        async: false,
        success: function (data) {
            //alert(data);
            if (eval("[" + data + "]")[0].Error) {
                $.messager.alert("出错了", eval("[" + data + "]")[0].Error, 'error');
                return;
            }
            m_DepotName = eval("[" + data + "]")[0].DepotName;
        }
    });


    if (m_DepotID != "") {
        XMLData = GetFormJson([], 'GETDEPOTINFO');
        htmlobj = $.ajax({
            url: GetWSRRURL('e6d23a54-38a6-474e-ad06-82c78fadd5e0'),
            data: { "XML": XMLData, "WHERE": "depotid='" + m_DepotID + "'" },
            type: 'post',
            async: false
        });
        var result = $.parseJSON(htmlobj.responseText);
        if (result.rows[0]['m_type'] != "") {
            m_Jform = result.rows[0]['m_type']
        }
    }
    $('#txtyearselect').combobox({
        valueField: 'id',
        textField: 'text',
        data: m_year,
        panelHeight: 'auto',
        editable: false,
        multiple: false
    });

    $('#txtselectcom').combobox({
        valueField: 'id',
        textField: 'text',
        data: m_com,
        panelHeight: 'auto',
        editable: false,
        multiple: false
    });

    $('#txtform').combobox({
        valueField: 'id',
        textField: 'text',
        data: m_form,
        panelHeight: 'auto',
        editable: false,
        multiple: false
    });

    $('#txtmonthselect').combobox({
        valueField: 'id',
        textField: 'text',
        data: m_month,
        panelHeight: 'auto',
        editable: false,
        multiple: false,
        onChange: function () {
            var m_yearselect = $('#txtyearselect').combobox("getValue");
            var m_monthselect = $('#txtmonthselect').combobox("getValue");
            var m_monthselect = m_monthselect;
            var m_monthselect_next = m_monthselect * 1 + 1;
            var m_monthselect_old = m_monthselect * 1 - 11;
            var m_yearselect_next = m_yearselect * 1 + 1;

            var url = GetWSRRURL('8bb9dd9c-1299-45b0-bdcb-bba7e5d8d55e') + "&XML=" + GetGetJson([{}]) + "&WHERE=1=1";
            if (m_monthselect != 12) {
                url += " and createtime between '" + m_yearselect + "-" + m_monthselect + "-1" + "'" + " AND " + "'" + m_yearselect + "-" + m_monthselect_next + "-1" + "'";
            }
            else {
                url += " and createtime between '" + m_yearselect + "-" + m_monthselect + "-1" + "'" + " AND " + "'" + m_yearselect_next + "-" + m_monthselect_old + "-1" + "'";
            }
            InitGrid(url);
        }
    });

    $('#txtselectstate').combogrid({
        panelWidth: 110,
        multiple: true,
        //idField: 'id',
        textField: 'text',
        //method: 'get',
        data: m_state,
        columns: [[
            { field: 'ck', checkbox: true },
            //{ field: 'id', title: 'id',width: 20,sortable: true },
            { field: 'text', title: '状态', width: 60, sortable: true }
        ]]
    });

    $('#txtcreatetime_star').datebox({
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false,
        //required: true,
        formatter: function (date) { return date.getFullYear() + '/' + (date.getMonth() + 1) + '/' + date.getDate(); },
        onChange: function () {
            if ($('#txtcreatetime_end').datebox("getValue") == "") {
                var txtcreatetime = $('#txtcreatetime_star').datebox("getValue")
                $('#txtcreatetime_end').datebox("setValue", txtcreatetime);
            }
        }
    });

    $('#txtcreatetime_end').datebox({
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false,
        //required: true,
        formatter: function (date) { return date.getFullYear() + '/' + (date.getMonth() + 1) + '/' + date.getDate(); },
        onChange: function () {
            if ($('#txtcreatetime_star').datebox("getValue") == "") {
                var txtendtime = $('#txtcreatetime_end').datebox("getValue")
                $('#txtcreatetime_star').datebox("setValue", txtendtime);
            }
        }
    });
    //高级首选种类品类联动
    $('#txtselecttypeid').combobox({
        editable: false
        //required: true
    });
    $('#txtselectparentid').combobox({
        url: GetComboxWSRRURL('0c604bc9-457b-4fdc-9dda-2e2711665061') + "&XML=" + GetGetJson([{ "entity": "entity" }])
            + "&WHERE=parentid=0",
        //required: true,
        //panelHeight: 'auto',
        editable: false,
        valueField: 'id',
        textField: 'text',
        onLoadSuccess: function () {
            var data = $('#txtselectparentid').combobox("getData");
            if (data.length == 0 || data[0].id != "0") {
                ComboboxAddRow({ "id": "0", "text": "全部", "selected": true }, 0, '#txtselectparentid');
            }
        },
        onChange: function () {
            var data = $('#txtselectparentid').combobox("getValue");
            if (data == 0) {
                //    $('#txtselecttypeid').combobox({ required: false });
                //    $('#txtselecttypeid').combobox({ disabled: true });
                $('#txtselecttypeid').combobox('setValue', "全部");
                data = "";
                //    return;
                //ComboboxAddRow({ "id": "0", "text": "全部", "selected": true }, 0, '#txtselecttypeid');
            }
            else {
                //    $('#txtselecttypeid').combobox({ required: true })
                //    $('#txtselecttypeid').combobox({ disabled: false });
                init_select_type(data);
            }
        }
    });



    function init_select_type(strselecttypeid) {
        var url = GetComboxWSRRURL('0c604bc9-457b-4fdc-9dda-2e2711665061') + "&XML=" + GetGetJson([{ "entity": "entity" }])
                + "&WHERE=parentid=" + strselecttypeid,
        htmlobj = $.ajax({
            url: url,
            async: false
        });
        m_select_type = $.parseJSON(htmlobj.responseText);

        $('#txtselecttypeid').combobox({
            //panelHeight: 'auto',
            data: m_select_type,
            editable: false,
            valueField: 'id',
            textField: 'text',
            onLoadSuccess: function () {
                var data = $('#txtselecttypeid').combobox("getData");
                if (data.length == 0 || data[0].id != "0") {
                    ComboboxAddRow({ "id": "0", "text": "全部", "selected": true }, 0, '#txtselecttypeid');
                }
            }
        });
    }

    var strMenuID = $.getUrlParam('vexmenuid');

    if (strMenuID == "") {
        alert('获取权限信息失败，请勿提交非法的URL');
        return;
    }
    if (m_DepotID == "") {
        $.ajax({
            url: GetWSRRURL('f134e783-bb04-4aba-ad48-7525563d6271') + "&Menu_ID=" + strMenuID,
            options: "JSON",
            async: false,
            success: function (data) {
                if (eval("[" + data + "]")[0].Error) {
                    $.messager.alert("出错了", eval("[" + data + "]")[0].Error, 'error');
                    return;
                }
                m_dataAUZ = eval("[" + data + "]")[0];
            }
        });
    }
    else {
        m_dataAUZ.rows = [{ "actionurl": "btn_shop" }, { "actionurl": "btn_submit" }, { "actionurl": "btn_shopconfirm" }, { "actionurl": "btn_delete" }];

    }

    var url = GetWSRRURL('8bb9dd9c-1299-45b0-bdcb-bba7e5d8d55e') + "&XML=" + GetGetJson([{}]);
    InitGrid(url);
})

//读取权限
function ReadeAuz() {

    //将所有的按扭设置为隐藏
    $(".datagrid-toolbar #btn_shop").hide();
    $(".datagrid-toolbar #btn_general").hide();
    $(".datagrid-toolbar #btn_submit").hide();
    $(".datagrid-toolbar #btn_reply").hide();
    $(".datagrid-toolbar #btn_change").hide();
    $(".datagrid-toolbar #btn_shopconfirm").hide();
    $(".datagrid-toolbar #btn_generalconfirm").hide();
    $(".datagrid-toolbar #btn_delete").hide();
    $(".datagrid-toolbar #btn_deleteconfirm").hide();

    for (var i = 0; i < m_dataAUZ.rows.length; i++) {
        $(".datagrid-toolbar #" + m_dataAUZ.rows[i].actionurl).show();
    }
}
//店铺填写...总部代填写
function AddNew(isadd) {

    init_parentid();//触发种类和品类联动
    $('#txttypeid').combobox({});

    if (isadd) {
        $('#form_Add').window({
            title: "店铺维修上报",
            top: 20,
            width: 600,
            height: 280,
            modal: true
        });
        document.getElementById('txtselectdepot').disabled = "disabled"
        $('#txttypeid').combobox({ required: true });
        $('#txtdepotname').val(m_DepotName);
        $('#txtdepotid').val(m_DepotID);
        $('#txtparentid').combobox('setValue', '');
        $('#txttypeid').combobox('setValue', '');
        $('#txtcontent').val("");
        $('#txtimg').val("");
        $('#txtlinkman').val("");
        $('#txtlinkTel').numberbox('setValue', '');
        $('#txtimg').val("");
        $('#txtcomment').val("");
        $('#txtimgupload').html("");
        $('#txtj_form').val(m_Jform);
    }
    else {
        $('#form_Add').window({
            title: "总部代报",
            top: 20,
            width: 600,
            height: 280,
            modal: true
        });
        document.getElementById('txtselectdepot').disabled = ""
        $('#txtimgupload').html("");
        $('#txtdepotname').val("");
        $('#txtdepotid').val("");
        $('#txtparentid').combobox('setValue', '');
        $('#txttypeid').combobox('setValue', '');
        $('#txtcontent').val("");
        $('#txtimg').val("");
        $('#txtlinkman').val("");
        $('#txtlinkTel').numberbox('setValue', '');
        $('#txtimg').val("");
        $('#txtcomment').val("");

    }
}
function Add_Cancel() {
    $('#form_Add').window('close')
}
function SelectDepot() {
    $('#divSelectDepot').window({
        title: "选择店铺",
        top: 40,
        width: 550,
        height: 530,
        modal: true
    });
    initSelectDepot()
}
function initSelectDepot() {

    $('#divSelectDepot').datagrid(
        {
            url: GetWSRRURL('e6d23a54-38a6-474e-ad06-82c78fadd5e0'),
            queryParams: { "XML": GetFormJson("", 'GETForCombobox') },
            width: '100%',
            singleSelect: true, //单行选择
            //fit: true,
            pagination: true, //是否开启分页
            pageSize: 20, //默认一页数据条数
            onDblClickRow: dginitSelectDepotDblClickRow,
            columns: [[
                { field: 'depotid', title: '店铺编号', width: 80, search: true, sortable: true },
                { field: 'd_name', title: '店铺名称', width: 140, search: true, sortable: true },
                { field: 'areaid', title: '地区编码', width: 60, search: true, sortable: true },
                { field: 'shutname', title: '省份', width: 100, search: true, sortable: true },
                { field: 'm_type', title: '店铺类型', width: 100, search: true, sortable: true }
            ]]
        }
        );
}
function dginitSelectDepotDblClickRow() {
    $('#divSelectDepot').window('close');
    var dg = $("#divSelectDepot");
    var SelectDepot = $('#divSelectDepot').datagrid('getSelected')
    $('#txtdepotname').val(SelectDepot.d_name);
    $('#txtdepotid').val(SelectDepot.depotid);
    $('#txtj_form').val(SelectDepot.m_type);
}
function Add_Submit() {
    $('#form_Add').form('submit', {
        onSubmit: function (e) {

            if ($('#form_Add').form('validate') == false) {
                $.messager.alert("提示", "请把必填项填完！", 'error');
                return false;
            }

            if (document.getElementById('txtdepotid').value == "") {
                $.messager.alert("提示", "请选择店铺！", 'error');
                return false;
            }

            $('#form_Add').window('close');

            var depotid_update = $('#txtdepotid').val();
            var depotname_update = $('#txtdepotname').val();
            var img_update = $('#txtimg').val();

            var data = $('#form_Add').serializeArray();

            data[data.length] = { "name": "txtdepotid", "value": depotid_update }
            data[data.length] = { "name": "txtimg", "value": img_update }
            data[data.length] = { "name": "txtdepotname", "value": depotname_update }

            var XMLData = GetFormJson(data, 'INSERT');
            //return;
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('8bb9dd9c-1299-45b0-bdcb-bba7e5d8d55e'),
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

            return false;
        }
    });

}
//品类种类联动
function init_parentid() {

    $('#txtparentid').combobox({
        //url: GetComboxWSRRURL('0c604bc9-457b-4fdc-9dda-2e2711665061') + "&parentid=0&chk_sure=1&XML=" + GetGetJson([]),
        //url: GetComboxWSRRURL('0c604bc9-457b-4fdc-9dda-2e2711665061') + "&XML=" + GetGetJson([{ "pagerows": 20000, "parentid": 0, "chk_sure": 1 }]),
        url: GetComboxWSRRURL('0c604bc9-457b-4fdc-9dda-2e2711665061') + "&XML=" + GetGetJson([{ "entity": "entity" }])
            + "&WHERE=parentid=0",
        // queryParams: { "XML":, "WHERE": "parentid=0" },
        required: true,
        //panelHeight: 'auto',
        editable: false,
        valueField: 'id',
        textField: 'text',
        onChange: function () {
            var data = $('#txtparentid').combobox("getValue");
            init_type(data);
        }
    });


}
function init_type(strtypeid) {

    // var url = GetComboxWSRRURL('0c604bc9-457b-4fdc-9dda-2e2711665061') + "&XML=" + GetGetJson([{ "typeid": strtypeid }]),
    var url = GetComboxWSRRURL('0c604bc9-457b-4fdc-9dda-2e2711665061') + "&XML=" + GetGetJson([{ "entity": "entity" }])
            + "&WHERE=parentid=" + strtypeid,
    htmlobj = $.ajax({
        url: url,
        async: false
    });
    m_type = $.parseJSON(htmlobj.responseText);

    $('#txttypeid').combobox({
        //panelHeight: 'auto',
        data: m_type,
        editable: false,
        valueField: 'id',
        textField: 'text'
    });
}
//上报
function Submit() {
    var selected = $('#tab_list').datagrid('getSelected');

    if (!selected) {
        alert('请选择数据');
        return;
    }
    var S_state = selected.state
    if (S_state != "未上报") {
        alert('该数据已经上报，请选择未上报的数据');
        return;
    }


    $.messager.confirm('提示框', '是否确定', function (r) {
        if (r) {
            var data = [];
            data[data.length] = { "name": "txtbillid", "value": selected.billid }
            data[data.length] = { "name": "txtchk_sure", "value": "1" }
            //data[data.length] = { "name": "txtchk_name", "value": m_DepotName }
            data[data.length] = { "name": "txtdepotid", "value": selected.depotid }
            data[data.length] = { "name": "txtchk_date", "value": "" }
            data[data.length] = { "name": "txtstate", "value": "1" }

            var XMLData = GetFormJson(data, 'Update_Submit');
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('8bb9dd9c-1299-45b0-bdcb-bba7e5d8d55e'),
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

            return false;
        }
    });

}
//总部回复
function reply_cancel() {
    $('#form_reply').window('close')
}
function Reply() {
    var selected = $('#tab_list').datagrid('getSelected');
    if (!selected) {
        alert('请选择数据');
        return;
    }
    var S_state = selected.state

    if (S_state != "已上报" && S_state != "处理超期") {
        alert('请选择已上报且未处理的数据');
        return;
    }

    $('#txtschemaenddate').datebox({
        valueField: 'id',
        textField: 'text',
        //panelHeight: 'auto',
        editable: false,
        required: true,
        formatter: function (date) { return date.getFullYear() + '/' + (date.getMonth() + 1) + '/' + date.getDate(); }
    });

    $('#form_reply').window({
        title: "回复维修单",
        top: 20,
        width: 450,
        height: 280,
        modal: true
    });

    $('#txtbillid').val(selected.billid);
    //document.getElementById('Checkbox').checked = false;
    $('#Checkbox').removeAttr("checked");
    //$('#Checkbox').attr("checked","true"); 
    $('#txtfb_comment').val("");
    $('#txtschemaenddate').datebox('setValue', "");
    $('#txtisquality').val("");
    $('#txtfb_content').val("");
    $('#txtorgid').val("");
    $('#txtname').val("");


    $('#txtisquality').combobox({
        valueField: 'id',
        textField: 'text',
        data: [{ "id": "", "text": "", "selected": true }, { "id": "是", "text": "是" }, { "id": "否", "text": "否" }],
        //panelHeight: 'auto',
        editable: false,
        required: true
    });

    $('#txtfb_comment').validatebox({ required: true });
    $('#txtfb_content').attr("disabled", false);
    $('#txtorgid').attr("disabled", "");
    $('#txtschemaenddate').datebox({ disabled: false });
    $('#form_reply').form('validate');
    $('#txtisquality').combobox({ disabled: false });




}
function Checkbox_Reply() {
    if (document.getElementById('Checkbox').checked) {

        $('#txtfb_content').validatebox({ required: false });
        $('#txtschemaenddate').datebox({ required: false });
        $('#txtisquality').combobox({ required: false });
        $('#txtschemaenddate').datebox('setValue', "");
        $('#txtisquality').val("");
        $('#txtfb_content').val("");
        $('#txtorgid').val("");
        $('#txtname').val("");

        $('#txtisquality').combobox({ disabled: true });
        $('#txtfb_content').attr("disabled", "disabled");
        $('#txtorgid').attr("disabled", "disabled");
        $('#txtschemaenddate').datebox({ disabled: true });
    }
    else {
        $('#txtfb_comment').validatebox({ required: true });
        $('#txtschemaenddate').datebox({ required: true });
        $('#txtisquality').combobox({ required: true });



        //$('#txtisquality').attr("disabled", "");
        $('#txtfb_content').attr("disabled", true);
        $('#txtorgid').attr("disabled", "");
        $('#txtisquality').combobox({ disabled: false });
        $('#txtschemaenddate').datebox({ disabled: false });
        $('#form_reply').form('validate');
        $('#txtfb_content').validatebox({ required: true });
    }
}
function reply_submit() {
    var selected = $('#tab_list').datagrid('getSelected');
    $('#form_reply').form('submit', {
        onSubmit: function (e) {
            if ($('#form_reply').form('validate') == false) {
                $.messager.alert("提示", "请把必填项填完！", 'error');
                return false;
            }
            $('#form_reply').window('close');

            var data = $('#form_reply').serializeArray();

            if (document.getElementById('Checkbox').checked) {
                data[data.length] = { "name": "txtstate", "value": "3" }
                data[data.length] = { "name": "txtbillid", "value": selected.billid }
                data[data.length] = { "name": "txtfb_date", "value": "" }
                data[data.length] = { "name": "txtfb_name", "value": "" }
                data[data.length] = { "name": "txtdepotid", "value": selected.depotid }
            }
            else {
                data[data.length] = { "name": "txtstate", "value": "2" }
                data[data.length] = { "name": "txtbillid", "value": selected.billid }
                data[data.length] = { "name": "txtfb_date", "value": "" }
                data[data.length] = { "name": "txtfb_name", "value": "" }
                data[data.length] = { "name": "txtdepotid", "value": selected.depotid }
                data[data.length] = { "name": "txtorgid", "value": $('#txtorgid').val() }
            }
            var XMLData = GetFormJson(data, 'REPLY_UPDATE');
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('8bb9dd9c-1299-45b0-bdcb-bba7e5d8d55e'),
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

            return false;
        }
    });

}
function Selectorg(type) {
    m_selectorg = type;
    $('#divSelectOrg').window({
        title: "选择维修商",
        top: 40,
        width: 550,
        height: 530,
        modal: true
    });
    //alert(type);
    initSelectorg()
}
function initSelectorg() {
    $('#divSelectOrg').datagrid(
           {
               url: GetWSRRURL('7d0ffd5e-ba2f-45f6-9f77-4500e5ac6474') + "&XML=" + GetGetJson([{ "entity": "entity" }])
                             + "&WHERE=chk_sure=1",
               width: '100%',
               singleSelect: true, //单行选择
               //fit: true,
               pagination: true, //是否开启分页
               pageSize: 20, //默认一页数据条数
               onDblClickRow: dginitSelectorgDblClickRow,
               columns: [[
                   { field: 'orgid', title: '维修商编号', width: 80, search: true, sortable: true },
                   { field: 'assitenid', title: '助记码', width: 60, search: true, sortable: true },
                   { field: 'name', title: '维修商名称', width: 100, search: true, sortable: true },
                   { field: 'linkman', title: '联系人', width: 100, search: true, sortable: true },
                   { field: 'tel', title: '联系电话', width: 100, search: true, sortable: true }
               ]]
           }
           );
}
function dginitSelectorgDblClickRow() {
    if (m_selectorg == 'ture') {
        var SelectOrg = $('#divSelectOrg').datagrid('getSelected')
        $('#divSelectOrg').window('close');
        $('#txtname').val(SelectOrg.name);
        $('#txtorgid').val(SelectOrg.orgid);
    }
    else {
        $('#divSelectOrg').window('close');
        var SelectOrg = $('#divSelectOrg').datagrid('getSelected')
        $('#txtorg_linkname_reture').val(SelectOrg.linkman);
        $('#txtorgtel_reture').val(SelectOrg.tel);
        $('#txtorg_reture').val(SelectOrg.name);
        $('#txtorgid_reture').val(SelectOrg.orgid);
    }
}
//更改计划
function change_cancel() {
    $('#form_change').window('close')
}
function ChangePlan() {

    var selected = $('#tab_list').datagrid('getSelected');
    if (!selected) {
        alert('请选择数据');
        return;
    }
    var S_state = selected.state

    if (S_state != "已更改" && S_state != "已跟进" && S_state != "施工超期") {
        alert('请选择已处理且未完成的数据');
        return;
    }
    $('#txtschemaenddate_change').datebox({
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false,
        formatter: function (date) { return date.getFullYear() + '/' + (date.getMonth() + 1) + '/' + date.getDate(); }
    });

    $('#txtbillid_change').val(selected.billid);
    $('#txtchangecause').val("");
    $('#txtschemaenddate_change').datebox('setValue', selected.schemaenddate);

    //$('#txtschemaenddate_change').datebox('setValue', "");

    $('#form_change').window({
        title: "更改计划",
        top: 100,
        width: 400,
        height: 280,
        modal: true
    });

}
function change_submit() {
    var selected = $('#tab_list').datagrid('getSelected');
    $('#form_change').form('submit', {
        onSubmit: function (e) {
            if ($('#form_change').form('validate') == false) {
                $.messager.alert("提示", "请把必填项填完！", 'error');
                return false;
            }
            $('#form_change').window('close');

            var data = $('#form_change').serializeArray();

            data[data.length] = { "name": "txtstate", "value": "6" }
            data[data.length] = { "name": "txtbillid", "value": selected.billid }
            data[data.length] = { "name": "txtdepotid", "value": selected.depotid }

            var XMLData = GetFormJson(data, 'CHANGE_UPDATE');
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('8bb9dd9c-1299-45b0-bdcb-bba7e5d8d55e'),
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

            return false;
        }
    });

}
//确认
function save_cancel() {
    $('#form_save').window('close')
}
function Save() {
    var selected = $('#tab_list').datagrid('getSelected');
    if (!selected) {
        alert('请选择数据');
        return;
    }
    var S_state = selected.state

    if (S_state != "已跟进" && S_state != "已更改" && S_state != "施工超期") {
        alert('请选择已处理过数据');
        return;
    }
    $('#txtenddate').datebox({
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false,
        required: true,
        formatter: function (date) { return date.getFullYear() + '/' + (date.getMonth() + 1) + '/' + date.getDate(); }
    });
    $('#form_save').window({
        title: "确认完成",
        top: 100,
        width: 390,
        height: 150,
        modal: true
    });
    $('#txtopinion').combobox({
        valueField: 'id',
        textField: 'text',
        data: [{ "id": "好", "text": "好", "selected": true }, { "id": "一般", "text": "一般" }, { "id": "不好", "text": "不好" }],
        panelHeight: 'auto',
        editable: false,
        required: true
    });
    $('#txtbillid_save').val(selected.billid);
    $('#txtenddate').datebox('setValue', '')
}
function save_submit() {
    var selected = $('#tab_list').datagrid('getSelected');
    $('#form_save').form('submit', {
        onSubmit: function (e) {
            if ($('#form_save').form('validate') == false) {
                $.messager.alert("提示", "请把必填项填完！", 'error');
                return false;
            }
            $('#form_save').window('close');

            var data = $('#form_save').serializeArray();

            data[data.length] = { "name": "txtstate", "value": "5" }
            data[data.length] = { "name": "txtbillid", "value": selected.billid }
            data[data.length] = { "name": "txtdepotid", "value": selected.depotid }


            var XMLData = GetFormJson(data, 'SAVE_UPDATE');
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            //return;
            $.ajax({
                url: GetWSRRURL('8bb9dd9c-1299-45b0-bdcb-bba7e5d8d55e'),
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

            return false;
        }
    });

}
//删除
function Delete(Judge) {

    var selected = $('#tab_list').datagrid('getSelected');

    if (!selected) {
        alert('请选择数据');
        return;
    }
    var S_state = selected.state

    if (Judge) {
        if (S_state != "未上报") {
            alert('该数据已经上报，无法删除');
            return;
        }
    }
    else {
        if (S_state != "已上报") {
            alert('只能删除已经上报的单据');
            return;
        }
    }
    $.messager.confirm('提示框', '是否确定', function (r) {
        if (r) {

            var data = [];
            data[data.length] = { "name": "txtstate", "value": selected.state };
            data[data.length] = { "name": "txtbillid", "value": selected.billid };
            data[data.length] = { "name": "txtdepotid", "value": selected.depotid };
            var XMLData = GetFormJson(data, 'DELETE');
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('8bb9dd9c-1299-45b0-bdcb-bba7e5d8d55e'),
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

            return false;
        }
    });

}

function InitGird_select() {
    ClearGrid("#tab_list");

    if ($('#form_select').form('validate') == false) {
        $.messager.alert("提示", "请把必填项填完！", 'error');
        return false;
    }
    var txtcreatetime_star = $('#txtcreatetime_star').datebox('getValue');
    var txttcreatetime_end = $('#txtcreatetime_end').datebox('getValue');
    var txtselectparentid = $('#txtselectparentid').combobox('getText');
    var txtselecttypeid = $('#txtselecttypeid').combobox('getText');
    var txtselectstate = $('#txtselectstate').combobox('getText');
    var txtselectform = $('#txtform').combobox('getText');
    var txtselectcom = $('#txtselectcom').combobox('getText');

    var url = "1=1";
    if (txtcreatetime_star != "") {
        url += " and createtime between '" + txtcreatetime_star + "'" + " AND " + "'" + txttcreatetime_end + "'";
    }
    if (txtselectparentid != "全部") {
        url += " and 大类名称='" + txtselectparentid + "'";
    }
    if (txtselecttypeid == "全部") {
        url = url;
    }
    else {
        url += " and 小类名称='" + txtselecttypeid + "'";
    }
    if (txtselectform == "全部") {
        url = url;
    }
    else {
        url += " and j_form='" + txtselectform + "'";
    }
    if (txtselectcom == "全部") {
        url = url;
    }
    else {
        url += " and 公司='" + txtselectcom + "'";
    }
    if (txtselectstate == "") {
        url += " and state in ('未上报','已上报','已跟进','已更改','已退回','超期','完成')";
    }
    else {
        var txtselectstate_forselect = txtselectstate.replace(/\,/g, "','");
        url += " and state in ('" + txtselectstate_forselect + "')";
    }
    url = GetWSRRURL('8bb9dd9c-1299-45b0-bdcb-bba7e5d8d55e') + "&XML=" + GetGetJson([{ "entity": "entity" }]) + "&WHERE=" + escape(url);

    InitGrid(url);
}

function InitGrid(url) {

    ClearGrid("#tab_list");
    $('#tab_list').datagrid(

        {
            title: '报修单', //表格标题
            url: url,
            queryParams: { "XML": GetGetJson([{}]) },
            sortName: 'billid', //排序字段
            idField: 'billid', //标识字段,主键
            width: '90%', //宽度
            height: $(document).height() - 20, //高度
            nowrap: true, //是否换行，True 就会把数据显示在一行里
            remoteSort: true, //定义是否从服务器给数据排序
            collapsible: false, //可折叠
            sortOrder: 'DESC', //排序类型
            sortable: true,
            striped: true, //True 奇偶行使用不同背景色
            singleSelect: true, //单行选择
            fit: true,
            pagination: true, //是否开启分页
            pageSize: 20, //默认一页数据条数 
            pageList: [10, 20, 30, 40, 50, 100, 500, 1000, 5000, 10000],
            onSelect: onClickRow,
            onDblClickRow: onDblClickRow,
            rowStyler: function (index, row) {
                if (row.state == "未上报") {
                    return 'background-color:#FFEBCD;color:#000000;font-weight:bold;';
                }
                if (row.state == "已上报") {
                    return 'background-color:#FFFF66;color:#000000;font-weight:bold;';
                }
                if (row.state == "已跟进") {
                    return 'background-color:#00CCFF;color:#000000;font-weight:bold;';
                }
                if (row.state == "已退回") {
                    return 'background-color:#999999;color:#000000;font-weight:bold;';
                }
                if (row.state == "施工超期") {
                    return 'background-color:#FF7F50;color:#000000';
                }
                if (row.state == "完成") {
                    return 'background-color:#669933;color:#000000;font-weight:bold;';
                }
                if (row.state == "已更改") {
                    return 'background-color:#00CCFF;color:#000000;font-weight:bold;';
                }
                if (row.state == "处理超期") {
                    return 'background-color:#FF7F50;color:#000000';
                }
            },
            frozenColumns: [[
            ]],
            columns: [[
                { field: 'ck', checkbox: true },
                { field: 'img', title: '图片', width: 30, sortable: true },
                { field: 'billid', title: '编号', width: 45, search: true, sortable: true },
                { field: 'depotid', title: '店铺编号', width: 70, search: true, sortable: true },
                { field: '公司', title: '公司', width: 40, sortable: true },
                { field: 'j_form', title: '店铺类型', search: true, width: 55, sortable: true },
                { field: 'depotname', title: '店铺名称', width: 120, search: true, sortable: true },
                { field: '大类名称', title: '种类', width: 70, search: true, sortable: true },
                { field: '小类名称', title: '品类', width: 70, search: true, sortable: true },
                { field: 'content', title: '内容', width: 100, sortable: true },
                { field: 'state', title: '状态', width: 60, search: true, sortable: true },
                { field: 'chk_date', title: '报修时间', width: 75, sortable: true },
                { field: 'fb_date', title: '反馈时间', width: 75, sortable: true },
                { field: 'isquality', title: '质保', width: 35, search: true, sortable: true },
                { field: '维修商', title: '维修商', width: 100, search: true, sortable: true },
                { field: 'ischangeschema', title: '计划变更', width: 60, search: true, sortable: true },
                { field: 'schemaenddate', title: '计划完成时间', width: 80, search: true, sortable: true },
                { field: 'enddate', title: '完工时间', width: 75, search: true, sortable: true }
            ]],
            onLoadSuccess: function (data) {
                ReadeAuz();
                if (m_ExportFlag == true) {
                    m_ExportFlag = false;
                    Export('导出excel', $('#tab_list'));
                    $dg.datagrid({ pagination: true });
                }
            },
            toolbar: "#tab_toolbar",
            toolbar: [
            {
                id: 'btn_shop',
                text: '店铺上报',
                iconCls: 'icon-add',
                handler: function () {
                    AddNew(true);
                }
            },
            {
                id: 'btn_general',
                text: '总部代报',
                iconCls: 'icon-add',
                handler: function () {
                    AddNew(false);
                }
            },
            {
                id: 'btn_submit',
                text: '上报',
                iconCls: 'icon-save',
                handler: function () {
                    Submit();
                }
            },
            {
                id: 'btn_reply',
                text: '总部回复',
                iconCls: 'icon-redo',
                handler: function () {
                    Reply();
                }
            },
            {
                id: 'btn_change',
                text: '更改计划',
                iconCls: 'icon-back',
                handler: function () {
                    ChangePlan();
                }
            },
            {
                id: 'btn_shopconfirm',
                text: '店铺确认完成',
                iconCls: 'icon-ok',
                handler: function () {
                    Save();
                }
            },
            {
                id: 'btn_generalconfirm',
                text: '总部代确认完成',
                iconCls: 'icon-ok',
                handler: function () {
                    Save();
                }
            },
            {
                id: 'btn_delete',
                text: '删除未上报单据',
                iconCls: 'icon-cancel',
                handler: function () {
                    Delete(true);
                }
            },
            {
                id: 'btn_deleteconfirm',
                text: '删除上报单据',
                iconCls: 'icon-cancel',
                handler: function () {
                    Delete(false);
                }
            }
            //,
            //{
            //    id: 'btn_Export',
            //    text: '导出',
            //    iconCls: 'icon-sum',
            //    handler: function () {
            //        Export_OnClick();
            //    }
            //}
            ]
        });
    var $dg = $('#tab_list');
    var col = undefined;
    col = $dg.datagrid('getColumnOption', 'img');
    if (col != null) {
        col.formatter = function (value) {
            var strSmallImg = "";
            if (value != "") {
                strSmallImg = value.substr(0, value.length - 4) + "small" + value.substr(value.length - 4);

                var data = "<a href='" + value + "' target='_blank'><img  src='" + strSmallImg + "' style='width:20px;height:20px'/></a>";
                return data;
            }
            else {
                return "";
            }
        }
    }
    $dg.datagrid();
    ReadeAuz();
}

//控制按钮是否可点击
function onClickRow(RowIndex, RowData) {
    //var selected = $('#tab_list').datagrid('getSelected');
    var type_state = RowData.state;
    if (type_state == "未上报") {
        $('#btn_shop').linkbutton('enable');
        $('#btn_general').linkbutton('enable');
        $('#btn_submit').linkbutton('enable');
        $('#btn_reply').linkbutton('disable');
        $('#btn_change').linkbutton('disable');
        $('#btn_shopconfirm').linkbutton('disable');
        $('#btn_generalconfirm').linkbutton('disable');
        $('#btn_delete').linkbutton('enable');
        $('#btn_deleteconfirm').linkbutton('disable');
    }
    else if (type_state == "已上报") {
        $('#btn_shop').linkbutton('enable');
        $('#btn_general').linkbutton('enable');
        $('#btn_submit').linkbutton('disable');
        $('#btn_reply').linkbutton('enable');
        $('#btn_change').linkbutton('disable');
        $('#btn_shopconfirm').linkbutton('disable');
        $('#btn_generalconfirm').linkbutton('disable');
        $('#btn_delete').linkbutton('disable');
        $('#btn_deleteconfirm').linkbutton('enable');
    }
    else if (type_state == "已跟进") {
        $('#btn_shop').linkbutton('enable');
        $('#btn_general').linkbutton('enable');
        $('#btn_submit').linkbutton('disable');
        $('#btn_reply').linkbutton('disable');
        $('#btn_change').linkbutton('enable');
        $('#btn_shopconfirm').linkbutton('enable');
        $('#btn_generalconfirm').linkbutton('disable');
        $('#btn_delete').linkbutton('disable');
        $('#btn_deleteconfirm').linkbutton('disable');
    }
    else if (type_state == "已更改") {
        $('#btn_shop').linkbutton('enable');
        $('#btn_general').linkbutton('enable');
        $('#btn_submit').linkbutton('disable');
        $('#btn_reply').linkbutton('disable');
        $('#btn_change').linkbutton('enable');
        $('#btn_shopconfirm').linkbutton('enable');
        $('#btn_generalconfirm').linkbutton('enable');
        $('#btn_delete').linkbutton('disable');
        $('#btn_deleteconfirm').linkbutton('disable');
    }
    else if (type_state == "已退回") {
        $('#btn_shop').linkbutton('enable');
        $('#btn_general').linkbutton('enable');
        $('#btn_submit').linkbutton('disable');
        $('#btn_reply').linkbutton('disable');
        $('#btn_change').linkbutton('disable');
        $('#btn_shopconfirm').linkbutton('disable');
        $('#btn_generalconfirm').linkbutton('disable');
        $('#btn_delete').linkbutton('disable');
        $('#btn_deleteconfirm').linkbutton('disable');
    }
    else if (type_state == "完成") {
        $('#btn_shop').linkbutton('enable');
        $('#btn_general').linkbutton('enable');
        $('#btn_submit').linkbutton('disable');
        $('#btn_reply').linkbutton('disable');
        $('#btn_change').linkbutton('disable');
        $('#btn_shopconfirm').linkbutton('disable');
        $('#btn_generalconfirm').linkbutton('disable');
        $('#btn_delete').linkbutton('disable');
        $('#btn_deleteconfirm').linkbutton('disable');
    }
    else if (type_state == "施工超期") {
        $('#btn_shop').linkbutton('enable');
        $('#btn_general').linkbutton('enable');
        $('#btn_submit').linkbutton('disable');
        $('#btn_reply').linkbutton('disable');
        $('#btn_change').linkbutton('enable');
        $('#btn_shopconfirm').linkbutton('enable');
        $('#btn_generalconfirm').linkbutton('enable');
        $('#btn_delete').linkbutton('disable');
        $('#btn_deleteconfirm').linkbutton('disable');
    }
    else if (type_state == "处理超期") {
        $('#btn_shop').linkbutton('enable');
        $('#btn_general').linkbutton('enable');
        $('#btn_submit').linkbutton('disable');
        $('#btn_reply').linkbutton('enable');
        $('#btn_change').linkbutton('disable');
        $('#btn_shopconfirm').linkbutton('disable');
        $('#btn_generalconfirm').linkbutton('disable');
        $('#btn_delete').linkbutton('disable');
        $('#btn_deleteconfirm').linkbutton('disable');
    }
}

function Export_OnClick() {
    var $dg = $('#tab_list');
    m_ExportFlag = true;
    $dg.datagrid({ pagination: false });
}


function onDblClickRow(rowIndex, rowData) {
    var m_Dbstate = rowData.state;
    if (m_Dbstate == "完成") {
        onDblClickRow_edit(false, rowIndex, rowData)
    }
    else {
        onDblClickRow_edit(true, rowIndex, rowData)
    }
    Inireture_detail()
}


function onDblClickRow_edit(tpye, rowIndex, rowData) {

    if ($("#btn_reply").is(":hidden") == true) {
        $("#A10").hide();
        //$("#A11").hide();
        //document.getElementById('txtselectorgid_reture').disabled = "disabled"
        $('#txtisquality_reture').attr("disabled", "disabled");
        $('#txtorg_reture').attr("disabled", "disabled");
        $('#txtfb_content_reture').attr("disabled", "disabled");
        $('#txtfb_comment_reture').attr("disabled", "disabled");

    }
    else {
        $("#A10").show();
        //$("#A11").show();
        $('#txtisquality_reture').attr("disabled", "");
        $('#txtorg_reture').attr("disabled", "disabled");
        $('#txtfb_content_reture').attr("disabled", "");
        $('#txtfb_comment_reture').attr("disabled", "");
    }
    if (tpye) {
        $('#Mat_bill').window({
            title: "报修单",
            top: 20,
            width: 800,
            height: 450,
            modal: true
        });

        if (rowData.state == "未上报" || rowData.state == "已上报") {
            document.getElementById('txtselectorgid_reture').disabled = "disabled";
            $('#txtfb_comment_reture').attr("disabled", "disabled");
            $('#txtfb_content_reture').attr("disabled", "disabled");
            $('#txtisquality_reture').combobox({ disabled: true });
            $("#A10").hide();

        }
        else {
            document.getElementById('txtselectorgid_reture').disabled = "";
            //    //$("#A10").show();
        }
        $('#txtbillid_edit').val(rowData.billid);
        $('#txtcom_edit').val(rowData.公司);
        $('#txtform_edit').val(rowData.j_form);
        $('#txtdepotname_edit').val(rowData.depotname);
        $('#txtcrname_edit').val(rowData.crname);
        $('#txtcreatetime_edit').val(rowData.createtime);
        $('#txtstate_edit').val(rowData.state);
        $('#txtchk_name_edit').val(rowData.chk_name);
        $('#txtchk_date_edit').val(rowData.chk_date);
        $('#txtparentid_edit').val(rowData.大类名称);
        $('#txttypeid_edit').val(rowData.小类名称);
        $('#txtlinkman_edit').val(rowData.linkman);
        $('#txtlinktel_edit').val(rowData.linktel);
        $('#txtcontent_edit').val(rowData.content);
        $('#txtcomment_edit').val(rowData.comment);
        $('#txtcomment_edit').attr("disabled", "");
        $('#txtlinkman_edit').attr("disabled", "");
        $('#txtlinktel_edit').attr("disabled", "");
        $('#txtimgview').html("");

        var value = rowData.img;
        strSmallImg = value.substr(0, value.length - 4) + "small" + value.substr(value.length - 4);

        $("<img src='" + strSmallImg + "' style='width:150px;height:100px'/>").appendTo($('#txtimgview'));

        $('#txtfb_date_reture').val(rowData.fb_date);
        $('#txtfb_name_reture').val(rowData.fb_name);
        $('#txtendday_reture').val(rowData.endday);
        $('#txtorg_reture').val(rowData.维修商);
        $('#txtorg_linkname_reture').val(rowData.orglinkman);
        $('#txtorgtel_reture').val(rowData.orgtel);
        $('#txtischangeschema_reture').val(rowData.ischangeschema);
        $('#txtenddate_reture').val(rowData.enddate);
        $('#txtschemaenddate_reture').val(rowData.schemaenddate);
        $('#txtenddate_reture').val(rowData.enddate);
        $('#txtopinion_reture').val(rowData.opinion);
        $('#txtfb_content_reture').val(rowData.fb_content);
        $('#txtfb_comment_reture').val(rowData.fb_comment);
        $('#txtchangecause_reture').val(rowData.changecause);
        //$('#txtisquality_reture').combobox({ disabled: false });
        $("#A8").show();


        $('#txtisquality_reture').combobox({
            valueField: 'id',
            textField: 'text',
            data: [{ "id": "是", "text": "是" }, { "id": "否", "text": "否" }],
            editable: false,
            required: true,
            panelHeight: 'auto'
        });
        $('#txtisquality_reture').combobox('setValue', rowData.isquality);


    }
    else {
        $('#Mat_bill').window({
            title: "报修单",
            top: 20,
            width: 800,
            height: 450,
            modal: true
        });

        $('#txtbillid_edit').val(rowData.billid);
        $('#txtcom_edit').val(rowData.公司);
        $('#txtform_edit').val(rowData.j_form);
        $('#txtdepotname_edit').val(rowData.depotname);
        $('#txtcrname_edit').val(rowData.crname);
        $('#txtcreatetime_edit').val(rowData.createtime);
        $('#txtstate_edit').val(rowData.state);
        $('#txtchk_name_edit').val(rowData.chk_name);
        $('#txtchk_date_edit').val(rowData.chk_date);
        $('#txtparentid_edit').val(rowData.大类名称);
        $('#txttypeid_edit').val(rowData.小类名称);
        $('#txtimgview').val(rowData.imgview);
        $('#txtlinkman_edit').val(rowData.linkman);
        $('#txtlinktel_edit').val(rowData.linktel);
        $('#txtcontent_edit').val(rowData.content);
        $('#txtcomment_edit').val(rowData.comment);
        $('#txtcomment_edit').attr("disabled", "disabled");
        $('#txtlinkman_edit').attr("disabled", "disabled");
        $('#txtlinktel_edit').attr("disabled", "disabled");
        $('#txtimgview').html("");

        var value = rowData.img;
        strSmallImg = value.substr(0, value.length - 4) + "small" + value.substr(value.length - 4);


        $("<img src='" + strSmallImg + "' style='width:150px;height:100px'/>").appendTo($('#txtimgview'));

        document.getElementById('txtselectorgid_reture').disabled = "disabled"

        $('#txtfb_date_reture').val(rowData.fb_date);
        $('#txtfb_name_reture').val(rowData.fb_name);
        $('#txtendday_reture').val(rowData.endday);
        $('#txtorg_reture').val(rowData.维修商);
        $('#txtorg_linkname_reture').val(rowData.orglinkman);
        $('#txtorgtel_reture').val(rowData.orgtel);

        $('#txtisquality_reture').combobox({ disabled: true });

        $('#txtisquality_reture').combobox('setValue', rowData.isquality);


        $('#txtischangeschema_reture').val(rowData.ischangeschema);
        $('#txtenddate_reture').val(rowData.enddate);
        $('#txtschemaenddate_reture').val(rowData.schemaenddate);
        $('#txtenddate_reture').val(rowData.enddate);
        $('#txtopinion_reture').val(rowData.opinion);
        $('#txtfb_content_reture').val(rowData.fb_content);
        $('#txtfb_comment_reture').val(rowData.fb_comment);
        $('#txtchangecause_reture').val(rowData.changecause);
        $('#txtfb_comment_reture').attr("disabled", "disabled");
        $('#txtfb_content_reture').attr("disabled", "disabled");
        $("#A10").hide();
        $("#A8").hide();
        //$("#A11").hide();
    }
}

function edit_cancel() {
    $('#Mat_bill').window('close')
}
function edit_submit() {
    var selected = $('#tab_list').datagrid('getSelected');
    $('#form_info').form('submit', {
        onSubmit: function (e) {
            var data = $('#form_info').serializeArray();
            data[data.length] = { "name": "txtbillid", "value": selected.billid };
            $('#Mat_bill').window('close');
            var XMLData = GetFormJson(data, 'INFO_UPDATE');
            //return;
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('8bb9dd9c-1299-45b0-bdcb-bba7e5d8d55e'),
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

            return false;
        }
    });

}


function reture_submit() {

    var selected = $('#tab_list').datagrid('getSelected');
    $('#form_reture').form('submit', {
        onSubmit: function (e) {
            var data = $('#form_reture').serializeArray();
            data[data.length] = { "name": "txtbillid", "value": selected.billid };
            $('#Mat_bill').window('close');
            var XMLData = GetFormJson(data, 'RETURE_UPDATE');

            //return;
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('8bb9dd9c-1299-45b0-bdcb-bba7e5d8d55e'),
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

            return false;
        }
    });

}






function Inireture_detail() {
    var selected = $('#tab_list').datagrid('getSelected');

    ClearGrid("#txtreture_detail");
    $('#txtreture_detail').datagrid(
       {
           url: GetWSRRURL('8bb9dd9c-1299-45b0-bdcb-bba7e5d8d55e'),
           queryParams: { "XML": GetFormJson("", 'RETURE_DETAIL'), "WHERE": "billid=" + "'" + selected.billid + "'" },
           sortName: 'createtime', //排序字段
           sortable: true,
           iconCls: '', //标题左边的图标
           nowrap: true, //是否换行，True 就会把数据显示在一行里
           striped: true, //True 奇偶行使用不同背景色
           collapsible: false, //可折叠
           sortOrder: 'asc', //排序类型
           //height:$("form_reture").height-,
           remoteSort: false, //定义是否从服务器给数据排序
           fit: true,
           //pagination: true, //是否开启分页
           pageSize: 5, //默认一页数据条数
           singleSelect: true, //单行选择
           columns: [[
               { field: 'billid', title: '单号', width: 100 },
               { field: 'schemaenddate', title: '计划完成时间', width: 120 },
               { field: 'changecause', title: '原因', width: 300 },
               { field: 'createtime', title: '更改时间', width: 150 }
           ]]
       }
 );
}
var m_compName = $.cookie("compName"); //获取事业体
var m_data = [{ "name": "txtzt", "value": m_compName }];
var m_state = [{ "id": "20", "text": "正常" }, { "id": "99", "text": "禁用" }];

$(function () {
    var url = GetWSRRURL('ffda947c-e49f-4106-982a-dbda0664b282') + "&XML=" + GetFormJson('', 'SupplierInfoForPageList');
    InitGird(url);

    suppWin();
})

//加载数据
function InitGird(url) {
    $('#tab_list').datagrid(
            {
                url: url,
                sortName: 'sp1_lmdt', //排序字段
                idField: 'sp1_suppliercode', //标识字段,主键
                width: '90%', //宽度
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
                rownumbers: true,//行号
                columns: [[
                    { field: 'sp1_suppliercode', title: '供应商编号', width: 65, search: true, sortable: true },
                    { field: 'sp1_name', title: '供应商简称', width: 100, search: true, sortable: true },
                    { field: 'sp1_desp', title: '供应商名称', width: 200, search: true, sortable: true },
                    { field: 'sp1_typename', title: '供应商类别', width: 65, search: true, sortable: true },
                    { field: 'sp1_featurename', title: '供应商特性', width: 65, search: true, sortable: true },
                    { field: 'sp1_regionname', title: '供应商类型', width: 65, search: true, sortable: true },
                    { field: 'sp1_state', title: '供应商状态', width: 65, search: true, sortable: true },
                    { field: 'sp1_contacts', title: '联系人', width: 65, search: true, sortable: true },
                    { field: 'sp1_contacttel', title: '联系电话', width: 100, search: true, sortable: true },
                    { field: 'sp1_address', title: '地址', width: 65, search: true, sortable: true },
                    { field: 'sp1_bankname', title: '开户行', width: 100, search: true, sortable: true },
                    { field: 'sp1_bankaccount', title: '银行账号', width: 100, search: true, sortable: true },
                    { field: 'sp1_bankaddress', title: '银行地址', width: 65, search: true, sortable: true },
                    { field: 'sp1_bankswiftid', title: '银行SWIFT', width: 100, search: true, sortable: true },
                    { field: 'sp1_lmuser', title: '更新人', width: 65, search: true, sortable: true },
                    { field: 'sp1_lmdt', title: '更新时间', width: 65, search: true, sortable: true }
                ]],
                toolbar: [{
                    iconCls: 'icon-add',
                    text: '新增',
                    handler: function () {
                        winFormBuild("new");
                        $("#supplierWin").window("open");
                    }
                }, '-', {
                    iconCls: 'icon-edit',
                    text: '修改',
                    handler: function () {
                        if (winFormBuild("edit")) {
                            $("#supplierWin").window("open");
                        };
                    }
                }]
            });
    var $dg = $('#tab_list');
    col = $dg.datagrid('getColumnOption', 'sp1_state');
    if (col != null) {
        col.formatter = function (value) {
            return GetCommboboxText(m_state, value);
        }
    }
}

//模糊查询
function doSearch() {
    var strSearchBoxForSupplier = $('#SearchBoxForSupplier').searchbox('getValue');//取查询框数据
    var url = "1=1";
    if (strSearchBoxForSupplier == "") {
        url = url
    } else {
        url += " and sp1_name like '%" + strSearchBoxForSupplier + "%' or sp1_desp like '%" + strSearchBoxForSupplier + "%' ";
    }
    url = GetWSRRURL('ffda947c-e49f-4106-982a-dbda0664b282') + "&XML=" + GetFormJson('', 'SupplierInfoForPageList');
    InitGird(url);
}

//供应商操作窗口
function suppWin() {
    var tit = ""

    if (m_compName == "GL") {
        tit = "雅斓供应商维护";
    }
    if (m_compName == "LX") {
        tit = "斓绣供应商维护";
    }
    if (m_compName == "RS") {
        tit = "斓居供应商维护";
    }
    $("#supplierWin").window({
        title: tit,
        //fit: true,
        closed: true,
        minimizable: false,
        maximizable: false,
        modal: true,
        //draggable: false,   //窗口拖动
        collapsible: false, //折叠按钮
        closable: false    //关闭按钮
    }).window('close');
    winButton();
}
function winButton() {
    $("#winSaveNew").linkbutton({ iconCls: 'icon-ok', plain: true }).click(function () { suppSave("new") });
    $("#winSaveClose").linkbutton({ iconCls: 'icon-ok', plain: true }).click(function () { suppSave("close") });
    $("#winClose").linkbutton({ iconCls: 'icon-undo', plain: true }).click(winClose);
}
function winFormBuild(type) {

    if (type == "edit") {
        var getData = $('#tab_list').datagrid('getSelected')
        if (!getData) {
            alert('请选择一行');
            return false;
        }
    }

    var formHtml = "<form id=\"saveForm\">";
    formHtml += "<div style=\"padding:5px;\">";

    if (type == "new") {
        formHtml += "供应商编号：<input id=\"suppCode\" style=\"width:100px; background-color:#fff; border:0px; color:#808080;\" value=\"系统生成\" />";
        formHtml += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
        formHtml += "供应商状态：<span style=\"color:#808080\">启用</span>";
        formHtml += "</div>";
    }
    if (type == "edit") {
        formHtml += "供应商编号：<input id=\"suppCode\" style=\"width:100px; background-color:#fff; border:0px; color:#808080;\" />";
        formHtml += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
        formHtml += "供应商状态：<input id=\"start\" style=\"width:100px;\" />";
        formHtml += "</div>";
    }

    if (type == "new") {
        formHtml += "<div style=\"padding-left:5px;padding-top:20px;\">";
        formHtml += "供应商简称：<input id=\"shortName\" style=\"width:100px;\" />";
        formHtml += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
        formHtml += "供应商名称：<input id=\"fullName\" style=\"width:200px;\" /></div>";
        formHtml += "<div style=\"padding-left:5px;padding-top:20px;\">";
    }
    if (type == "edit") {
        formHtml += "<div style=\"padding-left:5px;padding-top:20px;\">";
        formHtml += "供应商简称：<span id=\"shortName\" style=\"color:#808080\">" + getData.sp1_name + "</span>";
        formHtml += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
        formHtml += "供应商名称：<span id=\"fullName\" style=\"color:#808080\">" + getData.sp1_desp + "</span></div>";
        formHtml += "<div style=\"padding-left:5px;padding-top:20px;\">";
    }

    //if (type == "new") {
    //    if (m_compName == "LX") {
    //        formHtml += "所属公司：<input id=\"company\" />";
    //        formHtml += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
    //    };
    //};
    //if (type == "edit") {
    //    if (m_compName == "LX") {
    //        var compName;
    //        var combCompVal = getData.sp1_suppliercode.substr(0, 1);

    //        if (combCompVal == "R") {
    //            compName = "斓居百货商行";
    //        } else {
    //            compName = "斓绣生活家居";
    //        }

    //        formHtml += "所属公司：<span style=\"color:#808080\">" + compName + "</span>";
    //        formHtml += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
    //    };
    //};

    if (type == "new") {
        formHtml += "供应商特性：<input id=\"featurename\" style=\"width:100px;\" />";
        formHtml += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
        formHtml += "供应商类别：<input id=\"typecode\" style=\"width:100px;\" />";
        formHtml += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
        formHtml += "供应商分类：<input id=\"regioncode\" style=\"width:100px;\" />";
        formHtml += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
        formHtml += "供应商税率：<input id=\"tax\" style=\"width:50px;\" />";
        formHtml += "%</div>";
    };
    if (type == "edit") {
        formHtml += "供应商特性：<span style=\"color:#808080\">" + getData.sp1_featurename + "</span>";
        formHtml += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
        formHtml += "供应商类别：<span style=\"color:#808080\">" + getData.sp1_typename + "</span>";
        formHtml += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
        formHtml += "供应商分类：<span style=\"color:#808080\">" + getData.sp1_regionname + "</span>";
        formHtml += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
        formHtml += "供应商税率：<input id=\"tax\" style=\"width:50px;\" />";
        formHtml += "%</div>";
    };

    formHtml += "<div style=\"padding-left:5px;padding-top:30px;\">";
    formHtml += "联系人：<input id=\"contacts\" style=\"width:100px;\" />";
    formHtml += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
    formHtml += "联系电话：<input id=\"contacttel\" style=\"width:150px;\" />";
    formHtml += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
    formHtml += "通讯地址：<input id=\"address\" style=\"width:250px;\" />";

    formHtml += "</div>";
    formHtml += "<div style=\"padding-left:5px;padding-top:20px;\">";
    formHtml += "开户行：<input id=\"bankname\" style=\"width:100px;\" />";
    formHtml += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
    formHtml += "银行账号：<input id=\"bankaccount\" style=\"width:150px;\" />";
    formHtml += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
    formHtml += "银行地址：<input id=\"bankaddress\" style=\"width:250px;\" />";
    formHtml += "<br /><br />"
    formHtml += "银行SWIFT：<input id=\"bankswiftid\" style=\"width:100px;\" />";
    formHtml += "</div>";
    formHtml += "</form>";
    //if (type == "new") {

    //    $("#winTag").html("新增供应商");
    //}
    //if (type == "edit") {
    //    $("#winTag").html("修改供应商");
    //}

    $("#winform").html(formHtml);

    //初始化下拉框
    formInputINIT(type);

    if (type == "edit") {
        $("#suppCode").val(getData.sp1_suppliercode);
        $("#tax").numberbox("setValue", getData.sp1_supplytax);
        $("#start").combobox("setValue", getData.sp1_state);
        $("#contacts").val(getData.sp1_contacts);
        $("#contacttel").val(getData.sp1_contacttel);
        $("#address").val(getData.sp1_address);
        $("#bankname").val(getData.sp1_bankname);
        $("#bankaccount").val(getData.sp1_bankaccount);
        $("#bankaddress").val(getData.sp1_bankaddress);
        $("#bankswiftid").val(getData.sp1_bankswiftid);
        $("#tax").focus();
    }

    return true;
}
function formInputINIT(type) {
    if (type == "new") {
        //简称
        $("#shortName").validatebox({ required: true }).val("");
        //全称
        $("#fullName").validatebox({ required: true }).val("");
        //公司
        //if (m_compName == "LX") {
        //    $("#company").combobox({
        //        url: GetComboxWSRRURL('7ea4d40d-02fa-43cf-ae3c-8231943f8124') + "&XML=" + GetFormJson('', 'SupplierBasicInfo') + "&Where=CT1_Code ='COMP'",
        //        valueField: 'id',
        //        textField: 'text',
        //        panelHeight: 'auto',
        //        editable: false,
        //        required: true
        //    }).combobox("setValue", "");
        //};
        //特性
        $("#featurename").combobox({
            url: GetComboxWSRRURL('7ea4d40d-02fa-43cf-ae3c-8231943f8124') + "&XML=" + GetFormJson('', 'SupplierBasicInfo') + "&Where=CT1_Code ='FEAT'",
            valueField: 'id',
            textField: 'text',
            panelHeight: 'auto',
            editable: false,
            required: true
        }).combobox("setValue", "");
        //类别
        $("#typecode").combobox({
            url: GetComboxWSRRURL('7ea4d40d-02fa-43cf-ae3c-8231943f8124') + "&XML=" + GetFormJson('', 'SupplierBasicInfo') + "&Where=CT1_Code ='CATE'",
            valueField: 'id',
            textField: 'text',
            panelHeight: 'auto',
            editable: false,
            required: true
        }).combobox("setValue", "");
        //分类
        $("#regioncode").combobox({
            url: GetComboxWSRRURL('7ea4d40d-02fa-43cf-ae3c-8231943f8124') + "&XML=" + GetFormJson('', 'SupplierBasicInfo') + "&Where=CT1_Code ='SORT'",
            valueField: 'id',
            textField: 'text',
            panelHeight: 'auto',
            editable: false,
            required: true
        }).combobox("setValue", "");

        $("#tax").numberbox({ required: true, precision: 0 }).val("");
    };
    if (type == "edit") {
        $("#start").combobox({
            url: GetComboxWSRRURL('7ea4d40d-02fa-43cf-ae3c-8231943f8124') + "&XML=" + GetFormJson('', 'SupplierBasicInfo') + "&Where=CT1_Code ='SATE'",
            valueField: 'id',
            textField: 'text',
            panelHeight: 'auto',
            editable: false,
            required: true
        });
    };
    //税率
    $("#tax").numberbox({ required: true, precision: 0 });
}

//保存
function suppSave(followup) {

    //检查
    if ($('#saveForm').form('validate') == false) {
        $.messager.alert("提示", "请把必填项填完！", 'error');
        return;
    };

    //待存数据
    var saveData;

    var suppCode = $("#suppCode").val();

    //拼装数据
    saveData = piecedData(suppCode);

    //提交
    submit(saveData, followup);

}
function piecedData(suppCode) {
    var data = [];
    data[data.length] = { "name": "txtsp1_cono", "value": "HYFG" };
    data[data.length] = { "name": "txtzt", "value": m_compName };
    if (strlen($('#shortName').val()) > 50) {
        $.messager.alert('提示', '供应商简称不能超过50个字符', 'warning');
        return false;
    }
    if (strlen($('#fullName').val()) > 100) {
        $.messager.alert('提示', '供应商名称不能超过50个字符', 'warning');
        return false;
    }
    if (suppCode == "系统生成") {
        //获取供应商编号
        suppCode = getMaxCode();
        if (suppCode == '') {
            $.messager.alert('提示', '生成供应商编号失败!', 'error');
            return false;
        }
        data[data.length] = { "name": "txtsp1_suppliercode", "value": suppCode };//供应商编号
        data[data.length] = { "name": "txtsp1_name", "value": $("#shortName").val() };//简称
        data[data.length] = { "name": "txtsp1_desp", "value": $("#fullName").val() };//全称
        data[data.length] = { "name": "txtsp1_state", "value": "20" };
        data[data.length] = { "name": "txtsp1_featurecode", "value": $("#featurename").combobox("getValue") };//特性
        data[data.length] = { "name": "txtsp1_featurename", "value": $("#featurename").combobox("getText") };//特性名
        data[data.length] = { "name": "txtsp1_typecode", "value": $("#typecode").combobox("getValue") };//类别
        data[data.length] = { "name": "txtsp1_typename", "value": $("#typecode").combobox("getText") };//类别名
        data[data.length] = { "name": "txtsp1_regioncode", "value": $("#regioncode").combobox("getValue") };//分类
        data[data.length] = { "name": "txtsp1_regionname", "value": $("#regioncode").combobox("getText") };//分类名

    } else {
        data[data.length] = { "name": "txtsp1_suppliercode", "value": suppCode };//供应商编号
        data[data.length] = { "name": "txtsp1_state", "value": $("#start").combobox("getValue") };//状态
    }
    data[data.length] = { "name": "txtsp1_supplytax", "value": $("#tax").val() };//税率
    data[data.length] = { "name": "txtsp1_contacts", "value": $("#contacts").val() };//联系人
    data[data.length] = { "name": "txtsp1_contacttel", "value": $("#contacttel").val() };//电话
    data[data.length] = { "name": "txtsp1_address", "value": $("#address").val() };//通讯地址
    data[data.length] = { "name": "txtsp1_bankname", "value": $("#bankname").val() };//开户行
    data[data.length] = { "name": "txtsp1_bankaccount", "value": $("#bankaccount").val() };//银行帐号
    data[data.length] = { "name": "txtsp1_bankaddress", "value": $("#bankaddress").val() };//银行地址
    data[data.length] = { "name": "txtsp1_bankswiftid", "value": $("#bankswiftid").val() };//银行swift

    return data;
}
function getMaxCode() {

    var data = [];

    var sp1_typecode = $("#typecode").combobox("getValue");
    var sp1_regioncode = $("#regioncode").combobox("getValue");
    var sp1_featurecode = $("#featurename").combobox("getValue");
    var company = "";
    if (m_compName == "LX") {
        company = "L";
    }
    if (m_compName == "GL") {
        company = "A"
    }
    if (m_compName == "RS") {
        company = "R";
    }

    data[data.length] = { "name": "txt模块", "value": "GetSupplierInfoFromPos" };
    data[data.length] = { "name": "txt操作类型", "value": "GET" };
    data[data.length] = { "name": "txtDIVI", "value": m_compName };
    data[data.length] = { "name": "txtCONO", "value": "HYFG" };
    data[data.length] = { "name": "texcompany", "value": company + sp1_typecode + sp1_regioncode + sp1_featurecode };
    var xmlData = GetDBFrameAML(data);//组成调用APIxml
    var url = GetWSRRURL('c8704d3c-b80c-437c-83e2-d16d838ed426') + xmlData;
    var htmlobj = $.ajax({
        url: url,
        type: 'post',
        async: false
    });
    var result = $.parseJSON(htmlobj.responseText);

    return result.rows[0]['maxid'];
}
function submit(data, followup) {
    
    $('#saveForm').form('submit', {
        onSubmit: function (e) {
            $.messager.confirm('提示框', '是否确认提交', function (r) {
                if (r) {
                    var XMLData = GetFormJson(data, 'EDIT');
                    $.messager.progress({ title: '请稍后', msg: '处理中' });
                    $.ajax({
                        url: GetWSRRURL('ffda947c-e49f-4106-982a-dbda0664b282'),
                        type: 'post',
                        async: false, //同步,
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
                                    $.messager.progress('close');

                                    //同步到POS
                                    esbPOSERP(data[2].value, $("#shortName").val(), $("#fullName").val(),
                                        $("#contacts").val(), $("#contacttel").val(), "", $("#address").val(), $("#bankname").val(), "", $("#bankaccount").val(), "");

                                    if (followup == 'new') { //继续新建
                                        $("#winform").html("");
                                        winFormBuild("new");
                                    };

                                    if (followup == 'close') {//关闭
                                        $("#winform").html("");
                                        winClose();
                                    }
                                    $("#tab_list").datagrid('reload');
                                }
                            } catch (ex) {
                                $.messager.alert("提示", ex, 'error');
                            };
                        },
                        error: function () {
                            $.messager.alert("提示", "提交错误了！", 'error');
                        }
                    });
                    return false;
                };
            });
        }
    });
}


//关闭
function winClose() {
    $("#winform").html("");
    $("#supplierWin").window("close");
}

//ESB同步到POS
function esbPOSERP(strsp1_suppliercode, sp1_name, sp1_desp, sp1_contacts, sp1_contacttel, tex, sp1_address,
                                           sp1_bankname, email, sp1_bankaccount, bz) {
    if (sp1_name == undefined) {
        sp1_name = "";
    }
    if (sp1_desp == undefined) {
        sp1_desp = "";
    }
    var data = [];
    data[data.length] = { "name": "txt模块", "value": "SupplierInfoTOPos" };
    data[data.length] = { "name": "txt操作类型", "value": "INSERT" };
    data[data.length] = { "name": "txtDIVI", "value": m_compName };
    data[data.length] = { "name": "txtCONO", "value": "HYFG" };
    data[data.length] = { "name": "txtAppName", "value": "F22" };
    data[data.length] = { "name": "txtSupplierPower", "value": "1" };
    data[data.length] = { "name": "txt供应商编号", "value": strsp1_suppliercode };
    data[data.length] = { "name": "txt供应商简称", "value": sp1_name };
    data[data.length] = { "name": "txt供应商全称", "value": sp1_desp };
    data[data.length] = { "name": "txt联系人", "value": sp1_contacts };
    data[data.length] = { "name": "txt电话", "value": sp1_contacttel };
    data[data.length] = { "name": "txt传真", "value": tex };
    data[data.length] = { "name": "txt供应商地址", "value": sp1_address };
    data[data.length] = { "name": "txt银行名称", "value": sp1_bankname };
    data[data.length] = { "name": "txtemail", "value": email };
    data[data.length] = { "name": "txt银行帐号", "value": sp1_bankaccount };
    data[data.length] = { "name": "txt备注", "value": bz };

    var xmlData = GetDBFrameAML(data);//组成调用APIxml 
    var url = GetWSRRURL('c8704d3c-b80c-437c-83e2-d16d838ed426') + xmlData;
    var htmlobj = $.ajax({
        url: url,
        type: 'post',
        async: false
    });
    var result = $.parseJSON(htmlobj.responseText);
    //result = result[0].rows[0].result;
    //return result;

}


//主页查询按钮事件
function btnSearch() {
    var supplierCode = $('#txtSupplierCode').val();
    var supplierName = $('#txtSupplierName').val();
    var strWhere = '1=1';
    if (supplierCode != '') {
        supplierCode = '%' + supplierCode + '%';
        strWhere = strWhere + " AND SP1_SupplierCode LIKE '" + supplierCode + "'";
    }
    if (supplierName != '') {
        supplierName = '%' + supplierName + '%';
        strWhere = strWhere + " AND SP1_Desp LIKE '" + supplierName + "'";
    }
    var url = GetWSRRURL('ffda947c-e49f-4106-982a-dbda0664b282') + "&XML=" + GetFormJson('', 'SupplierInfoForPageList') + "&Where=" + escape(strWhere);
    InitGird(url);
}


//主页取消按钮事件
function btnCancel() {
    $('#txtSupplierCode').val('');
    $('#txtSupplierName').val('');
    btnSearch();
}

//获取字符长度,汉字占两个字符
function strlen(str) {
    var len = 0;
    for (var i = 0; i < str.length; i++) {
        var c = str.charCodeAt(i);
        //单字节加1 
        if ((c >= 0x0001 && c <= 0x007e) || (0xff60 <= c && c <= 0xff9f)) {
            len++;
        }
        else {
            len += 2;
        }
    }
    return len;
}
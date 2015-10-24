//创建者:俞佳伟

var m_divi = ""; //登录事业体
var m_data = [];
var m_state = [{ "id": "20", "text": "正常" }, { "id": "99", "text": "禁用" }];
var m_tabs = {
    "年份": "YEAR", "品类": "ITCL", "状态": "SATE", "单位": "UNIT", "国家": "COTY", "执行标准": "STRD", "安全技术类别": "STCL", "大类": "ITGR", "小类": "ITGL",
    "币种": "CUCD", "汇率": "EXRA", "税率": "VTCD", "付款方式": "TEPY", "供应商分类": "SORT", "供应商类别": "CATE", "供应商特性": "FEAT", "批准文号": "RNOA", "季节": "SSON",
}
//初始化
$(function () {
    m_divi = $.cookie("compName");
    m_data[0] = { "name": "txtzt", "value": m_divi };
    if (m_divi == 'GL') {
        $('.easyui-tabs').tabs('close', '批准文号');
    } else {
        $('.easyui-tabs').tabs('close', '季节');
    }
    //初始化 tabs标签页
    $('#BasicTabs').tabs({
        onSelect: function (title) {

            if (title == '款式类别') {
                title = '品类';
            }
            if (title == '币种(汇率)') {
                title = '币种';
            }
            var tabValue = m_tabs[title];
            InitGrid('tab' + tabValue, tabValue, title);
            $('#tab' + tabValue).show();
            if (tabValue == 'ITCL') {
                $('#tab' + tabValue).datagrid({ onClickRow: function (index, row) { onClickRow(index, row) } });
            }
            if (tabValue == 'CUCD') { //币种汇率
                $('#tab' + tabValue).datagrid({ onClickRow: function (index, row) { onClickRowCUCD(index, row) } });
            }
        }
    });
});

//加载数据
function InitGrid(table, where, myTitle) {
    var url = GetWSRRURL('7ea4d40d-02fa-43cf-ae3c-8231943f8124') + "&XML=" + GetFormJson(m_data, 'Get') + "&Where=CT1_Code='" + where + "'";
    $('#' + table).datagrid({
        url: url,
        striped: true, //True 奇偶行使用不同背景色
        fit: true,
        singleSelect: true,
        //onClickRow: onClickRow,
        pagination: true, //是否开启分页
        pageSize: 20, //默认一页数据条数 
        rownumbers: true,
        sortName: 'ct1_lmdt',
        sortOrder: 'desc',
        columns: [[
            { field: 'ct1_keyid', title: myTitle + '编号' },
            { field: 'ct1_keyname', title: myTitle + '名称' },
            { field: 'ct1_optionsvalues', title: myTitle + '下拉选项编号' },
            { field: 'ct1_options', title: myTitle + '下拉选项值' },
            { field: 'ct1_state', title: '状态' },
            { field: 'ct1_rguser', title: '建立人' },
            { field: 'ct1_rgdt', title: '建立时间' },
            { field: 'ct1_lmuser', title: '更新人' },
            { field: 'ct1_lmdt', title: '更新时间' }

        ]],
        toolbar: [
            {
                id: table + 'btn_New',
                text: '新增',
                iconCls: 'icon-add',
                handler: function () {
                    //新增
                    btnNew(table, myTitle);
                }
            },
            '-',
            {
                id: table + 'btn_Edit',
                text: '修改',
                iconCls: 'icon-edit',
                handler: function () {
                    //修改
                    btnEdit(table, myTitle);
                }
            }
        ]
    });
    var $dg = $('#' + table);
    col = $dg.datagrid('getColumnOption', 'ct1_state');
    if (col != null) {
        col.formatter = function (value) {
            return GetCommboboxText(m_state, value);
        }
    }
}

//品类表单击行事件
function onClickRow(index, row) {
    var fatherID = row.ct1_id;
    var where = "ITGR" + "' AND CT1_FatherID='" + fatherID;
    InitGrid('tabITGR', where, '大类');
    $('#tabITGR').datagrid({ onClickRow: function (index, row) { onClickRow1(index, row) } });
}

//大类表单击行事件
function onClickRow1(index, row) {
    var fatherID = row.ct1_id;
    var where = "ITGL" + "' AND CT1_FatherID='" + fatherID;
    InitGrid('tabITGL', where, '小类');
}

//币种表单击事件
function onClickRowCUCD(index, row) {
    var fatherID = row.ct1_id;
    var where = "EXRA" + "' AND CT1_FatherID='" + fatherID;
    InitGrid('tabEXRA', where, '汇率');
    //一个币种只有一个汇率
    $('#tabEXRA').datagrid({
        onLoadSuccess: function (data) {
            if (data.rows.length > 0) {
                $('#tabEXRAbtn_New').linkbutton('disable');
            }
            else {
                $('#tabEXRAbtn_New').linkbutton('enable');
            }
        }
    });
    //var getRows = $('#tabEXRA').datagrid('getRows');
    //if (getRows.length > 0) {

    //}
    //else {

    //}
}

//修改事件
function btnEdit(table, name) {
    var selectRow = $('#' + table).datagrid('getSelected');
    if (selectRow == null) {
        alert('请选中一行');
        return false;
    }
    var id = selectRow.ct1_id;
    var keyid = selectRow.ct1_keyid;
    var keyname = selectRow.ct1_keyname;
    var optionsvalue = selectRow.ct1_optionsvalues;
    var options = selectRow.ct1_options;
    var state = selectRow.ct1_state;
    var html = '';
    if (name == '汇率') {
        html = "<tr><td style=\"text-align:right\">编  号:</td><td><input id=\"keyId\" style=\"width:80px\" class=\"easyui-numberbox\" /></td></tr>";
    }
    else {
        html = "<tr><td style=\"text-align:right\">编  号:</td><td><input id=\"keyId\" style=\"width:80px\" disabled=\"disabled\" /></td></tr>";
    }
    html += "<tr><td style=\"text-align:right\">名  称:</td><td><input id=\"keyName\" /></td></tr>";
    if (name == '品类' || name == '大类' || name == '小类') {
        html = html + "<tr><td>选项值:</td><td><input id=\"ct1_optionsvalues\" style=\"width:80px\" class=\"easyui-validatebox\" required=\"required\" /></td></tr>" +
            "<tr><td>选项名称:</td><td><input id=\"ct1_options\" /></td></tr>";
    }
    html += "<tr><td>状 态:</td><td><input id=\"cmbState\" /></td></tr>";
    html = html + "<tr><td></td><td><a id=\"btnEditSave\" iconCls=\"icon-save\" onclick=\"saveEdit('" + id +
        "','" + name + "')\">保存</a>&nbsp;&nbsp;&nbsp;&nbsp;<a id=\"btnCancel\" iconCls=\"icon-cancel\" onclick=\"btnCancel()\">取消</a></td></tr>"
    $('#tabEdit').html(html);

    $('#keyId').val(keyid);
    $('#keyName').val(keyname);
    //if (name == "品类" || name == "大类" || name == "小类") {
    //    $('#ct1_optionsvalues').val(optionsvalue);
    //    $('#ct1_options').val(options);
    //}
    $('#ct1_optionsvalues').val(optionsvalue);
    $('#ct1_options').val(options);
    $('#btnEditSave').linkbutton({ plain: true });
    $('#btnCancel').linkbutton({ plain: true });

    //初始化状态
    $("#cmbState").combobox({
        url: GetComboxWSRRURL('7ea4d40d-02fa-43cf-ae3c-8231943f8124') + "&XML=" + GetFormJson(m_data, 'GET') + "&Where=CT1_Code ='SATE' AND CT1_State='20'",
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false,
        required: true
    }).combobox("setValue", state);

    $('#winNew').window({
        title: name + "维护",
        top: 20,
        modal: true
    });
}

//新增事件
function btnNew(table, name) {


    var html = "<tr><td style=\"text-align:right\">编  号:</td><td><input id=\"keyId\" style=\"width:80px\" /></td></tr>" +
       "<tr><td style=\"text-align:right\">名  称:</td><td><input id=\"keyName\" /></td></tr>";
    if (name == '品类' || name == '大类' || name == '小类') {
        html = html + "<tr><td>选项值:</td><td><input id=\"ct1_optionsvalues\" style=\"width:80px\" class=\"easyui-validatebox\" required=\"required\" /></td></tr>" +
            "<tr><td>选项名称:</td><td><input id=\"ct1_options\" /></td></tr>";
    }
    html += "<tr><td>状 态:</td><td><input id=\"cmbState\" /></td></tr>";
    html = html + "<tr><td></td><td><a id=\"btnNewSave\" iconCls=\"icon-save\" onclick=\"saveEdit(''" +
        ",'" + name + "')\">保存</a>&nbsp;&nbsp;&nbsp;&nbsp;<a id=\"btnCancel\" iconCls=\"icon-cancel\" onclick=\"btnCancel()\">取消</a></td></tr>"
    $('#tabEdit').html(html);
    $('#btnNewSave').linkbutton({ plain: true });
    $('#btnCancel').linkbutton({ plain: true });

    //初始化状态
    $("#cmbState").combobox({
        url: GetComboxWSRRURL('7ea4d40d-02fa-43cf-ae3c-8231943f8124') + "&XML=" + GetFormJson(m_data, 'GET') + "&Where=CT1_Code ='SATE' AND CT1_State='20'",
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false,
        required: true
    }).combobox('setValue', '20');

    $('#winNew').window({
        title: name + "维护",
        top: 20,
        modal: true
    });

}

//保存修改
function saveEdit(id, name) {
    //修改只需要保存名字
    var keyid = $('#keyId').val();
    var keyname = $('#keyName').val();
    var options = '';
    var optionsValue = '';
    if (name == '品类' || name == '大类' || name == '小类') {
        options = $('#ct1_options').val();
        optionsValue = $('#ct1_optionsvalues').val();
    }
    else if (name == '汇率') { //汇率：keyid=options  keyname=optionsvalue
        options = keyid;
        optionsValue = keyname;
    }
    else { //keyid=options  keyname=optionsvalue
        options = keyname;
        optionsValue = keyid;
    }
    var state = $('#cmbState').combobox('getValue');
    var data = [];
    if (id == "" || id == undefined) {  //无id 表示新增基础数据 
        id = "";
        var fatherid = "";
        if (name == "大类") {
            fatherid = $('#tabITCL').datagrid('getSelected').ct1_id;
        }
        if (name == "小类") {
            fatherid = $('#tabITGR').datagrid('getSelected').ct1_id;
        }
        if (name == "汇率") {
            fatherid = $('#tabCUCD').datagrid('getSelected').ct1_id;
        }
        if (fatherid != "") {
            data[data.length] = { "name": "txtct1_fatherid", "value": fatherid };
        }

        data[data.length] = { "name": "txtct1_code", "value": m_tabs[name] };
        data[data.length] = { "name": "txtct1_codename", "value": name };
        //data[data.length] = { "name": "txtct1_divi", "value": m_divi };
    }
    data[data.length] = { "name": "txtct1_keyid", "value": keyid };
    data[data.length] = { "name": "txtct1_id", "value": id };
    data[data.length] = { "name": "txtct1_keyname", "value": keyname };
    data[data.length] = { "name": "txtct1_optionsvalues", "value": optionsValue };
    data[data.length] = { "name": "txtct1_options", "value": options };
    data[data.length] = { "name": "txtct1_state", "value": state };

    //var url = GetWSRRURL('7ea4d40d-02fa-43cf-ae3c-8231943f8124') + "&XML=" + GetFormJson(data, 'Edit');
    $.messager.progress({ title: '请稍后', msg: '处理中' });
    $.ajax({
        url: GetWSRRURL('7ea4d40d-02fa-43cf-ae3c-8231943f8124'),
        type: 'post',
        async: false, //同步,
        data: { "XML": GetFormJson(data, 'Edit') },
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
                    $.messager.alert("提示", result[0].rows[0].message);
                    $.messager.progress('close');
                    $('#winNew').window('close');
                    $('#tab' + m_tabs[name]).datagrid('reload');
                }
            }
            catch (ex) {
                $.messager.alert("提示", ex, 'error');
            }
        }
    });

}


//取消事件
function btnCancel() {
    $('#keyId').val('');
    $('#keyName').val('');
    $('#ct1_optionsvalues').val('');
    $('#ct1_options').val('');
    $('#cmbState').combobox('setValue', '20');
    $('#winNew').window('close');
}


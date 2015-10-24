var msp1_typename = [{ "id": "M", "text": "面料" }, { "id": "F", "text": "辅料" }, { "id": "C", "text": "成衣" }, { "id": "D", "text": "成衣附件" },
                 { "id": "E", "text": "服饰品" }, { "id": "J", "text": "加工" }, { "id": "Z", "text": "综合类" }, { "id": "S", "text": "家饰家具" }];
var msp1_regionname = [{ "id": "C", "text": "国内" }, { "id": "W", "text": "国外" }];//国内不能建
var msp1_featurename = [{ "id": "G", "text": "生产工厂" }, { "id": "M", "text": "贸易公司" }, { "id": "L", "text": "零售" }];
var msp1_state = [{ "id": "0", "text": "正常" }, { "id": "1", "text": "禁用" }];
var msp1_company = [{ "id": "L", "text": "斓绣公司" }, { "id": "R", "text": "斓居百货商行" }];

$(function () {
    $('#formSupplier #txtsp1_typecode').combobox({
        valueField: 'id',
        textField: 'text',
        data: msp1_typename,
        required: true,
        panelHeight: 'auto',
        editable: false,
        onSelect: function (newValue, oldValue) {
            $('#formSupplier #txtsp1_typename').val($('#formSupplier #txtsp1_typecode').combobox('getText'));
        }
    });
    $('#formSupplier #txtsp1_regioncode').combobox({
        valueField: 'id',
        textField: 'text',
        data: msp1_regionname,
        required: true,
        panelHeight: 'auto',
        editable: false,
        onSelect: function (newValue, oldValue) {
            $('#formSupplier #txtsp1_regionname').val($('#formSupplier #txtsp1_regioncode').combobox('getText'));
            if ($('#formSupplier #txtsp1_regioncode').combobox('getText') == "国内") {
                $('#txtsp1_supplytax').numberbox('setValue', "")
                //$('#txtsp1_supplytax').numberbox('enable')
            }
            else {
                $('#txtsp1_supplytax').numberbox('setValue', "0")
                //$('#txtsp1_supplytax').numberbox('disable')
            }
        }
    });
    $('#formSupplier #txtsp1_featurecode').combobox({
        valueField: 'id',
        textField: 'text',
        data: msp1_featurename,
        required: true,
        panelHeight: 'auto',
        editable: false,
        onSelect: function (newValue, oldValue) {
            $('#formSupplier #txtsp1_featurename').val($('#formSupplier #txtsp1_featurecode').combobox('getText'));
        }
    });
    $('#formSupplier #txtsp1_state').combobox({
        valueField: 'id',
        textField: 'text',
        data: msp1_state,
        required: true,
        panelHeight: 'auto',
        editable: false
    });
    $("#company").combobox({
        valueField: 'id',
        textField: 'text',
        data: msp1_company,
        required: true,
        panelHeight: 'auto',
        editable: false
    })
    var url = GetWSRRURL('643a8280-09c8-4e52-aaff-1d27440b7d41') + "&XML=" + GetFormJson([], 'SupplierInfoForPageList');
    InitGird(url);
})
//加载数据
function InitGird(url) {
    $('#tab_list').datagrid(
            {
                title: '供应商', //表格标题
                url: url,
                sortName: 'sp1_lmdt', //排序字段
                idField: 'sp1_suppliercode', //标识字段,主键
                width: '90%', //宽度
                height: $(document).height() - 100, //高度
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
                toolbar: '#tab_toolbar'
            });

    var $dg = $('#tab_list');
    col = $dg.datagrid('getColumnOption', 'sp1_state');
    if (col != null) {
        col.formatter = function (value) {
            return GetCommboboxText(msp1_state, value);
        }
    }
}
//tab_toolbar,按钮控制
//新增供应商
function AddSupplier() {
    $('#DivSupplier').window({
        title: "供应商新增",
        top: 100,
        width: 900,
        height: 300,
        modal: true
    });
    $('#txtsp1_suppliercode').val("系统自动生成");//供应商编号
    $('#txtsp1_name').val("");//供应商简称
    $('#txtsp1_desp').val("");//供应商名称
    $('#txtsp1_supplytax').numberbox('setValue', "");//供应商税率
    $('#txtsp1_featurecode').combobox('setValue', "");//供应商特性
    $('#txtsp1_featurename').val("");//供应商特性编号
    $('#txtsp1_typecode').combobox('setValue', "");//供应商类别
    $('#txtsp1_typename').val("");//供应商类别编号
    $('#txtsp1_regioncode').combobox('setValue', "");//供应商分类
    $('#txtsp1_regionname').val("");//供应商分类编号
    $('#txtsp1_state').combobox('setValue', "0");//状态
    $('#txtsp1_contacts').val("");//联系人
    //$('#txtsp1_contacttel').numberbox('setValue', "");//联系电话
    $('#txtsp1_contacttel').val("");//联系电话

    $('#txtsp1_address').val("");//地址
    $('#txtsp1_bankname').val("");//开户行
    $('#txtsp1_bankaccount').val("");//银行账号
    $('#txtsp1_bankaddress').val("");//银行地址
    $('#txtsp1_bankswiftid').val("");//SWIFT银行
    $('#txtsp1_lmuser').val("");//更新人
    $('#txtsp1_lmdt').val("");//更新时间
    $('#txtsp1_featurecode').combobox('enable')
    $('#txtsp1_typecode').combobox('enable')
    $('#txtsp1_regioncode').combobox('enable')
    $('#txtsp1_name').attr("disabled", false);
    $('#txtsp1_desp').attr("disabled", false);
    $('#formSupplier').form('validate')

}
//修改
function EditSupplier() {
    var strSelectSupplier = $('#tab_list').datagrid('getSelected')

    var combCompVal = strSelectSupplier.sp1_suppliercode.substr(0, 1);

    if (!strSelectSupplier) {
        alert('请选择一行');
        return;
    }
    $('#DivSupplier').window({
        title: "供应商修改",
        top: 100,
        width: 900,
        height: 250,
        modal: true
    });
    $('#txtsp1_suppliercode').val(strSelectSupplier.sp1_suppliercode);//供应商编号
    $('#txtsp1_name').val(strSelectSupplier.sp1_name);//供应商简称
    $('#txtsp1_desp').val(strSelectSupplier.sp1_desp);//供应商名称
    $('#txtsp1_supplytax').numberbox('setValue', strSelectSupplier.sp1_supplytax);//供应商税率
    $('#txtsp1_featurecode').combobox('setValue', strSelectSupplier.sp1_featurecode);//供应商特性
    $('#txtsp1_featurename').val(strSelectSupplier.sp1_featurename);//供应商特性编号
    $('#txtsp1_typecode').combobox('setValue', strSelectSupplier.sp1_typecode);//供应商类别
    $('#txtsp1_typename').val(strSelectSupplier.sp1_typename);//供应商类别编号
    $('#txtsp1_regioncode').combobox('setValue', strSelectSupplier.sp1_regioncode);//供应商分类
    $('#txtsp1_regionname').val(strSelectSupplier.sp1_regionname);//供应商分类编号
    $('#txtsp1_state').combobox('setValue', strSelectSupplier.sp1_state);//状态
    $('#txtsp1_contacts').val(strSelectSupplier.sp1_contacts);//联系人
    $('#txtsp1_contacttel').val(strSelectSupplier.sp1_contacttel);//联系电话
    $("#company").combobox('setValue', combCompVal);//公司
    //$('#txtsp1_contacttel').numberbox('setValue', strSelectSupplier.sp1_contacttel);//联系电话

    $('#txtsp1_address').val(strSelectSupplier.sp1_address);//地址
    $('#txtsp1_bankname').val(strSelectSupplier.sp1_bankname);//开户行
    //$('#txtsp1_bankaccount').numberbox('setValue', strSelectSupplier.sp1_bankaccount);//银行账号
    $('#txtsp1_bankaccount').val(strSelectSupplier.sp1_bankaccount);//银行账号
    $('#txtsp1_bankaddress').val(strSelectSupplier.sp1_bankaddress);//银行地址
    $('#txtsp1_bankswiftid').val(strSelectSupplier.sp1_bankswiftid);//SWIFT银行
    $('#txtsp1_lmuser').val(strSelectSupplier.sp1_lmuser);//更新人
    $('#txtsp1_lmdt').val(strSelectSupplier.sp1_lmdt);//更新时间

    $('#formSupplier').form('validate')
    $("#company").combobox('disable');
    $('#txtsp1_featurecode').combobox('disable')//赋值之后不能修改
    $('#txtsp1_typecode').combobox('disable')//赋值之后不能修改
    $('#txtsp1_regioncode').combobox('disable')//赋值之后不能修改
    $('#txtsp1_name').attr("disabled", "disabled");
    $('#txtsp1_desp').attr("disabled", "disabled");

    //if (strSelectSupplier.sp1_regionname == "国内") {
    //    $('#txtsp1_supplytax').numberbox('enable')
    //} else {
    //    $('#txtsp1_supplytax').numberbox('disable')
    //}
    //$('#formSupplier').form('validate')
}

function FormSupplierSubmit(type) {
    //为调取ERP POS供应商最大值做准备
    var strsp1_suppliercode = $('#txtsp1_suppliercode').val();//供应商编号
    var sp1_name = $('#txtsp1_name').val();//供应商简称
    var sp1_desp = $('#txtsp1_desp').val();//供应商名称
    var sp1_state = $('#txtsp1_state').combobox('getValue');//供应商状态
    var sp1_featurecode = $('#txtsp1_featurecode').combobox('getValue');//供应商特性编号
    var sp1_featurename = $('#txtsp1_featurename').val();//供应商特性名称
    var sp1_typecode = $('#txtsp1_typecode').combobox('getValue');//供应商类别编号
    var sp1_typename = $('#txtsp1_typename').val();//供应商类别名称
    var sp1_regioncode = $('#txtsp1_regioncode').combobox('getValue');//供应商分类编号
    var sp1_regionname = $('#txtsp1_regionname').val();//供应商分类名称
    var sp1_supplytax = $('#txtsp1_supplytax').numberbox('getValue');//供应商税率
    var sp1_contacts = $('#txtsp1_contacts').val();//供应商联系人
    //var sp1_contacttel = $('#txtsp1_contacttel').numberbox('getValue');//供应商电话
    var sp1_contacttel = $('#txtsp1_contacttel').val();//供应商电话
    var sp1_address = $('#txtsp1_address').val();//供应商地址
    var sp1_bankname = $('#txtsp1_bankname').val();//供应商开户行
    var sp1_bankaccount = $('#txtsp1_bankaccount').val();//供应商银行账号
    var sp1_bankswiftid = $('#txtsp1_bankswiftid').val();//供应商swift
    var sp1_lmuser = $('#txtsp1_lmuser').val();//供应商更新人
    var sp1_lmdt = $('#txtsp1_lmdt').val();//供应商更新时间
    var company = $("#company").combobox('getValue');

    $('#formSupplier').form('submit', {
        onSubmit: function (e) {
            if ($('#formSupplier').form('validate') == false) {
                $.messager.alert("提示", "请把必填项填完！", 'error');
                return false;
            }
            $.messager.confirm('提示框', '是否确认提交', function (r) {
                if (r) {
                    //AJax 如果是国内 取ERP最大值,如果是国外去POS最大
                    if (strsp1_suppliercode == "系统自动生成") {
                        if (sp1_regioncode == "C") {

                            //alert("国内暂时不能新增,请联系唐正宇!");
                            //return;//如果是国内不能新增

                            var data = [];
                            data[data.length] = { "name": "txt模块", "value": "GetSupplierInfoFromPos" };
                            data[data.length] = { "name": "txt操作类型", "value": "GET" };
                            data[data.length] = { "name": "txtDIVI", "value": "LX" };
                            data[data.length] = { "name": "txtCONO", "value": "HYFG" };
                            data[data.length] = { "name": "texcompany", "value": company + sp1_typecode + sp1_regioncode + sp1_featurecode };
                            var xmlData = GetDBFrameAML(data);//组成调用APIxml
                            var url = GetWSRRURL('c8704d3c-b80c-437c-83e2-d16d838ed426') + xmlData
                            var htmlobj = $.ajax({
                                url: url,
                                type: 'post',
                                async: false
                            });
                            var result = $.parseJSON(htmlobj.responseText);
                            strsp1_suppliercode = (result.rows[0]['maxid'])//ERP供应商编号
                        } else {

                            var data = [];

                            data[data.length] = { "name": "txt模块", "value": "GetSupplierInfoFromPos" };
                            data[data.length] = { "name": "txt操作类型", "value": "GET" };
                            data[data.length] = { "name": "txtDIVI", "value": "LX" };
                            data[data.length] = { "name": "txtCONO", "value": "HYFG" };
                            data[data.length] = { "name": "texcompany", "value": company + sp1_typecode + sp1_regioncode + sp1_featurecode };

                            var xmlData = GetDBFrameAML(data);//组成调用APIxml
                            var url = GetWSRRURL('c8704d3c-b80c-437c-83e2-d16d838ed426') + xmlData
                            var htmlobj = $.ajax({
                                url: url,
                                type: 'post',
                                async: false
                            });
                            var result = $.parseJSON(htmlobj.responseText);
                            strsp1_suppliercode = (result.rows[0]['maxid'])//
                        }
                    }
                    var data = $('#formSupplier').serializeArray();
                    data[data.length] = { "name": "txtsp1_suppliercode", "value": strsp1_suppliercode }
                    var XMLData = GetFormJson(data, 'EDIT');
                    //return;
                    $.messager.progress({ title: '请稍后', msg: '处理中' });
                    $.ajax({
                        url: GetWSRRURL('643a8280-09c8-4e52-aaff-1d27440b7d41'),
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
                                    $.messager.progress('close');
                                    if (type == '保存并继续新建') {
                                        //$('#formSupplier').form('clear');
                                        //$('#txtsp1_suppliercode').val("系统自动生成");//供应商编号
                                        esbPOSERP(strsp1_suppliercode, sp1_name, sp1_desp, sp1_contacts, sp1_contacttel, "", sp1_address,
                                            sp1_bankname, "", sp1_bankaccount, "");

                                        AddSupplier();
                                    }
                                    if (type == '保存并关闭') {
                                        $('#DivSupplier').window('close');
                                    }
                                    $('#tab_list').datagrid("unselectAll");
                                    $('#tab_list').datagrid("reload");
                                    //$.messager.alert("提示", result[0].rows[0].message);
                                    esbPOSERP(strsp1_suppliercode, sp1_name, sp1_desp, sp1_contacts, sp1_contacttel, "", sp1_address,
                                           sp1_bankname, "", sp1_bankaccount, "");
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
            })
        }
    });
}
function Cancel() {
    $('#DivSupplier').window('close');
}

//模糊查询（按照供应商名称和供应商简称）
function doSearch() {
    var strSearchBoxForSupplier = $('#SearchBoxForSupplier').searchbox('getValue');//取查询框数据
    var url = "1=1";
    if (strSearchBoxForSupplier == "") {
        url = url
    } else {
        url += " and sp1_name like '%" + strSearchBoxForSupplier + "%' or sp1_desp like '%" + strSearchBoxForSupplier + "%' ";
    }
    url = GetWSRRURL('643a8280-09c8-4e52-aaff-1d27440b7d41') + "&XML=" + GetFormJson([], 'SupplierInfoForPageList') + "&WHERE=" + escape(url);
    InitGird(url);
}

//导出
function OutputSupplier() {
    alert('OutputSupplier')
}
//新增品牌
function Addbrand() {
    alert('Addbrand')
}


//ESB同步到POS
function esbPOSERP(strsp1_suppliercode, sp1_name, sp1_desp, sp1_contacts, sp1_contacttel, tex, sp1_address,
                                           sp1_bankname, email, sp1_bankaccount, bz) {

    var data = [];
    data[data.length] = { "name": "txt模块", "value": "SupplierInfoTOPos" };
    data[data.length] = { "name": "txt操作类型", "value": "INSERT" };
    data[data.length] = { "name": "txtDIVI", "value": "LX" };
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
    var url = GetWSRRURL('c8704d3c-b80c-437c-83e2-d16d838ed426') + xmlData
    var htmlobj = $.ajax({
        url: url,
        type: 'post',
        async: false
    });
    var result = $.parseJSON(htmlobj.responseText);
}
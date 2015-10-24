/// JS名：Tag_Apply.JS
/// JS说明：用于吊牌打印申请的前台控制
/// 创建人：刘洪 
/// 创建日期：2014-04
/// 修改人：刘洪
/// 修改日期：2014-05-06
/// 修改内容：店铺名称改为从J_Depot表中取值


var m_DepotName,m_DepotId,m_DepotPhone,m_StyleID,m_Total;
var m_Company, m_ChannelType, m_data = [];
var rowsIndex, selectRow;
var m_saveType = 1;

//
//初始化-- 初始化打开网页后所有必要的相关信息与功能,包括下拉框,验证与datagrid的初始数据
//
$(function () {
    //文件上传相关-----------------
    var button = $('#btn_up'), interval;
    new AjaxUpload(button, {
        //action: 'upload-test.php',文件上传服务器端执行的地址
        action: '/Handler_Upload.ashx?filePath=HZY_Tag',
        name: 'myfile',
        onSubmit: function (file, ext) {
            if (!(ext && /^(jpg|jpeg|JPG|JPEG|PNG|GIF|gif|png)$/.test(ext))) 
            {
                alert('图片格式不正确,请选择 jpg,gif,png 格式的文件!', '系统提示');
                return false;
                };
            button.val('文件上传中');
            this.disable();
            // Uploding -> Uploading. -> Uploading...
            interval = window.setInterval(function () {
                var text = button.val();
                if (text.length < 10) 
                {
                    button.val(text + '.');
                    }
                else 
                {
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
                if (result[0].Error) 
                {
                    $.messager.progress('close');
                    $.messager.alert("系统错误", result[0].Error, 'error');
                    }
                else if (result[0].rows[0].result == "False") 
                {
                    $.messager.progress('close');
                    $.messager.alert("提示", result[0].rows[0].message, 'error');
                    }
                else 
                {
                    $("#txtpic").val(result[0].rows[0].message);
                    };
                }
            catch (ex) {
                $.messager.progress('close');
                $.messager.alert("提示", ex, 'error');
            };
        }
    });
    //文件上传相关-----------------

    //获取店铺ID
    htmlobj = $.ajax({
        url: GetWSRRURL('DepotID'),
        options: "JSON",
        async: false
    });
    var result = $.parseJSON(htmlobj.responseText);
    if (result.DepotID != "") 
    {
        m_DepotId = result.DepotID;
        };
    //获取店铺各类信息
    XMLData = GetFormJson([], 'GETDEPOTINFO');
    htmlobj = $.ajax({
        url: GetWSRRURL('e6d23a54-38a6-474e-ad06-82c78fadd5e0'),
        data: { "XML": XMLData, "WHERE": "depotid='" + m_DepotId + "'" },
        type: 'post',
        async: false
    });
    var result = $.parseJSON(htmlobj.responseText);
    m_Company = result.rows[0]['公司'];
    m_ChannelType = result.rows[0]['m_type'];
    m_DepotName = result.rows[0]['d_name']; //从GP的表中获取店铺名,这样最为准确
    $('#txtDepotName').val(m_DepotName);
    if (result.rows[0]['tel'] != "") 
    {
        m_DepotPhone = result.rows[0]['tel']
        $('#txtpra_Phone').val(m_DepotPhone);
    };

    //设置店铺电话验证
    $('#txtpra_Phone').validatebox({
        required: true,
        message: '请输入电话号码'
    });
    //获取人员列表
    $('#cmbpra_Employeeid').combobox({
        url: GetComboxWSRRURL('e6d23a54-38a6-474e-ad06-82c78fadd5e0') + "&XML=" + GetFormJson([], 'GETEMPLOYEEINFO')
                + "&WHERE=depotid='" + m_DepotId + "'",
        type: 'post',
        editable: false,
        valueField: 'id',
        textField: 'text',
        required: true,
        onLoadSuccess: function () {
            m_data = $('#cmbpra_Employeeid').combobox("getData");
        }
    });
    InitGird();
});
//
// 表格初始化--这里初始化吊牌申请后款式与数量的显示框.
//
function InitGird() {
    $('#tab_list').datagrid({
        striped: true, //True 奇偶行使用不同背景色
        singleSelect: true, //单行选择
        columns: [[
    { field: 'prad_styleid', title: '款号', width: 150 },
    { field: 'prad_total', title: '数量', width: 50 }
    ]],
    onClickRow: function (rowIndex, rowData) 
    {
        rowsIndex = rowIndex;
        selectRow = rowData;
        },
        toolbar: [
            {
                id: 'btn_Remove',
                text: '删除',
                iconCls: 'icon-cancel',
                handler: function () {
                    removeRows();
                }
            }
        ]
        });
    };
    //
    //款号数量为空检查--这里检查款号与数量是否为空,为空提示并返回
    //
function GetValue() {
    m_StyleID = $("#txtStyleID").val();
    m_Total = $("#txtTotal").val();
    if (m_StyleID == "" || m_Total == "") 
    {
        bottomRight();      //错误提示信息
        return;
        }
    insertValue();
    };
//
//给datagrid添加数据--将款号与数量添加到datagrid中。其中会检查datagrid是否已存在(checkStyleInDatagrid方法),
//以及数据库中是否有该款式存在(checkStyleInData)方法。
//
function insertValue() {
    if (checkStyleInDatagrid(m_StyleID)) 
    {
        if (checkStyleInData(m_StyleID)) 
        {
            $(tab_list).datagrid('appendRow', {
                prad_styleid: m_StyleID.toUpperCase(),
                prad_total: m_Total
                });
            $('#txtStyleID').val("");
            $('#txtTotal').val("");
            }
        };
    $("#txtStyleID").focus();
    };
//
//检查datagrid中是否已经存在款号
//
function checkStyleInDatagrid(StyldId) {
    var chk_styldid = StyldId;  //款号
    chk_styldid = chk_styldid.toUpperCase();//转换为大写
    var dglength = $('#tab_list').datagrid('getRows').length - 1;

    for (var i = 0; i <= dglength; i++) 
    {
        if (chk_styldid == $('#tab_list').datagrid('getRows')[i].prad_styleid) 
        {
            alert('款号已存在，请检查。');
            return false;                   
            };
        };
    return true;
    };
//
//检查数据库中是否存在该款号
//
function checkStyleInData(style) {
    var chk_styleid = style;
    XMLData = GetFormJson('', 'CHECKCLOTHING');
    htmlobj = $.ajax({
        url: GetWSRRURL('713f0856-4a75-4ae8-b33d-ba60677d28b6'),
        data: { "XML": XMLData, "WHERE": "clothingid='" + chk_styleid + "'" },
        type: 'post',
        async: false
        });
    var result = $.parseJSON(htmlobj.responseText);
    if (result.rows[0]["count"] > 0) 
    {
        return true;
        }
    else 
    {
        alert('款号不存在，请检查');
        return false; 
        };
    };
//检查数量是否符合规则--规则：通过正则表达式来判断输入框中是否只输入了1-9中的某个数
function checkQuaInput(str) {
    var regex = str.search(/^[1-9]$/); //regex,匹配1-9之间的数，匹配失败返回-1。
    if (regex == "-1") 
    {
        str = '';
        return str;
        };
    return str;
    };
//
//datagrid中删除按钮--删除选中的行。
//

function removeRows() {
    if (rowsIndex != null) 
    {
        $('#tab_list').datagrid('deleteRow', rowsIndex);
        rowsIndex = undefined;
        selectRow = undefined;
        }
    else 
    {
        alert('请选中一行！');
        };
    };
//
//提交按钮--提交吊牌打印申请，会先做上传前的准备（检查数据完整性，XML格式转换），
//最终向后台提发（提法地址：906ae367-5e18-4ba2-9ac1-8de6834f3620）
//
function onSubmit() {
    if ($('#formCreate').form('validate')) 
    {
        if (m_saveType == 1) {
            var dataTotal = $('#tab_list').datagrid('getChanges');
            var sumtotal = 0;
            m_saveType == 2;
            $('#btn_save').linkbutton('disable');
            var employeeid = $('#cmbpra_Employeeid').combobox("getValue");
            var picpath = $('#txtpic').val();
            var remark = $('#txtpra_Remark').val();
            var data = [];
            //循环取出datagrid数量的值
            for (i = 0; i <= dataTotal.length - 1; i++) {
                sumtotal += +dataTotal[i]["prad_total"];
            };
            if (checkTotal(sumtotal)) {
                //生成子表
                var inserted = $("#tab_list").datagrid('getChanges', "inserted");
                var data1 = GetExcelXML(inserted);
                //生成组表
                var data2 = $('#formCreate').serializeArray();
                var m_Employeeid = data2[1]["value"];
                var m_EmployeeName = getEmployeeName(m_Employeeid); //取申请人名
                var m_DepotPhone = data2[0]["value"];
                var m_report = data2[2]["value"];
                data[data.length] = { "name": "txt操作类型", "value": "NEW" };
                data[data.length] = { "name": "txt实体", "value": "数据新增" };
                data[data.length] = { "name": "txtCONO", "value": "EP" };
                data[data.length] = { "name": "txtDIVI", "value": "D01" };
                data[data.length] = { "name": "txt公司", "value": m_Company };
                data[data.length] = { "name": "txt店铺ID", "value": m_DepotId };
                data[data.length] = { "name": "txt店铺名称", "value": m_DepotName };
                data[data.length] = { "name": "txt店铺电话", "value": m_DepotPhone };
                data[data.length] = { "name": "txt客户经理ID", "value": m_Employeeid };
                data[data.length] = { "name": "txt客户经理名字", "value": m_EmployeeName };
                data[data.length] = { "name": "txt申请总数", "value": sumtotal };
                data[data.length] = { "name": "txt备注", "value": m_report };
                data[data.length] = { "name": "txt图片", "value": picpath };
                data[data.length] = { "name": "txt申请人", "value": m_EmployeeName };
                data[data.length] = { "name": "txt申请明细", "value": data1, specialCharset: true };

                XMLData = GetDBFrameAML(data);
                $.ajax({
                    url: GetWSRRURL('906ae367-5e18-4ba2-9ac1-8de6834f3620') + XMLData,
                    type: 'post',
                    async: false, //异步,
                    success: function (result) {
                        try {
                            var result = eval("[" + result + "]");
                            if (result[0].rows[0].result != "1") {
                                $.messager.progress('close');
                                $.messager.alert("提示", result[0].rows[0].msg, 'error');
                            }
                            else {

                                $.messager.alert("提示", result[0].rows[0].msg);
                                ClearGrid("#tab_list");
                                rowsIndex = undefined;
                                selectRow = undefined;
                                $('#txtpra_Remark').val("");
                                $('#txtpic').val("");
                                $('#btn_save').linkbutton('enable');
                                m_saveType == 1;
                            }
                        }
                        catch (ex) {
                            $.messager.progress('close');
                            $.messager.alert("提示", ex, 'error');
                        };
                    },
                    error: function () {
                        $.messager.alert("提示", "提交错误了！", 'error');
                    }
                });
            }
        } else { $('#btn_save').linkbutton('disable'); return; };
        }
    };
//
//验证吊牌申请数--验证最终所有吊牌申请数量是否超过10个，return t or f。
//
function checkTotal(total) {
    if (total >= 10) 
    {
        if (checkPicInput()) 
        {
            return false;
            };
        }
    else if (total == 0) 
    {
        alert('请输入款号和数量');
        return false;
        };
    return true;
    };
//
//验证上传图片的input框是否有数据
//
function checkPicInput() { //true表示没有图片，fasle表示有图片。
    if ($('#txtpic').val() == "") 
    {
        alert('当月申请数量有10个或以上，请上传图片');
        return true;
        }
    else 
    {
        return false;
        };
    };
//
//取申请人对应的名称
//
function getEmployeeName(id) {
    if (id == "") 
    {
        m_EmployeeName = "";
        }
    else 
    {
        for (i = 0; i <= m_data.length - 1; i++) 
        {
            if (id == m_data[i]["id"]) 
            {
                return m_EmployeeName = m_data[i]["text"];
                };
            };
        };
    };
//款号数量未填写时的提示框
function bottomRight() {
    $.messager.show({
        title: '警告',
        msg: '请填写款号和数量',
        showType: 'show'
        });
    }

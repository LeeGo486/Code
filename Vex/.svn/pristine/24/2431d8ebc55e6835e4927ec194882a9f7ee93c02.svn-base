var m_depotid;
$(function () {
    //获取公司下拉列表
    $('#cmbpra_Company').combobox({
        url: GetComboxWSRRURL('ec43afc5-c305-4377-bc35-4f6d57ae8b9a', "", "pra_company", "pra_company") + "&XML=" + GetFormJson([], 'FCCOMPANY'),
        valueField: 'id',
        textField: 'text',
        type: 'post',
        panelHeight: 'auto',
        editable: false
    });
    //获取店铺ID
    $('#cmbpra_ChannelType').combobox({
        url: GetComboxWSRRURL('ec43afc5-c305-4377-bc35-4f6d57ae8b9a', "", "pra_channeltype", "pra_channeltype") + "&XML=" + GetFormJson([], 'FCCHANNELTYPE'),
        valueField: 'id',
        textField: 'text',
        type: 'post',
        panelHeight: 'auto',
        editable: false
    });
    $('#cmbpra_Depotid').combobox({
        url: GetComboxWSRRURL('ec43afc5-c305-4377-bc35-4f6d57ae8b9a') + "&XML=" + GetFormJson([], 'FCDEPOTNAME'),
        valueField: 'id',
        textField: 'text',
        type: 'post',
        panelHeight: 'auto',
        editable: true,
        onLoadSuccess: function () {
            m_depotid = $('#cmbpra_Depotid').combobox('getData');
        }
    });
    $('#cmbpra_status').combobox({
        panelHeight: 'auto',
        editable: false
    });
    InitGird();
})

function InitGird() {
    $('#tab_list').datagrid({
        url: GetWSRRURL('ec43afc5-c305-4377-bc35-4f6d57ae8b9a'),
        queryParams: { "XML": GetFormJson([], 'FCGET') },
        striped: true, //True 奇偶行使用不同背景色
        singleSelect: true, //单行选择
        selectOnCheck: false, //关闭checkbox单个选择
        checkOnSelect: true, //开启checkbox多个选择
        title: '吊牌申请',
        width: '90%',
        height: $(document).height() - 70,
        sortOrder: 'desc',
        sortName: 'pra_createtime',
        columns: [[
            { field: 'ck', checkbox: true },
            { field: 'pra_company', title: '公司', width: 50 },
            { field: 'pra_channeltype', title: '店铺类型', width: 55 },
            { field: 'pra_depotname', title: '店铺名称', width: 150 },
            { field: 'pra_employeename', title: '联系人', width: 80 },
            { field: 'pra_phone', title: '联系电话', width: 100 },
            { field: 'pra_total', title: '总数', width: 50 },
            { field: 'pra_createtime', title: '申请时间', width: 100 },
            { field: 'pra_updatetime', title: '处理时间', width: 100 },
            { field: 'pra_statusname', title: '状态', width: 80 }
           ]],
        pagination: true, //是否开启分页
        pageNumber: 1, //默认索引页
        pageSize: 20, //默认一页数据条数
        rownumbers: true, //行号
        onDblClickRow: function () {
            Edit_Rows();
        },
        toolbar: [
            {
                text: '处理',
                iconCls: 'icon-ok',
                handler: function () {
                    onSubmit();
                }
            }, '-', {
                text: '明细',
                iconCls: 'icon-edit',
                handler: function () {
                    Edit_Rows();
                }
            }
        ]
    })
    };

    //查询按钮方法
    function Search() {
        var data = $('#formSearch').serializeArray();
        if (checkDepotNameInput()) {
            ClearGrid("#tab_list");
            XMLData = GetFormJson(data, 'GSDATA1');
        
            $('#tab_list').datagrid({
                url: GetWSRRURL('ec43afc5-c305-4377-bc35-4f6d57ae8b9a'),
                queryParams: { "XML": XMLData },
                async: true, //异步
                striped: true, //True 奇偶行使用不同背景色
                singleSelect: true, //单行选择
                title: '查询结果',
                sortOrder: 'desc',
                sortName: 'pra_createtime',
                width: '90%',
                columns: [[
                { field: 'ck', checkbox: true },
                { field: 'pra_guid',title:'guid',hidden: true},
                { field: 'pra_remark', title: '备注', hidden: true },
                { field: 'pra_picpath', title: '图片', hidden: true },
                { field: 'pra_company', title: '公司', width: 50 },
                { field: 'pra_channeltype', title: '店铺类型', width: 55 },
                { field: 'pra_depotname', title: '店铺名称', width: 150 },
                { field: 'pra_employeename', title: '联系人', width: 80 },
                { field: 'pra_phone', title: '联系电话', width: 100 },
                { field: 'pra_total', title: '总数', width: 50 },
                { field: 'pra_createtime', title: '申请时间', width: 100 },
                { field: 'pra_updatetime', title: '处理时间', width: 100 },
                { field: 'pra_statusname', title: '状态', width: 80 }
               ]],
                pagination: true, //是否开启分页
                pageNumber: 1, //默认索引页
                pageSize: 20, //默认一页数据条数
                rownumbers: true//行号
            });
        };
    };
    //处理按钮方法
    function onSubmit() {
            var inserted = undefined;
            var update = $('#tab_list').datagrid('getChecked');
            if (checkstatus(update)) {
                XMLData = GetEditJson(inserted, update);
                $.ajax({
                    url: GetWSRRURL('ec43afc5-c305-4377-bc35-4f6d57ae8b9a'),
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
                                $.messager.alert("提示", result[0].rows[0].message);
                                $('#divDetail').window("close");
                                ClearGrid("#tab_list");
                                InitGird();
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
    };

    //检查店铺名称是否正确
    function checkDepotNameInput() {
        var data = $('#formSearch').serializeArray();
        var depotinput = data[2]['value'];
        if (depotinput == "") {
            return true;
        }
        for (var i = 0; i <= m_depotid.length - 1; i++) {
            if (depotinput == m_depotid[i]['id']) {
                return true;
            }
        }
        alert('店铺名称错误，请检查');
    }

    //检查提交的状态是否符合规则
    function checkstatus(data) {
        var chk_data = data;
        for (var i = 0; i <= chk_data.length - 1; i++) {
            if (chk_data[i]["pra_status"] == "0") {
                return true;
            } else {
                alert('提交数据的状态为已处理，请检查');
                return false;
            }
         }
    }
    //取消按钮方法
    function Cancel() {
        $('#divDetail').window('close');
    }
    //查看按钮方法
    function Edit_Rows() {
        var selected_Row = $('#tab_list').datagrid('getSelected');
        var url;
        if (selected_Row) {
            var guid = selected_Row.pra_guid;
            $('#tab_Detail').datagrid({
                url: GetWSRRURL('ec43afc5-c305-4377-bc35-4f6d57ae8b9a'),
                queryParams: { "XML": GetFormJson([], 'FCGETDETAIL'),"WHERE": "PRA_guid = '" + guid +"'"},
                striped: true, //True 奇偶行使用不同背景色
                singleSelect: true, //单行选择
                sortOrder: 'desc',
                sortName: 'prad_styleid',
                columns: [[
                    { field: 'prad_styleid', title: '款号', width: 200 },
                    { field: 'prad_total', title: '数量', width: 80 }
                ]]
            })
            $('#divDetail').window({
                title: '吊牌申请明细',
                top: 30
            });

            $('#divDetail').window("open");
            $('#txtpra_remark').val(selected_Row.pra_remark);
            if (selected_Row.pra_picpath == "") {
                url = "";
            } else {
                url ="" + selected_Row.pra_picpath;
             };
            $('#txtpicpath').val(url);
        } else {
            alert("请选择一行");
            return;
        };
    }
    //查看图片的方法
    function lookPicPath() {
        var selected_Row = $('#tab_list').datagrid('getSelected');
        var url;
        if (selected_Row.pra_picpath == "") {
            url = "";
            return;
        } else {
            url = "" + selected_Row.pra_picpath;
            window.open(url, "newwindow", "");

        };
     }
var m_DataGridID = '#fymxlb'; //费用明细列表ID
var m_LastIndex = undefined;  //费用明细列表最后一次选中行下标    

//用户信息
var m_UserInfo = parent.m_UserInfo; 

/***********************************************************************
 *  初始化设置
 *  DLY
 *  2014-05-07
 */
$(function () {
    var cxml = '';  

    //鼠标单击后事件求合计
    document.onmouseup = function (e) {
        getSumfymxAmount(m_LastIndex); //求合计金额
        return true;
    }


    //申请日期格式化及值变化控制
    $('#ea1_applydt').datebox({
        closeText: '关闭',
        editable: false,
        formatter: function (date) {
            return dateUtil_dateFomaterB(date, '-');
        },
        parser: function (s) {
            var t = Date.parse(s);
            if (!isNaN(t)) {
                return new Date(t);
            } else {
                return new Date();
            }
        },
        onChange: function (newValue, oldValue) {
            if (newValue != oldValue) {

            }
        }
    });

    //根据URL参数初始化表单数据
    setbillInfoByURL();

});


/***********************************************************************
 *  申购明细列表初始化-预算外
 *  DLY
 *  2014-04-28
 */
function actfymxlbcsh(dgid) {
    $(dgid).datagrid({
        //title:'明细列表', 
        width: 800,
        height: 240,
        nowrap: true,
        striped: true,
        collapsible: true,
        sortName: 'id',
        sortOrder: 'asc',
        remoteSort: false,
        idField: 'id',
        iconCls: 'icon-tip',
        loadMsg: '数据加载中请稍后……',
        frozenColumns: [[

        ]],
        columns: [[
			{ field: 'ea2_id', title: 'FID', width: 100, hidden: true },
            { field: 'ea2_cono', title: 'cono', width: 100, hidden: true },
            { field: 'ea2_divi', title: 'divi', width: 100, hidden: true },
            { field: 'ea2_billcode', title: '单据编号', width: 100, hidden: true },
			{ field: 'ea2_usedt', title: '使用日期', width: 100, editor: 'datebox' },
			{ field: 'ea2_comment', title: '费用明细', width: 400, editor: 'text' },
			{
			    field: 'ea2_amount', title: '金额', width: 150, align: "right"
				, editor: { type: 'numberbox', options: { precision: 2, min: 0 } }
			    , formatter: function (val) { return dataUtil_formatNum(val); }
			}
        ]],
        pagination: false,
        rownumbers: true,
        singleSelect: true,
        onDblClickRow: function () {
            //alert(1);
            //$('#fymxxx').tabs('select', '费用分摊明细'); // 激活标签   
        },
        onClickRow: function (rowIndex) {
            $(dgid).datagrid('endEdit', m_LastIndex);
            $(dgid).datagrid('selectRow', rowIndex);
            $(dgid).datagrid('beginEdit', rowIndex);
            m_LastIndex = rowIndex; 
            var dg = $(dgid);
            if (dataUtil_undefinedOrNull(basedata_getUrlParam("v2"), '') == 'F02-XXZYSH') { // 信息专员操作项   
                var col1 = dg.datagrid('getColumnOption', 'isadjust');  //是否调配项
                col1.editor = {
                    type: 'combobox', options: {
                        valueField: 'ct1_codename', textField: 'ct1_codename', editable: false, panelHeight: "50"
                        ,data:m_YesOrNo
                    }
                };
            }
        },
        onClickCell: function (rowIndex, field, value) {
        },
        onAfterEdit: function (index, row) {
            getSumfymxAmount(-1); //求合计;
        },
        toolbar: [{
            text: '添加',
            iconCls: 'icon-add',
            handler: function () {
                $(dgid).datagrid('appendRow', {
                    ea2_id: dataUtil_NewGuid(), 
                    ea2_divi: $('#ea1_divi').attr('value'),
                    ea2_cono: $('#ea1_cono').attr('value'),
                    ea2_billcode: $('#ea1_billcode').attr('value'),
                    ea2_usedt: '',
                    ea2_comment: '',
                    ea2_amount: ''
                });
                $(dgid).datagrid('endEdit', m_LastIndex);
                m_LastIndex = $(dgid).datagrid('getRows').length - 1;
                $(dgid).datagrid('selectRow', m_LastIndex);
                $(dgid).datagrid('beginEdit', m_LastIndex);
            }
        }, '-', {
            text: '复制',
            iconCls: 'icon-design',
            handler: function () {
                var row = $(m_DataGridID).datagrid('getSelected');
                if (row) {
                    $(dgid).datagrid('endEdit', m_LastIndex);
                    $(dgid).datagrid('appendRow', {
                        ea2_id: dataUtil_NewGuid(), 
                        ea2_divi: $('#ea1_divi').attr('value'),
                        ea2_cono: $('#ea1_cono').attr('value'),
                        ea2_billcode: dataUtil_undefinedOrNull(row.ea2_billcode, ''),
                        ea2_usedt: dataUtil_undefinedOrNull(row.ea2_usedt, ''),
                        ea2_comment: dataUtil_undefinedOrNull(row.ea2_comment, ''),
                        ea2_amount: dataUtil_undefinedOrNull(row.ea2_amount, '')
                    }); 
                    m_LastIndex = $('#sgmxlb').datagrid('getRows').length - 1;
                    $(dgid).datagrid('selectRow', m_LastIndex);
                    $(dgid).datagrid('beginEdit', m_LastIndex);
                    getSumfymxAmount(-1); //求合计;
                }
            }
        }, '-', {
            text: dataUtil_actSetNStr('&nbsp', 150),
            iconCls: '',
            handler: function () {
            }
        }, '-', {
            text: '删除',
            iconCls: 'icon-remove',
            handler: function () {
                var row = $(dgid).datagrid('getSelected');
                if (row) {
                    $.messager.confirm('确认框', '确认删除此记录吗？', function (r) {
                        if (r) {
                            var index = $(dgid).datagrid('getRowIndex', row);
                            $(dgid).datagrid('deleteRow', index);
                            m_LastIndex = -1;
                            getSumfymxAmount(-1); //求合计;
                        }
                    });
                }
            }
        }]
    });
} 
 


/***********************************************************************
 *  
 * 根据URL加载初始数据 
 *  DLY
 *  2013-05-27
 */
function setbillInfoByURL() {
    //新增单据
    if (dataUtil_undefinedOrNull(basedata_getUrlParam("type"), '') == '') {
        setbillInfo('new', null);
        actfymxlbcsh(m_DataGridID); //初始化设置明细列表 
        $(m_DataGridID).datagrid('appendRow', {   //插入一条空记录
            ea2_id: dataUtil_NewGuid(),
            ea2_divi: $('#ea1_divi').attr('value'),
            ea2_cono: $('#ea1_cono').attr('value'),
            ea2_billcode: $('#ea1_billcode').attr('value'),
            ea2_usedt: '',
            ea2_comment: '',
            ea2_amount: ''
        });
        m_LastIndex = $(m_DataGridID).datagrid('getRows').length - 1;
        $(m_DataGridID).datagrid('selectRow', m_LastIndex);
        $(m_DataGridID).datagrid('beginEdit', m_LastIndex); 
    } else if (basedata_getUrlParam("type") == 'task') {
        var flag = true;
        if (dataUtil_undefinedOrNull(basedata_getUrlParam("v0")) == '') {
            alert('申购单号无效！');
            flag = false;

        }
        if (dataUtil_undefinedOrNull(basedata_getUrlParam("v1")) == '') {
            alert('待办任务无效！');
            flag = false;
        }
        if (flag == false) {
            $('#ea1_id').attr('value', '此单据信息有误！');
            $('#ea1_billcode').attr('value', '此单据信息有误！');
            $('#tbztoolbar').hide();
            return false;
        } else {
            var crows = [];
            //获取主表信息
            var cXML = '<Page>1</Page><Num>1</Num>'
                + '<Cons> AND ea1_billcode=\'' + basedata_getUrlParam("v0") + '\'</Cons><OrderBy></OrderBy>'
            cXML = basedata_addROOT(cXML); 
            var curl = GetWSRRURL(peoa_GetWSRRURL(12)) + "&type=GetH&XML=" + encodeURIComponent(cXML)
                    + "&s=" + new Date().getTime();  //拼接url  
            $.ajax({
                url: curl,
                type: "GET",
                async: false,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    //alert(jsonUtil_jsonToStr(data));
                    if (data && data.rows) {
                        data.rows[0].taskid = basedata_getUrlParam("v1");
                        setbillInfo('old', data.rows[0]);
                        if (data.rows[0].fa1_rejectinfo != ''){
                            $('#btnlookRI').show(); 
                            $('#rejectInfoSpan').text(data.rows[0].fa1_rejectinfo);
                        }
                        //获取从表信息 
                        var cXML = '<Page>1</Page><Num>1</Num>'
                            + '<Cons> AND ea2_billcode=\'' + basedata_getUrlParam("v0") + '\'</Cons><OrderBy></OrderBy>'
                        cXML = basedata_addROOT(cXML);
                        var curl = GetWSRRURL(peoa_GetWSRRURL(12)) + "&type=GetD&XML=" + encodeURIComponent(cXML)
                                + "&s=" + new Date().getTime();  //拼接url   
                        $.ajax({
                            url: curl,
                            type: "GET",
                            async: false,
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                //  alert(jsonUtil_jsonToStr(data));
                                if (data && data.rows && data.rows[0].ea2_id) {
                                    crows = data.rows;
                                    
                                }
                            }
                        })
                    }
                }
            })

            //控件只读控制  
            if (dataUtil_undefinedOrNull(basedata_getUrlParam("v2"), '') == 'F01-SQRTD'){ 
                actfymxlbcsh(m_DataGridID); //初始化设置明细列表 
            } else { 
                //控件只读控制 
                $('#ProjectCode').combobox('disable'); //项目代码
                $('#AdvancedCode').combobox('disable');//高薪代码
                $('#ApplyDt').datebox('disable');//申请日期;
                $('#DeptID').combotree('disable');//部门名称
                $('#AssetsType').combobox('disable');
                $('#CenterCode').combobox('disable');
                $('#BudgetType').combobox('disable');
                $('#Comment').attr("disabled", true);
                $('#btnReject').show();
                $('#btnCancel').hide();
                $("#btnTurnSpan").text('审核'); 
            }
            //加载申购明细数据 
            $(m_DataGridID).datagrid('loadData', crows);
            
        } 
    }   
}
 

/***********************************************************************
 *  保存
 *  DLY
 *  2014-05-13
 */
function actSaveZ() {
    var flag = false;

    //保存校验  
    if (!saveCheck()) {
        return flag;
    }  
    $(m_DataGridID).datagrid('endEdit', m_LastIndex);

    //保存操作
    var billInfo = eval('[{' + jsonUtil_form2json('#CashAppForm') + '}]'); //获取单据主信息json 
    var gridData = $(m_DataGridID).datagrid('getRows'); //获取单据从信息json 	
    if ($('#ea1_billcode').attr('value') == '') {  //新增单据 
        billInfo[0].Taskid = '';
        var cXML = GetEditJson(billInfo, [], []); //json转xml 
        var cXML1 = ''
        if (gridData.length > 0) {
            var cXML1 = GetEditJson(gridData, [], []);//json转xml 
        }
        var curl = GetWSRRURL(peoa_GetWSRRURL(12)) + "&type=New&actor=" + encodeURIComponent(m_UserInfo.UserName);
        var cxmlsJson = { XML: cXML, XML1: cXML1 }; 
        $.ajax({
            url: curl,
            type: "POST",
            async: false,
            data: cxmlsJson,
            dataType: "json",
            success: function (data) {  
                //回写单据信息
                if (data.rows) {
                    if (dataUtil_undefinedOrNull(data.rows[0].billcode, '') != '') {
                        $('#ea1_billcode').attr('value', data.rows[0].billcode);
                        $('#TaskID').attr('value', dataUtil_undefinedOrNull(data.rows[0].taskid, ''));
                        if ($('#ea1_billcode').attr('value') == '') {
                            alert('表单编号生成失败！')
                        } else if ($('#TaskID').attr('value') == '') {
                            alert('流程启动生成失败！')
                        } else {
                            flag = true;
                        }
                        for (var i = 0; i < gridData.length; i++) {
                            gridData[i].ea2_billcode = data.rows[0].billcode;
                        }
                        $(m_DataGridID).datagrid('loadData', gridData); 
                    }
                }
            }
        })
    } else {        //修改单据 
        billInfo[0].Taskid = $('#TaskID').attr('value');
        var cXML = GetEditJson(billInfo, [], []); //json转xml        
        var cXML1 = '';
        //以下拼接从表修改记录信息json
        if ($(m_DataGridID).datagrid('getChanges').length > 0) {
            var gridDataChanges = [];
            var inserted = $(m_DataGridID).datagrid('getChanges', "inserted");
            var updated = $(m_DataGridID).datagrid('getChanges', "updated");
            var deleted = $(m_DataGridID).datagrid('getChanges', "deleted");
            for (var i = 0; i < inserted.length; i++) {
                inserted[i].otype = 'inserted';
                gridDataChanges.push(inserted[i]);
            }
            for (var i = 0; i < updated.length; i++) {
                updated[i].otype = 'updated';
                updated[i].lmuser = m_UserInfo.UserName;
                updated[i].lmdt = dateUtil_dateFomaterA(new Date(), '-');
                gridDataChanges.push(updated[i]);
            }
            for (var i = 0; i < deleted.length; i++) {
                var obj = new Object();
                obj.id = deleted[i].id;
                obj.poapplycode = deleted[i].poapplycode;
                obj.otype = 'deleted';
                gridDataChanges.push(obj);
            }
            cXML1 = GetEditJson(gridDataChanges, [], []);//json转xml
        }
        ////alert(cXML1);  

        var curl = GetWSRRURL(peoa_GetWSRRURL(12)) + "&type=Upd&actor=" + encodeURIComponent(m_UserInfo.UserName); //拼接url
        var cxmlsJson = { XML: cXML, XML1: cXML1 };
        $.ajax({
            url: curl,
            type: "POST",
            async: false,
            data: cxmlsJson,
            //contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                //alert(jsonUtil_jsonToStr(data));
                //回写单据信息
                if (data.rows) {
                    if (dataUtil_undefinedOrNull(data.rows[0].billcode, '') != '') {
                        $(m_DataGridID).datagrid('loadData', gridData);
                        flag = true;
                    }
                }
            }
        })
    }
    return flag;
}


/**
 * 合计明细总金额
 * DLY 
 */
function getSumfymxAmount(rowindex) {
    if ((rowindex == undefined || rowindex == null)) {
        rowindex = -1;
    }
    var sum = 0; 
    var gridData = $(m_DataGridID).datagrid('getRows');
    for (var i = 0; i < gridData.length; i++) {
        if (rowindex == i) {
            var ed = $(m_DataGridID).datagrid('getEditor', { index: m_LastIndex, field: 'ea2_amount' });
            if (ed) {
                sum = 1 * sum + 1 * dataUtil_undefinedOrNull(ed.target.val(), 0);
            } else {
                sum = 1 * sum + 1 * dataUtil_undefinedOrNull(gridData[i].ea2_amount, 0);
            } 
        } else {
            sum = 1 * sum + 1 * dataUtil_undefinedOrNull(gridData[i].ea2_amount, 0);
        } 
    }
    $('#ea1_tamount').numberbox('setValue', sum.toFixed(2)); //设置申购总金额  
} 


/*******************
 * 调用打印页
 */
function print() {
    var billcode = $("#ea1_billcode").attr("value");
    if (billcode == null || billcode == '' || billcode == '（系统自动生成）') {
        $.messager.alert('提示', '保存生成单号才能打印');
        return;
    }
    window.open("../../../WEB/PE_OA/FA/FA_App_print.html?v0=" + billcode);
}


/***********************************************************************
  *  
  * 设置主表信息
  *  DLY 
  */
function setbillInfo(ctype, cdata) {
    if (ctype == 'new') {
        $("form input").attr("value", "");
        $("form textarea").attr("value", ""); 
        $('#ea1_id').attr('value', dataUtil_NewGuid());  //赋值ID  
        $('#TaskID').attr('value', ''); 
        $('#ea1_state').attr('value', '未提交');  
        $('#ea1_applydt').datebox('setValue', dateUtil_dateFomaterB(new Date(), '-'));//申请日期-当前日期
        $('#ea1_applyuser').attr('value', m_UserInfo.UserName);
        $('#ea1_divi').attr('value', basedata_getCommonData('DIVI'));
        $('#ea1_cono').attr('value', 'EP');
        $('#ea1_tamount').numberbox('setValue', '0.00'); 
    } else if (ctype == 'old') {
        $('#ea1_id').attr('value', cdata.ea1_id);
        $('#TaskID').attr('value', cdata.taskid);
        $('#ea1_cono').attr('value', cdata.ea1_cono);
        $('#ea1_divi').attr('value', cdata.ea1_divi);
        $('#ea1_state').attr('value', cdata.ea1_state);
        $('#ea1_billcode').attr('value', cdata.ea1_billcode);
        $('#ea1_applyuser').attr('value', cdata.ea1_applyuser);
        $('#ea1_employeename').attr('value', cdata.ea1_employeename);
        $('#ea1_deptname').attr('value', cdata.ea1_deptname);
        $('#ea1_superior').attr('value', cdata.ea1_superior);
        $('#ea1_employeeid').attr('value', cdata.ea1_employeeid);
        $('#ea1_centercode').attr('value', cdata.ea1_centercode);
        $('#ea1_applydt').datebox('setValue', cdata.ea1_applydt);
        $('#ea1_bankname').attr('value', cdata.ea1_bankname);
        $('#ea1_tel').attr('value', cdata.ea1_tel);
        $('#ea1_projectcode').attr('value', cdata.ea1_projectcode);
        $('#ea1_bankaccount').attr('value', cdata.ea1_bankaccount);
        $('#ea1_tamount').numberbox('setValue', cdata.ea1_tamount); 
    } 
}



/**
 * 保存校验
 * DLY
 * 2014-06-04
 */
function saveCheck() {
    return true;
    //主信息部分校验
    if ($('#GenusCompanyName').combogrid('getValue') == '') {
        $.messager.alert('提示框', '所属公司必填!', "worning");
        return false;
    }
    if ($('#GenusCompanyCode').attr('value') == '') {
        $.messager.alert('提示框', '所属公司编码不能为空!', "worning");
        return false;
    }
    if ($('#ApplyDt').datebox('getValue') == null || $('#ApplyDt').datebox('getValue') == '') {
        $.messager.alert('提示框', '申请日期必填!', 'worning');
        return false;
    }
    if ($('#ApplyUser').attr('value') == '') {
        $.messager.alert('提示框', '申请人不能为空!', 'worning');
        return false;
    }
    /*
    if ($('#EmployeeId').attr('value') == '') {
        $.messager.alert('提示框', '员工代码不能为空!', 'worning');
        return false;
    }*/
    if ($("#DeptID").combotree('getValue') == null || $("#DeptID").combotree('getValue') == ''
        || $('#DeptName').attr('value') == '') {
        $.messager.alert('提示框', '部门名称必填!', 'worning');
        return false;
    }
    if ($('#CenterCode').combobox('getValue') == null || $('#CenterCode').combotree('getValue') == '') {
        $.messager.alert('提示框', '成本中心必填!', 'worning');
        return false;
    }
    if ($('#AssetsType').combobox('getValue') == null || $('#AssetsType').combotree('getValue') == '') {
        $.messager.alert('提示框', '资产类别必填!', 'worning');
        return false;
    }
    if ($('#BudgetType').combobox('getValue') == null || $('#BudgetType').combotree('getValue') == '') {
        $.messager.alert('提示框', '预算内外必填!', 'worning');
        return false;
    }


    //明细信息校验 
    $(m_DataGridID).datagrid('endEdit', m_LastIndex);
    var rows = $(m_DataGridID).datagrid('getRows'); 
    for (var i = 0; i < rows.length; i++) {
        if (rows[i].isadjust == '') {
            $.messager.alert('提示框', '请选择第' + (i * 1 + 1) + '行的是否调配!', 'worning');
            $(m_DataGridID).datagrid('selectRow', i);
            return false;
        }
        if (rows[i].isadjust != '是' && dataUtil_undefinedOrNull(rows[i].sureprice, 0) <= 0) {
            $.messager.alert('提示框', '请填写第' + (i * 1 + 1) + '行的确认单价!', 'worning');
            $(m_DataGridID).datagrid('selectRow', i);
            return false; 
        } 
    } 
    return true;
}
   

/**
 * 提交/审核
 * DLY
 * 2014-06-06
 */
function turnToCheck() {
    var flag = false; //状态标志    
    var info = '确认提交该固定资产申购单吗？';

    if (!actSaveZ()) {
        return flag;
    } else { 
        
        //预算校验(申请人提交时)
        if ($('#State').attr('value') != 1 && $('#State').attr('value') != 99
            && $('#State').attr('value') != 98 && $('#BudgetType').combobox('getValue') == 0) {
            var cXML = '<POApplyCode>' + $('#POApplyCode').attr('value') + '</POApplyCode>'
            var res = basedata_getFABudgetByCons('CheckFABudget', cXML);
            if (res[0].flag != 1) {
                alert(res[0].message);
                return flag;
            }
        } 

        //审核按钮提示
        if ($("#btnTurnSpan").text() == '审核') {
            info = '确认审核该固定资产申购单吗？';
        }

        // 提交流程   
        $.messager.confirm('确认框', info, function (r) {
            if (r) {
                var taskInfo = [{ "ActType": "Y" }];
                taskInfo[0].ID = $('#ID').attr('value');
                taskInfo[0].TaskID = $('#TaskID').attr('value');
                taskInfo[0].CONO = $('#CONO').attr('value');
                taskInfo[0].DIVI = $('#DIVI').attr('value');
                taskInfo[0].RejectFlag = '';
                taskInfo[0].RejectCode = '';
                taskInfo[0].RejectInfo = '';
                var cXML = GetEditJson(taskInfo, [], []); //json转xml     
                var curl = GetWSRRURL(peoa_GetWSRRURL(3)) + "&type=FlowOut&actor=" + encodeURIComponent(m_UserInfo.UserName); //拼接url
                var cxmlsJson = { XML: cXML };
                $.ajax({
                    url: curl,
                    type: "POST",
                    async: false,
                    data: cxmlsJson,
                    //contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        //alert(jsonUtil_jsonToStr(data));
                        //回写单据信息
                        if (data && data.rows) {
                            if (dataUtil_undefinedOrNull(data.rows[0].taskid, '') != '') {
                                $('#successdlg').dialog('open');
                                timeDesc(10);  //关闭页面倒计时 
                                flag = true;
                            } else {
                                alert('表单编号：' + $('#POApplyCode').attr('value') + '流程提交失败，请截图与管理人员联系!');
                            }
                        }
                    }
                })
            }
        });
    }
    return flag;
}
 

/**
 * 驳回按钮
 * DLY
 *  2014-06-04
 */
function actReject() {
    //驳回类型下拉框设置
    $('#gridbhlb').combogrid({
        panelWidth: "375",
        panelHeight: "120",
        animate: true,
        idField: 'ct1_code',
        textField: 'ct1_codename',
        data: basedata_getBDX('gbd3', basedata_getCommonData('CONOT')
                    , basedata_getCommonData('DIVI'), '2', '启用', 'BDType', 'FA_APPRejectType', '', 'ct1_code '),
        editable: false,
        columns: [[
		    { field: 'ct1_code', title: '驳回编码', width: 100, hidden: true },
			{ field: 'ct1_codename', title: '驳回类型', width: 245 },
		    { field: 'ct1_fieldvalues1', title: '类别', width: 100 }
        ]],
        onClickRow: function (rowIndex) {
            var row = $('#gridbhlb').combogrid('grid').datagrid('getSelected');
            $('#rejectCode').attr('value', row.ct1_code);
            $('#rejectFlag').attr('value', row.ct1_vieldvalues1);
        },
        onShowPanel: function (rowIndex) {
        }
    });
    $('#rejectdlg').dialog('open');
}


/**
 * 驳回提交
 * DLY
 *  2014-06-04
 */
function QRrefusal() {
    $('#rejectdlg').dialog('close');
    var refuseReason = $('#refuseReason').attr('value').replace(/[{"\r\n"}]/g, '  ');
    var refuseName = $('#gridbhlb').combogrid('getText');
    var refuseCode = $('#rejectCode').attr('value');
    var refuseFlag = $('#rejectFlag').attr('value');
    if (refuseCode == null || refuseCode == '') {
        $.messager.alert("提示", "请选择驳回理由!");
        return;
    }
    $.messager.confirm('确认框', '确认要驳回该固定资产申购单吗？', function (r) {
        if (r) {
            var taskInfo = [{ "ActType": "N" }];
            taskInfo[0].ID = $('#ID').attr('value');
            taskInfo[0].TaskID = $('#TaskID').attr('value');
            taskInfo[0].CONO = $('#CONO').attr('value');
            taskInfo[0].DIVI = $('#DIVI').attr('value');
            taskInfo[0].RejectFlag = refuseFlag;
            taskInfo[0].RejectCode = refuseCode;
            taskInfo[0].RejectInfo = refuseName + ' —— ' + jsonUtil_serialize(refuseReason);
            var cXML = GetEditJson(taskInfo, [], []); //json转xml     
            var curl = GetWSRRURL(peoa_GetWSRRURL(3)) + "&type=FlowOut&actor=" + encodeURIComponent(m_UserInfo.UserName); //拼接url
            var cxmlsJson = { XML: cXML };
            $.ajax({
                url: curl,
                type: "POST",
                async: false,
                data: cxmlsJson,
                //contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    //alert(jsonUtil_jsonToStr(data));
                    //回写单据信息
                    if (data && data.rows) {
                        if (dataUtil_undefinedOrNull(data.rows[0].taskid, '') != '') {
                            $('#successdlg').dialog('open');
                            timeDesc(10);  //关闭页面倒计时 
                            flag = true;
                        } else {
                            alert('表单编号：' + $('#POApplyCode').attr('value') + '驳回失败，请截图与管理人员联系!');
                        }
                    }
                }
            })
        }
    });
}
 

/**
 * 取消-终止流程
 * DLY
 * 2014-06-04
 */
function actCancel() {
    if ($('#TaskID').attr('value') == null || $('#TaskID').attr('value') == '') {
        $.messager.alert('提示', "流程未启动或该任务无效，无需取消，关闭即可！");
    } else {
        $.messager.confirm('确认框', '确认取消该付款申请单吗？', function (r) {
            if (r) {  
                var taskInfo = [{ "ActType": "C" }];
                taskInfo[0].ID = $('#ID').attr('value');
                taskInfo[0].TaskID = $('#TaskID').attr('value');
                taskInfo[0].CONO = $('#CONO').attr('value');
                taskInfo[0].DIVI = $('#DIVI').attr('value');
                taskInfo[0].RejectFlag = '';
                taskInfo[0].RejectCode = '';
                taskInfo[0].RejectInfo = '';
                var cXML = GetEditJson(taskInfo, [], []); //json转xml     
                var curl = GetWSRRURL(peoa_GetWSRRURL(3)) + "&type=FlowOut&actor=" + encodeURIComponent(m_UserInfo.UserName); //拼接url
                var cxmlsJson = { XML: cXML };
                $.ajax({
                    url: curl,
                    type: "POST",
                    async: false,
                    data: cxmlsJson,
                    //contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        alert(jsonUtil_jsonToStr(data));
                        //回写单据信息
                        if (data && data.rows) {
                            if (dataUtil_undefinedOrNull(data.rows[0].flag, '') == '1') {
                                $('#successdlg').dialog('open');
                                timeDesc(10);  //关闭页面倒计时 
                                flag = true;
                            } else {
                                alert('表单编号：' + $('#POApplyCode').attr('value') + '流程取消失败，请截图与管理人员联系!');
                            }
                        }
                    }
                }) 
            }
        });
    }
}



/***********************************************************************
 *  倒计时
 *  DLY
 *  2013-07-12
 */
function timeDesc(x) {
    if (x > 0) {
        $('#stime').text(x);
        x = x * 1 - 1;
        setTimeout("timeDesc(" + x + ")", 1000);
    } else {
        actCloseTab('T');
    }
}


/***********************************************************************
 *  提交成功确认框，关闭当前单据事件
 *  DLY
 *  2013-07-12
 */
function actCloseTab(type) {
    $('#successdlg').dialog('close');
    if (type == 'T') {
        if (basedata_getUrlParam("type") == 'task') {
            parent.closeTab('申购单' + basedata_getUrlParam("v0"));  //关闭当前选项卡，待办任务
        } else {
            //alert(parent.document.URL); 
            parent.closeTab('固定资产申购单');  //关闭当前选项卡，新建单据
        }
    } else {
        window.location.href = '../../../WEB/PE_OA/FA/FA_APPQuery.html'
            + '?v0=' + basedata_getUrlParam("v0");
    }
}


/***********************************************************************
 *  打开鉴定单选择窗体
 *  DLY 
 */
function openJDDSdlg() {
    $('#jddsdlg').dialog('open');

    // 单据类别
    $('#cxBillType').combobox({
        panelWidth: "130",
        panelHeight: "60",
        editable: false,
        multiple: false,
        data: [{ "code": "1", "text": "电脑鉴定单" }, { "code": "2", "text": "其他" }],
        valueField: 'code',
        textField: 'text'
    });  
    setJDDSGrid('Clear');//先清空-设初值
    setJDDSGrid('Query');//后查询
    $('#jddsgrid').datagrid('loadData', []);
}


/***********************************************************************
 *  设置鉴定单列表
 * acttype： Clear - 清空-设初值  ； Query—查询 ； Link-确定关联鉴定单
 *  DLY 
 */
function setJDDSGrid(acttype) {
    if (acttype == 'Clear') {
        $('#cxBillType').combobox('setValue', '1');
        $('#cxDept').attr('value', '');
        $('#cxName').attr('value', '');
        $('#jddsgrid').datagrid('clearSelections');
        return true;
    } else if (acttype == 'Query') {  
        var cxDept = $('#cxDept').attr('value');
        var cxName = $('#cxName').attr('value');
        var type = $('#cxBillType').combobox('getValue');
        if (type == 1) {
            var cons = ' AND fa4_state=\'已审核\' AND ISNULL(FA4_RefID,\'\') = \'\' '
            // + ' AND fa4_cono=\'EP\' AND fa4_divi == \'D01\' '
            if (cxDept != '') {
                cons += ' AND fa4_department like \'%' + cxDept + '%\' '
            }
            if (cxName != '') {
                cons += ' AND fa4_name like \'%' + cxName + '%\' '
            }
            var cXML = '<Page>1</Page><Num>200</Num>'
                 + '<Cons>' + cons + '</Cons><OrderBy>fa4_rgdt DESC</OrderBy>'
            cXML = basedata_addROOT(cXML);
            //alert(cXML);	
            var curl = GetWSRRURL(peoa_GetWSRRURL(10)) + "&type=GetHs&XML=" + encodeURIComponent(cXML)
                    + "&s=" + new Date().getTime();  //拼接url   

            $('#jddsgrid').datagrid({
                url: curl,
                width: "auto",
                height: 300,
                nowrap: true,
                striped: true,
                collapsible: true,
                remoteSort: false,
                idField: 'fa4_id',
                frozenColumns: [[
                     //{ field: 'ck', checkbox: true }
                ]],
                columns: [[
                    { field: 'fa4_id', title: 'fa4_id', width: 100, hidden: true },
                    { field: 'fa4_department', title: '部门名称', width: 120 },
                    { field: 'fa4_name', title: '使用人', width: 70 },
                    { field: 'fa4_deviceno', title: '设备型号', width: 150 },
                    { field: 'fa4_notebook', title: '笔记本', width: 80 },
                    { field: 'fa4_computer', title: '台式机', width: 80 },
                    { field: 'fa4_diagnosispeople', title: '鉴定人', width: 70 },
                    { field: 'fa4_filldate', title: '鉴定日期', width: 80 },
                    { field: 'fa4_cpu', title: 'CPU', width: 100 },
                    { field: 'fa4_mem', title: '内存', width: 80 },
                    { field: 'fa4_hd', title: '硬盘', width: 80 },
                    { field: 'fa4_buydate', title: '购买日期', width: 80 }
                ]],
                pagination: false,
                rownumbers: true,
                singleSelect: false,
                onClickRow: function (rowIndex) {
                },
                onDblClickRow: function (rowIndex, rowData) {
                    window.open("../../../WEB/PE_OA/FA/FA_CCAS_print.html?v0=" + rowData.fa4_id);
                }
            });
        } else if (type == 2) {
            var cons = ' AND fa3_state=\'已审核\' AND ISNULL(FA3_RefID,\'\') = \'\' '
            // + ' AND fa4_cono=\'EP\' AND fa4_divi == \'D01\' '
            if (cxDept != '') {
                cons += ' AND fa3_department like \'%' + cxDept + '%\' '
            }
            if (cxName != '') {
                cons += ' AND fa3_name like \'%' + cxName + '%\' '
            }
            var cXML = '<Page>1</Page><Num>200</Num>'
                 + '<Cons>' + cons + '</Cons><OrderBy>fa3_rgdt DESC</OrderBy>'
            cXML = basedata_addROOT(cXML);
            //alert(cXML);	
            var curl = GetWSRRURL(peoa_GetWSRRURL(6)) + "&type=GetHs&XML=" + encodeURIComponent(cXML)
                    + "&s=" + new Date().getTime();  //拼接url   
            $('#jddsgrid').datagrid({
                url: curl,
                width: "auto",
                height: 300,
                nowrap: true,
                striped: true,
                collapsible: true,
                remoteSort: false,
                idField: 'fa3_id',
                frozenColumns: [[
                    //{ field: 'ck', checkbox: true }
                ]],
                columns: [[
                    { field: 'fa3_id', title: 'fa3_id', width: 100, hidden: true },
	                { field: 'fa3_department', title: '部门', width: 120 },
	                { field: 'fa3_name', title: '使用人', width: 70 },
	                { field: 'fa3_deviceno', title: '设备型号', width: 150 },
	                { field: 'fa3_assetsno', title: '资产编码', width: 100 },
	                { field: 'fa3_diagnosispeople', title: '诊断人', width: 70 },
	                { field: 'fa3_filldate', title: '诊断日期', width: 80 },
	                { field: 'fa3_diagnosisdept', title: '诊断部门', width: 100 }
                ]],
                pagination: false,
                rownumbers: true,
                singleSelect: false,
                onClickRow: function (rowIndex) {
                },
                onDblClickRow: function (rowIndex, rowData) {
                    window.open("../../../WEB/PE_OA/FA/FA_IPDR_print.html?v0=" + rowData.fa3_id);
                }
            });
        } 
        $('#jddsgrid').datagrid('clearSelections');
    } else if (acttype == 'Link') {  
        var flag = 0; 
        var type = $('#cxBillType').combobox('getValue'); 
        var info = '确认关联鉴定单吗？';
        var row1 = $(m_DataGridID).datagrid('getSelected'); 
        var row2 = $('#jddsgrid').datagrid('getSelected');
        var taskInfo = [{ "ActType": "new" }];
        taskInfo[0].CONO = $('#CONO').attr('value');
        taskInfo[0].DIVI = $('#DIVI').attr('value');
        taskInfo[0].FA2_ID = row1.id;

        //新关联
        if (dataUtil_undefinedOrNull(row1.ccasfid, '') == '') {
            if (!row2) {
                alert('请先选中一条记录！');
            } else {
                taskInfo[0].OldCCASID = 'NULL';
                taskInfo[0].NewCCASID = '';
                if (type == 1) {
                    taskInfo[0].NewCCASID = type + ',' + row2.fa4_id;
                } else if (type == 2) {
                    taskInfo[0].NewCCASID = type + ',' + row2.fa3_id;
                }
            }
        } else {
            if (!row2) { //清除关联 
                info = '确认取消已关联鉴定单吗？';
                taskInfo[0].ActType = 'clear';
                taskInfo[0].OldCCASID = row1.ccasfid; 
                taskInfo[0].NewCCASID = ''; 

            } else { //替换关联
                info = '确认替换已关联鉴定单吗？'
                taskInfo[0].ActType = 'upd';
                taskInfo[0].OldCCASID = row1.ccasfid;
                taskInfo[0].NewCCASID = '';
                if (type == 1) {
                    taskInfo[0].NewCCASID = type + ',' + row2.fa4_id;
                } else if (type == 2) {
                    taskInfo[0].NewCCASID = type + ',' + row2.fa3_id;
                } 
            } 
        }

        // 执行关联  
        $.messager.confirm('确认框', info, function (r) {
            if (r) { 
                var cXML = GetEditJson(taskInfo, [], []); //json转xml     
                var curl = GetWSRRURL(peoa_GetWSRRURL(3)) + "&type=LinkCCAS&actor=" + encodeURIComponent(m_UserInfo.UserName); //拼接url
                var cxmlsJson = { XML: cXML };
                $.ajax({
                    url: curl,
                    type: "POST",
                    async: false,
                    data: cxmlsJson, 
                    dataType: "json",
                    success: function (data) {
                        //alert(jsonUtil_jsonToStr(data));
                        //回写信息
                        if (data && data.rows) { 
                            if (data.rows[0].flag == '1') { 
                                row1.ccasfid = taskInfo[0].NewCCASID;
                                $(m_DataGridID).datagrid('endEdit', m_LastIndex);
                                $(m_DataGridID).datagrid('selectRow', m_LastIndex); 
                                alert(data.rows[0].message);
                                $('#jddsdlg').dialog('close');
                            } else {
                                alert(data.rows[0].message);
                            }
                        }
                    }
                })
            }
        });  
    }
}
 

/***********************************************************************
 *  申购明细列表初始化-只读
 *  DLY
 *  2014-04-28
 */
function actsgmxlbcshzd(dgid) {
    $(dgid).datagrid({
        //title:'申购明细列表', 
        width: 900,
        height: 240,
        nowrap: true,
        striped: true,
        collapsible: true,
        sortName: 'id',
        sortOrder: 'asc',
        remoteSort: false,
        idField: 'id',
        iconCls: 'icon-tip',
        loadMsg: '数据加载中请稍后……',
        frozenColumns: [[

        ]],
        columns: [[
			{ field: 'id', title: 'FID', width: 100, hidden: true },
            { field: 'cono', title: 'cono', width: 100, hidden: true },
            { field: 'divi', title: 'divi', width: 100, hidden: true },
            { field: 'poapplycode', title: '单据编号', width: 100, hidden: true },
			{ field: 'largeclassname', title: '资产大类', width: 100 },
			{ field: 'largeclasscode', title: '大类编码', width: 100 },
			{ field: 'smallclassname', title: '资产小类', width: 100 },
			{ field: 'smallclasscode', title: '小类编码', width: 100 },
			{ field: 'assetsname', title: '资产名称', width: 100 },
			{ field: 'brandcode', title: '品牌', width: 100 },
			{ field: 'model', title: '规格/型号', width: 100 },
			{ field: 'number', title: '数量', width: 35 },
			{
			    field: 'applyprice', title: '申请单价', width: 100, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum(val); }
			},
			{
			    field: 'sureprice', title: '确认单价', width: 100, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum(val); }
			},
			{ field: 'username', title: '使用人', width: 70 },
			{ field: 'usercode', title: '员工号', width: 70 },
			{ field: 'isadjust', title: '是否调配', width: 70 },
		    { field: 'planuse', title: '行动计划', width: 100 },
			{
			    field: 'ccasfid', title: '关联鉴定单', width: 90
                , formatter: function (val) {
                    if (val == undefined || val == null) {
                        return val;
                    }
                    var vals = val.split(',');
                    if (val && vals.length == 2) {
                        if (vals[0] == 1) {
                            var curl = '../../../WEB/PE_OA/FA/FA_CCAS_print.html?v0=' + vals[1];
                            return '&nbsp;&nbsp;&nbsp;' + '<a href="#" class="easyui-linkbutton" onclick=\'javascript:window.open("' + curl + '")\'>查看鉴定单</a>';
                        } else if (vals[0] == 2) {
                            var curl = '../../../WEB/PE_OA/FA/FA_IPDR_print.html?v0=' + vals[1];
                            return '&nbsp;&nbsp;&nbsp;' + '<a href="#" class="easyui-linkbutton" onclick=\'javascript:window.open("' + curl + '")\'>查看诊断单</a>';
                        }
                    }
                    return val;
                }
			},
			{ field: 'filepath', title: '附件路径', width: 100, hidden: true },
			{ field: 'comment', title: '备注', width: 150, editor: 'text' },
			{ field: 'rgdt', title: '创建时间', hidden: true },
			{ field: 'rguser', title: '创建人', hidden: true },
		    { field: 'lmdt', title: '修改时间', hidden: true },
            { field: 'lmuser', title: '修改人', hidden: true },
            { field: 'uptno', title: '修改次数', hidden: true },
			{ field: 'planprice', title: '预算单价', width: 100 }
        ]],
        pagination: false,
        rownumbers: true,
        singleSelect: true,
        onDblClickRow: function () {
        },
        onClickRow: function (rowIndex) {
            if (dataUtil_undefinedOrNull(basedata_getUrlParam("v2"), '') == 'F06-CGJLSH') { // 采购经理操作项
                $(dgid).datagrid('endEdit', m_LastIndex);
                $(dgid).datagrid('selectRow', rowIndex);
                $(dgid).datagrid('beginEdit', rowIndex);
                var dg = $(dgid);
                col = dg.datagrid('getColumnOption', 'sureprice'); //确认金额项
                col.editor = { type: 'numberbox', options: { precision: 2, min: 0 } };

                col1 = dg.datagrid('getColumnOption', 'isadjust'); //是否调配项
                col1.editor = {
                    type: 'combobox', options: {
                        valueField: 'ct1_codename', textField: 'ct1_codename',
                        data: m_YesOrNo, editable: false, panelHeight: "50"
                    }
                };
            } else {
                $(dgid).datagrid('selectRow', rowIndex);
            }
            m_LastIndex = rowIndex;
        },
        onClickCell: function (rowIndex, field, value) {
        },
        onAfterEdit: function (index, row) {
        },
        toolbar: []
    });
}
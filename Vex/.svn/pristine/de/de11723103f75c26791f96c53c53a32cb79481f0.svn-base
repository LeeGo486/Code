var m_SGMXdgId = '#sgmxlb'; //费用明细列表ID
var m_LastIndex = undefined;  //费用明细列表最后一次选中行下标   

 

//人员json数组
var m_EmpList = [];

//低值易耗品类别数组
var m_DLList = [];
var m_XLList = [];



//用户信息
var m_UserInfo = parent.m_UserInfo;
m_UserInfo.depts = [];
m_UserInfo.deptstree = [];
m_deptchose = '';

//下拉数组
var m_YesOrNo = [];//是否选项 
var m_APPState = [];//单据状态 
var m_ProjectCode = [];//项目代码
var m_AdvancedCode = [];//高薪代码
var m_AssetsType = [];//资产类别  
var m_PlanUse = [];//行动计划
var m_CostCenter = [];//成本中心选项  
var m_rejFlag = '0'; //驳回类型
/***********************************************************************
 *  初始化设置
 *  DLY
 *  2014-05-07
 */
$(function () {
    var cxml = ''; 

    //基础数据获取
    var APPStateid = peoa_GetBDFID(11);//单据状态 
    var YesOrNoid = peoa_GetBDFID(4);//是否选项 
    var AssetsTypeid = peoa_GetBDFID(5);//资产类别  
    var DLListid = peoa_GetBDFID(13);//资产大类  
    var cons = ' AND CT1_FatherID in ('
             + '\'' + APPStateid + '\',' + '\'' + YesOrNoid + '\','
             + '\'' + DLListid + '\','
             + '\'' + AssetsTypeid + '\''
             + ')';
    var res = basedata_getBDCommon('gbd12', cons);
    for (var i = 0; i < res.length; i++) {
        var f1 = res[i].ct1_fatherid.toUpperCase();
        if (f1 == AssetsTypeid.toUpperCase()) {
            m_AssetsType.push(res[i]);
        } else if (f1 == APPStateid.toUpperCase()) {
            m_APPState.push(res[i]);
        } else if (f1 == YesOrNoid.toUpperCase()) {
            m_YesOrNo.push(res[i]);
        } else if (f1 == DLListid.toUpperCase()) {
            m_DLList.push(res[i]);
        }
    } 
 

    //所属公司  下拉框设置 
    $('#GenusCompanyName').combogrid({
        panelWidth: "255",
        panelHeight: "150",
        animate: true,
        idField: 'ct1_codename',
        textField: 'ct1_codename',
        editable: false,
        columns: [[
            { field: 'ct1_code', title: '编码', width: 60 },
            { field: 'ct1_codename', title: '所属公司', width: 170 }
        ]],
        onClickRow: function (rowIndex) {
            var row = $('#GenusCompanyName').combogrid('grid').datagrid('getSelected');
            $("#GenusCompanyCode").attr("value", row.ct1_code);
        },
        onShowPanel: function () {
            //if ($('#POApplyCode').attr('value') != '') {
            //    $('#GenusCompanyName').combogrid('grid').datagrid('loadData', []);
            //    alert('单据编号已生成，不允许再调整所属公司！')
            //}
            if (m_deptchose == '') {
                alert('请选择部门');
                $('#GenusCompanyName').combogrid('grid').datagrid('loadData', []);
                return false;
            } 
            var fatherid = m_deptchose.cominfo.oz1_id;
            //alert(fatherid);
            var cons = ' AND CT1_FatherID = '
                     + '\'' + fatherid + '\''
                     + ' AND CT1_State=\'启用\''
                     + ' AND ISNULL(CT1_FieldValues1,\'\') = \'SSGS\'';
            var res = basedata_getBDCommon('gbd12', cons);
            $('#GenusCompanyName').combogrid('grid').datagrid('loadData', res);
            
        }
    }); 


    //项目代码 下拉框设置 
    $('#ProjectCode').combobox({
        panelWidth: "155",
        panelHeight: "60",
        editable: true,
        multiple: false,
        valueField: 'ct1_code',
        textField: 'ct1_codename',
        onShowPanel: function () {
            if (m_deptchose == '') {
                alert('请选择部门');
                $('#ProjectCode').combobox('loadData', res);
                return false;
            }
            //基础数据获取   
            var fatherid = m_deptchose.attributes.OZ1_ID;
            //alert(fatherid);
            var cons = ' AND CT1_FatherID = '
                     + '\'' + fatherid + '\''
                     + ' AND CT1_State=\'启用\''
                     + ' AND ISNULL(CT1_FieldValues1,\'\') = \'XMDM\'';
            var res = basedata_getBDCommon('gbd12', cons);
            $('#ProjectCode').combobox('loadData', res);
        }
    });

    //高薪代码 下拉框设置 
    $('#AdvancedCode').combobox({
        panelWidth: "125",
        panelHeight: "60",
        editable: true,
        multiple: false,
        valueField: 'ct1_code',
        textField: 'ct1_codename',
        onShowPanel: function () {
            if (m_deptchose == '') {
                alert('请选择部门');
                $('#AdvancedCode').combobox('loadData', []);
                return false;
            }
            //基础数据获取   
            var fatherid = m_deptchose.attributes.OZ1_ID;
            //alert(fatherid);
            var cons = ' AND CT1_FatherID = '
                     + '\'' + fatherid + '\''
                     + ' AND CT1_State=\'启用\''
                     + ' AND ISNULL(CT1_FieldValues1,\'\') = \'GXDM\''; 
            var res = basedata_getBDCommon('gbd12', cons);  
            $('#AdvancedCode').combobox('loadData', res);
             
        }
    });

    //资产类别 下拉框设置 
    $('#AssetsType').combobox({
        panelWidth: "125",
        panelHeight: "60",
        editable: false,
        multiple: false,
        valueField: 'ct1_code',
        textField: 'ct1_codename',
        data: m_AssetsType
    });

      

    //获取人员所在部门及级联树
    m_UserInfo.depts = basedata_getDeptsByEmpCode(m_UserInfo.empCode, dateUtil_dateFomaterB(new Date(), '-'));
    for (var i = 0; i < m_UserInfo.depts.length; i++) {
        var cXML = '<Page>0</Page><Num>0</Num>'
              + '<Cons> AND OZ1_State=\'启用\'</Cons><OrderBy></OrderBy>'
        cXML = basedata_addROOT(cXML);
        //alert(cXML);	
        var curl = GetTreeWSRRURL(peoa_GetWSRRURL(11), undefined, m_UserInfo.depts[i].oz1_orgcode, "1")
                + "&MenuCodeContains=0&type=GetORGTree&XML=" + encodeURIComponent(cXML)
                + "&s=" + new Date().getTime();  //拼接url   
        $.ajax({
            url: curl,
            options: "JSON",
            async: false,
            success: function (data) {
                //alert(data);
                var data1 = eval('(' + data + ')'); 
                m_UserInfo.deptstree.push(data1[0]);
            }
        });
    } 
     

    //部门 下拉框设置
    $('#DeptID').combotree({ 
        panelWidth: "155",
        panelHeight: "130",
        animate: true,
        onlyLeafCheck: true,
        editable: false,
        idField: 'id',
        textField: 'text',
        data: m_UserInfo.deptstree,
        onSelect: function (data) { 
            //if (data.id == $('#DeptID').combotree("getValue")) { //判断是否改变，无效
            //    return false;
            //} 
            m_deptchose = data; 
            //获取部门所在公司信息 
            m_deptchose = basedata_getDeptInfo(2, '', m_deptchose);
            $('#DeptName').attr('value', data.text);
            $('#DIVI').attr('value', basedata_getCommonData('DIVI'));
            $('#CONO').attr('value', m_deptchose.cominfo.oz1_brand);
            //alert(m_deptchose.cominfo.oz1_brand);
            $('#CenterCode').combobox('setValue', ''); 
            $("#DeptID1").attr("value", data.attributes.OZ1_MDeptCode);
            
        },
        onShowPanel: function (rowIndex) {
        }
    }); 
    

    //成本中心 下拉框设置
    $('#CenterCode').combobox({
        panelWidth: "155",
        panelHeight: "80", 
        editable: false,
        multiple: false,
        valueField: 'costcentercode',
        textField: 'costcentercode',
        onShowPanel: function (rowIndex) {
            var cdeptid = $('#DeptID').combotree("getValue");
            if (cdeptid == '') {
                $.messager.alert('提示框', '请先选择部门！');
                return false;
            } 
            //alert(m_deptchose.attributes.OZ1_CostCenterCode2);
            var costs = dataUtil_undefinedOrNull(m_deptchose.attributes.OZ1_CostCenterCode2, '');
            if (costs == '') {
                $.messager.alert('提示框', '未配置成本中心！');
                return false;
            }
            costs = costs.split(',');
            m_CostCenter = [];
            for (var i = 0; i < costs.length; i++) {
                if (costs[i] != '') {
                    m_CostCenter.push({ costcentercode: costs[i] });
                }
            }
            $('#CenterCode').combobox('loadData', m_CostCenter);
        },
        onSelect: function (data) {
            //获取预算信息 
            basedatalv_getYSInfo(data.costcentercode, undefined, undefined, 'lvapp');
        }
    });


    //鼠标单击后事件求合计
    document.onmouseup = function (e) {
        getSumfymxAmount(m_LastIndex); //求合计金额 
        return true;
    }
     
    //申请日期格式化及值变化控制
    $('#ApplyDt').datebox({
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
 *  申购明细列表初始化 
 *  DLY
 *  2014-04-28
 */
function actsgmxlbcsh(dgid) {
    $(dgid).datagrid({
        //title:'申购明细列表', 
        width: 900,
        height: 240,
        nowrap: true,
        striped: true,
        collapsible: true,
        sortName: 'lv2_id',
        sortOrder: 'asc',
        remoteSort: false,
        idField: 'lv2_id',
        iconCls: 'icon-tip',
        loadMsg: '数据加载中请稍后……',
        frozenColumns: [[

        ]],
        columns: [[
			{ field: 'lv2_id', title: 'FID', width: 100, hidden: true },
            { field: 'lv2_cono', title: 'cono', width: 100, hidden: true },
            { field: 'lv2_divi', title: 'divi', width: 100, hidden: true },
            { field: 'lv2_poapplycode', title: '单据编号', width: 100, hidden: true },
			{ field: 'lv2_assetsname', title: '资产名称', width: 130, editor: 'text' },
			{ field: 'lv2_brandcode', title: '品牌', width: 100, editor: 'text' },
			{ field: 'lv2_model', title: '规格/型号', width: 100, editor: 'text' },
			{ field: 'lv2_number', title: '数量', width: 65, align: "right" 
                , editor: { type: 'numberbox', options: { precision: 2, min: 0 } }
			    , formatter: function (val) { return dataUtil_formatNum(val); }
			},
			{ field: 'lv2_applyprice', title: '申请单价', width: 90, align: "right"
				, editor: { type: 'numberbox', options: { precision: 2, min: 0 } }
			    , formatter: function (val) { return dataUtil_formatNum(val); }
			},
			{ field: 'lv2_sureprice', title: '确认单价', width: 90, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum(val); }
			},
			{ field: 'lv2_username', title: '使用人', width: 70, editor: 'text'},
			{ field: 'lv2_usercode', title: '员工号', width: 70, editor: 'text' },
			{ field: 'lv2_isadjust', title: '是否调配', width: 70 },
		    { field: 'lv2_planuse', title: '行动计划', width: 100
		         , editor: {
		             type: 'combobox', options: {
		                 valueField: 'code', textField: 'codename',
		                 editable: false, panelHeight: "70",
		                 onShowPanel: function () {
		                     //行动计划选项获取 
		                     if (m_PlanUse.length == 0) {
		                         m_PlanUse = basedata_getBDX('gbd2', basedata_getCommonData('CONOT')
                                    , basedata_getCommonData('DIVI'), '2', '启用', 'BDType', 'PlanUse', '', '');
		                         var ed = $(dgid).datagrid('getEditor', { index: m_LastIndex, field: 'lv2_planuse' });
		                         ed.target.combobox('loadData', m_PlanUse); ;
		                     }
		                 }  
		             }
		         }
		    },
			{ field: 'lv2_ccasfid', title: '关联鉴定单', width: 90
			   , formatter: function (val) {
			       if (val == undefined || val == null || val == '') { 
			           return val;
			       }
			       var vals = val.split(',');
			       if (vals.length == 2) {
			           if (vals[0] == 1) {
			               var curl = '../../../WEB/PE_OA/FA/FA_CCAS_print.html?v0=' + vals[1];
			               return '&nbsp;&nbsp;&nbsp;' + '<a href="#" style="background-color:#FFBBFF" onclick=\'javascript:window.open("' + curl + '")\'>查看鉴定单</a>';
			           } else if (vals[0] == 2) {
			               var curl = '../../../WEB/PE_OA/FA/FA_IPDR_print.html?v0=' + vals[1];
			               return '&nbsp;&nbsp;&nbsp;' + '<a href="#" style="background-color:#FFBBFF" onclick=\'javascript:window.open("' + curl + '")\'>查看诊断单</a>';
			           }
			       }
			       return val;
			   }
			},
			{ field: 'lv2_filepath', title: '附件路径', width: 100, hidden: true },
			{ field: 'lv2_comment', title: '备注', width: 150, editor: 'text' },
			{ field: 'lv2_rgdt', title: '创建时间', hidden: true },
			{ field: 'lv2_rguser', title: '创建人', hidden: true },
		    { field: 'lv2_lmdt', title: '修改时间', hidden: true },
            { field: 'lv2_lmuser', title: '修改人', hidden: true },
            { field: 'lv2_uptno', title: '修改次数', hidden: true },
			{ field: 'lv2_planprice', title: '预算单价', width: 100 }
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
            $(dgid).datagrid('beginEdit', rowIndex);
            m_LastIndex = rowIndex;
        },
        onClickCell: function (rowIndex, field, value) {  
        },
        onAfterEdit: function (index, row) {
            getSumfymxAmount(-1); //求合计;
        },
        onBeforeEdit: function (index, row) {

        },
        toolbar: [{
            text: '添加',
            iconCls: 'icon-add',
            handler: function () {
                if (!savemxCheck()) {
                    return false;
                }
                $(dgid).datagrid('appendRow', {
                    lv2_rgdt: dateUtil_dateFomaterA(new Date(), '-'),
                    lv2_rguser: m_UserInfo.UserName,
                    lv2_id: dataUtil_NewGuid(),
                    lv2_poapplycode: $('#POApplyCode').attr('value'),
                    lv2_isadjust: '否'
                });
                $(dgid).datagrid('endEdit', m_LastIndex);
                m_LastIndex = $('#sgmxlb').datagrid('getRows').length - 1;
                $(dgid).datagrid('selectRow', m_LastIndex);
                $(dgid).datagrid('beginEdit', m_LastIndex); 
            }
        }, '-', {
            text: '复制',
            iconCls: 'icon-design',
            handler: function () {
                if (!savemxCheck()) {
                    return false;
                }
                var row = $(m_SGMXdgId).datagrid('getSelected');
                if (row) {
                    $(dgid).datagrid('endEdit', m_LastIndex);
                    $(dgid).datagrid('appendRow', {
                        lv2_rgdt: dateUtil_dateFomaterA(new Date(), '-'),
                        lv2_rguser: m_UserInfo.UserName,
                        lv2_id: dataUtil_NewGuid(),
                        lv2_poapplycode: $('#POApplyCode').attr('value'),  
                        lv2_assetsname: dataUtil_undefinedOrNull(row.lv2_assetsname, ''),
                        lv2_brandcode: dataUtil_undefinedOrNull(row.lv2_brandcode, ''),
                        lv2_model: dataUtil_undefinedOrNull(row.lv2_model, ''),
                        lv2_username: dataUtil_undefinedOrNull(row.lv2_username, ''),
                        lv2_usercode: dataUtil_undefinedOrNull(row.lv2_usercode, ''),
                        lv2_planuse: dataUtil_undefinedOrNull(row.lv2_planuse, ''),
                        lv2_applyprice: dataUtil_undefinedOrNull(row.lv2_applyprice, ''),
                        lv2_number: dataUtil_undefinedOrNull(row.lv2_number, ''),
                        lv2_isadjust: '否'
                    });

                    m_LastIndex = $('#sgmxlb').datagrid('getRows').length - 1;
                    $(dgid).datagrid('selectRow', m_LastIndex);
                    $(dgid).datagrid('beginEdit', m_LastIndex); 
                    getSumfymxAmount(-1); //求合计;
                }
            }
        }, '-', {
            text: dataUtil_actSetNStr('&nbsp', 170),
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
        actsgmxlbcsh(m_SGMXdgId); //初始化设置申购明细列表
        $(m_SGMXdgId).datagrid('appendRow', {   //插入一条空记录
            lv2_rgdt: dateUtil_dateFomaterA(new Date(), '-'),
            lv2_rguser: m_UserInfo.UserName,
            lv2_id: dataUtil_NewGuid(),
            lv2_poapplycode: $('#POApplyCode').attr('value'),
            lv2_isadjust: '否'
        });
        m_LastIndex = $(m_SGMXdgId).datagrid('getRows').length - 1;
        $(m_SGMXdgId).datagrid('selectRow', m_LastIndex);
        $(m_SGMXdgId).datagrid('beginEdit', m_LastIndex); 

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
            $('#ID').attr('value', '此单据信息有误！');
            $('#POApplyCode').attr('value', '此单据信息有误！');
            $('#tbztoolbar').hide();
            return false;
        } else {
            var crows = [];
            //获取主表信息 
            var cxml3 = '<Page>1</Page><Num>1</Num>'
             + '<Cons> AND LV1_POApplyCode = \'' + basedata_getUrlParam("v0") + '\' </Cons><OrderBy></OrderBy>';
            cxml3 = basedata_addROOT(cxml3);
            var curl = GetWSRRURL(peoa_GetWSRRURL(15)) + "&type=GetHs&XML=" + encodeURIComponent(cxml3)
                     + "&s=" + new Date().getTime(); //拼接url
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
                        m_rejFlag = data.rows[0].lv1_isreject; 
                        if (data.rows[0].lv1_rejectinfo != ''){
                            $('#btnlookRI').show(); 
                            $('#rejectInfoSpan').text(data.rows[0].lv1_rejectinfo);
                        }
                        //获取从表信息 
                        var cxml4 = '<Page>1</Page><Num>100</Num>'
                         + '<Cons> AND LV2_POApplyCode = \'' + basedata_getUrlParam("v0") + '\' </Cons><OrderBy></OrderBy>';
                        cxml4 = basedata_addROOT(cxml4);
                        var curl4 = GetWSRRURL(peoa_GetWSRRURL(15)) + "&type=GetDs&XML=" + encodeURIComponent(cxml4)
                                 + "&s=" + new Date().getTime(); //拼接url 
                        $.ajax({
                            url: curl4,
                            type: "GET",
                            async: false,
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                //alert(jsonUtil_jsonToStr(data));
                                if (data && data.rows && data.rows.length > 0 && data.rows[0].lv2_id) {
                                    crows = data.rows
                                }
                            }
                        });
                         
                    }
                }
            })

            if (dataUtil_undefinedOrNull(basedata_getUrlParam("v2"), '') == 'F01-SGDTX') {
                //获取部门信息 
                if (m_deptchose == '') {
                    m_deptchose = basedata_getDeptInfo(1, '', m_deptchose);
                }
                //申请人特殊控制--驳回类型资产用途不明确  
                if (m_rejFlag == '3') { 
                    fielsControl(3);
                    actsgmxlbcshzd(m_SGMXdgId);
                } else {
                    //初始化设置申购明细列表 
                    actsgmxlbcsh(m_SGMXdgId); 
                } 
               
            } else {  
                //控件只读控制 
                fielsControl(1);
                $('#btnReject').show();
                $('#btnCancel').hide();
                $("#btnTurnSpan").text('审核');
                //信息专员环节特殊控制 
                if (dataUtil_undefinedOrNull(basedata_getUrlParam("v2"), '') == 'F02-XXZYSH') {
                    actsgmxlbcsh(m_SGMXdgId); 
                    $(m_SGMXdgId).datagrid({
                        toolbar: [{
                            text: '关联鉴定单',
                            iconCls: 'icon-design',
                            //hidden: true,
                            handler: function () {
                                var row = $(m_SGMXdgId).datagrid('getSelected');
                                if (row) {
                                    openJDDSdlg();
                                }
                            }
                        }]
                    });
                } else {     //其他环节只读 
                    actsgmxlbcshzd(m_SGMXdgId); 
                }
            }
             
            //加载申购明细数据 
            $(m_SGMXdgId).datagrid('loadData', crows); 
           
        }

    }  
     
}


/*******************
 * field控件只读控制
 * DLY
 */
function fielsControl(type) {
    if (type == 1) {   //全部只读
        $('#GenusCompanyName').combogrid('disable'); //所属公司不可调整
        $('#ProjectCode').combobox('disable'); //项目代码
        $('#AdvancedCode').combobox('disable');//高薪代码
        $('#ApplyDt').datebox('disable');//申请日期;
        $('#DeptID').combotree('disable');//部门名称
        $('#AssetsType').combobox('disable');//资产类别
        $('#CenterCode').combobox('disable');//成本中心 
        $('#Comment').attr("disabled", true);//资产用途 
    } else if (type == 3) {   //仅资产用途可编辑
        $('#GenusCompanyName').combogrid('disable'); //所属公司不可调整
        $('#ProjectCode').combobox('disable'); //项目代码
        $('#AdvancedCode').combobox('disable');//高薪代码
        $('#ApplyDt').datebox('disable');//申请日期;
        $('#DeptID').combotree('disable');//部门名称
        $('#AssetsType').combobox('disable');//资产类别
        $('#CenterCode').combobox('disable');//成本中心 
        $('#Comment').attr("disabled", false);//资产用途 
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

    $(m_SGMXdgId).datagrid('endEdit', m_LastIndex);
    //保存操作
    var billInfo = eval('[{' + jsonUtil_form2json('#FA-AppForm') + '}]'); //获取单据主信息json 
    var gridData = $(m_SGMXdgId).datagrid('getRows'); //获取单据从信息json 	
    if ($('#POApplyCode').attr('value') == '') {  //新增单据 
        billInfo[0].Taskid = '';
        var cXML = GetEditJson(billInfo, [], []); //json转xml 
        var cXML1 = ''
        if (gridData.length > 0) {
            var cXML1 = GetEditJson(gridData, [], []);//json转xml 
        }
        var curl = GetWSRRURL(peoa_GetWSRRURL(15)) + "&type=New&actor=" + encodeURIComponent(m_UserInfo.UserName);
        var cxmlsJson = { XML: cXML, XML1: cXML1 };
        //cxmlsJson.XML = cXML;
        //cxmlsJson.XML1 = cXML1;
        $.ajax({
            url: curl,
            type: "POST",
            async: false,
            data: cxmlsJson,
            dataType: "json",
            success: function (data) {
                //alert(jsonUtil_jsonToStr(data));
                //回写单据信息
                if (data.rows) { 
                    $('#POApplyCode').attr('value', dataUtil_undefinedOrNull(data.rows[0].poapplycode, ''));
                    $('#ID').attr('value', data.rows[0].id);
                    $('#TaskID').attr('value', dataUtil_undefinedOrNull(data.rows[0].taskid, ''));
                    if ($('#POApplyCode').attr('value') == '') {
                        alert('表单编号生成失败！')
                    } else if ($('#TaskID').attr('value') == '') {
                        alert('流程启动生成失败！')
                    } else {
                        flag = true;
                    }
                    for (var i = 0; i < gridData.length; i++) {
                        gridData[i].poapplycode = data.rows[0].poapplycode;
                        $('#GenusCompanyName').combogrid('disable');
                    }
                    $(m_SGMXdgId).datagrid('loadData', gridData); 
                }
            }
        })
    } else {        //修改单据 
        billInfo[0].Taskid = $('#TaskID').attr('value');
        var cXML = GetEditJson(billInfo, [], []); //json转xml        
        var cXML1 = '';
        //以下拼接从表修改记录信息json
        if ($(m_SGMXdgId).datagrid('getChanges').length > 0) {
            var gridDataChanges = [];
            var inserted = $(m_SGMXdgId).datagrid('getChanges', "inserted");
            var updated = $(m_SGMXdgId).datagrid('getChanges', "updated");
            var deleted = $(m_SGMXdgId).datagrid('getChanges', "deleted");
            for (var i = 0; i < inserted.length; i++) {
                inserted[i].otype = 'inserted';
                gridDataChanges.push(inserted[i]);
            }
            for (var i = 0; i < updated.length; i++) {
                updated[i].otype = 'updated';
                updated[i].lv2_lmuser = m_UserInfo.UserName;
                updated[i].lv2_lmdt = dateUtil_dateFomaterA(new Date(), '-');
                gridDataChanges.push(updated[i]);
            }
            for (var i = 0; i < deleted.length; i++) {
                var obj = new Object();
                obj.lv2_id = deleted[i].lv2_id;
                obj.lv2_poapplycode = deleted[i].lv2_poapplycode;
                obj.otype = 'deleted';
                gridDataChanges.push(obj);
            }
            cXML1 = GetEditJson(gridDataChanges, [], []);//json转xml
        }
        ////alert(cXML1);  

        var curl = GetWSRRURL(peoa_GetWSRRURL(15)) + "&type=Upd&actor=" + encodeURIComponent(m_UserInfo.UserName); //拼接url
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
                    if (dataUtil_undefinedOrNull(data.rows[0].poapplycode, '') != '') {
                        $(m_SGMXdgId).datagrid('loadData', gridData);
                        flag = true;
                    }
                }
            }
        })
    }
    return flag;
}


/**
 * 合计明细申购总金额，确认总金额
 * DLY
 * 2014-05-13
 */
function getSumfymxAmount(rowindex) {
    if ((rowindex == undefined || rowindex == null)) {
        rowindex = -1;
    }
    var sum = 0;
    var sum1 = 0;
    var gridData = $(m_SGMXdgId).datagrid('getRows');
    for (var i = 0; i < gridData.length; i++) {
        if (rowindex == i) {
            var number = 0;
            var ed2 = $(m_SGMXdgId).datagrid('getEditor', { index: m_LastIndex, field: 'lv2_number' });
            if (ed2) {
                number = dataUtil_undefinedOrNull(ed2.target.val(), 0);
            } else {
                number = dataUtil_undefinedOrNull(gridData[i].lv2_number, 0);
            }
            var ed = $(m_SGMXdgId).datagrid('getEditor', { index: m_LastIndex, field: 'lv2_applyprice' });
            if (ed) {
                sum = 1 * sum + number * dataUtil_undefinedOrNull(ed.target.val(), 0);
            } else {
                sum = 1 * sum + number * dataUtil_undefinedOrNull(gridData[i].lv2_applyprice, 0);
            }
            var isadjust =  dataUtil_undefinedOrNull(gridData[i].lv2_isadjust, '否')
            var ed2 = $(m_SGMXdgId).datagrid('getEditor', { index: m_LastIndex, field: 'lv2_isadjust' });
            if (ed2) { 
                isadjust = ed2.target.combobox('getValue');
            }
            var ed1 = $(m_SGMXdgId).datagrid('getEditor', { index: m_LastIndex, field: 'lv2_sureprice' });
            if (isadjust != '是') {
                if (ed1) {
                    sum1 = 1 * sum1 + number * dataUtil_undefinedOrNull(ed1.target.val(), 0);
                } else {
                    sum1 = 1 * sum1 + number * dataUtil_undefinedOrNull(gridData[i].lv2_sureprice, 0);
                }
            } else {
                ed1.target.val(0);
            }
        } else {
            sum = 1 * sum + dataUtil_undefinedOrNull(gridData[i].lv2_number, 0) * dataUtil_undefinedOrNull(gridData[i].lv2_applyprice, 0); 
            if (dataUtil_undefinedOrNull(gridData[i].lv2_isadjust, '否') != '是') {
                sum1 = 1 * sum1 + dataUtil_undefinedOrNull(gridData[i].lv2_number, 0) * dataUtil_undefinedOrNull(gridData[i].lv2_sureprice, 0);
            }
       }

    }
    $('#ApplyAmount').numberbox('setValue', sum.toFixed(2)); //设置申购总金额  
    $('#ConfirmAmount').numberbox('setValue', sum1.toFixed(2)); //设置确认总金额 
}

 
/*******************
 * 调用打印页
 */
function print() {
    var billcode = $("#POApplyCode").attr("value");
    if (billcode == null || billcode == '' || billcode == '（系统自动生成）') {
        $.messager.alert('提示', '保存生成单号才能打印');
        return;
    }
    window.open("../../../WEB/PE_OA/LV/LV_App_print.html?v0=" + billcode);
}


/***********************************************************************
  *  
  * 设置主表信息
  *  DLY 
  */
function setbillInfo(ctype, cdata) {
    if (ctype == 'new') {
        $('#ID').attr('value', dataUtil_NewGuid());  //赋值ID  
        $('#TaskID').attr('value', '');
        $('#GenusCompanyName').combogrid('setValue', '');
        $('#GenusCompanyCode').attr('value', '');
        $('#ProjectCode').combobox('setValue', '');
        $('#AdvancedCode').combobox('setValue', '');
        $('#State').attr('value', '未提交');
        $('#POApplyCode').attr('value', '');
        $('#ApplyDt').datebox('setValue', dateUtil_dateFomaterB(new Date(), '-'));//申请日期-当前日期 
        if (m_UserInfo.deptstree.length == 1 && (m_UserInfo.deptstree[0].children == undefined
            || m_UserInfo.deptstree[0].children == [])) {
            $('#DeptID').combotree('setValue', m_UserInfo.deptstree[0].id);
            $('#DeptName').attr('value', m_UserInfo.deptstree[0].text);
            $("#DeptID1").attr("value", m_UserInfo.deptstree[0].attributes.OZ1_MDeptCode);
            $('#CenterCode').combobox('setValue', m_UserInfo.deptstree[0].attributes.OZ1_CostCenterCode);
            $('#CenterName').attr('value', '');
            //获取部门所在公司信息 
            var deptinfo = basedata_getDeptInfo(2, '', m_UserInfo.deptstree[0]); 
            $('#CONO').attr('value', deptinfo.cominfo.oz1_brand);
            $('#DIVI').attr('value', basedata_getCommonData('DIVI'));
             
        } else { 
            $('#CONO').attr('value', '');
            $('#DIVI').attr('value', '');
            $('#DeptID').combotree('setValue', '');
            $('#DeptName').attr('value', '');
            $("#DeptID1").attr("value", '');
            $('#CenterCode').combobox('setValue', '');
            $('#CenterName').attr('value', '');
        }
        $('#AssetsType').combobox('setValue', '');
        $('#ApplyUser').attr('value', m_UserInfo.UserName);
        $('#EmployeeId').attr('value', m_UserInfo.empCode); 
        $('#ApplyAmount').numberbox('setValue', '0.00');
        $('#ConfirmAmount').numberbox('setValue', '0.00');
        $('#Comment').attr('value', '');
    } else if (ctype == 'old') {
        $('#ID').attr('value', cdata.lv1_id);  //赋值ID  
        $('#TaskID').attr('value', cdata.taskid);
        $('#CONO').attr('value', cdata.lv1_cono);
        $('#DIVI').attr('value', cdata.lv1_divi);
        $('#GenusCompanyName').combogrid('setValue', cdata.lv1_genuscompanyname);
        $('#GenusCompanyCode').attr('value', cdata.lv1_genuscompanycode);
        $('#ProjectCode').combobox('setValue', cdata.lv1_projectcode);
        $('#AdvancedCode').combobox('setValue', cdata.lv1_advancedcode);
        $('#State').attr('value', basedata_getCodename(m_APPState, cdata.lv1_state, 'ct1_code', 'ct1_codename'));
        $('#POApplyCode').attr('value', cdata.lv1_poapplycode);
        $('#ApplyDt').datebox('setValue', dateUtil_dateFomaterB(new Date(cdata.lv1_applydt), '-'));//申请日期-当前日期
        $('#ApplyUser').attr('value', cdata.lv1_applyuser); 
        $('#DeptID').combotree('setValue', cdata.lv1_deptid);
        $('#DeptID').combotree('setText', cdata.lv1_deptname);
        $('#DeptName').attr('value', cdata.lv1_deptname);
        $("#DeptID1").attr("value", cdata.lv1_deptid1);
        $('#AssetsType').combobox('setValue', cdata.lv1_assetstype);
        $('#EmployeeId').attr('value', cdata.lv1_employeeid);
        $('#CenterCode').combobox('setValue', cdata.lv1_centercode);
        $('#CenterName').attr('value', cdata.lv1_centerName); 
        $('#ApplyAmount').numberbox('setValue', cdata.lv1_applyamount);
        $('#ConfirmAmount').numberbox('setValue', cdata.lv1_confirmamount);
        $('#Comment').attr('value', decodeURIComponent(cdata.lv1_comment));
        $('#DepartmentDirector').text(cdata.lv1_departmentdirector);
        $('#DivisionManager').text(cdata.lv1_divisionmanager);
        $('#ITDirector').text(cdata.lv1_itdirector);
        $('#PurchaseManager').text(cdata.lv1_purchasemanager);
        $('#ShareServiceCenterDirector').text(cdata.lv1_shareservicecenterdirector);
        $('#FinanceDirector').text(cdata.lv1_financedirector);
        //获取预算信息
        basedatalv_getYSInfo(cdata.lv1_centercode, dateUtil_dateFomaterB(new Date(cdata.lv1_applydt), '-'), cdata.lv1_poapplycode, 'lvapp');
    }

}
 

/**
 * 保存校验
 * DLY 
 */
function saveCheck() {
    //主信息部分校验
    if ($('#CONO').attr('value') == '') {
        $.messager.alert('提示框', '公司对应品牌获取失败!', "worning");
        return false;
    }
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


    //明细信息校验 
    $(m_SGMXdgId).datagrid('endEdit', m_LastIndex);
    var rows = $(m_SGMXdgId).datagrid('getRows');
    if (rows.length == 0) {
        $.messager.alert('提示框', '请至少添加一条资产明细!', 'worning'); 
        return false;
    }

    //申请人环节校验
    if (dataUtil_undefinedOrNull(basedata_getUrlParam("v2"), '') == 'F01-SGDTX') {
        for (var i = 0; i < rows.length; i++) { 
            if (dataUtil_undefinedOrNull(rows[i].lv2_applyprice, 0) <= 0) {
                $.messager.alert('提示框', '请填写第' + (i * 1 + 1) + '行的申请单价!', 'worning');
                $(m_SGMXdgId).datagrid('selectRow', i);
                return false;
            }
            if (dataUtil_undefinedOrNull(rows[i].lv2_number, 0) <= 0) {
                $.messager.alert('提示框', '请填写第' + (i * 1 + 1) + '行的数量!', 'worning');
                $(m_SGMXdgId).datagrid('selectRow', i);
                return false;
            }
            if (dataUtil_undefinedOrNull(rows[i].lv2_assetsname, '') == '') {
                $.messager.alert('提示框', '请填写第' + (i * 1 + 1) + '行的资产名称!', 'worning');
                $(m_SGMXdgId).datagrid('selectRow', i);
                return false;
            }
        }
    }

    //采购经理环节确认单价校验
    if (dataUtil_undefinedOrNull(basedata_getUrlParam("v2"), '') == 'F06-CGJLSH') {
        for (var i = 0; i < rows.length; i++) {
            if (rows[i].lv2_isadjust == '') {
                $.messager.alert('提示框', '请选择第' + (i * 1 + 1) + '行的是否调配!', 'worning');
                $(m_SGMXdgId).datagrid('selectRow', i);
                return false;
            }
            if (rows[i].lv2_isadjust != '是' && dataUtil_undefinedOrNull(rows[i].lv2_sureprice, 0) <= 0) {
                $.messager.alert('提示框', '请填写第' + (i * 1 + 1) + '行的确认单价!', 'worning');
                $(m_SGMXdgId).datagrid('selectRow', i);
                return false;
            }

            //if (rows[i].lv2_isadjust != '是'
            //    && dataUtil_undefinedOrNull(rows[i].lv2_applyprice, 0) < rows[i].lv2_sureprice) {
            //    $.messager.alert('提示框', '第' + (i * 1 + 1) + '行的确认单价不能大于申请单价!', 'worning');
            //    $(m_SGMXdgId).datagrid('selectRow', i);
            //    return false;
            //}
        }
    }  
    return true;
}
  
 
/**
 * 明细信息校验 
 * DLY
 * 2015-04-01
 */
function savemxCheck() {
    //明细信息校验  
    var rows = $(m_SGMXdgId).datagrid('getRows');
    if (rows.length >= 10) {
        $.messager.alert('提示框', '每单申请明细记录数不可超过10条!', 'worning');
        return false;
    }
    return true;
}

/**
 * 提交/审核
 * DLY 
 */
function turnToCheck() {
    var flag = false; //状态标志    
    var info = '确认提交该低值易耗品申购单吗？';

    if (!actSaveZ()) {
        return flag;
    } else { 
        var curfunccode = dataUtil_undefinedOrNull(basedata_getUrlParam("v2"), 'F01-SGDTX');
        //alert(curfunccode);
        //预算校验(申请人提交时)
        if ( (curfunccode== 'F01-SGDTX' && m_rejFlag != '3')
                || curfunccode == 'F06-CGJLSH') {
            //获取预算信息
            var res = basedatalv_getYSInfo($('#CenterCode').combobox('getValue'),
                $('#ApplyDt').datebox('getValue'), $('#POApplyCode').attr('value'), 'lvapp'); 
            if (res.length == 0) {
                alert('获取预算信息失败！');
                return flag;
            }
            if (res[0].flag == 1) {
                if (curfunccode== 'F01-SGDTX' && res[0].kyje*1 < $('#ApplyAmount').numberbox('getValue')*1) {
                    alert('申请总金额不能大于可用金额！');
                    return flag;
                } else if (curfunccode == 'F06-CGJLSH' && res[0].kyje * 1 < $('#ConfirmAmount').numberbox('getValue') * 1) {
                    alert('确认总金额不能大于可用金额！');
                    return flag;
                }
            }
        } 

        //审核按钮提示
        if ($("#btnTurnSpan").text() == '审核') {
            info = '确认审核该低值易耗品申购单吗？';
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
                //alert(cXML);
                var curl = GetWSRRURL(peoa_GetWSRRURL(15)) + "&type=FlowOut&actor=" + encodeURIComponent(m_UserInfo.UserName); //拼接url
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
    $.messager.confirm('确认框', '确认要驳回该低值易耗品申购单吗？', function (r) {
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
            var curl = GetWSRRURL(peoa_GetWSRRURL(15)) + "&type=FlowOut&actor=" + encodeURIComponent(m_UserInfo.UserName); //拼接url
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
                var curl = GetWSRRURL(peoa_GetWSRRURL(15)) + "&type=FlowOut&actor=" + encodeURIComponent(m_UserInfo.UserName); //拼接url
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
            parent.closeTab('低值易耗品申购单');  //关闭当前选项卡，新建单据
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
        var row1 = $(m_SGMXdgId).datagrid('getSelected'); 
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
                var curl = GetWSRRURL(peoa_GetWSRRURL(15)) + "&type=LinkCCAS&actor=" + encodeURIComponent(m_UserInfo.UserName); //拼接url
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
                                row1.lv2_ccasfid = taskInfo[0].NewCCASID;
                                $(m_SGMXdgId).datagrid('endEdit', m_LastIndex);
                                $(m_SGMXdgId).datagrid('selectRow', m_LastIndex); 
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
        sortName: 'lv2_id',
        sortOrder: 'asc',
        remoteSort: false,
        idField: 'lv2_id',
        iconCls: 'icon-tip',
        loadMsg: '数据加载中请稍后……',
        frozenColumns: [[

        ]],
        columns: [[
			{ field: 'lv2_id', title: 'FID', width: 100, hidden: true },
            { field: 'lv2_cono', title: 'cono', width: 100, hidden: true },
            { field: 'lv2_divi', title: 'divi', width: 100, hidden: true },
            { field: 'lv2_poapplycode', title: '单据编号', width: 100, hidden: true }, 
			{ field: 'lv2_assetsname', title: '资产名称', width: 100 },
			{ field: 'lv2_brandcode', title: '品牌', width: 100 },
			{ field: 'lv2_model', title: '规格/型号', width: 100 },
			{ field: 'lv2_number', title: '数量', width: 35 },
			{
			    field: 'lv2_applyprice', title: '申请单价', width: 100, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum(val); }
			},
			{
			    field: 'lv2_sureprice', title: '确认单价', width: 100, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum(val); }
			},
			{ field: 'lv2_username', title: '使用人', width: 70 },
			{ field: 'lv2_usercode', title: '员工号', width: 70 },
			{ field: 'lv2_isadjust', title: '是否调配', width: 70 },
		    { field: 'lv2_planuse', title: '行动计划', width: 100 },
			{
			    field: 'lv2_ccasfid', title: '关联鉴定单', width: 90
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
			{ field: 'lv2_filepath', title: '附件路径', width: 100, hidden: true },
			{ field: 'lv2_comment', title: '备注', width: 150, editor: 'text' },
			{ field: 'lv2_rgdt', title: '创建时间', hidden: true },
			{ field: 'lv2_rguser', title: '创建人', hidden: true },
		    { field: 'lv2_lmdt', title: '修改时间', hidden: true },
            { field: 'lv2_lmuser', title: '修改人', hidden: true },
            { field: 'lv2_uptno', title: '修改次数', hidden: true },
			{ field: 'lv2_planprice', title: '预算单价', width: 100 }
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
                col = dg.datagrid('getColumnOption', 'lv2_sureprice'); //确认金额项
                col.editor = { type: 'numberbox', options: { precision: 2, min: 0 } };

                col1 = dg.datagrid('getColumnOption', 'lv2_isadjust'); //是否调配项
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


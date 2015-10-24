
//控件ID
var m_TabsId = '#rwzx';         //任务中心选项卡id
var m_DatagridId = '#dbrwlb';   //待办任务列表id


var m_LastIndex = -1;  //列表最后一次选中行下标
var m_PageNumber = 1;  //当前页码
var m_PageSize = 20;  //每页显示行数

var m_TaskTypes = [];

 
 
//用户信息
var m_UserInfo = basedata_getUserInfo();
m_UserInfo.mdeptCodes = [];
  

// 过滤条件
var m_Filter = '';  //主的条件
var m_Filter1 = ''; //查询条件-记录表
var m_Filter2 = ''; //查询条件-任务表
var m_OrderBy = ' ORDER BY CONVERT(VARCHAR(20),WT1_RgDt,120) DESC '; //排序方式





/**
     * 修改DataGrid对象的默认大小，以适应页面宽度。
     * 
     * @param heightMargin
     *            高度对页内边距的距离。
     * @param widthMargin
     *            宽度对页内边距的距离。
     * @param minHeight
     *            最小高度。
     * @param minWidth
     *            最小宽度。
     * 
     
$.fn.extend({
    resizeDataGrid: function (heightMargin, widthMargin, minHeight, minWidth) {
        var height = $(document.body).height() - heightMargin;
        var width = $(document.body).width() - widthMargin;

        height = height < minHeight ? minHeight : height;
        width = width < minWidth ? minWidth : width;

        $(this).datagrid('resize', {
            height: height*0.996,
            width: width*0.996
        });

    }
});
// 第一次加载时自动变化大小
    $(m_DatagridId).resizeDataGrid(0, 0, 460, 700);
    // 当窗口大小发生变化时，调整DataGrid的大小
    $(window).resize(function () {
        //$(m_DatagridId).resizeDataGrid(0, 0, 460, 700);
    }); 

*/



/***********************************************************************
 *  付款待办任务列表设置
 *  DLY
 *  2014-05-24
 */ 
$(function () { 
    // 当窗口大小发生变化时，调整DataGrid的大小
    $(window).resize(function () {
        //根据index.html页面的高度设置选项卡大小 
        $(rwzx).tabs('resize', {
            width: $(document.body).width(),
            height: getcurheight()
        });

        //根据index.html页面的高度设置列表高度 
        $(m_DatagridId).datagrid('resize', {
            width: $(document.body).width() * 0.997,
            height: getcurheight()
        });

    });
     
    //基础数据获取
    var TaskTypesid = peoa_GetBDFID(2);//流程类型  
    var cons = ' AND CT1_FatherID = \'' + TaskTypesid + '\'';
    var orderby = ' ORDER BY CT1_KeyName '
    m_TaskTypes = basedata_getBDCommon('gbd12', cons, orderby);

    //任务类型
    $('#cxTaskType').combobox({
        panelWidth: "140",
        panelHeight: "100",
        editable: false,
        multiple: false,
        valueField: 'ct1_code',
        textField: 'ct1_codename',
        data: m_TaskTypes
    });  

    //m_TaskTypes = basedata_getBDX('gbd2', basedata_getCommonData('CONOT')
    //    , basedata_getCommonData('DIVI'), '2', '启用', 'BDType', 'TaskType', '', 'CT1_KeyName');
    //$('#cxTaskType').combobox('loadData', m_TaskTypes);
	
	//设置待办任务列表
    $(m_DatagridId).datagrid({
		//title:'待办任务',
		//iconCls:'icon-save',
		width:document.body.clientWidth*0.987,
		height: getcurheight(),
	    //url:'datagrid_data1.json',
		nowrap: true,
		striped: false,
		collapsible:true,
		//sortName: 'sid',
		//sortOrder: 'asc',
		remoteSort: false,
		idField: 'sid',
		singleSelect:false,
		frozenColumns:[[ 
		     { field:'ck',checkbox:true }
		]],
		columns: [[
            { field: 'sid', title: 'sid', width: 30, hidden: true },
		    { field: 'wt1_id', title: 'wt1_id', width: 50, hidden: true },
		    { field: 'wt1_cono', title: '公司', width: 50 },
		    {
		        field: 'wr1_wi1_workflowcode', title: '流程类别', width: 130
		        , formatter: function (val) { return basedata_getCodename(m_TaskTypes, val, 'ct1_code', 'ct1_codename'); }
		    },
		    { field: 'wt1_divi', title: 'wt1_divi', width: 50, hidden: true },
		    { field: 'wt1_wr1_id', title: 'wt1_wr1_id', width: 50, hidden: true },
		    { field: 'wt1_seq', title: 'wt1_seq', width: 50, hidden: true },
		    { field: 'wr1_entityid', title: 'wt1_entityid', width: 50, hidden: true },
		    { field: 'wr1_entitycode', title: '申购单号', width: 125 },
		    { field: 'wr1_deptid', title: '部门id', width: 100, hidden: true },
		    { field: 'wr1_deptid1', title: '事业部id', width: 100, hidden: true },
		    { field: 'wr1_deptname', title: '部门名称', width: 100 },
		    { field: 'wr1_centercode', title: '成本中心', width: 70 },
		    { field: 'wr1_applyper', title: '申请人', width: 70 },
		    { field: 'wr1_applyamount', title: '申请总金额', width: 100, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum(val); } },
		    { field: 'wr1_sureamount', title: '确认总金额', width: 100, align: "right"
			    , formatter: function (val) { return dataUtil_formatNum(val); } },
		    { field: 'wr1_applydt', title: '申请日期', width: 80 },
		    { field: 'wt1_wf3_currfunccode', title: '当前环节ID', width: 100, hidden: true },
		    { field: 'wt1_wf3_currfuncname', title: '当前环节', width: 130 }, 
		    { field: 'wt1_lastcurrfunccode', title: '上一环节ID', width: 100, hidden: true },
		    { field: 'wt1_state', title: '任务状态', width: 100, hidden: true },
		    { field: 'wt1_rgdt', title: '提交时间', width: 105 },
		    { field: 'wt1_rguser', title: '提交人', width: 65 },
		    { field: 'wt1_lmdt', title: '修改时间', width: 105, hidden: true },
		    { field: 'wt1_lmuser', title: '修改人', width: 100, hidden: true },
		    { field: 'wt1_ckdt', title: '执行时间', width: 105, hidden: true },
		    { field: 'wt1_cuser', title: '执行人', width: 100, hidden: true }
		]],
		pagination:false,
		rownumbers:true, 
		toolbar:'#dbrwcxk',
		onRowContextMenu:onRowContextMenu,
		onDblClickRow: function (rowIndex, rowData) {
            //双击先取消所以选中行，再选中当前行进行相关操作
		    $(m_DatagridId).datagrid('clearSelections');
		    $(m_DatagridId).datagrid('selectRow', rowIndex);
		    view('actdjmx');
		},
		onClickRow: function (rowIndex) { 

		} 
	}); 
	
	//设置查询分页控件  
	//pager.pagination("options")
	//对象如下：total | pageSize | pageNumber | pageList | loading | buttons | showPageList | showRefresh | onSelectPage 
	//| onBeforeRefresh | onRefresh | onChangePageSize | beforePageText | afterPageText | displayMsg | 
	 
   $('#cxpager').pagination({  
	   total:0,
	   pageNumber:1,
       pageSize: m_PageSize,//每页显示的记录条数，默认为10  
       pageList: [20,100,200],//可以设置每页记录条数的列表  
       showPageList: false, //不显示每页记录数列表
       beforePageText: '第',//页数文本框前显示的汉字  
       afterPageText: '页    共 {pages} 页',  
       displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',
       exportExcel: false,
       onBeforeRefresh: function () {
       },
       onSelectPage: function (pageNumber, pageSize) {
           actLoadData(pageNumber, pageSize);
       },
       buttons: [{
                text: '单据明细',
                iconCls: 'icon-edit',
                handler: function () {
                    view('actdjmx');
                }
            }, '-', {
                text:'批量审批',
			    iconCls:'icon-ok',
			    handler:function(){ 				
			        var rowData = $(m_DatagridId).datagrid('getSelections');
			        if(rowData.length>0){
			            var rowDataT = [];
			            var billsStr = ''; //可审批单据
			            var billsStr1 = ''; //不可审批单据 
			            var n = 0;
			            for(var i=0; i<rowData.length; i++){  
			                if (rowData[i].wt1_wf3_currfunccode == 'F01-SGDTX' || rowData[i].wt1_wf3_currfunccode == 'F02-XXZYSH'
                                || rowData[i].wt1_wf3_currfunccode == 'F06-CGJLSH') {
			                    billsStr1 = billsStr1 + rowData[i].wr1_entitycode + ';<br>';
			                    n = n*1 + 1;
			                }else{
			                    billsStr = billsStr + rowData[i].wr1_entitycode + ';<br>';
			                    rowDataT.push(rowData[i]);
			                } 
			            }  
			            if(n>0){
			                $.messager.alert('提示框','不允许批量审批“申请人， 信息专员， 采购经理环节”的单据，共<font color="red">'
                                    + n + '</font>条：<br> <br> <font color="red">' + billsStr1 + '</font>  以上单据需单独打开明细页面处理！', "info"
                                    ,function () { 
                                        if(n < rowData.length){ 
                                            var str = '继续批量审批其余单据吗？ 共<font color="red">' + (rowData.length - n) + '</font>条：<br> <br>  ' + billsStr;
                                            $.messager.confirm('确认框',str,function(r){   
                                                if (r){    
                                                    var res = actPLSP(rowDataT);	 
                                                    actLoadData(m_PageNumber, m_PageSize);
                                                    if(res[0] == 'OK'){
                                                        alert('批量审批成功！\r\n'+res[1]);
                                                    }else if(res[0] == 'ERROR'){
                                                        alert(res[1]);
                                                        $(m_DatagridId).datagrid('selectRecord', res[2]);
                                                    }; 
												
                                                }    
                                            });   
                                        }  
                                    }); 
			            }else if(n==0){
			                var str = '确认批量审批如下单据吗？ 共<font color="red">' + rowData.length + '</font>条： <br> <br> ' + billsStr;
			                $.messager.confirm('确认框',str,function(r){   
			                    if (r){    
			                        var res = actPLSP(rowDataT); 
			                        actLoadData(m_PageNumber, m_PageSize);
			                        if(res[0] == 'OK'){
			                            alert('批量审批成功！\r\n'+res[1]);
			                        }else if(res[0] == 'ERROR'){
			                            alert(res[1]);
			                            $(m_DatagridId).datagrid('selectRecord', res[2]);
			                        }; 
								
			                    }    
			                });   
			            }   
			        }else{
			            alert('至少选择一条记录，方可审批！');
			        } 
			    }
		}]
    	   
   });  
     
   var mdepts = '\'-2\'';;
    //初始化条件
   for (var i = 0; i < m_UserInfo.roles.length; i++) {
       var authorization_id = m_UserInfo.roles[i].authorization_id;
        var authorization_text = m_UserInfo.roles[i].authorization_name;
        if (authorization_id == peoa_GetActorID(1)) { //申请人
            m_Filter = m_Filter + ' OR (WF3_MDM_AdID = \'' + authorization_id + '\'  AND wr1_applyper=\'' + m_UserInfo.UserName + '\')';
        } else if (authorization_id == peoa_GetActorID(2)) { //部门长  
           var mdepts1 = basedata_getMDeptCodes(m_UserInfo.empCode) + mdepts;
           m_Filter = m_Filter + ' OR (WF3_MDM_AdID = \'' + authorization_id + '\' AND WR1_DeptID  in (' + mdepts1 + '))';
        } else if (authorization_id == peoa_GetActorID(3)) { //事业部部门长 
            var mdepts2 = basedata_getMDeptCodes(m_UserInfo.empCode) + mdepts;
           m_Filter = m_Filter + ' OR (WF3_MDM_AdID = \'' + authorization_id + '\' AND WR1_DeptID1 in (' + mdepts2 + '))';
        } else if (authorization_id == peoa_GetActorID(12)) { //综合管理部负责人
            var morgs = basedata_getOrgsByZHGLBEmpID(m_UserInfo.empCode, ''); 
            m_Filter = m_Filter + ' OR (WF3_MDM_AdID = \'' + authorization_id + '\' AND OZ1_ComCode1 in (' + morgs + '))';
        } else if (authorization_id == peoa_GetActorID(7)) { //财务总监
            var myyorgid = peoa_GetOrgID(1); 
            var mqtcwbid = peoa_GetOrgID(3);
            if (m_UserInfo.empCode == '1412188') { // 高晓红
                m_Filter = m_Filter + ' OR (WF3_MDM_AdID = \'' + authorization_id
                    + '\' AND OZ1_ComCode1 = \'' + myyorgid + '\' AND WR1_DeptID1 not in (\'' + mqtcwbid + '\'))';
            } else {
                m_Filter = m_Filter + ' OR (WF3_MDM_AdID = \'' + authorization_id
                    + '\' AND (OZ1_ComCode1 not in (\'' + myyorgid
                    + '\') OR WR1_DeptID1 = \'' + mqtcwbid + '\' ))';
            }
        } else {
           m_Filter = m_Filter + ' OR (WF3_MDM_AdID = \'' + authorization_id + '\')';
       } 
   }
   if (m_Filter != '') {
       m_Filter = ' AND ( 2=1  ' + m_Filter + ' )';
   } 
   //alert(m_Filter);
   searchByCons();

    //选项卡绑定事件 
   basedata_bindTabEvent(m_TabsId, '#tabs-mm');
   basedata_bindTabMenuEvent(m_TabsId, '#tabs-mm');
});


/***********************************************************************
 *  打开待办任务明细
 *  DLY
 *  2014-05-24
 */ 
function addTab(title, url) {
	var content = '未实现';
	if ($(m_TabsId).tabs('exists', title)) {
	    $(m_TabsId).tabs('select', title);
	} else { 
		var h = window.screen.height-20;
		h = 460; 
		if (url) {
		    content = '<iframe frameborder="0"  src="'
		        + url + '" style="overflow:hidden;width:100%;height:' + h + 'px;"></iframe>';
		} else {
			content = '未实现';
		} 
		$(m_TabsId).tabs('add', {
			title : title,
			content : content,
			closable : true
		});
	}
}



/***********************************************************************
 *  清除按钮事件：清除查询条件
 *  DLY
 *  2014-05-24
 */ 
function clearText()  { 
    $('#cxTaskType').combobox('setValue', '');
    $('#cxDeptName').attr('value', '');
    $('#cxAppPer').attr('value', '');
    $('#cxCostCenter').attr('value', '');
    $('#cxBillCode').attr('value', '');
    $('#cxAppDate').attr('value', '');
    $('#cxCurrfuncname').attr('value', '');
}

/***********************************************************************
 *  查询按钮事件：根据条件查询
 *  DLY
 *  2014-05-24
 */ 
function searchByCons() { 
    m_PageNumber = 1; 
    var cfilter1 = 'AND wr1_state = \'stStarted\'';
    var cfilter2 = 'AND wt1_state = \'stStarted\'';
    if ($('#cxTaskType').combobox('getValue') != '') {
        cfilter1 = cfilter1 + ' AND wr1_wi1_workflowcode = \'' + $('#cxTaskType').combobox('getValue') + '\'';
    }
    if ($('#cxDeptName').attr('value') != '') {
        cfilter1 = cfilter1 + ' AND wr1_deptname LIKE \'%' + $('#cxDeptName').attr('value') + '%\'';
    }
    if ($('#cxAppPer').attr('value') != '') {
        cfilter1 = cfilter1 + ' AND wr1_applyper LIKE \'%' + $('#cxAppPer').attr('value') + '%\'';
    }
    if ($('#cxCostCenter').attr('value') != '') {
        cfilter1 = cfilter1 + ' AND wr1_centercode LIKE \'%' + $('#cxCostCenter').attr('value') + '%\'';
    }
	if($('#cxBillCode').attr('value')!=''){
	    cfilter1 = cfilter1 + ' AND wr1_entitycode LIKE \'%' + $('#cxBillCode').attr('value') + '%\'';
	}
	if ($('#cxAppDate').attr('value') != '') {
	    cfilter1 = cfilter1 + ' AND  convert(varchar(10),wr1_applydt,120) LIKE \'' + $('#cxAppDate').attr('value') + '%\'';
	}
	if ($('#cxCurrfuncname').attr('value') != '') {
	    cfilter2 = cfilter2 + ' AND wt1_wf3_currfuncname LIKE \'%' + $('#cxCurrfuncname').attr('value') + '%\'';
	}
	m_Filter1 = cfilter1;
	m_Filter2 = cfilter2;
	//alert(m_Filter1);
	actLoadData(m_PageNumber, m_PageSize); 
}


 
/***********************************************************************
 *  刷新待办任务列表数据
 *  DLY
 *  2014-05-24
 */ 
function   actLoadData(page,number)   {   
    var totalCount = 0;
    m_PageNumber = page;
    m_PageSize = number;
    var cXML = '<Page>' + m_PageNumber + '</Page><Num>' + m_PageSize + '</Num>'
             + '<Cons1>' + m_Filter1 + '</Cons1>'
             + '<Cons2>' + m_Filter2 + '</Cons2>'
             + '<Cons3>' + m_Filter + '</Cons3><OrderBy>' + m_OrderBy + '</OrderBy>' 
	cXML = basedata_addROOT(cXML);
	//alert(cXML);
	var curl = GetWSRRURL(peoa_GetWSRRURL(1)) + "&type=GetWFTList&XML=" + encodeURIComponent(cXML); //拼接url	
	$.ajax({
	    url: curl,
	    type: "GET",
	    async: true,
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function (data) {    
	        //alert(jsonUtil_jsonToStr(data)); 
	        $(m_DatagridId).datagrid('clearSelections');
	        if (data && data.rows) {
	            if (dataUtil_undefinedOrNull(data.rows[0].totalnum, 0) == 0) {
	                $(m_DatagridId).datagrid('loadData', []);
	                totalCount = 0;
	            } else {
	                $(m_DatagridId).datagrid('loadData', data.rows);
	                totalCount = dataUtil_undefinedOrNull(data.rows[0].totalnum, 0);
	            }
	        }
	    }
	})
	$('#cxpager').pagination({
		total:totalCount,
		pageNumber:page
	});  
} 


/***********************************************************************
 *  根据title关闭选项卡
 *  DLY
 *  2014-06-04
 */ 
function closeTab(title) {  
	//alert(title);
    $(m_TabsId).tabs('close', title);
    actLoadData(m_PageNumber,m_PageSize);  
}

  

/***********************************************************************
 *  添加右击菜单内容
 *  DLY
 *  2014-06-04
 */ 
function onRowContextMenu(e, rowIndex, rowData){ 
   e.preventDefault();  
   var rows = $(m_DatagridId).datagrid('getSelections');
   if (rows == null || rows.length == 0) {
       alert('请先选择一条记录！');
       return false;
   }
   if (rows.length > 1) {
       alert('请只选择一行记录，方可查看！');
       return false;
   }
   if (rows.length == 1) {
	   $('#mm').menu('show', {
	        left:e.pageX,
	        top:e.pageY
	   });  
   }
   
}
 

/***********************************************************************
 *  查看单据明细/单据审批历史/单据驳回历史
 *  DLY
 *  2014-06-04
 */ 
function view(act){   
    if (act == 'actdjmx') {
        var rows = $(m_DatagridId).datagrid('getSelections');
        if (rows == null || rows.length == 0) {
            alert('请先选择一条记录！');
            return false;
        }
        if (rows.length > 1) {
            alert('请只选择一行记录，方可查看！');
            return false;
        }
        var rowData = $(m_DatagridId).datagrid('getSelected');
        var title = basedata_getCodename(m_TaskTypes, rowData.wr1_wi1_workflowcode, 'ct1_code', 'ct1_fieldvalues1');
        var curl = '';
        title = title + rowData.wr1_entitycode;
        curl = basedata_getCodename(m_TaskTypes, rowData.wr1_wi1_workflowcode, 'ct1_code', 'ct1_fieldvalues2')
             +'?&type=task&v0='+ rowData.wr1_entitycode + '&v1=' + rowData.wt1_id
             + '&v2=' + rowData.wt1_wf3_currfunccode;
        //alert(curl);
        addTab(title, curl);

    } else { 
        var rowData = $(m_DatagridId).datagrid('getSelected');
        var flowHis = [];
        var cXML = '<Page>' + '1' + '</Page><Num>' + '100' + '</Num>'
         + '<Cons1> AND WT1_WR1_ID =\'' + rowData.wt1_wr1_id + '\'</Cons1>'
         + '<Cons2></Cons2><Cons3>GetWFTHisListByWFID</Cons3>'
         + '<OrderBy>ORDER BY CONVERT(VARCHAR(20),WT1_RgDt,120) ASC</OrderBy>'
        cXML = basedata_addROOT(cXML);
        //alert(cXML);
        var curl = GetWSRRURL(peoa_GetWSRRURL(1)) + "&type=GetWFTHisList&XML=" + encodeURIComponent(cXML); //拼接url	
        $.ajax({
            url: curl,
            type: "GET",
            async: false,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                //alert(jsonUtil_jsonToStr(data)); 
                if (data && data.rows) {
                    flowHis = data.rows;
                }
            }
        })
        if (act == 'actspls') { 
            if(rowData){ 
                $('#flowHistoryInfo').dialog({
                    title:'审批历史',  
                    width:460,
                    height:180, 
                    left:event.clientX-20,
                    top:event.clientY-40
                });

                var itextc = '单据编号：' + rowData.wr1_entitycode + '\n\n';
                var itext = '';
                for (var i = 0; i < flowHis.length; i++) {
                    if (flowHis[i].wt1_rejectreason != '') {
                        itext = itext + flowHis[i].wt1_wf3_currfuncname + '(驳回)   ' + flowHis[i].wt1_ckdt + '\n';
                    }else{ 
                        itext = itext + flowHis[i].wt1_wf3_currfuncname + '   ' + flowHis[i].wt1_ckdt + '\n';
                    }  
                }
                document.getElementById('flowHistoryInfoSpanC').innerText = itextc;
                document.getElementById('flowHistoryInfoSpan').innerText = itext;
                $('#flowHistoryInfo').dialog('open');
            }else{
                alert('请先选择一条记录！');
            }   
        } else if (act == 'actbhls') {
            if (rowData) {
                $('#flowHistoryInfo').dialog({
                    title: '驳回历史',
                    width: 460,
                    height: 180,
                    left: event.clientX - 20,
                    top: event.clientY - 70
                });

                var itextc = '单据编号：' + rowData.wr1_entitycode + '\n\n';
                var itext = '';
                for (var i = 0; i < flowHis.length; i++) {
                    if (flowHis[i].wt1_rejectreason != '') {
                        itext = itext + flowHis[i].wt1_wf3_currfuncname + '(驳回)   ' + flowHis[i].wt1_ckdt + '\n'
                              + flowHis[i].wt1_rejectreason + '   ' + '\n\n';
                    }
                }
                for (var i = 0; i < flowHis.length; i++) {
                    itext = itext   + '  '
                
                }
                document.getElementById('flowHistoryInfoSpanC').innerText = itextc;
                document.getElementById('flowHistoryInfoSpan').innerText = itext;
                $('#flowHistoryInfo').dialog('open');
            } else {
                alert('请先选择一条记录！');
            }
        }
    }
}
 

/***********************************************************************
 *  批量审批
 *  DLY
 *  2014-06-04
 */ 
function actPLSP(rowData)  {
    var res = [];
    var str = '已成功处理单据如下:\r\n     ';
    for (var i = 0; i < rowData.length; i++) {
        var taskInfo = [{ "ActType": "Y" }];
        taskInfo[0].ID = rowData[i].wr1_entityid;
        taskInfo[0].TaskID = rowData[i].wt1_id;
        taskInfo[0].CONO = rowData[i].wt1_cono;
        taskInfo[0].DIVI = rowData[i].wt1_divi;
        taskInfo[0].RejectFlag = '';
        taskInfo[0].RejectCode = '';
        taskInfo[0].RejectInfo = '';
        var cXML = GetEditJson(taskInfo, [], []); //json转xml     
        var curl = '';
        if (rowData[i].wr1_wi1_workflowcode == 'FA-GDZCSGD') {
            curl = GetWSRRURL(peoa_GetWSRRURL(3)) + "&type=FlowOut&actor=" + encodeURIComponent(m_UserInfo.UserName); //拼接url
        } else if (rowData[i].wr1_wi1_workflowcode == 'LV-DZYHPSGD') { 
            curl = GetWSRRURL(peoa_GetWSRRURL(15)) + "&type=FlowOut&actor=" + encodeURIComponent(m_UserInfo.UserName); //拼接url
        } 
        if (curl == '') {
            alert('表单编号：' + rowData[i].wr1_entitycode + '未设置批量审批curl，请截图与管理人员联系!');
            res.push('ERROR');
            res.push(str);
            res.push(rowData[i].id);
        }
            
        var cxmlsJson = { XML: cXML };
        $.ajax({
            url: curl,
            type: "POST",
            async: false,
            data: cxmlsJson,
            //contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                if (data && data.rows) {
                    if (dataUtil_undefinedOrNull(data.rows[0].taskid, '') != '') {
                        str = str + rowData[i].wr1_entitycode + ';  ';
                    } else {
                        alert('表单编号：' + rowData[i].wr1_entitycode + '流程提交失败，请截图与管理人员联系!');
                        res.push('ERROR');
                        res.push(str);
                        res.push(rowData[i].id);
                        return res;
                    }
                }
            }
        })
    }
    res.push('OK');
    res.push(str);
    res.push('');
    return res; 
    
}
 

/*******************
* 获取列表高度
*/
function getcurheight() {
    var htjcxk = document.getElementById("dbrwcxk").style.height.replace('px', '');
    var curheight = parent.getTabsHeight() * 1 - htjcxk * 1 + 50;
    return curheight;
}

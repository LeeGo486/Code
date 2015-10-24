//组织树ID
var m_treeID = '#tree_dept'; 
var m_DatagridID1 = '#configlb';
var m_LastIndex1 = -1;

 //状态下拉选择
var m_States = [{text:'启用'},{text:'禁用'}];
var m_OrgTypes = [{ text: '公司' }, { text: '部门' }];  
var m_depttree = []; //组织架构树
 
 //用户信息
 var m_UserInfo = basedata_getUserInfo();
 

 //全局标志
 var m_dlgFlag = '';
 var m_selected_tree_node;

 // 过滤条件
 var m_Filter = '';  //主的条件
 var m_Filter1 = ''; //查询条件
 var m_OrderBy = ' EE1_EmpCode '; //排序方式

 /***********************************************************************
  *  初始化
  *  DLY 
  */ 
 $(function () { 
    env_Click();
 }); 
 
  
 function env_Click() {
     var cXML = '<Page>0</Page><Num>0</Num>'
                       + '<Cons> </Cons><OrderBy></OrderBy>'
     cXML = basedata_addROOT(cXML);
     //alert(cXML);	
     var curl = GetTreeWSRRURL(peoa_GetWSRRURL(11), undefined, '1', "1")
             + "&MenuCodeContains=0&type=GetORGTree&XML=" + encodeURIComponent(cXML)
             + "&s=" + new Date().getTime();  //拼接url   
     $(m_treeID).tree({
         url: curl, 
         onDblClick: function (node) {
             m_selected_tree_node = node;
             edit_Tree(true);
         },
         onContextMenu: function (e, node) {//右击
             tree_onContextMenu(e, node);
         }
     });  
 }


 function tree_onContextMenu(e, node) {
     e.preventDefault();
     $(m_treeID).tree('select', node.target);
     m_selected_tree_node = node;
     if (node.attributes.OZ1_OrgType == '公司') {
         $('#SSGS').show(); //所属公司按钮可见
         $('#QTPZ').show(); //其他配置按钮可见
     } else {
         $('#SSGS').show(); //所属公司按钮可见
         $('#QTPZ').show(); //其他配置按钮可见
     }
     $('#Menu_Tree').menu('show', {
         left: e.pageX,
         top: e.pageY
     }); 
 } 


/***********************************************************************
 *  ture 编辑  --- false 添加
 *  DLY 
 */
 function edit_Tree(bIsEdit) {

     //首次打开加载控件数据
     if (m_dlgFlag == '') {
         $('#txtOrgType').combobox({
             panelWidth: "125",
             panelHeight: "80",
             editable: false,
             multiple: false,
             valueField: 'text',
             textField: 'text',
             data: m_OrgTypes
         });
         $('#txtState').combobox({
             panelWidth: "125",
             panelHeight: "80",
             editable: false,
             multiple: false,
             valueField: 'text',
             textField: 'text',
             data: m_States
         });
         m_dlgFlag = 'opened';
     } 

     var node = m_selected_tree_node;
     if (bIsEdit) {//编辑
         if (node.id == "-1") {
             $.messager.alert("消息框", "根目录不能编辑", '');
             return false;
         } 
         $('#txtID').val(node.attributes.OZ1_ID); 
         $('#txtFatherID').val(node.attributes.OZ1_FatherIdT);
         $('#txtOrgCode').val(node.id);
         $('#txtOrgName').val(node.text);
         $('#txtCom1').val(node.attributes.OZ1_Com1);
         $('#txtComCode1').val(node.attributes.OZ1_ComCode1);
         $('#txtCostCenter').val(node.attributes.OZ1_CostCenterCode2);
         $('#txtDManager').val(node.attributes.OZ1_DepartmentManager);
         $('#txtOrgCodeSYB').val(node.attributes.OZ1_MDeptCode);
         $('#txtState').combobox('setValue', node.attributes.OZ1_State);
         $('#txtOrgType').combobox('setValue', node.attributes.OZ1_OrgType);

         $('#txtOrgName').focus();
         $('#divEditTrue').dialog({
             modal: true,
             title: "部门编辑"
         });
     }
     else { 
         //$('#txtID').val(dataUtil_NewGuid());
         $('#txtID').val('');
         $('#txtFatherID').val(node.id);
         $('#txtOrgCode').val(dateUtil_dateFomaterD(new Date()));
         $('#txtOrgName').val('');
         $('#txtCom1').val('');
         $('#txtComCode1').val('');
         $('#txtCostCenter').val('');
         $('#txtDManager').val('');
         $('#txtOrgCodeSYB').val('');
         $('#txtState').combobox('setValue', '启用');
         $('#txtOrgType').combobox('setValue', '部门');

         $('#txtOrgName').focus(); 
         $('#divEditTrue').dialog({
             modal: true,
             title: "添加部门"
         }); 
     } 
     $('#divEditTrue').dialog('open');
 }
 

 /***********************************************************************
  *  删除
  *  DLY 
  */
 function delete_Tree() {
     var node = m_selected_tree_node;  
     if (!node) {
         alert('请选择一个节点！');
         return false;
     }  
     if (!($(m_treeID).tree('isLeaf', node.target))) {
         alert('该节点存在子节点，不可删除！');
         return false;
     } 
     $.messager.confirm('提示框', '你确定"' + node.text + '"删除吗?', function (r) {
         if (r) {      
             var curl = GetWSRRURL(peoa_GetWSRRURL(11));
             curl = curl + "&type=DelDept&actor=" + m_UserInfo.UserName; 
             var row = {oz1_id: node.attributes.OZ1_ID };
             var rowInfo = [];
             rowInfo.push(row);
             var cXML = GetEditJson(rowInfo, [], []); //json转xml  
             var cxmlsJson = { XML: cXML };
             $.ajax({
                 url: curl,
                 type: "POST",
                 async: false,
                 data: cxmlsJson,
                 dataType: "json",
                 success: function (result) {
                     try {
                         //alert(jsonUtil_jsonToStr(result));
                         if (result.Error) {
                             $.messager.alert("系统错误", result.Error, 'error');
                         } else if (result.rows[0].result == "False") {
                             $.messager.alert("提示", result.rows[0].message, 'error');
                         } else if (result.rows[0].result == "True") {
                             //回写信息  
                             $(m_treeID).tree('remove', node.target);
                             alert("删除成功！");
                         }
                     } catch (ex) {
                         $.messager.alert("提示", ex, 'error');
                     }
                 },
                 error: function () { 
                     alert("删除失败！"); 
                 }
             });
              
         }
     })
 }

 
/***********************************************************************
 *  提交
 *  DLY 
 */
 function edit_Submnit() {
     var flag = 0;
     var rid = dataUtil_NewGuid();
     var curl = GetWSRRURL(peoa_GetWSRRURL(11));
     if ($('#txtID').val() == '') {
         flag = 1;
         curl = curl + "&type=NewDept&actor=" + m_UserInfo.UserName; 
     } else {
         rid = $('#txtID').val();
         curl = curl + "&type=UpdDept1&actor=" + m_UserInfo.UserName;
     }  
     var row = {};
     row.oz1_id = rid;
     row.oz1_fatherid = $('#txtFatherID').val(); 
     row.oz1_com1 = $('#txtCom1').val();
     row.oz1_comcode1 = $('#txtComCode1').val();
     row.oz1_orgcode= $('#txtOrgCode').val();
     row.oz1_orgname = $('#txtOrgName').val();
     row.oz1_costcentercode2 = $('#txtCostCenter').val();
     row.oz1_departmentmanager = $('#txtDManager').val();
     row.oz1_mdeptcode = $('#txtOrgCodeSYB').val();
     row.oz1_state = $('#txtState').combobox('getValue');
     row.oz1_orgtype = $('#txtOrgType').combobox('getValue'); 
     var rowInfo = [];
     rowInfo.push(row);
     var cXML = GetEditJson(rowInfo, [], []); //json转xml  
     //alert(cXML);
     var cxmlsJson = { XML: cXML };
     $.ajax({
         url: curl,
         type: "POST",
         async: false,
         data: cxmlsJson,
         dataType: "json",
         success: function (result) {
             try {
                 //alert(jsonUtil_jsonToStr(result));
                 if (result.Error) {
                     $.messager.alert("系统错误", result.Error, 'error');
                 } else if (result.rows[0].result == "False") {
                     $.messager.alert("提示", result.rows[0].message, 'error');
                 } else if (result.rows[0].result == "True") {
                     var node = m_selected_tree_node;
                     //回写  
                     if (flag == 1) {
                         $('#txtID').val(rid);
                         var datas = []
                         var node1 = {};
                         node1.attributes = {};
                         node1.attributes.OZ1_ID = $('#txtID').val();
                         node1.attributes.OZ1_FatherId = $('#txtFatherID').val();
                         node1.id = $('#txtOrgCode').val();
                         node1.text = $('#txtOrgName').val();
                         node1.attributes.OZ1_Com1 = $('#txtCom1').val();
                         node1.attributes.OZ1_ComCode1 = $('#txtComCode1').val();
                         node1.attributes.OZ1_CostCenterCode2 = $('#txtCostCenter').val();
                         node1.attributes.OZ1_DepartmentManager = $('#txtDManager').val();
                         node1.attributes.OZ1_MDeptCode = $('#txtOrgCodeSYB').val();
                         node1.attributes.OZ1_State = $('#txtState').combobox('getValue');
                         node1.attributes.OZ1_OrgType = $('#txtOrgType').combobox('getValue');
                         datas.push(node1);
                         $(m_treeID).tree('append', {
                             parent: node.target,
                             data: datas
                         });
                     } else {  
                         //node.attributes.OZ1_ID = $('#txtID').val();
                         //node.attributes.OZ1_FatherId = $('#txtFatherID').val();
                         //node.id = $('#txtOrgCode').val();
                         node.text = $('#txtOrgName').val();
                         node.attributes.OZ1_Com1 = $('#txtCom1').val();
                         node.attributes.OZ1_ComCode1 = $('#txtComCode1').val();
                         node.attributes.OZ1_CostCenterCode2 = $('#txtCostCenter').val();
                         node.attributes.OZ1_DepartmentManager = $('#txtDManager').val();
                         node.attributes.OZ1_MDeptCode = $('#txtOrgCodeSYB').val();
                         node.attributes.OZ1_State = $('#txtState').combobox('getValue');
                         node.attributes.OZ1_OrgType = $('#txtOrgType').combobox('getValue');  
                         $(m_treeID).tree('update', node);
                     }
                     alert("提交成功！");
                     $('#divEditTrue').dialog('close');
                 }
             } catch (ex) {
                 $.messager.alert("提示", ex, 'error');
             }
         },
         error: function () {
             alert("提交失败！"); 
         }
     });
 }
  

/***********************************************************************
 *  折叠或展开
 *  DLY 
 */
 function actArrowInOut(type) {
     if (type == 'in') { 
         $(m_treeID).tree('collapseAll');
     } else { 
         $(m_treeID).tree('expandAll');
     }
 }


 /***********************************************************************
  *  打开相关配置窗
  *  DLY 
  */
 function open_Config(ccode, cname) {
     if (dataUtil_undefinedOrNull(ccode, '') == '') {
         return false;
     } 

     $('#dlgconfig').dialog({
         modal: true,
         title: cname
     });
     $('#dlgconfig').dialog('open');

     //初始化配置列表
     if ($('#configflag').val() == '') { 
         cshConfiglb(); 
     }
     //加载数据
     $('#configflag').val(ccode); 
     actQuery1();
 }


 /***********************************************************************
   *  相关配置列表初始化
   *  DLY 
   */
 function cshConfiglb() { 
     $(m_DatagridID1).datagrid({
         //title:'列表', 
         //width: 500,
         height: 300,
         nowrap: true,
         striped: false,
         collapsible: true,
         sortName: 'ct1_code',
         sortOrder: 'asc',
         remoteSort: false,
         idField: 'ct1_id',
         frozenColumns: [[

         ]],
         columns: [[
             { field: 'ct1_id', title: 'ct1_id', width: 100, hidden: true },
             { field: 'ct1_fatherid', title: 'ct1_fatherid', width: 100, hidden: true },
             { field: 'ct1_cono', title: 'ct1_cono', width: 100, hidden: true },
             { field: 'ct1_divi', title: 'ct1_divi', width: 100, hidden: true },
             { field: 'ct1_code', title: '代码', width: 100, sortable: true, editor: 'text' },
             { field: 'ct1_codename', title: '名称', width: 200, sortable: true, editor: 'text' },
             {
                 field: 'ct1_state', title: '状态', width: 100, editor: {
                     type: 'combobox', options: {
                         valueField: 'text', textField: 'text',
                         editable: false, panelHeight: "70",
                         data: m_States
                     }
                 }
             }
         ]],
         pagination: false,
         rownumbers: true,
         singleSelect: true,
         onClickRow: function (rowIndex) {
             //结束前一次选中的行，自动调用onAfterEdit
             if (m_LastIndex1 != undefined) {
                 $(m_DatagridID1).datagrid('endEdit', m_LastIndex1);
             }
             $(m_DatagridID1).datagrid('selectRow', rowIndex);
             $(m_DatagridID1).datagrid('beginEdit', rowIndex);
             m_LastIndex1 = rowIndex;

         }, onAfterEdit: function (rowIndex, rowData, changes) {
             if (jsonUtil_jsonToStr(changes) != '{}') {
                 actSave1(rowData);
             }

         }
     });
 }


 /***********************************************************************
  *  添加配置
  *  DLY 
  */
 function actADD1() { 
     var node = m_selected_tree_node;
     if (!node) {
         return false;
     }
     $(m_DatagridID1).datagrid('endEdit', m_LastIndex1);
     $(m_DatagridID1).datagrid('appendRow', {
         ct1_id: '',
         ct1_fatherid: node.attributes.OZ1_ID,
         ct1_code: '',
         ct1_codename: '',
         ct1_state: '启用',
         ct1_fieldvalues1: $('#configflag').val(),
         ct1_cono: basedata_getCommonData('CONOT'),
         ct1_divi: basedata_getCommonData('DIVI')
     });
     m_LastIndex1 = $(m_DatagridID1).datagrid('getRows').length - 1;
     $(m_DatagridID1).datagrid('selectRow', m_LastIndex1);
     $(m_DatagridID1).datagrid('beginEdit', m_LastIndex1);
 }


 /***********************************************************************
  *  保存配置
  *  DLY 
  */
 function actSave1(updrow) {
     var flag = 0;
     if (updrow == undefined && m_LastIndex1 != undefined) {
         $(m_DatagridID1).datagrid('endEdit', m_LastIndex1);
     }

     if (updrow == undefined) {
         return false;
     }
     //保存操作      
     var curl = GetWSRRURL(peoa_GetWSRRURL(2));
     if (updrow.ct1_id == '') { //新增
         flag = 1;
         updrow.ct1_id = dataUtil_NewGuid();
         curl = curl + "&type=NewBMType&actor=" + m_UserInfo.UserName;
         updrow.ct1_rguser = m_UserInfo.UserName;
     } else { //修改
         curl = curl + "&type=UpdBMType&actor=" + m_UserInfo.UserName;
         updrow.ct1_lmdt = dateUtil_dateFomaterA(new Date(), '-');
         updrow.ct1_lmuser = m_UserInfo.UserName;
     }
     var billInfo = [];
     billInfo.push(updrow);
     var cXML = GetEditJson(billInfo, [], []); //json转xml  
     var cxmlsJson = { XML: cXML };
     $.ajax({
         url: curl,
         type: "POST",
         async: false,
         data: cxmlsJson,
         dataType: "json",
         success: function (result) {
             try {
                 //alert(jsonUtil_jsonToStr(result));
                 if (result.Error) {
                     $.messager.alert("系统错误", result.Error, 'error');
                 } else if (result.rows[0].result == "False") {
                     $.messager.alert("提示", result.rows[0].message, 'error');
                 } else if (result.rows[0].result == "True") {
                     //回写
                     actQuery1(); 
                     //$.messager.alert("提示", "保存成功！", 'error');
                 }
             } catch (ex) {
                 $.messager.alert("提示", ex, 'error');
             }
         },
         error: function () {  
             alert("保存失败！");
         }
     });
 }



 /***********************************************************************
  *  查询配置( 
  *  DLY 
  */
 function actQuery1() { 
     var node = m_selected_tree_node;
     if (!node) {
         return false;
     } 
     $(m_DatagridID1).datagrid('loadData', []);
     var cons = ' AND CT1_FatherID = \'' + node.attributes.OZ1_ID + '\'';
     var ccode = $('#configflag').val();
     cons = cons + ' AND CT1_FieldValues1 = \'' + ccode + '\''; 
     var res = basedata_getBDCommon('gbd12', cons); 
     if (res.length > 0 && res[0].ct1_id != '') { 
         $(m_DatagridID1).datagrid('loadData', res);
     }
 }
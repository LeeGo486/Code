 var m_DatagridID = '#ryxxlb'; //列表ID
 var m_LastIndex = -1;  //人员列表最后一次选中行下标
 var m_LastIndex1 = -1;  //关联部门列表最后一次选中行下标
 var m_PageNumber = 1;  //当前页码
 var m_PageSize = 10;  //每页显示行数
 
 //状态下拉选择
 var m_protimesZT = [ {statets:'启用',statevs:'启用'},{statets:'禁用',statevs:'禁用'} ];
 var m_depttree = []; //组织架构树
 
 //用户信息
 var m_UserInfo = parent.m_UserInfo;
 

 
 var m_pers = [];
 var m_employeestatus = [];

 /***********************************************************************
  *  初始化
  *  DLY 
  */ 
 $(function () {
     // 滚动条居顶
     parent.sc();

     //用户认证
     if (m_UserInfo == undefined || m_UserInfo.userName == undefined) {
         top.location.href = 'error.html';
         return;
     }
     setDatebox('#c_hiredate');
     setDatebox('#c_beginworkdate');
     setDatebox('#syqBegin');
     setDatebox('#syqEnd');
     
     
     //基础数据获取 
     var type1 = hr_getCodeType(1);// 员工状态  
     var types = '\'0\','+ '\''+type1+'\''; 
     var row = { c_typecode: types };
     var codeitems = hr_getCodeItems(row);
     for (var i = 0; i < codeitems.length; i++) { 
         var t1 = codeitems[i].c_typecode.toUpperCase();
         if (t1 == type1.toUpperCase()) {
             m_employeestatus.push(codeitems[i]);
         } 
      }
      // 初始化查询
      setDataGrid();
      searchByCons();

      
 }); 
 
 
/***********************************************************************
  *  加载数据
  *  DLY 
  */ 
 function   actLoadData(page,number)   {   
    var totalCount = 0;
    $(m_DatagridID).datagrid('loadData', []);
    var rows = [];
    for (var i = 0; i < m_pers.length; i++) {
        if (i >= (page - 1) * number && i < page * number) {  
            rows.push(m_pers[i]);
        }
    }
    
    totalCount = m_pers.length;
    $(m_DatagridID).datagrid('loadData', rows);
    $(m_DatagridID).datagrid('clearSelections');
     
 	$('#cxpager').pagination({
 		total:totalCount,
 		pageNumber:page
 	});   
	m_PageNumber = page;
	m_PageSize = number;
 } 

 
/***********************************************************************
 *  获取条件查询
 *  DLY 
 */ 
function searchByCons() { 
    var row = { type: '2', c_employeestatus: '', c_orgunitid: '492674' };
    m_pers = hr_getShopPers(row);  
	actLoadData(1, m_PageSize);
} 
  
 
/***********************************************************************
 *  验证身份证号码
 *  DLY 
 */
function checkIdCard(id) {
    $('#c_birthday').val('');
    $('#c_age').val(''); 
    if (id != '' && idcard_check(id)) {
        var birthday = idcard_getBirthDay(id, '-');
        if (birthday != '') {
            var curyear = (new Date()).getFullYear(); 
            var age = 1 * curyear - birthday.substring(0, 4)+1;
            $('#c_birthday').val(birthday);
            $('#c_age').val(age);
        }
    } 
}


/***********************************************************************
 *  设置日期控件
 *  DLY 
 */
function setDatebox(field) { 
    $(field).datebox({
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
}


 
/***********************************************************************
 *  设置员工信息
 *  DLY 
 */
function setInfo(type, data) {  
    if (type == 'new') { 
        $('form').find('input').prop('value', '');
    } else if (type == 'old') { 
        $('form').find('input').prop("readonly", true);
    }
}
  
/***********************************************************************
 *  获取操作人信息
 *  DLY 
 */
function basedata_getUserInfo() { 
    var userInfo = '';
    //登陆验证
    $.ajax({
        url: GetLoginNameURL(),
        type: "GET", 
        async: false,
        success: function (data) {
            //alert(data);
            if (eval("[" + data + "]")[0].Error) {
                $.messager.alert("出错了", eval("[" + data + "]")[0].Error, 'error');
                window.location.href = "login.html";
                top.location.href = '/WEB/PE_OA/Login/login.html';
                return;
            } 
            userInfo = eval("(" + data + ")"); 
             
            //获取权限组
            $.ajax({
                url: GetWSRRURL(peoa_GetWSRRURL(9)), //88ba3fe2-139b-4075-add5-c79b50d1df95
                type: "GET",
                async: false,
                success: function (data) {
                    //alert(data);
                    if (eval("[" + data + "]")[0].Error) {
                        $.messager.alert("出错了", eval("[" + data + "]")[0].Error, 'error');
                        top.location.href = '/WEB/PE_OA/Login/login.html';
                        return;
                    }
                    var data1 = eval("(" + data + ")");
                    userInfo.roles = data1.rows;
                }
            });
           
            //获取员工编号 
            var cXML = '<Page>1</Page><Num>1</Num>'
                      + '<Cons> AND EE1_EmpName = \'' + userInfo.UserName + '\'</Cons><OrderBy></OrderBy>'
            cXML = basedata_addROOT(cXML);
            //alert(cXML);	
            var curl = GetWSRRURL(peoa_GetWSRRURL(4))
                    + "&type=GetEmpsByCons&XML=" + encodeURIComponent(cXML)
                    + "&s=" + new Date().getTime();  //拼接url  
            $.ajax({
                url: curl,
                type: "GET",
                async: false,
                success: function (data) {
                    if (eval("[" + data + "]")[0].Error) {
                        $.messager.alert("出错了", eval("[" + data + "]")[0].Error, 'error');
                        top.location.href = '/WEB/PE_OA/Login/login.html';
                        return;
                    }
                    var data1 = eval("(" + data + ")");
                    if (data1.rows && data1.rows.length > 0
                        && data1.rows[0].ee1_empcode && data1.rows[0].ee1_empcode != '') {
                        userInfo.empCode = data1.rows[0].ee1_empcode; //员工号
                        userInfo.empCodeCH = data1.rows[0].ee1_empcodech; //姓名
                    } else {
                        //$.messager.alert("系统提示", '您好，系统未设置您的“员工编号”等信息，<br> 请先联系管理员, 以免影响系统操作！', 'error');
                        alert('您好，系统未设置您的“员工编号”等信息，\n 请先联系管理员, 以免影响系统操作！');
                        //top.location.href = '/WEB/PE_OA/Login/login.html';
                        return;
                    }
                }
            }); 
             
            
        }
    }); 
    return userInfo;
}


/***********************************************************************
 *  获取操作人作为部门长的部门
 *  DLY 
 */
function basedata_getMDeptCodes(empcode) {
    var mdepts = '';
    var cons = 'AND OZ1_DepartmentManager = \'' + empcode + '\'';
    var cXML = '<Page>0</Page><Num>0</Num>'
              + '<Cons>' + cons + '</Cons><OrderBy></OrderBy>'
    cXML = basedata_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(11))
            + "&type=GetORGTree&XML=" + encodeURIComponent(cXML)
            + "&s=" + new Date().getTime();  //拼接url   
    $.ajax({
        url: curl,
        options: "JSON",
        async: false,
        success: function (data) {
            //alert(data);
            if (eval("[" + data + "]")[0].Error) {
                $.messager.alert("出错了", eval("[" + data + "]")[0].Error, 'error');
                window.location.href = "login.html";
                return;
            }
            var data1 = eval("(" + data + ")");
            var depts = data1.rows; 
            for (var i = 0; i < depts.length; i++) {
                if (depts[i].oz1_orgcode != undefined && depts[i].oz1_orgcode != '') {
                    mdepts = mdepts +'\''+ depts[i].oz1_orgcode + '\',';
                }
            } 
        }
    });
    return mdepts;
}
 

/***********************************************************************
 *  获取操作人所在的部门
 *  DLY 
 */
function basedata_getDeptsByEmpCode(empcode, date) {
    var depts = []; 
    var cXML = '<EmpID>' + empcode + '</EmpID><Date>' + date + '</Date>'
    cXML = basedata_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(11))
            + "&type=GetDeptsByEmpID&XML=" + encodeURIComponent(cXML)
            + "&s=" + new Date().getTime();  //拼接url   
    $.ajax({
        url: curl,
        options: "JSON",
        async: false,
        success: function (data) {
            //alert(data);
            if (eval("[" + data + "]")[0].Error) {
                $.messager.alert("出错了", eval("[" + data + "]")[0].Error, 'error');
                window.location.href = "login.html";
                return;
            }
            var data1 = eval("(" + data + ")");
            depts = data1.rows;
             
        }
    });
    return depts;
}

/***********************************************************************
 *  获取综合管理部负责所负责的公司code
 *  DLY 
 */
function basedata_getOrgsByZHGLBEmpID(empcode, date) { 
    var orgs = '\'-2\'';
    var cXML = '<EmpID>' + empcode + '</EmpID><Date>' + date + '</Date>'
    cXML = basedata_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(11))
            + "&type=GetOrgsByZHGLBEmpID&XML=" + encodeURIComponent(cXML)
            + "&s=" + new Date().getTime();  //拼接url   
    $.ajax({
        url: curl,
        options: "JSON",
        async: false,
        success: function (data) {
            //alert(data);
            if (eval("[" + data + "]")[0].Error) {
                $.messager.alert("出错了", eval("[" + data + "]")[0].Error, 'error');
                window.location.href = "login.html";
                return;
            }  
            var data1 = eval("(" + data + ")"); 
            for (var i = 0; i < data1.rows.length; i++) {
                if (data1.rows[i].oz1_orgcode != undefined && data1.rows[i].oz1_orgcode != '') {
                    orgs = orgs + ', \'' + data1.rows[i].oz1_orgcode +'\'' ;
                }
            } 
        }
    });
    return orgs;
}


/***********************************************************************
 *  获取基础信息公共方法
 *  DLY 
 */
function basedata_getBDCommon(type, cons, orderby) {
    var res = [];
    if (type == undefined || type == null || type == '') {
        return res;
    }
    if (cons == undefined) {
        cons = '';
    }
    if (orderby == undefined) {
        orderby = ' ORDER BY CT1_CODE ';
    }
    var cXML = '<Cons>' + cons + '</Cons><OrderBy>' + orderby + '</OrderBy>'
    cXML = basedata_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(2))
            + "&type=" + type + "&XML=" + encodeURIComponent(cXML)
            + "&s=" + new Date().getTime();  //拼接url   
    $.ajax({
        url: curl,
        options: "JSON",
        async: false,
        success: function (data) {
            //alert(data);
            if (eval("[" + data + "]")[0].Error) {
                $.messager.alert("出错了", eval("[" + data + "]")[0].Error, 'error'); 
                return;
            }
            var data1 = eval("(" + data + ")");
            res = data1.rows;

        }
    });
    return res;
}


/***********************************************************************
 * 
 * 获取基础数据选择项 - cXML 
 *  ctype: gdb1-启用，gdb2-通用
 *  cXML：cXML
 *  DLY
 *  2014-05-05
 */
function basedata_getBD(ctype, cXML) {
    var res = [];
    if (dataUtil_undefinedOrNull(ctype, '') == '' || dataUtil_undefinedOrNull(cXML, '') == '') {
        return res;
    }
    cXML = basedata_addROOT(cXML);
    var curl = GetWSRRURL(peoa_GetWSRRURL(2)) + "&type=" + ctype
             + "&XML=" + encodeURIComponent(cXML) + "&s=" + new Date().getTime();
    //alert(curl);
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data.rows));
            if (dataUtil_undefinedOrNull(data, '') == '') {
                res = [];
            } else if (dataUtil_undefinedOrNull(data.rows, '') == '') {
                res = [];
            } else {
                res = data.rows;
            }
        }
    })
    return res;
}


/***********************************************************************
 * 
 * 获取基础数据选择项 - 传参
 *  ctype: gdb1-启用，gdb2-通用
 *  code：类型编码
 *  DLY 
 */
function basedata_getBDX(ctype, CONO, DIVI, Level, State, Code0, Code1, Code2, Order) {
    var res = [];
    if (dataUtil_undefinedOrNull(ctype, '') == '') {
        return res;
    }
    var cXML = '<CONO>' + CONO + '</CONO><DIVI>' + DIVI + '</DIVI><Level>' + Level
            + '</Level><State>' + State + '</State>'
            + '<Code0>' + Code0 + '</Code0><Code1>' + Code1
            + '</Code1><Code2>' + Code2 + '</Code2><Order>' + Order + '</Order>';
    cXML = basedata_addROOT(cXML);
    var curl = GetWSRRURL(peoa_GetWSRRURL(2)) + "&type=" + ctype
             + "&XML=" + encodeURIComponent(cXML) + "&s=" + new Date().getTime();
    //alert(curl);
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data.rows));
            if (dataUtil_undefinedOrNull(data, '') == '') {
                res = [];
            } else if (dataUtil_undefinedOrNull(data.rows, '') == '') {
                res = [];
            } else {
                res = data.rows;
            }
        }
    })
    return res;
}


/***********************************************************************
 * 
 * 获取基础数据选择项 - 传参
 *  ctype: gdb1-启用，gdb2-通用
 *  code：类型编码
 *  DLY
 *  2014-05-05
 */
function basedata_getBDX1(ctype, CONO, DIVI, Level, State, Code0, Code1, Code2, Order, async) {
    var res = [];
    if (dataUtil_undefinedOrNull(ctype, '') == '') {
        return res;
    }
    var cXML = '<CONO>' + CONO + '</CONO><DIVI>' + DIVI + '</DIVI><Level>' + Level
            + '</Level><State>' + State + '</State>'
            + '<Code0>' + Code0 + '</Code0><Code1>' + Code1
            + '</Code1><Code2>' + Code2 + '</Code2><Order>' + Order + '</Order>';
    cXML = basedata_addROOT(cXML);
    var curl = GetWSRRURL(peoa_GetWSRRURL(2)) + "&type=" + ctype
             + "&XML=" + encodeURIComponent(cXML) + "&s=" + new Date().getTime();
    //alert(curl);
    $.ajax({
        url: curl,
        type: "GET",
        async: async,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data.rows));
            if (dataUtil_undefinedOrNull(data, '') == '') {
                res = [];
            } else if (dataUtil_undefinedOrNull(data.rows, '') == '') {
                res = [];
            } else {
                res = data.rows;
            }
        }
    })
    return res;
}



/***********************************************************************
 * 
 * 获取部门对应人员信息
 *  ctype: 获取方式
 *  cXML：条件
 *  DLY
 *  2014-05-05
 */
function basedata_getEmpList(ctype, cXML) {
    var res = [];
    if (dataUtil_undefinedOrNull(ctype, '') == '' || dataUtil_undefinedOrNull(cXML, '') == '') {
        alert('条件不明确!')
        return res;
    }
    cXML = basedata_addROOT(cXML);
    var curl = GetWSRRURL(peoa_GetWSRRURL(4)) + "&type=" + ctype
             + "&XML=" + encodeURIComponent(cXML) + "&s=" + new Date().getTime();
    //alert(curl);
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data.rows));
            if (dataUtil_undefinedOrNull(data, '') == '') {
                res = [];
            } else if (dataUtil_undefinedOrNull(data.rows, '') == '') {
                res = [];
            } else {
                res = data.rows;
            }
        }
    })
    return res;
}


/***********************************************************************
 * 
 *  字符串追加 <ROOT><LIST><ROWS> 
 *  DLY
 *  2014-05-14
 */
function basedata_addROOT(str) {
    return '<ROOT><LIST><ROWS>' + dataUtil_undefinedOrNull(str) + '</ROWS></LIST></ROOT>';
}



/***********************************************************************
 *  获取url参数
 *  参数说明
 *       name  参数名
 *  DLY
 *  2013-05-27
 */
function basedata_getUrlParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return decodeURIComponent(r[2]); return "";
}


/***********************************************************************
 * 
 *  设置打开选项卡地址
 *  ctype: 单据类型
 *  code：类型编码
 *  DLY
 *  2014-05-05
 */
function basedata_setOpenURL(ctype, v0, v1, v2) {
    var res = [];

    return res;
}
 

/***********************************************************************
 *  根据code从数组中获取codename
 *  参数说明
 *       list  数组[{code,codename},{code,codename}]
 *  DLY
 *  2014-05-27
 */
function basedata_getCodename(list, code, codefield, namefield) {
    var codename = code;
    if (codefield == undefined || codefield == undefined) {
        if (dataUtil_undefinedOrNull(code, '') != '') {
            for (var i = 0; i < list.length; i++) {
                if (code == list[i].code) {
                    codename = list[i].codename;
                }
            }
        }
    } else {
        if (dataUtil_undefinedOrNull(code, '') != '') {
            for (var i = 0; i < list.length; i++) {
                if (code == list[i][codefield]) {
                    codename = list[i][namefield];
                }
            }
        }
    }
    return codename
}
 

/***********************************************************************
 * 
 * 获取DIVI 
 *  DLY
 *  2014-05-28
 */
function basedata_getCommonData(type) {
    var res = '';
    if (type == 'DIVI') {
        res = 'D01';
    } else if (type == 'CONOT') {
        res = 'HWA';
    }
    return res;
}


/***********************************************************************
 *  根据条件获取固定资产预算信息或申购单预算校验
 *  DLY
 *  2014-05-21
 */
function basedata_getFABudgetByCons(type, cXML) {
    var res = [];
    var cXML = basedata_addROOT(cXML);
    var curl = GetWSRRURL(peoa_GetWSRRURL(5)) + "&type=" + type + "&XML=" + encodeURIComponent(cXML); //拼接url
    //alert(scondition);	
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        //contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                res = data.rows;
            }
        }
    })
    return res;
}


/***********************************************************************
 *  多个签名，取随机值
 *  DLY 
 */
function basedata_random(n1, n2, n3) {
    n1 = dataUtil_undefinedOrNull(n1, '');
    n2 = dataUtil_undefinedOrNull(n2, '');
    n3 = dataUtil_undefinedOrNull(n3, '');

    var res = n1;
    var n = parseInt(3 * Math.random()); 
    if (n > 0) {
        if (n2 != '') { 
            res = n2;
        }
        if (n > 1 && n3 != '') {
            res = n3;
        }
    }  
    return res;
}


/***********************************************************************
 *  值替换
 *  DLY 
 */
function basedata_AtoB(v1, v2, v3) {
    if (v1 == v2) {
        return v3;
    } else { 
        return v1;
    }
}


//添加右击小类
function basedata_rightClickXL(mtitle, msg) {
    if (dataUtil_undefinedOrNull(msg, '') == '') {
        msg = '无科目说明！';
    }
    $('#remarkXLdlg').dialog({
        title: mtitle,
        top:350
    });
    $('#remarkXLdlg').dialog('open');
    $('#remarkXLspan').html(msg);
    event.returnValue = false;
    event.cancelBubble = true;
    return false;
}


/***********************************************************************
 *  根据品牌获取大区 
 *  DLY 
 */
function basedata_getBranchByBrand(brand) {
    var res = [];
    var orderby = '';
    var cons =  ' AND OZ1_State=\'启用\' AND OZ1_ISBranch =\'是\' ';
    if (brand != '') {
        cons = cons + ' AND oz1_brand = \'' + brand + '\'';
    } 
  
    var cXML = '<Page>' + '' + '</Page><Num>' + '' + '</Num>'
        + '<Cons>' + cons + '</Cons><OrderBy>' + orderby + '</OrderBy>'; 
    cXML = basedata_addROOT(cXML);
    var curl = GetWSRRURL(peoa_GetWSRRURL(11)) + "&type=GetOrgs&XML=" + encodeURIComponent(cXML); //拼接url 
    $.ajax({
        url: curl,
        options: "JSON",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(data); 
            if (data && data.rows) {
                res = data.rows;
            }
        }
    });
    return res;
}


/***********************************************************************
 *  获取部门信息 
 *  DLY   
 *  1-部门加公司  2-加公司
 */
function basedata_getDeptInfo(type, deptcode, dept) {
    //获取部门信息 
    if (type == 1) {
        var cons = ' AND OZ1_OrgCode=\'' + deptcode + '\' ';
        var cXML = '<Page>0</Page><Num>0</Num>'
                  + '<Cons>' + cons + '</Cons><OrderBy></OrderBy>'
        cXML = basedata_addROOT(cXML);
        //alert(cXML);	
        var curl = GetWSRRURL(peoa_GetWSRRURL(11)) + "&type=GetOrgs&XML=" + encodeURIComponent(cXML)
            + "&s=" + new Date().getTime();  //拼接url   
        $.ajax({
            url: curl,
            options: "JSON",
            async: false,
            dataType: "json",
            success: function (data) {
                if (data.rows[0]) {
                    dept = data.rows[0];
                }
            }
        });
    }
    //获取部门所在公司信息 
    if (type == 1 || type == 2) {
        var cons = ' AND OZ1_OrgCode=\'' + dept.attributes.OZ1_ComCode1 + '\' ';
        var cXML = '<Page>0</Page><Num>0</Num>'
                  + '<Cons>' + cons + '</Cons><OrderBy></OrderBy>'
        cXML = basedata_addROOT(cXML);
        //alert(cXML);	
        var curl = GetWSRRURL(peoa_GetWSRRURL(11)) + "&type=GetOrgs&XML=" + encodeURIComponent(cXML)
            + "&s=" + new Date().getTime();  //拼接url   
        $.ajax({
            url: curl,
            options: "JSON",
            async: false,
            dataType: "json",
            success: function (data) {
                if (data.rows[0]) {
                    dept.cominfo = data.rows[0];
                }
            }
        });
    }
    return dept;
}


/***********************************************************************
 * 设置编制年份 
 *  DLY 
 */
function basedata_getBMYear() {
    return 2015; 
}

/***********************************************************************
 *  调用ajax公共方法
 *  DLY 
 */
function basedata_ajax(curl, ctype, casync, cdata, cdataType) {
    var res = '';
    $.ajax({
        url: curl,
        type: ctype,
        async: casync,
        data: cdata,
        dataType: cdataType,
        success: function (data) {
            res = data;
        }
    });
    return res
}

//绑定tab的双击事件、右键事件  
function basedata_bindTabEvent(tabsid, menuid) {
    $(".tabs-inner").live('dblclick', function () {
        var subtitle = $(this).children("span").text();
        if ($(this).next().is('.tabs-close')) {
           // $(tabsid).tabs('close', subtitle);
        }
    });
    $(".tabs-inner").live('contextmenu', function (e) {
        $(menuid).menu('show', {
            left: e.pageX,
            top: e.pageY
        });
        var subtitle = $(this).children("span").text();
        $(menuid).data("currtab", subtitle);
        return false;
    });
}


//绑定tab右键菜单事件 
function basedata_bindTabMenuEvent(tabsid, menuid) {
    //关闭当前     
    $('#mm-tabclose').live("click", function () {
        var currtab_title = $(menuid).data("currtab");
        var tab = $(tabsid).tabs('getTab', currtab_title);
        if (tab.panel('options').closable) {
            $(tabsid).tabs('close', currtab_title);
        }
    });

    //全部关闭  
    $('#mm-tabcloseall').click(function () {
        var tabs = $('.tabs-inner span');
        tabs.each(function (i, n) {
            var t = $(n).text();
            var tab = $(tabsid).tabs('getTab', t);
            if (t && tab.panel('options').closable) {
                $(tabsid).tabs('close', t);
            }
        });
    });

    //关闭除当前之外的TAB  
    $('#mm-tabcloseother').click(function () {
        var currtab_title = $(menuid).data("currtab");
        var tabs = $('.tabs-inner span');
        tabs.each(function (i, n) {
            var t = $(n).text();
            var tab = $(m_TabsId).tabs('getTab', t);
            if (t && tab.panel('options').closable && t != currtab_title) {
                $(tabsid).tabs('close', t);
            }
        });
    });

    //关闭当前右侧的TAB  
    $('#mm-tabcloseright').click(function () {
        var nextall = $('.tabs-selected').nextAll();
        if (nextall.length == 0) {
            //alert('已经是最后一个了');  
            //$.messager.alert("ok", '已经是最后一个了');
            return false;
        }  
        nextall.each(function (i, n) {
            if ($('a.tabs-close', $(n)).length > 0) {
                var t = $('a:eq(0) span', $(n)).text();
                $(tabsid).tabs('close', t);
            }
        });
        return false;
    });
    //关闭当前左侧的TAB
    $('#mm-tabcloseleft').click(function () {
        var prevall = $('.tabs-selected').prevAll();
        if (prevall.length == 1) {
            //alert('已经是第一个了');  
            return false;
        }
        prevall.each(function (i, n) {
            if ($('a.tabs-close', $(n)).length > 0) {
                var t = $('a:eq(0) span', $(n)).text();
                $(tabsid).tabs('close', t);
            }
        });
        return false;
    });
}
 

function basedata_endEditing(dgid, rowIndex) {
    if (rowIndex == undefined) { return true }
    if ($(dgid).datagrid('validateRow', rowIndex)) {
        $(dgid).datagrid('endEdit', rowIndex);
        return true;
    } else {
        return false;
    }
}


function basedata_beginEditing(dgid, rowIndex, rowIndexO) {
    if (basedata_endEditing(dgid, rowIndexO)) {
        $(dgid).datagrid('selectRow', rowIndex);
        $(dgid).datagrid('beginEdit', rowIndex);
        return true;
    } else {
        return false;
    }
}

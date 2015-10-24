﻿/***********************************************************************
*  根据rid 获取加班主记录信息
*  DLY 
*/
function hr_getOTApply(cons) {
    var res = '';
    var cXML = '<Page>1</Page><Num>1</Num>'
            + '<Cons>' + cons + '</Cons><OrderBy></OrderBy>';
    cXML = basedata_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=GetHs&XML=" + encodeURIComponent(cXML); //拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (data.rows.length == 0) {
                    res = '1';
                } else if (data.rows[0].hr1_id) {
                    res = data.rows[0];
                }
            }
        }
    })
    return res;
}


/***********************************************************************
*  加班申请汇总（人资导出用）
*  DLY 
*/
function hr_getOTHZInfo(row) {
    var res = [];
    var cXML = '<orgid>' + row.orgid + '</orgid><month>' + row.month + '</month>';
    cXML = basedata_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=GetOTHZInfo&XML=" + encodeURIComponent(cXML); //拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (data.rows[0].flag != undefined && data.rows[0].flag == 'F') {
                    alert(data.rows[0].message);
                } else if (data.rows[0].shopname != undefined && data.rows[0].shopname != '') {
                    res = data.rows;
                }
            }
        }
    })
    return res;
}


/***********************************************************************
*  根据条件获取任务记录信息
*  DLY 
*/
function hr_getTask(cons) {
    var res = '';
    var cXML = '<Page>1</Page><Num>1</Num>'
            + '<Cons>' + cons + '</Cons><OrderBy></OrderBy>';
    cXML = basedata_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=GetAs&XML=" + encodeURIComponent(cXML); //拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (data.rows.length == 0) {
                    res = '1';
                } else if (data.rows[0].hr3_id) {
                    res = data.rows[0];
                }
            }
        }
    })
    return res;
}


/***********************************************************************
*  根据条件获取人员记录信息
*  DLY 
*/
function hr_getPerRecord(cons) {
    var res = '';
    var cXML = '<Page>1</Page><Num>1</Num>'
            + '<Cons>' + cons + '</Cons><OrderBy></OrderBy>';
    cXML = basedata_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=GetPerRecord&XML=" + encodeURIComponent(cXML); //拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (data.rows.length == 0) {
                    res = '1';
                } else if (data.rows[0].hr5_id) {
                    res = data.rows[0];
                }
            }
        }
    })
    return res;
}


/***********************************************************************
*  根据条件获取人员调转记录信息
*  DLY 
*/
function hr_getPerTurnRecord(cons) {
    var res = '';
    var cXML = '<Page>1</Page><Num>1</Num>'
            + '<Cons>' + cons + '</Cons><OrderBy></OrderBy>';
    cXML = basedata_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=GetPerTurnRecord&XML=" + encodeURIComponent(cXML); //拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (data.rows.length == 0) {
                    res = '1';
                } else if (data.rows[0].hr7_id) {
                    res = data.rows[0];
                }
            }
        }
    })
    return res;
}


/***********************************************************************
*  根据条件获取人员离职记录信息
*  DLY 
*/
function hr_getPerDimissRecord(cons) {
    var res = '';
    var cXML = '<Page>1</Page><Num>1</Num>'
            + '<Cons>' + cons + '</Cons><OrderBy></OrderBy>';
    cXML = basedata_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=GetPerDimissRecord&XML=" + encodeURIComponent(cXML); //拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (data.rows.length == 0) {
                    res = '1';
                } else if (data.rows[0].hr8_id) {
                    res = data.rows[0];
                }
            }
        }
    })
    return res;
}


/***********************************************************************
*  根据店铺id获取人员信息
*  DLY 
*/
function hr_getUnitInfo(row) {
    var res = [];
    var rows = [];
    rows.push(row);
    var cXML = GetEditJsonbyType(rows, 'GetEHRUnitInfo');//json转xml  
    var curl = GetWSRRURL(peoa_GetWSRRURL(1002)) + "&XML=" + encodeURIComponent(cXML); //拼接url
    //alert(cXML);	
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows && data.rows[0].c_unitcode != '') {
                res = data.rows;
            }
        }
    })
    return res;
}


/***********************************************************************
*  根据店铺id获取人员信息
*  DLY 
*/
function hr_getShopPers(row) {
    var res = [];
    var rows = [];
    rows.push(row);
    var cXML = GetEditJsonbyType(rows, 'GetEHRShopPersonInfo');//json转xml  
    var curl = GetWSRRURL(peoa_GetWSRRURL(1002)) + "&XML=" + encodeURIComponent(cXML); //拼接url
    //alert(cXML);	
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows && data.rows[0].c_oid != '') {
                res = data.rows;
            }
        }
    })
    return res;
}


/***********************************************************************
*  根据人员id获取人员信息
*  DLY 
*/
function hr_getPer(row) {
    var res = {};
    var rows = [];
    rows.push(row);
    var cXML = GetEditJsonbyType(rows, 'GetEHRPersonInfo');//json转xml  
    var curl = GetWSRRURL(peoa_GetWSRRURL(1002)) + "&XML=" + encodeURIComponent(cXML); //拼接url
    //alert(cXML);	
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows && data.rows[0].c_code != '') {
                res = data.rows[0];
            }
        }
    })
    return res;
}


/***********************************************************************
*  数据同步到EHR
*  DLY 
*/
function hr_ActDataSync(row) {
    var res = '';
    var rows = [];
    rows.push(row);
    var cXML = GetEditJsonbyType(rows, 'ActDataSync');//json转xml  
    var curl = GetWSRRURL(peoa_GetWSRRURL(1002)) + "&XML=" + encodeURIComponent(cXML); //拼接url
    //alert(cXML);	
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows && data.rows[0].flag != '') {
                res = data.rows[0];
            }
        }
    })
    return res;
}


/***********************************************************************
*  根据部门id获取岗位信息
*  DLY 
*/
function hr_getJobs(row) {
    var res = [];
    var rows = [];
    rows.push(row);
    var cXML = GetEditJsonbyType(rows, 'GetEHRJobInfo');//json转xml  
    var curl = GetWSRRURL(peoa_GetWSRRURL(1002)) + "&XML=" + encodeURIComponent(cXML); //拼接url
    //alert(cXML);	
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows && data.rows[0].c_code) {
                res = data.rows;
            }
        }
    })
    return res;
}


/***********************************************************************
*  获取银行信息
*  DLY 
*/
function hr_getBanks(row) {
    var res = [];
    var rows = [];
    rows.push(row);
    var cXML = GetEditJsonbyType(rows, 'GetBank');//json转xml  
    var curl = GetWSRRURL(peoa_GetWSRRURL(1002)) + "&XML=" + encodeURIComponent(cXML); //拼接url
    //alert(cXML);	
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows && data.rows[0].c_oid_bank) {
                res = data.rows;
            }
        }
    })
    return res;
}


/***********************************************************************
*  保存加班主信息
*  DLY 
*/
function hr_saveOTApply(type, row, actor) {
    var res = false;
    var rows = [];
    rows.push(row);
    var cXML = GetEditJson([], [], []);//json转xml  
    if (type == 'N') {
        cXML = GetEditJson(rows, [], []);
    } else if (type == 'U') {
        cXML = GetEditJson([], rows, []);
    } else if (type == 'D') {
        cXML = GetEditJson([], [], rows);
    }
    //alert(cXML);
    var cxmlsJson = { XML: cXML };
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=SaveH&actor="
             + encodeURIComponent(actor) + "&s=" + new Date().getTime();; //拼接url
    $.ajax({
        url: curl,
        type: "POST",
        async: false,
        data: cxmlsJson,
        //contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (data.rows[0].result.toUpperCase() == 'TRUE') {
                    res = true;
                }
            }
        }
    });
    return res;
}


/***********************************************************************
*  保存加班明细
*  DLY 
*/
function hr_saveOTRecords(cXML, actor) {
    var res = false;
    ////保存明细
    var cxmlsJson = { XML: cXML };
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=SaveD&actor="
             + encodeURIComponent(actor) + "&s=" + new Date().getTime();; //拼接url
    $.ajax({
        url: curl,
        type: "POST",
        async: false,
        data: cxmlsJson,
        //contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (data.rows[0].result.toUpperCase() == 'TRUE') {
                    res = true;
                }
            }
        }
    });
    return res;
}


/***********************************************************************
*  保存任务
*  DLY 
*/
function hr_saveTask(type, row, actor) {
    var res = false;
    var rows = [];
    rows.push(row);
    var cXML = GetEditJson([], [], []);//json转xml  
    if (type == 'N') {
        cXML = GetEditJson(rows, [], []);
    } else if (type == 'U') {
        cXML = GetEditJson([], rows, []);
    } else if (type == 'D') {
        cXML = GetEditJson([], [], rows);
    }
    var cxmlsJson = { XML: cXML };
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=SaveA&actor="
             + encodeURIComponent(actor) + "&s=" + new Date().getTime();; //拼接url
    $.ajax({
        url: curl,
        type: "POST",
        async: false,
        data: cxmlsJson,
        //contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (data.rows[0].result.toUpperCase() == 'TRUE') {
                    res = true;
                }
            }
        }
    });
    return res;
}


/***********************************************************************
*  保存人员信息
*  DLY 
*/
function hr_savePer(type, row, actor) {
    var res = false;
    var rows = [];
    rows.push(row);
    var cXML = GetEditJson([], [], []);//json转xml  
    if (type == 'N') {
        cXML = GetEditJson(rows, [], []);
    } else if (type == 'U') {
        cXML = GetEditJson([], rows, []);
    } else if (type == 'D') {
        cXML = GetEditJson([], [], rows);
    }
    //alert(cXML);
    var cxmlsJson = { XML: cXML };
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=SavePer&actor="
             + encodeURIComponent(actor) + "&s=" + new Date().getTime();; //拼接url
    $.ajax({
        url: curl,
        type: "POST",
        async: false,
        data: cxmlsJson,
        //contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (data.rows[0].result.toUpperCase() == 'TRUE') {
                    res = true;
                }
            }
        }
    });
    return res;
}


/***********************************************************************
*  保存人员调转记录
*  DLY 
*/
function hr_savePerTurn(type, row, actor) {
    var res = false;
    var rows = [];
    rows.push(row);
    var cXML = GetEditJson([], [], []);//json转xml  
    if (type == 'N') {
        cXML = GetEditJson(rows, [], []);
    } else if (type == 'U') {
        cXML = GetEditJson([], rows, []);
    } else if (type == 'D') {
        cXML = GetEditJson([], [], rows);
    }
    //alert(cXML);
    var cxmlsJson = { XML: cXML };
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=SavePerTurn&actor="
             + encodeURIComponent(actor) + "&s=" + new Date().getTime();; //拼接url
    $.ajax({
        url: curl,
        type: "POST",
        async: false,
        data: cxmlsJson,
        //contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (data.rows[0].result.toUpperCase() == 'TRUE') {
                    res = true;
                }
            }
        }
    });
    return res;
}


/***********************************************************************
*  保存人员离职记录
*  DLY 
*/
function hr_savePerDimiss(type, row, actor) {
    var res = false;
    var rows = [];
    rows.push(row);
    var cXML = GetEditJson([], [], []);//json转xml  
    if (type == 'N') {
        cXML = GetEditJson(rows, [], []);
    } else if (type == 'U') {
        cXML = GetEditJson([], rows, []);
    } else if (type == 'D') {
        cXML = GetEditJson([], [], rows);
    }
    //alert(cXML);
    var cxmlsJson = { XML: cXML };
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=SavePerDimiss&actor="
             + encodeURIComponent(actor) + "&s=" + new Date().getTime();; //拼接url
    $.ajax({
        url: curl,
        type: "POST",
        async: false,
        data: cxmlsJson,
        //contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (data.rows[0].result.toUpperCase() == 'TRUE') {
                    res = true;
                }
            }
        }
    });
    return res;
}




/***********************************************************************
*  获取系统配置参数（人资或大区经理）
*  DLY 
*/
function hr_getSYSConfig(cons, page, num, orderby) {
    var res = [];
    var cXML = '<Page>' + page + '</Page><Num>' + num + '</Num>'
            + '<Cons>' + cons + '</Cons><OrderBy>' + orderby + '</OrderBy>';
    cXML = basedata_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=GetSYSConfig&XML=" + encodeURIComponent(cXML); //拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (data.rows.length == 0) {
                    res = '1';
                } else if (data.rows[0].hr9_id) {
                    res = data.rows;
                }
            }
        }
    })
    return res;
}


/***********************************************************************
*  获取系统配置参数（人资或大区经理）
*  DLY 
*/
function hr_getSYSConfig1(cons, page, num, orderby) {
    var res = '';
    var cXML = '<Page>' + page + '</Page><Num>' + num + '</Num>'
            + '<Cons>' + cons + '</Cons><OrderBy>' + orderby + '</OrderBy>';
    cXML = basedata_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=GetSYSConfig&XML=" + encodeURIComponent(cXML); //拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.total >= 0) {
                res = data;
            }
        }
    })
    return res;
}


/***********************************************************************
*  大区经理配置调整
*  DLY 
*/
function hr_updSysCfg(row) {
    var res = '';
    var cXML = '<id>' + row.id + '</id><unitid>' + row.unitid + '</unitid>'
            + '<unitname>' + row.unitname + '</unitname><percode>' + row.percode + '</percode>'
            + '<pername>' + row.pername + '</pername><percode1>' + row.percode1 + '</percode1>'
            + '<pername1>' + row.pername1 + '</pername1><actor>' + row.actor + '</actor>';
    cXML = basedata_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=UpdSysCfg&XML=" + encodeURIComponent(cXML); //拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (data.rows[0].flag != undefined && data.rows[0].flag == 'T')
                    res = 'T';
            }
        }
    })
    return res;
}

/***********************************************************************
*  获取公司人资负责人
*  DLY 
*/
function hr_getHRPer(type, value) {
    var cons = ' AND HR9_TYPE = \'0\' ';
    var coms = hr_getSYSConfig(cons, '1', '100', '');
    if (type == 1) {         //人资负责人code——》人资负责公司id
        var orgs = "";
        for (var i = 0; i < coms.length; i++) {
            if (value == coms[i].hr9_rzempcode) {
                orgs = orgs + coms[i].hr9_ehrorgid + ',';
            }
        }
        if (orgs != "") {
            return orgs;
        }
    } else if (type == 2) {   //公司id——》人资负责人code
        for (var i = 0; i < coms.length; i++) {
            if (value == coms[i].hr9_ehrorgid) {
                return coms[i].hr9_rzempcode;
            }
        }
    }
    return '';
}


/***********************************************************************
*  根据店铺id 获取大区经理 
*  DLY 
*  value ：UnitID
*/
function hr_getDQJLPer(type, value) {
    var cons = ' AND HR9_TYPE = \'1\'  AND HR9_EHRUnitID =\'' + value + '\'';
    var coms = hr_getSYSConfig(cons, '1', '100', '');
    if (coms.length > 0) {
        return coms[0].hr9_dqjlempcode;
    }
    return '';
}


/***********************************************************************
*  获取大区经理负责店铺ID
*  DLY 
*  value ：empcode
*/
function hr_getUnitidByDQJL(type, value) {
    var res = ''
    var cons = ' AND HR9_TYPE = \'1\'  AND  HR9_DQJLEmpCode =\'' + value + '\'';
    var coms = hr_getSYSConfig(cons, '1', '100', '');
    if (type == 1) {
        if (coms.length > 0) {
            res = '是大区经理';
        }
    } else if (type == 2) {
        if (coms == '1') {
            coms = [];
        }
        for (var i = 0; i < coms.length; i++) {
            if (coms[i].hr9_ehrunitid != undefined) {
                res = res + ', \'' + coms[i].hr9_ehrunitid + '\'';
            }
        }
        if (res != '') {
            res = ' \'0\' ' + res;
        }
    }
    return res;
}

/***********************************************************************
*  获取城市经理负责店铺ID
*  DLY 
*  value ：empcode
*/
function hr_getUnitidByCSJL(type, value) {
    var res = ''
    var cons = ' AND HR9_TYPE = \'1\'  AND  HR9_CSJLEmpCode =\'' + value + '\'';
    var coms = hr_getSYSConfig(cons, '1', '100', '');
    if (type == 1) {
        if (coms.length > 0) {
            res = '是城市经理';
        }
    } else if (type == 2) {
        if (coms == '1') {
            coms = [];
        }
        for (var i = 0; i < coms.length; i++) {
            if (coms[i].hr9_ehrunitid != undefined) {
                res = res + ', \'' + coms[i].hr9_ehrunitid + '\'';
            }
        }
        if (res != '') {
            res = ' \'0\' ' + res;
        }
    }
    return res;
}


/***********************************************************************
*  获取基础选项
*  DLY 
*/
function hr_getCodeItems(row) {
    var res = [];
    var rows = [];
    rows.push(row);
    var cXML = GetEditJsonbyType(rows, 'GetCodeItems');//json转xml  
    var curl = GetWSRRURL(peoa_GetWSRRURL(1002)) + "&XML=" + encodeURIComponent(cXML); //拼接url
    //alert(cXML);	
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows && data.rows[0].c_code) {
                res = data.rows;
            }
        }
    })
    return res;
}


/***********************************************************************
*  获取基础配置
*  DLY  
*/
function hr_getBaseItems(n) {
    var s = '';
    switch (n) {
        case 1:           //角色 
            s = [{ value: "申请人" }, { value: "经理" }, { value: "人资" }, { value: "全部" }];
            break;
        case 2:           //状态
            s = [{ value: "未提交" }, { value: "经理待批" }, { value: "人资待批" },
                    { value: "经理(驳回)" }, { value: "人资(驳回)" }, { value: "已完结" }, { value: "已取消" }
                , { value: "全部" }];
            break;
        case 3:           //任务类型
            s = [{ value: "加班申请" }, { value: "新增人员" }, { value: "更新人员" }
                    , { value: "人员调转" }, { value: "人员离职" }, { value: "全部" }];
            break;
        default:
            s = [];
    }
    return s;
}


/***********************************************************************
*  获取基础选项类型
*  DLY 
*/
function hr_getCodeType(n) {
    var s = '11111111';
    switch (n) {
        case 1:           //员工状态 
            s = 'CODE_StaffStatusType';
            break;
        case 2:           //性别
            s = 'CODE_GenderType';
            break;
        case 3:           //员工来源
            s = 'CODE_EmployeeSource';
            break;
        case 4:           //户籍性质
            s = 'CODE_DomicileType';
            break;
        case 5:           //名族
            s = 'CODE_Nationality';
            break;
        case 6:           //国籍
            s = 'CODE_Nation';
            break;
        case 7:           //婚姻状况
            s = 'CODE_Marital';
            break;
        case 8:           //政治面貌
            s = 'CODE_PolityType';
            break;
        case 9:           //最高学历
            s = 'CODE_Grade';
            break;
        case 10:           //最高学位
            s = 'CODE_Degree';
            break;
        case 11:           //试用期
            s = 'CODE_ProbationDays';
            break;
        case 12:           //布尔类型
            s = 'CODE_BooleanType';
            break;
        case 13:           //调转原因
            s = 'CODE_StaffChangeType';
            break;
        case 14:           //离职类型
            s = 'CODE_DimissionType';
            break;
        case 15:           //员工类别(分布)
            s = 'CODE_EmployeeType';
            break;
        case 16:           //所属区域
            s = 'CODE_AreaType';
            break;
        case 17:           //异动类型
            s = 'CODE_StaffRecordType';
            break;
        case 18:           //离职原因
            s = 'CODE_DimissionReason';
            break;
        case 19:           //合同所属公司
            s = 'CODE_company';
            break;
        default:
            s = '11111111';
    }
    return s;
}


/***********************************************************************
* 照片url
*  DLY 
*/
function hr_getServUrl(type) {
    if (type == undefined) {
        //return 'http://172.16.205.180:7001/temp/'; 
        return 'http://ehr.elegant-prosper.com.cn:7001/temp/';
    } else if (type == 1) {
        //return 'http://localhost:8084/WEB/PE_OA/HRLogin/AttendanceIndex.HTML';
        return 'http://192.168.0.35/PE_OA/WEB/PE_OA/HRLogin/AttendanceIndex.HTML';
    } if (type == 2) {
        return 'index_hr.html';
    }

}


/***********************************************************************
* 上传照片
*  DLY 
*/
function hr_uploadPhoto(row) {
    var res = '';
    var cXML = '<photoPath>' + row.photoPath + '</photoPath><photoID>' + row.photoID + '</photoID>'
             + '<actor>' + row.actor + '</actor><actorid>' + row.actorid + '</actorid>'
             + '<upType>' + row.upType + '</upType>';
    cXML = basedata_addROOT(cXML);
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=setPhotToSave&actor="
            + encodeURIComponent(row.actor)
            + "&XML=" + encodeURIComponent(cXML)
            + "&s=" + new Date().getTime();; //拼接url
    $.ajax({
        url: curl,
        type: "POST",
        async: false,
        //data: cxmlsJson,
        //contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows && data.rows[0].result) {
                res = data.rows[0];
            }
        }
    });
    return res;
}


/***********************************************************************
* 人资环节特殊控制 - 雅莹的取分公司人资
*  DLY 
*/
function hr_HRPerFlag(comid) {
    var res = '0';
    if (comid == '118502730') {
        res = '1';
    }
    return res;
}
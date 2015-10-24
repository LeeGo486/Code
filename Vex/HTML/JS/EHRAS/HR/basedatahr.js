/***********************************************************************
*  根据rid 获取加班主记录信息
*  DLY 
*/
function hr_getOTApply(cons) {
    var res = '';
    var cXML = '<Page>1</Page><Num>1</Num>'
            + '<Cons>' + cons + '</Cons><OrderBy></OrderBy>';
    cXML = dataUtil_addROOT(cXML);
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
    });
    return res;
}


/***********************************************************************
*  加班申请汇总（人资导出用）
*  DLY 
*/
function hr_getOTHZInfo(row) {
    var res = [];
    var cXML = '<orgid>' + row.orgid + '</orgid><month>' + row.month + '</month>';
    cXML = dataUtil_addROOT(cXML);
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
    });
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
    cXML = dataUtil_addROOT(cXML);
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
    });
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
    cXML = dataUtil_addROOT(cXML);
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
    });
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
    cXML = dataUtil_addROOT(cXML);
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
    });
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
    cXML = dataUtil_addROOT(cXML);
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
    });
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
    });
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
    });
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
    });
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
    });
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
    });
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
    });
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
*  加班工资计算
* sy
*/
function hr_setOTMoney(approveid) {
    var res = false;
    var cXML = '<approveid>' + approveid + '</approveid>';
    cXML = dataUtil_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=CalculateMoney&XML=" + encodeURIComponent(cXML); //拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (data.rows[0].flag != undefined && data.rows[0].flag == 'F') {
                    res = false;
                }
                else {
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
 *  流程控制
 *  Flow01  //店长——大区经理——人资
 *  Flow02  //店长——人资
 *  flowType——流程类型ID ； type——当前操作；
 *  taskid——待办id ； userName——当前操作人；
 *  zState—— 对比状态
 *  DLY 
 */
function hr_flowControl(flowType, type, taskid, userName, zState) {
    var actors = hr_getBaseItems(1); // 获取流程执行者
    var states = hr_getBaseItems(2); // 获取流程状态

    var flag = false;
    var res = {};
    var actinfo = '';
    var result = { "flag": flag, "res": res, "actinfo": actinfo };


    //任务状态校验  
    if (taskid == '') {
        alert('任务ID无效，请截全屏图发给系统管理员！(' + taskid + ')');
        return res;
    }
    var cons = ' AND  HR3_ID= \'' + taskid + '\'';
    res = hr_getTask(cons);
    if (res == '1') {
        alert('未找到对应待办任务，请截全屏图发给系统管理员！(' + taskid + ')');
        return result;
    } else if (res.hr3_id != undefined && res.hr3_id != '') {
        if (res.hr3_state != zState) {
            alert('该任务状态已更新，请刷新任务！(' + taskid + ')');
            return result;
        }
    } else {
        alert('待办任务信息获取失败，请截全屏图发给系统管理员！(' + taskid + ')');
        return result;
    }

    //审核控制
    var actT = dateUtil_dateFomaterA(new Date(), '-');
    var curActor = res.hr3_actor;
    if (type == 'tj') {
        actinfo = '提交';
        if (flowType == 'Flow01') {  //店长——大区经理——人资 
            res.hr3_state = states[1].value; //'经理待批'
            res.hr3_actor = actors[1].value; //'经理'
        } else if (flowType == 'Flow02') { //店长——人资
            res.hr3_state = states[2].value; //'人资待批'
            res.hr3_actor = actors[2].value; //'人资'
        }
    } else if (type == 'sh') {
        actinfo = '审核';
        if (res.hr3_actor == actors[1].value) { //'经理'
            res.hr3_state = states[2].value; //'人资待批'
            res.hr3_actor = actors[2].value; //'人资'
        } else if (res.hr3_actor == actors[2].value) { //'人资'
            res.hr3_state = states[5].value; //'已完结'
            res.hr3_actor = '';
        }

    } else if (type == 'bh') {
        actinfo = '驳回';
        if (res.hr3_actor == actors[1].value) {
            res.hr3_state = states[3].value; //'经理(驳回)' 
        } else if (res.hr3_actor == actors[2].value) {
            res.hr3_state = states[4].value; //'人资(驳回)';
        }
        res.hr3_actor = actors[0].value; //'申请人'
    } if (type == 'qx') {
        actinfo = '取消';
        res.hr3_state = states[6].value;
        res.hr3_actor = '';
    }
    res.hr3_comment = res.hr3_comment + curActor + '：' + userName + ' ' + actT + ' ' + actinfo + 'rrbrrr';

    result.flag = true;
    result.res = res;
    result.actinfo = actinfo;
    return result;
}


/***********************************************************************
 *  流程控制 批量审批
 *  res——待办记录信息 ； userName——当前操作人
 *  DLY 
 */
function hr_flowControlPL(res, userName) {
    var actors = hr_getBaseItems(1); // 获取流程执行者
    var states = hr_getBaseItems(2); // 获取流程状态   
    //审批控制
    var actinfo = '审核';
    var actT = dateUtil_dateFomaterA(new Date(), '-');
    var curActor = res.hr3_actor;
    if (res.hr3_actor == actors[1].value) { //'经理'
        res.hr3_state = states[2].value; //'人资待批'
        res.hr3_actor = actors[2].value; //'人资'
    } else if (res.hr3_actor == actors[2].value) { //'人资'
        res.hr3_state = states[5].value; //'已完结'
        res.hr3_actor = '';
    }
    res.hr3_comment = res.hr3_comment + curActor + '：' + userName + ' ' + actT + ' ' + actinfo + 'rrbrrr';
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
    cXML = dataUtil_addROOT(cXML);
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
    });
    return res;
}


/***********************************************************************
*  获取当前用户的加班信息
*  SY
*/
function hr_getOTSpecialDay(cons, page, num, orderby) {
    var res = '';
    var cXML = '<Page>' + page + '</Page><Num>' + num + '</Num>'
            + '<Cons>' + cons + '</Cons><OrderBy>' + orderby + '</OrderBy>';
    cXML = dataUtil_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=GetOTSpecialDay&XML=" + encodeURIComponent(cXML); //拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (data.rows.length == 0) {
                    res = '';
                } else if (data.rows[0].hr10_id && data.rows[0].hr10_id != '') {
                    res = data;
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
function hr_getSYSConfig1(cons, page, num, orderby) {
    var res = '';
    var cXML = '<Page>' + page + '</Page><Num>' + num + '</Num>'
            + '<Cons>' + cons + '</Cons><OrderBy>' + orderby + '</OrderBy>';
    cXML = dataUtil_addROOT(cXML);
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
    });
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
    cXML = dataUtil_addROOT(cXML);
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
    });
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
    if (coms != '1' && coms.length > 0) {
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
    });
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
                    , { value: "人员调转" }, { value: "人员离职" }, { value: "考勤申请" }, { value: "特殊薪资申请" }, { value: "销售目标制定" }, { value: "全部" }];
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
        return 'http://172.16.205.180:7001/temp/';
        //return 'http://ehr.elegant-prosper.com.cn:7001/temp/';
    } else if (type == 1) {
        return 'http://localhost:8084/WEB/PE_OA/HRLogin/AttendanceIndex.HTML';
        //return 'http://192.168.0.35/PE_OA/WEB/PE_OA/HRLogin/AttendanceIndex.HTML';
    } if (type == 2) {
        return 'index_hr.html';
    } if (type == 3) {
        return 'http://localhost:8084/WEB/PE_OA/HR/EHRForDLShopPay.HTML?type=EHRFZ';
        //return 'http:192.168.0.35/PE_OA/WEB/PE_OA/HR/EHRForDLShopPay.HTML?type=EHRFZ';
        //调用原点一点上的链接
        //return 'http://192.168.0.35/PE_OA/WEB/PE_OA/HR/EHRForDLShopPay_hr.HTML';
        //return 'http://localhost:8084/WEB/PE_OA/HR/EHRForDLShopPay_hr.HTML';
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
    cXML = dataUtil_addROOT(cXML);
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
*  公司流程类别—— 人资环节和经理环节特殊控制 
*  DLY 
*/
function hr_FlowComFlag(comid) {
    var res = '0';   // 贝爱等
    if (comid == '118502730' || comid == '255216032' || comid == '128624899'  // 雅莹等
         || comid == '202485806' || comid == '202485812' || comid == '202485809'
         || comid == '163599111' || comid == '219476245') {
        res = '1';
    } else if (comid == '140738831' || comid == '196993520') { // 卓莱雅 恩派雅
        res = '3';
    } else if (comid == '124288802') { // 贝爱
        res = '4';
    }
    return res;
}

/***********************************************************************
*  公司流程类别—— 人资环节和经理环节特殊控制 
*  DLY 
*/
function hr_ehrLogin(UserName, Password) {
    var flag = false;
    $.messager.progress({ title: '请稍后', msg: '正在验证中' });
    var data = [];
    data[data.length] = { "name": "txtname", "value": UserName };
    data[data.length] = { "name": "txtpassword", "value": $.md5(Password) };

    var CheckDologin = $.ajax({
        url: GetWSRRURL('cc517737-703e-4228-93cd-937d9bc328e6') + "&XML=" + GetFormJson(data, 'CheckDologin'),
        type: 'post',
        async: false,
        onLoadSuccess: function () { $.messager.progress('close'); }
    });
    var dologinInfo = $.parseJSON(CheckDologin.responseText);
    if (dologinInfo.rows[0].c_oid == "" || dologinInfo.rows[0].c_oid == undefined) {
        $.messager.progress('close');
        //alert("验证失败!请输入正确的员工号和密码");
    }
    else {
        $.messager.progress('close');
        //alert("验证成功!"); 
        flag = true;
    }
    return flag;
}


/***********************************************************************
*  获取考勤信息
*  SY 
*/
function hr_getAttendanceInfo(cons, page, num, orderby) {
    var res = '';
    var cXML = '<Page>' + page + '</Page><Num>' + num + '</Num>'
            + '<Cons>' + cons + '</Cons><OrderBy>' + orderby + '</OrderBy>';
    cXML = dataUtil_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=GetAttendanceInfo&XML=" + encodeURIComponent(cXML); //拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (data.rows.length == 0) {
                    res = '';
                } else if (data.rows[0].hr11_id && data.rows[0].hr11_id != '') {
                    res = data;
                }
            }
        }
    });
    return res;
}


/***********************************************************************
*  获取考勤人员信息
*  SY 
*/
function hr_getEmpWorkAttendance(row) {
    var res = [];
    var curl = GetWSRRURL(peoa_GetWSRRURL(1002)) + "&XML=" + GetFormJson(row, "GetEmpWorkAttendance")//拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            if (data && data.rows) {
                    res = data.rows;
            }
        }
    });
    return res;
}



/***********************************************************************
*  获取考勤明细信息
*  SY 
*/
function hr_getAttendanceRecord(cons, page, num, orderby) {
    var res = '';
    var cXML = '<Page>' + page + '</Page><Num>' + num + '</Num>'
            + '<Cons>' + cons + '</Cons><OrderBy>' + orderby + '</OrderBy>';
    cXML = dataUtil_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=GetAttendanceRecord&XML=" + encodeURIComponent(cXML); //拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (data.rows.length == 0) {
                    res = '';
                } else if (data.rows[0].hr12_id && data.rows[0].hr12_id != '') {
                    res = data;
                }
            }
        }
    });
    return res;
}


/***********************************************************************
*  保存考勤信息
*  SY 
*/
function hr_saveAttendanceInfo(cxml, actor) {
    var flag = false;
    var cxmlsJson = { XML: cxml };
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=SaveAttendanceInfo&actor="
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
                    flag = true;
                }
            }
        }
    });
    return flag;
}


/***********************************************************************
*   保存考勤明细信息
*  SY 
*/
function hr_saveAttendanceRecord(cxml, actor) {
    var flag = false;
    var cxmlsJson = { XML: cxml };
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=SaveAttendanceRecord&actor="
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
                    flag = true;
                }
            }
        }
    });
    return flag;
}


/***********************************************************************
*   更新店铺人员考勤明细信息
*  SY 
*/
function hr_updateAttendanceRecord(cxml, actor) {
    var flag = false;
    var cxmlsJson = { XML: cxml };
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=UpdateAttendanceRecord&actor="
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
                    flag = true;
                }
            }
        }
    });
    return flag;
}


/***********************************************************************
*  获取特殊薪资信息
*  SY 
*/
function hr_getSpecialPay(cons, page, num, orderby) {
    var res = '';
    var cXML = '<Page>' + page + '</Page><Num>' + num + '</Num>'
            + '<Cons>' + cons + '</Cons><OrderBy>' + orderby + '</OrderBy>';
    cXML = dataUtil_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=GetSpecialPay&XML=" + encodeURIComponent(cXML); //拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (data.rows.length == 0) {
                    res = '';
                } else if (data.rows[0].hr13_id && data.rows[0].hr13_id != '') {
                    res = data;
                }
            }
        }
    });
    return res;
}


/***********************************************************************
*  获取特殊薪资明细信息
*  SY 
*/
function hr_getSpecialPayRecord(cons, page, num, orderby) {
    var res = '';
    var cXML = '<Page>' + page + '</Page><Num>' + num + '</Num>'
            + '<Cons>' + cons + '</Cons><OrderBy>' + orderby + '</OrderBy>';
    cXML = dataUtil_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=GetSpecialPayRecord&XML=" + encodeURIComponent(cXML); //拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (data.rows.length == 0) {
                    res = '';
                } else if (data.rows[0].hr14_id && data.rows[0].hr14_id != '') {
                    res = data;
                }
            }
        }
    });
    return res;
}


/***********************************************************************
*  保存特殊薪资主信息
*  SY 
*/
function hr_saveSpecialPay(cxml, actor) {
    var flag = false;
    var cxmlsJson = { XML: cxml };
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=SaveSpecialPay&actor="
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
                    flag = true;
                }
            }
        }
    });
    return flag;
}


/***********************************************************************
*   保存特殊薪资明细信息
*  SY 
*/
function hr_saveSpecialPayRecord(cxml, actor) {
    var flag = false;
    var cxmlsJson = { XML: cxml };
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=SaveSpecialPayRecord&actor="
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
                    flag = true;
                }
            }
        }
    });
    return flag;
}


/***********************************************************************
*   任务查询公共条件  待办或全部的公共条件
*/
function hr_getTasksCons(type) {
    var cons = '';
    if (type == 'tasks') {
        cons = ' AND ( (HR3_PerID  = \'' + m_UserInfo.deptID + '\' AND HR3_Actor =\'申请人\')'
                 + ' OR (HR3_PerID1  = \'' + m_UserInfo.empCode + '\' AND HR3_Actor =\'经理\')'
                 + ' OR (HR3_PerID2  = \'' + m_UserInfo.empCode + '\' AND HR3_Actor =\'人资\') )';
    } else if (type == 'tasksQ') {
        cons = ' AND ( HR3_PerID  = \'' + m_UserInfo.deptID + '\''
                 + ' OR HR3_PerID1  = \'' + m_UserInfo.empCode + '\''
                 + ' OR HR3_PerID2  = \'' + m_UserInfo.empCode + '\' )';;
    } else {
        cons = ' AND 1=2 ';
    }
    return cons;
}


/***********************************************************************
*  根据角色和类型获取系统菜单
*  DLY 
*/
function hr_getPowerConfig(cons, page, num, orderby) {
    var res = [];
    var cXML = '<Page>' + page + '</Page><Num>' + num + '</Num>'
            + '<Cons>' + cons + '</Cons><OrderBy>' + orderby + '</OrderBy>';
    cXML = dataUtil_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=GetPowerConfig&XML=" + encodeURIComponent(cXML); //拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (data.rows.length == 0) {
                    res = [];
                } else if (data.rows[0].hr15_id) {
                    res = data.rows;
                }
            }
        }
    });
    return res;
}


/***********************************************************************
*  人资配置调整
*  SY 
*/
function hr_updRZSysCfg(row) {
    var res = '';
    var cXML = '<Orgid>' + row.orgid + '</Orgid><Percode>' + row.percode + '</Percode>'
            + '<Pername>' + row.pername + '</Pername><Actor>' + row.actor + '</Actor>';
    cXML = dataUtil_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=UpdRZSysCfg&XML=" + encodeURIComponent(cXML); //拼接url
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
    });
    return res;
}


/***********************************************************************
 * 
 * 获取DIVI 
 *  DLY 
 */
function hr_getCommonData(type) {
    var res = '';
    if (type == 'DIVI') {
        res = 'D01';
    } else if (type == 'CONOT') {
        res = 'HWA';
    }
    return res;
}


/***********************************************************************
*  获取员工基础信息
*  SY 
*/
function hr_getUserInfo(cons, page, num, orderby) {
    var res = '';
    var cXML = '<Page>' + page + '</Page><Num>' + num + '</Num>'
            + '<Cons>' + cons + '</Cons><OrderBy>' + orderby + '</OrderBy>';
    cXML = dataUtil_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=GetUserInfo&XML=" + encodeURIComponent(cXML); //拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (data.rows.length == 0) {
                    res = '';
                } else if (data.rows[0].empid) {
                    res = data;
                }
            }
        }
    });
    return res;
}


/***********************************************************************
*  获取数据公共
*  DLY 
*/
function hr_getDBCode(cons, page, num, orderby, type) {
    var res = '';
    var cXML = '<Page>' + page + '</Page><Num>' + num + '</Num>'
            + '<Cons>' + cons + '</Cons><OrderBy>' + orderby + '</OrderBy>';
    cXML = dataUtil_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=" + type + "&XML=" + encodeURIComponent(cXML); //拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (data.rows.length == 0) {
                    res = [];
                } else if (data.rows[0].id && data.rows[0].id != '') {
                    res = data;
                }
            }
        }
    });
    return res;
}


/***********************************************************************
*  保存基础数据
*  DLY
*/
function hr_saveSYSCode(cxml, actor, type) {
    var flag = false;
    var cxmlsJson = { XML: cxml };
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=" + type + "&actor="
             + encodeURIComponent(actor) + "&s=" + new Date().getTime();; //拼接url
    $.ajax({
        url: curl,
        type: "POST",
        async: false,
        data: cxmlsJson,
        //contentType: "application/json; charset=utf-8",
        //dataType: "json",
        success: function (data) {
            //alert(data); 
            if (data.indexOf("CK_SYS_CodeClass_Code") > 0) {
                alert("大类编码不能为空！");
                return flag;
            } else if (data.indexOf("PK_SYS_CodeClass_1") > 0) {
                alert("大类编码已存在，请修改！");
                return flag;
            }
            data = eval("(" + data + ")");
            if (data && data.rows) {
                if (data.rows[0].result.toUpperCase() == 'TRUE') {
                    flag = true;
                } else {
                    alert("保存失败！");
                    return flag;
                }
            }
        }
    });
    return flag;
}


/***********************************************************************
*  调整店员配置
*  SY
*/
function hr_updEmpCfg(row) {
    var res = [];
    var cXML = '<mid>' + row.mid + '</mid><unitid>' + row.unitid + '</unitid>'
            + '<empcode>' + row.empcode + '</empcode><workteamcode>' + row.workteamcode + '</workteamcode>'
            + '<salesid>' + row.salesid + '</salesid><begindt>' + row.begindt + '</begindt>'
            + '<enddt>' + row.enddt + '</enddt><actor>' + row.actor + '</actor>'
            + '<confirmtype>' + row.confirmtype + '</confirmtype>';
    cXML = dataUtil_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=UpdEmpCfg&XML=" + encodeURIComponent(cXML); //拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                res = data.rows;
            } else {
                var restemp = {};
                restemp.result = 'false';
                restemp.message = data.Error;
                res.push(restemp);
            }
        }
    });
    return res;
}


/***********************************************************************
*  调整店员配置（后台实现）
*  SY
*/
function hr_saveEmpCfg(row) {
    var res = [];
    var cXML = '<mid>' + row.mid + '</mid><unitid>' + row.unitid + '</unitid>'
            + '<empcode>' + row.empcode + '</empcode><workteamcode>' + row.workteamcode + '</workteamcode>'
            + '<salesid>' + row.salesid + '</salesid><begindt>' + row.begindt + '</begindt>'
            + '<enddt>' + row.enddt + '</enddt><actor>' + row.actor + '</actor>'
            + '<confirmtype>' + row.confirmtype + '</confirmtype>';
    cXML = dataUtil_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=SaveEmpCfg&XML=" + encodeURIComponent(cXML); //拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                res = data.rows;
            } else {
                var restemp = {};
                restemp.flag = 'F';
                restemp.message = data.Error;
                res.push(restemp);
            }
        }
    });
    return res;
}


/***********************************************************************
*  店员配置API SP
*  DLY 
*/
function hr_actSP_UserInfo(cXML, actor) {
    cXML = dataUtil_addROOT(cXML);
    var res = '';
    var cxmlsJson = { XML: cXML };
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=ActSP_UserInfo&actor="
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
                res = data.rows;
            }
        }
    });
    return res;
} 

/***********************************************************************
*  获取店铺员工信息（仅用于考勤测试）
*  SY 
*/
function hr_getAttendanceTest(cons, page, num, orderby) {
    var res = '';
    var cXML = '<Page>' + page + '</Page><Num>' + num + '</Num>'
            + '<Cons>' + cons + '</Cons><OrderBy>' + orderby + '</OrderBy>';
    cXML = dataUtil_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=GetAttendanceTest&XML=" + encodeURIComponent(cXML); //拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (data.rows.length == 0) {
                    res = '';
                } else if (data.rows[0].c_oid) {
                    res = data.rows;
                }
            }
        }
    });
    return res;
}


/***********************************************************************
*  获取当前公司的所有店铺的销售目标信息
*  SY 
*/
function hr_getShopSalesTarget(cons, page, num, orderby) {
    var res = '';
    var cXML = '<Page>' + page + '</Page><Num>' + num + '</Num>'
            + '<Cons>' + cons + '</Cons><OrderBy>' + orderby + '</OrderBy>';
    cXML = dataUtil_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=GetShopSalesTarget&XML=" + encodeURIComponent(cXML); //拼接url
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
                } else if (data.rows[0].id && data.rows[0].id != '') {
                    res = data;
                }
            }
        }
    });
    return res;
}


/***********************************************************************
*  调整店铺销售目标的配置
*  SY
*/
function hr_updShopSalesTargetCfg(row) {
    var res = [];
    var cXML = '<mid>' + row.mid + '</mid><targetamount>' + row.targetamount + '</targetamount>'
            + '<uptno>' + row.uptno + '</uptno><actor>' + row.actor + '</actor>'
    cXML = dataUtil_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=UpdShopSalesTargetCfg&XML=" + encodeURIComponent(cXML); //拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                res = data.rows;
            } else {
                var restemp = {};
                restemp.result = 'false';
                restemp.message = data.Error;
                res.push(restemp);
            }
        }
    });
    return res;
}


/***********************************************************************
*  保存店铺的销售目标
*  DLY 
*/
function hr_saveShopSalesTarget(type, row, actor) {
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
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=SaveShopSalesTarget&actor="
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
                } else {
                    alert(data.rows[0].message);
                }
            }
        }
    });
    return res;
}


/***********************************************************************
*  保存店员的销售目标
*  DLY 
*/
function hr_saveUserSalesTarget(cXML, actor) {
    var res = false;
    ////保存明细
    var cxmlsJson = { XML: cXML };
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=SaveUserSalesTarget&actor="
             + encodeURIComponent(actor) + "&s=" + new Date().getTime();; //拼接url
    $.ajax({
        url: curl,
        type: "POST",
        async: false,
        data: cxmlsJson,
        //contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            // alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (data.rows[0].result.toUpperCase() == 'TRUE') {
                    res = true;
                } else {
                    alert(data.rows[0].message);
                }
            }
        }
    });
    return res;
}


/***********************************************************************
*  获取店员的销售目标
*  DLY 
*/
function hr_getUserSalesTarget(cons, page, num, orderby) {
    var res = '';
    var cXML = '<Page>' + page + '</Page><Num>' + num + '</Num>'
            + '<Cons>' + cons + '</Cons><OrderBy>' + orderby + '</OrderBy>';
    cXML = dataUtil_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=GetUserSalesTarget&XML=" + encodeURIComponent(cXML); //拼接url
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
                } else if (data.rows[0].id && data.rows[0].id != '') {
                    res = data;
                }
            }
        }
    });
    return res;
}


/***********************************************************************
*  获取销售完成提成方案
*  DLY
*/
function hr_getSalesDeductPlan(cons, page, num, orderby) {
    var res = '';
    var cXML = '<Page>' + page + '</Page><Num>' + num + '</Num>'
            + '<Cons>' + cons + '</Cons><OrderBy>' + orderby + '</OrderBy>';
    cXML = dataUtil_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=GetSalesDeductPlan&XML=" + encodeURIComponent(cXML); //拼接url
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
                } else if (data.rows[0].id && data.rows[0].id != '') {
                    res = data;
                }
            }
        }
    });
    return res;
}


/***********************************************************************
*  保存销售完成提成方案
*  DLY 
*/
function hr_saveSalesDeductPlan(cXML, actor) {
    var res = false;
    ////保存明细
    var cxmlsJson = { XML: cXML };
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=SaveSalesDeductPlan&actor="
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
                } else {
                    alert(data.rows[0].message);
                }
            }
        }
    });
    return res;
}


/***********************************************************************
*  调用销售完成提成方案SP
*  DLY 
*/
function hr_actSP_SalesDeductPlan(cXML, actor) {
    cXML = dataUtil_addROOT(cXML);
    var res = '';
    ////保存明细
    var cxmlsJson = { XML: cXML };
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=ActSP_SalesDeductPlan&actor="
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
                res = data.rows;
            }
        }
    });
    return res;
}


/***********************************************************************
*  获取销售突破奖励方案
*  DLY 
*/
function hr_getSalesBreachPlan(cons, page, num, orderby) {
    var res = '';
    var cXML = '<Page>' + page + '</Page><Num>' + num + '</Num>'
            + '<Cons>' + cons + '</Cons><OrderBy>' + orderby + '</OrderBy>';
    cXML = dataUtil_addROOT(cXML);
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=GetSalesBreachPlan&XML=" + encodeURIComponent(cXML); //拼接url
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
                } else if (data.rows[0].id && data.rows[0].id != '') {
                    res = data;
                }
            }
        }
    });
    return res;
}


/***********************************************************************
*  保存销售突破奖励方案
*  DLY 
*/
function hr_saveSalesBreachPlan(cXML, actor) {
    var res = false;
    ////保存明细
    var cxmlsJson = { XML: cXML };
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=SaveSalesBreachPlan&actor="
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
                } else {
                    alert(data.rows[0].message);
                }
            }
        }
    });
    return res;
}


/***********************************************************************
*  调用销售突破奖励方案SP
*  DLY 
*/
function hr_actSP_SalesBreachPlan(cXML, actor) {
    cXML = dataUtil_addROOT(cXML);
    var res = '';
    ////保存明细
    var cxmlsJson = { XML: cXML };
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=ActSP_SalesBreachPlan&actor="
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
                res = data.rows;
            }
        }
    });
    return res;
}


/***********************************************************************
*  调用销售目标API SP
*  DLY 
*/
function hr_actSP_SalesTarget(cXML, actor) {
    cXML = dataUtil_addROOT(cXML);
    var res = '';
    ////保存明细
    var cxmlsJson = { XML: cXML };
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=ActSP_SalesTarget&actor="
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
                res = data.rows;
            }
        }
    });
    return res;
}


/***********************************************************************
*  获取销售单（POS单）
*  SY
*/
function hr_getSaleRetailInfo(row, cons) {
    var res = [];
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1003)) + "&XML=" + GetFormJson(row, "GetSaleRetailInfo")
                + "&Where=" + escape(cons); //拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (data.rows.length == 0) {
                    res = '';
                } else if (data.rows[0].id && data.rows[0].id != '') {
                    res = data;
                }
            } else {
                res = '';
            }
        }
    });
    return res;
}


/***********************************************************************
*  获取销售单明细（POS单）
*  SY
*/
function hr_getSaleRetailSubInfo(row) {
    var res = [];
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1003)) + "&XML=" + GetFormJson(row, "GetSaleRetailSubInfo"); //拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (data.rows.length == 0) {
                    res = '';
                } else if (data.rows[0].id && data.rows[0].id != '') {
                    res = data;
                }
            } else {
                res = '';
            }
        }
    });
    return res;
}


/***********************************************************************
*  获取店长下拉
*  SY
*/
function hr_getShopAdminEmployee(row) {
    var res = [];
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1003)) + "&XML=" + GetFormJson(row, "GetShopAdminEmployee"); //拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                res = data.rows;
            }
        }
    });
    return res;
}


/***********************************************************************
*  获取导购
*  SY
*/
function hr_getShopEmployeeAll(row) {
    var res = [];
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1003)) + "&XML=" + GetFormJson(row, "GetShopEmployeeAll"); //拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                res = data.rows;
            }
        }
    });
    return res;
}


/***********************************************************************
*  保存分单明细
*  SY
*/
function hr_saveSaleRetailSingle(row) {
    var res = [];
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1003)) + "&XML=" + escape(GetGetJson(row, "SaveSaleRetailSingle")); //拼接url
    $.ajax({
        url: curl,
        data: { 'XML': GetGetJson(row, "SaveSaleRetailSingle") },
        type: "POST",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                res = data.rows;
            } else {
                var restemp = {};
                restemp.result = 'false';
                restemp.message = data.Error;
                res.push(restemp);
            }
        }
    });
    return res;
}


/***********************************************************************
*  获取导购
*  SY
*/
function hr_getComInfo() {
    var res = [];
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1003)) + "&XML=" + GetFormJson('', 'GetComInfo')//拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                res = data.rows;
            }
        }
    });
    return res;
}


/***********************************************************************
*  验证分单申请
*  SY
*/
function hr_checkSubmit(row) {
    var res = [];
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1003)) + "&XML=" + escape(GetFormJson(row, "CheckSubmit")); //拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                res = data;
            }
        }
    });
    return res;
}


/***********************************************************************
*  获取分单报表（头表）
*  SY
*/
function hr_getReportHead(row, cons) {
    var res = [];
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1003)) + "&XML=" + GetFormJson(row, "GetReportHead")
                + "&Where=" + escape(cons); //拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (data.rows.length == 0) {
                    res = '';
                } else if (data.rows[0].id && data.rows[0].id != '') {
                    res = data;
                }
            } else {
                res = '';
            }
        }
    });
    return res;
}


/***********************************************************************
*  获取分单报表（子表）
*  SY
*/
function hr_getReportHeadDetail(row, cons) {
    var res = [];
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1003)) + "&XML=" + GetFormJson(row, "GetReportHeadDetail")
                + "&Where=" + escape(cons); //拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (data.rows.length == 0) {
                    res = '';
                } else if (data.rows[0].drp_userid && data.rows[0].drp_userid != '') {
                    res = data;
                }
            } else {
                res = '';
            }
        }
    });
    return res;
}


/***********************************************************************
*  获取分单报表（个人子表）——分单信息
*  SY
*/
function hr_getReportHeadDetailPerson(row, cons) {
    var res = [];
    //alert(cXML);	
    var curl = GetWSRRURL(peoa_GetWSRRURL(1003)) + "&XML=" + GetFormJson(row, "GetReportHeadDetailPerson")
                + "&Where=" + escape(cons); //拼接url
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (data.rows.length == 0) {
                    res = '';
                } else if (data.rows[0].id && data.rows[0].id != '') {
                    res = data;
                }
            } else {
                res = '';
            }
        }
    });
    return res;
}


/***********************************************************************
 *  设置下拉控件
 *  DLY 
 */
function hr_setCombobox(field, width, pwidth, pheight, edit, multi, vfield, tfield, data) {
    $(field).combobox({
        width: width,
        panelWidth: pwidth,
        panelHeight: pheight,
        editable: edit,
        multiple: multi,
        valueField: vfield,
        textField: tfield,
        data: data
    });
}

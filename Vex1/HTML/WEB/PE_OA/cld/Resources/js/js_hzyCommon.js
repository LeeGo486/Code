var m_UserID = "";
var m_PassWord = "";

function GetLoginUser() {
    if (window.m_UserID == undefined || window.m_UserID=="") {
        $.ajax({
            url: GetLoginNameURL(),
            options: "JSON",
            async: false, //同步
            success: function (data) {

                if (eval("[" + data + "]")[0].Error) {
                    $.messager.alert("出错了", eval("[" + data + "]")[0].Error, 'error');
                    window.location.href = "login.html";
                    return;
                }
                var objData = eval("[" + data + "]")[0]
                var user = objData.UserName;

                if (objData.PassWord) {
                    window.m_PassWord = objData.PassWord;
                }
                window.m_UserID = user;
            }
        });
    }
}

$(function () {
    document.title = hzy_WebName;

    //GetLoginUser();
});

//获取当前登录的用户名
function GetLoginNameURL() {
    var strReturn = encodeURI(hzy_WSRRUrl + '&WSID=LoginName');
    return strReturn;
}

function GetLoginURL() {
    return GetWSRRURL('550fc164-adc8-4f88-bc9d-73c4248050bc');
}

function GetWSRRURL(wsid, param) {
    if (param == undefined || param == '') {
        param = '';
    }
    else {
        if (param.substr(0, 1) != '&') {
            param = '&' + param;
        }
    }
    var strReturn = encodeURI(hzy_WSRRUrl + '&WSID=' + wsid + '' + param);
    return strReturn;
}

function GetGridColumnsWSRRURL(pstrWSID, pstrWidth, pbSort, pbSearch) {
    var strReturn = GetWSRRURL(pstrWSID);
    strReturn += "&RequestType=GridColumns&where=1!=1";
    if (!pstrWidth) {
        pstrWidth = "100";
    }
    strReturn += "&GridColumnsWidth=" + pstrWidth;

    if (!pbSort) {
        pbSort = "true";
    }
    strReturn += "&GridColumnsSort=" + pbSort;

    if (!pbSearch) {
        pbSearch = "true";
    }
    strReturn += "&GridColumnsSearch=" + pbSearch;

    return strReturn;
}

function GetComboxWSRRURL(wsid, comboxType, comboxIDFiled, comboxTextFiled) {
    var strReturn = GetWSRRURL(wsid);
    strReturn += "&RequestType=combox";
    strReturn += "&ComboxType=" + comboxType;

    if (comboxIDFiled) {
        strReturn += "&comboxIDFiled=" + escape(comboxIDFiled);
    }

    if (comboxTextFiled) {
        strReturn += "&comboxTextFiled=" + escape(comboxTextFiled);
    }
    return strReturn;
}



function GetComboxALLColumnWSRRURL(wsid, comboxType, comboxIDFiled, comboxTextFiled) {
    var strReturn = GetWSRRURL(wsid);
    strReturn += "&RequestType=comboxAllColumn";

    if (comboxIDFiled) {
        strReturn += "&comboxIDFiled=" + escape(comboxIDFiled);
    }

    if (comboxTextFiled) {
        strReturn += "&comboxTextFiled=" + escape(comboxTextFiled);
    }
    strReturn += "&ComboxType=" + comboxType;
    return strReturn;
}

function GetSubmitWSRRURL(wsid) {
    var strReturn = GetWSRRURL(wsid);
    strReturn += "&RequestType=Submit";
    return strReturn;
}

//containRoot=1:包含根节点信息
//parentID:父节点信息
function GetTreeWSRRURL(wsid, treeCheckboxCol, parentID, containRoot) {
    var strReturn = GetWSRRURL(wsid);
    strReturn += "&RequestType=tree";
    if (treeCheckboxCol != undefined) {
        strReturn += "&treeCheckboxCol=" + treeCheckboxCol;
    }
    if (parentID != undefined) {
        strReturn += "&parentID=" + parentID;
    }
    if (containRoot != undefined) {
        strReturn += "&ContainRoot=" + containRoot;
    }
    return strReturn;
}



function ComboboxAddRow(addValue, insertIndex, controlName) {
    var data = [];
    var oldValue = $(controlName).combobox("getData");
    var bInserted = false;
    for (var i = 0; i < oldValue.length; i++) {
        if (insertIndex == i) {
            data.push(addValue);
            bInserted = true
        }
        data.push(oldValue[i]);
    }

    if (bInserted == false) {
        data.push(addValue);
    }

    $(controlName).combobox("loadData", data);
}


function GetCommboboxText(data, value) {

    for (var i = 0; i < data.length; i++) {

        if (value && data[i].id.toString().toUpperCase() == value.toString().toUpperCase())
            return data[i].text;
    }
    return '';

}

function SetCommboboxValueByText(id, text) {
    var data = $(id).combobox('getData');
    for (var i = 0; i < data.length; i++) {
        if (text && data[i].text.toString().toUpperCase() == text.toString().toUpperCase()) {
            $(id).combobox('setValue', data[i].id);
            return;
        }
    }

}


function GetErrorMsg(code) {
    if (code == "E0001") {
        return "E0001:发生系统错误，请联系信息管理部";
    }

}

function ClearGrid(gridName) {

    try {
        $(gridName).datagrid('loadData', { total: 0, rows: [] });
        $(gridName).datagrid('clearSelections');
        $(gridName).datagrid('clearChecked');


    } catch (e) {
        return;
    }
}

//核对datagrid里面是否有重复项 
//dgname:datagrid的名称
//checkColumnList：需要检查的项目： [{ "name": "字段名称" }, { "name": "属性名称"}]
//toUpper:检查时是否需要忽略大小写：true
//trim:检查时是否需要trim：true
//noAlert:是否输入提示：true
//allCheck:是否全部一起check：true
function datagridCheckValueRepeat(dgName, checkColumnList, toUpper, trim, noAlert, allCheck) {
    var rowIndexList = [];
    var checkResult = true;
    var $dg = $(dgName);
    var rows = $dg.datagrid('getChanges');
    var ggg1 = "";
    for (var i = 0; i < rows.length; i++) {

        var row = rows[i];

        var rows1 = $dg.datagrid('getRows');

        for (var j = 0; j < rows1.length; j++) {
            var row1 = rows1[j];
            if (row1 == row) {
                continue;
            }

            var evalstr = "";
            var evalstr1 = "";
            var evalstr2 = "";

            for (var k = 0; k < checkColumnList.length; k++) {
                try {
                    var checkColumn = checkColumnList[k];

                    evalstr = "row1." + checkColumn.name;
                    evalstr1 = "row." + checkColumn.name;
                    if (toUpper == true) {
                        evalstr += ".toLocaleLowerCase()"
                        evalstr1 += ".toLocaleLowerCase()"
                    }
                    if (trim && trim == true) {
                        evalstr += ".trim()"
                        evalstr1 += ".trim()"
                    }
                    if (evalstr2 != "") {
                        evalstr2 += " && ";
                    }
                    evalstr2 = evalstr2 + evalstr + " == " + evalstr1;

                }
                catch (ex) {

                }
            }

            if (eval(evalstr2)) {
                if (noAlert || noAlert == true) {
                    $.messager.alert("提示", "第" + ($dg.datagrid('getRowIndex', row) + 1) + "行与第" + ($dg.datagrid('getRowIndex', row1) + 1) + "行数据重复！", "error");
                    ////startEditing($dg.datagrid('getRowIndex', row), checkColumn.name);
                    //checkResult = false;
                }
                //rowIndexList[rowIndexList.length] = $dg.datagrid('getRowIndex', row);
                //var dddd = $dg.datagrid('getData', row);
                
                if (allCheck || allCheck == true) {
                    //return ggg1
                    var ggg = "SKC  " + row.st3_st2_skccode + "  与尺码 " + row.st3_size ;
                     ggg1 = ggg1 + ggg;
                }
            }
        }
    }
    return "您好," + ggg1 + "数据有重复了，请调整之后在保存。谢谢";
}

function ReplaceSpecialXMLString(strSrcXML) {
    var strReturnXML = "";
    strReturnXML = strSrcXML.toString().replaceAll("&", "&amp;", false).replaceAll("<", "&lt;", false).replaceAll(">", "&gt;", false);
    return strReturnXML;
}

function GetFormJson(data, optype) {
    var updatedData = '<Root>'

    updatedData += "<OPTYPE>" + optype + "</OPTYPE>";
    updatedData += '<List>'
    updatedData += '<Rows>'
    if (data != null && data != "") {
        for (var key in data) {
            if (key) {
                if (data[key].specialCharset == true) {
                    updatedData += '<' + data[key].name.substring(3) + '>' + (data[key].value) + '</' + data[key].name.substring(3) + '>';
                }
                else {
                    updatedData += '<' + data[key].name.substring(3) + '>' + ReplaceSpecialXMLString(data[key].value) + '</' + data[key].name.substring(3) + '>';
                }
            }
        }
    }

    updatedData += '</Rows>'
    updatedData += "</List>";
    updatedData += "</Root>";
    return updatedData;
}

function MergeComboboxData(data) {
    var dataCopy = [];
    var strOldName = "";
    for (var key in data) {
        if (key) {
            if (strOldName != data[key].name) {
                dataCopy[dataCopy.length] = data[key];

                strOldName = data[key].name;
            }
            else {
                dataCopy[dataCopy.length - 1].value += "," + data[key].value;
            }
        }
    }
    return dataCopy;
}

function GetEditJson(inserted, updated, deleted) {
    var updatedData = '<Root>'
    if (inserted != null && inserted.length) {
        updatedData += "<OPTYPE>INSERT</OPTYPE>";
        updatedData += '<List>'
        for (var i = 0; i < inserted.length; i++) {
            updatedData += '<Rows>'
            for (var key in inserted[i]) {
                if (key) {
                    updatedData += '<' + key + '>' + ReplaceSpecialXMLString(inserted[i][key]) + '</' + key + '>';
                }
            }
            updatedData += '</Rows>'
        }
        updatedData += "</List>";
    }
    if (updated != null && updated.length) {
        updatedData += "<OPTYPE>UPDATE</OPTYPE>";
        updatedData += '<List>'
        for (var i = 0; i < updated.length; i++) {
            updatedData += '<Rows>'

            for (var key in updated[i]) {
                if (key) {
                    updatedData += '<' + key + '>' + ReplaceSpecialXMLString(updated[i][key]) + '</' + key + '>';
                }
            }
            updatedData += '</Rows>'

        }
        updatedData += "</List>";
    }

    if (deleted != null && deleted.length) {
        updatedData += "<OPTYPE>DELETE</OPTYPE>";
        updatedData += '<List>'
        for (var i = 0; i < deleted.length; i++) {
            updatedData += '<Rows>'

            for (var key in deleted[i]) {
                if (key) {
                    updatedData += '<' + key + '>' + ReplaceSpecialXMLString(deleted[i][key]) + '</' + key + '>';
                }
            }
            updatedData += '</Rows>'

        }
        updatedData += "</List>";
    }
    updatedData += "</Root>";
    return updatedData;
}

function GetEditJsonbyType(data, optype) {
    var updatedData = '<Root>'
    //如果没有传入optype参数，将不再生成OPTYPE节点
    if (optype != undefined) {
        updatedData += "<OPTYPE>" + optype + "</OPTYPE>";
    }
    if (data != null && data.length) {
        updatedData += '<List>'
        for (var i = 0; i < data.length; i++) {
            updatedData += '<Rows>'

            for (var key in data[i]) {
                if (key) {
                    updatedData += '<' + key + '>' + ReplaceSpecialXMLString(data[i][key]) + '</' + key + '>';
                }
            }
            updatedData += '</Rows>'

        }
        updatedData += "</List>";
    }
    updatedData += "</Root>";
    return updatedData;
}

function GetGetJson(condition, optype) {


    var updatedData = '<Root><OPTYPE>GET</OPTYPE><List >'

    if (optype != null) {
        updatedData = '<Root><OPTYPE>' + optype + '</OPTYPE><List >'
    }
    if (condition && condition.length) {
        for (var i = 0; i < condition.length; i++) {
            updatedData += '<Rows>'

            for (var key in condition[i]) {
                if (key) {
                    updatedData += '<' + key + '>' + condition[i][key] + '</' + key + '>';
                }
            }
            updatedData += '</Rows>'
        }
    }

    updatedData += "</List></Root>";
    return updatedData;
}

//获取DBFrameXML
function GetDBFrameXML(data) {
    var updatedData = '&InputFormat=XML&OutputContentType=RS&ConditionStr=';

    updatedData += '<ROOT><LIST>';
    updatedData += '<Rows>';

    if (data != null && data != "") {
        for (var key in data) {
            if (key) {
                if (data[key].specialCharset == true) {
                    updatedData += '<' + escape(data[key].name.substring(3)) + '>' + escape(data[key].value) + '</' + escape(data[key].name.substring(3)) + '>';
                }
                else {
                    updatedData += '<' + escape(data[key].name.substring(3)) + '>' + escape(ReplaceSpecialXMLString(data[key].value)) + '</' + escape(data[key].name.substring(3)) + '>';
                }
            }
        }
    }

    updatedData += '</Rows>'
    updatedData += "</LIST>";
    updatedData += "</ROOT>"
    return updatedData;
};
function GetDBFrameAML(data) {
    var updatedData = '&InputFormat=AML&OutputContentType=RS&ConditionStr=';

    //    updatedData += '<ROOT><LIST>';
    //    updatedData += '<Rows>';

    if (data != null && data != "") {
        for (var key in data) {
            if (key) {
                if (data[key].specialCharset == true) {
                    updatedData += escape('【') + escape(data[key].name.substring(3)) + ',' + escape(data[key].value) + escape('】');
                }
                else {
                    updatedData += escape('【') + escape(data[key].name.substring(3)) + ',' + escape(ReplaceSpecialXMLString(data[key].value)) + escape('】');
                }
            }
        }
    }
    return updatedData;
};

function GetDBFrameAMLPost(data) {
    var updatedData = new Object();
    updatedData.InputFormat = "AML";
    updatedData.OutputContentType = "RS";

    var condition = "";
    //    updatedData += '<ROOT><LIST>';
    //    updatedData += '<Rows>';

    if (data != null && data != "") {
        for (var key in data) {
            if (key) {
                if (data[key].specialCharset == true) {
                    condition += ('【') + (data[key].name.substring(3)) + ',' + (data[key].value) + ('】');
                }
                else {
                    condition += ('【') + (data[key].name.substring(3)) + ',' + (ReplaceSpecialXMLString(data[key].value)) + ('】');
                }
            }
        }
    }
    updatedData.ConditionStr = condition;
    return updatedData;
};

//获取明细
function GetExcelXML(data) {
    var updatedData = '<Root>'
    if (data != null && data.length) {
        updatedData += '<List>'
        for (var i = 0; i < data.length; i++) {
            updatedData += '<Rows>'

            for (var key in data[i]) {
                if (key) {
                    updatedData += '<' + key + '>' + ReplaceSpecialXMLString(data[i][key]) + '</' + key + '>';
                }
            }
            updatedData += '</Rows>'

        }
        updatedData += "</List>";
    }
    updatedData += "</Root>";
    return updatedData;
}

function WindowClose(id) {
    $(id).window("close")
}

function _99_1_1(td)  //datagrid的标题的搜索框
{
    td.oldInnerHTML = td.innerHTML;
    var td2 = $(td);

    var width = td2.width();
    td2.empty();
    td2.focus();

    td2.append("<input type=text value=''/>");
    var input = $("input", td2);

    input.width(width - (input.outerWidth() - input.width()));
    input.keydown(function (e) {
        var currKey = 0, e = e || event;
        currKey = e.keyCode || e.which || e.charCode;
        var keyName = String.fromCharCode(currKey);

        if (currKey == 13)
            _99_1_2(this, td);
    });
    input.blur(function () {
        _99_1_3(td);
    });
    input.focus();


}

function _99_1_2(input, td) //datagrid的标题的文本框的keydown事件
{
    var td2 = $(td);
    var grid_ID = td2.attr("grid")
    var field_ID = td2.attr("field")
    var field_Title = td2.attr("title")
    var queryParam = $("#" + grid_ID).datagrid('options').queryParams;

    if (input.value == "") {
        queryParam.searchFilter = "";
    }
    else {
        eval("queryParam.searchFilter=\"" + field_ID + " like '%" + input.value.replace(/'/gm, "''") + "%'\"");
    }

    var $dg = $("#" + grid_ID);
    if ($dg.datagrid('options').oldtitle == undefined) {
        if ($dg.datagrid('options').title == undefined) {
            $dg.datagrid('options').title = "";
        }
        $dg.datagrid('options').oldtitle = $dg.datagrid('options').title;
    }



    $dg.datagrid('getPager').pagination({ pageNumber: 1 }); //更改条件后，回到第一页

    $dg.datagrid('options').queryParams = queryParam;
    $dg.datagrid('clearSelections');


    var newTitle = $dg.datagrid('options').oldtitle;

    if (input.value != "") {
        newTitle += "----筛选条件：" + field_Title + "=\"" + input.value + "\"";
    }
    $dg.datagrid({ title: newTitle, data: { total: 0, rows: [] } });

    $dg.datagrid('reload');
    input.blur();
}

function _99_1_3(td) //datagrid的标题的文本框的blur事件
{
    td.innerHTML = td.oldInnerHTML;

}


$.extend($.fn.validatebox.defaults.rules, {
    S: {
        validator: function (value, param) {
            if (!param[0]) {
                param[0] = 0;
            }

            if (!param[1]) {
                param[1] = 1000000;
            }

            if (value.length < param[0]) {
                return false;
            }

            if (value.legnth > param[1]) {
                return false;
            }

            var reg = new RegExp("^[A-Za-z]{" + param[0] + "," + param[1] + "}$");
            return reg.test(value)
        },
        message: '必须是{0}到{1}位的英文'
    }
});



$.extend($.fn.validatebox.defaults.rules, {
    N: {
        validator: function (value, param) {
            if (!param[0]) {
                param[0] = 0;
            }

            if (!param[1]) {
                param[1] = 1000000;
            }

            if (value.length < param[0]) {
                return false;
            }

            if (value.legnth > param[1]) {
                return false;
            }

            var reg = new RegExp("^[0-9]{" + param[0] + "," + param[1] + "}$");
            return reg.test(value)
        },
        message: '必须是{0}到{1}位的纯数字'
    }
});


$.extend($.fn.validatebox.defaults.rules, {
    SN: {
        validator: function (value, param) {
            if (!param[0]) {
                param[0] = 0;
            }

            if (!param[1]) {
                param[1] = 1000000;
            }

            if (value.length < param[0]) {
                return false;
            }

            if (value.legnth > param[1]) {
                return false;
            }

            var reg = new RegExp("^[0-9a-zA-Z]{" + param[0] + "," + param[1] + "}$");
            return reg.test(value)
        },
        message: '必须是{0}到{1}位的英文数字'
    }
});




$.extend($.fn.validatebox.defaults.rules, {
    SNC: {
        validator: function (value, param) {
            if (!param[0]) {
                param[0] = 0;
            }

            if (!param[1]) {
                param[1] = 1000000;
            }

            if (value.length < param[0]) {
                return false;
            }

            if (value.legnth > param[1]) {
                return false;
            }

            var reg = new RegExp("^[\u4E00-\u9FCB]{1,}$");
            return !reg.test(value)
        },
        message: '必须是{0}到{1}位的字符'
    }
});

//字符串全文替换
//string：字符串表达式包含要替代的子字符串。
//reallyDo：被搜索的子字符串。
//replaceWith：用于替换的子字符串。
//ignoreCase：忽略大小写
String.prototype.replaceAll = function (reallyDo, replaceWith, ignoreCase) {
    if (!RegExp.prototype.isPrototypeOf(reallyDo)) {
        return this.replace(new RegExp(reallyDo, (ignoreCase ? "gi" : "g")), replaceWith);
    } else {
        return this.replace(reallyDo, replaceWith);
    }
}
/**
* 时间对象的格式化;
*/
Date.prototype.format = function (format) {
    /*
    * eg:format="YYYY-MM-dd hh:mm:ss";
    */
    var o = {
        "M+": this.getMonth() + 1, // month
        "d+": this.getDate(), // day
        "h+": this.getHours(), // hour
        "m+": this.getMinutes(), // minute
        "s+": this.getSeconds(), // second
        "q+": Math.floor((this.getMonth() + 3) / 3), // quarter
        "S": this.getMilliseconds()
        // millisecond
    }

    if (/(y+)/.test(format)) {
        format = format.replace(RegExp.$1, (this.getFullYear() + "")
                .substr(4 - RegExp.$1.length));
    }

    for (var k in o) {
        if (new RegExp("(" + k + ")").test(format)) {
            format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k]
                    : ("00" + o[k]).substr(("" + o[k]).length));
        }
    }
    return format;
}



$.extend($.fn.datagrid.methods, {
    editCell: function (jq, param) {
        return jq.each(function () {
            var opts = $(this).datagrid('options');
            var fields = $(this).datagrid('getColumnFields', true).concat($(this).datagrid('getColumnFields'));
            for (var i = 0; i < fields.length; i++) {
                var col = $(this).datagrid('getColumnOption', fields[i]);
                col.editor1 = col.editor;
                if (fields[i] != param.field) {
                    col.editor = null;
                }
            }
            $(this).datagrid('beginEdit', param.index);
            for (var i = 0; i < fields.length; i++) {
                var col = $(this).datagrid('getColumnOption', fields[i]);
                col.editor = col.editor1;
            }
        });
    }
});


$.extend($.fn.datagrid.defaults.editors, {
    selectButton: {//datetimebox就是你要自定义editor的名称 
        init: function (container, options) {
            var input = $("<div><input type='button' style='width:20px' value='...'  /><value></value><span style='width:90%'></span></div>").appendTo(container);
            //绑定事件
            //onclick=\"try{if(typeof(eval('selectButton'))=='function'){selectButton($(this).next()[0]);}}catch(ex){}\"
            //if (options.hander != null) {
            //    input.find('input').live('click', function () {
            //        $(this).after("<p>Another paragraph!</p>");
            //    });
            //}
            if (options != null && options.handler) {
                input.bind("click", eval(options.handler));
            }

            if (options != null && options.data != null) {
                input.data = options.data;
            }
            else {
                input.data = null;
            }
            return input;
        }, getValue: function (target) {
            return target.value;
        }, setValue: function (target, data) {
            if (typeof (data) == "string") {
                if (target.data != null) {
                    try {
                        var text = "";
                        text = GetCommboboxText(target.data, data);

                        $(target).parent().find('span').html(text);
                        target.value = data;
                    } catch (e) {

                    }
                }
                else {
                    $(target).parent().find('span').html(data);
                    target.value = data;;
                }
            }
            else {
                $(target).parent().find('span').html(target.data[0].text);
                target.value = target.data[0].id;
            }

        }, resize: function (target, width) {
            var input = $(target);
            if ($.boxModel == true) {
                input.width(width - (input.outerWidth() - input.width()));
            } else { input.width(width); }
        }
    }
});


function StringToDate(DateStr) {
    if (DateStr.indexOf(".") > 0) {
        DateStr = DateStr.substr(0, DateStr.indexOf(".")).replace(/-/g, '/');
    }

    var converted = Date.parse(DateStr);

    //alert(DateStr.substr(0, 4) + "/" + DateStr.substr(5, 2) + "/" + DateStr.substr(8, 2));
    var myDate = new Date(converted);
    if (isNaN(converted)) {

        myDate = new Date();
    }
    return myDate;
}



////---------------------easyui扩展------------------------------------------


//供DataGrid里面格式化使用，如：{ field: 'createtime', title: '创建时间', width: 150, sortable: true, formatter:Formater.Date },
var Formater = {
    Account: function (value, rec, index) {
        this.formatDataType = "Account";

        if (value == undefined) {
            return "";
        }
        return $.formatNumber(value, { format: "#,##0.00", locale: "cn" });
        //return "mwq";
    },
    Nums: function (value, rec, index) {
        this.formatDataType = "Nums";

        if (value == undefined) {
            return "";
        }
        return $.formatNumber(value, { format: "#,##0", locale: "cn" });

    },
    Date: function (value, rec, index) {
        this.formatDataType = "Date";

        if (value == undefined) {
            return "";
        }
        var dateValue = value;
        if (value.constructor != Date) {
            dateValue = StringToDate(value);
        }
        return dateValue.format("yyyy-MM-dd");
    },
    DateTime: function (value, rec, index) {
        this.formatDataType = "DateTime";

        if (value == undefined) {
            return "";
        }
        var dateValue = value;
        if (value.constructor != Date) {
            dateValue = StringToDate(value);
        }
        return dateValue.format("yyyy-MM-dd hh:mm:ss");
    },
    DateTimefff: function (value, rec, index) {
        this.formatDataType = "DateTimefff";

        if (value == undefined) {
            return "";
        }
        var dateValue = value;
        if (value.constructor != Date) {
            dateValue = StringToDate(value);
        }
        return dateValue.format("yyyy-MM-dd hh:mm:ss.fff");
        //return "mwq";
    }

};

//导出Exel主函数
function EasyUI_DataGrid_ExcelExport(pgrid,pagination) {
    var btnExcel = null;
     
    pagination.find('a.l-btn').each(function(){
        if ($(this).find('span.icon-excel').length) { 
            btnExcel = $(this);
            btnExcel.linkbutton('disable');
            btnExcel.linkbutton({ iconCls: "pagination-loading" });
           
        }
    });

    if (btnExcel == null) {
        return;
    }

    var dataOptions = pgrid.datagrid("options");

    var strUrl = dataOptions.url;
    var dataColumns = dataOptions.columns;
    var dataColumnsFrozen = dataOptions.frozenColumns;
    var dataParam = dataOptions.queryParams;
    var pageSize = dataOptions.pageSize;
    var pageNumber = dataOptions.pageNumber;
    var title = dataOptions.title;

    var strXMLCol = "<Root><List>";

    if (dataColumnsFrozen != null && dataColumnsFrozen.length > 0) {
        for (var i = 0; i < dataColumnsFrozen[0].length; i++) {

            if (dataColumnsFrozen[0][i].checkbox == true) {
                continue;
            }

            strXMLCol += "<Rows>";
            strXMLCol += "<field>" + dataColumnsFrozen[0][i].field + "</field>";

            if (dataColumnsFrozen[0][i].title) {
                strXMLCol += "<title>" + dataColumnsFrozen[0][i].title + "</title>";
            }
            else {
                strXMLCol += "<title>" + dataColumnsFrozen[0][i].field + "</title>";

            }
            if (dataColumnsFrozen[0][i].width) {
                strXMLCol += "<width>" + dataColumnsFrozen[0][i].width + "</width>";
            }
            else {
                strXMLCol += "<width></width>";

            }

            if (dataColumnsFrozen[0][i].hidden) {
                strXMLCol += "<hidden>true</hidden>";
            }
            else {
                strXMLCol += "<hidden>false</hidden>";
            }

            if (dataColumnsFrozen[0][i].formatDataType) {
                strXMLCol += "<formatDataType>" + dataColumnsFrozen[0][i].formatDataType + "</formatDataType>";
            }
            else {
                strXMLCol += "<formatDataType></formatDataType>";
            }
            strXMLCol += "</Rows>";
        }
    }
    if (dataColumns != null && dataColumns.length > 0) {
        for (var i = 0; i < dataColumns[0].length; i++) {

            if (dataColumns[0][i].checkbox == true) {
                continue;
            }

            strXMLCol += "<Rows>";
            strXMLCol += "<field>" + (dataColumns[0][i].field) + "</field>";

            if (dataColumns[0][i].title) {
                strXMLCol += "<title>" + (dataColumns[0][i].title) + "</title>";
            }
            else {
                strXMLCol += "<title>" + (dataColumns[0][i].field) + "</title>";

            }

            if (dataColumns[0][i].width) {
                strXMLCol += "<width>" + dataColumns[0][i].width + "</width>";
            }
            else {
                strXMLCol += "<width></width>";

            }

            if (dataColumns[0][i].hidden) {
                strXMLCol += "<hidden>true</hidden>";
            }
            else {
                strXMLCol += "<hidden>false</hidden>";
            }

            if (dataColumns[0][i].formatDataType) {
                strXMLCol += "<formatDataType>" + dataColumns[0][i].formatDataType + "</formatDataType>";
            }
            else {
                strXMLCol += "<formatDataType></formatDataType>";
            }

            //if (dataColumns[0][i].align) {
            //    strXMLCol += "<align>" + dataColumns[0][i].align + "</align>";
            //}
            //else {
            //    strXMLCol += "<align>left</align>";
            //} 


            //if (dataColumns[0][i].halign) {
            //    strXMLCol += "<halign>" + dataColumns[0][i].halign + "</halign>";
            //}
            //else {
            //    strXMLCol += "<halign>center</halign>";
            //}
            strXMLCol += "</Rows>";
        }
    }

    strXMLCol += "</List></Root>";

    dataParam.ExcelExportColumns = strXMLCol;

    $.ajax({
        url: strUrl + "&pagerows=0&pageNumber=1&ExcelExport=true&title="+escape(title)+"&rd="+Math.random(),
        data: dataParam,
        type: 'POST',
        options: "JSON",
        success: function (data) {
            if (btnExcel != null) {
                btnExcel.linkbutton('enable');

                btnExcel.linkbutton({ iconCls: "icon-excel" });
            }
            if (eval("[" + data + "]")[0].Error) {
                $.messager.alert("导出Excel出错了", eval("[" + data + "]")[0].Error, 'error');
                return;
            }
            var strFileName = eval("[" + data + "]")[0].FileName;
            window.location.href = strFileName;
        }
    });
}

////---------------------easyui扩展------------------------------------------


////---------------------Jquery扩展------------------------------------------

//Jquery扩展，获取URL的参数值：调用方法：$.getUrlParam('cid');
(function ($) {
    $.getUrlParam = function (name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]); return null;

    }
})(jQuery);



////Jquery扩展，格式化数据
////$.format(2000000010, 3, ',') //result: 2,000,000,010 
////$.format('abcdefghijklmnopqrstuvwxyz', 6, '-'); //result: ab-cdefgh-ijklmn-opqrst-uvwxyz 
//(function ($) {
//    $.extend({
//        format: function (str, step, splitor) {
//            str = str.toString();
//            var len = str.length;

//            if (len > step) {
//                var l1 = len % step,
//                l2 = parseInt(len / step),
//                arr = [],
//                first = str.substr(0, l1);
//                if (first != '') {
//                    arr.push(first);
//                };
//                for (var i = 0; i < l2 ; i++) {
//                    arr.push(str.substr(l1 + i * step, step));
//                };
//                str = arr.join(splitor);
//            };
//            return str;
//        }
//    });
//})(jQuery);

////---------------------Jquery扩展------------------------------------------
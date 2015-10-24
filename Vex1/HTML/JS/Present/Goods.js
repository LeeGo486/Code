//WSRR:GetWSRRURL('881346c3-1b26-4530-a894-c90dcb4d8344')
$().ready(function () {
    initParts();
    initWin("close");
    initGrid(GetGetJson([],"Get"));
});

function initParts() {
    //main
    $("#mainNew").linkbutton({ iconCls: 'icon-add', plain: true }).click(crtGoods);
    $("#mainEdit").linkbutton({ iconCls: 'icon-edit', plain: true }).linkbutton("disable");
    $("#mainSearch").linkbutton({ iconCls: 'icon-search', plain: true }).click(serach);
    $("#mainReset").linkbutton({ iconCls: 'icon-undo', plain: true }).click(rstSearch);
    $("#putOn").linkbutton({ iconCls: 'icon-ok', plain: true }).linkbutton("disable");
    $("#putOff").linkbutton({ iconCls: 'icon-stop', plain: true }).linkbutton("disable");
    $("#putDown").linkbutton({ iconCls: 'icon-cancel', plain: true }).linkbutton("disable");
    //win
    upPic();//图片上传
    $("#winSave").linkbutton({ iconCls: 'icon-save', plain: true }).click(saveGoods);
    $("#winClose").linkbutton({ iconCls: 'icon-undo', plain: true }).click(clsWin);
    $("#delPic").click(delPic);
    //验证
    $("#info input[name=txtName]").validatebox({ required: true });
    $("#info input[name=txtPrice]").validatebox({ required: true });
    $("#info input[name=txtSpec]").validatebox({ required: true });
    $("#info input[name=txtRetailPrice]").validatebox({ required: true });
    
    $("#picShow").html("");
    $("#txtPicPath").change(function () {
        var value = $(this).children('option:selected').val();
        if (value == "") {
            return;
        }
        sltPic(value);
    });
}
function initGrid(XMLData) {
    $("#tab_list").datagrid({
        url: GetWSRRURL('881346c3-1b26-4530-a894-c90dcb4d8344') + "&XML=" + XMLData,
        fit: true,
        striped: true,
        singleSelect: true, //单行选择
        pagination: true, //是否开启分页
        pageSize: 20, //默认一页数据条数 
        rownumbers: true,//行号
        columns: [[
            { field: 'ck', checkbox: true },
            { field: 'picpath', title: '商品图片' },
            { field: 'goodsno', title: '商品编号', width: 100 },
            { field: 'name', title: '商品名称', width: 150 },
            { field: 'categoryname', title: '商品类别', width: 80 },
            { field: 'status', title: '商品状态', width: 80 },
            { field: 'spec', title: '商品规格', width: 80 },
            { field: 'price', title: '商品原价', width: 80 },
            { field: 'retailprice', title: '商品现价', width: 80 },
            { field: 'description', title: '商品简述', width: 150 },
            { field: 'detail', title: '商品描述', width: 200 },
            { field: 'createuser', title: '创建人', width: 80 },
            { field: 'createtime', title: '创建时间', width: 80 }
        ]],
        onClickRow: function (rowIndex, rowData) {
            var status = rowData.status;
            if (status == "未上架") {
                $("#putOn").linkbutton("enable").unbind("click").click(function () { chooseOnOff("on") });
                $("#putDown").linkbutton("enable").unbind("click").click(function () { chooseOnOff("down") });
                $("#mainEdit").linkbutton("enable").unbind("click").click(edtGoods);
                $("#putOff").linkbutton("disable").unbind("click");
            } else if(status == "已上架") {
                $("#putOn").linkbutton("disable").unbind("click");
                $("#mainEdit").linkbutton("disable").unbind("click");
                $("#putDown").linkbutton("disable").unbind("click");
                $("#putOff").linkbutton("enable").unbind("click").click(function () { chooseOnOff("off") });;
            };
        }
    });
    //款图代码
    var $dg = $('#tab_list');
    var col = undefined;
    col = $dg.datagrid('getColumnOption', 'picpath');
    if (col != null) {
        col.formatter = function (value) {
            var strs = new Array(); //定义一数组 
            strs = value.split(","); //字符分割 
            var date = "<a href='" + strs[0] + "' target='_blank'><img  src='" + strs[0] + "' style='height:60px'/></a>";
            this.formatDataType = "Pic";
            return date;
        }
    };
}
function initWin(status) {
    $("#window").window({
        title: "商品维护",
        collapsible: false,
        minimizable: false,
        maximizable: false,
        closable: false,
        resizable: false,
        modal: true,
        width: 600,
        height: 520,
        top: 20
    });

    if (status == "open") {
        $("#window").window("open");
    } else {
        $("#window").window("close");
    }
}
function upPic() {
    //文件上传相关-----------------
    var btnUpExcel = $('#uploadPic'), interval;

    new AjaxUpload(btnUpExcel, {
        action: '/Handler_HZY_Present.ashx?filePath=Present',
        name: 'myfile',
        onSubmit: function (file, ext) {
            $.messager.progress({ title: '请稍后', msg: '上传中' });
            if (!(ext && /^(jpg|jpeg|png|JPG|JPEG|PNG)$/.test(ext))) {
                alert('文本格式不正确,请选择 jpg,png 格式的文件!', '系统提示');
                return false;
            };
            this.disable();
        },
        onComplete: function (file, response) {
            this.enable();
            var k = response.match(/\{ ?"rows":.*,"total":[0-9]+\}/g);
            //var k = response.replace("<pre>", "").replace("</pre>", "").replace("<PRE>", "").replace("</PRE>", "").replace("<pre.*\">", "");
                //k = k.replace(/^"<.*">/g, "");
            if (k.length != 0){
                try {
                    var k0 = k[0];
                    var result = eval("[" + k0 + "]");
                    if (result[0].Error) {
                        $.messager.progress('close');

                        $.messager.alert("系统错误", result[0].Error, 'error');
                    }
                    else if (result[0].rows[0].result == "False") {
                        var errormessage = result[0].rows[1].message;

                        $.messager.progress('close');

                        alert(result[0].rows[0].message + '\r' + errormessage);
                    }
                    else {
                        $.messager.progress('close');
                        //获取select最大索引
                        var value = result[0].rows[0].message;
                        $("#txtPicPath").append("<option value=" + value + ">" + value + "</option>");
                    }
                } catch (ex) {
                    $.messager.progress('close');

                    $.messager.alert("提示", ex, 'error');
                }
            }

        }
    });
    //文件上传相关-----------------
}

//新建商品
function crtGoods() {

    $("#tab_Form input[type!=button]").val("");
    $("#tab_Form textarea").val("");
    $("#tab_Form select").val("");

    $("#GoodsNo").val("系统生成");
    initWin("open");
}
//修改商品
function edtGoods() {
    var sltData = $("#tab_list").datagrid("getSelected");
    if (sltData == null) { $.messager.alert("提示", "请选择操作行", "warning"); return; };

    $("#GoodsNo").val("").val(sltData.goodsno);
    $("#info input[name=txtName]").val("").val(sltData.name);
    $("#info input[name=txtPrice]").val("").val(sltData.price);
    $("#info input[name=txtRetailPrice]").val("").val(sltData.retailprice);
    $("#info input[name=txtSpec]").val("").val(sltData.spec);
    $("textarea[name=txtDescription]").val("").val(sltData.description);
    $("textarea[name=txtDetail]").val("").val(sltData.detail);

    var opn = sltData.picpath;
    var opnArray = [];
    var option = "";
    opnArray = opn.split(",");
    if (opnArray.length != 0) {
        for (i = 0; i < opnArray.length; i++) {
            option += "<option value=" + opnArray[i] + ">" + opnArray[i] + "</option>";
        }
        $("#txtPicPath").html("").append(option);
    };

    initWin("open");
}
//选择图片
function sltPic(value) {
    var img = "<img style='width:100px;height:100px' src=\"" + value + "\"/>";
    $("#picShow").html("").html(img);
}
//删除图片
function delPic() {
    var value = $("select").children('option:selected').index();
    if (value == -1) return;

    $("select").find("option:selected").remove();
    $("#picShow").html("");
}
//保存商品
function saveGoods() {
    var isTrue = $("#winForm").form("validate");
    if (isTrue) {
        var xml ="";
        var selAllData = "";
        var data = $("#winForm").serializeArray();
        var index = $("#txtPicPath").find("option:last").index();
        if (index != -1) {
            $("#txtPicPath option").each(function () {
                selAllData += $(this).val() + ",";
            });
            selAllData = selAllData.substr(0, selAllData.length - 1);   //去掉最后一个逗号
        };
        data[data.length] = { "name": "txtPicPath", "value": selAllData };

        var GoodsNo = $("#GoodsNo").val();
        if (GoodsNo == "系统生成") {
            xml = GetFormJson(data, "SaveNew");
        } else {
            var mainData = $("#tab_list").datagrid("getSelected");//取guid
            data[data.length] = { "name": "txtGoodsID", "value": mainData.goodsid };
            mainData = null;
            xml = GetFormJson(data, "SaveEdit");
        };
        xml = escape(xml);
        xml = xml.replace(/\%3C/g, "<").replace(/\%3E/g, ">");
        data = null;
        submit(xml);
    };
}
//提交入口
function submit(xml) {
    $.messager.confirm('提示框', '是否确认提交', function (r) {
        if (r) {
            var url = GetWSRRURL('881346c3-1b26-4530-a894-c90dcb4d8344');
            $.post(url + "&XML=" + xml, function (result) {
                try {
                    var result = eval("[" + result + "]");
                    if (result[0].Error) {
                        $.messager.progress('close');

                        $.messager.alert("系统错误", result[0].Error, 'error');
                    }
                    else if (result[0].rows[0].result == "False") {
                        var errormessage = result[0].rows[1].message;

                        $.messager.progress('close');

                        alert(result[0].rows[0].message);
                    }
                    else {
                        $.messager.progress('close');
                        $.messager.alert("提示", result[0].rows[0].message, "ok");
                        initWin("close");
                        $("#tab_list").datagrid("reload");
                    }
                } catch (ex) {
                    $.messager.progress('close');
                    $.messager.alert("提示", ex, 'error');
                };
            });
        };
    });
}
//关闭窗口
function clsWin() {
    $("#txtPicPath option").each(function () {
        $(this).remove();
    });
    $("#picShow").html("");

    $("#info input[name]").val("");

    $("textarea").val("");

    initWin("close");
}
//查询
function serach() {
    var data = $("#serachForm").serializeArray();
    var XMLData = GetFormJson(data, "Search");
    XMLData = escape(XMLData);
    XMLData = XMLData.replace(/\%3C/g, "<").replace(/\%3E/g, ">");

    initGrid(XMLData);
}
//清空查询
function rstSearch() {
    $("#serachForm input").val("");
}
//上下架，删除
function chooseOnOff(whichone) {
    var data = [];
    var sltData = $("#tab_list").datagrid("getSelected");
    var XMLData = "";

    if (sltData == null) { $.messager.alert("提示", "请选择操作行", "warning"); return; };

    data[data.length] = { "name": "txtGoodsID", "value": sltData.goodsid };

    if (whichone == "on") {
        data[data.length] = { "name": "txtStatus", "value": "已上架" };
    } else if (whichone == "off") {
        data[data.length] = { "name": "txtStatus", "value": "未上架" };
    } else if (whichone == "down") {
        data[data.length] = { "name": "txtStatus", "value": "已删除" };
    };
    XMLData = GetFormJson(data, "UptStatus");
    XMLData = escape(XMLData);
    XMLData = XMLData.replace(/\%3C/g, "<").replace(/\%3E/g, ">");
    sltData = null;
    submit(XMLData);
}
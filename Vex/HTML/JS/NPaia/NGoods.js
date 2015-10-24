//
//WSID:50156559-98fe-4ea4-b5bb-3e42f2de0cb5     服务路径：/DRP/Style/F22/NPAIA
//WSID:df8dc27e-703a-4f79-ac01-f9efe6dfad1f     服务路径：/C3/Style/C3Portal/NPAIA
//WSID:3b0844c9-670a-477d-8db5-d80936dde290     服务内容: 更新按钮API
//

var GV = {};

GV.JSON = {
    data: {},
    combData: [{ "id": "15", "text": "未上架" }, { "id": "20", "text": "上架" }, { "id": "90", "text": "下架" }, { "id": "99", "text": "删除" }],
    rowdata: null
};

GV.Pic = {
    type: undefined,
    smallPicMaxNum: 0,
    bigPicMaxNum: 0,
    maxNum: 0,
    picPatch: "",
    bigPatch: "",
    picName: ""
};

GV.Button = {
    id: ""
}
//初始化
$(document).ready(function () {

    //按钮
    $('#btnSave').linkbutton({ iconCls: 'icon-save', plain: true });
    $('#btnClose').linkbutton({ iconCls: 'icon-undo', plain: true });
    $('#btnSearch').linkbutton({ iconCls: 'icon-search', plain: true });
    $('#btnMainClean').linkbutton({ iconCls: 'icon-undo', plain: true });
    $('#btnNewGoods').linkbutton({ iconCls: 'icon-add', plain: true });
    $('#btnEditGoods').linkbutton({ iconCls: 'icon-edit', plain: true });
    $('#btnUpdate')
        .linkbutton({ iconCls: 'icon-edit', plain: true })
        .click(function () { btnUpData(); });
    //批量更新按钮
    $('#btnMainState').linkbutton({ iconCls: 'icon-edit', plain: true })
        .click(winStateOpen);
    //批量更新保存按钮
    $('#btnState').linkbutton({ iconCls: 'icon-save', plain: true })
        .click(saveState);

    //回车事件
    $('#txtCode').keydown(function(e){
        if (e.keyCode == 13) {
            var styleData = $('#txtCode').val();
            //检查款式信息
            var data = [];
            data[data.length] = { "name": "txtCode", "value": styleData };
            var XMLData = GetFormJson(data, 'CheckStyle')
            var result = $.ajax({
                url: GetWSRRURL('df8dc27e-703a-4f79-ac01-f9efe6dfad1f'),
                data: { "XML": XMLData },
                type: 'post',
                async: false
            });
            var result = $.parseJSON(result.responseText);
            var check = result.rows[0].message;
            if (check == 1) {
                alert('款式已存在，请检查');
                return;
            }
            //取款式信息
            if (getStyleData(styleData)) {
                //加载颜色尺码
                $('#color_size').datagrid('loadData', GV.JSON.data);

                maxImagepath();

                $("#bigPicUp").show();
                $("#picUp").show();

                pic_onSubmit("picUp");
                pic_onSubmit("bigPicUp");

            };

        }
    });

    //禁用退格事件
    document.onkeydown = check;


    //主界面dg
    initGird("");

    //主界面combobox
    $('#year').combobox({
        //required: true,
        url: GetComboxWSRRURL('df8dc27e-703a-4f79-ac01-f9efe6dfad1f', "", "STYL_Year", "STYL_Year") + "&XML=" + GetFormJson([], 'GetYear'),
        type: 'post',
        editable: false,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto'
    });
    $('#subClass').combobox({
        //required: true,
        url: GetComboxWSRRURL('df8dc27e-703a-4f79-ac01-f9efe6dfad1f', "", "STYL_SubClass", "STYL_SubClass") + "&XML=" + GetFormJson([], 'GetSubClass'),
        type: 'post',
        editable: false,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto'
    });
    $('#season').combobox({
        //required: true,
        url: GetComboxWSRRURL('df8dc27e-703a-4f79-ac01-f9efe6dfad1f', "", "STYL_Season", "STYL_Season") + "&XML=" + GetFormJson([], 'GetSeason'),
        type: 'post',
        editable: false,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto'
    });
    $('#class').combobox({
        //required: true,
        url: GetComboxWSRRURL('df8dc27e-703a-4f79-ac01-f9efe6dfad1f', "", "STYL_Class", "STYL_Class") + "&XML=" + GetFormJson([], 'GetClass'),
        type: 'post',
        editable: false,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto'
    });
})


//主界面dg
function initGird(where) {
    $('#tab_list').datagrid({
        url: GetWSRRURL('df8dc27e-703a-4f79-ac01-f9efe6dfad1f'),
        queryParams: { "XML": GetFormJson([], 'GetStyleInfoVex'),"WHERE":where },
        title: '商品列表',
        width: '90%',
        sortName: 'styl_rgdt',
        sortOrder: 'desc',
        singleSelect: true,
        selectOnCheck: false,//check开启
        checkOnSelect: true,
        loadMsg: "加载中,请稍等",
        striped: true,
        fit: true,
        columns: [[
            { field: 'styl_id', hidden: true },
            { field: 'ck', checkbox: true },
            { field: 'styl_picturepath', title: '款图', width: 70 },
            { field: 'styl_Code', title: '款式编号', width: 120 },
            { field: 'styl_name', title: '产品名称', width: 60 },
            { field: 'styl_class', title: '大类', width: 60 },
            { field: 'styl_subclass', title: '小类', width: 60 },
            { field: 'statename', title: '状态', width: 60 },
            { field: 'styl_price', title: '吊牌价', width: 100, align: 'right', formatter: Formater.Account },
            { field: 'styl_sellprice', title: '结算价', width: 100, align: 'right', formatter: Formater.Account },
            { field: 'styl_type', title: '风格线', width: 80 },
            { field: 'styl_property1', title: '备用属性1', width: 90 },
            { field: 'styl_property2', title: '备用属性2', width: 90 },
            { field: 'styl_property3', title: '备用属性3', width: 90 },
            { field: 'styl_property4', title: '备用属性4', width: 90 },
            { field: 'styl_rgdt', title: '创建时间', width: 77, formatter: Formater.Date }
        ]],
        pagination: true, //是否开启分页
        //tpageNumber: 1, //默认索引页
        pageSize: 20, //默认一页数据条数
        onClickRow: function (rowIndex, rowData) {
            GV.JSON.rowdata = rowData;
            GV.Pic.picPatch = rowData.styl_picturepath;
            GV.Pic.bigPatch = rowData.styl_bigpicturepath;
            //抽取SKU数据
            htmlobj = $.ajax({
                url: GetWSRRURL('df8dc27e-703a-4f79-ac01-f9efe6dfad1f'),
                data: { "XML": GetFormJson([], 'GetStyleSKU'), "WHERE": "STL2_STYL_ID='" + rowData.styl_id + "'" },
                type: 'post',
                async: false
            });
            var result = $.parseJSON(htmlobj.responseText);
            //组JSON
            colorsizeJSON('edit',result.rows.length, result);
        }
    });
    //款图代码
    var $dg = $('#tab_list');
    var col = undefined;
    col = $dg.datagrid('getColumnOption', 'styl_picturepath');
    if (col != null) {
        col.formatter = function (value) {
            var strs = new Array(); //定义一数组 
            strs = value.split(","); //字符分割 
            var date = "<a href='" + strs[0] + "' target='_blank'><img  src='" + strs[0] + "' style='height:60px'/></a>";
            this.formatDataType = "Pic";
            return date;
        }
    }
}

//新建修改按钮
function btnGoods(type) {
    if (type == 'edit') {
        if (GV.JSON.rowdata == null) {
            jQuery.messager.alert("警告", "请选中一行", "warning");
            return;
        };
        var data = GV.JSON.rowdata;
        if (data != null) {
            $('#txtCode').val(data.styl_code);
            $('#txtName').val(data.styl_name);
            $('#txtYear').val(data.styl_year);
            $('#txtSeason').val(data.styl_season);
            $('#txtType').val(data.styl_type);
            $('#txtClass').val(data.styl_class);
            $('#txtSubClass').val(data.styl_subclass);
            $('#txtPrice').val(data.styl_price);
            $('#txtSellPrice').val(data.styl_sellprice);
            $('#txtProperty1').val(data.styl_property1);
            $('#txtProperty2').val(data.styl_property2);
            $('#txtProperty3').val(data.styl_property3);
            $('#txtProperty4').val(data.styl_property4);
            $('#txtSTYL_Desp').val(data.styl_desp);
            $('#cmbStatus').combobox().combobox('setValue', data.styl_state);
        }
    };
    //初始化
    win(type);

    //开启窗口
    $('#winEdit').window({
        //width: 1000,
        //height: 500,
        top: 10,
        maximized: true,
        title: '商品维护'
    }).window('open');
    $('#txtType').focus;
}

//初始化新建窗口
function win(type) {
    
    if (type == 'new') {
        //解除只读属性
        $('#txtCode').attr("readonly", "readonly");
        $('#txtCode').removeAttr("readonly");
        //初始化
        $('#formGoods :input').val('');

        $('#winType').val('new');
        //清空下拉选择
        $('#txtPicturePath').find("option").remove();;
        $('#txtBigPicPath').find("option").remove();;
        colorsizeGrid();
        //清空尺码
        ClearGrid("#color_size");
        $("#picUp").hide();
        $("#bigPicUp").hide();

        $('#txtCode').focus();
    } else {

        $("#picUp").show();
        $("#bigPicUp").show();

       

        $('#formGoods').form('validate');
        $('#txtCode').attr("readonly", "readonly");

        $('#txtPicturePath').find("option").remove();;
        $('#txtBigPicPath').find("option").remove();;

        $('#winType').val('edit');

        colorsizeGrid();
        $('#color_size').datagrid('loadData', GV.JSON.data);
        //select 添加选择项
        if (GV.Pic.picPatch != "") {
            var strs = new Array(); //定义一数组 
            strs = GV.Pic.picPatch.split(","); //字符分割
            var select = $('#txtPicturePath');

            if (strs[strs.length - 1] == "") {
                strs.length = strs.length -1;
            }

            for (i = 0; i <= strs.length - 1; i++) {
                select.append("<option value='" + strs[i] + "'>" + strs[i] + "</option>");
            };
        }
        if (GV.Pic.bigPatch != "") {
            var strs = new Array(); //定义一数组 
            strs = GV.Pic.bigPatch.split(","); //字符分割
            var select = $('#txtBigPicPath');
            if (strs[strs.length - 1] == "") {
                strs.length = strs.length - 1;
            }
            for (i = 0; i <= strs.length - 1; i++) {
                select.append("<option value='" + strs[i] + "'>" + strs[i] + "</option>");
            };
        };
        maxImagepath();
        pic_onSubmit("picUp");
        pic_onSubmit("bigPicUp");
    };
    //下拉框
    $('#cmbStatus').combobox({
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        required: true
    }).combobox('loadData', GV.JSON.combData);

    if (type == 'new') {
        $('#cmbStatus').combobox('setValue', '15');
    } else {
        var state = GV.JSON.rowdata.styl_state;
        $('#cmbStatus').combobox('setValue', state);
    };

    $('#txtType').focus;
    $('#picShow').html("");
    $('#picBigShow').html("");
}

//颜色尺码dg
function colorsizeGrid() {
    $('#color_size').datagrid({
        title: '颜色尺码',
        width: '200',
        height: '200',
        singleSelect: true,
        columns: [[
        { field: 'colorid', title: '颜色', width: 80 },
        { field: 'sizeid', title: '尺码', width: 80 }
        ]]
    });
    ClearGrid("#color_size");
}

//取款式数据
function getStyleData(style) {
        var chk_styleid = style;
        XMLData = GetFormJson('', 'GetStyleSKU');
        htmlobj = $.ajax({
            url: GetWSRRURL('50156559-98fe-4ea4-b5bb-3e42f2de0cb5'),
            data: { "XML": XMLData, "WHERE": "CL.styleid='" + chk_styleid + "'" },
            type: 'post',
            async: false
        });
        var result = $.parseJSON(htmlobj.responseText);
        if (result.rows[0].styleid != "") {

            //取行数
            var rowCount = result.rows.length;
            var price = result.rows[0].j_price;//吊牌价

            //赋值
            $('#txtName').val(result.rows[0].s_name); //产品名称
            $('#txtType').val(); //风格
            $('#txtClass').val(result.rows[0].st_dl); //大类
            $('#txtSubClass').val(result.rows[0].st_xz); //小类
            $('#txtPrice').val(price); //吊牌价
            $('#txtYear').val(result.rows[0].st_year);  //年
            $('#txtSeason').val(result.rows[0].st_month) //季节
            var WXprice = price * 0.88; //微信价
            $('#txtSellPrice').val(WXprice); //销售价

            //组尺码颜色组的JSON
            colorsizeJSON('new',rowCount, result);

            return true;
        }
        else {
            alert('款号不存在，请检查');
            return false;
        };
}


//文件上传
function pic_onSubmit(id) {
    var btn = document.getElementById(id);
    var button = $(btn);
    GV.Pic.picName = picName(id);
    var test = new AjaxUpload(button, {
        //action: 'upload-test.php',文件上传服务器端执行的地址
        action: '/Handler_Upload.ashx?filePath=NPaia_Goods&fileName=' + GV.Pic.picName,
        name: 'fileName',
        inputName: $('#txtCode').val(),
        onSubmit: function (file, ext) {
            if (!(ext && /^(jpg|jpeg|png|JPG|JPEG|PNG)$/.test(ext))) {
                alert('文本格式不正确,请选择 jpg,png 格式的文件!', '系统提示');
                return false;
            };
            // change button text, when user selects file
            button.val('文件上传中');
            // If you want to allow uploading only 1 file at time,
            // you can disable upload button
            this.disable();
            // Uploding -> Uploading. -> Uploading...
            interval = window.setInterval(function () {
                var text = button.val();
                if (text.length < 10) {
                    button.val(text + '.');
                } else {
                    button.val('文件上传中');
                }
            }, 200);
        },
        onComplete: function (file, response) {
            //file 本地文件名称，response 服务器端传回的信息
            button.val('上传');

            window.clearInterval(interval);

            // enable upload button
            this.enable();
            var k = response.replace("<pre>", "").replace("</pre>", "").replace("<PRE>", "").replace("</PRE>", "");

            try {
                var result = eval("[" + k + "]");
                if (result[0].Error) {
                    $.messager.progress('close');

                    $.messager.alert("系统错误", result[0].Error, 'error');
                }
                else if (result[0].rows[0].result == "False") {

                    $.messager.progress('close');

                    $.messager.alert("提示", result[0].rows[0].message, 'error');
                }
                else {
                    this.disable();
                    var value = result[0].rows[0].message;
                    col_add(id, value);
                    GV.Pic.picName = picName(id);

                    if (id == "picUp") {
                        GV.Pic.smallPicMaxNum = GV.Pic.smallPicMaxNum + 1;
                    }
                    else {
                        GV.Pic.bigPicMaxNum = GV.Pic.bigPicMaxNum + 1;
                    }
                    pic_onSubmit(id);
                }
            } catch (ex) {
                $.messager.progress('close');

                $.messager.alert("提示", ex, 'error');
            }
        }
    });
    //文件上传相关-----------------
}

//图片名字
function picName(htmlId) {
    var picName = $('#txtCode').val();
    var maxNum = "";
    //上传图片
    if (htmlId == "picUp") {

        if (GV.Pic.smallPicMaxNum < 10) {
            maxNum = '0' + GV.Pic.smallPicMaxNum;
        }
        else {
            maxNum = GV.Pic.smallPicMaxNum;
        }

        picName += "TP" + maxNum;

    } else if (htmlId == "bigPicUp") {

        if (GV.Pic.bigPicMaxNum < 10) {
            maxNum = '0' + GV.Pic.bigPicMaxNum;
        }
        else {
            maxNum = GV.Pic.bigPicMaxNum;
        };
        //取名
        picName += "DT" + maxNum;
    };
    return picName;
}

//计算图片名流水号最大值
function maxImagepath() {

    var smallPicNameToNum = $("#txtPicturePath").find("option:last").index();
    var bigPicNameToNum = $("#txtBigPicPath").find("option:last").index();

    if (smallPicNameToNum == -1) {
        GV.Pic.smallPicMaxNum = 1;
    } else {
        var $options = $("#txtPicturePath option");

        var optionsLastValue = $("#txtPicturePath").find("option:last").val();
        var opMaxNum = /TP[0-9][0-9]/.exec(optionsLastValue);

        for (i = 0; i < $options.length - 1; i++) {
            var optionsValue = $options[i].value;
            var checkNum = /TP[0-9][0-9]/.exec(optionsValue);

            if (checkNum > opMaxNum) {
                opMaxNum = checkNum;
            };
        };

        opMaxNum = opMaxNum[0].substr(2);

        GV.Pic.smallPicMaxNum = +opMaxNum + 1;
    };

    if (bigPicNameToNum == -1) {
        GV.Pic.bigPicMaxNum = 1;
    } else {
        var $options = $("#txtBigPicPath option");

        var optionsLastValue = $("#txtBigPicPath").find("option:last").val();
        var opMaxNum = /DT[0-9][0-9]/.exec(optionsLastValue);

        for (i = 0; i < $options.length - 1; i++) {
            var optionsValue = $options[i].value;
            var checkNum = /DT[0-9][0-9]/.exec(optionsValue);

            if (checkNum > opMaxNum) {
                opMaxNum = checkNum;
            };
        };

        opMaxNum = opMaxNum[0].substr(2);

        GV.Pic.bigPicMaxNum = +opMaxNum + 1;
    };
}



//颜色尺码的JSON
function colorsizeJSON(type, row, result) {
    var jdata = "";
    var color, size;
    for (i = 0; i <= row - 1; i++) {
        //根据result类型获取颜色和尺码的值
        if (type == 'edit') {
            color = result.rows[i].stl2_color;
            size = result.rows[i].stl2_size
        } else {
            color = result.rows[i].c_name;
            size = result.rows[i].sizeid;
        };

        if (i == 0 && i != row - 1) {
            jdata = '[{"colorid":"' + color + '","sizeid":"' + size + '"},';
        };
        if (i != 0 && i < row - 1) {
            jdata += '{ "colorid":"' + color + '","sizeid":"' + size + '"},';
        };
        if (i != 0 && i == row - 1) {
            jdata += '{ "colorid":"' + color + '","sizeid":"' + size + '"}]';
        };
        if (i == 0 && i == row - 1) {
            jdata = '[{"colorid":"' + color + '","sizeid":"' + size + '"}]';
        }
    };
    
    GV.JSON.data = {"total": row, "rows": eval(jdata) };
}

//赋值选择
function col_add(id, text) {
    if (id == "picUp") {
        var selObj = $("#txtPicturePath");
    } else {
        var selObj = $("#txtBigPicPath");
    }
    selObj.append("<option>" + text + "</option>");
}

//显示图片
function selectviw(id,picid) {
    eval("var selOpt" + "=" + "$('#" + id + " option:selected " + "')");
    eval("var picShow" + "=" + "$('#" + picid + " option:selected " + "')");

    var domObj = document.getElementById(picid);
    var jQyObj = $(domObj);

    if (selOpt == undefined || selOpt.length == 0) {
        return;
    } else {
        jQyObj.html("");
        $("<img style='width:100px;height:100px'/>").appendTo(jQyObj).attr("src", selOpt[0].innerHTML);
    }
}

//保存
function save() {
    var select_1 = "", select_2 = "";     //定义字符串
    var funType = "";
    
    if (!($('#formGoods').form('validate'))) { return; };

    //获取form数据
    var data = $('#formGoods').serializeArray();
    //新建
    if ($('#winType').val() == "new") {

        //获取颜色尺码数据
        var dgData = $('#color_size').datagrid('getData');
        var czXML = '<Root><OPTYPE>ColorSize</OPTYPE><List>'
        for (i = 0; i <= dgData.total - 1; i++) {
            if (i < dgData.total - 1) {
                czXML += "<rows><colorid>" + dgData.rows[i].colorid + "</colorid>";
                czXML += "<sizeid>" + dgData.rows[i].sizeid + "</sizeid></rows>";
            } else if (i == dgData.total - 1) {
                czXML += "<rows><colorid>" + dgData.rows[i].colorid + "</colorid>";
                czXML += "<sizeid>" + dgData.rows[i].sizeid + "</sizeid></rows>";
                czXML += "</List></Root>";
            }
        };
        //颜色尺码
        data[data.length] = { "name": "txtcorsie", "value": czXML };
        funType = 'AddStyleSKU';
    } else {
        data[data.length] = { "name": "txtSTYL_ID", "value": GV.JSON.rowdata.styl_id };
        funType = 'EditStyle';
    };

        //获取select的最大索引
        var indexPic = $("#txtPicturePath").find("option:last").index();
        var indexBig = $("#txtBigPicPath").find("option:last").index();

        //遍历select 取得图片的路径
        for (i = 0; i <= indexPic; i++) {
            if (i == 0 && i < indexPic) {
                select_1 = $("#txtPicturePath").get(0).options[i].text + ",";
            }
            if (i !=0 && i < indexPic) {
                select_1 += $("#txtPicturePath").get(0).options[i].text + ",";
            };
            if (i == indexPic) {
                select_1 += $("#txtPicturePath").get(0).options[i].text
            };
        };

        for (i = 0; i <= indexBig; i++) {
            if (i == 0) {
                select_2 = $("#txtBigPicPath").get(0).options[i].text + ",";
            }
            if (i!= 0 && i < indexBig) {
                select_2 += $("#txtBigPicPath").get(0).options[i].text + ",";
            };
            if (i == indexBig) {
                select_2 += $("#txtBigPicPath").get(0).options[i].text
            };
        };

        
        if (select_1 == "") {
            data[data.length] = { "name": "txtSTYL_PicturePath", "value": "" };
        } else {
            data[data.length] = { "name": "txtSTYL_PicturePath", "value": select_1 };
        };

        if (select_2 == "") {
            data[data.length] = { "name": "txtSTYL_BigPicturePath", "value": "" };
        } else {
            data[data.length] = { "name": "txtSTYL_BigPicturePath", "value": select_2 };
        };

        //data[data.length] = { "name": "txtSTYL_State", "value": $('#cmbStatus').combobox('getValue') };
        var XMLData = GetFormJson(data, funType);


    //提交
    $.ajax({
        url: GetWSRRURL('df8dc27e-703a-4f79-ac01-f9efe6dfad1f'),
        type: 'post',
        async: false, //同步,
        data: { "XML": XMLData },
        success: function (result) {
            try {
                var result = eval("[" + result + "]");
                if (result[0].Error) {
                    $.messager.progress('close');
                    $.messager.alert("系统错误", result[0].Error, 'error');
                }
                else if (result[0].rows[0].result == "False") {
                    $.messager.progress('close');
                    $.messager.alert("提示", result[0].rows[0].message, 'error');
                }
                else {
                    $.messager.alert("提示", result[0].rows[0].message, 'ok');
                    $('#txtCode').attr("readonly", "readonly");
                    $('#winType').val('edit');
                    $('#tab_list').datagrid('reload');
                };
            }
            catch (ex) {
                $.messager.progress('close');
                $.messager.alert("提示", ex, 'error');
            }
        },
        error: function () {
            $.messager.alert("提示", "提交错误了！", 'error');
        }
    });

}

//关闭窗口
function closeWin() {
    var winType = $('#winType').val();
    //清空数据
    win(winType);
    jQuery('#winEdit').window('close');



}

//主界面查询
function mainSearch() {
    var data = $('#mainForm').serializeArray();
    var str, where;

    for (i = 0; i <= data.length - 1; i++) {
        str += data[i].value;
    };

    if (str == "undefined") {
        initGird("");
        return;
    };

    if (data[0].value != "" && typeof(where) == "undefined") {
        where = " STYL_Code LIKE '%" + data[0].value + "%'";
    } else if (data[0].value != "" && typeof (where) != "undefined") {
        where += " AND STYL_Code LIKE '%" + data[0].value + "%'";
    };
    if (data[1].value != "" && typeof (where) == "undefined") {
        where = " STYL_Year = '" + data[1].value + "'";
    } else if (data[1].value != "" && typeof (where) != "undefined") {
        where += " AND STYL_Year = '" + data[0].value + "'";
    };
    if (data[2].value != "" && typeof (where) == "undefined") {
        where = " STYL_Season = '" + data[2].value + "'";
    } else if (data[2].value != "" && typeof (where).toString() != "undefined") {
        where += " AND STYL_Season = '" + data[0].value + "'";
    };
    if (data[3].value != "" && typeof (where) == "undefined") {
        where = " STYL_Class = '" + data[3].value + "'";
    } else if (data[3].value != "" && typeof (where) != "undefined") {
        where += " AND STYL_Class = '" + data[0].value + "'";
    };
    if (data[4].value != "" && typeof (where) == "undefined") {
        where = " STYL_SubClass = '" + data[4].value + "'";
    } else if (data[4].value != "" && typeof (where) != "undefined") {
        where += " AND STYL_SubClass = '%" + data[0].value + "%'";
    };
    if (data[5].value != "" && typeof (where) == "undefined") {
        where = " STYL_Name LIKE '%" + data[5].value + "%'";
    } else if (data[5].value != "" && typeof (where) != "undefined") {
        where += " AND STYL_Name LIKE '%" + data[0].value + "%'";
    };

    //加载数据
    initGird(where);
}

//主界面条件清空
function mainClean() {
    jQuery('#mainForm input').val('');
}

//禁用退格方法
function check(e) {
    var code;
    if (!e) var e = window.event;
    if (e.keyCode) code = e.keyCode;
    else if (e.which) code = e.which;
    else return;

    if (code == 8) {
        if (
            (event.srcElement.type != "text" &&
            event.srcElement.type != "textarea" &&
            event.srcElement.type != "password") ||
            event.srcElement.readOnly == true) {
            event.keyCode = 0;
            event.returnValue = false;
        };
        return true;
    };
}

//删除图片
function col_delete(id) {
    var selOpt = null;
    if (id == 'picDel') {
        selOpt = document.getElementById('txtPicturePath');
        $('#picShow').html("");
    } else {
        selOpt = document.getElementById('txtBigPicPath');
        $('#picBigShow').html("");
    };
    selOpt = $(selOpt).find('option:selected');
    selOpt.remove();
}

//更新按钮
function btnUpData() {
    if (GV.JSON.rowdata == null) {
        $.messager.alert('提示', '请选中需要更新的款式资料', 'warning');
        return;
    };
    var styleID = GV.JSON.rowdata.styl_id;
    var styleCode = GV.JSON.rowdata.styl_code;
    var upDateUser = GV.JSON.rowdata.styl_lmuser;

    var data = [];
    data[data.length] = { "name": "txt操作类型", "value": "UPDATE" };
    data[data.length] = { "name": "txtCONO", "value": "HYFG" };
    data[data.length] = { "name": "txtDIVI", "value": "D01" };
    data[data.length] = { "name": "txtGUID", "value": styleID };
    data[data.length] = { "name": "txt款号", "value": styleCode };
    //data[data.length] = { "name": "txt当前登陆人", "value": upDateUser };
    data[data.length] = { "name": "txt当前登陆人", "value": "张东明" };
    //调用API
    var XMLData = GetDBFrameAML(data);
    $.ajax({
        url: GetWSRRURL('3b0844c9-670a-477d-8db5-d80936dde290') + XMLData,
        type: 'post',
        async: false, //异步
        success: function (result) {
            try {
                var result = eval("[" + result + "]");
                var message = result[0].rows[0].msg;
                var messageArr = message.split(":");
                if (result[0].Error) {
                    $.messager.progress('close');
                    $.messager.alert("系统错误", result[0].Error, 'error');
                }
                else if (messageArr[0] == 9) {
                    $.messager.progress('close');
                    $.messager.alert("提示", messageArr[1], 'error');
                }
                else {
                    initGird("");
                    $.messager.alert("提示", '更新成功', 'ok');
                }
            }
            catch (ex) {
                $.messager.progress('close');
                $.messager.alert("提示", result[0].rows[0].msg, 'error');
            };
        },
        error: function () {
            $.messager.alert("提示", "提交错误了！", 'error');
        }
    });
}


//--------------批量更新------------

//批量状态更新窗口
function winStateOpen() {

    //状态框
    $("#state").combobox({
        editable: false,
        required: true,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto'
    }).combobox('loadData', GV.JSON.combData);

    //开启窗口
    $('#winState').window({
        width: 250,
        height: 150,
        top: 200,
        title: '商品维护'
    }).window('open');
};

//批量更新保存
function saveState() {
    var isValid = $("#winStateForm").form('validate');

    if (!isValid) {
        return;
    };

    $.messager.confirm("提示", "你确定要批量更新吗?", function (r) {
        if (r) {
            //勾选的数据
            var data = $("#tab_list").datagrid('getChecked');

            if (data.length == 0) {
                $.messager.alert("提示", "请勾选需要更新的行", "warning");
                return;
            };

            var XMLData = "<ROOT><OPTYPE>UPDateState</OPTYPE><LIST>";
            
            var state = $("#state").combobox('getValue');

            for (i = 0; i < data.length; i++) {
                XMLData += "<Rows><STYL_ID>" + data[i].styl_id + "</STYL_ID><STYL_State>" + state + "</STYL_State></Rows>";
            };

            XMLData += "</LIST></ROOT>";

            //提交更新

            $.post(GetWSRRURL('df8dc27e-703a-4f79-ac01-f9efe6dfad1f'), { "XML": XMLData }, function (data) {

                var result = eval("[" + data + "]");
                var message = result[0].rows[0].msg;

                $.messager.alert("提示", "更新成功");

                $("#winState").window("close");
                $('#tab_list').datagrid('reload');

            });

        }
    });
};
﻿
var depotInfo = null
$(document).ready(function () {

    //隐藏客户信息
    $("#clientInfo").hide();
    $("#selldatetr").hide();

    //初始化控件，基础信息
    initPlugin();

    $("#sku").textbox('textbox').bind('keydown', function (e) {
        if (e.keyCode == 13) {
            verifySKU();
        }
    });

    $("#SellDate").datebox({
        panelHeight:'250',
        formatter:function(date){
            var y = date.getFullYear();
            var m = date.getMonth()+1;
            if(m < 10){
                m = "0"+m;
            }
            var d = date.getDate();
            if(d < 10){
                d = "0"+d;
            }
            return y+'-'+m+'-'+d;
        },
        parser:function(s){
            var t = Date.parse(s);
            if (!isNaN(t)){
                return new Date(t);
            } else {
                return new Date();
            };
        }
    });

})

function initPlugin() {

    initTextBox();

    //店铺信息
    getDepotInfo();

    ////导购信息
    getSalesman();

    ////客户信息开关
    switchClient();

    //获取紧急程度
    getUrgentLeve();

    //快递公司
    getExpressInfo();

    //按钮
    initButton();

    //只读字段backspance事件
    screenBackspace();

    //初始化必填项
    initValidate();
    
}

function getDepotInfo() {

    depotInfo = null;
    var data = $.cookie('depotInfo');
    var mydate = new Date();
    var now = mydate.getFullYear()
        + "-" +
        (mydate.getMonth() + 1)
        + "-" +
        mydate.getDate();

    if (data != null) {

        depotInfo = eval("(" + data + ")");
    };

    if(depotInfo != null){

        //basicInfo
        $("#DepotId").append(depotInfo.rows[0].j_depotid);
        $("#DepotName").append(depotInfo.rows[0].j_name);
        $("#DepotPhone").append(depotInfo.rows[0].m_shoptel);
        $("#wxID").append(depotInfo.rows[0].j_wxid);
        $("#wxName").append(depotInfo.rows[0].j_wxname);
        $("#Date").append(now);
        $("#admin").append(depotInfo.rows[0].j_name);

        $("#shopadmin").textbox('setValue', depotInfo.rows[0].m_shopadmin);
        $("#shopadminmob").textbox('setValue', depotInfo.rows[0].m_shopadminmob);
        $("#depotaddress").textbox('setValue', depotInfo.rows[0].g_address);
        $("#wxaddress").textbox('setValue', depotInfo.rows[0].j_wxaddress);
        $("#wxadmin").textbox('setValue', depotInfo.rows[0].j_wxadmin);
        $("#wxshoptel").textbox('setValue', depotInfo.rows[0].m_wxshoptel);
    };
}

function getSalesman(){

    var url = GetWSRRURL('3a9cf88e-fc42-485d-9dff-96c35a8a1750')
        + "&XML=" + GetFormJson([], 'getSalesman');

    $.post(url, function (data) {
       var json = eval ("("+data+")");

       $("#supervisor").combobox({
            valueField: 'employeeid',
            textField:'names',
            required:true,
            width:200,
            height:32,
            panelHeight:"auto",
            data: json.rows,
            onLoadSuccess:function(){
                $("#supervisor").combobox('setValue',json.rows[0].employeeid);
                $("#supervisormob").textbox('setValue',json.rows[0].telephone);
            },
            onSelect:function(record){
                $("#supervisor").combobox('setValue',record.employeeid);
                $("#supervisormob").textbox('setValue',record.telephone);
            }
       })

    });
}

function getUrgentLeve(){
    var url = GetWSRRURL('3a9cf88e-fc42-485d-9dff-96c35a8a1750')
        + "&XML=" + GetFormJson([], 'getUrgentLeve');

    $.post(url, function (data) {
       var json = eval ("("+data+")");

       $("#UrgentLeve").combobox({
            valueField: 'value',
            textField:'name',
            required: true,
            editable: false,
            width:200,
            height:32,
            panelHeight:"auto",
            data: json.rows,
            onLoadSuccess:function(){
                $("#UrgentLeve").combobox('setValue',json.rows[2].value);
            }
       })

    });
}

function switchClient(){

    //增加散客判断
    $("#switch2").switchbutton({
        onText: 'VIP',
        offText: '散客',
        disabled:true,
        onChange:function(checked){
            if(checked){//VIP
                $("#VipId")
                    .textbox({ required: true, disabled: false })
                    .textbox('reset');
                initVipEvent();

                $("#submit").linkbutton("disable");
                $("#tishi").empty().append("输入卡号后按回车查询.");
                $("#wait").empty().append("按回车验证，否则无法提交.");
            }else{//散客
                $("#VipId").textbox({ required: false,disabled:true }).textbox('reset');
                $("#VipName").textbox('clear');
                $("#VipPhone").textbox('clear');
                $("#wait").empty();
                $("#tishi").empty();
                $("#submit").linkbutton("enable");
                
            };
        }
    });

    $("#switch").switchbutton({
        width:100,
        // height:30,
        onText:"顾客维修",
        offText:"未售维修",
        onChange: function(checked){
            if (checked) {//顾客维修
                $("#sku").textbox('clear');
                $("#submit").linkbutton("disable");

                $("#VipId").textbox('reset');
                $("#VipName").textbox('clear');
                $("#VipPhone").textbox('clear');
                $("input[name='pay']").attr("checked",false);

                $("#clientInfo").show();
                $("#selldatetr").show();
                $("#submit").linkbutton("enable");
                $("#switch2").switchbutton('enable');
            } else {//未售维修
                $("#wait").empty();
                $("#sku").textbox('clear');
                $("#submit").linkbutton("enable");

                $("#VipId").textbox('reset');
                $("#VipName").textbox('clear');
                $("#VipPhone").textbox('clear');
                $("input[name='pay']").attr("checked",false);
                $("#clientInfo").hide();
                $("#selldatetr").hide();

                $("#switch2").switchbutton('disable').switchbutton('reset');
            };
        }
    });
}

function initVipEvent(){
    $("#VipId").textbox('textbox')
         .unbind('keydown',function(e){
            return;
         })
         .bind('keydown', function (e) {
             if (e.keyCode == 13) {   // when press ENTER key, accept the inputed value.
                 getVipInfo();
             }
         });
}

function getVipInfo(){

    var vipid = $("#VipId").textbox('getValue');

    if(vipid.length == 0){
        alert("请输入VIP卡号");
        
        return;
    };

    var url = GetWSRRURL('3a9cf88e-fc42-485d-9dff-96c35a8a1750')
        + "&XML=" + GetFormJson(
            [{"name":"txtVipId","value":vipid}], 'getVipInfo');
    $.messager.progress({ title: '请稍后', msg: '处理中' });
    $.post(url,function(data){
        $.messager.progress('close');
        var json = eval("(" + data + ")");

        if (json.rows.length > 0) {

            //判断是否为空
            if (json.rows[0].mobtel.length == 0) {
                alert("无会员信息，请核对VIP卡号！");
                return;
            };

            $("#VipName").textbox('setValue',"")
                .textbox("setValue",json.rows[0].vipname);
            $("#VipPhone").textbox('setValue',"")
                .textbox("setValue",json.rows[0].mobtel);
        };
    })
}

function getExpressInfo(){

    var url = GetWSRRURL('3a9cf88e-fc42-485d-9dff-96c35a8a1750')
        + "&XML=" + GetFormJson([], 'getExpressInfo');

    $.post(url,function(data){
        var json = eval("(" + data + ")");

        if (json.rows.length > 0) {

            $("#express").combobox({
                valueField:'value',
                textField:'name',
                width:200,
                height:32,
                panelHeight:'auto',
                required:true,
                data:json.rows,
                onLoadSuccess:function(){
                    $("#express").combobox('setValue',json.rows[0].value);
                },
                onSelect:function(record){
                    if (record.value == 'self') {
                        $("#expressNo").textbox({ required: false }).textbox('reset');
                        $("#depotaddress").textbox({ required: false }).textbox('reset');
                        $("#wxaddress").textbox({ required: false }).textbox('reset');
                        $("#wxadmin").textbox({ required: false }).textbox('reset');
                        $("#wxshoptel").textbox({ required: false }).textbox('reset');
                    }else{
                        $("#expressNo").textbox({ required: true }).textbox('reset');
                        $("#depotaddress").textbox({ required: true }).textbox('reset');
                        $("#wxaddress").textbox({ required: true }).textbox('reset');
                        $("#wxadmin").textbox({ required: true }).textbox('reset');
                        $("#wxshoptel").textbox({ required: true }).textbox('reset');

                        $("#depotaddress").textbox('setValue', depotInfo.rows[0].g_address);
                        $("#wxaddress").textbox('setValue', depotInfo.rows[0].j_wxaddress);
                        $("#wxadmin").textbox('setValue', depotInfo.rows[0].j_wxadmin);
                        $("#wxshoptel").textbox('setValue', depotInfo.rows[0].m_wxshoptel);
                    }

                }
            })
        };
    })
}

function verifySKU() {

   var sku = $("#sku").textbox("getValue");

   if (sku.length == 0) {
       $.messager.alert('提示', '请输入款号', 'warning');
        return;
   };

   
   var vipId = $("#VipId").textbox("getValue");

   //Vip卡号为空，则代表不是顾客维修。
   if (vipId.length == 0) {
       $.messager.alert("提示", "请输入VIP卡号", "warning");
       return;
   }else{
       var url = GetWSRRURL('3a9cf88e-fc42-485d-9dff-96c35a8a1750')
        + "&XML=" + GetFormJson(
            [{"name":"txtVipId","value":vipId},
            {"name":"txtSKU","value":sku}], 'getSKUCheck');
        $.messager.progress({title:"提示",msg:"正在验证"});
        $.post(url,function(data){
            $.messager.progress('close');
            var json = eval("("+data+")");

            if(json.rows[0].result == "True"){
                //售出日期
                $("#SellDate").datebox({
                        editable:false,
                        disabled:false
                    }).datebox('enable')
                    .datebox('setValue',json.rows[0].date);
                    
                $("#submit").linkbutton('enable');
                $("#wait").empty().append(json.rows[0].msg);
            }
            else if (json.rows[0].result == "False"){
                    $("#SellDate").datebox({
                        editable:false,
                        disabled:true}).datebox('setValue','');

                $("#submit").linkbutton('disable');
                $("#wait").empty().append(json.rows[0].msg);
            };

        });
   };
}

function initButton(){
    $("#submit").linkbutton({
        width:80,
        height:30,
        iconCls: 'icon-ok',
        disabled:false,
        onClick: function(){
            submit();
        }
    });
}

function screenBackspace(){
    $("input[readonly]").keydown(function(e) {
        if (e.keyCode == 8) {
            e.preventDefault();
        };
    });
}


/*
    保存的逻辑
    0.必填字段检查
    1.确定是什么维修类型
    2.再次验证必填项
    3.组织提交的数据
    4.提交
    3.成功关闭，并刷新主页面
    4.失败，等待再次提交
*/
function submit(){
    var data = [];

    //检验必填项
    if(!isVaild("formDepot","店铺信息")){
        return;
    };
    if(!isVaild("formWXInfo","维修产品信息")){
        return;
    };
    if(!isVaild("formExpress","快递信息")){
        return;
    };

    var cookie = $.cookie("depotInfo");
    cookie = eval("(" + cookie + ")");

    data.push({"name":"txtDepotId","value":cookie.rows[0].j_depotid});
    data.push({"name":"txtDepotName","value":cookie.rows[0].j_name});
    data.push({"name":"txtDepotPhone","value":cookie.rows[0].m_shoptel});
    data.push({"name":"txtDepotTye","value":cookie.rows[0].j_form});
    data.push({"name":"txtDepotArea","value":cookie.rows[0].j_dq});
    data.push({"name": "txtRespName", "value": cookie.rows[0].m_shopadmin });
    data.push({ "name": "txtWarehouseNo", "value": cookie.rows[0].j_wxid });
    data.push({ "name": "txtWarehouseName", "value": cookie.rows[0].j_wxname });

    var dataDepot = $("#formDepot").serializeArray();
    data = eachJson(data,dataDepot);
    //受理导购名字
    data.push({"name":"txtStaffName","value":
        $("#supervisor").combobox("getText")});

    var switchOpt 
        = $("#switch").switchbutton('options');
    
    //false:未售维修,true:顾客维修
    var switchStatus = switchOpt.checked;

    if(switchStatus){
        if(!isVaild("formClient","顾客信息")){
            return;
        };
        
        var dataVip = $("#formClient").serializeArray();
        data = eachJson(data,dataVip);
        //售出时间
        data.push({"name":"txtSellDate",
            "value":$("#SellDate").datebox('getValue')});
    };

    var dataWX = $("#formWXInfo").serializeArray();
    data = eachJson(data,dataWX);

    var dataExpress = $("#formExpress").serializeArray();
    data = eachJson(data, dataExpress);

    var remark = $("#Remark").textbox('getValue');

    if(remark.length != 0){
        data.push({"name":"txtRemark","value":remark});
    };

    $.messager.confirm('提示框', "提交后无法修改，请确认？", function (e) {
        if(e){

            var url = GetWSRRURL('3a9cf88e-fc42-485d-9dff-96c35a8a1750')
                + "&XML=" + escape(GetFormJson(data, 'crtNewWX'));
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.post(url,function(data){
                $.messager.progress('close');

                var rst = eval("("+data+")");
                if (rst.Error) {
                    
                    $.messager.alert("系统错误", rst.Error, 'error');
                }
                else if (rst.rows[0].result == "False") {
                  
                    $.messager.alert("提示", rst.rows[0].message, 'error');
                }
                else {
                    $.messager.alert("提示", rst.rows[0].message, 'ok');
                    $("#submit").linkbutton('disable');
                    //关闭成衣维修登记
                    window.parent.$('#mainTabs').tabs('close', '总部维修登记');
                };

            });
        };
    });
}

function isVaild(formName, msg) {

    var isVaild 
        = $('#'+ formName).form('validate');

    if (!isVaild) {
        alert("请将" + msg + "填写完整");
        isVaild = false;
        
    };

    return isVaild;
}

function initValidate(){
   $("#sku").textbox({required:true});
   $("#Question").textbox({
        multiline:true,
        required:true
    });
   $("#expressNo").textbox({required:true});
}

function eachJson(data, jsonObj) {

    for (var o in jsonObj) {
        data.push(
            {"name":jsonObj[o].name
            ,"value":jsonObj[o].value}
        );
    };
    return data;
}

function initTextBox(){
    $("#shopadmin").textbox({
        width:'200',
        height:'32',
        required:true
    });
    $("#shopadminmob").textbox({
        width:'200',
        height:'32',
        required:true
    });

    $("#supervisormob").textbox({
        width:'200',
        height:'32',
        required:true
    });

    $("#depotaddress").textbox({
        width:'250',
        height:'32',
        required:true
    });

    $("#wxaddress").textbox({
        width:'250',
        height:'32',
        required:true
    });

    $("#wxadmin").textbox({
        width:'200',
        height:'32',
        required:true
    });

    $("#wxshoptel").textbox({
        width:'200',
        height:'32',
        required:true
    });

    $("#expressNo").textbox({
        width:'200',
        height:'32',
        required:true
    });

    $("#sku").textbox({
        width: '200',
        height: '32',
        required: true
    }).textbox('clear');

    $("#VipId").textbox({
        width:200,
        height:32,
        required: false,
        disabled:true
     });
}
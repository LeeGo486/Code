/// JS名：VIPScoreChange.js.
/// 说明：VIP积分兑换
/// 创建人：郭琦琦 
/// 创建日期：2014-07-28

var m_centum;//积分
var m_vipstate;//VIP状态
var m_vipname;//VIP姓名
var m_vipid;//VIPID
var m_vipcode;//VIPcode
var m_viptypeid//VIP卡类型
var m_viptypename//VIP卡名称
var flag = 1;
//初始化
var m_DepotID;//店铺编号
var m_merchantid;//加盟商编号
var m_level1_type;//等级1
var m_level1_rate;//等级1比例
var m_level2_type;//等级2
var m_level2_rate;//等级2比例
var m_level3_type;//等级3
var m_level3_rate;//等级3比例
var m_tikect_type;//券号
var flag_DP;//权限
var m_availableCentum;//可用积分
var m_convertibleCentum;//可兑换积分
$(function () {
    flag_DP = 1;
    m_DepotID = window.m_UserID.substring(0, 8);
    clearP();//隐藏初始化

    var data = [];
    data[data.length] = { "name": "txtdepotid", "value": m_DepotID };
    var xmlData = GetFormJson(data, 'GetMerchantid');
    htmlobj = $.ajax({
        url: GetWSRRURL('5b588a14-c810-4b67-826b-da92a3ce5871'),
        data: { "XML": xmlData },
        type: 'post',
        async: false
    });


    var result = $.parseJSON(htmlobj.responseText);


    if (htmlobj.responseText == undefined || result.Error == "请联系管理员！") {
        flag_DP = 1;
        alert("对不起只有店铺才有权限积分兑换");
        return;
    }
    flag_DP = 2;
    m_merchantid = result.rows[0]["merchantid"];
    m_level1_type = result.rows[0]["level1_type"];
    m_level1_rate = result.rows[0]["level1_rate"];
    m_level2_type = result.rows[0]["level2_type"];
    m_level2_rate = result.rows[0]["level2_rate"];
    m_level3_type = result.rows[0]["level3_type"];
    m_level3_rate = result.rows[0]["level3_rate"];
    m_tikect_type = result.rows[0]["tikect_type"];
})

//积分查询
function btnSearch() {
    if (flag_DP == 1) {
        alert("对不起只有店铺才有权限积分兑换");
        return;
    }
    var VIPCode = $('#formselect #txtvipcode').val();
    if (VIPCode == "" || VIPCode == undefined) {
        //$.messager.alert("提示", "请输入VIP卡号", 'error');
        alert("请输入VIP卡号!");
        return;
    }

    var data = [];
    data[data.length] = { "name": "txtVIPCode", "value": VIPCode };
    var xmlData = GetFormJson(data, 'GetVIPIntegral');
    htmlobj = $.ajax({
        url: GetWSRRURL('5b588a14-c810-4b67-826b-da92a3ce5871'),
        data: { "XML": xmlData },
        type: 'post',
        async: false
    });

    var result = $.parseJSON(htmlobj.responseText);
    var strHTML = "";
    $("#tdMessage").html("");
    if (result.Error != undefined) {
        //$.messager.alert("提示", result.Error, 'error');
        strHTML = ' <font color="red"> ' + result.Error.substring(7) + ' </font>'
        $("#tdMessage").html(strHTML);
        flag = 1;
        return;
    }
    else {
        m_viptypeid = result.rows[0].viptypeid;
        m_vipstate = result.rows[0].viptypename;
        m_centum = result.rows[0].centum;//积分
        m_vipname = result.rows[0].vipname;
        m_vipid = result.rows[0].vipid;
        m_vipcode = result.rows[0].vipcode;



         m_availableCentum = m_centum * 1 - m_centum % 100;//可用积分
          m_convertibleCentum = "";

        var data = [];
        data[data.length] = { "name": "txtVIPCode", "value": VIPCode };
        var xmlData = GetFormJson(data, 'GetVIPIntegral');
        htmlobj = $.ajax({
            url: GetWSRRURL('5b588a14-c810-4b67-826b-da92a3ce5871'),
            data: { "XML": xmlData },
            type: 'post',
            async: false
        });

        var result = $.parseJSON(htmlobj.responseText);

        if (m_viptypeid == m_level1_type) {
            m_convertibleCentum = m_availableCentum * m_level1_rate / 100;
        }
        else if (m_viptypeid == m_level2_type) {
            m_convertibleCentum = m_availableCentum * m_level2_rate / 100;
        }
        else if (m_viptypeid == m_level3_type) {
            m_convertibleCentum = m_availableCentum * m_level3_rate / 100;
        }
        else {
            m_convertibleCentum = "0";
        }

        strHTML = ' 会员姓名:' + m_vipname + ',VIP卡等级: ' + m_vipstate + ', 目前积分为: ' + m_centum + '' + ',可用积分为: ' + m_availableCentum + ',可兑换金额为: ' + m_convertibleCentum + '元'
        $("#tdMessage").html(strHTML);
        flag = 2;
    }
}

//积分兑换
function Exchange() {
    if (flag_DP == 1) {
        alert("对不起只有店铺才有权限积分兑换");
        return;
    }
    var VIPCode = $('#formselect #txtvipcode').val();
    if (VIPCode == "" || VIPCode == undefined) {
        //var strHTML = ' 请输入VIP卡号 '
        //$("#tdMessage").html(strHTML);
        alert("请输入VIP卡号!");
        return;
    }

    btnSearch();//积分兑换之前先查询

    $('#formexchange #txtjf').numberbox('setValue', "");//默认积分兑换为空

    //如果flag为1的时候,说明卡号没有验证通过
    if (flag != 2) {
        //var strHTML = ' 请先验证VIP卡号 '
        //$("#tdMessage").html(strHTML);
        //$.messager.alert("提示", "请先验证VIP卡号", 'error');
        alert("请先验证VIP卡号!");
        return;
    }
    //如果m_centum <=0的时候,直接提示积分不足
    if (m_centum * 1 <= 0 || m_centum == undefined) {
        //var strHTML = ' 积分不足 '
        //$("#tdMessage").html(strHTML);
        //$.messager.alert("提示", "积分不足", 'error');
        alert("积分不足!");
        return;
    }

    //if (m_viptypeid == "" || m_viptypeid == undefined || m_viptypeid != "Y1" || m_viptypeid != "Y2" || m_viptypeid != "Y3") {
    //    $.messager.alert("提示", "卡类型不属于,Y1,Y2,Y3,请联系吴伯勇", 'error');
    //    return;
    //}

    $('#formexchange').window({
        title: "积分兑换",
        top: 100,
        width: 300,
        height: 120,
        modal: true
    });


}

//取消
function calcel() {
    $('#formexchange').window('close');
}

//积分兑换
function addSave() {

    var dhje = "";//兑换金额
    var jf = $('#formexchange #txtjf').numberbox('getValue');//获取积分兑换
    if (jf == "") {
        //var strHTML = ' 请输入兑换积分 '
        //$("#tdMessage").html(strHTML);
        alert("请输入兑换积分!");
        //$.messager.alert("提示", "请输入兑换积分", 'error');
        return;
    }
    if (jf * 1 > m_centum * 1 || jf == undefined) {
        //var strHTML = ' 不能超过目前积分 '
        //$("#tdMessage").html(strHTML);
        alert("不能超过目前积分!");
        //$.messager.alert("提示", "不能超过目前积分", 'error');
        return;
    }
    if (jf * 1 % 100 != 0) {
        //var strHTML = ' 必须是100的整数 '
        //$("#tdMessage").html(strHTML);
        alert("必须是100的整数!");
        //$.messager.alert("提示", "必须是100的整数", 'error');
        return;
    }

    if (m_viptypeid == m_level1_type) {
        dhje = jf * m_level1_rate / 100;
    }
    else if (m_viptypeid == m_level2_type) {
        dhje = jf * m_level2_rate / 100;
    }
    else if (m_viptypeid == m_level3_type) {
        dhje = jf * m_level3_rate / 100;
    }
    else {
        dhje = "0";
    }

    $.messager.confirm('提示框', "你输入的积分可以兑换" + ' <font color="red"> ' + dhje + '元电子劵</font>' + ", 是否提交", function (e) {
        if (e) {
            var data = [];
            //data[data.length] = { "name": "txtviptypeid", "value": m_viptypeid }//VIP卡类型
            data[data.length] = { "name": "txttikect_type", "value": m_tikect_type }//VIP配置表这个加盟商券号规则
            data[data.length] = { "name": "txtvipstate", "value": m_vipstate }//VIP状态
            data[data.length] = { "name": "txtvipid", "value": m_vipid }//VIPid
            data[data.length] = { "name": "txttckname", "value": dhje + "元劵" }//劵名
            data[data.length] = { "name": "txtvipcode", "value": m_vipcode }//VIP卡号
            data[data.length] = { "name": "txtsums", "value": dhje }//劵大小
            data[data.length] = { "name": "txtcentum", "value": jf }//积分兑换金额
            var XMLData = GetFormJson(data, 'EDIT');
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('5b588a14-c810-4b67-826b-da92a3ce5871'),
                type: 'post',
                async: false, //异步,
                data: { "XML": XMLData },
                success: function (result) {
                    try {
                        var result = eval("[" + result + "]");

                        if (result[0].Error) {
                            $.messager.progress('close');
                            $.messager.alert("系统错误", result[0].Error, 'error');
                        } else if (result[0].rows[0].result == "False") {
                            $.messager.progress('close');
                            $.messager.alert("提示", result[0].rows[0].message, 'error');
                        }
                        else {
                            $.messager.progress('close');
                            $.messager.alert("提示", result[0].rows[0].message);
                            clearP();//初始化所有数据
                            $('#formexchange').window('close');
                        }
                    } catch (ex) {
                        $.messager.progress('close');

                        $.messager.alert("提示", ex, 'error');
                    }
                },
                error: function () {
                    $.messager.alert("提示", "提交错误了！", 'error');
                }
            });
            return false;
        }
    })
}

//初始化数据
function clearP() {
    //$('#formexchange').hide();//隐藏积分兑换界面
    $('#formselect #txtvipcode').val("");//初始化VIPCODE为空
    $("#tdMessage").html("");//初始化会员信息为空
}
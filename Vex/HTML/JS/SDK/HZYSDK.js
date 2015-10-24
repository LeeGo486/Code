var m_Envo_ID = "";
var m_Envo_TemplateID = "";
var m_Active_EvnoBtn = null;
var m_Active_EvnoTemplateBtn = null;


$(function () {
    InitEnvo();

})

function InitEnvo() {

    m_Envo_ID = "";
    m_Envo_TemplateID = "";
    m_Active_EvnoBtn = null;
    m_Active_EvnoTemplateBtn = null;
    $("#txtText").val("");

    var htmlobj = $.ajax({
        url: GetWSRRURL('4b62969a-5916-43c9-a638-9198d1d91b44'),
        data: "XML=" + GetGetJson(), async: false
    });

    var data = jQuery.parseJSON(htmlobj.responseText);

    if (data.rows[0].envo_id == "") {
        data.rows = [];
    }

    var strHTML = "<table style='width:100%'>";
    var i = 0;
    for (; i < (data.rows.length + 1) / 10 * 10 + 10; i++) {
        if (i % 10 == 0) {
            if (i == 0) {
                strHTML += "<tr>";
            }
            else {
                strHTML += "</tr>";
                strHTML += "<tr>";
            }
        }

        if (i < data.rows.length) {
            strHTML += '<td><div class="btn_unSelect" id="envo' + data.rows[i].envo_id + '" oncontextmenu=\'return ShowMenu(event,"envo","' + data.rows[i].envo_id + '");\'  onclick=\'onclick_Envo(' + data.rows[i].envo_id + ',"' + data.rows[i].envo_name + '",this)\'>' + data.rows[i].envo_name + '</div></td>';
        }
        else if (i == data.rows.length) {
            strHTML += '<td><div class="btn_unSelect" onclick=\'Add("envo")\'>添加环境</div></td>';
        }
        else {
            strHTML += '<td>&nbsp;</td>';
        }
    }

    strHTML += "</tr>";
    strHTML += "</table>";

    $("#divEnvoContent").html('');
    var targetObj = $(strHTML).appendTo("#divEnvoContent");

    $.parser.parse()
}

function UpdateEvno(id, name, updateType) {

    var data = [];
    data[data.length] = { "name": "txtEnvo_id", "value": id }
    data[data.length] = { "name": "txtEnvo_Name", "value": name }

    var XMLData = GetFormJson(data, updateType);

    $.ajax({
        url: GetWSRRURL('4b62969a-5916-43c9-a638-9198d1d91b44'),
        type: 'post',
        async: true,
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
                    //操作成功
                    InitEnvo();
                    alert("操作成功");
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
}



function UpdateTemplate(id, name, updateType) {

    var data = [];
    data[data.length] = { "name": "txtTemplate_ID", "value": id }
    data[data.length] = { "name": "txtTemplate_Name", "value": name }
    data[data.length] = { "name": "txtEnvo_ID", "value": m_Envo_ID }


    var XMLData = GetFormJson(data, updateType);

    $.ajax({
        url: GetWSRRURL('fc2ab7d2-21a7-4128-a73d-50c86bd72aa3'),
        type: 'post',
        async: true,
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
                    //操作成功
                    InitTemplate();
                    alert("修改成功");
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
}

function Add(type) {
    if (type == "envo") {
        $.messager.prompt('提示', '请输入需要添加的技术环境名称', function (value) {
            if (value) {
                UpdateEvno("", value, "INSERT");
            }
            else {
                alert("名称不能为空");
            }
        });
    }
    else {
        $.messager.prompt('提示', '请输入需要添加的模板名称', function (value) {
            if (value) {
                UpdateTemplate("", value, "INSERT");
            }
            else {
                alert("名称不能为空");
            }
        });
    }
}
function Update() {
    var type = $('#mm').attr("type");
    var id = $('#mm').attr("typeid");

    if (type == "envo") {
        $.messager.prompt('提示', '请输入需要修改成为的技术环境名称', function (value) {
            if (value) {
                UpdateEvno(id, value, "UPDATE");
            }
            else {
                alert("新名称不能为空");
            }
        });
    }
    else {
        $.messager.prompt('提示', '请输入需要修改成为的模板名称', function (value) {
            if (value) {
                UpdateTemplate(id, value, "UPDATE");
            }
            else {
                alert("新名称不能为空");
            }
        });
    }
}

function Delete() {
    var type = $('#mm').attr("type");
    var id = $('#mm').attr("typeid");

    if (type == "envo") {
        $.messager.confirm('提示框', '你确定要删除吗？删除后数据将无法恢复！', function (r) {

            if (r) {
                UpdateEvno(id, "", "DELETE");
            }
        });
    }
    else {
        $.messager.confirm('提示框', '你确定要删除吗？删除后数据将无法恢复！', function (r) {

            if (r) {
                UpdateTemplate(id, "", "DELETE");
            }
        });
    }
}
function ShowMenu(ev, type, id) {

    try {
        var x = 0
        var y = 0

        if (ev.pageX || ev.pageY) {
            x = ev.pageX
            y = ev.pageY
        }
        else {
            x = ev.clientX
            y = ev.clientY + $(document).scrollTop()

        }

        $('#mm').attr("type", type);
        $('#mm').attr("typeid", id);

        $('#mm').menu('show', {
            left: x,
            top: y
        });
    } catch (e) {
        return false;

    }
    return false;

}

function onclick_Envo(Envo_Id, Envo_Name, btn) {

    if (m_Active_EvnoBtn == btn) {
        return;
    }
    m_Envo_ID = Envo_Id;

    if (m_Active_EvnoBtn != null) {
        $(m_Active_EvnoBtn)[0].className = "btn_unSelect";
    }

    m_Active_EvnoBtn = btn;
    $(btn)[0].className = "btn_select";

    var pp = $('#divAccordion').accordion("getPanel", 0);
    pp.panel('setTitle', "技术环境：" + Envo_Name);

    InitTemplate()
}

function InitTemplate() {

    m_Envo_TemplateID = "";
    $("#txtText").val("");

    $('#divAccordion').accordion("getPanel", 1).panel('setTitle', "模板：");

    var htmlobj = $.ajax({
        url: GetWSRRURL('fc2ab7d2-21a7-4128-a73d-50c86bd72aa3'),
        data: "XML=" + GetGetJson() + "&Envo_ID=" + m_Envo_ID, async: false
    });

    var data = jQuery.parseJSON(htmlobj.responseText);

    if (data.rows[0].template_id == "") {
        data.rows = [];
    }

    var strHTML = "<table style='width:100%'>";
    var i = 0;
    for (; i < (data.rows.length + 1) / 10 * 10 + 10; i++) {
        if (i % 10 == 0) {
            if (i == 0) {
                strHTML += "<tr>";
            }
            else {
                strHTML += "</tr>";
                strHTML += "<tr>";
            }
        }

        if (i < data.rows.length) {

           // strHTML += '<td width="20%"><div class="btn_unSelect"  id="template' + data.rows[i].template_id + '" oncontextmenu=\'return ShowMenu(event,"template","' + data.rows[i].template_id + '");\'    onclick="onclick_Templates(this,' + data.rows[i].template_id + ')" value="' + data.rows[i].text + '" template_name="' + data.rows[i].template_name + '">' + data.rows[i].template_name + '</div></td>';
            strHTML += '<td width="10%"><div class="btn_unSelect"  id="template' + data.rows[i].template_id + '" oncontextmenu=\'return ShowMenu(event,"template","' + data.rows[i].template_id + '");\'    onclick="onclick_Templates(this,' + data.rows[i].template_id + ')" value="' + data.rows[i].text + '" template_name="' + data.rows[i].template_name + '">' + data.rows[i].template_name + '</div></td>';
        }
        else if (i == data.rows.length) {
            strHTML += '<td width="10%"><div class="btn_unSelect" onclick=\'Add("template")\'>添加模板</div></td>';
        }
        else {
            strHTML += '<td width="10%">&nbsp;</td>';
        }
    }

    strHTML += "</tr>";
    strHTML += "</table>";

    $('#divAccordion').accordion("select", 1);

    $("#divEnvoTemplateContent").html('');
    var targetObj = $(strHTML).appendTo("#divEnvoTemplateContent");
}

function onclick_Templates(btnTemplate, templateID) {

    if (m_Active_EvnoTemplateBtn == btnTemplate) {
        return;
    }

    if (m_Active_EvnoTemplateBtn != null) {
        $(m_Active_EvnoTemplateBtn)[0].className = "btn_unSelect";
    }
    m_Active_EvnoTemplateBtn = btnTemplate;
    $(btnTemplate)[0].className = "btn_select";

    var strTemplate_name = $(btnTemplate).attr("template_name");

    $('#divAccordion').accordion("select", 2);
    $('#divAccordion').accordion("getPanel", 1).panel('setTitle', "模板：" + strTemplate_name);
    m_Envo_TemplateID = templateID;

    var text = unescape($(btnTemplate).attr("value"));
    $("#txtText").val(text);

    //更新访问次数
    var data = [];
    var XMLData = GetFormJson(data, 'INSERT');

    $.ajax({
        url: GetWSRRURL('4d64f81f-73ec-474d-b552-b70089c48171'),
        type: 'post',
        async: true, //异步,
        data: { "XML": XMLData, "Template_ID": m_Envo_TemplateID },
        success: function (result) {

        },
        error: function () {
            $.messager.alert("提示", "提交错误了！", 'error');
        }
    });
}

function onClick_Submit() {


    if (m_Envo_ID == "") {
        alert("请先选择技术环境");
        return;
    }
    if (m_Envo_TemplateID == "") {
        alert("请先选择模板");
        return;
    }
    if ($("#txtText").val() == "") {
        alert("模板内容不能为空");
        $("#txtText").focus();
        return;
    }


    var data = [];
    data[data.length] = { "name": "txtTemplate_ID", "value": m_Envo_TemplateID }
    data[data.length] = { "name": "txtText", "value": escape($("#txtText").val()) }

    var XMLData = GetFormJson(data, 'UPDATE');

    $.ajax({
        url: GetWSRRURL('fc2ab7d2-21a7-4128-a73d-50c86bd72aa3'),
        type: 'post',
        async: true, //异步,
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
                    //操作成功
                    alert("操作成功");
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

}


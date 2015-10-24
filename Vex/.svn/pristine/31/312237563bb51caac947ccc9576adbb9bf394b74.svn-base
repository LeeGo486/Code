var m_treeMenu_Style = 1;
var m_treeData;
var m_treeLoaded = new Array([2]);
var m_DefaultMenu = $.getUrlParam('openmenu');
var m_lockMenu = false;

$(function () {
    changeThemeFun("metro-plm");

    //function getQueryString(name) {
    //    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    //    var r = window.location.search.substr(1).match(reg);
    //    if (r != null) return unescape(r[2]); return null;
    //}



    $.ajax({
        url: GetLoginNameURL(),
        options: "JSON",
        success: function (data) {

            if (eval("[" + data + "]")[0].Error) {
                $.messager.alert("出错了", eval("[" + data + "]")[0].Error, 'error');
                window.location.href = "login_PLMAS.html?r=" + Math.random();
                return;
            }

            var user = eval("[" + data + "]")[0].UserName;

            //m_zt = getQueryString("zt");
            var m_zt = $.cookie('m_zt');
            var m_UserNameC = $.cookie('m_UserNameC');
            //alert(m_zt);
            window.m_UserID = user;

            //$.cookie('m_zt', m_zt, { path: "/", expires: 365 * 10 });

            $("#txtm_zt").text(m_zt + "环境");
            $("#txtUserNameC").text(m_UserNameC);
            if (user && user != "") {
                $("#lblLoginName").html(eval("[" + data + "]")[0].UserName);
            }
            else {
                alert("已过期，请重新登录");
                window.location.href = "login_PLMAS.html?r=" + Math.random();
                return;
            }
        }
    });

    //风格主题 
    if ($.cookie('easyuiThemeName1' + window.hzy_WebName)) {
        $("#styleTheme").combobox('setValue', $.cookie('easyuiThemeName1' + window.hzy_WebName));
    }
    else {
        $("#styleTheme").combobox('setValue', 'default');
    }

    $.ajax({
        url: GetTreeWSRRURL('2f43e442-d6a8-4ca8-a4f6-ee7b8457578a') + "&MenuCodeContains=0",
        options: "JSON",
        success: function (data) {
            $("#layout").layout('resize');

            if (eval("[" + data + "]")[0].Error) {
                $.messager.alert("出错了", eval("[" + data + "]")[0].Error, 'error');
                return;
            }
            m_treeData = eval(data);

            treeTabsChanged();

            //打开默认菜单 
            if (m_DefaultMenu != null && m_DefaultMenu != "") {
                OpenDefaultMenu(m_treeData)
            }
        }

    });

});


function OpenDefaultMenu(treeData) {
    for (var i = 0; i < treeData.length; i++) {
        if (treeData[i].children) {
            OpenDefaultMenu(treeData[i].children);
        }
        if (treeData[i].attributes.ActionURL.toUpperCase() == m_DefaultMenu.toUpperCase()) {
            loadFrame(treeData[i]);
        }
    }
}

function treeTabsChanged() {

    if (m_treeMenu_Style == 0 && m_treeLoaded[m_treeMenu_Style] != 1) {
        m_treeLoaded[m_treeMenu_Style] = 1;//标志为已加载

        $("#treeMenu").tree({
            checkbox: false,
            animate: true,
            state: 'open',
            data: m_treeData,
            onClick: function (node) {
                $(this).tree('toggle', node.target);

                loadFrame(node);
            },
            onLoadSuccess: function (node, data) {
                if (data.Error != null) {
                    $.messager.alert("出错了", data.Error, 'error');
                }
            },
            onLoadError: function (arguments) {
                $.messager.alert("出错了", arguments, 'error');

            }
        });

        //$('#treeMenu').tree('collapseAll');

        $('#menuToolbar').toolbar({
            items: [{
                id: "test",
                iconCls: "icon-arrow-in",
                text: "折叠",
                handler: function () {
                    CollapseMenuList();
                }
            }, {
                iconCls: "icon-arrow-out",
                text: "展开",
                handler: function () {
                    ExpandMenuList();
                }
            }]
        });

    }
    else if (m_treeMenu_Style == 1 && m_treeLoaded[m_treeMenu_Style] != 1) {

        m_treeLoaded[m_treeMenu_Style] = 1;//标志为已加载

        $('#treeMenu_Style1').accordion({ animate: false, height: 400 });

        for (var i = 0; i < m_treeData.length; i++) {
            $('#treeMenu_Style1').accordion('add', {
                title: m_treeData[i].text,

                content: "<ul id='treeMenu_Style1" + i + "'></ul>",
                selected: true
            });

            var data1 = m_treeData[i].children

            $("#treeMenu_Style1" + i).tree({
                checkbox: false,
                data: data1,
                onClick: function (node) {
                    $(this).tree('toggle', node.target);
                    loadFrame(node);
                },
                onLoadSuccess: function (node, data) {
                    if (data.Error != null) {
                        $.messager.alert("出错了", data.Error, 'error');
                    }
                },
                onLoadError: function (arguments) {
                    $.messager.alert("出错了", arguments, 'error');

                }
            });


        }
        $('#treeMenu_Style1').accordion({ animate: true });
    }



}
function ExpandMenuList() {
    $('#treeMenu').tree('expandAll');
}

function CollapseMenuList() {
    $('#treeMenu').tree('collapseAll');
}

function collapseMune() {
    $('#layout').layout("collapse", "west");
}

//加载页面
function loadFrame(node) {

    var url = node.attributes.ActionURL;
    if (url == null || url == "") {
        return;
    }

    url = url.replace("#UserName", window.m_UserID)
    url = url.replace("#PassWord", window.m_PassWord)

    if (node.attributes.OpenNewWindow == "1") {
        window.open(url);
        return;
    }
    else {
        if (url.indexOf("?") > 0) {
            url += "&vexmenuid=" + node.id;
        }
        else {
            url += "?vexmenuid=" + node.id;
        }
        var title = node.text;



        if ($('#mainTabs').tabs('exists', title)) {
            $('#mainTabs').tabs('select', title)
            //refreshTab({ tabTitle: title, url: url }); 
            return;
        }
        url = url + "&rd=" + Math.random();
        var content = '<iframe scrolling="no" frameborder="0"  src="' + url + '" style="width:100%;height:100%;padding:0px"></iframe>';
        $('#mainTabs').tabs('add', {
            title: title,
            content: content,
            closable: true,
            fit: true,
            //style: { "display": "none", "overflow": "hidden" },
            tools: [{
                iconCls: 'icon-mini-refresh',
                handler: function () {
                    var selectTab = $('#mainTabs').tabs('getSelected');
                    refreshTab({});
                }
            }]
        });

        //重新设置tab的宽高，如果easyui升级的话，这里可能需要修改
        var tab = $('#mainTabs').tabs('getSelected');
        var tabDiv = tab.select("div:first");
        tabDiv.css("padding", "1px")
        tabDiv.css("overflow", "hidden");
        tabDiv.css("background-color", "#cacaca");
        tabDiv.height(tabDiv.height() - 10);
        tabDiv.width(tabDiv.width() - 10);;
    }
}

/**      
* 刷新tab  
* @cfg   
*example: {tabTitle:'tabTitle',url:'refreshUrl'}  
*如果tabTitle为空，则默认刷新当前选中的tab  
*如果url为空，则默认以原来的url进行reload  
*/
function refreshTab(cfg) {
    var refresh_tab = cfg.tabTitle ? $('#mainTabs').tabs('getTab', cfg.tabTitle) : $('#mainTabs').tabs('getSelected');
    if (refresh_tab && refresh_tab.find('iframe').length > 0) {
        var _refresh_ifram = refresh_tab.find('iframe')[0];
        var refresh_url = cfg.url ? cfg.url : _refresh_ifram.src;
        //_refresh_ifram.src = refresh_url;   
        _refresh_ifram.contentWindow.location.href = refresh_url;
    }
}


function changeTheme(data) {
    changeThemeFun(data.value);
}

function Logout() {
    $.ajax({
        async: true,
        cache: false,
        type: 'POST',
        dataType: "json",
        url: GetWSRRURL('f5f35aca-469b-463c-b33c-2e872dabbec3'), // 请求的action路径
        error: function () {// 请求失败处理函数
            alert(GetErrorMsg('E0001'));
        },
        onSubmit: function () {

        },
        success: function (data) { // 请求成功后处理函数。
            //alert(data);
            $.messager.progress('close');
            //var data = eval('(' + data + ')');
            if (data.Result != null) {
                //$("#login_msg").html("登录成功");
                window.location = "login_PLMAS.html";
            } else if (data.Error != null) {//后台异常处理
                alert(data.Error);
            }
        }
    });
}

//重新设置主界面的大小
function resizeCenter() {
    var westWidth = $("body").layout("panel", "west").panel("options").width;
    var centerWidth = $(document.body).width() - westWidth;
    $("body").layout("panel", "center").panel("resize", { left: 200, width: centerWidth });
}

//最大化主界面
function maxSizeCenter() {
    var centerWidth = $("body").layout("panel", "center").panel("options").width;
    var docWidth = $(document.body).width();
    var newCenterWidth = docWidth - 28;
    if (docWidth > centerWidth) {
        // $("body").layout("panel", "center").panel("maximize");
        //$("body").layout("panel", "center").panel("maximize");
        $("body").layout("panel", "center").panel("resize", { width: newCenterWidth });

    }
}
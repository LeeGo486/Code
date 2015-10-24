<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="Talent.Web.index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
    <title>人才信息管理首页</title>
    <style type="text/css">
    textarea{ overflow:auto}
    </style>
    <link href="Css/bmapCommon.css" rel="stylesheet" type="text/css" />
    <link href="themes/default/style.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="themes/css/core.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="themes/css/print.css" rel="stylesheet" type="text/css" media="print" />
    <link href="uploadify/css/uploadify.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="themes/css/ieHack.css" rel="stylesheet" type="text/css" media="screen"/>
    <link href="Css/colorPicker.css" rel="stylesheet" type="text/css" />
   
    <script src="js/speedup.js" type="text/javascript"></script>
    <script src="js/jquery-1.7.1.js" type="text/javascript"></script>
    <script src="js/jquery.colorPicker.js"  type="text/javascript"/></script>
    <script src="js/jquery.cookie.js" type="text/javascript"></script>
    <script src="js/jquery.validate.js" type="text/javascript"></script>
    <script src="js/jquery.metadata.js" type="text/javascript"></script>
    <script src="js/jquery.bgiframe.js" type="text/javascript"></script>
    <script src="xheditor/xheditor-1.1.13-zh-cn.min.js" type="text/javascript"></script>
    <script src="uploadify/scripts/swfobject.js" type="text/javascript"></script>
    <script src="uploadify/scripts/jquery.uploadify.v2.1.0.js" type="text/javascript"></script>
    <script src="js/public.js" type="text/javascript"></script>
    <script src="js/map.js" type="text/javascript"></script>
    <script src="js/TalentInfo.js" type="text/javascript"></script>

    <script src="js/dwz.core.js" type="text/javascript"></script>
    <script src="js/dwz.util.date.js" type="text/javascript"></script>
    <script src="js/dwz.validate.method.js" type="text/javascript"></script>
    <script src="js/dwz.regional.zh.js" type="text/javascript"></script>
    <script src="js/dwz.barDrag.js" type="text/javascript"></script>
    <script src="js/dwz.drag.js" type="text/javascript"></script>
    <script src="js/dwz.tree.js" type="text/javascript"></script>
    <script src="js/dwz.accordion.js" type="text/javascript"></script>
    <script src="js/dwz.ui.js" type="text/javascript"></script>
    <script src="js/dwz.theme.js" type="text/javascript"></script>
    <script src="js/dwz.switchEnv.js" type="text/javascript"></script>
    <script src="js/dwz.alertMsg.js" type="text/javascript"></script>
    <script src="js/dwz.contextmenu.js" type="text/javascript"></script>
    <script src="js/dwz.navTab.js" type="text/javascript"></script>
    <script src="js/dwz.tab.js" type="text/javascript"></script>
    <script src="js/dwz.resize.js" type="text/javascript"></script>
    <script src="js/dwz.dialog.js" type="text/javascript"></script>
    <script src="js/dwz.dialogDrag.js" type="text/javascript"></script>
    <script src="js/dwz.sortDrag.js" type="text/javascript"></script>
    <script src="js/dwz.cssTable.js" type="text/javascript"></script>
    <script src="js/dwz.stable.js" type="text/javascript"></script>
    <script src="js/dwz.taskBar.js" type="text/javascript"></script>
    <script src="js/dwz.ajax.js" type="text/javascript"></script>
    <script src="js/dwz.pagination.js" type="text/javascript"></script>
    <script src="js/dwz.database.js" type="text/javascript"></script>
    <script src="js/dwz.datepicker.js" type="text/javascript"></script>
    <script src="js/dwz.effects.js" type="text/javascript"></script>
    <script src="js/dwz.panel.js" type="text/javascript"></script>
    <script src="js/dwz.checkbox.js" type="text/javascript"></script>
    <script src="js/dwz.history.js" type="text/javascript"></script>
    <script src="js/dwz.combox.js" type="text/javascript"></script>
    <script src="js/dwz.print.js" type="text/javascript"></script>
    <!--
    <script src="bin/dwz.min.js" type="text/javascript"></script>
    -->
    <script src="js/dwz.regional.zh.js" type="text/javascript"></script>
    
    

    <script type="text/javascript">
        $(function () {
            DWZ.init("dwz.frag.xml", {
                loginUrl: "login.aspx", loginTitle: "登录", // 弹出登录对话框
                statusCode: { ok: 1, error: 0, timeout: -1 }, //【可选】
                pageInfo: { pageNum: "pageNum", numPerPage: "numPerPage", orderField: "orderField", orderDirection: "orderDirection" }, //【可选】
                debug: false, // 调试模式 【true|false】
                callback: function () {
                    initEnv();
                    $("#themeList").theme({ themeBase: "themes" }); // themeBase 相对于index页面的主题base路径
                    setTimeout(function () {
                        navTab.openTab("Map", "Map/Map.aspx", { title: "地图", fresh: false, data: {} });
                        $(".navTab-tab .close").remove();
                        $("li.selected[tabid=Map]").attr("url","");
                    }, 30);
                }
            });
        });

        function clickagain() {
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "Default.aspx/clickagain",
                cache: false,
                data: {},
                async: true,
                dataType: "json",
                success: function () { }
            });
        }
        window.setInterval("clickagain()", 90000);

    </script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=1.2"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/library/MarkerTool/1.2/src/MarkerTool_min.js" charset="GBK"></script>
</head>
<body scroll="no">
    <div id="layout">
        <div id="header">
            <div class="headerNav">
                <a class="logo" href="javascript:void(0)">标志</a>
                <ul class="nav">
                    <li><a href="javavoid:void(0)" onclick="return false ;">欢迎您：<%=Tools.SessionHelper.Get("userid") %></a></li>
                    <li><a href="login.aspx" target="_self">退出</a></li>
                </ul>
            </div>
            <!-- navMenu -->
        </div>
        <div id="leftside">
            <div id="sidebar_s">
                <div class="collapse">
                    <div class="toggleCollapse">
                        <div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="sidebar">
                <div class="toggleCollapse">
                    <h2>
                        主菜单</h2>
                    <div>
                        收缩</div>
                </div>
                <div class="accordion" fillspace="sidebar">
                    <div class="accordionHeader">
                        <h2>
                            <span>Folder</span>办公中心</h2>
                    </div>
                    <div class="accordionContent">
                        <ul class="tree treeFolder">
                            <li><a href="" target="navTab" fresh="false" rel="Map">地图</a></li>
                          <!--  <li><a href="TalentInfo/TalentInfo.aspx" target="navTab"  rel="TalentInfo">竞品信息</a></li>  -->
                            <li><a href="TalentCx/TalentCx.aspx" target="navTab"  rel="TalentCx">人才信息库查询</a></li>
                            <li><a href="TalentClass/TalentClassCx.aspx" target="navTab"  rel="TalentClassCx">人才类别</a></li>
                            <li <%=per.PM_Level == 9 ?"":"style='display:none'" %> ><a href="Authority/AuthorityCx.aspx?level=<%=per.PM_Level %>" target="navTab"  rel="AuthorityCx">权限列表</a></li>
                          <!--  <li><a href="TalentInfo/LabelDialog.aspx" target="dialog" height="435" rel="TalentLabel">人才信息</a></li>  -->
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div id="container">
            <div id="navTab" class="tabsPage">
                <div class="tabsPageHeader">
                    <div class="tabsPageHeaderContent">
                        <!-- 显示左右控制时添加 class="tabsPageHeaderMargin" -->
                        <ul class="navTab-tab tabsPageHeaderMargin"> 
                            
                        </ul>
                    </div>
                    <div class="tabsLeft">
                        left</div>
                    <!-- 禁用只需要添加一个样式 class="tabsLeft tabsLeftDisabled" -->
                    <div class="tabsRight">
                        right</div>
                    <!-- 禁用只需要添加一个样式 class="tabsRight tabsRightDisabled" -->
                    <div class="tabsMore">
                        more</div>
                </div>
                <ul class="tabsMoreList">
                    
                </ul>
                <div class="navTab-panel tabsPageContent layoutBox">
                    
                </div>
            </div>
        </div>
    </div>
    <div id="footer">
        雅莹人才管理平台    Copyright © 2012    浙江雅莹服装有限公司   版权所有   技术支持    信息管理部</div>
     
</body>
</html>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReperClass_List.aspx.cs"
    Inherits="EPReper.Web.manager.ReperClass.ReperClass_List" %>

<%@ Register Src="../../Controls/PageNavigator.ascx" TagName="PageNavigator" TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>自助维修平台</title>
    <link href="../../Styles/css.css" rel="stylesheet" type="text/css" />
    <link href="../../Styles/style.css" rel="Stylesheet" type="text/css" />
    <script src="../../Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="/Scripts/public.js" type="text/javascript"></script>
    <style type="text/css">
        a
        {
            text-decoration: none;
            color: Maroon;
        }
    </style>
</head>
<body>
    <center>
        <form id="form1" runat="server" method="post">
        <div class="header">
            <div class="menu">
                <div class="nav">
                    <a href="../../index.aspx" title="首页">首 页</a><a href="../ReperInfo/ReperInfo.aspx" style="margin-left:10px"
                        title="我要报修">报 修</a><a href="../ReperInfo/ReperInfo.aspx?type=select" style="margin-left:10px" title="我要查询">查
                            询</a><a href="ReperClass_List.aspx" title="我是管理员" style="margin-left:10px" class="on">管理员</a>
                </div>
            </div>
        </div>
        <table class="table" border="0" cellpadding="0" cellspacing="1" bgcolor="#FFFFFF">
            <tr>
                <td>
                    <table width="100%">
                        <tr>
                            <td align="left" width="80%">
                                <%--            <asp:Button id="baoxiu" runat="server" onclick="bx" Text="报    修" 
                    class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'"
onmouseout="this.className='btn3_mouseout'"
onmousedown="this.className='btn3_mousedown'"
  onmouseup="this.className='btn3_mouseup'"
  title="报修"  />--%>
                                <asp:Button ID="mulu" runat="server" Text="目录管理" OnClick="ml" class="btn3_mouseout"
                                    onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'"
                                    onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"
                                    title="目录管理" />&nbsp;&nbsp;
                                <asp:Button ID="renyuan" runat="server" Text="人员管理" OnClick="ry" class="btn3_mouseout"
                                    onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'"
                                    onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"
                                    title="人员管理" />&nbsp;&nbsp;
                                <asp:Button ID="Button1" runat="server" Text="添加类" OnClick="class_add" class="btn3_mouseout"
                                    onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'"
                                    onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"
                                    title="添加类" />&nbsp;&nbsp;&nbsp;<%=Session["usermsg"] %>
                            </td>
                            <td width="20%" style="font-size: 18px;font-family:黑体;">
                                <%=Tools.CookieHelper.GetCookie("username") %>
                                <a href="../../logout.aspx">注销</a>
                            </td>
                        </tr>
                    </table>
                    <div id="divHtml" runat="server">
                    </div>
                    <span style='margin-right: 5px'>每页显示条数
                        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                            <asp:ListItem>5</asp:ListItem>
                            <asp:ListItem>10</asp:ListItem>
                            <asp:ListItem>15</asp:ListItem>
                            <asp:ListItem>20</asp:ListItem>
                            <asp:ListItem>25</asp:ListItem>
                            <asp:ListItem>30</asp:ListItem>
                            <asp:ListItem>50</asp:ListItem>
                            <asp:ListItem>100</asp:ListItem>
                            <asp:ListItem>200</asp:ListItem>
                        </asp:DropDownList>
                        <uc2:PageNavigator ID="PageNavigator1" runat="server" />
                    </span>
                </td>
            </tr>
        </table>
        </form>
    </center>
</body>
</html>
<script language="javascript" type="text/javascript">
    function SwitchImg(ImgObj, ParentId) {
        var ImgSrc = "", SubImgSrc;
        ImgSrc = ImgObj.src;
        SubImgSrc = ImgSrc.substr(ImgSrc.length - 5, 12);
        if (SubImgSrc == "b.gif") {
            ImgObj.src = ImgObj.src.replace(SubImgSrc, "s.gif");
            ImgObj.alt = "点击收起子任务";
            $("#" + ParentId).css("display", "");
        } else {
            if (SubImgSrc == "s.gif") {
                ImgObj.src = ImgObj.src.replace(SubImgSrc, "b.gif");
                ImgObj.alt = "点击展开子任务";
                $("#" + ParentId).css("display", "none");
            } else {
                return false;
            }
        }
    }

    function SwitchSub(ParentId, ShowFlag) {
        if (ShowFlag == true) {
            $("Parent" + ParentId).style.display = "";
            //GetSubTask(ParentId,true);
            //		if ($("Parent"+ParentId).innerHTML=="" || $("Parent"+ParentId).innerHTML=="&nbsp;&nbsp;loading..."){
            //			$("Parent"+ParentId).innerHTML="&nbsp;&nbsp;loading...";
            //			
            //		}
        } else {
            $("Parent" + ParentId).style.display = "none";
            //GetSubTask(ParentId,false);
        }
    }
</script>

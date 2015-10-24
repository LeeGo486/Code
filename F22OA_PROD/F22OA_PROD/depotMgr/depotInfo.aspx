<%@ page language="C#" autoeventwireup="true" inherits="depotMgr_depotInfo, App_Web_depotinfo.aspx.9ee944ed" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>店铺信息</title>
    <link href="../depotMgr/scripts/common.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form2" runat="server">
    <div>
<table width="100%" border="0" cellpadding="0" cellspacing="5">
  <tr>
    <td colspan="2" >
    <div id="depotinfomenu">
    <ul>
    <li><a href="depotInfo.aspx?depotid=<%=depotid %>" class="mthis">店铺信息</a></li>
    <li><a href="depotFile.aspx?depotid=<%=depotid %>">店铺文档</a></li>
    <li><a href="depotUser.aspx?depotid=<%=depotid %>">人员档案</a></li>
    <li><a href="depotSale.aspx?depotid=<%=depotid %>">销售情况</a></li>
    </ul>
    </div>    </td>
  </tr>
    
  <tr>
    <td colspan="2" valign="top"> </td>
  </tr>
  <tr>
    <td width="50%" valign="top" style="border:none;border-right:solid 1px #eaeaea;">
    <dl>

      <dt>基本信息</dt>
      <dd>
        <strong>店铺名称</strong>：<asp:Label ID="Label2" runat="server" Text=""></asp:Label><br />
        <strong>店铺编号</strong>：<asp:Label ID="Label1" runat="server" Text=""></asp:Label><br />
        <strong>店铺类型</strong>：<asp:Label ID="Label7" runat="server" Text=""></asp:Label><br />
        <strong>电　　话</strong>：<asp:Label ID="Label3" runat="server" Text=""></asp:Label><br />
        <strong>传　　真</strong>：<asp:Label ID="Label4" runat="server" Text=""></asp:Label><br />
        <strong>开 户 行</strong>：<asp:Label ID="Label5" runat="server" Text=""></asp:Label><br />
        <strong>帐　　号</strong>：<asp:Label ID="Label6" runat="server" Text=""></asp:Label><br />
        <strong>创建日期</strong>：<asp:Label ID="Label8" runat="server" Text=""></asp:Label><br />
        <strong>地　　址</strong>：<asp:Label ID="Label12" runat="server" Text=""></asp:Label><br />
        <strong>备　　注</strong>：<asp:Label ID="Label13" runat="server" Text=""></asp:Label><br />
          </dd>
    </dl></td>
    <td valign="top">
    <dl>
      <dt>店铺负责人</dt>
      <dd><strong>姓名</strong>：<asp:Label ID="Label9" runat="server" Text=""></asp:Label><br />
        <strong>手机</strong>：<asp:Label ID="Label10" runat="server" Text=""></asp:Label><br />
        <strong>邮箱</strong>：<asp:Label ID="Label11" runat="server" Text=""></asp:Label><br />
        </dd>
      <dt>文档统计</dt>
      <dd><div ID="filecount" runat="server" >
      </div>
          <br />
          </dd>
    </dl>    
	</td>
  </tr>
</table>

    </div>
    </form>
</body>
</html>


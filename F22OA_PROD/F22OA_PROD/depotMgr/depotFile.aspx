<%@ page language="C#" autoeventwireup="true" inherits="depotMgr_depotFile, App_Web_depotfile.aspx.9ee944ed" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>店铺文档</title>
    <link href="../depotMgr/scripts/common.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
    function lookfile(fileid){
       var m=showModalDialog("filedetail.aspx?fileid="+fileid,"lookfile","scroll:no;status:no;help:no;resizable:no;center:yes;dialogWidth:700px;dialogHeight:330px;");
    }
    </script>
</head>
<body>
    <form id="form2" runat="server">
    <div>
    <table width="100%" border="0" cellpadding="0" cellspacing="5">
  <tr>
    <td >
    <div id="depotinfomenu">
    <ul>
    <li><a href="depotInfo.aspx?depotid=<%=depotid %>">店铺信息</a></li>
    <li><a href="depotFile.aspx?depotid=<%=depotid %>" class="mthis">店铺文档</a></li>
    <li><a href="depotUser.aspx?depotid=<%=depotid %>">人员档案</a></li>
    <li><a href="depotSale.aspx?depotid=<%=depotid %>">销售情况</a></li>
    </ul>
    </div></td>
  </tr>
    
  <tr>
    <td style="height:30px;">    
        　<asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        　类型：<a href="?depotid=<%=depotid%>&s=fileid&d=<%=desc%>" title="显示全部类型">全部</a><span style="text-align:Left;" runat="server" id="TypeDiv"></span>
        　</td>
  </tr>
  <tr>
      
    <td>
       <asp:DataList ID="DataList1" runat="server" Width="98%" CellPadding="4" ForeColor="#333333" HorizontalAlign="Center" CssClass="datalist" >
       <HeaderStyle HorizontalAlign="Center" BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderTemplate>
        <div style="width:7%;">
        <b><a href="?depotid=<%=depotid%>&s=fileid&d=<%=desc%>&t=<%=typeid%>" style="color:White" title="按ID排序">ID</a></b>
        </div>
        <div style="width:10%;">
        <b><a href="?depotid=<%=depotid%>&s=tname&d=<%=desc%>&t=<%=typeid%>" style="color:White" title="按文档类型排序">文档类型</a></b>
                </div>
        <div style="width:50%;">
        <b><a href="?depotid=<%=depotid%>&s=fname&d=<%=desc%>&t=<%=typeid%>" style="color:White" title="按文档名称排序">文档名称</a></b>
                </div>
        <div style="width:8%;">
        <b><a href="?depotid=<%=depotid%>&s=crname&d=<%=desc%>&t=<%=typeid%>" style="color:White" title="按创建人排序">创建人</a></b>
                </div>
        <div style="width:20%;">
        <b><a href="?depotid=<%=depotid%>&s=crdate&d=<%=desc%>&t=<%=typeid%>" style="color:White" title="按创建日期排序">创建日期</a></b>
        </div>
        <div style="width:5%;">
        操作
        </div>
        </HeaderTemplate>
        <ItemTemplate>
        <div style="width:7%;">
        <%#Eval("fileid") %>　
        </div>
        <div style="width:10%;">
        <a href="?depotid=<%=depotid%>&t=<%#Eval("typeid") %>"><%# Eval("tname") %></a>　
                </div>
        <div style="width:50%;text-align:left;">
        <a href="../file/openfile.aspx?url=<%# Server.UrlEncode((String)DataBinder.Eval(Container, "DataItem.fileurl")) %>" target="_blank"><%# Eval("fname") %></a>
                </div>
        <div style="width:8%;">
        <%# Eval("crname") %>
                </div>
        <div style="width:20%;">
        <%# Eval("crdate") %>
        </div>
        <div style="width:5%;">
        <a href="javascript:;" onclick='javascript:lookfile("<%#Eval("fileid") %>")'>查看</a>
        </div>
        </ItemTemplate>
        <FooterTemplate>
        
        </FooterTemplate>
           <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
           <SelectedItemStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
           <AlternatingItemStyle BackColor="White" ForeColor="#284775" />
           <ItemStyle BackColor="#F7F6F3" ForeColor="#333333" />
        </asp:DataList>
        </td>
  </tr>
  <tr><td>
            <div style="text-align:center;" runat="server" id="PageNum"></div>
        　
  </td></tr>
</table>
</div>
    </form>
</body>
</html>


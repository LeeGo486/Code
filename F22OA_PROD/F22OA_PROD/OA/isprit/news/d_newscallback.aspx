<%@ page language="C#" autoeventwireup="true" inherits="OA_isprit_news_d_newscallback, App_Web_d_newscallback.aspx.9a188d08" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>新闻回复</title>
    <LINK href="../../css/project.css" type="text/css" rel="STYLESHEET"/>
    <style type="text/css">
        #main 
        {
            width:800px;
            min-height:600px;
            margin:0px auto;
        }
        #main  .newsDiv
        {
            text-align:center;
            min-height:200px;
            white-space:pre;
        }
        span
        {
            font-weight:bold;
            font-size:1.2em;
        }
        #main .conDiv
        {
            margin-top:5px;
            min-height:200px;
        }
        #main .conDiv table 
        {
            width:100%;    
        }
        #main .conDiv table thead tr td
        {
            font-size:1.3em;
            font-weight:bold;
            text-align:center;    
        }
        #main .conDiv table tbody tr td
        {
           text-align:center;    
        }
    </style>

    <script src="js/jquery-1.3.2.js" type="text/javascript"></script>
    <script type="text/javascript">
        var cele=undefined;
        function del(ele,id) {
            if (confirm("是否真的要删除回复?")) {
                PageMethods.Del(id, sf, ef);
                cele=ele;
             }
         }
         function sf(r) {
             if (r) {
                 $(cele).parent().parent().remove();
                 alert("删除成功");
              }
          }
          function ef(e) {
              alert(e._message);
          }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
    </asp:ScriptManager>
    <div id="main">
        <div class="newsDiv">
            <asp:Label ID="lab_newTitle" runat="server" Text="Label"></asp:Label>
            <br />
            <asp:Literal ID="lit_newContent" runat="server"></asp:Literal>
        </div>
        <div class="conDiv">
            <asp:Repeater ID="rep_list" runat="server" 
                onitemdatabound="rep_list_ItemDataBound">
                <HeaderTemplate>
                    <table>
                    <thead>
                        <tr>
                            <td> &nbsp;&nbsp;</td>
                            <td>内容</td>
                            <td>回复人</td>
                            <td>&nbsp;</td>
                        </tr>
                    </thead>
                </HeaderTemplate>
                <ItemTemplate>
                    <tbody>
                        <tr>
                            <td>
                                <asp:Image ID="img_head" runat="server" />
                            <td>
                                <%#Eval("content") %>
                            </td>
                            <td><%#Eval("username") %></td>
                            <td>
                                <a href="#" onclick='javascript:del(this,<%#Eval("id") %>)'>删除</a>
                            </td>
                        </tr>
                    </tbody>
                </ItemTemplate>
                <FooterTemplate>
                </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>
    </div>
    </form>
</body>
</html>

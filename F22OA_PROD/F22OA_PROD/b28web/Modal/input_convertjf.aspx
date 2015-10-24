<%@ page language="C#" autoeventwireup="true" inherits="b28web_Modal_input_convertjf, App_Web_input_convertjf.aspx.a056ca89" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>积分抵扣</title>
    <base target="_self" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache,must-revalidate" />
    <link href="../Utility/main.css" rel="stylesheet" type="text/css" />
    <link href="../Utility/jQuery.f35.grid.css" rel="stylesheet" type="text/css" />
    <script src="../Utility/jquery-1.2.6.min.js" type="text/javascript"></script>
    <script src="../Utility/jquery.hotkeys-0.7.9.min.js" type="text/javascript"></script>
    <script src="../Utility/jQuery.f35.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function()
        {
	        $('#posGrid1').f35grid({
	            width:['220','100','100'],
	            choosebox:{type:'radio'},
	            rowClick:rowClick,
	            rowDblClick:rowdblClick
	        })
            window.returnValue =  $("#vipcode").val() + "$" +  $("#jfcash").val() + "$" +  $("#jfcentum").val();
       
        });
        
        function rowClick()
        {
	        var rows = $('#posGrid1').f35gridGetRow('.selected');
            $("#jfcentum").val($('#posGrid1').f35gridGetCol(1,rows));
            $("#jfcash").val($('#posGrid1').f35gridGetCol(2,rows));
        }
        
        function rowdblClick()
        {
            $("#Button2").click();
        }
    
        function KeyDown(){
            with (event){ 
                if(keyCode==113){//确定
                    document.getElementById('Button2').click();
                    event.keyCode = 0; 
                    event.cancelBubble = true; 
                    return false;
                }
                if(keyCode==27){//ESC返回输入状态
                    document.getElementById('Button3').click();
                    event.keyCode = 0; 
                    event.cancelBubble = true; 
                    return false;
                }
            }
        }
        document.onkeydown = KeyDown;

    </script>
    <style type="text/css">
        .style1
        {
            height: 38px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div style="padding:10px;">
        <table style="width:98%;">
            <tr>
                <td>
                <center><h3 runat="server" id="h3">可用积分抵扣方案</h3></center>
                    <div style="height:150px; overflow:auto">
                        <asp:Repeater ID="rp1" runat="server">
                        <HeaderTemplate>
                        <table id="posGrid1">
                            <thead><tr><td>名　称</td><td>积分</td><td>金额￥</td></tr></thead>
                            <tbody id="DataBody">
                            <tr>
                                <td>不使用</td>
                                <td>0</td>
                                <td>0</td>
                            </tr>

                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td><%#Eval("fjfcertname")%></td>
                                <td><%#Convert.ToDecimal(Eval("fjfnums").ToString()).ToString()%></td>
                                <td><%#Eval("fjfcash")%></td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </tbody></table>
                        </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </td>
            </tr>
            <tr>
                <td align="center" >
                    <asp:Button ID="Button2" runat="server" Text="确　定[F2]" CssClass="btn2" 
                        UseSubmitBehavior="False" Width="100px" onclick="Button2_Click" />&nbsp;
                    <asp:Button ID="Button3" runat="server" Text="取消[Esc]" CssClass="btn2" 
                     OnClientClick="window.close()"
                        UseSubmitBehavior="False" Width="100px" />
                    <asp:HiddenField ID="jfcentum" runat="server" />
                    <asp:HiddenField ID="vipcode" runat="server" />
                    <asp:HiddenField ID="jfcash" runat="server" />

                </td>
            </tr>
        </table>
    

    </div>
    </form>
</body>
</html>

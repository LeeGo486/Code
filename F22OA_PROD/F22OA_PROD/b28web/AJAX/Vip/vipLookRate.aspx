<%@ page language="C#" autoeventwireup="true" inherits="b28web_AJAX_Vip_vipLookRate, App_Web_viplookrate.aspx.3005feca" %>
    <script type="text/javascript">
        $(function(){
            var row = $("#dlbody").find("tr");
            $("#dlbody").find("tr:even").css('background-color','#F7F6F3');
            $.each(row,function(i,obj){

                $(obj).click(function(){
                    $("#dlbody").find("tr").css('background-color','#FFFFFF');
                    $("#dlbody").find("tr:even").css('background-color','#F7F6F3');
                   $(obj).css("background-color", "#E2DED6");
                });
            });
        })
    </script>
<form id="form1" runat="server">
<asp:Repeater ID="Repeater1" runat="server">
    <HeaderTemplate>
        <table id="dltab" class="dltab" cellpadding="4" cellspacing="0" border="0" width="100%">
            <thead>
              <tr>
                <td>卡类型</td>
                <td>折扣</td>
                <td>状态</td>
                <td>有效积分范围</td>
                <td>有效折扣范围</td>
              </tr>
	        </thead>
	        <tbody id="dlbody">
    </HeaderTemplate>
    <ItemTemplate>
        <tr style="text-align:center;">
            <td><%#Eval("viptypename")%></td>
            <td><%#Eval("rate")%></td>
            <td><%#Eval("isTrue").ToString()=="0"?"无效":"有效"%></td>
            <td><%#Eval("begcentum")%> ～ <%#Eval("endcentum")%></td>
            <td><%#Eval("begrate")%> ～ <%#Eval("endrate")%></td>
        </tr>
    </ItemTemplate>
    <FooterTemplate>
            </tbody>
        </table>
    </FooterTemplate>
</asp:Repeater>
</form>



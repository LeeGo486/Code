<%@ page language="C#" autoeventwireup="true" inherits="Modal_vipBuys, App_Web_vipbuys.aspx.3005feca" %>
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
          <td>店铺编号</td>
          <td>店铺名称</td>
          <td>销售日期</td>
          <td>类型</td>
          <td>款式</td>
          <td>颜色</td>
          <td>尺码</td>
          <td>现价</td>
          <td>折扣</td>
          <td>结算价</td>
          <td>数量</td>
          <td>金额</td>
          <td>促销</td>
          <td>抵扣</td>
          <td>实销</td>
          <td>实销折扣</td>
          <td>积分</td>
	    </tr>
	    </thead>
	    <tbody id="dlbody">
</HeaderTemplate>
<ItemTemplate>
        <tr style="text-align:center;">
            <td><%#Eval("depotid")%></td>
            <td><%#Eval("d_name")%></td>
            <td><%#Convert.ToDateTime(Eval("sure_date")).ToString("yyyy-MM-dd")%></td>
            <td><%#Eval("dtype")%></td>
            <td><%#Eval("styleid")%> <%#Eval("s_name")%></td>
            <td><%#Eval("colorid")%> <%#Eval("c_name")%></td>
            <td><%#Eval("sizeid")%></td>
            <td><%# Math.Round(Convert.ToDouble(app_fun.reNull(Eval("x_price").ToString(),"0")),2)%></td>
            <td><%# Math.Round(Convert.ToDouble(app_fun.reNull(Eval("discount").ToString(),"0")),6)%></td>
            <td><%# Math.Round(Convert.ToDouble(app_fun.reNull(Eval("s_price").ToString(),"0")),2)%></td>
            <td><asp:Label ID="nums" runat="server" Text='<%# Eval("nums")%>'  ForeColor='<%#app_fun.d2c(Convert.ToDecimal(Eval("nums").ToString()))%>'></asp:Label></td>
            <td><asp:Label ID="sums" runat="server" Text='<%# Math.Round(Convert.ToDouble(app_fun.reNull(Eval("FSSums").ToString(),"0")),2)%>'  ForeColor='<%#app_fun.d2c(Convert.ToDecimal(Eval("FSSums").ToString()))%>'></asp:Label></td>
            <td><%# Math.Round(Convert.ToDouble(app_fun.reNull(Eval("cx_price").ToString(), "0")), 2)%></td>
            <td><%# Math.Round(Convert.ToDouble(app_fun.reNull(Eval("dk_price").ToString(), "0")), 2)%></td>
            <td><asp:Label ID="ss_price" runat="server" Text='<%# Math.Round(Convert.ToDouble(app_fun.reNull(Eval("ss_price").ToString(),"0")),2)%>'></asp:Label></td>
            <td><%# Math.Round(Convert.ToDouble(app_fun.reNull(Eval("FcalcDisc").ToString(), "0")), 2)%></td>
            <td><asp:Label ID="centum" runat="server" Text='<%# Math.Round(Convert.ToDouble(app_fun.reNull(Eval("vipcentum").ToString(),"0")),2)%>'></asp:Label></td>
            </tr>

</ItemTemplate>
<FooterTemplate>
        </tbody>
        <tfoot>
           <tr>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
              <td><asp:Label ID="ncount" runat="server" Text="0"></asp:Label></td>
              <td><asp:Label ID="scount" runat="server" Text="0"></asp:Label></td>
              <td></td>
              <td></td>
              <td><asp:Label ID="fcalcsums" runat="server" Text="0"></asp:Label></td>
              <td></td>
              <td><asp:Label ID="vipcentum" runat="server" Text="0"></asp:Label></td>
          </tr>
        </tfoot>
    </table>
</FooterTemplate>
    </asp:Repeater>

</form>



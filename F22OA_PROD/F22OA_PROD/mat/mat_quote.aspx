<%@ page language="C#" autoeventwireup="true" inherits="mat_mat_quote, App_Web_mat_quote.aspx.e229d74d" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <base target="_self" />
 <link  href="../css/project.css" type="text/css"  rel="stylesheet" />
 <script src="../b28web/Utility/jquery-1.2.6.min.js" type="text/javascript"></script>
 <script src="../b28web/Utility/jquery.alphanumeric.pack.js" type="text/javascript"></script>
 <style type="text/css"> 
        body{font-family:arial;overflow:hidden;}
        .ltd{ background:#D9E5F4; text-align:center;}
        .lhead{text-align:center;font-size:14px;font-weight:bold; height:20px;}
        table thead tr td{background:#FFEFEF;}
        
        .head{ background:rgb(236,233,216)}
        .mid{ background:rgb(236,233,216)}
        .bottom{ background:#cac}
        .rdadonly{background:rgb(236,233,200)}
 </style>
 <script type="text/javascript">
     $(function () {

         $("input[type='text']").width(95);
         $("input[type='text']").addClass("txt");

         $(".numeric").numeric();
         $(".dnumeric").numeric({ allow: "." });

         $(".s1").change(function () {
             $(".sums1").val($(".nums1").val() * $(".price1").val())
         });

         $(".s2").change(function () {
             $(".sums2").val($(".nums2").val() * $(".price2").val())
         });

         $(".s3").change(function () {
             $(".sums3").val($(".nums3").val() * $(".price3").val())
         });

         $(".s4").change(function () {
             $(".sums4").val($(".nums4").val() * $(".price4").val())
         });

         $(".s5").change(function () {
             $(".sums5").val($(".nums5").val() * $(".price5").val())
         });

         $(".s6").change(function () {
             $(".sums6").val($(".nums6").val() * $(".price6").val())
         });

         $("input[type='text']").change(function () {
             var sums = parseFloat($(".sums1").val() * 1) + parseFloat($(".sums2").val() * 1) + parseFloat($(".sums3").val() * 1)
                     + parseFloat($(".sums4").val() * 1) + parseFloat($(".sums5").val() * 1) + parseFloat($(".sums6").val() * 1)
                     + parseFloat($(".LaborPrice").val() * 1) + parseFloat($(".Fare").val() * 1) + parseFloat($(".Subsidy").val() * 1);
             $(".sums").val(sums);

             $(".sManagFee").val((sums * $(".ManagFee").val() / 100).toFixed(2));
             $(".sTaxes").val((sums * $(".Taxes").val() / 100).toFixed(2));

             var ssums = sums + $(".sManagFee").val() * 1 + $(".sTaxes").val() * 1;
             $(".ssums").val(ssums.toFixed(2))
         });


     });
 </script>
    <title>费用明细</title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="float:right;margin:5px 15px">

        <asp:Button ID="Button1" runat="server" Text="保存" CssClass="btn" 
            onclick="Button1_Click" />
    </div>
    <div>
        <asp:HiddenField ID="matid" runat="server" Value="0" />
        <table  width="600px" border="1" cellspacing="0" bordercolor="#003333" bordercolordark="#FFFFFF" >
            <thead>
                <tr class="lhead">
                    <td>项目名称</td>
                    <td>品牌</td>
                    <td>数量</td>
                    <td>单价</td>
                    <td>金额</td>
                    <td>备注</td>
                </tr>
            </thead>
            <tr class="head">
                <td rowspan="6" class="ltd">材料费用</td>
                <td><asp:TextBox ID="name1" runat="server"></asp:TextBox></td>
                <td><asp:TextBox ID="nums1" runat="server" CssClass="numeric nums1 s1" MaxLength="4"></asp:TextBox></td>
                <td><asp:TextBox ID="price1" runat="server" CssClass="dnumeric price1 s1" MaxLength="10"></asp:TextBox></td>
                <td><asp:TextBox ID="sums1" runat="server" ReadOnly="true" CssClass="rdadonly sums1"></asp:TextBox></td>
                <td><asp:TextBox ID="comment1" runat="server"></asp:TextBox></td>
            </tr>
             <tr class="head">
                <td><asp:TextBox ID="name2" runat="server"></asp:TextBox></td>
                <td><asp:TextBox ID="nums2" runat="server" CssClass="numeric nums2 s2" MaxLength="4"></asp:TextBox></td>
                <td><asp:TextBox ID="price2" runat="server" CssClass="dnumeric price2 s2" MaxLength="10"></asp:TextBox></td>
                <td><asp:TextBox ID="sums2" runat="server" ReadOnly="true" CssClass="rdadonly sums2"></asp:TextBox></td>
                <td><asp:TextBox ID="comment2" runat="server"></asp:TextBox></td>
            </tr>
            <tr class="head">
                <td><asp:TextBox ID="name3" runat="server" ></asp:TextBox></td>
                <td><asp:TextBox ID="nums3" runat="server" CssClass="numeric nums3 s3" MaxLength="4"></asp:TextBox></td>
                <td><asp:TextBox ID="price3" runat="server" CssClass="dnumeric price3 s3" MaxLength="10"></asp:TextBox></td>
                <td><asp:TextBox ID="sums3" runat="server" ReadOnly="true" CssClass="rdadonly sums3"></asp:TextBox></td>
                <td><asp:TextBox ID="comment3" runat="server"></asp:TextBox></td>
            </tr>
            <tr class="head">
                <td><asp:TextBox ID="name4" runat="server"></asp:TextBox></td>
                <td><asp:TextBox ID="nums4" runat="server" CssClass="numeric nums4 s4" MaxLength="4"></asp:TextBox></td>
                <td><asp:TextBox ID="price4" runat="server" CssClass="dnumeric price4 s4" MaxLength="10"></asp:TextBox></td>
                <td><asp:TextBox ID="sums4" runat="server" ReadOnly="true" CssClass="rdadonly sums4"></asp:TextBox></td>
                <td><asp:TextBox ID="comment4" runat="server"></asp:TextBox></td>
            </tr>
            <tr class="head">
                <td><asp:TextBox ID="name5" runat="server"></asp:TextBox></td>
                <td><asp:TextBox ID="nums5" runat="server" CssClass="numeric nums5 s5" MaxLength="4"></asp:TextBox></td>
                <td><asp:TextBox ID="price5" runat="server" CssClass="dnumeric price5 s5" MaxLength="10"></asp:TextBox></td>
                <td><asp:TextBox ID="sums5" runat="server" ReadOnly="true" CssClass="rdadonly sums5"></asp:TextBox></td>
                <td><asp:TextBox ID="comment5" runat="server"></asp:TextBox></td>
            </tr>
            <tr class="head">
                <td><asp:TextBox ID="name6" runat="server"></asp:TextBox></td>
                <td><asp:TextBox ID="nums6" runat="server" CssClass="numeric nums6 s6" MaxLength="4"></asp:TextBox></td>
                <td><asp:TextBox ID="price6" runat="server" CssClass="dnumeric price6 s6" MaxLength="10"></asp:TextBox></td>
                <td><asp:TextBox ID="sums6" runat="server" ReadOnly="true" CssClass="rdadonly sums6"></asp:TextBox></td>
                <td><asp:TextBox ID="comment6" runat="server"></asp:TextBox></td>
            </tr>
            <tr class="head">
                <td class="ltd"><span>人工费</span></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td><asp:TextBox ID="LaborPrice" runat="server" CssClass="dnumeric LaborPrice" MaxLength="10"></asp:TextBox></td>
                <td><asp:TextBox ID="LaborComm" runat="server"></asp:TextBox></td>
            </tr>
            <tr class="head">
                <td class="ltd"><span>车旅费</span></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td><asp:TextBox ID="Fare" runat="server" CssClass="dnumeric Fare" MaxLength="10"></asp:TextBox></td>
                <td><asp:TextBox ID="FareComm" runat="server"></asp:TextBox></td>
            </tr>
            <tr class="head">
                <td class="ltd"><span>补帖</span></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td><asp:TextBox ID="Subsidy" runat="server" CssClass="dnumeric Subsidy" MaxLength="10"></asp:TextBox></td>
                <td><asp:TextBox ID="SubsidyComm" runat="server"></asp:TextBox></td>
            </tr>
 
            <tr class="mid">
                <td  class="ltd"><b>小计</b></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td >&nbsp;</td>
                <td><asp:TextBox ID="sums" runat="server" ReadOnly="true" CssClass="rdadonly sums"></asp:TextBox></td>
                <td>&nbsp;</td>
            </tr>
            <tr class="mid">
                <td class="ltd"><span>管理费</span></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td><asp:TextBox ID="ManagFee" runat="server" MaxLength="10" CssClass="ManagFee"></asp:TextBox>%</td>
                <td><asp:TextBox ID="sManagFee" runat="server" ReadOnly="true" CssClass="rdadonly sManagFee"></asp:TextBox></td>
                <td><asp:TextBox ID="ManagFeeComm" runat="server" ></asp:TextBox></td>
            </tr>
            <tr class="mid">
                <td class="ltd"><span>税费</span></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td><asp:TextBox ID="Taxes" runat="server" MaxLength="10" CssClass="Taxes"></asp:TextBox>%</td>
                <td><asp:TextBox ID="sTaxes" runat="server" ReadOnly="true" CssClass="rdadonly sTaxes"></asp:TextBox></td>
                <td><asp:TextBox ID="TaxesComm" runat="server"></asp:TextBox></td>
            </tr>
            <tr class="head">
                <td class="ltd"><b>合计</b></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td><asp:TextBox ID="ssums" runat="server" ReadOnly="true" CssClass="rdadonly ssums"></asp:TextBox></td>
                <td>&nbsp;</td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>

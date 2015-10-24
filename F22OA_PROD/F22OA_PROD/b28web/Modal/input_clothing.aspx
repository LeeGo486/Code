<%@ page language="C#" autoeventwireup="true" inherits="Retail_Modal_input_clothing, App_Web_input_clothing.aspx.a056ca89" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>手工输入</title>
    <base target="_self" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache,must-revalidate" />

    <script src="../../js/Common/userdata.js" type="text/javascript"></script>

    <link href="../Utility/main.css" rel="stylesheet" type="text/css" />
    <style>
        #Table1 input
        {
            ime-mode: disabled;
        }
    </style>

    <script type="text/javascript">
        String.prototype.trim = function() {
            return this.replace(/(^\s*)|(\s*$)/g, "");
        }
        function addClothing() {
            var t = document.getElementById("Table1");
            var input = t.getElementsByTagName("INPUT");
            var str = "";
            for (var i = 0; i < input.length; i++) {
                if (input[i].value.length > 0 && input[i].type == "text") {
                    str += input[i].id + "♀" + input[i].value + "$";
                }
            }
            document.getElementById("HiddenField2").value = str;

        }

        function chgsize() {
            var t = document.getElementById("Table1");
            var X = t.style.width;
            var Y = t.style.height;
            if (X) { X = X.replace("px", "") }
            if (Y) { Y = Y.replace("px", "") }
            var m = parseInt(parseInt(X) + 60);
            var n = parseInt(parseInt(Y) + 180);

            if (m < 500) { m = 500 }

            window.dialogHeight = n + "px";
            window.dialogWidth = m + "px";
        }

        function psi(t, r, c, s) {
            if (t.type = "text") {
                if (s) {
                    t.select();
                } else {
                    s = "";
                }
                var tr = document.getElementsByTagName("TR");
                var tdr = tr[(r + 1)].getElementsByTagName("TD");
                for (n = 0; n < tdr.length; n++) {
                    tdr[n].style.background = s;
                }

                for (i = 0; i < tr.length; i++) {
                    var td;
                    if (i == 0) {
                        td = tr[i].getElementsByTagName("TH");
                        td[(c + 1)].style.background = s;
                    } else {
                        td = tr[i].getElementsByTagName("TD");
                        td[(c + 1)].style.background = s;
                    }
                }
            }
        }
        function chkinput(t, i, n) {
            var k = event.keyCode;
            //alert(k)
            if ((k >= 48 && k <= 57) || (k >= 96 && k <= 105) || k == 8 || k == 46 || k == 9 || k == 16) {
                return k;
            } else {
                var tab = document.getElementById("Table1");
                var tr = document.getElementsByTagName("TR");
                var ipt = tr[1].getElementsByTagName("INPUT");
                var input = tab.getElementsByTagName("INPUT");
                var m;

                if (k == 37) {        //left
                    m = i - 1
                } else if (k == 38) {  //top
                    m = i - n
                } else if (k == 39) {  //right
                    m = i + 1
                } else if (k == 40) {  //bottom
                    m = i + n
                } else {
                    return false;
                }
                //alert(input.length);
                if (m > (input.length) || m <= 0) {
                    return false;
                } else {
                    input[m - 1].focus();

                }
                event.keyCode = 0;
                return false;
            }
        }
        function KeyDown() {
            with (event) {
                if (keyCode == 27) {//ESC返回输入状态
                    document.getElementById('Button2').click();
                    event.keyCode = 0;
                    event.cancelBubble = true;
                    return false;
                } else if (keyCode == 116 || keyCode == 13) {//F5 使用
                    document.getElementById('Button1').click();
                    event.keyCode = 0;
                    event.cancelBubble = true;
                    return false;
                }
            }
        }
        function SetDefaultType(obj, val) {
            if (obj.checked) {
                UserData.save('rdochecktype', val);
                //                delCookie('rdochecktype');
                //                setCookie('rdochecktype',val);
            }
        }
        function GetDefaultType(obj, val) {
            //            var val = getCookie('rdochecktype');
            var val = '<%=ft %>' == '0' ? UserData.load('rdochecktype') : '<%=ft %>';
            switch (val) {
                case '2':
                    document.getElementById('RadioButton2').checked = true;
                    break;
                case '3':
                    document.getElementById('RadioButton3').checked = true;
                    break;
                default:
                    document.getElementById('RadioButton1').checked = true;
                    break;
            }
        }
        document.onkeydown = KeyDown;
        window.onload = GetDefaultType;
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div style="padding: 0 10px;">
        <div style="padding: 10px; text-align: left;">
            <asp:Label ID="Label1" runat="server" Text="请输入："></asp:Label>
            <asp:TextBox ID="TextBox1" runat="server" CssClass="input" Width="120"></asp:TextBox>&nbsp;
            <asp:Button ID="Button3" runat="server" CssClass="btn2" Text="查询" Width="50px" UseSubmitBehavior="False"
                OnClick="Button3_Click" OnClientClick="this.disabled=true;this.value='请稍等...'" />
            <asp:RadioButton ID="RadioButton1" runat="server" Checked="True" onclick="SetDefaultType(this,1);"
                GroupName="keyType" Text="款式名称" />
            <asp:RadioButton ID="RadioButton2" runat="server" GroupName="keyType" onclick="SetDefaultType(this,2);"
                Text="款式编号" />
            <asp:RadioButton ID="RadioButton3" runat="server" GroupName="keyType" onclick="SetDefaultType(this,3);"
                Text="助记码" />
            <asp:HiddenField ID="HiddenField1" runat="server" />
            <asp:HiddenField ID="HiddenField2" runat="server" />
        </div>
        <div style="padding: 10px 0; text-align: center;">
            <asp:Label ID="Label2" runat="server" Text="<br><br><br><br><br><br><br>请选择并输入款式名称/款式编号/助记码！<br><br><br><br><br><br>"
                ForeColor="Red"></asp:Label>
        </div>
        <asp:Table ID="Table1" runat="server" BackColor="#dddddd" CellSpacing="0" CellPadding="3">
        </asp:Table>
        <div style="padding: 10px; text-align: center;">
            <asp:Button ID="Button1" runat="server" Text="确定[F5]" Enabled="false" CssClass="btn2"
                Width="100px" OnClick="Button1_Click" OnClientClick="addClothing();this.disabled=true;this.value='请稍等...'"
                UseSubmitBehavior="false" />
            <asp:Button ID="Button2" runat="server" CssClass="btn2" Text="取消[Esc]" UseSubmitBehavior="False"
                OnClientClick="window.close();" Width="100px" />
        </div>
    </div>
    </form>
</body>
</html>

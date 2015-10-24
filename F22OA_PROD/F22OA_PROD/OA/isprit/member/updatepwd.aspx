<%@ page language="C#" autoeventwireup="true" inherits="isprit_member_updatepwd, App_Web_updatepwd.aspx.be6dd291" %>

<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>updatePWD</title>

    <script language="javascript" type="text/javascript" src="../../js/project.js"></script>
    <script language="javascript" type="text/javascript" src="../../../Scripts/jquery-1.2.6.min.js"></script>
    <link href="../../css/project.css" type="text/css" rel="STYLESHEET">

    <script language="javascript" type="text/javascript">
    
     $(function(){
          $("#btOK").click(CheckSubmit);
      });
      
      
       function CheckSubmit(){
        if($("#tbpwd1").val()==''){
            alert('请输入新密码！');
            $("#tbpwd1").focus();
            event.returnValue=false;
            return;
        }
        
        var pwd=$("#tbpwd1").val();
      
        if(pwd.indexOf("+")>-1)
        {
           alert('密码中不能包含+,请重新输入!');
           $("#tbpwd1").focus();
           event.returnValue=false;
           return;
        }  
        
        if(pwd.indexOf("%")>-1)
        {
           alert('密码中不能包含%,请重新输入!');
           $("#tbpwd1").focus();
           event.returnValue=false;
           return;
        }  
        
        if(pwd.indexOf("#")>-1)
        {
           alert('密码中不能包含#,请重新输入!');
           $("#tbpwd1").focus();
           event.returnValue=false;
           return;
        }  
        
        
        if(pwd.indexOf("&")>-1)
        {
           alert('密码中不能包含&,请重新输入!');
           $("#tbpwd1").focus();
           event.returnValue=false;
           return;
        }  
        
        if(pwd.indexOf("|")>-1)
        {
           alert('密码中不能包含|,请重新输入!');
           $("#tbpwd1").focus();
           event.returnValue=false;
           return;
        }  
        
        if(pwd.indexOf("'")>-1)
        {
           alert('密码中不能包含单引号,请重新输入!');
           $("#tbpwd1").focus();
           event.returnValue=false;
           return;
        }  
        
        if($("#tbpwd1").val().length>50){
            alert('密码长度不能超过50个字符,请重新输入!');
            $("#tbpwd1").focus();
            event.returnValue=false;
            return;
        }
       }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div id="jstable">
        <table id="table1" align="center" cellspacing="1" cellpadding="1" width="300" border="0"
            bgcolor="aliceblue">
            <tr>
                <td colspan="2">
                    <strong>更改密码</strong>
                </td>
            </tr>
            <tr>
                <td align="right" style="width: 82px">
                    真实姓名：
                </td>
                <td>
                    <asp:Label ID="lbname" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="right" style="width: 82px">
                    用户ID：
                </td>
                <td>
                    <asp:Label ID="lbid" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="right" style="width: 82px">
                    原密码:
                </td>
                <td>
                    <asp:TextBox ID="tboldpwd" runat="server" TextMode="Password" CssClass="bt"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right" style="width: 82px">
                    新密码：
                </td>
                <td>
                    <asp:TextBox ID="tbpwd1" runat="server" TextMode="Password" CssClass="bt"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                        ControlToValidate="tbpwd1"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td align="right" style="width: 82px">
                    再次输入：
                </td>
                <td>
                    <asp:TextBox ID="tbpwd2" runat="server" TextMode="Password" CssClass="bt"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rv" runat="server" ErrorMessage="*" ControlToValidate="tbpwd2"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td align="right" style="width: 82px">
                    &nbsp;
                </td>
                <td>
                    <asp:Button ID="btOK" runat="server" CssClass="btn" Text="更改密码" OnClick="btOK_Click"
                       ></asp:Button>
                    <span id="closespan"></span>
                </td>
            </tr>
        </table>
         <table  id="tbtips" width="300px" align="center"  valign="middle" height="10px"  cellpadding="0" cellspacing="0"  style="margin-top:12px; border:0px solid #cad9ea;"  runat="server">
             <tr>
                <td>
                   说明:<br />
                   1:F22系统启用了高强度密码策略.<br />
                   2:密码长度必须<font color="red">大于<%=passwordlength%>位，同时小于50位。</font> <br />  
                   3:密码必须由<font color="red">字母、数字、特殊符两种以上组成</font>不能包含<font color="red">+ % # & | ' </font>.
                  
                   
                </td>
             </tr>
             </table>  
        <p align="center">
            <asp:Label ID="lberror" runat="server"></asp:Label>
            <asp:CompareValidator ID="cv" runat="server" ErrorMessage="二次输入的密码不相符" ControlToCompare="tbpwd1"
                ControlToValidate="tbpwd2"></asp:CompareValidator>
        </p>
    </div>

    <script type="text/javascript" defer="defer">
    	jsTable('jstable','lr','65%','120','center');
			goBack("","closespan");
    </script>

    </form>
</body>
</html>

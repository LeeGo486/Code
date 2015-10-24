<%@ page language="C#" autoeventwireup="true" inherits="modifypass, App_Web_modifypass.aspx.cdcab7d2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>密码修改</title>
    <link href="Css/ModifyPassword.css"  type ="text/css" rel="Stylesheet" />
    <link href="OA/css/project.css" type="text/css" rel="stylesheet" />
      <script type="text/javascript"  src="Scripts/jquery-1.2.6.min.js"></script> <!--jQuery -->
    <script language="javascript" type="text/javascript">
      
      $(function(){
          $("#btnok").click(CheckSubmit);
      });
 
       function CheckSubmit(){
       
        if ($("#Password").val()==''){
           alert('请输入旧密码!');
           $("#Password").focus();
           event.returnValue=false;
           return;
        }
        
   
        if($("#NewPassword").val()==''){
            alert('请输入新密码！');
            $("#NewPassword").focus();
            event.returnValue=false;
            return;
        }
        
        var pwd=$("#NewPassword").val();
      
        if(pwd.indexOf("+")>-1)
        {
           alert('密码中不能包含+,请重新输入!');
           $("#NewPassword").focus();
           event.returnValue=false;
           return;
        }  
        
        if(pwd.indexOf("%")>-1)
        {
           alert('密码中不能包含%,请重新输入!');
           $("#NewPassword").focus();
           event.returnValue=false;
           return;
        }  
        
        if(pwd.indexOf("#")>-1)
        {
           alert('密码中不能包含#,请重新输入!');
           $("#NewPassword").focus();
           event.returnValue=false;
           return;
        }  
        
        
        if(pwd.indexOf("&")>-1)
        {
           alert('密码中不能包含&,请重新输入!');
           $("#NewPassword").focus();
           event.returnValue=false;
           return;
        }  
        
        if(pwd.indexOf("|")>-1)
        {
           alert('密码中不能包含|,请重新输入!');
           $("#NewPassword").focus();
           event.returnValue=false;
           return;
        }  
        
        if(pwd.indexOf("'")>-1)
        {
           alert('密码中不能包含单引号,请重新输入!');
           $("#NewPassword").focus();
           event.returnValue=false;
           return;
        }  
        
        /*
        if (!checkpassword($("#NewPassword").val()))
        {
            alert('新密码必须含有字母,请重新输入!');
            $("#NewPassword").focus();
            event.returnValue=false;
            return;
        }
        */
         var len="<%=passlength%>";
        if($("#NewPassword").val().length<=len){
            alert('新密码长度不够,请重新输入!');
            $("#NewPassword").focus();
            event.returnValue=false;
            return;
        }
        
        if($("#NewPassword").val().length>50){
            alert('密码长度不能超过50个字符,请重新输入!');
            $("#NewPassword").focus();
            event.returnValue=false;
            return;
        }
        
        
        if($("#NewPassword").val()!=$("#NewPassword2").val()){
            alert('两次密码输入不正确！');
            $("#NewPassword2").focus();
            event.returnValue=false;
            return;
        }
              
        if(confirm('确定要修改密码吗？')==false){
            event.returnValue=false;
            return;
        }
        ajax_modifypass();
    }
    
    function ajax_modifypass(){
      var dbtype="<%=dbtype%>";
      var result = ajax_rText("oa//updatepass.aspx","pwd="+$("#Password").val()+"&newpwd="+$("#NewPassword").val())

      //密码修改成功
      if (result==1){
         
          alert("密码修改成功!");
         if (dbtype==4)
         {
            window.location="oa//loadoa.aspx?pass="+$("#NewPassword").val();
         }
         else
         {
          
           window.location="oa//Default.aspx";
         }
         
      }
      
      
      
      if (result==-1){
         alert("密码修改发生异常,请重新输入!");
         $("#Password").val('');
         $("#NewPassword").val('');
         $("#NewPassword2").val('');
      } 
      
      if (result==-2){
         alert("旧密码不正确,请重新输入!");
         $("#Password").val('');
      } 
      
      if (result==-3){
         alert("您的密码必须由字母、数字、特殊符两种以上组成，修改密码失败！!");
         $("#NewPassword").val('');
         $("#NewPassword2").val('');
      } 
    }
    
     //取得更新结果
    function ajax_rText(url,data)
    {
        var html = $.ajax({
        url: url,
        type: "POST",
        data: data,
        async: false
        }).responseText;
        return html;
    }
         
    function checkpassword(str)
    {
         
        var reg = /[_a-zA-Z]/;
        if(reg.test(str))
        {
          return true;
        }
        else
        {
          return false;
        }
    } 
  
    function FormReset()
	{
	   form1.reset();
	}
    </script>
</head>
<body style="width:100%;">
    <form id="form1" runat="server">
    <div id="divmain" class="wrap" style=" margin:0px auto; border:0px solid red;">
     <table width="360px" align="center"  valign="middle" height="200px" class="tb" cellpadding="0" cellspacing="0"  style="margin-top:100px; border:1px solid #cad9ea;">
                <tr>
                    <td colspan="2" class="passtitle">
                     <b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;请重新设置密码</b>
                    </td>
                </tr>
                 <tr class="tr3">
                     <td style="width: 30%;" class="td1" align="right">
                         <asp:Label ID="Label1" runat="server" Text="旧密码：" ForeColor="Black" Width="100%"></asp:Label></td>
                     <td style="width: 60%;" class="td1" align="left"><asp:TextBox ID="Password" Width="165px" TextMode="Password"  runat="server"></asp:TextBox><span  style="color: red">*</span></td>
                         
                 </tr>
                
                 <tr class="tr3">
                     <td style="width: 30%;" class="td1" align="right">
                             <asp:Label ID="Label2" runat="server" ForeColor="Black" Text="新密码：" Width="100%"></asp:Label></td>
                     <td style="width: 60%;" class="td1"  align="left"><asp:TextBox ID="NewPassword" Width="165px" TextMode="Password" runat="server"></asp:TextBox><span
                             style="color: #ff0000">*</span></td>
                     
                 </tr>
                 
                    <tr class="tr3">
                     <td style="width: 30%;" class="td1" align="right">
                         <asp:Label ID="Label3" runat="server" Text="重复新密码：" ForeColor="Black" Width="100%"></asp:Label></td>
                     <td style="width: 60%;" class="td1"  align="left"><asp:TextBox ID="NewPassword2" Width="165px" TextMode="Password" runat="server"></asp:TextBox><span
                             style="color: #ff0000">*</span></td>
                     
                 </tr>
                 
                                
                <tr class="tr3">
                     
                     <td style="width: 100%;" class="td1" colspan="2" align="center" > 
                         <input type="button" class="btn" value="修 改" id="btnok" />    
                         <input type="button"  onclick="FormReset();"   class="btn" value=" 重 填 "  name="btnCancle" /></td>
                     
                     
                 </tr>
                 
                
             </table>
         
             <table width="360px" align="center"  valign="middle" height="10px" class="tb" cellpadding="0" cellspacing="0"  style="margin-top:12px; border:0px solid #cad9ea;">
             <tr>
                <td>
                   说明：<br />
                   1:F22系统启用了高强度密码策略.<br />
                   2:您的密码过于简单,密码长度必须<font color="red">大于<%=passlength%>位，同时小于50位。</font> <br />  
                   3:密码必须由<font color="red">字母、数字、特殊符两种以上组成</font>不能包含<font color="red">+ % # & | ' </font>.
                  
                   
                </td>
             </tr>
             </table>  
    </div>
   
    </form>
</body>
</html>

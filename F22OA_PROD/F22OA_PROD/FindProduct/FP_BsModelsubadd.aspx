<%@ page language="C#" autoeventwireup="true" inherits="FindProduct_FP_BsModelsubadd, App_Web_fp_bsmodelsubadd.aspx.a918743" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>增加调查项目</title>
    <link  href="../css/project.css" type="text/css"  rel="stylesheet">
		    <script language="javascript" type="text/javascript">
     function addFile()
    {
       
    	var str1 = '编号:<INPUT type="text" size="10" id="AnswerNo2" runat="server"    class="tbinput" style="width: 50px" NAME="txtBox">'
    	var str2= '   &nbsp; &nbsp;内容:<INPUT type="text" size="50" id="strAnswerName2" runat="server"   class="tbinput" style="width: 150px" NAME="txtBox">'
    	var str3= '   &nbsp; &nbsp;分值:<INPUT type="text" size="10" id="strAnswerScore2" runat="server" value="100"   class="tbinput" style="width: 50px" NAME="txtBox">(<font color="red">*</font>数字类型)<br>'
    	document.getElementById('MyFile').insertAdjacentHTML("beforeEnd",str1+str2+str3)
    	
    }
    /* 检测字符串是否是指点的数点数 */
function isfloat(_T)
{
if(_T.AnserScore2.value.length<=0){
 var str=_T.AnserScore2.value
  var number_chars = "1234567890.";
        var i;
        for (i=0;i<str.length;i++)
        {
            if (number_chars.indexOf(str.charAt(i))==-1)
            {
               msg="这里应该是数字；";
               alert(msg);
            return false;
             }
        }
        
  if (str.length==0)
  {
   msg="数字位不能为空";
   alert(msg);
   return false;
  }
  return true;
  }
  return true;
}
           
    </script>
</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
        <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">增加调查题目</span>&nbsp;&nbsp;&nbsp;
					
				</TD>
				<TD class="tdTitle2"></TD>
				<TD class="tdTitle3">
                    <span id="rm_MainPanel_lPageNO"></span></TD>
			</TR>
	</TABLE>
    <!--head end-->
    <!--menu----->
   <table  width="98%" class="menu">
    <tr>
    <td align="right">
    <div >

      <asp:Button ID="BtnGo" Width="100px" runat="server" Text="查看调查方案" CssClass="btn"   OnClientClick="window.location.href='FP_BsModel.aspx'; return false;"   />
      <asp:Button ID="BtnGo2" Width="100px" runat="server" Text="查看调查题目" CssClass="btn" CausesValidation="false"  OnClick="BtnGo2_Click"     />
      <asp:Button ID="BtnSave" Width="100px" runat="server" Text="保 存" CssClass="btn" OnClick="Savedata" />
     </div>  
        </td> 
    </tr>
    </table>
  

      <div  class="BContent">
    <table width="100%">
      <tr>
    <td colspan="2">
  
        <asp:Label ID="LblModelId" runat="server" Font-Size="14pt"></asp:Label>
        <asp:Label ID="LblModelName" runat="server" Font-Size="14pt"></asp:Label></td>
    </tr>
    <tr>
    <tr>
    <td style="height: 30px">调查题目:</td>
    <td style="height: 30px">
    
       <asp:TextBox ID="TxtTitle" runat="server" Width="300px"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TxtTitle"
            ErrorMessage="*"></asp:RequiredFieldValidator>&nbsp;
        分值系数:
    
      <asp:TextBox ID="TxtTitleNum" runat="server" Text="100"
                Width="50px"></asp:TextBox>(%)
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TxtTitleNum"
            ErrorMessage="*"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TxtTitleNum"
            ErrorMessage="*数字类型" ValidationExpression="(^-?\d\d*\.\d*$)|(^-?\d\d*$)|(^-?\.\d\d*$)"></asp:RegularExpressionValidator></td>
    </tr>
   <tr>
    <td>
        </td>
    <td>
        说明:题目的分值系数*答案分值=该题目所得分,请分配好调查各题的分值系数，各题分值系数加起来为100</td>
    </tr>
    <tr>
    <td colspan="2">
    <hr  style="display:inline;"/>
    </td>
    </tr>
    <tr>
    <td >
        题目答案:
    </td>
    <td></td>
    </tr>
    <tr>
    <td></td>
    <td>
    <table width="100%" align="left">
    <tr>
       
    <td style="width: 561px; height: 14px;">
     <P id="MyFile">
         编号:<asp:TextBox ID="TxtAnwserNo" runat="server" Width="50px" Text="A"></asp:TextBox>
         <asp:RequiredFieldValidator ID="RFVAnserNo" runat="server" ControlToValidate="TxtAnwserNo"
             ErrorMessage="*"></asp:RequiredFieldValidator>
         内容:<asp:TextBox ID="TxtAnserName" runat="server" Width="150px"></asp:TextBox>
             <asp:RequiredFieldValidator ID="RFVName" runat="server" ControlToValidate="TxtAnserName"
             ErrorMessage="*"></asp:RequiredFieldValidator>
             分值:<asp:TextBox ID="TxtAnserScore" runat="server"
                     Width="50px">100</asp:TextBox>(<font color="red">*</font>数字类型)
         <asp:RequiredFieldValidator ID="RFVScore" runat="server" ControlToValidate="TxtAnserScore"
             ErrorMessage="*"></asp:RequiredFieldValidator>
             <asp:RegularExpressionValidator ID="REVScore"
                 runat="server" ErrorMessage="*数字类型" ValidationExpression="(^-?\d\d*\.\d*$)|(^-?\d\d*$)|(^-?\.\d\d*$)" ControlToValidate="TxtAnserScore" ></asp:RegularExpressionValidator>
          <br />
        </p>
    </td>
    <td valign="bottom">
        <input accesskey="z" class="btn" onclick="addFile()"  type="button"  value="增加答案(Z)" style="width: 100px" />
       </td>
    </tr>
    </table>
    </td>
    </tr>
    <tr>
    <td align="center" colspan="2">
        <asp:Label ID="LblAlart" runat="server" ForeColor="Red"></asp:Label></td>
    </tr>
    </table>
    </div>
    </form>
    
</body>
</html>

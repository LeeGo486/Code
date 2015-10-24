<%@ page language="C#" autoeventwireup="true" inherits="OA_isprit_news_d_newsclothing, App_Web_d_newsclothing.aspx.9a188d08" %>

<%@ Register Src="../../../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>

<%@ Register TagPrefix="CE" Namespace="CuteEditor" Assembly="CuteEditor" %>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>添加、编辑货品专栏</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<meta http-equiv="Content-Language" content="zh-cn">
		<LINK  href="../../css/project.css" type="text/css" rel="STYLESHEET"/>
		<script language="javascript" type="text/javascript" src="../../js/project.js"></script>
	
		<script language="javascript" type="text/javascript">
			//清除用户
function clear_user(v){
	if(v>0){
		var TO_NAME = document.getElementById("TO_NAME"+v);
		var TO_ID = document.getElementById("TO_ID"+v);
	}else{
		var TO_NAME = document.getElementById("TO_NAME");
		var TO_ID = document.getElementById("TO_ID");
	}
	TO_NAME.value="";
	TO_ID.value="";
}
//清除文件
function clear_file()
{
	document.getElementById("TO_FILE").value="";
	document.getElementById("HFILE").value="";
}
function addFile()
{
	var str = '<input type="file" style="width: 100%" runat="server" name="File" /><br/>';
	document.getElementById('iUpload').insertAdjacentHTML("beforeEnd",str)
}
</script>
</head>
<body  style="margin:0;">
    <form id="frmMain" runat="server" >
        <uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
    <div style="padding:10px;">
        <table width="100%">
        <tr>
        <td>
        <table  width="100%" >
   <colgroup>
   <col  width="60px"/>
    <col width="450px"/>
   <col />
   </colgroup>
   
        <tr>
   <td style="height: 28px">
       <asp:Label ID="Label9" runat="server" Text="标题:" Width="80px"></asp:Label></td>
   <td style="height: 28px">
       <asp:TextBox ID="TxtTitle" runat="server" CssClass="tbox" MaxLength="100" Width="98%"></asp:TextBox></td>
   <td style="height: 28px">
      
   </td>

   </tr>
   <tr>
   <td>
       <asp:Label ID="Label2" runat="server" Text="发   布  人:" Width="80px"></asp:Label></td>
   <td >
       <asp:TextBox ID="TxtPublisher" runat="server" CssClass="tbox" MaxLength="20" Width="98%"></asp:TextBox>
    </td>
    <td>
        类别:<select id="lbclass" runat="server" accesskey="b" datatextfield="newsclass" datavaluefield="classid"
            style="width: 118px">
            <option selected="selected"></option>
        </select><asp:CheckBox ID="ChkBoxAll" runat="server" Text="所有人接受" AutoPostBack="true" OnCheckedChanged="ChkBoxAll_CheckedChanged" /></td>
   </tr>
  
    <tr>
   <td ><asp:Label ID="Label4" runat="server" Text="加盟商接收人:" Width="80px"></asp:Label></td>
   <td >
      <TEXTAREA style="width: 98%; height: 25px;" id="TO_NAME" class="tbox" name="TO_NAME" readOnly  cols=62 runat="server"></TEXTAREA></td>
    <td >
       
       <a href="#" ></a>
                <INPUT onclick="LoadWindow('../module/selectmerchant.aspx',405,480,this.value,'50%')" type=button  value="添加接受人" class="NormalBtn"  size="" /><INPUT title="清空收件人" onclick="clear_user(0)" type="button" value="清 空" name="button" class="NormalBtn" /><asp:CheckBox ID="ChkBoxMenchart" runat="server" Text="所有加盟商" /></td>
   </tr>
   <tr>
   <td>
       <asp:Label ID="Label5" runat="server" Text="店铺接收人:"></asp:Label></td>
   <td >
       <textarea id="TO_NAME2" runat="server" class="tbox" cols="62" name="TO_NAME2"
           readonly="readonly" style="width: 98%; height: 25px"></textarea></td>
    <td>
        <INPUT onclick="LoadWindow('../module/selectdepot.aspx',405,480,this.value,'50%')" type=button value="添加接受人" size="" class="NormalBtn" /><INPUT title="清空收件人" onclick="clear_user(2)" type=button value="清 空" name="button" class="NormalBtn" /><asp:CheckBox ID="ChkBoxDepot" runat="server" Text="所有的店铺" /></td>
   </tr>
    <tr>
   <td>
       <asp:Label ID="Label6" runat="server" Text="部门接收人:" Width="80px"></asp:Label></td>
   <td >
       <textarea id="TO_NAME3" runat="server" class="tbox" cols="62" name="TO_NAME3"
           readonly="readonly" style="width: 98%; height: 25px"></textarea></td>
    <td>
        <INPUT onclick="LoadWindow('../module/selectdepart.aspx',405,480,this.value,'50%')" type=button value="添加接受人" size="" class="NormalBtn" /><INPUT title="清空收件人" onclick="clear_user(3)" type=button value="清 空" name="button" class="NormalBtn" /><asp:CheckBox ID="ChkBoxDepart" runat="server" Text="所有的部门" /></td>
   </tr>
  <tr>
  <td><asp:Label ID="Label7" runat="server" Text="附 件:" Width="80px"></asp:Label></td>
   <td><p id="iUpload"></p></td>
    <td valign="top"><p><input type="button" value="添加附件.." onclick="addFile();" class="tbNoBorder" />&nbsp;</p></td>
  </tr>
   </table>
        </td>
        </tr>
        </table>
      <table  width="100%" >
   <colgroup>
   <col  width="100px"/>
    <col />
   <col width="100px"/>
   </colgroup>
   <hr />
   <tr>
   <td></td>
   <td colspan="2">
  
   <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            Caption="符件列表" CaptionAlign="Left" DataKeyNames="fileid" 
             Width="90%" OnRowCommand="GridView1_RowCommand">
            <Columns>
                
                
                <asp:TemplateField HeaderText="" SortExpression="filename">
                  
                    <ItemTemplate>
                       <a href='../Module/openfile.aspx?url=../../file/uploadFiles/<%# Eval("fileurl") %>' ><asp:Label ID="Label1" runat="server" Text='<%# Bind("filename") %>'></asp:Label></a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete" CommandArgument='<%# Eval("fileurl") %>'
                            Text="删除" OnClientClick="return confirm('确认要删除此数据吗？')"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                               <RowStyle HorizontalAlign="Center" />
        </asp:GridView>
     
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="F22_dnews_DelfileExtran"
            SelectMethod="F22_dnews_getfileExtran" TypeName="ddl_F22">
            <DeleteParameters>
                <asp:Parameter Name="fileid" Type="Int32" />
            </DeleteParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="HFID" DefaultValue="0" Name="articleid" PropertyName="Value"
                    Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
     
       <asp:HiddenField ID="HFID" runat="server" />
   </td>
   </tr>
   <tr>
   <td colspan="3">
   <table width="100%">
   <tr>
   <td>
         <CE:Editor id="whtml" EditorWysiwygModeCss="~/css/webhtml.css" AutoConfigure="simple" runat="server" Width="98%"></CE:Editor>
     </td>
   </tr>
   </table>  
       </td>
   </tr>
   <tr>
   <td><asp:Button ID="BtnSubmit" runat="server" Text="提交" CssClass="NormalBtn" OnClick="BtnSubmit_Click" OnClientClick="return confirm('确认要发布公告吗？')" Width="100px" /></td>
      <td></td>
         <td></td>
   </tr>
   </table>
    </div>
       <a href="javascript:;" onclick="alert(document.getElementById('TO_ID2').value);">view</a> 
    <INPUT id="TO_ID" type=hidden name="TO_ID" runat="server" style="width: 88px" />
     <INPUT id="TO_ID2" type=hidden name="TO_ID2" runat="server" style="width: 88px" />
     <INPUT id="TO_ID3" type=hidden name="TO_ID3" runat="server" style="width: 88px" />
    </form>
</body>
</html>


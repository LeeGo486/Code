<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Modal.master" AutoEventWireup="true"
    CodeBehind="ShowStyle.aspx.cs" Inherits="F23Web.Public.ShowStyle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        #divMin
        {
        	padding:5px;
        }
        #divStyle
        {
            width:425px;
            float:left;	
            padding:10px;
        }
        #divPicture
        {
           float:right;	
        }
        #pic
        {
        }
        input
        {
        	width:8px;
        	 
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 <div id="divMain" >
 <div id="divStyle" >
    <h3>款式信息</h3>
   <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-bottom-color:Gray" >
    <tr>
        <td width="80px" >款式名称: </td><td ><asp:Label ID="lblS_name" runat="server" Text=""></asp:Label></td>
        <td width="80px">款式编码:</td><td ><asp:Label ID="lblStyleid" runat="server" Text=""></asp:Label></td>
    </tr>
    <tr>
      <td>款式年份:</td><td><asp:Label ID="lblSt_year" runat="server" Text=""></asp:Label></td>
      <td>款式季节:</td><td><asp:Label ID="lblSt_month" runat="server" Text=""></asp:Label></td>
    </tr>
    <tr>
      <td>原料:</td><td><asp:Label ID="lblSt_cloth" runat="server" Text=""></asp:Label></td>
      <td>款式大类:</td><td><asp:Label ID="lblSt_dl" runat="server" Text=""></asp:Label></td>
    </tr>
    <tr>
      <td>款式小类:</td><td><asp:Label ID="lblSt_xz" runat="server" Text=""></asp:Label></td>
      <td>款式性别:</td><td><asp:Label ID="lblSt_xb" runat="server" Text=""></asp:Label></td>
    </tr>
    <tr>
      <td>款式现价:</td><td><asp:Label ID="lblX_price" runat="server" Text=""></asp:Label></td>
      <td>计量单位:</td><td><asp:Label ID="lblSt_by1" runat="server" Text=""></asp:Label></td>
    </tr>
     </table><br />
     <h3>买点说明</h3>
    <textarea cols="80"  rows="6" runat="server" id="txtArea" class="field" name="txtArea">      
     </textarea>
 </div>
 <div id="divPicture" runat="server"  >
 <table>
    <tr>
        <td> <img id="pic" width="160" height="200" alt="图片" /></td>
    </tr>
    <tr>
        <td>
            <input type='button' value='1' class="showbtn" />
            <input type='button' value='2' class="showbtn" />
            <input type='button' value='3' class="showbtn" />
            <input type='button' value='4' class="showbtn" />
            <input type='button' value='5'  class="showbtn"/>
            <input type='button' value='6' class="showbtn" />
        </td>
    </tr>
 </table>
 </div>
 </div>
</asp:Content>
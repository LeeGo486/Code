<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowRI_List.aspx.cs" Inherits="EPReper.Web.manager.ReperInfo.ShowRI_List" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>自助维修平台</title>
    <link href="../../Styles/css.css" rel="stylesheet" type="text/css" />
    <link href="../../Styles/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <center>
        <form id="form1" runat="server" method="post">
        <table class="table" border="0" cellpadding="0" cellspacing="1" bgcolor="#FFFFFF">
            <tr>
                <td>
                    <table width="100%">
                        <tr align="left">
                            <td>
                                <asp:Button ID="baoxiu" runat="server" OnClick="bx" Text="报    修" class="btn3_mouseout"
                                    onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'"
                                    onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"
                                    title="报修" />&nbsp;&nbsp;
                                <asp:Button ID="gz" runat="server" Text="维修任务" OnClick="work" class="btn3_mouseout"
                                    onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'"
                                    onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"
                                    title="维修任务" />&nbsp;&nbsp;
                                <asp:Button ID="repair" runat="server" Text="维修员" OnClick="rep" Visible="false" class="btn3_mouseout"
                                    onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'"
                                    onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"
                                    title="维修员" />&nbsp;&nbsp;
                                <asp:Button ID="mulu" runat="server" Text="目录管理" Visible="false" OnClick="ml" class="btn3_mouseout"
                                    onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'"
                                    onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"
                                    title="目录管理" />&nbsp;&nbsp;
                                <asp:Button ID="renyuan" runat="server" Text="人员管理" Visible="false" OnClick="ry"
                                    class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'"
                                    onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"
                                    title="人员管理" />
                            </td>
                            <td>
                                <a href="../../logout.aspx">注销</a>
                            </td>
                        </tr>
                    </table>
                    <div class="ucts">
                        <div class="repair" id="ClassView" runat="server">
                            <ul>
                                <li style="background-image: url('../../Images/ico/插座1.png'); background-position: bottom;
                                    background-repeat: repeat-x; width: 100px; height: 100px;"><a href="#"></a></li>
                            </ul><font style="font-size: 25px; color:#33CC33"> dd</font>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        </form>
    </center>
</body>
</html>

<%@ page language="C#" autoeventwireup="true" inherits="depotMgr_depotInfo, App_Web_depotinfo.aspx.9ee944ed" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>������Ϣ</title>
    <link href="../depotMgr/scripts/common.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form2" runat="server">
    <div>
<table width="100%" border="0" cellpadding="0" cellspacing="5">
  <tr>
    <td colspan="2" >
    <div id="depotinfomenu">
    <ul>
    <li><a href="depotInfo.aspx?depotid=<%=depotid %>" class="mthis">������Ϣ</a></li>
    <li><a href="depotFile.aspx?depotid=<%=depotid %>">�����ĵ�</a></li>
    <li><a href="depotUser.aspx?depotid=<%=depotid %>">��Ա����</a></li>
    <li><a href="depotSale.aspx?depotid=<%=depotid %>">�������</a></li>
    </ul>
    </div>    </td>
  </tr>
    
  <tr>
    <td colspan="2" valign="top"> </td>
  </tr>
  <tr>
    <td width="50%" valign="top" style="border:none;border-right:solid 1px #eaeaea;">
    <dl>

      <dt>������Ϣ</dt>
      <dd>
        <strong>��������</strong>��<asp:Label ID="Label2" runat="server" Text=""></asp:Label><br />
        <strong>���̱��</strong>��<asp:Label ID="Label1" runat="server" Text=""></asp:Label><br />
        <strong>��������</strong>��<asp:Label ID="Label7" runat="server" Text=""></asp:Label><br />
        <strong>�硡����</strong>��<asp:Label ID="Label3" runat="server" Text=""></asp:Label><br />
        <strong>��������</strong>��<asp:Label ID="Label4" runat="server" Text=""></asp:Label><br />
        <strong>�� �� ��</strong>��<asp:Label ID="Label5" runat="server" Text=""></asp:Label><br />
        <strong>�ʡ�����</strong>��<asp:Label ID="Label6" runat="server" Text=""></asp:Label><br />
        <strong>��������</strong>��<asp:Label ID="Label8" runat="server" Text=""></asp:Label><br />
        <strong>�ء���ַ</strong>��<asp:Label ID="Label12" runat="server" Text=""></asp:Label><br />
        <strong>������ע</strong>��<asp:Label ID="Label13" runat="server" Text=""></asp:Label><br />
          </dd>
    </dl></td>
    <td valign="top">
    <dl>
      <dt>���̸�����</dt>
      <dd><strong>����</strong>��<asp:Label ID="Label9" runat="server" Text=""></asp:Label><br />
        <strong>�ֻ�</strong>��<asp:Label ID="Label10" runat="server" Text=""></asp:Label><br />
        <strong>����</strong>��<asp:Label ID="Label11" runat="server" Text=""></asp:Label><br />
        </dd>
      <dt>�ĵ�ͳ��</dt>
      <dd><div ID="filecount" runat="server" >
      </div>
          <br />
          </dd>
    </dl>    
	</td>
  </tr>
</table>

    </div>
    </form>
</body>
</html>


<%@ page language="C#" autoeventwireup="true" inherits="isprit_WORDPAD_shownote, App_Web_shownote.aspx.2b69af9" %>

<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>shownote</title>
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
</head>
<body style="margin:0px;">
    <form id="form1" runat="server">
    <div id="tmtable">
      <TABLE id="Table2" cellSpacing="1" cellPadding="1" width="100%" align="center"
        bgColor="whitesmoke" border="0">
        <TR>
          <TD height="300" colspan="8" valign="top">
          <div style="margin:20px 40px;line-height:30px;font-weight:bold; font-size:14px;text-align:center;">
          <asp:label id="lbtitle" runat="server"></asp:label>
          </div>
          <div style="line-height:40px; border-bottom:dotted 1px #DDD;text-align:center;">
						日期：<asp:label id="lbdate" runat="server"></asp:label>
          　　　类别：<asp:label id="lbclass" runat="server"></asp:label>
          </div>
          <div style="line-height:20px;padding:20px;">
              <asp:label id="lbcontent" runat="server"></asp:label>
          </div>
          </TD>
        </TR>
        <TR>
          <TD align="center" colSpan="8">
          <span id="backSpan"><input class="btn" type="button" value="返 回" onclick="javascript:history.go(-1);" /></span>
          </TD>
        </TR>
      </TABLE>
      </div>
		<script type="text/javascript" defer="defer">
				goBack("日常记录");
				jsTable('tmtable','tt','90%','','center');
		</script>
    </form>
</body>
</html>

<%@ page language="C#" autoeventwireup="true" inherits="isprit_Book_book_delete, App_Web_book_delete.aspx.b5839e7c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@   OutputCache   Duration="1"   VaryByParam="none"   %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>预借记录删除</title>
    <base target="_self"></base>
    <LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
		<script language=javascript type=text/javascript>

			function refresh(){
				var w;
				//w=parent.dialogArguments.location.reload();				
			}
			
			
		</script>
		
</head>
<body style="margin:10px 20px">
    <form id="form1" runat="server">
    <div style="line-height:30px;">
    提示：<asp:Label id="lb" runat="server"></asp:Label>
    </div>
    <div align="center"><input type="button" onclick="refreshTab(0);CloseWindow('删除借书记录')" value="关 闭" class="btn"/></div>
    </form>
</body>
</html>

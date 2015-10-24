<%@ page language="C#" autoeventwireup="true" inherits="isprit_ok, App_Web_ok.aspx.a9e09044" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<title>发送成功</title>
    <link href="../css/project.css" type="text/css" rel="stylesheet" />
<script type="text/javascript">
	
	//判断是否为新标签；如果不是则退回，并且在新标签中打开“写邮件”的标签
	
	var mainPanel = top.Ext.getCmp("doc-body");
	
	var tt = mainPanel.getActiveTab().title;
	var nt = "发送成功";	/*根据当前页面修改*/

	if(tt!=nt){
	    var href = location.href;
        mainPanel.remove("docs-"+tt);
	   // history.go(-1);
	    mainPanel.loadClass(href,nt);
    }
	
    function gotoUrl(v){
	
    //先关闭当前窗口
     mainPanel.remove(mainPanel.getActiveTab());
    
        if(v==1){
            mainPanel.loadClass('isprit/msg/msg_inbox.aspx','收信箱');
        }else if(v==2){
            mainPanel.loadClass('isprit/msg/msg_outbox.aspx','发信箱');
        }else if(v==3){
            mainPanel.loadClass('isprit/msg/msg_send.aspx','发送信息');
        }else if(v==4){
            mainPanel.loadClass('isprit/mail/mail_inbox.aspx','邮件收件箱');
        }else if(v==5){
            mainPanel.loadClass('isprit/mail/mail_outbox.aspx','邮件发件箱');
        }else if(v==6){
            mainPanel.loadClass('isprit/mail/mail_write.aspx','写邮件');
        }
    }
</script>
</head>
<body bgcolor="honeydew">
    <form id="form1" runat="server">
    <div>
    
				<br>
				<br>
				<h3 style="text-align:center">恭喜，发送成功！</h3>
				<p style="text-align:center;">

				<br>
				<a href="#" onclick="gotoUrl(0)" style="color:blue;">[ 关闭 ]</a><br>
				<br>
				<a href="#" onclick="gotoUrl(1)">查看收信箱</a><br>
				<br>
				<a href="#" onclick="gotoUrl(2)">查看发信箱</a><br>
				<br>
				<a href="#" onclick="gotoUrl(3)">发送信息</a><br>
				<br>
				<a href="#" onclick="gotoUrl(4)">邮件收件箱</a><br>
				<br>
				<a href="#" onclick="gotoUrl(5)">邮件发件箱</a><br>
				<br>
				<a href="#" onclick="gotoUrl(6)">写邮件</a><br>

		</P>
    </div>
    </form>
</body>
</html>

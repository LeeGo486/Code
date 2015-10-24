<%@ page language="C#" autoeventwireup="true" inherits="Usercontrol_web_djgridhelp, App_Web_web_djgridhelp.aspx.3f410aa0" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>帮助</title>
</head>
<body style="background-color: #9999ff">
    <form id="form1" runat="server">
    <div>
        &nbsp;</div>
    <div style="border-right: #990033 1px solid; border-top: #990033 1px solid; border-left: #990033 1px solid; border-bottom: #990033 1px solid; background-color: #ccccff">
        <br />
        &lt;打印&gt;<br />
        &nbsp; &nbsp; &nbsp; &nbsp; 打印当前单据。<br />
        &lt;保存退出&gt;<br />
        &nbsp; &nbsp; &nbsp; &nbsp; 保存当前单据的修改，然后退出当前页。<br />
        &lt;审核退出&gt;<br />
        &nbsp; &nbsp; &nbsp; &nbsp; 保存当前的修改，同时审核这张单据。<br />
        &lt;登帐退出&gt;<br />
        &nbsp; &nbsp; &nbsp;&nbsp; 保存当前的修改，同时审核、登帐这张单据。<br />
        &lt;删除退出&gt;<br />
        &nbsp; &nbsp; &nbsp;&nbsp; 删除当前单据，然后退出此页面。<br />
        &lt;关闭&gt;<br />
        &nbsp; &nbsp; &nbsp;&nbsp; 关闭当前单据页面，当前的修改将不被保存(已经修改或者的添加的款式例外)。<br />
        <br />
        &lt;注意&gt;<br />
        &nbsp; &nbsp; &nbsp;&nbsp; 对于已经录入新增加的款式或者修改、删除的款式，<br />
        &nbsp; &nbsp; &nbsp; &nbsp;那么已经生效。即：已经更改了数据库内容，所以点任何方式退出都无法回到原来的状态。<br />
        <br />
        &lt;建议&gt;<br />
        &nbsp; &nbsp; &nbsp;&nbsp; 如果你只是为了进来查看或者打印这张单据，请选择&lt;关闭&gt;。<br />
        &nbsp; &nbsp; &nbsp;&nbsp; 如果还迷惑，请选择&lt;保存退出&gt;。这样不会代来严重的后果。<br />
        <br />
    </div>
    </form>
</body>
</html>

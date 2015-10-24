<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_user_BP_Usermenu, App_Web_bp_usermenu.aspx.4969a439" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>menu</title>
    <link href="css/default.css" rel="stylesheet" type="text/css" />
    <link rel="StyleSheet" href="css/dtree.css" type="text/css" />
	<script type="text/javascript" src="js/dtree.js"></script>
<style>
@import url(css/main.css );
</style>
</head>
<body style="margin:2px;">
    <form id="form1" runat="server">
<div class="dtree">

<br />
	<script type="text/javascript">
		<!--

		d = new dTree('d');

		d.add(0,-1,'自助操作系统');
		d.add(1,0,'业务操作','','','img/empty2.gif', 'img/empty2.gif', 'img/empty2.gif');
		d.add(2,1,'目前求购信息','BP_UserMasterList.aspx','','main','img/empty2.gif', 'img/empty2.gif', 'img/empty2.gif');
		d.add(3,1,'已报价未提交','BP_UserMasterNoSumbit.aspx','','main','img/empty2.gif', 'img/empty2.gif', 'img/empty2.gif');
		d.add(4,1,'被打回的报价','BP_UserBackList.aspx','','main','img/empty2.gif', 'img/empty2.gif', 'img/empty2.gif');
		d.add(5,1,'采购方短信息','BP_UserMsgList.aspx','','main','img/empty2.gif', 'img/empty2.gif', 'img/empty2.gif');
		d.add(6,0,'单据查询','','','img/empty2.gif', 'img/empty2.gif', 'img/empty2.gif');
		d.add(7,6,'历史求购信息','BP_UserPublishHistory.aspx','','main','img/empty2.gif', 'img/empty2.gif', 'img/empty2.gif');
		d.add(8,6,'历史报价单据','BP_UserMasterHistory.aspx','','main','img/empty2.gif', 'img/empty2.gif', 'img/empty2.gif');
		d.add(9,6,'物进进度查询','BP_UserTrack.aspx','','main','img/empty2.gif', 'img/empty2.gif', 'img/empty2.gif');
		d.add(10,6,'待交货单据','BP_UserTrackAlart.aspx','','main','img/empty2.gif', 'img/empty2.gif', 'img/empty2.gif');
		d.add(11,0,'个人资料维护','','','img/empty2.gif', 'img/empty2.gif', 'img/empty2.gif');
		d.add(12,11,'联系资料修改','BP_UserEditContact.aspx','','main','img/empty2.gif', 'img/empty2.gif', 'img/empty2.gif');
		d.add(13,11,'登陆密码修改','BP_UserEditPwd.aspx','','main','img/empty2.gif', 'img/empty2.gif', 'img/empty2.gif');
		d.add(14,0,'系统信息','','','img/empty2.gif', 'img/empty2.gif', 'img/empty2.gif');
		d.add(15,14,'返回系统首面','BP_UserMain.aspx','','main','img/empty2.gif', 'img/empty2.gif', 'img/empty2.gif');
		d.add(16,14,'联系采购方','BP_UserContactUs.aspx','','main','img/empty2.gif', 'img/empty2.gif', 'img/empty2.gif');
		d.add(17,14,'退出系统','BP_UserExit.aspx','','main','img/empty2.gif', 'img/empty2.gif', 'img/empty2.gif');
		//d.add(9,0,'My Pictures','example01.html','Pictures I\'ve taken over the years','','','img/imgfolder.gif');
		//d.add(10,9,'The trip to Iceland','example01.html','Pictures of Gullfoss and Geysir');
		//d.add(11,9,'Mom\'s birthday','example01.html');
		//d.add(12,0,'Recycle Bin','example01.html','','','img/trash.gif');

		document.write(d);
        d.openAll();
		//-->
	</script>

</div>

   <!-- <div>
        &nbsp;&nbsp;&nbsp;
        <asp:Panel ID="Panel1" runat="server" Height="392px" Width="125px">
            <table style="width: 120px; height: 33px" cellpadding="4" cellspacing="10">
             
                <tr>
                    <td style="width: 100px; height: 20px;">
                        <a  ID="HyperLink2" runat="server" href="BP_UserMasterList.aspx"  Target="main">目前求购信息</a ></td>
                </tr>
                <tr>
                    <td style="width: 100px">
                        <a  ID="HyperLink1" runat="server" href="BP_UserPublishHistory.aspx" Target="main">历史求购信息</a ></td>
                </tr>
                <tr>
                    <td style="width: 100px">
                        <a  ID="HyperLink4" runat="server" href="BP_UserMasterNoSumbit.aspx" Target="main">已报价未提交 </a ></td>
                </tr>
                <tr>
                    <td style="width: 100px">
                        <a  ID="A2" runat="server" href="BP_UserBackList.aspx" Target="main">被打回的报价 </a ></td>
                </tr>
                <tr>
                    <td style="width: 100px">
                        <a  ID="HyperLink3" runat="server" href="BP_UserMasterHistory.aspx" Target="main">历史报价单据</a ></td>
                </tr>
                
               
                  <tr>
                    <td style="width: 100px">
                        <a  ID="A1" runat="server" href="BP_UserMsgList.aspx" Target="main">采购方短信息</a ></td>
                </tr>
                  <tr>
                    <td style="width: 100px">
                        <a  ID="HyperLink9" runat="server" href="BP_UserEditPwd.aspx" Target="main">登陆密码修改</a ></td>
                </tr>
                  <tr>
                    <td style="width: 100px">
                        <a  ID="HyperLink10" runat="server" href="BP_UserEditContact.aspx" Target="main">联系资料修改</a ></td>
                </tr>
                 <tr>
                    <td style="width: 100px">
                        <a  ID="A4" runat="server" href="BP_UserContactUs.aspx" Target="main">联系我们</a ></td>
                </tr>
                  <tr>
                    <td style="width: 100px">
                     <a  ID="A3" runat="server" href="BP_UserMain.aspx" Target="main">返回首页</a >
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px">
                     <a  ID="HyperLink6" runat="server" href="BP_UserExit.aspx" Target="main">退出系统</a >
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px">
                    </td>
                </tr>
            </table>
        </asp:Panel>
        &nbsp;&nbsp;&nbsp;&nbsp;
    </div>
    -->
    </form>
</body>
</html>

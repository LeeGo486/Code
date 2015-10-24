<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_user_BP_UserMain, App_Web_bp_usermain.aspx.4969a439" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>欢迎页面</title>
   <link  href="css/main.css" type="text/css"  rel="stylesheet">
<style>

#RightNews, #RightActive, #RightBrands{margin:0;}
#RightNews dt, #RightActive dt ,#RightBrands dt{background:#00a99d;font-weight:bold; color:white; line-height:22px; text-indent:10px;margin:5px 0;}
#RightNews .ddMore, #RightActive .ddMore{ text-align:right; margin:0;height:20px;}
#RightNews a:hover, #RightActive a:hover{ background:#DFDFDF;}
#RightNews dd{line-height:20px;height:20px;margin:0 10px;width:170px;}
#RightActive dd{line-height:18px;height:36px;margin:0 10px;width:170px;overflow:hidden;}
#RightActive .ActivePrice{ height:18px;}
#RightBrands dd{margin:0;}
</style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
<table width="100%" border="0" cellspacing="10" cellpadding="0">
  <tr>
    <td height="30" align="center"><img src="images/icon-vip.gif" width="16" align="top" height="16" /> <strong class="FS_L FC_Cya">欢迎您 <span class="FC_Blk"><asp:Label ID="LblUserNo" runat="server" Text=""></asp:Label></span>，您有
    <a href="BP_UserMsgList.aspx"><span class="FC_Red"><asp:Label
            ID="LblNewMsg" runat="server" Text=""></asp:Label></span></a>条新的留言 </strong>[<a href="BP_UserMsgList.aspx" class="FC_Red">查看留言</a>]</td>
  </tr>
</table>
<table cellSpacing="1" cellPadding="0" width="100%" align="center" bgColor="#c2e5ff" border="0">
							<tr>
								<td background="images/welcome_33.jpg" bgColor="#fafcfe" height="26">
									<table cellSpacing="0" cellPadding="0" width="100%" border="0">
										<tr>
											<td width="92%"><span class="unnamed1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>你的信息</strong></span></td>
											<td width="8%"></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td class="font" bgColor="#ffffff">
								<table cellSpacing="1" cellPadding="0" width="98%" align="center" border="0">
							<tr>
								<td  bgColor="#fafcfe" height="26">
                                    <table width="100%" border="0" cellspacing="12" cellpadding="0">
                                      <tr>
                                        
                                        <td>
                                                        <table width="100%" border="0" cellspacing="0" cellpadding="5">
                                                          <tr>
                                                            <td>会员级别：<a href="#" class="FC_Red"><asp:Label ID="LblLevel" runat="server" Text=""></asp:Label></a></td>
                                                          </tr>
                                                          <tr>
                                                            <td>
                                                                公司名称：<strong class="FC_Org" title=""><asp:Label ID="LblCompanyName" runat="server" Text=""></asp:Label></strong>
                                                                </td>
                                                          </tr>
                                                          <tr>
                                                            <td>
                                                                绑定邮箱：<strong title=""><asp:Label ID="LblEmail" runat="server" Text=""></asp:Label></strong> </td>
                                                          </tr>
                                                          <tr>
                                                            <td>
                                                                默认发货地址：<strong title=""><asp:Label ID="LblSendAddre" runat="server" Text=""></asp:Label></strong> </td>
                                                          </tr>
                                                        </table>
                                        </td>
                                      </tr>
                                    </table>
								</td>
							</tr>
						</table>
						</td>
						</tr>
						</table>
						<table cellSpacing="0" cellPadding="0" width="98%" align="center" border="0">
							<tr>
								<td height="4px"></td>
							</tr>
						</table>
						
<!--------------------------------------->	

<table cellSpacing="1" cellPadding="0" width="100%" align="center" bgColor="#c2e5ff" border="0">
							<tr>
								<td background="images/welcome_34.jpg" bgColor="#fafcfe" height="26">
									<table cellSpacing="0" cellPadding="0" width="100%" border="0">
										<tr>
											<td width="92%"><span class="unnamed1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;公告信息</span></td>
											<td width="8%">
                                                <a href="BP_UserPubinfoList.aspx"><asp:Image ID="Image1" runat="server" ImageUrl="~/buyproductuser/images/more01.gif"  BorderWidth="0" /></a></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
							<td valign="top" bgColor="#ffffff">
							
					
 <table width="100%" border="0" cellspacing="0" cellpadding="0"   bordercolor="#ffffff"   height="100px">
 <tr>
 <td height="3px"></td>
 </tr>
<tr>

<td valign="top"  >
<table  cellspacing="13" cellpadding="0" width="90%">
<tr>
<td>

<div class="FrameContent">
<ul class="Normalul">
  <asp:Repeater ID="RepeaterNew" runat="server" >
	<ItemTemplate>
		<li><a href="BP_UserPubDetail.aspx?sid=<%# Eval("PubNewListID")%>" target="_blank"><%# Eval("PubNewTitle")%></a></li>
	</ItemTemplate>
   </asp:Repeater>
</ul> 
</div>

 </td>
</tr>
</table>   

</td>
</tr>
</table>
	</td>
</tr>
							
						
</table>
	<table cellSpacing="0" cellPadding="0" width="98%" align="center" border="0">
							<tr>
								<td height="4px"></td>
							</tr>
						</table>
<!--------------------------------------->					
						

<table cellSpacing="1" cellPadding="0" width="100%" align="center" bgColor="#c2e5ff" border="0">
							<tr>
								<td background="images/welcome_34.jpg" bgColor="#fafcfe" height="26">
									<table cellSpacing="0" cellPadding="0" width="100%" border="0">
										<tr>
											<td width="92%"><span class="unnamed1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>提醒信息</strong></span></td>
											<td width="8%"></td>
										</tr>
									</table>
								</td>
							</tr>
						
						</table>
						<table cellSpacing="0" cellPadding="0" width="98%" align="center" border="0">
							<tr>
								<td height="10px"></td>
							</tr>
						</table>
					
 <table width="100%" border="0" cellspacing="0" cellpadding="0"  bordercolor="#ffffff"  >
   <colgroup>
   <col width="150px" />
   <col />
   <col width="150px" />
   <col />
   </colgroup>
  <tr>
    <td align="center" style="height: 31px">
    <strong class="FS_L FC_Org LH_XXL VIP_TIPS">未提交的报价:</strong>
     </td><td align="left">
     <asp:Label ID="LblNoUpNum" runat="server" Text=""></asp:Label>条
     [<a href="BP_UserMasterNoSumbit.aspx" >查看</a>]
        &nbsp;
</td>
  <td align="center" style="height: 31px">
    <strong class="FS_L FC_Org LH_XXL VIP_TIPS">待报价的物料:</strong>
    </td>
  <td align="left"><asp:Label ID="LblBuyNum" runat="server" Text=""></asp:Label>条
  [<a href="BP_UserMasterList.aspx" >查看</a>]
  </td>
  </tr>
 
  <tr>
  <td align="center" style="height: 31px">
    <strong class="FS_L FC_Org LH_XXL VIP_TIPS">被打回的报价:</strong>
    </td>
  <td align="left"><asp:Label ID="LblBackNum" runat="server" Text=""></asp:Label>条
  [<a href="BP_UserBackList.aspx" >查看</a>]
  </td>
    <td align="center" style="height: 31px">
    <strong class="FS_L FC_Org LH_XXL VIP_TIPS">近期待交货单:</strong>
    </td>
  <td align="left"><asp:Label ID="LblSupNum" runat="server" Text=""></asp:Label>单
  [<a href="BP_UserTrackAlart.aspx" >查看</a>]
  </td>
  </tr>
   
</table>

    </div>

   

     
    </form>
</body>
</html>